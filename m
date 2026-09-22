Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6CEC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC17E42E60;
	Tue, 22 Sep 2026 14:54:39 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 35A7B42DE9;
 Tue, 22 Sep 2026 14:54:36 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081674ta902d22a
X-QQ-Originating-IP: 9qW8oIulwsjIg7g7l6M+64ZTJhDuKdD1B2SGnYW29dA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3927290261138542324
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 05/16] net/txgbe: do not force reconfig on link retry
Date: Tue, 22 Sep 2026 20:37:38 +0800
Message-ID: <0A49801F89403AC7+20260922125414.3638-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N2dNga98lfCaHioxUk+B2mn9iriqAG+lPLq9Mnz5JLOz1TS5dxae65jH
 evV9h1h8R5aS3zKsSdFp1ZC51nKRJHpLQN4W6b1MJZV/HCgn8ajceGIaBxLCkXYVR820NAa
 oyAAl/EP6HLIuha7x5IUnLag3m4EYgIFSqUDsuM0UDO8YjFU1aKUqxhAraWvGG+t55oAeQO
 T6rSoQdAwfQc6b3ur4/HwXDfqsZMJNhfTctOSHWIfL7x9VtiiIc3OmbDs9FQgqhb5KSc8zV
 PLhDkJlRJCPJMmjNQ4QL/G17ZN9k+vIKLajNiLwXfRaUrskOzhVRvlajmgDTY18lIrZH8cI
 qdttnmKWIl0Hn1qxkmL0gYbaiDVIC42JNKJEyDT3LsujpdTWIUI/DdSBWn8jTEP2oBAvY1U
 XC6TNhZbmFGJVV7CeU60i/sl3MgSOUz4Ho72IcllP4XoXXZZUR5KvsAXON6FlvgVjrGVLbN
 91F5h0r3STU3VC9Q9+9nFxBN13wCoyuZeLEK/FnJR7hLIZLHTQ0R2S1NBH0juOF+JKixhNL
 FYEF7MHeSxWJZTtdJLZ/iidVf+Ta0AQfnVOpPHWzOMqwsp9iR0eoCpdLP1gNXAm39BYJNQ6
 OA8KvEd687a7PuaWaqogpfn3XOsYx+MD6W/yRm5cglRgtb75Ql6tPmRHsB7jbIjRl5FKIAh
 y3ayRxiD4Lg71uH4OnIDV73BX0IadXgZu4nramYCcTeAG4DKlnU2w1yKNYpFpxVL6HvuiCm
 /MyChEk+imRl7eGWPZq+3nwMIKV2GetmSy3hZOjGFYH+/0JitGluL2wK5LhJRmNuc6jBPyU
 0vndUHOlnTo/iUY4QoyYs6MGxU7XOgZLU4141eU7p+Ge/ZBYz1fEXgkrZvXKnyGDb7p7ueq
 4k/IFJbCxghRI6l5qrcOLr6CBJCE1i5tDVMmKLB928r2Qc2SJjBf+bkfbXEZs5NdpXQFDhM
 Wo5zboiI+b3rWlKcCk65SWzPKE6GXtfpoiCcjRn1uKykEEMOkLOoBCEMIxIU6YKGMUX+7cH
 hTMlRo1PHyhurtbFao/bmvMj3CXRmYnOO5xv83srY8QEPW1OONzj2gF5ac3D2Gq0p/fYbgZ
 /KzHkFSUykdMOOLFTJ2KXs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

The link alarm retry calls mac.setup_link() with
autoneg_wait_to_complete = true. On the AN73/xpcs path, setup_link
skips reconfiguration when the link is already up and AN is done
only if the flag is false. With true, a retry that arrives after the
link is up still runs set_phy_link_mode() and resets the established
AN73 link, which then drops and never recovers (e.g. after DAC
hot-plug).

Pass false from the retry path instead.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 69c94992ae..cb2a169da1 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3302,7 +3302,7 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 		return;
 	}
 
-	hw->mac.setup_link(hw, speed, true);
+	hw->mac.setup_link(hw, speed, false);
 
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
-- 
2.55.0.windows.2

