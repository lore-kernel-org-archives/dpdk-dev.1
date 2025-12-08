Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B0AD3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6323A409FA;
	Mon,  8 Dec 2025 12:53:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 61EAE40678
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:52:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194777; x=1796730777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NLMdVgUhaCj0jQAdGk7K7Jr0Cb8wFdvXYs+z/22AITM=;
 b=aWa4fueoeeg7frvDkYo+LRzer7e7VYgIpRYQAFTmdASmUmDcQuF+YMx6
 OgxZGlqCkfAMd4LJxD1rKmrrnBHSWyF1kgp7+YFu7b3H1omCl2N68QqNa
 sXP8wiy8FFRILm34i5yPfGZpFUvYU4N8GCF9q09KKJSGIuPhmRQmbJ4W2
 6qlRSDjZlmq7RL2fssWknPVdC5Py2nxrCJSbRMTUuk6akHYQ0LmUqaKmA
 dlzQZAlBkKI7H4RYMH0ATjteS1uA2TOvfrClcWQHLarm1u6MSbrFDYuIp
 0LVHmNwmG4wWRLHR9MwcN14awpqU6+Yrv2q2Tw5Qt6OzNzG4hModIZ5bR A==;
X-CSE-ConnectionGUID: 2lN6nRfUQQWdunBcJkOK1Q==
X-CSE-MsgGUID: 9X6C1RX/TGqJsjD5/z70CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096058"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:57 -0800
X-CSE-ConnectionGUID: T9I/dZ0YTAmExVUYOq4k7Q==
X-CSE-MsgGUID: QzNbxVZESTuOErjOB9Fcqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970673"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:57 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 08/11] app/test: add some unattached tests to fast-test
 suite
Date: Mon,  8 Dec 2025 11:52:42 +0000
Message-ID: <20251208115245.3809624-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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
index 8580880a56..8bff904ed4 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -225,4 +225,4 @@ test_timer_secondary(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(timer_secondary_autotest, test_timer_secondary);
+REGISTER_FAST_TEST(timer_secondary_autotest, NOHUGE_SKIP, ASAN_SKIP, test_timer_secondary);
-- 
2.51.0

