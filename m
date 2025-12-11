Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D9DD41D6A
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB1F540E41;
	Thu, 11 Dec 2025 18:17:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DF84540E16
 for <dev@dpdk.org>; Thu, 11 Dec 2025 18:17:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473442; x=1797009442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sp7h00+8ztdlRbDcj3SbXpaPAuBY6WQ8pkjjnm7OM5o=;
 b=i8g48xroLirE7He3b3CrJQrFyoOZ6PZ5HQm+V8vA1miQt8/hooYG9Gag
 Yny6ThrBJl3n3tUl7Q31AHVuKlHO3QZLGnKakDCEBWp1rfVIUNUlDLCkY
 hFNwszco0nD5Kiil0+R5TRLQFMUrUa1ilC9He5jOtreB/fRQsKjegWlhA
 a/WEfKHu44fMr4MU6BPlixsfyHRQzw4/K2S+O2g3rmdlWYomptYAIcRyX
 GFD+ctbokQI/Wji1lwDRnydUdEV/wrFSnwx4q+OstyuQCKpfKqBnCD+Zg
 IaPCMCaNfoJMm7rI52QNisfyDdwiAY8PO4x6k0G+pyV0OouRlKzl9yqTQ g==;
X-CSE-ConnectionGUID: m3oCVFVmSdeoS4Hye5gqcQ==
X-CSE-MsgGUID: 7lSIIsgKQzSBQtyw9NfeCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069990"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069990"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:21 -0800
X-CSE-ConnectionGUID: l2hNJH8cQHCXLna4WWks6g==
X-CSE-MsgGUID: TwyIn6zrSOK35u6OacKliA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461587"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 08/11] app/test: add some unattached tests to fast-test
 suite
Date: Thu, 11 Dec 2025 17:17:06 +0000
Message-ID: <20251211171709.714229-9-bruce.richardson@intel.com>
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

There are quite a number of test cases defined which are not present in
any test-suite. Meson warns about these on build, so reduce the warnings
by adding external-mem, ipsec-sad, power-caps and secondary timer test
cases to the fast-test suite.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_external_mem.c    | 2 +-
 app/test/test_ipsec_sad.c       | 2 +-
 app/test/test_power_cpufreq.c   | 2 +-
 app/test/test_timer_secondary.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 0c64b610a9..1c977b749b 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -587,4 +587,4 @@ test_external_mem(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(external_mem_autotest, test_external_mem);
+REGISTER_FAST_TEST(external_mem_autotest, NOHUGE_SKIP, ASAN_OK, test_external_mem);
diff --git a/app/test/test_ipsec_sad.c b/app/test/test_ipsec_sad.c
index 642643eb63..5e9dfb0f94 100644
--- a/app/test/test_ipsec_sad.c
+++ b/app/test/test_ipsec_sad.c
@@ -899,4 +899,4 @@ test_ipsec_sad(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(ipsec_sad_autotest, test_ipsec_sad);
+REGISTER_FAST_TEST(ipsec_sad_autotest, NOHUGE_OK, ASAN_OK, test_ipsec_sad);
diff --git a/app/test/test_power_cpufreq.c b/app/test/test_power_cpufreq.c
index 1d37b18fed..08bce4c0d1 100644
--- a/app/test/test_power_cpufreq.c
+++ b/app/test/test_power_cpufreq.c
@@ -679,4 +679,4 @@ test_power_caps(void)
 #endif
 
 REGISTER_FAST_TEST(power_cpufreq_autotest, NOHUGE_SKIP, ASAN_OK, test_power_cpufreq);
-REGISTER_TEST_COMMAND(power_caps_autotest, test_power_caps);
+REGISTER_FAST_TEST(power_caps_autotest, NOHUGE_OK, ASAN_OK, test_power_caps);
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index fb2cc43895..0895705ac4 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -225,4 +225,4 @@ test_timer_secondary(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(timer_secondary_autotest, test_timer_secondary);
+REGISTER_FAST_TEST(timer_secondary_autotest, NOHUGE_SKIP, ASAN_SKIP, test_timer_secondary);
-- 
2.51.0

