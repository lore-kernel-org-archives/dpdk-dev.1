Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00944C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:58:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A50740667;
	Fri, 30 May 2025 15:57:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D7BAE4042C
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613464; x=1780149464;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=syyydYjIrIesALno7bCDThsh2jBZAlXgMD0zKm39RHc=;
 b=i6ZyzMOKSm2ga00YehmCS/9LlwQgomfmbbUoAIbZJZwb1N9y5oUPPSPm
 nCOxtTsc5ME8K0sFblanPOfeUwU3JHkXxbNTPl+Nic1iokU4Q/sUPRKtO
 4gurEqLG/ybAa2KcywWgQ5QW7bMoyxsGGwh9hGKB3KBNqLVlaiEE+DH6x
 upUiUVECKw+mdw+nTYPsKf6O5y5/60ai5OiALDORzmJPxIBPiDmdfBqeK
 E2Eg7breI8J8m9Vx7TZFUhHJv7qbDJyljIT0vr3UVtTe8H9q5uQnBZ+vL
 W9Jae7++iYrEDxurBDq1t1RoUvGN2HT2lhnzhNS2TS1UoFy4nTNsJAGE9 w==;
X-CSE-ConnectionGUID: ZS2TplKGR9quTosUs9I15w==
X-CSE-MsgGUID: hOuAMv7nSCWNIumSiIfUQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809370"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:43 -0700
X-CSE-ConnectionGUID: PaWGYmh9Q9GdkD0+kuts9Q==
X-CSE-MsgGUID: iur4l6STQzCo0veAOVTpaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887387"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 05/25] net/ice: match variable name to other drivers
Date: Fri, 30 May 2025 14:57:01 +0100
Message-ID: <730db61d118c257b4862a2bb64137c743549559b.1748612803.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
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

Currently, the ice driver has a variable that have the same semantics as
in other drivers, but has a different name. Rename `rx_ring_dma` to
`rx_ring_phys_addr` for consistency with other drivers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Make this commit separate

 drivers/net/intel/ice/ice_dcf.c  | 2 +-
 drivers/net/intel/ice/ice_rxtx.c | 8 ++++----
 drivers/net/intel/ice/ice_rxtx.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 65c18921f4..fa95aaaba6 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1211,7 +1211,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 
 		vc_qp->rxq.max_pkt_size = rxq[i]->max_pkt_len;
 		vc_qp->rxq.ring_len = rxq[i]->nb_rx_desc;
-		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_dma;
+		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_phys_addr;
 		vc_qp->rxq.databuffer_size = rxq[i]->rx_buf_len;
 
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index ba1435b9de..81962a1f9a 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -370,7 +370,7 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
 		rx_ctx.dtype = 0; /* No Protocol Based Buffer Split mode */
 	}
 
-	rx_ctx.base = rxq->rx_ring_dma / ICE_QUEUE_BASE_ADDR_UNIT;
+	rx_ctx.base = rxq->rx_ring_phys_addr / ICE_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->nb_rx_desc;
 	rx_ctx.dbuf = rxq->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
 	rx_ctx.hbuf = rxq->rx_hdr_len >> ICE_RLAN_CTX_HBUF_S;
@@ -847,7 +847,7 @@ ice_fdir_program_hw_rx_queue(struct ice_rx_queue *rxq)
 
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
 
-	rx_ctx.base = rxq->rx_ring_dma / ICE_QUEUE_BASE_ADDR_UNIT;
+	rx_ctx.base = rxq->rx_ring_phys_addr / ICE_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->nb_rx_desc;
 	rx_ctx.dbuf = rxq->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
 	rx_ctx.hbuf = rxq->rx_hdr_len >> ICE_RLAN_CTX_HBUF_S;
@@ -1273,7 +1273,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Zero all the descriptors in the ring. */
 	memset(rz->addr, 0, ring_size);
 
-	rxq->rx_ring_dma = rz->iova;
+	rxq->rx_ring_phys_addr = rz->iova;
 	rxq->rx_ring = rz->addr;
 
 	/* always reserve more for bulk alloc */
@@ -2500,7 +2500,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 	rxq->reg_idx = pf->fdir.fdir_vsi->base_queue;
 	rxq->vsi = pf->fdir.fdir_vsi;
 
-	rxq->rx_ring_dma = rz->iova;
+	rxq->rx_ring_phys_addr = rz->iova;
 	memset(rz->addr, 0, ICE_FDIR_NUM_RX_DESC *
 	       sizeof(union ice_32byte_rx_desc));
 	rxq->rx_ring = (union ice_rx_flex_desc *)rz->addr;
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 500d630679..3c5c014b41 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -93,7 +93,7 @@ enum ice_rx_dtype {
 struct ice_rx_queue {
 	struct rte_mempool *mp; /* mbuf pool to populate RX ring */
 	volatile union ice_rx_flex_desc *rx_ring;/* RX ring virtual address */
-	rte_iova_t rx_ring_dma; /* RX ring DMA address */
+	rte_iova_t rx_ring_phys_addr; /* RX ring DMA address */
 	struct ice_rx_entry *sw_ring; /* address of RX soft ring */
 	uint16_t nb_rx_desc; /* number of RX descriptors */
 	uint16_t rx_free_thresh; /* max free RX desc to hold */
-- 
2.47.1

