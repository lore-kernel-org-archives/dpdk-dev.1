Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B8C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 16:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7603402E9;
	Tue,  1 Jul 2025 18:14:55 +0200 (CEST)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com
 [203.205.221.164])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 358754065E
 for <dev@dpdk.org>; Tue,  1 Jul 2025 18:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751386491;
 bh=Ojy0raqjqliAFZNRkOUjOTutkxrUUicY0EDA9LMCrbc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eidjm6pJwZIbF7Fb/NKgM4uXgKQZs9vHeTSaMChtli9/cF/ho0e0IfGOTxGG5eZ7J
 aaedbAkwauNjj2hBiYGxpkFZ7/Cf46wCVFTrOSjDWKhDGzaV45iXQwAM+8e6nWzSwj
 s8U5oppdD+kP5jyWDpnKWRPFpRmDRykDtljSfNsE=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
 id 3AD272FB; Wed, 02 Jul 2025 00:14:45 +0800
X-QQ-mid: xmsmtpt1751386485t697n5lb0
Message-ID: <tencent_938DF04CAA625B340C25179BCE8162CD850A@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2Ui2eHB6AzeWxnsbV0NC9sW90W4Q0uDRoqpQnmezMkrulC0ZOC9
 EQd7hGSkZGShOFYVq05fdB6ODzZM6RG2LQmBFOb37QE2Lks3n6iya57um1ejdKfX9XVw0nZW7mcQ
 2UhqNX5vrRO3XUOsiOCy5k8IX8e+RxeM1M06NJ+HKYHHynIsPeU3t/CsG1IjK4IvKhO7+mSFIc/1
 YmLfX3XKRUXCUQjNAov7RAbRpqNszC1HvPPsVPt33UxymEkjrt+veNiyTbAco5nh8OM6CjCkIn94
 CqRuz7HXyus1HwfL+21tMD2Xwuw0DLXNodvSnqsAggvcxS/WVmY3S3ZuapHzDsq1IgCHbSvF8rKD
 ELGxkwtZ66HDi2s9C+yuCpnW7/P+8hLJ/cmAbbe83ICVAddRC54N6LoxePPWJYKmoh/7HNw1eG59
 iAxMYQ8iiubkHH7Zd+qOn+SQTKIbUFujHabBJPWhFHAgn9glPVz8wIp07ad9YFlQVEliLdjKnj0X
 XFKDpVKFOb+U5q8jFCwlGcxs8VbQEI6Q4OA32XoARYBQwgKUBXLJsyvvGwC2ZxKgMa75LoCDK5oZ
 ddgy9WOOsxe09dHzQbCvMOKhDzXO+zBom2rgYBCMyqnC2bta2lfwef1/iwquXDdjUbrsirvo99wS
 Wf4lVfGIW2Svcgpqs0mD6k/M2N9oDpef1rY2wolVsteul452Etyk+qVg01n/h/6uTNgVCrokvQOv
 7r4JU6OM6NmAYOIGRgvhhl1DZ2uuyoqBG/zKn3wVeovM7Fk83RfJV31LQO/KSh9UhuV+9aMM+8Wm
 A2LmtbtVYK2u3SCpaZh1NC6+dJNt9czSJ29WD6d8VV4mlrfid5RXcz7kk4cqoEzTb4eNlmtYk0Zu
 IwagieSYTxNNsPQJo4WQRRboaRy9PH19FUfb0CZZAj3ZAXF5bbRpGYBwFyJ/+AZy5SZMPAM4m6
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/5] config/riscv: detect V extension
Date: Wed,  2 Jul 2025 00:13:38 +0800
X-OQ-MSGID: <20250701161342.46750-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701161342.46750-1-uk7b@foxmail.com>
References: <20250701161342.46750-1-uk7b@foxmail.com>
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
2.50.0

