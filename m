Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B2CC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 291AD40647;
	Thu,  5 Jun 2025 12:59:23 +0200 (CEST)
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com
 [203.205.221.221])
 by mails.dpdk.org (Postfix) with UTF8SMTP id B142340281
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749121149;
 bh=MzAHjcG7REGz9u+AtnNeWbmlIEvneQePDxlwqJy0hi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dJR/IZhrK02Yi0C10+SSSWF52362K0l+xx0hoavEgBABL8ZPygzSo2As8WA1ETL3C
 hfG3M/HOTWQ7ATclwiFCaG7L7kt2+AX0L8i9nClmfQM4layS+eYqhzAMZkUUNYIpFQ
 tW9Gu7FKB1Y3ZE245miFOSlDp0ZRBk2LMDFhehJI=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id EC78BA37; Thu, 05 Jun 2025 18:59:07 +0800
X-QQ-mid: xmsmtpt1749121147t3uij4jr8
Message-ID: <tencent_0061818419F294AB7658400E45142FCC010A@qq.com>
X-QQ-XMAILINFO: OX7X6k/GjMLRAfxGcAiequa8ul8o9YP028f6c6bLHAeeRsAXdKUl0FM6Yz+H/T
 A9bsVjGqWnGu60mI7DscBxtQN7l1+v/dUK/k+iUZ52Y57Ll8U3Z98UvNNDTq5PvXZfUF4A+6V5x8
 rzejzlvQETFztwaVewgs/PF9n5WWr5AkqY/gJKmNciADqfK7KQFSzfeoov47ztgk5BA9q0VUFBuY
 aA9/HJCVSwg+6QSUJflyklAGFFrcIrUVUfdL8GuQpwdyGUoJXbbqM2+DFxl7yNIx0pyj1jln2mcE
 MZT/vdudQ21vgPK4JIu2LHE/97jqSd9aSLU4DvS0QLT8//GNdfhCypWQXFCMcVDTXdE9P7oBOiFm
 dSU8wcQ+Ed/Q6UCI1wem6wGT3MGTiOuk3rNn2MgEjzhy4okllxG8WGlpqQM73pKBhLAJCndHxrVj
 qkQPnTLqdbieaUtLc+ti5Lhh8uqgT8xr6nzH7FLqPoaEolyrl+Z1nOz5uiR14w+a7HhU3gDsKMzE
 FiK4c5odqpcJEuf2X8VFGfH/jU61RdmnRS4kAy3W8QmNKRyU0mPuVcMCxQTBCwK7Y8iqDZrGXzJN
 MIfsmXq88IwaKALjGWdtzZFwLgTvj7NPh+DZXoCriQEKVUW6ViSl3LOraaMrK1n7/jrNV0Kj/LuA
 d9yA5bW8JrT6kEeHylQbmHIfMtau0266DuHPZ56C0cB/YIEV2votgeqvVZv/gOlBTO33gPyfpEs9
 umOxCpQGNHmi59KuRdgmdq7AUGw7hOQzgNPPO1DzIc222tlJYc+sP7wZKBvpl3yxP+oGqFCHn7xE
 ci0Ypu68BUHZ4vaHCfjD+cmOGif1nAeBC4vr0+fkVc+3kQYfcDpXSN1MH9rLd+DzgEpJM2JuAMbQ
 Y+GaMPm372b451AP+DQQ9JKAwFU994YSth5qXZB91Wb1VSCEuZdugHPM8GkeUKUQkYP8f0DDnn6+
 Vqz3tSbgU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 3/3] riscv: override machine_args only when default
Date: Thu,  5 Jun 2025 18:58:43 +0800
X-OQ-MSGID: <20250605105844.3931758-4-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605105844.3931758-1-uk7b@foxmail.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <20250605105844.3931758-1-uk7b@foxmail.com>
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

