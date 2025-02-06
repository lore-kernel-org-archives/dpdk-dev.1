Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B63C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EC4E41148;
	Thu,  6 Feb 2025 17:09:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 34F3E41104
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858163; x=1770394163;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pfZqtRs8SYJeBQLP+WEPF8AfBUKZCbjrDIx0iGCc74g=;
 b=DzuOUO9DpYQPqrAEswE/9ugzfQh4ZCdOCG9oPPfJaJT0OFYA+WyZt55G
 rewKu8Ec1qMJRKzDvfhAIMvvUDEE1Kmza2+VdDe8XtvkrvkTBSBph2Kko
 eBxtRxCqgIsyMdXEQhEI3/QcD7unK3Sv2Oxz6N9Pkgh5nqnbqU0Ew+yez
 VGoeHxzVKjtyDxFxsGuns2b5xD9UsPY5iISm/qoOzMyWjQWzoloUPkY8X
 dxMLJv05ln+FJHcDXYmOHsjexBqG8ZI2tkPpXUiZty2kOAoskJZ0h4feL
 l2KElOTzJDFO/JiHUtJfDtJBGughlbDVx52Ut6fiFBMmMl8vDkln1N83N g==;
X-CSE-ConnectionGUID: K86ESHukTz63NSXHQnLewQ==
X-CSE-MsgGUID: C6qSnfGxSuuNuT3mZu3lxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860759"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860759"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:23 -0800
X-CSE-ConnectionGUID: AkEDZJ0nRTm/qLEVKpTdDw==
X-CSE-MsgGUID: 3cSiC8NKT1W9aroo1aVJvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166793"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 16/24] net/e1000/base: fix iterator type
Date: Thu,  6 Feb 2025 16:08:39 +0000
Message-ID: <a3dd49e9b07d8fb6c360e07e31ac8ddc5dfca813.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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
index 208fb3f81b..b4aba9e4e3 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -2333,7 +2333,8 @@ s32 e1000_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 			       u32 usec_interval, bool *success)
 {
 	s32 ret_val = E1000_SUCCESS;
-	u16 i, phy_status;
+	u16 phy_status;
+	u32 i;
 
 	DEBUGFUNC("e1000_phy_has_link_generic");
 
-- 
2.43.5

