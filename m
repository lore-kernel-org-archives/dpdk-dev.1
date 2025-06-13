Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99960C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 16:14:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 633B142E7B;
	Fri, 13 Jun 2025 18:14:48 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0C012402E1
 for <dev@dpdk.org>; Fri, 13 Jun 2025 18:14:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1030E2115189; Fri, 13 Jun 2025 09:14:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1030E2115189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749831286;
 bh=6+LJwYcuLE/SE+l5wHHnCnWb0AwRhTeDF0/o9c2+WpM=;
 h=From:To:Cc:Subject:Date:From;
 b=O7ix4NSic2UxKUqtD8snbilI4pxXQojwbkEr/QEElFixWsPVrWru3grlb8yhXe/+9
 yK8k7qu8YQGgg2gADWreIyKCEJFs9j+i7st5BIQ1pfhJMWHVCHYyPEeUE7Qr98lM5b
 Q0hZRdxiRAjzTuDtTx9T4R1WSSGrAY5i65VLxvog=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] buildtools: allow a different minimum meson version for
 Windows
Date: Fri, 13 Jun 2025 09:14:38 -0700
Message-Id: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

There is a minimum meson version specified in the DPDK meson project
section, which has been documented. This string is parsed by
buildtools\get-min-meson-version.py and this information is used by
lab automation to install the corresponding meson package on the
build machine.

Turns out that the meson version specified on the DPDK project
(0.57.x) is buggy on Windows: it has issues related to path
manipulation, and these issues are causing failures. Therefore,
a newer meson is required on Windows.

To avoid bringing the minimum requirements up for all operating
systems before a more appropriate release, this patch implements
a mechanism allowing a different version to be specified for Windows.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/get-min-meson-version.py | 12 ++++++++++--
 meson.build                         |  9 +++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
index f0de8fdf2b..10a2596a5a 100755
--- a/buildtools/get-min-meson-version.py
+++ b/buildtools/get-min-meson-version.py
@@ -11,12 +11,19 @@
 basedir = dirname(buildtools_path)
 
 with open(join(basedir, "meson.build")) as f:
+    if os.name == "nt":
+        keyword = "windows_meson_version"
+        pattern = r"windows_meson_version:\s*'>=\s*([0-9\.]+)'"
+    else:
+        keyword = "meson_version"
+        pattern = r"meson_version:\s*'>=\s*([0-9\.]+)'"
+
     for ln in f.readlines():
-        if "meson_version" not in ln:
+        if keyword not in ln:
             continue
 
         ln = ln.strip()
-        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
+        ver_match = re.search(pattern, ln)
         if not ver_match:
             print(
                 f"Meson version specifier not in recognised format: '{ln}'",
@@ -24,3 +31,4 @@
             )
             sys.exit(1)
         print(ver_match.group(1), end="")
+        break
diff --git a/meson.build b/meson.build
index 5ff68cb3af..1ae51996be 100644
--- a/meson.build
+++ b/meson.build
@@ -13,6 +13,15 @@ project('DPDK', 'c',
         meson_version: '>= 0.57.2'
 )
 
+# Meson does not support dynamic/conditional values for meson_version in
+# the project section.
+# The line below contains the minimum meson version required on Windows,
+# which gets parsed by get-min-meson-version.py.
+# It is important to keep this line below the "project" section, so that
+# the script can make the correct determination according to the operating
+# system.
+# windows_meson_version: '>= 1.5.2'
+
 fs = import('fs')
 
 # check for developer mode
-- 
2.49.0.vfs.0.3

