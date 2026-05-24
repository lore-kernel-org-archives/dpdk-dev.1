Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE61CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE4A40E18;
	Sun, 24 May 2026 11:33:36 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id BB08340A8A
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S3;
 Sun, 24 May 2026 17:33:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 01/23] net/sxe2: support AVX512 vectorized path for Rx and
 Tx
Date: Sun, 24 May 2026 17:32:37 +0800
Message-ID: <20260524093259.397506-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S3
X-Coremail-Antispam: 1UD129KBjvAXoWDJr1fWw17uw4UWr45uF4fuFg_yoWrZry7Xo
 Wxur4fXr4kXr18ZrWkWr18ZFy0qw4S934UAayS9FsxZa15GF98AasrC3W7AF17XF4FgF4D
 WayxJa9ayrZ3JrWxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYA7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
 kI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM2
 8EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r4UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04k20x
 vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
 3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIx
 AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
 cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
 IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbqYLDUUUUU==
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add AVX512 vector data path for Rx and Tx burst functions.
The decision to use AVX512 is based on:
1. CPU hardware flags (AVX512F, AVX512BW).
2. Compiler support (CC_AVX512_SUPPORT).
3. Max SIMD bitwidth configuration.

Performance shows approximately X% improvement in small packet
forwarding scenarios.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build            |  24 +
 drivers/net/sxe2/sxe2_ethdev.c          |   2 +-
 drivers/net/sxe2/sxe2_txrx.c            |  91 ++-
 drivers/net/sxe2/sxe2_txrx_vec.c        |  46 +-
 drivers/net/sxe2/sxe2_txrx_vec.h        |  18 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c | 897 ++++++++++++++++++++++++
 6 files changed, 1063 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx512.c

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 3df57aee8c..30f2c7d816 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -15,6 +15,30 @@ includes += include_directories('../../common/sxe2')
 
 if arch_subdir == 'x86'
         sources += files('sxe2_txrx_vec_sse.c')
+
+        sxe2_avx512_cpu_support =(
+                cc.get_define('__AVX512F__', args: machine_args) != '' and
+                cc.get_define('__AVX512BW__', args: machine_args) != '')
+
+        sxe2_avx512_cc_support = (
+                not machine_args.contains('-mno-avx512f') and
+                cc.has_argument('-mavx512f') and
+                cc.has_argument('-mavx512bw'))
+
+        if sxe2_avx512_cpu_support == true or sxe2_avx512_cc_support == true
+                cflags += ['-DCC_AVX512_SUPPORT']
+                avx512_args = [cflags, '-mavx512f', '-mavx512bw']
+                if cc.has_argument('-march=skylake-avx512')
+                        avx512_args += '-march=skylake-avx512'
+                endif
+                sxe2_avx512_lib = static_library('sxe2_avx512_lib', 'sxe2_txrx_vec_avx512.c',
+                        dependencies: [static_rte_ethdev,
+                        static_rte_kvargs, static_rte_hash,
+                        static_rte_security, static_rte_cryptodev, static_rte_bus_pci],
+                        include_directories: includes,
+                        c_args: avx512_args)
+                objs += sxe2_avx512_lib.extract_objects('sxe2_txrx_vec_avx512.c')
+        endif
 endif
 
 sources += files(
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 8d66e5d8c5..e0f7002138 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -891,7 +891,7 @@ static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
 static int32_t sxe2_parse_eth_devargs(struct rte_device *dev,
 			  struct rte_eth_devargs *eth_da)
 {
-	int ret = 0;
+	int32_t ret = 0;
 
 	if (dev->devargs == NULL)
 		return 0;
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index 8bd5f2eca4..ee70a2a431 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -158,6 +158,19 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 		if (ret == 0 &&
 		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 			tx_mode_flags = vec_flags;
+#ifdef RTE_ARCH_X86
+			if ((rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512) &&
+			    (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
+			    (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)) {
+#ifdef CC_AVX512_SUPPORT
+				tx_mode_flags |= SXE2_TX_MODE_VEC_AVX512;
+#else
+				PMD_LOG_INFO(TX, "AVX512 is not supported in build env.");
+#endif
+			}
+			if ((tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) == 0)
+				tx_mode_flags |= SXE2_TX_MODE_VEC_SSE;
+#endif
 			if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
 				ret = sxe2_tx_queues_vec_prepare(dev);
 				if (ret != 0)
@@ -173,7 +186,6 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 		tx_mode_flags = adapter->q_ctxt.tx_mode_flags;
 	}
 
-#ifdef RTE_ARCH_X86
 	if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
 		if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
 			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
@@ -182,6 +194,27 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 			dev->tx_pkt_prepare = NULL;
 			dev->tx_pkt_burst = sxe2_tx_pkts_vec_sse_simple;
 		}
+	}
+	if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
+		dev->tx_pkt_prepare = NULL;
+#ifdef RTE_ARCH_X86
+		if (tx_mode_flags & SXE2_TX_MODE_VEC_AVX512) {
+#ifdef CC_AVX512_SUPPORT
+			if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
+				dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_avx512;
+			} else {
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_avx512_simple;
+			}
+#endif
+		} else {
+			if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
+				dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_sse;
+			} else {
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_sse_simple;
+			}
+		}
 	} else {
 #endif
 		if (tx_mode_flags & SXE2_TX_MODE_SIMPLE_BATCH) {
@@ -202,8 +235,16 @@ static const struct {
 } sxe2_tx_burst_infos[] = {
 	{ sxe2_tx_pkts,   "Scalar" },
 #ifdef RTE_ARCH_X86
-	{ sxe2_tx_pkts_vec_sse,        "Vector SSE" },
-	{ sxe2_tx_pkts_vec_sse_simple, "Vector SSE Simple" },
+#ifdef CC_AVX512_SUPPORT
+	{ sxe2_tx_pkts_vec_avx512,
+	      "Vector AVX512" },
+	{ sxe2_tx_pkts_vec_avx512_simple,
+	      "Vector AVX512 Simple" },
+#endif
+	{ sxe2_tx_pkts_vec_sse,
+	      "Vector SSE" },
+	{ sxe2_tx_pkts_vec_sse_simple,
+	      "Vector SSE Simple" },
 #endif
 };
 
@@ -289,6 +330,20 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 		if (ret == 0 &&
 		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 			rx_mode_flags = vec_flags;
+#ifdef RTE_ARCH_X86
+			if ((rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512) &&
+				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
+				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)) {
+#ifdef CC_AVX512_SUPPORT
+				rx_mode_flags |= SXE2_RX_MODE_VEC_AVX512;
+#else
+				PMD_LOG_INFO(RX, "AVX512 support detected but not enabled");
+#endif
+			}
+			if ((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) == 0 &&
+				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)
+				rx_mode_flags |= SXE2_RX_MODE_VEC_SSE;
+#endif
 			if ((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) != 0) {
 				ret = sxe2_rx_queues_vec_prepare(dev);
 				if (ret != 0)
@@ -302,7 +357,16 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 
 #ifdef RTE_ARCH_X86
 	if (rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) {
-		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_sse_offload;
+		if (rx_mode_flags & SXE2_RX_MODE_VEC_AVX512) {
+#ifdef CC_AVX512_SUPPORT
+			if (rx_mode_flags & SXE2_RX_MODE_VEC_OFFLOAD)
+				dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_avx512_offload;
+			else
+				dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_avx512;
+#endif
+		} else {
+			dev->rx_pkt_burst = sxe2_rx_pkts_scattered_vec_sse_offload;
+		}
 		return;
 	}
 #endif
@@ -316,19 +380,30 @@ static const struct {
 	eth_rx_burst_t rx_burst;
 	const char *info;
 } sxe2_rx_burst_infos[] = {
-	{ sxe2_rx_pkts_scattered,          "Scalar Scattered" },
-	{ sxe2_rx_pkts_scattered_split,          "Scalar Scattered split" },
+	{ sxe2_rx_pkts_scattered,
+	      "Scalar Scattered" },
+	{ sxe2_rx_pkts_scattered_split,
+	      "Scalar Scattered split" },
 #ifdef RTE_ARCH_X86
-	{ sxe2_rx_pkts_scattered_vec_sse_offload,      "Vector SSE Scattered" },
+#ifdef CC_AVX512_SUPPORT
+	{ sxe2_rx_pkts_scattered_vec_avx512,
+	      "Vector AVX512 Scattered" },
+	{ sxe2_rx_pkts_scattered_vec_avx512_offload,
+	      "Offload Vector AVX512 Scattered" },
+#endif
+	{ sxe2_rx_pkts_scattered_vec_sse_offload,
+	      "Vector SSE Scattered" },
 #endif
 };
 
 int32_t sxe2_rx_burst_mode_get(struct rte_eth_dev *dev,
-			__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode)
+			       __rte_unused uint16_t queue_id,
+			       struct rte_eth_burst_mode *mode)
 {
 	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
 	int32_t ret = -EINVAL;
 	uint32_t i, size;
+
 	size = RTE_DIM(sxe2_rx_burst_infos);
 	for (i = 0; i < size; ++i) {
 		if (pkt_burst == sxe2_rx_burst_infos[i].rx_burst) {
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.c b/drivers/net/sxe2/sxe2_txrx_vec.c
index 8df4954d86..cf004f5eb2 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -165,16 +165,54 @@ static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq)
 		return;
 	}
 	i = txq->next_dd - (txq->rs_thresh - 1);
-	buffer = txq->buffer_ring;
-	if (txq->next_use < i) {
-		for ( ; i < txq->ring_depth; ++i) {
+#ifdef CC_AVX512_SUPPORT
+	struct rte_eth_dev *dev;
+	struct sxe2_tx_buffer_vec *buffer_vec;
+
+	dev = &rte_eth_devices[txq->port_id];
+
+	if (dev->tx_pkt_burst == sxe2_tx_pkts_vec_avx512 ||
+		dev->tx_pkt_burst == sxe2_tx_pkts_vec_avx512_simple) {
+		buffer_vec = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
+
+		if (txq->next_use < i) {
+			for ( ; i < txq->ring_depth; ++i) {
+				if (buffer_vec[i].mbuf != NULL) {
+					rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+					buffer_vec[i].mbuf = NULL;
+				}
+			}
+			i = 0;
+		}
+		for ( ; i < txq->next_use; ++i) {
+			if (buffer_vec[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+				buffer_vec[i].mbuf = NULL;
+			}
+		}
+	} else {
+#endif
+		buffer = txq->buffer_ring;
+		buffer = txq->buffer_ring;
+		if (txq->next_use < i) {
+			for ( ; i < txq->ring_depth; ++i) {
+				if (buffer[i].mbuf != NULL) {
+					rte_pktmbuf_free_seg(buffer[i].mbuf);
+					buffer[i].mbuf = NULL;
+				}
+			}
+			i = 0;
+		}
+		for (; i < txq->next_use; ++i) {
 			if (buffer[i].mbuf != NULL) {
 				rte_pktmbuf_free_seg(buffer[i].mbuf);
 				buffer[i].mbuf = NULL;
 			}
 		}
-		i = 0;
+#ifdef CC_AVX512_SUPPORT
 	}
+#endif
+
 	for (; i < txq->next_use; ++i) {
 		if (buffer[i].mbuf != NULL) {
 			rte_pktmbuf_free_seg(buffer[i].mbuf);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.h b/drivers/net/sxe2/sxe2_txrx_vec.h
index 4aef93d140..62a5b1f3f5 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec.h
@@ -10,15 +10,19 @@
 #define SXE2_RX_MODE_VEC_SIMPLE    RTE_BIT32(0)
 #define SXE2_RX_MODE_VEC_OFFLOAD   RTE_BIT32(1)
 #define SXE2_RX_MODE_VEC_SSE       RTE_BIT32(2)
+#define SXE2_RX_MODE_VEC_AVX512    RTE_BIT32(4)
 #define SXE2_RX_MODE_BATCH_ALLOC   RTE_BIT32(10)
 #define SXE2_RX_MODE_VEC_SET_MASK	(SXE2_RX_MODE_VEC_SIMPLE | \
-			SXE2_RX_MODE_VEC_OFFLOAD | SXE2_RX_MODE_VEC_SSE)
+			SXE2_RX_MODE_VEC_OFFLOAD | SXE2_RX_MODE_VEC_SSE | \
+			SXE2_RX_MODE_VEC_AVX512)
 #define SXE2_TX_MODE_VEC_SIMPLE   RTE_BIT32(0)
 #define SXE2_TX_MODE_VEC_OFFLOAD  RTE_BIT32(1)
 #define SXE2_TX_MODE_VEC_SSE      RTE_BIT32(2)
+#define SXE2_TX_MODE_VEC_AVX512   RTE_BIT32(4)
 #define SXE2_TX_MODE_SIMPLE_BATCH RTE_BIT32(10)
 #define SXE2_TX_MODE_VEC_SET_MASK	(SXE2_TX_MODE_VEC_SIMPLE | \
-			SXE2_TX_MODE_VEC_OFFLOAD | SXE2_TX_MODE_VEC_SSE)
+			SXE2_TX_MODE_VEC_OFFLOAD | SXE2_TX_MODE_VEC_SSE | \
+			SXE2_TX_MODE_VEC_AVX512)
 #define SXE2_TX_VEC_NO_SUPPORT_OFFLOAD (		  \
 			RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		  \
 			RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	  \
@@ -53,6 +57,16 @@ uint16_t sxe2_tx_pkts_vec_sse(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_
 uint16_t sxe2_tx_pkts_vec_sse_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t sxe2_rx_pkts_scattered_vec_sse_offload(void *rx_queue,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t sxe2_tx_pkts_vec_avx512_simple(void *tx_queue,
+		struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t sxe2_tx_pkts_vec_avx512(void *tx_queue,
+		struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t sxe2_tx_pkts_vec_avx512_ctx_offload(void *tx_queue,
+		struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t sxe2_rx_pkts_scattered_vec_avx512(void *rx_queue,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t sxe2_rx_pkts_scattered_vec_avx512_offload(void *rx_queue,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 #endif
 int32_t __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags);
 int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
new file mode 100644
index 0000000000..2aec8037dd
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
@@ -0,0 +1,897 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_TEST
+#include <rte_vect.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_queue.h"
+#include "sxe2_txrx_vec.h"
+#include "sxe2_txrx_vec_common.h"
+#include "sxe2_vsi.h"
+
+static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_queue *txq)
+{
+	struct sxe2_tx_buffer_vec *buffer;
+	struct rte_mbuf *mbuf;
+	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
+	struct rte_mempool *mp;
+	struct rte_mempool_cache *cache;
+	void **cache_objs;
+	uint32_t copied;
+	uint32_t i;
+	int32_t ret;
+	uint16_t rs_thresh;
+	uint16_t free_num;
+
+	if (rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE) !=
+		(txq->desc_ring[txq->next_dd].wb.dd &
+			rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_MASK))) {
+		ret = 0;
+		goto l_end;
+	}
+
+	rs_thresh = txq->rs_thresh;
+
+	buffer = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
+	buffer += txq->next_dd - (rs_thresh - 1);
+
+	if ((txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
+			(rs_thresh & 31) == 0) {
+		mp = buffer[0].mbuf->pool;
+		cache = rte_mempool_default_cache(mp, rte_lcore_id());
+
+		if (cache == NULL || cache->len)
+			goto normal;
+
+		if (rs_thresh > RTE_MEMPOOL_CACHE_MAX_SIZE) {
+			(void)rte_mempool_ops_enqueue_bulk(mp, (void *)buffer, rs_thresh);
+			goto done;
+		}
+		cache_objs = &cache->objs[cache->len];
+
+		copied = 0;
+		while (copied < rs_thresh) {
+			const __m512i objs0 = _mm512_loadu_si512(&buffer[copied]);
+			const __m512i objs1 = _mm512_loadu_si512(&buffer[copied + 8]);
+			const __m512i objs2 = _mm512_loadu_si512(&buffer[copied + 16]);
+			const __m512i objs3 = _mm512_loadu_si512(&buffer[copied + 24]);
+
+			_mm512_storeu_si512(&cache_objs[copied], objs0);
+			_mm512_storeu_si512(&cache_objs[copied + 8], objs1);
+			_mm512_storeu_si512(&cache_objs[copied + 16], objs2);
+			_mm512_storeu_si512(&cache_objs[copied + 24], objs3);
+			copied += 32;
+		}
+		cache->len += rs_thresh;
+
+		if (cache->len >= cache->flushthresh) {
+			(void)rte_mempool_ops_enqueue_bulk(mp,
+					&cache->objs[cache->size], cache->len - cache->size);
+			cache->len = cache->size;
+		}
+		goto done;
+	}
+
+normal:
+	mbuf = rte_pktmbuf_prefree_seg(buffer[0].mbuf);
+
+	if (likely(mbuf)) {
+		mbuf_free_arr[0] = mbuf;
+		free_num = 1;
+
+		for (i = 1; i < rs_thresh; ++i) {
+			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
+
+			if (likely(mbuf)) {
+				if (likely(mbuf->pool == mbuf_free_arr[0]->pool)) {
+					mbuf_free_arr[free_num] = mbuf;
+					free_num++;
+				} else {
+					rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
+						(void *)mbuf_free_arr, free_num);
+
+				mbuf_free_arr[0] = mbuf;
+				free_num = 1;
+			}
+			}
+		}
+
+		rte_mempool_put_bulk(mbuf_free_arr[0]->pool,
+						(void *)mbuf_free_arr, free_num);
+	} else {
+		for (i = 1; i < rs_thresh; ++i) {
+			mbuf = rte_pktmbuf_prefree_seg(buffer[i].mbuf);
+			if (mbuf != NULL)
+				rte_mempool_put(mbuf->pool, mbuf);
+		}
+	}
+
+done:
+	txq->desc_free_num += txq->rs_thresh;
+	txq->next_dd       += txq->rs_thresh;
+	if (txq->next_dd >= txq->ring_depth)
+		txq->next_dd = txq->rs_thresh - 1;
+	ret = rs_thresh;
+
+l_end:
+	return ret;
+}
+
+static __rte_always_inline void
+sxe2_tx_desc_fill_one_avx512(volatile union sxe2_tx_data_desc *desc, struct rte_mbuf *pkt,
+	uint64_t desc_cmd, bool with_offloads)
+{
+	__m128i data_desc;
+	uint64_t desc_qw1;
+	uint32_t desc_offset;
+
+	desc_qw1 = (SXE2_TX_DESC_DTYPE_DATA |
+				((uint64_t)desc_cmd) << SXE2_TX_DATA_DESC_CMD_SHIFT |
+				((uint64_t)pkt->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT);
+	desc_offset = SXE2_TX_DATA_DESC_MACLEN_VAL(pkt->l2_len);
+	desc_qw1 |= ((uint64_t)desc_offset) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+	if (with_offloads)
+		sxe2_tx_desc_fill_offloads(pkt, &desc_qw1);
+
+	data_desc = _mm_set_epi64x(desc_qw1, rte_pktmbuf_iova(pkt));
+
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, desc), data_desc);
+}
+
+static __rte_always_inline
+void sxe2_tx_desc_fill_avx512(volatile union sxe2_tx_data_desc *desc, struct rte_mbuf **pkts,
+	uint16_t pkts_num, uint64_t desc_cmd, bool with_offloads)
+{
+	__m512i desc_group;
+	uint64_t desc0_qw1;
+	uint64_t desc1_qw1;
+	uint64_t desc2_qw1;
+	uint64_t desc3_qw1;
+
+	const uint64_t desc_qw1_com = (SXE2_TX_DESC_DTYPE_DATA |
+					((uint64_t)desc_cmd) << SXE2_TX_DATA_DESC_CMD_SHIFT);
+	uint32_t desc_offset[4] = {0};
+
+	while (pkts_num > 3) {
+		desc3_qw1 = desc_qw1_com |
+				((uint64_t)pkts[3]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT;
+
+		desc_offset[3] = SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[3]->l2_len);
+		desc3_qw1 |= ((uint64_t)desc_offset[3]) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+		if (with_offloads)
+			sxe2_tx_desc_fill_offloads(pkts[3], &desc3_qw1);
+
+		desc2_qw1 = desc_qw1_com |
+				((uint64_t)pkts[2]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT;
+		desc_offset[2] = SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[2]->l2_len);
+		desc2_qw1 |= ((uint64_t)desc_offset[2]) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+		if (with_offloads)
+			sxe2_tx_desc_fill_offloads(pkts[2], &desc2_qw1);
+
+		desc1_qw1 = (desc_qw1_com |
+				((uint64_t)pkts[1]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT);
+		desc_offset[1] = SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[1]->l2_len);
+		desc1_qw1 |= ((uint64_t)desc_offset[1]) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+		if (with_offloads)
+			sxe2_tx_desc_fill_offloads(pkts[1], &desc1_qw1);
+
+		desc0_qw1 = (desc_qw1_com |
+				((uint64_t)pkts[0]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT);
+		desc_offset[0] = SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[0]->l2_len);
+		desc0_qw1 |= ((uint64_t)desc_offset[0]) << SXE2_TX_DATA_DESC_OFFSET_SHIFT;
+		if (with_offloads)
+			sxe2_tx_desc_fill_offloads(pkts[0], &desc0_qw1);
+
+		desc_group =
+			_mm512_set_epi64(desc3_qw1, rte_pktmbuf_iova(pkts[3]),
+					 desc2_qw1, rte_pktmbuf_iova(pkts[2]),
+					 desc1_qw1, rte_pktmbuf_iova(pkts[1]),
+					 desc0_qw1, rte_pktmbuf_iova(pkts[0]));
+
+		_mm512_storeu_si512(RTE_CAST_PTR(void *, desc), desc_group);
+
+		pkts_num -= 4;
+		desc     += 4;
+		pkts     += 4;
+	}
+
+	while (pkts_num) {
+		sxe2_tx_desc_fill_one_avx512(desc, *pkts, desc_cmd, with_offloads);
+
+		pkts_num--;
+		desc++;
+		pkts++;
+	}
+}
+
+static __rte_always_inline void
+sxe2_tx_pkts_mbuf_fill_avx512(struct sxe2_tx_buffer_vec *buffer,
+	struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	uint16_t i;
+
+	for (i = 0; i < nb_pkts; ++i)
+		buffer[i].mbuf = tx_pkts[i];
+}
+
+static __rte_always_inline uint16_t
+sxe2_tx_pkts_vec_avx512_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
+	uint16_t nb_pkts, bool with_offloads)
+{
+	volatile union sxe2_tx_data_desc *desc;
+	struct sxe2_tx_buffer_vec *buffer;
+	uint16_t next_use;
+	uint16_t res_num;
+	uint16_t tx_num;
+
+	if (txq->desc_free_num < txq->free_thresh)
+		(void)sxe2_tx_bufs_free_vec_avx512(txq);
+
+	nb_pkts = RTE_MIN(txq->desc_free_num, nb_pkts);
+	if (unlikely(nb_pkts == 0)) {
+		PMD_LOG_DEBUG(TX, "Tx pkts avx512 batch: may not enough free desc, "
+				"free_desc=%u, need_tx_pkts=%u",
+				txq->desc_free_num, nb_pkts);
+		goto l_end;
+	}
+	tx_num = nb_pkts;
+
+	next_use = txq->next_use;
+	desc     = &txq->desc_ring[next_use];
+	buffer   = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
+	buffer  += next_use;
+
+	txq->desc_free_num -= nb_pkts;
+
+	res_num = txq->ring_depth - txq->next_use;
+
+	if (tx_num >= res_num) {
+		sxe2_tx_pkts_mbuf_fill_avx512(buffer, tx_pkts, res_num);
+
+		sxe2_tx_desc_fill_avx512(desc, tx_pkts, res_num,
+					SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+		tx_pkts += (res_num - 1);
+		desc    += (res_num - 1);
+
+		sxe2_tx_desc_fill_one_avx512(desc, *tx_pkts++,
+					(SXE2_TX_DATA_DESC_CMD_EOP | SXE2_TX_DATA_DESC_CMD_RS),
+					with_offloads);
+
+		tx_num -= res_num;
+
+		next_use     = 0;
+		txq->next_rs = txq->rs_thresh - 1;
+		desc         = txq->desc_ring;
+		buffer       = (struct sxe2_tx_buffer_vec *)txq->buffer_ring;
+	}
+
+	sxe2_tx_pkts_mbuf_fill_avx512(buffer, tx_pkts, tx_num);
+
+	sxe2_tx_desc_fill_avx512(desc, tx_pkts, tx_num,
+			SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+
+	next_use += tx_num;
+	if (next_use > txq->next_rs) {
+		txq->desc_ring[txq->next_rs].read.type_cmd_off_bsz_l2t |=
+			rte_cpu_to_le_64(SXE2_TX_DATA_DESC_CMD_RS_MASK);
+
+		txq->next_rs += txq->rs_thresh;
+	}
+	txq->next_use = next_use;
+
+	SXE2_PCI_REG_WRITE_WC(txq->tdt_reg_addr, next_use);
+	PMD_LOG_DEBUG(TX, "port_id=%u queue_id=%u next_use=%u send_pkts=%u",
+			txq->port_id, txq->queue_id, next_use, nb_pkts);
+l_end:
+	return nb_pkts;
+}
+
+static __rte_always_inline uint16_t
+sxe2_tx_pkts_vec_avx512_common(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
+	uint16_t nb_pkts, bool with_offloads)
+{
+	uint16_t tx_done_num = 0;
+	uint16_t tx_once_num;
+	uint16_t tx_need_num;
+
+	while (nb_pkts) {
+		tx_need_num = RTE_MIN(nb_pkts, txq->rs_thresh);
+		tx_once_num =
+			sxe2_tx_pkts_vec_avx512_batch(txq, tx_pkts + tx_done_num,
+					     tx_need_num, with_offloads);
+		nb_pkts     -= tx_once_num;
+		tx_done_num += tx_once_num;
+		if (tx_once_num < tx_need_num)
+			break;
+	}
+
+	return tx_done_num;
+}
+
+uint16_t sxe2_tx_pkts_vec_avx512_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return sxe2_tx_pkts_vec_avx512_common((struct sxe2_tx_queue *)tx_queue,
+					      tx_pkts, nb_pkts, false);
+}
+
+uint16_t sxe2_tx_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return sxe2_tx_pkts_vec_avx512_common((struct sxe2_tx_queue *)tx_queue,
+					      tx_pkts, nb_pkts, true);
+}
+
+static inline void sxe2_rx_queue_rearm_avx512(struct sxe2_rx_queue *rxq)
+{
+	volatile union sxe2_rx_desc *desc;
+	struct rte_mbuf **buffer;
+	struct rte_mbuf *mbuf0, *mbuf1;
+	__m128i dma_addr0, dma_addr1;
+	__m128i virt_addr0, virt_addr1;
+	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
+	int32_t ret;
+	uint16_t i;
+	uint16_t new_tail;
+
+	buffer = &rxq->buffer_ring[rxq->realloc_start];
+	desc   = &rxq->desc_ring[rxq->realloc_start];
+
+	ret = rte_mempool_get_bulk(rxq->mb_pool, (void *)buffer, SXE2_RX_REARM_THRESH_VEC);
+	if (ret != 0) {
+		if ((rxq->realloc_num + SXE2_RX_REARM_THRESH_VEC) >= rxq->ring_depth) {
+			dma_addr0 = _mm_setzero_si128();
+			for (i = 0; i < SXE2_RX_NUM_PER_LOOP_AVX; ++i) {
+				buffer[i] = &rxq->fake_mbuf;
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc[i].read),
+						dma_addr0);
+			}
+		}
+
+		rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed +=
+			SXE2_RX_REARM_THRESH_VEC;
+		goto l_end;
+	}
+
+	for (i = 0; i < SXE2_RX_REARM_THRESH_VEC; i += 2, buffer += 2) {
+		mbuf0 = buffer[0];
+		mbuf1 = buffer[1];
+
+#if RTE_IOVA_IN_MBUF
+
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				 offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		virt_addr0 = _mm_loadu_si128((__m128i *)&mbuf0->buf_addr);
+		virt_addr1 = _mm_loadu_si128((__m128i *)&mbuf1->buf_addr);
+
+#if RTE_IOVA_IN_MBUF
+
+		dma_addr0 = _mm_unpackhi_epi64(virt_addr0, virt_addr0);
+		dma_addr1 = _mm_unpackhi_epi64(virt_addr1, virt_addr1);
+#else
+
+		dma_addr0 = _mm_unpacklo_epi64(virt_addr0, virt_addr0);
+		dma_addr1 = _mm_unpacklo_epi64(virt_addr1, virt_addr1);
+#endif
+
+		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
+		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
+
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc++->read), dma_addr0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &desc++->read), dma_addr1);
+	}
+
+	rxq->realloc_start += SXE2_RX_REARM_THRESH_VEC;
+	if (rxq->realloc_start >= rxq->ring_depth)
+		rxq->realloc_start = 0;
+	rxq->realloc_num -= SXE2_RX_REARM_THRESH_VEC;
+
+	new_tail = (rxq->realloc_start == 0) ? (rxq->ring_depth - 1) :
+		(rxq->realloc_start - 1);
+
+	SXE2_PCI_REG_WRITE_WC(rxq->rdt_reg_addr, new_tail);
+
+l_end:
+	return;
+}
+
+static __rte_always_inline uint16_t
+sxe2_rx_pkts_common_vec_avx512(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+	uint16_t nb_pkts, uint8_t *split_rxe_flags,
+	uint8_t *umbcast_flags, bool do_offload)
+{
+	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, rxq->mbuf_init_value);
+	struct rte_mbuf **buffer;
+	volatile union sxe2_rx_desc *desc;
+	__m512i mbufs4_7;
+	__m512i mbufs0_3;
+	__m256i mbufs6_7;
+	__m256i mbufs4_5;
+	__m256i mbufs2_3;
+	__m256i mbufs0_1;
+	uint32_t bit_num  = 0;
+	uint16_t done_num = 0;
+	uint16_t i = 0;
+	uint16_t j = 0;
+
+	buffer   = &rxq->buffer_ring[rxq->processing_idx];
+	desc     = &rxq->desc_ring[rxq->processing_idx];
+
+	rte_prefetch0(desc);
+
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, SXE2_RX_NUM_PER_LOOP_AVX);
+
+	if (rxq->realloc_num > SXE2_RX_REARM_THRESH_VEC)
+		sxe2_rx_queue_rearm_avx512(rxq);
+
+	if (0 == (rte_le_to_cpu_64(desc->wb.status_err_ptype_len) & SXE2_RX_DESC_STATUS_DD_MASK))
+		goto l_end;
+
+	const __m512i crc_adjust =
+			_mm512_set4_epi32(0, -rxq->crc_len, -rxq->crc_len, 0);
+
+	const __m256i dd_mask = _mm256_set1_epi32(1);
+
+	const __m512i rvp_shuf_mask =
+			_mm512_set4_epi32((7 << 24) | (6 << 16) | (5 << 8) | 4,
+					  (3 << 24) | (2 << 16) | (13 << 8) | 12,
+					  (0xFFU << 24) | (0xFF << 16) | (13 << 8) | 12,
+					  0xFFFFFFFF);
+
+	const __m128i eop_shuf_mask =
+		_mm_set_epi8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+			     0xFF, 0xFF, 8, 0, 10, 2, 12, 4, 14, 6);
+
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
+
+	for (i = 0; i < nb_pkts; i += SXE2_RX_NUM_PER_LOOP_AVX,
+				desc += SXE2_RX_NUM_PER_LOOP_AVX) {
+		_mm256_storeu_si256((void *)&rx_pkts[i],
+			_mm256_loadu_si256((void *)&buffer[i]));
+#ifdef RTE_ARCH_X86_64
+		_mm256_storeu_si256((void *)&rx_pkts[i + 4],
+			_mm256_loadu_si256((void *)&buffer[i + 4]));
+#endif
+
+		const __m128i desc7 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 7));
+		rte_compiler_barrier();
+		const __m128i desc6 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 6));
+		rte_compiler_barrier();
+		const __m128i desc5 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 5));
+		rte_compiler_barrier();
+		const __m128i desc4 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 4));
+		rte_compiler_barrier();
+		const __m128i desc3 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 3));
+		rte_compiler_barrier();
+		const __m128i desc2 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 2));
+		rte_compiler_barrier();
+		const __m128i desc1 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 1));
+		rte_compiler_barrier();
+		const __m128i desc0 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, desc + 0));
+
+		const __m256i descs6_7 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(desc6), desc7, 1);
+		const __m256i descs4_5 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(desc4), desc5, 1);
+		const __m256i descs2_3 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(desc2), desc3, 1);
+		const __m256i descs0_1 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(desc0), desc1, 1);
+
+		const __m512i descs4_7 =
+			_mm512_inserti64x4(_mm512_castsi256_si512(descs4_5), descs6_7, 1);
+		const __m512i descs0_3 =
+			_mm512_inserti64x4(_mm512_castsi256_si512(descs0_1), descs2_3, 1);
+
+		if (split_rxe_flags != NULL) {
+			for (j = 0; j < SXE2_RX_NUM_PER_LOOP_AVX; j++)
+				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
+		}
+
+		mbufs4_7 = _mm512_shuffle_epi8(descs4_7, rvp_shuf_mask);
+		mbufs0_3 = _mm512_shuffle_epi8(descs0_3, rvp_shuf_mask);
+
+		mbufs4_7 = _mm512_add_epi32(mbufs4_7, crc_adjust);
+		mbufs0_3 = _mm512_add_epi32(mbufs0_3, crc_adjust);
+
+		const __m512i ptype_mask = _mm512_set1_epi64(SXE2_RX_FLEX_DESC_PTYPE_M <<
+					SXE2_RX_FLEX_DESC_PTYPE_S);
+
+		__m512i ptypes4_7 = _mm512_and_si512(descs4_7, ptype_mask);
+		__m512i ptypes0_3 = _mm512_and_si512(descs0_3, ptype_mask);
+
+		const __m256i ptypes6_7 = _mm512_extracti64x4_epi64(ptypes4_7, 1);
+		const __m256i ptypes4_5 = _mm512_extracti64x4_epi64(ptypes4_7, 0);
+		const __m256i ptypes2_3 = _mm512_extracti64x4_epi64(ptypes0_3, 1);
+		const __m256i ptypes0_1 = _mm512_extracti64x4_epi64(ptypes0_3, 0);
+
+		const uint16_t ptype7 = _mm256_extract_epi16(ptypes6_7, 13);
+		const uint16_t ptype6 = _mm256_extract_epi16(ptypes6_7, 5);
+		const uint16_t ptype5 = _mm256_extract_epi16(ptypes4_5, 13);
+		const uint16_t ptype4 = _mm256_extract_epi16(ptypes4_5, 5);
+		const uint16_t ptype3 = _mm256_extract_epi16(ptypes2_3, 13);
+		const uint16_t ptype2 = _mm256_extract_epi16(ptypes2_3, 5);
+		const uint16_t ptype1 = _mm256_extract_epi16(ptypes0_1, 13);
+		const uint16_t ptype0 = _mm256_extract_epi16(ptypes0_1, 5);
+
+		const __m512i ptype_mask4_7 =
+				_mm512_set_epi32(0, 0, 0, ptype_tbl[ptype7],
+						 0, 0, 0, ptype_tbl[ptype6],
+						 0, 0, 0, ptype_tbl[ptype5],
+						 0, 0, 0, ptype_tbl[ptype4]);
+		const __m512i ptype_mask0_3 =
+				_mm512_set_epi32(0, 0, 0, ptype_tbl[ptype3],
+						 0, 0, 0, ptype_tbl[ptype2],
+						 0, 0, 0, ptype_tbl[ptype1],
+						 0, 0, 0, ptype_tbl[ptype0]);
+
+		mbufs4_7 = _mm512_or_si512(mbufs4_7, ptype_mask4_7);
+		mbufs0_3 = _mm512_or_si512(mbufs0_3, ptype_mask0_3);
+
+		mbufs6_7 = _mm512_extracti64x4_epi64(mbufs4_7, 1);
+		mbufs4_5 = _mm512_extracti64x4_epi64(mbufs4_7, 0);
+		mbufs2_3 = _mm512_extracti64x4_epi64(mbufs0_3, 1);
+		mbufs0_1 = _mm512_extracti64x4_epi64(mbufs0_3, 0);
+
+		const __m512i staterr_per_mask =
+			_mm512_set_epi32(0x17, 0x1F, 0x07, 0x0F,
+					 0x13, 0x1B, 0x03, 0x0B,
+					 0x16, 0x1E, 0x06, 0x0E,
+					 0x12, 0x1A, 0x02, 0x0A);
+		__m512i qw1_0_7 = _mm512_permutex2var_epi32(descs4_7,
+							    staterr_per_mask,
+							    descs0_3);
+
+		__m256i staterrs0_7 = _mm512_extracti64x4_epi64(qw1_0_7, 0);
+
+		__m256i stu_len0_7 = _mm512_extracti64x4_epi64(qw1_0_7, 1);
+		__m256i mbuf_flags = _mm256_setzero_si256();
+
+		if (do_offload) {
+			const __m256i desc_flags_mask = _mm256_set1_epi32(0xC0001C04);
+			const __m256i desc_flags_rss_mask = _mm256_set1_epi32(0x20000000);
+			const __m256i vlan_flags =
+				_mm256_set_epi8(0, 0, 0, 0,
+					0, 0, 0, 0,
+					0, 0, 0, RTE_MBUF_F_RX_VLAN |
+						RTE_MBUF_F_RX_VLAN_STRIPPED,
+					0, 0, 0, 0,
+					0, 0, 0, 0,
+					0, 0, 0, 0,
+					0, 0, 0, RTE_MBUF_F_RX_VLAN |
+						RTE_MBUF_F_RX_VLAN_STRIPPED,
+					0, 0, 0, 0);
+
+			const __m256i rss_flags =
+				_mm256_set_epi8(0, 0, 0, 0,
+					0, 0, 0, 0,
+					0, 0, 0, RTE_MBUF_F_RX_RSS_HASH,
+					0, 0, 0, 0,
+					0, 0, 0, 0,
+					0, 0, 0, 0,
+					0, 0, 0, RTE_MBUF_F_RX_RSS_HASH,
+					0, 0, 0, 0);
+
+			const __m256i cksum_flags =
+			_mm256_set_epi8(0, 0, 0, 0, 0, 0, 0,
+			0,
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+				RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+				RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+				RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+				RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			0, 0, 0, 0, 0, 0, 0, 0,
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+				RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+				RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+				RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+				RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1),
+			((RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1));
+
+			const __m256i cksum_mask =
+				_mm256_set1_epi32(RTE_MBUF_F_RX_IP_CKSUM_MASK |
+						  RTE_MBUF_F_RX_L4_CKSUM_MASK |
+						  RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
+						  RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD);
+
+			const __m256i vlan_mask =
+				_mm256_set1_epi32(RTE_MBUF_F_RX_VLAN |
+						  RTE_MBUF_F_RX_VLAN_STRIPPED);
+
+			__m256i tmp_flags;
+			__m256i descs_flags = _mm256_and_si256(staterrs0_7, desc_flags_mask);
+			stu_len0_7 = _mm256_and_si256(stu_len0_7, desc_flags_rss_mask);
+
+			tmp_flags = _mm256_shuffle_epi8(vlan_flags, descs_flags);
+			mbuf_flags = _mm256_and_si256(tmp_flags, vlan_mask);
+
+			descs_flags = _mm256_srli_epi32(descs_flags, 10);
+			tmp_flags   = _mm256_shuffle_epi8(cksum_flags, descs_flags);
+			tmp_flags   = _mm256_slli_epi32(tmp_flags, 1);
+			tmp_flags   = _mm256_and_si256(tmp_flags, cksum_mask);
+			mbuf_flags  = _mm256_or_si256(mbuf_flags, tmp_flags);
+
+			descs_flags = _mm256_srli_epi32(stu_len0_7, 27);
+			tmp_flags   = _mm256_shuffle_epi8(rss_flags, descs_flags);
+			mbuf_flags  = _mm256_or_si256(mbuf_flags, tmp_flags);
+
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+			if (rxq->fnav_enable) {
+				__m256i fnav_vld0_3, fnav_vld4_7;
+				__m256i fnav_vld0_7;
+				__m256i v_zeros, v_ffff, v_u32_one;
+				const __m256i fdir_flags =
+					_mm256_set1_epi32(RTE_MBUF_F_RX_FDIR |
+							  RTE_MBUF_F_RX_FDIR_ID);
+				fnav_vld0_3 = _mm256_unpacklo_epi32(descs2_3, descs0_1);
+				fnav_vld4_7 = _mm256_unpacklo_epi32(descs6_7, descs4_5);
+
+				fnav_vld0_7 = _mm256_unpacklo_epi64(fnav_vld4_7, fnav_vld0_3);
+
+				fnav_vld0_7 = _mm256_slli_epi32(fnav_vld0_7, 26);
+				fnav_vld0_7 = _mm256_srli_epi32(fnav_vld0_7, 31);
+
+				v_zeros = _mm256_setzero_si256();
+				v_ffff = _mm256_cmpeq_epi32(v_zeros, v_zeros);
+				v_u32_one = _mm256_srli_epi32(v_ffff, 31);
+
+				tmp_flags = _mm256_cmpeq_epi32(fnav_vld0_7, v_u32_one);
+
+				tmp_flags = _mm256_and_si256(tmp_flags, fdir_flags);
+
+				mbuf_flags = _mm256_or_si256(mbuf_flags, tmp_flags);
+
+				rx_pkts[i + 0]->hash.fdir.hi = desc[0].wb.fd_filter_id;
+				rx_pkts[i + 1]->hash.fdir.hi = desc[1].wb.fd_filter_id;
+				rx_pkts[i + 2]->hash.fdir.hi = desc[2].wb.fd_filter_id;
+				rx_pkts[i + 3]->hash.fdir.hi = desc[3].wb.fd_filter_id;
+				rx_pkts[i + 4]->hash.fdir.hi = desc[4].wb.fd_filter_id;
+				rx_pkts[i + 5]->hash.fdir.hi = desc[5].wb.fd_filter_id;
+				rx_pkts[i + 6]->hash.fdir.hi = desc[6].wb.fd_filter_id;
+				rx_pkts[i + 7]->hash.fdir.hi = desc[7].wb.fd_filter_id;
+			}
+#endif
+		}
+
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
+				offsetof(struct rte_mbuf, rearm_data) + 8);
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rx_descriptor_fields1) !=
+				offsetof(struct rte_mbuf, rearm_data) + 16);
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
+				RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
+
+		__m256i rearm_arr[8];
+
+		rearm_arr[6] = _mm256_blend_epi32(mbuf_init,
+					_mm256_slli_si256(mbuf_flags, 8), 0x04);
+		rearm_arr[4] = _mm256_blend_epi32(mbuf_init,
+					_mm256_slli_si256(mbuf_flags, 4), 0x04);
+		rearm_arr[2] = _mm256_blend_epi32(mbuf_init, mbuf_flags, 0x04);
+		rearm_arr[0] = _mm256_blend_epi32(mbuf_init,
+					_mm256_srli_si256(mbuf_flags, 4), 0x04);
+
+		rearm_arr[6] = _mm256_permute2f128_si256(rearm_arr[6], mbufs6_7, 0x20);
+		rearm_arr[4] = _mm256_permute2f128_si256(rearm_arr[4], mbufs4_5, 0x20);
+		rearm_arr[2] = _mm256_permute2f128_si256(rearm_arr[2], mbufs2_3, 0x20);
+		rearm_arr[0] = _mm256_permute2f128_si256(rearm_arr[0], mbufs0_1, 0x20);
+
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 6]->rearm_data, rearm_arr[6]);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 4]->rearm_data, rearm_arr[4]);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm_arr[2]);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 0]->rearm_data, rearm_arr[0]);
+
+		const __m256i tmp_mbuf_flags =
+				_mm256_castsi128_si256(_mm256_extracti128_si256(mbuf_flags, 1));
+
+		rearm_arr[7] = _mm256_blend_epi32(mbuf_init,
+					_mm256_slli_si256(tmp_mbuf_flags, 8), 4);
+		rearm_arr[5] = _mm256_blend_epi32(mbuf_init,
+					_mm256_slli_si256(tmp_mbuf_flags, 4), 4);
+		rearm_arr[3] = _mm256_blend_epi32(mbuf_init, tmp_mbuf_flags, 4);
+		rearm_arr[1] = _mm256_blend_epi32(mbuf_init,
+					_mm256_srli_si256(tmp_mbuf_flags, 4), 4);
+
+		rearm_arr[7] = _mm256_blend_epi32(rearm_arr[7], mbufs6_7, 0XF0);
+		rearm_arr[5] = _mm256_blend_epi32(rearm_arr[5], mbufs4_5, 0XF0);
+		rearm_arr[3] = _mm256_blend_epi32(rearm_arr[3], mbufs2_3, 0XF0);
+		rearm_arr[1] = _mm256_blend_epi32(rearm_arr[1], mbufs0_1, 0XF0);
+
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 7]->rearm_data, rearm_arr[7]);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 5]->rearm_data, rearm_arr[5]);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm_arr[3]);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 1]->rearm_data, rearm_arr[1]);
+
+		if (umbcast_flags) {
+			const __m256i umbcast_mask =
+				_mm256_set1_epi32(SXE2_RX_DESC_STATUS_UMBCAST_MASK);
+			__m256i umbcast_bits_256 =
+				_mm256_and_si256(staterrs0_7, umbcast_mask);
+
+			umbcast_bits_256 = _mm256_srli_epi32(umbcast_bits_256, 24);
+			__m128i umbcast_bits_128 =
+				_mm_packs_epi32(_mm256_castsi256_si128(umbcast_bits_256),
+						_mm256_extractf128_si256(umbcast_bits_256, 1));
+
+			umbcast_bits_128 = _mm_shuffle_epi8(umbcast_bits_128, eop_shuf_mask);
+
+			*(uint64_t *)umbcast_flags = _mm_cvtsi128_si64(umbcast_bits_128);
+			umbcast_flags += SXE2_RX_NUM_PER_LOOP_AVX;
+		}
+
+		if (split_rxe_flags) {
+			const __m256i eop_rxe_mask =
+					_mm256_set1_epi32(SXE2_RX_DESC_STATUS_EOP_MASK |
+								SXE2_RX_DESC_ERROR_RXE_MASK |
+								SXE2_RX_DESC_ERROR_OVERSIZE_MASK);
+			const __m128i eop_mask_128 =
+					_mm_set1_epi16(SXE2_RX_DESC_STATUS_EOP_MASK);
+			const __m128i rxe_mask_128 =
+					_mm_set1_epi16(SXE2_RX_DESC_ERROR_RXE_MASK |
+							SXE2_RX_DESC_ERROR_OVERSIZE_MASK);
+
+			const __m256i tmp_stats = _mm256_and_si256(staterrs0_7, eop_rxe_mask);
+
+			const __m128i eop_rxe_bits = _mm_packs_epi32
+							(_mm256_castsi256_si128(tmp_stats),
+							 _mm256_extractf128_si256(tmp_stats, 1));
+
+			__m128i not_eop_bits = _mm_andnot_si128(eop_rxe_bits, eop_mask_128);
+
+			not_eop_bits =
+				_mm_or_si128(not_eop_bits,
+					     _mm_srli_epi16(_mm_and_si128(eop_rxe_bits,
+									       rxe_mask_128),
+							      7));
+
+			not_eop_bits = _mm_shuffle_epi8(not_eop_bits, eop_shuf_mask);
+
+			*(uint64_t *)split_rxe_flags = _mm_cvtsi128_si64(not_eop_bits);
+			split_rxe_flags += SXE2_RX_NUM_PER_LOOP_AVX;
+		}
+
+		staterrs0_7 = _mm256_and_si256(staterrs0_7, dd_mask);
+
+		staterrs0_7 = _mm256_packs_epi32(staterrs0_7, _mm256_setzero_si256());
+
+		bit_num = rte_popcount64
+				(_mm_cvtsi128_si64(_mm256_extracti128_si256(staterrs0_7, 1)));
+		bit_num += rte_popcount64
+				(_mm_cvtsi128_si64(_mm256_castsi256_si128(staterrs0_7)));
+		done_num += bit_num;
+
+		if (bit_num != SXE2_RX_NUM_PER_LOOP_AVX)
+			break;
+	}
+
+	rxq->processing_idx += done_num;
+	rxq->processing_idx &= (rxq->ring_depth - 1);
+	if ((rxq->processing_idx & 1) == 1 && done_num > 1) {
+		rxq->processing_idx--;
+		done_num--;
+	}
+	rxq->realloc_num     += done_num;
+
+l_end:
+	PMD_LOG_DEBUG(RX, "port_id=%u queue_id=%u last_id=%u recv_pkts=%d",
+			rxq->port_id, rxq->queue_id, rxq->processing_idx, done_num);
+	return done_num;
+}
+
+static __rte_always_inline uint16_t
+sxe2_rx_pkts_scattered_batch_vec_avx512(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+	uint16_t nb_pkts, bool do_offload)
+{
+	const uint64_t *split_rxe_flags64;
+	uint8_t split_rxe_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	uint8_t umbcast_flags[SXE2_RX_PKTS_BURST_BATCH_NUM_VEC] = {0};
+	uint16_t rx_done_num;
+	uint16_t rx_pkt_done_num;
+
+	rx_pkt_done_num = 0;
+
+	if (rxq->vsi->adapter->devargs.sw_stats_en) {
+		rx_done_num = sxe2_rx_pkts_common_vec_avx512(rxq, rx_pkts,
+				nb_pkts, split_rxe_flags,
+				umbcast_flags, do_offload);
+	} else {
+		rx_done_num = sxe2_rx_pkts_common_vec_avx512(rxq, rx_pkts,
+				nb_pkts, split_rxe_flags,
+			    NULL, do_offload);
+	}
+	if (rx_done_num == 0)
+		goto l_end;
+
+	if (!rxq->vsi->adapter->devargs.sw_stats_en) {
+		split_rxe_flags64 = (uint64_t *)split_rxe_flags;
+
+		if (rxq->pkt_first_seg == NULL &&
+				!split_rxe_flags64[0] && !split_rxe_flags64[1] &&
+				!split_rxe_flags64[2] && !split_rxe_flags64[3]) {
+			rx_pkt_done_num = rx_done_num;
+			goto l_end;
+		}
+
+		if (rxq->pkt_first_seg == NULL) {
+			while (rx_pkt_done_num < rx_done_num &&
+			       split_rxe_flags[rx_pkt_done_num] == 0)
+				rx_pkt_done_num++;
+
+			if (rx_pkt_done_num == rx_done_num)
+				goto l_end;
+
+			rxq->pkt_first_seg = rx_pkts[rx_pkt_done_num];
+		}
+	}
+
+	rx_pkt_done_num += sxe2_rx_pkts_refactor(rxq, &rx_pkts[rx_pkt_done_num],
+			rx_done_num - rx_pkt_done_num, &split_rxe_flags[rx_pkt_done_num],
+			&umbcast_flags[rx_pkt_done_num]);
+
+l_end:
+
+	return rx_pkt_done_num;
+}
+
+static __rte_always_inline uint16_t
+sxe2_rx_pkts_scattered_common_vec_avx512(void *rx_queue,
+	struct rte_mbuf **rx_pkts, uint16_t nb_pkts, bool offload)
+{
+	uint16_t done_num = 0;
+	uint16_t once_num  = 0;
+
+	while (nb_pkts > SXE2_RX_PKTS_BURST_BATCH_NUM) {
+		once_num = sxe2_rx_pkts_scattered_batch_vec_avx512(rx_queue, rx_pkts + done_num,
+			SXE2_RX_PKTS_BURST_BATCH_NUM, offload);
+
+		done_num  += once_num;
+		nb_pkts -= once_num;
+
+		if (once_num < SXE2_RX_PKTS_BURST_BATCH_NUM)
+			goto end;
+	}
+
+	done_num += sxe2_rx_pkts_scattered_batch_vec_avx512(rx_queue,
+		rx_pkts + done_num, nb_pkts, offload);
+
+end:
+	return done_num;
+}
+
+uint16_t sxe2_rx_pkts_scattered_vec_avx512(void *rx_queue,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	return sxe2_rx_pkts_scattered_common_vec_avx512(rx_queue,
+			rx_pkts, nb_pkts, false);
+}
+
+uint16_t sxe2_rx_pkts_scattered_vec_avx512_offload(void *rx_queue,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	return sxe2_rx_pkts_scattered_common_vec_avx512(rx_queue,
+			rx_pkts, nb_pkts, true);
+}
+
+#endif
-- 
2.47.3

