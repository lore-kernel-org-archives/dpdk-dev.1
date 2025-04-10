Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB78C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 18:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48BEF406B8;
	Thu, 10 Apr 2025 20:05:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9B88B406B7
 for <dev@dpdk.org>; Thu, 10 Apr 2025 20:05:51 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AI1dbn031051
 for <dev@dpdk.org>; Thu, 10 Apr 2025 11:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=RzGdYgzeqgwQyMg1OqQ+EmM
 eK0j6iEaS2gUvS5gWIPE=; b=hZ3JxwpmIiwzTT5zRGDbVILV5EcweUid0+y/A6v
 /Zq0fwijBtqNbZA9Uf5lUw0+qbg6tef11PtI6u1TorUObn3e7DMQynlNnUaCZ7cW
 nVeFTvIG32hi/CdMYwqKKhsQwwD5b4a5e0BuJsYfqpKBg6xWzqMTkgE6VcKnIrM0
 70C+TuFUn02G0XOeyhC8GKCrOpSPYiZwOsajZrnSv/prv6auL5XbC4RrDlvJ1vGf
 OL9llzJhV2cF0q99kdC9/ciORkYv8tt+cUOAEiNPsPGR6JC9mALK4c1FJ0CFniZf
 cWUBeiwWB0BW8agalJp+TUL3fqyRG4HMb9eC66TorQQ1mVQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45unnb3eu6-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 10 Apr 2025 11:05:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 10 Apr 2025 11:05:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 10 Apr 2025 11:05:50 -0700
Received: from MININT-80QBFE8.corp.innovium.com (unknown [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 5D3B43F7069;
 Thu, 10 Apr 2025 11:05:48 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH] event/cnxk: update timer arm routine
Date: Thu, 10 Apr 2025 23:35:44 +0530
Message-ID: <20250410180544.10765-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2_eCIblZv6B4l_GCu7l4esFSAds3fC3h
X-Authority-Analysis: v=2.4 cv=E57Npbdl c=1 sm=1 tr=0 ts=67f8087e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=sWKEhP36mHoA:10 a=M5GUcnROAAAA:8 a=1VQfcJWLNi9H73sON1wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2_eCIblZv6B4l_GCu7l4esFSAds3fC3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
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

Add additional HW state checks in timer arm routine to ensure
HW-SW synchronization.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/event/cnxk/cnxk_tim_worker.h | 140 ++++++++++++++-------------
 1 file changed, 73 insertions(+), 67 deletions(-)

diff --git a/drivers/event/cnxk/cnxk_tim_worker.h b/drivers/event/cnxk/cnxk_tim_worker.h
index 6a9ee2fd5284..09f84091abba 100644
--- a/drivers/event/cnxk/cnxk_tim_worker.h
+++ b/drivers/event/cnxk/cnxk_tim_worker.h
@@ -102,7 +102,7 @@ cnxk_tim_bkt_get_nent(uint64_t w1)
 static inline void
 cnxk_tim_bkt_inc_nent(struct cnxk_tim_bkt *bktp)
 {
-	rte_atomic_fetch_add_explicit(&bktp->nb_entry, 1, rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&bktp->nb_entry, 1, rte_memory_order_release);
 }
 
 static inline void
@@ -132,6 +132,33 @@ cnxk_tim_bkt_fast_mod(uint64_t n, uint64_t d, struct rte_reciprocal_u64 R)
 	return (n - (d * rte_reciprocal_divide_u64(n, &R)));
 }
 
+static inline uint64_t
+cnxk_tim_bkt_wait_hbt(struct cnxk_tim_bkt *bkt)
+{
+	uint64_t hbt_state;
+
+#ifdef RTE_ARCH_ARM64
+	asm volatile(PLT_CPU_FEATURE_PREAMBLE
+		     "		ldxr %[hbt], [%[w1]]	\n"
+		     "		tbz %[hbt], 33, .Ldne%=	\n"
+		     "		sevl			\n"
+		     ".Lrty%=:	wfe			\n"
+		     "		ldxr %[hbt], [%[w1]]	\n"
+		     "		tbnz %[hbt], 33, .Lrty%=\n"
+		     ".Ldne%=:				\n"
+		     : [hbt] "=&r"(hbt_state)
+		     : [w1] "r"((&bkt->w1))
+		     : "memory");
+#else
+	do {
+		hbt_state = rte_atomic_load_explicit(&bkt->w1,
+						     rte_memory_order_relaxed);
+	} while (hbt_state & BIT_ULL(33));
+#endif
+
+	return hbt_state;
+}
+
 static inline void
 cnxk_tim_format_event(const struct rte_event_timer *const tim, struct cnxk_tim_ent *const entry)
 {
@@ -265,31 +292,24 @@ cnxk_tim_add_entry_sp(struct cnxk_tim_ring *const tim_ring,
 	/* Bucket related checks. */
 	if (unlikely(cnxk_tim_bkt_get_hbt(lock_sema))) {
 		if (cnxk_tim_bkt_get_nent(lock_sema) != 0) {
-			uint64_t hbt_state;
-#ifdef RTE_ARCH_ARM64
-			asm volatile(PLT_CPU_FEATURE_PREAMBLE
-				     "		ldxr %[hbt], [%[w1]]	\n"
-				     "		tbz %[hbt], 33, .Ldne%=	\n"
-				     "		sevl			\n"
-				     ".Lrty%=:	wfe			\n"
-				     "		ldxr %[hbt], [%[w1]]	\n"
-				     "		tbnz %[hbt], 33, .Lrty%=\n"
-				     ".Ldne%=:				\n"
-				     : [hbt] "=&r"(hbt_state)
-				     : [w1] "r"((&bkt->w1))
-				     : "memory");
-#else
-			do {
-				hbt_state = rte_atomic_load_explicit(&bkt->w1,
-								     rte_memory_order_relaxed);
-			} while (hbt_state & BIT_ULL(33));
-#endif
+			uint64_t hbt_state = cnxk_tim_bkt_wait_hbt(bkt);
+
+			if (cnxk_tim_bkt_get_nent(lock_sema) != 0 &&
+			    cnxk_tim_bkt_get_nent(hbt_state) == 0) {
+				cnxk_tim_bkt_dec_lock(bkt);
+				goto __retry;
+			}
+
+			if (cnxk_tim_bkt_get_nent(hbt_state) != 0)
+				hbt_state |= BIT_ULL(34);
 
 			if (!(hbt_state & BIT_ULL(34)) ||
 			    !(hbt_state & GENMASK(31, 0))) {
 				cnxk_tim_bkt_dec_lock(bkt);
 				goto __retry;
 			}
+		} else {
+			cnxk_tim_bkt_wait_hbt(bkt);
 		}
 	}
 	/* Insert the work. */
@@ -321,9 +341,9 @@ cnxk_tim_add_entry_sp(struct cnxk_tim_ring *const tim_ring,
 
 	tim->impl_opaque[0] = (uintptr_t)chunk;
 	tim->impl_opaque[1] = (uintptr_t)bkt;
-	rte_atomic_store_explicit(&tim->state, RTE_EVENT_TIMER_ARMED, rte_memory_order_release);
+	tim->state = RTE_EVENT_TIMER_ARMED;
 	cnxk_tim_bkt_inc_nent(bkt);
-	cnxk_tim_bkt_dec_lock_relaxed(bkt);
+	cnxk_tim_bkt_dec_lock(bkt);
 
 	return 0;
 }
@@ -348,31 +368,24 @@ cnxk_tim_add_entry_mp(struct cnxk_tim_ring *const tim_ring,
 	/* Bucket related checks. */
 	if (unlikely(cnxk_tim_bkt_get_hbt(lock_sema))) {
 		if (cnxk_tim_bkt_get_nent(lock_sema) != 0) {
-			uint64_t hbt_state;
-#ifdef RTE_ARCH_ARM64
-			asm volatile(PLT_CPU_FEATURE_PREAMBLE
-				     "		ldxr %[hbt], [%[w1]]	\n"
-				     "		tbz %[hbt], 33, .Ldne%=	\n"
-				     "		sevl			\n"
-				     ".Lrty%=:	wfe			\n"
-				     "		ldxr %[hbt], [%[w1]]	\n"
-				     "		tbnz %[hbt], 33, .Lrty%=\n"
-				     ".Ldne%=:				\n"
-				     : [hbt] "=&r"(hbt_state)
-				     : [w1] "r"((&bkt->w1))
-				     : "memory");
-#else
-			do {
-				hbt_state = rte_atomic_load_explicit(&bkt->w1,
-								     rte_memory_order_relaxed);
-			} while (hbt_state & BIT_ULL(33));
-#endif
+			uint64_t hbt_state = cnxk_tim_bkt_wait_hbt(bkt);
+
+			if (cnxk_tim_bkt_get_nent(lock_sema) != 0 &&
+			    cnxk_tim_bkt_get_nent(hbt_state) == 0) {
+				cnxk_tim_bkt_dec_lock(bkt);
+				goto __retry;
+			}
+
+			if (cnxk_tim_bkt_get_nent(hbt_state) != 0)
+				hbt_state |= BIT_ULL(34);
 
 			if (!(hbt_state & BIT_ULL(34)) ||
 			    !(hbt_state & GENMASK(31, 0))) {
 				cnxk_tim_bkt_dec_lock(bkt);
 				goto __retry;
 			}
+		} else {
+			cnxk_tim_bkt_wait_hbt(bkt);
 		}
 	}
 
@@ -412,13 +425,13 @@ cnxk_tim_add_entry_mp(struct cnxk_tim_ring *const tim_ring,
 			cnxk_tim_bkt_dec_lock(bkt);
 			return -ENOMEM;
 		}
-		*chunk = *pent;
 		if (cnxk_tim_bkt_fetch_lock(lock_sema)) {
 			do {
 				lock_sema = rte_atomic_load_explicit(&bkt->w1,
 								     rte_memory_order_relaxed);
 			} while (cnxk_tim_bkt_fetch_lock(lock_sema) - 1);
 		}
+		cnxk_tim_bkt_inc_nent(bkt);
 		rte_atomic_thread_fence(rte_memory_order_acquire);
 		mirr_bkt->current_chunk = (uintptr_t)chunk;
 		rte_atomic_store_explicit(&bkt->chunk_remainder, tim_ring->nb_chunk_slots - 1,
@@ -426,14 +439,14 @@ cnxk_tim_add_entry_mp(struct cnxk_tim_ring *const tim_ring,
 	} else {
 		chunk = (struct cnxk_tim_ent *)mirr_bkt->current_chunk;
 		chunk += tim_ring->nb_chunk_slots - rem;
-		*chunk = *pent;
+		cnxk_tim_bkt_inc_nent(bkt);
 	}
 
+	*chunk = *pent;
 	tim->impl_opaque[0] = (uintptr_t)chunk;
 	tim->impl_opaque[1] = (uintptr_t)bkt;
-	rte_atomic_store_explicit(&tim->state, RTE_EVENT_TIMER_ARMED, rte_memory_order_release);
-	cnxk_tim_bkt_inc_nent(bkt);
-	cnxk_tim_bkt_dec_lock_relaxed(bkt);
+	tim->state = RTE_EVENT_TIMER_ARMED;
+	cnxk_tim_bkt_dec_lock(bkt);
 
 	return 0;
 }
@@ -480,31 +493,24 @@ cnxk_tim_add_entry_brst(struct cnxk_tim_ring *const tim_ring,
 	/* Bucket related checks. */
 	if (unlikely(cnxk_tim_bkt_get_hbt(lock_sema))) {
 		if (cnxk_tim_bkt_get_nent(lock_sema) != 0) {
-			uint64_t hbt_state;
-#ifdef RTE_ARCH_ARM64
-			asm volatile(PLT_CPU_FEATURE_PREAMBLE
-				     "		ldxr %[hbt], [%[w1]]	\n"
-				     "		tbz %[hbt], 33, .Ldne%=	\n"
-				     "		sevl			\n"
-				     ".Lrty%=:	wfe			\n"
-				     "		ldxr %[hbt], [%[w1]]	\n"
-				     "		tbnz %[hbt], 33, .Lrty%=\n"
-				     ".Ldne%=:				\n"
-				     : [hbt] "=&r"(hbt_state)
-				     : [w1] "r"((&bkt->w1))
-				     : "memory");
-#else
-			do {
-				hbt_state = rte_atomic_load_explicit(&bkt->w1,
-								     rte_memory_order_relaxed);
-			} while (hbt_state & BIT_ULL(33));
-#endif
+			uint64_t hbt_state = cnxk_tim_bkt_wait_hbt(bkt);
+
+			if (cnxk_tim_bkt_get_nent(lock_sema) != 0 &&
+			    cnxk_tim_bkt_get_nent(hbt_state) == 0) {
+				cnxk_tim_bkt_dec_lock(bkt);
+				goto __retry;
+			}
+
+			if (cnxk_tim_bkt_get_nent(hbt_state) != 0)
+				hbt_state |= BIT_ULL(34);
 
 			if (!(hbt_state & BIT_ULL(34)) ||
 			    !(hbt_state & GENMASK(31, 0))) {
 				cnxk_tim_bkt_dec_lock(bkt);
 				goto __retry;
 			}
+		} else {
+			cnxk_tim_bkt_wait_hbt(bkt);
 		}
 	}
 
@@ -553,7 +559,7 @@ cnxk_tim_add_entry_brst(struct cnxk_tim_ring *const tim_ring,
 			chunk = cnxk_tim_insert_chunk(bkt, mirr_bkt, tim_ring);
 
 		if (unlikely(chunk == NULL)) {
-			cnxk_tim_bkt_dec_lock_relaxed(bkt);
+			cnxk_tim_bkt_dec_lock(bkt);
 			rte_errno = ENOMEM;
 			tim[index]->state = RTE_EVENT_TIMER_ERROR;
 			return index;
@@ -575,7 +581,7 @@ cnxk_tim_add_entry_brst(struct cnxk_tim_ring *const tim_ring,
 		cnxk_tim_bkt_add_nent(bkt, nb_timers);
 	}
 
-	cnxk_tim_bkt_dec_lock_relaxed(bkt);
+	cnxk_tim_bkt_dec_lock(bkt);
 
 	return nb_timers;
 }
-- 
2.49.0

