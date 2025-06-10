Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C314C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:10:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D61442E8F;
	Tue, 10 Jun 2025 12:10:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BFA3342E8F
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:10:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749550214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LccsnPgnZL7DZzCZPgzSDhETVxgSrjXUS8DFQHxu2/A=;
 b=G8pUL+ERe8TiMLfnzNHj/H2eWdMQrEODywBa3YOAu3KQjvV5RCm2H2anU1bIrcm3OLc/XX
 rhmWkKklM9mhuxI5qU2FESoR00Prfymcal2AbypnPR6RUi47r7xttRMkzo2ltsl5jQ5kpw
 dr4wGtY3AwvrNjc5GJWbDjiPndrwV1U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-d02jepG6MoisOn6rlTG3tw-1; Tue,
 10 Jun 2025 06:10:12 -0400
X-MC-Unique: d02jepG6MoisOn6rlTG3tw-1
X-Mimecast-MFC-AGG-ID: d02jepG6MoisOn6rlTG3tw_1749550212
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D880E19560B7; Tue, 10 Jun 2025 10:10:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D64119560A3; Tue, 10 Jun 2025 10:10:10 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v6 3/4] buildtools: embed driver information with MSVC
Date: Tue, 10 Jun 2025 12:09:46 +0200
Message-ID: <20250610100947.421877-4-david.marchand@redhat.com>
In-Reply-To: <20250610100947.421877-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gq3umCJg5l0PCWHAnjRN-3XyTl8R2fUnjI-wTy1gV5Y_1749550212
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
index dfb89500c0..68db9e5fb6 100755
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

