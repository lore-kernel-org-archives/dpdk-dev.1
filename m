Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E10C79F8C
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01C6742D0B;
	Wed,  9 Sep 2026 12:03:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C5428411F3
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948185; x=1820484185;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f5ZNOaupg92ut+Cp1QpxpwaA6B6KL9Fbr/eQyVsUKdE=;
 b=XzoKgATEMsc193yRyvXEvJCFu8gFSNV4ZKiS/Ofod+2wfgYayx8ln7/D
 KF86EKvNllMyRaOK55NAteuu9rvEcGYJY6E8l7zYEohUZwRBWbwLzlKAa
 tfipm1wsWz160agVor/N5RPLOs5AEm99BMlnEYkRH80VLcuC08YpaRVIN
 fcQgNJNzbwp+uxHB5FDEpU2K6h6TnvcESHW3BLOkkI/1UoAISvlCnMBOQ
 BblflXYbJD2N68KJ8OCZ9z4Dz/Jb4lmI+0iEYZT3HBPjuiAR/bEQppuia
 LAlPlr5ie5z6lYpNhMJAwNKSYNQm0vP+Tm2LoBj1c2F6ua/PB7wosGfMH w==;
X-CSE-ConnectionGUID: JYHmLWthTHykUtdVLfu2OA==
X-CSE-MsgGUID: nQgcJvSwSviLA1mRgOcTRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492298"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492298"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:03:05 -0700
X-CSE-ConnectionGUID: OrBQaYHSTxKVP+mELymh3g==
X-CSE-MsgGUID: zKC8MZPlRFeugnWjpczCDA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:03:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v16 24/26] net/ntnic: use the new VFIO IOMMU mode API
Date: Wed,  9 Sep 2026 11:02:17 +0100
Message-ID: <9e8cbb3bc7f5e45a989eff53819d47205ac38f31.1788947938.git.anatoly.burakov@intel.com>
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

