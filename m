Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C5ECA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4106F40E0C;
	Fri, 22 Aug 2025 20:21:25 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E30C640DFB
 for <dev@dpdk.org>; Fri, 22 Aug 2025 20:21:23 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b00f187so13625975e9.0
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755886883;
 x=1756491683; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2/w1UOP6tP33JCgAWP2cKfBI+k3Pc84Eg89T10xvUU=;
 b=OzCMccm/e4NUBx/MKMw2nNd+QzTEUmyssSLnskhfm2XBBCahldW9NrbQO2FZLgzFJh
 HQqyf2a5kpupn6qep+OSGRv87ndL+RKQNjriAVvHUAcxs/tACeQo4y4D5QK6ubZaMPG2
 1oEFm+EQbHw3fdhDOQldV8/q1vTco1xDLPEKLLUIUT49kqo4WyM9VfQNPBhxh2fjYiB4
 M47kVsPZsebex6DLEZ3kbY0OKp7U8hD7h4OpR1xZPuXRWoUOPxHTTcCQz365PlrokGgo
 gJFg+2xqBrB3nc/WgtE7PgkHCsjHaT0X0jcE0NaOVictGV8ltG+3L6JOyfR6LNmIgobs
 6zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755886883; x=1756491683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2/w1UOP6tP33JCgAWP2cKfBI+k3Pc84Eg89T10xvUU=;
 b=mfQLboOwgGH6PS90APLqN0ocnQ+5ozzfl2aarorRVe5/bGYC2bFmx9i6z0n+jbOr+t
 4EuGT6tX2FngbFQvSlEGmpdhrUiHUd0MqGP6biBmW2hf73oGsYEkbXsNMugDUaEVJ7/r
 XJglz/nK4x2RbGYvNei8YWEgW7yRNDwaE4DqsY2V0hhwugLKeU3Elx/iQyqcjvh6N4Eh
 RLm7dh5ch3MnZFSofpbPunPgSJ6wJgpHjyIF8X1uTHKsp2d3vYxdWbop/qpgklnj3PCL
 Kv9jd5vo8glxtB7Qadhrnjafyt2toreXOYm9gohVu2L++/vrvMG1qYLyyQGMBnCzV+Bh
 R8rg==
X-Gm-Message-State: AOJu0YzfE5WypPz1rXSyHmXkdAHQGipLhy2cTsuUDwSDFnW55bk9i2ln
 GmLSFfnfkalZZIrSRYP+jq8J+uGlxUyVHpyee1tn7UA+sa75CwPvi4IvZYcqO1rERHw5s5nnA+3
 xyo5V
X-Gm-Gg: ASbGncsqiPQDuqXFpLPjcLpPJABflKrAkQIR5G8NJmOy4uCtKC3k73znGt2VORyi5PE
 fFmGYi08WUVQmjkMjzMeh4HjXuCfsJEFHAyk6hEwZaWvHD7DsgTrIFErLQWCV+p7grNSQjj2K+C
 /B9IpZFL+YrBBDpYuS7h2zCULxl9w28AXh9QFDVVYeOaOBopHe4ahrZ2mfuELB+ivg0fB/2Rc05
 85zc6KtA3kj3F48JN1Tv2L/5bBqa6TIybtJK14moBcv3VJxKoviVQOHtSgcJK/uokYUJ66GNts9
 /oH2uzjtA/jRtNGbA83lb23lrvNoE3D7egVa418g5vwY2k181CVix8SouZfpW8MRuC1Pt4G5D95
 4D0nQ3wu2Zll6REkmzYoP/AjoBfyWwXsgNwygba86W/YnI6j/2YeMeed9Wt/ckh7XsVogjHaV
X-Google-Smtp-Source: AGHT+IF4yAvRhin7NlEDbcoeMr1kEoWHZ2Zu2K/3qx1ylevierG9Nh6vOJMHxlb7wG8hNU5eB+huxw==
X-Received: by 2002:a05:600c:350e:b0:456:29da:bb25 with SMTP id
 5b1f17b1804b1-45b517b962bmr33181085e9.19.1755886883318; 
 Fri, 22 Aug 2025 11:21:23 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711ca61d8sm376441f8f.61.2025.08.22.11.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 11:21:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 3/4] hash: reduce architecture special cases
Date: Fri, 22 Aug 2025 11:19:33 -0700
Message-ID: <20250822182110.27599-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822182110.27599-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
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

Make comparison of sizes compatible across platforms.
Keep the special case code for 16 bytes for x86 and arm64 but
also add simple xor for others.

Need to keep rte_hash_k32_cmp_eq() exposed because ip_frag
code poaches it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cmp_arm64.h   | 56 +------------------------
 lib/hash/rte_cmp_generic.h | 35 ++++++++++++++++
 lib/hash/rte_cmp_x86.h     | 60 ++------------------------
 lib/hash/rte_cuckoo_hash.c | 86 +++++++++++++++++++++++++++++++++-----
 4 files changed, 116 insertions(+), 121 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

diff --git a/lib/hash/rte_cmp_arm64.h b/lib/hash/rte_cmp_arm64.h
index a3e85635eb..2b2a37ebd2 100644
--- a/lib/hash/rte_cmp_arm64.h
+++ b/lib/hash/rte_cmp_arm64.h
@@ -2,7 +2,7 @@
  * Copyright(c) 2015 Cavium, Inc
  */
 
-/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
+/* Functions to compare multiple of 16 byte keys */
 static inline int
 rte_hash_k16_cmp_eq(const void *key1, const void *key2,
 		    size_t key_len __rte_unused)
@@ -27,59 +27,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void *key2,
 static inline int
 rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
 {
-	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
 		rte_hash_k16_cmp_eq((const char *) key1 + 16,
 				(const char *) key2 + 16, key_len);
 }
-
-static inline int
-rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 16,
-				(const char *) key2 + 16, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 32,
-				(const char *) key2 + 32, key_len);
-}
-
-static inline int
-rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k32_cmp_eq((const char *) key1 + 32,
-				(const char *) key2 + 32, key_len);
-}
-
-static inline int
-rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len);
-}
-
-static inline int
-rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k32_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len);
-}
-
-static inline int
-rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k32_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 96,
-				(const char *) key2 + 96, key_len);
-}
-
-static inline int
-rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k64_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len);
-}
diff --git a/lib/hash/rte_cmp_generic.h b/lib/hash/rte_cmp_generic.h
new file mode 100644
index 0000000000..f846d562e3
--- /dev/null
+++ b/lib/hash/rte_cmp_generic.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger
+ */
+
+#ifndef _RTE_CMP_GENERIC_H_
+#define _RTE_CMP_GENERIC_H_
+
+/* Function to compare 16 byte keys */
+static inline int
+rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+#ifdef RTE_ARCH_64
+	const uint64_t *k1 = key1;
+	const unaligned_uint64_t *k2 = key2;
+
+	return ((k1[0] ^ k2[0]) | (k1[1] ^ k2[1])) != 0;
+#else
+	const uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) |
+	       (k1[2] ^ k2[2]) | (k1[3] ^ k2[3]);
+#endif
+}
+
+/* Function to compare 32 byte keys */
+static inline int
+rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				(const uint8_t *) key2 + 16, key_len);
+}
+
+#endif
diff --git a/lib/hash/rte_cmp_x86.h b/lib/hash/rte_cmp_x86.h
index ddfbef462f..e7a38c8fcd 100644
--- a/lib/hash/rte_cmp_x86.h
+++ b/lib/hash/rte_cmp_x86.h
@@ -4,7 +4,7 @@
 
 #include <rte_vect.h>
 
-/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
+/* Function to compare multiple of 16 byte keys */
 static inline int
 rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
@@ -18,59 +18,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unu
 static inline int
 rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
 {
-	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 16,
-				(const char *) key2 + 16, key_len);
-}
-
-static inline int
-rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 16,
-				(const char *) key2 + 16, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 32,
-				(const char *) key2 + 32, key_len);
-}
-
-static inline int
-rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k32_cmp_eq((const char *) key1 + 32,
-				(const char *) key2 + 32, key_len);
-}
-
-static inline int
-rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len);
-}
-
-static inline int
-rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k32_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len);
-}
-
-static inline int
-rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k32_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len) ||
-		rte_hash_k16_cmp_eq((const char *) key1 + 96,
-				(const char *) key2 + 96, key_len);
-}
-
-static inline int
-rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
-{
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
-		rte_hash_k64_cmp_eq((const char *) key1 + 64,
-				(const char *) key2 + 64, key_len);
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				(const uint8_t *) key2 + 16, key_len);
 }
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 619fe0c691..199cb62bf0 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -42,13 +42,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
 #define RETURN_IF_TRUE(cond, retval)
 #endif
 
-#if defined(RTE_ARCH_X86)
-#include "rte_cmp_x86.h"
-#endif
-
-#if defined(RTE_ARCH_ARM64)
-#include "rte_cmp_arm64.h"
-#endif
 
 /*
  * All different options to select a key compare function,
@@ -57,7 +50,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
  */
 enum cmp_jump_table_case {
 	KEY_CUSTOM = 0,
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	KEY_16_BYTES,
 	KEY_32_BYTES,
 	KEY_48_BYTES,
@@ -66,11 +58,85 @@ enum cmp_jump_table_case {
 	KEY_96_BYTES,
 	KEY_112_BYTES,
 	KEY_128_BYTES,
-#endif
 	KEY_OTHER_BYTES,
 	NUM_KEY_CMP_CASES,
 };
 
+/*
+ * Comparison functions for different key sizes.
+ * Each function is only called with a specific fixed key size.
+ *
+ * Return value is 0 on equality to allow direct use of memcmp.
+ * Recommend using XOR and | operator to avoid branching
+ * as long as key is smaller than cache line size.
+ *
+ * Key1 always points to key[] in rte_hash_key which is aligned.
+ * Key2 is parameter to insert which might not be.
+ *
+ * Special case for 16 and 32 bytes to allow for architecture
+ * specific optimizations.
+ */
+
+#if defined(RTE_ARCH_X86)
+#include "rte_cmp_x86.h"
+#elif defined(RTE_ARCH_ARM64)
+#include "rte_cmp_arm64.h"
+#else
+#include "rte_cmp_generic.h"
+#endif
+
+static int
+rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				    (const uint8_t *) key2 + 16, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
+				    (const uint8_t *) key2 + 32, key_len);
+}
+
+static int
+rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k32_cmp_eq(key1, key2, key_len) |
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 32,
+				    (const uint8_t *) key2 + 32, key_len);
+}
+
+static int
+rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 64,
+				    (const uint8_t *) key2 + 64, key_len);
+}
+
+static int
+rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
+				    (const uint8_t *) key2 + 64, key_len);
+}
+
+static int
+rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
+				    (const uint8_t *) key2 + 64, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 96,
+				    (const uint8_t *) key2 + 96, key_len);
+}
+
+static int
+rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k64_cmp_eq((const uint8_t *) key1 + 64,
+				(const uint8_t *) key2 + 64, key_len);
+}
+
 /* Enum used to select the implementation of the signature comparison function to use
  * eg: a system supporting SVE might want to use a NEON or scalar implementation.
  */
@@ -160,7 +226,6 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
  */
 static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_CUSTOM] = NULL,
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
@@ -169,7 +234,6 @@ static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_96_BYTES] = rte_hash_k96_cmp_eq,
 	[KEY_112_BYTES] = rte_hash_k112_cmp_eq,
 	[KEY_128_BYTES] = rte_hash_k128_cmp_eq,
-#endif
 	[KEY_OTHER_BYTES] = memcmp,
 };
 
-- 
2.47.2

