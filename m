Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881FDCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C81A4065A;
	Sat, 23 May 2026 21:56:15 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 23EE840265
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:11 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso8583825eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566170;
 x=1780170970; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnqBSFicIbkNjnr+kwFqzDJCFrAYPCLgCZIV7ICIDNg=;
 b=pss3K/kuRHG9fp19aAhir1A1ATDxpBJl1dz4PdoQkuYYCsko30iMQ6tlmS6GpUlWrQ
 azovlVaqXx1OdYTWwdRgiVbPO9eyjsHUmcGHa9Y2o4JPrTUrtCbinHg3WzTw0HdH0Je8
 06GD/pNrBW23JFyXrAto2aWSLw+ZcTY4iT+owMzZ/I5BBfiK2hD+0ODekMtS12d792C2
 /fx/tN/beAd2wnxlJtNDqgRTj2KTR0LRe7A9SFRQUd+li9H3x9+LzMVzoopvFb3Goxlq
 r+YRzxYq8gOSOsd7IZQrhqND6gjlGI+jb45/duTqjAt5AKwQVrsbABa9G92Inu3HOKjf
 lTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566170; x=1780170970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnqBSFicIbkNjnr+kwFqzDJCFrAYPCLgCZIV7ICIDNg=;
 b=LSwc3Gp9S97CidJY9N2pQEiRQrKaNpFNf9pezQok9v4E2BSK2SqG/MS+pDnUz2Rqid
 7x5uw7hGKM+G2jeG0+Ay7SzGUacWlsVZ3smlmAxqsYRhCYuagVkz/PofEeSm9+3NQo5S
 +FzdyVW9jBNgOn68Qg8mnChjTTWfGxv4bEe1IcKPg0gIDflO5HhCbwPYzB/diDZ6svAM
 8ScLaBMFz+TrA2KUw11mPNg/uzSboCsIhQbTAajWFbEulVGXyuLi6Z+lB24CMm95wrv/
 0C3NoMPZ+422qrXhuc2h9JQLswJ3BNP2uU2FPZaSFaYMxnh0vsaQ45AjW6Jsg0TgA5TD
 i4jg==
X-Gm-Message-State: AOJu0Yy2h/0O+/bhI/ZDppvuxsx1nedHZXvJaz9KFgCh+ZbgnRjbP5oN
 0GdcNRKKKWU+tk0K/WkdasjLfLS/k+mTAPLRx13KlapcymiRqdfaqlgabynSzNbGSXovL6As6YA
 FPBBd
X-Gm-Gg: Acq92OFzHl94yplbsQi9gfv2qdmawOQPrPWSbb2McxYiG7a/IaA1FzQwT1xpGiWmilA
 j8V1YRjQyJOt/SieQ1IKkC4pBhPAiCt1+F9rbF9TKEIjFtebsEBJ6++LSddvEMO3nT41Mk3q91O
 DfscaFrHJ6EQ0CBkWHz4R5vewLPSVQficfOQWONBUlFJc8FW+tKxfjk/J1LjwW/YevYSoBfT5yI
 DCob47PhI50aFBJhIs9meb9xNeF9lhUtP5CfRMz5I3uvKUQ2ZIbihgsuIAlARQfblZ0G4PfxxL6
 cMd3lGgA2eSrsPmE5uuFwum4oulQP0+Q5dCP67n5xXv1RxYjv26GaZsWXxUFSa/uOO2YRVaH5c8
 V+CkwhQxi01fyXKfrZLCzYvCEDvX78Y1tb2/NzlTpc+Ppl/+ZhAvWk/ExcUnvqoxpB0fGMOHbnO
 AIy2wzWrNHXAQTnbeexaCjSLdPzkWG6lXjGeTEQlFmitSpdUAyu9s5G97ocYq/CQ==
X-Received: by 2002:a05:7300:ad02:b0:2d8:71c2:255d with SMTP id
 5a478bee46e88-30448fbdddcmr4600608eec.14.1779566170116; 
 Sat, 23 May 2026 12:56:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Date: Sat, 23 May 2026 12:16:05 -0700
Message-ID: <20260523195604.441947-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195604.441947-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
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

The rte_atomic32_cmpset is deprecated. Initial attempts at
changing this with direct conversion to
rte_atomic_compare_exchange_weak_explicit()
regressed MP/MC contended performance on x86 by 10-30%,
because the C11 builtin's failure-writeback semantic forces
GCC to emit extra instructions on the CAS critical path.

Add an internal __rte_ring_compare_and_swap() wrapper that calls
__sync_bool_compare_and_swap() directly, which keeps the original
instruction sequence. Add equivalent function for MSVC.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/rte_ring_generic_pvt.h | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_pvt.h
index affd2d5ba7..0fb972de9e 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
@@ -18,6 +18,30 @@
  * For more information please refer to <rte_ring.h>.
  */
 
+/**
+ * @internal optimized version of compare exchange
+ *
+ * The C11 builtin's failure-writeback semantic generates worse code on x86.
+ * Unlike rte_atomic_compare_exchange_*_explicit(), this wrapper does NOT
+ * write the actual value back to a pointer on failure. Callers in a retry
+ * loop must reload the expected value explicitly on the next iteration.
+ *
+ * Full memory barrier, equivalent to rte_memory_order_seq_cst on both
+ * success and failure.
+ */
+static __rte_always_inline bool
+__rte_ring_compare_and_swap(volatile uint32_t *dst,
+			    uint32_t expected, uint32_t desired)
+{
+#if defined(RTE_TOOLCHAIN_MSVC)
+	return _InterlockedCompareExchange((volatile long *)dst,
+					   (long)desired, (long)expected)
+		== (long)expected;
+#else
+	return __sync_bool_compare_and_swap(dst, expected, desired);
+#endif
+}
+
 /**
  * @internal This function updates tail values.
  */
@@ -108,10 +132,10 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 		if (is_st) {
 			d->head = *new_head;
 			success = 1;
-		} else
-			success = rte_atomic32_cmpset(
-					(uint32_t *)(uintptr_t)&d->head,
-					*old_head, *new_head);
+		} else {
+			success = __rte_ring_compare_and_swap(
+					&d->head, *old_head, *new_head);
+		}
 	} while (unlikely(success == 0));
 	return n;
 }
-- 
2.53.0

