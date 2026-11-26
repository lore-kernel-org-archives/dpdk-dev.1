Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3206606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rx89vQEJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81342409FA;
	Thu, 26 Nov 2026 17:03:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 00D1F4069D
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709015; x=1827245015;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yGNnxoEPilzZZmbIK6fU36TniZQqHlgpUUqU4CPZY/I=;
 b=Rx89vQEJVFz0VMK5MJ5ZhFE2cBlM0YRClfgGbOSEO+mKZfQP3+PfT1XY
 mJT8hjh7Vkc6HGLnrN6g5AHr4pTwIs0evjj62PitrIJ5gQS9ga3BVRI6I
 erXreWFMsq70kZpeWTiTTeGXJC4/rw1RvrYTRxR2cYeHgooO4DyGjUcKb
 MDSPcgG89PkBAbHsWewfcYWFz+wGLdH+lW9r3ODD7GtWkt2IYCBUjZS4W
 ZojIrPVh9qYd8TYaJt2zlpiIesExdH4eWthsOTgzRMeS6AT1RTl3ruzEW
 6RvsXPEEfWmR7MANcMHGIHI1YfEfhlzI5wXnGigFctiQ/JF/9q//Cqh4R w==;
X-CSE-ConnectionGUID: LAV860GzQwulbnGJG1BKbw==
X-CSE-MsgGUID: A+toVkGkQ3m9WjAtFnkyPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519767"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:34 -0800
X-CSE-ConnectionGUID: YvlOogWxS4O1xEO4Qgavxw==
X-CSE-MsgGUID: +pjlO/D9SFyt1km4MzlsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236674"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Miao Li <miao.li@intel.com>,
 Yahui Cao <yahui.cao@intel.com>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH v1 09/11] bus/pci: fix BAR area list free in secondary process
Date: Thu, 26 Nov 2026 16:03:15 +0000
Message-ID: <5cc25acfca98cea368a54d08734b01ca28ba8212.1795708917.git.anatoly.burakov@intel.com>
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

Currently, when we unmap a device in a secondary process, we free the
mmap area lists of its BARs. These lists are allocated by the primary
process in shared memory and are referenced from the mapped resource
entry, which stays in the shared list after a secondary process unmaps
the device. As a result, we have use-after-free (if another process
references the list) as well as a double-free (if another process, primary
or secondary, tries to free it).

Fix it by freeing the area lists only in the primary process, where the
mapped resource entry itself is freed.

Fixes: f60abf9757f2 ("bus/pci: add VFIO sparse mmap")
Cc: miao.li@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 1c88d403d25..f4f9cad7409 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1057,9 +1057,6 @@ find_and_unmap_vfio_resource(struct mapped_pci_res_list *vfio_res_list,
 				pci_addr, maps[i].addr);
 			pci_unmap_resource(maps[i].addr, maps[i].size);
 		}
-
-		if (maps[i].nr_areas > 0)
-			rte_free(maps[i].areas);
 	}
 
 	return vfio_res;
@@ -1072,7 +1069,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 	struct rte_pci_addr *loc = &dev->addr;
 	struct mapped_pci_resource *vfio_res = NULL;
 	struct mapped_pci_res_list *vfio_res_list;
-	int ret, vfio_dev_fd;
+	int i, ret, vfio_dev_fd;
 
 	/* store PCI address string */
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
@@ -1113,6 +1110,10 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 		return -1;
 	}
 
+	/* area lists are shared with secondaries, so only the primary frees them */
+	for (i = 0; i < vfio_res->nb_maps; i++)
+		rte_free(vfio_res->maps[i].areas);
+
 	TAILQ_REMOVE(vfio_res_list, vfio_res, next);
 	rte_free(vfio_res);
 	return 0;
-- 
2.52.0

