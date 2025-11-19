Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A75CF3195
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06EEB40674;
	Wed, 19 Nov 2025 12:02:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E660840431
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550145; x=1795086145;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IIRTbmbYme/vLycYbtOaJS9CD1TVuQZtOKDSHEUO2Xc=;
 b=bHd9hna/lrblccVFu1jeB1RQjjj6eSyW1dNvqBhvIdnPuaTnlxJlbRr/
 TfQvt43JSIL8G77usLANct3WrvbrYXwI5HOsyqPVT+RiCP9wk9OM286rh
 4svvpii2H7rNfyKVsX0QxKYqQUa8bM7WYGoF/Z/P6XZ5GUCV5bj24kScs
 CO5z4tDZy3gA5ifTaGsGkJAcJxXxSarVqPWSWmfLQObNcTm5ibQu58rEK
 wZ47xhLBVROW1HOTBd4JeM1wDzG29+Y2+CPPaicup85jbZHYSyd2DQX4Z
 WznCdHrIcZMv9maZtt/lb4t/75PV0HICpKSO5S/f1FPeXQ8ObPfXcytbF Q==;
X-CSE-ConnectionGUID: WExPgeHUQKuTxZzTKsKnHA==
X-CSE-MsgGUID: MYZln3HbTzW2y4uxqZ7x5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76942131"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76942131"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:02:24 -0800
X-CSE-ConnectionGUID: 92mLLuqbT5u9ODyQxhEfUQ==
X-CSE-MsgGUID: 9RiI429OSyu3eYoKpTbHzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="214409252"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2025 03:02:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v4 12/17] bus/pci: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:01:55 +0000
Message-ID: <9a4e2c488fcf9a6e941dc098611b40caccb6805c.1763549737.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763549736.git.anatoly.burakov@intel.com>
 <cover.1763549736.git.anatoly.burakov@intel.com>
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

