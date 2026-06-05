Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1A2CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B49402E0;
	Fri,  5 Jun 2026 22:28:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 6975F4021F;
 Fri,  5 Jun 2026 22:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780691330; x=1812227330;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A4XJjwk3kNBV+kUlVl4xnWAA19v8eRKauHT4d7rQc1A=;
 b=WvW3IjfBkHbruJi+ove11cDET8XmWMsWHV6SD/UAFjgxcYLX89wCWGU6
 AhkgjEdJdFNmhdFfxmtWCmJg3D+kpyJJuLmFbuY3V+nKdLc1bT9T0VW28
 XlgB2MTB/gBNohDcqpoOLYS4GwHo6i/8PPFNhG4DjkIYLBBPb7td6AJ5s
 jad4JiRm0G79RkdAX7WuRsp/r4tn8Yv56qaB7IHn2lyBbnW5feY6Ggge6
 sduQOM5D71wsY97nYXpSu8vWN0NOYmTV2AGyTEnlUooxlVJqA6tgm1DAP
 YayPZbF344rmTnoZlYxv2MaP0c0n8mf77NNvFqOuXFwaNgoMjnwPbyO48 w==;
X-CSE-ConnectionGUID: gd5TLc4LSEabpxzzS8dUqg==
X-CSE-MsgGUID: PWwRcbXyRHW+HBn2/iW4QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="106970538"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="106970538"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 13:28:48 -0700
X-CSE-ConnectionGUID: kdOtzRQQTo+AtEv0j2N5EQ==
X-CSE-MsgGUID: yHIYhlJKQ+yr5Yg4JxOWmg==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 05 Jun 2026 13:28:46 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix duplicate VF reset during PF reset recovery
Date: Fri,  5 Jun 2026 20:29:11 +0000
Message-Id: <20260605202911.314359-1-anurag.mandal@intel.com>
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

During PF initiated reset recovery, iavf_dev_close() sending
an extra VIRTCHNL_OP_RESET_VF while recovery is already in progress.
That second reset can leave PF/VF virtchnl state inconsistent and
cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after
ToR link flap, leaving the VF unable to recover.
This results in connection loss.

Skipped close-time VF reset and related close-time virtchnl
operations when PF triggered reset recovery is set. This is
done to avoid a duplicate VF reset, and keep normal behavior
for application-driven close.
Handled link-change events through a common static function that
reads the correct advanced & legacy link fields properly and
updates no-poll/watchdog/LSC state consistently.
Also added IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message
drain as a normal empty-queue condition and avoid logging it as
an misleading AQ failure.

Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without interrupt")
Fixes: 5c8ca9f13c78 ("net/iavf: fix no polling mode switching")
Fixes: 48de41ca11f0 ("net/avf: enable link status update")
Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c |  36 ++++----
 drivers/net/intel/iavf/iavf_vchnl.c  | 130 +++++++++++++++------------
 2 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index bdf650b822..a936748397 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3166,24 +3166,26 @@ iavf_dev_close(struct rte_eth_dev *dev)
 
 	ret = iavf_dev_stop(dev);
 
-	/*
-	 * Release redundant queue resource when close the dev
-	 * so that other vfs can re-use the queues.
-	 */
-	if (vf->lv_enabled) {
-		ret = iavf_request_queues(dev, IAVF_MAX_NUM_QUEUES_DFLT);
-		if (ret)
-			PMD_DRV_LOG(ERR, "Reset the num of queues failed");
+	/* Skip RESET_VF on a PF-initiated reset */
+	if (!vf->in_reset_recovery) {
+		/*
+		 * Release redundant queue resource when close the dev
+		 * so that other vfs can re-use the queues.
+		 */
+		if (vf->lv_enabled) {
+			ret = iavf_request_queues(dev, IAVF_MAX_NUM_QUEUES_DFLT);
+			if (ret)
+				PMD_DRV_LOG(ERR, "Reset the num of queues failed");
+			vf->max_rss_qregion = IAVF_MAX_NUM_QUEUES_DFLT;
+		}
 
-		vf->max_rss_qregion = IAVF_MAX_NUM_QUEUES_DFLT;
+		/* Disable promiscuous mode before resetting the VF. This is to avoid
+		 * potential issues when the PF is bound to the kernel driver.
+		 */
+		if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
+			iavf_config_promisc(adapter, false, false);
 	}
 
-	/* Disable promiscuous mode before resetting the VF. This is to avoid
-	 * potential issues when the PF is bound to the kernel driver.
-	 */
-	if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
-		iavf_config_promisc(adapter, false, false);
-
 	adapter->closed = true;
 
 	/* free iAVF security device context all related resources */
@@ -3195,7 +3197,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
-	iavf_vf_reset(hw);
+	/* Skip RESET_VF on a PF-initiated reset */
+	if (!vf->in_reset_recovery)
+		iavf_vf_reset(hw);
 	vf->aq_intr_enabled = false;
 	iavf_shutdown_adminq(hw);
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..fd22973a68 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -216,6 +216,63 @@ iavf_convert_link_speed(enum virtchnl_link_speed virt_link_speed)
 	return speed;
 }
 
+/*
+ * iavf_handle_link_change_event: common handler for VIRTCHNL link change events
+ *
+ * @dev: pointer to rte_eth_dev for this VF
+ * @vpe: pointer to the virtchnl_pf_event payload received from the PF
+ *
+ * Handle PF link-change event: decode adv/legacy link info, update VF
+ * link state, sync no-poll/watchdog behavior & notify app via LSC event.
+ */
+static void
+iavf_handle_link_change_event(struct rte_eth_dev *dev,
+			      struct virtchnl_pf_event *vpe)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = &adapter->vf;
+	bool adv_link_speed;
+
+	adv_link_speed = (vf->vf_res != NULL) &&
+		(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_ADV_LINK_SPEED);
+
+	if (adv_link_speed) {
+		vf->link_up = vpe->event_data.link_event_adv.link_status;
+		vf->link_speed = vpe->event_data.link_event_adv.link_speed;
+	} else {
+		enum virtchnl_link_speed speed;
+
+		vf->link_up = vpe->event_data.link_event.link_status;
+		speed = vpe->event_data.link_event.link_speed;
+		vf->link_speed = iavf_convert_link_speed(speed);
+	}
+
+	iavf_dev_link_update(dev, 0);
+
+	/*
+	 * Update watchdog/no_poll state BEFORE notifying the application via
+	 * the LSC event. Otherwise the application's link-up callback could
+	 * race with stale (link-down) no_poll/watchdog state and either
+	 * continue to drop traffic or trigger a spurious reset detection.
+	 */
+	if (vf->link_up && !vf->vf_reset)
+		iavf_dev_watchdog_disable(adapter);
+	else if (!vf->link_up)
+		iavf_dev_watchdog_enable(adapter);
+
+	if (adapter->devargs.no_poll_on_link_down) {
+		iavf_set_no_poll(adapter, true);
+		PMD_DRV_LOG(DEBUG, "VF no poll turned %s",
+			    adapter->no_poll ? "on" : "off");
+	}
+
+	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
+
+	PMD_DRV_LOG(INFO, "Link status update:%s",
+		vf->link_up ? "up" : "down");
+}
+
 /* Read data in admin queue to get msg from pf driver */
 static enum iavf_aq_result
 iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
@@ -253,38 +310,17 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 		result = IAVF_MSG_SYS;
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
-			vf->link_up =
-				vpe->event_data.link_event.link_status;
-			if (vf->vf_res != NULL &&
-			    vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
-				vf->link_speed =
-				    vpe->event_data.link_event_adv.link_speed;
-			} else {
-				enum virtchnl_link_speed speed;
-				speed = vpe->event_data.link_event.link_speed;
-				vf->link_speed = iavf_convert_link_speed(speed);
-			}
-			iavf_dev_link_update(vf->eth_dev, 0);
-			iavf_dev_event_post(vf->eth_dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
-			if (vf->link_up && !vf->vf_reset) {
-				iavf_dev_watchdog_disable(adapter);
-			} else {
-				if (!vf->link_up)
-					iavf_dev_watchdog_enable(adapter);
-			}
-			if (adapter->devargs.no_poll_on_link_down) {
-				iavf_set_no_poll(adapter, true);
-				if (adapter->no_poll)
-					PMD_DRV_LOG(DEBUG, "VF no poll turned on");
-				else
-					PMD_DRV_LOG(DEBUG, "VF no poll turned off");
-			}
-			PMD_DRV_LOG(INFO, "Link status update:%s",
-					vf->link_up ? "up" : "down");
+			iavf_handle_link_change_event(vf->eth_dev, vpe);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
-			vf->vf_reset = true;
-			iavf_set_no_poll(adapter, false);
+			vf->link_up = false;
+			if (!vf->vf_reset) {
+				vf->vf_reset = true;
+				iavf_set_no_poll(adapter, false);
+				iavf_dev_event_post(vf->eth_dev,
+					RTE_ETH_EVENT_INTR_RESET,
+					NULL, 0);
+			}
 			PMD_DRV_LOG(INFO, "VF is resetting");
 			break;
 		case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
@@ -518,30 +554,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		break;
 	case VIRTCHNL_EVENT_LINK_CHANGE:
 		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_LINK_CHANGE event");
-		vf->link_up = pf_msg->event_data.link_event.link_status;
-		if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_ADV_LINK_SPEED) {
-			vf->link_speed =
-				pf_msg->event_data.link_event_adv.link_speed;
-		} else {
-			enum virtchnl_link_speed speed;
-			speed = pf_msg->event_data.link_event.link_speed;
-			vf->link_speed = iavf_convert_link_speed(speed);
-		}
-		iavf_dev_link_update(dev, 0);
-		if (vf->link_up && !vf->vf_reset) {
-			iavf_dev_watchdog_disable(adapter);
-		} else {
-			if (!vf->link_up)
-				iavf_dev_watchdog_enable(adapter);
-		}
-		if (adapter->devargs.no_poll_on_link_down) {
-			iavf_set_no_poll(adapter, true);
-			if (adapter->no_poll)
-				PMD_DRV_LOG(DEBUG, "VF no poll turned on");
-			else
-				PMD_DRV_LOG(DEBUG, "VF no poll turned off");
-		}
-		iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
+		iavf_handle_link_change_event(dev, pf_msg);
 		break;
 	case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
 		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_PF_DRIVER_CLOSE event");
@@ -570,7 +583,14 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 	while (pending) {
 		ret = iavf_clean_arq_element(hw, &info, &pending);
 
-		if (ret != IAVF_SUCCESS) {
+		/* IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means AQ is empty
+		 * and is a normal way to terminate the drain loop.
+		 * Log error only for genuine other failure codes.
+		 * Incorrect logging like this during VF resets might
+		 * mislead into chasing a non-existent AQ failure.
+		 */
+		if (ret != IAVF_SUCCESS &&
+		    ret != IAVF_ERR_ADMIN_QUEUE_NO_WORK) {
 			PMD_DRV_LOG(INFO, "Failed to read msg from AdminQ,"
 				    "ret: %d", ret);
 			break;
-- 
2.34.1

