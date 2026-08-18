Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0570C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B5144069D;
	Tue, 18 Aug 2026 06:58:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E6524068E;
 Tue, 18 Aug 2026 06:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787029128; x=1818565128;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0GWUtsQtUnAOJWcrJRfNyXmkBTALUha71NF1c7MwqVQ=;
 b=M0sihtLnl0e/6EF/6mHton7tXx08rKhBfqw/vg6NlgRwd9mWIaIQMp3o
 5CdSqDtwVOTXvujPLPZ3pQzdkpF+LNDsIdbvexrbEltej2AAYaUPoLA1y
 An3SVA0a2Q/DzfaGpZZsfm9vwBDyI/Po7BLrTc3XqwxVDUfwWYL53uEfB
 yiSwaik9soF+KnPSil0cIwOiX0akI8VmP6q3yaLOG7cDa6Iix6Bs8tn43
 LBUUYYacgydEbIhjCtiUBDuout7pUHL/sSJDBvbgLsv4STfHPjdzc+tWn
 WhsBYD8A0PKAs9BaHOWX+P0B5xKoANUCLLpw1VHKxSpVXqK7/Hn6ObvG3 w==;
X-CSE-ConnectionGUID: LiTy1PE6TxmV4Dt8LIzMgw==
X-CSE-MsgGUID: V6nK4hMPTZ6awALetndKuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87633021"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87633021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 21:58:47 -0700
X-CSE-ConnectionGUID: CwNC8VapSdalOXAEv1ggjw==
X-CSE-MsgGUID: vrDbEA/GQfSGJneVgPBToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268611288"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 17 Aug 2026 21:58:45 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v4 5/7] net/iavf: improve VF reset detection on fast ARQ flip
Date: Tue, 18 Aug 2026 04:57:30 +0000
Message-Id: <88850d22e9dfaff94930fb65557117ee1bccfbcd.1787028683.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
References: <cover.1787028683.git.anurag.mandal@intel.com>
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
instead of bailing out so the PF and the VF states converge.

Fixes: 80fb3c920458 ("net/iavf: fix crash on VF start")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 37 +++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 605e9dd3aa..d57040e630 100644
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
index 0f5eb57bbe..322b59d68c 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3358,8 +3358,26 @@ iavf_dev_reset(struct rte_eth_dev *dev)
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
@@ -3368,11 +3386,14 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
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
@@ -3423,10 +3444,8 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
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

