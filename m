Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6FCAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2FA84066D;
	Fri, 19 Sep 2025 18:36:11 +0200 (CEST)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 75BC44067D
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1758299762;
 bh=vcs9lDKqtiPVRbM2N828KwQziZv0W2BGmYfuvvT7Gv0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DS9i8ilymUt0I+NjLetzaHAxD2Jf/4032LDEXnsxrb6fhlwSnjMbzU+l5S3u7Yizy
 DjfYGPWkVYNfi6p4QB7L6reabx3k927T+O0/w44azU0zkxl6LxSAY5b9sJET5ubbfG
 98mGCZMAQrvs9nbim1WmUWQSvEGB0SMGztSZaFvg=
Received: from ar ([42.177.177.196])
 by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
 id 90129271; Sat, 20 Sep 2025 00:36:01 +0800
X-QQ-mid: xmsmtpt1758299761tu6d6923z
Message-ID: <tencent_4FCC0962D18471F1D0A98A5B700D2D153F0A@qq.com>
X-QQ-XMAILINFO: NaSpywN1vOX7Y0bKd3Ae4SBrp3GWk6mI9sXcro69j0odOhmFSZyPSGPbmDWjcp
 0vgFIybxUOtfWWeL+L4DXgDgBuGssTlfqOKzc2UaIXN6AZfHEhCCEMoi74rHGSbG8zkMV8sr4bsi
 Hhmz9Y1yN8bfGrjrpgig7PrK9jXRfPzreL8CfUoQ16DfCQxSNOzuSi9A+XAFGQfBJY5vr9S3aJHg
 96aeT6xYx3m6AIKZsevZzcYJq4cQmXHmACMPuXcbih6gLa6gdmJV+xU4A3UITR9rwNfo4yeAiIQv
 6AKKthYoAIQke/nhurePAv2RIxGlwcJeUi6g8zlgWBrShALoKfb/uLJxsav3B/6v7UkJHQ5YTk/0
 keDZMyh50o4SOB2nyrJbFKJtk3wswOngwC9rl1cw9d7f2ktG9/jiLFmMa88zP10Io5i7PJw/ehbi
 d4QfWP7ElkQsjeT1c6zNieDukVr9sHgTMMYDPow/Gcq0BDQsTotFgAFokIUuJYPIhizQPkld/1Fw
 I9sbcGqQlxZ5sL3B6NrTL7n4/qHJRiJ9U97AfeJH6RADO1fHx3QmMP4ytW6a7gHNEcsOAFQS4l31
 tqOD2S22MEa68THeoNM6D5CYz6zzu2DnAziwpHKPFCBQMop98mE5qVQNbDAjbz9E3OTgF+wEKrwg
 BMIzlHSHYrp/lqLm0lu6u13mtenOLq8v3IpukrLGuc5x7YhoMsPfVsbq+MKTpuzV80hSt9cc9iUx
 gZ70rf2Qc3qH6m3Bd6Ku0AesGaaDcKLZKPighRhLv3csnMTdUNbBF8u/OQsls4k1+mNST/kMap9O
 UYybfZv1NCWsVC0+ChUaVo1nKtl5GIymIG+9vGpCTiAkaq2oYxJcTvmcEHgQStzBxVY8BTLU4ed7
 DMixUAmT9UATCI0D0mt5X0vD/2RoW4v/f0w5H0BqdFZc5YmCld2X7t4w+mOvTEcaq9mFVDeSoMQY
 9e2pZLS9hzBda8jHNe2Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 4/4] riscv: override machine_args only when default
Date: Sat, 20 Sep 2025 00:33:57 +0800
X-OQ-MSGID: <20250919163358.2887335-5-uk7b@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919163358.2887335-1-uk7b@foxmail.com>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
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
2.51.0

