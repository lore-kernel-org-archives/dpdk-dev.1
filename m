Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8603C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71A9240697;
	Mon, 17 Aug 2026 08:50:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id BB65540679;
 Mon, 17 Aug 2026 08:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949400; x=1818485400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0GWUtsQtUnAOJWcrJRfNyXmkBTALUha71NF1c7MwqVQ=;
 b=hCFk8BuHNZdOr0m6H8CR7xC59ZfWwgHoEAJ2xkTlHg1NJjI4Gsb3oKdi
 hncQzr640JHC0ACC6mO5N/bfX3+cNqqc+m8ncFIqsn1LXOzk+TzRRFxws
 62i91FcYgQRChnyiKAagKZoavvifuN23HcqartezNL6o4arH7kZ1pd8LK
 BwVMtrvVRCSGWEkr3YRkQjQjZUr101N8kIx1ep7vNsZ9MOQCa5XjiJgxp
 8DQFs+qGDzDbKFs/9uVxXQyqCUW9n9bFLc1uF/2dGXvAKoGTMR7B/EiJy
 NFo8uY6CG3oZvS1KcgpR0gn0orh5s5+YJ00bJGMA4PdyaQ31RYKap/TI/ Q==;
X-CSE-ConnectionGUID: LC4I3eM5TEycWb732axm9g==
X-CSE-MsgGUID: Q0TNaXnRSPubNb3lyIyLvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095603"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="91095603"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:50:00 -0700
X-CSE-ConnectionGUID: bKSkyyhpSA+FG9URrHZIsg==
X-CSE-MsgGUID: jOaq8epARtm+ae65NHDLvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="262195979"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2026 23:49:57 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 5/7] net/iavf: improve VF reset detection on fast ARQ flip
Date: Mon, 17 Aug 2026 06:48:44 +0000
Message-Id: <1fc42bd7ae00b063f4c12c2276ad7ccea840176b.1786948817.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786948817.git.anurag.mandal@intel.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
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

