Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC41CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D015440B98;
	Thu,  6 Nov 2025 15:10:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4E31C40A77;
 Thu,  6 Nov 2025 15:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438216; x=1793974216;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aX6EewRmCdP8f1fl5qZq09o/2EppoUAbik0lSAYDyiE=;
 b=nUGvPH/oLTFUVeCykr45MFAPTiGuNFa6ndv4zGsBFzw2OnUHU62SbETK
 CcHSCXva5ugyi2ie8DTXGF/+t4e70MseRq3WRXPnjoxt9i0ADzVNJGwGC
 iXFILGZ6f7QttRBR25+y8dyt2waMAPBcbZBNtuoab4yH5lTMi2/FyBP/t
 mnaYd+cCJbCpv1KWxHtKqwX+g/xEq3NiaD+BahVhJ5OM5A6OV/q/+CD9H
 +uWLnc/HhBw4tfRhfixBo4VmmlUVNoMTWzNHmxLaG0+gkjKk+dXy8DLDV
 qoWDYfQS36vOKoiwPTQgaLvPHw68U1Yb3XaA5rZhvPUF2CFeRqjVR5fwf g==;
X-CSE-ConnectionGUID: 9PbwXe6hT+iaXhGScSkSMQ==
X-CSE-MsgGUID: KHRFGd6hQqCni7rgSNAiNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185319"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185319"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:15 -0800
X-CSE-ConnectionGUID: zaYSxNa8SOCI8vdxGUDkBQ==
X-CSE-MsgGUID: XBEagoSZTmSpF40Q+nAjTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054757"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:14 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 12/19] bus/pci: remove shadowed variables
Date: Thu,  6 Nov 2025 14:09:41 +0000
Message-ID: <20251106140948.2894678-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

Remove two instances where we had duplicate shadowed local variables
called "ret". In each case, we could just remove the inner instance,
since the outer value was not needing to be preserved.

Fixes: 03ba15ca65c1 ("vfio: allow mapping MSI-X BARs if kernel allows it")
Fixes: c0ce0577e84d ("pci: consolidate address comparisons")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/pci/linux/pci.c      | 1 -
 drivers/bus/pci/linux/pci_vfio.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 66d7e09a6e..2ffac82e94 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -326,7 +326,6 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 		rte_pci_add_device(dev);
 	} else {
 		struct rte_pci_device *dev2;
-		int ret;
 
 		TAILQ_FOREACH(dev2, &rte_pci_bus.device_list, next) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 8562fdcc6b..242f567ed7 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -797,7 +797,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 	}
 	/* if we found our MSI-X BAR region, check if we can mmap it */
 	if (vfio_res->msix_table.bar_index != -1) {
-		int ret = pci_vfio_msix_is_mappable(vfio_dev_fd,
+		ret = pci_vfio_msix_is_mappable(vfio_dev_fd,
 				vfio_res->msix_table.bar_index);
 		if (ret < 0) {
 			PCI_LOG(ERR, "Couldn't check if MSI-X BAR is mappable");
-- 
2.48.1

