Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EABC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C62A42EC4;
	Fri,  7 Feb 2025 13:46:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 99F9C42EA3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932391; x=1770468391;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=c0RXZQ3NXV8MMscFeyjX0JuzZp52jrHBn4VJnZiYhc4=;
 b=gyW7+O1V41vMV3D1d9rdk/xtl2yQw565WsSh8pQCfxWAgFrY5UV/ZbBi
 ud49+Rvo6wqEXLX4TiT/qhYVMXUWQbSuevonM3Jvs0p7J2hvkFLZVd0vP
 DIWsp6Q+WUrzV4/uttrusNMHSY+qxHi1rs2VLYqKDGSdYaxPhWnslqEru
 PEF0nbMLPZb3GBcjRXIuXgJt51br1lVUomHaBB3EUKMdhu8iFF1CdUnIX
 sBefwj498iSAm5C51qE8XhHrI1Td5E6+0scljRokdXMQLdW5jSlTjbAPQ
 4ndtGRhIKeK0eNY6hXL1XMyYJsMKdumK0/xu5FtbHC807weKqCCcOUUhy g==;
X-CSE-ConnectionGUID: hgjaXvMKSbu7gcRWwm2ZKQ==
X-CSE-MsgGUID: ZrY8cm1IRLiEVhZVnL42xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331882"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331882"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:31 -0800
X-CSE-ConnectionGUID: fXlXTr+GSrCGBUXUlwedog==
X-CSE-MsgGUID: OQ8SLrVfTzaLQYkrIS71OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953812"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 31/36] net/e1000/base: remove redundant access to RO
 register
Date: Fri,  7 Feb 2025 12:45:23 +0000
Message-ID: <1585ba28ebd5cd9d4030926213421e3a9ada1c1b.1738932115.git.anatoly.burakov@intel.com>
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
index c6dc58d1ab..60f6ea1e6d 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4924,7 +4924,6 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	u16 kum_cfg;
 	u32 ctrl, reg;
 	s32 ret_val;
-	u16 pci_cfg;
 
 	DEBUGFUNC("e1000_reset_hw_ich8lan");
 
@@ -4986,27 +4985,11 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
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

