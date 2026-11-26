Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59204606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TDqNxcfn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D54640A71;
	Thu, 26 Nov 2026 17:03:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id C2D3B40A6B
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709018; x=1827245018;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=QLMD4msuLzYWLyFVF82K7lqvZ91Eq/ydJV8Z01pH0I0=;
 b=TDqNxcfnE717uNW0Vu0WoFB6tJ1Rnzbk4Hvhg+35uVCKKtRoaqXI/PGs
 PDZR8ardzbjjOTbEJr9KOuF/dGYDv1c2aY4ZcLfgRWfePyhY1+5ETDUWk
 VwPEBUeGG16JF/fLbWYeG7yuX7kWpBuGL5DkWw9ESnjvL2NjB1P1pzIMG
 sNk4RLd9U5+azj/Uvn0/bTojsZBYpf8ZUMGc5IUy4t3GIP/VYojC+1Off
 6ixSUNAxZJAAwD17mCJAJCTOOJXTU7dUyrQ7dvFrcmSEWe0s1eJnNdSi9
 2ps3vcfvLySiuYqMkDvRpm7IPI4VI92gjX4dQRYtK2x8rhrBPa5wzPOJF Q==;
X-CSE-ConnectionGUID: 1MSN3r+jSvaGY/0apEt30g==
X-CSE-MsgGUID: gIyDlWSsSLO9OniE7dw2mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519776"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:37 -0800
X-CSE-ConnectionGUID: gKQK8QzvSU2lRxv/CGL8nQ==
X-CSE-MsgGUID: eC5B+szsRzqed8MqeSCovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236683"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:36 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vijay Kumar Srivastava <vsrivast@xilinx.com>,
 Abhimanyu Saini <absaini@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v1 11/11] vdpa/sfc: fix doorbell address in notify area query
Date: Thu, 26 Nov 2026 16:03:17 +0000
Message-ID: <2df08ca56c08d3099f23e56919db7547222a39f6.1795708917.git.anatoly.burakov@intel.com>
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

Currently, when vhost asks for the notify area of a queue, we return
its offset within the VFIO device fd, which is the offset of the BAR
region within the fd plus the doorbell offset within the BAR. We then
also write to the doorbell ourselves, but we compute its address by
adding that same fd offset to the address the BAR is mapped at. This is
only correct when the region happens to be at offset zero within the fd:
otherwise, the address ends up far outside of the BAR mapping.

Fix it by adding only the doorbell offset within the BAR, and check that
the doorbell is within the BAR before writing to it.

Fixes: 2eb13ddea384 ("vdpa/sfc: fix sync between QEMU and vhost-user")
Cc: absaini@amd.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/sfc/sfc_vdpa_ops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/sfc/sfc_vdpa_ops.c b/drivers/vdpa/sfc/sfc_vdpa_ops.c
index 84ba141b348..778cde115f8 100644
--- a/drivers/vdpa/sfc/sfc_vdpa_ops.c
+++ b/drivers/vdpa/sfc/sfc_vdpa_ops.c
@@ -815,6 +815,7 @@ sfc_vdpa_get_notify_area(int vid, int qid, uint64_t *offset, uint64_t *size)
 	struct vfio_region_info reg = { .argsz = sizeof(reg) };
 	const efx_nic_cfg_t *encp;
 	int max_vring_cnt;
+	uint64_t bar_offset;
 	int64_t len;
 	void *dev;
 
@@ -847,7 +848,8 @@ sfc_vdpa_get_notify_area(int vid, int qid, uint64_t *offset, uint64_t *size)
 	}
 
 	/* Use bar_offset that was cached during sfc_vdpa_virtq_start() */
-	*offset = reg.offset + (uint64_t)ops_data->vq_cxt[qid].doorbell;
+	bar_offset = (uintptr_t)ops_data->vq_cxt[qid].doorbell;
+	*offset = reg.offset + bar_offset;
 
 	len = (1U << encp->enc_vi_window_shift) / 2;
 	if (len >= sysconf(_SC_PAGESIZE)) {
@@ -861,7 +863,11 @@ sfc_vdpa_get_notify_area(int vid, int qid, uint64_t *offset, uint64_t *size)
 		      *offset);
 
 	pci_dev = sfc_vdpa_adapter_by_dev_handle(dev)->pdev;
-	doorbell = (uint8_t *)pci_dev->mem_resource[reg.index].addr + *offset;
+	if (bar_offset + sizeof(uint16_t) > pci_dev->mem_resource[reg.index].len) {
+		sfc_vdpa_err(dev, "invalid doorbell offset : 0x%" PRIx64, bar_offset);
+		return -1;
+	}
+	doorbell = (uint8_t *)pci_dev->mem_resource[reg.index].addr + bar_offset;
 
 	/*
 	 * virtio-net driver in VM sends queue notifications before
-- 
2.52.0

