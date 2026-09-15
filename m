Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29612C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C8EF42EB0;
	Tue, 15 Sep 2026 15:37:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3A46D42EA1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479450; x=1821015450;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NmMdosAqibqc4IDAvq/PGXz6KQSdAP8IWc8k9qNJ4OE=;
 b=idM3RlFxNRs3dhHgdL0TJUUULq2bt6KhSvtzPfVwScYepRzKs3bInK98
 drhY+kSpzFTswH6/ScLs7z82h2M1yv16z8OvSFdeLDVhrJKoMbJpOt/Pe
 zBxHVQA+ljNTc0nmJI4rNHhPNsIkS16UmAUY5LV+DHFGzojWZkIcZ7DlQ
 g7eClk3P7GesSzZK+1d/AYu5LWIh1xljFPbbEroL+iNznjCxM6i25jZsd
 tKjKJILZsEBbp/yn91ZRNa2/6ysEKK3vaoNVACaCSveTS0tFj14UowelZ
 A7cgO2QuhY6rNRwXAmd/1jKZgz6LZvf00e5peO1nFHz1zUOtwPf4ybAzx w==;
X-CSE-ConnectionGUID: kMEHrNn5QeSTmvqqP78UyQ==
X-CSE-MsgGUID: UhsAa3hmQKqnCx3MQeH/dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972540"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:30 -0700
X-CSE-ConnectionGUID: q6ZhmvbGTAS7+MgHU4f1zQ==
X-CSE-MsgGUID: a8Wdo4pLQ3iMmici2/OhEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800780"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 15/15] net/intel: consolidate Tx vector offload path checks
Date: Tue, 15 Sep 2026 14:36:52 +0100
Message-ID: <20260915133654.278780-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915133654.278780-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
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

Since iavf and ice drivers now have common Tx vector paths, we can
consolidate the path decisions a little, including replacing the
per-driver offload flags with common ones.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h                 | 30 +++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c            | 18 +++++------
 drivers/net/intel/iavf/iavf_rxtx.h            | 19 ------------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  3 +-
 drivers/net/intel/ice/ice_rxtx.c              | 14 ++++-----
 drivers/net/intel/ice/ice_rxtx.h              | 18 -----------
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  3 +-
 7 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 0f36989b32..867892f306 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -12,6 +12,27 @@
 #include <rte_io.h>
 #include <rte_byteorder.h>
 
+#define CI_VPMD_TX_BURST            32
+#define CI_VPMD_TX_MAX_FREE_BUF     64
+
+/* basic vector path */
+#define CI_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+/* offload vector path */
+#define CI_TX_VEC_OFFLOAD_PATH_OFFLOADS (	\
+		CI_TX_VECTOR_OFFLOADS |		\
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
+/* offload vector path with context descriptor */
+#define CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS (	\
+		CI_TX_VECTOR_OFFLOADS |		\
+		CI_TX_VEC_OFFLOAD_PATH_OFFLOADS |	\
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
+
 /* Common TX Descriptor QW1 Field Definitions */
 #define CI_TXD_QW1_DTYPE_S      0
 #define CI_TXD_QW1_DTYPE_M      (0xFUL << CI_TXD_QW1_DTYPE_S)
@@ -261,6 +282,15 @@ struct ci_tx_path_info {
 	bool supports_ctx;
 };
 
+/* basic check for a vector-driver capable Tx queue.
+ * Individual drivers may have other further tests beyond this.
+ */
+static inline bool
+ci_txq_vec_capable(uint16_t tx_rs_thresh)
+{
+	return tx_rs_thresh >= CI_VPMD_TX_BURST && tx_rs_thresh <= CI_VPMD_TX_MAX_FREE_BUF;
+}
+
 static __rte_always_inline void
 ci_tx_backlog_entry(struct ci_tx_entry *txep, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 3be8b00bbd..9b776a6391 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3620,7 +3620,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx2,
 		.info = "Vector AVX2",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		}
 	},
@@ -3628,7 +3628,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx2_offload,
 		.info = "Vector AVX2 Offload",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		}
 	},
@@ -3636,7 +3636,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx2_ctx,
 		.info = "Vector AVX2 Ctx",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		},
 		.supports_ctx = true
@@ -3645,7 +3645,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx2_ctx_offload,
 		.info = "Vector AVX2 Ctx Offload",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		},
 		.supports_ctx = true
@@ -3655,7 +3655,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx512,
 		.info = "Vector AVX512",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		}
 	},
@@ -3663,7 +3663,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx512_offload,
 		.info = "Vector AVX512 Offload",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		}
 	},
@@ -3671,7 +3671,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx512_ctx,
 		.info = "Vector AVX512 Ctx",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		},
 		.supports_ctx = true
@@ -3680,7 +3680,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx512_ctx_offload,
 		.info = "Vector AVX512 Ctx Offload",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		},
 		.supports_ctx = true
@@ -3691,7 +3691,7 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts_vec,
 		.info = "Vector Neon",
 		.features = {
-			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128
 		}
 	},
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 19931f5f7c..812d7e23ee 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -29,11 +29,9 @@
 
 /* used for Vector PMD */
 #define IAVF_VPMD_RX_BURST             CI_VPMD_RX_BURST
-#define IAVF_VPMD_TX_BURST             32
 #define IAVF_VPMD_RXQ_REARM_THRESH     CI_VPMD_RX_REARM_THRESH
 #define IAVF_VPMD_DESCS_PER_LOOP       CI_VPMD_DESCS_PER_LOOP
 #define IAVF_VPMD_DESCS_PER_LOOP_WIDE  CI_VPMD_DESCS_PER_LOOP_WIDE
-#define IAVF_VPMD_TX_MAX_FREE_BUF      64
 
 /* basic scalar path */
 #define IAVF_TX_SCALAR_OFFLOADS (			\
@@ -54,23 +52,6 @@
 		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |	\
 		RTE_ETH_TX_OFFLOAD_SECURITY |		\
 		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
-/* basic vector path */
-#define IAVF_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
-/* offload vector path */
-#define IAVF_TX_VECTOR_OFFLOAD_OFFLOADS (		\
-		IAVF_TX_VECTOR_OFFLOADS |		\
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
-/* offload vector path with context descriptor */
-#define IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (		\
-		IAVF_TX_VECTOR_OFFLOADS |		\
-		IAVF_TX_VECTOR_OFFLOAD_OFFLOADS |	\
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
 
 /* basic scalar path */
 #define IAVF_RX_SCALAR_OFFLOADS (			\
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 61478036ec..e0a67fedc6 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -80,8 +80,7 @@ iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 	if (!txq)
 		return -1;
 
-	if (txq->tx_rs_thresh < IAVF_VPMD_TX_BURST ||
-	    txq->tx_rs_thresh > IAVF_VPMD_TX_MAX_FREE_BUF)
+	if (!ci_txq_vec_capable(txq->tx_rs_thresh))
 		return -1;
 
 	return 0;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 50cacadc44..2db1fe16bf 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3551,7 +3551,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx2,
 		.info = "Vector AVX2",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		},
 		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
@@ -3560,7 +3560,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx2_offload,
 		.info = "Offload Vector AVX2",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		},
 		.pkt_prep = ice_prep_pkts
@@ -3569,7 +3569,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx2_ctx_offload,
 		.info = "Offload Vector AVX2 Ctx",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256
 		},
 		.pkt_prep = ice_prep_pkts,
@@ -3580,7 +3580,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512,
 		.info = "Vector AVX512",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		},
 		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
@@ -3589,7 +3589,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512_offload,
 		.info = "Offload Vector AVX512",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		},
 		.pkt_prep = ice_prep_pkts
@@ -3598,7 +3598,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512_ctx_offload,
 		.info = "Offload Vector AVX512 Ctx",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.tx_offloads = CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512
 		},
 		.pkt_prep = ice_prep_pkts,
@@ -3610,7 +3610,7 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts_vec,
 		.info = "Vector Neon",
 		.features = {
-			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.tx_offloads = CI_TX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128
 		},
 		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index bee8a464f5..cd23f7c56f 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -47,9 +47,7 @@
 #define ICE_SUPPORT_CHAIN_NUM 5
 
 #define ICE_VPMD_RX_BURST            CI_VPMD_RX_BURST
-#define ICE_VPMD_TX_BURST            32
 #define ICE_VPMD_RXQ_REARM_THRESH    CI_VPMD_RX_REARM_THRESH
-#define ICE_TX_MAX_FREE_BUF_SZ       64
 #define ICE_VPMD_DESCS_PER_LOOP      CI_VPMD_DESCS_PER_LOOP
 #define ICE_VPMD_DESCS_PER_LOOP_WIDE CI_VPMD_DESCS_PER_LOOP_WIDE
 
@@ -125,22 +123,6 @@
 	RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
 	RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	\
 	RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
-/* basic vector path */
-#define ICE_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
-/* vector offload paths */
-#define ICE_TX_VECTOR_OFFLOAD_OFFLOADS (	\
-	ICE_TX_VECTOR_OFFLOADS |		\
-	RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
-	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
-	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
-	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
-	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
-/* vector ctx offload path: QinQ outer tag + outer/tunnel checksum via ctx desc */
-#define ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (	\
-	ICE_TX_VECTOR_OFFLOAD_OFFLOADS |	\
-	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
-	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
-	RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
 
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 53d1eb42a3..d5ef213e08 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -72,8 +72,7 @@ ice_tx_vec_queue_default(struct ci_tx_queue *txq)
 	if (!txq)
 		return -1;
 
-	if (txq->tx_rs_thresh < ICE_VPMD_TX_BURST ||
-	    txq->tx_rs_thresh > ICE_TX_MAX_FREE_BUF_SZ)
+	if (!ci_txq_vec_capable(txq->tx_rs_thresh))
 		return -1;
 
 	return 0;
-- 
2.53.0

