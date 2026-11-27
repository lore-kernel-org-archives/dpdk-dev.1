Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F62606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ktYMaGJi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE574064E;
	Fri, 27 Nov 2026 14:14:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 719C840291
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785262; x=1827321262;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VjyhooncN91fMnwMXtapd0hO0W30wWG8MeAHjk5HUy8=;
 b=ktYMaGJir/etiJFzS12qVaK1Ycy2n0j+4n2dUWilTt83D4HRoH7NHGoB
 MeVoB8uewVA4PO27fxFt6wq1LZMYSVTpx05dxC9kflo/XiUglXxOpLKlU
 oTo/iLKrjkg5+4bLl6zjrm7tbMB75QT60mEQ5iyOsiPWzKOFguYVlEgfH
 OzVldKIJhvSyO///IUzckBREtrLOCG3i25EGKcGOn3NnpbuoOOtehiPCz
 fqAjtNCFh0Zz6CYirXlGFtJcArf+CJzYQ7AgZd7+Mft5sIECTbxgzpMdV
 PupL0e/jqWBuOWMRgKp1hTUCHBxJFPHO7vYGxieSh151n06fD4OrAicCA A==;
X-CSE-ConnectionGUID: +EvOFB8STF6vl9WiVr5zGg==
X-CSE-MsgGUID: SNO/2RUDQK+v7U+e/4OaGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787507"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:21 -0800
X-CSE-ConnectionGUID: kI68dYC3SIqxrk5t7E8veA==
X-CSE-MsgGUID: o1h/u0/oT3SRFlEcq4XyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655979"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 02/13] interrupts: validate event list counts
Date: Fri, 27 Nov 2026 13:14:02 +0000
Message-ID: <90527d0de3892db47860101d470cb26f433f04c0.1795785194.git.anatoly.burakov@intel.com>
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

Currently, when resizing event list counts, we only reject zero size. What
we do not check is the following:

- Negative sizes
- Sizes above UINT16_MAX (which would truncate)
- Sizes below current nb_efd or max_intr
- Sizing nb_efd above nb_intr

Fix the code to validate against these conditions.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_interrupts.c             | 89 ++++++++++++++++++++++++++
 lib/eal/common/eal_common_interrupts.c | 17 +++--
 lib/eal/include/rte_interrupts.h       |  5 +-
 3 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 2d63a2fd986..7fa26241695 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -4,6 +4,7 @@
 
 #define ALLOW_INTERNAL_API
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <unistd.h>
@@ -498,6 +499,79 @@ test_interrupt_full_path_check(enum test_interrupt_handle_type intr_type)
 	return 0;
 }
 
+static int
+test_interrupt_event_list_resize(struct rte_intr_handle *intr_handle)
+{
+	struct rte_epoll_event event = { .fd = 123 };
+
+	TEST_ASSERT_SUCCESS(rte_intr_event_list_update(intr_handle, 2),
+		"Failed to shrink interrupt event list");
+	TEST_ASSERT_SUCCESS(rte_intr_efds_index_set(intr_handle, 1, 123),
+		"Failed to set eventfd entry before growth");
+	TEST_ASSERT_SUCCESS(rte_intr_elist_index_set(intr_handle, 1, event),
+		"Failed to set epoll event before growth");
+	TEST_ASSERT_SUCCESS(rte_intr_event_list_update(intr_handle, 4),
+		"Failed to grow interrupt event list");
+	TEST_ASSERT_EQUAL(rte_intr_efds_index_get(intr_handle, 1), 123,
+		"Growth did not preserve eventfd entry");
+	TEST_ASSERT_EQUAL(rte_intr_elist_index_get(intr_handle, 1)->fd, 123,
+		"Growth did not preserve epoll event");
+	TEST_ASSERT_EQUAL(rte_intr_efds_index_get(intr_handle, 2), -1,
+		"Growth did not initialize new eventfd entry");
+	TEST_ASSERT_EQUAL(rte_atomic_load_explicit(&rte_intr_elist_index_get(intr_handle, 2)->status,
+			rte_memory_order_relaxed), RTE_EPOLL_INVALID,
+		"Growth did not initialize new epoll event");
+	TEST_ASSERT_SUCCESS(rte_intr_efds_index_set(intr_handle, 1, -1),
+		"Failed to clear eventfd entry");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_interrupt_eventfd_counts(struct rte_intr_handle *intr_handle)
+{
+	TEST_ASSERT_SUCCESS(rte_intr_event_list_update(intr_handle, 4),
+		"Failed to resize interrupt event list");
+	TEST_ASSERT_SUCCESS(rte_intr_efds_index_set(intr_handle, 3, 123),
+		"Failed to set eventfd entry");
+	TEST_ASSERT_SUCCESS(rte_intr_nb_efd_set(intr_handle, 4),
+		"Failed to set eventfd count at capacity");
+	TEST_ASSERT_EQUAL(rte_intr_nb_efd_set(intr_handle, 5), -EINVAL,
+		"Accepted eventfd count above capacity");
+	TEST_ASSERT_EQUAL(rte_intr_nb_efd_set(intr_handle, -1), -EINVAL,
+		"Accepted negative eventfd count");
+	TEST_ASSERT_EQUAL(rte_intr_nb_efd_get(intr_handle), 4,
+		"Rejected eventfd count changed the handle");
+	TEST_ASSERT_EQUAL(rte_intr_event_list_update(intr_handle, 3), -EINVAL,
+		"Accepted resize below eventfd count");
+	TEST_ASSERT_EQUAL(rte_intr_event_list_update(intr_handle, 0), -EINVAL,
+		"Accepted zero event list size");
+	TEST_ASSERT_EQUAL(rte_intr_event_list_update(intr_handle, -1), -EINVAL,
+		"Accepted negative event list size");
+	TEST_ASSERT_EQUAL(rte_intr_event_list_update(intr_handle, UINT16_MAX + 1), -EINVAL,
+		"Accepted event list size above the interrupt count limit");
+	TEST_ASSERT_EQUAL(rte_intr_nb_intr_get(intr_handle), 4,
+		"Rejected resize changed the interrupt count");
+	TEST_ASSERT_EQUAL(rte_intr_efds_index_get(intr_handle, 3), 123,
+		"Rejected resize changed the eventfd list");
+	TEST_ASSERT_SUCCESS(rte_intr_event_list_update(intr_handle, 4),
+		"Failed to resize to the eventfd count");
+	TEST_ASSERT_SUCCESS(rte_intr_nb_efd_set(intr_handle, 0),
+		"Failed to clear eventfd count");
+	TEST_ASSERT_SUCCESS(rte_intr_max_intr_set(intr_handle, 3),
+		"Failed to set requested interrupt count");
+	TEST_ASSERT_EQUAL(rte_intr_event_list_update(intr_handle, 2), -EINVAL,
+		"Accepted resize below requested interrupt count");
+	TEST_ASSERT_EQUAL(rte_intr_nb_intr_get(intr_handle), 4,
+		"Rejected resize changed the interrupt count");
+	TEST_ASSERT_SUCCESS(rte_intr_max_intr_set(intr_handle, 0),
+		"Failed to clear requested interrupt count");
+	TEST_ASSERT_SUCCESS(rte_intr_event_list_update(intr_handle, 2),
+		"Failed to shrink after clearing eventfd count");
+
+	return TEST_SUCCESS;
+}
+
 /**
  * Main function of testing interrupt.
  */
@@ -505,6 +579,7 @@ static int
 test_interrupt(void)
 {
 	int ret = -1;
+	struct rte_intr_handle *shared_intr_handle;
 	struct rte_intr_handle *test_intr_handle;
 
 	if (RTE_EXEC_ENV_IS_WINDOWS || RTE_EXEC_ENV_IS_FREEBSD)
@@ -515,6 +590,20 @@ test_interrupt(void)
 		goto out;
 	}
 
+	if (test_interrupt_event_list_resize(intr_handles[TEST_INTERRUPT_HANDLE_INVALID]) != 0)
+		goto out;
+	shared_intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
+	if (shared_intr_handle == NULL)
+		goto out;
+	ret = test_interrupt_event_list_resize(shared_intr_handle);
+	rte_intr_instance_free(shared_intr_handle);
+	if (ret != 0)
+		goto out;
+	ret = -1;
+
+	if (test_interrupt_eventfd_counts(intr_handles[TEST_INTERRUPT_HANDLE_INVALID]) != 0)
+		goto out;
+
 	printf("Check unknown valid interrupt full path\n");
 	if (test_interrupt_full_path_check(TEST_INTERRUPT_HANDLE_VALID) < 0) {
 		printf("failure occurred during checking unknown valid "
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 3b46e90c4c3..31a9d48d7c5 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -113,8 +113,10 @@ int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 
 	CHECK_VALID_INTR_HANDLE(intr_handle);
 
-	if (size == 0) {
-		EAL_LOG(DEBUG, "Size can't be zero");
+	if (size <= 0 || size > UINT16_MAX || (uint32_t)size < intr_handle->nb_efd ||
+			(uint32_t)size < intr_handle->max_intr) {
+		EAL_LOG(DEBUG, "Invalid event list size %d, eventfd count %u, max interrupts %u",
+			size, intr_handle->nb_efd, intr_handle->max_intr);
 		rte_errno = EINVAL;
 		goto fail;
 	}
@@ -154,9 +156,9 @@ int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 		free(intr_handle->efds);
 		free(intr_handle->elist);
 	}
-	intr_handle->elist = tmp_elist;
-
 	intr_handle->efds = tmp_efds;
+	intr_handle->elist = tmp_elist;
+
 	intr_handle->nb_intr = size;
 
 	return 0;
@@ -317,6 +319,13 @@ int rte_intr_nb_efd_set(struct rte_intr_handle *intr_handle, int nb_efd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
 
+	if (nb_efd < 0 || nb_efd > intr_handle->nb_intr) {
+		EAL_LOG(DEBUG, "Invalid eventfd count %d, interrupt count %d",
+			nb_efd, intr_handle->nb_intr);
+		rte_errno = EINVAL;
+		goto fail;
+	}
+
 	intr_handle->nb_efd = nb_efd;
 
 	return 0;
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index 85b5546dee1..904a10495ca 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -521,7 +521,7 @@ rte_intr_max_intr_get(const struct rte_intr_handle *intr_handle);
  * @param intr_handle
  *  pointer to the interrupt handle.
  * @param nb_efd
- *  Available event fd
+ *  Number of available event fds, from zero to the interrupt vector count.
  *
  * @return
  *  - On success, zero.
@@ -768,7 +768,8 @@ rte_intr_vec_list_free(struct rte_intr_handle *intr_handle);
  * @param intr_handle
  *  pointer to the interrupt handle.
  * @param size
- *  efds and elist array size.
+ *  efds and elist array size. Must be positive, no greater than UINT16_MAX,
+ *  and at least the number of available event fds and requested interrupts.
  *
  * @return
  *  - On success, zero
-- 
2.52.0

