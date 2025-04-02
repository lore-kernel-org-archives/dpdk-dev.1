Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FCC36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC3414066A;
	Thu,  3 Apr 2025 01:24:56 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 7A6FA4065D
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:55 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6e8ec399427so2576296d6.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636295;
 x=1744241095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpSyP1ACjR3Hz1VpCWZkhgpdnbhuNQ9ONA1Rme7mczo=;
 b=BUOfibxcU1reob8a3txoTpCi9dZt/VMapS+uws+1Rog+EpzFrhiFWCz368HRFbKVZo
 qGSsBL2IcaL+pNsQOR5oGhOX2GZxEj913BlNHWtsbV6MdT2tmFMu5RH49W4Bi6aMkGkH
 B9c78+pjZ6Qq00claRdc6ppBemgAVp/LuYpeRSFiSAg/MvYLNtpotEkSUNERyv1QNMyw
 eF/wR+bS7z6hhv0hKhZpHchszX52P+vb3sZxBy9CeFmSils+9txc11T/5eS+zLBEvmTL
 WQVo0wwzNDM/LKhCcQ+kh4avl1Q1m5RX6AvEJte/Z8OvHBU57e1mtkPQfNxO1pakmx7t
 YQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636295; x=1744241095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpSyP1ACjR3Hz1VpCWZkhgpdnbhuNQ9ONA1Rme7mczo=;
 b=mUS7XgE3sxG/Ut7nRbKK+MAj1lLNiWfv65+srJ352aB6wwyqriYmxUMQStxgMoy4sH
 pxbCKQH/hyJoX12WArW2oy2Usu7MxlKC1F7DeS7d9FfEKkhvIgAg+w8cyB1aEsplgXa8
 6YR9uVchyXVSL6qB3soaLhee2+Cz+vJOugNnep+cd+rwMwzEsxfoWw/VEvg+6zPFqsuo
 APf5VsizUzsFwXEO6NYMLokU9JiJ9k4t1YhELeBg04UlpQrvPqdjDIAOqotMTpL4w9H0
 7/ahyC13BhpxGMxoRKfDOh6Jqlp8TZT+I2DrnqGzHnJoyEbibVQY0gd1ra1cQKyiCvnL
 h/kA==
X-Gm-Message-State: AOJu0Yx0NJjRZzcV1EeBJUzMZmFucz7/PJ7aCQf9cqh/UfXL9qjlbS+4
 fkH/J1CTYFEgmAewGroVFAyz3ZcyR6lff3mNHCRV18eCh/TdnCjhvr0R1d8/qE5z0hiBvT5CYNn
 m
X-Gm-Gg: ASbGnctDG6hAfeQLGQMtf3xurIlZPGpp4kMDopzCeXblvjxSddvR5GVMIl3trblPlw/
 sI1UsRbKO7tiS6paVhhD2yRrL53x4v2m/bzR/FuaZziqDIIitLiuJQpSRoNa986OWiASAd+W6YP
 jjnrWEop07itEyfRWe/IizzrB0lATgCR/lQx/hXYIs8NabEW/2pIEEUO9/e2ZC8qrKkla8eeyG2
 H2kra4XUBaOWkLzuQ0tfWIlfZ8liaVBtkFqomm0Jqg7bdSr9TNWvzrh/HDsqyK6+Z3NwdFg5sHS
 /JKmkXI8/lZFyQDoFn0k/i7RQSkMHtwsZIVaWSUUHoqe1ltuP1dvwVudU6qhhY0VbLKt0J8IYxV
 GWXOejrNBiLnJe1Xz6A==
X-Google-Smtp-Source: AGHT+IFzuQDa0qYhw6FPTGxUlM1XWKWWkcr8qOPTCcaTf9RZWzbdQnqBJaW6KtX/m69kZt9A/cfzkg==
X-Received: by 2002:a05:6214:5081:b0:6e8:ea17:8587 with SMTP id
 6a1803df08f44-6ef02d8af87mr64459616d6.42.1743636294642; 
 Wed, 02 Apr 2025 16:24:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v12 05/10] eal: replace use of sanity check in comments and
 messages
Date: Wed,  2 Apr 2025 16:23:15 -0700
Message-ID: <20250402232441.440346-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Sanity check is on the Tier 2 non-inclusive list.
Replace or remove it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 lib/eal/common/eal_common_proc.c   | 3 ++-
 lib/eal/common/eal_common_trace.c  | 2 +-
 lib/eal/common/eal_memcfg.h        | 2 +-
 lib/eal/common/rte_malloc.c        | 2 +-
 lib/eal/freebsd/eal.c              | 2 +-
 lib/eal/linux/eal.c                | 2 +-
 lib/eal/windows/eal.c              | 2 +-
 8 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index a185e0b580..c3c448fa82 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -564,7 +564,7 @@ check_dma_mask(uint8_t maskbits, bool thread_unsafe)
 	uint64_t mask;
 	int ret;
 
-	/* Sanity check. We only check width can be managed with 64 bits
+	/* We only check width can be managed with 64 bits
 	 * variables. Indeed any higher value is likely wrong. */
 	if (maskbits > MAX_DMA_MASK_BITS) {
 		EAL_LOG(ERR, "wrong dma mask size %u (Max: %u)",
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 201973c5db..2eab49b8e0 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -309,7 +309,8 @@ read_msg(int fd, struct mp_msg_internal *m, struct sockaddr_un *s)
 			break;
 		}
 	}
-	/* sanity-check the response */
+
+	/* Check that the response is valid */
 	if (m->msg.num_fds < 0 || m->msg.num_fds > RTE_MP_MAX_FD_NUM) {
 		EAL_LOG(ERR, "invalid number of fd's received");
 		return -1;
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index 918f49bf4f..9349f5780d 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -468,7 +468,7 @@ __rte_trace_point_register(rte_trace_point_t *handle, const char *name,
 	struct trace_point *tp;
 	uint16_t sz;
 
-	/* Sanity checks of arguments */
+	/* Check arguments */
 	if (name == NULL || register_fn == NULL || handle == NULL) {
 		trace_err("invalid arguments");
 		rte_errno = EINVAL;
diff --git a/lib/eal/common/eal_memcfg.h b/lib/eal/common/eal_memcfg.h
index 60e2089797..e8a85df355 100644
--- a/lib/eal/common/eal_memcfg.h
+++ b/lib/eal/common/eal_memcfg.h
@@ -18,7 +18,7 @@
  * Memory configuration shared across multiple processes.
  */
 struct rte_mem_config {
-	volatile uint32_t magic;   /**< Magic number - sanity check. */
+	volatile uint32_t magic;   /**< Magic number check. */
 	uint32_t version;
 	/**< Prevent secondary processes using different DPDK versions. */
 
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3eed4d4be6..c3a2069010 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -654,7 +654,7 @@ rte_malloc_heap_destroy(const char *heap_name)
 		ret = -1;
 		goto unlock;
 	}
-	/* sanity checks done, now we can destroy the heap */
+	/* checks done, now we can destroy the heap */
 	rte_spinlock_lock(&heap->lock);
 	ret = malloc_heap_destroy(heap);
 	rte_spinlock_unlock(&heap->lock);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index d07cff8651..e9936961c3 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -460,7 +460,7 @@ eal_parse_args(int argc, char **argv)
 		goto out;
 	}
 
-	/* sanity checks */
+	/* options checks */
 	if (eal_check_common_options(internal_conf) != 0) {
 		eal_usage(prgname);
 		ret = -1;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b1e63e37fc..205ea5d8f9 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -765,7 +765,7 @@ eal_parse_args(int argc, char **argv)
 		goto out;
 	}
 
-	/* sanity checks */
+	/* options checks */
 	if (eal_check_common_options(internal_conf) != 0) {
 		eal_usage(prgname);
 		ret = -1;
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 5c7526f922..57f2310f88 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -160,7 +160,7 @@ eal_parse_args(int argc, char **argv)
 	if (eal_adjust_config(internal_conf) != 0)
 		return -1;
 
-	/* sanity checks */
+	/* options checks */
 	if (eal_check_common_options(internal_conf) != 0) {
 		eal_usage(prgname);
 		return -1;
-- 
2.47.2

