Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF8C4451B
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 21:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A80A40297;
	Fri, 17 Jul 2026 23:15:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 385484013F
 for <dev@dpdk.org>; Fri, 17 Jul 2026 23:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784322951; x=1815858951;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aiUzZ+gGYxMz7H0FFKQKfYpOBHeWweDWFOU5vViO5e8=;
 b=CUON6UN0v7JBk9UPSu4n1PCZ8TZVr5KYLdSztsVdKDTGQEsqadx2X4Pm
 mvkd85cFtEJrE2OA6hq6BitmNq1TFXbpG/h8RQ1av1mG/S68aNXs6APMj
 sfJEvtHSQsBs6c2pOO1Z6mMHZTeM6s+f06jJ6hIQySL3zvAjk3uxcR6r0
 ffGe0m1dhhHleUFdue2AhjY8t59nnThvQjNvPd02BhW1wYXx7G/jXkOxQ
 Kn3N2EGWzrAXOrLGJkEpARjutTUCybMu0EgXHZPGP655PUH/+EYttgoEc
 jCm8GTA0k+rueabsmhrIZfASZ0sOXY5ivHEX4VhG6ZBnBmVi8wXkLC8mA g==;
X-CSE-ConnectionGUID: Wp08/0DtRceO7qSQj4e1EQ==
X-CSE-MsgGUID: wGdggc+HTIWuymI8m0Ex5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85117426"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="85117426"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 14:15:50 -0700
X-CSE-ConnectionGUID: OdRjOftXTL+0INVfAKk57w==
X-CSE-MsgGUID: X0X6O+D/S1yd0Jp/8hrINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; d="scan'208";a="252480834"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa006.fm.intel.com with ESMTP; 17 Jul 2026 14:15:47 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/iavf: harden reset recovery and data path on link flap
Date: Fri, 17 Jul 2026 21:15:26 +0000
Message-Id: <20260717211526.716220-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

During PF-initiated reset or a remote/ToR switch link-flap, the VF
might miss the reset event, race on the no_poll gate, leak in-flight
Tx descriptors, and stay down if dev_start ran before the PF VSI was
ready.

This patch builds on the earlier reset-recovery fixes with the
following:

- Reset detection: complement the ARQLEN1 check with VFGEN_RSTAT
  (VIRTCHNL_VFR_INPROGRESS) and poll at a 5 ms interval, matching the
  kernel iavf driver, so fast ARQ flips are not missed. When the VFR
  is still not observed, recover anyway instead of bailing out,
  keeping PF and VF state in sync.

- no_poll: make the flag atomic (RTE_ATOMIC) with release/acquire
  ordering so the data-plane lcores observe gate changes reliably.

- Tx drain: add iavf_dev_tx_drain() to flush in-flight Tx descriptors
  on link-down and impending-reset events before teardown, preventing
  MDD events and descriptor leaks.

- Deferred start: when dev_start fails during recovery (PF VSI inactive),
  defer it via start_pending and resume on the next link-up event so the
  VF comes back without manual intervention.

- AdminQ: discard zeroed (opcode 0) descriptors seen during PF-initiated
  resets to avoid the "Request 0 is not supported" log flood.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  4 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 88 +++++++++++++++++++++++-----
 drivers/net/intel/iavf/iavf_rxtx.c   | 77 +++++++++++++++++++++++-
 drivers/net/intel/iavf/iavf_rxtx.h   |  6 ++
 drivers/net/intel/iavf/iavf_vchnl.c  | 40 ++++++++++++-
 5 files changed, 195 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..037bc8436f 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -293,6 +293,7 @@ struct iavf_info {
 	bool in_reset_recovery;
 	bool reset_pending;
 	bool pf_reset_in_progress;
+	bool start_pending;
 
 	uint32_t ptp_caps;
 	rte_spinlock_t phc_time_aq_lock;
@@ -391,7 +392,7 @@ struct iavf_adapter {
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[IAVF_MAX_PKT_TYPE];
 	bool stopped;
 	bool closed;
-	bool no_poll;
+	RTE_ATOMIC(bool)no_poll;
 	enum iavf_rx_func_type rx_func_type;
 	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
@@ -533,4 +534,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
 void iavf_hash_uninit(struct iavf_adapter *ad);
+void iavf_resume_pending_start(struct rte_eth_dev *dev);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..eaabef41ed 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3212,7 +3212,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* remove RSS configuration */
 	iavf_hash_uninit(adapter);
 
-	iavf_flow_flush(dev, NULL);
+	/* Skip the virtchnl-emitting teardow on a PF-initiated reset */
+	if (!vf->pf_reset_in_progress)
+		iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
 	/*
@@ -3335,8 +3337,27 @@ iavf_dev_reset(struct rte_eth_dev *dev)
 static inline bool
 iavf_is_reset(struct iavf_hw *hw)
 {
-	return !(IAVF_READ_REG(hw, IAVF_VF_ARQLEN1) &
-		IAVF_VF_ARQLEN1_ARQENABLE_MASK);
+	uint32_t rstat;
+
+	/* ARQ has been disabled by the PF as part of the VFR. */
+	if (!(IAVF_READ_REG(hw, IAVF_VF_ARQLEN1) &
+		IAVF_VF_ARQLEN1_ARQENABLE_MASK))
+		return true;
+
+	/*
+	 * VFGEN_RSTAT reports VIRTCHNL_VFR_INPROGRESS.
+	 * At times, the PF flips ARQENABLE so quickly
+	 * around a VFR that the ARQLEN1 sample window
+	 * misses it. Using VFGEN_RSTAT, as a
+	 * complementary indicator, help to prevent
+	 * from declaring "reset not start" when a
+	 * reset really did happen.
+	 */
+	rstat = (IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT) &
+		 IAVF_VFGEN_RSTAT_VFR_STATE_MASK) >>
+		IAVF_VFGEN_RSTAT_VFR_STATE_SHIFT;
+
+	return rstat == VIRTCHNL_VFR_INPROGRESS;
 }
 
 static bool
@@ -3345,11 +3366,17 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	int i;
 
-	/* poll until we see the reset actually happen */
-	for (i = 0; i < IAVF_RESET_DETECTED_CNT; i++) {
+	/*
+	 * Poll until we see the reset actually happen.
+	 * Poll every 5 ms to catch the fast ARQ flips.
+	 * Total wait time is unchanged (~10 s) since
+	 * the count is scale up by the same factor
+	 * that the per-iteration delay shrinks.
+	 */
+	for (i = 0; i < IAVF_RESET_DETECTED_CNT * 4; i++) {
 		if (iavf_is_reset(hw))
 			return true;
-		rte_delay_ms(20);
+		rte_delay_us(5000);
 	}
 
 	return false;
@@ -3400,14 +3427,13 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 		if (!dev->data->dev_started)
 			return;
 
-		if (!iavf_is_reset_detected(adapter)) {
-			PMD_DRV_LOG(DEBUG, "reset not start");
-			return;
-		}
+		if (!iavf_is_reset_detected(adapter))
+			PMD_DRV_LOG(WARNING, "VFR not observed; recovering anyway");
 	}
 
 	vf->in_reset_recovery = true;
 	vf->pf_reset_in_progress = !vf_initiated_reset;
+	vf->start_pending = false;
 	iavf_set_no_poll(adapter, false);
 
 	/* Call the pre reset callback */
@@ -3428,10 +3454,17 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	if (!vf_initiated_reset || restart_device) {
 		/* start the device */
 		ret = iavf_dev_start(dev);
-		if (ret)
-			goto error;
-
-		dev->data->dev_started = 1;
+		if (ret == 0) {
+			dev->data->dev_started = 1;
+		} else {
+			PMD_DRV_LOG(WARNING,
+				    "dev_start failed during reset recovery (rc=%d);"
+				    "deferring to next link-up event",
+				    ret);
+			vf->start_pending = true;
+			dev->data->dev_started = 0;
+			ret = 0;
+		}
 	}
 
 	/* Restore settings after the reset */
@@ -3573,9 +3606,13 @@ void
 iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 {
 	struct iavf_info *vf = &adapter->vf;
+	bool no_poll;
 
-	adapter->no_poll = (link_change & !vf->link_up) ||
+	no_poll = (link_change & !vf->link_up) ||
 		vf->vf_reset || vf->in_reset_recovery;
+
+	rte_atomic_store_explicit(&adapter->no_poll, no_poll,
+				  rte_memory_order_release);
 }
 
 static int
@@ -3645,6 +3682,27 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
 	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
 }
 
+void
+iavf_resume_pending_start(struct rte_eth_dev *dev)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	int ret;
+
+	if (!(vf->link_up && vf->start_pending))
+		return;
+
+	PMD_DRV_LOG(DEBUG, "PF link back up; resuming deferred dev_start");
+	ret = iavf_dev_start(dev);
+	if (ret == 0) {
+		dev->data->dev_started = 1;
+		vf->start_pending = false;
+	} else {
+		PMD_DRV_LOG(ERR,
+			    "deferred dev_start failed (ret=%d); will retry on next link-up",
+			    ret);
+	}
+}
+
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4f2ffe6188..1dbc7aa74a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3722,7 +3722,9 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct ci_rx_queue *rxq = rx_queue;
 	enum iavf_rx_func_type rx_func_type;
 
-	if (!rxq->iavf_vsi || rxq->iavf_vsi->adapter->no_poll)
+	if (!rxq->iavf_vsi ||
+	    rte_atomic_load_explicit(&rxq->iavf_vsi->adapter->no_poll,
+				     rte_memory_order_acquire))
 		return 0;
 
 	rx_func_type = rxq->iavf_vsi->adapter->rx_func_type;
@@ -3738,7 +3740,9 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_queue *txq = tx_queue;
 	enum iavf_tx_func_type tx_func_type;
 
-	if (!txq->iavf_vsi || txq->iavf_vsi->adapter->no_poll)
+	if (!txq->iavf_vsi ||
+	    rte_atomic_load_explicit(&txq->iavf_vsi->adapter->no_poll,
+				     rte_memory_order_acquire))
 		return 0;
 
 	tx_func_type = txq->iavf_vsi->adapter->tx_func_type;
@@ -4025,6 +4029,75 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	return (int)pkt_cnt;
 }
 
+/*
+ * iavf_dev_tx_drain - drain in-flight Tx descriptors after a link-down or
+ * impending PF reset event.
+ */
+void
+iavf_dev_tx_drain(struct rte_eth_dev *dev)
+{
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
+			if (ci_tx_xmit_cleanup(txq) == 0)
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
index f8fffa7802..513c3e18dd 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -260,7 +260,7 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	 * (link is down or a VF reset is in progress); the watchdog drives
 	 * auto-reset recovery, so it must remain armed in those cases.
 	 */
-	if (vf->link_up && !vf->vf_reset)
+	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)
 		iavf_dev_watchdog_disable(adapter);
 	else
 		iavf_dev_watchdog_enable(adapter);
@@ -268,9 +268,27 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	if (adapter->devargs.no_poll_on_link_down) {
 		iavf_set_no_poll(adapter, true);
 		PMD_DRV_LOG(DEBUG, "VF no poll turned %s",
-			    adapter->no_poll ? "on" : "off");
+			    rte_atomic_load_explicit(&adapter->no_poll,
+						     rte_memory_order_relaxed) ?
+						     "on" : "off");
+		if (!vf->link_up)
+			iavf_dev_tx_drain(dev);
 	}
 
+	/*
+	 * Resume a deferred dev_start.
+	 * iavf_handle_hw_reset() sets vf->start_pending when
+	 * reset recovery completed dev_init() but iavf_dev_start()
+	 * itself failed (typically -EIO from VIRTCHNL_OP_CONFIG_VSI_QUEUES
+	 * when the PF VSI was inactive).
+	 * A link-up event implies the PF VSI is active again, so retry now.
+	 * Run before the LSC event post so the port is ready to accept Tx
+	 * by the time the app's link-up callback fires; no_poll has already
+	 * been cleared above so bursts go through as soon as
+	 * dev_start sets dev_started=1.
+	 */
+	iavf_resume_pending_start(dev);
+
 	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
 
 	PMD_DRV_LOG(INFO, "Link status update:%s",
@@ -327,6 +345,8 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 			if (!vf->vf_reset) {
 				vf->vf_reset = true;
 				iavf_set_no_poll(adapter, false);
+				if (adapter->devargs.no_poll_on_link_down)
+					iavf_dev_tx_drain(vf->eth_dev);
 				iavf_dev_event_post(vf->eth_dev,
 					RTE_ETH_EVENT_INTR_RESET,
 					NULL, 0);
@@ -565,6 +585,9 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		if (!vf->vf_reset) {
 			vf->vf_reset = true;
 			iavf_set_no_poll(adapter, false);
+			iavf_dev_watchdog_enable(adapter);
+			if (adapter->devargs.no_poll_on_link_down)
+				iavf_dev_tx_drain(dev);
 			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
 				NULL, 0);
 		}
@@ -614,6 +637,19 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 			break;
 		}
 		aq_opc = rte_le_to_cpu_16(info.desc.opcode);
+
+		/*
+		 * During PF-initiated resets, iavf_clean_arq_element() has
+		 * been observed to return IAVF_SUCCESS with a fully zeroed
+		 * descriptor (opcode 0).
+		 * Without this guard, such descriptors would fall through
+		 * to the default case of the dispatch switch below and the
+		 * "Request 0 is not supported yet" log flood reported in
+		 * the field would be produced. These are discarded now.
+		 */
+		if (aq_opc == 0)
+			continue;
+
 		/* For the message sent from pf to vf, opcode is stored in
 		 * cookie_high of struct iavf_aq_desc, while return error code
 		 * are stored in cookie_low, Which is done by PF driver.
-- 
2.34.1

