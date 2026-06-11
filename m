Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD305CD98D5
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D30A43318;
	Thu, 11 Jun 2026 17:09:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id B7E22432D8
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190582; x=1812726582;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FTBYQAyivsC0JV6n5FjLdLNnk7ni+OabeL+ysyxxqa0=;
 b=esB2V/mcTNwW81W2Yjy/K2wXhHiScqSuOUv39Vn7VkKGtuyhbB4PoTx1
 jnA4q5PRUDAoitFCpvJF2fO1AimTMucybgnhp9szKU+zNjz3fez0mGZCR
 lIpiH+6P0/7KiCy2Ejrxb2Xj0J8EhpiPZHe7w72qEJ9yXeoA9CPNX3Qdn
 JiaAGZYm5UfiLyxSO9er13uY2Gh3FJnn5ENBAYp2AKdPBKtZZMRy3YDqs
 1Yg7WAGAFvHffn+ZV6FP/UPzcgv7/RcifuyVV+vxdbEOHNSL/CI7V961H
 QFnpnMV7a1rQfYE0zGm7hT0/YkhjUMIvIz1QnsZt1aQsqHRy5wfeKjgjY Q==;
X-CSE-ConnectionGUID: CoYrG5nYQkieT8gKKnSewA==
X-CSE-MsgGUID: QK868DIsRwipA+HbK4N0IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845406"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845406"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:40 -0700
X-CSE-ConnectionGUID: hnqrDHGeSQSx6cNBpBBI7w==
X-CSE-MsgGUID: YEtKnBDYQW+iNqMo5/MpEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625335"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:39 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v8 13/18] bus/pci: use the new VFIO mode API
Date: Thu, 11 Jun 2026 16:09:05 +0100
Message-ID: <129027d38dc356deef14d09485058e302f48b497.1781190152.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
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

Use the new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14..a1575b84e2 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.47.3

