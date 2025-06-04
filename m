Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B5CC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D675A42D96;
	Wed,  4 Jun 2025 13:49:28 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id B491442D90
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749037764;
 bh=9jPVAJsdveFmvEIskdyTPeqaobb0rO9QjEji692N5jY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nRolcmudRySFa+uWbE6x4p97fZpj/9P+W5qPC7AQbKB5+MpiZlwqw4gPBXBmML84g
 XSFwsgUG+Cg12yu/v9RkLgwWvnPpGUVuJe9iJzoq4a0a+ppY6StPM7PamoXtML8yGs
 xCM+AxNjR6VKqD1nlsowW+8lqx0OfvzMCXleuEqk=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id C51980C4; Wed, 04 Jun 2025 19:49:17 +0800
X-QQ-mid: xmsmtpt1749037757thcl3ykiv
Message-ID: <tencent_530B1E13D57A8BD821C26287B971ACE9B007@qq.com>
X-QQ-XMAILINFO: MWzGDmnScki3O1/G4UOXEzcqPVli4zVNWjPmZxxiF81Ghm/9RYn3/dWvrP/q00
 EJVahz2KPP1lCEal0UQLOZyD66egh5T+7M12Bz/EVGrLEkDJ8cx0LcxGgncYbzZDmd8F+xSEcu2S
 0q3m9dN3MkhqsbFO8zxalKWNfd10xhkXeSgLyVp4IjaYBikTExZjXfERzAbP3lmCKC5zq178fzEZ
 dAbswjOmQPUVr0v82DvXSswcD1L97a80VdUGsuxCl/uvx8iIDGb5nA/3GyNFb4K2ZQNPsgL5eJuK
 KKntxje7G4TM2LP1o0WKI+iLag+7wYpBsuy2U1g7oFNoItz75RAonHWPnaBFf0/wYVmeq8WVbBZ0
 ZjQIsqoULP3SBsuTkceRlo3UJsqhHXYViMil0au6+SJqjDAr17njZtZqM2e81sKi0SRAiABELttI
 GnWDOjlvzQ7Cs/EOdY6v1zQ7iJkZv9AVttMyhVbAtbNN9LSRmNHRoYcK7/26zntjn0i7B8Srd6x3
 +0+Q7lQl94oYMR8PkO/oaH8WKlV+pFS/WSCJoJu6fl+10JqjIU3etPHXtsGHZ/0EmHTxyMbBVNvl
 W1id7SXSGp/d1eMEOz/Cz88BI4z3Y/a0gNtjgu+GyGVTRmcMos85eGH/k364PtVd6QIZIuLYK9GF
 G3+yssbL2t8JjaYGY7vziH3T5NYEoQaGKCEpxX+W7Sv6+DA4GPEENNxrIeRd5UE/17QZr7t+wvYF
 Ezg2CpJI0CKTtJXDAiABxDqIhzzXwmZKo0wn94db0oojHx994RCtQ/ssEQCpyly5+fYSKA4DpVm/
 Le+OJXZjhStnPUq1DrQhgL206tbv+fy93VCJq7zZISNDv4Sma323MPIX/8khZe3ohFZBGX3gJdQI
 kMQk/h+le7dRVDTp+DpJX1nBmYTFkrSXkwyD36lkanj/jXs1c1RcYhjEl99yMgNNBEzkRRYfzjNP
 wGJ9Qjb+HZQcAozgvWEDmEPgmy8lIQcayX2yLFkL5QN9eMTkHZdNErwUbj+IAeEASiGiq4pZiL+e
 NSSp2vsELRg++pSJmPHdkPKnSxEdU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/3] config/riscv: detect V extension
Date: Wed,  4 Jun 2025 19:49:16 +0800
X-OQ-MSGID: <20250604114916.1947929-1-uk7b@foxmail.com>
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

