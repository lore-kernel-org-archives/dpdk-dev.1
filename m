Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26894C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07DD740E1C;
	Tue,  8 Sep 2026 07:47:52 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id BEC154026E
 for <dev@dpdk.org>; Tue,  8 Sep 2026 07:47:43 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FF84200129;
 Tue,  8 Sep 2026 07:47:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A2F320011E;
 Tue,  8 Sep 2026 07:47:43 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E702B1800068;
 Tue,  8 Sep 2026 13:47:42 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v13 08/15] net/enetc: support ethtool ring parameters
Date: Tue,  8 Sep 2026 11:17:29 +0530
Message-Id: <20260908054736.842738-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908054736.842738-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260908054736.842738-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

The ethtool ring parameter query relies on the queue info ethdev
ops (.rxq_info_get/.txq_info_get) together with the descriptor
limits reported in dev_info. The PF already registered these ops,
but the VF ops tables did not, so ring parameter queries failed on
the VF.

Make enetc4_rxq_info_get() and enetc4_txq_info_get() non-static and
register them in both VF ops tables so ring parameters are reported
for both the PF and VF.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/enetc.h              |  4 ++++
 drivers/net/enetc/enetc4_ethdev.c      | 10 ++++++----
 drivers/net/enetc/enetc4_vf.c          |  4 ++++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6fece98f28..ec223a93ba 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,7 @@ New Features
     as a device argument, otherwise link speed reporting will be incorrect.
   * Added firmware version reporting for the ENETC4 VF.
   * Added register dump support for ENETC4 PF and VF.
+  * Added ring parameters support for the ENETC4 VF (rxq_info_get / txq_info_get).
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 02b935ad8e..eec0edc963 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -336,6 +336,10 @@ int enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
 void enetc4_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 const uint32_t *enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 			size_t *no_of_elements);
+void enetc4_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			 struct rte_eth_rxq_info *qinfo);
+void enetc4_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			 struct rte_eth_txq_info *qinfo);
 
 /*
  * enetc4_vf function prototype
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 919400b170..790fa910d5 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -1165,7 +1165,7 @@ enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
 	return 0;
 }
 
-static void
+void
 enetc4_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			struct rte_eth_rxq_info *qinfo)
 {
@@ -1173,19 +1173,21 @@ enetc4_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	qinfo->mp = rxq->mb_pool;
 	qinfo->scattered_rx = dev->data->scattered_rx;
-	qinfo->nb_desc = rxq->bd_count;
+	/* RSC rings use 2 slots per descriptor; report the requested count. */
+	qinfo->nb_desc = rxq->rsc_enable ? rxq->bd_count / 2 : rxq->bd_count;
 	qinfo->conf.rx_free_thresh = 0;
 	qinfo->conf.rx_deferred_start = rxq->rx_deferred_start;
 	qinfo->conf.rx_drop_en = 0;
 }
 
-static void
+void
 enetc4_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			struct rte_eth_txq_info *qinfo)
 {
 	struct enetc_bdr *txq = dev->data->tx_queues[queue_id];
 
-	qinfo->nb_desc = txq->bd_count;
+	/* LSO rings use 2 slots per descriptor; report the requested count. */
+	qinfo->nb_desc = txq->lso_enable ? txq->bd_count / 2 : txq->bd_count;
 	qinfo->conf.tx_thresh.pthresh = 0;
 	qinfo->conf.tx_thresh.hthresh = 0;
 	qinfo->conf.tx_thresh.wthresh = 0;
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index ec9a2e2bf8..3da84941a2 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1539,10 +1539,12 @@ static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
 	.rx_queue_release     = enetc4_rx_queue_release,
+	.rxq_info_get         = enetc4_rxq_info_get,
 	.tx_queue_setup       = enetc4_tx_queue_setup,
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.txq_info_get         = enetc4_txq_info_get,
 	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
@@ -1569,10 +1571,12 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
 	.rx_queue_release     = enetc4_rx_queue_release,
+	.rxq_info_get         = enetc4_rxq_info_get,
 	.tx_queue_setup       = enetc4_tx_queue_setup,
 	.tx_queue_start       = enetc4_tx_queue_start,
 	.tx_queue_stop        = enetc4_tx_queue_stop,
 	.tx_queue_release     = enetc4_tx_queue_release,
+	.txq_info_get         = enetc4_txq_info_get,
 	.dev_supported_ptypes_get = enetc4_supported_ptypes_get,
 };
 
-- 
2.25.1

