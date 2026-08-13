Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B5C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F5A642D92;
	Thu, 13 Aug 2026 12:46:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7D47542831
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786618008; x=1818154008;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/+iCaK3SIHhfAtrlyr5KOlqbY5uPmpu4xfco8G4iPRU=;
 b=GFI6EUbZNlPQ3hcQ1+RIP1/NxeY/K9p+VCXEZY7Tc5JAI7fyEmsUVaVJ
 LqMH+/LT1hpXcXpZET3Nb0+rjLfQlQ+mHVKvw1YTauyADSH8oOLArr34F
 Az8c5YTJt25aZo8hZSE5NvKHvAxz23XA6D2NhFk+RXKGrSRsNsN1ioOak
 w3d6bT8FA0w/deFKh8prfAcb1Wsj1lm4QfdB4s407d29dmljQ5s83t+ch
 i3QVp9efSGpaf4iDgjUjTjO8LNIuitB9qy0kkD3PhnYplSl4CEF7piKcb
 sQ8/IysobgUToPPmwhsmYh6Qach4TQQvY2UyIwGs4PV51naUSoTjANBlU Q==;
X-CSE-ConnectionGUID: AHBV9t1ERNqWDLbuhMhOyw==
X-CSE-MsgGUID: WFeTHDhpT/uMIogvXk1ndw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89709000"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89709000"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:48 -0700
X-CSE-ConnectionGUID: hn9092oqS0ykgXcYTaIeWQ==
X-CSE-MsgGUID: iHK/qRGLT6idhUeB4kZzLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264491569"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 03:46:46 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 5/7] net/iavf: improve VF reset detection on fast ARQ flip
Date: Thu, 13 Aug 2026 10:45:33 +0000
Message-Id: <1087472087390290d367d3906743894ae20871c7.1786617159.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786617159.git.anurag.mandal@intel.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
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

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
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

