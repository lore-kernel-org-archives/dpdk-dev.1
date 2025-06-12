Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A138C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:12:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3991740E44;
	Thu, 12 Jun 2025 13:11:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5F10C4003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726717; x=1781262717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IH5CQ/vLks2nbEU0CWXxWuRX2a66YX60lBNVt9cOXNU=;
 b=i8mzOvQxV22BPK9TmVwumOx1jY3Ige0GqFdSK05V3NbcxcweAXZHWZR+
 wnFuLbOFQ4bqU0ryMW100cRStPirGJC/a6dZgj/Wh6ALAAWIXgheW7/01
 n2mWclLZX3VdXbsCcBhykABm8fHrn2RJMXGmzfF7V+seEL/xFLEfQsLKv
 OhEEKqDddXR3TBe0Yq+ljCSg1hq+guBh+2y+RAOOC2gEmHKBARVqVKb+U
 y0q1t5Rbg/HBBca8jsrjznqHRotC1DmG8wTzI5wCmfpSF6HUbXpXWUYNc
 B8IGe4uWARKyu4GABf8OzyStpXFuc7obP+uQs5twnLhkFqIcQNMY6Glm+ A==;
X-CSE-ConnectionGUID: kyoivKeOQZ6Cm9eCV+1BRA==
X-CSE-MsgGUID: qdUeObrYSYOeeOdQnqHVSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177524"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177524"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:11:56 -0700
X-CSE-ConnectionGUID: CbtCT97uR1e3zwAFEQs1lg==
X-CSE-MsgGUID: QSoqc7qPRiOre3MIlcgrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371262"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:11:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 01/33] net/ixgbe: remove unused field in Rx queue struct
Date: Thu, 12 Jun 2025 12:11:07 +0100
Message-ID: <419153470c975aeca1e9808af7ba6d2e244fba2c.1749726639.git.anatoly.burakov@intel.com>
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

