Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE0ECC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53D5740E11;
	Wed, 14 Oct 2026 00:35:20 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2F04140B97
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:18 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso2071085ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930917;
 x=1792535717; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TFwlFJVduEB4yBeXXGQ1mL+2FRNeJhvrNr0rUwM5v4k=;
 b=gTF4NmKVopd1uAnnsmGXosovh4FtDOvr41aOdRFitel+Ys5trwBhLEY8LHUrmNNTlG
 7nWJUqU6Dc0pOU/5jI+njI6bbzj40GPo3bat3vuTdC63CBjxT2DfFnSDKrbPd4zumR2M
 avAa4KWhnOJ5vURl7anLQy2HHSpiqTwO07DLS7yPcmnwAcvPDuclf76s9+T6aJ/xXRc9
 lLF+UCsKVmPyikh0RHeEEDfJP8kWS5kD7ri8IFkCm8GsVpRW/+pOIVK5rLw0Mc0MrMQ8
 cmeugsy6mdJ7PPs8KImPhpho8YQU9PpDKokCzifu8F5UrxClUtALLjosbjTRTaqW2SR6
 cbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930917; x=1792535717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TFwlFJVduEB4yBeXXGQ1mL+2FRNeJhvrNr0rUwM5v4k=;
 b=U/JDU1wiBndR2UNZKxVTdZ0UdVZA2wLW9hdoWVR8DuXl08SyfgNgOejn47965wPgN5
 xCD/neFsESM1HAtCpuA3JG+zQ90NZUbwAE4htEz8gRv+vvjCARYHNLU9QFqaEo5IkgZi
 dm8Aoq7kJvNt02jfit0SXspeTWo73/hbOKg8meCBfR0+ovyTDz2Su9PLNHlAFShOxEC5
 XXyGrL890esXeSz9kiiedRuwvaI/od1Gq4xdrriZo7uGHLBAw2dz6u4QJE92FWbcBPqZ
 ldqWFSl42VnqGPLEaMLinfLVVFJ2evAcsiU4QDStebxYsjQH0WiXszxOvCaQ06imF2nM
 jcYA==
X-Gm-Message-State: AFq9FYIoTN1U6sDsWqUXhyW11cacgRGwZ5sLm7hSMq9tNU0rkEBESZoP
 0tIwTWOFQQadVvckf0WuJt7FmhAz7pNOshulkd1tdcQZR+DZee9ljQPr96H0lJHx7qXAxULduUC
 OSzygBFE=
X-Gm-Gg: AYBFou0DqXJo5en/D+c2dMvwhyPHOyCFeZD7MquiA3/iJz+MzVAJR1Qw0hgv8ZykK2G
 Vphu8jeavKNNJxNBkShXFlExPVaqsE5QkAJ9rRXHqCl1OoEnFnGnxOdNF3+/1p2kreldm9/xyZ3
 NkDckwfk63InPGA3sxrK6+oycucMBxqepPvWozm9hmhxZB1IGFsZwLrpbuJ/BcsDK+5uB7ouu+z
 9VOpqZZfNdxBVgv2TdKpghF7rx84Uv1GkrJHJFleBONCnQYaTN8qjfYQY1UfPesM0qwa4y/eO6K
 8WN99NIUHOr7QQqylh9/uwni5gMUnpgA3fso3NUNJ4AjyK0Gg4D13fT105a02CR3CVdVQLV8WP4
 gnU5OefnE4Gp0KR6TKQc2z9H/WT5qVMDTd8IzbGfvPKIor3tavQdC3SIBRpgMKZRCyI6XRwWdqF
 fhrkh9AGy81XcFOuKhkNdq+IOxvQ0+ow1b5bPD4JukxYNj7dcoySYmWauZTUpHGoz7iPnzXY+nP
 uQn2lZVQU1BoQ6UZMhbBHTNN4Bflwmb1YX2yw==
X-Received: by 2002:a17:902:e892:b0:2e2:e38f:713c with SMTP id
 d9443c01a7336-2e842aad0bdmr129755385ad.13.1791930917302; 
 Tue, 13 Oct 2026 15:35:17 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 20/29] eal/x86: move optimized fence out of SMP barrier
Date: Tue, 13 Oct 2026 15:22:33 -0700
Message-ID: <20261013222410.2257622-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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
index 20a4baa575..a46bedb0f0 100644
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

