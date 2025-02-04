Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D2FC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A049942E5A;
	Tue,  4 Feb 2025 16:12:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1A12B42D99;
 Tue,  4 Feb 2025 16:12:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681947; x=1770217947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5dhqorFP9/BSydVJ1RS0jOTf95JA5YwtTydkUA5UleY=;
 b=glpQdiS4Mhu8tZaqMoixFKvHxCJ60yY/lF6myOqGw+JGWmbackQUo25q
 smuz8x9OnoeCkjewlr18v1K9IKJwWMVYOsrRwXorYfuSjxL0kW2PE9lwd
 LDnLFT+YFL40XlytGMONl64K62STOSIgFXCL6xKGWnV9q3c6tw5hCQ/cu
 QGW03SGra7+nEXD4/CMobnRgWlW4IXNY8I42An54XScf/tihCpY3CfCLF
 gfUrn5C9MY+yCT9MqU3zRMatQ/CKWdaB6fRqw65CUC24zQSpVT1GL/2PE
 F9XAOj4OcoKuwewWbvzIx+eh4AjUUxAGjWVkcmRoR1leABcjplzWu6iPX g==;
X-CSE-ConnectionGUID: D+xqPXPzSouhlvmkHLNwWQ==
X-CSE-MsgGUID: YVAM0WQCSFOn+scvwj6ouA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097184"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097184"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:26 -0800
X-CSE-ConnectionGUID: vxnFpRMVR5ua4RXQCouBKw==
X-CSE-MsgGUID: pY+N5sodT6aXBEWpti+M0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792774"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 46/54] net/e1000/base: fix iterator type
Date: Tue,  4 Feb 2025 15:10:52 +0000
Message-ID: <95ef3e061a76e761bfa0505529c4da9001aec0d6.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Amir Avivi <amir.avivi@intel.com>

Fix static analysis warning about comparison between types of
incompatible width, which might lead to an infinite loop due to overflow.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Amir Avivi <amir.avivi@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 06505d855e..b449c6ef42 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -2441,7 +2441,8 @@ s32 e1000_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 			       u32 usec_interval, bool *success)
 {
 	s32 ret_val = E1000_SUCCESS;
-	u16 i, phy_status;
+	u16 phy_status;
+	u32 i;
 
 	DEBUGFUNC("e1000_phy_has_link_generic");
 
-- 
2.43.5

