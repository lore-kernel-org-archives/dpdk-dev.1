Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B748C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 17:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 365CF40667;
	Wed, 28 May 2025 19:46:43 +0200 (CEST)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com
 [203.205.221.164])
 by mails.dpdk.org (Postfix) with UTF8SMTP id DBBF840156
 for <dev@dpdk.org>; Wed, 28 May 2025 19:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1748454394;
 bh=9jPVAJsdveFmvEIskdyTPeqaobb0rO9QjEji692N5jY=;
 h=From:To:Cc:Subject:Date;
 b=v9QxAdQjaW+j1koZoxezrQtQ9VrnODYMx3to0S73PG9HDVqt/uhGgkM9dUthsV+jh
 WXdJHLtRHJk4AznF/HxmWQ6gQtx8xfXRUzUvn8nFhWdxauL1J7wLPF1kXYsVmHUbFD
 kH6OnOy2ip6B6QPCwR0uMfIbaZlbBrz4nPspQ6yg=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id BA086493; Thu, 29 May 2025 01:46:32 +0800
X-QQ-mid: xmsmtpt1748454392tvqjydi70
Message-ID: <tencent_C644B5CC227C28A298734E108B3F4C8CC705@qq.com>
X-QQ-XMAILINFO: MQy0F0MPup0XRimqGt5Ryu16pUGByNmXok09XFF0Qy8ZFMILdm7hquk8Td14S3
 3v124zsqm4gngZ4xiZ9EiyJnbmmgNGp4bfVJcowskaUMhDLpFm3JxJWovIUBIxSIIPLLhNwrfwHj
 d+Ne4IVmn3OfD5KFmIuKNuO2YKz/7FWpQhp8QFbj3RFv/GRXCP6nYeVN5P8g0mSSoza3xljdDe9I
 zzPrfp8FU/AohCOEj6XA2zav2FdasVe24PI/bTh7tMobjg85rnCKG/E3BfQArgslwxVv6LXgJes1
 +I0D/6BqR12Q66c8J1xDv/3BZmBYcMCY82h9FtlRwUBWN1MhVwAdKbkxoZxfTi20EBDU8C3SZFqw
 sG+sgeLzo+++UaWqp4yCn0KIgGl+Zq7PZg7kF6XexiHwhx6mcQNwIdgI6QL7rdeidWfQ+BXXCwYo
 LVH9yDC4i2aSqxTJnD61j/zarsTd17VlZzgloODF95XJK7QQqQ6rOKTIwrvYifpspLCt5nyY4EYD
 ARXom7cSBTt1ocTjrfetaj6RmlcXcG74Z5+VS+LrYMemc0ST/wNhaLyte562OcBkwPM5pke6RAzM
 XUmAU/J0PhBCsby4/SV4dw9KY/naJkbzbig66wR58+JmlsN4VpkyFEdlQXhcs/WmgRVvwTY/ExbD
 1wR1n/yETpt68tnxCrCe4welt2RwkYIUNAU6sVGQ4aB7u6cY3/Hj844vF00akhzkaocMYVTI7SEz
 iSITsv4kgHe76IvZCotDeehqAsIE1gWverg6/y5MmYz6VPa3EGuvM3Um/ihuFQrM63Q6x+r/5EsJ
 0aUzctjKzgDFkQOm1ShmXddIyqZOny2SMEJ42Q7953mOCcJ+DLYv3S07pVVFDhQ/WeHyLgkg0sp9
 D8HPK1oZOs5+1YXRnZWQ1S7mstpvApJHxzgUp0mnse5aPJaTbEJQTYphM2u4mJOw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH RESEND 1/3] config/riscv: detect V extension
Date: Thu, 29 May 2025 01:46:26 +0800
X-OQ-MSGID: <20250528174628.443993-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
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

