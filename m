Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFFCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EDD440BA2;
	Fri, 16 Oct 2026 13:00:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C4E8040663
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148413; x=1823684413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A+dJNtHX2o896Y0SdMcOZDbQj1JzjYeyk+2iP9di/Yw=;
 b=aox72Qhkki0Nu4dp6bfLrI7i1UTnPV/Zu16OBHTNLyHGNYp87xRQV7/F
 6VN0mf6cEn6wOtJDrHxHzlR7BteEEQDmAz0maZkzzlJmkOBC/wUk9WChT
 zq5hWcols8l2qrvhNqVX0z0dEZzQlSmxs+FmNue+J/aZLnW951HpI1hmk
 rnXk7qWk0TQwrKswV6Xb7sm/U0JTL2CAfQY/Phoz+kN29yovjuQ9eZAic
 Lnw+b2Lp+ZmFCUHo7DrvzOTyVbM3uK23ym8oSQHb8usF7hajc9kEwdya0
 1WMxXWqCpFuyzwHxYzqswbsUoMlhTV9yYQBNb3RVFk1TwNTDF3aPWoBOD w==;
X-CSE-ConnectionGUID: 4DZ9CuSrQuSmzy22Pf4Gjg==
X-CSE-MsgGUID: zz7jVm8oQL6WVEFqePDjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944150"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944150"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:13 -0700
X-CSE-ConnectionGUID: FExzi0rtT264kHAk7wg80Q==
X-CSE-MsgGUID: iu0xexN9TQ6kvZLSsVEXOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759417"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 12/12] build: simplify mandatory library lists
Date: Fri, 16 Oct 2026 11:59:50 +0100
Message-ID: <20261016105950.273068-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

Rather than listing out all the libraries we think need to be built,
let's just have a minimal set that are necessary to build the minimal
set of drivers. Use the existing dependency resolution script to build
that minimal required library and driver set.

This change necessitates a change to test-meson-builds.sh since ethdev
is no longer in the always-required set, meaning that a minimal build
will error out if net/null is added as a required driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
The change to test-meson-builds.sh will cause issues for anyone who is
using an already-configured set of build directories, as the script does
not attempt any reconfiguration. For now, to avoid any potential testing
issues, I've side-stepped the issue by adjusting the directory name from
build-mini to build-minimal. This will configure a new directory rather
than reusing the old one with the broken config.
---
 devtools/test-meson-builds.sh |  3 +--
 drivers/meson.build           |  8 ++++----
 lib/meson.build               | 22 ++++------------------
 meson.build                   | 13 +++++++++++++
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 501034f398..9128d6bda7 100755
--- a/devtools/test-meson-builds.sh
+++ b/devtools/test-meson-builds.sh
@@ -249,8 +249,7 @@ for c in gcc clang ; do
 	done
 done
 
-build build-mini cc skipABI $use_shared -Ddisable_libs=* \
-	-Denable_drivers=net/null
+build build-minimal cc skipABI $use_shared -Ddisable_libs=*
 
 # test compilation with minimal x86 instruction set
 # Set the install path for libraries to "lib" explicitly to prevent problems
diff --git a/drivers/meson.build b/drivers/meson.build
index aacfe29c46..29b473eb04 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -79,10 +79,10 @@ foreach d:requested_drivers
 endforeach
 require_drivers = requested_drivers.length() != 0
 
-# these drivers must always be enabled, otherwise the build breaks
-always_enable = ['bus/pci', 'bus/vdev']
-# we always need a mempool driver, and ring is default, so make it mandatory
-always_enable += ['mempool/ring']
+# these drivers must always be enabled, otherwise the build breaks; the
+# full set, including their own dependencies, is computed once at the top
+# level
+always_enable = dpdk_min_required_drivers
 
 # expand the requested drivers to also include the drivers they depend on; with
 # no drivers requested every driver is wanted, so no list is needed
diff --git a/lib/meson.build b/lib/meson.build
index 34fbd93977..e4998d1090 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -70,24 +70,10 @@ libraries = [
         'node',
 ]
 
-always_enable = [
-        'argparse',
-        'cmdline',
-        'eal',
-        'ethdev',
-        'hash',
-        'kvargs',
-        'log',
-        'mbuf',
-        'mempool',
-        'meter',
-        'net',
-        'pci',
-        'rcu',
-        'ring',
-        'stack',
-        'telemetry',
-]
+# these libraries must always be enabled, otherwise the build breaks; the
+# full set, including their own dependencies, is computed once at the top
+# level, from the libraries that the mandatory drivers need
+always_enable = dpdk_min_required_libs
 
 enable_deprecated_libs = []
 foreach l:run_command(list_dir_globs, get_option('enable_deprecated_libs'),
diff --git a/meson.build b/meson.build
index 4536f7e9c5..8d31230528 100644
--- a/meson.build
+++ b/meson.build
@@ -96,6 +96,19 @@ dpdk_deps_graph = configure_file(
         capture: true,
         output: 'dependencies.txt')
 
+# these drivers must always be enabled, otherwise the build breaks: a PCI bus
+# driver, a vdev bus driver, and a mempool driver, with ring as the default
+dpdk_min_required_driver_paths = ['bus/pci', 'bus/vdev', 'mempool/ring']
+
+# the mandatory drivers' own dependencies are mandatory too, as are the
+# libraries they need, so none of them can be left out of the build
+dpdk_min_required_drivers = run_command(resolve_deps_cmd, dpdk_deps_graph,
+        '--drivers', dpdk_min_required_driver_paths,
+        check: true).stdout().strip().split(',')
+dpdk_min_required_libs = run_command(resolve_deps_cmd, dpdk_deps_graph,
+        '--libs', dpdk_min_required_driver_paths,
+        check: true).stdout().strip().split(',')
+
 # build libs and drivers
 subdir('lib')
 subdir('drivers')
-- 
2.53.0

