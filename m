Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF91EE66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:27:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7450640695;
	Fri, 19 Dec 2025 18:26:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5B36040673
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165184; x=1797701184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TcPSn+FCDk9wt0/prtCW01fIpJ9OCY1p7BCjpPKxJ98=;
 b=mjl+Rx42rnV+U916+mGalqhEP7N0lBiVF34pgQzpul96aqB39LSHUzuQ
 NiZ9HPGue/CIyWram/UVzydTKai9WeR9qMjvDlk3UgZqqv3StOf62wOB7
 gCGoa248KwYcswiM8MXtsp4O09z/aAuCR6Z2KxDdWzDyWMB3t00YY5Uj8
 C09bVJYhb7rC/Y9MlMfov+WeUTcNAwYdTbPFZRYN4sTBRUOc1ZU1WUqk8
 FZdfRvC7EraUxp/MkXtzxGtaAWMgchFOqOpsp2GfEdEaDeb0zioedZCTg
 ODoObXYQJf4/sCGJ66GtODZpKn8UsFX+rWqv3iqdtDPzgYiHuqiKPA2H6 Q==;
X-CSE-ConnectionGUID: ZIsMPBOtSpOR7om5SRnldA==
X-CSE-MsgGUID: FCpm0b4nQImpUVXkK9P+XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759485"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759485"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:23 -0800
X-CSE-ConnectionGUID: gKqSt0RGScGbZewYmupyzA==
X-CSE-MsgGUID: JGvsg0gCQW6B2HMrL4TZuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170440"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [RFC PATCH 10/27] net/intel: consolidate checksum mask definition
Date: Fri, 19 Dec 2025 17:25:27 +0000
Message-ID: <20251219172548.2660777-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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
 drivers/net/intel/ice/ice_rxtx.c          | 7 +------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx.h | 7 +------
 7 files changed, 13 insertions(+), 29 deletions(-)

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
index 82c4c6017b..e1964eab97 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -49,11 +49,6 @@
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
@@ -1171,7 +1166,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		td_cmd |= CI_TX_DESC_CMD_ICRC;
 
 		/* Enable checksum offloading */
-		if (ol_flags & I40E_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			i40e_txd_enable_checksum(ol_flags, &td_cmd,
 						 &td_offset, tx_offload);
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index ecf954a2c2..9ce978e69c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2597,7 +2597,7 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 	}
 
 	if ((m->ol_flags &
-	    (IAVF_TX_CKSUM_OFFLOAD_MASK | RTE_MBUF_F_TX_SEC_OFFLOAD)) == 0)
+	    (CI_TX_CKSUM_OFFLOAD_MASK | RTE_MBUF_F_TX_SEC_OFFLOAD)) == 0)
 		goto skip_cksum;
 
 	/* Set MACLEN */
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 86281aa965..4080184b3b 100644
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
index b90a1b4ec4..e102eb9bcc 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -9,11 +9,6 @@
 #include "ice_rxtx.h"
 #include "ice_rxtx_vec_common.h"
 
-#define ICE_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
-		RTE_MBUF_F_TX_L4_MASK |		 \
-		RTE_MBUF_F_TX_TCP_SEG |		 \
-		RTE_MBUF_F_TX_UDP_SEG |		 \
-		RTE_MBUF_F_TX_OUTER_IP_CKSUM)
 
 /**
  * The mbuf dynamic field pointer for protocol extraction metadata.
@@ -3210,7 +3205,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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

