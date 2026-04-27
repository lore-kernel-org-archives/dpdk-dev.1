Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F06FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92C2D4065E;
	Mon, 27 Apr 2026 04:40:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2664E40655
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257608; x=1808793608;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+C1+CZXBWNFruWGqOjYUuKdPiMyiIGb0WEOJl3P1r4g=;
 b=Pul1sGkLwR2xJ9uPFeQp1FO+7/GVCLXJiFlv7PojJAcR6lfvH9s+Px/Z
 ADthJsz0QUSBjNin15mjc1A2J5uA+7g58Yp1oSPsNLcwKSe4eE8uCabSN
 hWYmXACau9OCmDjTOn3L/cpTVHaHk4x+IPMF6oSH4IK0VwpYRpqSw6VvB
 gyagvuGyAFXAJTk5HEkZplq+B/TMfZR+aDZEFtisHi4CIdn10DGC2io00
 Opfe+5/Q1WyfpGtdjv48fqfeJAjZfUbuqpsZq9OYm8ISQPdlWcCIq3DDg
 ZLrtvSrFmSEEZyocmFWvyLLwGH4jcLqdFS55LeO0qVueemkuO/VxmMZQh g==;
X-CSE-ConnectionGUID: kjVXvmZdSn++U1GZJeqm7w==
X-CSE-MsgGUID: Z26f74N3Txqpgt9N01Wazw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703510"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:07 -0700
X-CSE-ConnectionGUID: IRuz3vf/R8extDbE1YXuwA==
X-CSE-MsgGUID: rL2IoHMKRSOp5SqAatTI0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637697"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:40:05 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 6/7] net/ice: fix stale profile after L2TPv2 subtype change
Date: Mon, 27 Apr 2026 08:01:14 +0530
Message-ID: <20260427023115.1225843-7-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427023115.1225843-1-shaiq.wani@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
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

After a rule is destroyed, the HW profile for that ptype persists.
If a new rule with the same ptype but a different L2TPv2 subtype is
created (e.g. data then data_l), the old profile is reused via -EEXIST
with stale field extraction offsets.  Since data and data_l have
session_id at different byte offsets, the NIC matches on the wrong
field and packets with mismatched session_id incorrectly hit the rule.

Remove the HW profile in ice_fdir_destroy_filter when the last
filter for a given ptype is destroyed so the next rule creates a fresh
profile with the correct offsets.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 0531208066..5ea74a4a5c 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1777,6 +1777,17 @@ ice_fdir_destroy_filter(struct ice_adapter *ad,
 
 	ice_fdir_cnt_update(pf, filter->input.flow_type, is_tun, false);
 
+	/* Remove the FDIR HW profile when no filters of this ptype
+	 * remain.  The profile encodes field extraction offsets that
+	 * vary between L2TPv2 subtypes (e.g. data vs data_l).  If the
+	 * profile is not removed, a subsequent rule with a different
+	 * subtype but the same ptype reuses the stale profile via
+	 * -EEXIST and the NIC extracts session_id from the wrong
+	 * offset, causing mismatched packets to hit the rule.
+	 */
+	if (pf->fdir_fltr_cnt[filter->input.flow_type][is_tun] == 0)
+		ice_fdir_prof_rm(pf, filter->input.flow_type, is_tun);
+
 	if (filter->mark_flag == 1)
 		ice_fdir_rx_parsing_enable(ad, 0);
 
-- 
2.43.0

