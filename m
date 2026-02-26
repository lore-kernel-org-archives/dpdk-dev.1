Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D56FCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2BB340A73;
	Thu, 26 Feb 2026 15:18:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B00C2406B7
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:18:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115487; x=1803651487;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ljw6WqzQFnIGBDiP0roub2DjiookUQ2+QmpndZxRc4g=;
 b=azHjz5oN60BQsL19fU5AN+GvxAKGfMTHrD2cr36LOXF79div8IclwrMc
 QiPyR+AtPnDssE2BhRvv+y7+VYYdBdQZw5VFX66xVAVzWgL5WwpsHVRQD
 nNzpv5WwP2QGTF1B/Vm4bTpyQaz5i4724C/NVNmWm/d9T+aZ6IDnMfHdI
 4n+n7SSoukAxoUMRs1ru1F/zZInyTjx6zsT/SKkJ6BGSDeoSjXyx9eAD3
 Rmr0kF6gHE0UHlYbqIPyW3AWHMXUlFf2wrXXurx0Ig1Rs1dvZyn0YGJKZ
 WGWfRqZLtJKiUQkTjiG2vm8kT3Xa4z1LWvPe9vQPM7Dtj1liSGB9DvW3z Q==;
X-CSE-ConnectionGUID: Gzi8yTLJRFCKw3Vj8irR2w==
X-CSE-MsgGUID: c0uhkYdARo+9vQ9GFLppPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271139"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271139"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:18:06 -0800
X-CSE-ConnectionGUID: ywVI9fslSAGOyvzbzN4iMw==
X-CSE-MsgGUID: AiY5BOzYRbqyJR3mLj1RAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719429"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:18:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v7 13/18] bus/pci: use the new VFIO mode API
Date: Thu, 26 Feb 2026 14:17:36 +0000
Message-ID: <41e902967ec82a274722000dfdb85e19d6230f6b.1772115412.git.anatoly.burakov@intel.com>
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

Use the new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 2ffac82e94..6a5035ac62 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -597,7 +597,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.47.3

