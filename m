Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71528C369B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 01:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 282C6402A1;
	Tue, 15 Apr 2025 03:21:52 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2096E40289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 03:21:50 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3BB83210C426; Mon, 14 Apr 2025 18:21:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BB83210C426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744680109;
 bh=gA6a7psNm/4sG/U9rvsZy+FkLKM2ch3k/O2cgiJpJK8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aUnX/6KW6Z097NuPr01Hf1dNQENlV/GRnRSiNzDvPKEXXLh/0t80JYyz1/SjSqMrX
 uMgkhLZeA6xJplYekPMawm2SkBpENJC/nwSQ/2CeV6gNsKQr9E7O5CwSbe9OdMaToa
 uhePD/Gg7P0Ez6euk7/c8kVaLhpvxiB415P1j0u4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 2/4] buildtools: use macro to embed information in binaries
Date: Mon, 14 Apr 2025 18:21:34 -0700
Message-Id: <1744680096-17683-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
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

The archiver tool from the MSVC toolset is lib.exe. It has different
parameters then it's GNU counterpart "ar".

buildtools\meson.build was updated to use lib.exe when MSVC compiler is
used. This is to allow the code to be built without requiring GNU "ar"
to be installed in that scenario.

Script gen-pmdinfo-cfile.py was updated to use the correct parameters
when using lib.exe.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/gen-pmdinfo-cfile.py | 10 +++++++---
 buildtools/meson.build          |  4 +++-
 buildtools/pmdinfogen.py        |  5 +++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 5fbd51658a..d1f1ea64fc 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -7,15 +7,19 @@
 import sys
 import tempfile
 
-_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
+_, tmp_root, archiver, archive, output, *pmdinfogen = sys.argv
 with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
     paths = []
-    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
+    if archiver == 'lib':
+        archiver_options = ['/LIST', '/NOLOGO']
+    else:
+        archiver_options = ['t']
+    for name in subprocess.run([archiver] + archiver_options + [archive], stdout=subprocess.PIPE,
                                check=True).stdout.decode().splitlines():
         if os.path.exists(name):
             paths.append(name)
         else:
-            subprocess.run([ar, "x", os.path.abspath(archive), name],
+            subprocess.run([archiver, "x", os.path.abspath(archive), name],
                            check=True, cwd=temp)
             paths.append(os.path.join(temp, name))
     subprocess.run(pmdinfogen + paths + [output], check=True)
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 1cd1ce02fd..11221f02ea 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -37,7 +37,9 @@ install_data([
 pmdinfo = py3 + files('gen-pmdinfo-cfile.py') + [meson.current_build_dir()]
 pmdinfogen = py3 + files('pmdinfogen.py')
 if host_machine.system() == 'windows'
-    if cc.get_id() == 'gcc'
+    if cc.get_id() == 'msvc'
+        pmdinfo += 'lib'
+    elif cc.get_id() == 'gcc'
         pmdinfo += 'ar'
     else
         pmdinfo += 'llvm-ar'
diff --git a/buildtools/pmdinfogen.py b/buildtools/pmdinfogen.py
index dfb89500c0..8eddbb798c 100755
--- a/buildtools/pmdinfogen.py
+++ b/buildtools/pmdinfogen.py
@@ -192,7 +192,7 @@ def dump(self, file):
         dumped = json.dumps(self.__dict__)
         escaped = dumped.replace('"', '\\"')
         print(
-            'const char %s_pmd_info[] __attribute__((used)) = "PMD_INFO_STRING= %s";'
+            'RTE_INCLUDE(const char, %s_pmd_info)[] = "PMD_INFO_STRING= %s";'
             % (self.name, escaped),
             file=file,
         )
@@ -252,7 +252,8 @@ def open_output(path):
 
 def write_header(output):
     output.write(
-        "static __attribute__((unused)) const char *generator = \"%s\";\n" % sys.argv[0]
+        "#include <rte_common.h>\n"
+        "static __rte_unused const char *generator = \"%s\";\n" % sys.argv[0]
     )
 
 
-- 
2.49.0.vfs.0.0

