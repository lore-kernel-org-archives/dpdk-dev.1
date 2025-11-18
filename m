Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CBCEE334
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8277B40672;
	Tue, 18 Nov 2025 17:29:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 23478406B6
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483393; x=1795019393;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IIRTbmbYme/vLycYbtOaJS9CD1TVuQZtOKDSHEUO2Xc=;
 b=LRA6oEQnzgbxOpBm40Om8fe2Oiu15fsCufL+v02ydJgbYrJj5/ZRI+ZP
 zqJP5VPAc1F1tASrYjZd5TRCK8svUu2SfY1uQau/T+DtVHPPJz7JK2MeQ
 jqRIOBYKqWleroQxbrcCKg4nwQEuTD4egHPIlpL+092sZGi1L4uGPaOgR
 rlqWq5/ABXvg7qtL04SUXrt05twjfUyipfxEgy4HETBfbMnKVQPj6NBzR
 1pa/xFTO81hIfRERDpRBkcEkXHtcFYd4fx0k+EhNLHbumVEnsCKmoHRfp
 iG2ioEVprBJpNqAjgH/EEec4UpXbAPN+4QH6wjaynBCDQSr/k8V5h/eTI Q==;
X-CSE-ConnectionGUID: 2bvRInjQR8+g3rCtzW7Z6Q==
X-CSE-MsgGUID: GlGif8qXSGeaouF+MYOQ/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550646"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:52 -0800
X-CSE-ConnectionGUID: ctFTmfj7Td6Dz8l7bvx3Og==
X-CSE-MsgGUID: tQMH7tuaSwavv9PzMW2xog==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v3 15/20] bus/pci: use the new VFIO mode API
Date: Tue, 18 Nov 2025 16:29:16 +0000
Message-ID: <fff4b04c6c710aee873637dd4ad105176bbc3df2.1763483254.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
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

