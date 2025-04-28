Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC7C369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 22:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E3C5402A3;
	Tue, 29 Apr 2025 00:10:46 +0200 (CEST)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mails.dpdk.org (Postfix) with ESMTP id 656B44026C
 for <dev@dpdk.org>; Tue, 29 Apr 2025 00:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=12502; q=dns/txt;
 s=iport01; t=1745878245; x=1747087845;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hibYhsmXj5sMnzgh4+OkIH/srZ5j55kuI96E+LBBjA0=;
 b=S+e/lGwTLllvT6yCCOhk47paQf0R3yoFxmffvvAxZMTaULQ7ZkKKgRJY
 5VsMykhXxynimdYReAqLy7mOXeekqth5kSAxUJBv4WDXbi2SNjwLwTcsj
 EXjAMd1KTjb4yfH7iEgDmqNUpcRZVhlMfvP4bNzLYzJnSXqGpok80dreD
 pObprw7LqU7/XA0AGBIUGmKrALp90Flv7/joroaT9zJjHeAa3V3CjKQI9
 DZ1zuNzgDmUOyTQvEov46kQOLpqs64gQ8ogT1hnKcLUIATzMBENkci70/
 NzMQdMYdf+YpkeoHBQmdz7sBND48xgqdlAgG7Sf1V8lWrBoet/ZinN01v w==;
X-CSE-ConnectionGUID: Xm6XCPGkQR6PsJZ3YG/6Qg==
X-CSE-MsgGUID: 4gqkXEk5TBGEFONMAqkY0w==
X-IPAS-Result: =?us-ascii?q?A0ADAAAt/A9o/44QJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGBfwQBAQEBAQsBgkqBT0NIjHCnaxSBEQNWDwEBAQ9EB?=
 =?us-ascii?q?AEBhQcCizACJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFg?=
 =?us-ascii?q?Q4ThgiGWwIBAycLAUYQUSsrBxKDAoJlA7E2gXkzgQGEfNk4gW6BSQGNTHCEd?=
 =?us-ascii?q?ycbgUlEhH2EKYZeBINDgUeRGos8SIEhA1ksAVUTDQoLBwWBaQMqCwwLEhwVb?=
 =?us-ascii?q?jMdghGFIYIPggeJCoRQLU+FMYFDQAMLGA1IESw3FBsGPm4HlUODa1o1glwMk?=
 =?us-ascii?q?yuQB6MohCWhSRozhAOmVJh+IoI2oXSEaYFnPIFZMxoIGxWDIlIZD44tFrpkK?=
 =?us-ascii?q?jI8AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:Xlk+AajHKVEQqSzJEypi84JNX161DxEKZh0ujC45NGQN5FlHY01je
 htvX2qEOP+PZWOgL9skaoS+pEMPuZDXz95gHgVprHg9FipjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSCULOZ82QsaD9Mt/jT8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUo/7hHKllh9
 sUidggWTCLYts3xnou0H7wEasQLdKEHPasWvnVmiDWcBvE8TNWbHuPB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQTYD/7C7pm9AusrmP6fjlEr1S9rqss6G+Vxwt0uFToGIaLJYLRFZUMxi50o
 Eqa8H36MjwZaeC15her1VSJr/bMrHvkDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWWttZb
 VcI/SkjtoAz8lCmSp/2WBjQiGCAtxIdXttKVeg35B+AxqnV5S6YAHQJSnhKb9lOiSMtbTUu0
 lnMm5biAiZi9eXID3mc7byT6zi1PED5MFM/WMPNdiNdi/GLnW35pkunogpLeEJtsuDIJA==
IronPort-HdrOrdr: A9a23:WeG4I6o8SSCRdZoLkcwee/oaV5oseYIsimQD101hICG9vPb2qy
 nIpoV96faaslcssR0b9OxofZPwI080lqQFhbX5Q43DYOCOggLBR+tfBMnZsljd8kbFmNK1u5
 0NT0EHMqySMbC/5vyKmTVR1L0bsb+6zJw=
X-Talos-CUID: =?us-ascii?q?9a23=3APZXcCGjyXdM7Medowf7NV1C6QjJuQniD/FzoDEy?=
 =?us-ascii?q?BMzhRU5+nEm6/v/1dnJ87?=
X-Talos-MUID: 9a23:3FZKkwt6Aj1tcT5pUM2n2D57N/dF4PmSIm8gv7IgnuCdNh0oJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,247,1739836800"; d="scan'208";a="467638810"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
 by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 22:10:44 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-05.cisco.com (Postfix) with ESMTPS id 19DD818000161;
 Mon, 28 Apr 2025 22:10:44 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id B70021406899; Mon, 28 Apr 2025 18:10:43 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: ian.stokes@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH v2] net/iavf: support Rx/Tx burst mode info
Date: Mon, 28 Apr 2025 18:07:13 -0400
Message-Id: <20250428220712.571492-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20250416160219.3841018-1-rmelton@cisco.com>
References: <20250416160219.3841018-1-rmelton@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com
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
 drivers/net/intel/iavf/iavf_rxtx.h     |   5 +-
 5 files changed, 133 insertions(+), 47 deletions(-)

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
index 823a6efa9a..0b5d67e718 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -609,7 +609,10 @@ int iavf_dev_rx_queue_setup(struct rte_eth_dev *dev,
 int iavf_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int iavf_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 void iavf_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
-
+int iavf_rx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			struct rte_eth_burst_mode *mode);
+int iavf_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t queue_id,
+			struct rte_eth_burst_mode *mode);
 int iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
-- 
2.35.6

