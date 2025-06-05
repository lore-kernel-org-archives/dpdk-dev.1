Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D50C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18B7140609;
	Thu,  5 Jun 2025 12:59:15 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id F13984026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749121145;
 bh=2uIDosCiWfh69kC/58xmEQJsD8S8tUyCJKHxUL/zZdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jbikN6tQCUpTiHsgbQnFKnrLEJH42m8+1HqteihDJGTFcxI2BY+sRKB2KrKgmyusY
 qJUfTST8/xRc8SA2ReC5BuE/4ASs2niWhDfeq/nmIEoCmk9evreXfEcxB+T7ia0ouw
 5AOjdDeXoW3L+Hxxxus3YRgR7fec62cDwiemwoOE=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id EC407837; Thu, 05 Jun 2025 18:59:04 +0800
X-QQ-mid: xmsmtpt1749121144tqcsaspqi
Message-ID: <tencent_F4F230AAB658900FD515FFCD1D61BD86B10A@qq.com>
X-QQ-XMAILINFO: NEoGzTA04D+5NkoSMGxdOROOEu6J1do69CXrfC3XKE6nxnKgXoAo1YoaNnqoP8
 Xjy+uxhQqQd/34urFJXtt1ULzkBvNrUj+6omVgLr2S0h9HGabs0vTQEC7dtASNa5rrnsdRBkhRjD
 ds9OIV+2HF+pIoxUil0gdZHsMF9oz1YBjzHv4QMwfv9Lm3ScakfeMi1RSOiFTV/90fFFAp9rIZCc
 q8joJxJSrsuZZDWObbQPVPCFNJrYGnuXaE1dlq8wYWDLKTN8ma+l4pTSUE+mWRF6Ay2Op6EThWNp
 RLBAPHavTBDoQ0vJxAN+uFL7FfL6ZuoaKypp0coaZb18/KOPr3rF6rXzaysEsQwwdm+IbkxfZD8i
 uMXWT4gqhSN4dC9PrDR4Q1ZAwmaUXRqvl0LjioPcvOtkr0xyXsJSr/In85e++xGnY5XeKiKFd81S
 WBm1MO+B5LzIMN6LayYO0/vqLQ4eC8hPxpJ3Agsqv70JK9hFOtvUoUeovn7+DkeHYXbXrOfCg/Dj
 HincwG1mNMRsxXRPElYi4N7avxQatm+3IAgceObIY4z5sZLPSA+qKsc5rcEskv0wDxsLLNpCjrx4
 kT3ZTwyhVrcyDeJ/BU+h/GFjGugwJ+eoZOX3O8QVoPnR9+3OPhtGZAvCu2CAnbkVFKN5ZqV1BEsl
 P/HpsArkudxAcS4O4+wQEPYxwK/wJWlFEVQ/bkvriUuRSbBcyY+HTs+SlA1llrEfhnsAmL+tH7QR
 bFqQlScK1OcCEZuuLl7hznjyfXkOjg9SUt6c7ksDJ4Lnf9mi4U8gMgwJmYohG2qLL0Vpq6E24f6g
 gMv49iWY4YnK/UHY4l0ePLT76xYj9Xr7CTSnXt4qjV92nQ5/77FzUKMSzz8O5ikbODEap0tK7i9c
 vE0faGnQSTnEm7GCgH5puN659Zgv+V8KNgwCfEcodVhOoLO8vrngg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 1/3] config/riscv: detect V extension
Date: Thu,  5 Jun 2025 18:58:41 +0800
X-OQ-MSGID: <20250605105844.3931758-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605105844.3931758-1-uk7b@foxmail.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <20250605105844.3931758-1-uk7b@foxmail.com>
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
 .mailmap                 |  1 +
 config/riscv/meson.build | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/.mailmap b/.mailmap
index c65872cd9f..b635eb645a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1508,6 +1508,7 @@ Sunil Kumar Kori <skori@marvell.com> <skori@mavell.com> <sunil.kori@nxp.com>
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
-- 
2.49.0

