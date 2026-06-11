Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11094CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65D8642F15;
	Thu, 11 Jun 2026 10:35:40 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 8818F42F13
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:35:38 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8ZZllC1787161,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166936;
 bh=/c42VExY6byHCM6jN7SM+8sHZxkUWuXPjCo9ZUQ5d5Q=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=h9lS/nHyzJE8tgURO2jFHFrxX+NPrWZA52p3tD8HZ9+XpyZR0fPgs0AbCfXvZ50U1
 5oy8qyQOQvwRA/NqD8slpQnKsvtZIzJhm1BLY88AI6psoJQlQfOrLnpWMad9QN+s/r
 WUxtZhpgdkm0ddo4mYZMDNDN+nWYcpvPmjb/v5H9yEs8O/1I6N52jPhC0zlqknsX/I
 fBEIxpORgeFtbyOuL/S6nUdMvrqMiHt5YhUDaOrYxGW7d0ExrkGVs4A4Iy5aprRuAl
 9SCLmPBl8CL+Zr0Rti2jTdd/q07B6EU9mf29bbrjlX1/gI3WVrkvxpc8gdCqkrjj/R
 4GXIsHzMFvLnQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8ZZllC1787161
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:35:36 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:36 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:36 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 1/6] net/r8169: disable RX CRC drop for RTL8125BP and later
Date: Thu, 11 Jun 2026 16:28:28 +0800
Message-ID: <20260611083521.20669-2-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611083521.20669-1-howard_wang@realsil.com.cn>
References: <20260611083521.20669-1-howard_wang@realsil.com.cn>
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

When RX drop CRC is enabled, the hardware will not DMA the RX CRC,
and the packet length in the RX descriptor will not include the CRC
length.
Other OS drivers might leave this feature enabled instead of disabling
it during their shutdown sequence. To avoid driver conflicts and
unexpected behavior upon reboot or driver reload, explicitly disable
this feature for RTL8125BP and all subsequent MAC versions.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/r8169_compat.h |  1 +
 drivers/net/r8169/r8169_hw.c     | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index 91c84c7633..28f0bfc246 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -347,6 +347,7 @@ enum RTL_register_content {
 	RxCfg_pause_slot_en = (1 << 11),
 	RxCfg_9356SEL       = (1 << 6),
 	EnableRxDescV4_0    = (1 << 1), /* Not in rcr */
+	RX_CRC_DROP_EN      = (1 << 0),
 
 	/* TX config bits */
 	TxInterFrameGapShift = 24,
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 27d52c81c9..e5434165ba 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -911,6 +911,29 @@ rtl8125_set_rx_desc_type(struct rtl_hw *hw)
 	}
 }
 
+static void
+rtl8125_set_rx_crc_drop(struct rtl_hw *hw, bool enable)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_58:
+	case CFG_METHOD_59:
+	case CFG_METHOD_60:
+	case CFG_METHOD_61:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+	case CFG_METHOD_91:
+		if (enable)
+			RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) | RX_CRC_DROP_EN);
+		else
+			RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~RX_CRC_DROP_EN);
+		break;
+	}
+}
+
 static void
 rtl8125_hw_config(struct rtl_hw *hw)
 {
@@ -967,6 +990,8 @@ rtl8125_hw_config(struct rtl_hw *hw)
 
 	rtl8125_set_rx_desc_type(hw);
 
+	rtl8125_set_rx_crc_drop(hw, false);
+
 	if (hw->mcfg == CFG_METHOD_58 || hw->mcfg == CFG_METHOD_91) {
 		rtl_clear_mac_ocp_bit(hw, 0xE00C, BIT_12);
 		rtl_clear_mac_ocp_bit(hw, 0xC0C2, BIT_6);
-- 
2.43.0

