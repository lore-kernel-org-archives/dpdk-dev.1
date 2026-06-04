Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FBECD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:37:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84CBD4068E;
	Thu,  4 Jun 2026 18:37:04 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id E3EC440676
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:37:01 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso1602483eec.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780591021;
 x=1781195821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO0cSQ7dwlBDiZTCLGq0lpSpjBjdJvxjZXvEXZUNoEk=;
 b=M7lDhks2weMZd35Ff+lxVSiBFvkXJsT2ibICsOiO08ocLxaQFmnVgIxcKFjYN7w7n5
 yzislXI2SMRSVl8jfnqQgdUNC0aGRXK+HPBchQc8FzLbAyeWmHiaDxJdI9AL9nS7yOBc
 QWs5pxmz1VZoXjz6XHpGJkdu+DgNdzUVNq1hUJH2ISk/QqdxyYWDDJtJhwPLZlVz0viB
 j00T01nSUb85GToiFlhOJ1zS3s211aHnyfKnnTuZ83P3l6XXMQHpQGBSbIvdvcqSfr5n
 SEzpXQmaJENkLrMKr8zex/6ZlmWoKwNjeLLyGfstA6nXVI2nUYXk/yp9LYH8Wo5zt5p9
 OoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591021; x=1781195821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qO0cSQ7dwlBDiZTCLGq0lpSpjBjdJvxjZXvEXZUNoEk=;
 b=hpc69ATV1WE8DAGJJjdxu+RDpJGyIQpU+2onf4IPXVO7qB+tbt2r8CsnwatH+2Diy2
 kirk4lRto5aLsLr7xXOoBDn6IZ76bPZTEFehAvrzZu2eDEx8fX0JfYw0oFhGKwhKjJGg
 Yrv8eT+8WudogsuSR7XnNskuFpKgC2EBycIi/J5zy3ztp8+jTc4oMWt/839uRBR2Jc3r
 L7VjsQ31zDwxkVdtOMXkA7lcODvQODpdy0b5BPTo5A2JdRtVraGI/JKrOSD66Cd5Mo6x
 BXhhPP4CYLkjUTpjoF6MwqhnycPL9PHVDW5Tdu8kK/WXejj+NLmwjDX6XWyUSqyWkL7m
 f7qw==
X-Gm-Message-State: AOJu0YwtpbyJVB6z+QVSisileschg3TPb5KqFMzDqZRJa8dj7mXR31jm
 l1z4WORZ7yGCT+5mcd4nuW/5RVnmY2M9C1Wzgaf2p3MU2PIKw+iAKEgh7Eidq0HNgRC89bN/IbW
 gzsPt
X-Gm-Gg: Acq92OEBF19RsMdXYSo0E3VejoisSHQqYMiajJNlBLxng/0YlgQMuEAzQHew2eKHeoa
 Cp9gqn3GUEg0wybPErxB+tI+U3YwDlkVBSQlJCiuB3xPY/UwWWxjFbTeEn4UdZe0+HjdG5YnDC1
 veOjJYeuVG37nT4rzbvyJC9MRyFE1Cr9RWlE0WTQpfvoPJX73JYN7RJgEn8unx7mSBJwPr0THph
 NR6+COnkG+lMNm/IGR/07JJGimC7Dv9TiC/5c6pp1qyShRABR32I81a0A87QC+srAYCIkVvj7fX
 IVqG83fvxZIhgRZ2xthLSWc4Z/K8sVpLjWVQqjKwVha/oYSY2l1f0MBFzucWAIi4A4xGgD5zJb6
 nXqqarDRNqbVaC0UqpDHhmvgJ1RMh8tosdGGE7kWpLdqYO1YvS44E7o79XgSI1YbxKdGUux4xEP
 y71jfR0RzBT3s61Jwfe/9LmabnFg2nqnh6/KOPwk17G/syRj45mX6hS8DNW14cJC7tEuc30610
X-Received: by 2002:a05:7301:578b:b0:307:3aa8:ca46 with SMTP id
 5a478bee46e88-3074fa653c7mr3846306eec.3.1780591020692; 
 Thu, 04 Jun 2026 09:37:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db56697sm5427951eec.2.2026.06.04.09.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:37:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v2 2/3] ring: use GCC builtin as alternative to rte_atomic32
Date: Thu,  4 Jun 2026 09:32:27 -0700
Message-ID: <20260604163656.1226902-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604163656.1226902-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260604163656.1226902-1-stephen@networkplumber.org>
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

This patch replaces use of the deprecated rte_atomic32 code with
GCC builtin atomic operations.

Although it would be preferable to use C11 version on all architectures,
there is a performance loss if we do it that way:

Measured on i9-13900H, two physical cores MP/MC bulk n=128, 10 runs:
  with C11 builtin:           5.86 cycles/elem
  with __sync builtin:        5.36 cycles/elem  (-9.4%)

The C11 __atomic_compare_exchange_n builtin writes the actual value back
to its expected pointer on failure. On x86 this forces GCC
to emit extra instructions on the critical path between the CAS
and the success-test.

__sync_bool_compare_and_swap returns a plain bool with no pointer
writeback, allowing GCC to emit tighter code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/meson.build                          |  2 +-
 lib/ring/rte_ring_elem_pvt.h                  |  2 +-
 ..._ring_generic_pvt.h => rte_ring_gcc_pvt.h} | 33 +++++++++++--------
 3 files changed, 21 insertions(+), 16 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_gcc_pvt.h} (88%)

diff --git a/lib/ring/meson.build b/lib/ring/meson.build
index 21f2c12989..2ba160b178 100644
--- a/lib/ring/meson.build
+++ b/lib/ring/meson.build
@@ -9,7 +9,7 @@ indirect_headers += files (
         'rte_ring_elem.h',
         'rte_ring_elem_pvt.h',
         'rte_ring_c11_pvt.h',
-        'rte_ring_generic_pvt.h',
+        'rte_ring_gcc_pvt.h',
         'rte_ring_hts.h',
         'rte_ring_hts_elem_pvt.h',
         'rte_ring_peek.h',
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index a0fdec9812..9a0170c4f0 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -309,7 +309,7 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
 #ifdef RTE_USE_C11_MEM_MODEL
 #include "rte_ring_c11_pvt.h"
 #else
-#include "rte_ring_generic_pvt.h"
+#include "rte_ring_gcc_pvt.h"
 #endif
 
 /**
diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
similarity index 88%
rename from lib/ring/rte_ring_generic_pvt.h
rename to lib/ring/rte_ring_gcc_pvt.h
index c044b0824f..68ab1355e8 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -7,11 +7,11 @@
  * Used as BSD-3 Licensed with permission from Kip Macy.
  */
 
-#ifndef _RTE_RING_GENERIC_PVT_H_
-#define _RTE_RING_GENERIC_PVT_H_
+#ifndef _RTE_RING_GCC_PVT_H_
+#define _RTE_RING_GCC_PVT_H_
 
 /**
- * @file rte_ring_generic_pvt.h
+ * @file rte_ring_gcc_pvt.h
  * It is not recommended to include this file directly,
  * include <rte_ring.h> instead.
  * Contains internal helper functions for MP/SP and MC/SC ring modes.
@@ -25,10 +25,8 @@ static __rte_always_inline void
 __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 		uint32_t new_val, uint32_t single, uint32_t enqueue)
 {
-	if (enqueue)
-		rte_smp_wmb();
-	else
-		rte_smp_rmb();
+	RTE_SET_USED(enqueue);
+
 	/*
 	 * If there are other enqueues/dequeues in progress that preceded us,
 	 * we need to wait for them to complete
@@ -37,7 +35,12 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail, old_val,
 			rte_memory_order_relaxed);
 
-	ht->tail = new_val;
+	/*
+	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1.
+	 * Ensures that memory effects by this thread on ring elements array
+	 * is observed by a different thread of the other type.
+	 */
+	__atomic_store_n(&ht->tail, new_val, __ATOMIC_RELEASE);
 }
 
 /**
@@ -73,7 +76,7 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
 	unsigned int max = n;
-	int success;
+	bool success;
 
 	do {
 		/* Reset n to the initial burst count */
@@ -81,10 +84,10 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 
 		*old_head = d->head;
 
-		/* add rmb barrier to avoid load/load reorder in weak
+		/* add fence to avoid load/load reorder in weak
 		 * memory model. It is noop on x86
 		 */
-		rte_smp_rmb();
+		__atomic_thread_fence(__ATOMIC_ACQUIRE);
 
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
@@ -103,10 +106,12 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 			return 0;
 
 		*new_head = *old_head + n;
-		success = rte_atomic32_cmpset(
+
+		success = __sync_bool_compare_and_swap(
 				(uint32_t *)(uintptr_t)&d->head,
 				*old_head, *new_head);
-	} while (unlikely(success == 0));
+	} while (unlikely(!success));
+
 	return n;
 }
 
@@ -169,4 +174,4 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 	return n;
 }
 
-#endif /* _RTE_RING_GENERIC_PVT_H_ */
+#endif /* _RTE_RING_GCC_PVT_H_ */
-- 
2.53.0

