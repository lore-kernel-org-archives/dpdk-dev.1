Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20EC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BAF542EA4;
	Wed, 16 Sep 2026 12:36:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2391B40DD0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554995; x=1821090995;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CXNIQ1SgJ89vaJzqK18fQFr40h7WdEQ3it1sk0HFvHM=;
 b=jYy6gVl2tnAN+s/JY6KVpAJpE/4mE6/CzE28oWJrx2CAPy6nZ26RilPq
 G7HVizDg06lJsDoKBE1st9Wv8h6wIkuG6t9WIseC/bIw9eBqqR8SzbqkE
 KPZkt6AHLkAX5MOJYQKrSB/o2/XZEwM1IYFR35xctIemcmswJIsryRr9B
 X5DKQsCK+IYGzKsxxe82r4ZVMaOs6/G+mRbMjH0vlX3aYLF4AQcJQM2qq
 mqtdjuUzp3pYsiPX8l2fHiN+OTdix65SFQwQkY2vjgqQ2sWsNEIiSDHwB
 j10LEAw/IN9KFI5qutQqyZVjQ0VEVprmku1l4D8ZTL50WRLcYK5DL0gT5 A==;
X-CSE-ConnectionGUID: zKDbsZ66RC6Eg+TpSb1FGQ==
X-CSE-MsgGUID: EdkrV1rXQ9yFCpF9tnSC9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867627"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867627"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:34 -0700
X-CSE-ConnectionGUID: ou9XUxLKQbevft6b3SEmrA==
X-CSE-MsgGUID: VuG8ROFkQnamC7lvrifKQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528155"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 05/15] net/intel: define common macros for tunneling
 bit-shifts
Date: Wed, 16 Sep 2026 11:36:12 +0100
Message-ID: <20260916103622.319874-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916103622.319874-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
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

Define common macros for use in iavf (for now) and other drivers
(future) defining the shifts needed for tunnel packet Tx

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h                 | 24 +++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c            | 30 ++++++++--------
 drivers/net/intel/iavf/iavf_rxtx.h            | 34 -------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 30 ++++++++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 30 ++++++++--------
 5 files changed, 69 insertions(+), 79 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index fb5268c972..c8fadee712 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -45,6 +45,30 @@
 #define CI_TX_CTX_DESC_TSYN             0x02
 #define CI_TX_CTX_DESC_IL2TAG2          0x04
 
+/* Common TX Context Descriptor QW0 Field Shifts */
+#define CI_TXD_CTX_QW0_L2TAG2_S         32
+#define CI_TXD_CTX_QW0_EIPT_S           0  /* 2 BITS - external IP type */
+#define CI_TXD_CTX_QW0_EIPLEN_S         2  /* 7 BITS - external IP header length */
+#define CI_TXD_CTX_QW0_NATT_S           9  /* 2 BITS - L4 tunnel type */
+#define CI_TXD_CTX_QW0_EIP_NOINC_S      11 /* 1 BIT  - external IP ID not incremented */
+#define CI_TXD_CTX_QW0_NATLEN_S         12 /* 7 BITS - L4 tunnel header length */
+#define CI_TXD_CTX_QW0_L4T_CS_S         23 /* 1 BIT  - tunnel UDP checksum enable */
+
+/**
+ * Enum for the external (outer) IP type field of a Tx context descriptor's
+ * tunnel parameters (QW0 bits 0-1).
+ */
+enum ci_tx_ctx_eipt {
+	CI_TX_CTX_EIPT_NONE,
+	CI_TX_CTX_EIPT_IPV6,
+	CI_TX_CTX_EIPT_IPV4_NO_CSUM,
+	CI_TX_CTX_EIPT_IPV4,
+};
+
+#define CI_TXD_CTX_UDP_TUNNELING        (0x1ULL << CI_TXD_CTX_QW0_NATT_S)
+#define CI_TXD_CTX_GRE_TUNNELING        (0x2ULL << CI_TXD_CTX_QW0_NATT_S)
+#define CI_TXD_CTX_QW0_L4T_CS_M         (0x1ULL << CI_TXD_CTX_QW0_L4T_CS_S)
+
 /**
  * Enum to specify where a VLAN tag is to be placed for packet Tx.
  */
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 80c9912ccc..849fc33dac 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2345,7 +2345,7 @@ iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag, bool lldp_e
 static inline void
 iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, uint64_t ol_flags, const struct rte_mbuf *m)
 {
-	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
+	uint64_t eip_typ = CI_TX_CTX_EIPT_NONE;
 	uint64_t eip_len = 0;
 	uint64_t eip_noinc = 0;
 	/* Default - IP_ID is increment in each segment of LSO */
@@ -2354,15 +2354,15 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, uint64_t ol_flags, const stru
 			RTE_MBUF_F_TX_OUTER_IPV6 |
 			RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
 	case RTE_MBUF_F_TX_OUTER_IPV4:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
+		eip_typ = CI_TX_CTX_EIPT_IPV4_NO_CSUM;
 		eip_len = m->outer_l3_len >> 2;
 	break;
 	case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
+		eip_typ = CI_TX_CTX_EIPT_IPV4;
 		eip_len = m->outer_l3_len >> 2;
 	break;
 	case RTE_MBUF_F_TX_OUTER_IPV6:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
+		eip_typ = CI_TX_CTX_EIPT_IPV6;
 		eip_len = m->outer_l3_len >> 2;
 	break;
 	}
@@ -2377,10 +2377,10 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, uint64_t ol_flags, const stru
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
 		case RTE_MBUF_F_TX_TUNNEL_GTP:
 		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-			eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
+			eip_typ |= CI_TXD_CTX_UDP_TUNNELING;
 			break;
 		case RTE_MBUF_F_TX_TUNNEL_GRE:
-			eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
+			eip_typ |= CI_TXD_CTX_GRE_TUNNELING;
 			break;
 		default:
 			PMD_TX_LOG(ERR, "Tunnel type not supported");
@@ -2397,23 +2397,23 @@ iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, uint64_t ol_flags, const stru
 		 * its last Ethertype.
 		 * If MPLS labels exists, it should include them as well.
 		 */
-		eip_typ |= (m->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
+		eip_typ |= (m->l2_len >> 1) << CI_TXD_CTX_QW0_NATLEN_S;
 
 		/**
 		 * Calculate the tunneling UDP checksum.
 		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
 		 */
-		if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV6 |
-					IAVF_TX_CTX_EXT_IP_IPV4 |
-					IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
-				(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
+		if ((eip_typ & (CI_TX_CTX_EIPT_IPV6 |
+					CI_TX_CTX_EIPT_IPV4 |
+					CI_TX_CTX_EIPT_IPV4_NO_CSUM)) &&
+				(eip_typ & CI_TXD_CTX_UDP_TUNNELING) &&
 				(ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-			eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
+			eip_typ |= CI_TXD_CTX_QW0_L4T_CS_M;
 	}
 
-	*qw0 = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
-		eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
-		eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
+	*qw0 = eip_typ << CI_TXD_CTX_QW0_EIPT_S |
+		eip_len << CI_TXD_CTX_QW0_EIPLEN_S |
+		eip_noinc << CI_TXD_CTX_QW0_EIP_NOINC_S;
 }
 
 static inline uint16_t
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 3ff49b94b4..19931f5f7c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -444,40 +444,6 @@ enum iavf_rx_flex_desc_ipsec_crypto_status {
 #define IAVF_TXD_CTX_QW1_SEG_PARAMS_MSS_MASK		\
 	(0x3FFFUL << IAVF_TXD_CTX_QW1_SEG_PARAMS_MSS_SHIFT)
 
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT		(0)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_MASK		(0x3UL)
-
-enum iavf_tx_ctx_desc_tunnel_external_ip_type {
-	IAVF_TX_CTX_DESC_EIPT_NONE,
-	IAVF_TX_CTX_DESC_EIPT_IPV6,
-	IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD,
-	IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD
-};
-
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT	(2)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_MASK		(0x7FUL)
-
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_L4TUNT_SHIFT	(9)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_L4TUNT_MASK		(0x3UL)
-
-enum iavf_tx_ctx_desc_tunnel_l4_tunnel_type {
-	IAVF_TX_CTX_DESC_L4_TUN_TYP_NO_UDP_GRE,
-	IAVF_TX_CTX_DESC_L4_TUN_TYP_UDP,
-	IAVF_TX_CTX_DESC_L4_TUN_TYP_GRE
-};
-
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT	(11)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_MASK	(0x1UL)
-
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_L4TUNLEN_SHIFT	(12)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_L4TUNLEN_MASK	(0x7FUL)
-
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_DECTTL_SHIFT	(19)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_DECTTL_MASK		(0xFUL)
-
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_L4T_CS_SHIFT	(23)
-#define IAVF_TXD_CTX_QW0_TUN_PARAMS_L4T_CS_MASK		(0x1UL)
-
 #define IAVF_TXD_CTX_QW0_L2TAG2_PARAM			(32)
 #define IAVF_TXD_CTX_QW0_L2TAG2_MASK			(0xFFFFUL)
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 10e96a8510..f95aabe577 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1760,7 +1760,7 @@ static inline void
 iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 {
 	if (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-		uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
+		uint64_t eip_typ = CI_TX_CTX_EIPT_NONE;
 		uint64_t eip_len = 0;
 		uint64_t eip_noinc = 0;
 		/* Default - IP_ID is increment in each segment of LSO */
@@ -1769,15 +1769,15 @@ iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 				RTE_MBUF_F_TX_OUTER_IPV6 |
 				RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
 		case RTE_MBUF_F_TX_OUTER_IPV4:
-			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
+			eip_typ = CI_TX_CTX_EIPT_IPV4_NO_CSUM;
 			eip_len = pkt->outer_l3_len >> 2;
 		break;
 		case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
+			eip_typ = CI_TX_CTX_EIPT_IPV4;
 			eip_len = pkt->outer_l3_len >> 2;
 		break;
 		case RTE_MBUF_F_TX_OUTER_IPV6:
-			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
+			eip_typ = CI_TX_CTX_EIPT_IPV6;
 			eip_len = pkt->outer_l3_len >> 2;
 		break;
 		}
@@ -1791,10 +1791,10 @@ iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
 		case RTE_MBUF_F_TX_TUNNEL_GTP:
 		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-			eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
+			eip_typ |= CI_TXD_CTX_UDP_TUNNELING;
 			break;
 		case RTE_MBUF_F_TX_TUNNEL_GRE:
-			eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
+			eip_typ |= CI_TXD_CTX_GRE_TUNNELING;
 			break;
 		default:
 			PMD_TX_LOG(ERR, "Tunnel type not supported");
@@ -1811,22 +1811,22 @@ iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 		 * its last Ethertype.
 		 * If MPLS labels exists, it should include them as well.
 		 */
-		eip_typ |= (pkt->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
+		eip_typ |= (pkt->l2_len >> 1) << CI_TXD_CTX_QW0_NATLEN_S;
 
 		/**
 		 * Calculate the tunneling UDP checksum.
 		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
 		 */
-		if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV4 |
-					IAVF_TX_CTX_EXT_IP_IPV6 |
-					IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
-				(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
+		if ((eip_typ & (CI_TX_CTX_EIPT_IPV4 |
+					CI_TX_CTX_EIPT_IPV6 |
+					CI_TX_CTX_EIPT_IPV4_NO_CSUM)) &&
+				(eip_typ & CI_TXD_CTX_UDP_TUNNELING) &&
 				(pkt->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-			eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
+			eip_typ |= CI_TXD_CTX_QW0_L4T_CS_M;
 
-		*low_ctx_qw = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
-			eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
-			eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
+		*low_ctx_qw = eip_typ << CI_TXD_CTX_QW0_EIPT_S |
+			eip_len << CI_TXD_CTX_QW0_EIPLEN_S |
+			eip_noinc << CI_TXD_CTX_QW0_EIP_NOINC_S;
 
 	} else {
 		*low_ctx_qw = 0;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 58ed89a72a..74d91fff31 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1899,7 +1899,7 @@ static __rte_always_inline void
 iavf_fill_ctx_desc_tunneling_avx512(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 {
 	if (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-		uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
+		uint64_t eip_typ = CI_TX_CTX_EIPT_NONE;
 		uint64_t eip_len = 0;
 		uint64_t eip_noinc = 0;
 		/* Default - IP_ID is increment in each segment of LSO */
@@ -1908,15 +1908,15 @@ iavf_fill_ctx_desc_tunneling_avx512(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 				RTE_MBUF_F_TX_OUTER_IPV6 |
 				RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
 		case RTE_MBUF_F_TX_OUTER_IPV4:
-			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
+			eip_typ = CI_TX_CTX_EIPT_IPV4_NO_CSUM;
 			eip_len = pkt->outer_l3_len >> 2;
 		break;
 		case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
+			eip_typ = CI_TX_CTX_EIPT_IPV4;
 			eip_len = pkt->outer_l3_len >> 2;
 		break;
 		case RTE_MBUF_F_TX_OUTER_IPV6:
-			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
+			eip_typ = CI_TX_CTX_EIPT_IPV6;
 			eip_len = pkt->outer_l3_len >> 2;
 		break;
 		}
@@ -1930,10 +1930,10 @@ iavf_fill_ctx_desc_tunneling_avx512(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
 		case RTE_MBUF_F_TX_TUNNEL_GTP:
 		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-			eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
+			eip_typ |= CI_TXD_CTX_UDP_TUNNELING;
 			break;
 		case RTE_MBUF_F_TX_TUNNEL_GRE:
-			eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
+			eip_typ |= CI_TXD_CTX_GRE_TUNNELING;
 			break;
 		default:
 			PMD_TX_LOG(ERR, "Tunnel type not supported");
@@ -1950,22 +1950,22 @@ iavf_fill_ctx_desc_tunneling_avx512(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 		 * its last Ethertype.
 		 * If MPLS labels exists, it should include them as well.
 		 */
-		eip_typ |= (pkt->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
+		eip_typ |= (pkt->l2_len >> 1) << CI_TXD_CTX_QW0_NATLEN_S;
 
 		/**
 		 * Calculate the tunneling UDP checksum.
 		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
 		 */
-		if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV4 |
-					IAVF_TX_CTX_EXT_IP_IPV6 |
-					IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
-				(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
+		if ((eip_typ & (CI_TX_CTX_EIPT_IPV4 |
+					CI_TX_CTX_EIPT_IPV6 |
+					CI_TX_CTX_EIPT_IPV4_NO_CSUM)) &&
+				(eip_typ & CI_TXD_CTX_UDP_TUNNELING) &&
 				(pkt->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-			eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
+			eip_typ |= CI_TXD_CTX_QW0_L4T_CS_M;
 
-		*low_ctx_qw = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
-			eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
-			eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
+		*low_ctx_qw = eip_typ << CI_TXD_CTX_QW0_EIPT_S |
+			eip_len << CI_TXD_CTX_QW0_EIPLEN_S |
+			eip_noinc << CI_TXD_CTX_QW0_EIP_NOINC_S;
 
 	} else {
 		*low_ctx_qw = 0;
-- 
2.53.0

