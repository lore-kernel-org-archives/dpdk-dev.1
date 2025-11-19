Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D9CF319D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E8140DDD;
	Wed, 19 Nov 2025 12:08:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 423DB40B8F
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550527; x=1795086527;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yWhlOMZgnKaEFgHe6BY0EiK65RuN3ZRqJAtpLwvP4lM=;
 b=GrWPUgg6/KEl1GsgAclSH4bmvVTZVLUvC/z4TaJJ54H37/BmNrR2e4QM
 oeaODfQPs/JGr/2rPJHAIuEhYZxa3OJEtfvr5EhIcrEzzLPVvaQnSDGE2
 N907JxvqiNfN0bBkxWs5BYEKEXoEoncqNw8G4ZebVmO1k+B9zYmHXo5oT
 eL3rG6vi3igk/RsZePzXoZbzZsuKyEAcnCnXrmArs7C7h4lN6oo8uS7Gd
 xLxi4SSERzXge6tGo4hhHro4i8fT1jw2I0CJdQiVa32Ba/vyxHG7o5Ram
 5JRYdTlZQH2xXhJW1FKJHRfAeX9zqJgPg+xnS7wbvHgj4VRY7DxTg+pRR w==;
X-CSE-ConnectionGUID: /1Jq/QakTbeEC5Tj4WYNoA==
X-CSE-MsgGUID: i+OBkHQ/QciVVyiYOcbN6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744999"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:47 -0800
X-CSE-ConnectionGUID: L4WROojhShaGtzseyBihAA==
X-CSE-MsgGUID: FrtCNH9yQlSDLfHLDdtIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158237"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v5 16/18] net/ntnic: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:08:14 +0000
Message-ID: <aa2ae2064aa0e929805f48ac64c4939952e87b1a.1763550470.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
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
index 23c3452d2d..c1195e5fbe 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2692,7 +2692,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
-- 
2.47.3

