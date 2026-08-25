Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E11BC61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C8B40697;
	Tue, 25 Aug 2026 15:21:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3E9F9402EB
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664090; x=1819200090;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DH6DPV0ATJ4lwaSxhF4EXwK3T8qeord2B077AHSD2ao=;
 b=OfZqjxAUVT2d5QWd2nP8qKDTTLx5VqsWOArLQ16L54dLFoV+zxs50+Nt
 T9pWTEbPUvo/+07YAeGdw06BgLvieqrwoQMFSgfn0S7fCRwutS7SEievj
 NxjdkH6CoxdkOIitxtdk+W7ra0HcRJvs+bU+D0GCbE1WdrqjiErZBP3pA
 DzSfuJxQYE4JmnI2EOxNcWlKLMrKZRH+OhJNtdIoaiFPZ/W2F3o5JNodE
 KcvB7hQNkf9aD58GHKJvIcr5QPVfzYkBgMA+GUJgTtA/Q0TFFAsetC2h8
 PYhyARaToDfP6dwaR2A3CwbTWCFxo55NDpjriCkt/tAd/LwXPc2yYZX7P w==;
X-CSE-ConnectionGUID: 5uv1W8jcQxeIj+OuL9SCVw==
X-CSE-MsgGUID: CcvSqNXyRA2O3ViQ2HJVLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332681"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332681"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:30 -0700
X-CSE-ConnectionGUID: 46WLpwjFQWez5oleJj3zqA==
X-CSE-MsgGUID: jqaL7b1zRJmKcFpHUX8AWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660862"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v12 03/20] bus/pci: rename mismatching error labels
Date: Tue, 25 Aug 2026 14:21:00 +0100
Message-ID: <005a946cf9921c5ed9149bfbb1f515323157e994.1787663787.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787663786.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
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

