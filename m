Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1EC606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WnQPXB29
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A16144069D;
	Fri, 23 Oct 2026 15:39:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8349A4060B
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792762767; x=1824298767;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MOEjP5eCgNXqXRCtxftlvZlL5XQOykt3HXiAIyJ4hOU=;
 b=WnQPXB29Tfrs2Jehk2EQScP3YOrxs9dgCkExLyRxkW5zkhg+ebXddPbp
 l0YkOyOikoeimh9EgSCctJ2XkXOvj4el5NSal7boRZOXIxo0578SZDAw9
 a+4UILWxnmNqR9kflWl0vJWMHZifFMEi3dqpJRnUBA2cRvHVY72USvH/2
 v6UCguC3BRfVbRTVbi5XHmI7KvT/Hbg501Yr5bhk51PbIkJ18OJtUpxgp
 lq04/xjJU+TQIG28eKW1ccXz/+3L9FTZCElNp8Ge0CBp6wMk4hCIK6u68
 Pp4/J7JCS3ktwS0BrN2I5P4bXQDnRYxj8zBpd3UWFfa83ECVmhgXhix9L Q==;
X-CSE-ConnectionGUID: cIwHVqhESaGP6Fg8NSpqqQ==
X-CSE-MsgGUID: l1h3bzruRNmBT+73PatBRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1537430"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1537430"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:39:27 -0700
X-CSE-ConnectionGUID: FHs9l2A2SHKfqwfyjEUbDw==
X-CSE-MsgGUID: uzxhpgIPRkKnkqG0f0iRGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3586594"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 06:39:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v3 4/8] eal/linux: fix eventfd leaks when enabling interrupts
Date: Fri, 23 Oct 2026 14:39:11 +0100
Message-ID: <c0a2a659547bb97d0d415bd02c27c11072841aed.1792762746.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <e9eba9cd731a90f6e487a76bfe3bee84b1cdc3de.1792762746.git.anatoly.burakov@intel.com>
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
Update the eventfd count as each descriptor is created, so that on failure
every eventfd created by the call can be closed, its entry cleared, and the
count reset.

Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_interrupts.c | 43 ++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index bdee1dd9777..410b6d66c45 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1569,31 +1569,45 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
-	uint32_t i;
-	int fd;
+	int fd, ret;
 	uint32_t n = RTE_MIN(nb_efd, (uint32_t)RTE_MAX_RXTX_INTR_VEC_ID);
 
 	assert(nb_efd != 0);
 
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
+		uint32_t i;
+
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
+			/* Record each eventfd as it is created so that the
+			 * error path can close exactly those that exist.
+			 */
+			if (rte_intr_efds_index_set(intr_handle, i, fd) ||
+					rte_intr_nb_efd_set(intr_handle, i + 1)) {
+				ret = -rte_errno;
+				close(fd);
+				rte_intr_efds_index_set(intr_handle, i, -1);
+				goto error;
+			}
 		}
 
-		if (rte_intr_nb_efd_set(intr_handle, n))
-			return -rte_errno;
-
-		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n))
-			return -rte_errno;
+		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n)) {
+			ret = -rte_errno;
+			goto error;
+		}
 	} else if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
 		/* only check, initialization would be done in vdev driver.*/
 		if ((uint64_t)rte_intr_efd_counter_size_get(intr_handle) >
@@ -1611,6 +1625,15 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	}
 
 	return 0;
+
+error:
+	for (int i = 0; i < rte_intr_nb_efd_get(intr_handle); i++) {
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

