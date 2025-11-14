Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1790CE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 290B74279E;
	Fri, 14 Nov 2025 18:40:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 550BD410FD
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142056; x=1794678056;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IIRTbmbYme/vLycYbtOaJS9CD1TVuQZtOKDSHEUO2Xc=;
 b=bFOB/uZIE+DcOTiEO38UjDR4xImnxv1R1xZqnfRjoRU10kRK/jYOwMDA
 fghO37rejIO1fVZzupGwPVyIGhtd934ppPFZkstFFPEC5AHbo0aq64RyH
 PXhphds9NtJRBc0W4qnJG1rYpF5DU+W3kd71cKN9NGrzszJhiA5c0QVJR
 DWbLuu0tR9A+5+bpHAHt5CtRwFYP3MRFRFNShJk3THf0hcTnfPeJbKcO2
 Mev4aM+aWtqi8ujuZoyREwzJNkIq9sHNUhyEQQYBxDGEtGMsqMTPENugk
 wOpIxqaqefx+FePGKj6TgASigeKddhaZaBmR4R3dG5fy1IKz3hJIvkYQL g==;
X-CSE-ConnectionGUID: MdAZmuR2RKu5NJindPItqQ==
X-CSE-MsgGUID: A3MwRWucQx+IBbx9FPnxUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864304"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864304"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:55 -0800
X-CSE-ConnectionGUID: 9XjiOMcwTo6bNb6M640JAg==
X-CSE-MsgGUID: J2Da0lG2R7S2/0Bc+/hWsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650797"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v2 14/19] bus/pci: use the new VFIO mode API
Date: Fri, 14 Nov 2025 17:40:24 +0000
Message-ID: <18445d94c02e5089e63d9982a0739d0697c8b375.1763142008.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

