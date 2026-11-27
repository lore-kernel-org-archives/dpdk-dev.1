Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A53606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n8rimWuS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B1B40678;
	Fri, 27 Nov 2026 14:14:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 5583440611
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785265; x=1827321265;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5WMyqyHG9xHWTkMwpxpLMPC3b/vEvMp6InPtbMVyeWU=;
 b=n8rimWuSj/ibFqxnJGtRNH6nECN4cMJEIWdYEyj/VeiL3Jmobuz75sQH
 1g5TTFMft2AzFyOce/6Y51yzQs6LOXWCkUWAkP/HW6l2yEwX0l2CuJjHy
 wCw9JR9O1Sp27LhxshLOgeZB0Xk8z357TaOnbyQeN9JJmh9DTOoX+/BlS
 afmE36XsZWvSesn9/U4pnhkR04/nEfFiXjjpLIMvrqxVYihwjeuFFnuq1
 dHeA+O0Y28yeHM8aP3o/9JdAuFWicACdotxHEjPHNIwtMOtY0h96kWFvV
 DVMoWFPfxhY/IhCSZBVd1rt3RsDcCgY0MleEXmwCFUz3AdyIbZYxrc9Ne w==;
X-CSE-ConnectionGUID: stzhlmL9RzyJsLlAnQdENA==
X-CSE-MsgGUID: iG4YTq2SRF6pAJ+5wM6Gug==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787516"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787516"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:24 -0800
X-CSE-ConnectionGUID: +AqHnhVbSFOexpadLMWAiA==
X-CSE-MsgGUID: cC2H9SFsQ72NHUgbzkue/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655987"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 05/13] bus/cdx: fix eventfd setup when enabling interrupts
Date: Fri, 27 Nov 2026 13:14:05 +0000
Message-ID: <75c18d128e457b654e525a5e1d521a2b4e15063f.1795785194.git.anatoly.burakov@intel.com>
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

Currently, when enabling CDX interrupts, the request tells the kernel to
set eventfds for all interrupts the device has, but only fills in an
eventfd for each vector that has one. The kernel reads every slot as a
file descriptor, so the remaining slots are uninitialized.

Also, the request lives in a fixed-size stack buffer, but the number of
slots comes from the device and is never checked against the buffer size,
so a device with enough interrupts may make the kernel read past the end of
the buffer.

Fix it by allocating the request to fit all of the device's interrupts,
and initializing slots without an efd to -1.

Fixes: f29fb5caa135 ("bus/cdx: support MSI")
Cc: nipun.gupta@amd.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/cdx/cdx_vfio.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 7e1f30c3764..9161a5f22a1 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -573,26 +573,41 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_enable)
 int
 rte_cdx_vfio_intr_enable(const struct rte_intr_handle *intr_handle)
 {
-	char irq_set_buf[MSI_IRQ_SET_BUF_LEN];
+	int nb_intr = rte_intr_nb_intr_get(intr_handle);
+	int nb_efd = rte_intr_nb_efd_get(intr_handle);
 	struct vfio_irq_set *irq_set;
 	int *fd_ptr, vfio_dev_fd, i;
+	size_t len;
 	int ret;
 
-	irq_set = (struct vfio_irq_set *) irq_set_buf;
-	irq_set->count = rte_intr_nb_intr_get(intr_handle);
-	irq_set->argsz = sizeof(struct vfio_irq_set) +
-			 (sizeof(int) * irq_set->count);
+	if (nb_intr <= 0) {
+		CDX_BUS_ERR("Invalid number of interrupts for fd %d",
+			rte_intr_fd_get(intr_handle));
+		return -1;
+	}
 
+	len = sizeof(*irq_set) + sizeof(int) * (size_t)nb_intr;
+	irq_set = calloc(1, len);
+	if (irq_set == NULL) {
+		CDX_BUS_ERR("Cannot allocate MSI interrupt request");
+		return -1;
+	}
+
+	irq_set->argsz = len;
+	irq_set->count = nb_intr;
 	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
 	irq_set->index = 0;
 	irq_set->start = 0;
 	fd_ptr = (int *) &irq_set->data;
 
-	for (i = 0; i < rte_intr_nb_efd_get(intr_handle); i++)
+	for (i = 0; i < nb_efd; i++)
 		fd_ptr[i] = rte_intr_efds_index_get(intr_handle, i);
+	for (; i < nb_intr; i++)
+		fd_ptr[i] = -1;
 
 	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
 	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
+	free(irq_set);
 
 	if (ret) {
 		CDX_BUS_ERR("Error enabling MSI interrupts for fd %d",
-- 
2.52.0

