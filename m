Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29632CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 05:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12DBB402A2;
	Fri, 22 May 2026 07:00:39 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 159944029F
 for <dev@dpdk.org>; Fri, 22 May 2026 07:00:36 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1309f4ee97fso7889156c88.1
 for <dev@dpdk.org>; Thu, 21 May 2026 22:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779426036;
 x=1780030836; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTcF4GJX4ij2Tkzo5rFIjPHzlroZHl4Zshi6SQhxt5Y=;
 b=BFTturaEpxdGht6MbIRjcGXnraEwn/OohguTOoKdr3xd+hNkU9Tvkz/BMB2rljGaXi
 ZXLQ3bk4+58PatiCrkoOrHnorqLQy9zbsyrD2PAAB7JtO9T4wn7mzZsi4fi/AK2qgbEF
 WjERbmzTFVvJUrxvO06EE/pctI/rmHUATbtS12U55EwpOBiAkbJzFsxMecBQGYEtNVSI
 b1lRdkZXHThlmDAZH+liUu8ldMnGVI/et3ln0yYZH1NYLme6FuqeH4I8x26C7WMY/zsC
 ZqTHUNygmVbCLV6OJqaV+TRDleBvDkXavfkKPF9XSJiC7oedwIj87TmD5NKv2C2Sl0C6
 geGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779426036; x=1780030836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTcF4GJX4ij2Tkzo5rFIjPHzlroZHl4Zshi6SQhxt5Y=;
 b=fn8u1gsAdMNuGAbtWKUtKPvLCQJaSHwd95OSxG4jLzIAI8H22QSyjorD+gTsXckZ2X
 OriIUn/3FAsSS8PEqE5fp44IEHoBnKgiasI+nja2qLGxZJ4cV8lxLDpb5FFof3t1Djc4
 UMwiy6a0OG58URc77jASFpLhxW3XjlcGquZgAeXmRtc9V2uWgK9IytDOnVJAcJw5aQWD
 EfkaMzON+Q3x+b9KaybqkH/yMII5qyWs1/0w3rCyQH0VO8JcFiMFlQ6We5TQmw+Fia3X
 J6hmhjIgyGZ2OHjnGjF4hVIP+j/1ihT51/2W9FyByn6K4L5pWq5ouPf1sl3okk0G8zGI
 rKRw==
X-Gm-Message-State: AOJu0YwzSIb7aeSquDgtN0BhKf0uSt2eGKP8WQrj9MxVrMykI0yFa8QE
 wCs3ipcCkibSk9MTKzOGWgJna7omA2Ifi2c0L16+uAKMl9Tz8u+ZhkJy5DavSp3Pkn7ieyACCoJ
 XO6eO
X-Gm-Gg: Acq92OHDFf/ySOhi9TfwGWzIy79FlL+u9qno423hsirt4z1TBN9Wmjjyt7S0jrUxag0
 Np26Df/GOugbr0xUa//5bJBVFOBfPD8n/YID+2iUW22L7Da5D7UO/+hkX2xADMhcTJlKb9WKyxc
 m/mBAb+rX0ulxpid40ue6xjjR2OSTzTxlkrqJjmqcP7J0f2x5XjI2W9D8daE5TEBRBCcetL2UVo
 uWQGCaBbmi2gBoS4B67xnykw9Q4uCuWPPpzPIIm+S+osvKh9iPFsLKF/wIOPLVikujuMaVVMmr2
 sx9E3RKEs9X4NQXwjsggJGalkrU5yz9OpldW8c+4J3yGRkhRIgr9WZmmbqSs1I2MVsafeIEzaZi
 YYemaXw6N2FJ69yExARJG/tkRKNK8lxK4c4lLwMbwL5SxAUJJaT0aVbIq6F01bjmD7DIKsjVvl2
 TByjHh4NgwT4ck3ZfFlvWDbiF+/vdnhrIMb5T9F8RKkb1OaaJwb7AanCT38Qml1w==
X-Received: by 2002:a05:7022:ec8c:b0:12a:72af:83d2 with SMTP id
 a92af1059eb24-1365f718082mr770847c88.14.1779426035680; 
 Thu, 21 May 2026 22:00:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a40187fsm535429c88.5.2026.05.21.22.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:00:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH] net/txgbe: fix AML mailbox lock acquisition
Date: Thu, 21 May 2026 22:00:32 -0700
Message-ID: <20260522050032.1354427-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The try-lock spin loop in txgbe_host_interface_command_aml() has
the condition inverted. rte_atomic32_test_and_set returns non-zero
on successful acquisition (0 -> 1), zero when the lock was already
held. Walk through the two cases:

  swfw_busy was 0 (free): test_and_set returns 1, sets to 1, loop
  body runs and sleeps 1ms. Next iteration finds 1, returns 0, loop
  exits. Lock held, after an unnecessary 1ms sleep.

  swfw_busy was 1 (busy): test_and_set returns 0, loop exits
  immediately. The caller proceeds without holding the lock,
  racing with the in-flight host interface command.

Invert the condition so the loop spins while the lock remains held
and exits only when acquisition succeeds, matching the intent of
the surrounding timeout machinery.

Fixes: 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/base/txgbe_mng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index a1974820b6..dcd8f58a68 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -185,7 +185,7 @@ txgbe_host_interface_command_aml(struct txgbe_hw *hw, u32 *buffer,
 	}
 
 	/* try to get lock */
-	while (rte_atomic32_test_and_set(&hw->swfw_busy)) {
+	while (rte_atomic32_test_and_set(&hw->swfw_busy) == 0) {
 		timeout--;
 		if (!timeout)
 			return TXGBE_ERR_TIMEOUT;
-- 
2.53.0

