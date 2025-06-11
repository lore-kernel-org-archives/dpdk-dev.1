Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A9C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 15:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA27E40A89;
	Wed, 11 Jun 2025 17:00:31 +0200 (CEST)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 2A56F402EA
 for <dev@dpdk.org>; Wed, 11 Jun 2025 17:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749654018;
 bh=2uIDosCiWfh69kC/58xmEQJsD8S8tUyCJKHxUL/zZdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XSXWrj9MSe61VPA/W2XhjXGpS0C+DjEPBIAMWvl11brom2/cXcGIvfhFe0iJcA+uO
 IvJB34NYXNNR4kvCJMKO3sVFn6yGOCaZqFmmySyS1bF0H/X5nzLbNjuA12XQLvxGsZ
 7nSbbuPn5stZAeK2HlRvr7SA/0nnpeY9wcup+PsU=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 10908EE; Wed, 11 Jun 2025 23:00:16 +0800
X-QQ-mid: xmsmtpt1749654016t6wlpmb2c
Message-ID: <tencent_F3EDF3A8AAA2584C0C1D1547CC2D61BD860A@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVD5Jr59567zGYC6+nMuxVgWK5OM3bCXHGUTH3k5uPONA3pxCcuR
 qhJdeXYGSr9GQb17x0Qw4WwoQFLciscqtrmVJF1ttZgas+Yrk0NlwdRJ4qGVvfdZzvCFusnwtOzW
 fit6OToWWC2tNZkQNmqeSsSn4RxugfjR4D/vIW7AAJKg52QgjM1zWLchuXEO02g2OtMpf/EfvEYf
 5sky1V69CkmbfOycJoCFUl8VnCsBnbJliy044KYRyd2vIR4t8pCse7KgEdXW/wMOFv8bwb0F9e4q
 koofzrGl342/NOlpMOqaZYCJrzyN5P8HAQNLIyYfSJlVUGpTExoypBHgUM+ArcoVkzmkaKew7bVq
 yUOmIJQCkPdv521aJ8BjJ2rEiEzyil5u0YYlbKCeGJVlQUmkP3DFxw78m/YFi8Wk1FcdJO9JQAG7
 eaLKa5iNlUa/uSNsRbxdz66Z0NBhxNu3n5tKFs+8pvGpJNC55pKgaMFC5HqG2lrEUn95HlTxDQvA
 uY1kUoKVyulZpzCKC/IHoDAwaCvVCyA0aasrKRCQDilyZFQXmpvgdFD7ryxoSiHlI5+JUPR70JwA
 k3Ae3VFMfkPIe0zptxFP39SagLaDHgGATMg5zc/Uk3Zp1pgFEGX6oWv/mR1cU77JdC5GAvE4gSxG
 /hvfOJN5PTtFYmX9YWcPwONWX5bXba1s168xN25l9V7zaYVtpcuxJIktQTp3rFP2e+z7RjK8EyM2
 HKZKF7DmWMYTBPaOJQDWoizy+gpocqsSjTOimCh8YCGyPWO3tmEM/o7byqh/ssbndo9COgnrJee2
 ONvkJDSXKTxCLaae3M3b57ipOm5DTVMem7NRTMdRCUz5u5aGZ13NVCv6MxdMqsT6MrgyKt49Wfmd
 zl+XWhn+nIPQu92o/nnyHe/1YMEeGHK+UEnxi1y39w1FUA0WQcTuJrFd9+2EeN3ZKuITHW1Gu7
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 1/3] config/riscv: detect V extension
Date: Wed, 11 Jun 2025 22:59:12 +0800
X-OQ-MSGID: <20250611145915.854026-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145915.854026-1-uk7b@foxmail.com>
References: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
 <20250611145915.854026-1-uk7b@foxmail.com>
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

