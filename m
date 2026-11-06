Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85B9606A338
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NYI80FwP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B75B942DA7;
	Fri,  6 Nov 2026 10:40:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 2D41942D0C;
 Fri,  6 Nov 2026 10:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793958027; x=1825494027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RaZTEIKd5aQqIjke+rtfAHJeBXfxzsuG/k1z3Uzf+oA=;
 b=NYI80FwPEVIDAp3pkJknsfzMdZAd7aaLSLfBAaIAElTZwpXMRfTLHrHZ
 zcooQjTQVslTYW2EZuPOytT7VsP40P5ZVTm8QrodhgKpgtTipUbEzoYmP
 ma+haB0xybvRn2qLV0CdajhH+iG1CRX4KJ88MzIxp8QgQ0sTRzuH3+vIc
 WlA24auGKXCytZqIXMrOsb5isqeMa89PeSRWcJ5g+0Qnqo1Q70oyDuxDs
 kZD3/cW7oXLr4i3Z0iHTHi+wAJe/4crb0S8GZ9tRh1UGW30EQ55T1pNZG
 /x+M90zCptVWcBoGnWse1c5ciQEYj6g6OE2vswUT6kDV8zepWftxzgAUV g==;
X-CSE-ConnectionGUID: 22ysF29rRa2bdx0+yBJ1+A==
X-CSE-MsgGUID: XNqmSOaBQlyIPqj//IzKYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2808511"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2808511"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:40:26 -0800
X-CSE-ConnectionGUID: 0SyhUvQwSx+t46lz0v3cIQ==
X-CSE-MsgGUID: 34zPJ6wsQIWIqwI52IJtpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7287101"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 06 Nov 2026 01:40:25 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v4 3/4] net/iavf: fix watchdog clearing reset state during
 recovery
Date: Fri,  6 Nov 2026 09:40:11 +0000
Message-ID: <20261106094014.28784-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106094014.28784-1-ciara.loftus@intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
 <20261106094014.28784-1-ciara.loftus@intel.com>
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

Since the watchdog is kept armed across a PF reset, it can clear the
`vf_reset` flag while the reset event is still queued or being handled,
as VFGEN_RSTAT toggles while the PF resets the VF. iavf_dev_close() then
skips re-enabling PCI bus mastering, which the VF reset cleared, so
VIRTCHNL_OP_VERSION never reaches the PF, iavf_dev_init() fails and the
port is left returning -EIO. Each toggle also posts a further reset
event, causing redundant recovery cycles.

Count reset events from before `vf_reset` is set until they have been
handled, and do not let the watchdog clear the flag while any are
outstanding. Also make the `vf_reset` flag atomic, as it is accessed from
multiple places: the watchdog alarm, the interrupt thread and the virtchnl
polling path.

Fixes: a0e296420a70 ("net/iavf: keep watchdog armed for the whole reset window")
Cc: stable@dpdk.org

Suggested-by: Declan Doherty <declan.doherty@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v4:
* Remove overly defensive check after reset callback
* Added a log on event post failure
---
 drivers/net/intel/iavf/iavf.h        |   6 +-
 drivers/net/intel/iavf/iavf_ethdev.c |  32 ++++----
 drivers/net/intel/iavf/iavf_vchnl.c  | 117 +++++++++++++++++----------
 3 files changed, 94 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 5550e57c35..04c2900afe 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -261,7 +261,7 @@ struct iavf_info {
 	uint16_t mc_addrs_num;   /* Multicast mac addresses number */
 
 	struct iavf_vsi vsi;
-	bool vf_reset;	/* true for VF reset pending, false for no VF reset */
+	RTE_ATOMIC(bool)vf_reset; /* true for VF reset pending, false for no VF reset */
 	iavf_pre_reset_cb_t pre_reset_cb; /* Pre reset callback function ptr */
 	iavf_post_reset_cb_t post_reset_cb; /* Post reset callback function ptr */
 	void *pre_reset_cb_arg; /* Pre reset callback argument */
@@ -290,6 +290,7 @@ struct iavf_info {
 	struct iavf_tm_conf tm_conf;
 
 	RTE_ATOMIC(bool)in_reset_recovery;
+	RTE_ATOMIC(uint32_t)reset_events_pending;
 	bool reset_pending;
 	bool pf_reset_in_progress;
 	bool start_pending;
@@ -455,9 +456,10 @@ struct iavf_cmd_info {
 
 int iavf_check_api_version(struct iavf_adapter *adapter);
 int iavf_get_vf_resource(struct iavf_adapter *adapter);
-void iavf_dev_event_post(struct rte_eth_dev *dev,
+int iavf_dev_event_post(struct rte_eth_dev *dev,
 		enum rte_eth_event_type event,
 		void *param, size_t param_alloc_size);
+bool iavf_dev_enter_reset(struct rte_eth_dev *dev, bool drain_tx);
 void iavf_dev_event_handler_fini(void);
 int iavf_dev_event_handler_init(void);
 void iavf_handle_virtchnl_msg(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 05b90a6230..83470a636d 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -335,32 +335,27 @@ iavf_dev_watchdog(void *cb_arg)
 		return;
 
 	/* If in reset then poll vfr_inprogress register for completion */
-	if (adapter->vf.vf_reset) {
+	if (rte_atomic_load_explicit(&adapter->vf.vf_reset, rte_memory_order_acquire)) {
 		vfr_inprogress = iavf_vfr_inprogress(hw);
 
-		if (!vfr_inprogress) {
+		if (!vfr_inprogress &&
+		    rte_atomic_load_explicit(&adapter->vf.reset_events_pending,
+				rte_memory_order_acquire) == 0) {
 			PMD_DRV_LOG(INFO, "VF \"%s\" reset has completed",
 				dev->data->name);
-			adapter->vf.vf_reset = false;
+			rte_atomic_store_explicit(&adapter->vf.vf_reset, false,
+					rte_memory_order_release);
 			iavf_set_no_poll(adapter, false);
 		}
 	/* If not in reset then poll vfr_inprogress register for VFLR event */
 	} else {
 		vfr_inprogress = iavf_vfr_inprogress(hw);
 
-		if (vfr_inprogress) {
+		/* enter reset state with VFLR event */
+		if (vfr_inprogress && iavf_dev_enter_reset(dev, false))
 			PMD_DRV_LOG(INFO,
 				"VF \"%s\" reset event detected by watchdog",
 				dev->data->name);
-
-			/* enter reset state with VFLR event */
-			adapter->vf.vf_reset = true;
-			iavf_set_no_poll(adapter, false);
-			adapter->vf.link_up = false;
-
-			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-				NULL, 0);
-		}
 	}
 
 	if (adapter->devargs.watchdog_period) {
@@ -3320,8 +3315,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	 * effect.
 	 */
 out:
-	if (vf->vf_reset && !rte_pci_set_bus_master(pci_dev, true)) {
-		vf->vf_reset = false;
+	if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire) &&
+	    !rte_pci_set_bus_master(pci_dev, true)) {
+		rte_atomic_store_explicit(&vf->vf_reset, false, rte_memory_order_release);
 		iavf_set_no_poll(adapter, false);
 	}
 
@@ -3657,7 +3653,7 @@ iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 	bool no_poll;
 
 	no_poll = (link_change & !vf->link_up) ||
-		vf->vf_reset ||
+		rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire) ||
 		rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed);
 
 	rte_atomic_store_explicit(&adapter->no_poll, no_poll,
@@ -3740,8 +3736,8 @@ iavf_resume_pending_start(struct rte_eth_dev *dev)
 	if (!vf->start_pending)
 		return;
 
-	if (vf->vf_reset || rte_atomic_load_explicit(&vf->in_reset_recovery,
-			rte_memory_order_acquire))
+	if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire) ||
+	    rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_acquire))
 		return;
 
 	/*
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 34961fe654..2485f81253 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -59,6 +59,21 @@ static struct iavf_event_handler event_handler = {
 	(var) = (tvar))
 #endif
 
+static void
+iavf_dev_reset_event_handle(struct iavf_event_element *elem)
+{
+	struct rte_eth_dev *dev = elem->dev;
+	struct iavf_adapter *adapter = dev->data->dev_private;
+
+	if (adapter->devargs.auto_reset)
+		iavf_handle_hw_reset(dev, false);
+	else
+		rte_eth_dev_callback_process(dev, elem->event, elem->param);
+
+	rte_atomic_fetch_sub_explicit(&adapter->vf.reset_events_pending, 1,
+			rte_memory_order_release);
+}
+
 static uint32_t
 iavf_dev_event_handle(void *param __rte_unused)
 {
@@ -80,15 +95,10 @@ iavf_dev_event_handle(void *param __rte_unused)
 		TAILQ_FOREACH_SAFE(pos, &pending, next, save_next) {
 			TAILQ_REMOVE(&pending, pos, next);
 
-			struct iavf_adapter *adapter = pos->dev->data->dev_private;
-			if (pos->event == RTE_ETH_EVENT_INTR_RESET &&
-			    adapter->devargs.auto_reset) {
-				iavf_handle_hw_reset(pos->dev, false);
-				rte_free(pos);
-				continue;
-			}
-
-			rte_eth_dev_callback_process(pos->dev, pos->event, pos->param);
+			if (pos->event == RTE_ETH_EVENT_INTR_RESET)
+				iavf_dev_reset_event_handle(pos);
+			else
+				rte_eth_dev_callback_process(pos->dev, pos->event, pos->param);
 			rte_free(pos);
 		}
 	}
@@ -96,7 +106,7 @@ iavf_dev_event_handle(void *param __rte_unused)
 	return 0;
 }
 
-void
+int
 iavf_dev_event_post(struct rte_eth_dev *dev,
 		enum rte_eth_event_type event,
 		void *param, size_t param_alloc_size)
@@ -105,7 +115,7 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
 	char notify_byte = 0;
 	struct iavf_event_element *elem = rte_malloc(NULL, sizeof(*elem) + param_alloc_size, 0);
 	if (!elem)
-		return;
+		return -ENOMEM;
 
 	elem->dev = dev;
 	elem->event = event;
@@ -122,6 +132,55 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
 
 	ssize_t nw = write(handler->fd[1], &notify_byte, 1);
 	RTE_SET_USED(nw);
+
+	return 0;
+}
+
+/*
+ * Enter the VF reset state. If this is a new reset, rather than one already
+ * in progress, gate the datapath and post the reset event.
+ * Returns true if this call started the reset.
+ */
+bool
+iavf_dev_enter_reset(struct rte_eth_dev *dev, bool drain_tx)
+{
+	struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = &adapter->vf;
+	bool expected = false;
+
+	/*
+	 * Force link down to drop the cached link-up state; a fresh LSC up
+	 * event will be re-issued by the PF once the VF is reinitialised.
+	 */
+	vf->link_up = false;
+
+	/*
+	 * Count the event before vf_reset becomes visible. The watchdog clears
+	 * vf_reset once it sees it set with no events pending, so setting the
+	 * flag first would open a window in which the event is lost. If another
+	 * thread has already entered reset, back the count out: no event is
+	 * posted on this path.
+	 */
+	rte_atomic_fetch_add_explicit(&vf->reset_events_pending, 1, rte_memory_order_relaxed);
+	if (!rte_atomic_compare_exchange_strong_explicit(&vf->vf_reset, &expected, true,
+			rte_memory_order_release, rte_memory_order_acquire)) {
+		rte_atomic_fetch_sub_explicit(&vf->reset_events_pending, 1,
+				rte_memory_order_relaxed);
+		return false;
+	}
+
+	iavf_set_no_poll(adapter, false);
+	/* drain before posting the event, as the event handler tears down the queues */
+	if (drain_tx && adapter->devargs.no_poll_on_link_down)
+		iavf_dev_tx_drain(dev);
+
+	if (iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET, NULL, 0) != 0) {
+		PMD_DRV_LOG(ERR, "VF \"%s\" failed to post reset event", dev->data->name);
+		rte_atomic_fetch_sub_explicit(&vf->reset_events_pending, 1,
+				rte_memory_order_release);
+	}
+
+	return true;
 }
 
 int
@@ -260,7 +319,7 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	 * (link is down or a VF reset is in progress); the watchdog drives
 	 * auto-reset recovery, so it must remain armed in those cases.
 	 */
-	if (vf->link_up && !vf->vf_reset &&
+	if (vf->link_up && !rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire) &&
 	    !rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
 		iavf_dev_watchdog_disable(adapter);
 	else
@@ -324,23 +383,8 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 			iavf_handle_link_change_event(dev, vpe);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
-			/*
-			 * Force link down on impending reset to drop
-			 * the cached link-up state; a fresh LSC up
-			 * event will be re-issued by the PF once the
-			 * VF is reinitialised.
-			 */
-			vf->link_up = false;
-			if (!vf->vf_reset) {
-				vf->vf_reset = true;
-				iavf_set_no_poll(adapter, false);
+			if (iavf_dev_enter_reset(dev, true))
 				iavf_dev_watchdog_enable(adapter);
-				if (adapter->devargs.no_poll_on_link_down)
-					iavf_dev_tx_drain(dev);
-				iavf_dev_event_post(dev,
-					RTE_ETH_EVENT_INTR_RESET,
-					NULL, 0);
-			}
 			PMD_DRV_LOG(DEBUG, "VF is resetting");
 			break;
 		case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
@@ -485,7 +529,7 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args)
 	bool poll = iavf_op_needs_poll(vf);
 	int err;
 
-	if (vf->vf_reset)
+	if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire))
 		return -EIO;
 
 	resp_count = iavf_get_cmd_resp_count(args->ops);
@@ -555,7 +599,6 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct iavf_info *vf = &adapter->vf;
 	struct virtchnl_pf_event *pf_msg =
 			(struct virtchnl_pf_event *)msg;
 
@@ -571,16 +614,8 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 	switch (pf_msg->event) {
 	case VIRTCHNL_EVENT_RESET_IMPENDING:
 		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_RESET_IMPENDING event");
-		vf->link_up = false;
-		if (!vf->vf_reset) {
-			vf->vf_reset = true;
-			iavf_set_no_poll(adapter, false);
+		if (iavf_dev_enter_reset(dev, true))
 			iavf_dev_watchdog_enable(adapter);
-			if (adapter->devargs.no_poll_on_link_down)
-				iavf_dev_tx_drain(dev);
-			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-				NULL, 0);
-		}
 		break;
 	case VIRTCHNL_EVENT_LINK_CHANGE:
 		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_LINK_CHANGE event");
@@ -2394,13 +2429,13 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 
 	/* wait for interrupt notification vf is resetting */
 	while (i++ < MAX_TRY_TIMES) {
-		if (vf->vf_reset)
+		if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire))
 			break;
 		iavf_msec_delay(ASQ_DELAY_MS);
 	}
 
 	/* request queues succeeded, vf is resetting */
-	if (vf->vf_reset) {
+	if (rte_atomic_load_explicit(&vf->vf_reset, rte_memory_order_acquire)) {
 		PMD_DRV_LOG(INFO, "vf is resetting");
 		return 0;
 	}
-- 
2.43.0

