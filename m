Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70097FCE087
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC64C40A81;
	Thu, 26 Feb 2026 15:18:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 96AEF40A6B
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:18:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115489; x=1803651489;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nwIgj9PDmbdUl3bpaGGCX7JJ1JQ7CR//Inm1lGWsPUc=;
 b=GDmzq4g/yIy6f+k9YfP9EWSRQGHAl1kXH5m5rEA7XaOIm2kEqLjOBG3I
 DrcTkHXBLFxHOVj0dF2p3n6bQopeCX0Hr1b55yLkEGphxXBIaA0XnoGlU
 5EjklwHasSbEn6RwYcybRCdlqmvKvgnNcp4kK2ttNOs2IyJQH2i3CXrJN
 MOwD7lCRZRS9/LMD4KW+t1WaIPBMIYPXM48USCggvUQH5knJeKjOMNXbO
 t4+ACp6QcBCjQ7xiRw7XDKsJ+TURBSSs1Y0Vbv50TVtIRxYsT1DbRGqWe
 UmkRXIkKlq6mCELJrTMg814fagtJFGeF4ilA1JM41mUpC9P3ezlc55J+0 Q==;
X-CSE-ConnectionGUID: 0uwIDgCOSFyg1DXlA93nUg==
X-CSE-MsgGUID: Cx0MPhdHSIq9mUufMa8Szg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271152"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:18:08 -0800
X-CSE-ConnectionGUID: lL7s+9s4S1K+qHDJwpecnw==
X-CSE-MsgGUID: p2QGhy1ZR5KlVCPEDpNPcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719452"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:18:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v7 15/18] net/hinic3: use the new VFIO mode API
Date: Thu, 26 Feb 2026 14:17:38 +0000
Message-ID: <c53695601eb38decdccd00d2214b82d477ab5e5a.1772115412.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772115411.git.anatoly.burakov@intel.com>
 <cover.1772115411.git.anatoly.burakov@intel.com>
References: 
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

Use new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/hinic3/base/hinic3_hwdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 668bbf4a0e..c5bf2bc8a4 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -77,7 +77,7 @@ bool
 hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev)
 {
 	return ((RTE_ETH_DEV_TO_PCI(rte_dev)->kdrv == RTE_PCI_KDRV_VFIO) &&
-		(rte_vfio_noiommu_is_enabled() != 1));
+		(rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU));
 }
 
 int
-- 
2.47.3

