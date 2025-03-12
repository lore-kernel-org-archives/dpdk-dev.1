Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2362AC282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 01:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC34940265;
	Wed, 12 Mar 2025 02:53:22 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2C1DD40264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 02:53:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5510C2045FE8; Tue, 11 Mar 2025 18:53:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5510C2045FE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741744401;
 bh=4rZGPSLdP2ZAp+Ib9c6Gz2YTRlR9uSV7OweAn6/f4ho=;
 h=From:To:Cc:Subject:Date:From;
 b=Ucczw2h3vU94ghMFt99KgEYeXd/Ov5Ay/CaveBOH9+Mtk+jobcYyH+mtONcQNZ1Ry
 8CuJ6+T/nOaH61+tFyWt+VVtSVzZjRRfvsN8f/1rcDIotygRSxFbbYq1FowpCGXvxH
 dyujZmLJZ8CXAaeKPSzOj5OjpGwSmjVL4z8D3HQg=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] buildtools: remove invalid option for Microsoft linker
Date: Tue, 11 Mar 2025 18:53:08 -0700
Message-Id: <1741744388-2290-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling "drivers" directory with MSVC the errors below popped up:

drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
    missing ')' before '('
drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
drivers/rte_mempool_stack.pmd.c(1): error C2059: syntax error: ')'
drivers/rte_mempool_stack.pmd.c(1): error C2143: syntax error:
    missing ')' before 'const'
drivers/rte_mempool_stack.pmd.c(1): error C2091: function returns function

The fix is to use common macros compatible with MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/pmdinfogen.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/buildtools/pmdinfogen.py b/buildtools/pmdinfogen.py
index dfb89500c0..116f05e7a8 100755
--- a/buildtools/pmdinfogen.py
+++ b/buildtools/pmdinfogen.py
@@ -192,7 +192,7 @@ def dump(self, file):
         dumped = json.dumps(self.__dict__)
         escaped = dumped.replace('"', '\\"')
         print(
-            'const char %s_pmd_info[] __attribute__((used)) = "PMD_INFO_STRING= %s";'
+            'const char %s_pmd_info[] __rte_used = "PMD_INFO_STRING= %s";'
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
2.48.1.vfs.0.1

