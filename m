Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B07C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 09:56:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0A7410D2;
	Thu, 29 May 2025 11:56:13 +0200 (CEST)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com
 [203.205.221.164])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 65C6640156
 for <dev@dpdk.org>; Wed, 28 May 2025 18:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1748451553;
 bh=9jPVAJsdveFmvEIskdyTPeqaobb0rO9QjEji692N5jY=;
 h=From:To:Cc:Subject:Date;
 b=MueyThXQ2KVucj7MwKfhylj9/8Vbvxa88RzCOjsrQFFDvuz4Z0vFRN0BC3RnNHw+M
 LDwvIUCZfvZhHIaP7awCGOzpnyBSLWwt9Zt3w7Y01zBBGXEzQJ+nJCsAp+ow5vBsz3
 rwwcTB7T+OhdeIq/4MBuwv/i8vj7IdXno9vGws5w=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
 id ECB9A859; Thu, 29 May 2025 00:59:11 +0800
X-QQ-mid: xmsmtpt1748451551tm7dqx017
Message-ID: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyIdrtUW7Rs31oh5YTctM/MoGLM0obc8oPROj9rR4gx8bOZDeNoC
 EE3wXscrLrNWYfqJihRNEzC5Q3pPqufqTmSE81syqYoxZxw/KeMHk9jjxVoYOEOPNb+qYfPNou6u
 9+0d5cPP9LK6+Pk1SB7WHodTKMFixZ5xcj7Xs0DQU0PCaZJt9Fn3MJzmzdKpqaPoI5PHblqhpIAG
 5RPYVrsIbXxXgHg8KW3JmtZXWUVQpL434zPQwLhLJkNFOd5AQ4lv17cktev6fFKCDILHT2tCvfiJ
 GY+LPH+uzEPKX4QO+IKKhrYihB8Uxq/oUoh1tGXvb9yNCw+lPWP6yNkdxnjQaRuXq1pDfltVbp7b
 xtAj8dP+1Aq01r221iWxg7jgPSSgPfuHPovlIqGGgrFgvqe2RssCJBjXjnTjVhL08INDjukzhtxC
 KpO8blrcr/ttyaGqSduMbo0jFyfk8glsqaVIRTma59DOdYEMwjBYWT6e0xNQUi6WVTSCXFW2/O9U
 FkKgPZzbCDF0D4jdPYtwuT9cJzpx6wFAqnvD01dTl4TgWkgDRFV2xK8svQBJ/WSgqa1Ctqll7bu5
 w4JbDoP2IHMRJp+yBTs928d9oqC9bjr0yd/IL6dV7t/kUaf6nzyosgXFXbCGxOaQzjZAOATkx4Jd
 KlOWdphc5gs0+pOYK0nx83VST6kQS370rXxpCmW2cxFvNnEHHsstkqxMT5vzBo2KOVpElyaVaA4N
 NzurTfHs4EfRNMUGk4QlQX336na1XDQ4vBUofolVTY7gjf2Ks9WHb0ySgQpZaGDuZRMhTy0yLxlU
 cKRW++7AO9d3GX7syupHBq6b1q82M2kBWmBGlvhueVXpSS29Q7787TWVOR4SGNdjwJKDmpsMh1lR
 2RItOs5hCP8qy3F6toIuZEwOPmJBtRJMES9wqS1SV2
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/3] config/riscv: detect V extension
Date: Thu, 29 May 2025 00:57:09 +0800
X-OQ-MSGID: <20250528165711.216524-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 May 2025 11:56:11 +0200
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

From: sunyuechi <sunyuechi@iscas.ac.cn>

This patch is derived from "config/riscv: detect presence of Zbc
extension with modifications".

The RISC-V C api defines architecture extension test macros
These let us detect whether the V extension is supported on the
compiler and -march we're building with. The C api also defines V
intrinsics we can use rather than inline assembly on newer versions of
GCC (14.1.0+) and Clang (18.1.0+).

If the V extension and intrinsics are both present and we can detect
the V extension at runtime, we define a flag, RTE_RISCV_FEATURE_V.

Signed-off-by: sunyuechi <sunyuechi@iscas.ac.cn>
---
 config/riscv/meson.build | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index 7562c6cb99..e3694cf2e6 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -119,6 +119,31 @@ foreach flag: arch_config['machine_args']
     endif
 endforeach
 
+# check if we can do buildtime detection of extensions supported by the target
+riscv_extension_macros = false
+if (cc.get_define('__riscv_arch_test', args: machine_args) == '1')
+  message('Detected architecture extension test macros')
+  riscv_extension_macros = true
+else
+  warning('RISC-V architecture extension test macros not available. Build-time detection of extensions not possible')
+endif
+
+# detect extensions
+# Requires intrinsics available in GCC 14.1.0+ and Clang 18.1.0+
+if (riscv_extension_macros and
+    (cc.get_define('__riscv_vector', args: machine_args) != ''))
+  if ((cc.get_id() == 'gcc' and cc.version().version_compare('>=14.1.0'))
+      or (cc.get_id() == 'clang' and cc.version().version_compare('>=18.1.0')))
+    if (cc.compiles('''#include <riscv_vector.h>
+        int main(void) { size_t vl = __riscv_vsetvl_e32m1(1); }''', args: machine_args))
+      message('Compiling with the V extension')
+      machine_args += ['-DRTE_RISCV_FEATURE_V']
+    endif
+  else
+    warning('Detected V extension but cannot use because intrinsics are not available (present in GCC 14.1.0+ and Clang 18.1.0+)')
+  endif
+endif
+
 # apply flags
 foreach flag: dpdk_flags
     if flag.length() > 0
-- 
2.49.0

