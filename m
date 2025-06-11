Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F0C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 15:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 432AD40A76;
	Wed, 11 Jun 2025 17:00:34 +0200 (CEST)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 by mails.dpdk.org (Postfix) with UTF8SMTP id E040540B94
 for <dev@dpdk.org>; Wed, 11 Jun 2025 17:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749654021;
 bh=MzAHjcG7REGz9u+AtnNeWbmlIEvneQePDxlwqJy0hi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eN229ndY8bvr9DtQmN1BHc14eVeARa3OUNQW5pGDh+Zr9U3+clK1SQwr2tDUqhgto
 /2EqI8DmOfAG24tx2294GxP9n4cZC13gtonaE65szRyULOk79fGdQkbzJ606C64dzV
 9zoQGSVah/oLLiggL9grTy6i5FEXcDfC33qz5N1E=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 14322FF; Wed, 11 Jun 2025 23:00:20 +0800
X-QQ-mid: xmsmtpt1749654020t41g0dyb7
Message-ID: <tencent_A06B260C88274A75C9E26748A3F8612E1005@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJFd2NolyoOg/pn1OZeGbBwRweESUY4l/Lr2YZCz4WhXPwtZnput
 AflSirwLETRWJfXk63WI/OsDTU7LzPm2eDmZL5fAhfp9RXQVRLTflFvtf4UR34c0uat9W044c1Z1
 uFD/geagwyBQ25V+BXpKKGNC+aebwQ47BpVMqWqdYQg11rbWXDHke5i1wp0tqskOhYpT4RTVQCZ4
 jXcDavI1LI5+ad0ngbMYyJnoe8wTYxI43k+Tfod8uXqQUy3aMPg1NwkK2+tfTyxj41t7Xs8VMXlO
 7ee1TCGJGHdsHgnULP8h4dMuW2gZuEYmq2f4aw+afIcB53PbgBKih+zSM2NPbGQh1wAcef/L0ZPL
 rzfk93ezqD3AgvnNJGyC0EbErHh/lfVu3yNutqPahflOPfxruYha0BqkcXfTpwafQLXOjOvzIArE
 VTzUQuKgaEmrl1UwY3+qeTa1lhrSqg+o5i4ESP8nUDhpeX+PyX3jo3G84ykBpf5ySKilISnoMwYi
 ZR7/xS3Jp6qQNAnl6sN5HxP88c0SyzHJ1+4MMnWjgnP74VP6pvZVGaYvMWoKLvR8uPueuKly+PW/
 Cf4dCq8l5NMYQOX12/S8LmgLCu9i5drntMrYAhZJHCTAG78oQAd0dVZnjPQmJkeuf9v59vWeeDdV
 wRRaoXV4kfkzx4g6BAbHD7tUfsDDi5ps+PVMoD2VchLW9LvAyZPIMVn0eik4vn8XMB+ZFEORshQV
 iUhfq5fKHR6ntv7ROP2aSvFU4WuPdgazFVMbdBv1apAG1+9cLFB/JEH+c2gQ6kHPNwpQ7E+JBKSF
 uDRZbNQuUGdiq/IZLSP4wMW++Boi/jX/9qvLO1vrItVmUrnziMOeTrggsIXoKMpkVkUgb7m60o42
 U5DjjlLT+NyKjalk3Z/Q8PB7Nw9R71cTGd8EX4EKr4w7EAaBXRt8pWCPiuJ4xCc7W//bIqz73u4/
 xkE6TnCmfitOwpU16HKg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 3/3] riscv: override machine_args only when default
Date: Wed, 11 Jun 2025 22:59:14 +0800
X-OQ-MSGID: <20250611145915.854026-4-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145915.854026-1-uk7b@foxmail.com>
References: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
 <20250611145915.854026-1-uk7b@foxmail.com>
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

