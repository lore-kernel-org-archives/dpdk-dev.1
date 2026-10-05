Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A90CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 13:00:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6FAF4028D;
	Mon,  5 Oct 2026 15:00:21 +0200 (CEST)
Received: from out-cbk.mail.syseleven.net (out-cbk.mail.syseleven.net
 [195.192.142.27])
 by mails.dpdk.org (Postfix) with ESMTP id 4557D4028C
 for <dev@dpdk.org>; Mon,  5 Oct 2026 15:00:21 +0200 (CEST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-cbk.mail.syseleven.net (Postfix) with ESMTPSA id 5ACFD3F0D4;
 Mon,  5 Oct 2026 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1791205220;
 bh=UFl5zE4fWjFc+m9ceGEF/r9dgbgl1DVuvod68yFSnlo=; h=From:From;
 b=g/znncbvhYEd3QAB/nlEIyLFQb3LdcREJ7iBGgLtllzs61jDt2uR2LfeA6yAiFd5b
 I0GbcHZwkH+3FcHLroUN5rE2PKg0cpBIsFunbaVWL1G58tcA2qk2OB3im+P5OW7udv
 CdA2lz6QiCEHcbgsZ862xNgwZCrX4GVdc+VV0tdlW4L3w+7w/r9wrcAtZSuHCxyMUB
 mPvMQa4C3QLmwin4IUlNWapAjoEg00m5klfQsOKLWOcwP7GCKaEg5MzTciLOZQecdZ
 l8caZgYGsOpWsT98Ab9JW6mzCoLKDgnC5kwR1GIajKAzKTKR1UqzZB9KRSKNvd5RO7
 ueWPJ0Rebf3jw==
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH] build: fix cross compilation to x86_64
Date: Mon,  5 Oct 2026 14:59:10 +0200
Message-ID: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If x86_64 is specified as target CPU instruction set (e.g. when
cross-compiling *to* x86_64), the cpu_instruction_set may be set to
x86_64, e.g. if it is derived from a Meson crossfile. However, while
Meson uses "x86_64" as name for the x86_64 architecture, compiler
options accept only "x86-64".

Introduce a conditional for handling this special case by changing
cpu_instruction_set to the march-compatible value.

Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
---
 config/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index dcb84ebd13..238d6cae0c 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -177,6 +177,11 @@ if not is_ms_compiler
         machine_args += '-mtune=' + cpu_instruction_set
         compiler_arch_support = cc.has_argument('-mcpu=' + cpu_instruction_set)
     else
+        # Meson uses x86_64, but compilers expect x86-64.
+        # See https://mesonbuild.com/Reference-tables.html#cpu-families
+        if cpu_instruction_set == 'x86_64'
+            cpu_instruction_set = 'x86-64'
+        endif
         machine_args += '-march=' + cpu_instruction_set
         # arm manages generic/auto config in config/arm/meson.build
         if cpu_instruction_set != 'generic' and cpu_instruction_set != 'auto'
--
2.43.0

