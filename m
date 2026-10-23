Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34506606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BfySHkkD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3236340A72;
	Fri, 23 Oct 2026 15:39:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A6A8F4066C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792762771; x=1824298771;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=SFS58omdne/7ER9G9cPH7l0AB4uZq8bxE1CVXID7ALY=;
 b=BfySHkkDQ2IZrlLKLlmXG7aqZDvtfKv6UZ9fp0Ia8m1lQAx/CuK6kjpK
 28viiLYAEWLzCnNdjGO+GJ2i6bgbTG25RlSbIcNYRxsunPM/KB7tlBmAX
 fqaiKmOItJObuSZnA6NoAaGLipvuoiU+nPc6FHk43WQQvOmMX5L+LLk/3
 emys6I095A/7Kog71hCC5PbmMHE4DGbwsNCpJ+LiedBgHyko95VaLPAsg
 lrWkqJi/KmX1sKZD6wcxgKS8WschALNXXSrENlR0wJdUurabgAGb34F+E
 6SZ0dfQLdazvn2YbxiLZhDcuLEN0C92onQ+XviHVy89+AZkw6qY0zhriB Q==;
X-CSE-ConnectionGUID: uV13SeXjTVayYA0MuSOUYw==
X-CSE-MsgGUID: Jf2ItNQ3Qo+EL/pCBD8JKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1537445"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1537445"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:39:31 -0700
X-CSE-ConnectionGUID: ptRSUDYcTA+75ZJg46yDlA==
X-CSE-MsgGUID: PxT8p5rpQ6SjhkrwcFndiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3586618"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 06:39:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3 7/8] bus/pci: fix leaked device FD warning on VFIO unmap
Date: Fri, 23 Oct 2026 14:39:14 +0100
Message-ID: <cc295d28b94c6b041c6dbecf0c2c963067bbce90.1792762746.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <e9eba9cd731a90f6e487a76bfe3bee84b1cdc3de.1792762746.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When unmapping a VFIO device, the interrupt handle FD is closed but the
reference to the VFIO device FD is left in the handle. The device FD is
owned by the VFIO layer and released separately, so freeing the handle
later reports it as leaked.

Clear the reference once the device FD has been retrieved, as is already
done for the request notifier handle.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index fb35bc1d491..1116603f43f 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1091,6 +1091,8 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 	if (vfio_dev_fd < 0)
 		return -1;
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	if (rte_pci_set_bus_master(dev, false)) {
 		PCI_LOG(ERR, "%s cannot unset bus mastering for PCI device!", pci_addr);
@@ -1135,6 +1137,8 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
 	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 	if (vfio_dev_fd < 0)
 		return -1;
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	ret = dev_vfio_release_device(rte_pci_get_sysfs_path(), pci_addr,
 				      vfio_dev_fd);
-- 
2.52.0

