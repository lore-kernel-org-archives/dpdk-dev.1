Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC4CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91C024028C;
	Mon, 28 Sep 2026 11:53:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 70BD840041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790589225; x=1822125225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IDEdjQeN8Z98ytZcyVZy/niRQQYzStBDl19choormIw=;
 b=B+kDDScUGMchl4FWs/rOFxAqYsJDcrvWbD+Pl0jF7MciC19x0OSF95wx
 3ULPwHzHcE2oSUmGfWyr48C6pta8IihMFVIx62b178CE5iVRhUyozkmPy
 dt39PGVLcTcA5Ih2zA5fqRWe+U/toDBXWwwH2GiaeyI96WRkh6EUbmhaO
 cGHBGnMeU0Ev3wnzV4gnDDtAim8jRWoXlDYWjsw8MBmnRfHpDt/3/8t2m
 HiaQpz/ebz416l31spyHpawsbpKC36x4aPZoSdrMLSWb/vInlRTVP4bMb
 XbRtH/ww4V6CPzx+9y13kzjJxjeBE9j3rqrNTjMg3ff/NvvSsp4Wky8ok A==;
X-CSE-ConnectionGUID: FgGJS5/kSzaiDQwUGmfTDA==
X-CSE-MsgGUID: lS95WnaESu2mdtMVkXwz6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90337671"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90337671"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 02:53:43 -0700
X-CSE-ConnectionGUID: ov8M03YpQW2rTJND8An60g==
X-CSE-MsgGUID: 59fjQMdJTSiiMePiigLRyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="271494623"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa009.fm.intel.com with ESMTP; 28 Sep 2026 02:53:42 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2] net/iavf: fix reset race condition
Date: Mon, 28 Sep 2026 09:53:25 +0000
Message-ID: <20260928095325.37968-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924084152.11089-1-ciara.loftus@intel.com>
References: <20260924084152.11089-1-ciara.loftus@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
v2:
* Use acquire ordering in iavf_resume_pending_start()
* Clear pf_reset_in_progress before the release store
---
 drivers/net/intel/iavf/iavf.h        |  4 +--
 drivers/net/intel/iavf/iavf_ethdev.c | 39 ++++++++++++++++++----------
 drivers/net/intel/iavf/iavf_rxtx.c   |  2 +-
 drivers/net/intel/iavf/iavf_vchnl.c  |  3 ++-
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index f16f66a3e9..c40b97444b 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -295,7 +295,7 @@ struct iavf_info {
 
 	struct rte_eth_dev *eth_dev;
 
-	bool in_reset_recovery;
+	RTE_ATOMIC(bool)in_reset_recovery;
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
index dafe22bdd4..6cf12ec34f 100644
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
@@ -3083,7 +3084,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->tpid = RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100 by default */
 	rte_spinlock_init(&adapter->phc_sync_lock);
 
-	if (!vf->in_reset_recovery && iavf_dev_event_handler_init())
+	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed) &&
+	    iavf_dev_event_handler_init())
 		goto init_vf_err;
 
 	if (iavf_init_vf(eth_dev) != 0) {
@@ -3330,7 +3332,7 @@ iavf_dev_uninit(struct rte_eth_dev *dev)
 
 	iavf_dev_close(dev);
 
-	if (!vf->in_reset_recovery)
+	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed))
 		iavf_dev_event_handler_fini();
 
 	return 0;
@@ -3451,11 +3453,12 @@ iavf_post_reset_reconfig(struct rte_eth_dev *dev)
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
 
@@ -3463,13 +3466,21 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
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
@@ -3520,11 +3531,11 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	if (vf->post_reset_cb != NULL)
 		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
 
-	vf->in_reset_recovery = false;
 	vf->pf_reset_in_progress = false;
+	rte_atomic_store_explicit(&vf->in_reset_recovery, false, rte_memory_order_release);
 	iavf_set_no_poll(adapter, false);
 
-	return;
+	return ret;
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_reinit, 25.11)
@@ -3555,9 +3566,7 @@ rte_pmd_iavf_reinit(uint16_t port)
 		return -EINVAL;
 	}
 
-	iavf_handle_hw_reset(dev, true);
-
-	return 0;
+	return iavf_handle_hw_reset(dev, true);
 }
 
 static int
@@ -3580,7 +3589,7 @@ iavf_validate_reset_cb(uint16_t port, void *cb, void *cb_arg)
 	}
 
 	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	if (vf->in_reset_recovery) {
+	if (rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed)) {
 		PMD_DRV_LOG(ERR, "Cannot modify reset cb on port %u, VF is resetting.", port);
 		return -EBUSY;
 	}
@@ -3639,7 +3648,8 @@ iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 	bool no_poll;
 
 	no_poll = (link_change & !vf->link_up) ||
-		vf->vf_reset || vf->in_reset_recovery;
+		vf->vf_reset ||
+		rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed);
 
 	rte_atomic_store_explicit(&adapter->no_poll, no_poll,
 				  rte_memory_order_release);
@@ -3721,7 +3731,8 @@ iavf_resume_pending_start(struct rte_eth_dev *dev)
 	if (!vf->start_pending)
 		return;
 
-	if (vf->vf_reset || vf->in_reset_recovery)
+	if (vf->vf_reset || rte_atomic_load_explicit(&vf->in_reset_recovery,
+			rte_memory_order_acquire))
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

