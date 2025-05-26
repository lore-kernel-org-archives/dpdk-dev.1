Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA1C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A353C406B7;
	Mon, 26 May 2025 10:34:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id A45DE40684
 for <dev@dpdk.org>; Mon, 26 May 2025 10:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248456; x=1779784456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6aspodEQmmK6GDU+cdJk3G4sd4nJC4u7leEJnIPykt8=;
 b=dCuI2Tfsy7QaBkr50vtcsNKKcz6CJgmIU/plVQMG6TmwTTkpJsM2V4mB
 Y/DWmBN75QB3WWNGkpUei7NguV93vMSMC8bg6oMusSHSJhpeEfKnEk+PZ
 mvaGPqT431oHEehlg9x90FCd6KVuR7K8BPJFRqeF6++nDZaxLnkt1rk9g
 8fy02qxy/B7XPMTN1bQ1JbHlFUhu2JZIAcW9a7nCj0JCmAI0eLQHHGJ6l
 QFsOSFWbsG53AB8Ns+MYO3Yl9fIw3XK+RiJWXz/DaxIO4DSsnKZ5sQO4t
 FdugpKqgrZlB4aftGxn8AVfSOh0BJhLgVv+PV+yJ+LXQlGjJHf79hKT5S Q==;
X-CSE-ConnectionGUID: MzBucLBZTaWZHGWKrZmteQ==
X-CSE-MsgGUID: KdbuIR+ZRZqzZNFiy32n1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009050"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009050"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:34:15 -0700
X-CSE-ConnectionGUID: HoF56TWhRJSXP4Q4/44DLA==
X-CSE-MsgGUID: 1Tkmo6qfTu6QelfmSphgdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293603"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:34:14 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, "Filar, Mikolaj" <mikolajx.filar@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 8/9] net/ice/base: configure PHY FEC error in logs for GNRD
Date: Mon, 26 May 2025 08:33:10 +0000
Message-ID: <20250526083325.248384-9-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
References: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

From: "Filar, Mikolaj" <mikolajx.filar@intel.com>

Configure PHY FEC error in logs for GNRD

Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 69070b740e..9ba656d8ec 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -6554,6 +6554,8 @@ bool ice_fw_supports_fec_dis_auto(struct ice_hw *hw)
 {
 	if (ice_is_e830(hw))
 		return true;
+	if (ice_is_e825c(hw))
+		return true;
 	return ice_is_fw_min_ver(hw, ICE_FW_VER_BRANCH_E810,
 				 ICE_FW_FEC_DIS_AUTO_MAJ,
 				 ICE_FW_FEC_DIS_AUTO_MIN,
-- 
2.43.0

