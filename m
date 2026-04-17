Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEEFF4368A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:56:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC48E4065E;
	Fri, 17 Apr 2026 12:56:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 372A6402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776423391; x=1807959391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xfpcsPsZbMwfjJ8w8Bzthy1twwqGxW3KIqUfmYhAMt0=;
 b=UyYOGfFkAxqjAPInAJKukftUBFkbwNhjE5usc2JRL+qyz58OkQMVvEY1
 OGbMRBZia7r+goI8tZIdBXN3TO5s5lUWcT6m8gbJF2SgXTOFhiGpIww0W
 KNcUQFWPBWNsV8s6oJjlpic27qHgK3cv1h9lUgil3VLyEXblKwepWtr1O
 JIE00n1HvJuYQogHd9tgJOeKlUaG0aEbLr37pq7mc76BZBdmtGAyGnuPa
 V6j6IZ6EwcxdrBR33vJDiLYapMWQLvsRiFnriKmVlIZaZrQRl+4z5gc7s
 meCoS+RF1XXr8zA+1sdce+yYjyEdSXxPk0o7KTvAhM84J2ecB0VVkc3uQ Q==;
X-CSE-ConnectionGUID: xucigCoeSG+NaPMqT2m2aQ==
X-CSE-MsgGUID: qiYuVFgaQluZXtB1MbCb6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="87739760"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="87739760"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:56:30 -0700
X-CSE-ConnectionGUID: 8y4XgQErRZmbA9w9aFwscA==
X-CSE-MsgGUID: 0iRfLMVbS1GYemLmjWZTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="224498011"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2026 03:56:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v4 2/3] net/iavf: add AVX2 context descriptor Tx paths
Date: Fri, 17 Apr 2026 10:56:09 +0000
Message-ID: <20260417105610.1161242-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417105610.1161242-1-ciara.loftus@intel.com>
References: <20260417100804.1143121-1-ciara.loftus@intel.com>
 <20260417105610.1161242-1-ciara.loftus@intel.com>
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

Prior to this commit the transmit paths implemented for AVX2 used the
transmit descriptor only, making some offloads and features unavailable
on the AVX2 path, like LLDP. Enable two new AVX2 transmit paths, both
of which support using a context descriptor, one which performs offload
and the other which does not.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v4:
* Use semicolons instead of commas to separate statements.
---
 doc/guides/rel_notes/release_26_07.rst      |   1 +
 drivers/net/intel/iavf/iavf.h               |   2 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  18 +
 drivers/net/intel/iavf/iavf_rxtx.h          |   4 +
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c | 386 ++++++++++++++++++++
 5 files changed, 411 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index e0b27a554a..6ecb0d4f38 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -59,6 +59,7 @@ New Features
 * **Updated Intel iavf driver.**
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
+  * Implemented AVX2 context descriptor transmit paths.
 
 
 Removed Items
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index ef503a1b64..7c39d516a7 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -360,6 +360,8 @@ enum iavf_tx_func_type {
 	IAVF_TX_DEFAULT,
 	IAVF_TX_AVX2,
 	IAVF_TX_AVX2_OFFLOAD,
+	IAVF_TX_AVX2_CTX,
+	IAVF_TX_AVX2_CTX_OFFLOAD,
 	IAVF_TX_AVX512,
 	IAVF_TX_AVX512_OFFLOAD,
 	IAVF_TX_AVX512_CTX,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index bb62ab07de..b0c9039bbf 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3616,6 +3616,24 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 			.simd_width = RTE_VECT_SIMD_256
 		}
 	},
+	[IAVF_TX_AVX2_CTX] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx2_ctx,
+		.info = "Vector AVX2 Ctx",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.ctx_desc = true
+		}
+	},
+	[IAVF_TX_AVX2_CTX_OFFLOAD] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx2_ctx_offload,
+		.info = "Vector AVX2 Ctx Offload",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.ctx_desc = true
+		}
+	},
 #ifdef CC_AVX512_SUPPORT
 	[IAVF_TX_AVX512] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx512,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 0157c4c37e..d4f0f4240c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -589,6 +589,10 @@ uint16_t iavf_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts);
 uint16_t iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 					 uint16_t nb_pkts);
+uint16_t iavf_xmit_pkts_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts);
+uint16_t iavf_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts);
 int iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 int iavf_rx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_tx_vec_dev_check(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index db0462f0f5..47bddcc4ca 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1763,6 +1763,392 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_pkts;
 }
 
+static inline void
+iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
+{
+	if (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
+		uint64_t eip_len = 0;
+		uint64_t eip_noinc = 0;
+		/* Default - IP_ID is increment in each segment of LSO */
+
+		switch (pkt->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
+				RTE_MBUF_F_TX_OUTER_IPV6 |
+				RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
+		case RTE_MBUF_F_TX_OUTER_IPV4:
+			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
+			eip_len = pkt->outer_l3_len >> 2;
+		break;
+		case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
+			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
+			eip_len = pkt->outer_l3_len >> 2;
+		break;
+		case RTE_MBUF_F_TX_OUTER_IPV6:
+			eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
+			eip_len = pkt->outer_l3_len >> 2;
+		break;
+		}
+
+		/* L4TUNT: L4 Tunneling Type */
+		switch (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		case RTE_MBUF_F_TX_TUNNEL_IPIP:
+			/* for non UDP / GRE tunneling, set to 00b */
+			break;
+		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
+		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+		case RTE_MBUF_F_TX_TUNNEL_GTP:
+		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
+			eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
+			break;
+		case RTE_MBUF_F_TX_TUNNEL_GRE:
+			eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
+			break;
+		default:
+			PMD_TX_LOG(ERR, "Tunnel type not supported");
+			return;
+		}
+
+		/* L4TUNLEN: L4 Tunneling Length, in Words
+		 *
+		 * We depend on app to set rte_mbuf.l2_len correctly.
+		 * For IP in GRE it should be set to the length of the GRE
+		 * header;
+		 * For MAC in GRE or MAC in UDP it should be set to the length
+		 * of the GRE or UDP headers plus the inner MAC up to including
+		 * its last Ethertype.
+		 * If MPLS labels exists, it should include them as well.
+		 */
+		eip_typ |= (pkt->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
+
+		/**
+		 * Calculate the tunneling UDP checksum.
+		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
+		 */
+		if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV4 |
+					IAVF_TX_CTX_EXT_IP_IPV6 |
+					IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
+				(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
+				(pkt->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
+			eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
+
+		*low_ctx_qw = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
+			eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
+			eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
+
+	} else {
+		*low_ctx_qw = 0;
+	}
+}
+
+static inline void
+iavf_fill_ctx_desc_tunneling_field(volatile uint64_t *qw0,
+		const struct rte_mbuf *m)
+{
+	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
+	uint64_t eip_len = 0;
+	uint64_t eip_noinc = 0;
+	/* Default - IP_ID is increment in each segment of LSO */
+
+	switch (m->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
+			RTE_MBUF_F_TX_OUTER_IPV6 |
+			RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
+	case RTE_MBUF_F_TX_OUTER_IPV4:
+		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
+		eip_len = m->outer_l3_len >> 2;
+	break;
+	case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
+		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
+		eip_len = m->outer_l3_len >> 2;
+	break;
+	case RTE_MBUF_F_TX_OUTER_IPV6:
+		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
+		eip_len = m->outer_l3_len >> 2;
+	break;
+	}
+
+	/* L4TUNT: L4 Tunneling Type */
+	switch (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+	case RTE_MBUF_F_TX_TUNNEL_IPIP:
+		/* for non UDP / GRE tunneling, set to 00b */
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+	case RTE_MBUF_F_TX_TUNNEL_GTP:
+	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
+		eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_GRE:
+		eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
+		break;
+	default:
+		PMD_TX_LOG(ERR, "Tunnel type not supported");
+		return;
+	}
+
+	/* L4TUNLEN: L4 Tunneling Length, in Words
+	 *
+	 * We depend on app to set rte_mbuf.l2_len correctly.
+	 * For IP in GRE it should be set to the length of the GRE
+	 * header;
+	 * For MAC in GRE or MAC in UDP it should be set to the length
+	 * of the GRE or UDP headers plus the inner MAC up to including
+	 * its last Ethertype.
+	 * If MPLS labels exists, it should include them as well.
+	 */
+	eip_typ |= (m->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
+
+	/**
+	 * Calculate the tunneling UDP checksum.
+	 * Shall be set only if L4TUNT = 01b and EIPT is not zero
+	 */
+	if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV6 |
+				IAVF_TX_CTX_EXT_IP_IPV4 |
+				IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
+			(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
+			(m->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
+		eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
+
+	*qw0 = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
+		eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
+		eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
+}
+
+static __rte_always_inline void
+ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+		uint64_t flags, bool offload, uint8_t vlan_flag)
+{
+	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
+	uint64_t low_ctx_qw = 0;
+
+	if (offload) {
+		iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw, pkt);
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				(uint64_t)pkt->vlan_tci_outer :
+				(uint64_t)pkt->vlan_tci;
+			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
+				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+		}
+#endif
+	}
+	if (IAVF_CHECK_TX_LLDP(pkt))
+		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+	uint64_t high_data_qw = (IAVF_TX_DESC_DTYPE_DATA |
+				((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
+				((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
+	if (offload)
+		iavf_txd_enable_offload(pkt, &high_data_qw, vlan_flag);
+
+	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
+							high_ctx_qw, low_ctx_qw);
+
+	_mm256_storeu_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+}
+
+static __rte_always_inline void
+ctx_vtx(volatile struct ci_tx_desc *txdp,
+		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
+		bool offload, uint8_t vlan_flag)
+{
+	uint64_t hi_data_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
+					((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
+
+	/* if unaligned on 32-bit boundary, do one to align */
+	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		nb_pkts--; txdp++; pkt++;
+	}
+
+	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
+		uint64_t hi_ctx_qw1 = IAVF_TX_DESC_DTYPE_CONTEXT;
+		uint64_t hi_ctx_qw0 = IAVF_TX_DESC_DTYPE_CONTEXT;
+		uint64_t low_ctx_qw1 = 0;
+		uint64_t low_ctx_qw0 = 0;
+		uint64_t hi_data_qw1 = 0;
+		uint64_t hi_data_qw0 = 0;
+
+		hi_data_qw1 = hi_data_qw_tmpl |
+				((uint64_t)pkt[1]->data_len <<
+					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+		hi_data_qw0 = hi_data_qw_tmpl |
+				((uint64_t)pkt[0]->data_len <<
+					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+		if (offload) {
+			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+					(uint64_t)pkt[1]->vlan_tci_outer :
+					(uint64_t)pkt[1]->vlan_tci;
+				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
+						IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw1 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw1 |=
+					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			}
+		}
+#endif
+		if (IAVF_CHECK_TX_LLDP(pkt[1]))
+			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+		if (offload) {
+			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+					(uint64_t)pkt[0]->vlan_tci_outer :
+					(uint64_t)pkt[0]->vlan_tci;
+				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
+						IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw0 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw0 |=
+					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			}
+		}
+#endif
+		if (IAVF_CHECK_TX_LLDP(pkt[0]))
+			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+
+		if (offload) {
+			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
+			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, vlan_flag);
+			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw1, pkt[1]);
+			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw0, pkt[0]);
+		}
+
+		__m256i desc2_3 =
+			_mm256_set_epi64x
+				(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
+				 hi_ctx_qw1, low_ctx_qw1);
+		__m256i desc0_1 =
+			_mm256_set_epi64x
+				(hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
+				 hi_ctx_qw0, low_ctx_qw0);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
+	}
+
+	if (nb_pkts)
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+}
+
+static __rte_always_inline uint16_t
+iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
+				 uint16_t nb_pkts, bool offload)
+{
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, nb_mbuf, tx_id;
+	/* bit2 is reserved and must be set to 1 according to Spec */
+	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
+	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts << 1);
+	nb_commit &= 0xFFFE;
+	if (unlikely(nb_commit == 0))
+		return 0;
+
+	nb_pkts = nb_commit >> 1;
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = (void *)txq->sw_ring;
+	txep += (tx_id >> 1);
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+	if (n != 0 && nb_commit >= n) {
+		nb_mbuf = n >> 1;
+		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag);
+		tx_pkts += (nb_mbuf - 1);
+		txdp += (n - 2);
+		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+		tx_id = 0;
+		/* avoid reach the end of ring */
+		txdp = txq->ci_tx_ring;
+		txep = (void *)txq->sw_ring;
+	}
+
+	nb_mbuf = nb_commit >> 1;
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag);
+	tx_id = (uint16_t)(tx_id + nb_commit);
+
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
+					 IAVF_TXD_QW1_CMD_SHIFT);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	IAVF_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+	return nb_pkts;
+}
+
+static __rte_always_inline uint16_t
+iavf_xmit_pkts_vec_avx2_ctx_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts, bool offload)
+{
+	uint16_t nb_tx = 0;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		/* cross rs_thresh boundary is not allowed */
+		num = (uint16_t)RTE_MIN(nb_pkts << 1, txq->tx_rs_thresh);
+		num = num >> 1;
+		ret = iavf_xmit_fixed_burst_vec_avx2_ctx(tx_queue, &tx_pkts[nb_tx],
+						       num, offload);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
+uint16_t
+iavf_xmit_pkts_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts)
+{
+	return iavf_xmit_pkts_vec_avx2_ctx_cmn(tx_queue, tx_pkts, nb_pkts, false);
+}
+
+uint16_t
+iavf_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts)
+{
+	return iavf_xmit_pkts_vec_avx2_ctx_cmn(tx_queue, tx_pkts, nb_pkts, true);
+}
+
 static __rte_always_inline uint16_t
 iavf_xmit_pkts_vec_avx2_common(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts, bool offload)
-- 
2.43.0

