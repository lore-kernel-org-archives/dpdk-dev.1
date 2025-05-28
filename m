Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22011C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 17:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A5DF40E54;
	Wed, 28 May 2025 19:47:42 +0200 (CEST)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com
 [203.205.221.235])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 1985D40667
 for <dev@dpdk.org>; Wed, 28 May 2025 19:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1748454453;
 bh=gZuath/qkKD9o/Anpg7yWB85iperEzQT0ytrAzc4tF8=;
 h=From:To:Cc:Subject:Date;
 b=MCmPm5xqEIYmtSU3/OqKM/Q0EmsQl89uMkXDfTzNqa/+0SH7wUxb+RbEhC2FQoumM
 hBTC72uOmJnJ+wOeh9Wh3+cIIaiX62Dcd8/cSiu+rAZs48ePu2MaSCyQ3XZG4b0TOK
 Th+YKLCND8pQFbG6bzkSzi2YljUYaXkk8gun0alg=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id BDFB6052; Thu, 29 May 2025 01:47:31 +0800
X-QQ-mid: xmsmtpt1748454451tjoa6o0go
Message-ID: <tencent_5BBC98646E19EB34CC8D474BB5D462602805@qq.com>
X-QQ-XMAILINFO: Ma5SRgm1i5sbzMWaiycp6CGLfjFv3u/3QRbhHWB8k9FGdfQ/362qlWlLstb3mk
 GH1YOjV377hLowYP/JYJ9AA2ARHP83rTv3fEO2Q/IsEoSWSoQpvDr22fT6IIocdWaLVP1sFEpLEj
 cpMaFU6F+RdIpOpUaHxiGL50GHe5ibBCgsh3AF/K+8z8mNXUvhL+3SX2CyrhxUnQTP7xUmwyjq6i
 W9cULkgCK+k1o2AndkFzR/9ZKCLOrVLb4KYAe6IIwVePED3EQtJk32wRhcmZP9UbWYIiAdD3ncPy
 QYO+Xs99EKIrAnDHEb9RSE/uIjOI/uWQzb/AUeYNgPUAY8gb+zsgqy0P0vrNGBb+yP+7q+9oSrJS
 zL8dBTa+nr8FL923hUaZtTYC9M3tTadxsAhI6u6nt6qUHEW6YJIulbPRVDc1bFcO11xs7qmjGa8A
 hdeu2chgfXtQ5Ial56aRMRmPDyPUAPbACp9LTUese+Zsfy1oCrDfdEyUL4Lm3zKxWVHqd1wnvL4H
 rhwdQW1FbyLHlH2XuezxXzmOsGuBwFIItaHDCTmkyqbJewyPjPn5SiSAM/bxKVYHKfpm67gdzZZE
 hkkOn1Tln+WQRDmbujmE/CJV77NIYdJ5l4GSHG8yCntDKDwsr1iFjSsoGHN6Wba2uDT+sjYZWrhz
 2k3ZYhhtId20tEbBgi1MUgbDAamY3dHfDRgYHugPLus9b3cYzRMrKIg0hlbEDurxPXCXi/H+6Hv5
 uSV1hbb/2z3kw6PfPWTef4CKCB5TNdThR/lapPu0kZSpzEL1wiAXZdklknwZraCIkwkUIlHvWpxp
 VTEhe7qax3UGYXhzEW2b5ncOGsRNqDLoJKwM9Nm5hwo3o2+f72MzdlPJXQajwBXbmIUGry8APbtH
 d19I9IAv7ozFiDRdw7+IWlfz7HGYUFvKx0FHhY9V77ELFUd8273XWCcCk89o9WxA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH RESEND 3/3] riscv: override machine_args only when default
Date: Thu, 29 May 2025 01:47:30 +0800
X-OQ-MSGID: <20250528174730.448918-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
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

