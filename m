Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D5C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15FF042DDE;
	Mon,  9 Jun 2025 17:38:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 078274270A
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483519; x=1781019519;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rlQQpIrJMZYiI3cXw8YFGz8n2T28PgvdiR2UMl/B1TU=;
 b=j7leUksg/0sHQuO6Bm+/n2QBUe4SSA7DUS5/SDCqXzAxUaDnK/Tt6f2q
 beebSq9WbAx38F7ybdjP1P0g7HaxnDjsMDI5texARHJX5dvbGXoJI0d9g
 SS7kPvu6wiwrRbfiiRCl0SrbbzHGixx0EVBf2owy/ws0jOj5+cdD2Eguf
 WS3CkjinCJbZj5ULwp3NT8KrDelGZCQc0TIangeQZq1VqKngfmBrRtxcn
 r4wYCR6YR9uvVykOmyf4bjJ8ljlxtR/uX0IdqnJ6yoobJlnsC+B9TCiKB
 pKQFYAMsij0Tk/ux+MP4ooN9YVyrQpGZQm1cMPRBQoqBsPDSprA1tAmTf A==;
X-CSE-ConnectionGUID: JOW4lO28QheA38Wo/SjiXg==
X-CSE-MsgGUID: wzXmQ8XvTt26QG0mecVNQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012245"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012245"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:39 -0700
X-CSE-ConnectionGUID: CMZauvF/Ru+wKAri9Fo+Pw==
X-CSE-MsgGUID: pC33HSZEQEOdkxh3Bv0RMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419796"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 32/33] net/intel: add common Rx mbuf recycle
Date: Mon,  9 Jun 2025 16:37:30 +0100
Message-ID: <f07a70aeb5b80b331a2d65ac13df64c2eb4f057a.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
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

Currently, there are duplicate implementations of Rx mbuf recycle in some
drivers, specifically ixgbe and i40e. Move them into a common header.

While we're at it, also support no-IOVA-in-mbuf case.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Renamed paddr to iova

 drivers/net/intel/common/recycle_mbufs.h      | 68 +++++++++++++++++++
 .../i40e/i40e_recycle_mbufs_vec_common.c      | 37 +---------
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   | 35 +---------
 3 files changed, 74 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/intel/common/recycle_mbufs.h

diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
new file mode 100644
index 0000000000..1aea611c80
--- /dev/null
+++ b/drivers/net/intel/common/recycle_mbufs.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+ #ifndef _COMMON_INTEL_RECYCLE_MBUFS_H_
+#define _COMMON_INTEL_RECYCLE_MBUFS_H_
+
+#include <stdint.h>
+#include <unistd.h>
+
+#include <rte_mbuf.h>
+#include <rte_io.h>
+#include <ethdev_driver.h>
+
+#include "rx.h"
+#include "tx.h"
+
+/**
+ * Recycle mbufs for Rx queue.
+ *
+ * @param rxq Rx queue pointer
+ * @param nb_mbufs number of mbufs to recycle
+ * @param desc_len length of Rx descriptor
+ */
+static __rte_always_inline void
+ci_rx_recycle_mbufs(struct ci_rx_queue *rxq, const uint16_t nb_mbufs)
+{
+	struct ci_rx_entry *rxep;
+	volatile union ci_rx_desc *rxdp;
+	uint16_t rx_id;
+	uint16_t i;
+
+	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxep = &rxq->sw_ring[rxq->rxrearm_start];
+
+	for (i = 0; i < nb_mbufs; i++) {
+		struct rte_mbuf *mb = rxep[i].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		const uint64_t iova = mb->buf_iova + RTE_PKTMBUF_HEADROOM;
+		const uint64_t dma_addr = rte_cpu_to_le_64(iova);
+#else
+		const uint64_t vaddr = (uintptr_t)mb->buf_addr + RTE_PKTMBUF_HEADROOM;
+		const uint64_t dma_addr = rte_cpu_to_le_64(vaddr);
+#endif
+
+		rxdp[i].read.hdr_addr = 0;
+		rxdp[i].read.pkt_addr = dma_addr;
+	}
+
+	/* Update the descriptor initializer index */
+	rxq->rxrearm_start += nb_mbufs;
+	rx_id = rxq->rxrearm_start - 1;
+
+	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
+		rxq->rxrearm_start = 0;
+		rx_id = rxq->nb_rx_desc - 1;
+	}
+
+	rxq->rxrearm_nb -= nb_mbufs;
+
+	rte_io_wmb();
+
+	/* Update the tail pointer on the NIC */
+	rte_write32_wc_relaxed(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
+}
+
+#endif
diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
index 20d9fd7b22..0b036faea9 100644
--- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
@@ -10,43 +10,12 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 
+#include "../common/recycle_mbufs.h"
+
 void
 i40e_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 {
-	struct ci_rx_queue *rxq = rx_queue;
-	struct ci_rx_entry *rxep;
-	volatile union ci_rx_desc *rxdp;
-	uint16_t rx_id;
-	uint64_t paddr;
-	uint64_t dma_addr;
-	uint16_t i;
-
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
-	rxep = &rxq->sw_ring[rxq->rxrearm_start];
-
-	for (i = 0; i < nb_mbufs; i++) {
-		/* Initialize rxdp descs. */
-		paddr = (rxep[i].mbuf)->buf_iova + RTE_PKTMBUF_HEADROOM;
-		dma_addr = rte_cpu_to_le_64(paddr);
-		/* flush desc with pa dma_addr */
-		rxdp[i].read.hdr_addr = 0;
-		rxdp[i].read.pkt_addr = dma_addr;
-	}
-
-	/* Update the descriptor initializer index */
-	rxq->rxrearm_start += nb_mbufs;
-	rx_id = rxq->rxrearm_start - 1;
-
-	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
-		rxq->rxrearm_start = 0;
-		rx_id = rxq->nb_rx_desc - 1;
-	}
-
-	rxq->rxrearm_nb -= nb_mbufs;
-
-	rte_io_wmb();
-	/* Update the tail pointer on the NIC */
-	I40E_PCI_REG_WRITE_RELAXED(rxq->qrx_tail, rx_id);
+	ci_rx_recycle_mbufs(rx_queue, nb_mbufs);
 }
 
 uint16_t
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index 5f231b9012..486dae4178 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -10,6 +10,8 @@
 #include "ixgbe_rxtx.h"
 #include "ixgbe_rxtx_vec_common.h"
 
+#include "../common/recycle_mbufs.h"
+
 void __rte_cold
 ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq)
 {
@@ -173,38 +175,7 @@ ixgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 void
 ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 {
-	struct ci_rx_queue *rxq = rx_queue;
-	struct ci_rx_entry *rxep;
-	volatile union ixgbe_adv_rx_desc *rxdp;
-	uint16_t rx_id;
-	uint64_t paddr;
-	uint64_t dma_addr;
-	uint16_t i;
-
-	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
-	rxep = &rxq->sw_ring[rxq->rxrearm_start];
-
-	for (i = 0; i < nb_mbufs; i++) {
-		/* Initialize rxdp descs. */
-		paddr = (rxep[i].mbuf)->buf_iova + RTE_PKTMBUF_HEADROOM;
-		dma_addr = rte_cpu_to_le_64(paddr);
-		/* Flush descriptors with pa dma_addr */
-		rxdp[i].read.hdr_addr = 0;
-		rxdp[i].read.pkt_addr = dma_addr;
-	}
-
-	/* Update the descriptor initializer index */
-	rxq->rxrearm_start += nb_mbufs;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= nb_mbufs;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			(rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
+	ci_rx_recycle_mbufs(rx_queue, nb_mbufs);
 }
 
 uint16_t
-- 
2.47.1

