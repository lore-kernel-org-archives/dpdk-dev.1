Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3332C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 16:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E0140EDD;
	Thu, 15 May 2025 18:59:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 66AED40A79
 for <dev@dpdk.org>; Thu, 15 May 2025 18:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747328356; x=1778864356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rh3UaclUCTaG/qE/1aITilUqvJmg83TBhi0J4HQMJwQ=;
 b=ib9ZUphqF0Ru4cAEA2rIOEmX23gw6eqYy16h84uVEahUj6Gd+018ze8g
 egrZIZCcVRGotnecZcsuOoda0DjBMZ3EpWVi/UI0NcF9AXoDYxNVauln9
 +4hPXsrtyz2b8DSn02OHFPJQpzEGOiJvE6xxaJhvrSgxoZZJ/X/IVU9nZ
 3jUxo0Yum0LTPK83FKD9oAtueBf1OFmoik7p0IPJ4FZLjffQWjs7e7H7q
 7JhFl6gHVUDoBu2ro9EQOf6XTtLWsSai+AbhpSWhqqhfAmPWtuf4uIrMF
 IzUYe5q56f7s1AJ68/x7X6nU1geUNIkC4HEkcz9KSELPmnfBuYBuqKumG g==;
X-CSE-ConnectionGUID: q/YkMbSJTOqR3v2QvG2iUQ==
X-CSE-MsgGUID: TEZuofawSqukGhOxtODBdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="52952981"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="52952981"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 09:59:15 -0700
X-CSE-ConnectionGUID: 5MoS3oG/SA+Oew/du47A0g==
X-CSE-MsgGUID: k5Ro8DSQSvqBslQi5RAxUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138156552"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by orviesa009.jf.intel.com with ESMTP; 15 May 2025 09:59:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 2/2] test/power_intel_uncore: skip test if init fails
Date: Thu, 15 May 2025 17:58:54 +0100
Message-ID: <20250515165854.1087247-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250515165854.1087247-1-bruce.richardson@intel.com>
References: <20250515165854.1087247-1-bruce.richardson@intel.com>
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

If the initialization of the uncore power management fails, mark the
test as skipped rather than a failure. This prevents false failures in
the case where we are running as a normal user, who doesn't have
permissions to edit uncore power states.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_power_intel_uncore.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/app/test/test_power_intel_uncore.c b/app/test/test_power_intel_uncore.c
index 049658627d..973dc7a945 100644
--- a/app/test/test_power_intel_uncore.c
+++ b/app/test/test_power_intel_uncore.c
@@ -35,7 +35,7 @@ static int check_power_uncore_init(void)
 			"may occur if environment is not configured "
 			"correctly(APCI cpufreq) or operating in another valid "
 			"Power management environment\n", VALID_PKG, VALID_DIE);
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	/* Unsuccessful Test */
@@ -257,8 +257,11 @@ test_power_intel_uncore(void)
 	}
 
 	ret = check_power_uncore_init();
-	if (ret < 0)
+	if (ret != 0) {
+		if (ret == TEST_SKIPPED)
+			return TEST_SKIPPED;
 		goto fail_all;
+	}
 
 	ret = check_power_get_uncore_freq();
 	if (ret < 0)
-- 
2.48.1

