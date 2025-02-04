Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94929C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 075704111C;
	Tue,  4 Feb 2025 16:11:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B4AE841109
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681900; x=1770217900;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kgv4Fj6yrHTg9lJ/RiQTJWB6hAA48VNfcWuL2XsTb2g=;
 b=kGSFncoWtxmyirpLFxL4OHCVClrH/Gx/G3h34/3bkA0wPd8on3u5HID0
 l1CcoBmc0SKR02GuGC/7/9XQ3dcT/QcMO6znjEVCtdgZu0sMaShD/GldU
 O0ujkLnlIxOYRtHjDAdL3+MnEL2Z7T+jCRN9xN0kgaXfUAGddehnlsrBE
 zAwF5Vp/k3JaeuDIkdlqWCfZS7g4axXtReExoovf4dyaXR3C2J78yhq38
 N7taB474mUib4tR169ihcMknRRn3lVPbIAf5U99SZ/hnBX2FoD+Bk6NJ+
 lcDQl3P06aCEdYZGEEQkB44I2Bf2wwKLOJDMvwRhO0nMgy+wsRmsYxq5m w==;
X-CSE-ConnectionGUID: WoQzCELoQKmOA9lwvqtRng==
X-CSE-MsgGUID: j7mPnlllT82qWnREx8t80Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097105"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:40 -0800
X-CSE-ConnectionGUID: oLn+cildTeCjmDPXLShtAA==
X-CSE-MsgGUID: lI9mc6nqQJCSHEGhmSQE0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792586"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:38 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 09/54] net/e1000/base: add missing definitions
Date: Tue,  4 Feb 2025 15:10:15 +0000
Message-ID: <670ffd19b208031605672844ae709a94bd689afb.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

Some definitions that are present in the base code are missing from DPDK.
This patch adds the following definitions:

- EEPROM R/W v2 modes
- BAR ctrl CSR shift size
- I225 flash access register
- EEE-related registers

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 5 +++++
 drivers/net/intel/e1000/base/e1000_regs.h    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index d795c327a3..3d3bc3f6dc 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -947,6 +947,11 @@
 #define E1000_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
 #define E1000_EEE_LP_ADV_DEV_I225	7          /* EEE LP Adv Device */
 #define E1000_EEE_LP_ADV_ADDR_I225	61         /* EEE LP Adv Register */
+#define E1000_EEE_LP_ADV_2_5G           0          /* EEE LP Adv 2.5G */
+#define E1000_EEE_LP_ADV_1G             2          /* EEE LP Adv 1G */
+#define E1000_EEE_LP_ADV_100M           1          /* EEE LP Adv 100M */
+#define E1000_ANEG_EEE_AN_LPAB1_I225    26         /* EEE LP Ability 1 Offset */
+#define E1000_ANEG_EEE_AN_LPAB2_I225    0x2A       /* EEE LP Ability 2 Offset */
 
 /* PCI Express Control */
 #define E1000_GCR_RXD_NO_SNOOP		0x00000001
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 994e3c391b..3af356be77 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -12,6 +12,8 @@
 #define E1000_EECD	0x00010  /* EEPROM/Flash Control - RW */
 #define E1000_EERD	0x00014  /* EEPROM Read - RW */
 #define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
+#define E1000_EERD_V2	0x12014  /* EEprom mode read - RW */
+#define E1000_EEWR_V2	0x12018  /* EEprom mode write - RW */
 /* NVM  Register Descriptions */
 #define E1000_CTRL_EXT	0x00018  /* Extended Device Control - RW */
 #define E1000_FLA	0x0001C  /* Flash Access - RW */
@@ -23,6 +25,7 @@
 #define E1000_BARCTRL			0x5BBC /* BAR ctrl reg */
 #define E1000_BARCTRL_FLSIZE		0x0700 /* BAR ctrl Flsize */
 #define E1000_BARCTRL_CSRSIZE		0x2000 /* BAR ctrl CSR size */
+#define E1000_BARCTRL_CSRSIZE_SHIFT	13
 #define E1000_MPHY_ADDR_CTRL	0x0024 /* GbE MPHY Address Control */
 #define E1000_MPHY_DATA		0x0E10 /* GBE MPHY Data */
 #define E1000_MPHY_STAT		0x0E0C /* GBE MPHY Statistics */
@@ -33,6 +36,7 @@
 #define E1000_FCAL	0x00028  /* Flow Control Address Low - RW */
 #define E1000_FCAH	0x0002C  /* Flow Control Address High -RW */
 #define E1000_FEXT	0x0002C  /* Future Extended - RW */
+#define E1000_I225_FLA		0x1201C /* FLASH access register */
 #define E1000_I225_FLSWCTL	0x12048 /* FLASH control register */
 #define E1000_I225_FLSWDATA	0x1204C /* FLASH data register */
 #define E1000_I225_FLSWCNT	0x12050 /* FLASH Access Counter */
-- 
2.43.5

