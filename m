Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50042C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44FD042DD0;
	Tue, 10 Jun 2025 08:23:04 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 4428342C24
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:22:59 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A6Mu0yA2379758,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749536577;
 bh=8oIWmE7bRjwvrbJRQ1Vj3O/NJuOksUtgvYiJgN1kJsE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=M159uZWSVqmgQYnGdjm18Pcr8q8kMnygi5WHTF0pbsBaiBcP+VZV4RMPRvfXidumW
 cF1vP9rsiJ1kvo5kSK7Xfl30VcuA1paxewhaJzZNe3/9g05Oc87imNDlidBAjFsHBt
 vsFMtICmrOGXqhXk+DId5swLPS7GxW8eeE3kTwEnO8MRexVWZgkkSkiFviUtLcTZU7
 JZlQCEfgfY+xkiL8ePWeMAVhfGbKnfwnqjStUdnjoEnC9tGRfjzP0BzZqpsZVDvOv3
 dfqvkQU6VvW4Sdc5ys8DuH4xgQEETXO2hQdIAkcv1NsQMA6gjCvEdu9l+LdwQpL/kL
 E51k2tPjnWHhg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A6Mu0yA2379758
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Jun 2025 14:22:57 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 14:22:56 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 10 Jun 2025 14:22:56 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 3/8] net/r8169: add support for RTL8127
Date: Tue, 10 Jun 2025 14:22:36 +0800
Message-ID: <20250610062241.4517-4-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610062241.4517-1-howard_wang@realsil.com.cn>
References: <20250610062241.4517-1-howard_wang@realsil.com.cn>
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
 doc/guides/nics/r8169.rst              |    5 +-
 drivers/net/r8169/base/rtl8125a.c      |    8 +-
 drivers/net/r8169/base/rtl8125a.h      |    1 -
 drivers/net/r8169/base/rtl8125a_mcu.c  |   17 +-
 drivers/net/r8169/base/rtl8125b.c      |    5 +-
 drivers/net/r8169/base/rtl8125b.h      |    1 -
 drivers/net/r8169/base/rtl8125b_mcu.c  |    8 -
 drivers/net/r8169/base/rtl8125bp.c     |    5 +
 drivers/net/r8169/base/rtl8125bp_mcu.c |   28 +-
 drivers/net/r8169/base/rtl8125d.c      |    5 +-
 drivers/net/r8169/base/rtl8125d_mcu.c  |    8 +-
 drivers/net/r8169/base/rtl8125d_mcu.h  |    1 -
 drivers/net/r8169/base/rtl8126a.c      |    5 +
 drivers/net/r8169/base/rtl8126a_mcu.c  |   20 +-
 drivers/net/r8169/base/rtl8127.c       |  365 ++++++++
 drivers/net/r8169/base/rtl8127_mcu.c   |  616 ++++++++++++++
 drivers/net/r8169/base/rtl8127_mcu.h   |   12 +
 drivers/net/r8169/base/rtl8168kb.c     |    5 +
 drivers/net/r8169/meson.build          |    2 +
 drivers/net/r8169/r8169_compat.h       |   52 +-
 drivers/net/r8169/r8169_ethdev.c       |  121 +--
 drivers/net/r8169/r8169_ethdev.h       |    4 +-
 drivers/net/r8169/r8169_hw.c           | 1050 ++++++++----------------
 drivers/net/r8169/r8169_hw.h           |    8 +
 drivers/net/r8169/r8169_phy.c          |  523 +++++-------
 drivers/net/r8169/r8169_phy.h          |    7 +-
 drivers/net/r8169/r8169_rxtx.c         |   64 +-
 27 files changed, 1701 insertions(+), 1245 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl8127.c
 create mode 100644 drivers/net/r8169/base/rtl8127_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8127_mcu.h

diff --git a/doc/guides/nics/r8169.rst b/doc/guides/nics/r8169.rst
index f3c547c4d4..c0eeb5ec6a 100644
--- a/doc/guides/nics/r8169.rst
+++ b/doc/guides/nics/r8169.rst
@@ -4,8 +4,8 @@
 R8169 Poll Mode Driver
 ======================
 
-The R8169 PMD provides poll mode driver support for Realtek 1, 2.5 and 5 Gigabit
-Ethernet NICs.
+The R8169 PMD provides poll mode driver support for Realtek 1, 2.5, 5 and 10
+Gigabit Ethernet NICs.
 
 More information about Realtek 1G Ethernet NIC can be found at `RTL8168
 <https://www.realtek.com/Product/Index?id=4080>`_.
@@ -22,6 +22,7 @@ Supported Chipsets and NICs
 - Realtek RTL8168 1 Gigabit Ethernet Controller
 - Realtek RTL8125 2.5 Gigabit Ethernet Controller
 - Realtek RTL8126 5 Gigabit Ethernet Controller
+- Realtek RTL8127 10 Gigabit Ethernet Controller
 
 Features
 --------
diff --git a/drivers/net/r8169/base/rtl8125a.c b/drivers/net/r8169/base/rtl8125a.c
index 39ab308d51..114727b717 100644
--- a/drivers/net/r8169/base/rtl8125a.c
+++ b/drivers/net/r8169/base/rtl8125a.c
@@ -380,10 +380,12 @@ hw_mac_mcu_config_8125a(struct rtl_hw *hw)
 	if (hw->NotWrMcuPatchCode)
 		return;
 
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	/* Get H/W mac mcu patch code version */
+	hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
 	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-		rtl_set_mac_mcu_8125a_1(hw);
-		break;
 	case CFG_METHOD_49:
 		rtl_set_mac_mcu_8125a_2(hw);
 		break;
diff --git a/drivers/net/r8169/base/rtl8125a.h b/drivers/net/r8169/base/rtl8125a.h
index 0b2e0492ab..e1f98fa40a 100644
--- a/drivers/net/r8169/base/rtl8125a.h
+++ b/drivers/net/r8169/base/rtl8125a.h
@@ -5,7 +5,6 @@
 #ifndef RTL8125A_H
 #define RTL8125A_H
 
-void rtl_set_mac_mcu_8125a_1(struct rtl_hw *hw);
 void rtl_set_mac_mcu_8125a_2(struct rtl_hw *hw);
 
 void rtl_set_phy_mcu_8125a_1(struct rtl_hw *hw);
diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c b/drivers/net/r8169/base/rtl8125a_mcu.c
index e2d56102fb..b810787daa 100644
--- a/drivers/net/r8169/base/rtl8125a_mcu.c
+++ b/drivers/net/r8169/base/rtl8125a_mcu.c
@@ -11,15 +11,10 @@
 
 /* ------------------------------------MAC 8125A------------------------------------- */
 
-void
-rtl_set_mac_mcu_8125a_1(struct rtl_hw *hw)
-{
-	rtl_hw_disable_mac_mcu_bps(hw);
-}
-
 void
 rtl_set_mac_mcu_8125a_2(struct rtl_hw *hw)
 {
+	u16 entry_cnt;
 	static const u16 mcu_patch_code_8125a_2[] = {
 		0xE010, 0xE012, 0xE022, 0xE024, 0xE029, 0xE02B, 0xE094, 0xE09D, 0xE09F,
 		0xE0AA, 0xE0B5, 0xE0C6, 0xE0CC, 0xE0D1, 0xE0D6, 0xE0D8, 0xC602, 0xBE00,
@@ -109,10 +104,14 @@ rtl_set_mac_mcu_8125a_2(struct rtl_hw *hw)
 		0x0B15, 0x090E, 0x1139
 	};
 
-	rtl_hw_disable_mac_mcu_bps(hw);
+	entry_cnt = ARRAY_SIZE(mcu_patch_code_8125a_2);
+
+	/* Get BIN mac mcu patch code version */
+	hw->bin_mcu_patch_code_ver = rtl_get_bin_mcu_patch_code_ver(mcu_patch_code_8125a_2,
+								    entry_cnt);
 
-	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8125a_2,
-				   ARRAY_SIZE(mcu_patch_code_8125a_2));
+	if (hw->hw_mcu_patch_code_ver != hw->bin_mcu_patch_code_ver)
+		rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8125a_2, entry_cnt);
 
 	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
 
diff --git a/drivers/net/r8169/base/rtl8125b.c b/drivers/net/r8169/base/rtl8125b.c
index 06cd125bcf..3b094f3080 100644
--- a/drivers/net/r8169/base/rtl8125b.c
+++ b/drivers/net/r8169/base/rtl8125b.c
@@ -362,10 +362,9 @@ hw_mac_mcu_config_8125b(struct rtl_hw *hw)
 	if (hw->NotWrMcuPatchCode)
 		return;
 
+	rtl_hw_disable_mac_mcu_bps(hw);
+
 	switch (hw->mcfg) {
-	case CFG_METHOD_50:
-		rtl_set_mac_mcu_8125b_1(hw);
-		break;
 	case CFG_METHOD_51:
 		rtl_set_mac_mcu_8125b_2(hw);
 		break;
diff --git a/drivers/net/r8169/base/rtl8125b.h b/drivers/net/r8169/base/rtl8125b.h
index ec63446e89..b2df6746be 100644
--- a/drivers/net/r8169/base/rtl8125b.h
+++ b/drivers/net/r8169/base/rtl8125b.h
@@ -5,7 +5,6 @@
 #ifndef RTL8125B_H
 #define RTL8125B_H
 
-void rtl_set_mac_mcu_8125b_1(struct rtl_hw *hw);
 void rtl_set_mac_mcu_8125b_2(struct rtl_hw *hw);
 
 void rtl_set_phy_mcu_8125b_1(struct rtl_hw *hw);
diff --git a/drivers/net/r8169/base/rtl8125b_mcu.c b/drivers/net/r8169/base/rtl8125b_mcu.c
index 03b004b430..afc17707ec 100644
--- a/drivers/net/r8169/base/rtl8125b_mcu.c
+++ b/drivers/net/r8169/base/rtl8125b_mcu.c
@@ -11,12 +11,6 @@
 
 /* ------------------------------------MAC 8125B------------------------------------- */
 
-void
-rtl_set_mac_mcu_8125b_1(struct rtl_hw *hw)
-{
-	rtl_hw_disable_mac_mcu_bps(hw);
-}
-
 void
 rtl_set_mac_mcu_8125b_2(struct rtl_hw *hw)
 {
@@ -38,8 +32,6 @@ rtl_set_mac_mcu_8125b_2(struct rtl_hw *hw)
 		0x0000, 0xC602, 0xBE00, 0x0000
 	};
 
-	rtl_hw_disable_mac_mcu_bps(hw);
-
 	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8125b_2,
 				   ARRAY_SIZE(mcu_patch_code_8125b_2));
 
diff --git a/drivers/net/r8169/base/rtl8125bp.c b/drivers/net/r8169/base/rtl8125bp.c
index 19d0d256af..fe546cf9a3 100644
--- a/drivers/net/r8169/base/rtl8125bp.c
+++ b/drivers/net/r8169/base/rtl8125bp.c
@@ -83,6 +83,11 @@ hw_mac_mcu_config_8125bp(struct rtl_hw *hw)
 	if (hw->NotWrMcuPatchCode)
 		return;
 
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	/* Get H/W mac mcu patch code version */
+	hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_54:
 		rtl_set_mac_mcu_8125bp_1(hw);
diff --git a/drivers/net/r8169/base/rtl8125bp_mcu.c b/drivers/net/r8169/base/rtl8125bp_mcu.c
index 05e04dbf84..2a9d0a3d48 100644
--- a/drivers/net/r8169/base/rtl8125bp_mcu.c
+++ b/drivers/net/r8169/base/rtl8125bp_mcu.c
@@ -14,7 +14,8 @@
 void
 rtl_set_mac_mcu_8125bp_1(struct rtl_hw *hw)
 {
-	static const u16 mcu_patch_code_8125bp_1[] = {
+	u16 entry_cnt;
+	static const u16 mcu_patch_code[] = {
 		0xE010, 0xE014, 0xE027, 0xE04A, 0xE04D, 0xE050, 0xE052, 0xE054, 0xE056,
 		0xE058, 0xE05A, 0xE05C, 0xE05E, 0xE060, 0xE062, 0xE064, 0x1BC8, 0x46EB,
 		0xC302, 0xBB00, 0x0F14, 0xC211, 0x400A, 0xF00A, 0xC20F, 0x400A, 0xF007,
@@ -31,10 +32,14 @@ rtl_set_mac_mcu_8125bp_1(struct rtl_hw *hw)
 		0x0000, 0x6936, 0x0A18, 0x0C02, 0x0D21
 	};
 
-	rtl_hw_disable_mac_mcu_bps(hw);
+	entry_cnt = ARRAY_SIZE(mcu_patch_code);
 
-	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8125bp_1,
-				   ARRAY_SIZE(mcu_patch_code_8125bp_1));
+	/* Get BIN mac mcu patch code version */
+	hw->bin_mcu_patch_code_ver = rtl_get_bin_mcu_patch_code_ver(mcu_patch_code,
+								    entry_cnt);
+
+	if (hw->hw_mcu_patch_code_ver != hw->bin_mcu_patch_code_ver)
+		rtl_write_mac_mcu_ram_code(hw, mcu_patch_code, entry_cnt);
 
 	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
 
@@ -52,7 +57,8 @@ rtl_set_mac_mcu_8125bp_1(struct rtl_hw *hw)
 void
 rtl_set_mac_mcu_8125bp_2(struct rtl_hw *hw)
 {
-	static const u16 mcu_patch_code_8125bp_2[] = {
+	u16 entry_cnt;
+	static const u16 mcu_patch_code[] = {
 		0xE010, 0xE033, 0xE046, 0xE04A, 0xE04D, 0xE050, 0xE052, 0xE054, 0xE056,
 		0xE058, 0xE05A, 0xE05C, 0xE05E, 0xE060, 0xE062, 0xE064, 0xB406, 0x1000,
 		0xF016, 0xC61F, 0x400E, 0xF012, 0x218E, 0x25BE, 0x1300, 0xF007, 0x7340,
@@ -68,9 +74,15 @@ rtl_set_mac_mcu_8125bp_2(struct rtl_hw *hw)
 		0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00,
 		0x0000, 0x6936, 0x0B18, 0x0C02, 0x0D22
 	};
-	rtl_hw_disable_mac_mcu_bps(hw);
-	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8125bp_2,
-				   ARRAY_SIZE(mcu_patch_code_8125bp_2));
+
+	entry_cnt = ARRAY_SIZE(mcu_patch_code);
+
+	/* Get BIN mac mcu patch code version */
+	hw->bin_mcu_patch_code_ver = rtl_get_bin_mcu_patch_code_ver(mcu_patch_code,
+								    entry_cnt);
+
+	if (hw->hw_mcu_patch_code_ver != hw->bin_mcu_patch_code_ver)
+		rtl_write_mac_mcu_ram_code(hw, mcu_patch_code, entry_cnt);
 
 	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
 
diff --git a/drivers/net/r8169/base/rtl8125d.c b/drivers/net/r8169/base/rtl8125d.c
index 3d4b60abc9..55bfdbcf21 100644
--- a/drivers/net/r8169/base/rtl8125d.c
+++ b/drivers/net/r8169/base/rtl8125d.c
@@ -275,13 +275,12 @@ hw_mac_mcu_config_8125d(struct rtl_hw *hw)
 	if (hw->NotWrMcuPatchCode)
 		return;
 
+	rtl_hw_disable_mac_mcu_bps(hw);
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_56:
 		rtl_set_mac_mcu_8125d_1(hw);
 		break;
-	case CFG_METHOD_57:
-		rtl_set_mac_mcu_8125d_2(hw);
-		break;
 	}
 }
 
diff --git a/drivers/net/r8169/base/rtl8125d_mcu.c b/drivers/net/r8169/base/rtl8125d_mcu.c
index 8f01b5414e..2f6d1df584 100644
--- a/drivers/net/r8169/base/rtl8125d_mcu.c
+++ b/drivers/net/r8169/base/rtl8125d_mcu.c
@@ -102,7 +102,7 @@ rtl_set_mac_mcu_8125d_1(struct rtl_hw *hw)
 		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x6938,
 		0x0A18, 0x0217, 0x0D2A
 	};
-	rtl_hw_disable_mac_mcu_bps(hw);
+
 	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8125d_1,
 				   ARRAY_SIZE(mcu_patch_code_8125d_1));
 	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
@@ -110,12 +110,6 @@ rtl_set_mac_mcu_8125d_1(struct rtl_hw *hw)
 	rtl_mac_ocp_write(hw, 0xFC48, 0x0001);
 }
 
-void
-rtl_set_mac_mcu_8125d_2(struct rtl_hw *hw)
-{
-	rtl_hw_disable_mac_mcu_bps(hw);
-}
-
 /* ------------------------------------PHY 8125D--------------------------------------- */
 
 static const u16 phy_mcu_ram_code_8125d_1_1[] = {
diff --git a/drivers/net/r8169/base/rtl8125d_mcu.h b/drivers/net/r8169/base/rtl8125d_mcu.h
index 82b70e5b53..163e0e8123 100644
--- a/drivers/net/r8169/base/rtl8125d_mcu.h
+++ b/drivers/net/r8169/base/rtl8125d_mcu.h
@@ -6,7 +6,6 @@
 #define RTL8125D_MCU_H
 
 void rtl_set_mac_mcu_8125d_1(struct rtl_hw *hw);
-void rtl_set_mac_mcu_8125d_2(struct rtl_hw *hw);
 
 void rtl_set_phy_mcu_8125d_1(struct rtl_hw *hw);
 void rtl_set_phy_mcu_8125d_2(struct rtl_hw *hw);
diff --git a/drivers/net/r8169/base/rtl8126a.c b/drivers/net/r8169/base/rtl8126a.c
index cd6ac5e4e9..047ef83587 100644
--- a/drivers/net/r8169/base/rtl8126a.c
+++ b/drivers/net/r8169/base/rtl8126a.c
@@ -491,6 +491,11 @@ hw_mac_mcu_config_8126a(struct rtl_hw *hw)
 	if (hw->NotWrMcuPatchCode)
 		return;
 
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	/* Get H/W mac mcu patch code version */
+	hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_69:
 		rtl_set_mac_mcu_8126a_1(hw);
diff --git a/drivers/net/r8169/base/rtl8126a_mcu.c b/drivers/net/r8169/base/rtl8126a_mcu.c
index ba8112d723..759e2df7cf 100644
--- a/drivers/net/r8169/base/rtl8126a_mcu.c
+++ b/drivers/net/r8169/base/rtl8126a_mcu.c
@@ -25,8 +25,6 @@ rtl_set_mac_mcu_8126a_1(struct rtl_hw *hw)
 		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000
 	};
 
-	rtl_hw_disable_mac_mcu_bps(hw);
-
 	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code_8126a_1,
 				   ARRAY_SIZE(mcu_patch_code_8126a_1));
 
@@ -67,10 +65,13 @@ rtl_set_mac_mcu_8126a_2(struct rtl_hw *hw)
 		0x0000, 0xC602, 0xBE00, 0x0000, 0x6847, 0x0A18, 0x0C02, 0x0B30
 	};
 
-	rtl_hw_disable_mac_mcu_bps(hw);
+	/* Get BIN mac mcu patch code version */
+	hw->bin_mcu_patch_code_ver = rtl_get_bin_mcu_patch_code_ver(mcu_patch_code,
+								    ARRAY_SIZE(mcu_patch_code));
 
-	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code,
-				   ARRAY_SIZE(mcu_patch_code));
+	if (hw->hw_mcu_patch_code_ver != hw->bin_mcu_patch_code_ver)
+		rtl_write_mac_mcu_ram_code(hw, mcu_patch_code,
+					   ARRAY_SIZE(mcu_patch_code));
 
 	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
 
@@ -104,10 +105,13 @@ rtl_set_mac_mcu_8126a_3(struct rtl_hw *hw)
 		0x0000, 0x6847, 0x0B18, 0x0C02, 0x0D10
 	};
 
-	rtl_hw_disable_mac_mcu_bps(hw);
+	/* Get BIN mac mcu patch code version */
+	hw->bin_mcu_patch_code_ver = rtl_get_bin_mcu_patch_code_ver(mcu_patch_code,
+								    ARRAY_SIZE(mcu_patch_code));
 
-	rtl_write_mac_mcu_ram_code(hw, mcu_patch_code,
-				   ARRAY_SIZE(mcu_patch_code));
+	if (hw->hw_mcu_patch_code_ver != hw->bin_mcu_patch_code_ver)
+		rtl_write_mac_mcu_ram_code(hw, mcu_patch_code,
+					   ARRAY_SIZE(mcu_patch_code));
 
 	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
 
diff --git a/drivers/net/r8169/base/rtl8127.c b/drivers/net/r8169/base/rtl8127.c
new file mode 100644
index 0000000000..fac6165931
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8127.c
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8127_mcu.h"
+
+/* For RTL8127, CFG_METHOD_91 */
+
+static void
+hw_init_rxcfg_8127(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_91:
+		RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | Rx_Close_Multiple |
+			RxCfg_pause_slot_en | (RX_DMA_BURST_512 << RxCfgDMAShift));
+		break;
+	}
+}
+
+static void
+hw_ephy_config_8127(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_91:
+		rtl_ephy_write(hw, 0x8088, 0x0064);
+		rtl_ephy_write(hw, 0x8488, 0x0064);
+		rtl_ephy_write(hw, 0x8888, 0x0064);
+		rtl_ephy_write(hw, 0x8C88, 0x0064);
+		rtl_ephy_write(hw, 0x8188, 0x0064);
+		rtl_ephy_write(hw, 0x8588, 0x0064);
+		rtl_ephy_write(hw, 0x8988, 0x0064);
+		rtl_ephy_write(hw, 0x8D88, 0x0064);
+		rtl_ephy_write(hw, 0x808C, 0x09B0);
+		rtl_ephy_write(hw, 0x848C, 0x09B0);
+		rtl_ephy_write(hw, 0x888C, 0x0F90);
+		rtl_ephy_write(hw, 0x8C8C, 0x0F90);
+		rtl_ephy_write(hw, 0x818C, 0x09B0);
+		rtl_ephy_write(hw, 0x858C, 0x09B0);
+		rtl_ephy_write(hw, 0x898C, 0x0F90);
+		rtl_ephy_write(hw, 0x8D8C, 0x0F90);
+		rtl_ephy_write(hw, 0x808A, 0x09B8);
+		rtl_ephy_write(hw, 0x848A, 0x09B8);
+		rtl_ephy_write(hw, 0x888A, 0x0F98);
+		rtl_ephy_write(hw, 0x8C8A, 0x0F98);
+		rtl_ephy_write(hw, 0x818A, 0x09B8);
+		rtl_ephy_write(hw, 0x858A, 0x09B8);
+		rtl_ephy_write(hw, 0x898A, 0x0F98);
+		rtl_ephy_write(hw, 0x8D8A, 0x0F98);
+		rtl_ephy_write(hw, 0x9020, 0x0080);
+		rtl_ephy_write(hw, 0x9420, 0x0080);
+		rtl_ephy_write(hw, 0x9820, 0x0080);
+		rtl_ephy_write(hw, 0x9C20, 0x0080);
+		rtl_ephy_write(hw, 0x901E, 0x0190);
+		rtl_ephy_write(hw, 0x941E, 0x0190);
+		rtl_ephy_write(hw, 0x981E, 0x0140);
+		rtl_ephy_write(hw, 0x9C1E, 0x0140);
+		rtl_ephy_write(hw, 0x901C, 0x0190);
+		rtl_ephy_write(hw, 0x941C, 0x0190);
+		rtl_ephy_write(hw, 0x981C, 0x0140);
+		rtl_ephy_write(hw, 0x9C1C, 0x0140);
+
+		/* Clear extended address */
+		rtl8127_clear_ephy_ext_addr(hw);
+		break;
+	default:
+		/* nothing to do */
+		break;
+	}
+}
+
+static void
+rtl8127_tgphy_irq_mask_and_ack(struct rtl_hw *hw)
+{
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA4D2, 0x0000);
+	(void)rtl_mdio_direct_read_phy_ocp(hw, 0xA4D4);
+}
+
+static void
+rtl_hw_phy_config_8127a_1(struct rtl_hw *hw)
+{
+	rtl8127_tgphy_irq_mask_and_ack(hw);
+
+	rtl_clear_eth_phy_ocp_bit(hw, 0xA442, BIT_11);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8415);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x9300);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81A3);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x0F00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81AE);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x0F00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81B9);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0xB900);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x83B0);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xB87E, 0x0E00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x83C5);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xB87E, 0x0E00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x83DA);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xB87E, 0x0E00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x83EF);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xB87E, 0x0E00);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8173);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x8620);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8175);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x8671);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x817C);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8187);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8192);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x819D);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81A8);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81B3);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81BE);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_13);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x817D);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0xA600);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8188);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0xA600);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8193);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0xA600);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x819E);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0xA600);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81A9);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x1400);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81B4);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x1400);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81BF);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0xA600);
+
+	rtl_clear_eth_phy_ocp_bit(hw, 0xAEAA, BIT_5 | BIT_3);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84F0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x201C);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84F2);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x3117);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xAEC6, 0x0000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xAE20, 0xFFFF);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xAECE, 0xFFFF);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xAED2, 0xFFFF);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xAEC8, 0x0000);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xAED0, BIT_0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xADB8, 0x0150);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8197);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8231);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x82CB);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x82CD);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5700);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8233);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5700);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8199);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5700);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x815A);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0150);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x81F4);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0150);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x828E);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0150);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x81B1);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x824B);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x82E5);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0000);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84F7);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x2800);
+	rtl_set_eth_phy_ocp_bit(hw, 0xAEC2, BIT_12);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x81B3);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0xAD00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x824D);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0xAD00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x82E7);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0xAD00);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xAE4E, 0x000F, 0x0001);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x82CE);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xF000, 0x4000);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84AC);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84AE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x0000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84B0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xF818);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x84B2);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x6000);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FFC);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x6008);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FFE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xF450);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8015);
+	rtl_set_eth_phy_ocp_bit(hw, 0xB87E, BIT_9);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8016);
+	rtl_set_eth_phy_ocp_bit(hw, 0xB87E, BIT_11);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FE6);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x0800);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FE4);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x2114);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8647);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xA7B1);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8649);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xBBCA);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x864B);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0xDC00);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8154);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xC000, 0x4000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8158);
+	rtl_clear_eth_phy_ocp_bit(hw, 0xB87E, 0xC000);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x826C);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xFFFF);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x826E);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xFFFF);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8872);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x0E00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8012);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_11);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8012);
+	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_14);
+	rtl_set_eth_phy_ocp_bit(hw, 0xB576, BIT_0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x834A);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x0700);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8217);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0x3F00, 0x2A00);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81B1);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0xFF00, 0x0B00);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8370);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x8671);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8372);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x86C8);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8401);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x86C8);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8403);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x86DA);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8406);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8408);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x840A);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x840C);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x840E);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8410);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8412);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8414);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x8416);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xA438, 0x1800, 0x1000);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x82BD);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x1F40);
+
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xBFB4, 0x07FF, 0x0328);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xBFB6, 0x3E14);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x81C4);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x003B);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0086);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00B7);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00DB);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00FE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00FE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00FE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00FE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x00C3);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0078);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0047);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0023);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x88D7);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x01A0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x88D9);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x01A0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FFA);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x002A);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FEE);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xFFDF);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FF0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xFFDF);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FF1);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0xDF0A);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FF3);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x4AAA);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FF5);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x5A0A);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FF7);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87E, 0x4AAA);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8FF9);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x5A00);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x88D5);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x0200);
+
+	rtl_set_eth_phy_ocp_bit(hw, 0xA430, BIT_1 | BIT_0);
+}
+
+static void
+hw_phy_config_8127(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_91:
+		rtl_hw_phy_config_8127a_1(hw);
+		break;
+	}
+}
+
+static void
+hw_mac_mcu_config_8127(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	/* Get H/W mac mcu patch code version */
+	hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_91:
+		rtl_set_mac_mcu_8127a_1(hw);
+		break;
+	}
+}
+
+static void
+hw_phy_mcu_config_8127(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_91:
+		rtl_set_phy_mcu_8127a_1(hw);
+		break;
+	}
+}
+
+const struct rtl_hw_ops rtl8127_ops = {
+	.hw_init_rxcfg     = hw_init_rxcfg_8127,
+	.hw_ephy_config    = hw_ephy_config_8127,
+	.hw_phy_config     = hw_phy_config_8127,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8127,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8127,
+};
diff --git a/drivers/net/r8169/base/rtl8127_mcu.c b/drivers/net/r8169/base/rtl8127_mcu.c
new file mode 100644
index 0000000000..44e6d96d9e
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8127_mcu.c
@@ -0,0 +1,616 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8127_mcu.h"
+
+/* For RTL8127, CFG_METHOD_91 */
+
+/* ------------------------------------MAC 8127------------------------------------- */
+
+static void
+_rtl_set_mac_mcu_8127a_1(struct rtl_hw *hw)
+{
+	u16 entry_cnt;
+	static const u16 mcu_patch_code[] =  {
+		0xE010, 0xE012, 0xE014, 0xE016, 0xE018, 0xE01A, 0xE0CF, 0xE180, 0xE182,
+		0xE184, 0xE186, 0xE188, 0xE18A, 0xE18C, 0xE18E, 0xE190, 0xC602, 0xBE00,
+		0x0000, 0xC602, 0xBE00, 0x0000, 0xC502, 0xBD00, 0x0000, 0xC502, 0xBD00,
+		0x0000, 0xC502, 0xBD00, 0x0000, 0xC643, 0x76C0, 0x49E1, 0xF13F, 0xC140,
+		0x7720, 0x49E0, 0xF003, 0x1B00, 0xE00A, 0x49E2, 0xF003, 0x1B04, 0xE006,
+		0x49E4, 0xF003, 0x1B08, 0xE002, 0x1B0C, 0x21B8, 0x1A0E, 0x44DA, 0xE893,
+		0x481C, 0xE884, 0xE001, 0x49E0, 0xF003, 0x1B00, 0xE00A, 0x49E2, 0xF003,
+		0x1B04, 0xE006, 0x49E4, 0xF003, 0x1B08, 0xE002, 0x1B0C, 0x21B8, 0x1A12,
+		0x44DA, 0xE87F, 0x481F, 0xE870, 0xE001, 0x49E0, 0xF003, 0x1B00, 0xE00A,
+		0x49E2, 0xF003, 0x1B04, 0xE006, 0x49E4, 0xF003, 0x1B08, 0xE002, 0x1B0C,
+		0x21B8, 0x1A1C, 0x44DA, 0xE86B, 0x481F, 0xE85C, 0xE004, 0xE04F, 0xDD98,
+		0xD450, 0x49E0, 0xF003, 0x1B00, 0xE00A, 0x49E2, 0xF003, 0x1B04, 0xE006,
+		0x49E4, 0xF003, 0x1B08, 0xE002, 0x1B0C, 0x21B8, 0x1A0E, 0x44DA, 0xE854,
+		0x489E, 0x481F, 0xE844, 0xE001, 0x1908, 0xE83E, 0x49E0, 0xF003, 0x1B00,
+		0xE00A, 0x49E2, 0xF003, 0x1B04, 0xE006, 0x49E4, 0xF003, 0x1B08, 0xE002,
+		0x1B0C, 0x21B8, 0x1A8A, 0x44DA, 0xE83D, 0x4813, 0xE82E, 0x49F9, 0xF106,
+		0x4838, 0xE837, 0x4813, 0xE828, 0xE001, 0x49E0, 0xF003, 0x1B00, 0xE00A,
+		0x49E2, 0xF003, 0x1B04, 0xE006, 0x49E4, 0xF003, 0x1B08, 0xE002, 0x1B0C,
+		0x21B8, 0x1A84, 0x44DA, 0xE823, 0x4890, 0x4811, 0xE813, 0x49F9, 0xF106,
+		0x4838, 0xE81C, 0x4890, 0x4811, 0xE80C, 0xC207, 0x7440, 0xC602, 0xBE00,
+		0x1600, 0x0FFE, 0xDE20, 0xE092, 0xC3FD, 0xE802, 0xFF80, 0xC0FB, 0x7202,
+		0x49AE, 0xF1FE, 0x9900, 0x44D3, 0x4413, 0x482F, 0x9A02, 0x7202, 0x49AE,
+		0xF1FE, 0xFF80, 0xC0EE, 0x7202, 0x49AE, 0xF1FE, 0x44D3, 0x4413, 0x48AF,
+		0x9A02, 0x7202, 0x49AE, 0xF1FE, 0x7100, 0xFF80, 0xB401, 0xB402, 0xB404,
+		0xB407, 0xC61F, 0x76C0, 0x49E1, 0xF164, 0xC11C, 0x7720, 0x1906, 0xE88A,
+		0x1B0C, 0x21B8, 0x1A40, 0x44DA, 0xE895, 0x4810, 0xE886, 0x190C, 0xE881,
+		0x1B08, 0x21B8, 0x1A26, 0x44DA, 0xE88C, 0x4890, 0x4891, 0xE87C, 0x49F9,
+		0xF107, 0x4898, 0x4899, 0xE877, 0xE003, 0xDD98, 0xD450, 0x1908, 0xE86F,
+		0x49E0, 0xF003, 0x1B00, 0xE00A, 0x49E2, 0xF003, 0x1B04, 0xE006, 0x49E2,
+		0xF003, 0x1B08, 0xE002, 0x1B0C, 0x21B8, 0x1A5C, 0x44DA, 0xE86E, 0x4897,
+		0x4898, 0x4819, 0x481A, 0xE85C, 0x49F9, 0xF109, 0x4838, 0xE865, 0x4897,
+		0x4898, 0x4819, 0x481A, 0xE853, 0xE001, 0x190A, 0xE84D, 0x1B00, 0xE85B,
+		0x44E1, 0x4838, 0xE858, 0x44E9, 0x1908, 0xE845, 0x49E0, 0xF003, 0x1B00,
+		0xE00A, 0x49E2, 0xF003, 0x1B04, 0xE006, 0x49E4, 0xF003, 0x1B08, 0xE002,
+		0x1B0C, 0x21B8, 0x1A86, 0x44DA, 0xE844, 0x44CC, 0xE835, 0x49F9, 0xF108,
+		0x4838, 0xE83E, 0x44CD, 0xE82F, 0xE003, 0xE021, 0xFFC0, 0x190A, 0xE827,
+		0x1B00, 0x4839, 0xE834, 0x249A, 0x1C00, 0x44E1, 0x1909, 0xE81F, 0x49E0,
+		0xF003, 0x1B00, 0xE00A, 0x49E2, 0xF003, 0x1B04, 0xE006, 0x49E4, 0xF003,
+		0x1B08, 0xE002, 0x1B0C, 0x21B8, 0x1A1A, 0x44DA, 0xE81E, 0xC5E4, 0x414D,
+		0x418C, 0xE80D, 0xB007, 0xB004, 0xB002, 0xB001, 0xC602, 0xBE00, 0x15E6,
+		0x0FFE, 0xDE20, 0xC3FE, 0xE802, 0xFF80, 0xC0FC, 0x7202, 0x49AE, 0xF1FE,
+		0x9900, 0x44D3, 0x4413, 0x482F, 0x9A02, 0x7202, 0x49AE, 0xF1FE, 0xFF80,
+		0xC0EF, 0x7202, 0x49AE, 0xF1FE, 0x44D3, 0x4413, 0x48AF, 0x9A02, 0x7202,
+		0x49AE, 0xF1FE, 0x7100, 0xFF80, 0xC502, 0xBD00, 0x0000, 0xC502, 0xBD00,
+		0x0000, 0xC502, 0xBD00, 0x0000, 0xC302, 0xBB00, 0x0000, 0xC602, 0xBE00,
+		0x0000, 0xC102, 0xB900, 0x0000, 0xC102, 0xB900, 0x0000, 0xC602, 0xBE00,
+		0x0000, 0xC602, 0xBE00, 0x0000, 0x6961, 0x0018, 0x0C11, 0x0A38
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
+
+	rtl_mac_ocp_write(hw, 0xFC32, 0x15FE);
+	rtl_mac_ocp_write(hw, 0xFC34, 0x15E4);
+
+	rtl_mac_ocp_write(hw, 0xFC48, 0x0060);
+}
+
+void
+rtl_set_mac_mcu_8127a_1(struct rtl_hw *hw)
+{
+	u8 tmp = (u8)rtl_mac_ocp_read(hw, 0xD006);
+
+	if (tmp != 0x04)
+		return;
+	_rtl_set_mac_mcu_8127a_1(hw);
+}
+
+/* ------------------------------------PHY 8127------------------------------------- */
+
+static const u16 phy_mcu_ram_code_8127a_1[] = {
+	0xa436, 0x8023, 0xa438, 0x6100, 0xa436, 0xB82E, 0xa438, 0x0001,
+	0xb820, 0x0090, 0xa436, 0xA016, 0xa438, 0x0000, 0xa436, 0xA012,
+	0xa438, 0x0000, 0xa436, 0xA014, 0xa438, 0x1800, 0xa438, 0x8010,
+	0xa438, 0x1800, 0xa438, 0x801a, 0xa438, 0x1800, 0xa438, 0x801a,
+	0xa438, 0x1800, 0xa438, 0x801a, 0xa438, 0x1800, 0xa438, 0x801a,
+	0xa438, 0x1800, 0xa438, 0x801a, 0xa438, 0x1800, 0xa438, 0x801a,
+	0xa438, 0x1800, 0xa438, 0x801a, 0xa438, 0xce00, 0xa438, 0x2941,
+	0xa438, 0x8017, 0xa438, 0x2c59, 0xa438, 0x8017, 0xa438, 0x1800,
+	0xa438, 0x0e11, 0xa438, 0x8aff, 0xa438, 0x1800, 0xa438, 0x0e11,
+	0xa436, 0xA026, 0xa438, 0xffff, 0xa436, 0xA024, 0xa438, 0xffff,
+	0xa436, 0xA022, 0xa438, 0xffff, 0xa436, 0xA020, 0xa438, 0xffff,
+	0xa436, 0xA006, 0xa438, 0xffff, 0xa436, 0xA004, 0xa438, 0xffff,
+	0xa436, 0xA002, 0xa438, 0xffff, 0xa436, 0xA000, 0xa438, 0x0e10,
+	0xa436, 0xA008, 0xa438, 0x0100, 0xa436, 0xA016, 0xa438, 0x0000,
+	0xa436, 0xA012, 0xa438, 0x0ff8, 0xa436, 0xA014, 0xa438, 0x219a,
+	0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000,
+	0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000, 0xa436, 0xA152,
+	0xa438, 0x21a4, 0xa436, 0xA154, 0xa438, 0x3fff, 0xa436, 0xA156,
+	0xa438, 0x3fff, 0xa436, 0xA158, 0xa438, 0x3fff, 0xa436, 0xA15A,
+	0xa438, 0x3fff, 0xa436, 0xA15C, 0xa438, 0x3fff, 0xa436, 0xA15E,
+	0xa438, 0x3fff, 0xa436, 0xA160, 0xa438, 0x3fff, 0xa436, 0xA150,
+	0xa438, 0x0001, 0xa436, 0xA016, 0xa438, 0x0010, 0xa436, 0xA012,
+	0xa438, 0x0000, 0xa436, 0xA014, 0xa438, 0x1800, 0xa438, 0x8010,
+	0xa438, 0x1800, 0xa438, 0x8014, 0xa438, 0x1800, 0xa438, 0x801a,
+	0xa438, 0x1800, 0xa438, 0x801e, 0xa438, 0x1800, 0xa438, 0x8026,
+	0xa438, 0x1800, 0xa438, 0x802e, 0xa438, 0x1800, 0xa438, 0x8036,
+	0xa438, 0x1800, 0xa438, 0x803a, 0xa438, 0xce01, 0xa438, 0x8208,
+	0xa438, 0x1800, 0xa438, 0x0028, 0xa438, 0x1000, 0xa438, 0x02c5,
+	0xa438, 0x1000, 0xa438, 0x0304, 0xa438, 0x1800, 0xa438, 0x0119,
+	0xa438, 0xce01, 0xa438, 0x8208, 0xa438, 0x1800, 0xa438, 0x009e,
+	0xa438, 0xd501, 0xa438, 0xce01, 0xa438, 0xa50f, 0xa438, 0x8208,
+	0xa438, 0xd500, 0xa438, 0xaa0f, 0xa438, 0x1800, 0xa438, 0x015b,
+	0xa438, 0xd501, 0xa438, 0xce01, 0xa438, 0xa50f, 0xa438, 0x8208,
+	0xa438, 0xd500, 0xa438, 0xaa0f, 0xa438, 0x1800, 0xa438, 0x01a9,
+	0xa438, 0xd501, 0xa438, 0xce01, 0xa438, 0xa50f, 0xa438, 0x8208,
+	0xa438, 0xd500, 0xa438, 0xaa0f, 0xa438, 0x1800, 0xa438, 0x01f4,
+	0xa438, 0x8208, 0xa438, 0xd500, 0xa438, 0x1800, 0xa438, 0x02a5,
+	0xa438, 0xa208, 0xa438, 0xd500, 0xa438, 0x1800, 0xa438, 0x02b8,
+	0xa436, 0xA08E, 0xa438, 0x02b7, 0xa436, 0xA08C, 0xa438, 0x02a4,
+	0xa436, 0xA08A, 0xa438, 0x01e7, 0xa436, 0xA088, 0xa438, 0x019c,
+	0xa436, 0xA086, 0xa438, 0x014e, 0xa436, 0xA084, 0xa438, 0x009d,
+	0xa436, 0xA082, 0xa438, 0x0117, 0xa436, 0xA080, 0xa438, 0x0027,
+	0xa436, 0xA090, 0xa438, 0x00ff, 0xa436, 0xA016, 0xa438, 0x0020,
+	0xa436, 0xA012, 0xa438, 0x0000, 0xa436, 0xA014, 0xa438, 0x1800,
+	0xa438, 0x8010, 0xa438, 0x1800, 0xa438, 0x801d, 0xa438, 0x1800,
+	0xa438, 0x803b, 0xa438, 0x1800, 0xa438, 0x8087, 0xa438, 0x1800,
+	0xa438, 0x808e, 0xa438, 0x1800, 0xa438, 0x809d, 0xa438, 0x1800,
+	0xa438, 0x80b7, 0xa438, 0x1800, 0xa438, 0x80c4, 0xa438, 0xd1bc,
+	0xa438, 0xd040, 0xa438, 0x1000, 0xa438, 0x1cd2, 0xa438, 0xd700,
+	0xa438, 0x5fba, 0xa438, 0xd700, 0xa438, 0x273d, 0xa438, 0x801b,
+	0xa438, 0x1800, 0xa438, 0x07d1, 0xa438, 0x1800, 0xa438, 0x080e,
+	0xa438, 0xd700, 0xa438, 0x37c9, 0xa438, 0x8032, 0xa438, 0x33a9,
+	0xa438, 0x802a, 0xa438, 0xd705, 0xa438, 0x4084, 0xa438, 0xd1f4,
+	0xa438, 0xd048, 0xa438, 0xf013, 0xa438, 0xd1b7, 0xa438, 0xd04b,
+	0xa438, 0xf010, 0xa438, 0xd705, 0xa438, 0x4084, 0xa438, 0xd1f4,
+	0xa438, 0xd048, 0xa438, 0xf00b, 0xa438, 0xd1b7, 0xa438, 0xd04b,
+	0xa438, 0xf008, 0xa438, 0xd705, 0xa438, 0x4084, 0xa438, 0xd1f4,
+	0xa438, 0xd048, 0xa438, 0xf003, 0xa438, 0xd1b7, 0xa438, 0xd04b,
+	0xa438, 0x1800, 0xa438, 0x14cc, 0xa438, 0xd700, 0xa438, 0x2b59,
+	0xa438, 0x803f, 0xa438, 0xf003, 0xa438, 0x1800, 0xa438, 0x118f,
+	0xa438, 0x6060, 0xa438, 0x1800, 0xa438, 0x1167, 0xa438, 0xd700,
+	0xa438, 0x60c7, 0xa438, 0xd704, 0xa438, 0x609f, 0xa438, 0xd705,
+	0xa438, 0x4043, 0xa438, 0xf003, 0xa438, 0x1800, 0xa438, 0x1150,
+	0xa438, 0x0c03, 0xa438, 0x1502, 0xa438, 0x8702, 0xa438, 0x8011,
+	0xa438, 0x9503, 0xa438, 0x800a, 0xa438, 0x81a0, 0xa438, 0x8302,
+	0xa438, 0x8480, 0xa438, 0x8686, 0xa438, 0xcde0, 0xa438, 0xd1ff,
+	0xa438, 0xd049, 0xa438, 0x1000, 0xa438, 0x1cd2, 0xa438, 0xd700,
+	0xa438, 0x5fba, 0xa438, 0xd705, 0xa438, 0x417e, 0xa438, 0x0c03,
+	0xa438, 0x1502, 0xa438, 0xa011, 0xa438, 0x9503, 0xa438, 0xd1c8,
+	0xa438, 0xd045, 0xa438, 0x1000, 0xa438, 0x1cd2, 0xa438, 0xd700,
+	0xa438, 0x5fba, 0xa438, 0x0c03, 0xa438, 0x1502, 0xa438, 0xa702,
+	0xa438, 0x9503, 0xa438, 0xa00a, 0xa438, 0xa1a0, 0xa438, 0xa480,
+	0xa438, 0xa686, 0xa438, 0xd705, 0xa438, 0x605e, 0xa438, 0xa302,
+	0xa438, 0x9503, 0xa438, 0xd700, 0xa438, 0x37c9, 0xa438, 0x8083,
+	0xa438, 0x33a9, 0xa438, 0x807f, 0xa438, 0xd178, 0xa438, 0xd04b,
+	0xa438, 0x1800, 0xa438, 0x115d, 0xa438, 0xd1c8, 0xa438, 0xd04b,
+	0xa438, 0x1800, 0xa438, 0x115d, 0xa438, 0xd1e6, 0xa438, 0xd04b,
+	0xa438, 0x1800, 0xa438, 0x115d, 0xa438, 0xd71f, 0xa438, 0x6080,
+	0xa438, 0xd704, 0xa438, 0x1800, 0xa438, 0x1bc0, 0xa438, 0x1800,
+	0xa438, 0x1bc4, 0xa438, 0x4134, 0xa438, 0xd115, 0xa438, 0xd04f,
+	0xa438, 0x1000, 0xa438, 0x1d0b, 0xa438, 0x1000, 0xa438, 0x80ad,
+	0xa438, 0x1800, 0xa438, 0x01f2, 0xa438, 0x1000, 0xa438, 0x1d0b,
+	0xa438, 0x1000, 0xa438, 0x80ad, 0xa438, 0x1800, 0xa438, 0x01f9,
+	0xa438, 0x2969, 0xa438, 0x80a3, 0xa438, 0xd700, 0xa438, 0x606b,
+	0xa438, 0xd701, 0xa438, 0x60b4, 0xa438, 0x1000, 0xa438, 0x80ad,
+	0xa438, 0x1800, 0xa438, 0x0551, 0xa438, 0xd196, 0xa438, 0xd04d,
+	0xa438, 0x1000, 0xa438, 0x80ad, 0xa438, 0x1800, 0xa438, 0x054d,
+	0xa438, 0xd208, 0xa438, 0x0c09, 0xa438, 0x1301, 0xa438, 0x1000,
+	0xa438, 0x1cd2, 0xa438, 0xd701, 0xa438, 0x5fa3, 0xa438, 0xb302,
+	0xa438, 0xd200, 0xa438, 0x0800, 0xa438, 0xd705, 0xa438, 0x6064,
+	0xa438, 0x1800, 0xa438, 0x140a, 0xa438, 0x8810, 0xa438, 0xd199,
+	0xa438, 0xd04b, 0xa438, 0x1000, 0xa438, 0x1cd2, 0xa438, 0xd700,
+	0xa438, 0x5fba, 0xa438, 0x1800, 0xa438, 0x140a, 0xa436, 0xA10E,
+	0xa438, 0xffff, 0xa436, 0xA10C, 0xa438, 0x1352, 0xa436, 0xA10A,
+	0xa438, 0x0545, 0xa436, 0xA108, 0xa438, 0x01ed, 0xa436, 0xA106,
+	0xa438, 0x1bbf, 0xa436, 0xA104, 0xa438, 0x114b, 0xa436, 0xA102,
+	0xa438, 0x14bf, 0xa436, 0xA100, 0xa438, 0x07ce, 0xa436, 0xA110,
+	0xa438, 0x007f, 0xa436, 0xA016, 0xa438, 0x0020, 0xa436, 0xA012,
+	0xa438, 0x1ff8, 0xa436, 0xA014, 0xa438, 0xd1ce, 0xa438, 0x0000,
+	0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000,
+	0xa438, 0x0000, 0xa438, 0x0000, 0xa436, 0xA164, 0xa438, 0x07fc,
+	0xa436, 0xA166, 0xa438, 0x143d, 0xa436, 0xA168, 0xa438, 0x3fff,
+	0xa436, 0xA16A, 0xa438, 0x3fff, 0xa436, 0xA16C, 0xa438, 0x3fff,
+	0xa436, 0xA16E, 0xa438, 0x3fff, 0xa436, 0xA170, 0xa438, 0x3fff,
+	0xa436, 0xA172, 0xa438, 0x3fff, 0xa436, 0xA162, 0xa438, 0x0003,
+	0xa436, 0xb87c, 0xa438, 0x8994, 0xa436, 0xb87e, 0xa438, 0xaf89,
+	0xa438, 0xacaf, 0xa438, 0x89e4, 0xa438, 0xaf89, 0xa438, 0xecaf,
+	0xa438, 0x8a04, 0xa438, 0xaf8a, 0xa438, 0x2eaf, 0xa438, 0x8a4a,
+	0xa438, 0xaf8d, 0xa438, 0x31af, 0xa438, 0x8dc6, 0xa438, 0x1f55,
+	0xa438, 0xe18f, 0xa438, 0xe3a1, 0xa438, 0x0007, 0xa438, 0xee86,
+	0xa438, 0xe900, 0xa438, 0xaf4f, 0xa438, 0x9ead, 0xa438, 0x281b,
+	0xa438, 0xe18f, 0xa438, 0xfcef, 0xa438, 0x71bf, 0xa438, 0x74f6,
+	0xa438, 0x027e, 0xa438, 0xd2ef, 0xa438, 0x641c, 0xa438, 0x670d,
+	0xa438, 0x67ef, 0xa438, 0x461f, 0xa438, 0x00bf, 0xa438, 0x74f6,
+	0xa438, 0x027e, 0xa438, 0xdee1, 0xa438, 0x8fe3, 0xa438, 0x0d11,
+	0xa438, 0xe58f, 0xa438, 0xe313, 0xa438, 0xaeca, 0xa438, 0x028d,
+	0xa438, 0xd1d3, 0xa438, 0x01af, 0xa438, 0x40d1, 0xa438, 0xbf7a,
+	0xa438, 0x6102, 0xa438, 0x7d44, 0xa438, 0xa100, 0xa438, 0x09e0,
+	0xa438, 0x8ffa, 0xa438, 0xe18f, 0xa438, 0xfbaf, 0xa438, 0x683d,
+	0xa438, 0x027f, 0xa438, 0xa9af, 0xa438, 0x682c, 0xa438, 0xbf8e,
+	0xa438, 0x4102, 0xa438, 0x7d44, 0xa438, 0xe58f, 0xa438, 0xecbf,
+	0xa438, 0x74cc, 0xa438, 0x027d, 0xa438, 0x44e3, 0xa438, 0x8fed,
+	0xa438, 0x0d31, 0xa438, 0xf63f, 0xa438, 0x0d11, 0xa438, 0xf62f,
+	0xa438, 0x1b13, 0xa438, 0xad2f, 0xa438, 0x06bf, 0xa438, 0x8e41,
+	0xa438, 0x027c, 0xa438, 0xf9d1, 0xa438, 0x01af, 0xa438, 0x5974,
+	0xa438, 0xee88, 0xa438, 0x8600, 0xa438, 0xe08f, 0xa438, 0xebad,
+	0xa438, 0x200b, 0xa438, 0xe18f, 0xa438, 0xecbf, 0xa438, 0x8e41,
+	0xa438, 0x027d, 0xa438, 0x25ae, 0xa438, 0x04ee, 0xa438, 0x8feb,
+	0xa438, 0x01af, 0xa438, 0x5945, 0xa438, 0xad28, 0xa438, 0x2ce0,
+	0xa438, 0x8fea, 0xa438, 0xa000, 0xa438, 0x0502, 0xa438, 0x8af0,
+	0xa438, 0xae1e, 0xa438, 0xa001, 0xa438, 0x0502, 0xa438, 0x8b9f,
+	0xa438, 0xae16, 0xa438, 0xa002, 0xa438, 0x0502, 0xa438, 0x8c0f,
+	0xa438, 0xae0e, 0xa438, 0xa003, 0xa438, 0x0502, 0xa438, 0x8c95,
+	0xa438, 0xae06, 0xa438, 0xa004, 0xa438, 0x0302, 0xa438, 0x8d08,
+	0xa438, 0xaf63, 0xa438, 0x8902, 0xa438, 0x8a7f, 0xa438, 0xaf63,
+	0xa438, 0x81f8, 0xa438, 0xef49, 0xa438, 0xf8e0, 0xa438, 0x8015,
+	0xa438, 0xad21, 0xa438, 0x19bf, 0xa438, 0x7bd8, 0xa438, 0x027c,
+	0xa438, 0xf9bf, 0xa438, 0x7bf3, 0xa438, 0x027d, 0xa438, 0x44bf,
+	0xa438, 0x7bf6, 0xa438, 0x027c, 0xa438, 0xf902, 0xa438, 0x638e,
+	0xa438, 0xee8f, 0xa438, 0xea00, 0xa438, 0xe080, 0xa438, 0x16ad,
+	0xa438, 0x233d, 0xa438, 0xbf7b, 0xa438, 0xf302, 0xa438, 0x7d44,
+	0xa438, 0xbf7a, 0xa438, 0x9402, 0xa438, 0x7cf9, 0xa438, 0xbf8e,
+	0xa438, 0x4402, 0xa438, 0x7cf9, 0xa438, 0xbf7a, 0xa438, 0xa602,
+	0xa438, 0x7cf9, 0xa438, 0xbf7a, 0xa438, 0xa302, 0xa438, 0x7cf9,
+	0xa438, 0xbf7a, 0xa438, 0xa902, 0xa438, 0x7cf9, 0xa438, 0xbf7a,
+	0xa438, 0xac02, 0xa438, 0x7cf9, 0xa438, 0xbf8e, 0xa438, 0x4702,
+	0xa438, 0x7cf9, 0xa438, 0xbf8e, 0xa438, 0x4a02, 0xa438, 0x7cf9,
+	0xa438, 0x0263, 0xa438, 0x8eee, 0xa438, 0x8fea, 0xa438, 0x00bf,
+	0xa438, 0x7c02, 0xa438, 0x027c, 0xa438, 0xf9fc, 0xa438, 0xef94,
+	0xa438, 0xfc04, 0xa438, 0xf8f9, 0xa438, 0xfbef, 0xa438, 0x79fb,
+	0xa438, 0xe080, 0xa438, 0x15ac, 0xa438, 0x2103, 0xa438, 0xaf8b,
+	0xa438, 0x70ee, 0xa438, 0x8888, 0xa438, 0x00ee, 0xa438, 0x888a,
+	0xa438, 0x00ee, 0xa438, 0x888b, 0xa438, 0x00bf, 0xa438, 0x7bd8,
+	0xa438, 0x027d, 0xa438, 0x02bf, 0xa438, 0x6000, 0xa438, 0xd788,
+	0xa438, 0x881f, 0xa438, 0x44d4, 0xa438, 0x000c, 0xa438, 0x0273,
+	0xa438, 0x3b02, 0xa438, 0x7fa9, 0xa438, 0xac28, 0xa438, 0x05ac,
+	0xa438, 0x290d, 0xa438, 0xae18, 0xa438, 0xe188, 0xa438, 0x98bf,
+	0xa438, 0x7be1, 0xa438, 0x027d, 0xa438, 0x25ae, 0xa438, 0x18e1,
+	0xa438, 0x8898, 0xa438, 0x0d11, 0xa438, 0xbf7b, 0xa438, 0xe102,
+	0xa438, 0x7d25, 0xa438, 0xae0b, 0xa438, 0xe188, 0xa438, 0x980d,
+	0xa438, 0x12bf, 0xa438, 0x7be1, 0xa438, 0x027d, 0xa438, 0x25bf,
+	0xa438, 0x88a0, 0xa438, 0xda19, 0xa438, 0xdb19, 0xa438, 0xd819,
+	0xa438, 0xd91f, 0xa438, 0x77bf, 0xa438, 0x88b1, 0xa438, 0xde19,
+	0xa438, 0xdf19, 0xa438, 0xdc19, 0xa438, 0xdd19, 0xa438, 0x17a7,
+	0xa438, 0x0004, 0xa438, 0xf302, 0xa438, 0x63cd, 0xa438, 0xee8f,
+	0xa438, 0xea01, 0xa438, 0xe080, 0xa438, 0x16ad, 0xa438, 0x2319,
+	0xa438, 0xee88, 0xa438, 0x8800, 0xa438, 0xee88, 0xa438, 0x8a00,
+	0xa438, 0xee88, 0xa438, 0x8b00, 0xa438, 0xbf8e, 0xa438, 0x4402,
+	0xa438, 0x7d02, 0xa438, 0x0263, 0xa438, 0xcdee, 0xa438, 0x8fea,
+	0xa438, 0x0102, 0xa438, 0x70de, 0xa438, 0xbf7c, 0xa438, 0x0202,
+	0xa438, 0x7d02, 0xa438, 0xffef, 0xa438, 0x97ff, 0xa438, 0xfdfc,
+	0xa438, 0x04f8, 0xa438, 0xf9fa, 0xa438, 0xef69, 0xa438, 0xfae0,
+	0xa438, 0x888a, 0xa438, 0xe188, 0xa438, 0x8b14, 0xa438, 0xe488,
+	0xa438, 0x8ae5, 0xa438, 0x888b, 0xa438, 0xbf88, 0xa438, 0x94d8,
+	0xa438, 0x19d9, 0xa438, 0xef64, 0xa438, 0xe088, 0xa438, 0x8ae1,
+	0xa438, 0x888b, 0xa438, 0x1b46, 0xa438, 0x9f30, 0xa438, 0x1f44,
+	0xa438, 0xe488, 0xa438, 0x8ae5, 0xa438, 0x888b, 0xa438, 0xe080,
+	0xa438, 0x15ad, 0xa438, 0x211a, 0xa438, 0x0260, 0xa438, 0xece0,
+	0xa438, 0x8016, 0xa438, 0xad23, 0xa438, 0x1602, 0xa438, 0x7c86,
+	0xa438, 0xef47, 0xa438, 0xe48f, 0xa438, 0xe9e5, 0xa438, 0x8fe8,
+	0xa438, 0xee8f, 0xa438, 0xea02, 0xa438, 0xae0b, 0xa438, 0x028c,
+	0xa438, 0x2eae, 0xa438, 0x0602, 0xa438, 0x8bfe, 0xa438, 0x0270,
+	0xa438, 0xdefe, 0xa438, 0xef96, 0xa438, 0xfefd, 0xa438, 0xfc04,
+	0xa438, 0xf8e1, 0xa438, 0x8888, 0xa438, 0x11e5, 0xa438, 0x8888,
+	0xa438, 0xad2a, 0xa438, 0x04ee, 0xa438, 0x8888, 0xa438, 0x00fc,
+	0xa438, 0x04f8, 0xa438, 0xfafb, 0xa438, 0xe08f, 0xa438, 0xe9e1,
+	0xa438, 0x8fe8, 0xa438, 0xef64, 0xa438, 0x1f00, 0xa438, 0xe18f,
+	0xa438, 0xe6ef, 0xa438, 0x7402, 0xa438, 0x7ca1, 0xa438, 0xad50,
+	0xa438, 0x0302, 0xa438, 0x8c2e, 0xa438, 0xfffe, 0xa438, 0xfc04,
+	0xa438, 0xf8fa, 0xa438, 0xef69, 0xa438, 0xfbbf, 0xa438, 0x7bf3,
+	0xa438, 0x027d, 0xa438, 0x44ac, 0xa438, 0x284c, 0xa438, 0x0264,
+	0xa438, 0x1cbf, 0xa438, 0x8e47, 0xa438, 0x027d, 0xa438, 0x02bf,
+	0xa438, 0x8e4a, 0xa438, 0x027d, 0xa438, 0x02d1, 0xa438, 0x43b1,
+	0xa438, 0xfebf, 0xa438, 0x7aa6, 0xa438, 0x027c, 0xa438, 0xf9bf,
+	0xa438, 0x7aa3, 0xa438, 0x027c, 0xa438, 0xf9bf, 0xa438, 0x7aa9,
+	0xa438, 0x027c, 0xa438, 0xf9bf, 0xa438, 0x7aac, 0xa438, 0x027d,
+	0xa438, 0x02d1, 0xa438, 0x80e0, 0xa438, 0x8888, 0xa438, 0x100e,
+	0xa438, 0x11b0, 0xa438, 0xfcbf, 0xa438, 0x7a94, 0xa438, 0x027d,
+	0xa438, 0x2502, 0xa438, 0x7c86, 0xa438, 0xef47, 0xa438, 0xe48f,
+	0xa438, 0xe9e5, 0xa438, 0x8fe8, 0xa438, 0xee8f, 0xa438, 0xea03,
+	0xa438, 0xae07, 0xa438, 0xee8f, 0xa438, 0xea01, 0xa438, 0x0270,
+	0xa438, 0xdeff, 0xa438, 0xef96, 0xa438, 0xfefc, 0xa438, 0x04f8,
+	0xa438, 0xf9fa, 0xa438, 0xfbef, 0xa438, 0x79fb, 0xa438, 0xbf7a,
+	0xa438, 0x9402, 0xa438, 0x7d44, 0xa438, 0xef21, 0xa438, 0xbf7a,
+	0xa438, 0xb802, 0xa438, 0x7d44, 0xa438, 0x1f21, 0xa438, 0x9e19,
+	0xa438, 0xe08f, 0xa438, 0xe9e1, 0xa438, 0x8fe8, 0xa438, 0xef64,
+	0xa438, 0x1f00, 0xa438, 0xe18f, 0xa438, 0xe4ef, 0xa438, 0x7402,
+	0xa438, 0x7ca1, 0xa438, 0xad50, 0xa438, 0x3dee, 0xa438, 0x8fe7,
+	0xa438, 0x01bf, 0xa438, 0x7a94, 0xa438, 0x027c, 0xa438, 0xf9bf,
+	0xa438, 0x7aa6, 0xa438, 0x027c, 0xa438, 0xf9bf, 0xa438, 0x7aa3,
+	0xa438, 0x027c, 0xa438, 0xf9bf, 0xa438, 0x7aa9, 0xa438, 0x027c,
+	0xa438, 0xf9bf, 0xa438, 0x7aac, 0xa438, 0x027d, 0xa438, 0x02bf,
+	0xa438, 0x8e47, 0xa438, 0x027c, 0xa438, 0xf9bf, 0xa438, 0x8e4a,
+	0xa438, 0x027c, 0xa438, 0xf902, 0xa438, 0x7c86, 0xa438, 0xef47,
+	0xa438, 0xe48f, 0xa438, 0xe9e5, 0xa438, 0x8fe8, 0xa438, 0xee8f,
+	0xa438, 0xea04, 0xa438, 0xffef, 0xa438, 0x97ff, 0xa438, 0xfefd,
+	0xa438, 0xfc04, 0xa438, 0xf8fa, 0xa438, 0xfbe0, 0xa438, 0x8fe9,
+	0xa438, 0xe18f, 0xa438, 0xe8ef, 0xa438, 0x641f, 0xa438, 0x00e1,
+	0xa438, 0x8fe5, 0xa438, 0xef74, 0xa438, 0x027c, 0xa438, 0xa1ad,
+	0xa438, 0x500d, 0xa438, 0x0263, 0xa438, 0x8e02, 0xa438, 0x8bfe,
+	0xa438, 0xee8f, 0xa438, 0xea01, 0xa438, 0x0270, 0xa438, 0xdeff,
+	0xa438, 0xfefc, 0xa438, 0x04e3, 0xa438, 0x8fd8, 0xa438, 0xe787,
+	0xa438, 0x75e4, 0xa438, 0x8fe1, 0xa438, 0xe58f, 0xa438, 0xe2bf,
+	0xa438, 0x8fd9, 0xa438, 0xef32, 0xa438, 0x0c31, 0xa438, 0x1a93,
+	0xa438, 0xdc19, 0xa438, 0xdd02, 0xa438, 0x7fa9, 0xa438, 0xac2a,
+	0xa438, 0x18e0, 0xa438, 0x8fe1, 0xa438, 0xe18f, 0xa438, 0xe2ef,
+	0xa438, 0x74e1, 0xa438, 0x8775, 0xa438, 0x1f00, 0xa438, 0xef64,
+	0xa438, 0xe18f, 0xa438, 0xd8e5, 0xa438, 0x8775, 0xa438, 0xaf4d,
+	0xa438, 0x72bf, 0xa438, 0x7b3c, 0xa438, 0xef32, 0xa438, 0x4b03,
+	0xa438, 0x1a93, 0xa438, 0x027d, 0xa438, 0x44ef, 0xa438, 0x64e1,
+	0xa438, 0x8fff, 0xa438, 0x1f00, 0xa438, 0xef74, 0xa438, 0x1b67,
+	0xa438, 0xac4f, 0xa438, 0xcee0, 0xa438, 0x8ffd, 0xa438, 0xe18f,
+	0xa438, 0xfeef, 0xa438, 0x64e0, 0xa438, 0x8fe1, 0xa438, 0xe18f,
+	0xa438, 0xe2ef, 0xa438, 0x7402, 0xa438, 0x7c53, 0xa438, 0xac50,
+	0xa438, 0x02ae, 0xa438, 0xb6e1, 0xa438, 0x8775, 0xa438, 0x1f00,
+	0xa438, 0xef64, 0xa438, 0xe18f, 0xa438, 0xfcef, 0xa438, 0x711c,
+	0xa438, 0x670d, 0xa438, 0x67ef, 0xa438, 0x46e5, 0xa438, 0x8775,
+	0xa438, 0xef32, 0xa438, 0xd101, 0xa438, 0xa300, 0xa438, 0x02ae,
+	0xa438, 0x050c, 0xa438, 0x1183, 0xa438, 0xaef6, 0xa438, 0xe08f,
+	0xa438, 0xe31e, 0xa438, 0x10e5, 0xa438, 0x8fe3, 0xa438, 0xae89,
+	0xa438, 0xe287, 0xa438, 0x75e6, 0xa438, 0x8fd8, 0xa438, 0x1f22,
+	0xa438, 0xaf4d, 0xa438, 0x42f8, 0xa438, 0xf9ef, 0xa438, 0x59fa,
+	0xa438, 0xfbbf, 0xa438, 0x8fee, 0xa438, 0x027f, 0xa438, 0xa90d,
+	0xa438, 0x1149, 0xa438, 0x041a, 0xa438, 0x91d7, 0xa438, 0x8df3,
+	0xa438, 0xd68e, 0xa438, 0x2302, 0xa438, 0x72aa, 0xa438, 0xfffe,
+	0xa438, 0xef95, 0xa438, 0xfdfc, 0xa438, 0x0400, 0xa438, 0x7591,
+	0xa438, 0x0275, 0xa438, 0x4404, 0xa438, 0x758e, 0xa438, 0x2675,
+	0xa438, 0x4100, 0xa438, 0x8e26, 0xa438, 0x028e, 0xa438, 0x2304,
+	0xa438, 0x759d, 0xa438, 0x2675, 0xa438, 0x4700, 0xa438, 0x8e32,
+	0xa438, 0x028e, 0xa438, 0x2f04, 0xa438, 0x8e2c, 0xa438, 0x268e,
+	0xa438, 0x2900, 0xa438, 0x8e3e, 0xa438, 0x028e, 0xa438, 0x3b04,
+	0xa438, 0x8e38, 0xa438, 0x268e, 0xa438, 0x35fe, 0xa438, 0xad96,
+	0xa438, 0xdcad, 0xa438, 0x96ba, 0xa438, 0xad96, 0xa438, 0x98ad,
+	0xa438, 0x9676, 0xa438, 0xad98, 0xa438, 0x54ad, 0xa438, 0x9876,
+	0xa438, 0xae38, 0xa438, 0x54ae, 0xa438, 0x38fe, 0xa438, 0xae3a,
+	0xa438, 0xdcae, 0xa438, 0x3abb, 0xa438, 0xbf14, 0xa438, 0x99bd,
+	0xa438, 0xe0cc, 0xa438, 0xbdc8, 0xa438, 0xddbd, 0xa438, 0xc800,
+	0xa436, 0xb85e, 0xa438, 0x4f9a, 0xa436, 0xb860, 0xa438, 0x40cf,
+	0xa436, 0xb862, 0xa438, 0x6829, 0xa436, 0xb864, 0xa438, 0x5972,
+	0xa436, 0xb886, 0xa438, 0x5941, 0xa436, 0xb888, 0xa438, 0x636b,
+	0xa436, 0xb88a, 0xa438, 0x4d6b, 0xa436, 0xb88c, 0xa438, 0x4d40,
+	0xa436, 0xb838, 0xa438, 0x00ff, 0xb820, 0x0010, 0xa436, 0x8608,
+	0xa438, 0xaf86, 0xa438, 0xdaaf, 0xa438, 0x894c, 0xa438, 0xaf8a,
+	0xa438, 0xf8af, 0xa438, 0x8bf3, 0xa438, 0xaf8b, 0xa438, 0xf3af,
+	0xa438, 0x8bf3, 0xa438, 0xaf8b, 0xa438, 0xf3af, 0xa438, 0x8bf3,
+	0xa438, 0x006f, 0xa438, 0x4a03, 0xa438, 0x6f47, 0xa438, 0x266f,
+	0xa438, 0x5900, 0xa438, 0x6f4d, 0xa438, 0x016f, 0xa438, 0x5004,
+	0xa438, 0x6f56, 0xa438, 0x056f, 0xa438, 0x5f06, 0xa438, 0x6f5c,
+	0xa438, 0x2774, 0xa438, 0x7800, 0xa438, 0x6f68, 0xa438, 0x246f,
+	0xa438, 0x6b20, 0xa438, 0x6f6e, 0xa438, 0x206f, 0xa438, 0x7410,
+	0xa438, 0x7469, 0xa438, 0x1074, 0xa438, 0x6c10, 0xa438, 0x746f,
+	0xa438, 0x1074, 0xa438, 0x7225, 0xa438, 0x8bfc, 0xa438, 0x008c,
+	0xa438, 0x0802, 0xa438, 0x8c02, 0xa438, 0x038b, 0xa438, 0xff04,
+	0xa438, 0x6eed, 0xa438, 0x278c, 0xa438, 0x0520, 0xa438, 0x74da,
+	0xa438, 0x2074, 0xa438, 0xdd20, 0xa438, 0x74e0, 0xa438, 0x0074,
+	0xa438, 0xe300, 0xa438, 0x6ef3, 0xa438, 0x006e, 0xa438, 0xf600,
+	0xa438, 0x6ef9, 0xa438, 0x006e, 0xa438, 0xfc00, 0xa438, 0x6eff,
+	0xa438, 0x006f, 0xa438, 0x0200, 0xa438, 0x6f05, 0xa438, 0x026f,
+	0xa438, 0x0802, 0xa438, 0x6f0b, 0xa438, 0x026f, 0xa438, 0x0e02,
+	0xa438, 0x6f11, 0xa438, 0x026f, 0xa438, 0x1402, 0xa438, 0x6f17,
+	0xa438, 0x226f, 0xa438, 0x1a00, 0xa438, 0x723e, 0xa438, 0x016e,
+	0xa438, 0xed24, 0xa438, 0x6f50, 0xa438, 0x0072, 0xa438, 0x4701,
+	0xa438, 0x724a, 0xa438, 0x0272, 0xa438, 0x4d23, 0xa438, 0x7250,
+	0xa438, 0x1074, 0xa438, 0x6910, 0xa438, 0x746c, 0xa438, 0x1074,
+	0xa438, 0x6f00, 0xa438, 0x7472, 0xa438, 0x158c, 0xa438, 0x0b15,
+	0xa438, 0x8c0e, 0xa438, 0x158c, 0xa438, 0x1105, 0xa438, 0x8c14,
+	0xa438, 0x006f, 0xa438, 0x4a03, 0xa438, 0x6f47, 0xa438, 0x266f,
+	0xa438, 0x5900, 0xa438, 0x731f, 0xa438, 0x0273, 0xa438, 0x2203,
+	0xa438, 0x8c08, 0xa438, 0xee84, 0xa438, 0x7100, 0xa438, 0x0286,
+	0xa438, 0xece0, 0xa438, 0x8043, 0xa438, 0xf626, 0xa438, 0xe480,
+	0xa438, 0x43af, 0xa438, 0x6611, 0xa438, 0xf8e0, 0xa438, 0x8012,
+	0xa438, 0xac26, 0xa438, 0x03af, 0xa438, 0x86ff, 0xa438, 0x0287,
+	0xa438, 0x0102, 0xa438, 0x8906, 0xa438, 0x0289, 0xa438, 0x29fc,
+	0xa438, 0x04f8, 0xa438, 0xf9ef, 0xa438, 0x59f9, 0xa438, 0xfaee,
+	0xa438, 0x8476, 0xa438, 0x00d6, 0xa438, 0x008f, 0xa438, 0x0266,
+	0xa438, 0x53ef, 0xa438, 0x643e, 0xa438, 0x1200, 0xa438, 0xac4f,
+	0xa438, 0x08e4, 0xa438, 0x8fe7, 0xa438, 0xe58f, 0xa438, 0xe8ae,
+	0xa438, 0x06e0, 0xa438, 0x8fe7, 0xa438, 0xe18f, 0xa438, 0xe8ee,
+	0xa438, 0x8476, 0xa438, 0x01d6, 0xa438, 0x00c0, 0xa438, 0x0266,
+	0xa438, 0x71ee, 0xa438, 0x8476, 0xa438, 0x00d6, 0xa438, 0x0090,
+	0xa438, 0x0266, 0xa438, 0x53ef, 0xa438, 0x643e, 0xa438, 0x1200,
+	0xa438, 0xac4f, 0xa438, 0x08e4, 0xa438, 0x8fe9, 0xa438, 0xe58f,
+	0xa438, 0xeaae, 0xa438, 0x06e0, 0xa438, 0x8fe9, 0xa438, 0xe18f,
+	0xa438, 0xeaee, 0xa438, 0x8476, 0xa438, 0x01d6, 0xa438, 0x00c1,
+	0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x8476, 0xa438, 0x00d6,
+	0xa438, 0x0091, 0xa438, 0x0266, 0xa438, 0x53ef, 0xa438, 0x643e,
+	0xa438, 0x1200, 0xa438, 0xac4f, 0xa438, 0x08e4, 0xa438, 0x8feb,
+	0xa438, 0xe58f, 0xa438, 0xecae, 0xa438, 0x06e0, 0xa438, 0x8feb,
+	0xa438, 0xe18f, 0xa438, 0xecee, 0xa438, 0x8476, 0xa438, 0x01d6,
+	0xa438, 0x00c2, 0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x8476,
+	0xa438, 0x01d6, 0xa438, 0x008f, 0xa438, 0x0266, 0xa438, 0x53ef,
+	0xa438, 0x643e, 0xa438, 0x1200, 0xa438, 0xac4f, 0xa438, 0x08e4,
+	0xa438, 0x8fed, 0xa438, 0xe58f, 0xa438, 0xeeae, 0xa438, 0x06e0,
+	0xa438, 0x8fed, 0xa438, 0xe18f, 0xa438, 0xeeee, 0xa438, 0x8476,
+	0xa438, 0x02d6, 0xa438, 0x00c0, 0xa438, 0x0266, 0xa438, 0x71ee,
+	0xa438, 0x8476, 0xa438, 0x01d6, 0xa438, 0x0090, 0xa438, 0x0266,
+	0xa438, 0x53ef, 0xa438, 0x643e, 0xa438, 0x1200, 0xa438, 0xac4f,
+	0xa438, 0x08e4, 0xa438, 0x8fef, 0xa438, 0xe58f, 0xa438, 0xf0ae,
+	0xa438, 0x06e0, 0xa438, 0x8fef, 0xa438, 0xe18f, 0xa438, 0xf0ee,
+	0xa438, 0x8476, 0xa438, 0x02d6, 0xa438, 0x00c1, 0xa438, 0x0266,
+	0xa438, 0x71ee, 0xa438, 0x8476, 0xa438, 0x01d6, 0xa438, 0x0091,
+	0xa438, 0x0266, 0xa438, 0x53ef, 0xa438, 0x643e, 0xa438, 0x1200,
+	0xa438, 0xac4f, 0xa438, 0x08e4, 0xa438, 0x8ff1, 0xa438, 0xe58f,
+	0xa438, 0xf2ae, 0xa438, 0x06e0, 0xa438, 0x8ff1, 0xa438, 0xe18f,
+	0xa438, 0xf2ee, 0xa438, 0x8476, 0xa438, 0x02d6, 0xa438, 0x00c2,
+	0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x8476, 0xa438, 0x02d6,
+	0xa438, 0x008f, 0xa438, 0x0266, 0xa438, 0x53ef, 0xa438, 0x643e,
+	0xa438, 0x1200, 0xa438, 0xac4f, 0xa438, 0x08e4, 0xa438, 0x8ff3,
+	0xa438, 0xe58f, 0xa438, 0xf4ae, 0xa438, 0x06e0, 0xa438, 0x8ff3,
+	0xa438, 0xe18f, 0xa438, 0xf4ee, 0xa438, 0x8476, 0xa438, 0x04d6,
+	0xa438, 0x00c0, 0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x8476,
+	0xa438, 0x02d6, 0xa438, 0x0090, 0xa438, 0x0266, 0xa438, 0x53ef,
+	0xa438, 0x643e, 0xa438, 0x1200, 0xa438, 0xac4f, 0xa438, 0x08e4,
+	0xa438, 0x8ff5, 0xa438, 0xe58f, 0xa438, 0xf6ae, 0xa438, 0x06e0,
+	0xa438, 0x8ff5, 0xa438, 0xe18f, 0xa438, 0xf6ee, 0xa438, 0x8476,
+	0xa438, 0x04d6, 0xa438, 0x00c1, 0xa438, 0x0266, 0xa438, 0x71ee,
+	0xa438, 0x8476, 0xa438, 0x02d6, 0xa438, 0x0091, 0xa438, 0x0266,
+	0xa438, 0x53ef, 0xa438, 0x643e, 0xa438, 0x1200, 0xa438, 0xac4f,
+	0xa438, 0x08e4, 0xa438, 0x8ff7, 0xa438, 0xe58f, 0xa438, 0xf8ae,
+	0xa438, 0x06e0, 0xa438, 0x8ff7, 0xa438, 0xe18f, 0xa438, 0xf8ee,
+	0xa438, 0x8476, 0xa438, 0x04d6, 0xa438, 0x00c2, 0xa438, 0x0266,
+	0xa438, 0x71ee, 0xa438, 0x8476, 0xa438, 0x03d6, 0xa438, 0x008f,
+	0xa438, 0x0266, 0xa438, 0x53ef, 0xa438, 0x643e, 0xa438, 0x1200,
+	0xa438, 0xac4f, 0xa438, 0x08e4, 0xa438, 0x8ff9, 0xa438, 0xe58f,
+	0xa438, 0xfaae, 0xa438, 0x06e0, 0xa438, 0x8ff9, 0xa438, 0xe18f,
+	0xa438, 0xfaee, 0xa438, 0x8476, 0xa438, 0x08d6, 0xa438, 0x00c0,
+	0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x8476, 0xa438, 0x03d6,
+	0xa438, 0x0090, 0xa438, 0x0266, 0xa438, 0x53ef, 0xa438, 0x643e,
+	0xa438, 0x1200, 0xa438, 0xac4f, 0xa438, 0x08e4, 0xa438, 0x8ffb,
+	0xa438, 0xe58f, 0xa438, 0xfcae, 0xa438, 0x06e0, 0xa438, 0x8ffb,
+	0xa438, 0xe18f, 0xa438, 0xfcee, 0xa438, 0x8476, 0xa438, 0x08d6,
+	0xa438, 0x00c1, 0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x8476,
+	0xa438, 0x03d6, 0xa438, 0x0091, 0xa438, 0x0266, 0xa438, 0x53ef,
+	0xa438, 0x643e, 0xa438, 0x1200, 0xa438, 0xac4f, 0xa438, 0x08e4,
+	0xa438, 0x8ffd, 0xa438, 0xe58f, 0xa438, 0xfeae, 0xa438, 0x06e0,
+	0xa438, 0x8ffd, 0xa438, 0xe18f, 0xa438, 0xfeee, 0xa438, 0x8476,
+	0xa438, 0x08d6, 0xa438, 0x00c2, 0xa438, 0x0266, 0xa438, 0x71fe,
+	0xa438, 0xfdef, 0xa438, 0x95fd, 0xa438, 0xfc04, 0xa438, 0xf8f9,
+	0xa438, 0xfad4, 0xa438, 0x0400, 0xa438, 0xd600, 0xa438, 0x0dd3,
+	0xa438, 0x0fe7, 0xa438, 0x8476, 0xa438, 0x0266, 0xa438, 0x71d4,
+	0xa438, 0x1400, 0xa438, 0xd600, 0xa438, 0x0dd3, 0xa438, 0x0fe7,
+	0xa438, 0x8476, 0xa438, 0x0266, 0xa438, 0x71fe, 0xa438, 0xfdfc,
+	0xa438, 0x04f8, 0xa438, 0xf9fa, 0xa438, 0xd410, 0xa438, 0x00d6,
+	0xa438, 0x000d, 0xa438, 0xd30f, 0xa438, 0xe784, 0xa438, 0x7602,
+	0xa438, 0x6671, 0xa438, 0xd400, 0xa438, 0x00d6, 0xa438, 0x000d,
+	0xa438, 0xd30f, 0xa438, 0xe784, 0xa438, 0x7602, 0xa438, 0x6671,
+	0xa438, 0xfefd, 0xa438, 0xfc04, 0xa438, 0xe080, 0xa438, 0x4fac,
+	0xa438, 0x2317, 0xa438, 0xe080, 0xa438, 0x44ad, 0xa438, 0x231a,
+	0xa438, 0x0289, 0xa438, 0x75e0, 0xa438, 0x8044, 0xa438, 0xac23,
+	0xa438, 0x11bf, 0xa438, 0x6ecf, 0xa438, 0x0276, 0xa438, 0x74ae,
+	0xa438, 0x0902, 0xa438, 0x8adb, 0xa438, 0x021f, 0xa438, 0xe702,
+	0xa438, 0x1fbb, 0xa438, 0xaf1f, 0xa438, 0x95f8, 0xa438, 0xf9ef,
+	0xa438, 0x59f9, 0xa438, 0xfafb, 0xa438, 0xe080, 0xa438, 0x12ac,
+	0xa438, 0x2303, 0xa438, 0xaf8a, 0xa438, 0xd0d4, 0xa438, 0x0120,
+	0xa438, 0xd600, 0xa438, 0x10d2, 0xa438, 0x0fe6, 0xa438, 0x8476,
+	0xa438, 0x0266, 0xa438, 0x71ee, 0xa438, 0x846f, 0xa438, 0x00d4,
+	0xa438, 0x000f, 0xa438, 0xbf72, 0xa438, 0x9e02, 0xa438, 0x7697,
+	0xa438, 0x0275, 0xa438, 0xbeef, 0xa438, 0x47e4, 0xa438, 0x8474,
+	0xa438, 0xe584, 0xa438, 0x75bf, 0xa438, 0x729b, 0xa438, 0x0276,
+	0xa438, 0xb6e5, 0xa438, 0x846f, 0xa438, 0xef31, 0xa438, 0xbf6e,
+	0xa438, 0x0602, 0xa438, 0x76b6, 0xa438, 0xef64, 0xa438, 0xbf6e,
+	0xa438, 0x0902, 0xa438, 0x76b6, 0xa438, 0x1e64, 0xa438, 0xbf6e,
+	0xa438, 0x0f02, 0xa438, 0x76b6, 0xa438, 0x1e64, 0xa438, 0xac40,
+	0xa438, 0x05a3, 0xa438, 0x0f0c, 0xa438, 0xae26, 0xa438, 0xa303,
+	0xa438, 0x02ae, 0xa438, 0x21a3, 0xa438, 0x0c02, 0xa438, 0xae1c,
+	0xa438, 0xe084, 0xa438, 0x74e1, 0xa438, 0x8475, 0xa438, 0xef64,
+	0xa438, 0xd000, 0xa438, 0xd196, 0xa438, 0xef74, 0xa438, 0x0275,
+	0xa438, 0xd9ad, 0xa438, 0x50b7, 0xa438, 0xe083, 0xa438, 0xecf7,
+	0xa438, 0x23e4, 0xa438, 0x83ec, 0xa438, 0xbf72, 0xa438, 0x9e02,
+	0xa438, 0x766b, 0xa438, 0x0287, 0xa438, 0x0102, 0xa438, 0x8906,
+	0xa438, 0xee83, 0xa438, 0xe800, 0xa438, 0xbf72, 0xa438, 0x6b02,
+	0xa438, 0x766b, 0xa438, 0xbf72, 0xa438, 0x6e02, 0xa438, 0x766b,
+	0xa438, 0xbf72, 0xa438, 0x7102, 0xa438, 0x766b, 0xa438, 0xbf72,
+	0xa438, 0x7402, 0xa438, 0x766b, 0xa438, 0xbf72, 0xa438, 0x7702,
+	0xa438, 0x766b, 0xa438, 0xbf72, 0xa438, 0x7a02, 0xa438, 0x766b,
+	0xa438, 0xd400, 0xa438, 0x0fbf, 0xa438, 0x7295, 0xa438, 0x0276,
+	0xa438, 0x97d7, 0xa438, 0x0400, 0xa438, 0xbf6e, 0xa438, 0x0602,
+	0xa438, 0x76b6, 0xa438, 0xef64, 0xa438, 0xbf6e, 0xa438, 0x0902,
+	0xa438, 0x76b6, 0xa438, 0x1e64, 0xa438, 0xbf6e, 0xa438, 0x0f02,
+	0xa438, 0x76b6, 0xa438, 0x1e64, 0xa438, 0xac40, 0xa438, 0x0fbf,
+	0xa438, 0x7298, 0xa438, 0x0276, 0xa438, 0xb6e5, 0xa438, 0x83e8,
+	0xa438, 0xa10f, 0xa438, 0x28af, 0xa438, 0x8a95, 0xa438, 0xbf8b,
+	0xa438, 0xf302, 0xa438, 0x76b6, 0xa438, 0xac28, 0xa438, 0x02ae,
+	0xa438, 0x0bbf, 0xa438, 0x8bf9, 0xa438, 0x0276, 0xa438, 0xb6e5,
+	0xa438, 0x83e8, 0xa438, 0xae09, 0xa438, 0xbf8b, 0xa438, 0xf602,
+	0xa438, 0x76b6, 0xa438, 0xe583, 0xa438, 0xe8a1, 0xa438, 0x0303,
+	0xa438, 0xaf8a, 0xa438, 0x95b7, 0xa438, 0xafe2, 0xa438, 0x83ec,
+	0xa438, 0xf735, 0xa438, 0xe683, 0xa438, 0xecbf, 0xa438, 0x7295,
+	0xa438, 0x0276, 0xa438, 0x6bbf, 0xa438, 0x726b, 0xa438, 0x0276,
+	0xa438, 0x74bf, 0xa438, 0x726e, 0xa438, 0x0276, 0xa438, 0x74bf,
+	0xa438, 0x7271, 0xa438, 0x0276, 0xa438, 0x74bf, 0xa438, 0x7274,
+	0xa438, 0x0276, 0xa438, 0x74bf, 0xa438, 0x7277, 0xa438, 0x0276,
+	0xa438, 0x74bf, 0xa438, 0x727a, 0xa438, 0x0276, 0xa438, 0x7402,
+	0xa438, 0x8929, 0xa438, 0xd401, 0xa438, 0x28d6, 0xa438, 0x0010,
+	0xa438, 0xd20f, 0xa438, 0xe684, 0xa438, 0x7602, 0xa438, 0x6671,
+	0xa438, 0x021f, 0xa438, 0xbbff, 0xa438, 0xfefd, 0xa438, 0xef95,
+	0xa438, 0xfdfc, 0xa438, 0x04f8, 0xa438, 0xf9ef, 0xa438, 0x59f9,
+	0xa438, 0xe080, 0xa438, 0x12ad, 0xa438, 0x230c, 0xa438, 0xbf72,
+	0xa438, 0x9e02, 0xa438, 0x766b, 0xa438, 0xbf72, 0xa438, 0x9502,
+	0xa438, 0x766b, 0xa438, 0xfdef, 0xa438, 0x95fd, 0xa438, 0xfc04,
+	0xa438, 0xbf6e, 0xa438, 0x0602, 0xa438, 0x76b6, 0xa438, 0xef64,
+	0xa438, 0xbf6e, 0xa438, 0x0902, 0xa438, 0x76b6, 0xa438, 0x1e64,
+	0xa438, 0xbf6e, 0xa438, 0x0f02, 0xa438, 0x76b6, 0xa438, 0x1e64,
+	0xa438, 0xac40, 0xa438, 0x0ebf, 0xa438, 0x7298, 0xa438, 0x0276,
+	0xa438, 0xb6e5, 0xa438, 0x8478, 0xa438, 0xa10f, 0xa438, 0x26ae,
+	0xa438, 0x47bf, 0xa438, 0x8bf3, 0xa438, 0x0276, 0xa438, 0xb6ac,
+	0xa438, 0x2802, 0xa438, 0xae0b, 0xa438, 0xbf8b, 0xa438, 0xf902,
+	0xa438, 0x76b6, 0xa438, 0xe584, 0xa438, 0x78ae, 0xa438, 0x09bf,
+	0xa438, 0x8bf6, 0xa438, 0x0276, 0xa438, 0xb6e5, 0xa438, 0x8478,
+	0xa438, 0xa103, 0xa438, 0x02ae, 0xa438, 0x23e0, 0xa438, 0x8474,
+	0xa438, 0xe184, 0xa438, 0x75ef, 0xa438, 0x64e0, 0xa438, 0x83fc,
+	0xa438, 0xe183, 0xa438, 0xfdef, 0xa438, 0x7402, 0xa438, 0x75d9,
+	0xa438, 0xad50, 0xa438, 0x0ae0, 0xa438, 0x83ec, 0xa438, 0xf721,
+	0xa438, 0xe483, 0xa438, 0xecae, 0xa438, 0x03af, 0xa438, 0x68e4,
+	0xa438, 0xbf72, 0xa438, 0x9502, 0xa438, 0x766b, 0xa438, 0xe083,
+	0xa438, 0xebad, 0xa438, 0x2170, 0xa438, 0xbf73, 0xa438, 0x7f02,
+	0xa438, 0x766b, 0xa438, 0xd700, 0xa438, 0x64bf, 0xa438, 0x73c4,
+	0xa438, 0x0276, 0xa438, 0xb6a4, 0xa438, 0x0000, 0xa438, 0x02ae,
+	0xa438, 0x0d87, 0xa438, 0xa700, 0xa438, 0x00ef, 0xa438, 0xe183,
+	0xa438, 0xecf7, 0xa438, 0x2ae5, 0xa438, 0x83ec, 0xa438, 0xbf73,
+	0xa438, 0xbe02, 0xa438, 0x766b, 0xa438, 0xbf73, 0xa438, 0xb802,
+	0xa438, 0x766b, 0xa438, 0xbf73, 0xa438, 0xc102, 0xa438, 0x766b,
+	0xa438, 0xbf73, 0xa438, 0xbb02, 0xa438, 0x766b, 0xa438, 0xe084,
+	0xa438, 0x9ee1, 0xa438, 0x849f, 0xa438, 0xbf72, 0xa438, 0x7d02,
+	0xa438, 0x7697, 0xa438, 0xbf72, 0xa438, 0x8002, 0xa438, 0x7697,
+	0xa438, 0xbf72, 0xa438, 0x8302, 0xa438, 0x7697, 0xa438, 0xbf72,
+	0xa438, 0x8602, 0xa438, 0x7697, 0xa438, 0xbf72, 0xa438, 0x8902,
+	0xa438, 0x7674, 0xa438, 0xbf72, 0xa438, 0x8c02, 0xa438, 0x7674,
+	0xa438, 0xbf72, 0xa438, 0x8f02, 0xa438, 0x7674, 0xa438, 0xbf72,
+	0xa438, 0x9202, 0xa438, 0x7674, 0xa438, 0xee84, 0xa438, 0x7700,
+	0xa438, 0xe080, 0xa438, 0x44f6, 0xa438, 0x21e4, 0xa438, 0x8044,
+	0xa438, 0xaf68, 0xa438, 0xe411, 0xa438, 0xd1a4, 0xa438, 0x10bc,
+	0xa438, 0x7432, 0xa438, 0xbc74, 0xa438, 0xbbbf, 0xa438, 0x14cc,
+	0xa438, 0xbfaa, 0xa438, 0x00bf, 0xa438, 0x9055, 0xa438, 0xbf06,
+	0xa438, 0x10bf, 0xa438, 0xb876, 0xa438, 0xbe02, 0xa438, 0x54be,
+	0xa438, 0x0232, 0xa438, 0xbe02, 0xa438, 0x10be, 0xa438, 0x0200,
+	0xa436, 0x8fe7, 0xa438, 0x1200, 0xa436, 0x8fe9, 0xa438, 0x1200,
+	0xa436, 0x8feb, 0xa438, 0x1200, 0xa436, 0x8fed, 0xa438, 0x1200,
+	0xa436, 0x8fef, 0xa438, 0x1200, 0xa436, 0x8ff1, 0xa438, 0x1200,
+	0xa436, 0x8ff3, 0xa438, 0x1200, 0xa436, 0x8ff5, 0xa438, 0x1200,
+	0xa436, 0x8ff7, 0xa438, 0x1200, 0xa436, 0x8ff9, 0xa438, 0x1200,
+	0xa436, 0x8ffb, 0xa438, 0x1200, 0xa436, 0x8ffd, 0xa438, 0x1200,
+	0xa436, 0xb818, 0xa438, 0x6602, 0xa436, 0xb81a, 0xa438, 0x1f75,
+	0xa436, 0xb81c, 0xa438, 0x67eb, 0xa436, 0xb81e, 0xa438, 0xffff,
+	0xa436, 0xb850, 0xa438, 0xffff, 0xa436, 0xb852, 0xa438, 0xffff,
+	0xa436, 0xb878, 0xa438, 0xffff, 0xa436, 0xb884, 0xa438, 0xffff,
+	0xa436, 0xb832, 0xa438, 0x0007, 0xB82E, 0x0000, 0xa436, 0x8023,
+	0xa438, 0x0000, 0xB820, 0x0000, 0xFFFF, 0xFFFF
+};
+
+static const u16 phy_mcu_ram_code_8127a_2[] = {
+	0xb892, 0x0000, 0xB88E, 0xc07c, 0xB890, 0x0203, 0xB890, 0x0304,
+	0xB890, 0x0405, 0xB890, 0x0607, 0xB890, 0x0809, 0xB890, 0x0B0D,
+	0xB890, 0x0F11, 0xB890, 0x1418, 0xB890, 0x1B20, 0xB890, 0x252B,
+	0xB890, 0x343E, 0xB890, 0x4854, 0xB890, 0x6203, 0xB890, 0x0304,
+	0xB890, 0x0506, 0xB890, 0x080A, 0xB890, 0x0C0E, 0xB890, 0x1216,
+	0xB890, 0x1B22, 0xB890, 0x2A34, 0xB890, 0x404F, 0xB890, 0x6171,
+	0xB890, 0x7884, 0xB890, 0x9097, 0xB890, 0x0203, 0xB890, 0x0406,
+	0xB890, 0x080B, 0xB890, 0x0E13, 0xB890, 0x1820, 0xB890, 0x2A39,
+	0xB890, 0x4856, 0xB890, 0xE060, 0xB890, 0xE050, 0xB890, 0xD080,
+	0xB890, 0x8070, 0xB890, 0x70A0, 0xB890, 0x1000, 0xB890, 0x60D0,
+	0xB890, 0xB010, 0xB890, 0xE0B0, 0xB890, 0x80C0, 0xB890, 0xE000,
+	0xB890, 0x2020, 0xB890, 0x1020, 0xB890, 0xE090, 0xB890, 0x80C0,
+	0xB890, 0x3020, 0xB890, 0x00E0, 0xB890, 0x40A0, 0xB890, 0xE020,
+	0xB890, 0x5060, 0xB890, 0xE0D0, 0xB890, 0xA000, 0xB890, 0x3030,
+	0xB890, 0x4070, 0xB890, 0xE0E0, 0xB890, 0xD080, 0xB890, 0xA010,
+	0xB890, 0xE040, 0xB890, 0x80B0, 0xB890, 0x50B0, 0xB890, 0x2090,
+	0xB820, 0x0000, 0xFFFF, 0xFFFF
+};
+
+static void
+rtl_real_set_phy_mcu_8127a_1(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_ram_code(hw, phy_mcu_ram_code_8127a_1,
+				 ARRAY_SIZE(phy_mcu_ram_code_8127a_1));
+}
+
+static void
+rtl_real_set_phy_mcu_8127a_2(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_ram_code(hw, phy_mcu_ram_code_8127a_2,
+				 ARRAY_SIZE(phy_mcu_ram_code_8127a_2));
+}
+
+void
+rtl_set_phy_mcu_8127a_1(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_real_set_phy_mcu_8127a_1(hw);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_real_set_phy_mcu_8127a_2(hw);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
diff --git a/drivers/net/r8169/base/rtl8127_mcu.h b/drivers/net/r8169/base/rtl8127_mcu.h
new file mode 100644
index 0000000000..3cea035cf8
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8127_mcu.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef RTL8127_MCU_H
+#define RTL8127_MCU_H
+
+void rtl_set_mac_mcu_8127a_1(struct rtl_hw *hw);
+
+void rtl_set_phy_mcu_8127a_1(struct rtl_hw *hw);
+
+#endif /* RTL8127_MCU_H */
diff --git a/drivers/net/r8169/base/rtl8168kb.c b/drivers/net/r8169/base/rtl8168kb.c
index 1131f69856..e6f9d68c45 100644
--- a/drivers/net/r8169/base/rtl8168kb.c
+++ b/drivers/net/r8169/base/rtl8168kb.c
@@ -91,8 +91,13 @@ hw_mac_mcu_config_8168kb(struct rtl_hw *hw)
 	if (hw->NotWrMcuPatchCode)
 		return;
 
+	rtl_hw_disable_mac_mcu_bps(hw);
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_52:
+		/* Get H/W mac mcu patch code version */
+		hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
 		rtl_set_mac_mcu_8125a_2(hw);
 		break;
 	case CFG_METHOD_53:
diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index 720d79acff..5662ecf0f5 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -27,4 +27,6 @@ sources = files(
         'base/rtl8168fp.c',
         'base/rtl8168fp_mcu.c',
         'base/rtl8168m.c',
+        'base/rtl8127.c',
+        'base/rtl8127_mcu.c',
 )
\ No newline at end of file
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index 631acffb64..8d06120518 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -105,6 +105,7 @@ enum mcfg {
 	CFG_METHOD_69,
 	CFG_METHOD_70,
 	CFG_METHOD_71,
+	CFG_METHOD_91,
 	CFG_METHOD_MAX,
 	CFG_METHOD_DEFAULT = 0xFF
 };
@@ -393,8 +394,13 @@ enum RTL_register_content {
 
 	/* PHY status */
 	PowerSaveStatus = 0x80,
+	_1000bpsL       = 0x80000,
+	_10000bpsF      = 0x4000,
+	_10000bpsL      = 0x2000,
 	_5000bpsF       = 0x1000,
+	_5000bpsL       = 0x800,
 	_2500bpsF       = 0x400,
+	_2500bpsL       = 0x200,
 	TxFlowCtrl      = 0x40,
 	RxFlowCtrl      = 0x20,
 	_1000bpsF       = 0x10,
@@ -429,6 +435,7 @@ enum RTL_register_content {
 	EPHYAR_Reg_Mask_v2 = 0x7f,
 	EPHYAR_Reg_shift   = 16,
 	EPHYAR_Data_Mask   = 0xffff,
+	EPHYAR_EXT_ADDR    = 0x0ffe,
 
 	/* CSI access */
 	CSIAR_Flag         = 0x80000000,
@@ -513,6 +520,7 @@ enum RTL_chipset_name {
 	RTL8168G,
 	RTL8168H,
 	RTL8168M,
+	RTL8127,
 	UNKNOWN
 };
 
@@ -551,28 +559,28 @@ enum RTL_chipset_name {
 #define TRUE  1
 #define FALSE 0
 
-#define SPEED_10	10
-#define SPEED_100	100
-#define SPEED_1000	1000
-#define SPEED_2500	2500
-#define SPEED_5000	5000
-
-#define DUPLEX_HALF	1
-#define DUPLEX_FULL	2
-
-#define AUTONEG_ENABLE	1
-#define AUTONEG_DISABLE	0
-
-#define ADVERTISE_10_HALF     0x0001
-#define ADVERTISE_10_FULL     0x0002
-#define ADVERTISE_100_HALF    0x0004
-#define ADVERTISE_100_FULL    0x0008
-#define ADVERTISE_1000_HALF   0x0010 /* Not used, just FYI */
-#define ADVERTISE_1000_FULL   0x0020
-#define ADVERTISE_2500_HALF   0x0040 /* NOT used, just FYI */
-#define ADVERTISE_2500_FULL   0x0080
-#define ADVERTISE_5000_HALF   0x0100 /* NOT used, just FYI */
-#define ADVERTISE_5000_FULL   0x0200
+#define SPEED_10     10
+#define SPEED_100    100
+#define SPEED_1000   1000
+#define SPEED_2500   2500
+#define SPEED_5000   5000
+#define SPEED_10000  10000
+
+#define DUPLEX_HALF 1
+#define DUPLEX_FULL 2
+
+#define AUTONEG_ENABLE  1
+#define AUTONEG_DISABLE 0
+
+#define ADVERTISE_10_HALF     RTE_BIT64(0)
+#define ADVERTISE_10_FULL     RTE_BIT64(1)
+#define ADVERTISE_100_HALF    RTE_BIT64(2)
+#define ADVERTISE_100_FULL    RTE_BIT64(3)
+#define ADVERTISE_1000_HALF   RTE_BIT64(4)
+#define ADVERTISE_1000_FULL   RTE_BIT64(5)
+#define ADVERTISE_2500_FULL   RTE_BIT64(15)
+#define ADVERTISE_5000_FULL   RTE_BIT64(48)
+#define ADVERTISE_10000_FULL  RTE_BIT64(12)
 
 #define RTL_MAX_TX_DESC 4096
 #define RTL_MAX_RX_DESC 4096
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index e2ea9435fe..1f4c7eb885 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -56,6 +56,8 @@ static const struct rte_pci_id pci_id_r8169_map[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8126) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x5000) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8168) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8127) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x0E10) },
 	{.vendor_id = 0, /* sentinel */ },
 };
 
@@ -165,6 +167,9 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 		case CFG_METHOD_71:
 			speed_mode = SPEED_5000;
 			break;
+		case CFG_METHOD_91:
+			speed_mode = SPEED_10000;
+			break;
 		default:
 			speed_mode = SPEED_1000;
 			break;
@@ -176,7 +181,8 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 		if (*link_speeds & ~(RTE_ETH_LINK_SPEED_10M_HD | RTE_ETH_LINK_SPEED_10M |
 				     RTE_ETH_LINK_SPEED_100M_HD | RTE_ETH_LINK_SPEED_100M |
 				     RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
-				     RTE_ETH_LINK_SPEED_5G | RTE_ETH_LINK_SPEED_FIXED))
+				     RTE_ETH_LINK_SPEED_5G | RTE_ETH_LINK_SPEED_10G |
+				     RTE_ETH_LINK_SPEED_FIXED))
 			goto error_invalid_config;
 
 		if (*link_speeds & RTE_ETH_LINK_SPEED_10M_HD) {
@@ -214,6 +220,11 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 			hw->duplex = DUPLEX_FULL;
 			adv |= ADVERTISE_5000_FULL;
 		}
+		if (*link_speeds & RTE_ETH_LINK_SPEED_10G) {
+			hw->speed = SPEED_10000;
+			hw->duplex = DUPLEX_FULL;
+			adv |= ADVERTISE_10000_FULL;
+		}
 
 		hw->autoneg = AUTONEG_ENABLE;
 		hw->advertising = adv;
@@ -295,27 +306,8 @@ rtl_dev_start(struct rte_eth_dev *dev)
 
 	rtl_hw_config(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (!rtl_is_8125(hw))
 		set_offset79(pci_dev, 0x40);
-		break;
-	}
 
 	/* Initialize transmission unit */
 	rtl_tx_init(dev);
@@ -362,23 +354,8 @@ rtl_dev_stop(struct rte_eth_dev *dev)
 
 	rtl_nic_reset(hw);
 
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+	if (rtl_is_8125(hw))
 		rtl_mac_ocp_write(hw, 0xE00A, hw->mcu_pme_setting);
-		break;
-	}
 
 	rtl_powerdown_pll(hw);
 
@@ -411,23 +388,8 @@ rtl_dev_set_link_down(struct rte_eth_dev *dev)
 	struct rtl_hw *hw = &adapter->hw;
 
 	/* mcu pme intr masks */
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+	if (rtl_is_8125(hw))
 		rtl_mac_ocp_write(hw, 0xE00A, hw->mcu_pme_setting & ~(BIT_11 | BIT_14));
-		break;
-	}
 
 	rtl_powerdown_pll(hw);
 
@@ -463,6 +425,9 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			       RTE_ETH_LINK_SPEED_1G;
 
 	switch (hw->chipset_name) {
+	case RTL8127:
+		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_10G;
+	/* fallthrough */
 	case RTL8126A:
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_5G;
 	/* fallthrough */
@@ -605,61 +570,23 @@ rtl_dev_link_update(struct rte_eth_dev *dev, int wait __rte_unused)
 
 		if (status & FullDup) {
 			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			switch (hw->mcfg) {
-			case CFG_METHOD_21:
-			case CFG_METHOD_22:
-			case CFG_METHOD_23:
-			case CFG_METHOD_24:
-			case CFG_METHOD_25:
-			case CFG_METHOD_26:
-			case CFG_METHOD_27:
-			case CFG_METHOD_28:
-			case CFG_METHOD_29:
-			case CFG_METHOD_30:
-			case CFG_METHOD_31:
-			case CFG_METHOD_32:
-			case CFG_METHOD_33:
-			case CFG_METHOD_34:
-			case CFG_METHOD_35:
-			case CFG_METHOD_36:
-			case CFG_METHOD_37:
-			case CFG_METHOD_48:
+			if (!rtl_is_8125(hw) || hw->mcfg == CFG_METHOD_48)
 				RTL_W32(hw, TxConfig, (RTL_R32(hw, TxConfig) |
 						      (BIT_24 | BIT_25)) & ~BIT_19);
-				break;
-			}
 		} else {
 			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
-			switch (hw->mcfg) {
-			case CFG_METHOD_21:
-			case CFG_METHOD_22:
-			case CFG_METHOD_23:
-			case CFG_METHOD_24:
-			case CFG_METHOD_25:
-			case CFG_METHOD_26:
-			case CFG_METHOD_27:
-			case CFG_METHOD_28:
-			case CFG_METHOD_29:
-			case CFG_METHOD_30:
-			case CFG_METHOD_31:
-			case CFG_METHOD_32:
-			case CFG_METHOD_33:
-			case CFG_METHOD_34:
-			case CFG_METHOD_35:
-			case CFG_METHOD_36:
-			case CFG_METHOD_37:
-			case CFG_METHOD_48:
+			if (!rtl_is_8125(hw) || hw->mcfg == CFG_METHOD_48)
 				RTL_W32(hw, TxConfig, (RTL_R32(hw, TxConfig) | BIT_25) &
 						      ~(BIT_19 | BIT_24));
-				break;
-			}
 		}
 
 		/*
 		 * The PHYstatus register for the RTL8168 is 8 bits,
-		 * while for the RTL8125 and RTL8126, it is 16 bits.
+		 * while for the RTL8125, RTL8126 and RTL8127, it is 16 bits.
 		 */
-		if (status & _5000bpsF && rtl_is_8125(hw))
+		if (status & _10000bpsF && rtl_is_8125(hw))
+			speed = 10000;
+		else if (status & _5000bpsF && rtl_is_8125(hw))
 			speed = 5000;
 		else if (status & _2500bpsF && rtl_is_8125(hw))
 			speed = 2500;
diff --git a/drivers/net/r8169/r8169_ethdev.h b/drivers/net/r8169/r8169_ethdev.h
index 0de91045fa..bc65ccf68a 100644
--- a/drivers/net/r8169/r8169_ethdev.h
+++ b/drivers/net/r8169/r8169_ethdev.h
@@ -52,6 +52,8 @@ struct rtl_hw {
 	u8  NotWrMcuPatchCode;
 	u8  HwSuppMacMcuVer;
 	u16 MacMcuPageSize;
+	u64 hw_mcu_patch_code_ver;
+	u64 bin_mcu_patch_code_ver;
 
 	u8 NotWrRamCodeToMicroP;
 	u8 HwHasWrRamCodeToMicroP;
@@ -63,7 +65,7 @@ struct rtl_hw {
 	u8  autoneg;
 	u8  duplex;
 	u32 speed;
-	u32 advertising;
+	u64 advertising;
 	enum rtl_fc_mode fcpause;
 
 	u32 HwSuppMaxPhyLinkSpeed;
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 21a599dfc6..002dc25ef7 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -431,6 +431,30 @@ rtl_mac_ocp_read(struct rtl_hw *hw, u16 addr)
 	return data16;
 }
 
+static void
+rtl_clear_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 clearmask,
+			  u16 setmask)
+{
+	u16 val;
+
+	val = rtl_mac_ocp_read(hw, addr);
+	val &= ~clearmask;
+	val |= setmask;
+	rtl_mac_ocp_write(hw, addr, val);
+}
+
+void
+rtl_clear_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
+{
+	rtl_clear_set_mac_ocp_bit(hw, addr, mask, 0);
+}
+
+void
+rtl_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
+{
+	rtl_clear_set_mac_ocp_bit(hw, addr, 0, mask);
+}
+
 u32
 rtl_csi_other_fun_read(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr)
 {
@@ -562,46 +586,26 @@ rtl8168_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
 static void
 rtl_enable_rxdvgate(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_3);
+	RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_3);
+
+	if (!rtl_is_8125(hw))
 		rte_delay_ms(2);
-		break;
-	}
 }
 
 void
 rtl_disable_rxdvgate(struct rtl_hw *hw)
 {
+	RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_3);
+
+	if (!rtl_is_8125(hw))
+		rte_delay_ms(2);
+}
+
+static void
+rtl_stop_all_request(struct rtl_hw *hw)
+{
+	int i;
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_21:
 	case CFG_METHOD_22:
@@ -620,11 +624,20 @@ rtl_disable_rxdvgate(struct rtl_hw *hw)
 	case CFG_METHOD_35:
 	case CFG_METHOD_36:
 	case CFG_METHOD_37:
+		rte_delay_ms(2);
+		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
+	case CFG_METHOD_52:
+		RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | StopReq);
+		for (i = 0; i < 20; i++) {
+			rte_delay_us(10);
+			if (!(RTL_R8(hw, ChipCmd) & StopReq))
+				break;
+		}
+		break;
 	case CFG_METHOD_50:
 	case CFG_METHOD_51:
-	case CFG_METHOD_52:
 	case CFG_METHOD_53:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
@@ -633,74 +646,17 @@ rtl_disable_rxdvgate(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
-		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_3);
-		rte_delay_ms(2);
-		break;
-	}
-}
-
-static void
-rtl8125_stop_all_request(struct rtl_hw *hw)
-{
-	int i;
-
-	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | StopReq);
-
-	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
-		for (i = 0; i < 20; i++) {
-			rte_delay_us(10);
-			if (!(RTL_R8(hw, ChipCmd) & StopReq))
-				break;
-		}
-
-		break;
-	default:
+	case CFG_METHOD_91:
+		RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | StopReq);
 		rte_delay_us(200);
 		break;
 	}
-
-	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) & (CmdTxEnb | CmdRxEnb));
 }
 
 static void
-rtl8168_stop_all_request(struct rtl_hw *hw)
+rtl_clear_stop_all_request(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rte_delay_ms(2);
-		break;
-	default:
-		rte_delay_ms(10);
-		break;
-	}
-}
-
-static void
-rtl_stop_all_request(struct rtl_hw *hw)
-{
-	if (rtl_is_8125(hw))
-		rtl8125_stop_all_request(hw);
-	else
-		rtl8168_stop_all_request(hw);
+	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) & (CmdTxEnb | CmdRxEnb));
 }
 
 static void
@@ -708,24 +664,14 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 {
 	int i;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (rtl_is_8125(hw)) {
+		for (i = 0; i < 3000; i++) {
+			rte_delay_us(50);
+			if ((RTL_R8(hw, MCUCmd_reg) & (Txfifo_empty | Rxfifo_empty)) ==
+			    (Txfifo_empty | Rxfifo_empty))
+				break;
+		}
+	} else {
 		for (i = 0; i < 10; i++) {
 			rte_delay_us(100);
 			if (RTL_R32(hw, TxConfig) & BIT_11)
@@ -740,27 +686,6 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 		}
 
 		rte_delay_ms(1);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		for (i = 0; i < 3000; i++) {
-			rte_delay_us(50);
-			if ((RTL_R8(hw, MCUCmd_reg) & (Txfifo_empty | Rxfifo_empty)) ==
-			    (Txfifo_empty | Rxfifo_empty))
-				break;
-		}
-		break;
 	}
 
 	switch (hw->mcfg) {
@@ -774,6 +699,7 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		for (i = 0; i < 3000; i++) {
 			rte_delay_us(50);
 			if ((RTL_R16(hw, IntrMitigate) & (BIT_0 | BIT_1 | BIT_8)) ==
@@ -805,7 +731,7 @@ rtl_nic_reset(struct rtl_hw *hw)
 
 	rtl_wait_txrx_fifo_empty(hw);
 
-	rte_delay_ms(2);
+	rtl_clear_stop_all_request(hw);
 
 	/* Soft reset the chip. */
 	RTL_W8(hw, ChipCmd, CmdReset);
@@ -833,43 +759,10 @@ rtl_disable_cfg9346_write(struct rtl_hw *hw)
 static void
 rtl_enable_force_clkreq(struct rtl_hw *hw, bool enable)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		if (enable)
-			RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) | BIT_7);
-		else
-			RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) & ~BIT_7);
-		break;
-	}
+	if (enable)
+		RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) | BIT_7);
+	else
+		RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) & ~BIT_7);
 }
 
 static void
@@ -935,7 +828,7 @@ rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 }
 
 static void
-rtl8126_disable_l1_timeout(struct rtl_hw *hw)
+rtl_disable_l1_timeout(struct rtl_hw *hw)
 {
 	rtl_csi_write(hw, 0x890, rtl_csi_read(hw, 0x890) & ~BIT_0);
 }
@@ -943,26 +836,7 @@ rtl8126_disable_l1_timeout(struct rtl_hw *hw)
 static void
 rtl8125_disable_eee_plus(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_mac_ocp_write(hw, 0xE080, rtl_mac_ocp_read(hw, 0xE080) & ~BIT_1);
-		break;
-	default:
-		/* Not support EEEPlus */
-		break;
-	}
+	rtl_mac_ocp_write(hw, 0xE080, rtl_mac_ocp_read(hw, 0xE080) & ~BIT_1);
 }
 
 static void
@@ -1004,6 +878,7 @@ rtl_hw_clear_timer_int(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		RTL_W32(hw, TIMER_INT0_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT1_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT2_8125, 0x0000);
@@ -1049,9 +924,6 @@ rtl8125_hw_config(struct rtl_hw *hw)
 {
 	u32 mac_ocp_data;
 
-	/* Set RxConfig to default */
-	RTL_W32(hw, RxConfig, (RX_DMA_BURST_unlimited << RxCfgDMAShift));
-
 	rtl_nic_reset(hw);
 
 	rtl_enable_cfg9346_write(hw);
@@ -1061,24 +933,7 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	rtl_enable_aspm_clkreq_lock(hw, 0);
 
 	/* Disable magic packet */
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		mac_ocp_data = 0;
-		rtl_mac_ocp_write(hw, 0xC0B6, mac_ocp_data);
-		break;
-	}
+	rtl_mac_ocp_write(hw, 0xC0B6, 0);
 
 	/* Set DMA burst size and interframe gap time */
 	RTL_W32(hw, TxConfig, (TX_DMA_BURST_unlimited << TxDMAShift) |
@@ -1103,190 +958,178 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
-		rtl8126_disable_l1_timeout(hw);
+	case CFG_METHOD_91:
+		rtl_disable_l1_timeout(hw);
 		break;
 	}
 
+	/* RSS_control_0 */
+	RTL_W32(hw, RSS_CTRL_8125, 0x00);
+
+	/* VMQ_control */
+	RTL_W16(hw, Q_NUM_CTRL_8125, 0x0000);
+
+	/* Disable speed down */
+	RTL_W8(hw, Config1, RTL_R8(hw, Config1) & ~0x10);
+
+	/* CRC disable set */
+	rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
+	rtl_mac_ocp_write(hw, 0xC142, 0xFFFF);
+
+	/* Disable new TX desc format */
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB58);
+	if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
+	    hw->mcfg == CFG_METHOD_91)
+		mac_ocp_data &= ~(BIT_0 | BIT_1);
+	else
+		mac_ocp_data &= ~BIT_0;
+	rtl_mac_ocp_write(hw, 0xEB58, mac_ocp_data);
+
+	if (hw->mcfg >= CFG_METHOD_91) {
+		if (hw->EnableTxNoClose)
+			RTL_W8(hw, 0x20E4, RTL_R8(hw, 0x20E4) | BIT_2);
+		else
+			RTL_W8(hw, 0x20E4, RTL_R8(hw, 0x20E4) & ~BIT_2);
+	}
+
 	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
-	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
-		/* RSS_control_0 */
-		RTL_W32(hw, RSS_CTRL_8125, 0x00);
-
-		/* VMQ_control */
-		RTL_W16(hw, Q_NUM_CTRL_8125, 0x0000);
+	case CFG_METHOD_91:
+		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~EnableRxDescV4_0);
+		break;
+	}
+
+	if (hw->mcfg >= CFG_METHOD_91) {
+		rtl_clear_mac_ocp_bit(hw, 0xE00C, BIT_12);
+		rtl_clear_mac_ocp_bit(hw, 0xC0C2, BIT_6);
+	}
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE63E);
+	mac_ocp_data &= ~(BIT_5 | BIT_4);
+	if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
+	    hw->mcfg == CFG_METHOD_52 || hw->mcfg == CFG_METHOD_69 ||
+	    hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
+	    hw->mcfg == CFG_METHOD_91)
+		mac_ocp_data |= ((0x02 & 0x03) << 4);
+	rtl_mac_ocp_write(hw, 0xE63E, mac_ocp_data);
+
+	/*
+	 * FTR_MCU_CTRL
+	 * 3-2 txpla packet valid start
+	 */
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xC0B4);
+	mac_ocp_data &= ~BIT_0;
+	rtl_mac_ocp_write(hw, 0xC0B4, mac_ocp_data);
+	mac_ocp_data |= BIT_0;
+	rtl_mac_ocp_write(hw, 0xC0B4, mac_ocp_data);
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xC0B4);
+	mac_ocp_data |= (BIT_3 | BIT_2);
+	rtl_mac_ocp_write(hw, 0xC0B4, mac_ocp_data);
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB6A);
+	mac_ocp_data &= ~(BIT_7 | BIT_6 | BIT_5 | BIT_4 | BIT_3 | BIT_2 |
+			  BIT_1 | BIT_0);
+	mac_ocp_data |= (BIT_5 | BIT_4 | BIT_1 | BIT_0);
+	rtl_mac_ocp_write(hw, 0xEB6A, mac_ocp_data);
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB50);
+	mac_ocp_data &= ~(BIT_9 | BIT_8 | BIT_7 | BIT_6 | BIT_5);
+	mac_ocp_data |= BIT_6;
+	rtl_mac_ocp_write(hw, 0xEB50, mac_ocp_data);
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE056);
+	mac_ocp_data &= ~(BIT_7 | BIT_6 | BIT_5 | BIT_4);
+	rtl_mac_ocp_write(hw, 0xE056, mac_ocp_data);
+
+	/* EEE_CR */
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE040);
+	mac_ocp_data &= ~BIT_12;
+	rtl_mac_ocp_write(hw, 0xE040, mac_ocp_data);
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xEA1C);
+	mac_ocp_data &= ~(BIT_1 | BIT_0);
+	mac_ocp_data |= BIT_0;
+	rtl_mac_ocp_write(hw, 0xEA1C, mac_ocp_data);
 
-		/* Disable speed down */
-		RTL_W8(hw, Config1, RTL_R8(hw, Config1) & ~0x10);
+	switch (hw->mcfg) {
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_52:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+		rtl_oob_mutex_lock(hw);
+		break;
+	}
 
-		/* CRC disable set */
-		rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
-		rtl_mac_ocp_write(hw, 0xC142, 0xFFFF);
+	/* MAC_PWRDWN_CR0 */
+	rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
 
-		/* Disable new TX desc format */
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB58);
-		if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71)
-			mac_ocp_data &= ~(BIT_0 | BIT_1);
-		else
-			mac_ocp_data &= ~BIT_0;
-		rtl_mac_ocp_write(hw, 0xEB58, mac_ocp_data);
-
-		if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71)
-			RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~BIT_1);
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xE63E);
-		mac_ocp_data &= ~(BIT_5 | BIT_4);
-		if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
-		    hw->mcfg == CFG_METHOD_52 || hw->mcfg == CFG_METHOD_69 ||
-		    hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71)
-			mac_ocp_data |= ((0x02 & 0x03) << 4);
-		rtl_mac_ocp_write(hw, 0xE63E, mac_ocp_data);
-
-		/*
-		 * FTR_MCU_CTRL
-		 * 3-2 txpla packet valid start
-		 */
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xC0B4);
-		mac_ocp_data &= ~BIT_0;
-		rtl_mac_ocp_write(hw, 0xC0B4, mac_ocp_data);
-		mac_ocp_data |= BIT_0;
-		rtl_mac_ocp_write(hw, 0xC0B4, mac_ocp_data);
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xC0B4);
-		mac_ocp_data |= (BIT_3 | BIT_2);
-		rtl_mac_ocp_write(hw, 0xC0B4, mac_ocp_data);
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB6A);
-		mac_ocp_data &= ~(BIT_7 | BIT_6 | BIT_5 | BIT_4 | BIT_3 | BIT_2 | BIT_1 |
-				  BIT_0);
-		mac_ocp_data |= (BIT_5 | BIT_4 | BIT_1 | BIT_0);
-		rtl_mac_ocp_write(hw, 0xEB6A, mac_ocp_data);
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB50);
-		mac_ocp_data &= ~(BIT_9 | BIT_8 | BIT_7 | BIT_6 | BIT_5);
-		mac_ocp_data |= BIT_6;
-		rtl_mac_ocp_write(hw, 0xEB50, mac_ocp_data);
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xE056);
-		mac_ocp_data &= ~(BIT_7 | BIT_6 | BIT_5 | BIT_4);
-		rtl_mac_ocp_write(hw, 0xE056, mac_ocp_data);
-
-		/* EEE_CR */
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xE040);
-		mac_ocp_data &= ~BIT_12;
-		rtl_mac_ocp_write(hw, 0xE040, mac_ocp_data);
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEA1C);
-		mac_ocp_data &= ~(BIT_1 | BIT_0);
-		mac_ocp_data |= BIT_0;
-		rtl_mac_ocp_write(hw, 0xEA1C, mac_ocp_data);
-
-		switch (hw->mcfg) {
-		case CFG_METHOD_48:
-		case CFG_METHOD_49:
-		case CFG_METHOD_52:
-		case CFG_METHOD_54:
-		case CFG_METHOD_55:
-			rtl_oob_mutex_lock(hw);
-			break;
-		}
+	rtl_set_mac_ocp_bit(hw, 0xE052, (BIT_6 | BIT_5));
+	rtl_clear_mac_ocp_bit(hw, 0xE052, (BIT_3 | BIT_7));
 
-		/* MAC_PWRDWN_CR0 */
-		rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
+	switch (hw->mcfg) {
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_52:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+		rtl_oob_mutex_unlock(hw);
+		break;
+	}
 
-		rtl_set_mac_ocp_bit(hw, 0xE052, (BIT_6 | BIT_5));
-		rtl_clear_mac_ocp_bit(hw, 0xE052, (BIT_3 | BIT_7));
+	/*
+	 * DMY_PWR_REG_0
+	 * (1)ERI(0xD4)(OCP 0xC0AC).bit[7:12]=6'b111111, L1 Mask
+	 */
+	rtl_set_mac_ocp_bit(hw, 0xC0AC, (BIT_7 | BIT_8 | BIT_9 | BIT_10 |
+					 BIT_11 | BIT_12));
 
-		switch (hw->mcfg) {
-		case CFG_METHOD_48:
-		case CFG_METHOD_49:
-		case CFG_METHOD_52:
-		case CFG_METHOD_54:
-		case CFG_METHOD_55:
-			rtl_oob_mutex_unlock(hw);
-			break;
-		}
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xD430);
+	mac_ocp_data &= ~(BIT_11 | BIT_10 | BIT_9 | BIT_8 | BIT_7 | BIT_6 |
+			  BIT_5 | BIT_4 | BIT_3 | BIT_2 | BIT_1 | BIT_0);
+	mac_ocp_data |= 0x45F;
+	rtl_mac_ocp_write(hw, 0xD430, mac_ocp_data);
 
-		/*
-		 * DMY_PWR_REG_0
-		 * (1)ERI(0xD4)(OCP 0xC0AC).bit[7:12]=6'b111111, L1 Mask
-		 */
-		rtl_set_mac_ocp_bit(hw, 0xC0AC,
-				    (BIT_7 | BIT_8 | BIT_9 | BIT_10 | BIT_11 | BIT_12));
-
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xD430);
-		mac_ocp_data &= ~(BIT_11 | BIT_10 | BIT_9 | BIT_8 | BIT_7 | BIT_6 | BIT_5 |
-				  BIT_4 | BIT_3 | BIT_2 | BIT_1 | BIT_0);
-		mac_ocp_data |= 0x45F;
-		rtl_mac_ocp_write(hw, 0xD430, mac_ocp_data);
-
-		if (!hw->DASH)
-			RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_6 | BIT_7);
-		else
-			RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~(BIT_6 | BIT_7));
+	if (!hw->DASH)
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_6 | BIT_7);
+	else
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~(BIT_6 | BIT_7));
 
-		if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
-		    hw->mcfg == CFG_METHOD_52)
-			RTL_W8(hw, MCUCmd_reg, RTL_R8(hw, MCUCmd_reg) | BIT_0);
+	if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
+	    hw->mcfg == CFG_METHOD_52)
+		RTL_W8(hw, MCUCmd_reg, RTL_R8(hw, MCUCmd_reg) | BIT_0);
 
-		rtl8125_disable_eee_plus(hw);
+	rtl8125_disable_eee_plus(hw);
 
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEA1C);
-		mac_ocp_data &= ~BIT_2;
-		if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71)
-			mac_ocp_data &= ~(BIT_9 | BIT_8);
-		rtl_mac_ocp_write(hw, 0xEA1C, mac_ocp_data);
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xEA1C);
+	mac_ocp_data &= ~BIT_2;
+	if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
+	    hw->mcfg == CFG_METHOD_91)
+		mac_ocp_data &= ~(BIT_9 | BIT_8);
+	rtl_mac_ocp_write(hw, 0xEA1C, mac_ocp_data);
 
-		/* Clear TCAM entries */
-		rtl_set_mac_ocp_bit(hw, 0xEB54, BIT_0);
-		rte_delay_us(1);
-		rtl_clear_mac_ocp_bit(hw, 0xEB54, BIT_0);
+	/* Clear TCAM entries */
+	rtl_set_mac_ocp_bit(hw, 0xEB54, BIT_0);
+	rte_delay_us(1);
+	rtl_clear_mac_ocp_bit(hw, 0xEB54, BIT_0);
 
-		RTL_W16(hw, 0x1880, RTL_R16(hw, 0x1880) & ~(BIT_4 | BIT_5));
+	RTL_W16(hw, 0x1880, RTL_R16(hw, 0x1880) & ~(BIT_4 | BIT_5));
 
-		switch (hw->mcfg) {
-		case CFG_METHOD_54:
-		case CFG_METHOD_55:
-		case CFG_METHOD_56:
-		case CFG_METHOD_57:
-			RTL_W8(hw, 0xd8, RTL_R8(hw, 0xd8) & ~EnableRxDescV4_0);
-			break;
-		}
-	}
+	if (hw->mcfg == CFG_METHOD_91)
+		rtl_clear_set_mac_ocp_bit(hw, 0xD40C, 0xE038, 0x8020);
 
 	/* Other hw parameters */
 	rtl_hw_clear_timer_int(hw);
 
 	rtl8125_hw_clear_int_miti(hw);
 
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_mac_ocp_write(hw, 0xE098, 0xC302);
-		break;
-	}
+	rtl_mac_ocp_write(hw, 0xE098, 0xC302);
 
 	rtl_disable_cfg9346_write(hw);
 
@@ -1308,52 +1151,12 @@ rtl8168_hw_config(struct rtl_hw *hw)
 	rtl_enable_aspm_clkreq_lock(hw, 0);
 
 	/* Clear io_rdy_l23 */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~BIT_1);
-		break;
-	}
+	RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~BIT_1);
 
 	/* Keep magic packet only */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		csi_tmp = rtl_eri_read(hw, 0xDE, 1, ERIAR_ExGMAC);
-		csi_tmp &= BIT_0;
-		rtl_eri_write(hw, 0xDE, 1, csi_tmp, ERIAR_ExGMAC);
-		break;
-	}
+	csi_tmp = rtl_eri_read(hw, 0xDE, 1, ERIAR_ExGMAC);
+	csi_tmp &= BIT_0;
+	rtl_eri_write(hw, 0xDE, 1, csi_tmp, ERIAR_ExGMAC);
 
 	/* Set TxConfig to default */
 	RTL_W32(hw, TxConfig, (TX_DMA_BURST_unlimited << TxDMAShift) |
@@ -1377,29 +1180,9 @@ rtl8168_hw_config(struct rtl_hw *hw)
 	rtl_hw_clear_timer_int(hw);
 
 	/* Clkreq exit masks */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		csi_tmp = rtl_eri_read(hw, 0xD4, 4, ERIAR_ExGMAC);
-		csi_tmp |= (BIT_7 | BIT_8 | BIT_9 | BIT_10 | BIT_11 | BIT_12);
-		rtl_eri_write(hw, 0xD4, 4, csi_tmp, ERIAR_ExGMAC);
-		break;
-	}
+	csi_tmp = rtl_eri_read(hw, 0xD4, 4, ERIAR_ExGMAC);
+	csi_tmp |= (BIT_7 | BIT_8 | BIT_9 | BIT_10 | BIT_11 | BIT_12);
+	rtl_eri_write(hw, 0xD4, 4, csi_tmp, ERIAR_ExGMAC);
 
 	switch (hw->mcfg) {
 	case CFG_METHOD_25:
@@ -1516,6 +1299,9 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 	case CFG_METHOD_71:
 		hw->hw_ops = rtl8126a_ops;
 		return 0;
+	case CFG_METHOD_91:
+		hw->hw_ops = rtl8127_ops;
+		return 0;
 	default:
 		return -ENOTSUP;
 	}
@@ -1526,48 +1312,11 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 {
 	u16 reg_addr;
 
-	rtl_enable_cfg9346_write(hw);
-	rtl_enable_aspm_clkreq_lock(hw, 0);
-	rtl_disable_cfg9346_write(hw);
-
-	switch (hw->mcfg) {
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rtl_mac_ocp_write(hw, 0xFC38, 0x0000);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_mac_ocp_write(hw, 0xFC48, 0x0000);
-		break;
-	}
+	rtl_enable_cfg9346_write(hw);
+	rtl_enable_aspm_clkreq_lock(hw, 0);
+	rtl_disable_cfg9346_write(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
 	case CFG_METHOD_29:
 	case CFG_METHOD_30:
 	case CFG_METHOD_31:
@@ -1577,11 +1326,7 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 	case CFG_METHOD_35:
 	case CFG_METHOD_36:
 	case CFG_METHOD_37:
-		for (reg_addr = 0xFC28; reg_addr < 0xFC38; reg_addr += 2)
-			rtl_mac_ocp_write(hw, reg_addr, 0x0000);
-
-		rte_delay_ms(3);
-		rtl_mac_ocp_write(hw, 0xFC26, 0x0000);
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0000);
 		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
@@ -1596,13 +1341,21 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
+		rtl_mac_ocp_write(hw, 0xFC48, 0x0000);
+		break;
+	}
+
+	if (rtl_is_8125(hw)) {
 		for (reg_addr = 0xFC28; reg_addr < 0xFC48; reg_addr += 2)
 			rtl_mac_ocp_write(hw, reg_addr, 0x0000);
-
-		rte_delay_ms(3);
-		rtl_mac_ocp_write(hw, 0xFC26, 0x0000);
-		break;
+	} else {
+		for (reg_addr = 0xFC28; reg_addr < 0xFC38; reg_addr += 2)
+			rtl_mac_ocp_write(hw, reg_addr, 0x0000);
 	}
+
+	rte_delay_ms(3);
+	rtl_mac_ocp_write(hw, 0xFC26, 0x0000);
 }
 
 static void
@@ -1647,12 +1400,37 @@ _rtl_write_mac_mcu_ram_code_with_page(struct rtl_hw *hw, const u16 *entry,
 	}
 }
 
+static void
+_rtl_set_hw_mcu_patch_code_ver(struct rtl_hw *hw, u64 ver)
+{
+	int i;
+
+	/* Switch to page 2 */
+	rtl_switch_mac_mcu_ram_code_page(hw, 2);
+
+	for (i = 0; i < 8; i += 2) {
+		rtl_mac_ocp_write(hw, 0xF9F8 + 6 - i, (u16)ver);
+		ver >>= 16;
+	}
+
+	/* Switch back to page 0 */
+	rtl_switch_mac_mcu_ram_code_page(hw, 0);
+}
+
+static void
+rtl_set_hw_mcu_patch_code_ver(struct rtl_hw *hw, u64 ver)
+{
+	_rtl_set_hw_mcu_patch_code_ver(hw, ver);
+
+	hw->hw_mcu_patch_code_ver = ver;
+}
+
 void
 rtl_write_mac_mcu_ram_code(struct rtl_hw *hw, const u16 *entry, u16 entry_cnt)
 {
-	if (HW_SUPPORT_MAC_MCU(hw) == FALSE)
+	if (!HW_SUPPORT_MAC_MCU(hw))
 		return;
-	if (entry == NULL || entry_cnt == 0)
+	if (!entry || entry_cnt == 0)
 		return;
 
 	if (hw->MacMcuPageSize > 0)
@@ -1660,12 +1438,16 @@ rtl_write_mac_mcu_ram_code(struct rtl_hw *hw, const u16 *entry, u16 entry_cnt)
 						      hw->MacMcuPageSize);
 	else
 		_rtl_write_mac_mcu_ram_code(hw, entry, entry_cnt);
+
+	if (hw->bin_mcu_patch_code_ver > 0)
+		rtl_set_hw_mcu_patch_code_ver(hw, hw->bin_mcu_patch_code_ver);
 }
 
 bool
 rtl_is_speed_mode_valid(u32 speed)
 {
 	switch (speed) {
+	case SPEED_10000:
 	case SPEED_5000:
 	case SPEED_2500:
 	case SPEED_1000:
@@ -1708,7 +1490,7 @@ rtl_set_link_option(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex,
 	u64 adv;
 
 	if (!rtl_is_speed_mode_valid(speed))
-		speed = SPEED_1000;
+		speed = hw->HwSuppMaxPhyLinkSpeed;
 
 	if (!rtl_is_duplex_mode_valid(duplex))
 		duplex = DUPLEX_FULL;
@@ -1720,6 +1502,9 @@ rtl_set_link_option(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex,
 
 	adv = 0;
 	switch (speed) {
+	case SPEED_10000:
+		adv |= ADVERTISE_10000_FULL;
+	/* Fall through */
 	case SPEED_5000:
 		adv |= ADVERTISE_5000_FULL;
 	/* Fall through */
@@ -1767,6 +1552,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_71:
 		speed_mode = SPEED_5000;
 		break;
+	case CFG_METHOD_91:
+		speed_mode = SPEED_10000;
+		break;
 	default:
 		speed_mode = SPEED_1000;
 		break;
@@ -1912,45 +1700,15 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_71:
 		hw->chipset_name = RTL8126A;
 		break;
+	case CFG_METHOD_91:
+		hw->chipset_name = RTL8127;
+		break;
 	default:
 		hw->chipset_name = UNKNOWN;
 		break;
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		hw->HwSuppNowIsOobVer = 1;
-		break;
-	}
+	hw->HwSuppNowIsOobVer = 1;
 
 	switch (hw->mcfg) {
 	case CFG_METHOD_21:
@@ -1985,6 +1743,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		hw->HwSuppCheckPhyDisableModeVer = 3;
 		break;
 	}
@@ -2005,6 +1764,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_71:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_5000;
 		break;
+	case CFG_METHOD_91:
+		hw->HwSuppMaxPhyLinkSpeed = SPEED_10000;
+		break;
 	default:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_1000;
 		break;
@@ -2023,6 +1785,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_91:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
 	case CFG_METHOD_69:
@@ -2140,6 +1903,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_71:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_71;
 		break;
+	case CFG_METHOD_91:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_91;
+		break;
 	}
 
 	if (hw->HwIcVerUnknown) {
@@ -2147,40 +1913,10 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		hw->NotWrMcuPatchCode = TRUE;
 	}
 
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+	if (rtl_is_8125(hw)) {
 		hw->HwSuppMacMcuVer = 2;
-		break;
-	}
-
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
 		hw->MacMcuPageSize = RTL_MAC_MCU_PAGE_SIZE;
-		break;
+		hw->mcu_pme_setting = rtl_mac_ocp_read(hw, 0xE00A);
 	}
 
 	switch (hw->mcfg) {
@@ -2208,6 +1944,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_91:
 		hw->HwSuppIntMitiVer = 6;
 		break;
 	case CFG_METHOD_70:
@@ -2218,24 +1955,6 @@ rtl_init_software_variable(struct rtl_hw *hw)
 
 	rtl_set_link_option(hw, autoneg_mode, speed_mode, duplex_mode, rtl_fc_full);
 
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		hw->mcu_pme_setting = rtl_mac_ocp_read(hw, 0xE00A);
-		break;
-	}
-
 	hw->mtu = RTL_DEFAULT_MTU;
 }
 
@@ -2272,6 +1991,7 @@ rtl_exit_realwow(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		rtl_mac_ocp_write(hw, 0xC0BC, 0x00FF);
 		break;
 	}
@@ -2329,15 +2049,8 @@ rtl_wait_ll_share_fifo_ready(struct rtl_hw *hw)
 static void
 rtl8168_switch_to_sgmii_mode(struct rtl_hw *hw)
 {
-	if (!HW_SUPP_SERDES_PHY(hw))
-		return;
-
-	switch (hw->HwSuppSerDesPhyVer) {
-	case 1:
-		rtl_mac_ocp_write(hw, 0xEB00, 0x2);
-		rtl8168_set_mcu_ocp_bit(hw, 0xEB16, BIT_1);
-		break;
-	}
+	rtl_mac_ocp_write(hw, 0xEB00, 0x2);
+	rtl8168_set_mcu_ocp_bit(hw, 0xEB16, BIT_1);
 }
 
 static void
@@ -2361,63 +2074,25 @@ rtl_exit_oob(struct rtl_hw *hw)
 
 	rtl_nic_reset(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rtl_disable_now_is_oob(hw);
-
-		data16 = rtl_mac_ocp_read(hw, 0xE8DE) & ~BIT_14;
-		rtl_mac_ocp_write(hw, 0xE8DE, data16);
-		rtl_wait_ll_share_fifo_ready(hw);
-
-		data16 = rtl_mac_ocp_read(hw, 0xE8DE) | BIT_15;
-		rtl_mac_ocp_write(hw, 0xE8DE, data16);
-
-		rtl_wait_ll_share_fifo_ready(hw);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_disable_now_is_oob(hw);
+	rtl_disable_now_is_oob(hw);
 
-		data16 = rtl_mac_ocp_read(hw, 0xE8DE) & ~BIT_14;
-		rtl_mac_ocp_write(hw, 0xE8DE, data16);
-		rtl_wait_ll_share_fifo_ready(hw);
+	data16 = rtl_mac_ocp_read(hw, 0xE8DE) & ~BIT_14;
+	rtl_mac_ocp_write(hw, 0xE8DE, data16);
+	rtl_wait_ll_share_fifo_ready(hw);
 
+	if (rtl_is_8125(hw)) {
 		rtl_mac_ocp_write(hw, 0xC0AA, 0x07D0);
 
 		rtl_mac_ocp_write(hw, 0xC0A6, 0x01B5);
 
 		rtl_mac_ocp_write(hw, 0xC01E, 0x5555);
 
-		rtl_wait_ll_share_fifo_ready(hw);
-		break;
+	} else {
+		data16 = rtl_mac_ocp_read(hw, 0xE8DE) | BIT_15;
+		rtl_mac_ocp_write(hw, 0xE8DE, data16);
 	}
+
+	rtl_wait_ll_share_fifo_ready(hw);
 }
 
 static void
@@ -2448,6 +2123,7 @@ rtl_disable_ups(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		rtl_mac_ocp_write(hw, 0xD40A,
 				  rtl_mac_ocp_read(hw, 0xD40A) & ~BIT_4);
 		break;
@@ -2542,29 +2218,9 @@ rtl_hw_init(struct rtl_hw *hw)
 	rtl_disable_ocp_phy_power_saving(hw);
 
 	/* Set PCIE uncorrectable error status mask pcie 0x108 */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		csi_tmp = rtl_csi_read(hw, 0x108);
-		csi_tmp |= BIT_20;
-		rtl_csi_write(hw, 0x108, csi_tmp);
-		break;
-	}
+	csi_tmp = rtl_csi_read(hw, 0x108);
+	csi_tmp |= BIT_20;
+	rtl_csi_write(hw, 0x108, csi_tmp);
 
 	/* MCU PME setting */
 	switch (hw->mcfg) {
@@ -2845,6 +2501,14 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->HwIcVerUnknown = TRUE;
 		}
 		break;
+	case 0x6C800000:
+		if (ic_version_id == 0x100000) {
+			hw->mcfg = CFG_METHOD_91;
+		} else {
+			hw->mcfg = CFG_METHOD_91;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
 	default:
 		PMD_INIT_LOG(NOTICE, "unknown chip version (%x)", reg);
 		hw->mcfg = CFG_METHOD_DEFAULT;
@@ -2865,45 +2529,12 @@ rtl_get_mac_address(struct rtl_hw *hw, struct rte_ether_addr *ea)
 {
 	u8 mac_addr[RTE_ETHER_ADDR_LEN] = {0};
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		*(u32 *)&mac_addr[0] = rtl_eri_read(hw, 0xE0, 4, ERIAR_ExGMAC);
-		*(u16 *)&mac_addr[4] = rtl_eri_read(hw, 0xE4, 2, ERIAR_ExGMAC);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+	if (rtl_is_8125(hw)) {
 		*(u32 *)&mac_addr[0] = RTL_R32(hw, BACKUP_ADDR0_8125);
 		*(u16 *)&mac_addr[4] = RTL_R16(hw, BACKUP_ADDR1_8125);
-		break;
-	default:
-		break;
+	} else {
+		*(u32 *)&mac_addr[0] = rtl_eri_read(hw, 0xE0, 4, ERIAR_ExGMAC);
+		*(u16 *)&mac_addr[4] = rtl_eri_read(hw, 0xE4, 2, ERIAR_ExGMAC);
 	}
 
 	rte_ether_addr_copy((struct rte_ether_addr *)mac_addr, ea);
@@ -3016,3 +2647,42 @@ rtl_is_8125(struct rtl_hw *hw)
 {
 	return hw->mcfg >= CFG_METHOD_48;
 }
+
+u64
+rtl_get_hw_mcu_patch_code_ver(struct rtl_hw *hw)
+{
+	u64 ver;
+	int i;
+
+	/* Switch to page 2 */
+	rtl_switch_mac_mcu_ram_code_page(hw, 2);
+
+	ver = 0;
+	for (i = 0; i < 8; i += 2) {
+		ver <<= 16;
+		ver |= rtl_mac_ocp_read(hw, 0xF9F8 + i);
+	}
+
+	/* Switch back to page 0 */
+	rtl_switch_mac_mcu_ram_code_page(hw, 0);
+
+	return ver;
+}
+
+u64
+rtl_get_bin_mcu_patch_code_ver(const u16 *entry, u16 entry_cnt)
+{
+	u64 ver;
+	int i;
+
+	if (!entry || entry_cnt == 0 || entry_cnt < 4)
+		return 0;
+
+	ver = 0;
+	for (i = 0; i < 4; i++) {
+		ver <<= 16;
+		ver |= entry[entry_cnt - 4 + i];
+	}
+
+	return ver;
+}
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index 36a7b57c97..f775c1a547 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -18,6 +18,9 @@
 u16 rtl_mac_ocp_read(struct rtl_hw *hw, u16 addr);
 void rtl_mac_ocp_write(struct rtl_hw *hw, u16 addr, u16 value);
 
+void rtl_clear_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
+void rtl_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
+
 u32 rtl_ocp_read(struct rtl_hw *hw, u16 addr, u8 len);
 void rtl_ocp_write(struct rtl_hw *hw, u16 addr, u8 len, u32 value);
 
@@ -73,6 +76,9 @@ void rtl8168_clear_and_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr,
 void rtl8168_clear_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 void rtl8168_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 
+u64 rtl_get_hw_mcu_patch_code_ver(struct rtl_hw *hw);
+u64 rtl_get_bin_mcu_patch_code_ver(const u16 *entry, u16 entry_cnt);
+
 extern const struct rtl_hw_ops rtl8168g_ops;
 extern const struct rtl_hw_ops rtl8168h_ops;
 extern const struct rtl_hw_ops rtl8168ep_ops;
@@ -84,6 +90,7 @@ extern const struct rtl_hw_ops rtl8125bp_ops;
 extern const struct rtl_hw_ops rtl8125d_ops;
 extern const struct rtl_hw_ops rtl8126a_ops;
 extern const struct rtl_hw_ops rtl8168kb_ops;
+extern const struct rtl_hw_ops rtl8127_ops;
 
 #define NO_BASE_ADDRESS       0x00000000
 #define RTL8168FP_OOBMAC_BASE 0xBAF70000
@@ -128,6 +135,7 @@ extern const struct rtl_hw_ops rtl8168kb_ops;
 #define NIC_RAMCODE_VERSION_CFG_METHOD_69  (0x0023)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_70  (0x0033)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_71  (0x0060)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_91  (0x0015)
 
 #define RTL_MAC_MCU_PAGE_SIZE 256
 #define RTL_DEFAULT_MTU       1500
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index ce16ab3242..44ffd49a56 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -15,30 +15,6 @@
 #include "r8169_logs.h"
 #include "r8169_dash.h"
 
-static void
-rtl_clear_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 clearmask,
-			  u16 setmask)
-{
-	u16 phy_reg_value;
-
-	phy_reg_value = rtl_mac_ocp_read(hw, addr);
-	phy_reg_value &= ~clearmask;
-	phy_reg_value |= setmask;
-	rtl_mac_ocp_write(hw, addr, phy_reg_value);
-}
-
-void
-rtl_clear_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
-{
-	rtl_clear_set_mac_ocp_bit(hw, addr, mask, 0);
-}
-
-void
-rtl_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
-{
-	rtl_clear_set_mac_ocp_bit(hw, addr, 0, mask);
-}
-
 static u16
 rtl_map_phy_ocp_addr(u16 PageNum, u8 RegNum)
 {
@@ -172,12 +148,12 @@ void
 rtl_clear_and_set_eth_phy_ocp_bit(struct rtl_hw *hw, u16 addr, u16 clearmask,
 				  u16 setmask)
 {
-	u16 phy_reg_value;
+	u16 val;
 
-	phy_reg_value = rtl_mdio_direct_read_phy_ocp(hw, addr);
-	phy_reg_value &= ~clearmask;
-	phy_reg_value |= setmask;
-	rtl_mdio_direct_write_phy_ocp(hw, addr, phy_reg_value);
+	val = rtl_mdio_direct_read_phy_ocp(hw, addr);
+	val &= ~clearmask;
+	val |= setmask;
+	rtl_mdio_direct_write_phy_ocp(hw, addr, val);
 }
 
 void
@@ -208,18 +184,10 @@ rtl8168_check_ephy_addr(struct rtl_hw *hw, int addr)
 	return addr;
 }
 
-void
-rtl_ephy_write(struct rtl_hw *hw, int addr, int value)
+static void
+_rtl_ephy_write(struct rtl_hw *hw, int addr, int value, unsigned int mask)
 {
 	int i;
-	unsigned int mask;
-
-	if (rtl_is_8125(hw)) {
-		mask = EPHYAR_Reg_Mask_v2;
-	} else {
-		mask = EPHYAR_Reg_Mask;
-		addr = rtl8168_check_ephy_addr(hw, addr);
-	}
 
 	RTL_W32(hw, EPHYAR, EPHYAR_Write | (addr & mask) << EPHYAR_Reg_shift |
 		(value & EPHYAR_Data_Mask));
@@ -235,20 +203,48 @@ rtl_ephy_write(struct rtl_hw *hw, int addr, int value)
 	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
 }
 
-u16
-rtl_ephy_read(struct rtl_hw *hw, int addr)
+static void
+rtl8127_set_ephy_ext_addr(struct rtl_hw *hw, int addr)
+{
+	_rtl_ephy_write(hw, EPHYAR_EXT_ADDR, addr, EPHYAR_Reg_Mask_v2);
+}
+
+static int
+rtl8127_check_ephy_ext_addr(struct rtl_hw *hw, int addr)
+{
+	int data;
+
+	data = ((u16)addr >> 12);
+
+	rtl8127_set_ephy_ext_addr(hw, data);
+
+	return (addr & 0xfff);
+}
+
+void
+rtl_ephy_write(struct rtl_hw *hw, int addr, int value)
 {
-	int i;
-	u16 value = 0xffff;
 	unsigned int mask;
 
-	if (rtl_is_8125(hw)) {
-		mask = EPHYAR_Reg_Mask_v2;
-	} else {
+	if (!rtl_is_8125(hw)) {
 		mask = EPHYAR_Reg_Mask;
 		addr = rtl8168_check_ephy_addr(hw, addr);
+	} else if (hw->mcfg >= CFG_METHOD_91) {
+		mask = EPHYAR_Reg_Mask_v2;
+		addr = rtl8127_check_ephy_ext_addr(hw, addr);
+	} else {
+		mask = EPHYAR_Reg_Mask_v2;
 	}
 
+	_rtl_ephy_write(hw, addr, value, mask);
+}
+
+static u16
+_rtl_ephy_read(struct rtl_hw *hw, int addr, unsigned int mask)
+{
+	int i;
+	u16 value = 0xffff;
+
 	RTL_W32(hw, EPHYAR, EPHYAR_Read | (addr & mask) << EPHYAR_Reg_shift);
 
 	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
@@ -266,6 +262,24 @@ rtl_ephy_read(struct rtl_hw *hw, int addr)
 	return value;
 }
 
+u16
+rtl_ephy_read(struct rtl_hw *hw, int addr)
+{
+	unsigned int mask;
+
+	if (!rtl_is_8125(hw)) {
+		mask = EPHYAR_Reg_Mask;
+		addr = rtl8168_check_ephy_addr(hw, addr);
+	} else if (hw->mcfg >= CFG_METHOD_91) {
+		mask = EPHYAR_Reg_Mask_v2;
+		addr = rtl8127_check_ephy_ext_addr(hw, addr);
+	} else {
+		mask = EPHYAR_Reg_Mask_v2;
+	}
+
+	return _rtl_ephy_read(hw, addr, mask);
+}
+
 void
 rtl_clear_and_set_pcie_phy_bit(struct rtl_hw *hw, u8 addr, u16 clearmask,
 			       u16 setmask)
@@ -297,66 +311,36 @@ rtl_set_phy_mcu_patch_request(struct rtl_hw *hw)
 	u16 wait_cnt;
 	bool bool_success = TRUE;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rtl_mdio_write(hw, 0x1f, 0x0B82);
-		rtl_set_eth_phy_bit(hw, 0x10, BIT_4);
+	if (rtl_is_8125(hw)) {
+		rtl_set_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
 
-		rtl_mdio_write(hw, 0x1f, 0x0B80);
 		wait_cnt = 0;
 		do {
-			gphy_val = rtl_mdio_read(hw, 0x10);
+			gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
 			rte_delay_us(100);
 			wait_cnt++;
-		}  while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
+		} while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
 
 		if (!(gphy_val & BIT_6) && wait_cnt == 1000)
 			bool_success = FALSE;
+	} else {
+		rtl_mdio_write(hw, 0x1f, 0x0B82);
+		rtl_set_eth_phy_bit(hw, 0x10, BIT_4);
 
-		rtl_mdio_write(hw, 0x1f, 0x0000);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_set_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
-
+		rtl_mdio_write(hw, 0x1f, 0x0B80);
 		wait_cnt = 0;
 		do {
-			gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
+			gphy_val = rtl_mdio_read(hw, 0x10);
 			rte_delay_us(100);
 			wait_cnt++;
-		} while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
+		}  while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
 
 		if (!(gphy_val & BIT_6) && wait_cnt == 1000)
 			bool_success = FALSE;
-		break;
+
+		rtl_mdio_write(hw, 0x1f, 0x0000);
 	}
+
 	if (!bool_success)
 		PMD_INIT_LOG(NOTICE, "%s fail.", __func__);
 
@@ -370,65 +354,34 @@ rtl_clear_phy_mcu_patch_request(struct rtl_hw *hw)
 	u16 wait_cnt;
 	bool bool_success = TRUE;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rtl_mdio_write(hw, 0x1f, 0x0B82);
-		rtl_clear_eth_phy_bit(hw, 0x10, BIT_4);
+	if (rtl_is_8125(hw)) {
+		rtl_clear_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
 
-		rtl_mdio_write(hw, 0x1f, 0x0B80);
 		wait_cnt = 0;
 		do {
-			gphy_val = rtl_mdio_read(hw, 0x10);
+			gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
 			rte_delay_us(100);
 			wait_cnt++;
 		} while ((gphy_val & BIT_6) && (wait_cnt < 1000));
 
 		if ((gphy_val & BIT_6) && wait_cnt == 1000)
 			bool_success = FALSE;
+	} else {
+		rtl_mdio_write(hw, 0x1f, 0x0B82);
+		rtl_clear_eth_phy_bit(hw, 0x10, BIT_4);
 
-		rtl_mdio_write(hw, 0x1f, 0x0000);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_clear_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
-
+		rtl_mdio_write(hw, 0x1f, 0x0B80);
 		wait_cnt = 0;
 		do {
-			gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
+			gphy_val = rtl_mdio_read(hw, 0x10);
 			rte_delay_us(100);
 			wait_cnt++;
 		} while ((gphy_val & BIT_6) && (wait_cnt < 1000));
 
 		if ((gphy_val & BIT_6) && wait_cnt == 1000)
 			bool_success = FALSE;
-		break;
+
+		rtl_mdio_write(hw, 0x1f, 0x0000);
 	}
 
 	if (!bool_success)
@@ -545,6 +498,7 @@ rtl_wait_phy_ups_resume(struct rtl_hw *hw, u16 PhyState)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		do {
 			tmp_phy_state = rtl_mdio_direct_read_phy_ocp(hw, 0xA420);
 			tmp_phy_state &= 0x7;
@@ -597,6 +551,7 @@ rtl_phy_power_up(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		rtl_wait_phy_ups_resume(hw, 3);
 		break;
 	}
@@ -634,6 +589,7 @@ rtl_powerup_pll(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) | BIT_7 | BIT_6);
 		break;
 	}
@@ -699,6 +655,7 @@ rtl_phy_power_down(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_PDOWN);
 		break;
 	default:
@@ -745,6 +702,7 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 		case CFG_METHOD_69:
 		case CFG_METHOD_70:
 		case CFG_METHOD_71:
+		case CFG_METHOD_91:
 			RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) & ~BIT_7);
 			break;
 		}
@@ -783,6 +741,7 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
 		break;
 	}
@@ -813,31 +772,39 @@ rtl_wait_phy_reset_complete(struct rtl_hw *hw)
 static void
 rtl_xmii_reset_enable(struct rtl_hw *hw)
 {
+	u32 val;
+
 	if (rtl_is_in_phy_disable_mode(hw))
 		return;
 
 	rtl_mdio_write(hw, 0x1F, 0x0000);
-	rtl_mdio_write(hw, MII_ADVERTISE, rtl_mdio_read(hw, MII_ADVERTISE) &
-		       ~(ADVERTISE_10HALF | ADVERTISE_10FULL |
-		       ADVERTISE_100HALF | ADVERTISE_100FULL));
-	rtl_mdio_write(hw, MII_CTRL1000, rtl_mdio_read(hw, MII_CTRL1000) &
-		       ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL));
 
-	if (rtl_is_8125(hw))
-		rtl_mdio_direct_write_phy_ocp(hw, 0xA5D4,
-					      rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4) &
-					      ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL));
+	val = rtl_mdio_read(hw, MII_ADVERTISE);
+	val &= ~(ADVERTISE_10HALF | ADVERTISE_10FULL | ADVERTISE_100HALF |
+		 ADVERTISE_100FULL);
+	rtl_mdio_write(hw, MII_ADVERTISE, val);
+
+	val = rtl_mdio_read(hw, MII_CTRL1000);
+	val &= ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
+	rtl_mdio_write(hw, MII_CTRL1000, val);
+
+	if (rtl_is_8125(hw)) {
+		val = rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4);
+		val &= ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL |
+			 RTK_ADVERTISE_10000FULL);
+		rtl_mdio_direct_write_phy_ocp(hw, 0xA5D4, val);
+	}
 
 	rtl_mdio_write(hw, MII_BMCR, BMCR_RESET | BMCR_ANENABLE);
 
-	if (rtl_wait_phy_reset_complete(hw) == 0)
-		return;
+	if (rtl_wait_phy_reset_complete(hw))
+		PMD_INIT_LOG(NOTICE, "PHY reset failed.");
 }
 
 static void
 rtl8125_set_hw_phy_before_init_phy_mcu(struct rtl_hw *hw)
 {
-	u16 phy_reg_value;
+	u16 val;
 
 	switch (hw->mcfg) {
 	case CFG_METHOD_50:
@@ -846,11 +813,11 @@ rtl8125_set_hw_phy_before_init_phy_mcu(struct rtl_hw *hw)
 		rtl_set_eth_phy_ocp_bit(hw, 0xC402, BIT_10);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xC402, BIT_10);
 
-		phy_reg_value = rtl_mdio_direct_read_phy_ocp(hw, 0xBF86);
-		phy_reg_value &= (BIT_1 | BIT_0);
-		if (phy_reg_value != 0)
+		val = rtl_mdio_direct_read_phy_ocp(hw, 0xBF86);
+		val &= (BIT_1 | BIT_0);
+		if (val != 0)
 			PMD_INIT_LOG(NOTICE, "PHY watch dog not clear, value = 0x%x",
-				     phy_reg_value);
+				     val);
 
 		rtl_mdio_direct_write_phy_ocp(hw, 0xBD86, 0x1010);
 		rtl_mdio_direct_write_phy_ocp(hw, 0xBD88, 0x1010);
@@ -867,45 +834,14 @@ rtl_get_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 {
 	u16 hw_ram_code_ver = ~0;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (rtl_is_8125(hw)) {
+		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
+		hw_ram_code_ver = rtl_mdio_direct_read_phy_ocp(hw, 0xA438);
+	} else {
 		rtl_mdio_write(hw, 0x1F, 0x0A43);
 		rtl_mdio_write(hw, 0x13, 0x801E);
 		hw_ram_code_ver = rtl_mdio_read(hw, 0x14);
 		rtl_mdio_write(hw, 0x1F, 0x0000);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
-		hw_ram_code_ver = rtl_mdio_direct_read_phy_ocp(hw, 0xA438);
-		break;
 	}
 
 	return hw_ram_code_ver;
@@ -931,47 +867,16 @@ rtl_check_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 static void
 rtl_write_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (rtl_is_8125(hw)) {
+		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
+		rtl_mdio_direct_write_phy_ocp(hw, 0xA438, hw->sw_ram_code_ver);
+		hw->hw_ram_code_ver = hw->sw_ram_code_ver;
+	} else {
 		rtl_mdio_write(hw, 0x1F, 0x0A43);
 		rtl_mdio_write(hw, 0x13, 0x801E);
 		rtl_mdio_write(hw, 0x14, hw->sw_ram_code_ver);
 		rtl_mdio_write(hw, 0x1F, 0x0000);
 		hw->hw_ram_code_ver = hw->sw_ram_code_ver;
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
-		rtl_mdio_direct_write_phy_ocp(hw, 0xA438, hw->sw_ram_code_ver);
-		hw->hw_ram_code_ver = hw->sw_ram_code_ver;
-		break;
 	}
 }
 
@@ -1010,25 +915,25 @@ rtl_disable_phy_disable_mode(struct rtl_hw *hw)
 static int
 rtl8168_phy_ram_code_check(struct rtl_hw *hw)
 {
-	u16 phy_reg_value;
+	u16 val;
 	int retval = TRUE;
 
 	if (hw->mcfg == CFG_METHOD_21) {
 		rtl_mdio_write(hw, 0x1f, 0x0A40);
-		phy_reg_value = rtl_mdio_read(hw, 0x10);
-		phy_reg_value &= ~BIT_11;
-		rtl_mdio_write(hw, 0x10, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x10);
+		val &= ~BIT_11;
+		rtl_mdio_write(hw, 0x10, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A00);
-		phy_reg_value = rtl_mdio_read(hw, 0x10);
-		phy_reg_value &= ~(BIT_12 | BIT_13 | BIT_14 | BIT_15);
-		rtl_mdio_write(hw, 0x10, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x10);
+		val &= ~(BIT_12 | BIT_13 | BIT_14 | BIT_15);
+		rtl_mdio_write(hw, 0x10, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A43);
 		rtl_mdio_write(hw, 0x13, 0x8010);
-		phy_reg_value = rtl_mdio_read(hw, 0x14);
-		phy_reg_value &= ~BIT_11;
-		rtl_mdio_write(hw, 0x14, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x14);
+		val &= ~BIT_11;
+		rtl_mdio_write(hw, 0x14, val);
 
 		retval = rtl_set_phy_mcu_patch_request(hw);
 
@@ -1036,20 +941,20 @@ rtl8168_phy_ram_code_check(struct rtl_hw *hw)
 		rtl_mdio_write(hw, 0x10, 0x0140);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A4A);
-		phy_reg_value = rtl_mdio_read(hw, 0x13);
-		phy_reg_value &= ~BIT_6;
-		phy_reg_value |= BIT_7;
-		rtl_mdio_write(hw, 0x13, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x13);
+		val &= ~BIT_6;
+		val |= BIT_7;
+		rtl_mdio_write(hw, 0x13, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A44);
-		phy_reg_value = rtl_mdio_read(hw, 0x14);
-		phy_reg_value |= BIT_2;
-		rtl_mdio_write(hw, 0x14, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x14);
+		val |= BIT_2;
+		rtl_mdio_write(hw, 0x14, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A50);
-		phy_reg_value = rtl_mdio_read(hw, 0x11);
-		phy_reg_value |= (BIT_11 | BIT_12);
-		rtl_mdio_write(hw, 0x11, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x11);
+		val |= (BIT_11 | BIT_12);
+		rtl_mdio_write(hw, 0x11, val);
 
 		retval = rtl_clear_phy_mcu_patch_request(hw);
 
@@ -1057,32 +962,32 @@ rtl8168_phy_ram_code_check(struct rtl_hw *hw)
 		rtl_mdio_write(hw, 0x10, 0x1040);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A4A);
-		phy_reg_value = rtl_mdio_read(hw, 0x13);
-		phy_reg_value &= ~(BIT_6 | BIT_7);
-		rtl_mdio_write(hw, 0x13, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x13);
+		val &= ~(BIT_6 | BIT_7);
+		rtl_mdio_write(hw, 0x13, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A44);
-		phy_reg_value = rtl_mdio_read(hw, 0x14);
-		phy_reg_value &= ~BIT_2;
-		rtl_mdio_write(hw, 0x14, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x14);
+		val &= ~BIT_2;
+		rtl_mdio_write(hw, 0x14, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A50);
-		phy_reg_value = rtl_mdio_read(hw, 0x11);
-		phy_reg_value &= ~(BIT_11 | BIT_12);
-		rtl_mdio_write(hw, 0x11, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x11);
+		val &= ~(BIT_11 | BIT_12);
+		rtl_mdio_write(hw, 0x11, val);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A43);
 		rtl_mdio_write(hw, 0x13, 0x8010);
-		phy_reg_value = rtl_mdio_read(hw, 0x14);
-		phy_reg_value |= BIT_11;
-		rtl_mdio_write(hw, 0x14, phy_reg_value);
+		val = rtl_mdio_read(hw, 0x14);
+		val |= BIT_11;
+		rtl_mdio_write(hw, 0x14, val);
 
 		retval = rtl_set_phy_mcu_patch_request(hw);
 
 		rtl_mdio_write(hw, 0x1f, 0x0A20);
-		phy_reg_value = rtl_mdio_read(hw, 0x13);
-		if (phy_reg_value & BIT_11) {
-			if (phy_reg_value & BIT_10)
+		val = rtl_mdio_read(hw, 0x13);
+		if (val & BIT_11) {
+			if (val & BIT_10)
 				retval = FALSE;
 		}
 
@@ -1149,41 +1054,7 @@ rtl_disable_aldps(struct rtl_hw *hw)
 	u32 timeout = 0;
 	u32 wait_cnt = 200;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		tmp_ushort = rtl_mdio_real_direct_read_phy_ocp(hw, 0xA430);
-		if (tmp_ushort & BIT_2)
-			rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_2);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+	if (rtl_is_8125(hw)) {
 		tmp_ushort = rtl_mdio_real_direct_read_phy_ocp(hw, 0xA430);
 		if (tmp_ushort & BIT_2) {
 			rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_2);
@@ -1194,7 +1065,10 @@ rtl_disable_aldps(struct rtl_hw *hw)
 				timeout++;
 			} while (!(tmp_ushort & BIT_7) && timeout < wait_cnt);
 		}
-		break;
+	} else {
+		tmp_ushort = rtl_mdio_real_direct_read_phy_ocp(hw, 0xA430);
+		if (tmp_ushort & BIT_2)
+			rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_2);
 	}
 }
 
@@ -1232,6 +1106,7 @@ rtl_is_adv_eee_enabled(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		if (rtl_mdio_direct_read_phy_ocp(hw, 0xA430) & BIT_15)
 			enabled = true;
 		break;
@@ -1315,6 +1190,7 @@ _rtl_disable_adv_eee(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		rtl_clear_mac_ocp_bit(hw, 0xE052, BIT_0);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA442, (BIT_12 | BIT_13));
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_15);
@@ -1372,6 +1248,7 @@ static void
 rtl_disable_eee(struct rtl_hw *hw)
 {
 	u16 data;
+	u16 mask;
 	u32 csi_tmp;
 
 	switch (hw->mcfg) {
@@ -1438,12 +1315,16 @@ rtl_disable_eee(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
-		rtl_clear_eth_phy_ocp_bit(hw, 0xA5D0, (MDIO_EEE_100TX | MDIO_EEE_1000T));
-		rtl_clear_eth_phy_ocp_bit(hw, 0xA6D4, MDIO_EEE_2_5GT);
-		if (HW_SUPP_PHY_LINK_SPEED_5000M(hw))
-			rtl_clear_eth_phy_ocp_bit(hw, 0xA6D4, MDIO_EEE_5GT);
+		if (HW_SUPP_PHY_LINK_SPEED_10000M(hw))
+			mask = MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
+		else
+			mask = MDIO_EEE_100TX | MDIO_EEE_1000T;
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA5D0, mask);
+
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA6D4, MDIO_EEE_2_5GT | MDIO_EEE_5GT);
 
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA6D8, BIT_4);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_7);
@@ -1488,23 +1369,8 @@ rtl_hw_phy_config(struct rtl_hw *hw)
 	rtl_disable_aldps(hw);
 
 	/* Legacy force mode (chap 22) */
-	switch (hw->mcfg) {
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+	if (rtl_is_8125(hw))
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5B4, BIT_15);
-		break;
-	}
 
 	rtl_mdio_write(hw, 0x1F, 0x0000);
 
@@ -1550,8 +1416,9 @@ rtl_phy_setup_force_mode(struct rtl_hw *hw, u32 speed, u8 duplex)
 }
 
 static int
-rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
+rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u64 adv)
 {
+	u16 mask = 0;
 	int auto_nego = 0;
 	int giga_ctrl = 0;
 	int ctrl_2500 = 0;
@@ -1577,6 +1444,14 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 		rtl_mdio_write(hw, 0x1F, 0x0A40);
 		rtl_mdio_write(hw, 0x1F, 0x0000);
 		break;
+	case CFG_METHOD_91:
+		mask |= BIT_2;
+	/* Fall through */
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		mask |= BIT_1;
+	/* Fall through */
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_50:
@@ -1587,14 +1462,9 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
+		mask |= BIT_0;
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_9);
-		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, BIT_0);
-
-		if (HW_SUPP_PHY_LINK_SPEED_5000M(hw))
-			rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, BIT_1);
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, mask);
 		break;
 	}
 
@@ -1608,7 +1478,8 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 	giga_ctrl &= ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
 	if (rtl_is_8125(hw)) {
 		ctrl_2500 = rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4);
-		ctrl_2500 &= ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL);
+		ctrl_2500 &= ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL |
+			       RTK_ADVERTISE_10000FULL);
 	}
 
 	if (autoneg == AUTONEG_ENABLE) {
@@ -1634,6 +1505,8 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 			ctrl_2500 |= RTK_ADVERTISE_2500FULL;
 		if (adv & ADVERTISE_5000_FULL)
 			ctrl_2500 |= RTK_ADVERTISE_5000FULL;
+		if (adv & ADVERTISE_10000_FULL)
+			ctrl_2500 |= RTK_ADVERTISE_10000FULL;
 
 		/* Flow control */
 		if (hw->fcpause == rtl_fc_full)
@@ -1678,12 +1551,12 @@ void
 rtl_clear_and_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 clearmask,
 			      u16 setmask)
 {
-	u16 phy_reg_value;
+	u16 val;
 
-	phy_reg_value = rtl_mdio_read(hw, addr);
-	phy_reg_value &= ~clearmask;
-	phy_reg_value |= setmask;
-	rtl_mdio_write(hw, addr, phy_reg_value);
+	val = rtl_mdio_read(hw, addr);
+	val &= ~clearmask;
+	val |= setmask;
+	rtl_mdio_write(hw, addr, val);
 }
 
 void
@@ -1697,3 +1570,9 @@ rtl_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask)
 {
 	rtl_clear_and_set_eth_phy_bit(hw, addr, 0, mask);
 }
+
+void
+rtl8127_clear_ephy_ext_addr(struct rtl_hw *hw)
+{
+	rtl8127_set_ephy_ext_addr(hw, 0x0000);
+}
diff --git a/drivers/net/r8169/r8169_phy.h b/drivers/net/r8169/r8169_phy.h
index ea1facba5b..0a91515883 100644
--- a/drivers/net/r8169/r8169_phy.h
+++ b/drivers/net/r8169/r8169_phy.h
@@ -102,18 +102,17 @@
 
 #define HW_SUPPORT_CHECK_PHY_DISABLE_MODE(_M) ((_M)->HwSuppCheckPhyDisableModeVer > 0)
 
+#define HW_SUPP_PHY_LINK_SPEED_10000M(_M)     ((_M)->HwSuppMaxPhyLinkSpeed >= 10000)
 #define HW_SUPP_PHY_LINK_SPEED_5000M(_M)      ((_M)->HwSuppMaxPhyLinkSpeed >= 5000)
 
 #define MDIO_EEE_100TX  0x0002
 #define MDIO_EEE_1000T  0x0004
 #define MDIO_EEE_2_5GT  0x0001
 #define MDIO_EEE_5GT    0x0002
+#define MDIO_EEE_10GT   0x0008  /* 10GT EEE cap */
 
 #define HW_SUPP_SERDES_PHY(_M)  ((_M)->HwSuppSerDesPhyVer > 0)
 
-void rtl_clear_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
-void rtl_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
-
 u32 rtl_mdio_direct_read_phy_ocp(struct rtl_hw *hw, u32 RegAddr);
 void rtl_mdio_direct_write_phy_ocp(struct rtl_hw *hw, u32 RegAddr, u32 value);
 
@@ -155,4 +154,6 @@ void rtl_clear_and_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 clearmask,
 void rtl_clear_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask);
 void rtl_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask);
 
+void rtl8127_clear_ephy_ext_addr(struct rtl_hw *hw);
+
 #endif /* R8169_PHY_H */
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index eee91a639e..7bb2ab9cee 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -501,24 +501,7 @@ rtl_rx_init(struct rte_eth_dev *dev)
 
 	rtl_enable_cfg9346_write(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (!rtl_is_8125(hw)) {
 		/* RX ftr mcu enable */
 		csi_tmp = rtl_eri_read(hw, 0xDC, 1, ERIAR_ExGMAC);
 		csi_tmp &= ~BIT_0;
@@ -529,7 +512,6 @@ rtl_rx_init(struct rte_eth_dev *dev)
 		/* RSS disable */
 		rtl_eri_write(hw, 0xC0, 2, 0x0000, ERIAR_ExGMAC); /* queue num = 1 */
 		rtl_eri_write(hw, 0xB8, 4, 0x00000000, ERIAR_ExGMAC);
-		break;
 	}
 
 	/* RX accept type and csum vlan offload */
@@ -1090,6 +1072,9 @@ rtl8125_set_tx_tag_num(struct rtl_hw *hw)
 		else
 			mac_ocp_data |= (3 << 8);
 		break;
+	case CFG_METHOD_91:
+		mac_ocp_data |= (15 << 8);
+		break;
 	default:
 		mac_ocp_data |= (3 << 8);
 		break;
@@ -1122,47 +1107,14 @@ rtl_tx_init(struct rte_eth_dev *dev)
 
 	rtl_enable_cfg9346_write(hw);
 
-	if (rtl_is_8125(hw))
+	if (rtl_is_8125(hw)) {
 		rtl8125_set_tx_tag_num(hw);
-	else
+
+		RTL_W8(hw, TDFNR, 0x10);
+	} else {
 		rtl8168_set_mtps(hw);
 
-	/* Set TDFNR: TX Desc Fetch NumbeR */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
 		RTL_W8(hw, TDFNR, 0x4);
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		RTL_W8(hw, TDFNR, 0x10);
-		break;
 	}
 
 	rtl_disable_cfg9346_write(hw);
-- 
2.34.1

