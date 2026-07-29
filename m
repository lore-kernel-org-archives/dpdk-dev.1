Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D3CC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9F0140B9E;
	Wed, 29 Jul 2026 19:57:37 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id F17CC40A76
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:31 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso942083b3a.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347851;
 x=1785952651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iz0rEIC/r/rwPdngbM2BAq1vJbmyVEkrffuqOAIGjNA=;
 b=t8W9/h5nm3eKWIHHmmg18oTYsH13/S/hmi5cJ3IB11QMPw0FoX1Utx8Z4QSP2Cpo5m
 G2iaWJBCvjN4xBuv1+Ttuf7Y1FmcR2rEL8j38AN3UskoxXkgke9TYTjwnwXguu2iTvYC
 WJgiUMBZcjHyBxTjjQlPA0QFAXUdAPMdHrk5/OpihwogAELWn/xfHfugKJmsjpnpygM3
 dwNi4qQdIDCuOAv4ibW3uDbpOqWYru4c6AnQQNqaYuIzouKjQ54LSXSKLSkQ8XAW8iT+
 QeJ2Nqky4p3gbexS7qeNa52y2g4S2eZy8tsUTxhSxO2fbsklnEfjxJVxr0D+PqqWf3Ft
 f4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347851; x=1785952651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iz0rEIC/r/rwPdngbM2BAq1vJbmyVEkrffuqOAIGjNA=;
 b=Z8mR8kCs15qZ0zCk2yGheazZMFXKrYwhpsPBajw+3InHjpKoKU8YJJnzsbzkZrTBeD
 w0oj/l5d/yWmMcSbk+hzsJ8glIbCXxetqPpqYcihu1t8hKGYq2XkZPhXWGjKWJ5JQoML
 p+yMCGLDtAgAL4/5P7x5G8qUkvkoyBWfC1mmv4kwv36v2mu/FYMA/rSUpIdXR0kypKbw
 53kXbfIo8tq0GLR071AkKQMKMlakyGXsF+KYOoSnctTgM3Gc8ofmlQj6e5uH58gI6OGA
 eKFcZ/rn2GyDJycATTekyerRlAxBMmMbGDS/fBpcwsLaP6Oz0K9RJL9nltA+EHU17koj
 /izQ==
X-Gm-Message-State: AOJu0Yy7Oe+o701MRlOxDwQhWkAkRTkFSi9ncBUShClacQr/e7BMaDA8
 NImiF+3+FT0+lyyjjFJM6fxknQo7OxVMxVMSzTClhQG5md9TSoT5b1iTca1I39ZODeh6u7JHKol
 w3FtD
X-Gm-Gg: AR+sD10EKObKK4/DA2kSMXUxzmr/JxB5EAfMbSQvnEG+7875DTXrUCbIC3/WmjIvHsR
 CiowZb9x6492EjmysAdly+Bc5i4msl+YVLx+7MNqWVezKdF530tglLh81k6IPihyw3WQ2EaUDmh
 XiGqWqvV0j80eNNTa+vqlX3Pstj43pNcMUAN8JARS4FWQn12QQQC327+l89M0BGRu0swC55s9IG
 RcbprWKkMvFuhd4jZJrohDyiPhBB1kjah9zDmd618pNhq8ljMG56W4WUvAy2cbkZV40tBN48d5e
 dw1g/QCjB7YbVxH6QdhG0c+rhJ3GXto3xO67dMTP/SQBOOM3eTuSiXem5MKZEXizQo6+EG/46gy
 eI9JFFnuK1VFIYiWIIBvS/2xkY10GyNI25Dq9ZgmZvq+eSTJ/NUFl5Z20A4FfUDRM7/vB5nTgf+
 F7yZ7hRU/nuApiwMx7XOG5iovtBjpD/MxURSzMUKSFLYK95X+pov2nSl0RPlF6mGr0Gqtu+EprG
 MQRfqx19ApOGvVBLQrOKagdWwc=
X-Received: by 2002:a05:6a20:7290:b0:3b3:486f:f2d1 with SMTP id
 adf61e73a8af0-3c8aafbd522mr8887968637.3.1785347851011; 
 Wed, 29 Jul 2026 10:57:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 12/32] stack: always use C11 memory model implementation
Date: Wed, 29 Jul 2026 10:54:05 -0700
Message-ID: <20260729175715.165120-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The generic and C11 lock-free stack implementations differ only in
memory ordering. The generic version uses a full barrier where its
own comments state an acquire fence is sufficient, and seq_cst for
all length counter operations.

Only x86 and ThunderX still used the generic version. On x86 the
switch removes a locked add per CAS attempt in push and pop; TSO
provides the acquire semantics. On ThunderX the pop fence weakens
from dmb ish to dmb ishld and the push fence goes away. Unlike the
ring, no platform selected the generic stack for measured
performance reasons.

Remove it and use the C11 implementation everywhere.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

