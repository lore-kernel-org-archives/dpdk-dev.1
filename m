Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB710C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A49734066D;
	Mon, 26 May 2025 10:34:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EE5A3402A0
 for <dev@dpdk.org>; Mon, 26 May 2025 10:33:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248439; x=1779784439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=miwe+W1vGEysJ/QHHkMran/H8+f25Hwu1hXodB1mhLo=;
 b=W1nXz1rdRG/S+rvMugEUc9pkK5NttLedNJ07G94vSr2GfuPOJGODr0QL
 5G03bcfYd9WeXLjI8cmYNhhq9EpV2dPf9KpmXzClt7H+NF/Sw8sm+f9n3
 H3fYF+ZID2fElbhpycpw1tt2H0+0CYbrDKnpvkXXlm2qa/V8igL2ZdUGS
 qJqtbv8QReUeqBAQH+jiQMHnWfHhYXePw2Fa5xTHZSo/lLxH8WlYjjOF3
 /elSUAglEVDrueIne4ONJKL0fNIV8kWvX936+swiNKsnJnQO163SfnwnN
 fWQD+5+09QAq/gEbhNxRO63Al1Arjrg4CLIi+dSWc8u2+9MbIV7tlTHdj A==;
X-CSE-ConnectionGUID: s6dzMcS0QXKOZRO4k56BYQ==
X-CSE-MsgGUID: XZNPqYENRo6BXO2MOVwlDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009021"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009021"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:33:58 -0700
X-CSE-ConnectionGUID: 8+qxMO5JTS+OxGW5GmWMJQ==
X-CSE-MsgGUID: VjSCc3y1REe4odWhMUgNWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293489"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:33:57 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 3/9] net/ice/base: integer overflow issue fix
Date: Mon, 26 May 2025 08:33:05 +0000
Message-ID: <20250526083325.248384-4-dhanya.r.pillai@intel.com>
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

From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>

Fix Coverity issue related to INTEGER_OVERFLOW.

Coverity issue: 1207097
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

