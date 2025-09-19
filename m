Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACA8CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 800BD40657;
	Fri, 19 Sep 2025 18:36:06 +0200 (CEST)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
 by mails.dpdk.org (Postfix) with UTF8SMTP id E492E4028E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1758299763;
 bh=7N+FOwMWoP/TRXJNJgZUWWfRAAnc+AhJxDelBRBXFVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=x40Ht2sG1LFnQ+ode8i104J8G5QyLuvy+jfog5ypi5a77HO/PyJQEBjtllZ3uALaW
 Uvthoc0wyGhowHgvVprU4nXC5j/7o1yye1Gvd+YP0McqSZvCnhRgMjY7h0DUYxAToM
 CqQlWtzrcsJvwmR0Ns8BCWgfFAICFGDQ8H7sbW+8=
Received: from ar ([42.177.177.196])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 8F791E1E; Sat, 20 Sep 2025 00:35:55 +0800
X-QQ-mid: xmsmtpt1758299755tlmuk58sk
Message-ID: <tencent_FDE91C0DD66F18084FBD6A8F45C3D05AB106@qq.com>
X-QQ-XMAILINFO: OD+BZsga98Ud7YPi1jK8gcQsqLM6EOAPR3P/nF7cdfjJU7AhbepBQElHaejazU
 963ESbkRZM57trNyuv5RsTX+rdetjYumgWt+dF1tYwj2ZiMKQyIvfHII0lfurj39lz80EtnyzOze
 rkkiU8DbaKjJcL2Knv927cKVKtRCD21Jdxl6iPJ1oWNhcDx/BKVseIedlafEVgolZrpfCrErZ368
 sWLRSkDwDEHSjDKvNCGXlM3X0fqsCmzgv33h5TaA8Ss7kw2Qe+lyfcPgqk2urDbYbvj8ybCBWWFd
 XL2UCcgbCKmrnRcvMRQGrJ008IMnHgGw+SspvHlw9GMQKVPjyZ22IfaBlpAzaa4e4hLPub8aIG8a
 WWU0qd01fOtUlMmm7EFQIqSrpeRi2tUV8QDdNRarry1S8ol+a15DZUg05qtrNTJWH6AOhhdVm9HT
 gEnX9MJkveEUJ3CZayfw16iEBAeNx2s0Rnm7ea03tHTtD9024Gw5ctqk1GrSP8C/Rzk9S3c4Xs+o
 Tpcq53mb35qUzYRGWCaRBz6to3OjNk6s7cLDZkwLN3QiTKm+JP2OmoqRoXBHchzxTEwPk4hBKArv
 ktZQSIpWmxasGAFpUuf8R8uKMaYDk3vCkS03I1IhUqU/3/4p9lOUadhK3x5v5tu8kH2aR0ZPXavk
 +TTc/9HkKgEG0Ho4hMAPgym/l8ytCoHVLIiOEPnQ1TbXi9w7NIxh2Yera40gIT0yihxClj1zLXPL
 t3StMUhXD1oAKwYr9DWRhzL0HsNfJceemJeQws3bWQ1122swe5mU4dVWJr0b6siodcW2BrPf9D2m
 R8U8YiAtBalpx98D/YGsyQZj2qLRoq2z5hV6z1j2qF9wwqDLyX+8afEdU0DuUormV4N09xU7alLt
 8QgESvbQRbfAi8ro0SJajQIcLX34NyB7y8qJfZjsDZ8hsPrAmRg7ZhvG1DOP+JJW9T6QIBsyHWbQ
 /FKLtjIRg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/4] config/riscv: detect V extension
Date: Sat, 20 Sep 2025 00:33:54 +0800
X-OQ-MSGID: <20250919163358.2887335-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919163358.2887335-1-uk7b@foxmail.com>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
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

From: Sun Yuechi <sunyuechi@iscas.ac.cn>

This patch is derived from "config/riscv: detect presence of Zbc
extension with modifications".

The RISC-V C api defines architecture extension test macros
These let us detect whether the V extension is supported on the
compiler and -march we're building with. The C api also defines V
intrinsics we can use rather than inline assembly on newer versions of
GCC (14.1.0+) and Clang (18.1.0+).

If the V extension and intrinsics are both present and we can detect
the V extension at runtime, we define a flag, RTE_RISCV_FEATURE_V.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 .mailmap                         |  1 +
 config/riscv/meson.build         | 25 +++++++++++++++++++++++++
 lib/eal/riscv/include/rte_vect.h |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..21f5d7fb5e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1513,6 +1513,7 @@ Sunil Kumar Kori <skori@marvell.com> <skori@mavell.com> <sunil.kori@nxp.com>
 Sunil Pai G <sunil.pai.g@intel.com>
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
 Sun Jiajia <sunx.jiajia@intel.com>
+Sun Yuechi <sunyuechi@iscas.ac.cn> <uk7b@foxmail.com>
 Sunyang Wu <sunyang.wu@jaguarmicro.com>
 Surabhi Boob <surabhi.boob@intel.com>
 Suyang Ju <sju@paloaltonetworks.com>
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
diff --git a/lib/eal/riscv/include/rte_vect.h b/lib/eal/riscv/include/rte_vect.h
index 6df10fa8ee..a4357e266a 100644
--- a/lib/eal/riscv/include/rte_vect.h
+++ b/lib/eal/riscv/include/rte_vect.h
@@ -11,6 +11,10 @@
 #include "generic/rte_vect.h"
 #include "rte_common.h"
 
+#ifdef RTE_RISCV_FEATURE_V
+#include <riscv_vector.h>
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.51.0

