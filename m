Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9CED2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 198C940A6E;
	Tue, 13 Jan 2026 16:15:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B796140696
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317329; x=1799853329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ebJFACDVcB8c0lcAPg5J8I8/pzo3cO5n/1o3i+0/CxI=;
 b=IbVVOWt9OTBqrJULJUYkGBXKEtAg49mUO1Q/ws4ua24JneBgJibWmKVa
 AVNRmDIWKAfKrDbqmhvxpUH2WXQ+TRQ3WYU1UfsTeKOhnYnVXyFZjhfNi
 Ym0srip+rr9R5l1tkagyoQI/zoRFq8qgT27KfRi59flnOqnT2Wb/4cWsz
 +b7Bo/oQkoJ4rR+j7t2LkeC+QjZetEG07iEw/gczshekt11oMI2PGOgED
 BFWWGa9+MAsnah1oI65y5+Za/CT/SpwPXL3NpqccaDhSE6GlLSV1N/eSd
 fk/WJYr+KFSvT7MGLX1cOHekWPrHsI8eYYELhJciZxEYcxjLV7/qsdIPg w==;
X-CSE-ConnectionGUID: aoFOBSSmT++hHIQJpcAPJw==
X-CSE-MsgGUID: 7G0bQsgyRYOLgpE9F2Wk7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969165"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969165"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:28 -0800
X-CSE-ConnectionGUID: FI9srKpuQSC6H2xpkXa9Bw==
X-CSE-MsgGUID: uC9MoNA7THeu8gXos65EHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556579"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:27 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v2 10/36] net/intel: consolidate checksum mask definition
Date: Tue, 13 Jan 2026 15:14:34 +0000
Message-ID: <20260113151505.1871271-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

Create a common definition for checksum masks across iavf, idpf, i40e
and ice drivers.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h             | 7 +++++++
 drivers/net/intel/i40e/i40e_rxtx.c        | 7 +------
 drivers/net/intel/iavf/iavf_rxtx.c        | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.h        | 8 --------
 drivers/net/intel/ice/ice_rxtx.c          | 8 +-------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx.h | 7 +------
 7 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 320ab0b8e0..a71b98f119 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -53,6 +53,13 @@
 /* Common maximum data per TX descriptor */
 #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >> CI_TXD_QW1_TX_BUF_SZ_S)
 
+/* Checksum offload mask to identify packets requesting offload */
+#define CI_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
+				   RTE_MBUF_F_TX_L4_MASK |		 \
+				   RTE_MBUF_F_TX_TCP_SEG |		 \
+				   RTE_MBUF_F_TX_OUTER_IP_CKSUM |	 \
+				   RTE_MBUF_F_TX_OUTER_UDP_CKSUM)
+
 /**
  * Common TX offload union for Intel drivers.
  * Supports both basic offloads (l2_len, l3_len, l4_len, tso_segsz) and
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 7646ea07aa..db36ec86f7 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -53,11 +53,6 @@
 #define I40E_TX_IEEE1588_TMST 0
 #endif
 
-#define I40E_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
-		RTE_MBUF_F_TX_L4_MASK |		 \
-		RTE_MBUF_F_TX_TCP_SEG |		 \
-		RTE_MBUF_F_TX_OUTER_IP_CKSUM)
-
 #define I40E_TX_OFFLOAD_MASK (RTE_MBUF_F_TX_OUTER_IPV4 |	\
 		RTE_MBUF_F_TX_OUTER_IPV6 |	\
 		RTE_MBUF_F_TX_IPV4 |		\
@@ -1176,7 +1171,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		td_cmd |= CI_TX_DESC_CMD_ICRC;
 
 		/* Enable checksum offloading */
-		if (ol_flags & I40E_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			i40e_txd_enable_checksum(ol_flags, &td_cmd,
 						 &td_offset, tx_offload);
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index dc4c64d169..75f2e143f9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2601,7 +2601,7 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 	}
 
 	if ((m->ol_flags &
-	    (IAVF_TX_CKSUM_OFFLOAD_MASK | RTE_MBUF_F_TX_SEC_OFFLOAD)) == 0)
+	    (CI_TX_CKSUM_OFFLOAD_MASK | RTE_MBUF_F_TX_SEC_OFFLOAD)) == 0)
 		goto skip_cksum;
 
 	/* Set MACLEN */
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 395d97b4ee..cca5c25119 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -136,14 +136,6 @@
 
 #define IAVF_TX_MIN_PKT_LEN 17
 
-#define IAVF_TX_CKSUM_OFFLOAD_MASK (		 \
-		RTE_MBUF_F_TX_IP_CKSUM |		 \
-		RTE_MBUF_F_TX_L4_MASK |		 \
-		RTE_MBUF_F_TX_TCP_SEG |          \
-		RTE_MBUF_F_TX_UDP_SEG |          \
-		RTE_MBUF_F_TX_OUTER_IP_CKSUM |   \
-		RTE_MBUF_F_TX_OUTER_UDP_CKSUM)
-
 #define IAVF_TX_OFFLOAD_MASK (  \
 		RTE_MBUF_F_TX_OUTER_IPV6 |		 \
 		RTE_MBUF_F_TX_OUTER_IPV4 |		 \
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index f9dcc30208..dc21a89ce3 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -13,12 +13,6 @@
 #include "../common/rx_vec_x86.h"
 #endif
 
-#define ICE_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
-		RTE_MBUF_F_TX_L4_MASK |		 \
-		RTE_MBUF_F_TX_TCP_SEG |		 \
-		RTE_MBUF_F_TX_UDP_SEG |		 \
-		RTE_MBUF_F_TX_OUTER_IP_CKSUM)
-
 /**
  * The mbuf dynamic field pointer for protocol extraction metadata.
  */
@@ -3206,7 +3200,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		/* Enable checksum offloading */
-		if (ol_flags & ICE_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			ice_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 9219ad9047..b34d545a0a 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -945,7 +945,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		else
 			nb_used = tx_pkt->nb_segs + nb_ctx;
 
-		if (ol_flags & IDPF_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
 
 		/* context descriptor */
@@ -1425,7 +1425,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			}
 		}
 
-		if (ol_flags & IDPF_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			td_cmd |= IDPF_TX_FLEX_DESC_CMD_CS_EN;
 
 		if (nb_ctx != 0) {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index b88a87402d..fe7094d434 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -39,13 +39,8 @@
 #define IDPF_RLAN_CTX_DBUF_S	7
 #define IDPF_RX_MAX_DATA_BUF_SIZE	(16 * 1024 - 128)
 
-#define IDPF_TX_CKSUM_OFFLOAD_MASK (		\
-		RTE_MBUF_F_TX_IP_CKSUM |	\
-		RTE_MBUF_F_TX_L4_MASK |		\
-		RTE_MBUF_F_TX_TCP_SEG)
-
 #define IDPF_TX_OFFLOAD_MASK (			\
-		IDPF_TX_CKSUM_OFFLOAD_MASK |	\
+		CI_TX_CKSUM_OFFLOAD_MASK |	\
 		RTE_MBUF_F_TX_IPV4 |		\
 		RTE_MBUF_F_TX_IPV6)
 
-- 
2.51.0

