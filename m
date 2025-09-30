Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447FCCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 14:29:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9A224025F;
	Tue, 30 Sep 2025 16:29:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6EADA40151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 16:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759242547; x=1790778547;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=amZc6jqKMIWfJBIBDORJZGUkABKEV7s0MA5pMd1ITa0=;
 b=bg3Ma2rQAVhFpB7UzK/e7BjyITP9tGIuxhoRjKCBF0KzaMceMrs8u/ES
 8kTTi9FKkJzXgpn5d8h7+5Vrpa9B4EAIPzti30vgA6dduTh4ar7jWzAwq
 CfIf+ZCD7+7HGPQrUYobSaMR4oIEC5QPPr1slmcc0A/u86/yNGUCWK6Tp
 TiQEE17hfnMQxOJFHf1fWNXQqF/xvl53BUawMbXtWgXRaaLGQZBu9uTvw
 Aaddbno4O6Xs8fbXfVvQ+14gCq9fOi2OccvDxE1rYrOxFCFSS/wVs/UTH
 dd8zVLWdYi8mxdjLiXrNMU78Xde6n1/WtlECaGfkpE64W7Hb9ep7FeEtM Q==;
X-CSE-ConnectionGUID: A5FwWuZmTRqJH/a1ChSHSw==
X-CSE-MsgGUID: PhKzEPwxQoiXBlaM3jVyng==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65139468"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="65139468"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 07:29:03 -0700
X-CSE-ConnectionGUID: t70PHkpATEKpzmY7rmaW7w==
X-CSE-MsgGUID: LjBqsBQPQTeHwiDwNTcfwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="183797659"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2025 07:28:58 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/ice: fix initialization with 8 ports
Date: Tue, 30 Sep 2025 15:28:50 +0100
Message-ID: <20250930142850.1782615-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

When initializing an 8-port device, the ACL configuration
failed with the adminq returning an ENOMEM status from the
sixth port onwards. Fix this issue by halving the depth, and
therefore the space required, when using a device with >4 PFs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 83cb3e36f9..38e30a4f62 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -114,7 +114,10 @@ ice_acl_setup(struct ice_pf *pf)
 	else
 		params.width = ICE_AQC_ACL_KEY_WIDTH_BYTES * 3;
 
-	params.depth = ICE_AQC_ACL_TCAM_DEPTH;
+	if (pf_num > 4)
+		params.depth = ICE_AQC_ACL_TCAM_DEPTH / 2;
+	else
+		params.depth = ICE_AQC_ACL_TCAM_DEPTH;
 	params.entry_act_pairs = 1;
 	params.concurr = false;
 
-- 
2.43.0

