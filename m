Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A902C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 03:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EDB6402DC;
	Fri, 27 Jun 2025 05:58:57 +0200 (CEST)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 4C660402DC
 for <dev@dpdk.org>; Fri, 27 Jun 2025 05:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1750996728;
 bh=eEVMSwwSQa3yIiTxmaC0K6FHYeT9mqfgOxZULmmQj/o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E3+RIoEMj1BqrBGkt/1TFKzMqzcq8WZGzBnE2XXglu8wC3uiA/ES9ikKDEeD71yb7
 Ca9Dfib5Z4gUD35+xge1igKyRRtVCJVNhDbKxq8BhDJDq4t3jI+4BT23w/BWgGX8t2
 xAN18c142Rs8eXonemi1oPQ80AJRVDtAGmc0XZBU=
Received: from localhost.localdomain ([113.231.69.199])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id EAF1D4B5; Fri, 27 Jun 2025 11:58:47 +0800
X-QQ-mid: xmsmtpt1750996727tq833hm69
Message-ID: <tencent_0B86F88AB3E7B4B040C262799254E72C7609@qq.com>
X-QQ-XMAILINFO: OabLgwGJB7xGMWw6EpCKz5uYwHz+LhYfb8Hsw2H6n5CFiLC8HmcE5m0ihQAQDp
 fdWwZgwyxs7l6MCexNAmYBOY1z5Bsi8qGyOwlr+iToF3RqNGYXQPbnhuHSYxzfbAI5xTEhkJXkxU
 PNTq2GcMvfnX/8W8qrQiQUOz9yGLZF70+M76AgP+BMb2b23KyDWDqORxsDkEheKQ064Oa/cSnzrt
 aaHZaIJ/z/fbO6oQ+ewWBRjkw+tLUZSTyeTLPsTXiWk53o+QG9H/k9LtfF+n0XTRySICEY+jG1fd
 vuzcOJnKHnBSdvsoA/Qc5k/K7hMH1sCUT1L3hbqble6rNCSI9Wl6EL4XM6opId00jJkAlplKp8K9
 AxakmIKCj1UCdpy8/hmgThrUalBcrncuJbnzk+T1wlE7gKpHER/t6jKZ2+JgMZtXc4l8nXResBOo
 fFBQ5Q5a7e/1MrAy1NOR2vLC6AYakbJOIXS1VTOhwf0UEe+DDRSiF1rWu/4hWubGMJ5eVg1wAdVk
 DcDqGrm2IP7YvsjvZxXn+/fMlhMZiMKgd1/GJINX41fILh+YfiNUAOeoyv8QXIBkU/JJs5HcjYUG
 Bmg5Kafrtw53mGqbZv2Lqd76qFXfukkcF6Yue8mHmVLCYmocspTv0DItLtjwjApbBK4bbqrouRHa
 x0kzM3jM1g3T2EAz3xyxr3E6Ak9pZbAnuts59O+/F7ZhFpQTypBlakVC1QSjF0K4h1NAxC3Z2Hw5
 9PFReAAtgIDJLxxl4yRu+1aYWAs7s2RIaMfY4BHeTBVHwC+bCzEXQAnPkJU0mlRDrtlZR8p1ENLI
 wdTHO36kI037+Op1HBFsDNSRJXU7Q++Qb+MX1YmTCyAAMgXIcI6TU4fv3/YonC9So+8Dl9mEdLA0
 NpJgz0kGn4bH4K/wZbzn4sQewBx3mKrrmdxl+DUh3WrllE546bmM7GcAHIHscXkQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 1/3] config/riscv: detect V extension
Date: Fri, 27 Jun 2025 11:58:12 +0800
X-OQ-MSGID: <20250627035814.670775-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627035814.670775-1-uk7b@foxmail.com>
References: <tencent_6985C4D07FF1CB5C3AD652182E4F9DAA9906@qq.com>
 <20250627035814.670775-1-uk7b@foxmail.com>
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
-- 
2.49.0

