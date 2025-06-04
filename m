Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E1FC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A5D342E82;
	Wed,  4 Jun 2025 17:47:47 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 95BE042E81
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749052052;
 bh=gZuath/qkKD9o/Anpg7yWB85iperEzQT0ytrAzc4tF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mhsG/8T9wABPxCeVnFPfbHWQEmQ1k6MrExDk+v+mUuq0ZKMiJ7zfTild6G0NlZSpV
 NiFBUUOZJL3pb6a92ryERlvER5xmpx6wfCOyuScfDDIyuWfMgciNqNdjJ8qAk0mUOQ
 RNLORTOGCscfLRYOIIucqYmhndvZDEHTkVULHtcg=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id BDF3AAC2; Wed, 04 Jun 2025 23:47:31 +0800
X-QQ-mid: xmsmtpt1749052051tpzm5065z
Message-ID: <tencent_4361083CE4AA3E16A1430DC533739958AC08@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GY1M4ahXNh+HMUT3h2TtWGUAPvZ5I6jzV5BueX0P2mjzLDSNvjz
 mywlm0JaXrUHdGw2ZLnToFjnV44phCJdjwDZgFTJq+EwL9eOzkMQVdST+MdhR0imAkqq1rjkyHfg
 vzaw1FHhAu+XCWo2JvMKx+p7Zlz7/aEOjBmpz3WgqHpU37RtnI2IC7m/5b8F11Dfc8NMBusZ0FxT
 PL6bs+65n17maM4f5h0TbaB/Szh4M8+9KesKQeG21I13qUmmZpVk3pbR25lcIs2uyW1s7OQkjNoy
 KXtuXcw8/UmGMQsbqzdUV/XLy6PLvZR48ViClvJgLdYL/aBvxGHZTEnTEjJgScG0Y1gNQI2l3/lj
 YngMpT64J2yk/xENOsqQCFteR6DfK+7XQHUgp9IoZ+DnnoSDiHDqoTCXIKDUGSYw4e3nrjgjJGy6
 cJFOc8qBj90PsdArn3Cddn3AxjKt40FHBPu5FkuYkPPFMppb1KSJUrQg+76FzwnfM727ghm1bo/a
 0TZ5HTlwXfFxOUvBxVrwQGhRWzGdi8OWwGlE9M4lIoHtOLwy6LiegyCHfzLVpB2huzgwQDgfhgxh
 PSMr+v3ULuv0GS4TnQ79hEsdO2Hv+U7OVILa/KvKK7ec3aGT59K0EhkRdJ8vZ7sHAhlLBlwOI9U8
 r1ipYBnLtZhsW2dYtTzRDFPkEN+nAWMw9eJT5T8Ld16OIPAbfyXm+5mJPCPR+h87UNUuk5gFX9MM
 vqjLFlaSB1UoX1etKxtujMw07Ex0ojv13dSXDvif5YNi2jnemvnN8qbj/90jiSNKfSq+66mEOr+s
 0n8iaSI1Q+/8DCaqi6pVcVbV5VY1o2SLkJqtBEdnHZcIiwd1SOot9+aSO5j2xpyjE5XX9VzU3zTa
 nXSWd2ajsfQfEpsBI4SwazGKiroJ6as/xpCZJVPihfkbCmnR2v2esemeNYycv3nH+e8SYfHk86J3
 bdgpqatwxdRhHvlMKfXUCB3YBptboa1WeQvDb/mcMhO/OMMAclIzXoDuqa5V5Fi9j+8lTnEvphkn
 alEE0QrX2Wy053tirQ6l/3Xh9e4Pb21OC1Bq6iGQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/3] riscv: override machine_args only when default
Date: Wed,  4 Jun 2025 23:47:20 +0800
X-OQ-MSGID: <20250604154720.3078131-4-uk7b@foxmail.com>
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

