Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9585CC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC05140C35;
	Wed, 29 Jul 2026 19:57:43 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 2399140B9C
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:37 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so945862a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347856;
 x=1785952656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqfC3UsRjVykHs3LQAD2C/wMBA9LiNfLWbGW5I/XbHw=;
 b=VPfcetjaoBH0/zKuI/zv3l/CdKXz0Wj/nQVoVns6yJe7EtPShNxgOxrxO1btB/iRXU
 NuwMvg4Gwtvqrncosfb8rAWig3ucM3MpnMRGXqsCCgL4ijLp0qVG5aE8Y+cR4Yp5AZMV
 C90yhvjOL1emQT978zwZ5O6gXWZN9LWvgg5dEIczIodfYDLnXzPQo/HPVgqr4XXsMp9E
 lkLAuQ8f2Syd3lZqeDB/CFCjzwt3EZPLj1DtB625cq6VLdOUoMgGJPox2lWZarMa6Nvn
 pW9cSUililbBJQL7jQxN84Rp5p7zUxs92+htv50FyooQbm49HieqbBUgyTlpeyX48a4+
 /8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347856; x=1785952656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqfC3UsRjVykHs3LQAD2C/wMBA9LiNfLWbGW5I/XbHw=;
 b=I7x27CGavaLMVFAw4EFvnsjQ3Q/eUS6vWkSjmc2STBJvSP16ZtMNL07gA8BPi/iUPx
 dv0TZV+whe8wvirwq8efm6c2AHuSpVeRwXDLAZK2IiPFde3ZXuVweAItPwwCm7tPp2Aj
 s7TCbc6y25o940y92Xq6MbFxT5m+NfePXbIzkOZaZLt8IqXPdJhUDrPBRy8wTI2Ft/J2
 NRPcwJA36Tik/iBdICUU8H5UuQdITqjZfDnDmjJQnCkrJfIb21lgs0DsiUCoRUc0YgL8
 5WHZR2iFwlQFRvEqXb1+Yo20h22nWYRALRD3lJ695PK9PuAzpLqA3BW6xdcgZiGU5i8/
 G4ZA==
X-Gm-Message-State: AOJu0YxrGarkNGwdg16pYqM0lDIyX+ySLUdjJJdY+dYQxdL025/ePoFk
 ntFLuT7ijaNFPvXeNhhSePm41mO2QRZ452hOQxil03WFVmdOSVzOEp0ILpp+Sf2WXSuTxjP8haZ
 sinG5
X-Gm-Gg: AR+sD13G1MDR4vF9cF2FDtiwTdD5lXxDj6neKmwlVyupgTZnCFAUEXGZGvhrEeLN7LH
 koHaBj3SHFpB+/JBgftXiDFFEf3Yui383nbqblrSANj/yRG0uGQr/AL9Oa+/9Sks/jbM544l+K6
 st70cIPrNjPomPFoY8757VGVXsZfLBBqcd6jYYu0G8Ns/CirBiCy3LaFUysK6Z2T++rS3di5ZAD
 c1Bq9wi/NArSTfJa2fNb5vk+Z0AqalQ27gcl6ymZho2MEmoQ9EzohxYLzJxiG74YZVLMqGKew5p
 u6SjeM7IA1ym5XJoi7tBYgn8eeHPvAY7oQLGukWsVOIFFVR5m0nODoLI9/DdECdwC0gHLbix2eO
 5W6m3U3YYzj3vBtphXzjFmCP+kOR+moN0p2+fQhHdpx+zdeBAQwHeA86whwFbKTWP4+iDOv6F4D
 787Q1YhiHP+RQXCencReeTnYcG0pBsmrrwohwQGDI/aXt0cHsssStwbDLPwEASiYQQ1jOeV9ISl
 EABXKQtcfD825otEQMF+51Dz0Pkwg1CZonyCQ==
X-Received: by 2002:a05:6a21:7106:b0:3c3:a4f4:c5c1 with SMTP id
 adf61e73a8af0-3c8ba60b296mr8401067637.60.1785347856260; 
 Wed, 29 Jul 2026 10:57:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC 17/32] eal/x86: move optimized fence out of SMP barrier
Date: Wed, 29 Jul 2026 10:54:10 -0700
Message-ID: <20260729175715.165120-18-stephen@networkplumber.org>
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

rte_atomic_thread_fence() implemented the seq_cst case by calling the
deprecated rte_smp_mb(). Invert the dependency: the lock add based
fence moves into rte_atomic_thread_fence() and rte_smp_mb() becomes a
wrapper around it, so removing the deprecated barriers later is a pure
deletion. The optimization itself must stay; a plain seq_cst fence is
an mfence, about twice the cost. No change in generated code.

Drop no longer used rte_smp_mb().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

