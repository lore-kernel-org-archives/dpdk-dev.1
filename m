Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED82BC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49F0642EA3;
	Tue, 22 Sep 2026 14:54:48 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 05A1B42E80;
 Tue, 22 Sep 2026 14:54:43 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081679t26c35ffd
X-QQ-Originating-IP: bKHwveX0dRDnV2rKUXpdZC47CpIX7iMLZAiHAJAovV4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8370515671534440839
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 07/16] net/txgbe: fix link speed display info for 10G mode
Date: Tue, 22 Sep 2026 20:37:40 +0800
Message-ID: <C84AB974FC7962BB+20260922125414.3638-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M4zpSD2yH9t0xI9edBxrckIr3cEhGqXYc53end7IbadKsMb34//qyGBD
 /3hYqBZWRGDcZcqYMg2jJ67zJAcTXddXr9tfM1qUbSM4vysMkUvPXjUWQy9k1OpbFOToWQR
 28c3BVqd3HljiINZ0BXDK8J00Y+HgkGrEb5mJ/g4tvE+Pjj13LLu5thDCKivbL69VNvrLU8
 161it0aMOkITyMER7k9rBpnyrq+pAAcTfvkKgrYe1FaU1VpkT6lXCpDXipT6b36IvavrAz0
 NGqfeqCj5AYW3ulIRtXeTqMUZ2QyfQYO41Z1CwFzu/ugLMYi+oig3dStUr9x9MacN3A6B+i
 zaDbc1O7xW0BP7/lxHbWsgmSRVzrWAwwaaKiAPnEPt3JKPKk4GiIs3JIDIIQVx8fb9Lb9aT
 XMC7lFqM7l/k77E6kyKakTOETzgGBe2qaThd8XCL04Lzb1t2rOS9/OR/u6wL0JsfDoTTDEJ
 jZGZCrx0lXhzexXofrJYWAzL88cNS+JgHOsh1/56SZaRG2sX8bSgCoxCmpP7YMHVTKo+VvG
 gbhGU1xnNne3ZQtJb6WtD5QuHCNkRbxeBVb7u+R9+T+6JjTKvV0u+N0YMJU9/1D86uhzohb
 OuGGGf//xagnZOgJ2ByChp6jWsN5zLVtKPQ8dkhAW6bc9OfBTU2LF9MB2ymV2iUE0LHw+vK
 cZgQ4OoK9XhIayJwQmgVI31B7CXYF0vkaIr9mAt2VRAKVzp7Ej5kXe0gMyGaH0ZWhOdyxHB
 mkw757TKKL8r/+PR/vFXCqgibWBZL/KHVxwm+UT80mw3jYuJM36sGwnY3pKFRtab0r5m7UG
 mk5CJKIOQrlwT7vaGB2Hf8BSrtVcV6Tlz69E3vr/gqRE8BL6X6seCHBLxDR86bm07xyM8fQ
 SzD7l8HPWSQZixPID2LA2sl5A6BYOkY2i3jP/wFJPe2GTdrp6evp6vqYEd0cotjABNzGGna
 aaVtglWdoWqfXo4iSUtp2lE9IqGSeF5FuYPXpiPW1dMATX/y4MHjbkIdvo+KFBv8rUme8Gg
 2fDc9FkiwB2VorKWtPd1kdbNDWQ3NHJHNZCOUqUDOqjqz1+r6Ub74rJ5aNqX43bZD4WuDNk
 mm0llIR35hCstESTRAX+feeU3zqsff+ilWV6+iaN2gu
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

When an AML40 port links up at 10G, DPDK reports the speed as 100M
instead of 10G. The 10G link status bit is not recognized in
txgbe_check_mac_link_aml40(), so any non-40G speed falls through to
the default case (UNKNOWN) which is then reported as 100M.

Add the 10G port status bit recognition, and include 10G in the
default advertised speed mask in txgbe_dev_start() so a 10G link is
reported with the correct speed.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 drivers/net/txgbe/txgbe_ethdev.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..d812adac69 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -85,6 +85,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
 	} else {
 		*speed = TXGBE_LINK_SPEED_UNKNOWN;
 	}
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index cb2a169da1..626015fae2 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1912,7 +1912,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
 		if (hw->mac.type == txgbe_mac_aml40) {
-			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			speed = TXGBE_LINK_SPEED_40GB_FULL |
+				TXGBE_LINK_SPEED_10GB_FULL;
 		} else  if (hw->mac.type == txgbe_mac_aml) {
 			speed = (TXGBE_LINK_SPEED_10GB_FULL |
 				 TXGBE_LINK_SPEED_25GB_FULL);
-- 
2.55.0.windows.2

