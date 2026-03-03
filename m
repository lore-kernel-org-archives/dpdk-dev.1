Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD5EDEBF1
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 20:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D83940659;
	Tue,  3 Mar 2026 21:54:22 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7063F4064A;
 Tue,  3 Mar 2026 21:54:20 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id DD92B20B6F02; Tue,  3 Mar 2026 12:54:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD92B20B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v4 1/6] net/netvsc: fix subchannel leak on device removal
Date: Tue,  3 Mar 2026 12:54:04 -0800
Message-ID: <20260303205411.325585-2-longli@microsoft.com>
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

eth_hn_dev_uninit() only closes the primary channel but never
closes subchannels allocated during hn_dev_configure(). This
leaks VMBus subchannel resources on device removal.

Close all subchannels before closing the primary channel to
prevent resource leaks.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 6584819f4f..798b4c9023 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1433,6 +1433,7 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct hn_data *hv = eth_dev->data->dev_private;
 	int ret, ret_stop;
+	int i;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1444,6 +1445,15 @@ eth_hn_dev_uninit(struct rte_eth_dev *eth_dev)
 
 	hn_detach(hv);
 	hn_chim_uninit(eth_dev);
+
+	/* Close any subchannels before closing the primary channel */
+	for (i = 1; i < HN_MAX_CHANNELS; i++) {
+		if (hv->channels[i] != NULL) {
+			rte_vmbus_chan_close(hv->channels[i]);
+			hv->channels[i] = NULL;
+		}
+	}
+
 	rte_vmbus_chan_close(hv->channels[0]);
 	rte_free(hv->primary);
 	ret = rte_eth_dev_owner_delete(hv->owner.id);
-- 
2.43.0

