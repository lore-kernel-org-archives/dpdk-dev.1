Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2288C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E7DF402D8;
	Wed,  4 Jun 2025 13:33:47 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 5EAFF4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749036812;
 bh=9jPVAJsdveFmvEIskdyTPeqaobb0rO9QjEji692N5jY=;
 h=From:To:Cc:Subject:Date;
 b=VU1ueqq1fTq/vDndibOfmZU1xtszTxSuNRMHU4ROC1tkBVOV4FU8AlTmiAvIhf4tM
 u9+CWwLccRSBKwDm/phnSZzI82NAD7lgEEYBEvc5JLzf1JXHdh3ghw1g60t+Lii4OE
 DGjhW+r+75ZnW+DGAjz6kuYzXjMv5DXYc/MKpB8E=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
 id 85EB5E68; Wed, 04 Jun 2025 19:33:30 +0800
X-QQ-mid: xmsmtpt1749036810tyg493qzr
Message-ID: <tencent_6E62CE174B272C9BE749D5C8A279C8A9F805@qq.com>
X-QQ-XMAILINFO: MEaKDlY90mahxgrRvPvLB8545zLE70dFxfPn9nhPpY7HIs9hVC4XWPMrQYAuz8
 a3zM0YGlE7K7qK9wNSz8f1DF2vUlALl3jqXBeCS+qtfz6bP4mu1lsXi7I4fxtxLmjcvrUbKlgqiP
 YQ0jVGqc5iIlcOVAkX37Dwmu42UpQ7EhdQiaqUuiyh3FWR9NSYBtobkromJbUgJLJ7E2UdFe44c0
 BeHsSExEXvQaHb+F9mTf9PloqETXPVurirQzJGS3LUTtO4Yj5UUCcUTMprIhVPUmVozZ/US3z6NL
 BZX3CfchyRuOv9fhR2qvJza1JgFyKKXPUumnqRS0H487DjyEvgwqRmvmp41JjAdjyTJwerzfgdHS
 nW00jILS4x7girJDXNZ3gATYCUV/WspRGZZXV0OJWIyPfKR1t6R4dB19USRzc//E4j5uFYCY6oeF
 9horIbSCouQDpJijz2SGXcvmk7be2u2LD0Ba/3jf7WU4cmLQ6CSemc153fS4l0KAsK6Wh82rXL+H
 AH+C1BTX2zCjS99ZosaUtDP7wJBVuO0jqIdmvWoIv2n0WdNjj3YrpSczhUhCCbE81le6FDal5b+k
 rMwCc+SvWshCsLbcC8up016pvQvsRnmfnqap2lMdi4wUnn+lyP6JMsofHCSohJzzzf75h+yjhUW6
 yMgfRsv6b8sEKFbxYrJaT3IVAkr2iluuaYP0NPvviJ8pn0DC8A+4jIiUyabAEheLNmX4SB73902C
 EyqM7ED5y9ztic6j8oEenmY0/Tahtc/a/oyzhJWfKodoTYlibQYJt3EN19okVRmLi65Y/iw+d7dz
 He2vlQavTabAu6QMZ+fwWIiWSbJlGrssb0wh8/WLwrzyN5J5Gz3s/RvZ+vNevarXh97BYSx+lOHn
 epUQWGsQm5zBHVCk+2ac9r//TmLKZpOSHaog2QxTw7qUQ9BGhgF8dmteHf8OdbSbZbnzmgsFDdc1
 zIuX8HefmvW0TJc3C7u7UHu5EGT1qbE3RvCjWL8Cm9RCKQAn7nsA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/3] config/riscv: detect V extension
Date: Wed,  4 Jun 2025 19:33:11 +0800
X-OQ-MSGID: <20250604113311.1874526-1-uk7b@foxmail.com>
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

