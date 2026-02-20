Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D234DC5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E641240650;
	Fri, 20 Feb 2026 11:14:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 56AC74042C
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582491; x=1803118491;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hXosBZKmAxYlW0wQiqGYJBp+ERrtMLMvafE7yLPio9o=;
 b=DotHAN5zPIamaioP7yjf00m+BQYbk8qp7vmSKSHb0Fnq1TYUUHuqv2HE
 0kitTLZNFFAws0Li8odbc8Z9nq8UvjigUturmRd8FqwBD1820yNDaq608
 uYtPll2iTOLJmdPA42BJCTxbhGFr+7/SAf6L+LteE8wCtjjXWK9LwQmoJ
 UOhzhkJRpSqEGxc/7shwcwK/jBbQlHZMQUAqI8kOZDCFJFK3KLVRI17LA
 6Azsj1CVYtnElBiSADbKzoEHfkz9hYPg6qgDmYxeBAsTf+n8FcnW///3Y
 60t64KXRxPAdwuaLCxdINQRBOUJj1q1525yrBj5qckQIi5nCaG66gcyVx Q==;
X-CSE-ConnectionGUID: DJxwCzSTRCKhhNm0t+Es4Q==
X-CSE-MsgGUID: 7KqzPbXRQ0KHW9BmdrcxOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283333"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283333"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:14:50 -0800
X-CSE-ConnectionGUID: lRMONwq3Q0StZoOVq9N2gA==
X-CSE-MsgGUID: i8qjAitsTTKIhCrq3yFnrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038414"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:14:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 02/27] net/ixgbe: remove security-related ifdefery
Date: Fri, 20 Feb 2026 10:14:09 +0000
Message-ID: <dd3952dc1c591f5d559b1ee11944d9bd75ff4a02.1771582362.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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

The security library is specified as explicit dependency for ixgbe, so
there is no more need to gate features behind #ifdef blocks that depend
on presence of this library.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c       |  8 ------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h       |  4 ---
 drivers/net/intel/ixgbe/ixgbe_flow.c         |  6 -----
 drivers/net/intel/ixgbe/ixgbe_rxtx.c         | 26 --------------------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h         |  2 --
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c |  6 -----
 6 files changed, 52 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 11500a923c..57d929cf2c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -32,9 +32,7 @@
 #include <rte_random.h>
 #include <dev_driver.h>
 #include <rte_hash_crc.h>
-#ifdef RTE_LIB_SECURITY
 #include <rte_security_driver.h>
-#endif
 #include <rte_os_shim.h>
 
 #include "ixgbe_logs.h"
@@ -1177,11 +1175,9 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	/* Unlock any pending hardware semaphore */
 	ixgbe_swfw_lock_reset(hw);
 
-#ifdef RTE_LIB_SECURITY
 	/* Initialize security_ctx only for primary process*/
 	if (ixgbe_ipsec_ctx_create(eth_dev))
 		return -ENOMEM;
-#endif
 
 	/* Initialize DCB configuration*/
 	memset(dcb_config, 0, sizeof(struct ixgbe_dcb_config));
@@ -1362,10 +1358,8 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	rte_free(eth_dev->data->hash_mac_addrs);
 	eth_dev->data->hash_mac_addrs = NULL;
 err_exit:
-#ifdef RTE_LIB_SECURITY
 	rte_free(eth_dev->security_ctx);
 	eth_dev->security_ctx = NULL;
-#endif
 	return ret;
 }
 
@@ -3148,10 +3142,8 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* Remove all Traffic Manager configuration */
 	ixgbe_tm_conf_uninit(dev);
 
-#ifdef RTE_LIB_SECURITY
 	rte_free(dev->security_ctx);
 	dev->security_ctx = NULL;
-#endif
 
 	return ret;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 7dc02a472b..32d7b98ed1 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -14,9 +14,7 @@
 #include "base/ixgbe_dcb_82599.h"
 #include "base/ixgbe_dcb_82598.h"
 #include "ixgbe_bypass.h"
-#ifdef RTE_LIB_SECURITY
 #include "ixgbe_ipsec.h"
-#endif
 #include <rte_flow.h>
 #include <rte_time.h>
 #include <rte_hash.h>
@@ -480,9 +478,7 @@ struct ixgbe_adapter {
 	struct ixgbe_filter_info    filter;
 	struct ixgbe_l2_tn_info     l2_tn;
 	struct ixgbe_bw_conf        bw_conf;
-#ifdef RTE_LIB_SECURITY
 	struct ixgbe_ipsec          ipsec;
-#endif
 	bool rx_bulk_alloc_allowed;
 	bool rx_vec_allowed;
 	struct rte_timecounter      systime_tc;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index c8d6237f27..491e8bccc5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -214,7 +214,6 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
 	memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
 
-#ifdef RTE_LIB_SECURITY
 	/**
 	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
 	 */
@@ -282,7 +281,6 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		session = RTE_CAST_PTR(struct rte_security_session *, sec_act->security_session);
 		return ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
 	}
-#endif
 
 	/* the first not void item can be MAC or IPv4 */
 	item = next_no_void_pattern(pattern, NULL);
@@ -663,11 +661,9 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-#ifdef RTE_LIB_SECURITY
 	/* ESP flow not really a flow*/
 	if (filter->proto == IPPROTO_ESP)
 		return 0;
-#endif
 
 	/* Ixgbe doesn't support tcp flags. */
 	if (filter->flags & RTE_NTUPLE_FLAGS_TCP_FLAG) {
@@ -3107,7 +3103,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
 			actions, &ntuple_filter, error);
 
-#ifdef RTE_LIB_SECURITY
 	/* ESP flow not really a flow*/
 	if (ntuple_filter.proto == IPPROTO_ESP) {
 		if (ret != 0)
@@ -3115,7 +3110,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		flow->is_security = true;
 		return flow;
 	}
-#endif
 
 	if (!ret) {
 		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a6454cd1fe..3be0f0492a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -460,7 +460,6 @@ ixgbe_set_xmit_ctx(struct ci_tx_queue *txq,
 		seqnum_seed |= tx_offload.l2_len
 			       << IXGBE_ADVTXD_TUNNEL_LEN;
 	}
-#ifdef RTE_LIB_SECURITY
 	if (ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) {
 		union ixgbe_crypto_tx_desc_md *md =
 				(union ixgbe_crypto_tx_desc_md *)mdata;
@@ -474,7 +473,6 @@ ixgbe_set_xmit_ctx(struct ci_tx_queue *txq,
 		tx_offload_mask.sa_idx |= ~0;
 		tx_offload_mask.sec_pad_len |= ~0;
 	}
-#endif
 
 	txq->ctx_cache[ctx_idx].flags = ol_flags;
 	txq->ctx_cache[ctx_idx].tx_offload.data[0]  =
@@ -631,9 +629,7 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint32_t ctx = 0;
 	uint32_t new_ctx;
 	union ixgbe_tx_offload tx_offload;
-#ifdef RTE_LIB_SECURITY
 	uint8_t use_ipsec;
-#endif
 
 	tx_offload.data[0] = 0;
 	tx_offload.data[1] = 0;
@@ -661,9 +657,7 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		 * are needed for offload functionality.
 		 */
 		ol_flags = tx_pkt->ol_flags;
-#ifdef RTE_LIB_SECURITY
 		use_ipsec = txq->using_ipsec && (ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD);
-#endif
 
 		/* If hardware offload required */
 		tx_ol_req = ol_flags & IXGBE_TX_OFFLOAD_MASK;
@@ -675,7 +669,6 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			tx_offload.tso_segsz = tx_pkt->tso_segsz;
 			tx_offload.outer_l2_len = tx_pkt->outer_l2_len;
 			tx_offload.outer_l3_len = tx_pkt->outer_l3_len;
-#ifdef RTE_LIB_SECURITY
 			if (use_ipsec) {
 				union ixgbe_crypto_tx_desc_md *ipsec_mdata =
 					(union ixgbe_crypto_tx_desc_md *)
@@ -683,7 +676,6 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_offload.sa_idx = ipsec_mdata->sa_idx;
 				tx_offload.sec_pad_len = ipsec_mdata->pad_len;
 			}
-#endif
 
 			/* If new context need be built or reuse the exist ctx. */
 			ctx = what_advctx_update(txq, tx_ol_req,
@@ -871,10 +863,8 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			olinfo_status |= ctx << IXGBE_ADVTXD_IDX_SHIFT;
 		}
 		olinfo_status |= (pkt_len << IXGBE_ADVTXD_PAYLEN_SHIFT);
-#ifdef RTE_LIB_SECURITY
 		if (use_ipsec)
 			olinfo_status |= IXGBE_ADVTXD_POPTS_IPSEC;
-#endif
 
 		m_seg = tx_pkt;
 		do {
@@ -1505,13 +1495,11 @@ rx_desc_error_to_pkt_flags(uint32_t rx_status, uint16_t pkt_info,
 		pkt_flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
 	}
 
-#ifdef RTE_LIB_SECURITY
 	if (rx_status & IXGBE_RXD_STAT_SECP) {
 		pkt_flags |= RTE_MBUF_F_RX_SEC_OFFLOAD;
 		if (rx_status & IXGBE_RXDADV_LNKSEC_ERROR_BAD_SIG)
 			pkt_flags |= RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
 	}
-#endif
 
 	return pkt_flags;
 }
@@ -2472,9 +2460,7 @@ ixgbe_dev_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	if (txq->offloads == 0 &&
-#ifdef RTE_LIB_SECURITY
 			!(txq->using_ipsec) &&
-#endif
 			txq->tx_rs_thresh >= IXGBE_TX_MAX_BURST) {
 		if (txq->tx_rs_thresh <= IXGBE_TX_MAX_FREE_BUF_SZ &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
@@ -2629,9 +2615,7 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 {
 	/* Use a simple Tx queue (no offloads, no multi segs) if possible */
 	if ((txq->offloads == 0) &&
-#ifdef RTE_LIB_SECURITY
 			!(txq->using_ipsec) &&
-#endif
 			(txq->tx_rs_thresh >= IXGBE_TX_MAX_BURST)) {
 		PMD_INIT_LOG(DEBUG, "Using simple tx code path");
 		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
@@ -2692,10 +2676,8 @@ ixgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
 	    hw->mac.type == ixgbe_mac_E610)
 		tx_offload_capa |= RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM;
 
-#ifdef RTE_LIB_SECURITY
 	if (dev->security_ctx)
 		tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
-#endif
 	return tx_offload_capa;
 }
 
@@ -2873,10 +2855,8 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->offloads = offloads;
 	txq->ops = &def_txq_ops;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
-#ifdef RTE_LIB_SECURITY
 	txq->using_ipsec = !!(dev->data->dev_conf.txmode.offloads &
 			RTE_ETH_TX_OFFLOAD_SECURITY);
-#endif
 
 	/*
 	 * Modification to set VFTDT for virtual function if vf is detected
@@ -3170,10 +3150,8 @@ ixgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 	    hw->mac.type == ixgbe_mac_E610)
 		offloads |= RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
 
-#ifdef RTE_LIB_SECURITY
 	if (dev->security_ctx)
 		offloads |= RTE_ETH_RX_OFFLOAD_SECURITY;
-#endif
 
 	return offloads;
 }
@@ -5101,10 +5079,8 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
 		rxq->vector_rx = rx_using_sse;
-#ifdef RTE_LIB_SECURITY
 		rxq->using_ipsec = !!(dev->data->dev_conf.rxmode.offloads &
 				RTE_ETH_RX_OFFLOAD_SECURITY);
-#endif
 	}
 }
 
@@ -5610,7 +5586,6 @@ ixgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 			ixgbe_setup_loopback_link_x540_x550(hw, true);
 	}
 
-#ifdef RTE_LIB_SECURITY
 	if ((dev->data->dev_conf.rxmode.offloads &
 			RTE_ETH_RX_OFFLOAD_SECURITY) ||
 		(dev->data->dev_conf.txmode.offloads &
@@ -5623,7 +5598,6 @@ ixgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 			return ret;
 		}
 	}
-#endif
 
 	return 0;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 7950e56ee4..33023a3580 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -99,11 +99,9 @@ union ixgbe_tx_offload {
 		/* fields for TX offloading of tunnels */
 		uint64_t outer_l3_len:8; /**< Outer L3 (IP) Hdr Length. */
 		uint64_t outer_l2_len:8; /**< Outer L2 (MAC) Hdr Length. */
-#ifdef RTE_LIB_SECURITY
 		/* inline ipsec related*/
 		uint64_t sa_idx:8;	/**< TX SA database entry index */
 		uint64_t sec_pad_len:4;	/**< padding length */
-#endif
 	};
 };
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index dca3a20ca0..3f37038e5c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -21,7 +21,6 @@ ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
 	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
 }
 
-#ifdef RTE_LIB_SECURITY
 static inline void
 desc_to_olflags_v_ipsec(__m128i descs[4], struct rte_mbuf **rx_pkts)
 {
@@ -56,7 +55,6 @@ desc_to_olflags_v_ipsec(__m128i descs[4], struct rte_mbuf **rx_pkts)
 	*rearm2 = _mm_extract_epi32(rearm, 2);
 	*rearm3 = _mm_extract_epi32(rearm, 3);
 }
-#endif
 
 static inline void
 desc_to_olflags_v(__m128i descs[4], __m128i mbuf_init, uint8_t vlan_flags,
@@ -265,9 +263,7 @@ _recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	volatile union ixgbe_adv_rx_desc *rxdp;
 	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
-#ifdef RTE_LIB_SECURITY
 	uint8_t use_ipsec = rxq->using_ipsec;
-#endif
 	int pos;
 	uint64_t var;
 	__m128i shuf_msk;
@@ -444,10 +440,8 @@ _recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		desc_to_olflags_v(descs, mbuf_init, vlan_flags, udp_p_flag,
 				  &rx_pkts[pos]);
 
-#ifdef RTE_LIB_SECURITY
 		if (unlikely(use_ipsec))
 			desc_to_olflags_v_ipsec(descs, &rx_pkts[pos]);
-#endif
 
 		/* D.2 pkt 3,4 set in_port/nb_seg and remove crc */
 		pkt_mb4 = _mm_add_epi16(pkt_mb4, crc_adjust);
-- 
2.47.3

