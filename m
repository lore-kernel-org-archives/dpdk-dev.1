Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC0CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F08BD4065E;
	Tue,  2 Jun 2026 11:08:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id BA1FB402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780391335; x=1811927335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5fTKo4C+p+jQZ/4oHzN2Flg1yvQl0o7Ua6mC+j08UN0=;
 b=XttpzfPPFdyfA2JWkJZk90QF8fyl9xz1UP2VwNFNTambnu4VNAf1W290
 icxDavQF47McpYEZFQRt6sI57j314ccSX6S4AVq7+xr8OJBx1eQ6qwtv0
 yGF9qCHOqv3ngRnempJ7u4Z9/geeSKtwllBhLaxqKQptQy1FN1dxpzsu/
 2xokyVefoyHzyEHSHK9S8zKknGXT7uHhO8tpgRvoSjvfhA579M/X6JY0C
 LPNLrCxPJPANzXPffKAS+sLwzmse7wd21TuS8bmThT1B1qtB1D8NqKjCM
 1GIeWs9vxqW4U3OsBXU8urkfqSRl2Zegv16DVj1xtoPsthuUvg1KS0BTj A==;
X-CSE-ConnectionGUID: 0a80CBteQyqJMx3wzmtl3g==
X-CSE-MsgGUID: 9lERmi/TRZOblC5FveDgcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80201504"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80201504"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 02:08:54 -0700
X-CSE-ConnectionGUID: lfk1mzbERheMpq5u/iheRw==
X-CSE-MsgGUID: 8EeZX/0/T3CKVOnZRKIVzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="247809475"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 02 Jun 2026 02:08:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 2/3] build: deprecate standalone tests option
Date: Tue,  2 Jun 2026 10:08:46 +0100
Message-ID: <20260602090847.905721-3-bruce.richardson@intel.com>
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

The unit tests can be disabled in DPDK in a couple of ways. Firstly,
there is the original "tests" boolean option - when set to false, the
tests are skipped as part of the build. However, the newer
enable_apps/disable_apps options also can be used to disable the tests
[you can disable using the "enable" option by omitting "tests" from the
list to enable].

This duplication of functionality is unnecessary, so let's remove the
standalone tests option.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/meson.build                      | 6 +-----
 doc/guides/rel_notes/deprecation.rst | 1 +
 meson_options.txt                    | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/app/meson.build b/app/meson.build
index 1798db3ae4..52f704ec94 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -17,6 +17,7 @@ apps = [
         'graph',
         'pdump',
         'proc-info',
+        'test',
         'test-acl',
         'test-bbdev',
         'test-cmdline',
@@ -35,11 +36,6 @@ apps = [
         'test-security-perf',
 ]
 
-if get_option('tests')
-# build the auto test app if enabled.
-    apps += 'test'
-endif
-
 default_cflags = machine_args + ['-DALLOW_EXPERIMENTAL_API']
 default_ldflags = []
 if get_option('default_library') == 'static' and not is_windows
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index ed1dda6008..15459851d0 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -20,6 +20,7 @@ Deprecation Notices
 * build: The following meson build options are deprecated and will be removed in a future release:
 
   - ``kernel_dir``: option unused as Linux kernel drivers are in a separate ``dpdk-kmods`` repository.
+  - ``tests``: disabling tests can be achieved by using the ``enable_apps`` / ``disable_apps`` options instead.
 
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
diff --git a/meson_options.txt b/meson_options.txt
index 7bd5ebc084..323a3901e1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -55,6 +55,6 @@ option('enable_stdatomic', type: 'boolean', value: false, description:
 option('enable_trace_fp', type: 'boolean', value: false, description:
        'enable fast path trace points.')
 option('tests', type: 'boolean', value: true, description:
-       'build unit tests')
+       '[Deprecated] Value unused. Add "tests" to disable_apps setting to disable the unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
        'use HPET timer in EAL')
-- 
2.53.0

