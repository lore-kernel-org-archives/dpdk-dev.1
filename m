Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB6C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C112742E88;
	Fri, 31 Jan 2025 14:00:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9A90E42E52
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328397; x=1769864397;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=spm429Ce/KHA6cJMAEUzd0kflOVM5BXaA2UHHXuJlf4=;
 b=Jk4tSxDFFP/mu/SOEVnWY4PC+ZHg+wgIohX/QtvMft327JLJSH6M8Zgs
 E8wSgjWFPKZa27eYZcod+jKlWWdby8XIXy2etpFyckE2w+lB0C54gFTTJ
 MwMZg/Y7eNmYVt+cML8ZY58Whf2fyTD6aa6PzNf6lB1HPsX6ZYlssYRO6
 8zZiYA7tOStNjQ4jFB2PSEmQ9FNcVyipWrBm8aqNu3ORRdXOEUWTXrHtD
 KLcj0e35nLMGvt+DcPviQZ8BM6/KuVhR5KXZ2EZi6qPLplcVy1zbEALWh
 k6ZKXzMx9dgEIipg0QcgA6BgDWAQKDVxgzKPFoMUeYd4b+1KfbtKoUrcP w==;
X-CSE-ConnectionGUID: iMWcpA++Qx621G2ir9G5UQ==
X-CSE-MsgGUID: q6AIK2UVTFW2/3P14sYWug==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315656"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315656"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:56 -0800
X-CSE-ConnectionGUID: 00q+H8M+TPGTbE7O2R0jAw==
X-CSE-MsgGUID: B3ObMjJQT8mcpHUJoySaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503416"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 30/42] net/e1000/base: remove redundant access to RO
 register
Date: Fri, 31 Jan 2025 12:58:43 +0000
Message-ID: <1ac86a4c47e22b9d1063e96d4ce627790ce0d9d8.1738328107.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Remove workaround for hardware synchronization before reset. The original
bug that was fixed by this workaround was root caused later and fixed in
other ways.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 77c403fa80..0b5667fd01 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4922,7 +4922,6 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	u16 kum_cfg;
 	u32 ctrl, reg;
 	s32 ret_val;
-	u16 pci_cfg;
 
 	DEBUGFUNC("e1000_reset_hw_ich8lan");
 
@@ -4984,27 +4983,11 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	}
 	ret_val = e1000_acquire_swflag_ich8lan(hw);
 
-	/* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
-	 * may occur during global reset and cause system hang.
-	 * Configuration space access creates the needed delay.
-	 * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER value
-	 * insures configuration space read is done before global reset.
-	 */
-	e1000_read_pci_cfg(hw, E1000_PCI_VENDOR_ID_REGISTER, &pci_cfg);
-	E1000_WRITE_REG(hw, E1000_STRAP, pci_cfg);
 	DEBUGOUT("Issuing a global reset to ich8lan\n");
 	E1000_WRITE_REG(hw, E1000_CTRL, (ctrl | E1000_CTRL_RST));
 	/* cannot issue a flush here because it hangs the hardware */
 	msec_delay(20);
 
-	/* Configuration space access improve HW level time sync mechanism.
-	 * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
-	 * value to insure configuration space read is done
-	 * before any access to mac register.
-	 */
-	e1000_read_pci_cfg(hw, E1000_PCI_VENDOR_ID_REGISTER, &pci_cfg);
-	E1000_WRITE_REG(hw, E1000_STRAP, pci_cfg);
-
 	/* Set Phy Config Counter to 50msec */
 	if (hw->mac.type == e1000_pch2lan) {
 		reg = E1000_READ_REG(hw, E1000_FEXTNVM3);
-- 
2.43.5

