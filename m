Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0791606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dy/3UoOQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04A3640658;
	Fri, 27 Nov 2026 14:14:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id EE39440263
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785262; x=1827321262;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o/8lY6lKxI3pssO39gvMDzxCKLEcJCCXu80qSLGlx6Y=;
 b=Dy/3UoOQ/WootJYfqmqyo8suBEOtIVu2ifrU5ykAo0ITd6m56WIAFyUX
 QCxZRLWl5EOtBqCJWRW4P7AudHurxHNhScoc2UoCN1FiL2Xp8dvlCMsvm
 U+WS7aveadx2oxRUq+aPKrVd6IJFiuR/NO7FqYj/pMCEWTJenrYIw+BvN
 sDt4AYh7rtps0XgvS8uM2FefJBUJv8SfUrNXtCr5pjhBVcyO4JgMyd4HJ
 XH0ciRPAAKANc1KeTYvtgtre2JcwRuLBWr95aZg23+7EWoUI3YWhaNwkA
 hhbfvucvvlJgEgnAPZ4+l45RC0O0PxvntEHYRWMpYGUo2uE2GIXnltry3 g==;
X-CSE-ConnectionGUID: rMquA43SSyWLE25P/nh2og==
X-CSE-MsgGUID: uzfQxmFOTEienxslln8H0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787511"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787511"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:22 -0800
X-CSE-ConnectionGUID: tpCgPWqnRXe0q4R6f2Cy1w==
X-CSE-MsgGUID: Kfil6jXwTG2f9TkQO6EypA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655984"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:20 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Cunming Liang <cunming.liang@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2 03/13] vfio: fix uninitialized eventfds when enabling MSI-X
Date: Fri, 27 Nov 2026 13:14:03 +0000
Message-ID: <052d3d0ce063abc5f0e7df280656504e646474a0.1795785194.git.anatoly.burakov@intel.com>
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

Currently, when we enable MSI-X interrupts, we request as many vectors as
the interrupt handle says it may have, but we only fill in eventfds for
the vectors that have them. When the interrupt handle is set up through
EAL the two always match, but a driver is free to set the maximum number
of interrupts itself, and if it is bigger than the number of eventfds in
use, the rest of the request is uninitialized.

Fix it by marking all remaining vectors as having no eventfd.

Fixes: b13bfab4cdbe ("eal: reserve VFIO vector zero for misc interrupt")
Cc: cunming.liang@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_interrupts.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index c63956cde5c..03a0fc6ff32 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -278,7 +278,7 @@ vfio_enable_msix(const struct rte_intr_handle *intr_handle) {
 	int len, ret;
 	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
 	struct vfio_irq_set *irq_set;
-	int *fd_ptr, vfio_dev_fd, i;
+	int *fd_ptr, vfio_dev_fd, i, nb_rxtx_vectors;
 
 	len = sizeof(irq_set_buf);
 
@@ -289,6 +289,8 @@ vfio_enable_msix(const struct rte_intr_handle *intr_handle) {
 		(rte_intr_max_intr_get(intr_handle) >
 		 RTE_MAX_RXTX_INTR_VEC_ID + 1 ?	RTE_MAX_RXTX_INTR_VEC_ID + 1 :
 		 rte_intr_max_intr_get(intr_handle)) : 1;
+	/* skip the first vector */
+	nb_rxtx_vectors = (int)irq_set->count - RTE_INTR_VEC_RXTX_OFFSET;
 
 	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
 	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
@@ -300,6 +302,9 @@ vfio_enable_msix(const struct rte_intr_handle *intr_handle) {
 		fd_ptr[RTE_INTR_VEC_RXTX_OFFSET + i] =
 			rte_intr_efds_index_get(intr_handle, i);
 	}
+	/* vectors that have no eventfd must not be left uninitialized */
+	for (; i < nb_rxtx_vectors; i++)
+		fd_ptr[RTE_INTR_VEC_RXTX_OFFSET + i] = -1;
 
 	vfio_dev_fd = rte_intr_dev_fd_get(intr_handle);
 	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
-- 
2.52.0

