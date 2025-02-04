Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A291C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:17:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAE44427AE;
	Tue,  4 Feb 2025 16:12:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD6A42D89
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681941; x=1770217941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=spm429Ce/KHA6cJMAEUzd0kflOVM5BXaA2UHHXuJlf4=;
 b=SfbcW6oB1AU4z2JiAGOFLbXwmawiDiuVlgxiesGbXfkex7s7D2wOBw/d
 dZ7uN59STswTkoudGbLJpZj+Jfb2Y9E5FE7Mam6W3T+972tMijGlXTWKR
 7i0Gf26pAXXyZZkuD9PlRNF5ChNFkNMoTTieLLOFwEzR4T8zZPyrB1B/6
 J+O21j7XR+yYKSzYbkXczG3nupVqDAiJz1zP8OUoaAsD3+0nHGk8QOWNc
 1MVSt83yWTG3Q2yOoB4llTXFY555LlK4qsyGoVDaoy7oMh07iZSkLEKR+
 E0n7mvv7W3iu3zccvbXWNs85tORN2AFj05JfS/pAB/RDznK2ROG3qmXs/ A==;
X-CSE-ConnectionGUID: rq+GE4C4SDauH0/bWZgaog==
X-CSE-MsgGUID: RrVw6fTxTqaWKP5Iw5eOkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097173"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097173"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:20 -0800
X-CSE-ConnectionGUID: U0U3XLGjRcmy0wwZRX76fg==
X-CSE-MsgGUID: CafvonwGRV6bOcEMoYyoaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792759"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 42/54] net/e1000/base: remove redundant access to RO
 register
Date: Tue,  4 Feb 2025 15:10:48 +0000
Message-ID: <516bb28dd3edcc6fe90628f5ecebfd894d68abfe.1738681726.git.anatoly.burakov@intel.com>
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

