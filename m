Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96ACD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 08:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8EB142F25;
	Thu, 11 Jun 2026 10:35:54 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 98BC842EF2
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:35:52 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B8ZoRdA1787339,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1781166950;
 bh=tiRXRRNZQ+viQafaaW3OGaYqrEd/Ijn+mrmsoO+FbjU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=QM+tgx0d+4Fgz75OF2pC/Jk5J72RSicb5YcMdzW/Nm3f3Q3c6HqVjWY/TvuVVp1Vv
 DNHEx7a+H7lB36XtyFI1PDmAGpxkV8I7yB5uWou1sWXJSkw0v150b5Bxl/EeuR+BAh
 /Fj+R3g+2IGVwpf7dm4MGuVHvBxaCHMTt7uPiNNQBkt24OpKweabkqwPCfbcv9W8lE
 XUIanINDoIZxGHeP1WFwfHrPFYHxS9uvBKmPSLLQGx1yEbgwWxwxUos4p25re64lsz
 pkNzj7JYq1kGorPl/UPSbgm0ZERTYYTzWiTP/q7dfifnIV84YpDJg4ojmj4P8LYNi1
 /nN4Tpj/puKJA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B8ZoRdA1787339
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:35:50 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 16:35:50 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 16:35:50 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 5/6] net/r8169: update hardware configurations for 8125
Date: Thu, 11 Jun 2026 16:28:32 +0800
Message-ID: <20260611083521.20669-6-howard_wang@realsil.com.cn>
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

Update hw configurations as below:
9151a's phy mcu,
9151a's phy config,
8125bp's mac mcu.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/base/rtl8125bp_mcu.c | 15 ++++++++-------
 drivers/net/r8169/base/rtl9151a.c      |  8 ++++++++
 drivers/net/r8169/base/rtl9151a_mcu.c  | 14 ++++++++++++--
 drivers/net/r8169/r8169_hw.h           |  2 +-
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/net/r8169/base/rtl8125bp_mcu.c b/drivers/net/r8169/base/rtl8125bp_mcu.c
index a591988657..56b036314c 100644
--- a/drivers/net/r8169/base/rtl8125bp_mcu.c
+++ b/drivers/net/r8169/base/rtl8125bp_mcu.c
@@ -59,8 +59,8 @@ rtl_set_mac_mcu_8125bp_2(struct rtl_hw *hw)
 {
 	u16 entry_cnt;
 	static const u16 mcu_patch_code[] = {
-		0xE010, 0xE033, 0xE046, 0xE04A, 0xE04D, 0xE050, 0xE054, 0xE056, 0xE058,
-		0xE05A, 0xE05C, 0xE05E, 0xE060, 0xE062, 0xE064, 0xE066, 0xB406, 0x1000,
+		0xE010, 0xE033, 0xE046, 0xE04A, 0xE04D, 0xE050, 0xE054, 0xE058, 0xE05A,
+		0xE05C, 0xE05E, 0xE060, 0xE062, 0xE064, 0xE066, 0xE068, 0xB406, 0x1000,
 		0xF016, 0xC61F, 0x400E, 0xF012, 0x218E, 0x25BE, 0x1300, 0xF007, 0x7340,
 		0xC618, 0x400E, 0xF102, 0x48B0, 0x8320, 0xB400, 0x2402, 0x1000, 0xF003,
 		0x7342, 0x8322, 0xB000, 0xE007, 0x7322, 0x9B42, 0x7320, 0x9B40, 0x0300,
@@ -69,10 +69,10 @@ rtl_set_mac_mcu_8125bp_2(struct rtl_hw *hw)
 		0x9B20, 0x1B00, 0x9BA0, 0xC602, 0xBE00, 0x4392, 0xE6E0, 0xE6E2, 0xC01C,
 		0x4166, 0x9CF6, 0xC002, 0xB800, 0x143C, 0x49D1, 0xC602, 0xBE00, 0x3FC4,
 		0x49D1, 0xC602, 0xBE00, 0x405A, 0xC104, 0xC202, 0xBA00, 0x22E6, 0xD116,
-		0xC602, 0xBE00, 0x0000, 0xC102, 0xB900, 0x0000, 0xC002, 0xB800, 0x0000,
-		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
-		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
-		0xC602, 0xBE00, 0x0000, 0x6936, 0x0119, 0x030E, 0x0B18
+		0x1BC8, 0x46EB, 0xC302, 0xBB00, 0x0F14, 0xC102, 0xB900, 0x0000, 0xC002,
+		0xB800, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602,
+		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602,
+		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0x1171, 0x011A, 0x041D, 0x131A
 	};
 
 	entry_cnt = ARRAY_SIZE(mcu_patch_code);
@@ -92,8 +92,9 @@ rtl_set_mac_mcu_8125bp_2(struct rtl_hw *hw)
 	rtl_mac_ocp_write(hw, 0xFC2E, 0x3FC2);
 	rtl_mac_ocp_write(hw, 0xFC30, 0x4058);
 	rtl_mac_ocp_write(hw, 0xFC32, 0x22E4);
+	rtl_mac_ocp_write(hw, 0xFC34, 0x0F10);
 
-	rtl_mac_ocp_write(hw, 0xFC48, 0x003F);
+	rtl_mac_ocp_write(hw, 0xFC48, 0x007F);
 }
 
 /* ------------------------------------PHY 8125BP--------------------------------------- */
diff --git a/drivers/net/r8169/base/rtl9151a.c b/drivers/net/r8169/base/rtl9151a.c
index 4eca5fb96b..54ea424703 100644
--- a/drivers/net/r8169/base/rtl9151a.c
+++ b/drivers/net/r8169/base/rtl9151a.c
@@ -38,6 +38,14 @@ rtl_hw_phy_config_9151a_1(struct rtl_hw *hw)
 
 	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x80B6);
 	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0xB6C3);
+
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_set_eth_phy_ocp_bit(hw, 0xA466, BIT_1);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x837C);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xA438, BIT_14);
+
+	rtl_clear_phy_mcu_patch_request(hw);
 }
 
 static void
diff --git a/drivers/net/r8169/base/rtl9151a_mcu.c b/drivers/net/r8169/base/rtl9151a_mcu.c
index 50a2cd90e6..d338daafce 100644
--- a/drivers/net/r8169/base/rtl9151a_mcu.c
+++ b/drivers/net/r8169/base/rtl9151a_mcu.c
@@ -31,8 +31,18 @@ static const u16 phy_mcu_ram_code_9151a_1_1[] = {
 	0xa436, 0xA108, 0xa438, 0xffff, 0xa436, 0xA106, 0xa438, 0xffff,
 	0xa436, 0xA104, 0xa438, 0xffff, 0xa436, 0xA102, 0xa438, 0x0cb4,
 	0xa436, 0xA100, 0xa438, 0x1398, 0xa436, 0xA110, 0xa438, 0x0003,
-	0xb820, 0x0010, 0xB82E, 0x0000, 0xa436, 0x8023, 0xa438, 0x0000,
-	0xB820, 0x0000, 0xFFFF, 0xFFFF
+	0xb820, 0x0010, 0xa436, 0x844e, 0xa438, 0xaf84, 0xa438, 0x66af,
+	0xa438, 0x847b, 0xa438, 0xaf84, 0xa438, 0x7baf, 0xa438, 0x847b,
+	0xa438, 0xaf84, 0xa438, 0x7baf, 0xa438, 0x847b, 0xa438, 0xaf84,
+	0xa438, 0x7baf, 0xa438, 0x847b, 0xa438, 0xd400, 0xa438, 0x04bf,
+	0xa438, 0x645d, 0xa438, 0x026a, 0xa438, 0x4cd4, 0xa438, 0x0004,
+	0xa438, 0xbf64, 0xa438, 0x6002, 0xa438, 0x6a4c, 0xa438, 0xaf61,
+	0xa438, 0x1600, 0xa436, 0xb818, 0xa438, 0x6110, 0xa436, 0xb81a,
+	0xa438, 0xffff, 0xa436, 0xb81c, 0xa438, 0xffff, 0xa436, 0xb81e,
+	0xa438, 0xffff, 0xa436, 0xb850, 0xa438, 0x03d1, 0xa436, 0xb852,
+	0xa438, 0xffff, 0xa436, 0xb878, 0xa438, 0xffff, 0xa436, 0xb884,
+	0xa438, 0xffff, 0xa436, 0xb832, 0xa438, 0x0001, 0xB82E, 0x0000,
+	0xa436, 0x8023, 0xa438, 0x0000, 0xB820, 0x0000, 0xFFFF, 0xFFFF
 };
 
 static void
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index 65007c2a7e..475bbbb016 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -138,7 +138,7 @@ extern const struct rtl_hw_ops rtl8125cp_ops;
 #define NIC_RAMCODE_VERSION_CFG_METHOD_56  (0x0027)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_57  (0x0034)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_58  (0x0024)
-#define NIC_RAMCODE_VERSION_CFG_METHOD_60  (0x0003)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_60  (0x0017)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_70  (0x0033)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_71  (0x0060)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_91  (0x0051)
-- 
2.43.0

