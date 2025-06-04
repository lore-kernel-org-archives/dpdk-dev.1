Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A564C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:47:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B07642E70;
	Wed,  4 Jun 2025 17:47:44 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 7CEFE42E78
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749052049;
 bh=9jPVAJsdveFmvEIskdyTPeqaobb0rO9QjEji692N5jY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Enil/mcZDyqqUJofLh37wIdUqb2NMiG/0WQ+2Qb1IU4UkDCufRfcybcqrJOySwMYg
 HIZRtkb4PFUoprCmM/Mh6k47YA1viOBxq31063lh3OMiaRoO9uZ6ZCQrykYP4SiLy5
 vKhBjND8XoCYuFnxaWZBUydBHHDXKI5At5GJu+Bs=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id BDC0EADA; Wed, 04 Jun 2025 23:47:28 +0800
X-QQ-mid: xmsmtpt1749052048tc75jqmjw
Message-ID: <tencent_82B9B0241E45553F0BE421E062BF39332C07@qq.com>
X-QQ-XMAILINFO: MyIG+pWbYkory4kIyLrCv2F1WcrROCcOS2lRjDSZGe5uOZE3raqt9tdIbMWwed
 vuhr44yHnNaYwsfIuxKsL7AJS92m6allHSdVRVEEtEYLqBvCuKX2YMdtDM9uxgvUJPawxTYOyqB9
 tmIK2usgY9DnxOJb0PZ88QvGMJvguztcKRLa1+eP3r56ZY393QOr3rg4/yAmeC+FEPFgKaOV8epx
 yvpQO1dZjCekqitZ6T+ndkEwLWlZFuyNpAJMFMVks7wpdCK3N6IQdienhaYjwyesZToN6DMjxo6+
 IKF1JwODkLpWaYE9x97IKSM3R5itrVUhQ1M4OKXjuezJ5oMuSoOXhdauS2Dppamk/VL2rWIR8D6s
 eBAl17b60EcTykrjs25HxnzhYb1ML69BYq526ZNYDjE3ELR3RO+8ynRPZ+tZFBPgI9xXwZWDSHHZ
 BK5Q9p7XRnHpXY+N/+mpTVyh3VO/ZcWJaC/Ouqyr04qGJcdP6DEzGfgkNeKI0h7NYAHv1o78GTS9
 HU13pjPtEZcKn6TcPiNxUC0Gnej/CvlGqv68+poPdiSlFp81Ctur/T1k2NzH2iM+mgdEXtxnRG+A
 DH+StYNidOLk456HtP2n5MC/OfRATy7Mobk1s6Bp6iInQkG/ss6JyIG6hL5d3GY3lpU4EHuQD3Uq
 eountevtG42zSz9yU2yHO1O/RNDCYLzfDiMCAbUhmyfNWBy+EMCII/2Af/NHUxA8zwjqlPS8vwe/
 /JTTBVWzBvpUT4+oifaGemsfnqPW/hArZgvjQUr8Aju3lXBGxDC49nuzWKq6v9aCpsLGgWiR4pTS
 Skk3MA1HYcutPsMfGhPPEC8UqIJCDbMdeZyn4bZnlLSa31KPxCsZ6wb1k4BWCErZ0Ss6IUTCO0kU
 Sz3AmDgcjfsB9Tkvs7b64AvL1yjAQopBeLDg4wG6Dc/uDTNYIMJq8HmIpXhb6zl7IS3JFSY8nEf3
 y7IdVWlFtdZfIs1sXJYbRR3g+vVlIj5aERQeTxh/eqSdrh4OMvG6MUH+t8Peio1vWq4YF93mqRzx
 jEorco2lhoWp7K7Orn
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/3] config/riscv: detect V extension
Date: Wed,  4 Jun 2025 23:47:18 +0800
X-OQ-MSGID: <20250604154720.3078131-2-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604154720.3078131-1-uk7b@foxmail.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <20250604154720.3078131-1-uk7b@foxmail.com>
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

