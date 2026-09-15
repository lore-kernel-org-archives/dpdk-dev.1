Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D87C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:38:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25DFC42E92;
	Tue, 15 Sep 2026 15:37:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 13740406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479440; x=1821015440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vtQ1AajBf/UWwT18yzSR2CWY892+ANCRaGVeUyujQqE=;
 b=TKSxkJTELvidFkVM6UZM05/6aipe9XNZ33/sjYgqePsu3z8PgHb5KdFl
 uWeStZiJjSuF+vToGkwnDngGFlfIFa2AMlFEktasfXcC/bkPaRexxbwHq
 9zubs/yQpOFTdp8Orh1VkVgs7WXUMxkEcBav3Y76Ut3drB1ABGCm5OXGF
 rVZ7gQQA1mraOZTFSsHgSkgJ/nPrqH8MwyIpXDWgZ5+GZhfWFnt27pdfS
 77mDnseqbB5mgMW0n4jycfkB4PI3RKvAAK1okmIWY5X4+IPYWwEBEAQEI
 gcYvYji10UsWMCUz2F7h8vSS4Ht+w2Cw/R98NKdcDuLLNIRgdBnBY5kRz g==;
X-CSE-ConnectionGUID: DYchAKj1Tn2kd904aIZ/Tw==
X-CSE-MsgGUID: OXrE+TyySEG9X3zyJBoxJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972528"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972528"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:20 -0700
X-CSE-ConnectionGUID: pCj+HQ2IT/mbPkx1IRD1NQ==
X-CSE-MsgGUID: 5BGlUiibTzCFxNFBWtigZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800749"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 08/15] net/intel: allow building without IOVA in mbuf
Date: Tue, 15 Sep 2026 14:36:45 +0100
Message-ID: <20260915133654.278780-9-bruce.richardson@intel.com>
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

Ensure correct macros are used to build the vector Tx code without the
IOVA stored explicitly in the mbuf. This allows the iavf driver to build
when the config setting for IOVA in mbuf is disabled.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_vec_x86.h | 30 +++++++++++++--------------
 drivers/net/intel/iavf/meson.build    |  4 +---
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/common/tx_vec_x86.h b/drivers/net/intel/common/tx_vec_x86.h
index 0c6c60a21e..56efe1d1ec 100644
--- a/drivers/net/intel/common/tx_vec_x86.h
+++ b/drivers/net/intel/common/tx_vec_x86.h
@@ -168,7 +168,7 @@ ci_vtx1(volatile struct ci_tx_desc *txdp,
 	if (offload)
 		ci_tx_vec_offload(pkt, &high_qw, single_vlan_pos, qinq_outer_pos);
 
-	__m128i descriptor = _mm_set_epi64x(high_qw, pkt->buf_iova + pkt->data_off);
+	__m128i descriptor = _mm_set_epi64x(high_qw, rte_pktmbuf_iova(pkt));
 	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
 }
 
@@ -209,15 +209,15 @@ ci_vtx_avx2(volatile struct ci_tx_desc *txdp,
 		__m256i desc2_3 =
 			_mm256_set_epi64x
 				(hi_qw3,
-				 pkt[3]->buf_iova + pkt[3]->data_off,
+				 rte_pktmbuf_iova(pkt[3]),
 				 hi_qw2,
-				 pkt[2]->buf_iova + pkt[2]->data_off);
+				 rte_pktmbuf_iova(pkt[2]));
 		__m256i desc0_1 =
 			_mm256_set_epi64x
 				(hi_qw1,
-				 pkt[1]->buf_iova + pkt[1]->data_off,
+				 rte_pktmbuf_iova(pkt[1]),
 				 hi_qw0,
-				 pkt[0]->buf_iova + pkt[0]->data_off);
+				 rte_pktmbuf_iova(pkt[0]));
 		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
 		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
 	}
@@ -259,7 +259,7 @@ ci_vtx1_ctx_avx2(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	if (offload)
 		ci_tx_vec_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
 
-	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
+	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, rte_pktmbuf_iova(pkt),
 							high_ctx_qw, low_ctx_qw);
 
 	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
@@ -331,10 +331,10 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 		}
 
 		__m256i desc2_3 = _mm256_set_epi64x
-				(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
+				(hi_data_qw1, rte_pktmbuf_iova(pkt[1]),
 				 hi_ctx_qw1, low_ctx_qw1);
 		__m256i desc0_1 = _mm256_set_epi64x
-				(hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
+				(hi_data_qw0, rte_pktmbuf_iova(pkt[0]),
 				 hi_ctx_qw0, low_ctx_qw0);
 		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
 		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
@@ -382,13 +382,13 @@ ci_vtx_avx512(volatile struct ci_tx_desc *txdp,
 		__m512i desc0_3 =
 			_mm512_set_epi64
 				(hi_qw3,
-				 pkt[3]->buf_iova + pkt[3]->data_off,
+				 rte_pktmbuf_iova(pkt[3]),
 				 hi_qw2,
-				 pkt[2]->buf_iova + pkt[2]->data_off,
+				 rte_pktmbuf_iova(pkt[2]),
 				 hi_qw1,
-				 pkt[1]->buf_iova + pkt[1]->data_off,
+				 rte_pktmbuf_iova(pkt[1]),
 				 hi_qw0,
-				 pkt[0]->buf_iova + pkt[0]->data_off);
+				 rte_pktmbuf_iova(pkt[0]));
 		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
 	}
 
@@ -430,7 +430,7 @@ ci_vtx1_ctx_avx512(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		ci_tx_vec_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
 
 	__m256i ctx_data_desc = _mm256_set_epi64x
-			(high_data_qw, pkt->buf_iova + pkt->data_off,
+			(high_data_qw, rte_pktmbuf_iova(pkt),
 			high_ctx_qw, low_ctx_qw);
 
 	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
@@ -500,9 +500,9 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 		}
 
 		__m512i desc0_3 = _mm512_set_epi64
-				(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
+				(hi_data_qw1, rte_pktmbuf_iova(pkt[1]),
 				hi_ctx_qw1, low_ctx_qw1,
-				hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
+				hi_data_qw0, rte_pktmbuf_iova(pkt[0]),
 				hi_ctx_qw0, low_ctx_qw0);
 		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
 	}
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 9b071a3a4b..3884043ae6 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
 
-if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
-    subdir_done()
-endif
+require_iova_in_mbuf = false
 
 testpmd_sources = files('iavf_testpmd.c')
 
-- 
2.53.0

