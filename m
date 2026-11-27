Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9C606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mm+UzOWl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32E12402DF;
	Fri, 27 Nov 2026 14:14:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 485E940263
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785262; x=1827321262;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YgmIWLCK3HZHcNpQ+1uf3XoJ9beMgqnKPf+Y5eE2Gr8=;
 b=mm+UzOWl+in/D340PzBVAtsZHb2EtiNqiVPj7LS2xb0vUHczbMwLHTLi
 zZ5R5dp9PaTOod9MZTY201h10bF8GKfz8DavlU9UFM2eQn3wobBvMGQaQ
 kEjMLvrEUaMVnG7BQAfQcJjufqSSKoQvpLzl6rpoMGliq6WW0HtYEB5It
 Q7mTQq6Gonk2nIRIqG+d3Y8h+LbnQ2Dqs0FrRZBmoageYxc6V+1VOjcY0
 k3VptvN01umVxIP2BJ8v/9n7ipAxs2ufa/El1gpqLrfpLVUpC8MMvSyx7
 7mgZ6HgqbQaXN7SQIN6dhx3rcMmn86PFuk0wAL0GADZ1Rl7f/A37dNPd0 w==;
X-CSE-ConnectionGUID: 1xeTGqNkQlmClqilY0rf/g==
X-CSE-MsgGUID: rd550kOBRHmtvqjz4kBO8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787502"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787502"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:20 -0800
X-CSE-ConnectionGUID: LGvQtqvJSXGYNmdaIoFPrg==
X-CSE-MsgGUID: OLsj8+QtS9mvRvKYTriRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655975"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2 01/13] interrupts: fix partial event list resize
Date: Fri, 27 Nov 2026 13:14:01 +0000
Message-ID: <eb5a8a7a578f444984c6acd70e179c611d0e7d33.1795785194.git.anatoly.burakov@intel.com>
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

Resizing the eventfd list before the epoll event list can leave the handle with a smaller eventfd array and the old interrupt count if the second allocation fails. Subsequent access can then read past the end of the array.

Allocate both replacement arrays before changing the handle. Preserve the existing entries and free the original arrays only after both allocations succeed.

Fixes: 8cb5d08db940 ("interrupts: extend event list")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_interrupts.c | 40 +++++++++++++++-----------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index f3eee636df3..3b46e90c4c3 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -107,6 +107,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_event_list_update)
 int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 {
 	struct rte_epoll_event *tmp_elist;
+	size_t copy_count;
 	bool uses_rte_memory;
 	int *tmp_efds;
 
@@ -121,34 +122,41 @@ int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 	uses_rte_memory =
 		RTE_INTR_INSTANCE_USES_RTE_MEMORY(intr_handle->alloc_flags);
 	if (uses_rte_memory) {
-		tmp_efds = rte_realloc(intr_handle->efds, size * sizeof(int),
-			0);
+		tmp_efds = rte_calloc(NULL, size, sizeof(*tmp_efds), 0);
+		tmp_elist = rte_calloc(NULL, size, sizeof(*tmp_elist), 0);
 	} else {
-		tmp_efds = realloc(intr_handle->efds, size * sizeof(int));
+		tmp_efds = calloc(size, sizeof(*tmp_efds));
+		tmp_elist = calloc(size, sizeof(*tmp_elist));
 	}
-	if (tmp_efds == NULL) {
-		EAL_LOG(ERR, "Failed to realloc the efds list");
+	if (tmp_efds == NULL || tmp_elist == NULL) {
+		EAL_LOG(ERR, "Failed to allocate interrupt event lists");
+		if (uses_rte_memory) {
+			rte_free(tmp_efds);
+			rte_free(tmp_elist);
+		} else {
+			free(tmp_efds);
+			free(tmp_elist);
+		}
 		rte_errno = ENOMEM;
 		goto fail;
 	}
-	intr_handle->efds = tmp_efds;
+
+	copy_count = RTE_MIN((size_t)size, (size_t)intr_handle->nb_intr);
+	memcpy(tmp_efds, intr_handle->efds, copy_count * sizeof(*tmp_efds));
+	memcpy(tmp_elist, intr_handle->elist, copy_count * sizeof(*tmp_elist));
 	for (int i = intr_handle->nb_intr; i < size; i++)
-		intr_handle->efds[i] = -1;
+		tmp_efds[i] = -1;
 
 	if (uses_rte_memory) {
-		tmp_elist = rte_realloc(intr_handle->elist,
-			size * sizeof(struct rte_epoll_event), 0);
+		rte_free(intr_handle->efds);
+		rte_free(intr_handle->elist);
 	} else {
-		tmp_elist = realloc(intr_handle->elist,
-			size * sizeof(struct rte_epoll_event));
-	}
-	if (tmp_elist == NULL) {
-		EAL_LOG(ERR, "Failed to realloc the event list");
-		rte_errno = ENOMEM;
-		goto fail;
+		free(intr_handle->efds);
+		free(intr_handle->elist);
 	}
 	intr_handle->elist = tmp_elist;
 
+	intr_handle->efds = tmp_efds;
 	intr_handle->nb_intr = size;
 
 	return 0;
-- 
2.52.0

