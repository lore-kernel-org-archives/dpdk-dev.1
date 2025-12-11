Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51340D41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A073540E37;
	Thu, 11 Dec 2025 18:17:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2B18A40E16
 for <dev@dpdk.org>; Thu, 11 Dec 2025 18:17:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473441; x=1797009441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w/7zeUoZ7mCFB1NxfN987xebHZYmo2YGUzh06uRCiPs=;
 b=U2eAXx2u3EAVS1JBCLRXwHHhIXUBzwSO8FEGEeyG7O9+94y84fsifGol
 JXkUYWEmJLjpKwUYD0F7HFX7RjcdiBrpJ/B859RzIKpOzp6Q7RxQInaUI
 YtkHFUXH9XcjH7MGkEwtWq4GipwS9R2c6PO+7P+z9LBETIUeMrxoev2KB
 gQadnbZ9gxMhfaCU5ZbGNU2hYcH/QNS/VNFpkP0StDmuIrln2lyiWq+Ip
 qFF97KtdXMidGHumdxzv/KHnzACl/oGyGU/JUG3QTSfNje/itykXobDyG
 lrQD2ObNB9lojw9l0SlJb1ezwGaEpEij7nrOnY4sxZpmK993Bj07kxjr0 Q==;
X-CSE-ConnectionGUID: C5OBxstnQzGpXwzVSuLLlw==
X-CSE-MsgGUID: 0iHkVXXYR7ORTO/2SIgA1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069988"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:21 -0800
X-CSE-ConnectionGUID: wQXMfCJ5TsKsSE9SgwEe7Q==
X-CSE-MsgGUID: 718LOKrtRImMUMpYbpdB4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461581"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 07/11] app/test: skip power capabilities test if unsupported
Date: Thu, 11 Dec 2025 17:17:05 +0000
Message-ID: <20251211171709.714229-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
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

If the power subsystem cannot be initialized e.g. due to not being root,
skip the capabilities test, rather than failing it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_power_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_power_cpufreq.c b/app/test/test_power_cpufreq.c
index 96de255f27..1d37b18fed 100644
--- a/app/test/test_power_cpufreq.c
+++ b/app/test/test_power_cpufreq.c
@@ -661,7 +661,7 @@ test_power_caps(void)
 			"correctly(APCI cpufreq) or operating in another valid "
 			"Power management environment\n", TEST_POWER_LCORE_ID);
 		rte_power_unset_env();
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	ret = rte_power_get_capabilities(TEST_POWER_LCORE_ID, &caps);
-- 
2.51.0

