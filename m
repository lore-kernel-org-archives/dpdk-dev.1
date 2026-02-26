Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBE4FCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C2DF40B94;
	Thu, 26 Feb 2026 15:18:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9A811402E4
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:18:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115490; x=1803651490;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fQPvDYU3C/UV7ZmTnw9U6u4pFgCfbEWtVx6D6wLFys4=;
 b=bMU9Oz3QNNhVC0uMqE5hj55G7eu6hYqKwLcesDMurc7V+a//iHD9i57S
 p+huzhUDpJYux1EDVk3EaegTYBy01EAhU9x91DhC2i3fbHTO6Qg9FZ8xH
 9mXniDxUZQ+ZIf/WQa+urnKRYl1HTQysGtNoZUbYsEFxDyHR+cQQzoDLR
 eascipOvTQta2ONDPQp3CmeJGYk5vtR4hw5r8q5su7d5+M5DCRSXklOFG
 LnywYTkPG1XVdcfXogxY5uTcimuMi+vdWVwrATD2Exe/naXecIr1w+hTs
 xV8PQWDJUZyylqmGwcdK03ScWgg1Q3fFudyrabnSMhAfDLBVm2nfpsgfr g==;
X-CSE-ConnectionGUID: MDY6nS3DTniq2b5gav3W7w==
X-CSE-MsgGUID: HqCRxEiRRwO74O4NAAnYCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271156"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271156"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:18:09 -0800
X-CSE-ConnectionGUID: 0eu38JXeTaCmSNdajjkmgw==
X-CSE-MsgGUID: aWPhfnB7RjGWNtIbb19+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719471"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:18:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v7 16/18] net/ntnic: use the new VFIO mode API
Date: Thu, 26 Feb 2026 14:17:39 +0000
Message-ID: <b765ea57f18b6b81f0044db07fc3c8ec23be8e75.1772115412.git.anatoly.burakov@intel.com>
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
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 89e751e7e0..7fda61d3ff 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2691,7 +2691,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
-- 
2.47.3

