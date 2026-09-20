Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F721C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0306440EDF;
	Sun, 20 Sep 2026 20:14:23 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id B60DA40E42
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:15 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so1532679a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928055;
 x=1790532855; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PvkwqsEoXXe6tvLb6lbDw0JwxPtx8rv7esIYbMJREI4=;
 b=zOTEhI9yA1+7lDHnijnwZswENAQ/RaiOY87Bcl0N7uxU764Z2HOJ7y5dSVYnKjHCwB
 YNTit+oVR7NflGJqKsCIIoApfWlJab5PPO/sC/W2x+piM4OBWZrXKbcLsK3uHvg+Zg05
 YCNUqIaIYD54HoTw55Gms5kdEXy4wiafji3HeNGCIKFCr0WOLh6KxDvsncIeX/rvCWIa
 E06EgNQh8y+n2ZGFl0HO+C75olYThMenVaY/3B1DVurocDgj5MTm7ZjELUKK7Ij7Zvzn
 rm83Cru005Qs0PL/niNZnFHy9K89FmGqwpIgjFCmL1jP0l87B7ZLLTbD/PFacfyPqOq8
 2dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928055; x=1790532855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PvkwqsEoXXe6tvLb6lbDw0JwxPtx8rv7esIYbMJREI4=;
 b=vcD++aDm6vFVUy1BctWWs3Jl7Ut29GK0OfXPe/BzOKTOc4DwRzfzhGPFUJVh/nhefP
 capEWLX4VhHCpkrsB0TlLgPAFD4iIFQp5UG6A1MZEh4UUuMQVgrD2EGx1YDxw4o3Nm0U
 WEm9egbVVhc10OfjCn7wau9VK3L1mqDNWlHZ7wQy30ySmjkNdJIIi+jGrJWQWNu2Jun1
 qvmd9tAoaX+FTPWIIlJFh1EK10pdNK32ACbycRnqwFXHl88RzZkCmos4ex6NxjExYNKB
 PWQz8C0pyQi8E6I0L5Z0BvL5/AFJEUOmToe/8dPnf+tEIY3WqV50MmiyNLA9fylbSNkt
 m3qw==
X-Gm-Message-State: AFuF++nFkD4Ox4oev65163ZO0+fX7sNpUg6Ne7NX8Ej3m/EUtodFkksn
 x9NXpLQs2lkJeGEm8t8EEoatoDpi2E+db652a+glxRhOYtnAKydBPfH8yYMtGuKsk3OZw0lUE5L
 jVmpl
X-Gm-Gg: AYBFou28+XcVcL9qDyW9yp7l8t3h9JpQ9x01xEhHAjahCz7ZB2s6V7EAz2P9MJbc5Sv
 7KeJ8XePBCtIOZBXwRUBvPqnN3jKLwJiLAHT6w5dAdJcqmnc7OwpBU5N1wTPiu+5pskDeJTc/t8
 LMSF0FhDpPxJm6YUbdzHsV3TeObBpNRv09AQOcDjE7KmoYKOrWzXFOdoEoWgV1sslxC7HF3AP7z
 24cSJcO3tuBu26rKQH427X08v5NB/dIwXMl/R3qWRRuM/4T0khySzQPZwtl7dSHFuFAyaNE+ZlX
 FBWimqaKU+ANCuwgoc9GPUqTalNh6EJ7GWJCLmKfffUMWKWHT8YdWpwcrtZOZAzkIG3jYJigjsl
 jvIr5nA9TMUj/eKh1Qh+70OJPGUyOQGjpciAT7S6AqNv54EvZELt/A1TNhtFDL67WLN8Fboqxbl
 5xzT+Ovi7+UbGNHxshTXwSHZRU+Z4iaAd1rTamk9kJsxhsWs1vRkVgULWMib4vvLOXeOVLHvgNp
 QwQUbcw/psY701ATNtCz9gwxierCb/2DkkIHA==
X-Received: by 2002:a17:90b:51c1:b0:39e:6c6a:209f with SMTP id
 98e67ed59e1d1-39e6c6a22ffmr7294697a91.64.1789928054860; 
 Sun, 20 Sep 2026 11:14:14 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 20/33] eal/x86: move optimized fence out of SMP barrier
Date: Sun, 20 Sep 2026 11:10:12 -0700
Message-ID: <20260920181347.747210-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

rte_atomic_thread_fence() implemented the seq_cst case by calling the
deprecated rte_smp_mb(). Invert the dependency: the lock add based
fence moves into rte_atomic_thread_fence(), and rte_smp_mb() goes
away with it since the test that was its last user is converted in
the preceding patch. The optimization itself must stay; a plain
seq_cst fence is an mfence, about twice the cost. No change in
generated code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/eal/x86/include/rte_atomic.h | 37 ++++++++++++++------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index e071e4234e..780fdce871 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -60,23 +60,8 @@ extern "C" {
  * Basic idea is to use lock prefixed add with some dummy memory location
  * as the destination. From their experiments 128B(2 cache lines) below
  * current stack pointer looks like a good candidate.
- * So below we use that technique for rte_smp_mb() implementation.
  */
 
-static __rte_always_inline void
-rte_smp_mb(void)
-{
-#ifdef RTE_TOOLCHAIN_MSVC
-	_mm_mfence();
-#else
-#ifdef RTE_ARCH_I686
-	asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
-#else
-	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
-#endif
-#endif
-}
-
 #define rte_io_mb() rte_mb()
 
 #define rte_io_wmb() rte_compiler_barrier()
@@ -86,17 +71,27 @@ rte_smp_mb(void)
 /**
  * Synchronization fence between threads based on the specified memory order.
  *
- * On x86 the __rte_atomic_thread_fence(rte_memory_order_seq_cst) generates full 'mfence'
- * which is quite expensive. The optimized implementation of rte_smp_mb is
- * used instead.
+ * On x86 the __rte_atomic_thread_fence(rte_memory_order_seq_cst) generates
+ * a full 'mfence' which is quite expensive. The optimized lock add on a
+ * dummy stack location (see above) is used instead.
  */
 static __rte_always_inline void
 rte_atomic_thread_fence(rte_memory_order memorder)
 {
-	if (memorder == rte_memory_order_seq_cst)
-		rte_smp_mb();
-	else
+	if (memorder != rte_memory_order_seq_cst) {
 		__rte_atomic_thread_fence(memorder);
+		return;
+	}
+
+#ifdef RTE_TOOLCHAIN_MSVC
+	_mm_mfence();
+#else
+#ifdef RTE_ARCH_I686
+	asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
+#else
+	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
+#endif
+#endif
 }
 
 #ifdef __cplusplus
-- 
2.53.0

