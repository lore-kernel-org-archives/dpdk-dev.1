Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173B606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=awq6W0jY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D658E40A71;
	Fri, 27 Nov 2026 14:14:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 91C66406BA
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785273; x=1827321273;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tOnCUAo2+wtzR8kTykWepzH6VCOuxWIl00UuEs7I4d4=;
 b=awq6W0jYc0Uejyqq8iSF866WgzbCI4ReOkc4Ju+lgWvufVoX9IpqAW0L
 xI88KiHpWFuw1AV+yxndyBLoL/Tba9k8j9ixRaNEldGEWtHMum0gmfVcD
 Qp5Usvkg5eK6XxkL5lF4wjvLX9MNWwEh6fqe0pmxe+19Mv206tHHx71UJ
 HrU9a9JfSNYWGJP0a9odxh5ehw5HbD1cZgBSCOsokTlgv9KocI7NM9spp
 Ab8x7nRjphH37gXGcvVmT6uy004UzxOrGiQGqxOolYAq/z7M6Y7TWWWZZ
 jCVcCjJtSWwNaZL/J/XAHWosVFLGZ6XTQCK/7mNEAUd1pAzD4lfSJpqnt A==;
X-CSE-ConnectionGUID: SXYyDiwHQxW+JoiDhGt+Ug==
X-CSE-MsgGUID: IX9ljF7hS+Gj5LZ5z9jCDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787566"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787566"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:32 -0800
X-CSE-ConnectionGUID: F7brjltESuGum7Oq3/AkNg==
X-CSE-MsgGUID: /HT9Q0MtQvi/8Gzm/hkjHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12656049"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Miao Li <miao.li@intel.com>,
 Yahui Cao <yahui.cao@intel.com>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH v2 11/13] bus/pci: fix leaks on BAR mapping failure
Date: Fri, 27 Nov 2026 13:14:11 +0000
Message-ID: <ec4aab5b71f4a21b745f5fbe698197507b8ee980.1795785194.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795785194.git.anatoly.burakov@intel.com>
 <cover.1795785194.git.anatoly.burakov@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, when mapping device BARs in the primary process fails, there
are two things we do not release:

- when allocating the list of sparse areas for a BAR fails, we leak region
  info for that BAR (other branches do `free(reg)`)
- when mapping a BAR fails, we release the lists of sparse areas for all
  BARs that were mapped so far, but not for the BAR that failed, because
  cleanup stops just short of it.

Fix it by releasing region info when allocation fails, and by releasing
the list of sparse areas of the failed BAR as part of cleanup.

Fixes: f60abf9757f2 ("bus/pci: add VFIO sparse mmap")
Cc: miao.li@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 986b0322588..1c88d403d25 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -863,6 +863,7 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 					sizeof(*maps[i].areas) * maps[i].nr_areas, 0);
 				if (maps[i].areas == NULL) {
 					PCI_LOG(ERR, "Cannot alloc memory for sparse map areas");
+					free(reg);
 					goto err_map;
 				}
 				memcpy(maps[i].areas, sparse->areas,
@@ -913,6 +914,9 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 		if (maps[j].nr_areas > 0)
 			rte_free(maps[j].areas);
 	}
+	/* the loop above stops short of the BAR that failed to map */
+	if (i < vfio_res->nb_maps)
+		rte_free(maps[i].areas);
 err_vfio_res:
 	rte_free(vfio_res);
 err_vfio_dev_fd:
-- 
2.52.0

