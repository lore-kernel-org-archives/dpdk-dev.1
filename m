Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D3BD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD7E44069F;
	Mon,  1 Dec 2025 12:45:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 48B2A40613;
 Mon,  1 Dec 2025 12:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589516; x=1796125516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kfpK6TqkUDQYXyQfmhRGLzOm9Adm/FkySYjnm98LDVU=;
 b=Raa6JIzJHJ02p0mkWOGXxFmutyz7yXArLX/EXZnlZgpID/k5y1p5RIDr
 uLVAE102mJWHklhJeXXy4IzaVOPNgiEwYHG4GDETXN/GoLi2PfTFRP88b
 uf862eye/r36m0RT0FDew4ZX5c4u3NXqRfJok02Zo9Xk1+xNkwwZVG3lM
 pkUA19rDdwOOKVBR9WXU2wkIiEDqp1KyMj/6yBvTqFmpbq8sGY7yIxtwM
 /Wz8U8xw8PeVPnIXPx6RlD3v/7zF6en1+M/k8FyTQFDbkAY5j3Omiy6k3
 CVbRC9Fnew1neczv1/8NfNteWRatsnVVvuQNc3Q8dhd80XXXg70RXcrOU A==;
X-CSE-ConnectionGUID: cW8vCEH8TBeXHX77Vlk4Kw==
X-CSE-MsgGUID: SoxNVlp4RAOzQULArhlj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991727"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991727"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:15 -0800
X-CSE-ConnectionGUID: w4ee5IRUSIqziceflZW+wQ==
X-CSE-MsgGUID: BXc2teoJQ0Cp0QC8EDDF4w==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:14 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 11/31] bus/pci: remove shadowed variables
Date: Mon,  1 Dec 2025 11:44:28 +0000
Message-ID: <20251201114448.1441377-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

