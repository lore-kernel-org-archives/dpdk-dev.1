Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F9CC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A89C2427AF;
	Wed, 21 May 2025 13:15:12 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BBCB1427B3
 for <dev@dpdk.org>; Wed, 21 May 2025 13:15:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2TJw1wxkz6H6rV;
 Wed, 21 May 2025 19:12:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A9F51400F4;
 Wed, 21 May 2025 19:15:11 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:15:11 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: [PATCH v1 2/4] ring/soring: fix head-tail synchronization issue
Date: Wed, 21 May 2025 12:14:30 +0100
Message-ID: <20250521111432.207936-3-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100004.china.huawei.com (7.182.85.167) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

While running soring_stress_autotest on machine with Ampere Altra Max CPU,
observed the following synchronization issue:
...
TEST-CASE MT MT_DEQENQ-MT_STG1-PRCS
test_worker_prcs:_st_ring_dequeue_bulk: check_updt_elem(lc=11, num=42) failed at 11-th iter, offending object: 0x103df1480
...
EAL: PANIC in soring_verify_state():
line:382 from:acquire_state_update: soring=0x103c72c00, stage=0, idx=0x7fb8, expected={.stnum=0, .ftoken=0}, actual={.stnum=0x80000028, .ftoken=0x47fb8};

Few things to note:
- the problem is reproducible only for producer and consumer with
  RTE_RING_SYNC_MT sync type.
- the problem is reproducible only for RTE_USE_C11_MEM_MODEL enabled,
  i.e. when we use __rte_ring_headtail_move_head() implementation from
  rte_ring_c11_pvt.h.
- stage[nb_stage - 1].tail value becomes less then cons.head which should
  never happen.

While debugging it, I figured out that in some cases
__rte_ring_headtail_move_head() gets 'new' cons.head value while
corresponding tail value remains 'old'.
That causing the following calculation to return wrong (way too big value):
*entries = (capacity + stail - *old_head);
And then cons.head erroneously progress over not yet released elements.
Note that this issue happens only on the second iteration of
do { …; success=(CAS(&head); } while(success==0);
loop, i.e. – only when first CAS(&cons.head) attempt fails.

I believe that we are hitting the following race-condition scenario here:
1) soring_dequeue() calls _fianlize()
   It updates state[], then does store(stage.tail, release);
   Note that stage.tail itself can still contain the old value:
   release only guarantee that all *previous* stores will be visible.
2) soring_dequeue() calls move_cons_head() again.
   move_cons_head() updates 'cons.head', but there are still no
   *release* barriers   happened.
3) soring_dequeue() is called on different thread
   (in parallel with previous 2 operations).
     At first iteration move_cons_head() reads 'old' values for both
     'stage.tail' and 'cons.head'.
     Then CAS(cons.head) fails and returns a new value for it,
     while coming next load(stage.tail) still returns 'old' value
     (still no *release* happened).
     Then:
     *entries = (capacity + stail - *old_head);
     calculates wrong value.
In other words – in some rare cases (due to memory re-ordering),
thread can read 'new' 'cons.head' value, but 'old' value for 'stage.tail'.

The reason why that problem doesn’t exist with RTE_USE_C11_MEM_MODEL
disabled - move_head() implementation in rte_ring_generic_pvt.h uses
rte_atomic32_cmpset() – which generates a proper Acquire-Release barrier
for CAS operation.
While in rte_ring_c11_pvt.h – CAS operation is invoked with relaxed
memory-ordering.

To fix that issue for SORING - I introduced an extra release fence straight
after store(&tail)  operations.
As expected that helps – now  tail and it’s  counterpart head values
are always synchronized and all tests pass successfully.

One extra thing to note – I think the same problem potentially exists
even in conventional rte_ring with default (MP/MC case) behavior.
Though chances to hit it in practice are negligible.
At least, I wasn’t able to make it happen so far, even I tried really hard.

As alternative way to fix that issue – use Acquire-Release memory ordering
for CAS(&head) operation in move_head().
That would guarantee that if 'head' value is updated, then its
couterpart 'tail' latest value will also become visible.
Again, in that case conventional rte_ring will also be covered.

Fixes: b5458e2cc483 ("ring: introduce staged ordered ring")

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/soring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 21a1a27e24..7bcbf35516 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -123,6 +123,8 @@ __rte_soring_stage_finalize(struct soring_stage_headtail *sht, uint32_t stage,
 	rte_atomic_store_explicit(&sht->tail.raw, ot.raw,
 			rte_memory_order_release);
 
+	/* make sure that new tail value is visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
 	return i;
 }
 
@@ -217,6 +219,9 @@ __rte_soring_update_tail(struct __rte_ring_headtail *rht,
 		/* unsupported mode, shouldn't be here */
 		RTE_ASSERT(0);
 	}
+
+	/* make sure that new tail value is visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
 }
 
 static __rte_always_inline uint32_t
-- 
2.43.0

