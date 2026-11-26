Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B9606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4yj9A7C
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 037AE4069F;
	Thu, 26 Nov 2026 17:03:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id BCF6840663
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709012; x=1827245012;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Zk3Bj+3dPG7q9BqWb3brPSMlSYn1hUqvAFpsAOFh0N0=;
 b=a4yj9A7CqB3A6L/LUV7ZEkNsJSPJ/vm0Vjp/SEjVSdMRJkFJFMgnldR/
 GI22JK1/2AB3P56NFcQAGShaHkklKdbmftuV3BumVVc1jf+cPoKtCfDSy
 LSmebiZHADgIA2zypcjLg6na+5tsrXL4Xv9RW3dx2xMWMS9YDYNGSQv9R
 fNSy4kkJYv8h1VZM2egL/Xi7b83Dlp60Aaz2zafT4Dz5Ab+48Hgv+wzH+
 N95qbVLbE1uNUoQKnuu4X2aU0qggqLD8DJdrT+ihh8uJjd6C0wC373pfU
 aNaZKZz3iFWlzaceOy7IhEenn2Y6pveaFRiZamr1Mo5yMg0/mrg2eWb4V Q==;
X-CSE-ConnectionGUID: /GJkwllvTiqcnLYOR64Srw==
X-CSE-MsgGUID: kX5m3dAhRuuIIxwQ4pxcRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519753"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519753"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:31 -0800
X-CSE-ConnectionGUID: j4pHFPRNRtGzlgTaU/Y7Qg==
X-CSE-MsgGUID: WfNzfFL9TrmBZCC8mTCelA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236649"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:30 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Miao Li <miao.li@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>, Yahui Cao <yahui.cao@intel.com>
Subject: [PATCH v1 07/11] bus/pci: fix shared BAR info reset on mapping failure
Date: Thu, 26 Nov 2026 16:03:13 +0000
Message-ID: <e9f75a24a2fe54b5124600d9d542a2b9246014ed.1795708917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795708917.git.anatoly.burakov@intel.com>
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

