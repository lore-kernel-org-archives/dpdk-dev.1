Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20CEC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DD5E42DD9;
	Tue, 22 Sep 2026 14:54:36 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 8E29B42D76;
 Tue, 22 Sep 2026 14:54:31 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081669t544c1543
X-QQ-Originating-IP: uKLkJp33XtoVYKjdAnuubNfas0GvZ+vYxaLC8VRdoQo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15655251402342007908
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 03/16] net/txgbe: fix e56 PHY configuration error
Date: Tue, 22 Sep 2026 20:37:36 +0800
Message-ID: <D3FA6FB123192AA2+20260922125414.3638-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhRA+Wg7eZqsA8KmS7SmRr1zUKDe0svgWIFO+ZVv8ehHdrQDVz9VkABp
 N2r3bFAxe1kvrkxZnEL3blHQo4n43mG1ORkch1ABkO0nbRLQfWR/x1vW/nGwy5L8yXC5Kmm
 g2BaPbVwoclmDN9JFZrrjh1z1n7JcG1TSwHyM98SOCOFO2t9d3nisW4n2uoWtG+WKGd9Ecn
 XOPS9Nb/dkBkCpRqbw2fRPltXbwzBJlufS6932Pg6m0S2W/gVkIRwTagR3yIgCvyxfzTQbe
 XxdvEGV+5KjIMbZzHvFGJhbuQizJFWtnO0Tt9YVFj65lGo425o6f0aMDry+oTipse4X6FcX
 6/8D8hmbx4QS4vkONo4nz7HfrGZvKBDUaulPndkys7d9pEiL5bjSOg7QVkYL/n2ayvVaCWM
 R/86PMLHTYT+2lSuxudXvCN8iYM6RID5DN4CVKRaGQyTMkafFa6ISMHWCerIzFb4EElFaGb
 C3wL+9iEfQBEUg1iS//kU2M7fJoKxjx0/Ixia4aYQygpGHJGiuZ+8kx+IHKQ9ISlm5l4ZOl
 JgirJSzU8MqEi1nnKC+2I7sQpY6vkb1ZkY3VTo95MSnXJe2LKW9jaB+qsUSaouHZTJP2JNs
 Gs4ET3fwNmwCQ00oV+7dwkoEO7yj83tyi6qIsF87ICzfppvsvzElrJK/sYiFka9j07hhZSJ
 lv2p3bzsje3Ar+N/D07QR94kBDvvSpWZQ1lppu0Sto9S3OPor8nXD2CLFVtpTiPDDUUGF0b
 mIWG5++UvHHos1htEZl4gAupa3t0WK4H9LV40dtQuwgLDB3Nsl6uAeyy+3SQnp1S2Ketl0U
 a0Egb6UsR3SB/KQh6OTJqQXacuH8YqXwa0mlz0JEw49udzQsL82BDSsZ+3Oo7g1zMIn28By
 r16gzhj3DLhvYurE9t9/EXBwhfW+Z1X0GAzCgGK2x8cOV1RVm2Kf/EcEqKpCRaZIsdNVCZv
 mH2iCy5badXeMebLsII/TgxMCq93RnibCJg46qGVHgvCW1M8HF4rM2FDSgiOtj52GT/6tSH
 AQ4aQgwveejxHYasOZNQzpzHdVaMu8DdooGS3XVj5NDqVStZwfwLXbhgzyfTo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

The e56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..2711863f2c 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
-- 
2.55.0.windows.2

