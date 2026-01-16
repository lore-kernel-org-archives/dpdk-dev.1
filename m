Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A6D4A605
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A244F42DA3;
	Fri, 16 Jan 2026 07:46:55 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 7C246410D2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:46:54 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b86ed375d37so224913366b.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546014;
 x=1769150814; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boQcwVjYbcBuQRxSEGP777zpG9Oh0PC1VgL38lUXTS4=;
 b=lL/BRMC0qb0pa/A/ESul1Bod4b2FeTWBa0uf3Et4JbB8a6D1MjzHCjNhaZ06sTOs2i
 PTrp1/RcRGZIvPUBBA3qAb7hovilhvG4nD5wjo/p7NQcOxW5NZAAmxV2wKfcYN+Oqj/b
 IXNAhFB+soFf2Cz9GmnQYwouys2lJqS7L0eB9L6zLmdKAWzrornEGVLj53a6cHcz22of
 Ec/wHOtbBhuyt+5EgUrm/Kt8XA6Fwram11vHuJSQK3vPHIMagKdFz5c+SOcaG6QlJmzw
 OdeMv2sobb+5Ku1mtxqg7h50aGmK/8/ara1iWUJaBUgAV9avVcUp8wwC0Z4WRrXcMN3V
 PiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546014; x=1769150814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=boQcwVjYbcBuQRxSEGP777zpG9Oh0PC1VgL38lUXTS4=;
 b=INAQTUCLv+zZUJo3YTyy/d7StKr9xb3hYuYVF8g+peUVQkYPqjnJR64cr9fC71HV9E
 YxhIDGgbdozZzY7BPp3vvFW4kS3nYmXbwpSPq+gBj+LRe0V3xsQiPEj/CSWQ9vswR1NH
 gZ9dkWmICyFQrXQWfIrsoNOfrgd6MRLtgPivjNMfU7C5HQYL37KJcnXdnXabWs8Zc5l7
 KvoClhlN2O3j5fczLZArOWLnQy2JoiI3Na/8oGiY/tXhh5l64gHtjZerRuICdCqA1Un0
 qLC6f0JuHkCMDzm4/ge6JN/G9OuVoEaZ8+SF3rHkAN3R5b1FKruu7ukiBOeWYR1xpIaM
 VRCA==
X-Gm-Message-State: AOJu0YwoSdKI7i3bkFLHSkwV/mfa/3psehCJNK6zkf4FK1yKrtLLBOrI
 hrSubnWNzY2uAcvQmnWOUutQLTbFERTR72QEmzpDjYRBnmo0IOSAwClVIbi4I/kCdSs7ziQxh7g
 tqYag
X-Gm-Gg: AY/fxX5rSdqb07D/qwxrP4Lem0xZHPRhWzgX+OccYcoa+Za6+59QvP7g/4P6ocdP+cu
 T86HDI32mEMPBsuRKUnyNRs9sfRVuyDnMuBqIeXck1rS4dX/cM2a3mBPzIWUq1I5lwAyH1qabl7
 ikx2j72YnZtgdK9RKDI3HVzHwk32dMfwY6ypuAoV/9Yc1o95dhZwkBqnQ9CkREcJ0YjshmfzhYo
 eKvSeaonjm5XmTZZDKHxPeOcYaY/5PK6a75hLJ0XC86A4Ob2RNNwt+x7j8rtmJVoeihj97fWAhx
 kCnDqKPCKy5DUYgsewTeuAjgSZIXj33g8RhKSzpv2pNCozJP2oW2a/Iz3EGg+Q3Lp6R1599/iRA
 FT/V8888lqnRlw+JWNV20TpmYBfrsVYYbjsKkomgQvGCnKEwayWAvQMe9eugeLe4cCDJXn6dgSF
 4GbpiCl5Xkxs+Wlb7m1fDHtdgkkFINxtP2z9n5xIX+94C9pVKrxw==
X-Received: by 2002:a17:907:960b:b0:b83:15cb:d491 with SMTP id
 a640c23a62f3a-b879323e471mr165147366b.53.1768546013520; 
 Thu, 15 Jan 2026 22:46:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:46:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Date: Thu, 15 Jan 2026 22:46:22 -0800
Message-ID: <20260116064646.224254-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116064646.224254-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
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

When building with LTO (Link Time Optimization), GCC performs
aggressive cross-compilation-unit inlining. This causes the compiler
to analyze all code paths in __rte_ring_do_dequeue_elems(), including
the 16-byte element path (__rte_ring_dequeue_elems_128), even when
the runtime element size is only 4 bytes.

The static analyzer sees that the 16-byte path would copy
32 elements * 16 bytes = 512 bytes into a 128-byte buffer (uint32_t[32]),
triggering -Wstringop-overflow warnings.

The existing #pragma GCC diagnostic suppression in rte_ring_elem_pvt.h
doesn't help because with LTO the warning context shifts to the test
file where the inlined code is instantiated.

Fix by sizing all buffers passed to soring acquire/dequeue functions
for the worst-case element size (16 bytes = 4 * sizeof(uint32_t)).
This satisfies the static analyzer without changing runtime behavior.

Bugzilla ID: 1458

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_soring.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/app/test/test_soring.c b/app/test/test_soring.c
index 3c1944424e..96be3935d4 100644
--- a/app/test/test_soring.c
+++ b/app/test/test_soring.c
@@ -31,6 +31,19 @@
 
 #define MAX_ACQUIRED 20
 
+/*
+ * Buffer scaling factor for static analyzer appeasement.
+ *
+ * With LTO, GCC analyzes all code paths in __rte_ring_do_dequeue_elems(),
+ * including the 16-byte element path, even when runtime esize is smaller.
+ * Buffers passed to soring acquire/dequeue must be sized for the worst-case
+ * element size (16 bytes) to avoid -Wstringop-overflow warnings.
+ *
+ * Scale factor of 4 converts uint32_t count to 16-byte element capacity:
+ * N elements * 4 * sizeof(uint32_t) = N * 16 bytes
+ */
+#define SORING_TEST_BUFSIZE(n) ((n) * 4)
+
 #define SORING_TEST_ASSERT(val, expected) do { \
 	RTE_TEST_ASSERT(expected == val, \
 			"%s: expected %u got %u\n", #val, expected, val); \
@@ -58,7 +71,8 @@ move_forward_stage(struct rte_soring *sor,
 {
 	uint32_t acquired;
 	uint32_t ftoken;
-	uint32_t *acquired_objs[MAX_ACQUIRED];
+	/* Sized for 16-byte elements to satisfy LTO static analysis */
+	uint32_t *acquired_objs[SORING_TEST_BUFSIZE(MAX_ACQUIRED)];
 
 	acquired = rte_soring_acquire_bulk(sor, acquired_objs, stage,
 			num_packets, &ftoken, NULL);
@@ -149,12 +163,13 @@ test_soring_stages(void)
 {
 	struct rte_soring *sor = NULL;
 	struct rte_soring_param prm;
-	uint32_t objs[32];
-	uint32_t rcs[32];
-	uint32_t acquired_objs[32];
-	uint32_t acquired_rcs[32];
-	uint32_t dequeued_rcs[32];
-	uint32_t dequeued_objs[32];
+	/* Buffers sized for 16-byte elements to satisfy LTO static analysis */
+	uint32_t objs[SORING_TEST_BUFSIZE(32)];
+	uint32_t rcs[SORING_TEST_BUFSIZE(32)];
+	uint32_t acquired_objs[SORING_TEST_BUFSIZE(32)];
+	uint32_t acquired_rcs[SORING_TEST_BUFSIZE(32)];
+	uint32_t dequeued_rcs[SORING_TEST_BUFSIZE(32)];
+	uint32_t dequeued_objs[SORING_TEST_BUFSIZE(32)];
 	size_t ssz;
 	uint32_t stage, enqueued, dequeued, acquired;
 	uint32_t i, ftoken;
-- 
2.51.0

