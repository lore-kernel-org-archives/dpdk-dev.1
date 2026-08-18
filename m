Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A386BC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31EB54067D;
	Tue, 18 Aug 2026 06:58:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id EC27640613;
 Tue, 18 Aug 2026 06:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787029121; x=1818565121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j0uUc4Au1t3ZTQpSvF6pyfwtD8z5H9R9w9edFS+ZKDM=;
 b=Qtsmt9bKlkFT+fESyYntmDPpOX2eJRzjNCej2ZDATlJTniviBjgKbbvK
 rs0FXjDlHpfml+o670pPsvP/89+9PyeIZJaeLDe8dY3v0qXHs1t6KrsSM
 6Ad1M4HMY+rPXNXa6pOxy7cAG3ybScKfNvKKwVvFnbtZwWqfhZqFYRVz9
 pm53pLXbLv3Ex5YXqmY/z2IdTLDPE1je2RNmozeMxZdD4J5PicnoPnvIT
 E8OQ6NT18hS0+IufI+nrLtL/pUPICHRJKbUwQNBBeBlpu79Ra37F0k08K
 y76x3sva2tSpD/VQoDaRn1BNlqiZ7FoDtpd/UL8H0gnW8TbuwJpkq8t7p Q==;
X-CSE-ConnectionGUID: lwb6bwWdR4WqWc4HLOYNtA==
X-CSE-MsgGUID: mPj7wtxASyCKJr2wroCqoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87633004"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87633004"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 21:58:41 -0700
X-CSE-ConnectionGUID: HVBIMLi2RTyRB8JPNQibkw==
X-CSE-MsgGUID: GRjBOW3USv2QCgsWfcLWQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268611255"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 17 Aug 2026 21:58:38 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v4 3/7] net/iavf: drain in-flight Tx before reset
Date: Tue, 18 Aug 2026 04:57:28 +0000
Message-Id: <5378bcef21b78ea6e50355d0de37d576e0ea5b03.1787028683.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
References: <cover.1787028683.git.anurag.mandal@intel.com>
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

On an impending PF reset, in-flight Tx descriptors were
left pending when the queues were torn down, which could
trigger Malicious Driver Detection (MDD) events and
leak descriptors.

Added iavf_dev_tx_drain() to let already-posted Tx bursts
complete and flush the rings within a bounded budget,
and call it on reset-impending events before teardown,
preventing MDD events and descriptor leaks.
The drain selects the cleanup routine that matches the
active Tx path.

Fixes: ece7d7eef04f ("net/iavf: fix duplicate VF reset during PF reset recovery")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Ciara Loftus<ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c  | 100 ++++++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.h  |   6 ++
 drivers/net/intel/iavf/iavf_vchnl.c |   4 ++
 3 files changed, 110 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4f2ffe6188..db332cc682 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -32,6 +32,7 @@
 
 #include "iavf.h"
 #include "iavf_rxtx.h"
+#include "iavf_rxtx_vec_common.h"
 #include "iavf_ipsec_crypto.h"
 #include "rte_pmd_iavf.h"
 
@@ -4025,6 +4026,105 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	return (int)pkt_cnt;
 }
 
+/*
+ * Reclaim completed Tx descriptors for a single queue using the cleanup
+ * routine that matches the active Tx path.
+ * Returns true if any descriptors were reclaimed.
+ */
+static bool
+iavf_tx_drain_cleanup(struct ci_tx_queue *txq,
+		      enum iavf_tx_func_type tx_func_type)
+{
+	switch (tx_func_type) {
+	case IAVF_TX_AVX2_CTX:
+	case IAVF_TX_AVX2_CTX_OFFLOAD:
+	case IAVF_TX_AVX512_CTX:
+	case IAVF_TX_AVX512_CTX_OFFLOAD:
+		return ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true) != 0;
+	case IAVF_TX_NEON:
+	case IAVF_TX_AVX2:
+	case IAVF_TX_AVX2_OFFLOAD:
+	case IAVF_TX_AVX512:
+	case IAVF_TX_AVX512_OFFLOAD:
+		return ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false) != 0;
+	case IAVF_TX_DEFAULT:
+	default:
+		return ci_tx_xmit_cleanup(txq) == 0;
+	}
+}
+
+/*
+ * iavf_dev_tx_drain - drain in-flight Tx descriptors after an
+ * impending PF reset event.
+ */
+void
+iavf_dev_tx_drain(struct rte_eth_dev *dev)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	enum iavf_tx_func_type tx_func_type = adapter->tx_func_type;
+	struct ci_tx_queue *txq;
+	uint64_t hz, deadline;
+	int idle_iters = 0;
+	uint16_t qid;
+
+	/*
+	 * Allow any Tx burst already in flight on a data-plane lcore to
+	 * write its remaining descriptors and notify. After
+	 * this window, the no_poll gate set by the caller is observed at
+	 * the next burst-entry and no new descriptors will be posted.
+	 */
+	rte_delay_us_block(IAVF_TX_DRAIN_SETTLE_US);
+
+	hz = rte_get_timer_hz();
+	deadline = rte_get_timer_cycles() +
+		(hz * IAVF_TX_DRAIN_TIMEOUT_US) / 1000000ULL;
+
+	while (rte_get_timer_cycles() < deadline) {
+		bool any_pending = false;
+		bool any_progress = false;
+
+		for (qid = 0; qid < dev->data->nb_tx_queues; qid++) {
+			txq = dev->data->tx_queues[qid];
+			if (txq == NULL ||
+			    dev->data->tx_queue_state[qid] !=
+				RTE_ETH_QUEUE_STATE_STARTED)
+				continue;
+
+			/*
+			 * nb_tx_free == nb_tx_desc - 1 means the ring is
+			 * empty (one descriptor is always reserved).
+			 */
+			if (txq->nb_tx_free >= txq->nb_tx_desc - 1)
+				continue;
+
+			any_pending = true;
+			if (iavf_tx_drain_cleanup(txq, tx_func_type))
+				any_progress = true;
+		}
+
+		if (!any_pending)
+			return;
+
+		if (any_progress) {
+			idle_iters = 0;
+		} else if (++idle_iters >= IAVF_TX_DRAIN_IDLE_MAX) {
+			/*
+			 * HW has not advanced the RS-bit write-back for
+			 * several polling intervals; either the queue is
+			 * quiescent except for the sub-rs_thresh tail
+			 * (which we cannot observe here) or HW is no
+			 * longer fetching. Further polling is unlikely to
+			 * help, and the PF teardown path has its own
+			 * grace period for the remainder.
+			 */
+			break;
+		}
+
+		rte_delay_us_block(IAVF_TX_DRAIN_POLL_US);
+	}
+}
+
 int
 iavf_dev_tx_done_cleanup(void *txq, uint32_t free_cnt)
 {
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 22ea415f44..4088bc421c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -506,6 +506,11 @@ enum iavf_tx_ctx_desc_tunnel_l4_tunnel_type {
 /* Valid indicator bit for the time_stamp_low field */
 #define IAVF_RX_FLX_DESC_TS_VALID	(0x1UL)
 
+#define IAVF_TX_DRAIN_TIMEOUT_US	10000	/* total drain budget: 10 ms */
+#define IAVF_TX_DRAIN_SETTLE_US		100	/* let in-flight burst land  */
+#define IAVF_TX_DRAIN_POLL_US		50	/* poll interval             */
+#define IAVF_TX_DRAIN_IDLE_MAX		20	/* ~1 ms of no RS write-back */
+
 int iavf_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			   uint16_t queue_idx,
 			   uint16_t nb_desc,
@@ -641,6 +646,7 @@ void iavf_set_default_ptype_table(struct rte_eth_dev *dev);
 void iavf_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 void iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq);
 enum rte_vect_max_simd iavf_get_max_simd_bitwidth(void);
+void iavf_dev_tx_drain(struct rte_eth_dev *dev);
 
 static inline
 void iavf_dump_rx_descriptor(struct ci_rx_queue *rxq,
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index b6864d8d69..565e81e176 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -330,6 +330,8 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 			if (!vf->vf_reset) {
 				vf->vf_reset = true;
 				iavf_set_no_poll(adapter, false);
+				if (adapter->devargs.no_poll_on_link_down)
+					iavf_dev_tx_drain(vf->eth_dev);
 				iavf_dev_event_post(vf->eth_dev,
 					RTE_ETH_EVENT_INTR_RESET,
 					NULL, 0);
@@ -568,6 +570,8 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		if (!vf->vf_reset) {
 			vf->vf_reset = true;
 			iavf_set_no_poll(adapter, false);
+			if (adapter->devargs.no_poll_on_link_down)
+				iavf_dev_tx_drain(dev);
 			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
 				NULL, 0);
 		}
-- 
2.34.1

