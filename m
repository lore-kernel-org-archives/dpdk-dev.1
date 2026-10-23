Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D2606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lMrKw2CB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC46240299;
	Fri, 23 Oct 2026 11:36:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 50FD840268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792748210; x=1824284210;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=16H0/jcKx4x2GrXQ11Dhu/LPWxiPUdZGvWy9lqaOOkQ=;
 b=lMrKw2CB67yldenmDa4iBkT0qoG9Wc/F+3AZBP36ormLzRWCVNqcapJu
 hm/ffVfvbowJ2d/yxuedTKtks3exhXQtPGnZfQMY1W1lLNRyLxt87UspL
 9OAhuiBqSYI01zFwSIYGFu6p8t2jUGZTmm19TZCtfuahJQ/GkyixX0QhG
 HrSCGqmiA7x85f8bqiOekROF1oKS+lv1nE9smYckde6FlWDL8ZYLDxNCR
 sRGvWcMax9GBFKyZkGTMaOfn0MIafSbocE3ETN4MmgSHFwuxne5zsOA3I
 /S8F27hzm7MjBbeGPPArwgvtm9SvbvYGfh+l/S2DJ3RER8souiaKa9x98 A==;
X-CSE-ConnectionGUID: W52l5qe4RmaQKLNkJvzyFQ==
X-CSE-MsgGUID: mTWlxGudSbaSonoFHjSVHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1383123"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1383123"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:36:49 -0700
X-CSE-ConnectionGUID: YGrv7mEvSrONU24sEvF53Q==
X-CSE-MsgGUID: spXswxrfSNiC/VZjQn5pWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="5415807"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa013.fm.intel.com with ESMTP; 23 Oct 2026 02:36:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v1 1/1] eal/linux: fix eventfd leaks when enabling interrupts
Date: Fri, 23 Oct 2026 10:36:46 +0100
Message-ID: <af76b0050fa71836d9663515f5efd66c8c910061.1792748199.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

When enabling MSI-X eventfds, a failure after creating some descriptors
leaves them open. The eventfd count is recorded only after all allocations
succeed, so disabling eventfds cannot clean up a partial allocation.

Calling enable again without disabling first also leaks descriptors by
overwriting the existing eventfd entries.

Reject repeated MSI-X enable calls with EBUSY before modifying the handle.
On failure, close all eventfds created by the call, clear their entries
and reset the eventfd count while preserving the original error.

Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_interrupts.c | 39 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4cfaeba7fe0..ff05d649607 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1570,30 +1570,43 @@ int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
 	uint32_t i;
-	int fd;
+	int fd, ret;
 	uint32_t n = RTE_MIN(nb_efd, (uint32_t)RTE_MAX_RXTX_INTR_VEC_ID);
 
 	assert(nb_efd != 0);
 
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
+		if (rte_intr_nb_efd_get(intr_handle) != 0) {
+			EAL_LOG(ERR, "Interrupt eventfds are already enabled");
+			return -EBUSY;
+		}
+
 		for (i = 0; i < n; i++) {
 			fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
 			if (fd < 0) {
+				ret = -errno;
 				EAL_LOG(ERR,
 					"can't setup eventfd, error %i (%s)",
 					errno, strerror(errno));
-				return -errno;
+				goto error;
 			}
 
-			if (rte_intr_efds_index_set(intr_handle, i, fd))
-				return -rte_errno;
+			if (rte_intr_efds_index_set(intr_handle, i, fd)) {
+				ret = -rte_errno;
+				close(fd);
+				goto error;
+			}
 		}
 
-		if (rte_intr_nb_efd_set(intr_handle, n))
-			return -rte_errno;
+		if (rte_intr_nb_efd_set(intr_handle, n)) {
+			ret = -rte_errno;
+			goto error;
+		}
 
-		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n))
-			return -rte_errno;
+		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n)) {
+			ret = -rte_errno;
+			goto error;
+		}
 	} else if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
 		/* only check, initialization would be done in vdev driver.*/
 		if ((uint64_t)rte_intr_efd_counter_size_get(intr_handle) >
@@ -1611,6 +1624,16 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	}
 
 	return 0;
+
+error:
+	while (i > 0) {
+		i--;
+		close(rte_intr_efds_index_get(intr_handle, i));
+		rte_intr_efds_index_set(intr_handle, i, -1);
+	}
+	rte_intr_nb_efd_set(intr_handle, 0);
+
+	return ret;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
-- 
2.52.0

