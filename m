Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E0C55174
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B61840B94;
	Wed,  5 Aug 2026 15:46:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0FBA640B94
 for <dev@dpdk.org>; Wed,  5 Aug 2026 15:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785937577; x=1817473577;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vQS8keByxPZqIq29tz14Cyz3xTbbSPThXrPAkc9Lic4=;
 b=MqepzKeduOQyBWGvUSv5WZ0+qa9NFBQvI9VNkBoXLFSpXCtVGD8tshZe
 sTyNiPLttrYno2UpzWq/6RPGBDZTbbVJsKt3lNcpnWGIoZqWyDvqnuh26
 0uHmeuG+ANU6gghpG1IDeGP9itZRULZl6hi3Xn+X/pf/ssfTUZpyq8J88
 +nvOsokgIfOsLnbuYF3kC655jX7y0ylFaC/XGI+IIGUwmaE0KeXu15Mb0
 fuK4IHyF9MreM//xarEOlhvf/iQqrENhC4ZeHfW5xYUJHE0HmDtThvmo2
 J11qDznTxRxuc4KOlaWwun2L+vpP/veYDaU3b1cGWMUQcpdaQDtqAHyUS Q==;
X-CSE-ConnectionGUID: x8RgJ4tUQPmXoju2PtKWeQ==
X-CSE-MsgGUID: 0Dc+KTAtTBORFOV6/ghXjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86284121"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86284121"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 06:46:16 -0700
X-CSE-ConnectionGUID: NyRjNHqHSzu4MqGN+y+Vfg==
X-CSE-MsgGUID: L1e/0LZqT/upLIAogvsDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="258476809"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2026 06:46:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v9 14/19] bus/pci: use the new VFIO mode API
Date: Wed,  5 Aug 2026 14:45:43 +0100
Message-ID: <bcda68fa111083b3d94c72ca68c04422dfeacdd8.1785937061.git.anatoly.burakov@intel.com>
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
2.52.0

