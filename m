Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBEC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6781E4326E;
	Thu, 24 Sep 2026 18:14:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE2C4326E
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266445; x=1821802445;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uDEUN2lewl4phlqFI5h9ucps7Zg2V3pIdsQ7Fa0RGXc=;
 b=Xaw+5Z3gjlueKzMrofofJfwYh1dKFRO3ksJ/u1Jaxex2uUWHauSaZJne
 p80CzPHDvpdx8LW2aaeDJRkFkwGZ6FeWbuQL6QoZGXd9EFGwFspa5ewUI
 TGUO8iSKqDI7KcMq6ax4TGg11g8rynystsK8PAaglygpLo6dgiYPcbhFg
 UV2iKAaHBW07k5/UlW5dVhPsefatrM7o/2EEoV4EXm/z/li8qCSusBuac
 AaE9NUT4/lvLUzIGIguZM1C3E+L3nP5NLoj8Lc+9l4iEydLXdZIT5dvLc
 Dk9UzaTNbTGWvyfxlbnNBpKO7WW60g+gXn27+DGH0+8uzXMYvH8YUZeuu A==;
X-CSE-ConnectionGUID: De7QukPCQeiry7U2LWhX1A==
X-CSE-MsgGUID: leScqOuLRC2zhGmNZq6roQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000687"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000687"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:04 -0700
X-CSE-ConnectionGUID: p11hGpNASFe6frdALY9K1A==
X-CSE-MsgGUID: 50Ox9OUhRkSSKbz6ciS33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830044"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v18 12/29] bus/pci: rename mismatching error labels
Date: Thu, 24 Sep 2026 17:13:19 +0100
Message-ID: <e401262e70420270bd2a042906b35f288282aa5e.1790266166.git.anatoly.burakov@intel.com>
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

Currently, there are two VFIO map functions - primary and secondary -
that use a very similar goto error pattern. However, the label names are
confusing.

Specifically, for primary, we have three error labels: vfio_res (release
VFIO resource), vfio_dev_fd (close the fd), and map (unmap all the mapped
regions). For secondary, there is vfio_dev (close the fd), and
vfio_dev_fd (unmap all mapped regions).

For consistency, align secondary process function's error labels to match
semantics of how they work in primary process function.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index e0e94e6ee2c..3b967d62c89 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -968,7 +968,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 
 	ret = pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info);
 	if (ret)
-		goto err_vfio_dev;
+		goto err_vfio_dev_fd;
 
 	/* map BARs */
 	maps = vfio_res->maps;
@@ -979,14 +979,14 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 			if (ret < 0) {
 				PCI_LOG(ERR, "%s sparse mapping BAR%i failed: %s",
 					pci_addr, i, strerror(errno));
-				goto err_vfio_dev_fd;
+				goto err_map;
 			}
 		} else {
 			ret = pci_vfio_mmap_bar(vfio_dev_fd, vfio_res, i, MAP_FIXED);
 			if (ret < 0) {
 				PCI_LOG(ERR, "%s mapping BAR%i failed: %s",
 					pci_addr, i, strerror(errno));
-				goto err_vfio_dev_fd;
+				goto err_map;
 			}
 		}
 
@@ -995,17 +995,17 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 
 	/* we need save vfio_dev_fd, so it can be used during release */
 	if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd))
-		goto err_vfio_dev_fd;
+		goto err_map;
 	if (rte_intr_dev_fd_set(dev->vfio_req_intr_handle, vfio_dev_fd))
-		goto err_vfio_dev_fd;
+		goto err_map;
 
 	return 0;
-err_vfio_dev_fd:
+err_map:
 	for (j = 0; j < i; j++) {
 		if (maps[j].addr)
 			pci_unmap_resource(maps[j].addr, maps[j].size);
 	}
-err_vfio_dev:
+err_vfio_dev_fd:
 	dev_vfio_release_device(rte_pci_get_sysfs_path(),
 			pci_addr, vfio_dev_fd);
 	return -1;
-- 
2.52.0

