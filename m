Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4DFC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E88C40685;
	Mon, 26 May 2025 20:03:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 257E440684
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282619; x=1779818619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mVPWLIRVZA96QTH26YUW6jC7HUx8ZYnrPjXCF3JlJJc=;
 b=RyJV4CsO3vyaUnOn91UazPa0ROsku8iB4qb12et9QkjrOUiHEl++6jW5
 ju1+ahFSSINmqJmhl8SwE230UzixBZagEC+95PUZQFOUHvnJJTqWFIqE6
 g02g4l5eLX4h3XpZA9SA9bupcg4AvWySsPDyeTYNI7fWVe2Na0qpNfzFE
 Wosz0ydIhD8qlJzSDzkKPNVFwJticCA7n78ApXm4q/qFnEOElHRXW3hZM
 X+QiTcVij80Hl6mi37bUMl0UsC5T5SlT8ZknUTAS1wqzgEaagXwWIvTiv
 QJOF5usyRIcsDcX0kxExSIN3h8jUFc8UvfML55c58/bsgYOvgNocSYifT g==;
X-CSE-ConnectionGUID: h0dTVbrUQPWNb5xrmjuJaw==
X-CSE-MsgGUID: xaNuB0D5RluYRJaYAEFxxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375172"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375172"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:34 -0700
X-CSE-ConnectionGUID: lZ55+YkiQ+mMy/dqHAPcbg==
X-CSE-MsgGUID: E9yPSlzHT2GPP1rJFZckbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478303"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:33 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 03/10] net/ice/base: integer overflow issue fix
Date: Mon, 26 May 2025 18:02:51 +0000
Message-ID: <20250526180311.4573-4-dhanya.r.pillai@intel.com>
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

From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>

Fix Coverity issue related to INTEGER_OVERFLOW.

Coverity issue: 1207097
Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 297a5ea890..757b1d7658 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -25,7 +25,7 @@
  */
 static inline bool ice_is_pow2(u64 val)
 {
-	return (val && !(val & (val - 1)));
+	return val != 0 && (val & (val -1)) == 0;
 }
 
 /**
-- 
2.43.0

