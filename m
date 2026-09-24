Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0CDC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7085B4331E;
	Thu, 24 Sep 2026 18:14:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3AAC54330E
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266462; x=1821802462;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4vevVtyS3ldBOABYszdPJTHMvjKt4sEBRRG67RvcyHg=;
 b=LGAa82P6bjX9Bmo7sqw5fUzHxozQQ4+1rqmJCJ8ufNWUWoxafNs91Kol
 eWTSIpbqsawSDcg4jEakElkZ+AJgZgpCAGZm0jrwMTUTBzdKD2ljD4rI5
 5v1yDmqsGVgW9Yp2g3I7KuMSFvjNCF6mUpn16cOtaOJIzvo9pW65IJaA3
 CO6brwcySEdeR4z7/r6/5xZFk5JDAZySUr1ojBuEQyQtK9yuC0J/kAhOb
 V5plmaJys//40pnztYFiJ31IiDCMuVg4IzEhgOtx+wHVLgol76gDnWhro
 gBskm/ggT4moR8AFVn2FVz+fJ8vuaC+y9pp6P3vNe2OucDN5uYCsqOlxx g==;
X-CSE-ConnectionGUID: p9dfOGyQS/KqWFL1L+hR6w==
X-CSE-MsgGUID: YkJ1Iym7SNug0RrTgjvrDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000755"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000755"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:21 -0700
X-CSE-ConnectionGUID: RfwE4MvFTMuNh0eQmecryA==
X-CSE-MsgGUID: nD2UH4MFQT+bTV2ahTX/2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830119"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v18 24/29] bus/pci: use the new VFIO IOVA mode API
Date: Thu, 24 Sep 2026 17:13:31 +0100
Message-ID: <033da902aecc2ba85a16dedae19b21ca0c595ad6.1790266167.git.anatoly.burakov@intel.com>
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

Use the new VFIO IOVA mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 233223fbe5b..cc952ca63b1 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -627,7 +627,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (dev_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_PA)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.52.0

