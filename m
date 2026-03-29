Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6AFF4923
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 033A440668;
	Mon, 30 Mar 2026 01:24:39 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 5F7B040669
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:37 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so62962a91.1
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826676;
 x=1775431476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wALJx15Iuo6HZegClY3W2pEEamDalmopMX9edOhQClg=;
 b=1IBq+doFJb/Z9M0H9Jekx1KXgdrUytFMNempVagbC7GlygPuCkhY7FVwBP8B/k7shA
 jwxwiL6C7fXHEpTzKOnKzfgRgtpTWrdy7K5nm770/aesg2Ea0JPC/rRE95l76vDnYNlY
 Pjm3A7sHx+VCJZ7xVhqTkx4WpG+p8x+OwN++VYGLM/IoSPiUYyF7w16TejjMy0vfOfgy
 p/L3bEEoHJEAY4NclHfApR3xsBUtByrQUvMFIbkmRFm+tk8NJnhXjdxmQBzvkE8rjXSp
 mYcuBl2XaZB0wCLHeWDRnum1VvN+fLrLxzWDxJIK8C9rJAN89oeIZQOjM3d6D3ql/PFl
 fHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826676; x=1775431476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wALJx15Iuo6HZegClY3W2pEEamDalmopMX9edOhQClg=;
 b=MifnFCtYz4JjVJI18kDAAEF2zuiBeBKPoxoBo+emr2dKHvMAbHLYvq/Kqf1IZI9a0R
 cKtFru6lPuVj4a8A88Ss8+O04W+rCg/ryMaBMOTWLODY1gaaJTLQDpSAc4FLbCYSJhFN
 wQy6An3ZDDUvx10eywIgHAkXreF4PKmIcQ7lz/3bpaSGn/1tysNhwa7/sFXmyFVYxl3F
 gBhels1FG/tKlhW8dO3OI/4CyM0iLF6UZSSKWyf9unudj/gyyGRxSn4BSv3YNNi7hxqV
 WO4eSQIDPBtp5iHkgVaWMy/PE1hvBpvg9/p6G8r5RK7/jARLpGr6RLiuOTv6kVyXC1WT
 DAUg==
X-Gm-Message-State: AOJu0Yx+ljrRA46AIUoRVAZn39xGDISUY3ZFw7mt0DiN5bbW35PQQNIY
 zuFPJPjKNz4qQyVK31eECIGnrcYMf4TnHISlCD0sbbKH4phBOt/qV/p4oUHGDQg5JW60JJevHol
 dKVp2
X-Gm-Gg: ATEYQzyi+WEMDljybvq+dfBCZ6I1u29IL4yLmwBYwl/L/qj0kEz2lbdlD6QYLlFbJ2O
 sxnnHF2BbsLxN3Xz5ciHJcz+Flxsbb2nFR1Rac2qN58eJYFhUJpmnP0hdXVv6DjJ/X0iO69Exel
 dpWKvieOA+jYWcOlAdIFQCPT9a8tm+bN1Y/A6oWmY8bQ/3heq6+Z4TAk1mLy29IzEsEBFPBPsal
 IezZfNeWq+Kel4bxJ/l/SWQ/eA/Vl/6DJqogSuhRPDJFI9YIlTljPZwI4RkgKcrfMxzZDj2iW2q
 YLpbmXAWcwQ4x7JBCZ0zuGZpYMKf/NGvQWG4k3PYDYJ2cBoZFjdbAh8pg/eECTkofdF8sHwoEhX
 wpkZL4dd9nrPBsrHoazmN5LG/AqGgTqhqJHBX2RHLvYGwEbjGEJhu8jJNBj5MnyRwkluUnjThMH
 OWEAr8L/SthbnNbzJJOA8CCVD49du6ojIV
X-Received: by 2002:a17:90b:4e85:b0:35b:e566:15a6 with SMTP id
 98e67ed59e1d1-35c300949c4mr11113697a91.28.1774826676489; 
 Sun, 29 Mar 2026 16:24:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 4/7] hash: simplify key comparison across architectures
Date: Sun, 29 Mar 2026 16:22:38 -0700
Message-ID: <20260329232409.205940-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329232409.205940-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260329232409.205940-1-stephen@networkplumber.org>
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
index 9af02f2abd..5bbc3c5464 100644
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
@@ -161,7 +227,6 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
  */
 static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_CUSTOM] = NULL,
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
@@ -170,7 +235,6 @@ static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_96_BYTES] = rte_hash_k96_cmp_eq,
 	[KEY_112_BYTES] = rte_hash_k112_cmp_eq,
 	[KEY_128_BYTES] = rte_hash_k128_cmp_eq,
-#endif
 	[KEY_OTHER_BYTES] = memcmp,
 };
 
-- 
2.53.0

