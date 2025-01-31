Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E0C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C446C42E8B;
	Fri, 31 Jan 2025 14:00:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE9C42E6B
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328399; x=1769864399;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kv+zllshdPZxSzaUc6T9i1wt4nvcACSLJ9Oow9TA/hI=;
 b=jzBUROIyAj5F+SOXbmKEwqJd9BeY/X5Kg74GIcsOVg8DtnatKLfz08XB
 M7UBFmg+SKmhTXbBHjHihZdvf3w9PGg1FjSFvsOZYWAwW2MiuAWTflBv9
 CtAr6hozKYv9m169/RLHMvCriOnyujdMHm2+P3S1yz7jaEXWYu5xv+T6f
 qCGXU2hbrYauxIm6ZTTaT2kh/AR9N+8EcPIjP0VabITo1uJp4MAsTRWqq
 KXpw+c23+bA52MuJ52RwN1hk/KCfpShZ0inWRoxTq4GHbRTYJ3Tta+oLR
 RxT+BkVA0190z9DmFzhW7+mL/n36mln3G+DcXu1KsAvItYylMCefNmyl3 w==;
X-CSE-ConnectionGUID: Ctfl4tw6TriuQ5X8grHVdA==
X-CSE-MsgGUID: QqED5MjdSwy/nlLu6vZ+sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315658"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:58 -0800
X-CSE-ConnectionGUID: Twa5KumrSwi5wX5YotnPdw==
X-CSE-MsgGUID: w39serp7TXGzHYrxn/CZmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503417"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 31/42] net/e1000/base: remove non-inclusive language
Date: Fri, 31 Jan 2025 12:58:44 +0000
Message-ID: <91633da9a6ab835bca3675b2ce299f94db3b8793.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Marcin Jurczak <marcin.jurczak@intel.com>

This patch removes non-inclusive language from the e1000 shared code and
comments.

Signed-off-by: Marcin Jurczak <marcin.jurczak@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .../net/intel/e1000/base/e1000_80003es2lan.c  |  8 ++--
 drivers/net/intel/e1000/base/e1000_82571.c    |  4 +-
 drivers/net/intel/e1000/base/e1000_82575.c    |  8 ++--
 drivers/net/intel/e1000/base/e1000_api.c      |  8 ++--
 drivers/net/intel/e1000/base/e1000_api.h      |  2 +-
 drivers/net/intel/e1000/base/e1000_defines.h  | 40 ++++++++--------
 drivers/net/intel/e1000/base/e1000_hw.h       |  4 +-
 drivers/net/intel/e1000/base/e1000_i225.c     |  4 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.c  |  8 ++--
 drivers/net/intel/e1000/base/e1000_mac.c      | 22 ++++-----
 drivers/net/intel/e1000/base/e1000_mac.h      |  2 +-
 drivers/net/intel/e1000/base/e1000_phy.c      | 46 +++++++++----------
 drivers/net/intel/e1000/base/e1000_regs.h     |  2 +-
 drivers/net/intel/e1000/base/e1000_vf.c       |  2 +-
 14 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_80003es2lan.c b/drivers/net/intel/e1000/base/e1000_80003es2lan.c
index 243bc6fe3e..b1f2df3803 100644
--- a/drivers/net/intel/e1000/base/e1000_80003es2lan.c
+++ b/drivers/net/intel/e1000/base/e1000_80003es2lan.c
@@ -797,9 +797,9 @@ STATIC s32 e1000_reset_hw_80003es2lan(struct e1000_hw *hw)
 	/* Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = e1000_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_primary_generic(hw);
 	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+		DEBUGOUT("PCI-E Primary disable polling has failed.\n");
 
 	DEBUGOUT("Masking off all interrupts\n");
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
@@ -820,7 +820,7 @@ STATIC s32 e1000_reset_hw_80003es2lan(struct e1000_hw *hw)
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl | E1000_CTRL_RST);
 	e1000_release_phy_80003es2lan(hw);
 
-	/* Disable IBIST slave mode (far-end loopback) */
+	/* Disable IBIST secondary mode (far-end loopback) */
 	ret_val = e1000_read_kmrn_reg_80003es2lan(hw,
 				E1000_KMRNCTRLSTA_INBAND_PARAM, &kum_reg_data);
 	if (!ret_val) {
@@ -886,7 +886,7 @@ STATIC s32 e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
-	/* Disable IBIST slave mode (far-end loopback) */
+	/* Disable IBIST secondary mode (far-end loopback) */
 	ret_val =
 	    e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
 					    &kum_reg_data);
diff --git a/drivers/net/intel/e1000/base/e1000_82571.c b/drivers/net/intel/e1000/base/e1000_82571.c
index 9dc7f6025c..af5ea0af65 100644
--- a/drivers/net/intel/e1000/base/e1000_82571.c
+++ b/drivers/net/intel/e1000/base/e1000_82571.c
@@ -1042,9 +1042,9 @@ STATIC s32 e1000_reset_hw_82571(struct e1000_hw *hw)
 	/* Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = e1000_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_primary_generic(hw);
 	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+		DEBUGOUT("PCI-E Primary disable polling has failed.\n");
 
 	DEBUGOUT("Masking off all interrupts\n");
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
diff --git a/drivers/net/intel/e1000/base/e1000_82575.c b/drivers/net/intel/e1000/base/e1000_82575.c
index c781085348..ff5a5cad80 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -1361,9 +1361,9 @@ STATIC s32 e1000_reset_hw_82575(struct e1000_hw *hw)
 	 * Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = e1000_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_primary_generic(hw);
 	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+		DEBUGOUT("PCI-E Primary disable polling has failed.\n");
 
 	/* set the completion timeout for interface */
 	ret_val = e1000_set_pcie_completion_timeout(hw);
@@ -2290,9 +2290,9 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	 * Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = e1000_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_primary_generic(hw);
 	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+		DEBUGOUT("PCI-E Primary disable polling has failed.\n");
 
 	DEBUGOUT("Masking off all interrupts\n");
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 1ab1cade27..0a8c5eb0bb 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -859,16 +859,16 @@ void e1000_update_adaptive(struct e1000_hw *hw)
 }
 
 /**
- *  e1000_disable_pcie_master - Disable PCI-Express master access
+ *  e1000_disable_pcie_primary - Disable PCI-Express primary access
  *  @hw: pointer to the HW structure
  *
- *  Disables PCI-Express master access and verifies there are no pending
+ *  Disables PCI-Express primary access and verifies there are no pending
  *  requests. Currently no func pointer exists and all implementations are
  *  handled in the generic version of this function.
  **/
-s32 e1000_disable_pcie_master(struct e1000_hw *hw)
+s32 e1000_disable_pcie_primary(struct e1000_hw *hw)
 {
-	return e1000_disable_pcie_master_generic(hw);
+	return e1000_disable_pcie_primary_generic(hw);
 }
 
 /**
diff --git a/drivers/net/intel/e1000/base/e1000_api.h b/drivers/net/intel/e1000/base/e1000_api.h
index 591a3ddc3f..ca3248c214 100644
--- a/drivers/net/intel/e1000/base/e1000_api.h
+++ b/drivers/net/intel/e1000/base/e1000_api.h
@@ -37,7 +37,7 @@ s32 e1000_reset_hw(struct e1000_hw *hw);
 s32 e1000_init_hw(struct e1000_hw *hw);
 s32 e1000_setup_link(struct e1000_hw *hw);
 s32 e1000_get_speed_and_duplex(struct e1000_hw *hw, u16 *speed, u16 *duplex);
-s32 e1000_disable_pcie_master(struct e1000_hw *hw);
+s32 e1000_disable_pcie_primary(struct e1000_hw *hw);
 void e1000_config_collision_dist(struct e1000_hw *hw);
 int e1000_rar_set(struct e1000_hw *hw, u8 *addr, u32 index);
 u32 e1000_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr);
diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 6227ac5340..0b370977f3 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -235,7 +235,7 @@
 /* Device Control */
 #define E1000_CTRL_FD		0x00000001  /* Full duplex.0=half; 1=full */
 #define E1000_CTRL_PRIOR	0x00000004  /* Priority on PCI. 0=rx,1=fair */
-#define E1000_CTRL_GIO_MASTER_DISABLE 0x00000004 /*Blocks new Master reqs */
+#define E1000_CTRL_GIO_PRIMARY_DISABLE 0x00000004 /*Blocks new Primary reqs */
 #define E1000_CTRL_LRST		0x00000008  /* Link reset. 0=normal,1=reset */
 #define E1000_CTRL_ASDE		0x00000020  /* Auto-speed detect enable */
 #define E1000_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
@@ -312,7 +312,7 @@
 #define E1000_STATUS_SPEED_2500		0x00400000 /* Speed 2.5Gb/s indication for I225 */
 #define E1000_STATUS_LAN_INIT_DONE	0x00000200 /* Lan Init Compltn by NVM */
 #define E1000_STATUS_PHYRA		0x00000400 /* PHY Reset Asserted */
-#define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000 /* Master request status */
+#define E1000_STATUS_GIO_PRIMARY_ENABLE	0x00080000 /* Primary request status */
 #define E1000_STATUS_PCI66		0x00000800 /* In 66Mhz slot */
 #define E1000_STATUS_BUS64		0x00001000 /* In 64 bit slot */
 #define E1000_STATUS_2P5_SKU		0x00001000 /* Val of 2.5GBE SKU strap */
@@ -706,7 +706,7 @@
 #define E1000_ERR_MAC_INIT		5
 #define E1000_ERR_PHY_TYPE		6
 #define E1000_ERR_RESET			9
-#define E1000_ERR_MASTER_REQUESTS_PENDING	10
+#define E1000_ERR_PRIMARY_REQUESTS_PENDING	10
 #define E1000_ERR_HOST_INTERFACE_COMMAND	11
 #define E1000_BLK_PHY_RESET		12
 #define E1000_ERR_SWFW_SYNC		13
@@ -723,8 +723,8 @@
 #define COPPER_LINK_UP_LIMIT		10
 #define PHY_AUTO_NEG_LIMIT		45
 #define PHY_FORCE_LIMIT			20
-/* Number of 100 microseconds we wait for PCI Express master disable */
-#define MASTER_DISABLE_TIMEOUT		800
+/* Number of 100 microseconds we wait for PCI Express primary disable */
+#define PRIMARY_DISABLE_TIMEOUT		800
 /* Number of milliseconds we wait for PHY configuration done after MAC reset */
 #define PHY_CFG_TIMEOUT			100
 /* Number of 2 milliseconds we wait for acquiring MDIO ownership. */
@@ -935,7 +935,7 @@
 #define E1000_EEE_LP_ADV_ADDR_I350	0x040F     /* EEE LP Advertisement */
 #define E1000_M88E1543_PAGE_ADDR	0x16       /* Page Offset Register */
 #define E1000_M88E1543_EEE_CTRL_1	0x0
-#define E1000_M88E1543_EEE_CTRL_1_MS	0x0001     /* EEE Master/Slave */
+#define E1000_M88E1543_EEE_CTRL_1_MS	0x0001     /* EEE Primary/Secondary */
 #define E1000_M88E1543_FIBER_CTRL	0x0        /* Fiber Control Register */
 #define E1000_EEE_ADV_DEV_I354		7
 #define E1000_EEE_ADV_ADDR_I354		60
@@ -1062,14 +1062,16 @@
 #define CR_1000T_FD_CAPS	0x0200 /* Advertise 1000T FD capability  */
 /* 1=Repeater/switch device port 0=DTE device */
 #define CR_1000T_REPEATER_DTE	0x0400
-/* 1=Configure PHY as Master 0=Configure PHY as Slave */
+/* 1=Configure PHY as Primary 0=Configure PHY as Secondary */
 #define CR_1000T_MS_VALUE	0x0800
-/* 1=Master/Slave manual config value 0=Automatic Master/Slave config */
+/* 1=Primary/Secondary manual config value
+ * 0=Automatic Primary/Secondary config
+ */
 #define CR_1000T_MS_ENABLE	0x1000
 #define CR_1000T_TEST_MODE_NORMAL 0x0000 /* Normal Operation */
 #define CR_1000T_TEST_MODE_1	0x2000 /* Transmit Waveform test */
-#define CR_1000T_TEST_MODE_2	0x4000 /* Master Transmit Jitter test */
-#define CR_1000T_TEST_MODE_3	0x6000 /* Slave Transmit Jitter test */
+#define CR_1000T_TEST_MODE_2	0x4000 /* Primary Transmit Jitter test */
+#define CR_1000T_TEST_MODE_3	0x6000 /* Secondary Transmit Jitter test */
 #define CR_1000T_TEST_MODE_4	0x8000 /* Transmitter Distortion test */
 
 /* 1000BASE-T Status Register */
@@ -1079,8 +1081,8 @@
 #define SR_1000T_LP_FD_CAPS		0x0800 /* LP is 1000T FD capable */
 #define SR_1000T_REMOTE_RX_STATUS	0x1000 /* Remote receiver OK */
 #define SR_1000T_LOCAL_RX_STATUS	0x2000 /* Local receiver OK */
-#define SR_1000T_MS_CONFIG_RES		0x4000 /* 1=Local Tx Master, 0=Slave */
-#define SR_1000T_MS_CONFIG_FAULT	0x8000 /* Master/Slave config fault */
+#define SR_1000T_MS_CONFIG_RES	0x4000 /* 1=Local Tx Primary, 0=Secondary */
+#define SR_1000T_MS_CONFIG_FAULT 0x8000 /* Primary/Secondary config fault */
 
 #define SR_1000T_PHY_EXCESSIVE_IDLE_ERR_COUNT	5
 
@@ -1425,15 +1427,15 @@
 #define M88E1000_PSSR_CABLE_LENGTH_SHIFT	7
 
 /* Number of times we will attempt to autonegotiate before downshifting if we
- * are the master
+ * are the primary
  */
-#define M88E1000_EPSCR_MASTER_DOWNSHIFT_MASK	0x0C00
-#define M88E1000_EPSCR_MASTER_DOWNSHIFT_1X	0x0000
+#define M88E1000_EPSCR_PRIMARY_DOWNSHIFT_MASK	0x0C00
+#define M88E1000_EPSCR_PRIMARY_DOWNSHIFT_1X	0x0000
 /* Number of times we will attempt to autonegotiate before downshifting if we
- * are the slave
+ * are the secondary
  */
-#define M88E1000_EPSCR_SLAVE_DOWNSHIFT_MASK	0x0300
-#define M88E1000_EPSCR_SLAVE_DOWNSHIFT_1X	0x0100
+#define M88E1000_EPSCR_SECONDARY_DOWNSHIFT_MASK	0x0300
+#define M88E1000_EPSCR_SECONDARY_DOWNSHIFT_1X	0x0100
 #define M88E1000_EPSCR_TX_CLK_25	0x0070 /* 25  MHz TX_CLK */
 
 /* Intel I347AT4 Registers */
@@ -1444,7 +1446,7 @@
 /* I347AT4 Extended PHY Specific Control Register */
 
 /* Number of times we will attempt to autonegotiate before downshifting if we
- * are the master
+ * are the primary
  */
 #define I347AT4_PSCR_DOWNSHIFT_ENABLE	0x0800
 #define I347AT4_PSCR_DOWNSHIFT_MASK	0x7000
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 2edf64f473..2777922a6b 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -391,8 +391,8 @@ enum e1000_dsp_config {
 
 enum e1000_ms_type {
 	e1000_ms_hw_default = 0,
-	e1000_ms_force_master,
-	e1000_ms_force_slave,
+	e1000_ms_force_primary,
+	e1000_ms_force_secondary,
 	e1000_ms_auto
 };
 
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index cfb61bad00..1dc7138856 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -219,9 +219,9 @@ STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw)
 	 * Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = e1000_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_primary_generic(hw);
 	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+		DEBUGOUT("PCI-E Primary disable polling has failed.\n");
 
 	DEBUGOUT("Masking off all interrupts\n");
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 0b5667fd01..01cda7ddeb 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -151,8 +151,8 @@ union ich8_hws_flash_regacc {
 	struct ich8_flracc {
 		u32 grra:8; /* 0:7 GbE region Read Access */
 		u32 grwa:8; /* 8:15 GbE region Write Access */
-		u32 gmrag:8; /* 23:16 GbE Master Read Access Grant */
-		u32 gmwag:8; /* 31:24 GbE Master Write Access Grant */
+		u32 gmrag:8; /* 23:16 GbE Primary Read Access Grant */
+		u32 gmwag:8; /* 31:24 GbE Primary Write Access Grant */
 	} hsf_flregacc;
 	u16 regval;
 };
@@ -4928,9 +4928,9 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	/* Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = e1000_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_primary_generic(hw);
 	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+		DEBUGOUT("PCI-E Primary disable polling has failed.\n");
 
 	DEBUGOUT("Masking off all interrupts\n");
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 64486f4e4b..0ba03e6a04 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -2061,33 +2061,33 @@ void e1000_set_pcie_no_snoop_generic(struct e1000_hw *hw, u32 no_snoop)
 }
 
 /**
- *  e1000_disable_pcie_master_generic - Disables PCI-express master access
+ *  e1000_disable_pcie_primary_generic - Disables PCI-express primary access
  *  @hw: pointer to the HW structure
  *
  *  Returns E1000_SUCCESS if successful, else returns -10
- *  (-E1000_ERR_MASTER_REQUESTS_PENDING) if master disable bit has not caused
- *  the master requests to be disabled.
+ *  (-E1000_ERR_PRIMARY_REQUESTS_PENDING) if primary disable bit has not caused
+ *  the primary requests to be disabled.
  *
- *  Disables PCI-Express master access and verifies there are no pending
+ *  Disables PCI-Express primary access and verifies there are no pending
  *  requests.
  **/
-s32 e1000_disable_pcie_master_generic(struct e1000_hw *hw)
+s32 e1000_disable_pcie_primary_generic(struct e1000_hw *hw)
 {
 	u32 ctrl;
-	s32 timeout = MASTER_DISABLE_TIMEOUT;
+	s32 timeout = PRIMARY_DISABLE_TIMEOUT;
 
-	DEBUGFUNC("e1000_disable_pcie_master_generic");
+	DEBUGFUNC("e1000_disable_pcie_primary_generic");
 
 	if (hw->bus.type != e1000_bus_type_pci_express)
 		return E1000_SUCCESS;
 
 	ctrl = E1000_READ_REG(hw, E1000_CTRL);
-	ctrl |= E1000_CTRL_GIO_MASTER_DISABLE;
+	ctrl |= E1000_CTRL_GIO_PRIMARY_DISABLE;
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl);
 
 	while (timeout) {
 		if (!(E1000_READ_REG(hw, E1000_STATUS) &
-		      E1000_STATUS_GIO_MASTER_ENABLE) ||
+		      E1000_STATUS_GIO_PRIMARY_ENABLE) ||
 				E1000_REMOVED(hw->hw_addr))
 			break;
 		usec_delay(100);
@@ -2095,8 +2095,8 @@ s32 e1000_disable_pcie_master_generic(struct e1000_hw *hw)
 	}
 
 	if (!timeout) {
-		DEBUGOUT("Master requests are pending.\n");
-		return -E1000_ERR_MASTER_REQUESTS_PENDING;
+		DEBUGOUT("Primary requests are pending.\n");
+		return -E1000_ERR_PRIMARY_REQUESTS_PENDING;
 	}
 
 	return E1000_SUCCESS;
diff --git a/drivers/net/intel/e1000/base/e1000_mac.h b/drivers/net/intel/e1000/base/e1000_mac.h
index 86fcad23bb..0b56178e5d 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.h
+++ b/drivers/net/intel/e1000/base/e1000_mac.h
@@ -22,7 +22,7 @@ s32  e1000_cleanup_led_generic(struct e1000_hw *hw);
 s32  e1000_commit_fc_settings_generic(struct e1000_hw *hw);
 s32  e1000_poll_fiber_serdes_link_generic(struct e1000_hw *hw);
 s32  e1000_config_fc_after_link_up_generic(struct e1000_hw *hw);
-s32  e1000_disable_pcie_master_generic(struct e1000_hw *hw);
+s32  e1000_disable_pcie_primary_generic(struct e1000_hw *hw);
 s32  e1000_force_mac_fc_generic(struct e1000_hw *hw);
 s32  e1000_get_auto_rd_done_generic(struct e1000_hw *hw);
 s32  e1000_get_bus_info_pci_generic(struct e1000_hw *hw);
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 05e6062ae7..92c60aeb49 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -981,17 +981,17 @@ s32 e1000_write_kmrn_reg_locked(struct e1000_hw *hw, u32 offset, u16 data)
 }
 
 /**
- *  e1000_set_master_slave_mode - Setup PHY for Master/slave mode
+ *  e1000_set_primary_secondary_mode - Setup PHY for Primary/Secondary mode
  *  @hw: pointer to the HW structure
  *
- *  Sets up Master/slave mode
+ *  Sets up Primary/Secondary mode
  **/
-STATIC s32 e1000_set_master_slave_mode(struct e1000_hw *hw)
+STATIC s32 e1000_set_primary_secondary_mode(struct e1000_hw *hw)
 {
 	s32 ret_val;
 	u16 phy_data;
 
-	/* Resolve Master/Slave mode */
+	/* Resolve Primary/Secondary mode */
 	ret_val = hw->phy.ops.read_reg(hw, PHY_1000T_CTRL, &phy_data);
 	if (ret_val)
 		return ret_val;
@@ -999,14 +999,14 @@ STATIC s32 e1000_set_master_slave_mode(struct e1000_hw *hw)
 	/* load defaults for future use */
 	hw->phy.original_ms_type = (phy_data & CR_1000T_MS_ENABLE) ?
 				   ((phy_data & CR_1000T_MS_VALUE) ?
-				    e1000_ms_force_master :
-				    e1000_ms_force_slave) : e1000_ms_auto;
+				    e1000_ms_force_primary :
+				    e1000_ms_force_secondary) : e1000_ms_auto;
 
 	switch (hw->phy.ms_type) {
-	case e1000_ms_force_master:
+	case e1000_ms_force_primary:
 		phy_data |= (CR_1000T_MS_ENABLE | CR_1000T_MS_VALUE);
 		break;
-	case e1000_ms_force_slave:
+	case e1000_ms_force_secondary:
 		phy_data |= CR_1000T_MS_ENABLE;
 		phy_data &= ~(CR_1000T_MS_VALUE);
 		break;
@@ -1080,7 +1080,7 @@ s32 e1000_copper_link_setup_82577(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
-	return e1000_set_master_slave_mode(hw);
+	return e1000_set_primary_secondary_mode(hw);
 }
 
 /**
@@ -1186,11 +1186,11 @@ s32 e1000_copper_link_setup_m88(struct e1000_hw *hw)
 			phy_data &= ~M88EC018_EPSCR_DOWNSHIFT_COUNTER_MASK;
 			phy_data |= M88EC018_EPSCR_DOWNSHIFT_COUNTER_5X;
 		} else {
-			/* Configure Master and Slave downshift values */
-			phy_data &= ~(M88E1000_EPSCR_MASTER_DOWNSHIFT_MASK |
-				     M88E1000_EPSCR_SLAVE_DOWNSHIFT_MASK);
-			phy_data |= (M88E1000_EPSCR_MASTER_DOWNSHIFT_1X |
-				     M88E1000_EPSCR_SLAVE_DOWNSHIFT_1X);
+			/* Configure Primary and Secondary downshift values */
+			phy_data &= ~(M88E1000_EPSCR_PRIMARY_DOWNSHIFT_MASK |
+				     M88E1000_EPSCR_SECONDARY_DOWNSHIFT_MASK);
+			phy_data |= (M88E1000_EPSCR_PRIMARY_DOWNSHIFT_1X |
+				     M88E1000_EPSCR_SECONDARY_DOWNSHIFT_1X);
 		}
 		ret_val = phy->ops.write_reg(hw, M88E1000_EXT_PHY_SPEC_CTRL,
 					     phy_data);
@@ -1325,7 +1325,7 @@ s32 e1000_copper_link_setup_m88_gen2(struct e1000_hw *hw)
 		return ret_val;
 	}
 
-	ret_val = e1000_set_master_slave_mode(hw);
+	ret_val = e1000_set_primary_secondary_mode(hw);
 	if (ret_val)
 		return ret_val;
 
@@ -1336,8 +1336,8 @@ s32 e1000_copper_link_setup_m88_gen2(struct e1000_hw *hw)
  *  e1000_copper_link_setup_igp - Setup igp PHY's for copper link
  *  @hw: pointer to the HW structure
  *
- *  Sets up LPLU, MDI/MDI-X, polarity, Smartspeed and Master/Slave config for
- *  igp PHY's.
+ *  Sets up LPLU, MDI/MDI-X, polarity, Smartspeed
+ *  and Primary/Secondary config for igp PHY's.
  **/
 s32 e1000_copper_link_setup_igp(struct e1000_hw *hw)
 {
@@ -1402,10 +1402,10 @@ s32 e1000_copper_link_setup_igp(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
-	/* set auto-master slave resolution settings */
+	/* set auto primary-secondary resolution settings */
 	if (hw->mac.autoneg) {
 		/* when autonegotiation advertisement is only 1000Mbps then we
-		 * should disable SmartSpeed and enable Auto MasterSlave
+		 * should disable SmartSpeed and enable Auto Primary/Secondary
 		 * resolution as hardware default.
 		 */
 		if (phy->autoneg_advertised == ADVERTISE_1000_FULL) {
@@ -1423,7 +1423,7 @@ s32 e1000_copper_link_setup_igp(struct e1000_hw *hw)
 			if (ret_val)
 				return ret_val;
 
-			/* Set auto Master/Slave resolution process */
+			/* Set auto Primary/Secondary resolution process */
 			ret_val = phy->ops.read_reg(hw, PHY_1000T_CTRL, &data);
 			if (ret_val)
 				return ret_val;
@@ -1434,7 +1434,7 @@ s32 e1000_copper_link_setup_igp(struct e1000_hw *hw)
 				return ret_val;
 		}
 
-		ret_val = e1000_set_master_slave_mode(hw);
+		ret_val = e1000_set_primary_secondary_mode(hw);
 	}
 
 	return ret_val;
@@ -3014,7 +3014,7 @@ s32 e1000_phy_init_script_igp3(struct e1000_hw *hw)
 	hw->phy.ops.write_reg(hw, 0x1F72, 0x3FB0);
 	/* AHT reset limit to 1 */
 	hw->phy.ops.write_reg(hw, 0x1F76, 0xC0FF);
-	/* Set AHT master delay to 127 msec */
+	/* Set AHT primary delay to 127 msec */
 	hw->phy.ops.write_reg(hw, 0x1F77, 0x1DEC);
 	/* Set scan bits for AHT */
 	hw->phy.ops.write_reg(hw, 0x1F78, 0xF9EF);
@@ -3030,7 +3030,7 @@ s32 e1000_phy_init_script_igp3(struct e1000_hw *hw)
 	 * to 8 for channel A
 	 */
 	hw->phy.ops.write_reg(hw, 0x1898, 0xD918);
-	/* Disable AHT in Slave mode on channel A */
+	/* Disable AHT in Secondary mode on channel A */
 	hw->phy.ops.write_reg(hw, 0x187A, 0x0800);
 	/* Enable LPLU and disable AN to 1000 in non-D0a states,
 	 * Enable SPD+B2B
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index d399126db9..fb6ad467c6 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -284,7 +284,7 @@
 #define E1000_FFMT_REG(_i)	(0x09000 + ((_i) * 8))
 #define E1000_FFVT_REG(_i)	(0x09800 + ((_i) * 8))
 #define E1000_FFLT_REG(_i)	(0x05F00 + ((_i) * 8))
-#define E1000_PBSLAC		0x03100  /* Pkt Buffer Slave Access Control */
+#define E1000_PBSLAC	0x03100  /* Pkt Buffer Access Control */
 #define E1000_PBSLAD(_n)	(0x03110 + (0x4 * (_n)))  /* Pkt Buffer DWORD */
 #define E1000_TXPBS		0x03404  /* Tx Packet Buffer Size - RW */
 /* Same as TXPBS, renamed for newer Si - RW */
diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index 44ebe07ee4..7d20150b59 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -175,7 +175,7 @@ STATIC s32 e1000_get_bus_info_pcie_vf(struct e1000_hw *hw)
 
 	DEBUGFUNC("e1000_get_bus_info_pcie_vf");
 
-	/* Do not set type PCI-E because we don't want disable master to run */
+	/* Do not set type PCI-E because we don't want disable primary to run */
 	bus->type = e1000_bus_type_reserved;
 	bus->speed = e1000_bus_speed_2500;
 
-- 
2.43.5

