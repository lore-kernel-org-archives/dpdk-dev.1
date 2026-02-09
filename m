Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5194E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE6740E20;
	Mon,  9 Feb 2026 17:46:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A8C6640E0F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655570; x=1802191570;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BNZ2VbdFmDPCDgXdCazNUO4gwxSX3Gy/OWY8sVSiUvo=;
 b=IvwV2jXITwbvQYxTpxLqu3gmMHTX7p7B9PTNhN2bcm5fDD1hAy96s+gv
 42kbBtQmpCx6ZhOLgE7WgvRf5X/Cat8nJmF6FeqNp6NcadfV30EdW0dvw
 T9alvjkPriKrS3Jy8D9ctx3Q3uO7F60kaihIYKgl6nyODlTE1ybfLbVaG
 +hMCXp4jOoy71jFAHl3gDJU/hhIK8+jRfAGFkSAS0uU0rWdyRGZxPqHSr
 QxkkusLyvuhH5iI9yAdnFMMa1mSPJx8kA4g4kk742rsviWC03dvun1HA+
 USwiylg/4kfK5ZIsnuZbOmJoCS4X2dRA/gaIJTc7eHH1LUSrqPtqtr6KP A==;
X-CSE-ConnectionGUID: poCIvRJEQD+rTuFu9putxg==
X-CSE-MsgGUID: mxuKSB0BT5imhPiUS/vCSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663479"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663479"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:09 -0800
X-CSE-ConnectionGUID: RLkwUqE3Q4WEoT8TgFWrtg==
X-CSE-MsgGUID: 77nvmmTSTxSHS0W4c1gu3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789180"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:08 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v4 24/35] net/intel: use separate array for desc status
 tracking
Date: Mon,  9 Feb 2026 16:45:22 +0000
Message-ID: <20260209164538.1428499-25-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

Rather than writing a last_id for each individual descriptor, we can
write one only for places where the "report status" (RS) bit is set,
i.e. the descriptors which will be written back when done. The method
used for marking what descriptors are free is also changed in the
process, even if the last descriptor with the "done" bits set is past
the expected point, we only track up to the expected point, and leave
the rest to be counted as freed next time. This means that we always
have the RS/DD bits set at fixed intervals, and we always track free
slots in units of the same tx_free_thresh intervals.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h             |  4 ++
 drivers/net/intel/common/tx_scalar.h      | 66 +++++++++++------------
 drivers/net/intel/cpfl/cpfl_rxtx.c        | 17 ++++++
 drivers/net/intel/i40e/i40e_rxtx.c        | 20 +++++++
 drivers/net/intel/iavf/iavf_rxtx.c        | 19 +++++++
 drivers/net/intel/ice/ice_rxtx.c          | 20 +++++++
 drivers/net/intel/idpf/idpf_common_rxtx.c |  7 +++
 drivers/net/intel/idpf/idpf_rxtx.c        | 13 +++++
 8 files changed, 132 insertions(+), 34 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index f0229314a0..e7d79eb7d0 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -127,6 +127,8 @@ struct ci_tx_queue {
 		struct ci_tx_entry *sw_ring; /* virtual address of SW ring */
 		struct ci_tx_entry_vec *sw_ring_vec;
 	};
+	/* Scalar TX path: Array tracking last_id at each RS threshold boundary */
+	uint16_t *rs_last_id;
 	uint16_t nb_tx_desc;           /* number of TX descriptors */
 	uint16_t tx_tail; /* current value of tail register */
 	uint16_t nb_tx_used; /* number of TX desc used since RS bit set */
@@ -140,6 +142,8 @@ struct ci_tx_queue {
 	uint16_t tx_free_thresh;
 	/* Number of TX descriptors to use before RS bit is set. */
 	uint16_t tx_rs_thresh;
+	/* Scalar TX path: log2 of tx_rs_thresh for efficient bit operations */
+	uint8_t log2_rs_thresh;
 	uint16_t port_id;  /* Device port identifier. */
 	uint16_t queue_id; /* TX queue index. */
 	uint16_t reg_idx;
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 342e271c5f..acda2f0478 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -22,33 +22,25 @@
 static __rte_always_inline int
 ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 {
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
 	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-
-	/* Determine the last descriptor needing to be cleaned */
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
-
-	/* Check if descriptor is done */
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
+	const uint16_t last_desc_cleaned = txq->last_desc_cleaned;
+	const uint16_t nb_tx_desc = txq->nb_tx_desc;
+
+	/* Calculate where the next descriptor write-back will occur */
+	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
+			0 :
+			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
+	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) + (txq->tx_rs_thresh - 1);
+
+	/* Check if descriptor is done  */
+	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 		return -1;
 
-	/* Figure out how many descriptors will be cleaned */
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) + desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to - last_desc_cleaned);
-
 	/* Update the txq to reflect the last descriptor that was cleaned */
 	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
+	txq->nb_tx_free += txq->tx_rs_thresh;
 
 	return 0;
 }
@@ -223,6 +215,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		uint16_t nb_ipsec = 0;
 		uint64_t ipsec_qw0 = 0, ipsec_qw1 = 0;
 		uint64_t cd_qw0, cd_qw1;
+		uint16_t pkt_rs_idx;
 		tx_pkt = *tx_pkts++;
 
 		ol_flags = tx_pkt->ol_flags;
@@ -266,6 +259,9 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		if (tx_last >= txq->nb_tx_desc)
 			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
 
+		/* Track the RS threshold bucket at packet start */
+		pkt_rs_idx = (uint16_t)(tx_id >> txq->log2_rs_thresh);
+
 		if (unlikely(nb_used > txq->nb_tx_free)) {
 			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
@@ -306,10 +302,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			if (txe->mbuf)
 				rte_pktmbuf_free_seg(txe->mbuf);
-			*txe = (struct ci_tx_entry){
-				.mbuf = tx_pkt, .last_id = tx_last, .next_id = tx_id
-			};
-
+			txe->mbuf = tx_pkt;
 			/* Setup TX Descriptor */
 			td_cmd |= CI_TX_DESC_CMD_EOP;
 			const uint64_t cmd_type_offset_bsz = CI_TX_DESC_DTYPE_DATA |
@@ -336,7 +329,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
-			txe->last_id = tx_last;
 			tx_id = txe->next_id;
 			txe = txn;
 		}
@@ -355,7 +347,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			ipsec_txd[0] = ipsec_qw0;
 			ipsec_txd[1] = ipsec_qw1;
 
-			txe->last_id = tx_last;
 			tx_id = txe->next_id;
 			txe = txn;
 		}
@@ -391,7 +382,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
 
-				txe->last_id = tx_last;
 				tx_id = txe->next_id;
 				txe = txn;
 				txd = &ci_tx_ring[tx_id];
@@ -409,7 +399,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
 			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
 
-			txe->last_id = tx_last;
 			tx_id = txe->next_id;
 			txe = txn;
 			m_seg = m_seg->next;
@@ -418,13 +407,22 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-		/* set RS bit on the last descriptor of one packet */
-		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
+		/* Check if packet crosses into a new RS threshold bucket.
+		 * The RS bit is set on the last descriptor when we move from one bucket to another.
+		 * For example, with tx_rs_thresh=32 and a 5-descriptor packet using slots 30-34:
+		 *   - pkt_rs_idx = 30 >> 5 = 0 (started in bucket 0)
+		 *   - tx_last = 34, so 35 >> 5 = 1 (next packet is in bucket 1)
+		 *   - Since 0 != 1, set RS bit on descriptor 34, and record rs_last_id[0] = 34
+		 */
+		uint16_t next_rs_idx = ((tx_last + 1) >> txq->log2_rs_thresh);
+
+		if (next_rs_idx != pkt_rs_idx) {
+			/* Packet crossed into a new bucket - set RS bit on last descriptor */
 			txd->cmd_type_offset_bsz |=
 					rte_cpu_to_le_64(CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
 
-			/* Update txq RS bit counters */
-			txq->nb_tx_used = 0;
+			/* Record the last descriptor ID for the bucket we're leaving */
+			txq->rs_last_id[pkt_rs_idx] = tx_last;
 		}
 
 		if (ts_fns != NULL)
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index bc5bec65f0..e7a98ed4f6 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -5,6 +5,7 @@
 #include <ethdev_driver.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_bitops.h>
 
 #include "cpfl_ethdev.h"
 #include "cpfl_rxtx.h"
@@ -330,6 +331,7 @@ cpfl_tx_queue_release(void *txq)
 
 	ci_txq_release_all_mbufs(q, q->vector_tx);
 	rte_free(q->sw_ring);
+	rte_free(q->rs_last_id);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_txq);
 }
@@ -572,6 +574,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
@@ -605,6 +608,17 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		goto err_sw_ring_alloc;
 	}
 
+	/* Allocate RS last_id tracking array */
+	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+	txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
+			sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->rs_last_id == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
+		ret = -ENOMEM;
+		goto err_rs_last_id_alloc;
+	}
+
 	if (!is_splitq) {
 		txq->ci_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
@@ -628,6 +642,9 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 
 err_complq_setup:
+	rte_free(txq->rs_last_id);
+err_rs_last_id_alloc:
+	rte_free(txq->sw_ring);
 err_sw_ring_alloc:
 	cpfl_dma_zone_release(mz);
 err_mz_reserve:
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index dfd2213020..b554bc6c31 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -24,6 +24,7 @@
 #include <rte_ip.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_bitops.h>
 
 #include "i40e_logs.h"
 #include "base/i40e_prototype.h"
@@ -2280,6 +2281,13 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			     (int)queue_idx);
 		return I40E_ERR_PARAM;
 	}
+	if (!rte_is_power_of_2(tx_rs_thresh)) {
+		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2. (tx_rs_thresh=%u port=%d queue=%d)",
+			     (unsigned int)tx_rs_thresh,
+			     (int)dev->data->port_id,
+			     (int)queue_idx);
+		return I40E_ERR_PARAM;
+	}
 	if ((tx_rs_thresh > 1) && (tx_conf->tx_thresh.wthresh != 0)) {
 		PMD_INIT_LOG(ERR, "TX WTHRESH must be set to 0 if "
 			     "tx_rs_thresh is greater than 1. "
@@ -2321,6 +2329,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->mz = tz;
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = queue_idx;
 	txq->reg_idx = reg_idx;
@@ -2346,6 +2355,16 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
+	/* Allocate RS last_id tracking array */
+	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->rs_last_id == NULL) {
+		i40e_tx_queue_release(txq);
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for RS last_id array");
+		return -ENOMEM;
+	}
+
 	i40e_reset_tx_queue(txq);
 	txq->q_set = TRUE;
 
@@ -2391,6 +2410,7 @@ i40e_tx_queue_release(void *txq)
 
 	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->sw_ring);
+	rte_free(q->rs_last_id);
 	rte_memzone_free(q->mz);
 	rte_free(q);
 }
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 2ea00e1975..e7187f713d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -25,6 +25,7 @@
 #include <rte_ip.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_bitops.h>
 #include <rte_vxlan.h>
 #include <rte_gtp.h>
 #include <rte_geneve.h>
@@ -194,6 +195,11 @@ check_tx_thresh(uint16_t nb_desc, uint16_t tx_rs_thresh,
 			     tx_rs_thresh, nb_desc);
 		return -EINVAL;
 	}
+	if (!rte_is_power_of_2(tx_rs_thresh)) {
+		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2. (tx_rs_thresh=%u)",
+			     tx_rs_thresh);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -801,6 +807,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = queue_idx;
 	txq->port_id = dev->data->port_id;
@@ -826,6 +833,17 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
+	/* Allocate RS last_id tracking array */
+	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->rs_last_id == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
+		rte_free(txq->sw_ring);
+		rte_free(txq);
+		return -ENOMEM;
+	}
+
 	/* Allocate TX hardware ring descriptors. */
 	ring_size = sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
 	ring_size = RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
@@ -1050,6 +1068,7 @@ iavf_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 	ci_txq_release_all_mbufs(q, q->use_ctx);
 	rte_free(q->sw_ring);
+	rte_free(q->rs_last_id);
 	rte_memzone_free(q->mz);
 	rte_free(q);
 }
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 111cb5e37f..2915223397 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -5,6 +5,7 @@
 #include <ethdev_driver.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_bitops.h>
 
 #include "ice_rxtx.h"
 #include "ice_rxtx_vec_common.h"
@@ -1589,6 +1590,13 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 			     (int)queue_idx);
 		return -EINVAL;
 	}
+	if (!rte_is_power_of_2(tx_rs_thresh)) {
+		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2. (tx_rs_thresh=%u port=%d queue=%d)",
+			     (unsigned int)tx_rs_thresh,
+			     (int)dev->data->port_id,
+			     (int)queue_idx);
+		return -EINVAL;
+	}
 	if (tx_rs_thresh > 1 && tx_conf->tx_thresh.wthresh != 0) {
 		PMD_INIT_LOG(ERR, "TX WTHRESH must be set to 0 if "
 			     "tx_rs_thresh is greater than 1. "
@@ -1631,6 +1639,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->mz = tz;
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = queue_idx;
 
@@ -1657,6 +1666,16 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
+	/* Allocate RS last_id tracking array */
+	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->rs_last_id == NULL) {
+		ice_tx_queue_release(txq);
+		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
+		return -ENOMEM;
+	}
+
 	if (vsi->type == ICE_VSI_PF && (offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)) {
 		if (hw->phy_model != ICE_PHY_E830) {
 			ice_tx_queue_release(txq);
@@ -1729,6 +1748,7 @@ ice_tx_queue_release(void *txq)
 
 	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->sw_ring);
+	rte_free(q->rs_last_id);
 	if (q->tsq) {
 		rte_memzone_free(q->tsq->ts_mz);
 		rte_free(q->tsq);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index bca5f13c8e..8859bcca86 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -5,6 +5,7 @@
 #include <eal_export.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_errno.h>
+#include <rte_bitops.h>
 
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
@@ -73,6 +74,11 @@ idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 			tx_rs_thresh, nb_desc);
 		return -EINVAL;
 	}
+	if (!rte_is_power_of_2(tx_rs_thresh)) {
+		DRV_LOG(ERR, "tx_rs_thresh must be a power of 2. (tx_rs_thresh=%u)",
+			tx_rs_thresh);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -333,6 +339,7 @@ idpf_qc_tx_queue_release(void *txq)
 	}
 
 	ci_txq_release_all_mbufs(q, false);
+	rte_free(q->rs_last_id);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(q);
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 0de54d9305..9420200f6d 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -447,6 +447,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
@@ -480,6 +481,15 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		goto err_sw_ring_alloc;
 	}
 
+	txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
+			sizeof(txq->rs_last_id[0]) * (nb_desc >> txq->log2_rs_thresh),
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->rs_last_id == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS tracking");
+		ret = -ENOMEM;
+		goto err_rs_last_id_alloc;
+	}
+
 	if (!is_splitq) {
 		txq->ci_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
@@ -502,6 +512,9 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 
 err_complq_setup:
+	rte_free(txq->rs_last_id);
+err_rs_last_id_alloc:
+	rte_free(txq->sw_ring);
 err_sw_ring_alloc:
 	idpf_dma_zone_release(mz);
 err_mz_reserve:
-- 
2.51.0

