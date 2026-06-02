Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B1CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38A514066C;
	Tue,  2 Jun 2026 11:08:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 80321402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780391336; x=1811927336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lLfBeQi8uklW1Fx+nJVDvnInblCPf4DzleU3UNdbCQY=;
 b=nw23Lu6/Sj0LJ8V4now7p/MBeN/Ql5r2hpQOduXtugD6SeH8J+rc6XFz
 PUzOH+SgUvDwEWY5/03V1xQxT4+v4tNbKUhOOJp47NPnCCszKBybPKa1C
 pOOMLWpQNDXyU6WJB0DIVGxUHpyPDecj2MsPn4tPYXAjTsb/eARuib7Wy
 NJvHKqcQ1Iq+g6FFea8M1YAu1EDpYkvs0rrvKWTudSvbZz1tdIfG5iu5h
 MVfJwTLjjeeKgTQPqfuuZ1KRUx2RMSf85+iGi45chmrn8Nidkwf3LA+UH
 7z9zm7Sb3HJEkeNVWuC4R64ZNDyxhA479sYuge0fhR4hvnZqPauIoVO8V A==;
X-CSE-ConnectionGUID: KrzLlJE1TZiN47aR+lSP+Q==
X-CSE-MsgGUID: hdpS43QyR3ujc7GDxqamcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80201505"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80201505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 02:08:55 -0700
X-CSE-ConnectionGUID: Vaow7vGbQRKLSVEcKEw/zQ==
X-CSE-MsgGUID: zzFUJeVsQ5GCT081wNbAAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="247809478"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 02 Jun 2026 02:08:54 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 3/3] build: deprecate HPET build option
Date: Tue,  2 Jun 2026 10:08:47 +0100
Message-ID: <20260602090847.905721-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602090847.905721-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
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

We can enable the building of the HPET code by default on Linux, since
the timers are not used - or even initialized - by default. Instead an
app needs to explicitly call rte_eal_hpet_init() to use the HPET timer
APIs. Therefore, let's simplify the user experience by deprecating the
option "use_hpet" and make it a no-op.

To avoid issue with the dpdk-test binary which was trying to initialize
the hpet on startup, move the hpet init call to the timer autotest - the
only place where it was used.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test.c                      | 7 -------
 app/test/test_timer.c                | 5 +++++
 config/meson.build                   | 2 +-
 doc/guides/linux_gsg/enable_func.rst | 2 --
 doc/guides/rel_notes/deprecation.rst | 2 ++
 lib/eal/linux/meson.build            | 5 +----
 meson_options.txt                    | 2 +-
 7 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index 58ef52f312..99d6e90f8b 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -180,13 +180,6 @@ main(int argc, char **argv)
 		goto out;
 	}
 
-#ifdef RTE_LIBEAL_USE_HPET
-	if (rte_eal_hpet_init(1) < 0)
-#endif
-		RTE_LOG(INFO, APP,
-				"HPET is not enabled, using TSC as default timer\n");
-
-
 	char *dpdk_test = getenv("DPDK_TEST");
 
 	if (dpdk_test && strlen(dpdk_test) > 0)
diff --git a/app/test/test_timer.c b/app/test/test_timer.c
index c936843ddc..dcb26c4395 100644
--- a/app/test/test_timer.c
+++ b/app/test/test_timer.c
@@ -501,6 +501,11 @@ static int
 timer_sanity_check(void)
 {
 #ifdef RTE_LIBEAL_USE_HPET
+	if (rte_eal_hpet_init(1) < 0) {
+		printf("HPET is not enabled, using TSC as default timer\n");
+		return 0;
+	}
+
 	if (eal_timer_source != EAL_TIMER_HPET) {
 		printf("Not using HPET, can't sanity check timer sources\n");
 		return 0;
diff --git a/config/meson.build b/config/meson.build
index 9ba7b9a338..6012a3c243 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -381,7 +381,7 @@ endforeach
 
 # set other values pulled from the build options
 dpdk_conf.set('RTE_MAX_ETHPORTS', get_option('max_ethports'))
-dpdk_conf.set('RTE_LIBEAL_USE_HPET', get_option('use_hpet'))
+dpdk_conf.set('RTE_LIBEAL_USE_HPET', is_linux)
 dpdk_conf.set('RTE_ENABLE_STDATOMIC', get_option('enable_stdatomic'))
 dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index 4e1a939f35..1d5b030172 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -176,8 +176,6 @@ To enable HPET support in DPDK:
    Note that this may involve doing a kernel rebuild,
    as many common linux distributions do *not* have this setting
    enabled by default in their kernel builds.
-#. Enable DPDK support for HPET by using the build-time meson option ``use_hpet``,
-   for example, ``meson configure -Duse_hpet=true``
 
 For an application to use the ``rte_get_hpet_cycles()`` and ``rte_get_hpet_hz()`` API calls,
 and optionally to make the HPET the default time source for the rte_timer library,
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 15459851d0..42ad118c92 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -21,6 +21,8 @@ Deprecation Notices
 
   - ``kernel_dir``: option unused as Linux kernel drivers are in a separate ``dpdk-kmods`` repository.
   - ``tests``: disabling tests can be achieved by using the ``enable_apps`` / ``disable_apps`` options instead.
+  - ``use_hpet``: option unused as HPET is only supported on Linux
+    and is runtime-enabled using ``rte_eal_hpet_init()`` API.
 
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
diff --git a/lib/eal/linux/meson.build b/lib/eal/linux/meson.build
index 29ba313218..8b0519c9a1 100644
--- a/lib/eal/linux/meson.build
+++ b/lib/eal/linux/meson.build
@@ -15,14 +15,11 @@ sources += files(
         'eal_memory.c',
         'eal_thread.c',
         'eal_timer.c',
+        'eal_timer_hpet.c',
         'eal_vfio.c',
         'eal_vfio_mp_sync.c',
 )
 
-if dpdk_conf.get('RTE_LIBEAL_USE_HPET')
-    sources += files('eal_timer_hpet.c')
-endif
-
 deps += ['kvargs', 'telemetry']
 if has_libnuma
     dpdk_conf.set10('RTE_EAL_NUMA_AWARE_HUGEPAGES', true)
diff --git a/meson_options.txt b/meson_options.txt
index 323a3901e1..242de6681f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -57,4 +57,4 @@ option('enable_trace_fp', type: 'boolean', value: false, description:
 option('tests', type: 'boolean', value: true, description:
        '[Deprecated] Value unused. Add "tests" to disable_apps setting to disable the unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
-       'use HPET timer in EAL')
+       '[Deprecated] Value unused. HPET can be runtime-enabled on Linux using rte_eal_hpet_init().')
-- 
2.53.0

