Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFACD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF54540672;
	Tue,  2 Jun 2026 19:16:01 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 66C2E40667
 for <dev@dpdk.org>; Tue,  2 Jun 2026 19:16:00 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so14200105c88.0
 for <dev@dpdk.org>; Tue, 02 Jun 2026 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780420559;
 x=1781025359; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPi+TQH7TJd/pPrAQmd6ke2JVL8jUiT/KFVpmfS9jYQ=;
 b=HPwDhJR86S7VIn/iGhBhpapFgL8ChKF4QcEM2LO8x+frWTTSI1bSCzNPs0J10mGMdf
 oecbMJPhfgETcfOU5x6JfXn7m7mw4RDqhji/0qkm5lGHY/nNBrWGSiSRJwvEPM+80p4V
 A46JzonaIlZCW5mBkXOe3x6L9a2vcvKxO/jdmO8b+rEqDWsUteW3a4cMNLW23rh3Z989
 KC1QFYOQI2dpl8bDZjp2kiyxhn9YUQgmRJARrM/HY0dTCJ7VWjWzgH8cx+0wKYlBTycF
 aS4T9QOP4BY5gOLi6OdgTByxjr8rJqIHV9AspMmUKKMlZJ2KYMX9SRYwU6Y5+kPK3FdO
 3bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780420559; x=1781025359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LPi+TQH7TJd/pPrAQmd6ke2JVL8jUiT/KFVpmfS9jYQ=;
 b=g2sdh17RGrtBY2q+DJe0FZL1lDLTtlsEvbTATi7wBWI2/DUUoq+5K6UpmnB8dEIUEt
 hkV4HUNoZAEa8MyxapYUMScHXVORTzXMhoy6TS52jB/Le6c/qYIVGsC3yalWndSOkEY2
 I3Is0k7fWj+F6hNwpVFGUjGLoQDd/+20jjPK107QUAk88gXO/DVQwJYcgdvOyZ0FLjP0
 0DGlqo7Q8RC0XBA3MJ1xdRYtQrm/BkxSR8Rh8kbsPaqyKjII8pnMF5h9WEcsiBD/FpUd
 8qyKYhPyYHTp5fhIUVt1hKTvw0NK1Nk91vn+hpDll2Pb/8Jg1qOeN5S5W82bzN7KDCPI
 EEIQ==
X-Gm-Message-State: AOJu0Yxc4r9FFiy5i5S54g8ugbYoVtP1ZCdru8rP+efx5PXYS+0OT4dp
 zSiSWEXyKyJflQ+AQyULq/RQFdpfwzZ9wnkC0hHl49IrLKGQQQtHRAuzwzZTiT1lw4c+Dv4iJRB
 PFIMo
X-Gm-Gg: Acq92OELdd/LMIB6Y5THvLyViW0kInoB0vqYky/QrbyNr9YsbNnwhN1l5FT1d35z0xS
 1RbmFYm5WtW5xQMxt69TTS5bmFAnsZ9PX6wsLndZUkG1JdT35VeHilElmYVLmfsWks+2XZlLw7P
 DGHTiHBdEPvgoa/OFoB9jVPc1upYdoC9D5Zt5Rf/fa3CRpdvss/ZkKHvAs6o+x4h353rs28B3gy
 34TtOlCi4fTZJpesrKMdpR0D1dlaZFDbIi0soJ2oIxlH7ff3qafMPiglUjYG9vFc772/LLQPzNe
 JfIu+CJXHG4LJDrjBzfppqWYct1lzABqkPP+UHhr2UPQm74XDAST8IHqe5lh6wEv7PZJuY2ovso
 TQek5TC/oOfwOJ5hMpR0S21BEzOcXMOGi0niUbzI4kwXfWtnxvJIzHpfxNaMhdxpVKO1X1UHO8c
 EwLgg29ZB+OK+oL9gJuCU224Jo3o9gdzKPLpn4dS2vGegQ8MZo7iKGRpZlz17COoXrmFy1GvCZ
X-Received: by 2002:a05:7022:1283:b0:12b:f881:d8f6 with SMTP id
 a92af1059eb24-137d424af0bmr7252389c88.29.1780420559384; 
 Tue, 02 Jun 2026 10:15:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm256095c88.9.2026.06.02.10.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:15:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 4/5] ring: drop unused arg to update_tail
Date: Tue,  2 Jun 2026 10:07:30 -0700
Message-ID: <20260602171552.686349-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602171552.686349-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The internal functions to update tail of ring no longer use
the enqueue flag argument.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/rte_ring_elem_pvt.h     |  8 +++-----
 lib/ring/rte_ring_hts_elem_pvt.h |  8 +++-----
 lib/ring/soring.c                | 10 +++++-----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index a7ff76931b..74b5fef771 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -301,10 +301,8 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
 
 static __rte_always_inline void
 __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
-		uint32_t new_val, uint32_t single, uint32_t enqueue)
+		       uint32_t new_val, uint32_t single)
 {
-	RTE_SET_USED(enqueue);
-
 	/*
 	 * If there are other enqueues/dequeues in progress that preceded us,
 	 * we need to wait for them to complete
@@ -448,7 +446,7 @@ __rte_ring_do_enqueue_elem(struct rte_ring *r, const void *obj_table,
 
 	__rte_ring_enqueue_elems(r, prod_head, obj_table, esize, n);
 
-	__rte_ring_update_tail(&r->prod, prod_head, prod_next, is_sp, 1);
+	__rte_ring_update_tail(&r->prod, prod_head, prod_next, is_sp);
 end:
 	if (free_space != NULL)
 		*free_space = free_entries - n;
@@ -495,7 +493,7 @@ __rte_ring_do_dequeue_elem(struct rte_ring *r, void *obj_table,
 
 	__rte_ring_dequeue_elems(r, cons_head, obj_table, esize, n);
 
-	__rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc, 0);
+	__rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc);
 
 end:
 	if (available != NULL)
diff --git a/lib/ring/rte_ring_hts_elem_pvt.h b/lib/ring/rte_ring_hts_elem_pvt.h
index a01089d15d..97ae240e2e 100644
--- a/lib/ring/rte_ring_hts_elem_pvt.h
+++ b/lib/ring/rte_ring_hts_elem_pvt.h
@@ -25,12 +25,10 @@
  */
 static __rte_always_inline void
 __rte_ring_hts_update_tail(struct rte_ring_hts_headtail *ht, uint32_t old_tail,
-	uint32_t num, uint32_t enqueue)
+			   uint32_t num)
 {
 	uint32_t tail;
 
-	RTE_SET_USED(enqueue);
-
 	tail = old_tail + num;
 
 	/*
@@ -217,7 +215,7 @@ __rte_ring_do_hts_enqueue_elem(struct rte_ring *r, const void *obj_table,
 
 	if (n != 0) {
 		__rte_ring_enqueue_elems(r, head, obj_table, esize, n);
-		__rte_ring_hts_update_tail(&r->hts_prod, head, n, 1);
+		__rte_ring_hts_update_tail(&r->hts_prod, head, n);
 	}
 
 	if (free_space != NULL)
@@ -258,7 +256,7 @@ __rte_ring_do_hts_dequeue_elem(struct rte_ring *r, void *obj_table,
 
 	if (n != 0) {
 		__rte_ring_dequeue_elems(r, head, obj_table, esize, n);
-		__rte_ring_hts_update_tail(&r->hts_cons, head, n, 0);
+		__rte_ring_hts_update_tail(&r->hts_cons, head, n);
 	}
 
 	if (available != NULL)
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 22f9c60e9c..45292c0f78 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -202,21 +202,21 @@ __rte_soring_move_cons_head(struct rte_soring *r, uint32_t stage, uint32_t num,
 
 static __rte_always_inline void
 __rte_soring_update_tail(struct __rte_ring_headtail *rht,
-	enum rte_ring_sync_type st, uint32_t head, uint32_t next, uint32_t enq)
+		 enum rte_ring_sync_type st, uint32_t head, uint32_t next)
 {
 	uint32_t n;
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
 	case RTE_RING_SYNC_MT:
-		__rte_ring_update_tail(&rht->ht, head, next, st, enq);
+		__rte_ring_update_tail(&rht->ht, head, next, st);
 		break;
 	case RTE_RING_SYNC_MT_RTS:
 		__rte_ring_rts_update_tail(&rht->rts);
 		break;
 	case RTE_RING_SYNC_MT_HTS:
 		n = next - head;
-		__rte_ring_hts_update_tail(&rht->hts, head, n, enq);
+		__rte_ring_hts_update_tail(&rht->hts, head, n);
 		break;
 	default:
 		/* unsupported mode, shouldn't be here */
@@ -295,7 +295,7 @@ soring_enqueue(struct rte_soring *r, const void *objs,
 			&prod_head, &prod_next, &nb_free);
 	if (n != 0) {
 		__enqueue_elems(r, objs, meta, prod_head, n);
-		__rte_soring_update_tail(&r->prod, st, prod_head, prod_next, 1);
+		__rte_soring_update_tail(&r->prod, st, prod_head, prod_next);
 	}
 
 	if (free_space != NULL)
@@ -401,7 +401,7 @@ soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	/* we have some elems to consume */
 	if (n != 0) {
 		__dequeue_elems(r, objs, meta, cons_head, n);
-		__rte_soring_update_tail(&r->cons, st, cons_head, cons_next, 0);
+		__rte_soring_update_tail(&r->cons, st, cons_head, cons_next);
 	}
 
 	if (available != NULL)
-- 
2.53.0

