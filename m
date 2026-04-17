Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8BEF99C6A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 21:24:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0627140657;
	Fri, 17 Apr 2026 23:24:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E48A84060A
 for <dev@dpdk.org>; Fri, 17 Apr 2026 23:24:43 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fy7Dk6pSdzHnGdX;
 Sat, 18 Apr 2026 05:24:22 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id ADA7C40584;
 Sat, 18 Apr 2026 05:24:43 +0800 (CST)
Received: from localhost (10.220.239.45) by dubpeml500001.china.huawei.com
 (7.214.147.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 22:24:43 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <wathsala.vithanage@arm.com>
Subject: [PATCH v3 1/2] ring: make soring to finalize its own stage only
Date: Fri, 17 Apr 2026 22:23:57 +0100
Message-ID: <20260417212358.212692-2-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
References: <20260416191440.208066-1-konstantin.ananyev@huawei.com>
 <20260417212358.212692-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 dubpeml500001.china.huawei.com (7.214.147.241)
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

While finalize() is MT-safe and can be called from multiple places:
from 'acquire()' for next stage or even from consumer's 'dequeue(),
doing so usually creates extra un-necessary contention and might
slow-down ring operations, especially for the cases when we have
multiple threads doing acquire/release for some stage.
Things become worse when we have single producer/consumer and multiple
workers doing acquire/release for the same ring.
So instead of calling finalize() from different places, just make
release() for given stage to always try to perform it.

Accorging to the soring_stress_autotest, for multiple workers (8+)
it reduces number of cycles spent by 1.5x-2.0x factor.
For l3fwd-like workload it improves things by ~20%.
For small number of workers didn't observe any serious change.
As another benefit - it allows to simplify the code.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/soring.c | 52 ++++++++---------------------------------------
 1 file changed, 9 insertions(+), 43 deletions(-)

diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 3b90521bdb..fc7fc55a21 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -50,10 +50,8 @@
  * from current stage tail up to its head, check state[] and move stage tail
  * through elements that already are in SORING_ST_FINISH state.
  * Along with that, corresponding state[] values are reset to zero.
- * Note that 'finalize()' for given stage can be done from multiple places:
- * 'release()' for that stage or from 'acquire()' for next stage
- * even from consumer's 'dequeue()' - in case given stage is the last one.
- * So 'finalize()' has to be MT-safe and inside it we have to
+ * Note that 'finalize()' for given stage can be called from multiple threads
+ * in parallel, so 'finalize()' has to be MT-safe and inside it we have to
  * guarantee that only one thread will update state[] and stage's tail values.
  */
 
@@ -284,7 +282,7 @@ soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	uint32_t *available)
 {
 	enum rte_ring_sync_type st;
-	uint32_t entries, cons_head, cons_next, n, ns, reqn;
+	uint32_t entries, cons_head, cons_next, n, ns;
 
 	RTE_ASSERT(r != NULL && r->nb_stage > 0);
 	RTE_ASSERT(meta == NULL || r->meta != NULL);
@@ -293,22 +291,8 @@ soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	st = r->cons.ht.sync_type;
 
 	/* try to grab exactly @num elems first */
-	n = __rte_soring_move_cons_head(r, ns, num, RTE_RING_QUEUE_FIXED, st,
+	n = __rte_soring_move_cons_head(r, ns, num, behavior, st,
 			&cons_head, &cons_next, &entries);
-	if (n == 0) {
-		/* try to finalize some elems from previous stage */
-		n = __rte_soring_stage_finalize(&r->stage[ns].sht, ns,
-			r->state, r->mask, 2 * num);
-		entries += n;
-
-		/* repeat attempt to grab elems */
-		reqn = (behavior == RTE_RING_QUEUE_FIXED) ? num : 0;
-		if (entries >= reqn)
-			n = __rte_soring_move_cons_head(r, ns, num, behavior,
-				st, &cons_head, &cons_next, &entries);
-		else
-			n = 0;
-	}
 
 	/* we have some elems to consume */
 	if (n != 0) {
@@ -382,7 +366,7 @@ soring_acquire(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, enum rte_ring_queue_behavior behavior,
 	uint32_t *ftoken, uint32_t *available)
 {
-	uint32_t avail, head, idx, n, next, reqn;
+	uint32_t avail, head, idx, n, next;
 	struct soring_stage *pstg;
 	struct soring_stage_headtail *cons;
 
@@ -399,22 +383,7 @@ soring_acquire(struct rte_soring *r, void *objs, void *meta,
 
 		/* try to grab exactly @num elems */
 		n = __rte_soring_stage_move_head(cons, &pstg->ht, 0, num,
-			RTE_RING_QUEUE_FIXED, &head, &next, &avail);
-		if (n == 0) {
-			/* try to finalize some elems from previous stage */
-			n = __rte_soring_stage_finalize(&pstg->sht, stage - 1,
-				r->state, r->mask, 2 * num);
-			avail += n;
-
-			/* repeat attempt to grab elems */
-			reqn = (behavior == RTE_RING_QUEUE_FIXED) ? num : 0;
-			if (avail >= reqn)
-				n = __rte_soring_stage_move_head(cons,
-					&pstg->ht, 0, num, behavior, &head,
-					&next, &avail);
-			else
-				n = 0;
-		}
+			behavior, &head, &next, &avail);
 	}
 
 	if (n != 0) {
@@ -442,7 +411,7 @@ static __rte_always_inline void
 soring_release(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken)
 {
-	uint32_t idx, pos, tail;
+	uint32_t idx, pos;
 	struct soring_stage *stg;
 	union soring_state st;
 
@@ -479,11 +448,8 @@ soring_release(struct rte_soring *r, const void *objs,
 	rte_atomic_store_explicit(&r->state[idx].raw, st.raw,
 			rte_memory_order_relaxed);
 
-	/* try to do finalize(), if appropriate */
-	tail = rte_atomic_load_explicit(&stg->sht.tail.pos,
-			rte_memory_order_relaxed);
-	if (tail == pos)
-		__rte_soring_stage_finalize(&stg->sht, stage, r->state, r->mask,
+	/* try to do finalize(), if possible */
+	__rte_soring_stage_finalize(&stg->sht, stage, r->state, r->mask,
 				r->capacity);
 }
 
-- 
2.51.0

