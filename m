Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B68C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9461242D9D;
	Tue, 10 Jun 2025 08:01:45 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 9330942D7B
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:01:41 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A61dgoE2359272,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749535299;
 bh=Y71lVJscVuONPy7W7cyNL4rRZ2e10rX2LJYC1zviv+k=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=qgePezUpHqUEFDsMij+BPs1cskXBMdctos6c4zn7xSRvVKOSdd4HfeceI2+TCJ4h7
 kl2h5bBqEjQejAvUHcIOIfHQS3JkSZuZa/baYdxfFt8fvU5GBq9hdWtJJe4bVv2HoF
 TU30o7jn1zcWjWEaNZmPzRMweoykfFXLHLRHcrLB0dpjUNvgdNASc7GjDhhc3svRLH
 MKleEN3H2UyMTx6XchoDdPpofBfxauArB/Vtb826BwZoVoTAgoglBKjUYqWqUrmeo3
 seRFWR2SpJc5DMR16l87RhX4IPlmaKEEgnQJGnqNfJafdjI++JXkugweFSHw0i4J1w
 fVw4UVoP5qcVA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A61dgoE2359272
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Jun 2025 14:01:39 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 14:01:39 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 10 Jun 2025 14:01:39 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH 5/8] net/r8169: add RTL8127AP dash support
Date: Tue, 10 Jun 2025 14:01:20 +0800
Message-ID: <20250610060123.4104-5-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610060123.4104-1-howard_wang@realsil.com.cn>
References: <20250610060123.4104-1-howard_wang@realsil.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_dash.c |  1 +
 drivers/net/r8169/r8169_hw.c   | 32 ++++++++++----------------------
 drivers/net/r8169/r8169_phy.c  | 34 ++--------------------------------
 3 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/drivers/net/r8169/r8169_dash.c b/drivers/net/r8169/r8169_dash.c
index 1fdbe5c4ae..384344373f 100644
--- a/drivers/net/r8169/r8169_dash.c
+++ b/drivers/net/r8169/r8169_dash.c
@@ -32,6 +32,7 @@ rtl_is_allow_access_dash_ocp(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_91:
 		mac_ocp_data = rtl_mac_ocp_read(hw, 0xd4c0);
 		if (mac_ocp_data == 0xffff || (mac_ocp_data & BIT_3))
 			allow_access = false;
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 002dc25ef7..e5a45f6810 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -334,6 +334,7 @@ rtl_oob_mutex_lock(struct rtl_hw *hw)
 	case CFG_METHOD_52:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_91:
 		ocp_reg_mutex_oob = 0x110;
 		ocp_reg_mutex_ib = 0x114;
 		ocp_reg_mutex_prio = 0x11C;
@@ -392,6 +393,7 @@ rtl_oob_mutex_unlock(struct rtl_hw *hw)
 	case CFG_METHOD_52:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_91:
 		ocp_reg_mutex_ib = 0x114;
 		ocp_reg_mutex_prio = 0x11C;
 		break;
@@ -1057,15 +1059,7 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	mac_ocp_data |= BIT_0;
 	rtl_mac_ocp_write(hw, 0xEA1C, mac_ocp_data);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-		rtl_oob_mutex_lock(hw);
-		break;
-	}
+	rtl_oob_mutex_lock(hw);
 
 	/* MAC_PWRDWN_CR0 */
 	rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
@@ -1073,15 +1067,7 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	rtl_set_mac_ocp_bit(hw, 0xE052, (BIT_6 | BIT_5));
 	rtl_clear_mac_ocp_bit(hw, 0xE052, (BIT_3 | BIT_7));
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-		rtl_oob_mutex_unlock(hw);
-		break;
-	}
+	rtl_oob_mutex_unlock(hw);
 
 	/*
 	 * DMY_PWR_REG_0
@@ -1574,9 +1560,12 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
+	case CFG_METHOD_91:
 		tmp = (u8)rtl_mac_ocp_read(hw, 0xD006);
 		if (tmp == 0x02 || tmp == 0x04)
 			hw->HwSuppDashVer = 2;
+		else if (tmp == 0x03)
+			hw->HwSuppDashVer = 4;
 		break;
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
@@ -1615,6 +1604,8 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_23:
 	case CFG_METHOD_27:
 	case CFG_METHOD_28:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
 		hw->HwSuppOcpChannelVer = 2;
 		break;
 	case CFG_METHOD_31:
@@ -1625,13 +1616,10 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
+	case CFG_METHOD_91:
 		if (HW_DASH_SUPPORT_DASH(hw))
 			hw->HwSuppOcpChannelVer = 2;
 		break;
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-		hw->HwSuppOcpChannelVer = 2;
-		break;
 	default:
 		hw->HwSuppOcpChannelVer = 0;
 		break;
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index 44ffd49a56..677bca7800 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -1207,41 +1207,11 @@ rtl_disable_adv_eee(struct rtl_hw *hw)
 	if (hw->mcfg < CFG_METHOD_25 || hw->mcfg == CFG_METHOD_37)
 		return;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_23:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-		rtl_oob_mutex_lock(hw);
-		break;
-	}
+	rtl_oob_mutex_lock(hw);
 
 	_rtl_disable_adv_eee(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_23:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-		rtl_oob_mutex_unlock(hw);
-		break;
-	}
+	rtl_oob_mutex_unlock(hw);
 }
 
 static void
-- 
2.34.1

