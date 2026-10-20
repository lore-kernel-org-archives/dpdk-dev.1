Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F608606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1402640270;
	Tue, 20 Oct 2026 10:49:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 70E6640144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:49:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 39BB320678;
 Tue, 20 Oct 2026 10:49:54 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 20 Oct 2026 10:49:51 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Ali Alnubani <alialnu@nvidia.com>
Subject: [PATCH] stack: fix pile GCC memcpy warnings
Date: Tue, 20 Oct 2026 08:49:44 +0000
Message-ID: <20261020084944.3188987-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2026 08:49:51.0231 (UTC)
 FILETIME=[F82CE0F0:01DD606F]
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On architectures where rte_memcpy() is defined as memcpy(),
GCC warns about source/destination overflow when copying more than the
source/destination size, even for code paths that are not taken in cases
where the sizes are smaller.

The relevant compiler warnings were disabled for GCC at the two
occurrences, and comments describing the reason were added.

NB:
It has not been investigated which GCC versions are affected.
GCC version 10 and up was chosen because that was what the previous
versions of x86 rte_memcpy() disabled sligthly similar warnings for.

PS:
The alternative was to obfuscate the code, but that would make the code
less readable, and might have unintended effects on architectures and
compilers not suffering by this issue.

Bugzilla ID: 2061
Fixes: ee0822a0ef41 ("stack: introduce pile")

The pile was introduce with this DPDK release, so no need to backport.

Reported-by: Ali Alnubani <alialnu@nvidia.com>
Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/stack/rte_stack_pile.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/stack/rte_stack_pile.h b/lib/stack/rte_stack_pile.h
index 819bd1d47a..69aa0cbf88 100644
--- a/lib/stack/rte_stack_pile.h
+++ b/lib/stack/rte_stack_pile.h
@@ -154,12 +154,25 @@ __rte_stack_pile_push(struct rte_stack *s,
 	 * Construct the bulk elements.
 	 * Copy bulks in reverse order, but ignore the object order within each bulk.
 	 */
+#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
+/*
+ * On architectures where rte_memcpy() is defined as memcpy(),
+ * although GCC knows that this code path is not taken when the source's size is smaller than
+ * RTE_STACK_PILE_BULK_SIZE, it still warns about memcpy() source overread.
+ * So we disable the compiler warning for this memcpy() instance.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#endif
 	tmp = (struct rte_stack_lf_elem *)bulk_first;
 	__rte_assume(n_bulk > 0);
 	for (i = 0; i < n_bulk; i++, tmp = tmp->next)
 		rte_memcpy(((struct rte_stack_pile_bulk_elem *)tmp)->objs,
 				&obj_table[(n_bulk - i - 1) * RTE_STACK_PILE_BULK_SIZE],
 				sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
+#pragma GCC diagnostic pop
+#endif
 
 	/* Push them to the bulk list. */
 	__rte_stack_pile_bulk_push_elems(&pile->bulk, bulk_first, bulk_last, n_bulk);
@@ -271,7 +284,20 @@ __rte_stack_pile_pop(struct rte_stack *s,
 
 bulk:
 	/* Fetch n_bulk * RTE_STACK_PILE_BULK_SIZE objects as bulk elements. */
+#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
+/*
+ * On architectures where rte_memcpy() is defined as memcpy(),
+ * although GCC knows that this code path is not taken when the destination's size is smaller than
+ * RTE_STACK_PILE_BULK_SIZE, it still warns about memcpy() destination overflow.
+ * So we disable the compiler warning for this memcpy() instance.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+#endif
 	bulk_first = __rte_stack_pile_bulk_pop_elems(&pile->bulk, n_bulk, obj_table, &bulk_last);
+#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
+#pragma GCC diagnostic pop
+#endif
 	if (unlikely(bulk_first == NULL)) {
 		/*
 		 * Not available.
-- 
2.43.0

