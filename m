Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228B7C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:18:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4894940DCD;
	Tue,  1 Sep 2026 18:16:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7891C40B95
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279374; x=1819815374;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=O4/ptTsOrKImcGp/3skOtsMf5qtscvQpIAhkQEMkeNY=;
 b=Bcqz6yzNL/qCt5BhN67qOFnz9xJgCM2T3Amtg76Gi3flG7UwEAFcNVoe
 mt2xuWaivkrEifzUU+eW2vLXQlHd/5s5XdQ2qV/5c3p/H2fM49byjZ3KM
 5Hv+BLJzeiZcgI312swzB4uVFhyhrLcrg0zXoje0PXr0g27aKInNxFBK9
 RjFcNLk+n0NMcSraw1guczbWPOU1Rs0aXnibz30xyWOd4BT2ji4kGoQkC
 zNF9iNf21+u5AgxVtBdYhUQs4pmrJgbtReLG3te6NyPWZ4b65eH3yrXNx
 lFimfQ16Xj1in5vvzk/K0UDgRbajg5VnG3QJ08fFKU8VVXqaoLpI6/qAS Q==;
X-CSE-ConnectionGUID: MJqp1c9sScOPXWZ2PI5LuQ==
X-CSE-MsgGUID: tbvS8S4tQiiwY8aE04o7Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656123"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:14 -0700
X-CSE-ConnectionGUID: 4BXswZOwQQubLlaFuVImFA==
X-CSE-MsgGUID: Bm7Vsg81SZmnRl3QtLOkuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032603"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v15 22/25] net/hinic3: use the new VFIO IOMMU mode API
Date: Tue,  1 Sep 2026 17:15:28 +0100
Message-ID: <0d42eea9eabde4a4f712570dc15271cff6e27875.1788278993.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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

