Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13A0C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5003E42E7A;
	Fri, 31 Jan 2025 14:00:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 983B0427B8
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328395; x=1769864395;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=azAKwRcwNrBUCY5htxOKb1/IGUcEcnAg+BiES5+1FTk=;
 b=aghEoxz2yU1pdfba6VlOrRzsFNLc+Op7OPnj0+APAx1z1K8OsNYLWrbs
 1L/wlp7W3LGlOPYsFfc0340K7JbclZHZgRKWxlPNxbn+q7808Kx6sXN11
 NzcLFD+0w5Cfucm4Quqjs5ORtt637qjNK2waBLLeDPSmsIlMNN2yyC260
 +ZxfqMivP75qaS4afuFjc0xoBN146TOxcZd+Lliy5U3BMCTVTamls6Jv/
 q4mgZMcYTOphE7BCsA/2DgyKqpOHHW0Wlaxv43qN9ts7ZboYrggGm+c31
 yO2EN+zAB2WFwCcVZ/DQh1UIcwU6zpy6LY/90biOdZXjHK0fTp2JQyYGp A==;
X-CSE-ConnectionGUID: OSceIUMAQdGVf693d8UEGA==
X-CSE-MsgGUID: M+9vW6o0S/C89trR1h9cKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315653"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:54 -0800
X-CSE-ConnectionGUID: HZgaWDN3TISsaPqj4Nw+wg==
X-CSE-MsgGUID: PQAgh+9OTfmkLLdxRZ9pTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503411"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 28/42] net/e1000/base: hardcode bus parameters for ICH8
Date: Fri, 31 Jan 2025 12:58:41 +0000
Message-ID: <3f5b4da6417c7a8df3d6400c3d39108d682fd950.1738328107.git.anatoly.burakov@intel.com>
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

