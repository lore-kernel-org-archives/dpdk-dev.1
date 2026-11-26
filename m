Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96F606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LhZ4dhly
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBB844069D;
	Thu, 26 Nov 2026 17:03:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 7D81B40684
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709013; x=1827245013;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tOnCUAo2+wtzR8kTykWepzH6VCOuxWIl00UuEs7I4d4=;
 b=LhZ4dhlyKZkkxPy8vCa98lZIOHudwl/AiqttqaJsiRJZWj3ZhG7YKO8W
 I4i/kD8AhMP3aaxiZzKnHCU3EkyWWoPM4DfjKqUqzx4rCWePJDa+uKNYR
 jwnzQmPxPGHfR6zYe1IXverKWNmWTIbDDNki3cCFpv4iBAqItDdjbu6b6
 TRcU5S1Tmx56jJErp0UVFfjeumvaTulYA39vPcGV96D51Thn5mtDnBVVt
 AqJ/oDfkW/wjWArSfodnHufHd/3mshCpRQcd1aVp5bQewTChjgv0yFjYr
 wzG+jEaEWjM4MbNeIzWiHDny6UjnUUbB1vhmC+5LFAc9b3YHXsz7C297r g==;
X-CSE-ConnectionGUID: 6pdAHybpRjqk0cPtE1L9ug==
X-CSE-MsgGUID: x8aaMannQyGFM0wIKkSO6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519760"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519760"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:33 -0800
X-CSE-ConnectionGUID: 1I0R4PV2RW2qnDiF8DtRpg==
X-CSE-MsgGUID: xFOoNSMoSm6OESwKEQwSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236667"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Yahui Cao <yahui.cao@intel.com>,
 Miao Li <miao.li@intel.com>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH v1 08/11] bus/pci: fix leaks on BAR mapping failure
Date: Thu, 26 Nov 2026 16:03:14 +0000
Message-ID: <6f6eecada5da9862653facc9cccc9e6a8b8a1bcf.1795708917.git.anatoly.burakov@intel.com>
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

