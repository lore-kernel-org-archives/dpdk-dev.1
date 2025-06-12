Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8921DC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BDDE427A1;
	Thu, 12 Jun 2025 13:12:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 02AEF42790
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726745; x=1781262745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YJ749Jfl929FQ2wWL8GwPFN2OHC+lH5G6OyfYtGTSaw=;
 b=kHDOFPJ5yfresWVgFwYf9HhtqOVkX1J5bA7pPhor2aq7F95xjNtHMlCx
 gDN3Yi4GtPsFPS2M/Ih8oqQv0ExZGST8nX6qekpYjfaBqdPm/4JOOutqT
 Ra9GhkfBRWYJGDwjUb+nusxsNVE4zpAUfBfrmcNnGuL6I7CgZhCnmFk0F
 MKky2QRo8yEHQ6oP7/zvfui7UXlN5AFIvTd2c3S/QZ8TcH+62rail+y0k
 I2o+tHzkMWcfVGlPs0aXXjjh/lGCuUaFsTE3mPJ/siAc2eKf0sOvRw0/4
 l5QCWxYn8zYi+KaAjZeo4eOIe5DEAnwN6tNiB+H7KSPMSIc5u6S6SLuCS A==;
X-CSE-ConnectionGUID: k0vJlriDTzWOjkJF6QKWJQ==
X-CSE-MsgGUID: WZE/rwe/S6qFXFHryZFh+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177573"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177573"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:24 -0700
X-CSE-ConnectionGUID: jaITpZFxRBecZJEKMSMukA==
X-CSE-MsgGUID: 6rSSjRcIQIu7Yniyi/HUmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371360"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 18/33] net/ixgbe: add a desc done function
Date: Thu, 12 Jun 2025 12:11:24 +0100
Message-ID: <732c030dfd90c360c425c6bf3252fffd035ce85e.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
References: 
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

Add a function to check DD bit status, and use it everywhere we do these
checks.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v6:
    - Move ixgbe_tx_desc_done() to ixgbe_rxtx.h to avoid compile errors on
      platforms that do not support vector driver
    
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |  8 ++-----
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 21 +++++++++++++++++++
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |  4 +---
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |  4 +---
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index cdf0d33955..f32c2be988 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -118,13 +118,11 @@ static __rte_always_inline int
 ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *txep;
-	uint32_t status;
 	int i, nb_free = 0;
 	struct rte_mbuf *m, *free[RTE_IXGBE_TX_MAX_FREE_BUF_SZ];
 
 	/* check DD bit on threshold descriptor */
-	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
-	if (!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD)))
+	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
 		return 0;
 
 	/*
@@ -3412,7 +3410,6 @@ int
 ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	volatile uint32_t *status;
 	uint32_t desc;
 
 	if (unlikely(offset >= txq->nb_tx_desc))
@@ -3428,8 +3425,7 @@ ixgbe_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
 			desc -= txq->nb_tx_desc;
 	}
 
-	status = &txq->ixgbe_tx_ring[desc].wb.status;
-	if (*status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD))
+	if (ixgbe_tx_desc_done(txq, desc))
 		return RTE_ETH_TX_DESC_DONE;
 
 	return RTE_ETH_TX_DESC_FULL;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 6fcc5ee1e6..4887a81c4a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -5,6 +5,8 @@
 #ifndef _IXGBE_RXTX_H_
 #define _IXGBE_RXTX_H_
 
+#include "ixgbe_type.h"
+
 #include "../common/tx.h"
 
 /*
@@ -241,4 +243,23 @@ uint64_t ixgbe_get_rx_port_offloads(struct rte_eth_dev *dev);
 uint64_t ixgbe_get_tx_queue_offloads(struct rte_eth_dev *dev);
 int ixgbe_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 
+/**
+ * Check if the Tx descriptor DD bit is set.
+ *
+ * @param txq
+ *   Pointer to the Tx queue structure.
+ * @param idx
+ *   Index of the Tx descriptor to check.
+ *
+ * @return
+ *   1 if the Tx descriptor is done, 0 otherwise.
+ */
+static inline int
+ixgbe_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+	const uint32_t status = txq->ixgbe_tx_ring[idx].wb.status;
+
+	return !!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD));
+}
+
 #endif /* _IXGBE_RXTX_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index cf6d3e4914..707dc7f5f9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -215,7 +215,6 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	struct ci_tx_entry *txep;
 	struct rte_mbuf **rxep;
 	int i, n;
-	uint32_t status;
 	uint16_t nb_recycle_mbufs;
 	uint16_t avail = 0;
 	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
@@ -232,8 +231,7 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		return 0;
 
 	/* check DD bits on threshold descriptor */
-	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
-	if (!(status & IXGBE_ADVTXD_STAT_DD))
+	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
 		return 0;
 
 	n = txq->tx_rs_thresh;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 4678a5dfd9..e5b16af694 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -29,15 +29,13 @@ static __rte_always_inline int
 ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry_vec *txep;
-	uint32_t status;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
 	struct rte_mbuf *m, *free[RTE_IXGBE_TX_MAX_FREE_BUF_SZ];
 
 	/* check DD bit on threshold descriptor */
-	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
-	if (!(status & IXGBE_ADVTXD_STAT_DD))
+	if (!ixgbe_tx_desc_done(txq, txq->tx_next_dd))
 		return 0;
 
 	n = txq->tx_rs_thresh;
-- 
2.47.1

