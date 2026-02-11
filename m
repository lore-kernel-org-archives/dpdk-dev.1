Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893AECD6D6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF1C040DD5;
	Wed, 11 Feb 2026 19:13:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7F4D640B9E
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833623; x=1802369623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qmpGGpEe30SOMFOd1sjYOMfc4qII0apMBad0UPQnxk4=;
 b=ItJffc34APMA2S5n5YIvH0OBxFp0bwjLiGyeJpim7qE+8UsfOoYX8rkp
 hvY0JrVOXIi+gBZxM/w57J3dpeV+OC//uEGRHIZxcjT2Bc0nLLyNTks7w
 EIpdIU3if8DKlFKhbWZDZmWyv/HasISnpXoEwRVwJKa9Y1G0lwm8A7MW9
 P8pSFd9ZjgyYEPiXXJbDQdbO4xpI4/KAydiYWFBYxDBVqkN8QRMxA03V9
 O2vqepDZBFL7akdfGgAtQ3rAbqC2y4ZD1xjtExOO9r7ix59VevAhg15MI
 4X4rrjAZFX4u7SfXfsZe40Xmu+veqSeXcyREEZV7ysMknWaJXCQuLyDMb Q==;
X-CSE-ConnectionGUID: yPo90yZKShOS68VOtPO/GQ==
X-CSE-MsgGUID: sElme064SVSGD1/Ppk2ApA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834675"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834675"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:42 -0800
X-CSE-ConnectionGUID: sBbCqScfRkGEpfvBKFSLiA==
X-CSE-MsgGUID: f9ggkwLKTGKQIw0Fx7VOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986323"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 10/35] net/intel: consolidate checksum mask definition
Date: Wed, 11 Feb 2026 18:12:39 +0000
Message-ID: <20260211181309.2838042-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx.h             | 8 ++++++++
 drivers/net/intel/i40e/i40e_rxtx.c        | 7 +------
 drivers/net/intel/iavf/iavf_rxtx.c        | 2 +-
 drivers/net/intel/iavf/iavf_rxtx.h        | 8 --------
 drivers/net/intel/ice/ice_rxtx.c          | 8 +-------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx.h | 7 +------
 7 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 091f220f1c..23deabc5d1 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -53,6 +53,14 @@
 /* Common maximum data per TX descriptor */
 #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >> CI_TXD_QW1_TX_BUF_SZ_S)
 
+/* Checksum offload mask to identify packets requesting offload */
+#define CI_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
+				   RTE_MBUF_F_TX_L4_MASK |		 \
+				   RTE_MBUF_F_TX_TCP_SEG |		 \
+				   RTE_MBUF_F_TX_UDP_SEG |		 \
+				   RTE_MBUF_F_TX_OUTER_IP_CKSUM |	 \
+				   RTE_MBUF_F_TX_OUTER_UDP_CKSUM)
+
 /**
  * Common TX offload union for Intel drivers.
  * Supports both basic offloads (l2_len, l3_len, l4_len, tso_segsz) and
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 601d4b98f2..12a21407c5 100644
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
@@ -1171,7 +1166,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		td_cmd |= CI_TX_DESC_CMD_ICRC;
 
 		/* Enable checksum offloading */
-		if (ol_flags & I40E_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			i40e_txd_enable_checksum(ol_flags, &td_cmd,
 						 &td_offset, tx_offload);
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 885d9309cc..3dbcfd5355 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2596,7 +2596,7 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
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
index 1c789d45da..63bce7bd9e 100644
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
@@ -3214,7 +3208,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		/* Enable checksum offloading */
-		if (ol_flags & ICE_TX_CKSUM_OFFLOAD_MASK)
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			ice_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 383cfc8567..c34dde2796 100644
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

