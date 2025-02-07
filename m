Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE229C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0065042E56;
	Fri,  7 Feb 2025 13:46:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6ADD842E48
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932362; x=1770468362;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MzaDw2n/W5knTH9YJeNWPc0IzrWalJSfzluXPzp3udg=;
 b=m0S15GJ6Bt20aTfZJBpLj3pSEYDMTUiaCz7YR2q2ZIqsgPw5nDMgCsqm
 zSZUxTzgLz5wPq0Sgk9+FQAzT4y8gOb2bgTCvymyjraaR8YNGeAgof1/T
 vMOqJ7IAtRTqItqGZ941i5A9wHzf9HLGsDZID7/GnxHorJbt2dzXqLlnY
 O7CLfv+ZAtTZ5JATXI5O2N7GUG0AvC5d2MhhjGY9k7E/s8EImTk06G/0A
 aBPPXu+EKvt79YYk4KAbuMhYBWLoRReyrp96a33T7Qjjc51uglaOIQ303
 47EGPRI4JJvbrTIYYAaj7Bii4hBcrdj5PsM40SiFIR3+JRXLIST2LHFNI g==;
X-CSE-ConnectionGUID: uML9bJEmSHOXP0rm5U51Yw==
X-CSE-MsgGUID: soG9C5ffQKOzyJzKWw4Dwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331724"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331724"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:01 -0800
X-CSE-ConnectionGUID: OMFUwPnUR3a9I8pO61GM6Q==
X-CSE-MsgGUID: ZRpi9PkdRoSJ5z1mH19lYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953516"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 09/36] net/e1000/base: add missing definitions
Date: Fri,  7 Feb 2025 12:45:01 +0000
Message-ID: <5df1e56779b38d306fe8c04cae3a26153e799cbf.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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
index 720bf52466..ea7d70b77e 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -948,6 +948,11 @@
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

