Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4536DC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 621A942DE4;
	Wed,  4 Jun 2025 15:08:07 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 1F2D042DE9
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749042483;
 bh=gZuath/qkKD9o/Anpg7yWB85iperEzQT0ytrAzc4tF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X1ogYpyfX7FDmm3wyLaiPDm/qD7+WEd+/bhZIlxpJBK/2V44hr2IaS+oMqVZM4n9y
 /vqkqDluN45GRm6Sp/F+HxGcAQq2YTSmH7Ko7UMk51315tfXcsNH8O9gad6uVagjyt
 fub2YpPffs5m78DPj/wjnWQVxV1jiROVLCtSiYQo=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
 id 1F808003; Wed, 04 Jun 2025 21:07:56 +0800
X-QQ-mid: xmsmtpt1749042476tf0b0jev0
Message-ID: <tencent_B52A55B12D5087CE8A57E68AB148C2A47809@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJVBMWibhg2vXNmhyu+Qqo+1p05p2yiWY9+NUksi7nhhOfZGJjKw
 p8aPHFq237hfLbdRft8beS26Skvc+EjZ5c4gwPmzlAluYchrHEvt1BxD8Y5oXf/T/T+OdXX4m0Mm
 so8iNiWhaIey/INRlCaV+W1HThckIFDU4CJsjiJ7wChfR/ezVCMVTHQFvBxk11hGXXWmYBIgEsYg
 nSbpDeojAS0BNvVl45jvWoyRRqwzxIHCv0LZJnLcILHhFXu+CkLoxellk7k4zMjamPt4Fc3+5ifq
 TzDmXqZxXn4mj6ftxby378ip+wenFP18C7ErD6roEuBYtaI7tfqQ4Raew7Bk3ASCvmryRtKKewHl
 a9XLmcZXZ7LuvKWiWEi0S2L4M3q7gUQgOcDSpGtkq0ha86fOkNb98mnkkNwpPNY1wK72Xk2eR58Y
 WABGh1g0Ymrtszh+gC0qCNRDdHOD3tL3m0wVDkegdLQyfo/ATJly+z8P0VEOnPCtMjlC8kE3IyV0
 uzf2tU8FV+lTyz0oOeTxlp7t91m337/dBAQs5uJLBvGOKWrnixzqcUZQY3OY7nTQtQ6HsOkq3bvg
 KopXHKZ3Rbaqd4+NidHFy5dhcK7E5P8oUYQbyJLkUI8/6rHayttliAtU22BM+6UTqOsfXS3XDn0y
 gJLaU1FpTMQyx8mKa//mkQR8++occHKKAfKwUvqBhhyso4sgyWfUAwmhhXUnFAPny/QAh28xm3U1
 SXXoFsCqx0kGT+BTJ7k0hUjI5Cte8ZRpBFBKU1smVrFGp/3TnpgdZlMG77TIb1KuhSikOuSz0sPI
 V3ko/L8878AJSLl4Wcsxnvhjfzc5nte3EQA0o+tTpVc1bOGdO2mfL0pkGJMBcoW3bX9Pi5F4/PN1
 dNK6QlOkym4b4bjYVQRT+Em3s6UhtR8CK1uJ6N5GjvylHSA/HmQggHv81zDXAI9nd7ffWCt0fgRo
 LMq/oO+nP+a8JHp61Qxc/YBxg/B5a+r9/ZEGGHF9P+KBUO+b269xloUOh0jE41KqS+4kN18EcC3l
 ffGYnNkD/yHlj/1W3xA9mDSCr0hPI=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] riscv: override machine_args only when default
Date: Wed,  4 Jun 2025 21:07:54 +0800
X-OQ-MSGID: <20250604130754.2349592-1-uk7b@foxmail.com>
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

Support using -Dcpu_instruction_set=rv64gcv to enable V extension.

Signed-off-by: sunyuechi <sunyuechi@iscas.ac.cn>
---
 config/riscv/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index e3694cf2e6..1036a86d05 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -111,6 +111,7 @@ arch_config = arch_config[arch_id]
 # Concatenate flags respecting priorities.
 dpdk_flags = flags_common + vendor_config['flags'] + arch_config.get('flags', [])
 
+if (cpu_instruction_set == 'rv64gc')
 # apply supported machine args
 machine_args = [] # Clear previous machine args
 foreach flag: arch_config['machine_args']
@@ -118,6 +119,7 @@ foreach flag: arch_config['machine_args']
         machine_args += flag
     endif
 endforeach
+endif
 
 # check if we can do buildtime detection of extensions supported by the target
 riscv_extension_macros = false
-- 
2.49.0

