Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3742CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4D5B40687;
	Sat, 23 May 2026 21:58:50 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 28DFB40616
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:46 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso3103253eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566325;
 x=1780171125; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnqBSFicIbkNjnr+kwFqzDJCFrAYPCLgCZIV7ICIDNg=;
 b=cbzYnYZnDeNmV7O6EPZ+KbDUDbqQ8/Zg8hU+7+WrUUAW6uoQ76Ir2Ag7apIzlUxyoj
 DjHbhEgwzjBBAfdjdyep7PYt3Zfj/om3eLMj9luFrP2HDiUY0vpwexc/iIgSTKKRCjd/
 iIUfhxNk3wYzMTMjbQ12q3YlpvWJfbJlmCPs98wXs1Uqde+7PL12wJzFDJcp72fcuPtX
 ECItJBhGZWqo0FNS7553nF28J+gubuUO+lsVhrHIwbcXMAmRIvO9mdQfNKmYDNojV1zj
 Jqry0ckA2EPjbD9K5mgdWzrnu7t6V6avAd6/q4smi5m1eWrceYpt/uuPxAxwstvUAxbK
 fZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566325; x=1780171125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnqBSFicIbkNjnr+kwFqzDJCFrAYPCLgCZIV7ICIDNg=;
 b=i6EHFF9MQ1xQ7BmU/4piE0ipixh0s0j/gAgGIK0Ao37inMDmu517PuForIJxQUaFLR
 6lnaMz8STUVf95NYMi7jbfjw2Vjnd970R+LydzAfykiy5DxBYhuAUlZpGVvemVt5EoVw
 YHXjtTW1mLGz/vNhcKozCR39/MVo/cRohMMd0fxi8mBcN6M3y1gaS8YUaxu6PtZUpl0f
 zSdNvagrs7joWMIBv3wXRmdvLb5CjIDYmTs0uB0X/Pv7fWuIr0NK/VJACB9CIQl8/bSw
 hQlQRCSGiK28Ntfe8x0ktHD0bhKW8UbM4fQrBaxPtqQr3izwQv/BeD9eazPwAMWetJUk
 IWpg==
X-Gm-Message-State: AOJu0YywKAX4ySaR2oo9Z7yZ39CHCENH/WRVj1E7zthOgQz1OlHlYDi1
 eP4a0n18b9DGgwLjsxKDXCNW36+ZfCjTGh2mO8Q5desmBdbKJdBvIX7v6ir9iiRh43Ns82nyP8j
 ivfbX
X-Gm-Gg: Acq92OEd5yiY1kSqxiG+EX5MyL/+i3TC6ua2ZBMJqckE5N/pWRdksZcO6AF4JUsranZ
 A/NjbilXophdt01D1yLl47drpW5/Zp3N7zUWIZNpfIgHm/R8TGLg9g6mGcL6g4hhUJuzg0iYg4N
 dMm0Trcdf2aGsEkQmlHq4Gp0IeHjo6m35k347GFztibFD9jc/QL8n2bxndrqNJirUwSDiqjWn/m
 Jxe/j6Po9I11mzlRk6SvlFLqc3wQ94wx2wy8vi9PhGukpGoq2jSRoW062z5NKaykwK9bBUpGMw/
 djO8JpvQKO7ZAOpVxaO+YX4615W770IrBufZ7hM6HFfRwa6IWUbx1xarXN2ViqSlZWrscZMVo1/
 DyHNUO2QBK/cqjobjFBn7BBA5AXGbqrXVv1G+EFZjKQMlG1YzJUA6aZaZPi284E3GGINaQA5+Uj
 /ozzqI3pgObnPXFX2Mr+5cQEhejg7pVuG6aws4wWmhzCzhmh5omKOnnP+LfMlAYTszWxXWh0TJ
X-Received: by 2002:a05:7301:2f9b:b0:2f2:5c68:5052 with SMTP id
 5a478bee46e88-3044905ecb1mr4046852eec.13.1779566325414; 
 Sat, 23 May 2026 12:58:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Date: Sat, 23 May 2026 12:56:17 -0700
Message-ID: <20260523195839.454952-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

