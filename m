Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039FCCA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FE7A40A77;
	Fri,  9 Oct 2026 01:37:07 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8CEA840608
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:05 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8819033dbadso2468278b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502625;
 x=1792107425; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gHYm6SRpbkyg+BuqflWy/kMxqFPpjGaCN3GZxfUGzLU=;
 b=AVG76ROoiFG4xVG0TW65kmpSPrYu0EJ/Lh0iS9xN6fZsC4i6R9aFC4tdfYEbNT1nEK
 blOonprxshBD9LCZEAnaci1BUBjs5G2bUHp1U9HQLAGsDYNAhozUqXHNXwMwgKgP+22u
 G7kxE3leid7EsaUIVk0JBQbugj04qTfvlwacVWfpEvQ8UlebITGAWRaHxCtCd/QlqJvO
 zio7YORaFQtcw+JRQ5yQlGcwnDpsiTYm2zVs4Hb45XPXdenQqz8Su1AW7wq6t/l5aRYi
 7bxqh+k+JIiUFdXfQ5Mel8+catqhyfuNCeyX/mKPomggNIweKMubX7xOFChb+Xa+NjdR
 zP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502625; x=1792107425;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gHYm6SRpbkyg+BuqflWy/kMxqFPpjGaCN3GZxfUGzLU=;
 b=wegSsDIaEexwZfcfvX5+IpImCOi8c7h1u0iW/wUClED2vxgw1w/hOIaA7HfBYgc3PF
 BoTShlgN5Al1zrdMQwiTF8mVggo7+aiuMC5E9CYki9TrwtKRzslslPYjG4/cBZN1ek5O
 UGZ4iVpGpV/JHOofYCupQ+bQupkZMCzSEGUi5OUPvlQ6r964rXGzG+uHoCnwhan3BVnt
 A1V6uzP+7OXHgIthyJg7JbZckGKuoSJIzJcyn2nj3oPK4H01dupRZmR6JtO4fL8C3PJT
 PdUU+foA7dklS6O5mqBFc322/ULtYTpKFmVkk2rdGVQdYHr/b5FDFlCupILSZTN1uhvj
 rIGQ==
X-Gm-Message-State: AFuF++n1Mf/HUSMuapy5DbyO6tb6suz0HNK5FnAGWyut5Z8RuY6FPzHr
 aPVRU7ReI7HEKbU/FpgZJIoILGfcOHvNCmB2cCo9miIT1kuDeRtezVdBDiOuJ/ZbTtUOKjznHsK
 XOwTFJ48=
X-Gm-Gg: AYBFou0CPjfpcB0XlEMgMqGFtvyVS1/FMHU0iqPkbPYGZlsvuhJt1MzmEVQmjPBP7qg
 zrxewGdMEwYKD0Z1FH9oggv9KxuIWNjAFiHW9anV/zgyacy1QgWoZf4QPQX6oYSFEvN6jXZ32bR
 OqYV5wer9AukHqDrBO8F2Jy4On7CLJmc+5ToksnYrfEJLUiz2fiGD44ZzUlJM8UYgxeUPq8pwTN
 6rT2F3AxxLxIIl4ILGQOAzi1AV+O0gWnLzI2JmWu3WIJE2cKwZDdZhJpQ8hseyTkVlKccM/Vesn
 zI3LyNDBSzWG6ZL+jQaX8exKHWpNeEAHfY5gjTeSAEw8a8A0FnreM6FwTj0x8baauectOxR19xD
 53SsQ5sUD9/ojDIJR/TPpxzKueSlNUBKZIQ6l9iVXahtQTMVpJKuGM7/1gxCdpaL8maJfxei9eF
 /G6W1FjOU9y8h3BG3KjwhFv7y7nY810h7EAgGUDWh6sXynKVDaBvhok91FQ2PjwanfDcTkjvBsJ
 /9IODCwq9estNO1xsRyZGEwhMxpEMcPxkRWuQ==
X-Received: by 2002:a05:6a00:178f:b0:882:8aea:fbc with SMTP id
 d2e1a72fcca58-897c663b759mr76936b3a.16.1791502624589; 
 Thu, 08 Oct 2026 16:37:04 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 11/29] stack: always use C11 memory model implementation
Date: Thu,  8 Oct 2026 16:35:04 -0700
Message-ID: <20261008233649.1260843-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The generic and C11 lock-free stack implementations differ only in
memory ordering. The generic version uses a full barrier where its
own comments state an acquire fence is sufficient, and seq_cst for
all length counter operations.

Only x86 and ThunderX still used the generic version. On x86 the
switch removes a locked add per CAS attempt in push and pop; TSO
provides the acquire semantics. On ThunderX the pop fence weakens
from dmb ish to dmb ishld and the push fence goes away.

Measured on a 32-core x86 machine, stack_perf_autotest, cycles per
operation, main versus the unified C11 version (n=9 each):

  Test              main          unified C11   delta
  single push/pop   46.62 +-0.30  33.41 +-0.10  -28%
  empty pop          1.47 +-0.01   0.98 +-0.01  -33%
  1 lcore, bulk 8    9.06 +-0.05   8.20 +-0.08  -10%
  1 lcore, bulk 32   6.09 +-0.02   6.15 +-0.03   +1%
  2 HT, bulk 8      42.05 +-0.31  39.24 +-0.52   -7%
  2 HT, bulk 32     11.92 +-0.13  11.89 +-0.10    0
  2 cores, bulk 8   78.90 +-0.60  72.96 +-1.11   -7%
  2 cores, bulk 32  20.74 +-1.56   7.70 +-0.13  -63%
  32 cores, bulk 8  6126 +-72     6121 +-89       0
  32 cores, bulk 32 1953.9 +-2.9  1984.6 +-13.3 +1.6%

The C11 version is faster because it no longer issues the lock
add of rte_smp_mb() on every CAS attempt.

Remove the generic version and use the C11 implementation everywhere.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/stack/meson.build            |   1 -
 lib/stack/rte_stack_lf.h         |   4 -
 lib/stack/rte_stack_lf_generic.h | 153 -------------------------------
 3 files changed, 158 deletions(-)
 delete mode 100644 lib/stack/rte_stack_lf_generic.h

diff --git a/lib/stack/meson.build b/lib/stack/meson.build
index 18177a742f..1fab46208f 100644
--- a/lib/stack/meson.build
+++ b/lib/stack/meson.build
@@ -7,7 +7,6 @@ headers = files('rte_stack.h')
 indirect_headers += files(
         'rte_stack_std.h',
         'rte_stack_lf.h',
-        'rte_stack_lf_generic.h',
         'rte_stack_lf_c11.h',
         'rte_stack_lf_stubs.h',
 )
diff --git a/lib/stack/rte_stack_lf.h b/lib/stack/rte_stack_lf.h
index f2b012cd0e..1bc6ee8f40 100644
--- a/lib/stack/rte_stack_lf.h
+++ b/lib/stack/rte_stack_lf.h
@@ -8,11 +8,7 @@
 #if !(defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64))
 #include "rte_stack_lf_stubs.h"
 #else
-#ifdef RTE_USE_C11_MEM_MODEL
 #include "rte_stack_lf_c11.h"
-#else
-#include "rte_stack_lf_generic.h"
-#endif
 
 /**
  * Indicates that RTE_STACK_F_LF is supported.
diff --git a/lib/stack/rte_stack_lf_generic.h b/lib/stack/rte_stack_lf_generic.h
deleted file mode 100644
index cc69e4d168..0000000000
--- a/lib/stack/rte_stack_lf_generic.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019 Intel Corporation
- */
-
-#ifndef _RTE_STACK_LF_GENERIC_H_
-#define _RTE_STACK_LF_GENERIC_H_
-
-#include <rte_branch_prediction.h>
-#include <rte_prefetch.h>
-
-static __rte_always_inline unsigned int
-__rte_stack_lf_count(struct rte_stack *s)
-{
-	/* stack_lf_push() and stack_lf_pop() do not update the list's contents
-	 * and stack_lf->len atomically, which can cause the list to appear
-	 * shorter than it actually is if this function is called while other
-	 * threads are modifying the list.
-	 *
-	 * However, given the inherently approximate nature of the get_count
-	 * callback -- even if the list and its size were updated atomically,
-	 * the size could change between when get_count executes and when the
-	 * value is returned to the caller -- this is acceptable.
-	 *
-	 * The stack_lf->len updates are placed such that the list may appear to
-	 * have fewer elements than it does, but will never appear to have more
-	 * elements. If the mempool is near-empty to the point that this is a
-	 * concern, the user should consider increasing the mempool size.
-	 */
-	/* NOTE: review for potential ordering optimization */
-	return rte_atomic_load_explicit(&s->stack_lf.used.len, rte_memory_order_seq_cst);
-}
-
-static __rte_always_inline void
-__rte_stack_lf_push_elems(struct rte_stack_lf_list *list,
-			  struct rte_stack_lf_elem *first,
-			  struct rte_stack_lf_elem *last,
-			  unsigned int num)
-{
-	struct rte_stack_lf_head old_head;
-	int success;
-
-	old_head = list->head;
-
-	do {
-		struct rte_stack_lf_head new_head;
-
-		/* An acquire fence (or stronger) is needed for weak memory
-		 * models to establish a synchronized-with relationship between
-		 * the list->head load and store-release operations (as part of
-		 * the rte_atomic128_cmp_exchange()).
-		 */
-		rte_smp_mb();
-
-		/* Swing the top pointer to the first element in the list and
-		 * make the last element point to the old top.
-		 */
-		new_head.top = first;
-		new_head.cnt = old_head.cnt + 1;
-
-		last->next = old_head.top;
-
-		/* old_head is updated on failure */
-		success = rte_atomic128_cmp_exchange(
-				(rte_int128_t *)&list->head,
-				(rte_int128_t *)&old_head,
-				(rte_int128_t *)&new_head,
-				1, rte_memory_order_release,
-				rte_memory_order_relaxed);
-	} while (success == 0);
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&list->len, num, rte_memory_order_seq_cst);
-}
-
-static __rte_always_inline struct rte_stack_lf_elem *
-__rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
-			 unsigned int num,
-			 void **obj_table,
-			 struct rte_stack_lf_elem **last)
-{
-	struct rte_stack_lf_head old_head;
-	int success = 0;
-
-	/* Reserve num elements, if available */
-	while (1) {
-		/* NOTE: review for potential ordering optimization */
-		uint64_t len = rte_atomic_load_explicit(&list->len, rte_memory_order_seq_cst);
-
-		/* Does the list contain enough elements? */
-		if (unlikely(len < num))
-			return NULL;
-
-		/* NOTE: review for potential ordering optimization */
-		if (rte_atomic_compare_exchange_strong_explicit(&list->len, &len, len - num,
-				rte_memory_order_seq_cst, rte_memory_order_seq_cst))
-			break;
-	}
-
-	old_head = list->head;
-
-	/* Pop num elements */
-	do {
-		struct rte_stack_lf_head new_head;
-		struct rte_stack_lf_elem *tmp;
-		unsigned int i;
-
-		/* An acquire fence (or stronger) is needed for weak memory
-		 * models to ensure the LF LIFO element reads are properly
-		 * ordered with respect to the head pointer read.
-		 */
-		rte_smp_mb();
-
-		rte_prefetch0(old_head.top);
-
-		tmp = old_head.top;
-
-		/* Traverse the list to find the new head. A next pointer will
-		 * either point to another element or NULL; if a thread
-		 * encounters a pointer that has already been popped, the CAS
-		 * will fail.
-		 */
-		for (i = 0; i < num && tmp != NULL; i++) {
-			rte_prefetch0(tmp->next);
-			if (obj_table)
-				obj_table[i] = tmp->data;
-			if (last)
-				*last = tmp;
-			tmp = tmp->next;
-		}
-
-		/* If NULL was encountered, the list was modified while
-		 * traversing it. Retry.
-		 */
-		if (i != num) {
-			old_head = list->head;
-			continue;
-		}
-
-		new_head.top = tmp;
-		new_head.cnt = old_head.cnt + 1;
-
-		/* old_head is updated on failure */
-		success = rte_atomic128_cmp_exchange(
-				(rte_int128_t *)&list->head,
-				(rte_int128_t *)&old_head,
-				(rte_int128_t *)&new_head,
-				1, rte_memory_order_release,
-				rte_memory_order_relaxed);
-	} while (success == 0);
-
-	return old_head.top;
-}
-
-#endif /* _RTE_STACK_LF_GENERIC_H_ */
-- 
2.53.0

