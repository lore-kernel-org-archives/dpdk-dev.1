Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7316BC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 18:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A45D40664;
	Tue,  1 Jul 2025 20:20:55 +0200 (CEST)
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com
 [203.205.221.245])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 37EE240276
 for <dev@dpdk.org>; Tue,  1 Jul 2025 20:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751394048;
 bh=Ojy0raqjqliAFZNRkOUjOTutkxrUUicY0EDA9LMCrbc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vx9dH3fbhJtsDIc5mEb7CrqS4NFmXE4NkYlOQa4mKajX43jQBa3X8x21XjcoOBb8b
 uZ4CleFdhKaxbuEAWQcu78BO2etAdVW3upSc05QAaSNYxS6Es5SDS/dQuaKf1go/yT
 2wkGnBFMEe2dzSqIiM66WYegRvFBXUtTSECoCfyo=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 5288F07D; Wed, 02 Jul 2025 02:20:40 +0800
X-QQ-mid: xmsmtpt1751394040ta95dzyhw
Message-ID: <tencent_512AC2D478AA548B2D4487968A1FE662B109@qq.com>
X-QQ-XMAILINFO: MwqrwaLzgdeboSpKkcOVWx0Hg9VBItzlNUAM4R3boQWqB2SCYWHMsG8RBDqyij
 fCN/KZYqgBPW+YAo/eF9cjs1CzaMxBhUFTZur+Elycd2OoJ/B7FF1AEeY8QSY2i51Dzs69p664kZ
 JugfftmoYF/FqXPEuFbVsjFaeGUvJ0bEOkyttirUiZ5MaKJGEdNqKJEJVcVH165p15ZnX2vZmjRC
 gE3HEHMm8Xqjz0lsxYlwtsmUfk3MtP64WcIGBmqeOIkeXzfbboWOJ8qwWZydUzOy/23WZsNAJS++
 x8pQr9xfMgOLZ450wzuXeb9iBTy1Txoil8xv/F6FW5j7nErpEEyHVacboJLOgQ0jQKugVjo+bEaU
 yLo3r8lrzjiaIkF88ILSHCtbToCQwx6eJz+T+BUdJi0bolYpr68T1zc0kMtXaI73dvkT5FdjmCdR
 YiaeT/mdt9YVNw0DoB5SQIRWdbBh2JuGAUq2fzjJe5GAbBupjCj6Li80d/vcd9de2fQovwk1So4Z
 vYTXke44OKBpGhreM1ptxX8gSwCThVPvshhRA/EHxen1h+7EOI1FBHeB8dYhnRHTBDll0hZQe5tE
 H/jYLGBW4c+NrfsoKqaEXwJ98bzQdo+VJkhy8o/Vih0Yjhl9SM86BVx+C17+v1L6XlufQysI1uSr
 3c17Ec4aeIJYBGOeOHLPc+5hO/0ce3d3h88Phmtgp1Zw5O8OwV2aTfr8FZ4c106uJxWMl9AechD0
 j8ha/ocQsTK8aTYtqnIHXuJ+Bm4S8FYvqivDuX2fguZRA+ctKCUPLeXu+RgOncZjyx7yp6xMskY6
 JG8Ak/5GguiyGAvaKlvD/R6MzavtXdnWHGT+JYWM+8sNoZ3+eDtp8tTnGIT33gK3amrrJSehr51t
 buk7pciyo0i+wFP1AcyX0oHg+9ctFz/VB1qsL+TTL17g3NsSSybNocmZ+A28AAYkh5M6uHN5s2
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/5] config/riscv: detect V extension
Date: Wed,  2 Jul 2025 02:20:29 +0800
X-OQ-MSGID: <20250701182033.642384-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701182033.642384-1-uk7b@foxmail.com>
References: <20250701182033.642384-1-uk7b@foxmail.com>
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

