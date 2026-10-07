Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8706ACA6007
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2033A4068E;
	Wed,  7 Oct 2026 11:27:06 +0200 (CEST)
Received: from out-dbl.mail.syseleven.net (out-dbl.mail.syseleven.net
 [195.192.142.195])
 by mails.dpdk.org (Postfix) with ESMTP id D9F5940274
 for <dev@dpdk.org>; Wed,  7 Oct 2026 11:27:04 +0200 (CEST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-dbl.mail.syseleven.net (Postfix) with ESMTPSA id 400E61F81FF;
 Wed,  7 Oct 2026 11:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1791365224;
 bh=O6ZvH4d3278LXrpEnXy4VtUodi9HCUUFschjFiERmoY=; h=From:From;
 b=PYzQcUmXMwZFDYt9H2g6JLkDIEsN35grtyBVQgHIoCWv06CyJYTr7pcKWq/83Ojhp
 GfRYTj5LDofyscqADQ/tRfQXdVKfXf72zyDntNd5P6bmBq9X4R66nervfydfNyKtLZ
 +Q9oYwYVmiwoRQH1WKlKuvXmLjOTKn2LEQ5nOQd2jXaU63lNwDpkJKytTbnICInHem
 iV4lncbCskClIsd8quYTuv0lKOZZOhOrVkWr3Hzj84LqJM49YWn2R95Yz7vgq6ul7K
 JoA+KPdm/QH20bniyOTl1Vws9mc2526ufS82QEBF6W/gp31JMa9xHbn+TX4y7HkiEP
 AMiaef2kHPQTw==
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Subject: [PATCH v2] build: fix cross compilation to x86_64
Date: Wed,  7 Oct 2026 11:26:29 +0200
Message-ID: <20261007092637.916513-1-a.schollmeyer@syseleven.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
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

v2 changes:

 * more explicit comment about GCC/Clang requiring x86-64
 * switch to x86-64-v2 feature level

 config/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index dcb84ebd13..4682729bad 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -177,6 +177,12 @@ if not is_ms_compiler
         machine_args += '-mtune=' + cpu_instruction_set
         compiler_arch_support = cc.has_argument('-mcpu=' + cpu_instruction_set)
     else
+        # Meson uses x86_64, but GCC/Clang expect x86-64.
+        # See https://mesonbuild.com/Reference-tables.html#cpu-families
+        if cpu_instruction_set == 'x86_64'
+            # Feature level derived from DPDK minimum CPU feature requirements
+            cpu_instruction_set = 'x86-64-v2'
+        endif
         machine_args += '-march=' + cpu_instruction_set
         # arm manages generic/auto config in config/arm/meson.build
         if cpu_instruction_set != 'generic' and cpu_instruction_set != 'auto'
--
2.43.0

