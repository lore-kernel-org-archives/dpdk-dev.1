Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6C606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:28:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111F340BA4;
	Mon, 26 Oct 2026 13:27:26 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTPS id 1BDC9402E4;
 Mon, 26 Oct 2026 13:27:20 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017635tfe05f2ac
X-QQ-Originating-IP: W3Mus8tCrWO7cWZRL6t2sE3LJXBuWa2Xb/4T58hgzyg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:27:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 204007424121327904
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 13/17] net/txgbe: fix Tx laser left on at AML40 link down
Date: Mon, 26 Oct 2026 20:21:59 +0800
Message-ID: <31B46DA23071699A+20261026122638.9198-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N01WXI1BAfzIolliU7ajtj5PZW8cKnVKliEzHOwyZlZ9vCZ8R8DN8jov
 SBCWMV7iWNLyKC/ecg6lJ7zFvhjrmt/ixoxGCvO3z45ZWCpMv9FX2dsrfrq9bHwoeHcD9MV
 mpqxkdvUTI/SvsEkBZt2d0M6AEGKtUR431WvkF1iRV6/grBtoJVgJox6Y2pwHEOKsYslZhB
 YMf7fILPCdDmbhrOzD6ZJ9IwJl7qnrj8Rc+YCldb/My7s1bp5vp5CFIjpIOl930j3d1OfFF
 2bgwlt0FJLVoHJzPQTqypKm+7Q5sXcFjBWW4BKI16YVO56Q3VVWff380l0VHiIq2vZNDusz
 pFAf8OxqM8Ob3iDgtDXaUU4kdl402WvNP/W52GSmJdgm7wYL5aMKVZBZ6QXo3LHBtC8y7fj
 TyJSS2QLEqBmZa6vF0fYU7kfTdL7uIWNUfJZUDseNjlaTsBLXGf4uQMEeFKiRf9GtkAJKJc
 GAznBeQLRGMjT4cCR3i7VuVMHLxrCrKevCIUrndRMWi8ae+hUpLhiKi1HMMFvGmg6Q8d/Ig
 QaD37D/9MVM8lhZcv8GeUJ93AwKnxwd0uZxqMOQ/yhxpPYv0oqiPBCmlfhDohsmrCxwHcNT
 rgJsbANTv62Ls6AMGuchjCZDnzz0ytGw+LmkH9UeHyhJ6R+mRV9q82FJsIq+OhMb/kodaDQ
 dsIfnKq+FkhiLDzuSXYcpuEpiVfPCUEL1rcZpPvxXSTCV+hsOKDZ0vVBLfO5XFgiZ9WPoEJ
 YwrL1yQl7v8T8U1lus+0HH4slaLDKgKL3OUDHNxfoJkprjrXFrHOrqOqMoUAxiwVhytqyHS
 7FeGNLA8ukgea3vvX1e2tN5Md/C69+QC/zgvYwvwvAOTkIM/cfg+2uNRuR5f21a7aNaN8ZH
 bBuElrqYdH7rtlOUBoiR4A12sk6sjYBEKhnANEIbb9HGMeIyYVdWHk9edkNUJl3kgUNNBr7
 KuEXxfVyq7ISzCNRt3kp/FmCbwtSreKu0VRMw2FtJeNTkK1L33XwDU7t04FlRRnfggus1SB
 iM3GsMY5bnPRlNGAqxKwTiyWIy8nHMzBvkhzbs4OGvYhG/m7c/fhlkrrJTb7nQyXldfYIoc
 VdfGQBwNd51gBjF7p1fbEo=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

txgbe_disable_tx_laser_multispeed_fiber() brings the laser down by
driving GPIO bit 1, which holds the SFP module in reset. Some DAC
cables and QSFP modules keep sending after that, so the port reports
link down while the peer still sees a live signal and cannot detect the
loss of signal.

Clear the PMD_CFG0 transmit and receive enables for DAC cables, and
write the SFF-8636 Tx disable bit for QSFP modules. The SFF-8636
register is only written while the management semaphore is held, and
the acquire_swfw_sync() result is checked so a failed acquire does not
release a semaphore that is not held.

Re-enabling the transmitter alone does not restore what link-down
disabled for DAC, so run the normal link setup again when the link
comes up. The setup is not gated on the current module classification
because the module may have changed while the port was down.

That setup resets the PHY, and restarts the AN73 negotiation when
auto-negotiation is enabled. That is the cost of bringing the link back
up.

The SFF-8636 Tx disable byte keeps its value while the module stays
powered, so link-up clears it for any module present, including one
left disabled by a previous run.

Fixes: e30e5fba32c4 ("net/txgbe: support Tx laser enable/disable for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c  | 31 ++++++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_phy.h |  6 ++++++
 drivers/net/txgbe/txgbe_ethdev.c   | 17 ++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 2650b8b7f1..eb032eea63 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,7 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_e56.h"
 #include "txgbe_aml.h"
 #include "txgbe_aml40.h"
 
@@ -3259,6 +3260,28 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg &= ~TXGBE_GPIOBIT_1;
+		if (txgbe_is_dac_cable(hw) ||
+		    hw->phy.sfp_type == txgbe_sfp_type_unknown ||
+		    hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+			u32 rdata = 0;
+
+			rte_spinlock_lock(&hw->phy_lock);
+			rdata = rd32_ephy(hw, PMD_CFG0);
+			set_fields_e56(&rdata,
+				       E56PHY_PMD_CFG_0_RX_EN_CFG,
+				       0x0);
+			set_fields_e56(&rdata, 15, 12, 0x0);
+			set_fields_e56(&rdata, 1, 1, 0x0);
+			wr32_ephy(hw, PMD_CFG0, rdata);
+			rte_spinlock_unlock(&hw->phy_lock);
+		} else if (hw->mac.acquire_swfw_sync(hw,
+						    TXGBE_MNGSEM_SWPHY) == 0) {
+			hw->phy.write_i2c_eeprom(hw,
+				TXGBE_SFF_8636_TX_DISABLE,
+				TXGBE_SFF_8636_TX_DISABLE_ALL_LANES);
+			hw->mac.release_swfw_sync(hw,
+						TXGBE_MNGSEM_SWPHY);
+		}
 	} else if (hw->mac.type == txgbe_mac_aml) {
 		esdp_reg |= TXGBE_GPIOBIT_1;
 	} else {
@@ -3288,6 +3311,14 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg |= TXGBE_GPIOBIT_1;
+		if (!txgbe_is_dac_cable(hw) &&
+		    hw->phy.sfp_type != txgbe_sfp_type_unknown &&
+		    hw->phy.sfp_type != txgbe_sfp_type_not_present &&
+		    hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) == 0) {
+			hw->phy.write_i2c_eeprom(hw,
+				TXGBE_SFF_8636_TX_DISABLE, 0x0);
+			hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+		}
 	} else {
 		esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
 	}
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index a5df015a4d..a06c0eb04e 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -251,6 +251,12 @@
 #define TXGBE_SFF_VENDOR_OUI_BYTE1	0x26
 #define TXGBE_SFF_VENDOR_OUI_BYTE2	0x27
 #define TXGBE_SFF_1GBE_COMP_CODES	0x06
+
+/* SFF-8636 PMD Tx disable register (byte 0x56); bit per lane,
+ * 0xF disables the transmitter on all four lanes.
+ */
+#define TXGBE_SFF_8636_TX_DISABLE		0x56
+#define TXGBE_SFF_8636_TX_DISABLE_ALL_LANES	0x0F
 #define TXGBE_SFF_10GBE_COMP_CODES	0x03
 #define TXGBE_SFF_25GBE_COMP_CODES	0x24
 #define TXGBE_SFF_COPPER_LENGTH		0x12
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0e95643239..9d3e1e4416 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2206,6 +2206,9 @@ static int
 txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	bool autoneg = false;
+	u32 speed;
+	int err;
 
 	if (hw->phy.media_type == txgbe_media_type_copper) {
 		/* Turn on the copper */
@@ -2213,6 +2216,20 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 	} else {
 		/* Turn on the laser */
 		hw->mac.enable_tx_laser(hw);
+
+		if (hw->mac.type == txgbe_mac_aml40) {
+			speed = hw->phy.autoneg_advertised;
+			if (speed == 0) {
+				err = hw->mac.get_link_capabilities(hw, &speed, &autoneg);
+				if (err != 0)
+					return -EIO;
+			}
+
+			err = hw->mac.setup_link(hw, speed, true);
+			if (err != 0)
+				return -EIO;
+		}
+
 		hw->dev_start = true;
 		txgbe_dev_link_update(dev, 0);
 	}
-- 
2.55.0.windows.2

