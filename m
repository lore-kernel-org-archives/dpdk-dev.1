Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B387D2ECF5
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6949A40685;
	Mon, 19 Jan 2026 23:46:17 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id B56E84067D
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:46:15 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so34167615e9.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862775;
 x=1769467575; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xKEaPMSON9KC9eIjwvSXyPN2cp64a6q795HgW/2I5E=;
 b=ezS1Y6Y/tMttWivRbG2wozUKJEjXzJaZi3x0aJFIWvddAgnXVFl3B9Qaep3GKnjQUW
 2Wzr4sg3kJNDHWDmt6GcuWnQkbAqpAmYCbYQUDqmx9tthR+w/c6TKDHK4t62HQkxavOV
 wbU32V9cztCPRu+o8TwXZRG6eU5P2LtVH/nz2hjrHKd4GepddFNXO7XOii8w1nOirMHo
 Ikxdd7lRzVTn/q5vsVg4O3XL43FXPxJp04IIadzmj6L363/2WIrrcVR1kxmWC6QngzWf
 JPZ06WRprI5WufChrZpc0ZvscBFidZ09AR3dMwYopC+hUxY6iCY+HNzdmBdLEnrbs9UD
 23MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862775; x=1769467575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1xKEaPMSON9KC9eIjwvSXyPN2cp64a6q795HgW/2I5E=;
 b=OtkjFrzPfjdo/kR3S2fPmYYqmQlQ8Sqzi/SbcmdeK16+HOxqwYg1D01k7WJe9GrjMH
 grZjVgW6X//jz9vi/VO5z5EUVrlHdH6Go1QcgKoneqz3kCLIsNInaj4FsTwjVfR2VYfd
 VLa1S7h9Kf5ybHM/aPQvCobhTDkFqSbbFNgjo98GXvHJrz0///icm/KIYnKkjQbhlifj
 Dtw1o8mO4Zb+iPYWsX9LVgrfPvrq+7bB1VjfvnBj3CO/qrt1j62LiCAMIBjvDfJvjiBJ
 IprYuZS+Kq7b3s/FyY4Ca28IVD1t0jOb+/ELKgkmzcXsPWi3bMIYATcW81oMl2isbsao
 PChw==
X-Gm-Message-State: AOJu0YwdGV/b798iVS0PHe4ORr+8MAnd8FiiiyHyj4iFOAS62DiNXnFH
 /NgzGvl1VQD84zF6QAjHC5BJkI6gNzwaGnMKHk3txYDAN9dyPTOxFxbsjuODW8ByinZ1LO9q/yZ
 oqA7a
X-Gm-Gg: AY/fxX7CI4qnXufjFY3uKsZO4+9dQ42UrWBuHU2pvwWoLReXRpai3mCExP5iA0S3J9O
 1ZGVOM5Qsb7zv1giczHUntOHJWDTyvEgqcmNIU0kcH1s34AkdK1gXck0NczCu+FdYBeDMxkOguh
 84vuf0I5QK/3XX7zbenrt4srIijzrJ4ErsXWMO4LnNzlPTAZ4JfqzxLhN/6cUiTtkHXTPfQKAgN
 Bp13JyJCb4ZD+OFVqj9K9Mi7aMm/9yjZ2YHdB4rXaQJwHkuOoGipv83Nd+1+K7Uuu7OhXJz+7Ba
 6/x4lg5b7GsMu0UG/G3mgNNfwB/3AmxRWH7np2yQh4KRZTpA8Cq2m16NC/36/zren5SlKou4ibh
 FfkcUwYsDUKCFZVeGhkhcxNXODP/3MDZFzmggDqdhpCz10eFll3xN3yYk48GFbQ4sQr2cDlMdCF
 IWQgFRfaKZaI1qRiiubg9T42w3ME9gDBrezPOhS3U0mkoNYjEQ4w==
X-Received: by 2002:a05:600c:8b6c:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-4801e66fcc5mr144886615e9.10.1768862775349; 
 Mon, 19 Jan 2026 14:46:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:46:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Eimear Morrissey <eimear.morrissey@huawei.com>
Subject: [PATCH v4 6/6] test/soring: fix stringop-overflow warning with LTO
Date: Mon, 19 Jan 2026 14:44:13 -0800
Message-ID: <20260119224553.226243-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119224553.226243-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260119224553.226243-1-stephen@networkplumber.org>
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

When LTO is enabled, GCC inlines through the soring dequeue path into
__rte_ring_dequeue_elems_128(), which copies 32 bytes per element for
128-bit ring elements. The compiler cannot prove at compile time that
this code path is unreachable when elem_size is 4 bytes, resulting in
warnings like:

  warning: writing 32 bytes into a region of size 0 [-Wstringop-overflow=]
  note: at offset 128 into destination object 'dequeued_objs' of size 128

The test allocates uint32_t arrays of 32 elements (128 bytes), which is
correct for 32 elements of 4 bytes each. However, the 128-bit path
would require 512 bytes for 32 elements.

Using __rte_assume or RTE_ASSERT in this case is not enough to
resolve the problem because the condition does not propogate
through the compiler inlining so the compiler still can't
prove the 128-bit path won't be taken.

Increase the array sizes in test_soring_stages() to 128 uint32_t
elements (512 bytes) to accommodate the worst-case 128-bit element
path that the compiler cannot eliminate.

Bugzilla ID: 1726
Fixes: 70581c355d69 ("test/ring: add unit tests for soring API")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_soring.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/app/test/test_soring.c b/app/test/test_soring.c
index 52852692d4..9e8e1e5fae 100644
--- a/app/test/test_soring.c
+++ b/app/test/test_soring.c
@@ -149,12 +149,18 @@ test_soring_stages(void)
 {
 	struct rte_soring *sor = NULL;
 	struct rte_soring_param prm;
-	uint32_t objs[32];
-	uint32_t rcs[32];
-	uint32_t acquired_objs[32];
-	uint32_t acquired_rcs[32];
-	uint32_t dequeued_rcs[32];
-	uint32_t dequeued_objs[32];
+	/*
+	 * The soring/ring code has paths for 4/8/16-byte elements.
+	 * With LTO, GCC cannot eliminate the 16-byte path and warns
+	 * about potential buffer overflow. Size arrays for worst case:
+	 * 32 elements * 16 bytes = 512 bytes = 128 uint32_t.
+	 */
+	uint32_t objs[128];
+	uint32_t rcs[128];
+	uint32_t acquired_objs[128];
+	uint32_t acquired_rcs[128];
+	uint32_t dequeued_rcs[128];
+	uint32_t dequeued_objs[128];
 	size_t ssz;
 	uint32_t stage, enqueued, dequeued, acquired;
 	uint32_t i, ftoken;
-- 
2.51.0

