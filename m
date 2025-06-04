Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5275EC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A349F42DD1;
	Wed,  4 Jun 2025 15:07:56 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 1433442DCB
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749042462;
 bh=9jPVAJsdveFmvEIskdyTPeqaobb0rO9QjEji692N5jY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NlImq0vjQPc4D/BmeBSFOLF8VrKNWNydCrF7KR/aam5b+ue4zTI0h6xufoVrFa+qH
 XJQANM2hffu8jGSI/Qc+I4nARZxEz4otMjseyoXmM3NqG1RGGj47mXtBAuF9hCvi9K
 iYnwy9zPEB+vDOnbGrv2fIYy9A0i1jsMd/N4ANog=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 1E909CDE; Wed, 04 Jun 2025 21:07:41 +0800
X-QQ-mid: xmsmtpt1749042461ty0fkrca1
Message-ID: <tencent_19200D25157FCC8160218545F000AB465A0A@qq.com>
X-QQ-XMAILINFO: OASTJNHpK0Kvx8VQBS4HeN2F5jZgWiRuBsjQXPOWeAnlsoIBu6vfhFAxXtRqMU
 WYnoRZWH+hFy2UJLgdZX97mvuvCXT1q/nmcrBzv6V2+8+FYc4Ro7iKU3Ns7dJXP2tmjqvf8W0Bpn
 5kBehRQVlmGT4SwVfxi/dCCc5o77J+P2VYLq3reoSSctFqo8HOri22DGMecamCEm9DaGhdaVYEJ1
 qUrmsYj51WZO2HZjKKBDP89RDoK2k+kCTnuuzUAyfG51RNe22//Z5ZuakEskYeF0l+3O3YY9kabN
 gJKgSZ1s2TyUUIIZi71esmf+DOGhP0ZJaTI4rN4qv8W7/VmelN86RqijVN4uNViNrfplPiHizK7A
 8y9OqBB8jBqlhR3aTe1LhLCZTBFTTMm1wtAE4SJV+XgPRHWUmLKWf0O8ZtIYQLj8b73jNjPpg14i
 gEXjwoVmczWWtYjbpZ5DFDmO1Bop+rB5mSc1YXXT+puZl8aYMt5oKrtfr5O1jgsMWtw7STZxj55Z
 YXx+oU3baxKxHNozE1dPuAhqxsiXHFN0+VkNriWRxqmRESB8lWsF7p293nA1zmFaWNiuutdK1G0Z
 ZZ4796mvdzVYyaVISbLqNrNxsIVFklLJ54KNzwMIS0MEpm+j+LQc88Ge0wuesBNxhnhg5ikfhoCS
 jpBx2ahgP4+uh2YFcpN9brCpnIgXt1htNS41a0cZ4gk5o23JQ6V+ldQvUySBCDSVFL/V8MVXGxtB
 Wqx8p++ZVtzpEG6AtvGNkcx2J08ZyHKmRJt3M5B8R/kn5BaMpJ8Zg4v8kMDPP5uOgA2jvs4pqKlZ
 3V7YulTZ6nQFmgkbwEvRzVsSSiH9fA4J547YYuqTVjUK6iSc+DWoZjHcY6xEvnNlI93pvkQnG4ax
 uu0IZHhOMWrbDLHAKESsWgpHbAi5rGwQjC0lyKAfXY7wJSwPq04fBHhULEnQPhigwbgGmPqklk07
 llkKOBT2jxz/orxhCdQSjtixrmdLMA05wia1LvF+q/OGrjNWJY/Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/3] config/riscv: detect V extension
Date: Wed,  4 Jun 2025 21:07:39 +0800
X-OQ-MSGID: <20250604130739.2347575-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
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

