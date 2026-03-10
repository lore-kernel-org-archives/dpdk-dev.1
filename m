Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34EFCA18E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FBF14067E;
	Mon,  9 Mar 2026 22:19:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B7BF84067E;
 Mon,  9 Mar 2026 22:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091185; x=1804627185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k6nc8kLiV+ywIIvrQYjOzQWm1i85FZmGXPqUEkXeE58=;
 b=kS2ocSPm6sXfSJ3IHFsixu4HM/HkaFzZzwZWV7Rpt2AHCoIuxPFpC9kG
 Lg6Y9fWzjHy/kFxkwEuDbLedy1QihQTF6YoTVJyZLR1+tLnWDb8uSiEIj
 2UQdVSUQo2a6M9hE0CEx/wn29o+5sx3yIsgA+KUTiAeJZGtf+n0g52E3w
 eWA0OpEAz4eFONuoOtIxIc3Re+c+PfZ9w6+PXh4KtOmupJD9Yx57xGtd0
 vPpDCUYaJqc7tn7DAPbtxWp23kWeWrrXV3Bz2N9zbNr5CkKH7F9pNiRtS
 +Vh77ySkist0ne2WN6n0g2voGDZ7wBURPn6w8vATdCzsGG6WT4Q5gNI8i w==;
X-CSE-ConnectionGUID: Rcy1AIwrRcCs5xj09j4Ejg==
X-CSE-MsgGUID: tBA0Sd2+Scu05/Ok6yeiAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74241084"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74241084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:19:44 -0700
X-CSE-ConnectionGUID: I7INptiXTOmf5hkYmDuoGA==
X-CSE-MsgGUID: TrDmm7fsTVWmDPkIYyo+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219016190"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:19:42 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	stable@dpdk.org
Subject: [PATCH v1 6/6] net/ice/base: fix 'adjust' timer programming for E830
Date: Tue, 10 Mar 2026 05:52:18 -0400
Message-ID: <20260310095218.703423-16-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
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

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Fix incorrect 'adjust the timer' programming sequence for E830 devices
series. Only shadow registers GLTSYN_SHADJ were programmed in the current
implementation. According to the specification [1], write to command
GLTSYN_CMD register is also required with CMD field set to "Adjust the
Time" value, for the timer adjustment to take the effect.

The flow was broken for the adjustment less than S32_MAX/MIN range
(around +/- 2 seconds). For bigger adjustment, non-atomic programming
flow is used, involving set timer programming. Non-atomic flow is
implemented correctly.

Fixes: 881169950d80 ("net/ice/base: implement initial PTP support for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/intel/ice/base/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_ptp_hw.c b/drivers/net/intel/ice/base/ice_ptp_hw.c
index 7d16965674..5688f969ce 100644
--- a/drivers/net/intel/ice/base/ice_ptp_hw.c
+++ b/drivers/net/intel/ice/base/ice_ptp_hw.c
@@ -6083,7 +6083,7 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval,
  */
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj, bool lock_sbq)
 {
-	int err;
+	int err = 0;
 	u8 tmr_idx;
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
@@ -6101,8 +6101,8 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj, bool lock_sbq)
 		err = ice_ptp_prep_phy_adj_eth56g(hw, adj, lock_sbq);
 		break;
 	case ICE_PHY_E830:
-		/* E830 sync PHYs automatically after setting GLTSYN_SHADJ */
-		return 0;
+		/* E830 sync PHYs automatically after setting cmd register */
+		break;
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_adj_e810(hw, adj, lock_sbq);
 		break;
-- 
2.47.1

