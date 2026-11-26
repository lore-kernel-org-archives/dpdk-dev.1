Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80689606A32D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XdhGXKyG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 092744067A;
	Thu, 26 Nov 2026 14:29:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id B3244402C9;
 Thu, 26 Nov 2026 14:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795699762; x=1827235762;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RuZD2BvMW+lHkczhi2UIaGY5OWKFiDGw8BZOnmRnBZs=;
 b=XdhGXKyGI/bilDq7fb+Pror+ErFUWXeJeI+IK4YQQzxjipIQekXB2PAL
 Ou6M0Hn1sIs8d8WgR1fZyxAmTedI4dUmps8Y1rXTBIWzjNH/HpzSDR+8p
 mONyAHQs6mrqA+a9ploY7o7TfIXJm7bdUWgaH05oi90/Y3sebKrEahJV3
 NRKwVJ6tswtscXoJ6i5YO/hqol660ID1UT3vucQ0mgz2w3exOyilFcyFx
 al0aSwWaQZl3dB7N/rYLOTnErcaKd+rOvLdrrAXc/OXKXcFOu58j/rAtm
 3LU8Y09GbMapAOvArKAROlQ83t084y/HtU4snTDkVkW3spl3Kj2jN6zc4 w==;
X-CSE-ConnectionGUID: ycQXXSYgTuWNxaqoQ6weqQ==
X-CSE-MsgGUID: umQIeXLyRuSVI65JfX2s8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4578861"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4578861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:29:20 -0800
X-CSE-ConnectionGUID: bbn4CdM4SCOlpyhyMWxTJA==
X-CSE-MsgGUID: AXos2i4qSNKejEUP7dFWvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12032059"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 26 Nov 2026 05:29:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH 4/4] net/i40e: fix Rx desc write-back with interrupts disabled
Date: Thu, 26 Nov 2026 13:29:08 +0000
Message-ID: <20261126132909.3488716-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126132909.3488716-1-bruce.richardson@intel.com>
References: <20261126132909.3488716-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On XL710 which does not have WB_ON_ITR support, Rx descriptors are only
written back in multi-descriptor blocks unless the queue's interrupt
vector fires. Disabling an Rx queue interrupt cleared INTENA on its
vector, so up to three received packets could stay invisible to polling
until more traffic arrived.

Instead of disabling the vector, move disabled queues onto a spare
MSI-X vector which has no eventfd. That vector still fires inside the
NIC, triggering write-back, but nothing is delivered to the application.
Queues now start in this disabled state, and enabling a queue raises a
software interrupt if packets completed while it was disabled, so no
wakeup is lost.

If no spare vector is available, the previous behaviour is kept.

Bugzilla ID: 1345
Bugzilla ID: 1347
Fixes: be6c228d4da3 ("i40e: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 213 +++++++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_ethdev.h |  18 +++
 2 files changed, 231 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 3ba5a61da3..07b5e3dd83 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -2044,6 +2044,185 @@ i40e_vsi_disable_queues_intr(struct i40e_vsi *vsi)
 	I40E_WRITE_FLUSH(hw);
 }

+#define I40E_RXQ_INTR_NONE UINT16_MAX
+#define I40E_RXQ_INTR_EOL 0x7FF
+
+static uint16_t
+i40e_rxq_intr_hwq(struct rte_eth_dev *dev, uint16_t qid)
+{
+	const struct ci_rx_queue *rxq = dev->data->rx_queues[qid];
+
+	return rxq->reg_idx;
+}
+
+static void
+i40e_rxq_intr_write_rqctl(struct i40e_hw *hw, uint16_t hwq, uint16_t vec, uint32_t next_hwq)
+{
+	I40E_WRITE_REG(hw, I40E_QINT_RQCTL(hwq),
+			(vec << I40E_QINT_RQCTL_MSIX_INDX_SHIFT) |
+			(I40E_ITR_INDEX_DEFAULT << I40E_QINT_RQCTL_ITR_INDX_SHIFT) |
+			(next_hwq << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
+			I40E_QINT_RQCTL_CAUSE_ENA_MASK);
+}
+
+/* Must be called with rxq_intr_lock held, or before the port is started */
+static void
+i40e_rxq_intr_list_add(struct rte_eth_dev *dev, uint16_t qid, uint16_t vec)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_rxq_intr_node *nodes = pf->rxq_intr_nodes;
+	const uint16_t head = pf->rxq_intr_heads[vec];
+	const uint16_t hwq = i40e_rxq_intr_hwq(dev, qid);
+
+	/* Link the queue to the old head before making it the head, so the list is always valid */
+	i40e_rxq_intr_write_rqctl(hw, hwq, vec,
+			head == I40E_RXQ_INTR_NONE ? I40E_RXQ_INTR_EOL : i40e_rxq_intr_hwq(dev, head));
+	I40E_WRITE_REG(hw, I40E_PFINT_LNKLSTN(vec - I40E_RX_VEC_START),
+			hwq << I40E_PFINT_LNKLSTN_FIRSTQ_INDX_SHIFT);
+
+	nodes[qid].vec = vec;
+	nodes[qid].prev = I40E_RXQ_INTR_NONE;
+	nodes[qid].next = head;
+	if (head != I40E_RXQ_INTR_NONE)
+		nodes[head].prev = qid;
+	pf->rxq_intr_heads[vec] = qid;
+}
+
+/* Must be called with rxq_intr_lock held */
+static void
+i40e_rxq_intr_list_del(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_rxq_intr_node *nodes = pf->rxq_intr_nodes;
+	const struct i40e_rxq_intr_node node = nodes[qid];
+	const uint32_t next_hwq = node.next == I40E_RXQ_INTR_NONE ?
+			I40E_RXQ_INTR_EOL : i40e_rxq_intr_hwq(dev, node.next);
+
+	if (node.prev == I40E_RXQ_INTR_NONE) {
+		I40E_WRITE_REG(hw, I40E_PFINT_LNKLSTN(node.vec - I40E_RX_VEC_START),
+				next_hwq << I40E_PFINT_LNKLSTN_FIRSTQ_INDX_SHIFT);
+		pf->rxq_intr_heads[node.vec] = node.next;
+	} else {
+		i40e_rxq_intr_write_rqctl(hw, i40e_rxq_intr_hwq(dev, node.prev), node.vec, next_hwq);
+		nodes[node.prev].next = node.next;
+	}
+	if (node.next != I40E_RXQ_INTR_NONE)
+		nodes[node.next].prev = node.prev;
+}
+
+static void
+i40e_rxq_intr_move(struct rte_eth_dev *dev, uint16_t qid, uint16_t vec)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+
+	rte_spinlock_lock(&pf->rxq_intr_lock);
+	if (pf->rxq_intr_nodes[qid].vec != vec) {
+		i40e_rxq_intr_list_del(dev, qid);
+		i40e_rxq_intr_list_add(dev, qid, vec);
+	}
+	rte_spinlock_unlock(&pf->rxq_intr_lock);
+}
+
+/*
+ * Without WB_ON_ITR, write-back of a partial block of Rx descriptors
+ * only happens when the queue's interrupt vector fires.
+ * Rather than disabling the vector, park disabled Rx queues on a vector that has no
+ * eventfd, so the vector still fires internally but nothing is delivered.
+ * If no such vector is available, the legacy vector enable/disable is used.
+ */
+static void
+i40e_rxq_intr_sink_setup(struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	const uint16_t nb_rxq = dev->data->nb_rx_queues;
+	int sink;
+
+	if (!rte_intr_dp_is_en(intr_handle) || !rte_intr_allow_others(intr_handle) ||
+			pf->support_multi_driver || nb_rxq == 0)
+		return;
+
+	sink = i40e_res_pool_alloc(&pf->msix_pool, 1);
+	if (sink < 0) {
+		PMD_DRV_LOG(INFO, "No spare MSI-X vector to hold disabled Rx queues");
+		return;
+	}
+	/* Vectors from max_intr upwards have no eventfd */
+	if (sink < rte_intr_max_intr_get(intr_handle)) {
+		PMD_DRV_LOG(INFO, "MSI-X vector %d for disabled Rx queues has an eventfd", sink);
+		i40e_res_pool_free(&pf->msix_pool, sink);
+		return;
+	}
+
+	pf->rxq_intr_nodes = calloc(nb_rxq, sizeof(*pf->rxq_intr_nodes));
+	pf->rxq_intr_heads = malloc(hw->func_caps.num_msix_vectors * sizeof(*pf->rxq_intr_heads));
+	if (pf->rxq_intr_nodes == NULL || pf->rxq_intr_heads == NULL) {
+		free(pf->rxq_intr_nodes);
+		free(pf->rxq_intr_heads);
+		pf->rxq_intr_nodes = NULL;
+		pf->rxq_intr_heads = NULL;
+		i40e_res_pool_free(&pf->msix_pool, sink);
+		return;
+	}
+	for (uint32_t v = 0; v < hw->func_caps.num_msix_vectors; v++)
+		pf->rxq_intr_heads[v] = I40E_RXQ_INTR_NONE;
+	rte_spinlock_init(&pf->rxq_intr_lock);
+
+	for (uint16_t q = 0; q < nb_rxq; q++) {
+		const uint16_t vec = rte_intr_vec_list_index_get(intr_handle, q);
+
+		I40E_WRITE_REG(hw, I40E_PFINT_LNKLSTN(vec - I40E_RX_VEC_START),
+				I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK);
+	}
+	for (uint16_t q = 0; q < nb_rxq; q++) {
+		const struct ci_rx_queue *rxq = dev->data->rx_queues[q];
+
+		if (rxq == NULL || !rxq->q_set)
+			continue;
+		i40e_rxq_intr_list_add(dev, q, sink);
+	}
+
+	I40E_WRITE_REG(hw, I40E_PFINT_ITRN(I40E_ITR_INDEX_DEFAULT, sink - I40E_RX_VEC_START),
+			i40e_calc_itr_interval(1, pf->support_multi_driver));
+	I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTLN(sink - I40E_RX_VEC_START),
+			I40E_PFINT_DYN_CTLN_INTENA_MASK |
+			I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
+			I40E_PFINT_DYN_CTLN_ITR_INDX_MASK);
+	I40E_WRITE_FLUSH(hw);
+	pf->rxq_intr_sink = sink;
+}
+
+static void
+i40e_rxq_intr_sink_release(struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	const uint16_t sink = pf->rxq_intr_sink;
+
+	if (sink == 0)
+		return;
+
+	I40E_WRITE_REG(hw, I40E_PFINT_LNKLSTN(sink - I40E_RX_VEC_START),
+			I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK);
+	I40E_WRITE_REG(hw, I40E_PFINT_ITRN(I40E_ITR_INDEX_DEFAULT, sink - I40E_RX_VEC_START), 0);
+	/* Clear any pending bit left by the masked vector, so it cannot fire if later reused */
+	I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTLN(sink - I40E_RX_VEC_START),
+			I40E_PFINT_DYN_CTLN_CLEARPBA_MASK |
+			I40E_PFINT_DYN_CTLN_ITR_INDX_MASK);
+	I40E_WRITE_FLUSH(hw);
+
+	i40e_res_pool_free(&pf->msix_pool, sink);
+	free(pf->rxq_intr_nodes);
+	free(pf->rxq_intr_heads);
+	pf->rxq_intr_nodes = NULL;
+	pf->rxq_intr_heads = NULL;
+	pf->rxq_intr_sink = 0;
+}
+
 static inline uint8_t
 i40e_parse_link_speeds(uint16_t link_speeds)
 {
@@ -2248,6 +2427,9 @@ i40e_dev_start(struct rte_eth_dev *dev)
 		i40e_vsi_enable_queues_intr(pf->vmdq[i].vsi);
 	}

+	/* Rx queue interrupts start disabled */
+	i40e_rxq_intr_sink_setup(dev);
+
 	/* Enable all queues which have been configured */
 	for (nb_rxq = 0; nb_rxq < dev->data->nb_rx_queues; nb_rxq++) {
 		ret = i40e_dev_rx_queue_start(dev, nb_rxq);
@@ -2376,6 +2558,7 @@ i40e_dev_start(struct rte_eth_dev *dev)
 rx_err:
 	for (i = 0; i < nb_rxq; i++)
 		i40e_dev_rx_queue_stop(dev, i);
+	i40e_rxq_intr_sink_release(dev);

 	return ret;
 }
@@ -2416,6 +2599,7 @@ i40e_dev_stop(struct rte_eth_dev *dev)
 		i40e_vsi_disable_queues_intr(pf->vmdq[i].vsi);
 		i40e_vsi_queues_unbind_intr(pf->vmdq[i].vsi);
 	}
+	i40e_rxq_intr_sink_release(dev);

 	/* Clear all queues and release memory */
 	i40e_dev_clear_queues(dev);
@@ -10349,11 +10533,16 @@ i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	const int msix_intr = rte_intr_vec_list_index_get(intr_handle, queue_id);
+	struct ci_rx_queue *rxq = dev->data->rx_queues[queue_id];

 	if (msix_intr < 0)
 		return msix_intr;

+	if (pf->rxq_intr_sink != 0)
+		i40e_rxq_intr_move(dev, queue_id, msix_intr);
+
 	if (msix_intr == I40E_MISC_VEC_ID)
 		I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTL0,
 			       I40E_PFINT_DYN_CTL0_INTENA_MASK |
@@ -10368,6 +10557,22 @@ i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 			       I40E_PFINT_DYN_CTLN_ITR_INDX_MASK);

 	I40E_WRITE_FLUSH(hw);
+
+	/*
+	 * Packets staged by bulk Rx are already past the descriptor tail. Written-back
+	 * descriptors and pending causes on the sink also need a wakeup after the move.
+	 */
+	if (pf->rxq_intr_sink != 0 &&
+			(rxq->rx_nb_avail != 0 ||
+			i40e_dev_rx_descriptor_status(rxq, 0) == RTE_ETH_RX_DESC_DONE ||
+			(I40E_READ_REG(hw, I40E_QINT_RQCTL(i40e_rxq_intr_hwq(dev, queue_id))) &
+				I40E_QINT_RQCTL_INTEVENT_MASK) != 0)) {
+		I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTLN(msix_intr - I40E_RX_VEC_START),
+				I40E_PFINT_DYN_CTLN_INTENA_MASK |
+				I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
+				I40E_PFINT_DYN_CTLN_ITR_INDX_MASK);
+		I40E_WRITE_FLUSH(hw);
+	}
 	rte_intr_ack(pci_dev->intr_handle);

 	return 0;
@@ -10382,11 +10587,19 @@ i40e_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	const int msix_intr = rte_intr_vec_list_index_get(intr_handle, queue_id);

 	if (msix_intr < 0)
 		return msix_intr;

+	/* Leave the vector enabled: it may serve other queues, and has no causes once empty */
+	if (pf->rxq_intr_sink != 0) {
+		i40e_rxq_intr_move(dev, queue_id, pf->rxq_intr_sink);
+		I40E_WRITE_FLUSH(hw);
+		return 0;
+	}
+
 	if (msix_intr == I40E_MISC_VEC_ID)
 		I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTL0,
 			       I40E_PFINT_DYN_CTL0_ITR_INDX_MASK);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 93cb8e6bac..6ead918f54 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -14,6 +14,7 @@
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
 #include <rte_tm_driver.h>
+#include <rte_spinlock.h>
 #include "rte_pmd_i40e.h"
 #include <rte_vect.h>

@@ -1157,6 +1158,13 @@ struct i40e_mbuf_stats {
 	uint64_t tx_pkt_errors;
 };

+/* Position of an Rx queue in a vector's interrupt cause list */
+struct i40e_rxq_intr_node {
+	uint16_t vec;
+	uint16_t prev;
+	uint16_t next;
+};
+
 /*
  * Structure to store private data specific for PF instance.
  */
@@ -1240,6 +1248,16 @@ struct i40e_pf {
 	/* true when interrupt path unavailable */
 	bool use_aq_polling;

+	/*
+	 * MSI-X vector with no eventfd, holding Rx queues whose interrupt is disabled.
+	 * It keeps firing internally so partial descriptor write-back still happens.
+	 * Zero when not in use.
+	 */
+	uint16_t rxq_intr_sink;
+	rte_spinlock_t rxq_intr_lock;
+	struct i40e_rxq_intr_node *rxq_intr_nodes; /* indexed by ethdev Rx queue id */
+	uint16_t *rxq_intr_heads; /* first Rx queue id per vector */
+
 	struct i40e_vf_msg_cfg vf_msg_cfg;
 	uint64_t prev_rx_bytes;
 	uint64_t prev_tx_bytes;
--
2.55.0

