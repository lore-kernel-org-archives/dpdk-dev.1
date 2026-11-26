Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF191606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F4wajsMv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9180C4064F;
	Thu, 26 Nov 2026 17:03:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A9EB402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709005; x=1827245005;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5WMyqyHG9xHWTkMwpxpLMPC3b/vEvMp6InPtbMVyeWU=;
 b=F4wajsMvwRvZXRZogqv0QA1sTODdm8wl+qpeBiJ2YFlYoJ2lDtV1GFmW
 7CN0zqrTXDuilrwnLwZFzweKs/0tET0B7c1zX2YHeych50tFrX51FTUFG
 WuNCAGhJAp62sDXwiXtK3Z51uBeEfQQBqMClxJHn8iTN8OJ4a+s9sMnxU
 EIgSo/MbSrn7YtO67WTo8FKLdN7NJXTSRXosdlPYcAR8kGJdGZpBiz4xr
 NeCHHPCn6UoSxEjL/PLlOJTfmL1DeetdIhn+CC4NL+d1H1J4UyXtV4mXo
 zbEScrQUPyvl9vSCe4wWolsZi0hZrM+fEWnkmMGJpGxxlRgo279AIqFI6 g==;
X-CSE-ConnectionGUID: NudIO/trTUex06h9aIdS8A==
X-CSE-MsgGUID: S4fbhyG3SX2tVU6wnIQRJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519727"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519727"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:24 -0800
X-CSE-ConnectionGUID: qoR1Np9aQ56kXDNFCg7v2g==
X-CSE-MsgGUID: b+VJPte6ThWGFVW9RSirdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236592"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v1 02/11] bus/cdx: fix eventfd setup when enabling interrupts
Date: Thu, 26 Nov 2026 16:03:08 +0000
Message-ID: <426012b22aba7005cda5bad7ac45b987d2cc84d3.1795708917.git.anatoly.burakov@intel.com>
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

