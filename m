Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0ADC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 08:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A65B44026F;
	Thu, 24 Sep 2026 10:42:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 504254026F
 for <dev@dpdk.org>; Thu, 24 Sep 2026 10:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790239374; x=1821775374;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2oKMxq5jBYlvYEqc3LFTXGmESSBxGXur5n7QEzGjNEo=;
 b=SbUqHIwwWK41Pxn1qnEUAuSJ8UBe6T8+bkwH9ZsjROlvUWglz1/vCm06
 LTYACy57O3QzWaj06NpF1HfJtJxGzK+cWCCqVFR6wMNBnRtTcMSbPvULV
 GbRfvMrXKdZY3kijiyB+suoYOYTeaMVDy7tvOhX+Im+3V+cJF6MwFwYHH
 BG8X1a5nynoswW8RqlqlRhcmhYnPTJoxcG2Rh3T7vVFOPJOhpSH9wdhuA
 A1mDyc1uxkMbx1avH0HNM16CEuH7UBBYdaN0/LdnU1wJJmE4GHc1N1pqJ
 VVED3BxkKIlHL9BRJinzfwn/+4s3m/4oZjLY4/hj5wnO2dn9mTEgj7ZY5 Q==;
X-CSE-ConnectionGUID: xeBUBihfSsumjvUFWiL1OQ==
X-CSE-MsgGUID: 4dogh/rVQIWv4Vwjh/ohmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91022290"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="91022290"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 01:42:37 -0700
X-CSE-ConnectionGUID: 9cNAhbzxT2mQAKyOn0lMLQ==
X-CSE-MsgGUID: QCorFCX3R927Ab81qIFZ3Q==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 24 Sep 2026 01:42:36 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/iavf: fix reset race condition
Date: Thu, 24 Sep 2026 08:41:52 +0000
Message-ID: <20260924084152.11089-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

iavf_handle_hw_reset() can be called concurrently from the iavf-event
thread handling RTE_ETH_EVENT_INTR_RESET and from any thread calling
rte_pmd_iavf_reinit() (VF-initiated reset), with no synchronisation
between the two. Make in_reset_recovery atomic and use it as a guard
so only one reset runs at a time.

Fixes: 28a1a72eac26 ("net/iavf: add VF initiated reset")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  4 +--
 drivers/net/intel/iavf/iavf_ethdev.c | 39 ++++++++++++++++++----------
 drivers/net/intel/iavf/iavf_rxtx.c   |  2 +-
 drivers/net/intel/iavf/iavf_vchnl.c  |  3 ++-
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index f16f66a3e9..35e96f881a 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -295,7 +295,7 @@ struct iavf_info {
 
 	struct rte_eth_dev *eth_dev;
 
-	bool in_reset_recovery;
+	RTE_ATOMIC(bool) in_reset_recovery;
 	bool reset_pending;
 	bool pf_reset_in_progress;
 	bool start_pending;
@@ -534,7 +534,7 @@ int iavf_flow_sub_check(struct iavf_adapter *adapter,
 			struct iavf_fsub_conf *filter);
 void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
 void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
-void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
+int iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
 void iavf_hash_uninit(struct iavf_adapter *ad);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8daa507bb..b323a39e55 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -767,7 +767,8 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 	 * recovery, in which case the reset handler restores them once at the
 	 * end (avoiding a double restore).
 	 */
-	if (reset_done && !vf->in_reset_recovery) {
+	if (reset_done && !rte_atomic_load_explicit(&vf->in_reset_recovery,
+			rte_memory_order_relaxed)) {
 		ret = iavf_post_reset_reconfig(dev);
 		if (ret)
 			return ret;
@@ -3095,7 +3096,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->tpid = RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100 by default */
 	rte_spinlock_init(&adapter->phc_sync_lock);
 
-	if (!vf->in_reset_recovery && iavf_dev_event_handler_init())
+	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed) &&
+	    iavf_dev_event_handler_init())
 		goto init_vf_err;
 
 	if (iavf_init_vf(eth_dev) != 0) {
@@ -3342,7 +3344,7 @@ iavf_dev_uninit(struct rte_eth_dev *dev)
 
 	iavf_dev_close(dev);
 
-	if (!vf->in_reset_recovery)
+	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
 		iavf_dev_event_handler_fini();
 
 	return 0;
@@ -3463,11 +3465,12 @@ iavf_post_reset_reconfig(struct rte_eth_dev *dev)
 /*
  * Handle hardware reset
  */
-void
+int
 iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter = dev->data->dev_private;
+	bool expected = false;
 	int ret;
 	bool restart_device = false;
 
@@ -3475,13 +3478,21 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 		restart_device = dev->data->dev_started;
 	} else {
 		if (!dev->data->dev_started)
-			return;
+			return 0;
 
 		if (!iavf_is_reset_detected(adapter))
 			PMD_DRV_LOG(WARNING, "VFR not observed; recovering anyway");
 	}
 
-	vf->in_reset_recovery = true;
+	/* serialize against a concurrent reset from another thread */
+	if (!rte_atomic_compare_exchange_strong_explicit(&vf->in_reset_recovery,
+			&expected, true, rte_memory_order_acquire,
+			rte_memory_order_acquire)) {
+		PMD_DRV_LOG(INFO, "Reset already in progress on port %u, skipping",
+				dev->data->port_id);
+		return -EBUSY;
+	}
+
 	vf->pf_reset_in_progress = !vf_initiated_reset;
 	vf->start_pending = false;
 	iavf_set_no_poll(adapter, false);
@@ -3533,11 +3544,11 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	if (vf->post_reset_cb != NULL)
 		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
 
-	vf->in_reset_recovery = false;
+	rte_atomic_store_explicit(&vf->in_reset_recovery, false, rte_memory_order_release);
 	vf->pf_reset_in_progress = false;
 	iavf_set_no_poll(adapter, false);
 
-	return;
+	return ret;
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_reinit, 25.11)
@@ -3568,9 +3579,7 @@ rte_pmd_iavf_reinit(uint16_t port)
 		return -EINVAL;
 	}
 
-	iavf_handle_hw_reset(dev, true);
-
-	return 0;
+	return iavf_handle_hw_reset(dev, true);
 }
 
 static int
@@ -3593,7 +3602,7 @@ iavf_validate_reset_cb(uint16_t port, void *cb, void *cb_arg)
 	}
 
 	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	if (vf->in_reset_recovery) {
+	if (rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed)) {
 		PMD_DRV_LOG(ERR, "Cannot modify reset cb on port %u, VF is resetting.", port);
 		return -EBUSY;
 	}
@@ -3652,7 +3661,8 @@ iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 	bool no_poll;
 
 	no_poll = (link_change & !vf->link_up) ||
-		vf->vf_reset || vf->in_reset_recovery;
+		vf->vf_reset ||
+		rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed);
 
 	rte_atomic_store_explicit(&adapter->no_poll, no_poll,
 				  rte_memory_order_release);
@@ -3734,7 +3744,8 @@ iavf_resume_pending_start(struct rte_eth_dev *dev)
 	if (!vf->start_pending)
 		return;
 
-	if (vf->vf_reset || vf->in_reset_recovery)
+	if (vf->vf_reset || rte_atomic_load_explicit(&vf->in_reset_recovery,
+			rte_memory_order_relaxed))
 		return;
 
 	/*
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index fc47a2cf1a..84b931e78a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -1106,7 +1106,7 @@ iavf_stop_queues(struct rte_eth_dev *dev)
 	int ret;
 
 	/* adminq will be disabled when vf is resetting. */
-	if (vf->in_reset_recovery) {
+	if (rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed)) {
 		iavf_reset_queues(dev);
 		return;
 	}
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 604399125f..6c054acf80 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -260,7 +260,8 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	 * (link is down or a VF reset is in progress); the watchdog drives
 	 * auto-reset recovery, so it must remain armed in those cases.
 	 */
-	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)
+	if (vf->link_up && !vf->vf_reset &&
+	    !rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
 		iavf_dev_watchdog_disable(adapter);
 	else
 		iavf_dev_watchdog_enable(adapter);
-- 
2.43.0

