Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACCC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 18:21:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E72A840698;
	Tue,  1 Jul 2025 20:21:02 +0200 (CEST)
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com
 [203.205.221.242])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 91C6640684
 for <dev@dpdk.org>; Tue,  1 Jul 2025 20:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751394049;
 bh=R9YiQUrq7lqtMfMgJmkGutu+Up3Sx/ZcWXIwvPE8vSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=t5tc7Z781d/fltwnI2VJ4Q5Rmgbf9aom1s5LJ0iU95n3hx+i4tBOQWybdFxNG/xpi
 4h4a9NpBoCgm3OvFIWc95qmtFPGM2neq09kEePyZB92BSqYaJW/fd75+eMk842NmYl
 WRk8VKOUCDzh0mhLdLXkN2UMx90oDle7P6LW1YpU=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 52FAC8C8; Wed, 02 Jul 2025 02:20:47 +0800
X-QQ-mid: xmsmtpt1751394047tsld2h8cf
Message-ID: <tencent_C36C8B675AB5C9C26B48AD986FEE0FCB2905@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuS/e4Q7hjUgt7YUI/F+8mmdhqvzsRhZ5mZ364j4sl3Kq7q81y/N
 842LkXu3mvR1qmWOJX0pqkj5EgwpdhgZT1Dt0zibGGBK0l0ASoYXfRTYlOPGQcacWracsHabTTwn
 Ts+rd1ovwGWRjMKn7AgzI1QaYiKEKDZ8mDWrESixIh+wvF6DhoanA94NLAnO+fzUpRIAlPis7gOU
 4b+PlcZn5zyz7taMndoIBtNAb9g3wePOlp0Ic2jJuDpS01K8kK41HEj29vR6aNhyEUfLvQ3vSwin
 fx6jD2LSDrqFvpcOyZhlOpVL7kuPHan1Goll+zi3tOAjPcd+d71qINtZq0vudkm10O2ODPGzRrmB
 sQWBHcgRA71LcfYgrL+FzWFroFz69U4pDb/b5Wol7WCoSTm7ZBPsijxp1CW3kBnBhqeeUnHPPXt8
 sWnoAbxz7ZAfd+gaD49Hr3JBw/9w4ofZpihcY0hpnSQeJllGqZJjO0zADiVOs4RVu5JWCdOa0fz/
 rGe1eWxTeXmFTlH0c4WFiVK+e3YjAWoEfRyNujKAItSkBTFaXYPfOxDW2VwLoDFuw/8UojkeixRo
 62jHx8KKGEQBFy3mmp17hheAYLwKx7jrA8RxnlhoXbQRFZxI3hBh08T7zlX8tkr6M7kQb1cymY/3
 DEVXeNXw+l3rzUA6xKm2SpbncS6ARuhxDexZy6KJ1F7i+gDKWbfaeCSvqU2eqoX7S6otT3wmgMCa
 aT0vsQ4/6ZAFVhRiIpqF26oqM15HkdYDrJcJXMzbZkHvpTqgw5oF+QsZb1mK3B0jxe3vYEsidrPG
 x7OAajnygUfBkoQaBFfPim1bv79kZnhw99OLAajEmL7Yspj0VAipdlQLwDHIuxJvgpWHzRxSocJF
 mhvW6pgQZq3QRk+ia7EEzkbcCymFaNcySHt8LLr8ioPtrswLP6quVye4zKJb79Bp2e6cduM7jyvJ
 uA2TblGAfllImLNia4JhUB8b5FFY49
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 5/5] riscv: override machine_args only when default
Date: Wed,  2 Jul 2025 02:20:33 +0800
X-OQ-MSGID: <20250701182033.642384-6-uk7b@foxmail.com>
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

