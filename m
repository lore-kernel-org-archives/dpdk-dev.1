Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B989C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:02:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D52EF427CC;
	Thu,  3 Sep 2026 19:02:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4AAA240647
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788454928; x=1819990928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=it97LerPW1j7Umaf54vyBS8sq8JaiqNysiZAHi8Dsuw=;
 b=ABOmllOpTniEhuION4OvUKf3Q6gnuXnJ3sQy1q0E27Z0t9dQx2NVVRUS
 HkKeJX48sjJ6QCovT2yoJFN6WqdjIopDUVtY6tUWFvUmwi8ijS31fvwOV
 4PgPUw9RxznG6MZU9X4SUH5KaaZ2GeizutRfbvSsqO3Bv61rIrJn3GJrp
 K+U+Vsoa3L3mNzcqS21ICK5JCztAXO+ajO3Bvw3ykN2abXOZFm5pflBCW
 iqckL43lmp/8vgrkoW5/6jaCDD+Z5IoVILS6JFnZlP0eTTeLBGnzRLQIg
 LwFa3NzPZPgJr2VeLKhV7q7Lw2wnsDmjhp7yskxlFhQNnxdQdfI7gTGK1 Q==;
X-CSE-ConnectionGUID: q8fw4CtfQvmPNZ+xwD8xPg==
X-CSE-MsgGUID: AJvakE5vQjaoXNuZKdO9/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100462958"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100462958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 10:01:46 -0700
X-CSE-ConnectionGUID: Qf8LPHUpT9WI3U4YKekTAA==
X-CSE-MsgGUID: /w6nlABHTg6H/z2Cxl+z7g==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2026 10:01:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 01/13] net/iavf: remove unnecessary alignment calls
Date: Thu,  3 Sep 2026 18:01:30 +0100
Message-ID: <20260903170140.360477-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903170140.360477-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
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

When we have a context descriptor on Tx of a packet from the vector
paths, that means that we always have 32-bytes being written per
descriptor/per packet, so the stores are always 32-bit aligned. This
means we can use aligned stores for each single descriptor store, and
that we never need to do an initial descriptor write for alignment when
doing a burst of descriptors.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 9 ++-------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 7217f32cef..9b62ef53d3 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1933,7 +1933,8 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
 							high_ctx_qw, low_ctx_qw);
 
-	_mm256_storeu_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
+	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
 }
 
 static __rte_always_inline void
@@ -1944,12 +1945,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 	uint64_t hi_data_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
 					((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
 
-	/* if unaligned on 32-bit boundary, do one to align */
-	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, ptype_lldp_enabled);
-		nb_pkts--; txdp++; pkt++;
-	}
-
 	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
 		uint64_t hi_ctx_qw1 = IAVF_TX_DESC_DTYPE_CONTEXT;
 		uint64_t hi_ctx_qw0 = IAVF_TX_DESC_DTYPE_CONTEXT;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index bf0245e8f4..4609c2245a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2078,7 +2078,8 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
 							high_ctx_qw, low_ctx_qw);
 
-	_mm256_storeu_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
+	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
 }
 
 static __rte_always_inline void
@@ -2088,12 +2089,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
-	/* if unaligned on 32-bit boundary, do one to align */
-	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_enabled);
-		nb_pkts--; txdp++; pkt++;
-	}
-
 	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
 		uint64_t hi_ctx_qw1 = IAVF_TX_DESC_DTYPE_CONTEXT;
 		uint64_t hi_ctx_qw0 = IAVF_TX_DESC_DTYPE_CONTEXT;
-- 
2.53.0

