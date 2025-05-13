Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFDC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 09:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BB8E4026C;
	Tue, 13 May 2025 11:00:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 196384025F
 for <dev@dpdk.org>; Tue, 13 May 2025 11:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747126806; x=1778662806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ASa653+DKLsGokcF+FTfbjpa5uUd37vt45rwcwNeBUo=;
 b=MY6mURWA3Q/+xqEx+zcshLKSgQ4Fm1vLOg0POMn/CzEzoBYFOgaKyQq0
 uaLbr3zHi56XkY8RENfJKCdXGTwsl8mxViZSlbVaIvOMzN2cZ+Rozy7Ho
 I/fsbH2RmhKxy+2xWjwucsEODpB+2lKDZR+9wueg+lOgFxzAaN5o5BMFZ
 Dyk2YVcfKXX9ijrO44QJfwxXPJXP2bWTfrJ2kSUTeyhJVm6F6ygLBA5Mm
 qgfksTs6DnYdS/n+v448JHB0q1eJbss6NA8pxMmo3n7Bm9CW1ncm9IWPM
 5I/FKjceetALWpHE7M5p7uVPnNa3SeIC2dbta8mhY20ajGkycjXSOhznX w==;
X-CSE-ConnectionGUID: gxmJAzEESq2cbOvXg/xw2g==
X-CSE-MsgGUID: NmmebfLnQJqLcocixN9xuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48651825"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="48651825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 02:00:05 -0700
X-CSE-ConnectionGUID: TxFDZlB1TXOmXrC9WXnKRA==
X-CSE-MsgGUID: ATKuFKo3SayWk1L5yW1xRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="137556277"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 13 May 2025 02:00:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2] build: automatically report minimum meson version
Date: Tue, 13 May 2025 09:59:42 +0100
Message-ID: <20250513085956.1670288-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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
v2: rebased to latest main
---
 .ci/linux-setup.sh                  |  6 +++++-
 buildtools/get-min-meson-version.py | 26 ++++++++++++++++++++++++++
 buildtools/meson.build              |  5 +++++
 3 files changed, 36 insertions(+), 1 deletion(-)
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
-- 
2.45.2

