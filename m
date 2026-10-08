Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6447CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE1840A82;
	Fri,  9 Oct 2026 01:37:40 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id C983D40A8B
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:38 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-890d52c7c7bso3084446b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502658;
 x=1792107458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TFwlFJVduEB4yBeXXGQ1mL+2FRNeJhvrNr0rUwM5v4k=;
 b=fC17DcScXripFy5QpgDStIThd2IEt2tg6a0hOiwhTQr9wg2JA40mVXBEfI0FUIUvFf
 e+OBSoVRKhV9+PhfsRT/tcThaLHztRkomY6fpaliGmuN2Xw1WipUkJ1uSS6uIGoyOw3Q
 JZHCGK71xLjJqsHWj/blozK+4XeN80Np+fE8gGG3Yjk45hY8TaJA7isa8Abaih8AkEE3
 rffcmQuCfAtbfbKss4i9LnJq/Zzs6YBYpRgelwR31JyKx6MXifFscEWrF+MNZxNsKODT
 v1bvzLK/L36cK8y3B/c9QAnrCI7P5vfKRuyEjoa/KJgMcysnVaC2yVkxS5FIRHvYI2zF
 V1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502658; x=1792107458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TFwlFJVduEB4yBeXXGQ1mL+2FRNeJhvrNr0rUwM5v4k=;
 b=cM0i4cf1xjDtwo25XgHKqPm+ynh6lr8JKjB4fOFaWE+i2MgxxdtentJfiqXYArniJ1
 t3Z+AbAXtx6TnM0hytSMX25BRBOv9MH9MRdaqY/dWBN4AS40Z0Wi93SWl3tzYQ2wTv1/
 ZYK1AJC/GrSCI5a0F3Vk84CplN2OrVxYwXPSzZlabZ0R8JgbwUt7DaEXbI9NnnjbVqWi
 C9tO1fux/aEgl7cSQw0yvHsBRJeMAwCthYaWkSAN/xri+OwLXeyX8YK6rWTIRo94NeU5
 D5yFuBaFyD2Z3Nd5yxH0rv+qYRgLDTpM1QCXmWXzG1NRQw9V/tPDv1pSBJLD30oOTDxl
 o9Ng==
X-Gm-Message-State: AFq9FYKuyIDNd8QV+s/1WDc0QLC9t3VavMqFlpU9mINms1b0LuVtfm4d
 NjLrCGiSSA/u7jIwnOyXglklmR1fOaAUjDrmGpGinAm9p38ibbZA5Iis2+DdiWapSDcQsVlCV4Q
 k0y5zhFQ=
X-Gm-Gg: AYBFou3onfhOETdBKwY5azQ87jQwuDok0fMtp8wH7gC3E9vdVncP42sVM6P5ic8klPx
 QR2Rpv6MpzkKK4XeJIEsXO1MRasZbg0d/ozAPZ6RVra1vu0wPIOm75LUz1osWyJxWyBFcg99rog
 8JQ86hfy6b61cNjHw2TR1kimFCUg3FeJGbwFx7nve28jNWPUEhS9m1gdzaS0c+aPNbc3dQWQcWW
 5kxbwNv3+lyNRhTxJM5hf2iWBXVJpfv6Qb4cbUvs7EkRflHuzuoDDzscn3qD47xwt2t9JhtDnfB
 USzkA2zlkTinIl0D1WXhxQ1+0ZB/lP86ZZ8Rz4ImMe4CUw321mHyl41p1NsDfpMt4v1GVYjOYMH
 b9u/JF+cRLgrPmPhaccVZDN56GD0ejH5xbyKbXunG0WTL/8H7HYPXW4Ows5/yi6lMNEfDEMMXuC
 FqOISW72z3OgW/qlACZxl3qIFf41hGrd6ML6w3xgWm8Gu23fD9hs4z4s+dAjKnXbmI1Nl0rzh6u
 sxZSjhMosp2a+BumUYa7KDicn3jqNjX/QCXBQ==
X-Received: by 2002:a05:6a00:3e22:b0:874:706d:856f with SMTP id
 d2e1a72fcca58-897c79ddb75mr43673b3a.32.1791502657017; 
 Thu, 08 Oct 2026 16:37:37 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 20/29] eal/x86: move optimized fence out of SMP barrier
Date: Thu,  8 Oct 2026 16:35:13 -0700
Message-ID: <20261008233649.1260843-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

