Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71CCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 10:06:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB53D402EB;
	Wed, 10 Jun 2026 12:06:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 343CF4026D;
 Wed, 10 Jun 2026 12:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781086008; x=1812622008;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EIcacn9HZjV3NAnFF1icttX222bbe4eM9ipJ1+DFrvc=;
 b=BoBZzOY9wO7NSHT+F2KQekIbCZPR//1X1yqVD60Y0lHMPlAGej5uHTkl
 RstBd4rB+7JoshL1cs7I01zeCbRaz9IBIvYJ5qXgPbD+iiEKYOGGhU+UB
 AoiSMlR/Khb8caXkGRgKuUR9PkbSM6LK6PiCeNcDMp2M7o/qTZTn7ENz1
 q/9Solp3leqZ4l1tuAKkNxHC8QsRsowHNhjkNwyb1daBP6mhnlLje+KLY
 Bquw7axgcMz9X2FpukfGZrfIbGnRGIR1FfIbvbcn0RuQ8aAOKryg8Un7z
 ZNI9E/FU6v8DyXHYTigtFkMYfzHziVSwwNU29G0vBQQTjwXFjmsjfkkoO g==;
X-CSE-ConnectionGUID: Y8/8a8hpT0yA5i+YACaM/A==
X-CSE-MsgGUID: v3v/yIKYS4CTuN36D4phiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85501426"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="85501426"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 03:06:46 -0700
X-CSE-ConnectionGUID: kMLw1RNwQomZQYK/TnWesg==
X-CSE-MsgGUID: 6uniyEk1RPe1eGffn8U6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245275729"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa010.jf.intel.com with ESMTP; 10 Jun 2026 03:06:44 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v5] net/iavf: fix duplicate VF reset during PF reset recovery
Date: Wed, 10 Jun 2026 10:07:04 +0000
Message-Id: <20260610100704.366722-1-anurag.mandal@intel.com>
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

This patch introduces a new flag 'pf_reset_in_progress', that is
set only when iavf_handle_hw_reset() is entered with
vf_initiated_reset as false and is cleared on exit.
Also, close-time VF reset and related close-time virtchnl
operations are skipped when PF triggered reset recovery is set.
This is done to avoid a duplicate VF reset, and keep normal
behavior for application-driven close or VF-initiated reinit.

Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without interrupt")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V5: Addressed Ciara Loftus's comments
 - added separate flag for PF initiated reset recovery 
V4: Addressed Ciara Loftus's comments
 - split VF reset from other code changes
V3: Addressed latest ai-code-review comments
V2: Addressed ai-code-review comments

 doc/guides/rel_notes/release_26_07.rst |  3 ++
 drivers/net/intel/iavf/iavf.h          |  7 +++++
 drivers/net/intel/iavf/iavf_ethdev.c   | 40 +++++++++++++++-----------
 drivers/net/intel/iavf/iavf_vchnl.c    | 18 ++++++++++--
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index d2563ac503..f6899a78c3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -95,6 +95,9 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
+    reset recovery, which earlier caused virtchnl state corruption
+    and connection loss after a top-of-rack (ToR) link flap/power-cycle.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 2615b6f034..67aacbe7a6 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -292,6 +292,13 @@ struct iavf_info {
 
 	bool in_reset_recovery;
 
+	/*
+	 * Set only while iavf_handle_hw_reset()
+	 * is processing a PF-initiated reset
+	 * (vf_initiated_reset == false).
+	 */
+	bool pf_reset_in_progress;
+
 	uint32_t ptp_caps;
 	rte_spinlock_t phc_time_aq_lock;
 };
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8031e23a5..2b6f4daa99 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3166,23 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
 
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
 
@@ -3195,7 +3199,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
-	iavf_vf_reset(hw);
+	/* Skip RESET_VF on a PF-initiated reset */
+	if (!vf->pf_reset_in_progress)
+		iavf_vf_reset(hw);
 	vf->aq_intr_enabled = false;
 	iavf_shutdown_adminq(hw);
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
@@ -3368,6 +3374,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	}
 
 	vf->in_reset_recovery = true;
+	vf->pf_reset_in_progress = !vf_initiated_reset;
 	iavf_set_no_poll(adapter, false);
 
 	/* Call the pre reset callback */
@@ -3418,6 +3425,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
 
 	vf->in_reset_recovery = false;
+	vf->pf_reset_in_progress = false;
 	iavf_set_no_poll(adapter, false);
 
 	return;
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..cf3513ef94 100644
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

