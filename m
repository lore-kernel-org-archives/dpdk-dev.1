Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034BC55174
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07C9840DCB;
	Wed,  5 Aug 2026 15:46:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id DCA2E40B9C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 15:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785937580; x=1817473580;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pRTtLvOFrQNIvTlICY58eHZ46QAC5vqp9NOIv+jyQ9s=;
 b=N5pJFgVWw3eU7WkR9mzz8Cu5MqVDYnXWuuHUqMqAmemLmno5iXU3tFHJ
 FIt8kv66sjCpFrecRmIGD7t9ETSPD7njFKi3UbgDWuxYIgIsqrVB3KIOp
 9BMxvMaSlW+8arwjnc3ZFtATe9OJyul1G1q6fcCN+X/wlDZ9sGG6UCn+v
 9adlB/QtzZbhSvD0n/r11pN7kPFywKqgVSzVg4na1uOWQ4FEwNGxKRI+b
 lRjUD9FS8sbn/4OZv7BxG+QqcL1LX5m1ufjP55WjjoIc4trSUFwUxfohn
 Aw7D8J/vFRHXlY+JrycUN/4VjvHcamsYxfp7243VqCafaGX+FjA0V+7d7 Q==;
X-CSE-ConnectionGUID: ULBTCtVUR7CRHbxnDNf2eA==
X-CSE-MsgGUID: 67g/Cr/nTsCUL55m/S+y6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86284132"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86284132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 06:46:19 -0700
X-CSE-ConnectionGUID: NdC8DFlwRo+doNmd0i86wg==
X-CSE-MsgGUID: FtD3LhRbQHiaZ1wnfr6SaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="258476816"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2026 06:46:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v9 17/19] net/ntnic: use the new VFIO mode API
Date: Wed,  5 Aug 2026 14:45:46 +0100
Message-ID: <d3e59b0d0426043ffd48c17185258736f3146467.1785937061.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785937060.git.anatoly.burakov@intel.com>
 <cover.1785937060.git.anatoly.burakov@intel.com>
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
index 7cc90a7a5b..8b6bca974c 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2690,7 +2690,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
-- 
2.52.0

