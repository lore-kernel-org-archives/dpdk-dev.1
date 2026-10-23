Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A76606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fXuaROdx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB72A40A77;
	Fri, 23 Oct 2026 15:39:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id BBEFA406B7
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792762772; x=1824298772;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Gtz9ZjmuXtI6Cq8VQVzgKAZdR6bM7ko0O3EhyWyBVpo=;
 b=fXuaROdxN2KbHiN+ruLLH12OXC8sgrGNO07ts9ar/SZIWVDWEUKU3lGa
 quTrXA7QrrhFdZ+NRxPXjXTb7e/5ZPutXJP+GhEMOuRmeoKxt3Qr6gdQ+
 meS9nkZvMrdpgXOP3oO3a0evpAQ4hoxGKWnLXzde9umH4NuYcTQklkmcD
 +6sJMT+waILnLO2a8T/LXtIwmx0r74pr7+DtmYq+PRCE5B5kcHh0Qw1sf
 q7iUCmuPokriGNB3p56wvQFXGkqL4y4OspA7lPWd+Eeo/bWhiDT5OATqf
 8XifRXmroVrZN+vY5fzMApZ3kCwZQNyEbd3t0uWZLQd4tmC72Q7MCfwPj A==;
X-CSE-ConnectionGUID: lQth2qJgS/+H3TKPd2uqVQ==
X-CSE-MsgGUID: UzlB1Q/hQrS5VuUQVknfzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1537448"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1537448"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 06:39:32 -0700
X-CSE-ConnectionGUID: GGMGvqKBRguhATKeRDpm/g==
X-CSE-MsgGUID: HfUqQizkSwOrDnmhdA3PZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3586623"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 23 Oct 2026 06:39:31 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 8/8] interrupts: warn on leaked event FDs
Date: Fri, 23 Oct 2026 14:39:15 +0100
Message-ID: <8f53967f2906f72609f2c3e8dd55157eaaa9e31f.1792762746.git.anatoly.burakov@intel.com>
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

Extend the leak warning in rte_intr_instance_free() to the event FD
array, in the same way as the handle FD and device FD.

rte_intr_efd_disable() used to close the eventfds it owns but left
the stale descriptors in the array, and never cleared the entry that
merely references the handle FD in the non-MSI-X case. Reset all
entries in use to -1 so a properly disabled handle is not reported.

Drivers filling the event FD array themselves are expected to reset
the entries once the descriptors are closed or no longer referenced.

Suggested-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_interrupts.c | 5 +++++
 lib/eal/include/rte_interrupts.h       | 7 ++++++-
 lib/eal/linux/eal_interrupts.c         | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index cf56f967218..fa0e0ab961d 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -201,6 +201,11 @@ void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 	if (rte_intr_dev_fd_get(intr_handle) >= 0)
 		EAL_LOG(NOTICE, "Some interrupt handle is leaking a device FD: %d",
 			rte_intr_dev_fd_get(intr_handle));
+	for (int i = 0; i < intr_handle->nb_intr; i++) {
+		if (intr_handle->efds[i] >= 0)
+			EAL_LOG(NOTICE, "Some interrupt handle is leaking an event FD: %d (index %d)",
+				intr_handle->efds[i], i);
+	}
 	if (RTE_INTR_INSTANCE_USES_RTE_MEMORY(intr_handle->alloc_flags)) {
 		rte_free(intr_handle->efds);
 		rte_free(intr_handle->elist);
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index d04c0c7b15f..3aeac9092ae 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -389,6 +389,7 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd);
  * @internal
  * It disables the packet I/O interrupt event.
  * It deletes registered eventfds and closes the open fds.
+ * All event fd entries in use are reset to -1.
  *
  * @param intr_handle
  *   Pointer to the interrupt handle.
@@ -620,12 +621,16 @@ rte_intr_efd_counter_size_get(const struct rte_intr_handle *intr_handle);
  * @internal
  * Set the event fd array index with the given fd.
  *
+ * Entries still holding a valid fd when the instance is freed are reported
+ * as leaks, so callers managing the array themselves must reset entries
+ * to -1 once the fd is closed or no longer referenced.
+ *
  * @param intr_handle
  *  pointer to the interrupt handle.
  * @param index
  *  efds array index to be set
  * @param fd
- *  event fd
+ *  event fd, or -1 to clear the entry
  *
  * @return
  *  - On success, zero.
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index aadb7b84a22..f6f51ba53c0 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1667,6 +1667,8 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 		for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
 			close(rte_intr_efds_index_get(intr_handle, i));
 	}
+	for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
+		rte_intr_efds_index_set(intr_handle, i, -1);
 	rte_intr_nb_efd_set(intr_handle, 0);
 	rte_intr_max_intr_set(intr_handle, 0);
 }
-- 
2.52.0

