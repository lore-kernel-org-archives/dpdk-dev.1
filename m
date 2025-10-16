Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586FCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFA50427C0;
	Thu, 16 Oct 2025 13:20:07 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 1E346427D8
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:20:04 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613599tead01c22
X-QQ-Originating-IP: iV9JG+ogMH0vaVDyQPAtqCbKmoASu7fYTjaV+hdu+p8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8868640379839855084
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 17/21] net/txgbe: add support for getting PHY ID
Date: Thu, 16 Oct 2025 19:17:31 +0800
Message-Id: <20251016111736.25372-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NoaupJ8ahyDy5b/j3B/KF+Gopv6u2VMn0J/K6CZZsWbyCfVit2lWeUm0
 g+yW1SphR7ax8SigIMlNOGJQpkrmfK/x4IjyQ44Yhb3P2kPWvZptBH26MSQD0GGLTLZ5DfZ
 4cp+7QWyG8nstPVUyNumS3XBEbFWwmvxVIKh7Buy3zgSqKNNwpoB2zU7HoQNDgJqenRTOb6
 iMrmgJGmN48E0rZJGpHQhCRII+QAOXRP4Jposf8bKW322ReLL1j0UgCHGtE4rjVamMrD2Cg
 6sdu7xTRCuFdhgYOY40wWU8wjLo2wVMhpnfyiSUqdKCeIUxvxJTzkYR3uH0R9104BP2sdC2
 tcozO0q4gExd1N4HYiG+ZpVMxZYeydFU0phLPDhkzue7A+cxIdqynC1C7+ecjE+BTCV+QDo
 YipYxVfl+wR/dAiZ2UCZIcygr43i9TJwL9xjakJVW5wWsXDo9mmOyq/I1AEkpY9b1HxSjbT
 OloVNKQcVrl4W7nwNc+48zOWYffqE09SXpt6zb4ufRQXuZBCTM77mMhpl1IZLFmoJlDiacL
 hCq9HP1wtAyOQ5A9COM32EUdUqLet+HEjY3bq0Pm17jUpkiS1unpGTGonEj/YSxP+D4x6Kg
 WuwvDULHUchTQa0LqBW88FCGhsCchoei31BSLq15DjUPEueSj59qAoGLnqPq+OylTXJPDkc
 Deig+NT4qnKhK73dOQgRyftm14NuSS20Yj9/tj8mt/sZk2eU3UlRLUfjQx77xNZXV0cExdr
 hoPR9gqarBUCxOSwj50Xj7zawM/0/8gdDtZ/z9rEwLDV+mngvCiOanLpWI4gyz+XwkLxqIh
 yN6MI025YjE6oSO+g2lnXZNhtE7PqEmVVBrKBdy5nzrTjG7b6/DFRNOtLUSMEznozGD91Aj
 70pxMHr3JHatzH6wQSLJJRFAiW+0NBzUjtywzzR729dIbSYGNZ1RNsIVGdcavauTTn/RJSh
 9PWwlvBQVZfIOFeCp3f9J3mEREf5uaULcH8nMZhiSrHIGX8RrSB7Z8l7wVNAuLEtzzO8c36
 o0+IAI7PwIe6mVIjjlyexCa+ylJvvueTpyTe2jCkZMFkFbTyBCDZv2fivC1nzTIkUaEg2PQ
 3Uv38FjlglIE4FFBZdkj7o=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Add PHY ID reading functionality for Amber-Lite NICs.
Due to hardware design differences, the process for obtaining the
PHY ID on Amber-Lite NICs differs from Sapphire NICs and requires
additional delay handling.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_phy.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 81e9aee295..bf7260a295 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -173,6 +173,41 @@ s32 txgbe_get_phy_id(struct txgbe_hw *hw)
 	u32 err;
 	u16 phy_id_high = 0;
 	u16 phy_id_low = 0;
+	u32 i = 0;
+	u32 status;
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		hw->phy.addr = 0;
+
+		for (i = 0; i < 32; i++) {
+			hw->phy.addr = i;
+			status = txgbe_read_phy_reg_mdi(hw, TXGBE_MD_PHY_ID_HIGH, 0, &phy_id_high);
+			if (status) {
+				DEBUGOUT("txgbe_read_phy_reg_mdi failed 1");
+				return status;
+			}
+			DEBUGOUT("%d: phy_id_high 0x%x", i, phy_id_high);
+			if ((phy_id_high & 0xFFFF) == 0x0141)
+				break;
+		}
+
+		if (i == 32) {
+			DEBUGOUT("txgbe_read_phy_reg_mdi failed");
+			return TXGBE_ERR_PHY;
+		}
+
+		status = txgbe_read_phy_reg_mdi(hw, TXGBE_MD_PHY_ID_LOW, 0, &phy_id_low);
+		if (status) {
+			DEBUGOUT("txgbe_read_phy_reg_mdi failed 2");
+			return status;
+		}
+		hw->phy.id = (u32)(phy_id_high & 0xFFFF) << 6;
+		hw->phy.id |= (u32)((phy_id_low & 0xFC00) >> 10);
+
+		DEBUGOUT("phy_id 0x%x", hw->phy.id);
+
+		return status;
+	}
 
 	err = hw->phy.read_reg(hw, TXGBE_MD_PHY_ID_HIGH,
 				      TXGBE_MD_DEV_PMA_PMD,
-- 
2.21.0.windows.1

