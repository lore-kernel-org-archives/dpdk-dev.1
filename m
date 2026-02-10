Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFCEA3F0D
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 05:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E54E40430;
	Tue, 10 Feb 2026 06:55:23 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 32F25402DC
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:55:19 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61A5tHgW53127160,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770702917;
 bh=X+UaFn0J/4KoXtts/qdtkfHoUUharg16kMhZHPCKECE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=GEVTjdtloy2w0a8zay7lOqrIpqewEIiO5p8PN6UMfZsRIUd0Lb2SrgJzUkmKXvMV5
 6MJghQwxY/TUG4rVZQJa/mbKMxfcmpKqyfJTEWgRvvsb/yaTwrx4hZe5XCuNeJzI9O
 Y+9YkstVYTd4J71/2c3Vv7BwFT+Jsm48gUq84WQj1RkhDW9G97B38RChRGLoNRNdZQ
 aECP58pADAl761NRyJtijS5r6T6NTPC/z4vo/NjmX4xrWu8qg5ScT8BV3OAQo2PHLF
 1Uk5eXAeVwkcN2DjITtWyALlfmq1fHaWTpNee//rSQ6M69d30Av2mV7RjJp/x5BAkf
 xtT2/qR+bDtFw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61A5tHgW53127160
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:55:17 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 10 Feb 2026 13:55:16 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 10 Feb 2026 13:55:16 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 03/12] net/r8169: add support for RTL8168KD
Date: Tue, 10 Feb 2026 13:55:02 +0800
Message-ID: <20260210055511.62382-4-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210055511.62382-1-howard_wang@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
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

This chip supports network speeds up to 1Gbps.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/base/rtl8125d.c     |  15 +++-
 drivers/net/r8169/base/rtl8125d_mcu.c | 112 +++++++++++++++++++++++++-
 drivers/net/r8169/base/rtl8125d_mcu.h |   1 +
 drivers/net/r8169/r8169_compat.h      |   3 +-
 drivers/net/r8169/r8169_hw.c          |  64 ++++++++-------
 drivers/net/r8169/r8169_phy.c         |  18 ++---
 6 files changed, 168 insertions(+), 45 deletions(-)

diff --git a/drivers/net/r8169/base/rtl8125d.c b/drivers/net/r8169/base/rtl8125d.c
index 55bfdbcf21..29be122e6b 100644
--- a/drivers/net/r8169/base/rtl8125d.c
+++ b/drivers/net/r8169/base/rtl8125d.c
@@ -7,7 +7,10 @@
 #include "../r8169_phy.h"
 #include "rtl8125d_mcu.h"
 
-/* For RTL8125D, CFG_METHOD_56,57 */
+/*
+ * For RTL8125D, CFG_METHOD_56,57
+ * For RTL8168KD, CFG_METHOD_59
+ */
 
 static void
 hw_init_rxcfg_8125d(struct rtl_hw *hw)
@@ -22,6 +25,7 @@ hw_ephy_config_8125d(struct rtl_hw *hw)
 	switch (hw->mcfg) {
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_59:
 		/* Nothing to do */
 		break;
 	}
@@ -264,6 +268,7 @@ hw_phy_config_8125d(struct rtl_hw *hw)
 		rtl_hw_phy_config_8125d_1(hw);
 		break;
 	case CFG_METHOD_57:
+	case CFG_METHOD_59:
 		rtl_hw_phy_config_8125d_2(hw);
 		break;
 	}
@@ -277,10 +282,17 @@ hw_mac_mcu_config_8125d(struct rtl_hw *hw)
 
 	rtl_hw_disable_mac_mcu_bps(hw);
 
+	/* Get H/W mac mcu patch code version */
+	hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_56:
 		rtl_set_mac_mcu_8125d_1(hw);
 		break;
+	case CFG_METHOD_57:
+	case CFG_METHOD_59:
+		rtl_set_mac_mcu_8125d_2(hw);
+		break;
 	}
 }
 
@@ -292,6 +304,7 @@ hw_phy_mcu_config_8125d(struct rtl_hw *hw)
 		rtl_set_phy_mcu_8125d_1(hw);
 		break;
 	case CFG_METHOD_57:
+	case CFG_METHOD_59:
 		rtl_set_phy_mcu_8125d_2(hw);
 		break;
 	}
diff --git a/drivers/net/r8169/base/rtl8125d_mcu.c b/drivers/net/r8169/base/rtl8125d_mcu.c
index 2f6d1df584..c99681ad33 100644
--- a/drivers/net/r8169/base/rtl8125d_mcu.c
+++ b/drivers/net/r8169/base/rtl8125d_mcu.c
@@ -7,7 +7,10 @@
 #include "../r8169_phy.h"
 #include "rtl8125d_mcu.h"
 
-/* For RTL8125D, CFG_METHOD_56,57 */
+/*
+ * For RTL8125D, CFG_METHOD_56,57
+ * For RTL8168KD, CFG_METHOD_59
+ */
 
 /* ------------------------------------MAC 8125D------------------------------------- */
 
@@ -110,6 +113,113 @@ rtl_set_mac_mcu_8125d_1(struct rtl_hw *hw)
 	rtl_mac_ocp_write(hw, 0xFC48, 0x0001);
 }
 
+void
+rtl_set_mac_mcu_8125d_2(struct rtl_hw *hw)
+{
+	u16 entry_cnt;
+	static const u16 mcu_patch_code[] = {
+		0xE010, 0xE014, 0xE016, 0xE018, 0xE01A, 0xE01C, 0xE01E, 0xE020, 0xE022,
+		0xE024, 0xE026, 0xE028, 0xE02A, 0xE02C, 0xE02E, 0xE030, 0xC104, 0xC202,
+		0xBA00, 0x2384, 0xD116, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x6938,
+		0x0A19, 0x030E, 0x0B2F
+	};
+
+	entry_cnt = ARRAY_SIZE(mcu_patch_code);
+
+	/* Get BIN mac mcu patch code version */
+	hw->bin_mcu_patch_code_ver = rtl_get_bin_mcu_patch_code_ver(mcu_patch_code,
+								    entry_cnt);
+
+	if (hw->hw_mcu_patch_code_ver != hw->bin_mcu_patch_code_ver)
+		rtl_write_mac_mcu_ram_code(hw, mcu_patch_code, entry_cnt);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+	rtl_mac_ocp_write(hw, 0xFC28, 0x2382);
+	rtl_mac_ocp_write(hw, 0xFC48, 0x0001);
+}
+
 /* ------------------------------------PHY 8125D--------------------------------------- */
 
 static const u16 phy_mcu_ram_code_8125d_1_1[] = {
diff --git a/drivers/net/r8169/base/rtl8125d_mcu.h b/drivers/net/r8169/base/rtl8125d_mcu.h
index 163e0e8123..82b70e5b53 100644
--- a/drivers/net/r8169/base/rtl8125d_mcu.h
+++ b/drivers/net/r8169/base/rtl8125d_mcu.h
@@ -6,6 +6,7 @@
 #define RTL8125D_MCU_H
 
 void rtl_set_mac_mcu_8125d_1(struct rtl_hw *hw);
+void rtl_set_mac_mcu_8125d_2(struct rtl_hw *hw);
 
 void rtl_set_phy_mcu_8125d_1(struct rtl_hw *hw);
 void rtl_set_phy_mcu_8125d_2(struct rtl_hw *hw);
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index ab6a984a54..d2d928cdd7 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -105,7 +105,7 @@ enum mcfg {
 	CFG_METHOD_69,
 	CFG_METHOD_70,
 	CFG_METHOD_71,
-	CFG_METHOD_91,
+	CFG_METHOD_91 = 91,
 	CFG_METHOD_MAX,
 	CFG_METHOD_DEFAULT = 0xFF
 };
@@ -525,6 +525,7 @@ enum RTL_chipset_name {
 	RTL8125BP,
 	RTL8125D,
 	RTL8125CP,
+	RTL8168KD,
 	RTL8126A,
 	RTL8168EP,
 	RTL8168FP,
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index e1521f5f9d..32c370deba 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -630,6 +630,7 @@ rtl_stop_all_request(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -687,6 +688,7 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -924,6 +926,7 @@ rtl8125_set_rx_desc_type(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~EnableRxDescV4_0);
 		break;
 	case CFG_METHOD_69:
@@ -1044,8 +1047,11 @@ rtl8125_hw_config(struct rtl_hw *hw)
 
 	rtl_oob_mutex_lock(hw);
 
-	/* MAC_PWRDWN_CR0 */
-	rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
+	if (hw->mcfg == CFG_METHOD_56 || hw->mcfg == CFG_METHOD_57 ||
+	    hw->mcfg == CFG_METHOD_59)
+		rtl_mac_ocp_write(hw, 0xE0C0, 0x4403);
+	else
+		rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
 
 	rtl_set_mac_ocp_bit(hw, 0xE052, (BIT_6 | BIT_5));
 	rtl_clear_mac_ocp_bit(hw, 0xE052, (BIT_3 | BIT_7));
@@ -1065,10 +1071,15 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	mac_ocp_data |= 0x45F;
 	rtl_mac_ocp_write(hw, 0xD430, mac_ocp_data);
 
-	if (!hw->DASH)
-		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_6 | BIT_7);
-	else
-		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~(BIT_6 | BIT_7));
+	if (hw->DASH) {
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_6);
+		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_7);
+	} else {
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_6);
+		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_6);
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_7);
+	}
 
 	if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
 	    hw->mcfg == CFG_METHOD_52)
@@ -1243,9 +1254,10 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 		hw->hw_ops = rtl8125bp_ops;
 		return 0;
-	/* 8125D */
+	/* 8125D and 8168KD */
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_59:
 		hw->hw_ops = rtl8125d_ops;
 		return 0;
 	/* 8125CP */
@@ -1538,6 +1550,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 		hw->chipset_name = RTL8125CP;
 		break;
+	case CFG_METHOD_59:
+		hw->chipset_name = RTL8168KD;
+		break;
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1688,6 +1703,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1710,6 +1726,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 	case CFG_METHOD_91:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
@@ -1801,6 +1818,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_56;
 		break;
 	case CFG_METHOD_57:
+	case CFG_METHOD_59:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_57;
 		break;
 	case CFG_METHOD_58:
@@ -1859,6 +1877,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 	case CFG_METHOD_91:
 		hw->HwSuppIntMitiVer = 6;
 		break;
@@ -1902,37 +1921,18 @@ rtl_exit_realwow(struct rtl_hw *hw)
 	u32 csi_tmp;
 
 	/* Disable realwow function */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
+	if (rtl_is_8125(hw)) {
+		rtl_mac_ocp_write(hw, 0xC0BC, 0x00FF);
+	} else if (hw->mcfg == CFG_METHOD_21 || hw->mcfg == CFG_METHOD_22) {
 		RTL_W32(hw, MACOCP, 0x605E0000);
 		RTL_W32(hw, MACOCP, (0xE05E << 16) |
 				    (RTL_R32(hw, MACOCP) & 0xFFFE));
 		RTL_W32(hw, MACOCP, 0xE9720000);
 		RTL_W32(hw, MACOCP, 0xF2140010);
-		break;
-	case CFG_METHOD_26:
+	} else if (hw->mcfg == CFG_METHOD_26) {
 		RTL_W32(hw, MACOCP, 0xE05E00FF);
 		RTL_W32(hw, MACOCP, 0xE9720000);
 		rtl_mac_ocp_write(hw, 0xE428, 0x0010);
-		break;
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-	case CFG_METHOD_56:
-	case CFG_METHOD_57:
-	case CFG_METHOD_58:
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
-		rtl_mac_ocp_write(hw, 0xC0BC, 0x00FF);
-		break;
 	}
 
 	switch (hw->mcfg) {
@@ -2059,7 +2059,7 @@ rtl_disable_ocp_phy_power_saving(struct rtl_hw *hw)
 			rtl_clear_phy_mcu_patch_request(hw);
 		}
 	} else if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
-		   hw->mcfg == CFG_METHOD_52){
+		   hw->mcfg == CFG_METHOD_52) {
 		val = rtl_mdio_direct_read_phy_ocp(hw, 0xC416);
 		if (val != 0x0050) {
 			rtl_set_phy_mcu_patch_request(hw);
@@ -2400,6 +2400,8 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->mcfg = CFG_METHOD_52;
 		else if (hw->mcfg == CFG_METHOD_51)
 			hw->mcfg = CFG_METHOD_53;
+		else if (hw->mcfg == CFG_METHOD_57)
+			hw->mcfg = CFG_METHOD_59;
 	}
 }
 
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index 50c24d1504..1239319da5 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -558,10 +558,6 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 	if (hw->mcfg >= CFG_METHOD_21 && hw->mcfg <= CFG_METHOD_36) {
 		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_6);
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
-	} else if ((hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_58) ||
-		   (hw->mcfg >= CFG_METHOD_69 && hw->mcfg <= CFG_METHOD_71) ||
-		   hw->mcfg == CFG_METHOD_91) {
-		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
 	}
 }
 
@@ -893,17 +889,14 @@ rtl_is_adv_eee_enabled(struct rtl_hw *hw)
 {
 	bool enabled = false;
 
-	if (hw->mcfg >= CFG_METHOD_25 && hw->mcfg <= CFG_METHOD_36) {
+	if (rtl_is_8125(hw)) {
+		if (rtl_mdio_direct_read_phy_ocp(hw, 0xA430) & BIT_15)
+			enabled = true;
+	} else if (hw->mcfg >= CFG_METHOD_25 && hw->mcfg <= CFG_METHOD_36) {
 		rtl_mdio_write(hw, 0x1F, 0x0A43);
 		if (rtl_mdio_read(hw, 0x10) & BIT_15)
 			enabled = true;
 		rtl_mdio_write(hw, 0x1F, 0x0000);
-	} else if ((hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_55) ||
-		   hw->mcfg == CFG_METHOD_58 || hw->mcfg == CFG_METHOD_69 ||
-		   hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
-		   hw->mcfg == CFG_METHOD_91){
-		if (rtl_mdio_direct_read_phy_ocp(hw, 0xA430) & BIT_15)
-			enabled = true;
 	}
 
 	return enabled;
@@ -982,6 +975,7 @@ _rtl_disable_adv_eee(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1068,6 +1062,7 @@ rtl_disable_eee(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xA432, BIT_4);
@@ -1232,6 +1227,7 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u64 adv)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_59:
 		mask |= BIT_0;
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_9);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, mask);
-- 
2.34.1

