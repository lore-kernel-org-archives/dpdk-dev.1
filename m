Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE8CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:01:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECB5140DD3;
	Tue, 30 Sep 2025 12:00:44 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 403CA40DD3
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:41 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226437t1a969970
X-QQ-Originating-IP: 0j2NDZLTRfII6q+OmScSFVSPgbLSbwUHviBbWCTF8jc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6084070779899740307
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 08/20] net/txgbe: add hardware reset change for Amber-Lite
 NICs
Date: Tue, 30 Sep 2025 17:59:40 +0800
Message-Id: <20250930095953.18508-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NAEPl/HULyKMXKW4cX3KWwsnY4MFGYa83pdzVXl3G9uWE16pPsmpTuT7
 3DL8YBj7NG26ADGByy0o68qPXhJiiljl9Gn/MIajq5fJUlmUo6KGLf/u8UIU6GE1va/mAfS
 RukruLfiaKZsBFyMOC+/ae/qXGto5PPysoIzoBaAtSMrJJceg4LpSBInSOrhHci0Nl6nJi4
 QXPcOW0flkYRzOqQ5AUmwRzQMJ07ikvQDtQOg5KYL/2bz6LvNxi7tNNfWiLX3DurOAhLm9X
 eg81YFpnL+aUevtaMpR0U035xNqqb/bF0JcNYgST1oCM7IN/2pYHe2BXYh679zKn3KpvdGC
 Zy5XPxvHq1fS/TgsxFg9kKmmUxgcD6y0/lPSbDI6Qug7OOB3zBC7fkdjIwAHjFZERyd7H8i
 RGMyHGvY1Yjuvz1GBVtYiLriJydIVMsOgd4dwe2ayTgRqS9CbxxA9MYrsI9MYhJkppsh/WD
 S3olLwCJtnFGUmIGHuRi/42bblKuZNX601ZpZn7apIwIwgHWnbyv+arzhKoD1jbacUm+J5X
 /rPtrKt/Zynei/DgurNC9sikNmA7K6WC9rZb4zNyDZ5NJU1KQli36Dm/q1jStO21ySCGWQU
 13EJvZeB1kVKA5B8pNUdzSMxVOcO8rI/aGRVCWqt6Bt9gNGzx0htlfQmJpR5bGa2tJwbhWx
 qV7VyaBHSf8LN6hIqZZWKWYQT5eX/k/KrxtlIhqay59XKJMfc9jutUb0H+GiCYbu04KOWxr
 jhcCcz7R7UHbZ+7cxymYQKjlf9PSrcU3umVF1EG3AqcxiZNVQiQHrw8PcQ3Fj0GS2+ZaaAw
 079Vg+cnCAC4RNDBbo8B7PrLJ0BdRQZ4s6nP1c2kQa5fJzkIGt5oXlC3yek+ks9xXuVCaZw
 mFzHnecMsZGJgrlV+0oGozHTJg/hDSFOA612AN0AMv4CRqzrY2bsQ1hpCGnXnwY/2kPK51+
 dmFUFYSvbjufz64M1Sc5nSSEVSG44nYyNhJWIgCP/QPzXKNhny0TnjbQitBek61VvqBZ4wV
 9SsE5r4kwmSfrmDxiAUXjqQO3o6uv8T4Siu15jqKje27IwOGGsv6LCceuEPhFOwzAGByNk8
 wP28IvMpMQZYzwN2s+MJIIVzGaekZeRWA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Add necessary configurations for Amber-Lite's hardware reset
process, which differs from the 10G NIC's. These configurations
may be modified in future to accommodate further changes.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 64 +++++++++++++++++++++++------
 drivers/net/txgbe/base/txgbe_regs.h |  2 +
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index be8409c28e..1fcc2feb98 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -276,6 +276,8 @@ s32 txgbe_start_hw(struct txgbe_hw *hw)
 	/* Cache bit indicating need for crosstalk fix */
 	switch (hw->mac.type) {
 	case txgbe_mac_sp:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		hw->mac.get_device_caps(hw, &device_caps);
 		if (device_caps & TXGBE_DEVICE_CAPS_NO_CROSSTALK_WR)
 			hw->need_crosstalk_fix = false;
@@ -3507,13 +3509,37 @@ txgbe_reset_misc(struct txgbe_hw *hw)
 {
 	int i;
 	u32 value;
+	int err = 0;
+	u32 speed;
 
 	wr32(hw, TXGBE_ISBADDRL, hw->isb_dma & 0x00000000FFFFFFFF);
 	wr32(hw, TXGBE_ISBADDRH, hw->isb_dma >> 32);
 
-	value = rd32_epcs(hw, SR_XS_PCS_CTRL2);
-	if ((value & 0x3) != SR_PCS_CTRL2_TYPE_SEL_X)
-		hw->link_status = TXGBE_LINK_STATUS_NONE;
+	if (hw->mac.type == txgbe_mac_aml) {
+		if ((rd32(hw, TXGBE_EPHY_STAT) & TXGBE_EPHY_STAT_PPL_LOCK)
+						!= TXGBE_EPHY_STAT_PPL_LOCK) {
+			speed = TXGBE_LINK_SPEED_25GB_FULL
+			      | TXGBE_LINK_SPEED_10GB_FULL;
+			err = hw->mac.setup_link(hw, speed, false);
+			if (err) {
+				DEBUGOUT("setup phy failed");
+				return;
+			}
+		}
+	} else if (hw->mac.type == txgbe_mac_aml40) {
+		if (!(rd32(hw, TXGBE_EPHY_STAT) & TXGBE_EPHY_STAT_PPL_LOCK)) {
+			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			err = hw->mac.setup_link(hw, speed, false);
+			if (err) {
+				DEBUGOUT("setup phy failed");
+				return;
+			}
+		}
+	} else {
+		value = rd32_epcs(hw, SR_XS_PCS_CTRL2);
+		if ((value & 0x3) != SR_PCS_CTRL2_TYPE_SEL_X)
+			hw->link_status = TXGBE_LINK_STATUS_NONE;
+	}
 
 	/* receive packets that size > 2048 */
 	wr32m(hw, TXGBE_MACRXCFG,
@@ -3576,7 +3602,7 @@ txgbe_reset_misc(struct txgbe_hw *hw)
 s32 txgbe_reset_hw(struct txgbe_hw *hw)
 {
 	s32 status;
-	u32 autoc;
+	u32 autoc = 0;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	status = hw->mac.stop_hw(hw);
@@ -3638,16 +3664,28 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
 		goto mac_reset_top;
 	}
 
-	/*
-	 * Store the original AUTOC/AUTOC2 values if they have not been
-	 * stored off yet.  Otherwise restore the stored original
-	 * values since the reset operation sets back to defaults.
-	 */
-	if (!hw->mac.orig_link_settings_stored) {
-		hw->mac.orig_autoc = hw->mac.autoc_read(hw);
-		hw->mac.orig_link_settings_stored = true;
+	/* amlite TODO*/
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_LINKUP_FILTER, 30);
+		wr32m(hw, TXGBE_MAC_MISC_CTL, TXGBE_MAC_MISC_LINK_STS_MOD,
+			  TXGBE_LINK_BOTH_PCS_MAC);
+		/* amlite: bme */
+		wr32(hw, TXGBE_PX_PF_BME, TXGBE_PX_PF_BME_EN);
+		/* amlite: rdm_rsc_ctl_free_ctl set to 1 */
+		wr32m(hw, TXGBE_RDM_RSC_CTL, TXGBE_RDM_RSC_CTL_FREE_CTL,
+			  TXGBE_RDM_RSC_CTL_FREE_CTL);
 	} else {
-		hw->mac.orig_autoc = autoc;
+		/*
+		 * Store the original AUTOC/AUTOC2 values if they have not been
+		 * stored off yet.  Otherwise restore the stored original
+		 * values since the reset operation sets back to defaults.
+		 */
+		if (!hw->mac.orig_link_settings_stored) {
+			hw->mac.orig_autoc = hw->mac.autoc_read(hw);
+			hw->mac.orig_link_settings_stored = true;
+		} else {
+			hw->mac.orig_autoc = autoc;
+		}
 	}
 
 	if (hw->phy.ffe_set) {
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 93cc222339..5b730bf749 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1238,6 +1238,8 @@ enum txgbe_5tuple_protocol {
 			TXGBE_ICRMISC_LNKUP)
 #define TXGBE_ICSMISC                   0x000104
 #define TXGBE_IENMISC                   0x000108
+#define TXGBE_PX_PF_BME                 0x0004B8
+#define   TXGBE_PX_PF_BME_EN            MS(0, 0x1)
 #define TXGBE_IVARMISC                  0x0004FC
 #define   TXGBE_IVARMISC_VEC(v)         LS(v, 0, 0x7)
 #define   TXGBE_IVARMISC_VLD            MS(7, 0x1)
-- 
2.21.0.windows.1

