Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBFFE73150
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF40340BA2;
	Mon,  2 Feb 2026 10:44:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8CCDE40B90
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770025448; x=1801561448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rwNn+6j9KyeBiqfMLnKnpBl+vRCYCBY7lzj3Wke+Brc=;
 b=CMeSrlTnRnuZgAEPAt2OHVZTHz9S4t8gY6icCQ0pgh3Io+V4/I9S693w
 y+ZY4C9fXCFJxHwPMRhEFeTqWWkbwCCo8m5Ihcaq5YqrkSQy+pV5O96ys
 tXMuxnoDSrxVICgZ2CohjMDBH1rx7zTTPKIbQLK2cfQemCmkn5ZUAMhIR
 8oaqU520RHTCjundOK7BliOPGF2ZPBrQOEJ2nllV3vCabh+4EHcUjxYGG
 SEKweIPlswCiEyOlESdgIrCuW2hKpasw9MaPyVzANzIE/VB+4E8cOIU1u
 4mVbig4MSsLL3iOWP0bVQf24jnNG6U2WTj5c0djSTfMVjcjjjXgpXo1IA Q==;
X-CSE-ConnectionGUID: NQpgQC6dQFagbqJn8Y4OWw==
X-CSE-MsgGUID: o7EjrMn1Q1SyIENT/xwRzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81917714"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="81917714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 01:44:07 -0800
X-CSE-ConnectionGUID: QBnLUbbVQlGvB75jwDlu3A==
X-CSE-MsgGUID: Vz1HcqX3QjSfrAS64y+myg==
X-ExtLoop1: 1
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 02 Feb 2026 01:44:06 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Jiale Song <songx.jiale@intel.com>
Subject: [PATCH 5/6] net/ice: add L2TPv2 hardware packet generation
Date: Mon,  2 Feb 2026 15:12:43 +0530
Message-Id: <20260202094244.447966-6-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
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

Add L2TPv2 packet type cases to ice_fdir_get_gen_prgm_pkt() to enable
hardware packet generation for FDIR rule programming.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Jiale Song <songx.jiale@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index f62313c559..2c0cb99854 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -4027,6 +4027,9 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 				   ICE_NONDMA_TO_NONDMA);
 			loc = &pkt[ICE_FDIR_V6_V4_GTPOGRE_EH_PKT_OFF];
 			break;
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
@@ -4038,6 +4041,9 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 						      idx, offset, tun);
 			loc = &pkt[pos];
 			break;
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
-- 
2.34.1

