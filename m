Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86CCA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 08:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59AF84067B;
	Sat,  3 Oct 2026 10:23:41 +0200 (CEST)
Received: from mail-qv2-f24.google.com (mail-qv2-f24.google.com
 [74.125.230.152])
 by mails.dpdk.org (Postfix) with ESMTP id 222F142E4C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 22:09:31 +0200 (CEST)
Received: by mail-qv2-f24.google.com with SMTP id
 6a1803df08f44-9144f89ce90so3531936d6.0
 for <dev@dpdk.org>; Fri, 02 Oct 2026 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790971770; x=1791576570; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SGT7XO08hMXbaTd9aaKTmO67lso3kyFmYtcRvSBAyG4=;
 b=CHHWQhpBEmpP8mxN2DhM30qxJs3rtWlKPOOAWkeVlEKEJq2cJWH8ZyTX3dB/OfDa+b
 sgqvWPhH3lKdJZT8Zkcqg3Cx/czKkL1S6hSZPYnMXtjCOEIn5CHc2X6hezRuCiICpdI+
 xlk0XpLpj2mLHQwDCsJVi35yRX+Kt21JejrmNLW+L6v7m5MjFAZjY/FIf6ZMA7BVPOoD
 ylclB4qji3ADeXXFOmMnQG3bxamMQxduXlny3eN3A0AH99qQsYTKIAgsVp/n/10XMN03
 l2y7PrVnOageW4VeOSCtRygrB8VXY/i79DCQ/VyzMDQt3tS267U28nQDeCssY0mJLS9v
 fnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790971770; x=1791576570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SGT7XO08hMXbaTd9aaKTmO67lso3kyFmYtcRvSBAyG4=;
 b=CTA/54KKPt0CWCVk70mDB2FkgooKlY0KLi9JGPKqMP4Dy60Xa+ZawmOC62lVVnx+dh
 xsx2f9U0grUVZGr6qqWfqgbEubUaRI/Bh5oD77iDy301S8MVa5fHtNO2Bf3q1WPVAINT
 Ri/wt3JrsCgwOg8h2SDvT7cd8/KWYW6ODcpftyU1TOYYY8uA7Xa1kpCQVM+gCiwBjpgW
 94v2AAjPLxZjVcIrpaklRPf3grlTGeUsI+l1MVqwx4+r0gxbN+7j4fVsBr8D5Kh/lLMw
 WLerXT4NnWhL+OFzWLfaO0P9tngLVvLowcUT0qLZ2XVc7Gp2BM+8D0eFlAe1O5tlnSYi
 Zj/w==
X-Gm-Message-State: AFuF++kcRAouWDFHWfqxi5SAEaOx1fB+0Xk+lOw2vSbXLbjcT94oYB7u
 UKsx6+Hnf0H0Tk4ULL56HQ7vLzYsAtAJpIH99xL3CQO/SRe2PGdvel64ibPnXLsa
X-Gm-Gg: AYBFou0uOZHcwsw5/pN9d0W23bjrhbarYYsX7GmfcwDYcbaR9vCJvWyoxaTW5/cD+UY
 vlB5xl0nPsPAl1+mCSiCMXo70sqstDOrxRCf6W7mPMRnnJfj8cw1cpSc99WqFjVtevmgX1FkiW7
 2BOepe3HxYNleAQ5BuuANSWDmUO8Lu0LC7f5p7aw35iwjXf2zETno34n6yQBSn0erxalT+WHt8A
 p1awu/GEl4SRb95hZGZ+EXuViS9Ac4LHthtK1LmKifdPub1Y1ayQKAj6BkczI8UQ0z5/NKv5FMT
 3JPg5pPO0VckAQJEo1e+H4rvkaS16ULk+u3+tNx0GOYKjGtBd+J+qmzoVGU8BbIuygrI1/KfxfA
 fhM39WVj9V5aX7EGSqfB/SUuw/h2bUAb3AJFq9rBO0kK+6ws1/czWCKtXtbNlpM7ml2TiKyDg4O
 uU146VLpzsudTKraQmT4LXeqdsKyv506bKJN5IkhA0fciI25vAQvsWl1ZgHkumqEq7OFRSTsfYU
 odLGwZzzekM
X-Received: by 2002:a05:6214:1c0b:b0:914:3ef6:ec17 with SMTP id
 6a1803df08f44-917c005e602mr75854606d6.11.1790971769917; 
 Fri, 02 Oct 2026 13:09:29 -0700 (PDT)
Received: from ubuntu-desktop.. ([137.99.252.104])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0bc98fbsm27933156d6.29.2026.10.02.13.09.29
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:09:29 -0700 (PDT)
From: Md Rayhanul Islam <r97yhan@gmail.com>
To: dev@dpdk.org
Subject: [RFC PATCH 2/2] net/e1000: support non-coherent DMA
Date: Fri,  2 Oct 2026 16:09:27 -0400
Message-Id: <20261002200927.6235-3-r97yhan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002200927.6235-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
 <20261002200927.6235-1-r97yhan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 10:23:38 +0200
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

On non-coherent systems the NIC reads stale descriptors and packet data.
Seen on a BCM2711 Compute Module 4 with an Intel I210: transmits never
completed and received data went to address zero.

Take the DMA context from the bus at probe, keep it in the shared adapter
data so secondary processes see it, and install separate TX and RX bursts
for such devices.  They translate every address against the device window
and synchronize buffers and descriptors.  Both come from one inlined
template with a constant flag, so the coherent datapath is unchanged.

Four descriptors share a cache line.  Invalidate a line before writing
into it, so cleaning it afterwards keeps the Done bits the NIC wrote on
the neighbours; without that a burst loses about three packets of every
sixteen.  Completion is the Done bit, never the head register, which
advances when a descriptor is fetched rather than when its data has been
read.  Receive descriptors are refilled a whole line at a time, and
receive buffers are cleaned before handover and rejected unless they are
direct, cache-line aligned and inside the window.

The em driver, which shares net/e1000 with igb, does not set
RTE_PCI_DRV_DMA_NONCOHERENT, so on non-coherent systems the PCI
bus does not probe em devices; they fail cleanly instead of
running with stale DMA.

Tested between two Compute Module 4 boards with Intel I210s: testpmd
txonly holds 1.42 Mpps at 1 GbE line rate, and a 512 MB transfer with
DPDK at both ends arrives byte-identical.

Signed-off-by: Md Rayhanul Islam <r97yhan@gmail.com>
---
 doc/guides/rel_notes/release_26_11.rst |   5 +
 drivers/net/intel/e1000/e1000_ethdev.h |  19 ++
 drivers/net/intel/e1000/igb_ethdev.c   |   9 +-
 drivers/net/intel/e1000/igb_rxtx.c     | 409 +++++++++++++++++++++++--
 4 files changed, 415 insertions(+), 27 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a752c94bbf..5883f0aeb8 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -70,6 +70,11 @@ New Features
   between the CPU and a device whose DMA is not coherent with the caches,
   with an explicit transfer direction.
 
+* **Updated e1000 driver.**
+
+  * Added non-coherent DMA support to ``igb``, through burst functions
+    selected at probe so that coherent platforms are unaffected.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 0907c7c259..979c661f09 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -11,6 +11,8 @@
 #include <rte_flow.h>
 #include <rte_time.h>
 #include <rte_pci.h>
+#include <rte_bus_pci.h>
+#include <rte_mem_sync.h>
 
 #define E1000_INTEL_VENDOR_ID 0x8086
 
@@ -283,6 +285,8 @@ struct e1000_adapter {
 	struct e1000_vf_info    *vfdata;
 	struct e1000_filter_info filter;
 	bool stopped;
+	struct rte_pci_dma_info dma;	/**< DMA window of the bridge above. */
+	bool dma_active;		/**< translate and maintain caches. */
 	struct rte_timecounter  systime_tc;
 	struct rte_timecounter  rx_tstamp_tc;
 	struct rte_timecounter  tx_tstamp_tc;
@@ -428,6 +432,21 @@ int eth_igb_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 
 int eth_igb_tx_done_cleanup(void *txq, uint32_t free_cnt);
 
+int igb_dma_probe(struct rte_eth_dev *dev);
+
+void igb_dma_set_burst(struct rte_eth_dev *dev);
+
+#if defined(RTE_ARCH_ARM64)
+uint16_t eth_igb_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts);
+
+uint16_t eth_igb_recv_scattered_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts);
+
+uint16_t eth_igb_xmit_pkts_nc(void *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts);
+#endif
+
 int eth_igb_rx_init(struct rte_eth_dev *dev);
 
 void eth_igb_tx_init(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 524c030be6..287f2a0105 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -809,9 +809,15 @@ eth_igb_dev_init(struct rte_eth_dev *eth_dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY){
 		if (eth_dev->data->scattered_rx)
 			eth_dev->rx_pkt_burst = &eth_igb_recv_scattered_pkts;
+		igb_dma_set_burst(eth_dev);
 		return 0;
 	}
 
+	error = igb_dma_probe(eth_dev);
+	if (error != 0)
+		return error;
+	igb_dma_set_burst(eth_dev);
+
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 
 	hw->hw_addr= (void *)pci_dev->mem_resource[0].addr;
@@ -1097,7 +1103,8 @@ static int eth_igb_pci_remove(struct rte_pci_device *pci_dev)
 
 static struct rte_pci_driver rte_igb_pmd = {
 	.id_table = pci_id_igb_map,
-	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC |
+		RTE_PCI_DRV_DMA_NONCOHERENT,
 	.probe = eth_igb_pci_probe,
 	.remove = eth_igb_pci_remove,
 };
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index 4fda5d57a0..3996f23b03 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -4,6 +4,10 @@
 
 #include <sys/queue.h>
 
+#include <limits.h>
+#include <stdbool.h>
+#include <unistd.h>
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -31,6 +35,9 @@
 #include <rte_mbuf.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
+#include <bus_pci_driver.h>
+#include <rte_bus_pci.h>
+#include <rte_mem_sync.h>
 #include <rte_prefetch.h>
 #include <rte_udp.h>
 #include <rte_tcp.h>
@@ -42,6 +49,107 @@
 #include "base/e1000_api.h"
 #include "e1000_ethdev.h"
 
+/*
+ * Non-coherent DMA: addresses go through the device's DMA window, and
+ * descriptors and buffers are synced around every handover.
+ */
+void
+igb_dma_set_burst(struct rte_eth_dev *dev)
+{
+#if defined(RTE_ARCH_ARM64)
+	struct e1000_adapter *adapter = E1000_DEV_PRIVATE(dev->data->dev_private);
+
+	if (!adapter->dma_active)
+		return;
+	if (dev->rx_pkt_burst == eth_igb_recv_pkts)
+		dev->rx_pkt_burst = eth_igb_recv_pkts_nc;
+	else if (dev->rx_pkt_burst == eth_igb_recv_scattered_pkts)
+		dev->rx_pkt_burst = eth_igb_recv_scattered_pkts_nc;
+	if (dev->tx_pkt_burst == eth_igb_xmit_pkts)
+		dev->tx_pkt_burst = eth_igb_xmit_pkts_nc;
+#else
+	RTE_SET_USED(dev);
+#endif
+}
+
+int
+igb_dma_probe(struct rte_eth_dev *dev)
+{
+	struct e1000_adapter *adapter = E1000_DEV_PRIVATE(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
+
+	rte_pci_get_dma_info(pci_dev, &adapter->dma);
+	adapter->dma_active = adapter->dma.noncoherent || adapter->dma.size != 0;
+	if (!adapter->dma_active)
+		return 0;
+	if (!rte_mem_sync_supported() || rte_mem_dcache_line_size() !=
+			4 * sizeof(union e1000_adv_rx_desc)) {
+		PMD_INIT_LOG(ERR, "%s: this DMA handling needs 64-byte cache lines",
+			dev->device->name);
+		return -ENOTSUP;
+	}
+	PMD_INIT_LOG(NOTICE, "%s: DMA is not cache coherent, maintaining %zu"
+		"-byte D-cache lines", dev->device->name,
+		rte_mem_dcache_line_size());
+	return 0;
+}
+
+static inline void
+igb_dma_sync_for_device(const volatile void *addr, size_t len,
+		enum rte_mem_sync_direction dir)
+{
+	if (len != 0)
+		rte_mem_sync_for_device((const void *)(uintptr_t)addr, len, dir);
+}
+
+static inline void
+igb_dma_sync_for_cpu(const volatile void *addr, size_t len)
+{
+	if (len != 0)
+		rte_mem_sync_for_cpu((const void *)(uintptr_t)addr, len,
+				RTE_MEM_SYNC_FROM_DEVICE);
+}
+
+static inline void
+igb_rx_buf_sync_for_device(struct rte_mbuf *mb)
+{
+	igb_dma_sync_for_device((char *)mb->buf_addr + RTE_PKTMBUF_HEADROOM,
+			mb->buf_len - RTE_PKTMBUF_HEADROOM,
+			RTE_MEM_SYNC_FROM_DEVICE);
+}
+
+static inline bool
+igb_rx_buf_usable(const struct rte_pci_dma_info *dma, struct rte_mbuf *mb)
+{
+	size_t line = rte_mem_dcache_line_size();
+	uintptr_t addr = (uintptr_t)mb->buf_addr + RTE_PKTMBUF_HEADROOM;
+	size_t len;
+
+	if (!RTE_MBUF_DIRECT(mb) || RTE_MBUF_HAS_EXTBUF(mb) ||
+			mb->buf_len <= RTE_PKTMBUF_HEADROOM)
+		return false;
+	len = mb->buf_len - RTE_PKTMBUF_HEADROOM;
+	return (addr % line) == 0 && (len % line) == 0 &&
+		rte_pci_dma_iova(dma, rte_mbuf_data_iova_default(mb), len) !=
+			RTE_BAD_IOVA;
+}
+
+static inline void
+igb_dma_sync_ring(const volatile void *ring, size_t desc_size, uint16_t nb_desc,
+		uint16_t from, uint16_t to)
+{
+	if (from == to)
+		return;
+	if (from < to) {
+		igb_dma_sync_for_device(RTE_PTR_ADD(ring, from * desc_size),
+				(to - from) * desc_size, RTE_MEM_SYNC_TO_DEVICE);
+	} else {
+		igb_dma_sync_for_device(RTE_PTR_ADD(ring, from * desc_size),
+				(nb_desc - from) * desc_size, RTE_MEM_SYNC_TO_DEVICE);
+		igb_dma_sync_for_device(ring, to * desc_size, RTE_MEM_SYNC_TO_DEVICE);
+	}
+}
+
 #ifdef RTE_LIBRTE_IEEE1588
 #define IGB_TX_IEEE1588_TMST RTE_MBUF_F_TX_IEEE1588_TMST
 #else
@@ -88,6 +196,9 @@ enum igb_rxq_flags {
  * Structure associated with each RX queue.
  */
 struct igb_rx_queue {
+	struct rte_pci_dma_info dma;    /**< translation window of the bridge. */
+	bool                   dma_active; /**< translate and maintain caches. */
+	uint16_t               dma_per_line; /**< descriptors in one cache line. */
 	struct rte_mempool  *mb_pool;   /**< mbuf pool to populate RX ring. */
 	volatile union e1000_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
 	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
@@ -98,6 +209,7 @@ struct igb_rx_queue {
 	struct rte_mbuf *pkt_last_seg;  /**< Last segment of current packet. */
 	uint16_t            nb_rx_desc; /**< number of RX descriptors. */
 	uint16_t            rx_tail;    /**< current value of RDT register. */
+	uint16_t            rx_unwritten; /**< first refill not written back. */
 	uint16_t            nb_rx_hold; /**< number of held free RX desc. */
 	uint16_t            rx_free_thresh; /**< max free RX desc to hold. */
 	uint16_t            queue_id;   /**< RX queue index. */
@@ -163,6 +275,10 @@ struct igb_advctx_info {
  * Structure associated with each TX queue.
  */
 struct igb_tx_queue {
+	struct rte_pci_dma_info dma;    /**< translation window of the bridge. */
+	bool                   dma_active; /**< translate and maintain caches. */
+	uint16_t               dma_per_line; /**< descriptors in one cache line. */
+	uint16_t               last_rs; /**< newest descriptor asking for status. */
 	volatile union e1000_adv_tx_desc *tx_ring; /**< TX ring address */
 	uint64_t               tx_ring_phys_addr; /**< TX ring DMA address. */
 	struct igb_tx_entry    *sw_ring; /**< virtual address of SW ring. */
@@ -384,9 +500,97 @@ tx_desc_vlan_flags_to_cmdtype(uint64_t ol_flags)
 	return cmdtype;
 }
 
-uint16_t
-eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
-	       uint16_t nb_pkts)
+/*
+ * Refresh a descriptor line before writing it, so the clean that publishes it
+ * does not erase Done bits the NIC set on its neighbours.
+ */
+static inline void
+igb_tx_line_acquire(struct igb_tx_queue *txq, uint16_t desc)
+{
+	uint16_t line = desc & ~(uint16_t)(txq->dma_per_line - 1);
+
+	igb_dma_sync_for_cpu(&txq->tx_ring[line],
+			txq->dma_per_line * sizeof(*txq->tx_ring));
+}
+
+/* Completion is in order, so Done on the last RS descriptor covers this one. */
+static inline bool
+igb_tx_desc_done(struct igb_tx_queue *txq, uint16_t desc, const bool nc)
+{
+	volatile uint32_t *status = &txq->tx_ring[desc].wb.status;
+
+	if (!nc)
+		return (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD)) != 0;
+
+	igb_dma_sync_for_cpu(status, sizeof(*status));
+	if (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD))
+		return true;
+
+	status = &txq->tx_ring[txq->last_rs].wb.status;
+	igb_dma_sync_for_cpu(status, sizeof(*status));
+	return (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD)) != 0;
+}
+
+static bool
+igb_tx_pkt_reachable(struct igb_tx_queue *txq, struct rte_mbuf *mb)
+{
+	uint16_t n = 0, expected = mb->nb_segs;
+
+	for (; mb != NULL && n < txq->nb_tx_desc; mb = mb->next, n++)
+		if (rte_pci_dma_iova(&txq->dma, rte_mbuf_data_iova(mb),
+				mb->data_len) == RTE_BAD_IOVA)
+			return false;
+	return mb == NULL && n == expected;
+}
+
+static inline uint16_t
+igb_rx_desc_per_line(struct igb_rx_queue *rxq)
+{
+	return rxq->dma_per_line;
+}
+
+static inline void
+igb_rx_write_range(struct igb_rx_queue *rxq, uint16_t from, uint16_t to)
+{
+	uint16_t i;
+
+	for (i = from; i < to; i++) {
+		volatile union e1000_adv_rx_desc *rxd = &rxq->rx_ring[i];
+		struct rte_mbuf *mb = rxq->sw_ring[i].mbuf;
+
+		igb_rx_buf_sync_for_device(mb);
+		rxd->read.hdr_addr = 0;
+		rxd->read.pkt_addr = rte_cpu_to_le_64(rte_pci_dma_iova(&rxq->dma,
+			rte_mbuf_data_iova_default(mb),
+			mb->buf_len - RTE_PKTMBUF_HEADROOM));
+	}
+	igb_dma_sync_for_device(&rxq->rx_ring[from],
+			(to - from) * sizeof(*rxq->rx_ring), RTE_MEM_SYNC_TO_DEVICE);
+}
+
+/* Post whole descriptor lines; returns the first one not yet posted. */
+static inline uint16_t
+igb_rx_flush_refills(struct igb_rx_queue *rxq, uint16_t rx_id)
+{
+	uint16_t mask = igb_rx_desc_per_line(rxq) - 1;
+	uint16_t start = rxq->rx_unwritten;
+	uint16_t end = rx_id & ~mask;
+
+	if (end == start)
+		return start;
+	if (end < start) {
+		igb_rx_write_range(rxq, start, rxq->nb_rx_desc);
+		start = 0;
+	}
+	if (end > start)
+		igb_rx_write_range(rxq, start, end);
+	rxq->rx_unwritten = end;
+	return end;
+}
+
+static __rte_always_inline uint16_t
+igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts,
+	      const bool nc)
 {
 	struct igb_tx_queue *txq;
 	struct igb_tx_entry *sw_ring;
@@ -419,6 +623,10 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = *tx_pkts++;
+		if (nc && (tx_pkt->nb_segs == 0 ||
+				tx_pkt->nb_segs >= txq->nb_tx_desc ||
+				!igb_tx_pkt_reachable(txq, tx_pkt)))
+			break;
 		pkt_len = tx_pkt->pkt_len;
 
 		RTE_MBUF_PREFETCH_TO_FREE(txe->mbuf);
@@ -508,7 +716,7 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/*
 		 * Check that this descriptor is free.
 		 */
-		if (! (txr[tx_end].wb.status & E1000_TXD_STAT_DD)) {
+		if (!igb_tx_desc_done(txq, tx_end, nc)) {
 			if (nb_tx == 0)
 				return 0;
 			goto end_of_tx;
@@ -595,6 +803,15 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 */
 			slen = (uint16_t) m_seg->data_len;
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
+			if (nc) {
+				if ((tx_id & (txq->dma_per_line - 1)) == 0 ||
+						tx_id == txq->tx_tail)
+					igb_tx_line_acquire(txq, tx_id);
+				buf_dma_addr = rte_pci_dma_iova(&txq->dma,
+						buf_dma_addr, slen);
+				igb_dma_sync_for_device(rte_pktmbuf_mtod(m_seg, void *),
+						slen, RTE_MEM_SYNC_TO_DEVICE);
+			}
 			txd->read.buffer_addr =
 				rte_cpu_to_le_64(buf_dma_addr);
 			txd->read.cmd_type_len =
@@ -613,10 +830,15 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		 */
 		txd->read.cmd_type_len |=
 			rte_cpu_to_le_32(E1000_TXD_CMD_EOP | E1000_TXD_CMD_RS);
+		txq->last_rs = tx_last;
 	}
  end_of_tx:
 	rte_wmb();
 
+	if (nc)
+		igb_dma_sync_ring(txq->tx_ring, sizeof(*txq->tx_ring),
+				txq->nb_tx_desc, txq->tx_tail, tx_id);
+
 	/*
 	 * Set the Transmit Descriptor Tail (TDT).
 	 */
@@ -629,6 +851,20 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
+uint16_t
+eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return igb_xmit_pkts(tx_queue, tx_pkts, nb_pkts, false);
+}
+
+#if defined(RTE_ARCH_ARM64)
+uint16_t
+eth_igb_xmit_pkts_nc(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return igb_xmit_pkts(tx_queue, tx_pkts, nb_pkts, true);
+}
+#endif
+
 /*********************************************************************
  *
  *  TX prep functions
@@ -817,9 +1053,9 @@ rx_desc_error_to_pkt_flags(uint32_t rx_status)
 		E1000_RXD_ERR_CKSUM_BIT) & E1000_RXD_ERR_CKSUM_MSK];
 }
 
-uint16_t
-eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
-	       uint16_t nb_pkts)
+static __rte_always_inline uint16_t
+igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
+	      const bool nc)
 {
 	struct igb_rx_queue *rxq;
 	volatile union e1000_adv_rx_desc *rx_ring;
@@ -854,6 +1090,8 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 * using invalid descriptor fields when read from rxd.
 		 */
 		rxdp = &rx_ring[rx_id];
+		if (nc)
+			igb_dma_sync_for_cpu(rxdp, sizeof(*rxdp));
 		staterr = rxdp->wb.upper.status_error;
 		if (! (staterr & rte_cpu_to_le_32(E1000_RXD_STAT_DD)))
 			break;
@@ -900,6 +1138,11 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			break;
 		}
 
+		if (nc && !igb_rx_buf_usable(&rxq->dma, nmb)) {
+			rte_pktmbuf_free(nmb);
+			rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+			break;
+		}
 		nb_hold++;
 		rxe = &sw_ring[rx_id];
 		rx_id++;
@@ -923,8 +1166,10 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxe->mbuf = nmb;
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
-		rxdp->read.hdr_addr = 0;
-		rxdp->read.pkt_addr = dma_addr;
+		if (!nc) {	/* deferred to igb_rx_flush_refills() */
+			rxdp->read.hdr_addr = 0;
+			rxdp->read.pkt_addr = dma_addr;
+		}
 
 		/*
 		 * Initialize the returned mbuf.
@@ -942,6 +1187,9 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		pkt_len = (uint16_t) (rte_le_to_cpu_16(rxd.wb.upper.length) -
 				      rxq->crc_len);
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		if (nc)
+			igb_dma_sync_for_cpu((char *)rxm->buf_addr + rxm->data_off,
+					rte_le_to_cpu_16(rxd.wb.upper.length));
 		rte_packet_prefetch((char *)rxm->buf_addr + rxm->data_off);
 		rxm->nb_segs = 1;
 		rxm->next = NULL;
@@ -993,18 +1241,39 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   (unsigned) rxq->port_id, (unsigned) rxq->queue_id,
 			   (unsigned) rx_id, (unsigned) nb_hold,
 			   (unsigned) nb_rx);
+		if (nc) {
+			uint16_t first = rxq->rx_unwritten;
+
+			rx_id = igb_rx_flush_refills(rxq, rx_id);
+			nb_hold -= (rx_id + rxq->nb_rx_desc - first) % rxq->nb_rx_desc;
+		} else {
+			nb_hold = 0;
+		}
 		rx_id = (uint16_t) ((rx_id == 0) ?
 				     (rxq->nb_rx_desc - 1) : (rx_id - 1));
 		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
-		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
 	return nb_rx;
 }
 
 uint16_t
-eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
-			 uint16_t nb_pkts)
+eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	return igb_recv_pkts(rx_queue, rx_pkts, nb_pkts, false);
+}
+
+#if defined(RTE_ARCH_ARM64)
+uint16_t
+eth_igb_recv_pkts_nc(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	return igb_recv_pkts(rx_queue, rx_pkts, nb_pkts, true);
+}
+#endif
+
+static __rte_always_inline uint16_t
+igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
+			uint16_t nb_pkts, const bool nc)
 {
 	struct igb_rx_queue *rxq;
 	volatile union e1000_adv_rx_desc *rx_ring;
@@ -1049,6 +1318,8 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 * using invalid descriptor fields when read from rxd.
 		 */
 		rxdp = &rx_ring[rx_id];
+		if (nc)
+			igb_dma_sync_for_cpu(rxdp, sizeof(*rxdp));
 		staterr = rxdp->wb.upper.status_error;
 		if (! (staterr & rte_cpu_to_le_32(E1000_RXD_STAT_DD)))
 			break;
@@ -1091,6 +1362,11 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			break;
 		}
 
+		if (nc && !igb_rx_buf_usable(&rxq->dma, nmb)) {
+			rte_pktmbuf_free(nmb);
+			rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+			break;
+		}
 		nb_hold++;
 		rxe = &sw_ring[rx_id];
 		rx_id++;
@@ -1117,8 +1393,10 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxm = rxe->mbuf;
 		rxe->mbuf = nmb;
 		dma = rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
-		rxdp->read.pkt_addr = dma;
-		rxdp->read.hdr_addr = 0;
+		if (!nc) {	/* deferred to igb_rx_flush_refills() */
+			rxdp->read.pkt_addr = dma;
+			rxdp->read.hdr_addr = 0;
+		}
 
 		/*
 		 * Set data length & data buffer address of mbuf.
@@ -1126,6 +1404,9 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		data_len = rte_le_to_cpu_16(rxd.wb.upper.length);
 		rxm->data_len = data_len;
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		if (nc)
+			igb_dma_sync_for_cpu((char *)rxm->buf_addr + rxm->data_off,
+					data_len);
 
 		/*
 		 * If this is the first buffer of the received packet,
@@ -1255,15 +1536,38 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   (unsigned) rxq->port_id, (unsigned) rxq->queue_id,
 			   (unsigned) rx_id, (unsigned) nb_hold,
 			   (unsigned) nb_rx);
+		if (nc) {
+			uint16_t first = rxq->rx_unwritten;
+
+			rx_id = igb_rx_flush_refills(rxq, rx_id);
+			nb_hold -= (rx_id + rxq->nb_rx_desc - first) % rxq->nb_rx_desc;
+		} else {
+			nb_hold = 0;
+		}
 		rx_id = (uint16_t) ((rx_id == 0) ?
 				     (rxq->nb_rx_desc - 1) : (rx_id - 1));
 		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
-		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
 	return nb_rx;
 }
 
+uint16_t
+eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
+			    uint16_t nb_pkts)
+{
+	return igb_recv_scattered_pkts(rx_queue, rx_pkts, nb_pkts, false);
+}
+
+#if defined(RTE_ARCH_ARM64)
+uint16_t
+eth_igb_recv_scattered_pkts_nc(void *rx_queue, struct rte_mbuf **rx_pkts,
+			       uint16_t nb_pkts)
+{
+	return igb_recv_scattered_pkts(rx_queue, rx_pkts, nb_pkts, true);
+}
+#endif
+
 /*
  * Maximum number of Ring Descriptors.
  *
@@ -1308,7 +1612,6 @@ static int
 igb_tx_done_cleanup(struct igb_tx_queue *txq, uint32_t free_cnt)
 {
 	struct igb_tx_entry *sw_ring;
-	volatile union e1000_adv_tx_desc *txr;
 	uint16_t tx_first; /* First segment analyzed. */
 	uint16_t tx_id;    /* Current segment being processed. */
 	uint16_t tx_last;  /* Last segment in the current packet. */
@@ -1319,7 +1622,6 @@ igb_tx_done_cleanup(struct igb_tx_queue *txq, uint32_t free_cnt)
 		return -ENODEV;
 
 	sw_ring = txq->sw_ring;
-	txr = txq->tx_ring;
 
 	/* tx_tail is the last sent packet on the sw_ring. Goto the end
 	 * of that packet (the last segment in the packet chain) and
@@ -1345,8 +1647,7 @@ igb_tx_done_cleanup(struct igb_tx_queue *txq, uint32_t free_cnt)
 		tx_last = sw_ring[tx_id].last_id;
 
 		if (sw_ring[tx_last].mbuf) {
-			if (txr[tx_last].wb.status &
-			    E1000_TXD_STAT_DD) {
+			if (igb_tx_desc_done(txq, tx_last, txq->dma_active)) {
 				/* Increment the number of packets
 				 * freed.
 				 */
@@ -1466,6 +1767,10 @@ igb_reset_tx_queue(struct igb_tx_queue *txq, struct rte_eth_dev *dev)
 		txq->ctx_start = txq->queue_id * IGB_CTX_NUM;
 
 	igb_reset_tx_queue_stat(txq);
+	if (txq->dma_active)
+		igb_dma_sync_for_device(txq->tx_ring,
+				txq->nb_tx_desc * sizeof(*txq->tx_ring),
+				RTE_MEM_SYNC_TO_DEVICE);
 }
 
 uint64_t
@@ -1573,9 +1878,21 @@ eth_igb_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->reg_idx = (uint16_t)((RTE_ETH_DEV_SRIOV(dev).active == 0) ?
 		queue_idx : RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx + queue_idx);
 	txq->port_id = dev->data->port_id;
+	txq->dma = E1000_DEV_PRIVATE(dev->data->dev_private)->dma;
+	txq->dma_active = E1000_DEV_PRIVATE(dev->data->dev_private)->dma_active;
+	txq->dma_per_line = 1;
+	if (txq->dma_active) {
+		txq->dma_per_line = rte_mem_dcache_line_size() /
+				sizeof(*txq->tx_ring);
+		txq->wthresh = 0;
+	}
 
 	txq->tdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_TDT(txq->reg_idx));
-	txq->tx_ring_phys_addr = tz->iova;
+	txq->tx_ring_phys_addr = rte_pci_dma_iova(&txq->dma, tz->iova, size);
+	if (txq->tx_ring_phys_addr == RTE_BAD_IOVA) {
+		igb_tx_queue_release(txq);
+		return -EINVAL;
+	}
 
 	txq->tx_ring = (union e1000_adv_tx_desc *) tz->addr;
 	/* Allocate software ring */
@@ -1591,6 +1908,7 @@ eth_igb_tx_queue_setup(struct rte_eth_dev *dev,
 
 	igb_reset_tx_queue(txq, dev);
 	dev->tx_pkt_burst = eth_igb_xmit_pkts;
+	igb_dma_set_burst(dev);
 	dev->tx_pkt_prepare = &eth_igb_prep_pkts;
 	dev->data->tx_queues[queue_idx] = txq;
 	txq->offloads = offloads;
@@ -1642,6 +1960,9 @@ igb_reset_rx_queue(struct igb_rx_queue *rxq)
 	}
 
 	rxq->rx_tail = 0;
+	rxq->rx_unwritten = 0;
+	if (rxq->dma_active)
+		rxq->nb_rx_hold = 0;
 	rxq->pkt_first_seg = NULL;
 	rxq->pkt_last_seg = NULL;
 }
@@ -1748,6 +2069,9 @@ eth_igb_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->reg_idx = (uint16_t)((RTE_ETH_DEV_SRIOV(dev).active == 0) ?
 		queue_idx : RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx + queue_idx);
 	rxq->port_id = dev->data->port_id;
+	rxq->dma = E1000_DEV_PRIVATE(dev->data->dev_private)->dma;
+	rxq->dma_active = E1000_DEV_PRIVATE(dev->data->dev_private)->dma_active;
+	rxq->dma_per_line = 1;
 	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
 		rxq->crc_len = RTE_ETHER_CRC_LEN;
 	else
@@ -1769,8 +2093,20 @@ eth_igb_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->mz = rz;
 	rxq->rdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_RDT(rxq->reg_idx));
 	rxq->rdh_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_RDH(rxq->reg_idx));
-	rxq->rx_ring_phys_addr = rz->iova;
+	rxq->rx_ring_phys_addr = rte_pci_dma_iova(&rxq->dma, rz->iova, size);
+	if (rxq->rx_ring_phys_addr == RTE_BAD_IOVA) {
+		igb_rx_queue_release(rxq);
+		return -EINVAL;
+	}
 	rxq->rx_ring = (union e1000_adv_rx_desc *) rz->addr;
+	if (rxq->dma_active) {
+		size_t line = rte_mem_dcache_line_size();
+		uint16_t per_line = line / sizeof(*rxq->rx_ring);
+
+		if (per_line > 1 && rxq->nb_rx_desc % per_line == 0 &&
+				((uintptr_t)rxq->rx_ring & (line - 1)) == 0)
+			rxq->dma_per_line = per_line;
+	}
 
 	/* Allocate software ring. */
 	rxq->sw_ring = rte_zmalloc("rxq->sw_ring",
@@ -1800,8 +2136,11 @@ eth_igb_rx_queue_count(void *rx_queue)
 	rxq = rx_queue;
 	rxdp = &(rxq->rx_ring[rxq->rx_tail]);
 
-	while ((desc < rxq->nb_rx_desc) &&
-		(rxdp->wb.upper.status_error & E1000_RXD_STAT_DD)) {
+	while (desc < rxq->nb_rx_desc) {
+		if (rxq->dma_active)
+			igb_dma_sync_for_cpu(rxdp, sizeof(*rxdp));
+		if ((rxdp->wb.upper.status_error & E1000_RXD_STAT_DD) == 0)
+			break;
 		desc += IGB_RXQ_SCAN_INTERVAL;
 		rxdp += IGB_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
@@ -1830,6 +2169,8 @@ eth_igb_rx_descriptor_status(void *rx_queue, uint16_t offset)
 		desc -= rxq->nb_rx_desc;
 
 	status = &rxq->rx_ring[desc].wb.upper.status_error;
+	if (rxq->dma_active)
+		igb_dma_sync_for_cpu(status, sizeof(*status));
 	if (*status & rte_cpu_to_le_32(E1000_RXD_STAT_DD))
 		return RTE_ETH_RX_DESC_DONE;
 
@@ -1840,7 +2181,6 @@ int
 eth_igb_tx_descriptor_status(void *tx_queue, uint16_t offset)
 {
 	struct igb_tx_queue *txq = tx_queue;
-	volatile uint32_t *status;
 	uint32_t desc;
 
 	if (unlikely(offset >= txq->nb_tx_desc))
@@ -1850,8 +2190,7 @@ eth_igb_tx_descriptor_status(void *tx_queue, uint16_t offset)
 	if (desc >= txq->nb_tx_desc)
 		desc -= txq->nb_tx_desc;
 
-	status = &txq->tx_ring[desc].wb.status;
-	if (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD))
+	if (igb_tx_desc_done(txq, desc, txq->dma_active))
 		return RTE_ETH_TX_DESC_DONE;
 
 	return RTE_ETH_TX_DESC_FULL;
@@ -2271,11 +2610,25 @@ igb_alloc_rx_queue_mbufs(struct igb_rx_queue *rxq)
 		}
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
+		if (rxq->dma_active) {
+			if (!igb_rx_buf_usable(&rxq->dma, mbuf)) {
+				rte_pktmbuf_free(mbuf);
+				return -EINVAL;
+			}
+			dma_addr = rte_cpu_to_le_64(rte_pci_dma_iova(&rxq->dma,
+					rte_mbuf_data_iova_default(mbuf),
+					mbuf->buf_len - RTE_PKTMBUF_HEADROOM));
+			igb_rx_buf_sync_for_device(mbuf);
+		}
 		rxd = &rxq->rx_ring[i];
 		rxd->read.hdr_addr = 0;
 		rxd->read.pkt_addr = dma_addr;
 		rxe[i].mbuf = mbuf;
 	}
+	if (rxq->dma_active)
+		igb_dma_sync_for_device(rxq->rx_ring,
+				rxq->nb_rx_desc * sizeof(*rxq->rx_ring),
+				RTE_MEM_SYNC_TO_DEVICE);
 
 	return 0;
 }
@@ -2583,6 +2936,7 @@ eth_igb_rx_init(struct rte_eth_dev *dev)
 		E1000_WRITE_REG(hw, E1000_RDH(rxq->reg_idx), 0);
 		E1000_WRITE_REG(hw, E1000_RDT(rxq->reg_idx), rxq->nb_rx_desc - 1);
 	}
+	igb_dma_set_burst(dev);
 
 	return 0;
 }
@@ -2624,6 +2978,8 @@ eth_igb_tx_init(struct rte_eth_dev *dev)
 
 		/* Setup Transmit threshold registers. */
 		txdctl = E1000_READ_REG(hw, E1000_TXDCTL(txq->reg_idx));
+		if (txq->dma_active)
+			txdctl &= ~(0x1FU << 16);	/* the field is OR-ed below */
 		txdctl |= txq->pthresh & 0x1F;
 		txdctl |= ((txq->hthresh & 0x1F) << 8);
 		txdctl |= ((txq->wthresh & 0x1F) << 16);
@@ -2793,6 +3149,7 @@ eth_igbvf_rx_init(struct rte_eth_dev *dev)
 		E1000_WRITE_REG(hw, E1000_RDH(i), 0);
 		E1000_WRITE_REG(hw, E1000_RDT(i), rxq->nb_rx_desc - 1);
 	}
+	igb_dma_set_burst(dev);
 
 	return 0;
 }
-- 
2.34.1

