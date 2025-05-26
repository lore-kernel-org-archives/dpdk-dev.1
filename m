Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85DFC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:04:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF7B440BA2;
	Mon, 26 May 2025 20:03:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0306340B8D
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282625; x=1779818625;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N++Db+s+yZqjUXZHOJorwre8EzSWEWX5zjW/XHRpyUM=;
 b=iZmUJCrYXLwNyj7LqLxi+iaLmdpZKkunA3gkPBmjNxy7h3YnmMV6xv8j
 Pxie68mmE26Qql+lyYgz81MbV5vhxMwNt5CZJVYVFWFRSR/+eTNW610mm
 1uqTni9Z9tvcfWwMAxEVXX4483RghGXA048KA3tH6veyJKqTQWv5+s4Si
 vyTMerw9vdPLsvpGecGJVeFKnWKb1IUTIS7+XWksHuomv4UCOcZUNETSG
 hFtU488FPyF9CnPOvmq94iYVU8lrsLO1eZFsUWoB7TrIBmw62dh3iHovr
 BRvpZRrex+9O7fXADkWIqBM+0o6Ew7441RVQLzIKrt9OX0yNyqizpGEz0 Q==;
X-CSE-ConnectionGUID: aHjWwMvUT5K8zATuKUKsxQ==
X-CSE-MsgGUID: /qnVEueASuKRzKHOovHvVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375182"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375182"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:44 -0700
X-CSE-ConnectionGUID: QLupayI3Qk25Crj3RcP8nQ==
X-CSE-MsgGUID: aAglGBg/RLaTXdTfwBKWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478320"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:43 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, "Filar, Mikolaj" <mikolajx.filar@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 08/10] net/ice/base: configure PHY FEC error in logs for
 GNRD
Date: Mon, 26 May 2025 18:02:56 +0000
Message-ID: <20250526180311.4573-9-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

Signed-off-by: Mikolaj Filar <mikolajx.filar@intel.com>
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

