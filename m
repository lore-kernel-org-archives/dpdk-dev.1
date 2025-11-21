Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9AFCFA76C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10E8A40687;
	Fri, 21 Nov 2025 11:09:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id E08EE402EF
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719773; x=1795255773;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IIRTbmbYme/vLycYbtOaJS9CD1TVuQZtOKDSHEUO2Xc=;
 b=B6/l+yC0LhCJ0YyHhjZ2bBreSTkSNgQmXMQ4vM23j83TRAibLaGtEnrP
 doCtnGWtie7jS8l1uX7tQyE4r+AXUyFhWuAZq2pOlqNAxXV1fhZIKweV9
 s/mfgqzRzd51L/04bASC+MWnGTnnB+ovxfRHEXUKRG9wLzKtWm0Ylc/+A
 wPUa2FKCyrV/l1KoYKvsESpllBdfpBF9HbEp9qyFByPWn3bwDTIWGLI+o
 vUbqJlct9gTLgxOw8gi8QL6tb+JiwZ12R6wUtjBDJWbIiAsM7BzTXOuXa
 gAPUZuFTbzyrZVsolVhlQ4skyp2a5s44iiSdiE5ushKT5llzUOGxSfps4 Q==;
X-CSE-ConnectionGUID: iOCFDTMmTfOSlcXf79otGQ==
X-CSE-MsgGUID: zidSEeG2SvWI0Lk2oSOsAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76491030"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76491030"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:32 -0800
X-CSE-ConnectionGUID: 4aKvb7JQQFCXAmyEmzCMUg==
X-CSE-MsgGUID: UpshOnksTUqOKeIx41zdqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121585"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v6 13/18] bus/pci: use the new VFIO mode API
Date: Fri, 21 Nov 2025 10:08:58 +0000
Message-ID: <da2ef404b87a46a872a940d4d79f82e07671b737.1763719707.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763719706.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
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

