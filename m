Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C2C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 09:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384EB41140;
	Thu, 29 May 2025 11:56:16 +0200 (CEST)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com
 [203.205.221.190])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 34D8240156
 for <dev@dpdk.org>; Wed, 28 May 2025 19:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1748451649;
 bh=gZuath/qkKD9o/Anpg7yWB85iperEzQT0ytrAzc4tF8=;
 h=From:To:Cc:Subject:Date;
 b=YWCLAIggUK2jbDyr37hWbjKk02czZbFHc+syD5myZKENvYM79M5M8cUI+FnApKsoI
 MlvRDKTz5uXHK4r69/jP1kRDwUWyA+QhIE2ThhNF1whn9W+Mk3gZNUa0knz43powim
 JjWpdT30hJCnO75npCHDKkdynTfGJdvvdk6mwkik=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 30082A2; Thu, 29 May 2025 01:00:48 +0800
X-QQ-mid: xmsmtpt1748451648t3j7l909k
Message-ID: <tencent_87AB6A59A00D69168BCC09615D86BDF21C0A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeYEB8OhEnSUSD0pbxXilFcnP0Ge5S/zemNGBETjn/ULC3MtM/nm
 Qo3fhCEjheYLB83h0fklJOn1L9SvBpqxgW6DE1dJMTUSjziQPMzP3H1q9c8eRp4ht6mKUqQFBtgV
 ouSxfqu0Gh6kOh2lLd5OMcR1/RqKQ3Em8PSXvgYmlm8/347HqTu32GuhTTH7HQ/otlrYa/EOZIda
 mTvuA7O/oyPOZUKNfYZSBpDumxW8cOlNi/EuEU5n6U7M8drZGphlQBEP2a81/dXdOV1lTOdWSQDv
 sYRrkq6AtG53MfPT2EDO4JzN5YvK4U2h2msfpnwOKKe58BjOYVmeNLEQjevyblaTJzkL21XzZbzu
 ZYnbA7MvtYGGQmRTSL4kBgqdueFORbfeYsUFQZXo5kL8UkF9gvJhllMgwkIuD3T/7pPka8XU0MTQ
 ULVCvjMo5y1hz/BtY+a4xnIbsUlKUHNR3UfCxX7tE8ZKx6Ykpq6Kr2Pgtzg0ZZiDTKSQyI+uRM5B
 +ey+x9+PR6qB7GQvVi/62vy1aCWKQMEWLv/PXI86n7SNqInJsxSjcbgFH79kia8NTsPap4yot981
 WI/KR+wzU5ToiYbbdtFtkw8ou9mOCuPim6KlqyJCJwwFyxBuIh7ffQ0gOlPAkZiyrXNYEE80vfI7
 GkYE0LPLaIemJl/QPSVJSb+96bb7n91hTMtaRff4+c0iczz592JPPezRqOvVKUrypRHGRhuGcWsI
 0UrDMCSr3irQjeefYjFvJdhZqlX+JEJQIda22Sxa42f+2uX5110E97mR9cTuFzlGhduWNBmYih0H
 d9jWwaxX389MBENx2sMiIC2vG0m0uwmmkfWEoqT8/URmo204QPfbeFVnCnJGdku4QRiDL52vsU1q
 XB1NRr1plsJasAp3KC2+w+SqF9sXwMVeuruW0gNwYBtDw104l9A396Pke4FP2RRQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] riscv: override machine_args only when default
Date: Thu, 29 May 2025 01:00:46 +0800
X-OQ-MSGID: <20250528170047.233831-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 May 2025 11:56:11 +0200
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

