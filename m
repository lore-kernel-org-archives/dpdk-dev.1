Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6CCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 09:51:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C0D6400D7;
	Fri, 16 Oct 2026 11:51:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DCB11400D5
 for <dev@dpdk.org>; Fri, 16 Oct 2026 11:51:37 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G3oAA5288891 for <dev@dpdk.org>; Fri, 16 Oct 2026 02:51:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=+C+0VWDyQfWPCpVFJPbBb35
 v4SqXPnMlXXxSij7ceCw=; b=faKUi8eAwHqsVpP6NOl/K+FlfXDC8jSrB81u4WV
 ThYHUa9jC2aEfRiDg+zkTi7Qd3N7T089Xc1CgsR4kFM1Uf1HWb0pXlgYxLPNmwFP
 YHrdmfvLvAjwA1keId72ntefUOfj8wV/LeJDoWyqYXwt6gtqn/S7ZrDbcAJdGqJg
 TS3gU5XJPRmTEt4YFBgrAU+yWW1xWL2WmfQNZ0r4XwhhXPuYCtZ4NEyKvLMMoZvn
 izGAG3TeZJ9aPw9wIaHJvRQ/rEv2QPFdXsCwpgOl6wKaJQLDINRmmu56xxeZl8cS
 FbNkUL1xxeV9DF/3rxKwrsRIKFf1rQNE+5J7SZ7f3TJfH8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hbcc3s9n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 16 Oct 2026 02:51:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 16 Oct 2026 02:51:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 16 Oct 2026 02:51:36 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.161.103])
 by maili.marvell.com (Postfix) with ESMTP id 7A73F3F7096;
 Fri, 16 Oct 2026 02:51:34 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH] event/cnxk: fix TIM HWWQE handling and chunk alignment
Date: Fri, 16 Oct 2026 15:21:31 +0530
Message-ID: <20261016095132.73347-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzOCBTYWx0ZWRfX3EaZiLTiFgPy
 oPxVbyozFly6ZhHHpICkHKGIrvHO5QZtI8sc1bD+bpkjTQjF7Ffh0+p2zdUEnVnv0UyJi9kDYxj
 OAl2h8YxukGY8fBnS5WmV3Etpy8uI34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzOCBTYWx0ZWRfX772oy/Ymj9Kh
 a/RaKgrvT+1vZ+2dtBb/pKDCAqLFuHcYgIHswSUCrSSbShH8UFxL10pCirGIQ/CR2yvyLC5EEJk
 KHSzTDezlxmg5YUEPG1TgZb+6g78Tlpu9+LZGwXyrgvHGTh+zY7Kcqpl+k+TUZPsdfDJMU9IhTJ
 KTzJi6+iYKrOi+qO9dJ4RXq2XJ73xIwYtisRhNg0FnIj6Gg2fEbmFQZ/yDYyjumiM/l/Tb/jDBL
 jfjuUYz4+M5i9Fdb51JRqLR+VdL5/ikV5HwzOtMMxv9nqTrnpycb7JlGSiYDr90Phi4OrIzGAO2
 kBkHjHqHt6/w4vX+ZoH65dzUfviAa+l0f8pDZ10/HOizMG5fpAjdNo9nThJhpcJdY4RkJmStMwW
 ePl8QI4uGSZjVY0Oj54zM/HZt8lKZSmeAOScr1+UEmyL/g0itBh+/WgG+2z90Sz8RV8dRvyyg+1
 MfS7h/u5QTqiwbE9X+g==
X-Authority-Analysis: v=2.4 cv=O/+sLx9W c=1 sm=1 tr=0 ts=6ad1f3a8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=qBbE4_ttCYJanBOFhhcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EWx-6i_xuwyPayXyyy8BJ2I7BjB4sMl9
X-Proofpoint-GUID: EWx-6i_xuwyPayXyyy8BJ2I7BjB4sMl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Use a single predicate for HWWQE enable, fast-path selection and chunk
pool sizing so a TIM_HWWQE_VER_0 device is not run with HWWQE paths
without being configured. Fix the burst response mapping in
cnxk_tim_add_entry_tmo_hwwqe() to match the single timer path.

With tim_disable_npa, the generic ring ops only align objects to
RTE_MEMPOOL_ALIGN, which does not give the 256B alignment CN20K needs.
Populate the pool from a 256B aligned memzone with the trailer padded
so the object stride is a multiple of 256B, and keep the chunk slot
count within CNXK_TIM_MAX_CHUNK_SLOTS after rounding up.

Fixes: 19861e9eac8d ("event/cnxk: align CN20K TIM chunk buffers")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/event/cnxk/cnxk_tim_evdev.c  | 100 ++++++++++++++++++++++-----
 drivers/event/cnxk/cnxk_tim_worker.h |  41 +++++------
 2 files changed, 103 insertions(+), 38 deletions(-)

diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 44acd4ef5170..41f1d20cec5a 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -12,14 +12,56 @@
 static struct event_timer_adapter_ops cnxk_tim_ops;
 static cnxk_sso_set_priv_mem_t sso_set_priv_mem_fn;
 
+static void
+cnxk_tim_chnk_pool_mem_free(struct rte_mempool_memhdr *memhdr, void *opaque)
+{
+	RTE_SET_USED(memhdr);
+	rte_free(opaque);
+}
+
+/* CN20K needs 256B aligned chunk buffers (cn20k-tim 14.2), other models use ROC_ALIGN. */
+static inline size_t
+cnxk_tim_chunk_buf_align(void)
+{
+	return roc_model_is_cn20k() ? CNXK_TIM_CN20K_CHUNK_BUF_ALIGN : ROC_ALIGN;
+}
+
+/* Populate the pool from a single aligned block, like the SSO XAQ pool. */
+static int
+cnxk_tim_chnk_pool_populate_aligned(struct rte_mempool *mp, size_t align)
+{
+	size_t stride, len;
+	void *mem;
+	int rc;
+
+	stride = (size_t)mp->header_size + mp->elt_size + mp->trailer_size;
+	len = stride * mp->size;
+
+	mem = rte_zmalloc_socket("cnxk_tim_chunks", len, align, mp->socket_id);
+	if (mem == NULL)
+		return -ENOMEM;
+
+	rc = rte_mempool_populate_iova(mp, mem, rte_malloc_virt2iova(mem), len,
+				       cnxk_tim_chnk_pool_mem_free, mem);
+	if (rc <= 0) {
+		/* The pool only takes ownership of the memory when objects were added. */
+		rte_free(mem);
+		return rc < 0 ? rc : -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int
 cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 			  struct rte_event_timer_adapter_conf *rcfg)
 {
 	unsigned int mp_flags = 0;
+	struct rte_mempool *mp;
 	unsigned int cache_sz;
-	const char *ops;
 	char pool_name[25];
+	size_t align, sz;
+	const char *ops;
 	int rc;
 
 	/* Create chunk pool. */
@@ -29,6 +71,10 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 		tim_ring->prod_type_sp = true;
 	}
 
+	/* One aligned block backs the pool, so objects need not be page contiguous. */
+	if (tim_ring->disable_npa)
+		mp_flags |= RTE_MEMPOOL_F_NO_IOVA_CONTIG;
+
 	snprintf(pool_name, sizeof(pool_name), "cnxk_tim_chunk_pool%d",
 		 tim_ring->ring_id);
 
@@ -43,10 +89,12 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 		return -ENOMEM;
 	}
 
-	/* cn20k needs 256B-aligned chunk buffers (cn20k-tim 14.2). */
-	if (roc_model_is_cn20k())
-		tim_ring->chunk_pool->header_size = RTE_ALIGN_CEIL(
-			tim_ring->chunk_pool->header_size, CNXK_TIM_CN20K_CHUNK_BUF_ALIGN);
+	/* Align the header and pad the trailer so every chunk buffer is aligned. */
+	mp = tim_ring->chunk_pool;
+	align = cnxk_tim_chunk_buf_align();
+	mp->header_size = RTE_ALIGN_CEIL(mp->header_size, align);
+	sz = (size_t)mp->header_size + mp->elt_size + mp->trailer_size;
+	mp->trailer_size += RTE_ALIGN_CEIL(sz, align) - sz;
 
 	if (!tim_ring->disable_npa)
 		ops = rte_mbuf_platform_mempool_ops();
@@ -61,7 +109,11 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 		goto free;
 	}
 
-	rc = rte_mempool_populate_default(tim_ring->chunk_pool);
+	if (tim_ring->disable_npa) {
+		rc = cnxk_tim_chnk_pool_populate_aligned(tim_ring->chunk_pool, align);
+	} else {
+		rc = rte_mempool_populate_default(tim_ring->chunk_pool);
+	}
 	if (rc < 0) {
 		plt_err("Unable to populate chunkpool.");
 		goto free;
@@ -81,6 +133,12 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 	return rc;
 }
 
+static inline bool
+cnxk_tim_hwwqe_enabled(const struct cnxk_tim_evdev *dev)
+{
+	return dev->tim.feat.hwwqe && dev->tim.feat.hwwqe_ver != TIM_HWWQE_VER_0;
+}
+
 static int
 cnxk_tim_enable_hwwqe(struct cnxk_tim_evdev *dev, struct cnxk_tim_ring *tim_ring)
 {
@@ -120,7 +178,7 @@ cnxk_tim_set_fp_ops(struct cnxk_tim_ring *tim_ring)
 	if (dev == NULL)
 		return;
 
-	if (dev->tim.feat.hwwqe) {
+	if (cnxk_tim_hwwqe_enabled(dev)) {
 		cnxk_tim_ops.arm_burst = cnxk_tim_arm_burst_hwwqe;
 		cnxk_tim_ops.arm_tmo_tick_burst = cnxk_tim_arm_tmo_burst_hwwqe;
 		cnxk_tim_ops.cancel_burst = cnxk_tim_timer_cancel_burst_hwwqe;
@@ -243,24 +301,30 @@ cnxk_tim_ring_create(struct rte_event_timer_adapter *adptr)
 		struct cnxk_tim_ctl *ring_ctl = &dev->ring_ctl_data[i];
 
 		if (ring_ctl->ring == tim_ring->ring_id) {
-			tim_ring->chunk_sz =
-				ring_ctl->chunk_slots ?
-					((uint32_t)(ring_ctl->chunk_slots + 1) *
-					 CNXK_TIM_CHUNK_ALIGNMENT) :
-					      tim_ring->chunk_sz;
+			if (ring_ctl->chunk_slots >= CNXK_TIM_MIN_CHUNK_SLOTS &&
+			    ring_ctl->chunk_slots <= CNXK_TIM_MAX_CHUNK_SLOTS)
+				tim_ring->chunk_sz = ((uint32_t)ring_ctl->chunk_slots + 1) *
+						     CNXK_TIM_CHUNK_ALIGNMENT;
 			tim_ring->enable_stats = ring_ctl->enable_stats;
 			tim_ring->disable_npa = ring_ctl->disable_npa;
 		}
 	}
 
-	if (roc_model_is_cn20k())
+	if (roc_model_is_cn20k()) {
 		tim_ring->chunk_sz =
 			RTE_ALIGN_CEIL(tim_ring->chunk_sz, CNXK_TIM_CN20K_CHUNK_BUF_ALIGN);
+		/* Clamp to the largest 256B aligned size within the slot limit. */
+		if (CNXK_TIM_NB_CHUNK_SLOTS(tim_ring->chunk_sz) > CNXK_TIM_MAX_CHUNK_SLOTS)
+			tim_ring->chunk_sz = RTE_ALIGN_FLOOR(
+				(CNXK_TIM_MAX_CHUNK_SLOTS + 1) * CNXK_TIM_CHUNK_ALIGNMENT,
+				CNXK_TIM_CN20K_CHUNK_BUF_ALIGN);
+	}
 
-	if (!dev->tim.feat.hwwqe && tim_ring->disable_npa) {
-		tim_ring->nb_chunks =
-			tim_ring->nb_timers /
-			CNXK_TIM_NB_CHUNK_SLOTS(tim_ring->chunk_sz);
+	if (!cnxk_tim_hwwqe_enabled(dev) && tim_ring->disable_npa) {
+		/* Each bucket needs at least one chunk. */
+		tim_ring->nb_chunks = RTE_MAX(RTE_ALIGN_MUL_CEIL(tim_ring->nb_timers,
+				CNXK_TIM_NB_CHUNK_SLOTS(tim_ring->chunk_sz)) /
+				CNXK_TIM_NB_CHUNK_SLOTS(tim_ring->chunk_sz), 1UL);
 		tim_ring->nb_chunks = tim_ring->nb_chunks * tim_ring->nb_bkts;
 	} else {
 		tim_ring->disable_npa = 0;
@@ -289,7 +353,7 @@ cnxk_tim_ring_create(struct rte_event_timer_adapter *adptr)
 		goto tim_chnk_free;
 	}
 
-	if (dev->tim.feat.hwwqe && dev->tim.feat.hwwqe_ver != TIM_HWWQE_VER_0) {
+	if (cnxk_tim_hwwqe_enabled(dev)) {
 		rc = cnxk_tim_enable_hwwqe(dev, tim_ring);
 		if (rc < 0) {
 			plt_err("Failed to enable hwwqe");
diff --git a/drivers/event/cnxk/cnxk_tim_worker.h b/drivers/event/cnxk/cnxk_tim_worker.h
index 9e33ff58d683..e031e83dabec 100644
--- a/drivers/event/cnxk/cnxk_tim_worker.h
+++ b/drivers/event/cnxk/cnxk_tim_worker.h
@@ -692,31 +692,31 @@ cnxk_tim_add_entry_tmo_hwwqe(struct cnxk_tim_ring *const tim_ring,
 
 		done += CNXK_TIM_ENT_PER_LMT;
 		rsp &= 0xF;
-		if (rsp != 0x1) {
+		if (rsp != 0x1 && rsp != 0x5) {
 			switch (rsp) {
 			case 0x3:
 				for (j = 0; j < CNXK_TIM_ENT_PER_LMT; j++)
 					tim[(i * CNXK_TIM_ENT_PER_LMT) + j]->state =
-						RTE_EVENT_TIMER_ERROR_TOOEARLY;
+						RTE_EVENT_TIMER_ERROR_TOOLATE;
 				done -= CNXK_TIM_ENT_PER_LMT;
 				break;
 			case 0x4:
 				for (j = 0; j < CNXK_TIM_ENT_PER_LMT; j++)
 					tim[(i * CNXK_TIM_ENT_PER_LMT) + j]->state =
-						RTE_EVENT_TIMER_ERROR_TOOLATE;
+						RTE_EVENT_TIMER_ERROR_TOOEARLY;
 				done -= CNXK_TIM_ENT_PER_LMT;
 				break;
 			case 0x2:
 			default:
 				for (j = 0; j < CNXK_TIM_ENT_PER_LMT; j++) {
-					if ((rte_atomic_load_explicit(
-						     (uint64_t __rte_atomic
-							      *)&tim[(i * CNXK_TIM_ENT_PER_LMT) + j]
-							     ->impl_opaque[0],
-						     rte_memory_order_relaxed) &
-					     0xF0) != 0x10) {
-						tim[(i * CNXK_TIM_ENT_PER_LMT) + j]->state =
-							RTE_EVENT_TIMER_ERROR;
+					struct rte_event_timer *t =
+						tim[(i * CNXK_TIM_ENT_PER_LMT) + j];
+					uint64_t res = rte_atomic_load_explicit(
+						(uint64_t __rte_atomic *)&t->impl_opaque[0],
+						rte_memory_order_relaxed) & 0xF0;
+
+					if (res != 0x10 && res != 0x50) {
+						t->state = RTE_EVENT_TIMER_ERROR;
 						done--;
 					}
 				}
@@ -749,27 +749,28 @@ cnxk_tim_add_entry_tmo_hwwqe(struct cnxk_tim_ring *const tim_ring,
 
 		done += (nb_timers - cnt);
 		rsp &= 0xF;
-		if (rsp != 0x1) {
+		if (rsp != 0x1 && rsp != 0x5) {
 			switch (rsp) {
 			case 0x3:
 				for (j = 0; j < nb_timers - cnt; j++)
-					tim[cnt + j]->state = RTE_EVENT_TIMER_ERROR_TOOEARLY;
+					tim[cnt + j]->state = RTE_EVENT_TIMER_ERROR_TOOLATE;
 				done -= (nb_timers - cnt);
 				break;
 			case 0x4:
 				for (j = 0; j < nb_timers - cnt; j++)
-					tim[cnt + j]->state = RTE_EVENT_TIMER_ERROR_TOOLATE;
+					tim[cnt + j]->state = RTE_EVENT_TIMER_ERROR_TOOEARLY;
 				done -= (nb_timers - cnt);
 				break;
 			case 0x2:
 			default:
 				for (j = 0; j < nb_timers - cnt; j++) {
-					if ((rte_atomic_load_explicit(
-						     (uint64_t __rte_atomic *)&tim[cnt + j]
-							     ->impl_opaque[0],
-						     rte_memory_order_relaxed) &
-					     0xF0) != 0x10) {
-						tim[cnt + j]->state = RTE_EVENT_TIMER_ERROR;
+					struct rte_event_timer *t = tim[cnt + j];
+					uint64_t res = rte_atomic_load_explicit(
+						(uint64_t __rte_atomic *)&t->impl_opaque[0],
+						rte_memory_order_relaxed) & 0xF0;
+
+					if (res != 0x10 && res != 0x50) {
+						t->state = RTE_EVENT_TIMER_ERROR;
 						done--;
 					}
 				}
-- 
2.50.1 (Apple Git-155)

