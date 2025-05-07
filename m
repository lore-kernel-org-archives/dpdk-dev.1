Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD8C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 14:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F38E3402EB;
	Wed,  7 May 2025 16:21:20 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 38B514025D
 for <dev@dpdk.org>; Wed,  7 May 2025 16:21:18 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0C6BE21180CC; Wed,  7 May 2025 07:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C6BE21180CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746627677;
 bh=mcgUaA/Tv7eSRbmYsTZB+t46CaUZBIvkfy4BH3Z5GX8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T3HJG9MxyyISK05MNvv98xmn0moV4RI6UEslLPGH1hp4/T5OSzoRlv7mSMyLcIAKf
 R4Qk5mgBCsUKKGrfFB7/kmBMV38KXtpjlfBxFXyuYITz5I/SM/392fOevC+aVVRyTL
 pVfH5teIzOdDRaCxqRETaqltHTQ1wpzX4Vhzh++o=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
Date: Wed,  7 May 2025 07:21:11 -0700
Message-Id: <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling drivers on Windows, instances have been seen where a
temporary directory fails to get cleaned up due to
ERROR_SHARING_VIOLATION (32).

This issue was not seen on operating systems other than Windows.

This patch eliminates the use of tempfile.TemporaryDirectory, which
was triggering the issue.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/gen-pmdinfo-cfile.py | 26 +++++++++++++-------------
 buildtools/meson.build          |  2 +-
 drivers/meson.build             |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 5fbd51658a..8ffc192c40 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -5,17 +5,17 @@
 import os
 import subprocess
 import sys
-import tempfile
 
-_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
-with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
-    paths = []
-    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
-                               check=True).stdout.decode().splitlines():
-        if os.path.exists(name):
-            paths.append(name)
-        else:
-            subprocess.run([ar, "x", os.path.abspath(archive), name],
-                           check=True, cwd=temp)
-            paths.append(os.path.join(temp, name))
-    subprocess.run(pmdinfogen + paths + [output], check=True)
+_, ar, tmp_dir, archive, output, *pmdinfogen = sys.argv
+paths = []
+for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
+                            check=True).stdout.decode().splitlines():
+    if os.path.exists(name):
+        paths.append(name)
+    else:
+        if not os.path.exists(tmp_dir):
+            os.makedirs(tmp_dir)
+        subprocess.run([ar, "x", os.path.abspath(archive), name],
+                        check=True, cwd=tmp_dir)
+        paths.append(os.path.join(tmp_dir, name))
+subprocess.run(pmdinfogen + paths + [output], check=True)
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 1cd1ce02fd..e7c53c9a84 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -34,7 +34,7 @@ install_data([
         install_dir: 'bin')
 
 # select library and object file format
-pmdinfo = py3 + files('gen-pmdinfo-cfile.py') + [meson.current_build_dir()]
+pmdinfo = py3 + files('gen-pmdinfo-cfile.py')
 pmdinfogen = py3 + files('pmdinfogen.py')
 if host_machine.system() == 'windows'
     if cc.get_id() == 'gcc'
diff --git a/drivers/meson.build b/drivers/meson.build
index caee1e3b79..8aad099c40 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -274,7 +274,7 @@ foreach subpath:subdirs
                 c_args: cflags)
         objs += tmp_lib.extract_all_objects(recursive: true)
         sources_pmd_info = custom_target(out_filename,
-                command: [pmdinfo, tmp_lib.full_path(), '@OUTPUT@', pmdinfogen],
+                command: [pmdinfo, '@PRIVATE_DIR@', tmp_lib.full_path(), '@OUTPUT@', pmdinfogen],
                 output: out_filename,
                 depends: [tmp_lib])
 
-- 
2.49.0.vfs.0.2

