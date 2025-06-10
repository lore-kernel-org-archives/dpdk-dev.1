Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2529CC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68E7142D7F;
	Tue, 10 Jun 2025 08:01:44 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 97A6E427D4
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:01:39 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A61byxE2359268,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749535298;
 bh=GoNxtyJRJTNn0yv0RxrRdZOn8JcAzAG4/EGeqVkfTT8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=UHpFlyc4cuLgIn0PTbBttgwAsbDjJURPYBTSE6GPh48p8q+N4NBmQzPQc4wdG66ja
 L9F5oXkrcNddLtFs1Ua2LBnQuD/spZ8I+sFWVC+F927KZmtgjsTgh+tkqk/Dw+3ZLa
 B2T/7QOoADcQcg3SzFdB1+ssbbVJqgt2UdxgYnsTGLLfaEh2Q4OlANQATvfbzo7aYg
 yWZHPGe2yjgfhSt9ScLzo54VaD/wA7m9IffdyRzVDruMLnhOfxdWLGARWx1JCrlm3M
 cexK4SlVYD6syBOjt5v63Ju/jn33iKRJuwBdHBe9461AFM69ybmrPtJjyeMNLO7Nb2
 zM8q1BRwPmOCg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A61byxE2359268
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Jun 2025 14:01:37 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 14:01:37 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 10 Jun 2025 14:01:37 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH 4/8] net/r8169: remove cmac feature for RTL8125AP
Date: Tue, 10 Jun 2025 14:01:19 +0800
Message-ID: <20250610060123.4104-4-howard_wang@realsil.com.cn>
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
 drivers/net/r8169/r8169_dash.c | 23 +++++++++++------------
 drivers/net/r8169/r8169_dash.h |  1 +
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/r8169/r8169_dash.c b/drivers/net/r8169/r8169_dash.c
index c26d7a5280..1fdbe5c4ae 100644
--- a/drivers/net/r8169/r8169_dash.c
+++ b/drivers/net/r8169/r8169_dash.c
@@ -63,18 +63,23 @@ _rtl_check_dash(struct rtl_hw *hw)
 	if (!hw->AllowAccessDashOcp)
 		return 0;
 
-	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_3(hw) ||
-	    HW_DASH_SUPPORT_TYPE_4(hw)) {
+	switch (hw->HwSuppDashVer) {
+	case 2:
+		if (rtl_is_8125(hw))
+			return 0;
+	/* Fall through */
+	case 3:
+	case 4:
 		if (rtl_ocp_read(hw, 0x128, 1) & BIT_0)
 			return 1;
 		else
 			return 0;
-	} else if (HW_DASH_SUPPORT_TYPE_1(hw)) {
+	case 1:
 		if (rtl_ocp_read(hw, 0x10, 2) & 0x00008000)
 			return 1;
 		else
 			return 0;
-	} else {
+	default:
 		return 0;
 	}
 }
@@ -193,7 +198,7 @@ rtl8168_csi_to_cmac_w8(struct rtl_hw *hw, u32 reg, u8 value)
 static void
 rtl_cmac_w8(struct rtl_hw *hw, u32 reg, u8 value)
 {
-	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_4(hw))
+	if (HW_DASH_SUPPORT_TYPE_2(hw))
 		RTL_CMAC_W8(hw, reg, value);
 	else if (HW_DASH_SUPPORT_TYPE_3(hw))
 		rtl8168_csi_to_cmac_w8(hw, reg, value);
@@ -202,7 +207,7 @@ rtl_cmac_w8(struct rtl_hw *hw, u32 reg, u8 value)
 static u8
 rtl_cmac_r8(struct rtl_hw *hw, u32 reg)
 {
-	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_4(hw))
+	if (HW_DASH_SUPPORT_TYPE_2(hw))
 		return RTL_CMAC_R8(hw, reg);
 	else if (HW_DASH_SUPPORT_TYPE_3(hw))
 		return rtl8168_csi_to_cmac_r8(hw, reg);
@@ -270,9 +275,6 @@ rtl8125_notify_dash_oob_cmac(struct rtl_hw *hw, u32 cmd)
 static void
 rtl8125_notify_dash_oob_ipc2(struct rtl_hw *hw, u32 cmd)
 {
-	if (!HW_DASH_SUPPORT_TYPE_4(hw))
-		return;
-
 	rtl_ocp_write(hw, IB2SOC_DATA, 4, cmd);
 	rtl_ocp_write(hw, IB2SOC_CMD, 4, 0x00);
 	rtl_ocp_write(hw, IB2SOC_SET, 4, 0x01);
@@ -554,9 +556,6 @@ rtl8125_driver_stop(struct rtl_hw *hw)
 	if (!hw->AllowAccessDashOcp)
 		return;
 
-	if (HW_DASH_SUPPORT_CMAC(hw))
-		rtl_dash2_disable_txrx(hw);
-
 	rtl8125_notify_dash_oob(hw, OOB_CMD_DRIVER_STOP);
 
 	rtl_wait_dash_fw_ready(hw);
diff --git a/drivers/net/r8169/r8169_dash.h b/drivers/net/r8169/r8169_dash.h
index 47c5d6906e..7c31658573 100644
--- a/drivers/net/r8169/r8169_dash.h
+++ b/drivers/net/r8169/r8169_dash.h
@@ -20,6 +20,7 @@
 #define HW_DASH_SUPPORT_TYPE_3(_M)      ((_M)->HwSuppDashVer == 3)
 #define HW_DASH_SUPPORT_TYPE_4(_M)      ((_M)->HwSuppDashVer == 4)
 #define HW_DASH_SUPPORT_CMAC(_M)        (HW_DASH_SUPPORT_TYPE_2(_M) || HW_DASH_SUPPORT_TYPE_3(_M))
+#define HW_DASH_SUPPORT_IPC2(_M)        (HW_DASH_SUPPORT_TYPE_4(_M))
 #define HW_DASH_SUPPORT_GET_FIRMWARE_VERSION(_M) (HW_DASH_SUPPORT_TYPE_2(_M) || \
 						  HW_DASH_SUPPORT_TYPE_3(_M) || \
 						  HW_DASH_SUPPORT_TYPE_4(_M))
-- 
2.34.1

