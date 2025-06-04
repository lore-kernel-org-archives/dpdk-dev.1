Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB8C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B9942D80;
	Wed,  4 Jun 2025 15:50:59 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4C0FF42D80
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:50:53 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2735B201FF51; Wed,  4 Jun 2025 06:50:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2735B201FF51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749045052;
 bh=nNYoWbnHIjecrARhTAwgjBsHNUO4luoxzqEGZeBxGc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JnFuEY/+4F9ERNd15wVIlhnW6oHdzZrV/mM+6lByAF/XCw9idIhbHozvTvWvghtZ0
 yE4Tk/8/5xwCLRSCcQwxjZej9Y9T8dK7jjfNmLXnHGGRjzyjpshB47HxjTVYpSSR1N
 f7+IFJY+mh2cmdUfSR1pOXDWDkvDVz/3Ia12B3oA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v5 2/4] buildtools: use macro to embed information in binaries
Date: Wed,  4 Jun 2025 06:50:41 -0700
Message-Id: <1749045043-4319-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749045043-4319-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1749045043-4319-1-git-send-email-andremue@linux.microsoft.com>
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
 buildtools/gen-pmdinfo-cfile.py | 25 ++++++++++++++++++++-----
 buildtools/meson.build          |  4 +++-
 buildtools/pmdinfogen.py        | 11 ++++++-----
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 8ffc192c40..5d2e8e076e 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -6,16 +6,31 @@
 import subprocess
 import sys
 
-_, ar, tmp_dir, archive, output, *pmdinfogen = sys.argv
+_, archiver, tmp_dir, archive, output, *pmdinfogen = sys.argv
 paths = []
-for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
-                            check=True).stdout.decode().splitlines():
+if archiver == "lib":
+    archiver_options = ["/LIST", "/NOLOGO"]
+else:
+    archiver_options = ["t"]
+
+for name in (
+    subprocess.run(
+        [archiver] + archiver_options + [archive],
+        stdout=subprocess.PIPE,
+        check=True,
+    )
+    .stdout.decode()
+    .splitlines()
+):
     if os.path.exists(name):
         paths.append(name)
     else:
         if not os.path.exists(tmp_dir):
             os.makedirs(tmp_dir)
-        subprocess.run([ar, "x", os.path.abspath(archive), name],
-                        check=True, cwd=tmp_dir)
+        if archiver == "lib":
+            run_args = [archiver, f"/EXTRACT:{name}", os.path.abspath(archive)]
+        else:
+            run_args = [archiver, "x", os.path.abspath(archive), name]
+        subprocess.run(run_args, check=True, cwd=tmp_dir)
         paths.append(os.path.join(tmp_dir, name))
 subprocess.run(pmdinfogen + paths + [output], check=True)
diff --git a/buildtools/meson.build b/buildtools/meson.build
index e7c53c9a84..48ece2e6b6 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -37,7 +37,9 @@ install_data([
 pmdinfo = py3 + files('gen-pmdinfo-cfile.py')
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
2.49.0.vfs.0.3

