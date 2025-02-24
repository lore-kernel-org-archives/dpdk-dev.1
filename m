Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96491C021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10F2E427B9;
	Mon, 24 Feb 2025 17:25:08 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1531E42707
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:24:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C2D9C203CDE4; Mon, 24 Feb 2025 08:24:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2D9C203CDE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740414289;
 bh=HE66JqDQRmFXa8cYs/I1PYsMY9nK6DXSXGPWIKvu1VY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qltL2gfSqRN+DeRamDD4iq5cD42GuW8A38nZVmoHbQCxdUOz7VOeBkx8HXTidIJiX
 RfXhokrDFB8ST9G5WacmBKzDp5maSkImNseaEYKyuvnwZM7uaEE7mDrmkvKuHa7+tA
 7IGVLr1IKBhoDl+MU2mJkGFsiuEyi0kBlaWizyAM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v6 08/10] test/test-pmd: declare lcore_count atomic
Date: Mon, 24 Feb 2025 08:24:23 -0800
Message-Id: <1740414265-12217-9-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Compiling with MSVC results in the error below:

app/test/test_ring_perf.c(197): error C7712: address argument to atomic
    operation must be a pointer to an atomic integer,
    'volatile unsigned int *' is not valid

The fix is to mark lcore_count as atomic.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_ring_perf.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 57cd04a124..9a2a481458 100644
--- a/app/test/test_ring_perf.c
+++ b/app/test/test_ring_perf.c
@@ -34,7 +34,7 @@ struct lcore_pair {
 	unsigned c1, c2;
 };
 
-static volatile unsigned lcore_count = 0;
+static RTE_ATOMIC(unsigned int) lcore_count;
 
 static void
 test_ring_print_test_string(unsigned int api_type, int esize,
@@ -193,13 +193,10 @@ enqueue_dequeue_bulk_helper(const unsigned int flag, struct thread_params *p)
 	unsigned int n_remaining;
 	const unsigned int bulk_n = bulk_sizes[p->ring_params->bulk_sizes_i];
 
-#ifdef RTE_USE_C11_MEM_MODEL
-	if (rte_atomic_fetch_add_explicit(&lcore_count, 1, rte_memory_order_relaxed) + 1 != 2)
-#else
-	if (__sync_add_and_fetch(&lcore_count, 1) != 2)
-#endif
-		while(lcore_count != 2)
+	if (rte_atomic_fetch_add_explicit(&lcore_count, 1, rte_memory_order_relaxed) + 1 != 2) {
+		while (rte_atomic_load_explicit(&lcore_count, rte_memory_order_relaxed) != 2)
 			rte_pause();
+	}
 
 	burst = test_ring_calloc(MAX_BURST, p->ring_params->elem_size);
 	if (burst == NULL)
@@ -272,7 +269,7 @@ run_on_core_pair(struct lcore_pair *cores,
 	struct ring_params *ring_params = param1->ring_params;
 
 	for (i = 0; i < RTE_DIM(bulk_sizes); i++) {
-		lcore_count = 0;
+		rte_atomic_store_explicit(&lcore_count, 0, rte_memory_order_relaxed);
 		ring_params->bulk_sizes_i = i;
 		if (cores->c1 == rte_get_main_lcore()) {
 			rte_eal_remote_launch(dequeue_bulk, param2, cores->c2);
-- 
2.48.1.vfs.0.0

