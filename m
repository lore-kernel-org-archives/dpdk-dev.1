Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5932C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04EDC42709;
	Mon,  9 Jun 2025 17:37:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id AC8C44275A
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483477; x=1781019477;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WPLoE8xndOh8GmklcV7m3fVc9XMNQqcA0Xm/3K4rFgA=;
 b=d0jwA/k1oYfTVqWD3Q1HDAgzXBSS0UhwUYbgiYsdpsq44ezfDed9WWzF
 7oogGV6zvGxF+RZCwynNSP6SEOcKX9vQ1V7DxscuRfXQB5VT8I0IR4vEM
 QiyrPEOFSiTZeaCvObq4bY7pXA7+WmsHHvl6QHMtMpSVyHFxng9dFBSHu
 qU3lRGKQwXQSSkwfi8I3toPf5FA54reF4xWibdlbbwrmyud/aDKMWJXzr
 JNJRAsdJOJJusRAX6AeVzJFJJ3OcJpymauwE5j6OhQDB9Yyd06KUnreqc
 0Lwiq32fw+Eczz33pj0+JJHR3nVDfGu58UEHky2yzM9FKjKVDTvcJerNe Q==;
X-CSE-ConnectionGUID: WaUfxTS+TQCE5IcfzB7TXQ==
X-CSE-MsgGUID: mImXn1GsSBqFFZezUApqvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012146"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012146"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:37:56 -0700
X-CSE-ConnectionGUID: gFk1LUeiQ1WPPh7WqZu5Ow==
X-CSE-MsgGUID: aulCGCQkQU207PJRObkKlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419590"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:37:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v6 06/33] net/i40e: rename 16-byte descriptor define
Date: Mon,  9 Jun 2025 16:37:04 +0100
Message-ID: <d66c58987f27a80014abb6d4d6e2f4ec4326d8e4.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
References: 
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

In preparation for having a common definition for 16-byte and 32-byte Rx
descriptors, rename `RTE_LIBRTE_I40E_16BYTE_RX_DESC` to
`RTE_NET_INTEL_USE_16BYTE_DESC``.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 app/test-pmd/config.c                         |  4 ++--
 config/rte_config.h                           |  2 +-
 doc/guides/nics/i40e.rst                      |  4 +++-
 drivers/net/intel/i40e/i40e_fdir.c            |  2 +-
 drivers/net/intel/i40e/i40e_pf.c              |  2 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 10 +++++-----
 drivers/net/intel/i40e/i40e_rxtx.h            |  2 +-
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h |  2 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  8 ++++----
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  8 ++++----
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  4 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  4 ++--
 12 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..1f43f3bbd8 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -4481,7 +4481,7 @@ ring_rxd_display_dword(union igb_ring_dword dword)
 
 static void
 ring_rx_descriptor_display(const struct rte_memzone *ring_mz,
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 			   portid_t port_id,
 #else
 			   __rte_unused portid_t port_id,
@@ -4490,7 +4490,7 @@ ring_rx_descriptor_display(const struct rte_memzone *ring_mz,
 {
 	struct igb_ring_desc_16_bytes *ring =
 		(struct igb_ring_desc_16_bytes *)ring_mz->addr;
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	int ret;
 	struct rte_eth_dev_info dev_info;
 
diff --git a/config/rte_config.h b/config/rte_config.h
index 86897de75e..6191ba3ae0 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -137,7 +137,7 @@
 
 /* i40e defines */
 #define RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC 1
-// RTE_LIBRTE_I40E_16BYTE_RX_DESC is not set
+/* RTE_NET_INTEL_USE_16BYTE_DESC is not set */
 #define RTE_LIBRTE_I40E_QUEUE_NUM_PER_PF 64
 #define RTE_LIBRTE_I40E_QUEUE_NUM_PER_VF 4
 #define RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM 4
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index ba592d23fe..234757cd7a 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -961,7 +961,9 @@ Use 16 Bytes RX Descriptor Size
 As i40e PMD supports both 16 and 32 bytes RX descriptor sizes, and 16 bytes size can provide helps to high performance of small packets.
 In ``config/rte_config.h`` set the following to use 16 bytes size RX descriptors::
 
-   #define RTE_LIBRTE_I40E_16BYTE_RX_DESC 1
+   #define RTE_NET_INTEL_USE_16BYTE_DESC 1
+
+Note however that setting this up will make it so that all PMD's supporting this definition will also use 16-byte descriptors.
 
 Input set requirement of each pctype for FDIR
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 94e3ab44e3..734218b67d 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -112,7 +112,7 @@ i40e_fdir_rx_queue_init(struct i40e_rx_queue *rxq)
 	rx_ctx.hbuff = 0;
 	rx_ctx.base = rxq->rx_ring_phys_addr / I40E_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->nb_rx_desc;
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	rx_ctx.dsize = 1;
 #endif
 	rx_ctx.dtype = i40e_header_split_none;
diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index 4a47a8f7ee..ebe1deeade 100644
--- a/drivers/net/intel/i40e/i40e_pf.c
+++ b/drivers/net/intel/i40e/i40e_pf.c
@@ -401,7 +401,7 @@ i40e_pf_host_hmc_config_rxq(struct i40e_hw *hw,
 	rx_ctx.hbuff = rxq->hdr_size >> I40E_RXQ_CTX_HBUFF_SHIFT;
 	rx_ctx.base = rxq->dma_ring_addr / I40E_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->ring_len;
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	rx_ctx.dsize = 1;
 #endif
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index b4caa3bdd5..5f54bcc225 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -125,7 +125,7 @@ i40e_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union i40e_rx_desc *rxdp)
 	} else {
 		mb->vlan_tci = 0;
 	}
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rte_le_to_cpu_16(rxdp->wb.qword2.ext_status) &
 		(1 << I40E_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT)) {
 		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ |
@@ -217,7 +217,7 @@ static inline uint64_t
 i40e_rxd_build_fdir(volatile union i40e_rx_desc *rxdp, struct rte_mbuf *mb)
 {
 	uint64_t flags = 0;
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	uint16_t flexbh, flexbl;
 
 	flexbh = (rte_le_to_cpu_32(rxdp->wb.qword2.ext_status) >>
@@ -2925,10 +2925,10 @@ i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq)
 		rxd = &rxq->rx_ring[i];
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		rxd->read.rsvd1 = 0;
 		rxd->read.rsvd2 = 0;
-#endif /* RTE_LIBRTE_I40E_16BYTE_RX_DESC */
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 		rxe[i].mbuf = mbuf;
 	}
@@ -3010,7 +3010,7 @@ i40e_rx_queue_init(struct i40e_rx_queue *rxq)
 
 	rx_ctx.base = rxq->rx_ring_phys_addr / I40E_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->nb_rx_desc;
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	rx_ctx.dsize = 1;
 #endif
 	rx_ctx.dtype = rxq->hs_mode;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 9db044f280..568f0536ac 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -68,7 +68,7 @@ enum i40e_header_split_mode {
 			       I40E_HEADER_SPLIT_SCTP)
 
 /* HW desc structure, both 16-byte and 32-byte types are supported */
-#ifdef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 #define i40e_rx_desc i40e_16byte_rx_desc
 #else
 #define i40e_rx_desc i40e_32byte_rx_desc
diff --git a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
index b66a808f9f..7d2bda624b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
@@ -41,7 +41,7 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 		return;
 	}
 
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	struct rte_mbuf *mb0, *mb1;
 	__m128i dma_addr0, dma_addr1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 9c406e7a6f..4469c73c56 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -21,7 +21,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	i40e_rxq_rearm_common(rxq, false);
 }
 
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 /* Handles 32B descriptor FDIR ID processing:
  * rxdp: receive descriptor ring, required to load 2nd 16B half of each desc
  * rx_pkts: required to store metadata back to mbufs
@@ -99,7 +99,7 @@ desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
 	/* NOT REACHED, see above switch returns */
 	return _mm256_setzero_si256();
 }
-#endif /* RTE_LIBRTE_I40E_16BYTE_RX_DESC */
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 #define PKTLEN_SHIFT     10
 
@@ -398,7 +398,7 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		 * not always performed. Branch over the code when not enabled.
 		 */
 		if (rxq->fdir_enabled) {
-#ifdef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 			/* 16B descriptor code path:
 			 * RSS and FDIR ID use the same offset in the desc, so
 			 * only one can be present at a time. The code below
@@ -490,7 +490,7 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			fdir_add_flags = desc_fdir_processing_32b(rxdp, rx_pkts, i, 6);
 			mbuf_flags = _mm256_or_si256(mbuf_flags, fdir_add_flags);
 			/* End 32B desc handling */
-#endif /* RTE_LIBRTE_I40E_16BYTE_RX_DESC */
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 		} /* if() on FDIR enabled */
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index d8244556c0..bb25acf398 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -23,7 +23,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	i40e_rxq_rearm_common(rxq, true);
 }
 
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 /* Handles 32B descriptor FDIR ID processing:
  * rxdp: receive descriptor ring, required to load 2nd 16B half of each desc
  * rx_pkts: required to store metadata back to mbufs
@@ -102,7 +102,7 @@ desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
 	/* NOT REACHED, see above switch returns */
 	return _mm256_setzero_si256();
 }
-#endif /* RTE_LIBRTE_I40E_16BYTE_RX_DESC */
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 #define PKTLEN_SHIFT     10
 
@@ -419,7 +419,7 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		 * not always performed. Branch over the code when not enabled.
 		 */
 		if (rxq->fdir_enabled) {
-#ifdef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 			/* 16B descriptor code path:
 			 * RSS and FDIR ID use the same offset in the desc, so
 			 * only one can be present at a time. The code below
@@ -539,7 +539,7 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			mbuf_flags =
 				_mm256_or_si256(mbuf_flags, fdir_add_flags);
 			/* End 32B desc handling */
-#endif /* RTE_LIBRTE_I40E_16BYTE_RX_DESC */
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 		} /* if() on FDIR enabled */
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 317a0323bb..695b4e1040 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -77,7 +77,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	I40E_PCI_REG_WRITE_RELAXED(rxq->qrx_tail, rx_id);
 }
 
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 /* NEON version of FDIR mark extraction for 4 32B descriptors at a time */
 static inline uint32x4_t
 descs_to_fdir_32b(volatile union i40e_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
@@ -284,7 +284,7 @@ desc_to_olflags_v(struct i40e_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
 
 	/* Extract FDIR ID only if FDIR is enabled to avoid useless work */
 	if (rxq->fdir_enabled) {
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		uint32x4_t v_fdir_ol_flags = descs_to_fdir_32b(rxdp, rx_pkts);
 #else
 		(void)rxdp; /* rxdp not required for 16B desc mode */
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 25a3ef7352..920089fe3e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -86,7 +86,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
 }
 
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 /* SSE version of FDIR mark extraction for 4 32B descriptors at a time */
 static inline __m128i
 descs_to_fdir_32b(volatile union i40e_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
@@ -285,7 +285,7 @@ desc_to_olflags_v(struct i40e_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
 
 	/* Extract FDIR ID only if FDIR is enabled to avoid useless work */
 	if (rxq->fdir_enabled) {
-#ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 		__m128i v_fdir_ol_flags = descs_to_fdir_32b(rxdp, rx_pkts);
 #else
 		(void)rxdp; /* rxdp not required for 16B desc mode */
-- 
2.47.1

