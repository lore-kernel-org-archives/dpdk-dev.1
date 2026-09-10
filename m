Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2031FC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7501742E49;
	Thu, 10 Sep 2026 14:53:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 22B9042E15
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044835; x=1820580835;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f5ZNOaupg92ut+Cp1QpxpwaA6B6KL9Fbr/eQyVsUKdE=;
 b=gf0JqVjlLe0QUJSrdSRSxqYBOvxCpfj6g3UO+i4Tq1Tr6BmiIgY8aT8p
 oVYStUE2L1hEfZCYJTvsZMstFE56YDb/Xkthv1aCOL6vRdgQb7J2PeOZt
 llnwsx7PXYbHICpecdQFbChv2FEmbU5vJIsnlVTjiYIglKmiCjM04Eot7
 k147qZsYeHMHWxQ06gQaoTtQx5YTABbIB7cgoeqFlzAUONR8ojhWpUibO
 CVCnulbDuJ/d/No4FGiMMbhNf1IvWOZ2RKgoDi2ss+HgyxhbJzVSCoPHQ
 fjyWL+vh5qlWiKXlyuRfAqPV44Agmy45w8QdJ8JUhyOVGnEE3Jkkzft7/ A==;
X-CSE-ConnectionGUID: sEAiUIqRShSl+RxCj3wOjA==
X-CSE-MsgGUID: Nz/pdMu6SAGwCMfM5G1cyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334110"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334110"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:54 -0700
X-CSE-ConnectionGUID: LF76dy1KQd2l5vYmWtTLsg==
X-CSE-MsgGUID: KCpvLHfxQxSuoC+lTC58QA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v17 24/26] net/ntnic: use the new VFIO IOMMU mode API
Date: Thu, 10 Sep 2026 13:53:08 +0100
Message-ID: <c6bb84d10ec54a409d1774f3637f7ec434975e88.1789044748.git.anatoly.burakov@intel.com>
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
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d9744a7d05..79f4dd5279 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2690,7 +2690,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_dev_vfio_no_io_mmu_enabled);
 
 	if (n_dev_vfio_no_io_mmu_enabled) {
-- 
2.52.0

