Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E57EDEBF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 20:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD02441132;
	Tue,  3 Mar 2026 21:54:24 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0CA6340655;
 Tue,  3 Mar 2026 21:54:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 7E33420B6F02; Tue,  3 Mar 2026 12:54:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E33420B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v4 3/6] net/netvsc: fix resource leak in init error path
Date: Tue,  3 Mar 2026 12:54:06 -0800
Message-ID: <20260303205411.325585-4-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260303205411.325585-1-longli@microsoft.com>
References: <20260303205411.325585-1-longli@microsoft.com>
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

The failed label in eth_hn_dev_init() does not free hv->primary or close
hv->channels[0], leaking both resources on any init failure after they
are allocated.

Additionally, the early return when hv->primary allocation fails leaks
hv->channels[0]. Change it to goto failed.

Add rte_free(hv->primary) and rte_vmbus_chan_close(hv->channels[0]) to
the failed label to properly clean up on all error paths.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 9f61f3a1a5..19721b4829 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1376,8 +1376,10 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 	hv->primary = hn_rx_queue_alloc(hv, 0,
 					eth_dev->device->numa_node);
 
-	if (!hv->primary)
-		return -ENOMEM;
+	if (!hv->primary) {
+		err = -ENOMEM;
+		goto failed;
+	}
 
 	err = hn_attach(hv, RTE_ETHER_MTU);
 	if  (err)
@@ -1403,8 +1405,10 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 
 	max_chan = rte_vmbus_max_channels(vmbus);
 	PMD_INIT_LOG(DEBUG, "VMBus max channels %d", max_chan);
-	if (max_chan <= 0)
+	if (max_chan <= 0) {
+		err = max_chan ? max_chan : -ENODEV;
 		goto failed;
+	}
 
 	if (hn_rndis_query_rsscaps(hv, &rxr_cnt) != 0)
 		rxr_cnt = 1;
@@ -1425,6 +1429,8 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 
 	hn_chim_uninit(eth_dev);
 	hn_detach(hv);
+	rte_free(hv->primary);
+	rte_vmbus_chan_close(hv->channels[0]);
 	return err;
 }
 
-- 
2.43.0

