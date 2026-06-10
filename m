Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A8CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:42:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A342C40B92;
	Wed, 10 Jun 2026 17:42:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1E5FA402BA;
 Wed, 10 Jun 2026 17:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781106171; x=1812642171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WVlj6mCg6i7N7TBCzO8+TjiF1SR+jmCRKfXySdW5Nik=;
 b=K/rspGa6+bhqhl3wlc6E5Q7qJVnFcFE/LCaeCgQAGGlU/gqqhRO782wx
 9/D0UNxcqC2N8Y+rJ1J1YClEY+FXzD0888QaTDT9BTJDN7+wllQ+Lzv1Z
 6FLsGCdthi/qYU6fwT26IVRBNPUeYEIKJWm8f2RdcJFgt9ZCcOMxCtR7y
 vz+ty87FBIBD5WNuVCkOXsZGMQaOVyEv1KS3hYcNGegSk+DLy9orJ8vB4
 YjghfSRyWj679RN6sEegtQ6u2AKpU9Z4s7xnB9xhtzLctNfkY/1Ah1K80
 aU8BSDMN6fn/eHuvlIw1XNGVkDQPtEEOu0D2bTlzgvW53a9I+m5yIXX6X w==;
X-CSE-ConnectionGUID: 6dJg+yLMRBqTzCeUF0V4EA==
X-CSE-MsgGUID: 9+OJLZedTv6QHtbpjIrWrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82012152"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="82012152"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 08:42:48 -0700
X-CSE-ConnectionGUID: o0FCE4SvQjmQZ/9miJttnQ==
X-CSE-MsgGUID: EjQa/qz7RtSKsB6R5PUgWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="284289575"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa001.jf.intel.com with ESMTP; 10 Jun 2026 08:42:45 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v6] net/iavf: fix duplicate VF reset during PF reset recovery
Date: Wed, 10 Jun 2026 15:43:06 +0000
Message-Id: <20260610154306.371431-1-anurag.mandal@intel.com>
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

During PF initiated reset recovery, iavf_dev_close() sends an
extra 'VIRTCHNL_OP_RESET_VF' while recovery is already in progress.
That second reset can leave PF/VF virtchnl state inconsistent and
cause 'VIRTCHNL_OP_CONFIG_VSI_QUEUES' to fail with 'ERR_PARAM' after
ToR link flap/power-cycle, leaving the VF unable to recover.
This results in connection loss.

This patch introduces a new flag 'pf_reset_in_progress', which
is set only when iavf_handle_hw_reset() is entered for a
PF-initiated reset (vf_initiated_reset is false), and
it is cleared on exit.
The aforesaid flag is used to prevent sending close-time VF
reset and related close-time virtchnl operation messages to the
AdminQ when PF triggered reset recovery is set.
This is done to avoid duplicate VF reset requests while preserving
normal behavior for application-driven close or VF-initiated reinit.

Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without interrupt")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V6: Addressed Ciara Loftus's review comments
 - changed to concise relase note
 - removed unwarranted comment
 - added proper comments in two places
 - aligned commits with latest 'next-net-intel-for-next-net' branch
V5: Addressed Ciara Loftus's review comments
 - added separate flag for PF initiated reset recovery
V4: Addressed Ciara Loftus's review comments
 - split VF reset from other code changes
V3: Addressed latest ai-code-review comments
V2: Addressed ai-code-review comments

 doc/guides/rel_notes/release_26_07.rst |  2 ++
 drivers/net/intel/iavf/iavf.h          |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c   | 42 +++++++++++++++++---------
 drivers/net/intel/iavf/iavf_vchnl.c    | 18 +++++++++--
 4 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b5285af5fe..3832410363 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -121,6 +121,8 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Fixed duplicate send of 'VIRTCHNL_OP_RESET_VF' during PF reset recovery
+    which could cause virtchnl state corruption.
 
 * **Updated NVIDIA mlx5 ethernet driver.**
 
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 4444602a30..293adaf6c9 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -292,6 +292,7 @@ struct iavf_info {
 
 	bool in_reset_recovery;
 	bool reset_pending;
+	bool pf_reset_in_progress;
 
 	uint32_t ptp_caps;
 	rte_spinlock_t phc_time_aq_lock;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ec1ad02826..4c8a1895e4 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3168,22 +3168,29 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	ret = iavf_dev_stop(dev);
 
 	/*
-	 * Release redundant queue resource when close the dev
-	 * so that other vfs can re-use the queues.
+	 * Prevent sending close-time virtchnl messages to the AdminQ
+	 * during PF-initiated reset recovery.
 	 */
-	if (vf->lv_enabled) {
-		ret = iavf_request_queues(dev, IAVF_MAX_NUM_QUEUES_DFLT);
-		if (ret)
-			PMD_DRV_LOG(ERR, "Reset the num of queues failed");
+	if (!vf->pf_reset_in_progress) {
 
-		vf->max_rss_qregion = IAVF_MAX_NUM_QUEUES_DFLT;
-	}
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
 
-	/* Disable promiscuous mode before resetting the VF. This is to avoid
-	 * potential issues when the PF is bound to the kernel driver.
-	 */
-	if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
-		iavf_config_promisc(adapter, false, false);
+		/*
+		 * Disable promiscuous mode before resetting the VF. This is to avoid
+		 * potential issues when the PF is bound to the kernel driver.
+		 */
+		if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
+			iavf_config_promisc(adapter, false, false);
+	}
 
 	adapter->closed = true;
 
@@ -3196,7 +3203,12 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
-	iavf_vf_reset(hw);
+	/*
+	 * Prevent sending VIRTCHNL_OP_RESET_VF during PF-initiated
+	 * reset recovery.
+	 */
+	if (!vf->pf_reset_in_progress)
+		iavf_vf_reset(hw);
 	/*
 	 * If a reset is pending, wait for the PF to disable the VF's admin
 	 * receive queue (its first reset action) before we shut it down
@@ -3380,6 +3392,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	}
 
 	vf->in_reset_recovery = true;
+	vf->pf_reset_in_progress = !vf_initiated_reset;
 	iavf_set_no_poll(adapter, false);
 
 	/* Call the pre reset callback */
@@ -3430,6 +3443,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
 
 	vf->in_reset_recovery = false;
+	vf->pf_reset_in_progress = false;
 	iavf_set_no_poll(adapter, false);
 
 	return;
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 0643a835d5..08ab11ccf1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -283,9 +283,21 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 					vf->link_up ? "up" : "down");
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
-- 
2.34.1

