Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FEFC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 314A642ECA;
	Wed, 16 Sep 2026 12:36:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6E94842E9A
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554998; x=1821090998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SwRGX8OmlsXoRTPON+W47IxoVaJVNPIuvnPj7RKw1ho=;
 b=lqb/t6Q2oQHAVCo8b/A0WTtfCxtTQZ9xTQcsprXkYG1DI2YFsE40nvJ/
 KBVgSZQ2RH0T2EA8Stn5dpdgFW+idNy3trOjA8IprXy3GJa7EFKpQdnSb
 II+q62YLrIkwiuKxQ0guWQdEVDZ0MSHFUVU5XUBxOIPcBkC3CE0YM+mYI
 YVbStJLecmD5/we5rueftZ1VRTR3YMMOfaUOVV46WNZLIdJtdeaRyghhH
 U8Pzid05BDDwisLiuO7fM4Y2cf6pAl4Ybw9DC/Dd99PMonaq0GWHyfxax
 0h0JLWi6rqJWSY6Uj0drl/z4+AgAlU0C9XZ/BSmY84uAs5Zdkyx9g64Y0 Q==;
X-CSE-ConnectionGUID: 1ucedC9OQLi/FeliNbH2nw==
X-CSE-MsgGUID: W52MyL/9RL2qxzQtcEYvOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867631"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867631"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:37 -0700
X-CSE-ConnectionGUID: 6COcB4KuQOy018cyPl6pCA==
X-CSE-MsgGUID: P+FPMPAaQ2mKrTCXnF8w4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528210"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 08/15] net/intel: allow building without IOVA in mbuf
Date: Wed, 16 Sep 2026 11:36:15 +0100
Message-ID: <20260916103622.319874-9-bruce.richardson@intel.com>
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

Ensure correct macros are used to build the vector Tx code without the
IOVA stored explicitly in the mbuf. This allows the iavf driver to build
when the config setting for IOVA in mbuf is disabled.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
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

