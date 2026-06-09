Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A017FCD8CB2
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 17:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E0454065F;
	Tue,  9 Jun 2026 19:38:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2CD400D5;
 Tue,  9 Jun 2026 19:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781026685; x=1812562685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jaq/6hFSNFSNRirnpQde9Yb5NTkqiTP4+nsymPukQeg=;
 b=ER2O218NraYgW0LgkK82SRr8ZTYnWQv0eEsJ5hDWAABgxi0WxoxiX231
 /v4CRGNItLBI+dH7syOsEtkIGmPutPdhz8avdrFmhJAAzK44NlWBLCKCN
 KkILd/1yyCOnQ1+dFrLM+T3xLuBORRGtsj5ZacdMEGp/GwD13Y2Fio+Cc
 IkJGDtYilG8yL2dg8Bm1a1ZOznsOCCGjV0aAOfWy/gViwC/1QGReho2nM
 xT8paOK735P0cBQycXjOc8FkgLDjzP2dt32VYb16nGgEkzqcmAqlvjDdO
 Adi6W69f9miQ7FNuW+s6d7nHelz+2w12/FV/T9UHs2JdXQKX0CqUqmfgi A==;
X-CSE-ConnectionGUID: COTSgXVzT9eDFAVlldzreA==
X-CSE-MsgGUID: W1ZciN8nRES9/QT/NgBAVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85689654"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="85689654"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 10:38:04 -0700
X-CSE-ConnectionGUID: iBVadDgoR9eBWKzCnGh2Zw==
X-CSE-MsgGUID: b3cDH8q8SY63DdVlAS9KcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="243460416"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 09 Jun 2026 10:38:01 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/iavf: fix to consolidate link change event handling
Date: Tue,  9 Jun 2026 17:38:22 +0000
Message-Id: <20260609173822.364452-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609001022.357509-1-anurag.mandal@intel.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
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

Handled link-change events through a common static function that
reads the correct advanced & legacy link fields properly and
updates no-poll/watchdog/LSC state consistently.

Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without interrupt")
Fixes: 48de41ca11f0 ("net/avf: enable link status update")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V2: Addressed Ciara Loftus's review comments
 - removed unnecessary NULL checks which were overly defensive checks

 drivers/net/intel/iavf/iavf_vchnl.c | 125 ++++++++++++++++------------
 1 file changed, 73 insertions(+), 52 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..31ce9e8987 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -216,6 +216,67 @@ iavf_convert_link_speed(enum virtchnl_link_speed virt_link_speed)
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
@@ -249,38 +310,15 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
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
 			vf->vf_reset = true;
@@ -505,6 +543,12 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		PMD_DRV_LOG(DEBUG, "Error event");
 		return;
 	}
+
+	if (pf_msg == NULL) {
+		PMD_DRV_LOG(ERR, "Invalid PF event message");
+		return;
+	}
+
 	switch (pf_msg->event) {
 	case VIRTCHNL_EVENT_RESET_IMPENDING:
 		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_RESET_IMPENDING event");
@@ -518,30 +562,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
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
-- 
2.34.1

