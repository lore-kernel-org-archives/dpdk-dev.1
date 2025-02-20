Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A60C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3B0640689;
	Thu, 20 Feb 2025 22:31:24 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1A34440395
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:31:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C2E472069405; Thu, 20 Feb 2025 13:31:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2E472069405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740087073;
 bh=i+VwVkbdcjw5oZ6WP4cCGkYkY/ToiACDQEGhH/Sy6lc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pAnPmu0rRXdEeV3RVII/uHUzk5it3APl2DWNDTIuM7HvqKp+J42yIHHpuR/BwQVG0
 wBgSulJ08P7EdufKKvCzSjYhJ2C2qBB9dhrEmzawvP97JNaEb0BFlZ8jeBGeKR5atg
 To4/GcV0roHAqXFb88ej0Ajv0NKXoaScg0AMQQd0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 08/10] test-pmd: declare lcore_count atomic
Date: Thu, 20 Feb 2025 13:31:02 -0800
Message-Id: <1740087064-18680-9-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
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
---
 app/test/test_ring_perf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 57cd04a124..366e256323 100644
--- a/app/test/test_ring_perf.c
+++ b/app/test/test_ring_perf.c
@@ -34,7 +34,7 @@ struct lcore_pair {
 	unsigned c1, c2;
 };
 
-static volatile unsigned lcore_count = 0;
+static RTE_ATOMIC(unsigned int) lcore_count;
 
 static void
 test_ring_print_test_string(unsigned int api_type, int esize,
@@ -193,11 +193,7 @@ enqueue_dequeue_bulk_helper(const unsigned int flag, struct thread_params *p)
 	unsigned int n_remaining;
 	const unsigned int bulk_n = bulk_sizes[p->ring_params->bulk_sizes_i];
 
-#ifdef RTE_USE_C11_MEM_MODEL
 	if (rte_atomic_fetch_add_explicit(&lcore_count, 1, rte_memory_order_relaxed) + 1 != 2)
-#else
-	if (__sync_add_and_fetch(&lcore_count, 1) != 2)
-#endif
 		while(lcore_count != 2)
 			rte_pause();
 
-- 
2.48.1.vfs.0.0

