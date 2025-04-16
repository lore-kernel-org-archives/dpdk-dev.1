Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5560C369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:02:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 661D7402E7;
	Wed, 16 Apr 2025 18:02:51 +0200 (CEST)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mails.dpdk.org (Postfix) with ESMTP id 904EC4025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=12540; q=dns/txt;
 s=iport01; t=1744819369; x=1746028969;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RWV6kGVIypDTMcaKjNnJhWE+8HxyLtIIia4x3aTsGKw=;
 b=Pt3f6fCjngE6ZA7gYRvc1cpB8ZqSjWBO9QQxsHh7c3DUew6HizG+X8fr
 KVTYZRrC9pP6kul5zbX+aD3/HBuSzcPwLSW6EKWuR2odZvIxaLKjiEFHl
 GKsQ4MansVxY3obJKTroCWgN0k8YO1Fn2oACRcB5YuR/3cRDA+ntPufAn
 QlmIXmD0b7Ib10DjLReArvZJ2pjAy/93U5F8uEelmzBVXgWmWxVntFQ+P
 a9NVWL9p7Kk3u7rubKs8LbRaJXUqO6bv/tgXjqkJF9JyQLuuZl9Nit3zJ
 TSGarjDyJSTJ8+Bjnuk3GTEEpt2nB45+qaMPdTbjytnlt0SoKnhILHb+j A==;
X-CSE-ConnectionGUID: MTLPHusOSsGSstV+bXp+mQ==
X-CSE-MsgGUID: JHzTTic+R/e7XBeCjT4N/g==
X-IPAS-Result: =?us-ascii?q?A0ADAAAM1P9n/5UQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGBfwQBAQEBAQsBgkp2WUNIjHCnahSBEQNWDwEBAQ8xE?=
 =?us-ascii?q?wQBAYUHiywCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFg?=
 =?us-ascii?q?Q4ThXsNhl0rCwFGLl4yEoMCAYJkA7FPgXkzgQGEfNk4gW6BSAGNTIVnJxuBS?=
 =?us-ascii?q?USEfYQphl4Egi2BF4RUkVeLH0iBIQNZLAFVEw0KCwcFgWwDKgsMCxIcFXE1H?=
 =?us-ascii?q?YF6g3OFNoIRggSJE4RWLU+FPEADCxgNSBEsNxQbBj5uB5c2hBZaNYJcDJMrk?=
 =?us-ascii?q?AWjJoQloUkaM4QDplMBmH4igjahc4RogWc8gVkzGggbFYMiCUkZD44tFoM/y?=
 =?us-ascii?q?EAqMgI6AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:c5oOAK6xl5YM4bXOA2XtFAxRtFfGchMFZxGqfqrLsTDasY5as4F+v
 mYWXGqBaayNY2rxeYpzOYnkpEgGu5PVydVlHFM5q3xhZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr/qUzBHf/g2Qpaj5NtfrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eGLE8wsZqGkZ17
 tMjMywzLRqzn6Gz+efuIgVsrpxLwMjDNYcbvDRkiDreF/tjGMqFSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZP0wn1lQ/UPrSmM+yg3T7bzpegFmUvqEwpWPUyWSd1ZC2bYeFI4zTHZQ9ckCwh
 ELUw1j4CVIgc9HA+RCI2XCQ2smIknauMG4VPPjinhJwu3Wfy3I7BAUaVh28u/bRok+3XZREN
 0sX9zEGrK4u+UjtRd74NzWmpHeIvxsdQZxVHuEk5Q2Oy6z84gCFC2xCRTlEAOHKr+c/QTgsk
 1vMlNTzCHk26vueSGmW8fGfqjba1TUpEFLurBQsFWMti+QPaqlq5v4TZr6PyJKIs+A=
IronPort-HdrOrdr: A9a23:VOvpVKCveHChjR/lHemn55DYdb4zR+YMi2TDGXofdfUzSL38qy
 nAppUmPHPP5Qr5O0tQ++xoRpPhfZq0z/cciuMs1NyZMjUO1lHFEGgb1/qA/9UlcBeOkdK0Es
 xbAsxDNOE=
X-Talos-CUID: 9a23:JcRZgGBTroYIFMv6Ewxb0HY0B9sCSWby92zMHQyyOX4qTYTAHA==
X-Talos-MUID: 9a23:e3ZjnQqzwumPYMfoV3oezxNCJvtU4q/tMgcAzqUstuKGCXBWfDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; d="scan'208";a="355818109"
Received: from alln-l-core-12.cisco.com ([173.36.16.149])
 by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Apr 2025 16:02:48 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-12.cisco.com (Postfix) with ESMTPS id 0644A1800016C;
 Wed, 16 Apr 2025 16:02:48 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id A1FBD1406899; Wed, 16 Apr 2025 12:02:47 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: ian.stokes@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH] net/iavf: support Rx/Tx burst mode info
Date: Wed, 16 Apr 2025 12:02:19 -0400
Message-Id: <20250416160219.3841018-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: alln-l-core-12.cisco.com
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

Return burst mode according to the selected Rx/Tx burst
function name.
Update 25.07 release notes with this information.

Signed-off-by: Roger Melton <rmelton@cisco.com>
---
 doc/guides/rel_notes/release_25_07.rst |   3 +
 drivers/net/intel/iavf/iavf.h          |   2 +
 drivers/net/intel/iavf/iavf_ethdev.c   |   2 +
 drivers/net/intel/iavf/iavf_rxtx.c     | 168 ++++++++++++++++++-------
 drivers/net/intel/iavf/iavf_rxtx.h     |   7 +-
 5 files changed, 135 insertions(+), 47 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..b83f911121 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel iavf driver.**
+
+  * Added support for rx_burst_mode_get and tx_burst_mode_get.
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 956c60ef45..97e6b243fb 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -321,6 +321,7 @@ struct iavf_devargs {
 struct iavf_security_ctx;
 
 enum iavf_rx_burst_type {
+	IAVF_RX_DISABLED,
 	IAVF_RX_DEFAULT,
 	IAVF_RX_FLEX_RXD,
 	IAVF_RX_BULK_ALLOC,
@@ -349,6 +350,7 @@ enum iavf_rx_burst_type {
 };
 
 enum iavf_tx_burst_type {
+	IAVF_TX_DISABLED,
 	IAVF_TX_DEFAULT,
 	IAVF_TX_SSE,
 	IAVF_TX_AVX2,
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 2335746f04..b3dacbef84 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -239,6 +239,8 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.rss_hash_conf_get          = iavf_dev_rss_hash_conf_get,
 	.rxq_info_get               = iavf_dev_rxq_info_get,
 	.txq_info_get               = iavf_dev_txq_info_get,
+	.rx_burst_mode_get          = iavf_rx_burst_mode_get,
+	.tx_burst_mode_get          = iavf_tx_burst_mode_get,
 	.mtu_set                    = iavf_dev_mtu_set,
 	.rx_queue_intr_enable       = iavf_dev_rx_queue_intr_enable,
 	.rx_queue_intr_disable      = iavf_dev_rx_queue_intr_disable,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 533e0c78a2..5411eb6897 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3688,66 +3688,142 @@ iavf_prep_pkts(__rte_unused void *tx_queue, struct rte_mbuf **tx_pkts,
 	return i;
 }
 
-static
-const eth_rx_burst_t iavf_rx_pkt_burst_ops[] = {
-	[IAVF_RX_DEFAULT] = iavf_recv_pkts,
-	[IAVF_RX_FLEX_RXD] = iavf_recv_pkts_flex_rxd,
-	[IAVF_RX_BULK_ALLOC] = iavf_recv_pkts_bulk_alloc,
-	[IAVF_RX_SCATTERED] = iavf_recv_scattered_pkts,
-	[IAVF_RX_SCATTERED_FLEX_RXD] = iavf_recv_scattered_pkts_flex_rxd,
+static uint16_t
+iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
+				uint16_t nb_pkts);
+static uint16_t
+iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
+				uint16_t nb_pkts);
+
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} iavf_rx_pkt_burst_ops[] = {
+	[IAVF_RX_DISABLED] = {iavf_recv_pkts_no_poll, "Disabled"},
+	[IAVF_RX_DEFAULT] = {iavf_recv_pkts, "Scalar"},
+	[IAVF_RX_FLEX_RXD] = {iavf_recv_pkts_flex_rxd, "Scalar Flex"},
+	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc,
+		"Scalar Bulk Alloc"},
+	[IAVF_RX_SCATTERED] = {iavf_recv_scattered_pkts,
+		"Scalar Scattered"},
+	[IAVF_RX_SCATTERED_FLEX_RXD] = {iavf_recv_scattered_pkts_flex_rxd,
+		"Scalar Scattered Flex"},
 #ifdef RTE_ARCH_X86
-	[IAVF_RX_SSE] = iavf_recv_pkts_vec,
-	[IAVF_RX_AVX2] = iavf_recv_pkts_vec_avx2,
-	[IAVF_RX_AVX2_OFFLOAD] = iavf_recv_pkts_vec_avx2_offload,
-	[IAVF_RX_SSE_FLEX_RXD] = iavf_recv_pkts_vec_flex_rxd,
-	[IAVF_RX_AVX2_FLEX_RXD] = iavf_recv_pkts_vec_avx2_flex_rxd,
-	[IAVF_RX_AVX2_FLEX_RXD_OFFLOAD] =
+	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector SSE"},
+	[IAVF_RX_AVX2] = {iavf_recv_pkts_vec_avx2, "Vector AVX2"},
+	[IAVF_RX_AVX2_OFFLOAD] = {iavf_recv_pkts_vec_avx2_offload,
+		"Vector AVX2 Offload"},
+	[IAVF_RX_SSE_FLEX_RXD] = {iavf_recv_pkts_vec_flex_rxd,
+		"Vector Flex SSE"},
+	[IAVF_RX_AVX2_FLEX_RXD] = {iavf_recv_pkts_vec_avx2_flex_rxd,
+		"Vector AVX2 Flex"},
+	[IAVF_RX_AVX2_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_pkts_vec_avx2_flex_rxd_offload,
-	[IAVF_RX_SSE_SCATTERED] = iavf_recv_scattered_pkts_vec,
-	[IAVF_RX_AVX2_SCATTERED] = iavf_recv_scattered_pkts_vec_avx2,
-	[IAVF_RX_AVX2_SCATTERED_OFFLOAD] =
+			"Vector AVX2 Flex Offload"},
+	[IAVF_RX_SSE_SCATTERED] = {iavf_recv_scattered_pkts_vec,
+		"Vector Scattered SSE"},
+	[IAVF_RX_AVX2_SCATTERED] = {iavf_recv_scattered_pkts_vec_avx2,
+		"Vector Scattered AVX2"},
+	[IAVF_RX_AVX2_SCATTERED_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx2_offload,
-	[IAVF_RX_SSE_SCATTERED_FLEX_RXD] =
+		"Vector Scattered AVX2 offload"},
+	[IAVF_RX_SSE_SCATTERED_FLEX_RXD] = {
 		iavf_recv_scattered_pkts_vec_flex_rxd,
-	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD] =
+		"Vector Scattered SSE Flex"},
+	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD] = {
 		iavf_recv_scattered_pkts_vec_avx2_flex_rxd,
-	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD] =
+		"Vector Scattered AVX2 Flex"},
+	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload,
+		"Vector Scattered AVX2 Flex Offload"},
 #ifdef CC_AVX512_SUPPORT
-	[IAVF_RX_AVX512] = iavf_recv_pkts_vec_avx512,
-	[IAVF_RX_AVX512_OFFLOAD] = iavf_recv_pkts_vec_avx512_offload,
-	[IAVF_RX_AVX512_FLEX_RXD] = iavf_recv_pkts_vec_avx512_flex_rxd,
-	[IAVF_RX_AVX512_FLEX_RXD_OFFLOAD] =
+	[IAVF_RX_AVX512] = {iavf_recv_pkts_vec_avx512, "Vector AVX512"},
+	[IAVF_RX_AVX512_OFFLOAD] = {iavf_recv_pkts_vec_avx512_offload,
+		"Vector AVX512 Offload"},
+	[IAVF_RX_AVX512_FLEX_RXD] = {iavf_recv_pkts_vec_avx512_flex_rxd,
+		"Vector AVX512 Flex"},
+	[IAVF_RX_AVX512_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_pkts_vec_avx512_flex_rxd_offload,
-	[IAVF_RX_AVX512_SCATTERED] = iavf_recv_scattered_pkts_vec_avx512,
-	[IAVF_RX_AVX512_SCATTERED_OFFLOAD] =
+		"Vector AVX512 Flex Offload"},
+	[IAVF_RX_AVX512_SCATTERED] = {iavf_recv_scattered_pkts_vec_avx512,
+		"Vector Scattered AVX512"},
+	[IAVF_RX_AVX512_SCATTERED_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx512_offload,
-	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD] =
+		"Vector Scattered AVX512 offload"},
+	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD] = {
 		iavf_recv_scattered_pkts_vec_avx512_flex_rxd,
-	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD] =
+		"Vector Scattered AVX512 Flex"},
+	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx512_flex_rxd_offload,
+		"Vector Scattered AVX512 Flex offload"},
 #endif
 #elif defined RTE_ARCH_ARM
-	[IAVF_RX_SSE] = iavf_recv_pkts_vec,
+	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector Neon"},
 #endif
 };
 
-static
-const eth_tx_burst_t iavf_tx_pkt_burst_ops[] = {
-	[IAVF_TX_DEFAULT] = iavf_xmit_pkts,
+int
+iavf_rx_burst_mode_get(struct rte_eth_dev *dev,
+		       __rte_unused uint16_t queue_id,
+		       struct rte_eth_burst_mode *mode)
+{
+	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(iavf_rx_pkt_burst_ops); i++) {
+		if (pkt_burst == iavf_rx_pkt_burst_ops[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 iavf_rx_pkt_burst_ops[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} iavf_tx_pkt_burst_ops[] = {
+	[IAVF_TX_DISABLED] = {iavf_xmit_pkts_no_poll, "Disabled"},
+	[IAVF_TX_DEFAULT] = {iavf_xmit_pkts, "Scalar"},
 #ifdef RTE_ARCH_X86
-	[IAVF_TX_SSE] = iavf_xmit_pkts_vec,
-	[IAVF_TX_AVX2] = iavf_xmit_pkts_vec_avx2,
-	[IAVF_TX_AVX2_OFFLOAD] = iavf_xmit_pkts_vec_avx2_offload,
+	[IAVF_TX_SSE] = {iavf_xmit_pkts_vec, "Vector SSE"},
+	[IAVF_TX_AVX2] = {iavf_xmit_pkts_vec_avx2, "Vector AVX2"},
+	[IAVF_TX_AVX2_OFFLOAD] = {iavf_xmit_pkts_vec_avx2_offload,
+		"Vector AVX2 Offload"},
 #ifdef CC_AVX512_SUPPORT
-	[IAVF_TX_AVX512] = iavf_xmit_pkts_vec_avx512,
-	[IAVF_TX_AVX512_OFFLOAD] = iavf_xmit_pkts_vec_avx512_offload,
-	[IAVF_TX_AVX512_CTX] = iavf_xmit_pkts_vec_avx512_ctx,
-	[IAVF_TX_AVX512_CTX_OFFLOAD] = iavf_xmit_pkts_vec_avx512_ctx_offload,
+	[IAVF_TX_AVX512] = {iavf_xmit_pkts_vec_avx512, "Vector AVX512"},
+	[IAVF_TX_AVX512_OFFLOAD] = {iavf_xmit_pkts_vec_avx512_offload,
+		"Vector AVX512 Offload"},
+	[IAVF_TX_AVX512_CTX] = {iavf_xmit_pkts_vec_avx512_ctx,
+		"Vector AVX512 Ctx"},
+	[IAVF_TX_AVX512_CTX_OFFLOAD] = {
+		iavf_xmit_pkts_vec_avx512_ctx_offload,
+		"Vector AVX512 Ctx Offload"},
 #endif
 #endif
 };
 
+int
+iavf_tx_burst_mode_get(struct rte_eth_dev *dev,
+		       __rte_unused uint16_t queue_id,
+		       struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(iavf_tx_pkt_burst_ops); i++) {
+		if (pkt_burst == iavf_tx_pkt_burst_ops[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 iavf_tx_pkt_burst_ops[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static uint16_t
 iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 				uint16_t nb_pkts)
@@ -3760,7 +3836,7 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 	rx_burst_type = rxq->vsi->adapter->rx_burst_type;
 
-	return iavf_rx_pkt_burst_ops[rx_burst_type](rx_queue,
+	return iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst(rx_queue,
 								rx_pkts, nb_pkts);
 }
 
@@ -3776,7 +3852,7 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_burst_type = txq->iavf_vsi->adapter->tx_burst_type;
 
-	return iavf_tx_pkt_burst_ops[tx_burst_type](tx_queue,
+	return iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst(tx_queue,
 								tx_pkts, nb_pkts);
 }
 
@@ -3861,7 +3937,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
 			return 0;
 	}
 
-	return iavf_tx_pkt_burst_ops[tx_burst_type](tx_queue, tx_pkts, good_pkts);
+	return iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
 }
 
 /* choose rx function*/
@@ -4047,7 +4123,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 			adapter->rx_burst_type = rx_burst_type;
 			dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 		} else {
-			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type];
+			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst;
 		}
 		return;
 	}
@@ -4069,7 +4145,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 			adapter->rx_burst_type = rx_burst_type;
 			dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 		} else {
-			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type];
+			dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst;
 		}
 		return;
 	}
@@ -4098,7 +4174,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 		adapter->rx_burst_type = rx_burst_type;
 		dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 	} else {
-		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type];
+		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst;
 	}
 }
 
@@ -4197,7 +4273,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 			adapter->tx_burst_type = tx_burst_type;
 			dev->tx_pkt_burst = iavf_xmit_pkts_check;
 		} else {
-			dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_burst_type];
+			dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst;
 		}
 		return;
 	}
@@ -4215,7 +4291,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		adapter->tx_burst_type = tx_burst_type;
 		dev->tx_pkt_burst = iavf_xmit_pkts_check;
 	} else {
-		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_burst_type];
+		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_burst_type].pkt_burst;
 	}
 }
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 823a6efa9a..8bc87b8465 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -609,7 +609,12 @@ int iavf_dev_rx_queue_setup(struct rte_eth_dev *dev,
 int iavf_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int iavf_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 void iavf_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
-
+int iavf_rx_burst_mode_get(struct rte_eth_dev *dev,
+			__rte_unused uint16_t queue_id,
+			struct rte_eth_burst_mode *mode);
+int iavf_tx_burst_mode_get(struct rte_eth_dev *dev,
+			__rte_unused uint16_t queue_id,
+			struct rte_eth_burst_mode *mode);
 int iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-- 
2.26.2.Cisco

