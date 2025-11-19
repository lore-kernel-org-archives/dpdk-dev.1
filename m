Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80464CF319D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC65240B9F;
	Wed, 19 Nov 2025 12:08:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 42F6A40B8F
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550524; x=1795086524;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IIRTbmbYme/vLycYbtOaJS9CD1TVuQZtOKDSHEUO2Xc=;
 b=bGJlmQsLH7QmEXWExWuNBQSidGoP6djkcA9d/KZtMsbOtBXGXtCojQDO
 lc/uq0aT+5j8jDZ2RERL1hYNjFXw4LsG/uVm2NmcyxxazRhzjdDTh9AjA
 LoBGS545xmBd2jhKRutsgiWDhNyB8nCsbXVfUEL919IPB6G3Xdh7VI5Dv
 LO/AwtNsu7b5uvjuPrSlGpxL1733pUgJ8DBbYwiYO3bY7STzPveHr2dvM
 aVfjQQE18V193Q29L+7oaw8FmxaQBF7DNylYhDJTR2bK6P2KOAzMfzMB/
 jMJRY45wFogmdmsu8Xyn3LHD0kgy30frnFYocLrTLKLRjaLGe1t1yd1It g==;
X-CSE-ConnectionGUID: Hvw37TGaS0O9NUBREDz/KQ==
X-CSE-MsgGUID: qEvmgXKgSqiPfKgr6L9x3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744988"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744988"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:43 -0800
X-CSE-ConnectionGUID: ppsWPVxEQ62J/GFm60P/GA==
X-CSE-MsgGUID: ODP2aS3oQ7uXzCOaQ2SdSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158218"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:42 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v5 13/18] bus/pci: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:08:11 +0000
Message-ID: <9a4e2c488fcf9a6e941dc098611b40caccb6805c.1763550470.git.anatoly.burakov@intel.com>
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

Use the new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 66d7e09a6e..6f7b67e140 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -598,7 +598,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.47.3

