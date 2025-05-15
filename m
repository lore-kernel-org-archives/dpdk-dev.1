Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B7C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 13:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5EAC40E3E;
	Thu, 15 May 2025 15:47:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id BE8D5402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 15:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747316832; x=1778852832;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SF3Fe+aO9bY5GcUcP1MORODGE4FVoc3CgBA6aUuqhg0=;
 b=KGo8B4CfupLwgK3SVeecqQtCkdkKmGQ4XtYeQ6GnFXjCxmjIL/XjLuou
 Lj38qf+OhU5+0ITAs/aoX8/jjtsxpSBsZLn0IS4p/IIt/C9ewWzeCWbQD
 q/UC4VdVx8eKK0kNRHocyxJc0AAwTn9TB5KzpkKoK3mFkGSp2KNdxupiM
 SEuxH3hwAhmoB+Idu9BCjfxe0Ikmo1Xmp/qTH9kbN731RU7udUOhXm8hW
 ZJNjtcjz2sIcfBdnFm7LTFWHSWQ/wZxJ0izcFmCcVWJ5k9XZiejFUP74i
 rv4CJtgBhOmVoe6Nq42IDCiEfCqBD1GCINrCVssh15xgiRaLH6t0sld4M Q==;
X-CSE-ConnectionGUID: ZZsSqAkzTkuiWvwE2CvRug==
X-CSE-MsgGUID: VzB9WKg+Rxmmaac0LA5/tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59480644"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="59480644"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 06:47:10 -0700
X-CSE-ConnectionGUID: hMQRaL/mQRWysrf4Hq/ldg==
X-CSE-MsgGUID: v7QLNEiRSECO52OUIB2cFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="143147286"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by orviesa003.jf.intel.com with ESMTP; 15 May 2025 06:47:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3] build: automatically report minimum meson version
Date: Thu, 15 May 2025 14:46:47 +0100
Message-ID: <20250515134647.932537-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20241009152417.4028297-1-bruce.richardson@intel.com>
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
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

Add a script to buildtools to report the minimum meson version given in
our meson.build file. Then use this script in two ways:

1. in the .ci/linux-setup.sh script, use the auto-determined minimum
   version to set up the CI, rather than hard-coding it.
2. in meson.build call the script to report the version. This serves as
   a sanity check to ensure that any changes to meson.build file do not
   break the script.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

---
v3: update minimum meson to 0.57.2 (from 0.57.0) to fix CI errors
v2: rebase to latest main
---
 .ci/linux-setup.sh                  |  6 +++++-
 buildtools/get-min-meson-version.py | 26 ++++++++++++++++++++++++++
 buildtools/meson.build              |  5 +++++
 meson.build                         |  2 +-
 4 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100755 buildtools/get-min-meson-version.py

diff --git a/.ci/linux-setup.sh b/.ci/linux-setup.sh
index 938d492cbb..e025ca0243 100755
--- a/.ci/linux-setup.sh
+++ b/.ci/linux-setup.sh
@@ -3,8 +3,12 @@
 # Builds are run as root in containers, no need for sudo
 [ "$(id -u)" != '0' ] || alias sudo=
 
+# determine minimum meson version
+ci_dir=$(dirname $(readlink -f $0))
+meson_ver=$(python3 $ci_dir/../buildtools/get-min-meson-version.py)
+
 # need to install as 'root' since some of the unit tests won't run without it
-sudo python3 -m pip install --upgrade 'meson==0.57.2'
+sudo python3 -m pip install --upgrade "meson==$meson_ver"
 
 # setup hugepages. error ignored because having hugepage is not mandatory.
 cat /proc/meminfo
diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
new file mode 100755
index 0000000000..f0de8fdf2b
--- /dev/null
+++ b/buildtools/get-min-meson-version.py
@@ -0,0 +1,26 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Intel Corporation
+
+import os
+import re
+import sys
+from os.path import dirname, realpath, join
+
+buildtools_path = dirname(realpath(__file__))
+basedir = dirname(buildtools_path)
+
+with open(join(basedir, "meson.build")) as f:
+    for ln in f.readlines():
+        if "meson_version" not in ln:
+            continue
+
+        ln = ln.strip()
+        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
+        if not ver_match:
+            print(
+                f"Meson version specifier not in recognised format: '{ln}'",
+                file=sys.stderr,
+            )
+            sys.exit(1)
+        print(ver_match.group(1), end="")
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 1cd1ce02fd..cc0198081d 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -26,6 +26,11 @@ header_gen_cmd = py3 + files('gen-header.py')
 has_hugepages_cmd = py3 + files('has-hugepages.py')
 cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
 check_dts_requirements = py3 + files('check-dts-requirements.py')
+get_min_meson_version_cmd = py3 + files('get-min-meson-version.py')
+
+# check that we can correctly report minimum meson version
+min_ver = run_command(get_min_meson_version_cmd, check: true, capture: true)
+message('Minimum meson required version is ' + min_ver.stdout())
 
 # install any build tools that end-users might want also
 install_data([
diff --git a/meson.build b/meson.build
index dfb4cb3aee..5ff68cb3af 100644
--- a/meson.build
+++ b/meson.build
@@ -10,7 +10,7 @@ project('DPDK', 'c',
             'default_library=static',
             'warning_level=2',
         ],
-        meson_version: '>= 0.57'
+        meson_version: '>= 0.57.2'
 )
 
 fs = import('fs')
-- 
2.48.1

