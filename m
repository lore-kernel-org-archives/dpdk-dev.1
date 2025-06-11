Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A0C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 09:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1516D4068A;
	Wed, 11 Jun 2025 11:46:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 306CF40674
 for <dev@dpdk.org>; Wed, 11 Jun 2025 11:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749635174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaCUi0EN6vabtKDChIoJspfdBVamOFMHfbeqh+nyqi8=;
 b=fgLWWiMg+rYVQVAgJdD7KOooBY5tQoNpGTCUyr5YNvCNdN1Wxs40j73yTu135rtXLZ4BPf
 0QDeBeRB8QMR+X9Qy3SAM8YCWgm7nEPfSOYSd/nqGlHMFo1jIT8VwPAQ8S9Zns5oFa0KIW
 jO0W4hHc11O6dbnxmBiX3ODqyuXUAN0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-WDRor1kgMMm5PA9nYxKuQg-1; Wed,
 11 Jun 2025 05:46:11 -0400
X-MC-Unique: WDRor1kgMMm5PA9nYxKuQg-1
X-Mimecast-MFC-AGG-ID: WDRor1kgMMm5PA9nYxKuQg_1749635170
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 638A719560B6; Wed, 11 Jun 2025 09:46:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03A13180035C; Wed, 11 Jun 2025 09:46:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v7 4/5] buildtools: embed driver information with MSVC
Date: Wed, 11 Jun 2025 11:45:31 +0200
Message-ID: <20250611094532.1242167-5-david.marchand@redhat.com>
In-Reply-To: <20250611094532.1242167-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N5N1jD9uAR0n_9JwCYpYetT0Aus9mgxaB3PCJPVo1ms_1749635170
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Andre Muezerie <andremue@linux.microsoft.com>

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
 buildtools/meson.build          |  2 ++
 buildtools/pmdinfogen.py        | 11 ++++++-----
 3 files changed, 28 insertions(+), 10 deletions(-)

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
index 822e79502a..7b5e449cdb 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -44,6 +44,8 @@ pmdinfogen = py3 + files('pmdinfogen.py')
 if host_machine.system() == 'windows'
     if cc.get_id() == 'gcc'
         pmdinfo += 'ar'
+    elif cc.get_id() == 'msvc'
+        pmdinfo += 'lib'
     else
         pmdinfo += 'llvm-ar'
     endif
diff --git a/buildtools/pmdinfogen.py b/buildtools/pmdinfogen.py
index 7be2e39dd2..63e0a8b364 100755
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
+            'RTE_PMD_EXPORT_SYMBOL(const char, %s_pmd_info)[] = "PMD_INFO_STRING= %s";'
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
+        "#include <dev_driver.h>\n"
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
2.49.0

