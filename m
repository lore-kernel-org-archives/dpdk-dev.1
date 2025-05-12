Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D0C3ABD4
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 12:56:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C3E540A75;
	Mon, 12 May 2025 14:55:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6677340696
 for <dev@dpdk.org>; Mon, 12 May 2025 14:55:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747054508; x=1778590508;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7QEln2GT9bV2jBxKeovHEKbobuRMEe2a+B8BQjyV/io=;
 b=fp0DV7WgU1oF9ypBneNIiQpuPrAruqPUhi+dYA4cg3ygc4/5Vyl9QaMx
 XFONRVs0zSrOJUZiX2ISjcS7sX+pcNZ1FEhQxydxn13YsAdaNXLC6lokI
 Om3ANfcR7Cwlnme13x+hKg7IXFZ3WyX49JVXziMj47Bkjz8unKaCjlCSI
 hXv0oJf7dvEkyYYZzgaY841rg15CjeQoDKhYz99V0cyZPYNiX3yw/QxL6
 bFmF5cDLCSZjNE/5n8lWyqyRIn2OMb6MKANrv3NZPEwoqgNLh3A9qd4E9
 +26BhkOBInW1rKJSZyP04aJxG/fD42wLZ0gjUwk6AIXz1zQfXr24vV5+0 Q==;
X-CSE-ConnectionGUID: thsn3tWRTPqORwrF/33WzA==
X-CSE-MsgGUID: 5WqzlSG0RwCZTMf9H6Ic3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48097021"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="48097021"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 05:55:07 -0700
X-CSE-ConnectionGUID: pJ5I9vaYQW65w39Y5NvLHw==
X-CSE-MsgGUID: 9XW+CYuBQ62GMOpxRy7xZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142251904"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 12 May 2025 05:55:05 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 12/13] net/intel: add common Rx mbuf recycle
Date: Mon, 12 May 2025 13:54:38 +0100
Message-ID: <f7cb4d7c73f06281bcea6da281f30052f01e3c53.1747054471.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
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
---
 drivers/net/intel/common/recycle_mbufs.h      | 67 +++++++++++++++++++
 .../i40e/i40e_recycle_mbufs_vec_common.c      | 37 +---------
 .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    | 35 +---------
 3 files changed, 73 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/intel/common/recycle_mbufs.h

diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
new file mode 100644
index 0000000000..fd31c5c1ff
--- /dev/null
+++ b/drivers/net/intel/common/recycle_mbufs.h
@@ -0,0 +1,67 @@
+#ifndef _COMMON_INTEL_RECYCLE_MBUFS_H_
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
+ci_rx_recycle_mbufs(struct ci_rx_queue *rxq, const uint16_t nb_mbufs,
+		const size_t desc_len)
+{
+	struct ci_rx_entry *rxep;
+	volatile void *rxdp;
+	uint16_t rx_id;
+	uint16_t i;
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+	rxep = &rxq->sw_ring[rxq->rxrearm_start];
+
+	for (i = 0; i < nb_mbufs; i++) {
+		volatile uint64_t *cur = RTE_PTR_ADD(rxdp, i * desc_len);
+
+#if RTE_IOVA_IN_MBUF
+		const uint64_t paddr = (rxep[i].mbuf)->buf_iova + RTE_PKTMBUF_HEADROOM;
+		const uint64_t dma_addr = rte_cpu_to_le_64(paddr);
+#else
+		const uint64_t vaddr = (uintptr_t)rxep[i].mbuf->buf_addr +
+			RTE_PKTMBUF_HEADROOM;
+		const uint64_t dma_addr = rte_cpu_to_le_64(vaddr);
+#endif
+
+		/* 8 bytes PBA followed by 8 bytes HBA */
+		*(cur + 1) = 0;
+		*cur = dma_addr;
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
index aa7703216d..073357bee2 100644
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
-	volatile union i40e_rx_desc *rxdp;
-	uint16_t rx_id;
-	uint64_t paddr;
-	uint64_t dma_addr;
-	uint16_t i;
-
-	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
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
+	ci_rx_recycle_mbufs(rx_queue, nb_mbufs, sizeof(union i40e_rx_desc));
 }
 
 uint16_t
diff --git a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
index 1df1787c7f..e2c3523ed2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
@@ -8,41 +8,12 @@
 #include "ixgbe_ethdev.h"
 #include "ixgbe_rxtx.h"
 
+#include "../common/recycle_mbufs.h"
+
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
+	ci_rx_recycle_mbufs(rx_queue, nb_mbufs, sizeof(union ixgbe_adv_rx_desc));
 }
 
 uint16_t
-- 
2.47.1

