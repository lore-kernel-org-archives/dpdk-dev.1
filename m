Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58487CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2FD40A84;
	Tue, 30 Sep 2025 12:00:39 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 4751F40A75
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:35 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226430t1ab6a14f
X-QQ-Originating-IP: NDRFMYRO6Vuydm3pWrw+mG4RmcyfSTSDTaHVb+zg1oc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16241656349860973096
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 06/20] net/txgbe: add support for PHY configuration via
 SW-FW mailbox
Date: Tue, 30 Sep 2025 17:59:38 +0800
Message-Id: <20250930095953.18508-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NOIkHYnr7VzdF5DodGZMKE1vAG+f1ugkoJDcD2MUXk8c848iGJiWDwE2
 SCsRpLfOzdd6J5ycg1U+uJzPOiN9FgJy19IJEPTKlVBU+O4Y3At9OXvIP2b50/Pc2V5w9dM
 ONe3P98ahofWGhWaA7EaQCnLywMYDXdI1COQGkbqUyT9Mnz+kcgJz4SCrFLgN5dvuOYoaB1
 KqTzcBgncY3BtamUuL5IlrZQkiD5+iBXjVD0zZFMvNUKUYnX0OCgeaCtXCtv36ohZFN/4xe
 fYBdnQyg6UJcwahz9K2qSdF5Dbhn4jW2ABj7H3TcMmH6TBTAw6NPkI3nNgoeU0V0kdgsAvw
 YVuCf1wkPPZ/YQvp0uDwST/z1EJE33gsdw/hN73IqKsFxV4muh1TdpO2SGKS6MLGl7B7bkx
 NNsZVkpUImR3J/GY1tAnbE2IXwB347maM7QChck1hvrMh2sZV6MhoD+SCMBiDtN7ct2toSh
 pHinK6Tqtr69/tFvQHU2dhVxUxzqakGS6vKLieVzORk9++yneQbF74SsB0YvfDp7OfoiWWd
 TqG+YP3bdFd4lnPxTquSu7a2K17tTy3GZPJoIBjHXWQdVcYq+wIONwfJxb8DMM2tOpCkaou
 oJ9nl2mJEsl6+NlnHFaSbVTUStpcb7DFwgV9XsPkP5a6oWCDrvSBkEoNvEvYDZ2l0hMVLVg
 opCyjpV5JKL7sJMNfLkZ7VXpUVluHrn6Z90AwqiGneJQzx0noitBkJ63ptKSNv818BRzis5
 kQUEaJ3BoqfGIERNuAsD2Tn77WwQ3AYsUSynhjhFlPNw82eBLhvHyoVJ5hk38fFc2jZfOHH
 f0xm6xsm7c4odr7O8+Si010GX9vmFQoSatLWUq7RFj5aaW482NsAnDDbQqfXCitsYLtsGOd
 Ti7nLsKXUSQVaEGab/88nZCgdKzcinIJIZOqtmhazsuFmEdhPSo8CbM8VwOTEWPyACQBzvN
 enmU+MW8/jNnlKfVDoIC7/mPwNlDBKeiyWR7Pm53hBBrsr4zlqOn2xoXdOcX3/UnaScbwpA
 FGfacu++iATI2ndxlea6BIaZmBwn6EZG6y4cLvbeRwemaHn5C//ZAjeLM89uY=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Migrate Amber-Lite PHY configuration to firmware due to complexity.
Driver now sends mailbox commands for link state changes, handled
by firmware’s intricate PHY setup process

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 37 ++++++++++++++++++++++++++--
 drivers/net/txgbe/base/txgbe_aml40.c | 37 +++++++++++++++++++++++++++-
 drivers/net/txgbe/base/txgbe_hw.c    |  1 +
 drivers/net/txgbe/base/txgbe_mng.c   | 36 +++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_mng.h   | 17 +++++++++++++
 drivers/net/txgbe/base/txgbe_type.h  |  7 ++++++
 6 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index b172622ac7..bf63975a15 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -131,6 +131,26 @@ u32 txgbe_get_media_type_aml(struct txgbe_hw *hw)
 	return media_type;
 }
 
+static void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed)
+{
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
+	int cnt = 0;
+	int i;
+
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL)
+		cnt = 4;
+	else
+		cnt = 1;
+
+	for (i = 0; i < (4 * cnt); i++) {
+		hw->mac.check_link(hw, &link_speed, &link_up, false);
+		if (link_up)
+			break;
+		msleep(250);
+	}
+}
+
 s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
 			       u32 speed,
 			       bool autoneg_wait_to_complete)
@@ -142,8 +162,6 @@ s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
 	u32 value = 0;
 
-	UNREFERENCED_PARAMETER(autoneg_wait_to_complete);
-
 	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
 		DEBUGOUT("SFP not detected, skip setup mac link");
 		return 0;
@@ -163,6 +181,21 @@ s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
 	if (value & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS))
 		return status;
 
+	status = hw->mac.check_link(hw, &link_speed, &link_up,
+				    autoneg_wait_to_complete);
+
+	if (link_speed == speed && link_up)
+		return status;
+
+	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
+		speed = 0x10;
+	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+		speed = 0x08;
+
+	status = hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
+
+	txgbe_wait_for_link_up_aml(hw, speed);
+
 	return status;
 }
 
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index d11773916b..597b42951e 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -107,7 +107,42 @@ s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw,
 			       u32 speed,
 			       bool autoneg_wait_to_complete)
 {
-	return 0;
+	bool autoneg = false;
+	s32 status = 0;
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
+	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
+	u32 value = 0;
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+		DEBUGOUT("SFP not detected, skip setup mac link");
+		return 0;
+	}
+
+	/* Check to see if speed passed in is supported. */
+	status = hw->mac.get_link_capabilities(hw,
+			&link_capabilities, &autoneg);
+	if (status)
+		return status;
+
+	speed &= link_capabilities;
+	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
+		return TXGBE_ERR_LINK_SETUP;
+
+	status = hw->mac.check_link(hw, &link_speed, &link_up,
+				    autoneg_wait_to_complete);
+
+	if (link_speed == speed && link_up)
+		return status;
+
+	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
+		speed = 0x20;
+
+	status = hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
+
+	txgbe_wait_for_link_up_aml(hw, speed);
+
+	return status;
 }
 
 void txgbe_init_mac_link_ops_aml40(struct txgbe_hw *hw)
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 1bfc07d930..ef1c3c06ea 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2836,6 +2836,7 @@ s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 	phy->write_i2c_byte_unlocked = txgbe_write_i2c_byte_unlocked;
 	phy->check_overtemp = txgbe_check_overtemp;
 	phy->reset = txgbe_reset_phy;
+	phy->set_link_hostif = txgbe_hic_ephy_set_link;
 
 	/* MAC */
 	mac->init_hw = txgbe_init_hw;
diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index 8839450b44..782e86e1fa 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -602,3 +602,39 @@ s32 txgbe_hic_set_lldp(struct txgbe_hw *hw, bool on)
 	return txgbe_host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
 					    TXGBE_HI_COMMAND_TIMEOUT, false);
 }
+
+s32 txgbe_hic_ephy_set_link(struct txgbe_hw *hw, u8 speed, u8 autoneg, u8 duplex)
+{
+	struct txgbe_hic_ephy_setlink buffer;
+	s32 status;
+	int i;
+
+	buffer.hdr.cmd = FW_PHY_CONFIG_LINK_CMD;
+	buffer.hdr.buf_len = sizeof(struct txgbe_hic_ephy_setlink) - sizeof(struct txgbe_hic_hdr);
+	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+
+	buffer.fec_mode = TXGBE_PHY_FEC_AUTO;
+	buffer.speed = speed;
+	buffer.autoneg = autoneg;
+	buffer.duplex = duplex;
+
+	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
+		status = txgbe_host_interface_command(hw, (u32 *)&buffer,
+						      sizeof(buffer),
+						      TXGBE_HI_COMMAND_TIMEOUT_SHORT, true);
+		if (status != 0) {
+			msleep(1);
+			continue;
+		}
+
+		if (buffer.hdr.cmd_or_resp.ret_status ==
+				FW_CEM_RESP_STATUS_SUCCESS)
+			status = 0;
+		else
+			status = TXGBE_ERR_HOST_INTERFACE_COMMAND;
+
+		break;
+	}
+
+	return status;
+}
diff --git a/drivers/net/txgbe/base/txgbe_mng.h b/drivers/net/txgbe/base/txgbe_mng.h
index 613aa7b88a..53c5cd5487 100644
--- a/drivers/net/txgbe/base/txgbe_mng.h
+++ b/drivers/net/txgbe/base/txgbe_mng.h
@@ -13,6 +13,7 @@
 #define TXGBE_PMMBX_BSIZE       (TXGBE_PMMBX_QSIZE * 4)
 #define TXGBE_PMMBX_DATA_SIZE   (TXGBE_PMMBX_BSIZE - FW_NVM_DATA_OFFSET * 4)
 #define TXGBE_HI_COMMAND_TIMEOUT        5000 /* Process HI command limit */
+#define TXGBE_HI_COMMAND_TIMEOUT_SHORT  500 /* Process HI command limit */
 #define TXGBE_HI_FLASH_ERASE_TIMEOUT    5000 /* Process Erase command limit */
 #define TXGBE_HI_FLASH_UPDATE_TIMEOUT   5000 /* Process Update command limit */
 #define TXGBE_HI_FLASH_VERIFY_TIMEOUT   60000 /* Process Apply command limit */
@@ -56,6 +57,12 @@
 #define FW_LLDP_GET_CMD                 0xF2
 #define FW_LLDP_SET_CMD_OFF             0xF1
 #define FW_LLDP_SET_CMD_ON              0xF0
+#define FW_PHY_CONFIG_READ_CMD          0xc0
+#define FW_PHY_CONFIG_LINK_CMD          0xc1
+#define FW_PHY_CONFIG_FC_CMD            0xc2
+#define FW_PHY_CONFIG_POWER_CMD         0xc3
+#define FW_PHY_CONFIG_RESET_CMD         0xc4
+#define FW_READ_SFP_INFO_CMD            0xc5
 
 #define TXGBE_CHECKSUM_CAP_ST_PASS      0x80658383
 #define TXGBE_CHECKSUM_CAP_ST_FAIL      0x70657376
@@ -101,6 +108,15 @@ union txgbe_hic_hdr2 {
 	struct txgbe_hic_hdr2_rsp rsp;
 };
 
+struct txgbe_hic_ephy_setlink {
+	struct txgbe_hic_hdr hdr;
+	u8 speed;
+	u8 duplex;
+	u8 autoneg;
+	u8 fec_mode;
+	u8 resv[4];
+};
+
 struct txgbe_hic_drv_info {
 	struct txgbe_hic_hdr hdr;
 	u8 port_num;
@@ -204,5 +220,6 @@ bool txgbe_mng_present(struct txgbe_hw *hw);
 bool txgbe_mng_enabled(struct txgbe_hw *hw);
 s32 txgbe_hic_get_lldp(struct txgbe_hw *hw);
 s32 txgbe_hic_set_lldp(struct txgbe_hw *hw, bool on);
+s32 txgbe_hic_ephy_set_link(struct txgbe_hw *hw, u8 speed, u8 autoneg, u8 duplex);
 
 #endif /* _TXGBE_MNG_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 8be0c6cd57..55123d0b6c 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -681,6 +681,7 @@ struct txgbe_phy_info {
 				      u8 *value);
 	s32 (*write_i2c_byte_unlocked)(struct txgbe_hw *hw, u8 offset, u8 addr,
 				       u8 value);
+	s32 (*set_link_hostif)(struct txgbe_hw *hw, u8 speed, u8 autoneg, u8 duplex);
 
 	enum txgbe_phy_type type;
 	u32 addr;
@@ -764,6 +765,12 @@ enum txgbe_isb_idx {
 	TXGBE_ISB_MAX
 };
 
+#define TXGBE_PHY_FEC_RS	MS(0, 0x1)
+#define TXGBE_PHY_FEC_BASER	MS(1, 0x1)
+#define TXGBE_PHY_FEC_OFF	MS(2, 0x1)
+#define TXGBE_PHY_FEC_AUTO	(TXGBE_PHY_FEC_OFF | TXGBE_PHY_FEC_BASER |\
+				 TXGBE_PHY_FEC_RS)
+
 struct txgbe_devargs {
 	u16 auto_neg;
 	u16 poll;
-- 
2.21.0.windows.1

