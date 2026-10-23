Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A47606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YRshfeIP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8CC140B94;
	Fri, 23 Oct 2026 15:51:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 22D2B40BA5
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792763510; x=1824299510;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gMQOJirPL4ecmqQUVMlr/CxIUamNNel+BDpAxmwZB0M=;
 b=YRshfeIPCyeWKNR6sRFZMafs4hEpz2T6R9b6THNWJs2ZwKtuUkzJsDpQ
 veErvS8E5DOufO1NFt47qqgH52QJxE5ox7T3ax28k7sjwP1Dmdpel/1lr
 xKGY0eSTglPoBb899eSr6qBha2fkrzd7kYp5qVO3t+GJareqQGLtRIFEy
 XNkVkYhoqIgfhEmCZxeKdIbClUFXQrackcEJLR6e5adF1QKXy41tjbQhs
 OLiW9OT/3CV7Ix8PB2/HvJbDBHKkIbRku4ZGcPGvp7ji/sOq7uAC+dKQt
 Lk6QJyCzWHo+BUkelNl8aqX6L6H1V+Y14CN6fB9Kd7guPnBbXiCtVaSDW w==;
X-CSE-ConnectionGUID: wAjOE9JNQ3WS0zwINtn/uA==
X-CSE-MsgGUID: VKCeWSbJRrmlH1kTq/FlfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1408357"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408357"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:51:50 -0700
X-CSE-ConnectionGUID: Bnwd5RK1RI2xFeO/5AtSaA==
X-CSE-MsgGUID: AffUL8yFQV2TZLwb6QDwag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4139875"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2026 06:51:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v4 7/8] bus/pci: fix leaked device FD warning on VFIO unmap
Date: Fri, 23 Oct 2026 14:51:37 +0100
Message-ID: <3db4bca818e4119f239c766686c5110f259c96c8.1792763492.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
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
index fb35bc1d491..62a7a85f6ed 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1103,6 +1103,8 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 		PCI_LOG(ERR, "Cannot release VFIO device");
 		return ret;
 	}
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
@@ -1142,6 +1144,8 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
 		PCI_LOG(ERR, "Cannot release VFIO device");
 		return ret;
 	}
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
-- 
2.52.0

