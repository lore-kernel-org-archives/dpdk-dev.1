Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460E6C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 22:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD5A402F1;
	Wed,  7 May 2025 00:14:31 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4E7DB4025D
 for <dev@dpdk.org>; Wed,  7 May 2025 00:14:29 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 574FD2115DDA; Tue,  6 May 2025 15:14:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 574FD2115DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746569668;
 bh=TYbRQ7ymDvMGb60j8/Osfd0fIgYHyryzrs6le271Jrc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jXCsFU1UmDFNOUxF0A2yy6LssUPWbvXhUjDI7JwI04gDB20k1KrgG/ayYACAbysQ1
 TRHWwPzTHrx59B7RkiYxgi/WLAhOB8/sGKgMIkN0mTBWP/rYv5JM2N9O5YVH49CEPB
 V/6OC4VPk706ETC8Fa6kEACnRcIW+9x1yA5sb7/A=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
Date: Tue,  6 May 2025 15:14:22 -0700
Message-Id: <1746569662-11532-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746569662-11532-1-git-send-email-andremue@linux.microsoft.com>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746569662-11532-1-git-send-email-andremue@linux.microsoft.com>
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

Code inspection did not reveal problems with the DPDK code and scripts,
and this issue was only seen on Windows. Adding a 1 second sleep before
cleaning up the temporary directory seems to be effective, but to
guarantee that this break does not happen anymore, flag
"ignore_cleanup_errors" is set to "True".

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/gen-pmdinfo-cfile.py | 24 +++++++++++-------------
 drivers/meson.build             |  2 +-
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 5fbd51658a..cf8881297f 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -5,17 +5,15 @@
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
+_, tmp_root, ar, tmp_dir, archive, output, *pmdinfogen = sys.argv
+paths = []
+for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
+                            check=True).stdout.decode().splitlines():
+    if os.path.exists(name):
+        paths.append(name)
+    else:
+        subprocess.run([ar, "x", os.path.abspath(archive), name],
+                        check=True, cwd=tmp_dir)
+        paths.append(os.path.join(tmp_dir, name))
+subprocess.run(pmdinfogen + paths + [output], check=True)
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

