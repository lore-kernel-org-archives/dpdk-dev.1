Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2EC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A493243336;
	Thu, 24 Sep 2026 18:14:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 592CF43314
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266465; x=1821802465;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uYMZXRo7PhFBLFYbXcWnzLIhAM3KninLRf4NxDx/CvI=;
 b=IjbMIskE4klnHlxt2nKwNi05GxlTx3GfMh2IyHydOd+UQd9DQ83zjL3r
 tqx3jzxpDcbs6ScSbyKo+2M1I6yORdr45pIwBC+4Wj7wTNoBFBtOJrg+I
 JdMSObY+cVCrOvULIzSp9bx/r6jtx+REkOYiumRTQ9cw4ZUkqKx+/dVEK
 DjjGfAiEl+G/h9we96uP502xtfdv68zddOt9b7ul1Yxa8GwpcO+sXLxf/
 xo33WvhW2Jap0dquzzLAcTK/PJ5rZQCKDMFwR45e4XOaFlbKQBlSjLb/j
 IZLz7d1SFUqZbc1uHgW1bP0knGmb6VQpxzQ1ngIDf6qwPqVstPHiGqYoE A==;
X-CSE-ConnectionGUID: BkRj40/AQWaX4AMi3NAGXA==
X-CSE-MsgGUID: YB02KosbTTOyFiKKcJZtMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000772"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000772"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:24 -0700
X-CSE-ConnectionGUID: YkY/UJVUSYinvsfycGBy+Q==
X-CSE-MsgGUID: tLsC6G0NTLSt7X9SGX6Cng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830122"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v18 27/29] net/ntnic: use the new VFIO IOVA mode API
Date: Thu, 24 Sep 2026 17:13:34 +0100
Message-ID: <2ed4de7d8ce11b21a6b47bbe313cb505445fd519.1790266167.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
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

Use new VFIO IOVA mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d79c4fc1d54..e0d84705f53 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2729,7 +2729,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_PA;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
-- 
2.52.0

