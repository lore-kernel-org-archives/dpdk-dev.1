Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CDAC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A33A840DCD;
	Tue, 27 May 2025 15:18:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8A2A840A79
 for <dev@dpdk.org>; Tue, 27 May 2025 15:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351882; x=1779887882;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1UvFE+XlnfK2p7c3NL8PWZ+dRnutHbyFPTSpXZ/eS2Y=;
 b=RpL587Qy54wXx84WKPlac1yKSkR8lkl6NELT7PMwKld6173/Ud5bALog
 hdgnUuI4vT4vrQCzdVWLLPtPBp2shQKtzFwPPjiAbZy2pz+uLg0ca7WAh
 qEeUJDtvYpQKXVDgAy9hNgrKgjfE/dkLbCdnUMLlCLxuCj/1rIUN0Nlw4
 lsE8qqofBPWRALUVifAhLRScorPKf1mc1Mf70sqCx5v+JRUhqQA2zAshr
 UsLIkTnEZhAV/ZyMnW+JljRFD3sp85Ebex6AoDlntJ8k6gpGBpXDcu1Oy
 7xPAseRxzyA2Iu/RxrvyPvM8jzbeRBJMynsyYkXclwjUugJbTWPJ0zdXr w==;
X-CSE-ConnectionGUID: Yopxz3+mTYK6GDKeFUsiWQ==
X-CSE-MsgGUID: a1JohFiVTquaa4yS307KNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884851"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884851"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:18:01 -0700
X-CSE-ConnectionGUID: 7+Uuy65pQ9e3+bf7XNRVoA==
X-CSE-MsgGUID: 4Tc4co3gRtuEIh3EJmCt+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150084"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:18:00 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Mikolaj Filar <mikolajx.filar@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 08/10] net/ice/base: configure PHY FEC error in logs for
 GNRD
Date: Tue, 27 May 2025 13:17:27 +0000
Message-ID: <20250527131741.7606-9-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

From: Mikolaj Filar <mikolajx.filar@intel.com>

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

