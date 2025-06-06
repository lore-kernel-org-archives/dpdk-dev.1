Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A2C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A5C40E2B;
	Fri,  6 Jun 2025 19:10:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C4A1240E2B
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229800; x=1780765800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xsdnvrkhwmytsn6ib4qg+t8NA1G31PD+ufokwhylldQ=;
 b=JSsEedUeQoZr+nBblD3Wc3hEZ0MEzyQlPmztRVzwAb94+q8SpYve34jU
 kopAxobnp7P+ezW7kg/l+BKOcggl77B8EJgmZnTWwcYdc3fQa1ayvrdkW
 ooZxnsgWNntRwOO9ybnD60a7LbRTnEBlfKFEW6wl+Xaf4HXZ25yBItJEb
 sybVBCb14oa6tiqKXj9qUEbHFijT6ZAELsVtYL/+7F59a2nG9HK7Dk1ux
 QIZaPjrsKYpu40PGyDs8duRCBeQGeS9oekZiKUrtuw3elqbPwwTd2ehfm
 lQmTQPoC4ZEWUSWajhwgnOlX+hggO4usWstyzxAeOMUO1AD7YpXqWpPJP A==;
X-CSE-ConnectionGUID: T9BCpoTmT3iGLBpcXVxceg==
X-CSE-MsgGUID: ieFFChQ4R3G9beM76BgCMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828447"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828447"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:59 -0700
X-CSE-ConnectionGUID: cUXJttioQZm5VBU9CP5q0g==
X-CSE-MsgGUID: BkSDftNDTxKLQeKz3OWwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808219"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 19/34] net/ixgbe: add a desc done function
Date: Fri,  6 Jun 2025 18:08:58 +0100
Message-ID: <75f2d5852f52e7b81b0036cb921e661edca8569b.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
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
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c            |  8 ++------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c |  4 +---
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h | 12 +++++++++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 5f0aedb4cd..50060ce64e 100644
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
index 4678a5dfd9..56e13b4125 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -25,19 +25,25 @@ void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
 uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
 
+static inline int
+ixgbe_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+	const uint32_t status = txq->ixgbe_tx_ring[idx].wb.status;
+
+	return !!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD));
+}
+
 static __rte_always_inline int
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

