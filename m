Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D93CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 05:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11DB540658;
	Mon,  8 Jun 2026 07:44:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 89739402D6;
 Mon,  8 Jun 2026 07:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780897454; x=1812433454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vY2QTZWAcvTog32YHDJdeP2SH0dkntatj9dlmk+h0Ks=;
 b=n8UWPbxkgMSajdA06N1bevKZ3jUw+X/z3QfrOeqXHYRw6hHP8i0kQ8LD
 7L2L7H2Yr7SkSxe155YSSwUw3aBG3u++uIyZKfmMJD2+77Y1t/IRuYamS
 qtiS9pZAdpdXsopJe1L9Lny7ZuHaNYCG/33HVmH6nCfbs4B8eE5M426iQ
 f3VRyuinjg/LEGVe7oNizLRKwY/BsIRrnrw4Fng6ALZVS9bEdzkA87Nw3
 9v1Fa4xoEQLJ25z9MunhIaY437yKT9rx04/5MJvPkGStuNEgApqtuEE4L
 q6PzQs6f7Pts+P40+VW4U3Lpl3+Ybf5y+0n8bSx9thVqmL8xcNatqBeul w==;
X-CSE-ConnectionGUID: vFtCvFxVT/i2iQn1gLDlHA==
X-CSE-MsgGUID: D4lZeL7PRzKh6FMj3Hy86Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="84199633"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="84199633"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 22:44:13 -0700
X-CSE-ConnectionGUID: H+0qtiYTQB6KET/DzBwO9A==
X-CSE-MsgGUID: FhDZdNOhR9qJpSNYX568sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; d="scan'208";a="245554925"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 07 Jun 2026 22:44:10 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset recovery
Date: Mon,  8 Jun 2026 05:44:33 +0000
Message-Id: <20260608054433.351880-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605202911.314359-1-anurag.mandal@intel.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
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
ToR link flap/power-cycle, leaving the VF unable to recover.
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
V3: Addressed latest ai-code-review comments
V2: Addressed ai-code-review comments

 doc/guides/rel_notes/release_26_07.rst |   3 +
 drivers/net/intel/iavf/iavf_ethdev.c   |  37 +++---
 drivers/net/intel/iavf/iavf_vchnl.c    | 155 ++++++++++++++++---------
 3 files changed, 123 insertions(+), 72 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b8a3e2ced9..e7ac730369 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -89,6 +89,9 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
+    reset recovery, which earlier caused virtchnl state corruption
+    and connection loss after a top-of-rack (ToR) link flap/power-cycle.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index bdf650b822..fb6f287d3c 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3166,24 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
 
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
+	if (!adapter->closed && !vf->in_reset_recovery) {
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
+		/*
+		 * Disable promiscuous mode before resetting the VF. This is to avoid
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
@@ -3195,7 +3198,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
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
index 94ccfb5d6e..4f35fdc72d 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -216,6 +216,75 @@ iavf_convert_link_speed(enum virtchnl_link_speed virt_link_speed)
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
+	struct iavf_adapter *adapter;
+	struct iavf_info *vf;
+	bool adv_link_speed;
+
+	if (dev == NULL || dev->data == NULL ||
+	    dev->data->dev_private == NULL || vpe == NULL) {
+		PMD_DRV_LOG(ERR, "Invalid device pointer in link change handler");
+		return;
+	}
+
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	vf = &adapter->vf;
+
+	adv_link_speed = (vf->vf_res != NULL) &&
+		((vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_ADV_LINK_SPEED) != 0);
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
+	 *
+	 * Keeping the watchdog enabled whenever the link cannot be trusted
+	 * (link is down or a VF reset is in progress); the watchdog drives
+	 * auto-reset recovery, so it must remain armed in those cases.
+	 */
+	if (vf->link_up && !vf->vf_reset)
+		iavf_dev_watchdog_disable(adapter);
+	else
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
@@ -249,43 +318,32 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 	if (opcode == VIRTCHNL_OP_EVENT) {
 		struct virtchnl_pf_event *vpe =
 			(struct virtchnl_pf_event *)event.msg_buf;
+		if (vpe == NULL) {
+			PMD_DRV_LOG(ERR, "Invalid PF event message");
+			return IAVF_MSG_ERR;
+		}
 
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
-			PMD_DRV_LOG(INFO, "VF is resetting");
+			/*
+			 * Force link down on impending reset to drop
+			 * the cached link-up state; a fresh LSC up
+			 * event will be re-issued by the PF once the
+			 * VF is reinitialised.
+			 */
+			vf->link_up = false;
+			if (!vf->vf_reset) {
+				vf->vf_reset = true;
+				iavf_set_no_poll(adapter, false);
+				iavf_dev_event_post(vf->eth_dev,
+					RTE_ETH_EVENT_INTR_RESET,
+					NULL, 0);
+			}
+			PMD_DRV_LOG(DEBUG, "VF is resetting");
 			break;
 		case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
 			vf->dev_closed = true;
@@ -518,30 +576,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
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
@@ -570,7 +605,15 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 	while (pending) {
 		ret = iavf_clean_arq_element(hw, &info, &pending);
 
-		if (ret != IAVF_SUCCESS) {
+		/*
+		 * IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means AQ is empty
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

