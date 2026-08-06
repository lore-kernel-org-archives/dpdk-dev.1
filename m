Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA47C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11ECF4069D;
	Thu,  6 Aug 2026 16:11:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A09184067C
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025492; x=1817561492;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1Shc3fa4JTQb3fvHW3Jk8YnaONalxyYe6AzamHi/8JY=;
 b=K/6cK6eBYt8dSbpwLz0TppDR0C3o0tiNF/Q6W6ywUIFmSziburUYtG9h
 wjZPkVD1zN6rHYrDyu5bNxb8MIiTEDkbbfZAd+ZH8UjEQjeO40jnMZrtb
 M+AkSi2tIIDNCIrCj82Dpqj83zH32pYqu0JB8BmmVk9Je2E6NCX5WMYpb
 1uj7kleFZrtPpcouBnJNhu6xLQuNgBDWCTg29a/pCSm3k1naHC4+8fk5i
 XDlsW4frL2a+QfeLT5JkOWyCT91Uslr3mSqe/KSPGd2ZItAkriO95+XxS
 xvBoJYuylOIRopgvxWMwVAnHlP+FqgZUcLB5aUQtu4WHSuWDdTsdw0zQT w==;
X-CSE-ConnectionGUID: iE+PpFtBSmG0Ct5tOLeptg==
X-CSE-MsgGUID: RTWBsjR3SjKWvrh1MBMWbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85589949"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85589949"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:31 -0700
X-CSE-ConnectionGUID: UJOaYIH2Qj2YzWyX5EnpIQ==
X-CSE-MsgGUID: GHYqCiAFRyi6wy93uN8KNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015152"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:31 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v10 03/20] bus/pci: rename mismatching error labels
Date: Thu,  6 Aug 2026 15:11:03 +0100
Message-ID: <7050bde55ba382b9d2f6ecc7fec6c4e8c7420752.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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

Specifcally, for primary, we have three error labels: vfio_res (release
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
index bc5c5c2499..a67de6ea02 100644
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
 	rte_vfio_release_device(rte_pci_get_sysfs_path(),
 			pci_addr, vfio_dev_fd);
 	return -1;
-- 
2.52.0

