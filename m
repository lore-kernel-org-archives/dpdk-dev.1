Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC6EF4EA4
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C37044026A;
	Mon,  6 Apr 2026 10:19:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4197C40265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 10:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775463573; x=1806999573;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1Kuv/w4ZvuhxbLOGqhKmakJ8YmR1EQdKE4l6QA+Vogk=;
 b=lz0XGs2y497eNsJwNwYP/OsWI3sQcZRFGKeWGx6T3gnEvE513pdmofe0
 X8bqchsglObF8RTOpRAS8GGgIkdB4HoPd0vpMIQUngxG+6wTLiMGSMs2z
 FY/fx2c6um1qlQWm9+YjCPBaMwToS0a1u+Ynb16bFwzZj+EPTUE+sJJx3
 DsTIh7vPHviw/B7lxyv3AFmm6qO47EJqf2iHxCkrzDMlN6XoAYB1FgBiz
 d7WSin36c91EzSJjlnv2Ym1uz3Rh8k+9EVP10ERwJcn26xRBrIVaZcXoQ
 zvBMYCfMGtROLVkoKqCSilyNaX61eNxGiI9U7mWc9/SfsvDJaOafwc2zE Q==;
X-CSE-ConnectionGUID: dqSgibPlTgyDzCJvOA5+BA==
X-CSE-MsgGUID: dITBDROiTWuAshxPIxSr9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="79007039"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="79007039"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 01:19:32 -0700
X-CSE-ConnectionGUID: uwxvi+R+R1eyTCu0sbKR5A==
X-CSE-MsgGUID: n5KXuySWRg+srjCnLTFbKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="250941268"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa002.fm.intel.com with ESMTP; 06 Apr 2026 01:19:31 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/ice: add missing SMAC field mapping in flow input set
Date: Mon,  6 Apr 2026 13:44:39 +0530
Message-ID: <20260406081439.3241409-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
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

ice_inset_map[] has no entry for ICE_INSET_SMAC, so source MAC is never
translated to ICE_FLOW_FIELD_IDX_ETH_SA. flow rules specifying a source
MAC silently match any source address.

Add the missing {ICE_INSET_SMAC, ICE_FLOW_FIELD_IDX_ETH_SA} entry.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 3522d77123..b3fdb1a9d7 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -967,6 +967,7 @@ ice_fdir_input_set_parse(uint64_t inset, enum ice_flow_field *field)
 	};
 	static const struct ice_inset_map ice_inset_map[] = {
 		{ICE_INSET_DMAC, ICE_FLOW_FIELD_IDX_ETH_DA},
+		{ICE_INSET_SMAC, ICE_FLOW_FIELD_IDX_ETH_SA},
 		{ICE_INSET_ETHERTYPE, ICE_FLOW_FIELD_IDX_ETH_TYPE},
 		{ICE_INSET_IPV4_SRC, ICE_FLOW_FIELD_IDX_IPV4_SA},
 		{ICE_INSET_IPV4_DST, ICE_FLOW_FIELD_IDX_IPV4_DA},
-- 
2.43.0

