Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C5C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A46D40615;
	Thu,  6 Aug 2026 10:28:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5B86F402EE;
 Thu,  6 Aug 2026 10:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786004884; x=1817540884;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AW5NlwlxM14KXhoCes5Facsvxn0z6XnuMV2MQIUn18s=;
 b=W/+wYb1hpG43wSWp0GXAbKD76URt/3JlcNec8qfGICaNXFZnXlYJo0LV
 lFJmGfzBWiKT+z8ga3wbb10GVBxZFq6ss4tBo4ePt27QWPgQ/W/iVxdlq
 DB8uryfMxrLTrozfg56Qm5mNNDSsKGeUPsrDieWVMyhoDiP4Ya4JEWH+5
 K+0VJrRqG1sh48iN46F/eECNBk+93D4HZgX+8U/Vx4HTfaspk71P65hUv
 4HXHUFB6fREZKSwaSx6EN211z1pbdD8bNfodUD3nZTaVEdIzY1wPRU8rV
 60B8/R+uOjUAGXtFMfvywYYRDY1hCsKFvCxsqkkh40uPKp+vZmLB1n8Yb A==;
X-CSE-ConnectionGUID: R9DbcHHHRq6vzdewdkcQEw==
X-CSE-MsgGUID: f4Y2aE/rRTudkps5iPqAEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86667001"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86667001"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:28:02 -0700
X-CSE-ConnectionGUID: IYnTj2D8TGWBgEtXBZm6lg==
X-CSE-MsgGUID: MavPZ49yS/6RJXR8K2EkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259421028"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 01:28:00 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH 5/5] net/iavf: improve VF reset detection on fast ARQ flip
Date: Thu,  6 Aug 2026 08:26:28 +0000
Message-Id: <ffb0fb45f27b33c90e26bf420193671f2488a172.1786004043.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786004043.git.anurag.mandal@intel.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
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

During PF-initiated reset or a remote/ToR switch link-flap,
the PF toggles the admin receive queue enable bit (ARQLEN1)
so quickly around a VF reset that the VF's sampling window
misses it, leaving the PF and the VF states out of sync
and the data path stalled.

Complement the ARQLEN1 check with VFGEN_RSTAT
(VIRTCHNL_VFR_INPROGRESS) and shorten the poll interval to
5 ms (with a proportionally larger count, keeping the ~10 s
budget), matching the Linux kernel iavf driver.
When the VFR is still not observed, proceed with recovery
instead of bailing out so the PF and  the VF states converge.

Fixes: ada64daa1a5b ("net/iavf: fix VF reset for flow director rule")
Fixes: 80fb3c920458 ("net/iavf: fix crash on VF start")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 41 +++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 037bc8436f..5e49e81447 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -21,6 +21,7 @@
 #define IAVF_AQ_BUF_SZ            4096
 #define IAVF_RESET_WAIT_CNT       2000
 #define IAVF_RESET_DETECTED_CNT   500
+#define IAVF_RESET_POLL_SCALE     4  /* Poll-interval scale for reset detection */
 #define IAVF_BUF_SIZE_MIN         1024
 #define IAVF_FRAME_SIZE_MAX       9728
 #define IAVF_QUEUE_BASE_ADDR_UNIT 128
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index f6ce339b0c..21bac51467 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3235,7 +3235,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	/* remove RSS configuration */
 	iavf_hash_uninit(adapter);
 
-	iavf_flow_flush(dev, NULL);
+	/* Skip the virtchnl-emitting teardown on a PF-initiated reset */
+	if (!vf->pf_reset_in_progress)
+		iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
 	/*
@@ -3358,8 +3360,26 @@ iavf_dev_reset(struct rte_eth_dev *dev)
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
+	 * complementary indicator, prevents from
+	 * missing a reset that really did happen.
+	 */
+	rstat = (IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT) &
+		 IAVF_VFGEN_RSTAT_VFR_STATE_MASK) >>
+		IAVF_VFGEN_RSTAT_VFR_STATE_SHIFT;
+
+	return rstat == VIRTCHNL_VFR_INPROGRESS;
 }
 
 static bool
@@ -3368,11 +3388,14 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	int i;
 
-	/* poll until we see the reset actually happen */
-	for (i = 0; i < IAVF_RESET_DETECTED_CNT; i++) {
+	/*
+	 * Poll until the reset actually happen.
+	 * Poll every 5 ms to catch the fast ARQ flips.
+	 */
+	for (i = 0; i < IAVF_RESET_DETECTED_CNT * IAVF_RESET_POLL_SCALE; i++) {
 		if (iavf_is_reset(hw))
 			return true;
-		rte_delay_ms(20);
+		rte_delay_us(5000);
 	}
 
 	return false;
@@ -3423,10 +3446,8 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
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
-- 
2.34.1

