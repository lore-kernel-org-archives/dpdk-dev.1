Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272B0C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CED0640E27;
	Sun, 20 Sep 2026 20:14:11 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id BA41840E03
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:05 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so2002386a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928045;
 x=1790532845; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dgVJWXodIKefY7pJCT5lGlaXiWMAKjKjaMzkZ6AKVbw=;
 b=KYwIZz6PwbL020uqv+4XwtbQ6MEy04rD+FwXU5pB4kAv6QPoT6DCBoaawz2WEP/e71
 31dvjRlQkIrnzPVpeYD5GE5wr68NM61+MuGn0zz3jW3LNWszGeeIft9rgzjjB+446ipK
 EhXZ8IDd2JJ/8Rql9Uim38vYBdEXexAtlyqQFW0k6CcS0EggNvZgk8aYFjZ1Xug6XaT8
 /IjtAp5WMY0LFMNQOyNRhze5MkXLtpipfPmAkX/cV6+qNFyWmEZNNVXZt2hhZzcfV7OB
 JKHyKfyWHIcLmwrc+/CXsj4OiHpqDU++/nit0qxwVvE2xoVbA+FbrFpFFZsPEDVg0b+P
 D6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928045; x=1790532845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dgVJWXodIKefY7pJCT5lGlaXiWMAKjKjaMzkZ6AKVbw=;
 b=B6B88W6yo1CDMTF+IBbq+Gw1GJEXOl5uiI1n3FvwS71iHH15rTcipjbB37awgQ6pCD
 Asx3ntKapcHHKOtkNvFvaI/mheuomzYtlTdJENn7ufxSJqQOQ6n2TKEKP/wWGBI1yos7
 gOXok9yYjp8cnFg4DyahjLFhf/XbiFjx7TYVm0vNOHlSi1DayszBmZC6ZLf/rGvWfVqI
 bCQRD0O4SwrCOMFF9of6RSUyjZNyU5hWD9hWqW6Zu7onBNA/F/ZMM1K/UTt60WwUDtTY
 Sw9KMgWMxFU1zMkJEQrF87FKWSIZ6N/dwNjuC5IFyKNceIbodEacvPWl9mlKz2J0XAwu
 B0zw==
X-Gm-Message-State: AFuF++kv3OXTm/e7pN4oOTyVHbNVmfufyC1ooxi4lQaoYBeffLor378a
 yDWJrlD0EuAt7Z5BcRQd1zy4KO+YxVS33RG+KVb3/iDe/Fv+t6O2Rdx3VMqIuO0xyzHmOxsdCfF
 gJ6bk
X-Gm-Gg: AYBFou2QhKcjg21CEeFLRXf6/PEmc8m1PnLVPg0/gVjqaCVgFbOcj3lqg3QCNzKdwU2
 +jjX45Ku7J/C63YqD2EvsVKcL/RUXaisyg0pTnXGxxzHmF/vSCMDWBzj+237h92xqYqe90QpvIV
 hvowE5mHGRqoYUxJcUDaL8JBcEx0mH3rv48K1Q/4WvVFyNj1AgtNW8c87OD63Be3gp1TDnFJDyN
 rECDYa6GHiiR3ZeYqHy62gpUS15/NZRQ4dSDlDoQ5ojJt6dR0W7vN/eyQwGphtX3VAF05+9G+x6
 qyCzXZPdq5tFXllRH4rvhUiQ5xopOy1zhF9/g8sAJzF/b711cHDeemAPM3EfwckFkokUb1zKwEm
 +iDQ7FbuU54bdSFj6KYOkzADELRNJW3UgqcWLdqnEO0z+v+QbEkoNdmz8MSjRHtfiIodOfdrIES
 YKcxmYTSmc2PZmxpvEqDGeBCkrZERVVnrNJljkm07DeqeI1xW8Ivuy9/OtplyR/8p8oczc9PbiU
 vVXHLQAUqCJs92fTYHHgZLFy5Vl/vZ112vkqA==
X-Received: by 2002:a17:90b:4ace:b0:3a0:4023:bb00 with SMTP id
 98e67ed59e1d1-3a04023bca4mr2023367a91.46.1789928044717; 
 Sun, 20 Sep 2026 11:14:04 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 11/33] stack: always use C11 memory model implementation
Date: Sun, 20 Sep 2026 11:10:03 -0700
Message-ID: <20260920181347.747210-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The C11 version is faster because it emits no lock prefixed
instructions.

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

