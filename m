Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30C5C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:55:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B32042E0C;
	Thu, 10 Sep 2026 14:53:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1A430427DA
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044832; x=1820580832;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6nF46JWldmQLAMRFJNVUDR5ShKstwDQTQFdxhtj5jSc=;
 b=Y8xAUspADYt5wQI9CGeR5+ZiIaJHmouIq714lq9ztxZaeitzDO9mL0hs
 jlz9DoXFPK8vnNqa0m/y++nKhSRu7ZV1y0OBAEB5wsLSjlqSW2J5S3qD2
 z3muAfPTZHjNqj0CfT/+E/IMG3gNCeMY31/bc1idGeignqmPCnRgzc+qS
 3YPviux/CEVgn+u0nMHS+zHxEtnLGPMWtKX7fYAMLsIbeKbok7Fsqy2aK
 pxgj6AKZA2jm0bAvRAUHhP0y5jhCOtIym5oOBRLH/IwVlypk5FvhJQwgB
 MS3HJgesv4R1fLNOIpMgve01f2lLZxWlwiuogiwf9Y1ZYhlcM3ScOdQ21 g==;
X-CSE-ConnectionGUID: RABn3j+gTViW5Gyi0Th9ww==
X-CSE-MsgGUID: tFtHH820TC20L1i1T5pGAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334097"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334097"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:51 -0700
X-CSE-ConnectionGUID: W9sBd8DqROuu3XAI70A4hw==
X-CSE-MsgGUID: bxGr2mdPR4i8wuPYD8qN6Q==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v17 21/26] bus/pci: use the new VFIO IOMMU mode API
Date: Thu, 10 Sep 2026 13:53:05 +0100
Message-ID: <eaed5db3357098fcc936269e295f4c94afdb17c0.1789044748.git.anatoly.burakov@intel.com>
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

Use the new VFIO IOMMU mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index af37a65c45..9961f5b2c9 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (dev_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.52.0

