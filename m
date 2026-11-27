Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81E606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RB7Ztkf0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18769409FA;
	Fri, 27 Nov 2026 14:14:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 049E140696
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785272; x=1827321272;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Zk3Bj+3dPG7q9BqWb3brPSMlSYn1hUqvAFpsAOFh0N0=;
 b=RB7Ztkf0/viKj734cOS0eYYcOnR7UjoxasMQ/py2+2ripCw/FIaU8YGO
 wIvEEvr464c16UwKA/6nDQWb9+LgGd3kzCjg6Yh3pWB6tj1mCuZEUAbT5
 ciPV6bELpvrJEWMyjIrs+rTgp24Nf9LI+1nZTZwcLzWgoqiqHY9/3moD2
 DNpZjqe/H29SpLoLqId+4BFicwxpucRpVPtOl0RAQUnMgQuQjxIXk8ChS
 r7ld3P66a2ni7Iks4hB/KOfCoWCALKkhw0qEwUYpL+wIckZvm6aXMIvqu
 V6BhRvVZRUBSLE2eXHAke5r8axASFzFgYe+M/1/TlS23m+hVWbvpVKAes w==;
X-CSE-ConnectionGUID: 8ptQJd5TRM6Va2l8v6/PyA==
X-CSE-MsgGUID: ODlns1ABS+usLSrEOGskUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787546"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787546"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:31 -0800
X-CSE-ConnectionGUID: VI8D9YPsTC2glYmOyi3USQ==
X-CSE-MsgGUID: K0OSo5gwQ5ObiLFOWL26jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12656030"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Miao Li <miao.li@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>, Yahui Cao <yahui.cao@intel.com>
Subject: [PATCH v2 10/13] bus/pci: fix shared BAR info reset on mapping failure
Date: Fri, 27 Nov 2026 13:14:10 +0000
Message-ID: <46334824529fd6cc03c8d688a589e7f6f6a66641.1795785194.git.anatoly.burakov@intel.com>
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

Currently, when mapping a sparse BAR fails, we reset the number of sparse
areas recorded for that BAR. However, BAR records live in memory that
is shared between primary and secondary processes, so when a secondary
process fails to map a BAR, it wipes the record that the primary process
and all other secondary processes rely on.

There is actually no need for the reset to begin with, because when mapping
fails in the primary process, the records are discarded anyway. Fix it
by leaving the record alone.

Fixes: f60abf9757f2 ("bus/pci: add VFIO sparse mmap")
Cc: miao.li@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 4363d7ff2c3..986b0322588 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -594,21 +594,17 @@ pci_vfio_sparse_mmap_bar(int vfio_dev_fd, struct mapped_pci_resource *vfio_res,
 				if (map_addr == NULL) {
 					munmap(bar_addr, bar->size);
 					PCI_LOG(ERR, "Failed to map pci BAR%d", bar_index);
-					goto err_map;
+					return -1;
 				}
 			}
 		}
 	} else {
 		PCI_LOG(ERR, "Failed to create inaccessible mapping for BAR%d", bar_index);
-		goto err_map;
+		return -1;
 	}
 
 	bar->addr = bar_addr;
 	return 0;
-
-err_map:
-	bar->nr_areas = 0;
-	return -1;
 }
 
 /*
-- 
2.52.0

