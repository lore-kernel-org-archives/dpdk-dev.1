Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C2AC7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 03:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7160C40667;
	Fri, 27 Jun 2025 05:59:04 +0200 (CEST)
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com
 [162.62.57.64])
 by mails.dpdk.org (Postfix) with UTF8SMTP id AD38D40267
 for <dev@dpdk.org>; Fri, 27 Jun 2025 05:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1750996734;
 bh=0GfACDHET/sYh4RweVmtl2pIUbdjtvyNJ0ESjd+2Hjc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vK6jiqzsTCxT/jhv+69yC10LSH7aBgasCIPKXCMXIsk1VcNsc2BBknpSoDCMFdkMq
 e57OqPkfac8ss2SHqbcB/5LMcycu7kR16Hhtq0wc/fPBru+yLZekVi3o3Zb/VtEeXs
 kOFWAmGKe89pVUvxVAlwX68uYLEzus9szFLRc94I=
Received: from localhost.localdomain ([113.231.69.199])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id EB4B381C; Fri, 27 Jun 2025 11:58:52 +0800
X-QQ-mid: xmsmtpt1750996732tgs79igo1
Message-ID: <tencent_4AC721AE62C5B9362CED30151E7A551D0B07@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLZb8sXEdKcawLVg0nfQPHW4YIESeUjLvfP7cIMTL6nSYhjTx/zR
 lENLTaXQ7K5EKt0hfL+UUC0HkKN2g4qceR/IoDbnqW83rEeksLf3HMqWYmLPEO/ouVUWkZumlpjr
 Hysf5PlTWwzzwyLj8qr39kDh7uSbm5AzROiXO4Qmu+bYwNu/68po0bSQUO0tPxTEhhl2mO2V2iqC
 4B+Cb+GqJTluZtdPYrhACyoYQ6Jne82l1WDBONQe0VwHcTu4TWe4DJpwFbiG+1hFMopC7G0Zq2eE
 gjke14BEV2iNywQkeC8BuDGPgU8m56e0br8NpVT94em12ZpUxx5ILtySLdtDHQvtdP1703/G2AqX
 6KL7/dLrKL52V0nYHvHvhg+3OHS21eckl98xODUDQKaTrj3unp9+LPjo1abVD2jgUrkYZ50WzEvm
 A4KWwhdXw+c2ZMA1zaqSL1XAoyDMjNH6EuPFJ+RthLmCrDd+CJXPy8jyUIwauhUvCIR70G+liV+O
 hWZot6uxBqHlMiYm8WY7M0M3yBookVhKIICONKXYZKkQc99H9WbkMpCGk9qN48f/HEUCsmQSdFlv
 neABueX2VOq1l1tusfGpYpwDLaJUuyFlFZpc4C8dxhynzpMESRkbNmmjmL+pUPXHTZiOcFxu/PNV
 uPg1TGgMy1+xKvJfvJLXGgxfIRxdE9ekyu7yjvsUmOv5jy1C0dSoHHdmKE+l886sVUgtUUq/y/Zl
 ARk9pdh5E0s8KLQwu0i5zPYqIQB9HhirRQJIdVUcryQfpwpBSAL81dYoMTd6eMkHM6jdeze6uUPb
 EKZvptJHLKWK/nzxcz+EA11WyFqiJiGYCysc43ybdxHCVBbAP7jG4Wy6AE5M6/f+PZ4talxLqR2p
 a0yajjF2Ehh6wgfR+Q62HCp7CqB2pp5hHcWv1BQMD1+owchumrGifV92w20PmSzapZ+9ZQJIyFlE
 7P5+KrWn7/D4GOLdL65h/9HDPIVQx1
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 3/3] riscv: override machine_args only when default
Date: Fri, 27 Jun 2025 11:58:14 +0800
X-OQ-MSGID: <20250627035814.670775-4-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627035814.670775-1-uk7b@foxmail.com>
References: <tencent_6985C4D07FF1CB5C3AD652182E4F9DAA9906@qq.com>
 <20250627035814.670775-1-uk7b@foxmail.com>
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
2.49.0

