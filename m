Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA596EB365B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 02:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4BC540F16;
	Tue,  3 Mar 2026 03:54:18 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7C94F40E37;
 Tue,  3 Mar 2026 03:54:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id EB77E20B6F03; Mon,  2 Mar 2026 18:54:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB77E20B6F03
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v3 4/6] net/netvsc: fix event callback leak on rxfilter failure
Date: Mon,  2 Mar 2026 18:53:59 -0800
Message-ID: <20260303025403.269182-5-longli@microsoft.com>
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

In hn_dev_start(), if hn_rndis_set_rxfilter() fails after registering
the device event callback, the function returns without unregistering
the callback. Unregister it before returning on error.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v3: New patch.
---
 drivers/net/netvsc/hn_ethdev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 19721b4829..5e954b8812 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1043,16 +1043,22 @@ hn_dev_start(struct rte_eth_dev *dev)
 				      NDIS_PACKET_TYPE_BROADCAST |
 				      NDIS_PACKET_TYPE_ALL_MULTICAST |
 				      NDIS_PACKET_TYPE_DIRECTED);
-	if (error)
+	if (error) {
+		rte_dev_event_callback_unregister(NULL,
+						  netvsc_hotadd_callback, hv);
 		return error;
+	}
 
 	error = hn_vf_start(dev);
-	if (error)
+	if (error) {
 		hn_rndis_set_rxfilter(hv, 0);
+		rte_dev_event_callback_unregister(NULL,
+						  netvsc_hotadd_callback, hv);
+		return error;
+	}
 
 	/* Initialize Link state */
-	if (error == 0)
-		hn_dev_link_update(dev, 0);
+	hn_dev_link_update(dev, 0);
 
 	for (i = 0; i < hv->num_queues; i++) {
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
-- 
2.43.0

