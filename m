Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F9E6BF10
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1895740668;
	Fri, 30 Jan 2026 21:23:40 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 4C03540655
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:38 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so32974675e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804618;
 x=1770409418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq3J/1QEuZ913aWzP1riS5bb5AorZXGGeSybm5bZFdg=;
 b=wb/ZA9Vvuj+7oFN7GusONTIrCuUiHJPK+oTza26wF2DXd0oTI6h4Y28s9h4jWyVlG/
 sg1ko8Q+wpD5lDW0mvB6Pr3H1XSLpSkxYeESzMM3luhV5qQecM8exYp5UhckNjFnBYnD
 G856MxB4XlVP6q+nR9WcCX7cH09yGOG2+pr7sJBL6KnUocXaUCFbvmWZhkFN2aqhgGmL
 jyytC5iO4Py5zCpWAqHNp1kS1ZzDNZNj18k31jiX079IaXSqHENL1G0Bb/R2IAmVTXU/
 wBiNiHtd2rSpAxjZbwUaQ6qgzTcfI+2XnfMIz4KWdOMMDm6+b5FV3Jn+qcvrGPoho3bc
 9kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804618; x=1770409418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dq3J/1QEuZ913aWzP1riS5bb5AorZXGGeSybm5bZFdg=;
 b=HTUaggws4gRqgGagkEbZ7jIT0M1xKgMRZ8lLKwie/dVkEYy38XiCEX0CL2K964NLiP
 L3W8p5BK7bJm5oi01cihbNTvVkIKSICzMJw4hrwUTdX0eD+2Ci1r86Xh88+DBacHJe2r
 Nam1c1pGNz63vzRgnL+wJJGitzvlxX4wEyAL6JXNXk10NcpdERsJmZ+sDhLIZL64ygRR
 z07w4KYJdUgNUsyF79jRN4d6kNStTQcoVvsYG5kjm6GzIwEYrbc61h7QdnK68GAvNCTy
 3qACNEEFcxTIUGOSFWKrEAnNl/Sljnp1+q+yWohZBoCW/6tNDNfPY7mr0zmQO64rU8a0
 8mBA==
X-Gm-Message-State: AOJu0YxCdiTPDmFPZJUKJbP/rdwrrA48+C5rENziKD2AhtP1su27xbJu
 2QFbWbEtc3D3a+xBdwIvs9joGk+bCpFqQhLV78wYS4w0J+7jhOJm/LHD0CscQRb7G9vohrtCfeJ
 9wupS
X-Gm-Gg: AZuq6aIWxtCHinC71oFMaK515lUO1nZSLJXn7UT3kR0wJQnvi+Y/AA/MWlQ5PLFvZes
 xrxhFmFvaRQSI9Nq3i5UB5jZFi/+1hy5M1EO7APsIxdE3V8mueiD4kNlS12ajglWwujAvsg+lJI
 zlETX3HFCo89zGNlOsACOsvr+7IfvQJIMhK8aXGSGjHXCf0zz512Tgm8/xxd7Yfv5CQKaCg70vQ
 Tv0U9lHBn/Z7UK4ymreYsEzsWghnlSPka2ASuqni+7Dk88Jrwm3/nRbz5d4vAbNEJde2iTdRRl0
 dSZIt1yU0EAXu60FxjFt+UojV6J7lk6Yc3e5ZgjLVwCopXa4umG6ay+XVBV8bgp0x+yaLtz+3mB
 ocYt2W67xzgkWgk3JN4/6Qr9kwMDpNIajIf1k7sMPITrUxiul5GsF14fJ9HTLSYmoLDMrSSE8ox
 aSaAo00iYmRvuCUrSTuZG7ucz+QvBP0aDdUua+MTwbUVOdMtyyww==
X-Received: by 2002:a05:600c:a08c:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-482db49ccc8mr44846035e9.29.1769804617844; 
 Fri, 30 Jan 2026 12:23:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 4/7] hash: simplify key comparison across architectures
Date: Fri, 30 Jan 2026 12:21:54 -0800
Message-ID: <20260130202324.37485-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130202324.37485-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260130202324.37485-1-stephen@networkplumber.org>
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

Refactor hash key comparison functions to reduce code duplication
and improve portability:

- Keep optimized 16-byte and 32-byte comparisons for x86 (SSE) and
  ARM64 (NEON), but remove the larger size-specific functions (48,
  64, 80, 96, 112, 128 bytes) from the architecture headers
- Add generic implementation using XOR for platforms without SIMD
- Move larger key comparison functions into rte_cuckoo_hash.c where
  they build upon the 16-byte primitives
- Enable optimized key comparisons on all architectures, not just
  x86 and ARM64

The rte_hash_k32_cmp_eq() function remains exposed because it is
used internally by the IP fragmentation library.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cmp_arm64.h   | 62 +++------------------------
 lib/hash/rte_cmp_generic.h | 35 ++++++++++++++++
 lib/hash/rte_cmp_x86.h     | 62 +++------------------------
 lib/hash/rte_cuckoo_hash.c | 86 +++++++++++++++++++++++++++++++++-----
 4 files changed, 120 insertions(+), 125 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

diff --git a/lib/hash/rte_cmp_arm64.h b/lib/hash/rte_cmp_arm64.h
index a3e85635eb..f209aaf474 100644
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
@@ -25,61 +25,9 @@ rte_hash_k16_cmp_eq(const void *key1, const void *key2,
 }
 
 static inline int
-rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
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
+	return rte_hash_k16_cmp_eq(key1, key2, 16) |
+		rte_hash_k16_cmp_eq((const uint8_t *)key1 + 16,
+				    (const uint8_t *)key2 + 16, 16);
 }
diff --git a/lib/hash/rte_cmp_generic.h b/lib/hash/rte_cmp_generic.h
new file mode 100644
index 0000000000..771180e97a
--- /dev/null
+++ b/lib/hash/rte_cmp_generic.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
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
+	const unaligned_uint64_t *k1 = key1;
+	const unaligned_uint64_t *k2 = key2;
+
+	return !!((k1[0] ^ k2[0]) | (k1[1] ^ k2[1]));
+#else
+	const unaligned_uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return !!((k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) |
+		  (k1[2] ^ k2[2]) | (k1[3] ^ k2[3]));
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
+#endif /* _RTE_CMP_GENERIC_H_ */
diff --git a/lib/hash/rte_cmp_x86.h b/lib/hash/rte_cmp_x86.h
index ddfbef462f..b450150d6d 100644
--- a/lib/hash/rte_cmp_x86.h
+++ b/lib/hash/rte_cmp_x86.h
@@ -4,7 +4,7 @@
 
 #include <rte_vect.h>
 
-/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
+/* Function to compare multiple of 16 byte keys */
 static inline int
 rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
@@ -16,61 +16,9 @@ rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unu
 }
 
 static inline int
-rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
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
+	return rte_hash_k16_cmp_eq(key1, key2, 16) |
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				    (const uint8_t *) key2 + 16, 16);
 }
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 619fe0c691..ce66308c5e 100644
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
+ * Special cases for 16 and 32 bytes to allow for architecture
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
+				    (const uint8_t *) key2 + 16, key_len) |
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
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 64,
+				    (const uint8_t *) key2 + 64, key_len);
+}
+
+static int
+rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
+				    (const uint8_t *) key2 + 64, key_len);
+}
+
+static int
+rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
+				    (const uint8_t *) key2 + 64, key_len) |
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 96,
+				    (const uint8_t *) key2 + 96, key_len);
+}
+
+static int
+rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
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
2.51.0

