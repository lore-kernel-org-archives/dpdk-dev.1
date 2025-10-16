Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE936CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EAE94279A;
	Thu, 16 Oct 2025 13:19:31 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id B75BC42708
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:29 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613564t0658bd37
X-QQ-Originating-IP: SdRrIljGUHbLwlghG77BRnex1CTzga5XGZh8H88lXD8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3215911537769948135
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 04/21] net/txgbe: rename raptor to sp for Sapphire-specific
 code
Date: Thu, 16 Oct 2025 19:17:18 +0800
Message-Id: <20251016111736.25372-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MOfwHzgDpc8IBHe/NOWrqrmwtVGqG1V48A3we8dyVGGNT26RiGZE02Qn
 cRb84/Zo3POiSlUIbVVUBLvroWyWGSzsP3GBK6pAV+RtpeUTelhWe8/b6F7jGN8jyEeGRYp
 DWaz1bzQR8kCfCLj83y/Re7dDshiQzY39PLg4k7nyxcFYeeD0vHuwqgrGvI6+arB0UnYOKt
 OP3HDuwczmsAzmTDEBBYq5Nc7Y5+i4W8yJjiDqxeEwRD+Qnt9vdFvbp/4teOccmljQ4/ihi
 A9I4+y2xfiIAsRQ1nxQbno3PCO+wVAEha9kiqaXZLhuY7/CRWxzwdkgZplbU5fGGLw5qenr
 +rsizVBJRum7YredVWSHerPK5FOELq/FJ5tqQGC58I+Ia+dw/SR8gyWtU0T7D0btdy/JG4C
 Z05sT+KQvyhO2dEq2A2iKUdw+4Lji4XWlF41L6fLhLdoB9Iu/djlH/iqfkQHhLJRFBj1Y7Z
 mF7RqQUlPX48Qj9xeVwzQc0TBs+JoEEwvUTnl1pbVEPUsijQa7Z5YVLdDxH58+kTywAU9gE
 vrEeQqqaFXK3cHP8eN9bSXxxAGUB34HoLKwrtIPcUH7Lkn0Z+APniYztWTkwBECD1J2lKSj
 NJ0TYJqf4HiiQGBIvV7OVDM6qRg/GLAjKGaeopvKrYUkcvVIdUfUIGwBvHX45wBlwhe4uND
 XjqiowKxiXUbW2e0JcDapTLGsg986UzTNQ74g3IWEYxYQy5df5jhp+fMSyMNZveojAgI0mH
 JB7Val4SkufIC0L3MtaIpZuZ7YrIJrwca/8dnzjn76lc1+rVUogeg104DdOYuf/TtRn8sGB
 +jA9oHF4axLK9Lc9RBvj66w68b0YGPJyKUXxM/eOGYXA4BRFrRKFVQJolTwfpv6/XVEQs/+
 qM+H/8EWR1K39oGKkZRAHK912d3OmsQs5j2IjuXY8taHFTlyAqGIh0UiUJ6j642t6Y9MiK7
 L6gEIqWAbCW1UXUmzKhE4Mi4oUzLWyiyYkLrWplbIotjBbSLxt95Q2oAxnQ06yNuWhWUE6r
 ocYYzHUruytP1EscuKRgQq63z29DfRW7/1pTHypZq85SHgGY0RmHbLwCuCffM=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

The term "raptor" was originally used as a general designation for
NICs when only Sapphire series existed. With the addition of
Amber-Lite series NICs, we now use "sp" to replace "raptor" for
driver components that are specific to Sapphire NICs, while
retaining the "raptor" name for common flows applicable to all NICs.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 62 +++++++++++++++++++----------
 drivers/net/txgbe/base/txgbe_hw.h   | 11 ++---
 drivers/net/txgbe/base/txgbe_regs.h |  8 ++--
 drivers/net/txgbe/base/txgbe_type.h |  5 ++-
 drivers/net/txgbe/base/txgbe_vf.c   |  2 +-
 drivers/net/txgbe/txgbe_ethdev.c    | 14 +++----
 drivers/net/txgbe/txgbe_ethdev_vf.c |  2 +-
 drivers/net/txgbe/txgbe_flow.c      |  2 +-
 drivers/net/txgbe/txgbe_rxtx.c      | 24 +++++------
 9 files changed, 76 insertions(+), 54 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 76f8ecf62e..81e686fdf1 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -272,7 +272,7 @@ s32 txgbe_start_hw(struct txgbe_hw *hw)
 
 	/* Cache bit indicating need for crosstalk fix */
 	switch (hw->mac.type) {
-	case txgbe_mac_raptor:
+	case txgbe_mac_sp:
 		hw->mac.get_device_caps(hw, &device_caps);
 		if (device_caps & TXGBE_DEVICE_CAPS_NO_CROSSTALK_WR)
 			hw->need_crosstalk_fix = false;
@@ -1915,7 +1915,7 @@ static bool txgbe_need_crosstalk_fix(struct txgbe_hw *hw)
  *
  *  Reads the links register to determine if link is up and the current speed
  **/
-s32 txgbe_check_mac_link(struct txgbe_hw *hw, u32 *speed,
+s32 txgbe_check_mac_link_sp(struct txgbe_hw *hw, u32 *speed,
 				 bool *link_up, bool link_up_wait_to_complete)
 {
 	u32 links_reg, links_orig;
@@ -1928,7 +1928,7 @@ s32 txgbe_check_mac_link(struct txgbe_hw *hw, u32 *speed,
 		u32 sfp_cage_full;
 
 		switch (hw->mac.type) {
-		case txgbe_mac_raptor:
+		case txgbe_mac_sp:
 			sfp_cage_full = !rd32m(hw, TXGBE_GPIODATA,
 					TXGBE_GPIOBIT_2);
 			break;
@@ -2475,12 +2475,13 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 
 	txgbe_init_ops_dummy(hw);
 	switch (hw->mac.type) {
-	case txgbe_mac_raptor:
+	case txgbe_mac_sp:
+		txgbe_init_ops_sp(hw);
+		break;
 	case txgbe_mac_aml:
 	case txgbe_mac_aml40:
-		status = txgbe_init_ops_pf(hw);
 		break;
-	case txgbe_mac_raptor_vf:
+	case txgbe_mac_sp_vf:
 		status = txgbe_init_ops_vf(hw);
 		break;
 	default:
@@ -2497,7 +2498,7 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 bool txgbe_is_pf(struct txgbe_hw *hw)
 {
 	switch (hw->mac.type) {
-	case txgbe_mac_raptor:
+	case txgbe_mac_sp:
 		return true;
 	default:
 		return false;
@@ -2523,7 +2524,7 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 	switch (hw->device_id) {
 	case TXGBE_DEV_ID_SP1000:
 	case TXGBE_DEV_ID_WX1820:
-		hw->mac.type = txgbe_mac_raptor;
+		hw->mac.type = txgbe_mac_sp;
 		break;
 	case TXGBE_DEV_ID_AML:
 	case TXGBE_DEV_ID_AML5025:
@@ -2537,7 +2538,7 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 	case TXGBE_DEV_ID_SP1000_VF:
 	case TXGBE_DEV_ID_WX1820_VF:
 		hw->phy.media_type = txgbe_media_type_virtual;
-		hw->mac.type = txgbe_mac_raptor_vf;
+		hw->mac.type = txgbe_mac_sp_vf;
 		break;
 	case TXGBE_DEV_ID_AML_VF:
 	case TXGBE_DEV_ID_AML5024_VF:
@@ -2556,7 +2557,7 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 	return err;
 }
 
-void txgbe_init_mac_link_ops(struct txgbe_hw *hw)
+void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw)
 {
 	struct txgbe_mac_info *mac = &hw->mac;
 
@@ -2616,7 +2617,7 @@ s32 txgbe_init_phy_raptor(struct txgbe_hw *hw)
 		goto init_phy_ops_out;
 
 	/* Setup function pointers based on detected SFP module and speeds */
-	txgbe_init_mac_link_ops(hw);
+	txgbe_init_mac_link_ops_sp(hw);
 
 	/* If copper media, overwrite with copper function pointers */
 	if (phy->media_type == txgbe_media_type_copper) {
@@ -2651,7 +2652,7 @@ s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw)
 	if (hw->phy.sfp_type == txgbe_sfp_type_unknown)
 		return 0;
 
-	txgbe_init_mac_link_ops(hw);
+	txgbe_init_mac_link_ops_sp(hw);
 
 	/* PHY config will finish before releasing the semaphore */
 	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
@@ -2792,13 +2793,13 @@ s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data)
 }
 
 /**
- *  txgbe_init_ops_pf - Inits func ptrs and MAC type
+ *  txgbe_init_ops_generic - Inits func ptrs and MAC type
  *  @hw: pointer to hardware structure
  *
  *  Initialize the function pointers and assign the MAC type.
  *  Does not touch the hardware.
  **/
-s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
+s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 {
 	struct txgbe_bus_info *bus = &hw->bus;
 	struct txgbe_mac_info *mac = &hw->mac;
@@ -2918,15 +2919,31 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
 	return 0;
 }
 
+void txgbe_init_ops_sp(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+	struct txgbe_phy_info *phy = &hw->phy;
+
+	txgbe_init_ops_generic(hw);
+
+	/* PHY */
+	phy->get_media_type = txgbe_get_media_type_sp;
+
+	/* LINK */
+	mac->init_mac_link_ops = txgbe_init_mac_link_ops_sp;
+	mac->get_link_capabilities = txgbe_get_link_capabilities_sp;
+	mac->check_link = txgbe_check_mac_link_sp;
+}
+
 /**
- *  txgbe_get_link_capabilities_raptor - Determines link capabilities
+ *  txgbe_get_link_capabilities_sp - Determines link capabilities
  *  @hw: pointer to hardware structure
  *  @speed: pointer to link speed
  *  @autoneg: true when autoneg or autotry is enabled
  *
  *  Determines the link capabilities by reading the AUTOC register.
  **/
-s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
+s32 txgbe_get_link_capabilities_sp(struct txgbe_hw *hw,
 				      u32 *speed,
 				      bool *autoneg)
 {
@@ -3027,12 +3044,12 @@ s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
 }
 
 /**
- *  txgbe_get_media_type_raptor - Get media type
+ *  txgbe_get_media_type_sp - Get media type
  *  @hw: pointer to hardware structure
  *
  *  Returns the media type (fiber, copper, backplane)
  **/
-u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw)
+u32 txgbe_get_media_type_sp(struct txgbe_hw *hw)
 {
 	u32 media_type;
 
@@ -3565,8 +3582,10 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
 	if (!hw->phy.reset_disable)
 		hw->phy.reset(hw);
 
-	/* remember AUTOC from before we reset */
-	autoc = hw->mac.autoc_read(hw);
+	if (hw->mac.type == txgbe_mac_sp) {
+		/* remember AUTOC from before we reset */
+		autoc = hw->mac.autoc_read(hw);
+	}
 
 mac_reset_top:
 	/* Do LAN reset, the MNG domain will not be reset. */
@@ -3615,7 +3634,8 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
 		msec_delay(50);
 
 		/* A temporary solution to set phy */
-		txgbe_set_phy_temp(hw);
+		if (hw->mac.type == txgbe_mac_sp)
+			txgbe_set_phy_temp(hw);
 	}
 
 	/* Store the permanent mac address */
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index 7a45020824..62c027c850 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -56,7 +56,7 @@ s32 txgbe_set_vlvf(struct txgbe_hw *hw, u32 vlan, u32 vind,
 s32 txgbe_clear_vfta(struct txgbe_hw *hw);
 s32 txgbe_find_vlvf_slot(struct txgbe_hw *hw, u32 vlan, bool vlvf_bypass);
 
-s32 txgbe_check_mac_link(struct txgbe_hw *hw,
+s32 txgbe_check_mac_link_sp(struct txgbe_hw *hw,
 			       u32 *speed,
 			       bool *link_up, bool link_up_wait_to_complete);
 
@@ -87,10 +87,11 @@ s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 s32 txgbe_init_shared_code(struct txgbe_hw *hw);
 bool txgbe_is_pf(struct txgbe_hw *hw);
 s32 txgbe_set_mac_type(struct txgbe_hw *hw);
-s32 txgbe_init_ops_pf(struct txgbe_hw *hw);
-s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
+s32 txgbe_init_ops_generic(struct txgbe_hw *hw);
+void txgbe_init_ops_sp(struct txgbe_hw *hw);
+s32 txgbe_get_link_capabilities_sp(struct txgbe_hw *hw,
 				      u32 *speed, bool *autoneg);
-u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw);
+u32 txgbe_get_media_type_sp(struct txgbe_hw *hw);
 void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
 void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
 void txgbe_flap_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
@@ -104,7 +105,7 @@ s32 txgbe_start_mac_link_raptor(struct txgbe_hw *hw,
 s32 txgbe_setup_mac_link(struct txgbe_hw *hw, u32 speed,
 			       bool autoneg_wait_to_complete);
 s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw);
-void txgbe_init_mac_link_ops(struct txgbe_hw *hw);
+void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw);
 s32 txgbe_reset_hw(struct txgbe_hw *hw);
 s32 txgbe_start_hw_raptor(struct txgbe_hw *hw);
 s32 txgbe_init_phy_raptor(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index e75597591f..ab1a11230c 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1737,11 +1737,11 @@ txgbe_map_reg(struct txgbe_hw *hw, u32 reg)
 {
 	switch (reg) {
 	case TXGBE_REG_RSSTBL:
-		if (hw->mac.type == txgbe_mac_raptor_vf)
+		if (hw->mac.type == txgbe_mac_sp_vf)
 			reg = TXGBE_VFRSSTBL(0);
 		break;
 	case TXGBE_REG_RSSKEY:
-		if (hw->mac.type == txgbe_mac_raptor_vf)
+		if (hw->mac.type == txgbe_mac_sp_vf)
 			reg = TXGBE_VFRSSKEY(0);
 		break;
 	default:
@@ -1917,10 +1917,10 @@ po32m(struct txgbe_hw *hw, u32 reg, u32 mask, u32 expect, u32 *actual,
 static inline void txgbe_flush(struct txgbe_hw *hw)
 {
 	switch (hw->mac.type) {
-	case txgbe_mac_raptor:
+	case txgbe_mac_sp:
 		rd32(hw, TXGBE_PWR);
 		break;
-	case txgbe_mac_raptor_vf:
+	case txgbe_mac_sp_vf:
 		rd32(hw, TXGBE_VFSTATUS);
 		break;
 	default:
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 2d13539f87..4d825bec44 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -139,10 +139,10 @@ enum txgbe_eeprom_type {
 
 enum txgbe_mac_type {
 	txgbe_mac_unknown = 0,
-	txgbe_mac_raptor,
+	txgbe_mac_sp,
 	txgbe_mac_aml,
 	txgbe_mac_aml40,
-	txgbe_mac_raptor_vf,
+	txgbe_mac_sp_vf,
 	txgbe_mac_aml_vf,
 	txgbe_num_macs
 };
@@ -544,6 +544,7 @@ struct txgbe_mac_info {
 	s32 (*prot_autoc_read)(struct txgbe_hw *hw, bool *locked, u64 *value);
 	s32 (*prot_autoc_write)(struct txgbe_hw *hw, bool locked, u64 value);
 	s32 (*negotiate_api_version)(struct txgbe_hw *hw, int api);
+	void (*init_mac_link_ops)(struct txgbe_hw *hw);
 
 	/* Link */
 	void (*disable_tx_laser)(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_vf.c b/drivers/net/txgbe/base/txgbe_vf.c
index 8c731b4776..5e41ba1a3e 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -488,7 +488,7 @@ s32 txgbe_check_mac_link_vf(struct txgbe_hw *hw, u32 *speed,
 	/* for SFP+ modules and DA cables it can take up to 500usecs
 	 * before the link status is correct
 	 */
-	if (mac->type == txgbe_mac_raptor_vf && wait_to_complete) {
+	if (mac->type == txgbe_mac_sp_vf && wait_to_complete) {
 		if (po32m(hw, TXGBE_VFSTATUS, TXGBE_VFSTATUS_UP,
 			0, NULL, 5, 100))
 			goto out;
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index d49030357d..82cec488f4 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -385,7 +385,7 @@ txgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
 	uint32_t q_map;
 	uint8_t n, offset;
 
-	if (hw->mac.type != txgbe_mac_raptor)
+	if (hw->mac.type != txgbe_mac_sp)
 		return -ENOSYS;
 
 	if (stat_idx & ~QMAP_FIELD_RESERVED_BITS_MASK)
@@ -1806,7 +1806,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	}
 
 	/* Skip link setup if loopback mode is enabled. */
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (hw->mac.type == txgbe_mac_sp &&
 	    dev->data->dev_conf.lpbk_mode)
 		goto skip_link_setup;
 
@@ -3072,7 +3072,7 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 	}
 
 	/* Re configure MAC RX */
-	if (hw->mac.type == txgbe_mac_raptor) {
+	if (hw->mac.type == txgbe_mac_sp) {
 		reg = rd32(hw, TXGBE_MACRXCFG);
 		wr32(hw, TXGBE_MACRXCFG, reg);
 		wr32m(hw, TXGBE_MACRXFLT, TXGBE_MACRXFLT_PROMISC,
@@ -3858,7 +3858,7 @@ txgbe_uc_hash_table_set(struct rte_eth_dev *dev,
 	struct txgbe_uta_info *uta_info = TXGBE_DEV_UTA_INFO(dev);
 
 	/* The UTA table only exists on pf hardware */
-	if (hw->mac.type < txgbe_mac_raptor)
+	if (hw->mac.type < txgbe_mac_sp)
 		return -ENOTSUP;
 
 	vector = txgbe_uta_vector(hw, mac_addr);
@@ -3903,7 +3903,7 @@ txgbe_uc_all_hash_table_set(struct rte_eth_dev *dev, uint8_t on)
 	int i;
 
 	/* The UTA table only exists on pf hardware */
-	if (hw->mac.type < txgbe_mac_raptor)
+	if (hw->mac.type < txgbe_mac_sp)
 		return -ENOTSUP;
 
 	if (on) {
@@ -4969,8 +4969,8 @@ bool
 txgbe_rss_update_sp(enum txgbe_mac_type mac_type)
 {
 	switch (mac_type) {
-	case txgbe_mac_raptor:
-	case txgbe_mac_raptor_vf:
+	case txgbe_mac_sp:
+	case txgbe_mac_sp_vf:
 		return 1;
 	default:
 		return 0;
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 847febf8c3..6505c5848c 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -375,7 +375,7 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 
 	PMD_INIT_LOG(DEBUG, "port %d vendorID=0x%x deviceID=0x%x mac.type=%s",
 		     eth_dev->data->port_id, pci_dev->id.vendor_id,
-		     pci_dev->id.device_id, "txgbe_mac_raptor_vf");
+		     pci_dev->id.device_id, "txgbe_mac_sp_vf");
 
 	return 0;
 }
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 99a76daca0..31af3593ed 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2854,7 +2854,7 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 
 step_next:
 
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (hw->mac.type == txgbe_mac_sp &&
 		rule->fdirflags == TXGBE_FDIRPICMD_DROP &&
 		(rule->input.src_port != 0 || rule->input.dst_port != 0))
 		return -ENOTSUP;
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index ca1e0a38c3..f74dd1a963 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -80,7 +80,7 @@ txgbe_is_vf(struct rte_eth_dev *dev)
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	switch (hw->mac.type) {
-	case txgbe_mac_raptor_vf:
+	case txgbe_mac_sp_vf:
 		return 1;
 	default:
 		return 0;
@@ -2121,10 +2121,10 @@ txgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
 	 * RSC is only supported by PF devices in a non-SR-IOV
 	 * mode.
 	 */
-	if (hw->mac.type == txgbe_mac_raptor && !sriov->active)
+	if (hw->mac.type == txgbe_mac_sp && !sriov->active)
 		offloads |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
 
-	if (hw->mac.type == txgbe_mac_raptor)
+	if (hw->mac.type == txgbe_mac_sp)
 		offloads |= RTE_ETH_RX_OFFLOAD_MACSEC_STRIP;
 
 	offloads |= RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
@@ -2498,7 +2498,7 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* Modification to set tail pointer for virtual function
 	 * if vf is detected.
 	 */
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (hw->mac.type == txgbe_mac_sp_vf) {
 		txq->tdt_reg_addr = TXGBE_REG_ADDR(hw, TXGBE_TXWP(queue_idx));
 		txq->tdc_reg_addr = TXGBE_REG_ADDR(hw, TXGBE_TXCFG(queue_idx));
 	} else {
@@ -2791,7 +2791,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modified to setup VFRDT for Virtual Function
 	 */
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (hw->mac.type == txgbe_mac_sp_vf) {
 		rxq->rdt_reg_addr =
 			TXGBE_REG_ADDR(hw, TXGBE_RXWP(queue_idx));
 		rxq->rdh_reg_addr =
@@ -3037,7 +3037,7 @@ txgbe_rss_disable(struct rte_eth_dev *dev)
 	struct txgbe_hw *hw;
 
 	hw = TXGBE_DEV_HW(dev);
-	if (hw->mac.type == txgbe_mac_raptor_vf)
+	if (hw->mac.type == txgbe_mac_sp_vf)
 		wr32m(hw, TXGBE_VFPLCFG, TXGBE_VFPLCFG_RSSENA, 0);
 	else
 		wr32m(hw, TXGBE_RACTL, TXGBE_RACTL_RSSENA, 0);
@@ -3074,7 +3074,7 @@ txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	/* Set configured hashing protocols */
 	rss_hf = rss_conf->rss_hf & TXGBE_RSS_OFFLOAD_ALL;
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (hw->mac.type == txgbe_mac_sp_vf) {
 		mrqc = rd32(hw, TXGBE_VFPLCFG);
 		mrqc &= ~TXGBE_VFPLCFG_RSSMASK;
 		if (rss_hf & RTE_ETH_RSS_IPV4)
@@ -3166,7 +3166,7 @@ txgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	}
 
 	rss_hf = 0;
-	if (hw->mac.type == txgbe_mac_raptor_vf) {
+	if (hw->mac.type == txgbe_mac_sp_vf) {
 		mrqc = rd32(hw, TXGBE_VFPLCFG);
 		if (mrqc & TXGBE_VFPLCFG_RSSIPV4)
 			rss_hf |= RTE_ETH_RSS_IPV4;
@@ -3627,7 +3627,7 @@ txgbe_dcb_hw_arbite_tx_config(struct txgbe_hw *hw, uint16_t *refill,
 		uint16_t *max, uint8_t *bwg_id, uint8_t *tsa, uint8_t *map)
 {
 	switch (hw->mac.type) {
-	case txgbe_mac_raptor:
+	case txgbe_mac_sp:
 		txgbe_dcb_config_tx_desc_arbiter_raptor(hw, refill,
 							max, bwg_id, tsa);
 		txgbe_dcb_config_tx_data_arbiter_raptor(hw, refill,
@@ -4555,7 +4555,7 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 	 * If loopback mode is configured, set LPBK bit.
 	 */
 	hlreg0 = rd32(hw, TXGBE_PSRCTL);
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (hw->mac.type == txgbe_mac_sp &&
 	    dev->data->dev_conf.lpbk_mode)
 		hlreg0 |= TXGBE_PSRCTL_LBENA;
 	else
@@ -4640,7 +4640,7 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 
 	wr32(hw, TXGBE_PSRCTL, rxcsum);
 
-	if (hw->mac.type == txgbe_mac_raptor) {
+	if (hw->mac.type == txgbe_mac_sp) {
 		rdrxctl = rd32(hw, TXGBE_SECRXCTL);
 		if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
 			rdrxctl &= ~TXGBE_SECRXCTL_CRCSTRIP;
@@ -4765,7 +4765,7 @@ txgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 	hw->mac.enable_rx_dma(hw, rxctrl);
 
 	/* If loopback mode is enabled, set up the link accordingly */
-	if (hw->mac.type == txgbe_mac_raptor &&
+	if (hw->mac.type == txgbe_mac_sp &&
 	    dev->data->dev_conf.lpbk_mode)
 		txgbe_setup_loopback_link_raptor(hw);
 
-- 
2.21.0.windows.1

