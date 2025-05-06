Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C91C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 267D14042E;
	Tue,  6 May 2025 15:28:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D282F40150
 for <dev@dpdk.org>; Tue,  6 May 2025 15:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538091; x=1778074091;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jbN0y6kRe3gR5yzmcGZ4NKd7Go9fDJx0EfBrn5wrpW4=;
 b=Kz2u/0fTMoMqf31zEPcPzmryDWSD4kLimpFKGR4Thxwhcr0mbY30QBsD
 0Eif5fq/2j4ORRMMxx5rHlDxAcEozg0W0vEjV8oWEtJQiyXjpaZvY6FVK
 k1bylItCTAd/WJkBHJZ+h2c1qfmpOQuuRhC53t5WI5sILIHUXWpOORie9
 tJsOxNsT07JG6lrwWFl2iUKrbbgYA4IVibEcu2fMOEVi54jWs0xGb9C6j
 qU4aHmWimEBUuEncPLkyLQTSJvD8lYy9QTeLrD6y1QeTzaFX2OuyjIkVW
 BwNbxzKrfQ05TxSW367cWLSKXmZUZYRqBeWGYrXX8b98/n2o1gZkHBVew w==;
X-CSE-ConnectionGUID: 9LrNA6GMSxK9H7iqSMbl/g==
X-CSE-MsgGUID: ejnWRfNHQx+qhEdPuQIwqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48215264"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48215264"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:28:10 -0700
X-CSE-ConnectionGUID: pGQ16ftGTkmEzbjo03S5oA==
X-CSE-MsgGUID: ZXo+OJefQTqGxRJWW7x2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136010733"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 06:28:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v1 01/13] net/ixgbe: remove unused field in Rx queue struct
Date: Tue,  6 May 2025 14:27:50 +0100
Message-ID: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

