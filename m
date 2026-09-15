Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD35AC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D94E42D0B;
	Tue, 15 Sep 2026 15:37:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 026F6406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479431; x=1821015431;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HzcP7jr+JH5Y789qtFA0nIujqdogEivVtsc1YgyT5ZU=;
 b=R1sTIr1S4VF9mYyeRZXnFnT5S30H9DGDEMiJfkW1BVJQoisnt+G16rO8
 Y16WL3lrZH3yD1+l2csyptiMvJtPAChedS0bz9M2jASxoN1L5H8S9GKYx
 tgHCJovMoq7qZVqDyMXWQovG8yFdLzeh73MhA03Sb6KbrzuDbuDl/tab3
 pvR6m5eCQKW8ZvhHoLBd9TB7uHdCCvvcMuvb/IXv9/tE+dO1j4l0d5DHn
 C9+Ldk2gM1aW9zGiCnIj64SLVAkGP9a7ymwQnzN38rcI2D8VNYCC7goqu
 4F4uPXTdnzUnEuwqZXcBk8XDWyZ4wRQlm+bY5M1JlVSNPtBcdRCASXwgg g==;
X-CSE-ConnectionGUID: AUnmyzWNSnaaXQTntAGEUg==
X-CSE-MsgGUID: tFI83h+EQNKuftknFcF07g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972500"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972500"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:10 -0700
X-CSE-ConnectionGUID: SZ9m1CbtRtyO/JWeNs3kPw==
X-CSE-MsgGUID: upd3YHUiQU+Bd43z8NOaaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800704"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:09 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 01/15] net/iavf: remove unnecessary alignment calls
Date: Tue, 15 Sep 2026 14:36:38 +0100
Message-ID: <20260915133654.278780-2-bruce.richardson@intel.com>
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

When we have a context descriptor on Tx of a packet from the vector
paths, that means that we always have 32-bytes being written per
descriptor/per packet, so the stores are always 32-bit aligned. This
means we can use aligned stores for each single descriptor store, and
that we never need to do an initial descriptor write for alignment when
doing a burst of descriptors.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
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

