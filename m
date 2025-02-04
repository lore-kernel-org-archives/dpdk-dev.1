Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1FC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 947BA4278F;
	Tue,  4 Feb 2025 16:12:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DBC3542794
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681939; x=1770217939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=azAKwRcwNrBUCY5htxOKb1/IGUcEcnAg+BiES5+1FTk=;
 b=QWmVCowvLpH2ewPq1Zx0u+Fxb1dx3hloQEVgT1IOkDbA5i3feER9zJBc
 zj/rRpOy4tyDDsndcPZ+uuLb+BDZIC/OX5CkTPYE9zMKH/WqQriENu+zo
 CIn8RrqUtvzNOYZ7rxqGrq+p/ubQqvZYwkSOpQzCOZGlB9iUH6NZqGn5v
 p8Fv56P7Leh9Z2f0h7RRiBkeSyECoqrpkPAypXaIsV8/VnVAXhLndawsq
 TJQD+LPTkt8ZayIxHxIRZQJu03fSbKraCk6QFhc6mXPzywkkT/Y5fKXOl
 3nDFBe4wsEWWuLJYsCpXUagDzr+m6oXsABUY5IALJcclqabvKv/VxKHAE A==;
X-CSE-ConnectionGUID: OstkR76EQ4ODqrDzoYER4g==
X-CSE-MsgGUID: P7rSoDARTbeKmdKLcrlIUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097170"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:18 -0800
X-CSE-ConnectionGUID: QqGGx3W4Tjy5S1dPW6NILw==
X-CSE-MsgGUID: y4BTxPEVQg+F1nj0yryZJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792752"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:16 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 40/54] net/e1000/base: hardcode bus parameters for ICH8
Date: Tue,  4 Feb 2025 15:10:46 +0000
Message-ID: <81c2d95565ad5db455f74440bbb8ccd5aba3a514.1738681726.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Current implementation of e1000_get_bus_info_ich8lan first attempts to
call e1000_get_bus_info_pcie_generic, and hard codes the bus width if the
latter does not return a valid value.

However, e1000_get_bus_info_pcie_generic will always fail on an ICH
device, since no PCIe capability is present in the ICH config space.
Therefore, there is no need to call it at all. Instead, we set the bus
parameters to their appropriate default values.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index d55797f817..da36d4c098 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4883,21 +4883,20 @@ STATIC s32 e1000_id_led_init_pchlan(struct e1000_hw *hw)
 STATIC s32 e1000_get_bus_info_ich8lan(struct e1000_hw *hw)
 {
 	struct e1000_bus_info *bus = &hw->bus;
-	s32 ret_val;
 
 	DEBUGFUNC("e1000_get_bus_info_ich8lan");
 
-	ret_val = e1000_get_bus_info_pcie_generic(hw);
-
 	/* ICH devices are "PCI Express"-ish.  They have
 	 * a configuration space, but do not contain
-	 * PCI Express Capability registers, so bus width
+	 * PCI Express Capability registers, so bus parameters
 	 * must be hardcoded.
 	 */
-	if (bus->width == e1000_bus_width_unknown)
-		bus->width = e1000_bus_width_pcie_x1;
+	bus->type = e1000_bus_type_pci_express;
+	bus->width = e1000_bus_width_pcie_x1;
+	bus->speed = e1000_bus_speed_unknown;
+	bus->func = 0;
 
-	return ret_val;
+	return E1000_SUCCESS;
 }
 
 /**
-- 
2.43.5

