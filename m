Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F74C79F8C
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D5B427E7;
	Wed,  9 Sep 2026 12:03:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9005840EE4
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948184; x=1820484184;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=O4/ptTsOrKImcGp/3skOtsMf5qtscvQpIAhkQEMkeNY=;
 b=AWKWVj7Xz87tG+91SYF+TsA+KX9x+mgWbjVXRenp0NKf1a2TIoMguBwW
 igmRKFkNkQ8InK/c7O01XZxVpC4ALviQ01KL7cLFbtbIidePeAgpAuQ6r
 DqdSEPP+VlhIcwxokY4mCEgH8Otqw1Zrwod+PCUgkR3qeW3/OGYmNN8MU
 vg8tj5bL/bjIPTvXS3C3BV14spXCsIBJ+1rK2zJYuM9g0zKwCi/x9u3QX
 pBB1FMDwrKyjCI1OkHiHjEeVi2CioiA4K07QvPxzGQ7K0fo+/5paLCDCG
 Eer1NUgKNgfAOO/0FtM+GPE8yquz7mgDJQYbyyX+13IeDkZxgXmBCegWA w==;
X-CSE-ConnectionGUID: 4Ki64sQXStSeEBpTwUYRqg==
X-CSE-MsgGUID: /vitsd8BTuGrnRnHwHfJxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492294"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492294"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:03:03 -0700
X-CSE-ConnectionGUID: wYzcoUYCReWiIy7yZrxuBg==
X-CSE-MsgGUID: aLgvgWvhT/K//np95mLSJw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:03:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v16 23/26] net/hinic3: use the new VFIO IOMMU mode API
Date: Wed,  9 Sep 2026 11:02:16 +0100
Message-ID: <bbbdc207bbc7442503d69102a8b83e496af72a9a.1788947938.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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

