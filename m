Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9BEC369C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 21:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 991FC42707;
	Wed, 16 Apr 2025 23:45:09 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 947FD411F3
 for <dev@dpdk.org>; Wed, 16 Apr 2025 23:45:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9B32C205250D; Wed, 16 Apr 2025 14:45:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B32C205250D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744839903;
 bh=j21oyAFfigtXPwaLyoVC8FlJ8W3YmqZ2LtjR43phXVM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D6Oa5Y3IFvHTBJ/kPyeF0VD9U4QO65HY9t08DkcCAlC3wiR0KU89oOv/dZbYs5X1e
 VvYJEYImlt9/v2sRO29mxPU1+77ljBkyIc3gIBaTnfUg4gNdzMm0KZB2ioMjDOzly2
 3SyJZ4rChDLmo4lI35HHLpqTF35RQ9W0GgIj5oe4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 2/4] buildtools: use macro to embed information in binaries
Date: Wed, 16 Apr 2025 14:44:56 -0700
Message-Id: <1744839898-15745-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
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
 buildtools/gen-pmdinfo-cfile.py | 24 +++++++++++++++++++-----
 buildtools/meson.build          |  4 +++-
 buildtools/pmdinfogen.py        | 11 ++++++-----
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 5fbd51658a..3a078ab6d1 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -7,15 +7,29 @@
 import sys
 import tempfile
 
-_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
+_, tmp_root, archiver, archive, output, *pmdinfogen = sys.argv
 with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
     paths = []
-    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
-                               check=True).stdout.decode().splitlines():
+    if archiver == "lib":
+        archiver_options = ["/LIST", "/NOLOGO"]
+    else:
+        archiver_options = ["t"]
+    for name in (
+        subprocess.run(
+            [archiver] + archiver_options + [archive],
+            stdout=subprocess.PIPE,
+            check=True,
+        )
+        .stdout.decode()
+        .splitlines()
+    ):
         if os.path.exists(name):
             paths.append(name)
         else:
-            subprocess.run([ar, "x", os.path.abspath(archive), name],
-                           check=True, cwd=temp)
+            if archiver == "lib":
+                run_args = [archiver, f"/EXTRACT:{name}", os.path.abspath(archive)]
+            else:
+                run_args = [archiver, "x", os.path.abspath(archive), name]
+            subprocess.run(run_args, check=True, cwd=temp)
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
index dfb89500c0..710913083f 100755
--- a/buildtools/pmdinfogen.py
+++ b/buildtools/pmdinfogen.py
@@ -87,7 +87,7 @@ def get_value(self, offset, size):
     @property
     def string_value(self):
         value = self._symbol.get_value(0)
-        return coff.decode_asciiz(value) if value else ''
+        return coff.decode_asciiz(value) if value else ""
 
 
 class COFFImage:
@@ -192,7 +192,7 @@ def dump(self, file):
         dumped = json.dumps(self.__dict__)
         escaped = dumped.replace('"', '\\"')
         print(
-            'const char %s_pmd_info[] __attribute__((used)) = "PMD_INFO_STRING= %s";'
+            'RTE_INCLUDE(const char, %s_pmd_info)[] = "PMD_INFO_STRING= %s";'
             % (self.name, escaped),
             file=file,
         )
@@ -215,7 +215,7 @@ def parse_args():
     parser = argparse.ArgumentParser()
     parser.add_argument("format", help="object file format, 'elf' or 'coff'")
     parser.add_argument(
-        "input", nargs='+', help="input object file path or '-' for stdin"
+        "input", nargs="+", help="input object file path or '-' for stdin"
     )
     parser.add_argument("output", help="output C file path or '-' for stdout")
     return parser.parse_args()
@@ -252,13 +252,14 @@ def open_output(path):
 
 def write_header(output):
     output.write(
-        "static __attribute__((unused)) const char *generator = \"%s\";\n" % sys.argv[0]
+        "#include <rte_common.h>\n"
+        'static __rte_unused const char *generator = "%s";\n' % sys.argv[0]
     )
 
 
 def main():
     args = parse_args()
-    if args.input.count('-') > 1:
+    if args.input.count("-") > 1:
         raise Exception("'-' input cannot be used multiple times")
     if args.format == "elf" and "ELFFile" not in globals():
         raise Exception("elftools module not found")
-- 
2.49.0.vfs.0.0

