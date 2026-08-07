Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DAC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:27:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FBB640DD8;
	Fri,  7 Aug 2026 13:26:36 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5D12E406BA
 for <dev@dpdk.org>; Fri,  7 Aug 2026 13:26:29 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 41AEA1A0116;
 Fri,  7 Aug 2026 13:26:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 087EF1A00FC;
 Fri,  7 Aug 2026 13:26:29 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 861D218000B0;
 Fri,  7 Aug 2026 19:26:28 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 07/14] net/enetc: support ethtool ring parameters
Date: Fri,  7 Aug 2026 16:56:16 +0530
Message-Id: <20260807112623.1402493-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807112623.1402493-1-g.singh@nxp.com>
References: <20260807070241.1151161-1-g.singh@nxp.com>
 <20260807112623.1402493-1-g.singh@nxp.com>
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
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 drivers/net/enetc/enetc.h              | 4 ++++
 drivers/net/enetc/enetc4_ethdev.c      | 4 ++--
 drivers/net/enetc/enetc4_vf.c          | 4 ++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index deb3bc5d52..9e333edf4f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -66,6 +66,7 @@ New Features
   * Extended the PF-to-VF link speed code field from 4-bit to 8-bit in ENETC4.
   * Added firmware version reporting for the ENETC4 VF.
   * Added register dump support for ENETC4 PF and VF.
+  * Added ring parameters support for the ENETC4 VF (rxq_info_get / txq_info_get).
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 73404308fe..367d350dde 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -339,6 +339,10 @@ int enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
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
index 681bac3ecc..afee0b90a3 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -1125,7 +1125,7 @@ enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
 	return 0;
 }
 
-static void
+void
 enetc4_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			struct rte_eth_rxq_info *qinfo)
 {
@@ -1139,7 +1139,7 @@ enetc4_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	qinfo->conf.rx_drop_en = 0;
 }
 
-static void
+void
 enetc4_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			struct rte_eth_txq_info *qinfo)
 {
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 77bec0425a..90b7b99e9a 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1508,10 +1508,12 @@ static const struct eth_dev_ops enetc4_vf_ops_no_vsi_m = {
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
 
@@ -1537,10 +1539,12 @@ static const struct eth_dev_ops enetc4_vf_ops = {
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

