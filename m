Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E9C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3CB9427D4;
	Thu,  3 Sep 2026 16:38:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id EF77E42DCE
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788446326; x=1819982326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IEbkgO8jjKBQbgJrWNUo0GtZfwX341afOCMufEsF2yw=;
 b=EElBEFZIOfjSsQaSr18r4onVTNHW786MQAQAuNflz6yHdN1I8GOUArDR
 IgJGlxbcXBwfVfhZ9ziEQ713RwQEhGqbVvrNpnrE9OklmgqJFrNGA20Vc
 jMmgxEoA57E6yt1KYn8uNwVEkW06RuuS1bz9GvCxFPf2oN5HvuT9MMa5e
 3q8W6rbOb+JJHnf897hEU1KMnoiKhXFMKGQCW1ERDDSZHJDXbd4bsYOfk
 OKFCgZZW1vz/oItDKJamWaRHDnsRKN1GGztXpLBH6t2C/1zsF9eAVL5U/
 OLC283JJYyib92yjD8/9PAoUDA3ztuDMPmSiotfFsOi3kpRw4Oikaas3R g==;
X-CSE-ConnectionGUID: CJEEzMwbT3uTr8N1Bt4bKw==
X-CSE-MsgGUID: 2LGhiK8eSDWgxY2qbS+E0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87869793"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87869793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:38:45 -0700
X-CSE-ConnectionGUID: fJlOS+L2SiuCnV4bpFtNnA==
X-CSE-MsgGUID: MYsYkPi6Q1yWqjoralgmfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273894977"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 07:38:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 7/7] net/iavf: remove undocumented conditional macros
Date: Thu,  3 Sep 2026 15:37:29 +0100
Message-ID: <20260903143827.327131-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903143827.327131-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260903143827.327131-1-bruce.richardson@intel.com>
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

The iavf driver included two #defines which enabled the QinQ and
checksum offload in the code. The intent as documented in code comments
was that any user not taking advantage of these features could remove
the #defines to cut out some code. However, this was never actually
publicly documented, and the use of these defines was never tested in
any builds, making them fragile - if not already broken. Therefore, just
remove these build time macros.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  6 ------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  6 ------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 18 ------------------
 3 files changed, 30 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index d05e6101ad..7217f32cef 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1910,7 +1910,6 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 
 	if (offload) {
 		iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw, pkt);
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
 			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 				(uint64_t)pkt->vlan_tci_outer :
@@ -1922,7 +1921,6 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
-#endif
 	}
 	if (IAVF_CHECK_TX_LLDP(pkt, ptype_lldp_enabled))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
@@ -1967,7 +1965,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 				((uint64_t)pkt[0]->data_len <<
 					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw1, pkt[1]);
@@ -1986,11 +1983,9 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
-#endif
 		if (IAVF_CHECK_TX_LLDP(pkt[1], ptype_lldp_enabled))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw0, pkt[0]);
@@ -2009,7 +2004,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
-#endif
 		if (IAVF_CHECK_TX_LLDP(pkt[0], ptype_lldp_enabled))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index bae9b2af9c..bf0245e8f4 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2054,7 +2054,6 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 
 	if (offload) {
 		iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
 			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 				(uint64_t)pkt->vlan_tci_outer :
@@ -2066,7 +2065,6 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
-#endif
 	}
 	if (IAVF_CHECK_TX_LLDP(pkt, lldp_enabled))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
@@ -2109,7 +2107,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		hi_data_qw0 = hi_data_qw_tmpl |
 				((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw1, pkt[1]);
@@ -2126,12 +2123,10 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
-#endif
 		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_enabled))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< CI_TXD_QW1_CMD_S;
 
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
 			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw0, pkt[0]);
@@ -2148,7 +2143,6 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
-#endif
 		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_enabled))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 1538a44892..1e9ce924ee 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -119,31 +119,16 @@ iavf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return ret;
 }
 
-/******************************************************************************
- * If user knows a specific offload is not enabled by APP,
- * the macro can be commented to save the effort of fast path.
- * Currently below 2 features are supported in TX path,
- * 1, checksum offload
- * 2, VLAN/QINQ insertion
- ******************************************************************************/
-#define IAVF_TX_CSUM_OFFLOAD
-#define IAVF_TX_VLAN_QINQ_OFFLOAD
-
 static __rte_always_inline void
 iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 			uint64_t *txd_hi, uint8_t vlan_flag)
 {
-#if defined(IAVF_TX_CSUM_OFFLOAD) || defined(IAVF_TX_VLAN_QINQ_OFFLOAD)
 	uint64_t ol_flags = tx_pkt->ol_flags;
-#endif
 	uint32_t td_cmd = 0;
-#ifdef IAVF_TX_CSUM_OFFLOAD
 	uint32_t td_offset = 0;
-#endif
 
 	RTE_SET_USED(vlan_flag);
 
-#ifdef IAVF_TX_CSUM_OFFLOAD
 	/* Set MACLEN */
 	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
 		td_offset |= (tx_pkt->outer_l2_len >> 1)
@@ -191,9 +176,7 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 	}
 
 	*txd_hi |= ((uint64_t)td_offset) << CI_TXD_QW1_OFFSET_S;
-#endif
 
-#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
 		/* vlan_flag specifies outer tag location for QinQ. */
@@ -205,7 +188,6 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
 	}
-#endif
 
 	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
 }
-- 
2.53.0

