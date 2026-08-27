Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7315C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:43:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E4E3402D3;
	Thu, 27 Aug 2026 13:43:38 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id CF52F4003C;
 Thu, 27 Aug 2026 13:43:34 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831010tf878ef1c
X-QQ-Originating-IP: oFWDCrlDrfInv854jtwKGk1LchLjV0lMBwk1MVWNwug=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11527852105635374087
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 01/13] net/txgbe: fix e56 PHY configuration error
Date: Thu, 27 Aug 2026 19:41:53 +0800
Message-ID: <2FAF7515193BCF22+20260827114309.10530-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NU60Kbs86PFjSjS6RSfDgnW2F8EYORRZRZCZQkj4F7Vi/YgfczKt8kT5
 KuSbA2JVn6z0Ppc1V5qsHLY0DD+cs9uI5j9Pthc5G7pCDweG3EoZ9aNR0InwAT+gzO6wb48
 Rhf3CReH6vssA9GFZV5dRhC79BcKsAUJh6D32uemTZDBxb6QeUbxBz2vm0K+p19PS+A+woH
 xmY+hQhuW7CJ+Yhr9WXsOE+PI2WCUeCCyimlPxzXt0b7k6NUBQS5+ekw9AgbvLeRoEGBmHT
 ydlbZNhDUzu9DUw2WC29EV4tIsrPDGbPkz0x9zcSgI46M4rHl0DPB1jmS8+Fb4BA7fXXLKD
 Y0ekmQqw9dUlHhlZMtaFgo2FA1A74hyFBtD1GVfWIKSZaGA+7MEZKIN5WJ+OLBVorlrBXp1
 h5GucWmxG4v5Op6OEnoNIpeEtjRmwff61ss03+o6vXjNcCT1PpQK1X55UY8TOcRV86DQAxA
 n7zL6HlBG4BUmWIawS7RKpU8WvV+TZFoEyZagKfeFyQVhxUWDt8YQlDLIO2l7PGpTFNnI07
 8EtTMcUqiSlgEjCq/GbTjPE9PpVHRmpoHxp4EtUeWByuOOWQZ4h83+vjikaCE/rbGfc1lNB
 0wdJIu0ONKUSWjRRhqj0WypzQiRr4QOlFQDLBuHS8SrJLhNL/O1oGE7FhnB1y/NLKXoys1+
 GHoyL7mHxDbWRkR8X/ABdMC43Q7sMIMK0uuUxXIqNirGjfHb0nHYdZC/nAhGwSq3erCQKTI
 MQUSBJ3Hzv/+iRf1mZYGJaLOOFORI+edzkxn3JyW0x0lE3llo5Cj9NveQgqDpq5g61y64ol
 W+qBL7IfOF/PF7lRu3SJRZUFRJunDBNlacz6o4jPb7ohCMPlQMofPNBW92v66cYvall74TR
 epZ9N9BMBSfgbvreVYurnsP1rTw03+ZqQ+MXQD9uXysfIlavt972MMEJyAR528fAD4HktoM
 nyQ1uhvEkcMy7sRlTC/DfFzlqx4S7fnIRXxDsDHVMwVQ2zd7pjKojzt3RIVwYoaoasnW16u
 qStgKNU+E5MgEVtgABchC7iddGDY7H4Uc/Xkc1rCBtJWiBeucExMMYYIMtHE7sY2ZaNz6az
 kJHZ4IMtt0j
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

