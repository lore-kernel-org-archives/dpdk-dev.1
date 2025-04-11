Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE1BC369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 19:40:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38D3540C35;
	Fri, 11 Apr 2025 21:39:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2CD1140A84
 for <dev@dpdk.org>; Fri, 11 Apr 2025 21:39:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 512BD21165AB; Fri, 11 Apr 2025 12:39:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 512BD21165AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744400385;
 bh=/p0pn9Zy0ZcJDddIFL+jY2SJiEx8FVw4rCXP3jqoRZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dbpB6+NV2MObw/X0CxgaEM71J5Eh3ahKKG+RFknSPRhHs9JFtemTeygE+htlZl/y3
 Z/NhEvU1QL9tHQcTyfKBffO72a7l8LuapGdfRqeAfAqP8vLdw2l6Nl1yabSz++XlWs
 PYgcDLonEk1Mq1fpnGcJiS7xdgpJWcf5oe/AK924=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 2/4] buildtools: use macro to embed information in binaries
Date: Fri, 11 Apr 2025 12:39:31 -0700
Message-Id: <1744400374-26620-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
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

buildtools/meson.build was updated to require Python module "pefile" on
Windows. This module is used to parse symbols on Windows images. Windows
images are in PE format (opposed to ELF on Linux).

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/gen-pmdinfo-cfile.py | 6 +++++-
 buildtools/meson.build          | 8 ++++++--
 buildtools/pmdinfogen.py        | 5 +++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 5fbd51658a..9b4c2c48f8 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -10,7 +10,11 @@
 _, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
 with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
     paths = []
-    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
+    if ar == 'lib':
+        ar_options = ['/LIST', '/NOLOGO']
+    else:
+        ar_options = ['t']
+    for name in subprocess.run([ar] + ar_options + [archive], stdout=subprocess.PIPE,
                                check=True).stdout.decode().splitlines():
         if os.path.exists(name):
             paths.append(name)
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 1cd1ce02fd..c331be6b35 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -6,7 +6,9 @@ check_symbols = find_program('check-symbols.sh')
 ldflags_ibverbs_static = find_program('options-ibverbs-static.sh')
 
 python3_required_modules = []
-if host_machine.system() != 'windows'
+if host_machine.system() == 'windows'
+    python3_required_modules = ['pefile']
+else
     python3_required_modules = ['elftools']
 endif
 python3 = import('python').find_installation('python3', required: false, modules: python3_required_modules)
@@ -37,7 +39,9 @@ install_data([
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

