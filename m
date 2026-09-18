Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE1DC982CC
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 08:17:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21B3F40682;
	Sat, 19 Sep 2026 10:17:39 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id D81E04026A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 00:56:16 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so9223495ad.1
 for <dev@dpdk.org>; Fri, 18 Sep 2026 15:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789772176; x=1790376976; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=joyqVOSlpLpOtvwtShbkeB8TZovNAtLArVymb+qB6zQ=;
 b=mJZGV9uW5FCSyr1mCemPwTEAbfxBmyXbEnM+CZItL5sHVORAHglahfEuZlgtbVfyJ2
 R9F81VHGb8wVVTh+56kfrqiNKX0uK6nwJKgskOQq9Us2iESs8Yg0z9y/4gAUtT9Cv8xV
 fR6GaSO7Q0YoZvUh+UWnMux8wrslm9R/r3LALzKiw07yJ3nCMqQjuHwkYq5+PW3wjafY
 403/pQEcmJ/PUNn1QZ8zHsORD39AVdurFOFQr4ZkymlAhbjSLpdiVfkhehMHpdsyOI7R
 +0Ow75fSuCGvKEBFDkfn6S6eQDwzexz1Z8piKxPMm11BfefGCGRWzzA663KIxQnCuC09
 6IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789772176; x=1790376976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=joyqVOSlpLpOtvwtShbkeB8TZovNAtLArVymb+qB6zQ=;
 b=Dljyo306F00j7KrsdQ96P10MpzJdoawUVKMRJRjcxbFPjhj3xU8VjgxrzLqckGSHzx
 fTjs/svQvkTQTj1GaXMKbbjdoCCDkBl+ghUTJKbqE/P94JNNNCpJL4Zkaum/efNkG1xt
 hLtUjcTBwpfSRRJeImphkKzwzIjfUUMr+Ar2Wop3jjdsRtADuDLLUFQIQJpSQZFKqnQ+
 qm35hIwVsAJsLsL/mw+nn9HiucEgewJImqoYRR27QaRYRBzoq3PbEmiKm9agWMRen7DK
 etWI4+GMh47OSfYTnGjIAmWVo0OtBFkQz2WZRnsmCcUClM7OeFEie+CIIn3dwgQC1Mw3
 E6DQ==
X-Gm-Message-State: AFuF++n/LdxNLNKkqV2t5nCtiWnKS6FLDrxkCvPOOEe6mSIh4UmPyCNh
 3WV76EaBe8l7EigfryD1nOVQ/AtSSVU6tWJDpXmOXBxI3xB3m5CvB0tbVBjgKPfo
X-Gm-Gg: AYBFou1dQ+FvKkPoQIkUwk8mInb0Sy1cK8g3Y6dya803po5gBV18ljpI/ZzC/iiCmE5
 89O84sD7AmctAG0jXmDauhTAm6T6oLQISSzKZ1/sZXj6AvQANYvAzgBz4KV1wpi2G/8zQdd7nDn
 Oith1GU1f0YiQB3uAhBcH6DGYCGEPO7Zqg9xz0QmXGE+w1UYcvojWg30quJ8KZHdLC2Yxdd5zeI
 tdGHlK2rtKb1IznwwBuo+5/JQjm766kSR/59LE9Mw9ymIOxibdxx5xBOPAMdah0AP5UUmezN7yP
 D40i2NRt5caZjKUT5rcVsRT4U4GSy5SvzDko3AjNT+PG/AMezp2MyM3kec81cspJu3t1ek+MprN
 4UarMa55Wzupbvim5L62orIujymiTIrrGmMH21W66H8LDxGtVZC+oA+zp+UGwIPZsdi+yvASBJN
 Gviv+GXBX5CTH9Fjsi+ZinjA7W3MaBPoZqR2H3EJevggc6S0+DmG6nn9Ot7Cbmg8WYOE9GFFNyh
 g==
X-Received: by 2002:a17:902:d491:b0:2dd:4438:4290 with SMTP id
 d9443c01a7336-2dd9c6b8750mr115264965ad.3.1789772175719; 
 Fri, 18 Sep 2026 15:56:15 -0700 (PDT)
Received: from ubuntu-desktop.. ([137.99.252.104])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3314313esm1569423eec.14.2026.09.18.15.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:56:15 -0700 (PDT)
From: Md Rayhanul Islam <r97yhan@gmail.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Chuanyu Xue <chuanyu.xue@uconn.edu>,
 Song Han <song.han@uconn.edu>,
 Md Rayhanul Islam <md_rayhanul.islam@uconn.edu>,
 Md Rayhanul Islam <r97yhan@gmail.com>
Subject: [PATCH 2/2] net/e1000: maintain caches on non-coherent DMA
Date: Fri, 18 Sep 2026 18:50:44 -0400
Message-Id: <20260918225045.177125-3-r97yhan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918225045.177125-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:17:34 +0200
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

When the PCIe bus is not cache coherent, the NIC can read stale memory.
The kernel's DMA API cleans the cache before handing a buffer to a
device; DPDK writes descriptors straight into hugepage memory and rings
the doorbell.

On a BCM2711 (Raspberry Pi Compute Module 4, Cortex-A72, 64-byte cache
lines) with an Intel I210, the NIC fetched the previous contents of the
rings -- zeroed descriptors with DD set and null buffer addresses -- so
transmits never completed and received data was DMA'd to address zero.
Cleaning to the point of unification was not enough; the device saw the
CPU's stores only after a clean to the point of coherency.

Cleaning writes back a whole 64-byte line, which holds four descriptors,
so cleaning one just written also restored stale status for its
neighbours and erased DD bits the NIC had set.

When the device is described by a device tree and no ancestor declares
"dma-coherent", on arm64:

 - clean the D-cache (DC CVAC) over descriptors and packet data before
   the tail register lets the NIC read them;
 - invalidate (DC CIVAC) descriptor status and received data before
   reading what the NIC wrote;
 - take TX completion from the hardware head register instead of the DD
   bits;
 - write RX buffer addresses back one whole cache line at a time, once
   every descriptor in that line has been returned and consumed.

This is a no-op on cache-coherent platforms and non-arm64 builds, and
DPDK_DMA_NONCOHERENT forces it either way.

Signed-off-by: Md Rayhanul Islam <r97yhan@gmail.com>
---
 doc/guides/linux_gsg/bcm2711_platform.rst |  30 +-
 doc/guides/rel_notes/release_26_11.rst    |   8 +
 drivers/net/intel/e1000/igb_rxtx.c        | 356 +++++++++++++++++++++-
 3 files changed, 381 insertions(+), 13 deletions(-)

diff --git a/doc/guides/linux_gsg/bcm2711_platform.rst b/doc/guides/linux_gsg/bcm2711_platform.rst
index 5a774607da..3be149e2f7 100644
--- a/doc/guides/linux_gsg/bcm2711_platform.rst
+++ b/doc/guides/linux_gsg/bcm2711_platform.rst
@@ -5,8 +5,8 @@ Running DPDK on Broadcom BCM2711 platforms
 ==========================================
 
 The Broadcom BCM2711, used on the Raspberry Pi 4 and Compute Module 4,
-has a platform property that must be taken into account before a PCIe
-device can DMA correctly.  It is handled automatically; this page
+needs two platform properties to be taken into account before a PCIe
+device can DMA correctly.  Both are handled automatically; this page
 describes what happens and how to check it.
 
 PCIe inbound address translation
@@ -36,6 +36,32 @@ variable, given in hexadecimal.  Without the translation, a device
 reports link up and counts packets in its own registers while never
 completing a DMA.
 
+Non-cache-coherent DMA
+----------------------
+
+The PCIe bus is not cache coherent: neither ``pcie@7d500000`` nor any of
+its ancestors declares ``dma-coherent``.  A device therefore does not see
+data the CPU has only written to its caches, and the CPU does not see
+data the device has written to memory.
+
+The ``e1000`` (igb) driver handles this when it detects a
+device-tree-described device with no ``dma-coherent`` ancestor, on arm64.
+It cleans the data cache over descriptors and packet data before the tail
+register is written, and invalidates it before reading what the device
+wrote.  Because a cache line covers four descriptors, TX completion is
+taken from the hardware head register rather than the DD bits, and RX
+descriptors are refilled one whole cache line at a time.
+
+This is logged at device probe::
+
+   E1000_INIT: 0000:01:00.0: PCIe DMA is not cache coherent,
+   cleaning 64-byte D-cache lines before each DMA
+
+It can be forced on or off with ``DPDK_DMA_NONCOHERENT=1`` or ``0``.
+
+Other drivers running on this platform need equivalent handling; only
+``e1000`` implements it today.
+
 Recommended settings
 --------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 37452b2a3f..e292cc3714 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -63,6 +63,14 @@ New Features
   Broadcom BCM2711 on Raspberry Pi 4 and Compute Module 4, can reach
   system memory.
 
+* **Added non-coherent DMA support to the e1000 (igb) driver.**
+
+  The driver now performs the cache maintenance required on a PCIe bus
+  that is not cache coherent, taking TX completion from the hardware head
+  register and refilling RX descriptors a cache line at a time.  It is
+  enabled when the device is described by a device tree whose bus does not
+  declare "dma-coherent", on arm64.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index 4fda5d57a0..ee81772a0e 100644
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
@@ -42,6 +46,211 @@
 #include "base/e1000_api.h"
 #include "e1000_ethdev.h"
 
+/*
+ * Non-cache-coherent DMA support.
+ *
+ * When the PCIe host bridge is not cache coherent -- no "dma-coherent" on the
+ * device tree bus -- a bus-master read by the NIC can observe stale memory:
+ * data the CPU has just stored is not yet visible to the device.  The Linux
+ * DMA API hides this by cleaning the CPU data cache over a buffer before
+ * handing it to the device (arch_sync_dma_for_device), but DPDK writes
+ * descriptors and packet data straight into hugepage memory and rings the
+ * doorbell immediately.
+ *
+ * This was developed and tested on one such platform: a BCM2711 (Raspberry Pi
+ * Compute Module 4, 4GB, Cortex-A72, 64-byte D-cache lines) with an Intel I210
+ * on uio_pci_generic.  There the NIC fetched the previous contents of the
+ * rings -- zeroed descriptors with DD set and null buffer addresses -- so
+ * transmits never completed and received data was DMA'd to address zero.
+ * Cleaning only to the point of unification (DC CVAU) did not help; the NIC
+ * saw the CPU's stores only after a clean to the point of coherency.
+ *
+ * Mirror the kernel: clean the D-cache to the point of coherency (DC CVAC, as
+ * arm64 __dma_clean_area does) over every descriptor and packet buffer before
+ * the tail register tells the NIC it may read them, and discard cached copies
+ * (DC CIVAC, as __dma_inv_area does) of descriptor status and received data
+ * before reading what the NIC wrote.
+ *
+ * Cleaning a line writes the CPU's copy of the whole line back to RAM, so it
+ * must never cover memory the NIC may still be writing: with 4 descriptors
+ * per 64-byte line, flushing a freshly written descriptor also restored stale
+ * status for its neighbours and erased the DD bits the NIC had just set (the
+ * kernel avoids this by mapping rings non-cacheable).  Therefore, when DMA is
+ * non-coherent:
+ *  - TX completion is taken from the hardware head (TDH), not from DD bits;
+ *  - RX buffer addresses are written back one whole cache line at a time,
+ *    and only once every descriptor in that line has been handed back by the
+ *    NIC and consumed.
+ * All of this is a no-op on cache-coherent platforms and non-arm64 builds.
+ */
+#if defined(RTE_ARCH_ARM64)
+/* void igb_arm64_dcache_clean(uintptr_t start, uintptr_t end, uint64_t line) */
+void igb_arm64_dcache_clean(uintptr_t start, uintptr_t end, uint64_t line);
+/* void igb_arm64_dcache_inval(uintptr_t start, uintptr_t end, uint64_t line) */
+void igb_arm64_dcache_inval(uintptr_t start, uintptr_t end, uint64_t line);
+/* uint64_t igb_arm64_read_ctr(void) */
+uint64_t igb_arm64_read_ctr(void);
+__asm__(
+	"	.pushsection .text\n"
+	"	.p2align 2\n"
+	"	.globl igb_arm64_dcache_clean\n"
+	"	.hidden igb_arm64_dcache_clean\n"
+	"	.type igb_arm64_dcache_clean, %function\n"
+	"igb_arm64_dcache_clean:\n"
+	"	sub	x3, x2, #1\n"
+	"	bic	x0, x0, x3\n"
+	"1:	dc	cvac, x0\n"
+	"	add	x0, x0, x2\n"
+	"	cmp	x0, x1\n"
+	"	b.lo	1b\n"
+	"	ret\n"
+	"	.size igb_arm64_dcache_clean, .-igb_arm64_dcache_clean\n"
+	"	.globl igb_arm64_dcache_inval\n"
+	"	.hidden igb_arm64_dcache_inval\n"
+	"	.type igb_arm64_dcache_inval, %function\n"
+	"igb_arm64_dcache_inval:\n"
+	"	sub	x3, x2, #1\n"
+	"	bic	x0, x0, x3\n"
+	"1:	dc	civac, x0\n"
+	"	add	x0, x0, x2\n"
+	"	cmp	x0, x1\n"
+	"	b.lo	1b\n"
+	"	ret\n"
+	"	.size igb_arm64_dcache_inval, .-igb_arm64_dcache_inval\n"
+	"	.globl igb_arm64_read_ctr\n"
+	"	.hidden igb_arm64_read_ctr\n"
+	"	.type igb_arm64_read_ctr, %function\n"
+	"igb_arm64_read_ctr:\n"
+	"	mrs	x0, ctr_el0\n"
+	"	ret\n"
+	"	.size igb_arm64_read_ctr, .-igb_arm64_read_ctr\n"
+	"	.popsection\n");
+#endif
+
+#define IGB_DMA_NONCOHERENT_ENV "DPDK_DMA_NONCOHERENT"
+
+/* -1: not yet probed, 0: cache coherent, 1: needs explicit cache cleaning */
+static int igb_dma_noncoherent = -1;
+static uint64_t igb_dcache_line;
+
+/*
+ * Linux only instantiates "of_node" links for devices described by a device
+ * tree.  Walk the PCI device's sysfs ancestry (device -> bridges -> host
+ * controller -> SoC bus) the way of_dma_is_coherent() walks DT parents, and
+ * treat the device as non-coherent if it is DT-described and no ancestor
+ * declares "dma-coherent".  ACPI and x86 systems have no of_node and are left
+ * alone.
+ */
+static void
+igb_probe_dma_coherence(const char *pci_name)
+{
+	const char *env = getenv(IGB_DMA_NONCOHERENT_ENV);
+	int noncoherent = 0;
+
+	if (igb_dma_noncoherent >= 0)
+		return;
+
+	if (env != NULL && env[0] != '\0') {
+		noncoherent = atoi(env) != 0;
+	} else {
+#if defined(RTE_ARCH_ARM64)
+		char path[PATH_MAX], real[PATH_MAX], probe[PATH_MAX];
+		bool dt_described = false, coherent = false;
+		char *slash;
+
+		if (snprintf(path, sizeof(path), "/sys/bus/pci/devices/%s",
+				pci_name) < (int)sizeof(path) &&
+				realpath(path, real) != NULL) {
+			while ((slash = strrchr(real, '/')) != NULL &&
+					slash != real) {
+				if (snprintf(probe, sizeof(probe), "%s/of_node",
+						real) < (int)sizeof(probe) &&
+						access(probe, F_OK) == 0) {
+					dt_described = true;
+					if (snprintf(probe, sizeof(probe),
+							"%s/of_node/dma-coherent",
+							real) < (int)sizeof(probe) &&
+							access(probe, F_OK) == 0) {
+						coherent = true;
+						break;
+					}
+				}
+				*slash = '\0';
+			}
+		}
+		noncoherent = dt_described && !coherent;
+#else
+		RTE_SET_USED(pci_name);
+#endif
+	}
+
+#if defined(RTE_ARCH_ARM64)
+	if (noncoherent) {
+		/* CTR_EL0.DCacheLine is log2 of the line size in words. */
+		igb_dcache_line = 4ULL << ((igb_arm64_read_ctr() >> 16) & 0xf);
+		PMD_INIT_LOG(NOTICE,
+			"%s: PCIe DMA is not cache coherent, cleaning %" PRIu64
+			"-byte D-cache lines before each DMA",
+			pci_name, igb_dcache_line);
+	}
+#else
+	if (noncoherent)
+		PMD_INIT_LOG(WARNING,
+			"%s: %s set, but cache cleaning is only implemented for arm64",
+			pci_name, IGB_DMA_NONCOHERENT_ENV);
+	noncoherent = 0;
+#endif
+	igb_dma_noncoherent = noncoherent;
+}
+
+/* Make [addr, addr + len) visible to a bus-master read by the NIC. */
+static inline void
+igb_dma_sync_for_device(const volatile void *addr, size_t len)
+{
+#if defined(RTE_ARCH_ARM64)
+	if (unlikely(igb_dma_noncoherent > 0) && len != 0)
+		igb_arm64_dcache_clean((uintptr_t)addr, (uintptr_t)addr + len,
+				igb_dcache_line);
+#else
+	RTE_SET_USED(addr);
+	RTE_SET_USED(len);
+#endif
+}
+
+/*
+ * Make memory the NIC has written visible to the CPU: discard any cached copy
+ * (DC CIVAC, as arm64 __dma_inv_area does) so the next read comes from RAM.
+ */
+static inline void
+igb_dma_sync_for_cpu(const volatile void *addr, size_t len)
+{
+#if defined(RTE_ARCH_ARM64)
+	if (unlikely(igb_dma_noncoherent > 0) && len != 0)
+		igb_arm64_dcache_inval((uintptr_t)addr, (uintptr_t)addr + len,
+				igb_dcache_line);
+#else
+	RTE_SET_USED(addr);
+	RTE_SET_USED(len);
+#endif
+}
+
+/* Sync descriptors [from, to) of a ring of nb_desc entries, handling wrap. */
+static inline void
+igb_dma_sync_ring(const volatile void *ring, size_t desc_size, uint16_t nb_desc,
+		uint16_t from, uint16_t to)
+{
+	if (likely(igb_dma_noncoherent <= 0) || from == to)
+		return;
+	if (from < to) {
+		igb_dma_sync_for_device(RTE_PTR_ADD(ring, from * desc_size),
+				(to - from) * desc_size);
+	} else {
+		igb_dma_sync_for_device(RTE_PTR_ADD(ring, from * desc_size),
+				(nb_desc - from) * desc_size);
+		igb_dma_sync_for_device(ring, to * desc_size);
+	}
+}
+
 #ifdef RTE_LIBRTE_IEEE1588
 #define IGB_TX_IEEE1588_TMST RTE_MBUF_F_TX_IEEE1588_TMST
 #else
@@ -98,6 +307,11 @@ struct igb_rx_queue {
 	struct rte_mbuf *pkt_last_seg;  /**< Last segment of current packet. */
 	uint16_t            nb_rx_desc; /**< number of RX descriptors. */
 	uint16_t            rx_tail;    /**< current value of RDT register. */
+	/**
+	 * Non-coherent DMA only: first consumed descriptor whose refilled
+	 * buffer address has not been written back to the ring yet.
+	 */
+	uint16_t            rx_unwritten;
 	uint16_t            nb_rx_hold; /**< number of held free RX desc. */
 	uint16_t            rx_free_thresh; /**< max free RX desc to hold. */
 	uint16_t            queue_id;   /**< RX queue index. */
@@ -167,6 +381,7 @@ struct igb_tx_queue {
 	uint64_t               tx_ring_phys_addr; /**< TX ring DMA address. */
 	struct igb_tx_entry    *sw_ring; /**< virtual address of SW ring. */
 	volatile uint32_t      *tdt_reg_addr; /**< Address of TDT register. */
+	volatile uint32_t      *tdh_reg_addr; /**< Address of TDH register. */
 	uint32_t               txd_type;      /**< Device-specific TXD type */
 	uint16_t               nb_tx_desc;    /**< number of TX descriptors. */
 	uint16_t               tx_tail; /**< Current value of TDT register. */
@@ -384,6 +599,90 @@ tx_desc_vlan_flags_to_cmdtype(uint64_t ol_flags)
 	return cmdtype;
 }
 
+/*
+ * Non-coherent DMA: has the NIC completed descriptor desc?  The NIC owns the
+ * circular range [TDH, tx_tail); everything else has been processed.  *head
+ * caches one TDH read per burst (-1 = not read yet) and is refreshed once
+ * before reporting a descriptor as still busy.
+ */
+static inline bool
+igb_tx_desc_done(struct igb_tx_queue *txq, uint16_t desc, int32_t *head)
+{
+	uint16_t n = txq->nb_tx_desc;
+	int pass;
+
+	if (likely(igb_dma_noncoherent <= 0))
+		return (txq->tx_ring[desc].wb.status &
+			rte_cpu_to_le_32(E1000_TXD_STAT_DD)) != 0;
+
+	for (pass = 0; pass < 2; pass++) {
+		uint16_t owned, dist;
+
+		if (*head < 0 || pass > 0)
+			*head = rte_le_to_cpu_32(E1000_PCI_REG(txq->tdh_reg_addr)) % n;
+		owned = (uint16_t)((txq->tx_tail + n - *head) % n);
+		dist = (uint16_t)((desc + n - *head) % n);
+		if (dist >= owned)
+			return true;
+	}
+	return false;
+}
+
+/* Descriptors covered by one D-cache line, or 0 if lines don't tile rings. */
+static inline uint16_t
+igb_rx_desc_per_line(struct igb_rx_queue *rxq)
+{
+	uint16_t per_line = igb_dcache_line / sizeof(*rxq->rx_ring);
+
+	if (per_line <= 1 || rxq->nb_rx_desc % per_line != 0 ||
+			((uintptr_t)rxq->rx_ring & (igb_dcache_line - 1)) != 0)
+		return 1;
+	return per_line;
+}
+
+/* Write refilled buffer addresses for descriptors [from, to) and flush them. */
+static inline void
+igb_rx_write_range(struct igb_rx_queue *rxq, uint16_t from, uint16_t to)
+{
+	uint16_t i;
+
+	for (i = from; i < to; i++) {
+		volatile union e1000_adv_rx_desc *rxd = &rxq->rx_ring[i];
+
+		rxd->read.hdr_addr = 0;
+		rxd->read.pkt_addr = rte_cpu_to_le_64(
+			rte_mbuf_data_iova_default(rxq->sw_ring[i].mbuf));
+	}
+	igb_dma_sync_for_device(&rxq->rx_ring[from],
+			(to - from) * sizeof(*rxq->rx_ring));
+}
+
+/*
+ * Non-coherent DMA: write back every whole cache line of descriptors that
+ * lies entirely before the software head rx_id, i.e. that the NIC has
+ * finished with.  Returns the first descriptor still unwritten, which bounds
+ * how far RDT may advance.
+ */
+static inline uint16_t
+igb_rx_flush_refills(struct igb_rx_queue *rxq, uint16_t rx_id)
+{
+	uint16_t per_line = igb_rx_desc_per_line(rxq);
+	uint16_t start = rxq->rx_unwritten;
+	uint16_t end = rx_id - rx_id % per_line;
+
+	if (end == start)
+		return start;
+	if (end < start) {
+		/* Wrapped: finish the ring, then the aligned part from 0. */
+		igb_rx_write_range(rxq, start, rxq->nb_rx_desc);
+		start = 0;
+	}
+	if (end > start)
+		igb_rx_write_range(rxq, start, end);
+	rxq->rx_unwritten = end;
+	return end;
+}
+
 uint16_t
 eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	       uint16_t nb_pkts)
@@ -402,6 +701,7 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint16_t slen;
 	uint64_t ol_flags;
 	uint16_t tx_end;
+	int32_t hw_head = -1;
 	uint16_t tx_id;
 	uint16_t tx_last;
 	uint16_t nb_tx;
@@ -508,7 +808,7 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/*
 		 * Check that this descriptor is free.
 		 */
-		if (! (txr[tx_end].wb.status & E1000_TXD_STAT_DD)) {
+		if (!igb_tx_desc_done(txq, tx_end, &hw_head)) {
 			if (nb_tx == 0)
 				return 0;
 			goto end_of_tx;
@@ -595,6 +895,8 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 */
 			slen = (uint16_t) m_seg->data_len;
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
+			igb_dma_sync_for_device(rte_pktmbuf_mtod(m_seg, void *),
+					slen);
 			txd->read.buffer_addr =
 				rte_cpu_to_le_64(buf_dma_addr);
 			txd->read.cmd_type_len =
@@ -617,6 +919,9 @@ eth_igb_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
  end_of_tx:
 	rte_wmb();
 
+	igb_dma_sync_ring(txq->tx_ring, sizeof(*txq->tx_ring), txq->nb_tx_desc,
+			txq->tx_tail, tx_id);
+
 	/*
 	 * Set the Transmit Descriptor Tail (TDT).
 	 */
@@ -854,6 +1159,7 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 * using invalid descriptor fields when read from rxd.
 		 */
 		rxdp = &rx_ring[rx_id];
+		igb_dma_sync_for_cpu(rxdp, sizeof(*rxdp));
 		staterr = rxdp->wb.upper.status_error;
 		if (! (staterr & rte_cpu_to_le_32(E1000_RXD_STAT_DD)))
 			break;
@@ -923,8 +1229,11 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxe->mbuf = nmb;
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
-		rxdp->read.hdr_addr = 0;
-		rxdp->read.pkt_addr = dma_addr;
+		/* Non-coherent DMA defers this to igb_rx_flush_refills(). */
+		if (likely(igb_dma_noncoherent <= 0)) {
+			rxdp->read.hdr_addr = 0;
+			rxdp->read.pkt_addr = dma_addr;
+		}
 
 		/*
 		 * Initialize the returned mbuf.
@@ -942,6 +1251,8 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		pkt_len = (uint16_t) (rte_le_to_cpu_16(rxd.wb.upper.length) -
 				      rxq->crc_len);
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		igb_dma_sync_for_cpu((char *)rxm->buf_addr + rxm->data_off,
+				rte_le_to_cpu_16(rxd.wb.upper.length));
 		rte_packet_prefetch((char *)rxm->buf_addr + rxm->data_off);
 		rxm->nb_segs = 1;
 		rxm->next = NULL;
@@ -993,6 +1304,8 @@ eth_igb_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   (unsigned) rxq->port_id, (unsigned) rxq->queue_id,
 			   (unsigned) rx_id, (unsigned) nb_hold,
 			   (unsigned) nb_rx);
+		if (unlikely(igb_dma_noncoherent > 0))
+			rx_id = igb_rx_flush_refills(rxq, rx_id);
 		rx_id = (uint16_t) ((rx_id == 0) ?
 				     (rxq->nb_rx_desc - 1) : (rx_id - 1));
 		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
@@ -1049,6 +1362,7 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 * using invalid descriptor fields when read from rxd.
 		 */
 		rxdp = &rx_ring[rx_id];
+		igb_dma_sync_for_cpu(rxdp, sizeof(*rxdp));
 		staterr = rxdp->wb.upper.status_error;
 		if (! (staterr & rte_cpu_to_le_32(E1000_RXD_STAT_DD)))
 			break;
@@ -1117,8 +1431,11 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxm = rxe->mbuf;
 		rxe->mbuf = nmb;
 		dma = rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
-		rxdp->read.pkt_addr = dma;
-		rxdp->read.hdr_addr = 0;
+		/* Non-coherent DMA defers this to igb_rx_flush_refills(). */
+		if (likely(igb_dma_noncoherent <= 0)) {
+			rxdp->read.pkt_addr = dma;
+			rxdp->read.hdr_addr = 0;
+		}
 
 		/*
 		 * Set data length & data buffer address of mbuf.
@@ -1126,6 +1443,8 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		data_len = rte_le_to_cpu_16(rxd.wb.upper.length);
 		rxm->data_len = data_len;
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		igb_dma_sync_for_cpu((char *)rxm->buf_addr + rxm->data_off,
+				data_len);
 
 		/*
 		 * If this is the first buffer of the received packet,
@@ -1255,6 +1574,8 @@ eth_igb_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   (unsigned) rxq->port_id, (unsigned) rxq->queue_id,
 			   (unsigned) rx_id, (unsigned) nb_hold,
 			   (unsigned) nb_rx);
+		if (unlikely(igb_dma_noncoherent > 0))
+			rx_id = igb_rx_flush_refills(rxq, rx_id);
 		rx_id = (uint16_t) ((rx_id == 0) ?
 				     (rxq->nb_rx_desc - 1) : (rx_id - 1));
 		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
@@ -1308,18 +1629,17 @@ static int
 igb_tx_done_cleanup(struct igb_tx_queue *txq, uint32_t free_cnt)
 {
 	struct igb_tx_entry *sw_ring;
-	volatile union e1000_adv_tx_desc *txr;
 	uint16_t tx_first; /* First segment analyzed. */
 	uint16_t tx_id;    /* Current segment being processed. */
 	uint16_t tx_last;  /* Last segment in the current packet. */
 	uint16_t tx_next;  /* First segment of the next packet. */
+	int32_t hw_head = -1;
 	int count = 0;
 
 	if (!txq)
 		return -ENODEV;
 
 	sw_ring = txq->sw_ring;
-	txr = txq->tx_ring;
 
 	/* tx_tail is the last sent packet on the sw_ring. Goto the end
 	 * of that packet (the last segment in the packet chain) and
@@ -1345,8 +1665,7 @@ igb_tx_done_cleanup(struct igb_tx_queue *txq, uint32_t free_cnt)
 		tx_last = sw_ring[tx_id].last_id;
 
 		if (sw_ring[tx_last].mbuf) {
-			if (txr[tx_last].wb.status &
-			    E1000_TXD_STAT_DD) {
+			if (igb_tx_desc_done(txq, tx_last, &hw_head)) {
 				/* Increment the number of packets
 				 * freed.
 				 */
@@ -1510,6 +1829,7 @@ eth_igb_tx_queue_setup(struct rte_eth_dev *dev,
 	offloads = tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
 
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	igb_probe_dma_coherence(dev->device->name);
 
 	/*
 	 * Validate number of transmit descriptors.
@@ -1575,6 +1895,7 @@ eth_igb_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->port_id = dev->data->port_id;
 
 	txq->tdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_TDT(txq->reg_idx));
+	txq->tdh_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_TDH(txq->reg_idx));
 	txq->tx_ring_phys_addr = tz->iova;
 
 	txq->tx_ring = (union e1000_adv_tx_desc *) tz->addr;
@@ -1642,6 +1963,7 @@ igb_reset_rx_queue(struct igb_rx_queue *rxq)
 	}
 
 	rxq->rx_tail = 0;
+	rxq->rx_unwritten = 0;
 	rxq->pkt_first_seg = NULL;
 	rxq->pkt_last_seg = NULL;
 }
@@ -1710,6 +2032,7 @@ eth_igb_rx_queue_setup(struct rte_eth_dev *dev,
 	offloads = rx_conf->offloads | dev->data->dev_conf.rxmode.offloads;
 
 	hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	igb_probe_dma_coherence(dev->device->name);
 
 	/*
 	 * Validate number of receive descriptors.
@@ -1801,7 +2124,8 @@ eth_igb_rx_queue_count(void *rx_queue)
 	rxdp = &(rxq->rx_ring[rxq->rx_tail]);
 
 	while ((desc < rxq->nb_rx_desc) &&
-		(rxdp->wb.upper.status_error & E1000_RXD_STAT_DD)) {
+		(igb_dma_sync_for_cpu(rxdp, sizeof(*rxdp)),
+		 rxdp->wb.upper.status_error & E1000_RXD_STAT_DD)) {
 		desc += IGB_RXQ_SCAN_INTERVAL;
 		rxdp += IGB_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
@@ -1830,6 +2154,7 @@ eth_igb_rx_descriptor_status(void *rx_queue, uint16_t offset)
 		desc -= rxq->nb_rx_desc;
 
 	status = &rxq->rx_ring[desc].wb.upper.status_error;
+	igb_dma_sync_for_cpu(status, sizeof(*status));
 	if (*status & rte_cpu_to_le_32(E1000_RXD_STAT_DD))
 		return RTE_ETH_RX_DESC_DONE;
 
@@ -1851,8 +2176,15 @@ eth_igb_tx_descriptor_status(void *tx_queue, uint16_t offset)
 		desc -= txq->nb_tx_desc;
 
 	status = &txq->tx_ring[desc].wb.status;
-	if (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD))
+	if (unlikely(igb_dma_noncoherent > 0)) {
+		int32_t hw_head = -1;
+
+		RTE_SET_USED(status);
+		if (igb_tx_desc_done(txq, desc, &hw_head))
+			return RTE_ETH_TX_DESC_DONE;
+	} else if (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD)) {
 		return RTE_ETH_TX_DESC_DONE;
+	}
 
 	return RTE_ETH_TX_DESC_FULL;
 }
@@ -2276,6 +2608,8 @@ igb_alloc_rx_queue_mbufs(struct igb_rx_queue *rxq)
 		rxd->read.pkt_addr = dma_addr;
 		rxe[i].mbuf = mbuf;
 	}
+	igb_dma_sync_for_device(rxq->rx_ring,
+			rxq->nb_rx_desc * sizeof(*rxq->rx_ring));
 
 	return 0;
 }
-- 
2.34.1

