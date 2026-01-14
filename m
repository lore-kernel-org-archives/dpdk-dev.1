Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643CD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFF4140E0B;
	Wed, 14 Jan 2026 16:45:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 99C8440B9D;
 Wed, 14 Jan 2026 16:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405521; x=1799941521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kfpK6TqkUDQYXyQfmhRGLzOm9Adm/FkySYjnm98LDVU=;
 b=JAl5b3gMC5wdgbaQhGKxLfMRpKJOGpnWVUsROhIDTo13Zy9hc/u29vFf
 trdGXnBx0eKoUl8l0QXdBSXk6fikpJ+ZtynQUbwTJy06Dw4chUNnibBbi
 fMV2gBYolLNlo0YYzJfgeaL38TARH8ChfkO5W+TuM7OejeTLpOie2p1qP
 GHZ9fbj2CjqF6FJqtpvnAbTbVgmpDGZMLDYyVzwMmCetqbKIY/TXj9pW8
 2qTTWYnbV2MRMd0XyoX+wwG0lcOtixsqOyGztRwL6krdYw4yZa3/WM8Ce
 1zxW0IkqDqwlMwZ+ykLzeLiEYwYqgsT5y3ZHPT476w7ECGpti/xJZcfA0 Q==;
X-CSE-ConnectionGUID: Bk3YSd2WSA+HILGzuzCGCA==
X-CSE-MsgGUID: 34DHyB1SSZyyuQ8Xr3k6OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870842"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870842"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:20 -0800
X-CSE-ConnectionGUID: 47QY8DScSEOShLjoFFe2OQ==
X-CSE-MsgGUID: Mr3OPT8NSKOagXl/cDnnJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924999"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v4 11/31] bus/pci: remove shadowed variables
Date: Wed, 14 Jan 2026 15:44:25 +0000
Message-ID: <20260114154450.2969716-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

