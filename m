Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E075C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6774042E;
	Fri, 30 May 2025 15:57:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1CE1D400D7
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613456; x=1780149456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IH5CQ/vLks2nbEU0CWXxWuRX2a66YX60lBNVt9cOXNU=;
 b=UrEJDPdFBm2Nn+M6kERRRIUPsM0umgub32sebJvJPJPEvGAf5fDrcFgY
 v4BOoJcpfjNf/MSIARTufcIv4dSNncPv3KmoV193NPN6XfJ+JPcyLa6qI
 R/9ig85dg+QprLkOCgQpItCvoB5sHRrAdbTWLBpiC0JiZqsjkRNBPiPRb
 OplA3jLM2gXj5xjXyp+cLp0qzUb3yZizmToD5P1A7sMuC2kiaxl7aD2+x
 uYDT1tUXx6YotrwyltsmvTpZC5p6eyGWFWn+6ldbCQFAsBlNnH/Ty1/8w
 rTFHFFORZ1hyOLvNuIjlHmksJlUlQBrfS0XiwnbtH598FWUj4BdnGprWR Q==;
X-CSE-ConnectionGUID: LjT3VvXoTUSP+R4m1hDYAg==
X-CSE-MsgGUID: +gjS48NcQFKx9yCd+wv+Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809364"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809364"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:36 -0700
X-CSE-ConnectionGUID: 9JsEi2naTc29S4ZmxR8LBA==
X-CSE-MsgGUID: hwkryH87STykd+rLhqbNFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887342"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 01/25] net/ixgbe: remove unused field in Rx queue struct
Date: Fri, 30 May 2025 14:56:57 +0100
Message-ID: <b3cf3fd9cf8ff8b791f3cd17caf6c95cbc57a589.1748612803.git.anatoly.burakov@intel.com>
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

The `rdh` (read head) field in the `ixgbe_rx_queue` struct is not used
anywhere in the codebase, and can be removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 9 ++-------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 95c80ac1b8..0c07ce3186 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3296,17 +3296,12 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modified to setup VFRDT for Virtual Function
 	 */
-	if (ixgbe_is_vf(dev)) {
+	if (ixgbe_is_vf(dev))
 		rxq->rdt_reg_addr =
 			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDT(queue_idx));
-		rxq->rdh_reg_addr =
-			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDH(queue_idx));
-	} else {
+	else
 		rxq->rdt_reg_addr =
 			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
-		rxq->rdh_reg_addr =
-			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDH(rxq->reg_idx));
-	}
 
 	rxq->rx_ring_phys_addr = rz->iova;
 	rxq->rx_ring = (union ixgbe_adv_rx_desc *) rz->addr;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 641f982b01..20a5c5a0af 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -85,7 +85,6 @@ struct ixgbe_rx_queue {
 	volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
 	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
 	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
-	volatile uint32_t   *rdh_reg_addr; /**< RDH register address. */
 	struct ixgbe_rx_entry *sw_ring; /**< address of RX software ring. */
 	struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of scattered Rx software ring. */
 	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
-- 
2.47.1

