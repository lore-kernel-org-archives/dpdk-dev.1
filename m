Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E050BC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:37:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77C3142E80;
	Tue, 15 Sep 2026 15:37:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AF45142E5D
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479438; x=1821015438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qRRA9f022uBYPW6bKK0Jd3lAkMlo+KqNMpV6ieWa5qg=;
 b=BlIUu9Ek8m2Pz3dzbLsuVc7b37Nk+tHhbCTcpgtOzYZVmKmpef+q0KRW
 8PQPl7DKKCoTOIMvPbSuoDH/gd4+QNm16lmgISR3LDOTCgPQC3dU3kwjH
 EBv7VW9Dd+C9wn9RhaN4LG/Joj/BMv5Yafbx+caz//OYgvQFPjQbJPyg9
 FQOVj8l0BItYSBeCGuiqnVrtbMrgQrT705QutUOe5W4IQFuzW60jV5gfu
 JYlikAbCTB5yxxYYkOSV8ixLvqKfwUoGr4SftRI3UVrxt0rTcej/5hM15
 jqiQGXFOzxrcYJPt+KO1iGKVG5K+k4pt3CZ1Qanxl0j5qeHqOQEMoqriC w==;
X-CSE-ConnectionGUID: /DU18sHTS/+9PVemlL9b1A==
X-CSE-MsgGUID: erJmuWtTQYqrjot2zfXNHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972525"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:17 -0700
X-CSE-ConnectionGUID: kqJplQyAS6Klcq1E7OiBrg==
X-CSE-MsgGUID: DlpuF2h7T3i4sgcR/K67Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800738"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 06/15] net/intel: move iavf descriptor writing functions to
 common
Date: Tue, 15 Sep 2026 14:36:43 +0100
Message-ID: <20260915133654.278780-7-bruce.richardson@intel.com>
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

In order to promote reuse of code, move the Tx vector functions for
writing descriptors from the iavf driver to the common folder in a new
tx_vec_x86.h file. This will allow reuse in later commits by other
drivers such as ice.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx_vec_x86.h         | 511 ++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 285 +---------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 272 +---------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  75 +--
 4 files changed, 530 insertions(+), 613 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_vec_x86.h

diff --git a/drivers/net/intel/common/tx_vec_x86.h b/drivers/net/intel/common/tx_vec_x86.h
new file mode 100644
index 0000000000..36e855eb26
--- /dev/null
+++ b/drivers/net/intel/common/tx_vec_x86.h
@@ -0,0 +1,511 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_TX_VEC_X86_H_
+#define _COMMON_INTEL_TX_VEC_X86_H_
+
+#include <stdint.h>
+
+#include <rte_mbuf.h>
+
+#include "tx.h"
+
+static __rte_always_inline void
+ci_fill_ctx_desc_tunneling(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
+{
+	if (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		uint64_t eip_typ = CI_TX_CTX_EIPT_NONE;
+		uint64_t eip_len = 0;
+		uint64_t eip_noinc = 0;
+		/* Default - IP_ID is increment in each segment of LSO */
+
+		switch (pkt->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
+				RTE_MBUF_F_TX_OUTER_IPV6 |
+				RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
+		case RTE_MBUF_F_TX_OUTER_IPV4:
+			eip_typ = CI_TX_CTX_EIPT_IPV4_NO_CSUM;
+			eip_len = pkt->outer_l3_len >> 2;
+		break;
+		case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
+			eip_typ = CI_TX_CTX_EIPT_IPV4;
+			eip_len = pkt->outer_l3_len >> 2;
+		break;
+		case RTE_MBUF_F_TX_OUTER_IPV6:
+			eip_typ = CI_TX_CTX_EIPT_IPV6;
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
+			eip_typ |= CI_TXD_CTX_UDP_TUNNELING;
+			break;
+		case RTE_MBUF_F_TX_TUNNEL_GRE:
+			eip_typ |= CI_TXD_CTX_GRE_TUNNELING;
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
+		eip_typ |= (pkt->l2_len >> 1) << CI_TXD_CTX_QW0_NATLEN_S;
+
+		/**
+		 * Calculate the tunneling UDP checksum.
+		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
+		 */
+		if ((eip_typ & (CI_TX_CTX_EIPT_IPV4 |
+					CI_TX_CTX_EIPT_IPV6 |
+					CI_TX_CTX_EIPT_IPV4_NO_CSUM)) &&
+				(eip_typ & CI_TXD_CTX_UDP_TUNNELING) &&
+				(pkt->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
+			eip_typ |= CI_TXD_CTX_QW0_L4T_CS_M;
+
+		*low_ctx_qw = eip_typ << CI_TXD_CTX_QW0_EIPT_S |
+			eip_len << CI_TXD_CTX_QW0_EIPLEN_S |
+			eip_noinc << CI_TXD_CTX_QW0_EIP_NOINC_S;
+
+	} else {
+		*low_ctx_qw = 0;
+	}
+}
+
+static __rte_always_inline void
+ci_tx_vec_offload(struct rte_mbuf *tx_pkt, uint64_t *txd_hi,
+		enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
+{
+	uint64_t ol_flags = tx_pkt->ol_flags;
+	uint32_t td_cmd = 0;
+	uint32_t td_offset = 0;
+
+	/* Set MACLEN */
+	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		td_offset |= (tx_pkt->outer_l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
+	else
+		td_offset |= (tx_pkt->l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
+
+	/* Enable L3 checksum offloads */
+	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+			td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
+			td_offset |= (tx_pkt->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+		}
+	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
+		td_offset |= (tx_pkt->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
+		td_offset |= (tx_pkt->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+	}
+
+	/* Enable L4 checksum offloads */
+	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
+		td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	case RTE_MBUF_F_TX_SCTP_CKSUM:
+		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
+		td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
+		td_offset |= (sizeof(struct rte_udp_hdr) >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	default:
+		break;
+	}
+
+	*txd_hi |= ((uint64_t)td_offset) << CI_TXD_QW1_OFFSET_S;
+
+	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
+		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
+		/* L2Tag1 always carries a tag for QinQ */
+		if (qinq_outer_pos == CI_TAG_IN_DATA_DESC)
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer << CI_TXD_QW1_L2TAG1_S);
+		else
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
+	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && single_vlan_pos == CI_TAG_IN_DATA_DESC) {
+		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
+		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
+	}
+
+	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
+}
+
+static __rte_always_inline void
+ci_vtx1(volatile struct ci_tx_desc *txdp,
+	  struct rte_mbuf *pkt, uint64_t flags, bool offload,
+	  enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
+{
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+	if (offload)
+		ci_tx_vec_offload(pkt, &high_qw, single_vlan_pos, qinq_outer_pos);
+
+	__m128i descriptor = _mm_set_epi64x(high_qw, pkt->buf_iova + pkt->data_off);
+	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
+}
+
+#ifdef __AVX2__
+
+static __rte_always_inline void
+ci_vtx_avx2(volatile struct ci_tx_desc *txdp,
+	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload,
+	 enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
+{
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
+
+	/* if unaligned on 32-bit boundary, do one to align */
+	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
+		ci_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
+		nb_pkts--; txdp++; pkt++;
+	}
+
+	/* do two at a time while possible, in bursts */
+	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		if (offload)
+			ci_tx_vec_offload(pkt[3], &hi_qw3, single_vlan_pos, qinq_outer_pos);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		if (offload)
+			ci_tx_vec_offload(pkt[2], &hi_qw2, single_vlan_pos, qinq_outer_pos);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		if (offload)
+			ci_tx_vec_offload(pkt[1], &hi_qw1, single_vlan_pos, qinq_outer_pos);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		if (offload)
+			ci_tx_vec_offload(pkt[0], &hi_qw0, single_vlan_pos, qinq_outer_pos);
+
+		__m256i desc2_3 =
+			_mm256_set_epi64x
+				(hi_qw3,
+				 pkt[3]->buf_iova + pkt[3]->data_off,
+				 hi_qw2,
+				 pkt[2]->buf_iova + pkt[2]->data_off);
+		__m256i desc0_1 =
+			_mm256_set_epi64x
+				(hi_qw1,
+				 pkt[1]->buf_iova + pkt[1]->data_off,
+				 hi_qw0,
+				 pkt[0]->buf_iova + pkt[0]->data_off);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
+	}
+
+	/* do any last ones */
+	while (nb_pkts) {
+		ci_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
+		txdp++; pkt++; nb_pkts--;
+	}
+}
+
+static __rte_always_inline void
+ci_vtx1_ctx_avx2(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
+		enum ci_l2tag_pos qinq_outer_pos, bool ptype_lldp_enabled)
+{
+	uint64_t high_ctx_qw = CI_TX_DESC_DTYPE_CTX;
+	uint64_t low_ctx_qw = 0;
+
+	if (offload) {
+		ci_fill_ctx_desc_tunneling(&low_ctx_qw, pkt);
+		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
+				(uint64_t)pkt->vlan_tci_outer :
+				(uint64_t)pkt->vlan_tci;
+			high_ctx_qw |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+			low_ctx_qw |= qinq_tag << CI_TXD_CTX_QW0_L2TAG2_S;
+		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
+				single_vlan_pos == CI_TAG_IN_CTX_DESC) {
+			high_ctx_qw |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+			low_ctx_qw |= (uint64_t)pkt->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
+		}
+	}
+	if (IAVF_CHECK_TX_LLDP(pkt, ptype_lldp_enabled))
+		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)flags  << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+	if (offload)
+		ci_tx_vec_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
+
+	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
+							high_ctx_qw, low_ctx_qw);
+
+	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
+	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+}
+
+static __rte_always_inline void
+ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
+		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
+		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
+		bool ptype_lldp_enabled)
+{
+	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags  << CI_TXD_QW1_CMD_S));
+
+	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
+		uint64_t hi_ctx_qw1 = CI_TX_DESC_DTYPE_CTX;
+		uint64_t hi_ctx_qw0 = CI_TX_DESC_DTYPE_CTX;
+		uint64_t low_ctx_qw1 = 0;
+		uint64_t low_ctx_qw0 = 0;
+		uint64_t hi_data_qw1 = 0;
+		uint64_t hi_data_qw0 = 0;
+
+		hi_data_qw1 = hi_data_qw_tmpl |
+				((uint64_t)pkt[1]->data_len <<
+					CI_TXD_QW1_TX_BUF_SZ_S);
+		hi_data_qw0 = hi_data_qw_tmpl |
+				((uint64_t)pkt[0]->data_len <<
+					CI_TXD_QW1_TX_BUF_SZ_S);
+
+		if (offload) {
+			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
+			ci_fill_ctx_desc_tunneling(&low_ctx_qw1, pkt[1]);
+			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
+					(uint64_t)pkt[1]->vlan_tci_outer :
+					(uint64_t)pkt[1]->vlan_tci;
+				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw1 |= qinq_tag << CI_TXD_CTX_QW0_L2TAG2_S;
+			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
+				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
+			}
+		}
+		if (IAVF_CHECK_TX_LLDP(pkt[1], ptype_lldp_enabled))
+			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+
+		if (offload) {
+			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
+			ci_fill_ctx_desc_tunneling(&low_ctx_qw0, pkt[0]);
+			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
+					(uint64_t)pkt[0]->vlan_tci_outer :
+					(uint64_t)pkt[0]->vlan_tci;
+				hi_ctx_qw0 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw0 |= qinq_tag << CI_TXD_CTX_QW0_L2TAG2_S;
+			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
+				hi_ctx_qw0 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
+			}
+		}
+		if (IAVF_CHECK_TX_LLDP(pkt[0], ptype_lldp_enabled))
+			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+
+		if (offload) {
+			ci_tx_vec_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
+			ci_tx_vec_offload(pkt[0], &hi_data_qw0, single_vlan_pos, qinq_outer_pos);
+		}
+
+		__m256i desc2_3 = _mm256_set_epi64x
+				(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
+				 hi_ctx_qw1, low_ctx_qw1);
+		__m256i desc0_1 = _mm256_set_epi64x
+				(hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
+				 hi_ctx_qw0, low_ctx_qw0);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
+	}
+
+	if (nb_pkts)
+		ci_vtx1_ctx_avx2(txdp, *pkt, flags, offload,
+				single_vlan_pos, qinq_outer_pos, ptype_lldp_enabled);
+}
+
+#endif /* __AVX2__ */
+
+#ifdef __AVX512VL__
+
+static __rte_always_inline void
+ci_vtx_avx512(volatile struct ci_tx_desc *txdp,
+		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
+		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
+{
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
+
+	/* if unaligned on 32-bit boundary, do one to align */
+	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
+		ci_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
+		nb_pkts--; txdp++; pkt++;
+	}
+
+	/* do 4 at a time while possible, in bursts */
+	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		if (offload) {
+			ci_tx_vec_offload(pkt[3], &hi_qw3, single_vlan_pos, qinq_outer_pos);
+			ci_tx_vec_offload(pkt[2], &hi_qw2, single_vlan_pos, qinq_outer_pos);
+			ci_tx_vec_offload(pkt[1], &hi_qw1, single_vlan_pos, qinq_outer_pos);
+			ci_tx_vec_offload(pkt[0], &hi_qw0, single_vlan_pos, qinq_outer_pos);
+		}
+
+		__m512i desc0_3 =
+			_mm512_set_epi64
+				(hi_qw3,
+				 pkt[3]->buf_iova + pkt[3]->data_off,
+				 hi_qw2,
+				 pkt[2]->buf_iova + pkt[2]->data_off,
+				 hi_qw1,
+				 pkt[1]->buf_iova + pkt[1]->data_off,
+				 hi_qw0,
+				 pkt[0]->buf_iova + pkt[0]->data_off);
+		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
+	}
+
+	/* do any last ones */
+	while (nb_pkts) {
+		ci_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
+		txdp++; pkt++; nb_pkts--;
+	}
+}
+
+static __rte_always_inline void
+ci_vtx1_ctx_avx512(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
+		enum ci_l2tag_pos qinq_outer_pos, bool lldp_enabled)
+{
+	uint64_t high_ctx_qw = CI_TX_DESC_DTYPE_CTX;
+	uint64_t low_ctx_qw = 0;
+
+	if (offload) {
+		ci_fill_ctx_desc_tunneling(&low_ctx_qw, pkt);
+		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
+				(uint64_t)pkt->vlan_tci_outer :
+				(uint64_t)pkt->vlan_tci;
+			high_ctx_qw |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+			low_ctx_qw |= qinq_tag << CI_TXD_CTX_QW0_L2TAG2_S;
+		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
+				single_vlan_pos == CI_TAG_IN_CTX_DESC) {
+			high_ctx_qw |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+			low_ctx_qw |= (uint64_t)pkt->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
+		}
+	}
+	if (IAVF_CHECK_TX_LLDP(pkt, lldp_enabled))
+		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+	if (offload)
+		ci_tx_vec_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
+
+	__m256i ctx_data_desc = _mm256_set_epi64x
+			(high_data_qw, pkt->buf_iova + pkt->data_off,
+			high_ctx_qw, low_ctx_qw);
+
+	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
+	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+}
+
+static __rte_always_inline void
+ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
+		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
+		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
+		bool lldp_enabled)
+{
+	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
+
+	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
+		uint64_t hi_ctx_qw1 = CI_TX_DESC_DTYPE_CTX;
+		uint64_t hi_ctx_qw0 = CI_TX_DESC_DTYPE_CTX;
+		uint64_t low_ctx_qw1 = 0;
+		uint64_t low_ctx_qw0 = 0;
+		uint64_t hi_data_qw1 = 0;
+		uint64_t hi_data_qw0 = 0;
+
+		hi_data_qw1 = hi_data_qw_tmpl |
+				((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		hi_data_qw0 = hi_data_qw_tmpl |
+				((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+
+		if (offload) {
+			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
+			ci_fill_ctx_desc_tunneling(&low_ctx_qw1, pkt[1]);
+			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
+					(uint64_t)pkt[1]->vlan_tci_outer :
+					(uint64_t)pkt[1]->vlan_tci;
+				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw1 |= qinq_tag << CI_TXD_CTX_QW0_L2TAG2_S;
+			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
+				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
+			}
+		}
+		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_enabled))
+			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+
+		if (offload) {
+			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
+			ci_fill_ctx_desc_tunneling(&low_ctx_qw0, pkt[0]);
+			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
+					(uint64_t)pkt[0]->vlan_tci_outer :
+					(uint64_t)pkt[0]->vlan_tci;
+				hi_ctx_qw0 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw0 |= qinq_tag << CI_TXD_CTX_QW0_L2TAG2_S;
+			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
+				hi_ctx_qw0 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
+				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
+			}
+		}
+		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_enabled))
+			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+
+		if (offload) {
+			ci_tx_vec_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
+			ci_tx_vec_offload(pkt[0], &hi_data_qw0, single_vlan_pos, qinq_outer_pos);
+		}
+
+		__m512i desc0_3 = _mm512_set_epi64
+				(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
+				hi_ctx_qw1, low_ctx_qw1,
+				hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
+				hi_ctx_qw0, low_ctx_qw0);
+		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
+	}
+
+	if (nb_pkts)
+		ci_vtx1_ctx_avx512(txdp, *pkt, flags, offload,
+				single_vlan_pos, qinq_outer_pos, lldp_enabled);
+}
+
+#endif /* __AVX512VL__ */
+
+#endif /* _COMMON_INTEL_TX_VEC_X86_H_ */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index f95aabe577..1d0492edd9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1617,77 +1617,6 @@ iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload(void *rx_queue,
 }
 
 
-static __rte_always_inline void
-iavf_vtx1(volatile struct ci_tx_desc *txdp,
-	  struct rte_mbuf *pkt, uint64_t flags, bool offload,
-	  enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
-{
-	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-	if (offload)
-		iavf_txd_enable_offload(pkt, &high_qw, single_vlan_pos, qinq_outer_pos);
-
-	__m128i descriptor = _mm_set_epi64x(high_qw,
-				pkt->buf_iova + pkt->data_off);
-	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
-static __rte_always_inline void
-iavf_vtx(volatile struct ci_tx_desc *txdp,
-	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload,
-	 enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
-{
-	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
-
-	/* if unaligned on 32-bit boundary, do one to align */
-	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
-		nb_pkts--; txdp++; pkt++;
-	}
-
-	/* do two at a time while possible, in bursts */
-	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 = hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			iavf_txd_enable_offload(pkt[3], &hi_qw3, single_vlan_pos, qinq_outer_pos);
-		uint64_t hi_qw2 = hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			iavf_txd_enable_offload(pkt[2], &hi_qw2, single_vlan_pos, qinq_outer_pos);
-		uint64_t hi_qw1 = hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			iavf_txd_enable_offload(pkt[1], &hi_qw1, single_vlan_pos, qinq_outer_pos);
-		uint64_t hi_qw0 = hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload)
-			iavf_txd_enable_offload(pkt[0], &hi_qw0, single_vlan_pos, qinq_outer_pos);
-
-		__m256i desc2_3 =
-			_mm256_set_epi64x
-				(hi_qw3,
-				 pkt[3]->buf_iova + pkt[3]->data_off,
-				 hi_qw2,
-				 pkt[2]->buf_iova + pkt[2]->data_off);
-		__m256i desc0_1 =
-			_mm256_set_epi64x
-				(hi_qw1,
-				 pkt[1]->buf_iova + pkt[1]->data_off,
-				 hi_qw0,
-				 pkt[0]->buf_iova + pkt[0]->data_off);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
-	}
-
-	/* do any last ones */
-	while (nb_pkts) {
-		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
-		txdp++; pkt++; nb_pkts--;
-	}
-}
-
 static __rte_always_inline uint16_t
 iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts, bool offload)
@@ -1721,11 +1650,11 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
-		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
+		ci_vtx_avx2(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		iavf_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
+		ci_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -1739,7 +1668,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
-	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
+	ci_vtx_avx2(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
@@ -1756,207 +1685,6 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_pkts;
 }
 
-static inline void
-iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
-{
-	if (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-		uint64_t eip_typ = CI_TX_CTX_EIPT_NONE;
-		uint64_t eip_len = 0;
-		uint64_t eip_noinc = 0;
-		/* Default - IP_ID is increment in each segment of LSO */
-
-		switch (pkt->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
-				RTE_MBUF_F_TX_OUTER_IPV6 |
-				RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
-		case RTE_MBUF_F_TX_OUTER_IPV4:
-			eip_typ = CI_TX_CTX_EIPT_IPV4_NO_CSUM;
-			eip_len = pkt->outer_l3_len >> 2;
-		break;
-		case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-			eip_typ = CI_TX_CTX_EIPT_IPV4;
-			eip_len = pkt->outer_l3_len >> 2;
-		break;
-		case RTE_MBUF_F_TX_OUTER_IPV6:
-			eip_typ = CI_TX_CTX_EIPT_IPV6;
-			eip_len = pkt->outer_l3_len >> 2;
-		break;
-		}
-
-		/* L4TUNT: L4 Tunneling Type */
-		switch (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-		case RTE_MBUF_F_TX_TUNNEL_IPIP:
-			/* for non UDP / GRE tunneling, set to 00b */
-			break;
-		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
-		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
-		case RTE_MBUF_F_TX_TUNNEL_GTP:
-		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-			eip_typ |= CI_TXD_CTX_UDP_TUNNELING;
-			break;
-		case RTE_MBUF_F_TX_TUNNEL_GRE:
-			eip_typ |= CI_TXD_CTX_GRE_TUNNELING;
-			break;
-		default:
-			PMD_TX_LOG(ERR, "Tunnel type not supported");
-			return;
-		}
-
-		/* L4TUNLEN: L4 Tunneling Length, in Words
-		 *
-		 * We depend on app to set rte_mbuf.l2_len correctly.
-		 * For IP in GRE it should be set to the length of the GRE
-		 * header;
-		 * For MAC in GRE or MAC in UDP it should be set to the length
-		 * of the GRE or UDP headers plus the inner MAC up to including
-		 * its last Ethertype.
-		 * If MPLS labels exists, it should include them as well.
-		 */
-		eip_typ |= (pkt->l2_len >> 1) << CI_TXD_CTX_QW0_NATLEN_S;
-
-		/**
-		 * Calculate the tunneling UDP checksum.
-		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
-		 */
-		if ((eip_typ & (CI_TX_CTX_EIPT_IPV4 |
-					CI_TX_CTX_EIPT_IPV6 |
-					CI_TX_CTX_EIPT_IPV4_NO_CSUM)) &&
-				(eip_typ & CI_TXD_CTX_UDP_TUNNELING) &&
-				(pkt->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-			eip_typ |= CI_TXD_CTX_QW0_L4T_CS_M;
-
-		*low_ctx_qw = eip_typ << CI_TXD_CTX_QW0_EIPT_S |
-			eip_len << CI_TXD_CTX_QW0_EIPLEN_S |
-			eip_noinc << CI_TXD_CTX_QW0_EIP_NOINC_S;
-
-	} else {
-		*low_ctx_qw = 0;
-	}
-}
-
-static __rte_always_inline void
-ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
-		enum ci_l2tag_pos qinq_outer_pos, bool ptype_lldp_enabled)
-{
-	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
-	uint64_t low_ctx_qw = 0;
-
-	if (offload) {
-		iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw, pkt);
-		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
-			uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
-				(uint64_t)pkt->vlan_tci_outer :
-				(uint64_t)pkt->vlan_tci;
-			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
-				single_vlan_pos == CI_TAG_IN_CTX_DESC) {
-			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-		}
-	}
-	if (IAVF_CHECK_TX_LLDP(pkt, ptype_lldp_enabled))
-		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-	uint64_t high_data_qw = (IAVF_TX_DESC_DTYPE_DATA |
-				((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
-				((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
-	if (offload)
-		iavf_txd_enable_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
-
-	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
-							high_ctx_qw, low_ctx_qw);
-
-	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
-	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
-}
-
-static __rte_always_inline void
-ctx_vtx(volatile struct ci_tx_desc *txdp,
-		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
-		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
-		bool ptype_lldp_enabled)
-{
-	uint64_t hi_data_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
-					((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
-
-	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
-		uint64_t hi_ctx_qw1 = IAVF_TX_DESC_DTYPE_CONTEXT;
-		uint64_t hi_ctx_qw0 = IAVF_TX_DESC_DTYPE_CONTEXT;
-		uint64_t low_ctx_qw1 = 0;
-		uint64_t low_ctx_qw0 = 0;
-		uint64_t hi_data_qw1 = 0;
-		uint64_t hi_data_qw0 = 0;
-
-		hi_data_qw1 = hi_data_qw_tmpl |
-				((uint64_t)pkt[1]->data_len <<
-					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
-		hi_data_qw0 = hi_data_qw_tmpl |
-				((uint64_t)pkt[0]->data_len <<
-					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
-
-		if (offload) {
-			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw1, pkt[1]);
-			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
-					(uint64_t)pkt[1]->vlan_tci_outer :
-					(uint64_t)pkt[1]->vlan_tci;
-				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
-						IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
-				hi_ctx_qw1 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw1 |=
-					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			}
-		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1], ptype_lldp_enabled))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-
-		if (offload) {
-			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw0, pkt[0]);
-			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
-					(uint64_t)pkt[0]->vlan_tci_outer :
-					(uint64_t)pkt[0]->vlan_tci;
-				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
-						IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
-				hi_ctx_qw0 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			}
-		}
-		if (IAVF_CHECK_TX_LLDP(pkt[0], ptype_lldp_enabled))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-
-		if (offload) {
-			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
-			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, single_vlan_pos, qinq_outer_pos);
-		}
-
-		__m256i desc2_3 =
-			_mm256_set_epi64x
-				(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
-				 hi_ctx_qw1, low_ctx_qw1);
-		__m256i desc0_1 =
-			_mm256_set_epi64x
-				(hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
-				 hi_ctx_qw0, low_ctx_qw0);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
-	}
-
-	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos, ptype_lldp_enabled);
-}
-
 static __rte_always_inline uint16_t
 iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts, bool offload)
@@ -1994,10 +1722,11 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
+		ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
+				vlan_pos, vlan_pos, lldp_enabled);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_enabled);
+		ci_vtx1_ctx_avx2(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_enabled);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2011,7 +1740,7 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
+	ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 74d91fff31..0c738e4882 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1827,266 +1827,8 @@ tx_backlog_entry_avx512(struct ci_tx_entry_vec *txep,
 		txep[i].mbuf = tx_pkts[i];
 }
 
-static __rte_always_inline void
-iavf_vtx1(volatile struct ci_tx_desc *txdp,
-	  struct rte_mbuf *pkt, uint64_t flags,
-	  bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
-{
-	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-	if (offload)
-		iavf_txd_enable_offload(pkt, &high_qw, single_vlan_pos, qinq_outer_pos);
-
-	__m128i descriptor = _mm_set_epi64x(high_qw,
-					    pkt->buf_iova + pkt->data_off);
-	_mm_storeu_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
 #define IAVF_TX_LEN_MASK 0xAA
 #define IAVF_TX_OFF_MASK 0x55
-static __rte_always_inline void
-iavf_vtx(volatile struct ci_tx_desc *txdp,
-		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
-{
-	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
-
-	/* if unaligned on 32-bit boundary, do one to align */
-	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
-		nb_pkts--; txdp++; pkt++;
-	}
-
-	/* do 4 at a time while possible, in bursts */
-	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 = hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw2 = hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw1 = hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw0 = hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		if (offload) {
-			iavf_txd_enable_offload(pkt[3], &hi_qw3, single_vlan_pos, qinq_outer_pos);
-			iavf_txd_enable_offload(pkt[2], &hi_qw2, single_vlan_pos, qinq_outer_pos);
-			iavf_txd_enable_offload(pkt[1], &hi_qw1, single_vlan_pos, qinq_outer_pos);
-			iavf_txd_enable_offload(pkt[0], &hi_qw0, single_vlan_pos, qinq_outer_pos);
-		}
-
-		__m512i desc0_3 =
-			_mm512_set_epi64
-				(hi_qw3,
-				 pkt[3]->buf_iova + pkt[3]->data_off,
-				 hi_qw2,
-				 pkt[2]->buf_iova + pkt[2]->data_off,
-				 hi_qw1,
-				 pkt[1]->buf_iova + pkt[1]->data_off,
-				 hi_qw0,
-				 pkt[0]->buf_iova + pkt[0]->data_off);
-		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
-	}
-
-	/* do any last ones */
-	while (nb_pkts) {
-		iavf_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos);
-		txdp++; pkt++; nb_pkts--;
-	}
-}
-
-static __rte_always_inline void
-iavf_fill_ctx_desc_tunneling_avx512(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
-{
-	if (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-		uint64_t eip_typ = CI_TX_CTX_EIPT_NONE;
-		uint64_t eip_len = 0;
-		uint64_t eip_noinc = 0;
-		/* Default - IP_ID is increment in each segment of LSO */
-
-		switch (pkt->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
-				RTE_MBUF_F_TX_OUTER_IPV6 |
-				RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
-		case RTE_MBUF_F_TX_OUTER_IPV4:
-			eip_typ = CI_TX_CTX_EIPT_IPV4_NO_CSUM;
-			eip_len = pkt->outer_l3_len >> 2;
-		break;
-		case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-			eip_typ = CI_TX_CTX_EIPT_IPV4;
-			eip_len = pkt->outer_l3_len >> 2;
-		break;
-		case RTE_MBUF_F_TX_OUTER_IPV6:
-			eip_typ = CI_TX_CTX_EIPT_IPV6;
-			eip_len = pkt->outer_l3_len >> 2;
-		break;
-		}
-
-		/* L4TUNT: L4 Tunneling Type */
-		switch (pkt->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-		case RTE_MBUF_F_TX_TUNNEL_IPIP:
-			/* for non UDP / GRE tunneling, set to 00b */
-			break;
-		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
-		case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
-		case RTE_MBUF_F_TX_TUNNEL_GTP:
-		case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-			eip_typ |= CI_TXD_CTX_UDP_TUNNELING;
-			break;
-		case RTE_MBUF_F_TX_TUNNEL_GRE:
-			eip_typ |= CI_TXD_CTX_GRE_TUNNELING;
-			break;
-		default:
-			PMD_TX_LOG(ERR, "Tunnel type not supported");
-			return;
-		}
-
-		/* L4TUNLEN: L4 Tunneling Length, in Words
-		 *
-		 * We depend on app to set rte_mbuf.l2_len correctly.
-		 * For IP in GRE it should be set to the length of the GRE
-		 * header;
-		 * For MAC in GRE or MAC in UDP it should be set to the length
-		 * of the GRE or UDP headers plus the inner MAC up to including
-		 * its last Ethertype.
-		 * If MPLS labels exists, it should include them as well.
-		 */
-		eip_typ |= (pkt->l2_len >> 1) << CI_TXD_CTX_QW0_NATLEN_S;
-
-		/**
-		 * Calculate the tunneling UDP checksum.
-		 * Shall be set only if L4TUNT = 01b and EIPT is not zero
-		 */
-		if ((eip_typ & (CI_TX_CTX_EIPT_IPV4 |
-					CI_TX_CTX_EIPT_IPV6 |
-					CI_TX_CTX_EIPT_IPV4_NO_CSUM)) &&
-				(eip_typ & CI_TXD_CTX_UDP_TUNNELING) &&
-				(pkt->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-			eip_typ |= CI_TXD_CTX_QW0_L4T_CS_M;
-
-		*low_ctx_qw = eip_typ << CI_TXD_CTX_QW0_EIPT_S |
-			eip_len << CI_TXD_CTX_QW0_EIPLEN_S |
-			eip_noinc << CI_TXD_CTX_QW0_EIP_NOINC_S;
-
-	} else {
-		*low_ctx_qw = 0;
-	}
-}
-
-static __rte_always_inline void
-ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
-		enum ci_l2tag_pos qinq_outer_pos, bool lldp_enabled)
-{
-	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
-	uint64_t low_ctx_qw = 0;
-
-	if (offload) {
-		iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
-		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
-			uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
-				(uint64_t)pkt->vlan_tci_outer :
-				(uint64_t)pkt->vlan_tci;
-			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
-				single_vlan_pos == CI_TAG_IN_CTX_DESC) {
-			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-		}
-	}
-	if (IAVF_CHECK_TX_LLDP(pkt, lldp_enabled))
-		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
-	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
-				((uint64_t)flags << CI_TXD_QW1_CMD_S) |
-				((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-	if (offload)
-		iavf_txd_enable_offload(pkt, &high_data_qw, single_vlan_pos, qinq_outer_pos);
-
-	__m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw, pkt->buf_iova + pkt->data_off,
-							high_ctx_qw, low_ctx_qw);
-
-	/* tx_id is always even in ctx mode, so txdp is always 32-byte aligned */
-	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
-}
-
-static __rte_always_inline void
-ctx_vtx(volatile struct ci_tx_desc *txdp,
-		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
-		bool lldp_enabled)
-{
-	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
-
-	for (; nb_pkts > 1; txdp += 4, pkt += 2, nb_pkts -= 2) {
-		uint64_t hi_ctx_qw1 = IAVF_TX_DESC_DTYPE_CONTEXT;
-		uint64_t hi_ctx_qw0 = IAVF_TX_DESC_DTYPE_CONTEXT;
-		uint64_t low_ctx_qw1 = 0;
-		uint64_t low_ctx_qw0 = 0;
-		uint64_t hi_data_qw1 = 0;
-		uint64_t hi_data_qw0 = 0;
-
-		hi_data_qw1 = hi_data_qw_tmpl |
-				((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-		hi_data_qw0 = hi_data_qw_tmpl |
-				((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
-
-		if (offload) {
-			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw1, pkt[1]);
-			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
-					(uint64_t)pkt[1]->vlan_tci_outer :
-					(uint64_t)pkt[1]->vlan_tci;
-				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
-				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
-				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
-				low_ctx_qw1 |=
-					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			}
-		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_enabled))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-				<< CI_TXD_QW1_CMD_S;
-
-		if (offload) {
-			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw0, pkt[0]);
-			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
-					(uint64_t)pkt[0]->vlan_tci_outer :
-					(uint64_t)pkt[0]->vlan_tci;
-				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
-				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					single_vlan_pos == CI_TAG_IN_CTX_DESC) {
-				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
-				low_ctx_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			}
-		}
-		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_enabled))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
-
-		if (offload) {
-			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
-			iavf_txd_enable_offload(pkt[0], &hi_data_qw0, single_vlan_pos, qinq_outer_pos);
-		}
-
-		__m512i desc0_3 =
-				_mm512_set_epi64
-						(hi_data_qw1, pkt[1]->buf_iova + pkt[1]->data_off,
-						hi_ctx_qw1, low_ctx_qw1,
-						hi_data_qw0, pkt[0]->buf_iova + pkt[0]->data_off,
-						hi_ctx_qw0, low_ctx_qw0);
-		_mm512_storeu_si512(RTE_CAST_PTR(void *, txdp), desc0_3);
-	}
-
-	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, single_vlan_pos, qinq_outer_pos, lldp_enabled);
-}
 
 static __rte_always_inline uint16_t
 iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
@@ -2122,11 +1864,11 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (nb_commit >= n) {
 		tx_backlog_entry_avx512(txep, tx_pkts, n);
 
-		iavf_vtx(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
+		ci_vtx_avx512(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
 		tx_pkts += (n - 1);
 		txdp += (n - 1);
 
-		iavf_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
+		ci_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2141,7 +1883,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
 
-	iavf_vtx(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
+	ci_vtx_avx512(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
@@ -2195,10 +1937,12 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
+		ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
+				vlan_pos, vlan_pos, lldp_enabled);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_enabled);
+		ci_vtx1_ctx_avx512(txdp, *tx_pkts++, rs, offload,
+				vlan_pos, vlan_pos, lldp_enabled);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2212,7 +1956,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
+	ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index e99964eaef..61478036ec 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -11,6 +11,10 @@
 #include "iavf.h"
 #include "iavf_rxtx.h"
 
+#ifdef RTE_ARCH_X86
+#include "../common/tx_vec_x86.h"
+#endif
+
 static inline int
 iavf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
@@ -119,75 +123,4 @@ iavf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static __rte_always_inline void
-iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
-			uint64_t *txd_hi, enum ci_l2tag_pos single_vlan_pos,
-			enum ci_l2tag_pos qinq_outer_pos)
-{
-	uint64_t ol_flags = tx_pkt->ol_flags;
-	uint32_t td_cmd = 0;
-	uint32_t td_offset = 0;
-
-	/* Set MACLEN */
-	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
-		td_offset |= (tx_pkt->outer_l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
-	else
-		td_offset |= (tx_pkt->l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
-
-	/* Enable L3 checksum offloads */
-	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-			td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
-			td_offset |= (tx_pkt->l3_len >> 2) <<
-				     CI_TX_DESC_LEN_IPLEN_S;
-		}
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
-		td_offset |= (tx_pkt->l3_len >> 2) <<
-			     CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
-		td_offset |= (tx_pkt->l3_len >> 2) <<
-			     CI_TX_DESC_LEN_IPLEN_S;
-	}
-
-	/* Enable L4 checksum offloads */
-	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
-	case RTE_MBUF_F_TX_TCP_CKSUM:
-		td_cmd |= IAVF_TX_DESC_CMD_L4T_EOFT_TCP;
-		td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-			     IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
-		break;
-	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		td_cmd |= IAVF_TX_DESC_CMD_L4T_EOFT_SCTP;
-		td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-			     IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
-		break;
-	case RTE_MBUF_F_TX_UDP_CKSUM:
-		td_cmd |= IAVF_TX_DESC_CMD_L4T_EOFT_UDP;
-		td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-			     IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
-		break;
-	default:
-		break;
-	}
-
-	*txd_hi |= ((uint64_t)td_offset) << CI_TXD_QW1_OFFSET_S;
-
-	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
-		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
-		/* L2Tag1 always carries a tag for QinQ */
-		if (qinq_outer_pos == CI_TAG_IN_DATA_DESC)
-			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer << CI_TXD_QW1_L2TAG1_S);
-		else
-			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
-	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && single_vlan_pos == CI_TAG_IN_DATA_DESC) {
-		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
-		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
-	}
-
-	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
-}
 #endif
-- 
2.53.0

