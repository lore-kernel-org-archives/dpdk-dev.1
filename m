Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B251FF8850
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A450440662;
	Mon, 27 Apr 2026 04:40:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5CB4340651
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257605; x=1808793605;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iEA/bg86nuvdaH1T6hrFnEhrolY66/bAtSQM6c2cnPM=;
 b=A4dfbqFywo7Ylwg26kyjtxDPXc4tq3qPm6+L/FrIkcSC8jsYtYnIjbUM
 enMG8ywoDKZWpw6sLDVHxzqFdQ7A0VNCCkNi7DpKJlTCZNSvDBEmDDG2S
 LhdcLBgU3I+jd4TP0muSzHXLCrmmtasvGE4/hHdpEoFjg+Ohkt6DXhssQ
 WblQNwG+xvfqAxdeUqPaIo/B52BLPbCKIMBIIC31dV6Vk/YmoubQNKXtA
 pP1FaUHTcGClvBODfqaWmsyBwWyG9uJ2rYWXoAVHCB56sIUd1Urt0OXYh
 kBHQ1vrh5lCw/V/DXlTGxzvzQvoVClXb9rJqX0EMkIT3oUe8C/tSJTs8Y A==;
X-CSE-ConnectionGUID: wxE9AjjpQHSoAzdtwSmJFA==
X-CSE-MsgGUID: FyQcfEt/QSmQ9aNrhGAFMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703508"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:04 -0700
X-CSE-ConnectionGUID: BzpGhozyQq2K9gbvP6P4gw==
X-CSE-MsgGUID: OXpt+5u5SAym3scybFZuaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637690"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:40:02 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 4/7] net/ice: fix bare L2TPv2 flow rule deletion
Date: Mon, 27 Apr 2026 08:01:12 +0530
Message-ID: <20260427023115.1225843-5-shaiq.wani@intel.com>
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

Bare L2TPv2 flow rules (no inner PPP) fail on deletion because
ice_fdir_is_tunnel_profile() forces a 2-segment profile with an empty
inner segment the NIC cannot remove. Reset tunnel_type to NONE when
no inner fields are present so a single-segment profile is used.

Also normalize L2TPv2 flags_version in the SW hash key to only the
CTRL/LEN/VER bits, preventing delete lookup mismatches when S/O/P
bits differ from the create path.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index a0cddaeaef..c2fd07e527 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1467,6 +1467,17 @@ ice_fdir_extract_fltr_key(struct ice_fdir_fltr_pattern *key,
 	rte_memcpy(&key->l2tpv2_data, &input->l2tpv2_data, sizeof(key->l2tpv2_data));
 	rte_memcpy(&key->l2tpv2_mask, &input->l2tpv2_mask, sizeof(key->l2tpv2_mask));
 
+	/* Normalize flags: keep only CTRL/LEN/VER bits that affect
+	 * FDIR extraction offsets. Subtypes differing only in S/O/P
+	 * share the same HW entry; masking prevents spurious SW hash
+	 * mismatches and delete failures.
+	 */
+	uint16_t fv_norm = rte_cpu_to_be_16(ICE_L2TPV2_FLAGS_CTRL |
+					     ICE_L2TPV2_FLAGS_LEN |
+					     ICE_L2TPV2_FLAGS_VER);
+	key->l2tpv2_data.flags_version &= fv_norm;
+	key->l2tpv2_mask.flags_version &= fv_norm;
+
 	key->tunnel_type = filter->tunnel_type;
 }
 
@@ -2930,6 +2941,14 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP;
 	}
 
+	/* Bare L2TPv2 (no inner fields) must use single-segment profile.
+	 * PPPoL2TPv2 rules must keep the tunnel profile even without
+	 * inner field values, so only reset when PPP is not present.
+	 */
+	if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 &&
+	    input_set_i == 0 && !ppp_present)
+		tunnel_type = ICE_FDIR_TUNNEL_TYPE_NONE;
+
 	filter->tunnel_type = tunnel_type;
 	filter->input.flow_type = flow_type;
 	filter->input_set_o = input_set_o;
-- 
2.43.0

