Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52863C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:07:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F6AC4064A;
	Wed,  5 Mar 2025 17:06:55 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EB0E5402A4
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:06:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1A3B4211049F; Wed,  5 Mar 2025 08:06:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A3B4211049F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741190811;
 bh=E+ZALFpPHCnoZky6JJbZ/pwZvyyHrPgMj6zqadH54UQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BTShki4A3nGJ6ndlslYpBAt2JrThp35C4D15SZcpM1fNLBni5OabpjgUzUGJ8wZu6
 p4ZAYJuCQkTqVqjAG5QdBjZpBuaUCkC/13NKtaSXu4vD9Qv7M7LdWO2OTUBLENGQ9F
 6kzbmAKjzUYFiMvYiMQyCo7qCokf9vxaogyuSKi0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 2/2] drivers/net: remove use of non-standard array range
 initialization
Date: Wed,  5 Mar 2025 08:06:42 -0800
Message-Id: <1741190802-19486-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741190802-19486-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1741190802-19486-1-git-send-email-andremue@linux.microsoft.com>
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

Array range initialization is non-standard and is not provided by
all compilers. MSVC does not implement it and ends up emitting
errors like the one below:

drivers/net/r8169/r8169_phy.c(380):
    error C2143: syntax error: missing ':' before '...'
case CFG_METHOD_48 ... CFG_METHOD_57:

The fix is to explicitly initialize each element in the range.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/octeon_ep/otx_ep_mbox.c   |  24 +-
 drivers/net/r8169/base/rtl8125a_mcu.c |   8 +-
 drivers/net/r8169/base/rtl8126a.c     |   5 +-
 drivers/net/r8169/r8169_ethdev.c      |  34 +-
 drivers/net/r8169/r8169_hw.c          | 447 ++++++++++++++++++++++----
 drivers/net/r8169/r8169_phy.c         | 163 ++++++++--
 drivers/net/r8169/r8169_rxtx.c        |  25 +-
 7 files changed, 617 insertions(+), 89 deletions(-)

diff --git a/drivers/net/octeon_ep/otx_ep_mbox.c b/drivers/net/octeon_ep/otx_ep_mbox.c
index 1d7e08d2cc..e0fb6842e0 100644
--- a/drivers/net/octeon_ep/otx_ep_mbox.c
+++ b/drivers/net/octeon_ep/otx_ep_mbox.c
@@ -17,10 +17,26 @@
  * with new command and it's version info.
  */
 static uint32_t otx_ep_cmd_versions[OTX_EP_MBOX_CMD_MAX] = {
-	[0 ... OTX_EP_MBOX_CMD_DEV_REMOVE] = OTX_EP_MBOX_VERSION_V1,
-	[OTX_EP_MBOX_CMD_GET_FW_INFO ... OTX_EP_MBOX_NOTIF_LINK_STATUS] = OTX_EP_MBOX_VERSION_V2,
-	[OTX_EP_MBOX_NOTIF_PF_FLR] = OTX_EP_MBOX_VERSION_V3
-
+	/* [0 ... OTX_EP_MBOX_CMD_DEV_REMOVE] = OTX_EP_MBOX_VERSION_V1, */
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	OTX_EP_MBOX_VERSION_V1,
+	/* [OTX_EP_MBOX_CMD_GET_FW_INFO ... OTX_EP_MBOX_NOTIF_LINK_STATUS] =
+	 *		OTX_EP_MBOX_VERSION_V2,
+	 */
+	OTX_EP_MBOX_VERSION_V2,
+	OTX_EP_MBOX_VERSION_V2,
+	OTX_EP_MBOX_VERSION_V2,
+	/* [OTX_EP_MBOX_NOTIF_PF_FLR] = OTX_EP_MBOX_VERSION_V3 */
+	OTX_EP_MBOX_VERSION_V3,
 };
 
 static int
diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c b/drivers/net/r8169/base/rtl8125a_mcu.c
index 5a69b3e094..c9bf5fc6ad 100644
--- a/drivers/net/r8169/base/rtl8125a_mcu.c
+++ b/drivers/net/r8169/base/rtl8125a_mcu.c
@@ -162,7 +162,13 @@ static void
 rtl_release_phy_mcu_patch_key_lock(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_53:
+	/* CFG_METHOD_48 ... CFG_METHOD_53 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x0000);
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0000);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xB82E, BIT_0);
diff --git a/drivers/net/r8169/base/rtl8126a.c b/drivers/net/r8169/base/rtl8126a.c
index 69fe7bc030..96a9d0a9b7 100644
--- a/drivers/net/r8169/base/rtl8126a.c
+++ b/drivers/net/r8169/base/rtl8126a.c
@@ -29,7 +29,10 @@ static void
 hw_ephy_config_8126a(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		/* nothing to do */
 		break;
 	}
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index c0cac6e7d8..4cf5bfb508 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -295,8 +295,21 @@ rtl_dev_stop(struct rte_eth_dev *dev)
 	rtl_nic_reset(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE00A, hw->mcu_pme_setting);
 		break;
 	}
@@ -333,8 +346,21 @@ rtl_dev_set_link_down(struct rte_eth_dev *dev)
 
 	/* mcu pme intr masks */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE00A, hw->mcu_pme_setting & ~(BIT_11 | BIT_14));
 		break;
 	}
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 63a20a733e..bc4cda3f51 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -348,8 +348,21 @@ static void
 rtl_enable_rxdvgate(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_3);
 		rte_delay_ms(2);
 	}
@@ -359,8 +372,21 @@ void
 rtl_disable_rxdvgate(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_3);
 		rte_delay_ms(2);
 	}
@@ -398,8 +424,21 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	int i;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		for (i = 0; i < 3000; i++) {
 			rte_delay_us(50);
 			if ((RTL_R8(hw, MCUCmd_reg) & (Txfifo_empty | Rxfifo_empty)) ==
@@ -412,8 +451,16 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	switch (hw->mcfg) {
 	case CFG_METHOD_50:
 	case CFG_METHOD_51:
-	case CFG_METHOD_53 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_53 ... CFG_METHOD_57 */
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		for (i = 0; i < 3000; i++) {
 			rte_delay_us(50);
 			if ((RTL_R16(hw, IntrMitigate) & (BIT_0 | BIT_1 | BIT_8)) ==
@@ -483,7 +530,17 @@ static void
 rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 	case CFG_METHOD_69:
 		rtl_enable_cfg9346_write(hw);
 		if (enable) {
@@ -520,8 +577,21 @@ static void
 rtl_disable_eee_plus(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE080, rtl_mac_ocp_read(hw, 0xE080) & ~BIT_1);
 		break;
 
@@ -535,8 +605,21 @@ static void
 rtl_hw_clear_timer_int(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W32(hw, TIMER_INT0_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT1_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT2_8125, 0x0000);
@@ -591,8 +674,21 @@ rtl_hw_config(struct rtl_hw *hw)
 
 	/* Disable aspm clkreq internal */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_enable_force_clkreq(hw, 0);
 		rtl_enable_aspm_clkreq_lock(hw, 0);
 		break;
@@ -600,8 +696,21 @@ rtl_hw_config(struct rtl_hw *hw)
 
 	/* Disable magic packet */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		mac_ocp_data = 0;
 		rtl_mac_ocp_write(hw, 0xC0B6, mac_ocp_data);
 		break;
@@ -616,20 +725,42 @@ rtl_hw_config(struct rtl_hw *hw)
 
 	/* TCAM */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_53:
+	/* CFG_METHOD_48 ... CFG_METHOD_53 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
 		RTL_W16(hw, 0x382, 0x221B);
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_disable_l1_timeout(hw);
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 
 		/* RSS_control_0 */
 		RTL_W32(hw, RSS_CTRL_8125, 0x00);
@@ -782,7 +913,11 @@ rtl_hw_config(struct rtl_hw *hw)
 		RTL_W16(hw, 0x1880, RTL_R16(hw, 0x1880) & ~(BIT_4 | BIT_5));
 
 		switch (hw->mcfg) {
-		case CFG_METHOD_54 ... CFG_METHOD_57:
+		/* CFG_METHOD_54 ... CFG_METHOD_57 */
+		case CFG_METHOD_54:
+		case CFG_METHOD_55:
+		case CFG_METHOD_56:
+		case CFG_METHOD_57:
 			RTL_W8(hw, 0xd8, RTL_R8(hw, 0xd8) & ~EnableRxDescV4_0);
 			break;
 		}
@@ -794,8 +929,21 @@ rtl_hw_config(struct rtl_hw *hw)
 	rtl_hw_clear_int_miti(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE098, 0xC302);
 		break;
 	}
@@ -835,7 +983,10 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 		hw->hw_ops = rtl8125d_ops;
 		return 0;
 	/* 8126A */
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->hw_ops = rtl8126a_ops;
 		return 0;
 	default:
@@ -851,15 +1002,41 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 	rtl_enable_aspm_clkreq_lock(hw, 0);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xFC48, 0x0000);
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		for (reg_addr = 0xFC28; reg_addr < 0xFC48; reg_addr += 2)
 			rtl_mac_ocp_write(hw, reg_addr, 0x0000);
 
@@ -1073,7 +1250,10 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 		hw->chipset_name = RTL8125D;
 		break;
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->chipset_name = RTL8126A;
 		break;
 	default:
@@ -1082,23 +1262,60 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppNowIsOobVer = 1;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppCheckPhyDisableModeVer = 3;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_51:
-	case CFG_METHOD_54 ... CFG_METHOD_57:
+	/* CFG_METHOD_48 ... CFG_METHOD_51 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	/* CFG_METHOD_54 ... CFG_METHOD_57 */
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_2500;
 		break;
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_5000;
 		break;
 	default:
@@ -1107,10 +1324,20 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_53:
+	/* CFG_METHOD_48 ... CFG_METHOD_53 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
 		hw->HwSuppTxNoCloseVer = 3;
 		break;
-	case CFG_METHOD_54 ... CFG_METHOD_57:
+	/* CFG_METHOD_54 ... CFG_METHOD_57 */
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
 	case CFG_METHOD_69:
@@ -1201,15 +1428,41 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppMacMcuVer = 2;
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->MacMcuPageSize = RTL_MAC_MCU_PAGE_SIZE;
 		break;
 	}
@@ -1235,7 +1488,11 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 		hw->HwSuppIntMitiVer = 4;
 		break;
-	case CFG_METHOD_54 ... CFG_METHOD_57:
+	/* CFG_METHOD_54 ... CFG_METHOD_57 */
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		hw->HwSuppIntMitiVer = 6;
 		break;
 	case CFG_METHOD_70:
@@ -1247,8 +1504,21 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	rtl_set_link_option(hw, autoneg_mode, speed_mode, duplex_mode, rtl_fc_full);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->mcu_pme_setting = rtl_mac_ocp_read(hw, 0xE00A);
 		break;
 	}
@@ -1261,8 +1531,21 @@ rtl_exit_realwow(struct rtl_hw *hw)
 {
 	/* Disable realwow function */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xC0BC, 0x00FF);
 		break;
 	}
@@ -1304,8 +1587,21 @@ rtl_exit_oob(struct rtl_hw *hw)
 	rtl_nic_reset(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_disable_now_is_oob(hw);
 
 		data16 = rtl_mac_ocp_read(hw, 0xE8DE) & ~BIT_14;
@@ -1327,8 +1623,21 @@ static void
 rtl_disable_ups(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xD40A, rtl_mac_ocp_read(hw, 0xD40A) & ~BIT_4);
 		break;
 	}
@@ -1355,8 +1664,21 @@ static void
 rtl_hw_init(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_enable_aspm_clkreq_lock(hw, 0);
 		rtl_enable_force_clkreq(hw, 0);
 		break;
@@ -1481,8 +1803,21 @@ rtl_get_mac_address(struct rtl_hw *hw, struct rte_ether_addr *ea)
 	u8 mac_addr[MAC_ADDR_LEN] = {0};
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		*(u32 *)&mac_addr[0] = RTL_R32(hw, BACKUP_ADDR0_8125);
 		*(u16 *)&mac_addr[4] = RTL_R16(hw, BACKUP_ADDR1_8125);
 		break;
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index cc8efe80f2..abdf09e879 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -377,8 +377,21 @@ rtl_wait_phy_ups_resume(struct rtl_hw *hw, u16 PhyState)
 	int i = 0;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		do {
 			tmp_phy_state = rtl_mdio_direct_read_phy_ocp(hw, 0xA420);
 			tmp_phy_state &= 0x7;
@@ -399,8 +412,21 @@ rtl_phy_power_up(struct rtl_hw *hw)
 
 	/* Wait ups resume (phy state 3) */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_wait_phy_ups_resume(hw, 3);
 	}
 }
@@ -409,8 +435,21 @@ void
 rtl_powerup_pll(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) | BIT_7 | BIT_6);
 	}
 
@@ -433,8 +472,21 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 	rtl_phy_power_down(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) & ~BIT_7);
 		break;
 	}
@@ -516,8 +568,21 @@ rtl_get_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 	u16 hw_ram_code_ver = ~0;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
 		hw_ram_code_ver = rtl_mdio_direct_read_phy_ocp(hw, 0xA438);
 		break;
@@ -547,8 +612,21 @@ static void
 rtl_write_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA438, hw->sw_ram_code_ver);
 		hw->hw_ram_code_ver = hw->sw_ram_code_ver;
@@ -633,8 +711,19 @@ static bool
 rtl_is_adv_eee_enabled(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_55:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_55 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		if (rtl_mdio_direct_read_phy_ocp(hw, 0xA430) & BIT_15)
 			return true;
 		break;
@@ -712,7 +801,12 @@ rtl_disable_eee(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_50:
 	case CFG_METHOD_51:
-	case CFG_METHOD_53 ... CFG_METHOD_57:
+	/* CFG_METHOD_53 ... CFG_METHOD_57 */
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xA432, BIT_4);
@@ -723,7 +817,10 @@ rtl_disable_eee(struct rtl_hw *hw)
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_7);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA4A2, BIT_9);
 		break;
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5D0, (MDIO_EEE_100TX | MDIO_EEE_1000T));
@@ -756,16 +853,42 @@ rtl_hw_phy_config(struct rtl_hw *hw)
 	hw->hw_ops.hw_phy_config(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_disable_aldps(hw);
 		break;
 	}
 
 	/* Legacy force mode (chap 22) */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 	default:
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5B4, BIT_15);
 		break;
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 57b97338d4..fa6ca59108 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -1012,8 +1012,21 @@ rtl_tx_init(struct rte_eth_dev *dev)
 
 	/* Set TDFNR: TX Desc Fetch NumbeR */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	/* CFG_METHOD_48 ... CFG_METHOD_57 */
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	/* CFG_METHOD_69 ... CFG_METHOD_71 */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, TDFNR, 0x10);
 		break;
 	}
@@ -1187,7 +1200,13 @@ rtl_xmit_pkt(struct rtl_hw *hw, struct rtl_tx_queue *txq,
 		rtl_setup_csum_offload(tx_pkt, tx_ol_flags, opts);
 
 		switch (hw->mcfg) {
-		case CFG_METHOD_48 ... CFG_METHOD_53:
+		/* CFG_METHOD_48 ... CFG_METHOD_53 */
+		case CFG_METHOD_48:
+		case CFG_METHOD_49:
+		case CFG_METHOD_50:
+		case CFG_METHOD_51:
+		case CFG_METHOD_52:
+		case CFG_METHOD_53:
 			rtl8125_ptp_patch(tx_pkt);
 			break;
 		}
-- 
2.48.1.vfs.0.0

