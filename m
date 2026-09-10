Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581B7C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8447442E3A;
	Thu, 10 Sep 2026 14:53:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9896B42DFA
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044833; x=1820580833;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=O4/ptTsOrKImcGp/3skOtsMf5qtscvQpIAhkQEMkeNY=;
 b=Y57lieMjlmQgij1sOe04n/jei1dWkpPTvATEecItz4DBOlDqy1SPdJD7
 okWo6utLOWIRN3bqFf/JuTPMcYwhky+gMdCw2U4oimHboe656IPY4IVwW
 KyRpucZqDF8sZK3LCS7rJjesnH193I3JmOfqwW3BThgS9D+OTpbExZ74G
 eqETrAWFNz+kAEfAYl5+M7r1vg0nLwVN22M1YWH36VIWd5IwDjPUpwOTu
 p6Hnhmd7roNVWM1f5bnZmKAf6POYS8HdihPlG2vVImwB7e+BxuTUjdAkn
 TYZ3GLi9Cp8T0E4RWMaWGYBM/9JxeScGWxZd7//IV0mH2BDHlIyhLyWP7 w==;
X-CSE-ConnectionGUID: PUSJogg7RvKaq2XO26L2vA==
X-CSE-MsgGUID: OSyYLwh7SOyhRg9zRByfzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334105"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334105"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:53 -0700
X-CSE-ConnectionGUID: Z5tAS+3wSaaXD+AYhOnfNg==
X-CSE-MsgGUID: ymWCKaAPR3exbF+aBWXNSg==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v17 23/26] net/hinic3: use the new VFIO IOMMU mode API
Date: Thu, 10 Sep 2026 13:53:07 +0100
Message-ID: <1db8690b9fb71bd42453c37fe77aac8e9a2d6012.1789044748.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cover.1789044746.git.anatoly.burakov@intel.com>
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

Use new VFIO IOMMU mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/hinic3/base/hinic3_hwdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 6a6cf44752..e8ad013345 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -78,7 +78,8 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && dev_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO &&
+			dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_SAFE;
 }
 
 int
-- 
2.52.0

