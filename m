Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CBEB365A
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 02:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF98740EE7;
	Tue,  3 Mar 2026 03:54:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 228FA40EAB;
 Tue,  3 Mar 2026 03:54:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 9236F20B6F04; Mon,  2 Mar 2026 18:54:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9236F20B6F04
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v3 5/6] net/netvsc: fix resource leaks in MTU change path
Date: Mon,  2 Mar 2026 18:54:00 -0800
Message-ID: <20260303025403.269182-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260303025403.269182-1-longli@microsoft.com>
References: <20260303025403.269182-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

hn_dev_mtu_set() has several resource management bugs:

1. Calls rte_free(hv->channels[0]) without rte_vmbus_chan_close()
   first, skipping the VMBus close protocol.

2. Does not free hv->primary->rxbuf_info before hn_detach(), causing
   hn_nvs_conn_rxbuf() in hn_reinit() to leak the old allocation.

3. Does not call hn_chim_uninit()/hn_chim_init() around the
   detach/reinit sequence, leaving a stale chimney bitmap that may
   not match the new chim_cnt.

Fix all three issues.

Fixes: 45c83603087e ("net/netvsc: support MTU set")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v3: New patch (split from reconfig patch).
---
 drivers/net/netvsc/hn_ethdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 5e954b8812..45d69272aa 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1214,6 +1214,11 @@ hn_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	if (ret)
 		return ret;
 
+	/* Free chimney bitmap and rxbuf_info before NVS detach */
+	hn_chim_uninit(dev);
+	rte_free(hv->primary->rxbuf_info);
+	hv->primary->rxbuf_info = NULL;
+
 	/* Release channel resources */
 	hn_detach(hv);
 
@@ -1222,6 +1227,7 @@ hn_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		rte_vmbus_chan_close(hv->channels[i]);
 
 	/* Close primary vmbus channel */
+	rte_vmbus_chan_close(hv->channels[0]);
 	rte_free(hv->channels[0]);
 
 	/* Unmap and re-map vmbus device */
@@ -1248,13 +1254,17 @@ hn_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	rte_vmbus_set_latency(hv->vmbus, hv->channels[0], hv->latency);
 
 	ret = hn_reinit(dev, mtu);
-	if (!ret)
+	if (!ret) {
+		hn_chim_init(dev);
 		goto out;
+	}
 
 	/* In case of error, attempt to restore original MTU */
 	ret = hn_reinit(dev, orig_mtu);
 	if (ret)
 		PMD_DRV_LOG(ERR, "Restoring original MTU failed for netvsc");
+	else
+		hn_chim_init(dev);
 
 	ret = hn_vf_mtu_set(dev, orig_mtu);
 	if (ret)
-- 
2.43.0

