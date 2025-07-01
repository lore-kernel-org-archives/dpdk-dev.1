Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1522CC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 16:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8BA3406B4;
	Tue,  1 Jul 2025 18:15:13 +0200 (CEST)
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com
 [203.205.221.245])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 987BB4068E
 for <dev@dpdk.org>; Tue,  1 Jul 2025 18:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751386505;
 bh=R9YiQUrq7lqtMfMgJmkGutu+Up3Sx/ZcWXIwvPE8vSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ST1gO3LXnoWg+H4Qu4wumXdAWxgyrYg1mmqeVe8PBQURPDrVs20h45+Tiz1IU+3+N
 gN4UT2DbUdYU2Dbc6+QW66q+cwbix3PaDsIWDoLX7ulHB3nwJ4ZUx2xh6DKkUAGKbC
 xJzmejes1Z/6AEIm0P0aSU8kUfLxUze7NUx0RPeM=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 3C394636; Wed, 02 Jul 2025 00:15:03 +0800
X-QQ-mid: xmsmtpt1751386503ter13e5h0
Message-ID: <tencent_BB4AC51B7378583861673C5BAAF816C04308@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9RGb6f3grdUi96W41jRKXF83fRZA2O6okXmyu4UG5PnOZHGozqT
 K61PcnfjrIjjqME1Bd8eydvU14nFGJNVIO8iR+2HkEv/NBytgbCfZJY3wxc2gZiyYHzEw+MYGHBD
 h86ykekhUjkQggrbWNHJwBOElPHdsH0Z9MUo5vbGNaEztyUz+IKHH58G9R8EFvKNHU3/zpakNvFE
 S7taJfiLJf2GANa307AdNylx942zW1ZdW3OQDpYNL3tUuENm4LvfZwMnKxdmBmtAoBlxqzzKzuFu
 6lctf1wSSPELTkgG/dh5z1kX30XNtxXXlNFeWbRvBEDk0UysMGJFxqyKR3COjzQFRbvw58nTs/88
 q+KYS577gg0Uc86lDEys3WCmtQTipfQPIEqt7VWn9dRjA8zMiD82SYBA+U9pogs0vvCeKYoIXAg4
 meJdtmPdfldZyJG8Jl5S7za6YEVJAhGND1HTmVzn48fpvRdM6Fet9kxF0Yr4fJ/A+O4TebyjGtKm
 3XhWtZ54izqKoatmMBJ3wnhbDaWZXJgvX74c2T4lHoMUFencu1K9MWKL2KyvLT9HEVE411bd5b+Y
 2A2ROl11MjSN8BuQ6j63+sPLO/tP6cGiDTsYliUsNJ3AJj96IsLVQ3ypSUVL4ICzKeN/Q8SZYzcK
 07JNMwxuhrSFNuJwrXJ2MKdOMMGybuOnZcZ9x2hwWEhVvTRVZdh438RK1WOMIBICJ2OG3LmtgUVe
 1oWFr86Fc2TZcFzVD17mUCeOWO0EJvJCgv7uyJrGY4M6ASv+QT5ALe2WFHaY1FZsXx3ogvX2eLlb
 6APvpjZz5GH6SoSUz6N4Fc1Vlfp9+vH6EWvEi5Ghw1d/YEkywhBlzsRZzMfqWT1OZA4Y/ROljMCP
 GrhLP+F4RMW1kD4TZWMQHkpRA5+plP9FcJuMgLpJOW8VJhaE2tHKIqvK2nyN+rjSlk1QYmU36H
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 5/5] riscv: override machine_args only when default
Date: Wed,  2 Jul 2025 00:13:42 +0800
X-OQ-MSGID: <20250701161342.46750-6-uk7b@foxmail.com>
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

Support using -Dcpu_instruction_set=rv64gcv to enable V extension.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 config/riscv/meson.build | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index e3694cf2e6..f93ea3e145 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -111,13 +111,15 @@ arch_config = arch_config[arch_id]
 # Concatenate flags respecting priorities.
 dpdk_flags = flags_common + vendor_config['flags'] + arch_config.get('flags', [])
 
-# apply supported machine args
-machine_args = [] # Clear previous machine args
-foreach flag: arch_config['machine_args']
-    if cc.has_argument(flag)
-        machine_args += flag
-    endif
-endforeach
+if (cpu_instruction_set == 'rv64gc')
+    # apply supported machine args
+    machine_args = [] # Clear previous machine args
+    foreach flag: arch_config['machine_args']
+        if cc.has_argument(flag)
+            machine_args += flag
+        endif
+    endforeach
+endif
 
 # check if we can do buildtime detection of extensions supported by the target
 riscv_extension_macros = false
-- 
2.50.0

