Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B2C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF99340E3A;
	Sun, 20 Sep 2026 20:14:12 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id EB5B640E16
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:06 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so1566521a12.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928046;
 x=1790532846; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Ll3GVPCmgnfNeFJlqD1LC3VCSUTk4+9dPQiUjL1UMQ=;
 b=xkG//RFyGZpTjrjVWjrOHLWigehMJ0irVItaRt9NUZslITiXP94bpTeVInA7NyuR93
 +/yyD6xRsoAiCXbJHWTe2JGXLHNafFp6G8S3taATw2avwfjUvIlZoSJqRxyeUGngqqQe
 7YcWQ5Rr3AJ16N2Zp1u8UOODGG9jea5SpdPn6JlNtMOJhOyifpgyLgC2tI0PepVHWnGl
 WyLqJCGl93vpaPs6tJsIVvZEc4Hf5gFiLlzhHsKRz42ebjrjkIQCE5OhEr/gJLzruqcR
 V4XPvgnc956/+rlHjxf4csNOk1LAKHHO6bfBrZrPQ9A9SXIcv7TVxJ3/0RaksZZajp02
 ziWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928046; x=1790532846;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Ll3GVPCmgnfNeFJlqD1LC3VCSUTk4+9dPQiUjL1UMQ=;
 b=jRTQi6p+5TEQK8z2YiiR5PYv5VQm67HOLO3DnAynkrCCIktNLuaz2gQzT/5EOI91Ml
 DckkaRcFic+9W5Lb5L5jX5L+B9vjezy1tUqkg3DGy7VhkHDJ7kJJHfZKaFDgN7yKmvZe
 O6Mn9kBu1dlvM0QtlFsFekYdB8UQNrHUoG4R7S/Q/pcR391us7AHO1ff9EHCX14SCJ6g
 TvEDbo7aAjyPOd8givbd1YG5NP7SHo2Rkfp2ndNKEBYwRXmxfozXYcAV8Xq0lU8EgJqb
 9vLGsccNinXJkwp3fR8zsW+PHGcFEFNYN1qnNSoPJBsLX2meWZsmIUIbQZhN28AL8oUP
 P09Q==
X-Gm-Message-State: AFuF++lBl0dfmrb9KYVp1Et66KPC5G6OzI3sLbDBmJ+FAcXSznaWvndL
 6lmsdNs+f1u8Yp/vh2wp5mzCAwJXXIyKgS1IIqDY040+fSdaf9hLMNJEhYRfQcoMLpH7VJtzeRz
 vRFPJ
X-Gm-Gg: AYBFou2S56hEPW72R98w76CJWizXKO3D6M2JBcthHXzSJib1BQ5r2sXp36POFcL2a1t
 EldbCIVBg8qD/PWm5nY9rVk/HiRnecpDoVDPT0KjXJKtUCBxIJGBEGDlxpk5MUfmCXY0zLNd4z5
 yqGnp7T6/8JXiMcZT6plPOx2X/jSHiLJbNZXDItMYS17TW90DUWpmhEaWqN4T2NljfoA1D4amNf
 UzL1ct99uZnXh879ArVSf4gY6EU5l9gboit8ZX2dXSYfeymSKKozB2x13MGKUNfeZ1ap2IDrmR4
 bgyCvcTiZHqmDsroO4z1Xk7eB9ouyVdASP+kss7J3Z61uwZwvy+TlKFoVhKS0oVxmvFbGSHpt5K
 C1+xYL7fRFC0eV1eTjYXBC8mo7ZnSMKX9Lt17WK+R4YOeGsbxjqHHkdjJtNjIBhpEi38XGo2R0C
 wUKhV77zaXLVhCC/O5hffnp5saibw7pVKJ5nXXxm1TYUJKwDcoAiJqCnEzmUi/7r/xTOyj2pg6f
 RjUp2oG2wMFXruWlpZFn51nc2f5ru5+Q+0lKg==
X-Received: by 2002:a17:90b:498e:b0:39e:4c7f:8b15 with SMTP id
 98e67ed59e1d1-39e54cf67efmr13754943a91.26.1789928046122; 
 Sun, 20 Sep 2026 11:14:06 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v2 12/33] ring: replace SMP read barrier with C11 acquire fence
Date: Sun, 20 Sep 2026 11:10:04 -0700
Message-ID: <20260920181347.747210-13-stephen@networkplumber.org>
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

rte_smp_rmb() is deprecated. The acquire fence generates the same
code everywhere the gcc implementation is used: a compiler barrier
on x86 and dmb ishld on ThunderX.

The gcc implementation itself is kept: unlike the lock-free stack,
the in-tree comment records a 10% x86 performance drop with the
C11 version, which needs re-measuring with current compilers
before RTE_USE_C11_MEM_MODEL can be removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ring/rte_ring_gcc_pvt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
index 340ece28c7..9c2c58824d 100644
--- a/lib/ring/rte_ring_gcc_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -55,10 +55,10 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 
 	*old_head = d->head;
 
-	/* add rmb barrier to avoid load/load reorder in weak
-	 * memory model. It is noop on x86
+	/* Acquire fence to avoid load/load reorder in weak
+	 * memory model. It is noop on x86.
 	 */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	/*
 	 *  The subtraction is done between two unsigned 32bits value
-- 
2.53.0

