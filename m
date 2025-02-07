Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EAC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFE0C42EB4;
	Fri,  7 Feb 2025 13:46:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4FEE942E97
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932389; x=1770468389;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mASI/+vFIxdHa0F+Z+4mEM52YfmPwnvgrrECC6BhjLk=;
 b=bLMWLG1KmXSZT5jztn35dDMzGz67LcyncC5/A4YrJJH2Vjn1tX3Lf7Nr
 fVwRamhWMsp8ql25PM2MhTY1mz1yUM7mVRx2dOf93Fa/EcMoUW6eUOPK/
 cU+LWxPMGHInafRgzleMcEcd3DPuhUM+OrKV8Fdvzih4KpJGMjTeKJdY+
 FRYaImpfC3HZL+lksS99OIUChNsNBeeSArTnHlN2mw8XXs+qbwdATJDmN
 E6mp60l4N+iLSQ0ZgXabPknS4UfgvkB+vtZBanW8A5cxYBv6UA95NX+rn
 j2dq3/5zZi1UI12tdORfRgk+DgNkMS+P/3eMMzxvhw8MbbeTE1lIzJdzr A==;
X-CSE-ConnectionGUID: wYTJGjxIT122kn1JJiSUXA==
X-CSE-MsgGUID: VC21uQCoQwm8F53BknXmJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331874"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331874"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:28 -0800
X-CSE-ConnectionGUID: woJNM8laTkOHbSQBSMkWnQ==
X-CSE-MsgGUID: mdR/o9AxSMCXbJ7lfakihQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953793"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 29/36] net/e1000/base: hardcode bus parameters for ICH8
Date: Fri,  7 Feb 2025 12:45:21 +0000
Message-ID: <3b90935d182d7c3a1bc2a776b701310b41792407.1738932115.git.anatoly.burakov@intel.com>
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
index 0bb67ca621..342a09e8b8 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4885,21 +4885,20 @@ STATIC s32 e1000_id_led_init_pchlan(struct e1000_hw *hw)
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

