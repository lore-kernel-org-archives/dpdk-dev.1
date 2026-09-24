Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE082C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97DC843330;
	Thu, 24 Sep 2026 18:14:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CB88F43318
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266463; x=1821802463;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=88d7/wXxFoSRYuPUUJF768EythWprZWiDij+szLwW1g=;
 b=cVaIFOnI6n+czguocHJXKIP88cmmQzrmJNE+FUx18Us7lFNDUZGZ8Y5H
 /My1nV+lfLRZ7dOPOLpiILa2zFLtRqsmnS5S9Ev27MfsdWwMs2N4eEKVs
 WUfKMYOxJvwM4jqMdGx6t0YhhT2nzUxa+jo5iabRb/lpYdj3rGAZbXYL4
 Ff5gPSeSyFrL1DR6R+hiLtnTcphw1migS3ofgUGHta+Hgorll/wyFmUQa
 JyByGQ770qTx3XrFGFcw8HsKGzf76BdRrNWfQxv0pBe0Sf2UZ7K7Qfl/Z
 xU4akwqcQw6kytO+aIOr6tMEShBWIfwsp0J5vXe41LcTlLr62erMASB0Z w==;
X-CSE-ConnectionGUID: 4jCfxlVvQ+OQxdbgKZ+Z7A==
X-CSE-MsgGUID: QoHGcYPxSvKvj7lkWHWEwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000768"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000768"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:23 -0700
X-CSE-ConnectionGUID: N93X0QLsSrmqqJCp6zy3lg==
X-CSE-MsgGUID: 78rf2VJUQkKH3urPAH+icQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830121"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v18 26/29] net/hinic3: use the new VFIO IOVA mode API
Date: Thu, 24 Sep 2026 17:13:33 +0100
Message-ID: <5d1b427365d1ac4c0a5aa697bc7875de3765af02.1790266167.git.anatoly.burakov@intel.com>
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

Use new VFIO IOVA mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/hinic3/base/hinic3_hwdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 6a6cf447528..9406b6cff27 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -78,7 +78,8 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && dev_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO &&
+			dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_VA;
 }
 
 int
-- 
2.52.0

