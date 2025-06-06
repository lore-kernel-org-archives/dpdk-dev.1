Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EAC61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84A2A40B8F;
	Fri,  6 Jun 2025 19:09:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BB49A40263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229771; x=1780765771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IH5CQ/vLks2nbEU0CWXxWuRX2a66YX60lBNVt9cOXNU=;
 b=hH/3bKVR3loBx5EZxrysaAYphYu61tpnmt/0u9pQZR2KoSEYoG3KG28R
 CuaKIQZc3DtcUMO3hPxis2qpalgMcmpln2E8dG+FbXUL2mggLddbiMngU
 bv3C6W4QOkyURUXbDqtNyuNzoj+ZBwI0sRPcI3RkJmZxGFwiwPY/OxI8w
 6VAxMCXcf9jo3I451QpSvV0Gk9olLNzBt8NEDKU62Pv5/w1pxEEWIuR0A
 gKmqNIDyZY+Vtdh/6fKoI0xMZ/xC6gtxH5UJVTiaPHlZk1aiAXk5V78Np
 J/ywJMVU7dcksnoidJeCLFC22ZjuwUjK9MMKhmHW/GaPIGOC42o//ASyk w==;
X-CSE-ConnectionGUID: eCRS0B1dSHyUS4G+Cx1Qww==
X-CSE-MsgGUID: TPVnyJ4SS423bIPU6Fu/mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828378"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828378"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:30 -0700
X-CSE-ConnectionGUID: LFwYfQ1jRouZS7PLQXK7YA==
X-CSE-MsgGUID: HZhU6tIIRzypcWylSveUjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808045"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 01/34] net/ixgbe: remove unused field in Rx queue struct
Date: Fri,  6 Jun 2025 18:08:40 +0100
Message-ID: <0742359ebe8c1cb6e7bdd82328f66d516a8233a0.1749229650.git.anatoly.burakov@intel.com>
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

