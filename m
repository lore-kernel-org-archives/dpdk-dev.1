Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8F8C02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 05:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 677A240E8A;
	Mon,  3 Feb 2025 06:11:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8918640E5E
 for <dev@dpdk.org>; Mon,  3 Feb 2025 06:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738559494; x=1770095494;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DYcVk1MHcs5+Tw3liyL/Ia/DY1EprNUq0yQIXTv1kfc=;
 b=nne/6pgctJXkwFTloTPbvidIsiccyNGroKrg+etYsyjGAeGBnFWgNL2g
 6eGtZ2hiLPjuiYUFde3MU5MFQrDNihEjbnI/4cKGHVWGnGSZ2WbeEI9/3
 0+KKgz7mtgAYYssPLg0mLs/08HmlDs8FQhkbp0MrI5Qt2pVCg+Kfp1HrU
 ZGNINjK+Ot0VZzxLKbYq5CFPDo85HQ3UvuBlz53oyhbQpyMpHIoows0JY
 V12OaoATyozBeUlnU8SaxuQI+zkGy2zc3Rsrpa2uX3uph+kip7w44g5oP
 zf8ZpjOlApG2CmnYzXZbjKBvSx6vCXmes5LGv1UMsaae9gKxF+QJ324xH g==;
X-CSE-ConnectionGUID: I8Bi3cwpQ+WU21PPgx+KBA==
X-CSE-MsgGUID: NYn/sI+iS2yueukSc3syfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="38924518"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="38924518"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2025 21:11:34 -0800
X-CSE-ConnectionGUID: ooQsPyQ+TqSiOiA/A+kcxg==
X-CSE-MsgGUID: EqZH5J6FSV2ESC9AgXRi2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="110348898"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.205])
 by fmviesa008.fm.intel.com with ESMTP; 02 Feb 2025 21:11:31 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v4 2/2] common/idpf: enable AVX2 for single queue Tx
Date: Mon,  3 Feb 2025 10:54:30 +0530
Message-Id: <20250203052430.1243485-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203052430.1243485-1-shaiq.wani@intel.com>
References: <20250130082445.1112043-2-shaiq.wani@intel.com>
 <20250203052430.1243485-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

The single queue model processes all packets in order while
the split queue model separates packet data and metadata into
different queues for parallel processing and improved performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst                    |   8 +-
 doc/guides/rel_notes/release_25_03.rst      |   7 +
 drivers/common/idpf/idpf_common_device.h    |   1 +
 drivers/common/idpf/idpf_common_rxtx.h      |   4 +
 drivers/common/idpf/idpf_common_rxtx_avx2.c | 224 ++++++++++++++++++++
 drivers/common/idpf/version.map             |   1 +
 drivers/net/intel/idpf/idpf_rxtx.c          |  13 ++
 7 files changed, 255 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index 0370989a07..90b651d193 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -93,9 +93,11 @@ The paths are chosen based on 2 conditions:
 
 - ``CPU``
 
-  On the x86 platform, the driver checks if the CPU supports AVX512.
-  If the CPU supports AVX512 and EAL argument ``--force-max-simd-bitwidth``
-  is set to 512, AVX512 paths will be chosen.
+  On the x86 platform, the driver checks if the CPU supports AVX instruction set.
+  If the CPU supports AVX512 and EAL argument --force-max-simd-bitwidth is set to 512, AVX512 paths will be chosen
+  else if --force-max-simd-bitwidth is set to 256, AVX2 paths will be chosen.
+  Note that 256 is the default bitwidth if no specific value is provided.
+
 
 - ``Offload features``
 
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index a88b04d958..905e8f363c 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -76,6 +76,13 @@ New Features
 
   * Added support for virtual function (VF).
 
+* **Added support of AVX2 instructions on IDPF.**
+
+   Support for AVX2 instructions in IDPF single queue RX and TX path
+   added.The single queue model processes all packets in order within
+   one RX queue, while the split queue model separates packet data and
+   metadata into different queues for parallel processing and improved performance.
+
 
 Removed Items
 -------------
diff --git a/drivers/common/idpf/idpf_common_device.h b/drivers/common/idpf/idpf_common_device.h
index 734be1c88a..5f3e4a4fcf 100644
--- a/drivers/common/idpf/idpf_common_device.h
+++ b/drivers/common/idpf/idpf_common_device.h
@@ -124,6 +124,7 @@ struct idpf_vport {
 	bool rx_vec_allowed;
 	bool tx_vec_allowed;
 	bool rx_use_avx2;
+	bool tx_use_avx2;
 	bool rx_use_avx512;
 	bool tx_use_avx512;
 
diff --git a/drivers/common/idpf/idpf_common_rxtx.h b/drivers/common/idpf/idpf_common_rxtx.h
index f50cf5ef46..e19e1878f3 100644
--- a/drivers/common/idpf/idpf_common_rxtx.h
+++ b/drivers/common/idpf/idpf_common_rxtx.h
@@ -306,5 +306,9 @@ __rte_internal
 uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
 					struct rte_mbuf **rx_pkts,
 					uint16_t nb_pkts);
+__rte_internal
+uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
+					struct rte_mbuf **tx_pkts,
+					uint16_t nb_pkts);
 
 #endif /* _IDPF_COMMON_RXTX_H_ */
diff --git a/drivers/common/idpf/idpf_common_rxtx_avx2.c b/drivers/common/idpf/idpf_common_rxtx_avx2.c
index 761dc3e5e7..a62e9d3e27 100644
--- a/drivers/common/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/common/idpf/idpf_common_rxtx_avx2.c
@@ -478,3 +478,227 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 {
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
+static __rte_always_inline void
+idpf_tx_backlog_entry(struct idpf_tx_entry *txep,
+		     struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	int i;
+
+	for (i = 0; i < (int)nb_pkts; ++i)
+		txep[i].mbuf = tx_pkts[i];
+}
+
+static __rte_always_inline int
+idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
+{
+	struct idpf_tx_entry *txep;
+	uint32_t n;
+	uint32_t i;
+	int nb_free = 0;
+	struct rte_mbuf *m, *free[txq->rs_thresh];
+
+	/* check DD bits on threshold descriptor */
+	if ((txq->tx_ring[txq->next_dd].qw1 &
+			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
+		return 0;
+
+	n = txq->rs_thresh;
+
+	 /* first buffer to free from S/W ring is at index
+	  * next_dd - (rs_thresh-1)
+	  */
+	txep = &txq->sw_ring[txq->next_dd - (n - 1)];
+	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
+	if (likely(m)) {
+		free[0] = m;
+		nb_free = 1;
+		for (i = 1; i < n; i++) {
+			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
+			if (likely(m)) {
+				if (likely(m->pool == free[0]->pool)) {
+					free[nb_free++] = m;
+				} else {
+					rte_mempool_put_bulk(free[0]->pool,
+							     (void *)free,
+							     nb_free);
+					free[0] = m;
+					nb_free = 1;
+				}
+			}
+		}
+		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+	} else {
+		for (i = 1; i < n; i++) {
+			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
+			if (m)
+				rte_mempool_put(m->pool, m);
+		}
+	}
+
+	/* buffers were freed, update counters */
+	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
+	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
+	if (txq->next_dd >= txq->nb_tx_desc)
+		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
+
+	return txq->rs_thresh;
+}
+
+static inline void
+idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
+		  struct rte_mbuf *pkt, uint64_t flags)
+{
+	uint64_t high_qw =
+		(IDPF_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags  << IDPF_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S));
+
+	__m128i descriptor = _mm_set_epi64x(high_qw,
+				pkt->buf_iova + pkt->data_off);
+	_mm_store_si128((__m128i *)txdp, descriptor);
+}
+
+static inline void
+idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
+		 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
+{
+	const uint64_t hi_qw_tmpl = (IDPF_TX_DESC_DTYPE_DATA |
+			((uint64_t)flags  << IDPF_TXD_QW1_CMD_S));
+
+	/* if unaligned on 32-bit boundary, do one to align */
+	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
+		idpf_singleq_vtx1(txdp, *pkt, flags);
+		nb_pkts--, txdp++, pkt++;
+	}
+
+	/* do two at a time while possible, in bursts */
+	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
+		uint64_t hi_qw3 =
+			hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len <<
+			 IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 =
+			hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len <<
+			 IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 =
+			hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len <<
+			 IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 =
+			hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len <<
+			 IDPF_TXD_QW1_TX_BUF_SZ_S);
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
+		_mm256_store_si256((void *)(txdp + 2), desc2_3);
+		_mm256_store_si256((void *)txdp, desc0_1);
+	}
+
+	/* do any last ones */
+	while (nb_pkts) {
+		idpf_singleq_vtx1(txdp, *pkt, flags);
+		txdp++, pkt++, nb_pkts--;
+	}
+}
+
+static inline uint16_t
+idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+				       uint16_t nb_pkts)
+{
+	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	volatile struct idpf_base_tx_desc *txdp;
+	struct idpf_tx_entry *txep;
+	uint16_t n, nb_commit, tx_id;
+	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
+	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
+
+	/* cross rx_thresh boundary is not allowed */
+	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+
+	if (txq->nb_free < txq->free_thresh)
+		idpf_singleq_tx_free_bufs_vec(txq);
+
+	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	if (unlikely(nb_pkts == 0))
+		return 0;
+
+	tx_id = txq->tx_tail;
+	txdp = &txq->tx_ring[tx_id];
+	txep = &txq->sw_ring[tx_id];
+
+	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+	if (nb_commit >= n) {
+		idpf_tx_backlog_entry(txep, tx_pkts, n);
+
+		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
+		tx_pkts += (n - 1);
+		txdp += (n - 1);
+
+		idpf_singleq_vtx1(txdp, *tx_pkts++, rs);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		tx_id = 0;
+		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+
+		/* avoid reach the end of ring */
+		txdp = &txq->tx_ring[tx_id];
+		txep = &txq->sw_ring[tx_id];
+	}
+
+	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
+
+	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->next_rs) {
+		txq->tx_ring[txq->next_rs].qw1 |=
+			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
+					 IDPF_TXD_QW1_CMD_S);
+		txq->next_rs =
+			(uint16_t)(txq->next_rs + txq->rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
+
+	return nb_pkts;
+}
+
+uint16_t
+idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+			       uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		ret = idpf_singleq_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx],
+						    num);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
diff --git a/drivers/common/idpf/version.map b/drivers/common/idpf/version.map
index 22b689f5f5..0557321963 100644
--- a/drivers/common/idpf/version.map
+++ b/drivers/common/idpf/version.map
@@ -10,6 +10,7 @@ INTERNAL {
 	idpf_dp_singleq_recv_pkts_avx512;
 	idpf_dp_singleq_recv_scatter_pkts;
 	idpf_dp_singleq_xmit_pkts;
+	idpf_dp_singleq_xmit_pkts_avx2;
 	idpf_dp_singleq_xmit_pkts_avx512;
 	idpf_dp_splitq_recv_pkts;
 	idpf_dp_splitq_recv_pkts_avx512;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index a8377d3fee..0c3ecd2765 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -887,6 +887,11 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	if (idpf_tx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->tx_vec_allowed = true;
+
+		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
+		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+			vport->tx_use_avx2 = true;
+
 		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
 #ifdef CC_AVX512_SUPPORT
 		{
@@ -946,6 +951,14 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (vport->tx_use_avx2) {
+				PMD_DRV_LOG(NOTICE,
+					    "Using Single AVX2 Vector Tx (port %d).",
+					    dev->data->port_id);
+				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx2;
+				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+				return;
+			}
 		}
 		PMD_DRV_LOG(NOTICE,
 			    "Using Single Scalar Tx (port %d).",
-- 
2.34.1

