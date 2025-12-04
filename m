Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A81D29FA7
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E43F40A6F;
	Thu,  4 Dec 2025 19:21:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D893140685
 for <dev@dpdk.org>; Thu,  4 Dec 2025 19:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872469; x=1796408469;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xV3V3l9mDJQOxbaRPe+hLXGdXLP/mYFfYjoKga9e+IY=;
 b=gx618ygnrZw8LymEKIC3Rp4e18QtAoW9Ievpyv+QRNK5lXqvlh38KyE/
 mjYhrycaD9hj4xyVt+jUX4Zvv07SY3+R8lPWjfjgbuw2uRBvpqn61xRCy
 0ghf0cUeLh6izKDrNt/3ED+tllav5601D9KGMSVYTbFejEK3bDUFoENpU
 QGKW1VFaopoy37kuL3vMQ4E5uqrFGXDcX6xF5zMx6BiVLE/H249Ri4dzU
 8FgoUkh3Q+ut1gMrX5muIiCpVaTuOotji3Vq/Io6RvGhTft0vLQO3/R0M
 N8nZsQAgY6JN2mzmK69eZe0tC6rKFXJ6xmzTWChQrhYzcYP9Nre2iCb0c A==;
X-CSE-ConnectionGUID: b2nD7juyS6+bLa5m/5PUvA==
X-CSE-MsgGUID: /BkAhCHuTMOB1f+caU2CmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013037"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013037"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:08 -0800
X-CSE-ConnectionGUID: 26qzSdWWRF+P6iB5P5PYmA==
X-CSE-MsgGUID: VSlWuJ+XTwmkr7YlPULwtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423195"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 08/10] app/test: add some unattached tests to fast-test
 suite
Date: Thu,  4 Dec 2025 18:20:45 +0000
Message-ID: <20251204182047.3154429-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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
by adding external-mem, ipsec-sad, red, power-caps and secondary timer
test cases to the fast-test suite.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_external_mem.c    | 2 +-
 app/test/test_ipsec_sad.c       | 2 +-
 app/test/test_power_cpufreq.c   | 2 +-
 app/test/test_red.c             | 2 +-
 app/test/test_timer_secondary.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
diff --git a/app/test/test_red.c b/app/test/test_red.c
index 7f38ed1469..4b17173999 100644
--- a/app/test/test_red.c
+++ b/app/test/test_red.c
@@ -1872,6 +1872,6 @@ test_red_all(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_TEST_COMMAND(red_autotest, test_red);
+REGISTER_FAST_TEST(red_autotest, NOHUGE_OK, ASAN_OK, test_red);
 REGISTER_PERF_TEST(red_perf, test_red_perf);
 REGISTER_PERF_TEST(red_all, test_red_all);
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

