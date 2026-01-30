Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554DDE6BF10
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39A414066E;
	Fri, 30 Jan 2026 21:23:42 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 9093640664
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:40 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so24482215e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804620;
 x=1770409420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1rHKphCyMl4Qj6DehXVpeD+rM9qdkxTSAh+3n4ZpEY=;
 b=q5ghdZLSUaGvwwBxzgW65j0MWpu4oYoVRAipE8uSXoq3gLDoEOYA6+K5Oswel7MLmR
 QZz8jlWF0q/xMrjyiZx6mCxAHvmdxOfYAK9ldZj6ODU5CLgNmYFNgO23OEtNvNofRhOQ
 AA9jpnkWdPGM2Zlmg8QctxRlWlbopMb1IsBV8bKtiFmQK7Xxa50f5b8MG/3Jn5HZM0XQ
 xX67plyxo1sgKR1kHESeGUs4YSycS6mOiweCLtTYeLc21XTZ/BghjL5azwRq36pxFKS1
 Sg2Uu7q0eTkkg1z984E461eUCeOL9Z0Z2eZS1spXBeK4ngZR3LbVvYrv63iJG6z9WYV7
 T46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804620; x=1770409420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u1rHKphCyMl4Qj6DehXVpeD+rM9qdkxTSAh+3n4ZpEY=;
 b=Dfsj6sTqkN+75lDGRNAF7UKFwGRkN0lwkvodJbJVc1qzWCQi0BglWTekraEF4WRs2c
 6GE5LSOVyFPCAk77C9biYIxbvBuABfgAwn9IMvXTIlmxy0oU2GXhvdlLXcOCCYbWRTHH
 cd/lwCtN5yzt5aCbwuO7uxq/03bO5WHLG44ur8KCps78Y7FXZULChGNbD+U4PsyId2yl
 5Fxr69JtT/Jr69oghhPXL2R3RGILo1RMJTtjcU7rosAH1GtGEj9smIqoR58wiGMpWpqo
 jw6m1M8L/ZRgJGeWuZH0ZmqenKsP2or7DMUdyLIXCqRb1l59fXqxl4DxfiYUFBPWi087
 7wDw==
X-Gm-Message-State: AOJu0Yy5myz2LdlbPYZgmZ/qumVl2Y/wTaozxcf0eu6sPvomLjH3GTwb
 LB6qVIKqsQndJp7o3P6K5CP/tqvrWW5jtGMl8yWqMQFxtXNUieTTAYBlclC730PuDZh5dy3fked
 wpfDn
X-Gm-Gg: AZuq6aKtxZi4uvQztnvWQyHVqndAcmY10JNK8AooU16yBquRMHDjqbvxeWQhFagLFiS
 O/BueE4NM6Uu8pDbCEqNJL822UJijYnNm2VOYkBJ9LnK1vTPw8gojuG9xkZF/prlpNbHq/Hm0T1
 sgCs1Pt7UFxLiUenMcggDC8O1Sv1zb6t0KkvIOCdE014S3hDkeESW7RGxyjjUNTTUhA/znhtujT
 B+rWoW/aBe72WyeTwx7gRUWS4b0fpxRf3lBv7bQ7fOF3jgJN/F4GHaIKXMkaO7yg6cjBi5oT9ai
 tR+74PwcIb+2E1F8ZE9hzh2Cuynwzqd7OMjlHuCnQWDZE2NnWKb4gEPeoSIS9hFXluHR3HS0Ey0
 wL8zbmoO32svwfQsfzHhEvDzxwWjmEOvGzR1wzqKJcEd7dHLeM/Kgq4dverPRHUQCs4at72CfbJ
 h80r3kNmZz4bg2miV0ViTHzO/DsfKeL+WiNRDFRX59UcW4cxlPJW8oIof93jWu
X-Received: by 2002:a05:600c:8b12:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-482db4956a2mr48080165e9.29.1769804620088; 
 Fri, 30 Jan 2026 12:23:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 5/7] hash: add support for common small key sizes
Date: Fri, 30 Jan 2026 12:21:55 -0800
Message-ID: <20260130202324.37485-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130202324.37485-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260130202324.37485-1-stephen@networkplumber.org>
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

Add new compare functions for common small key sizes.

Fill in more key sizes to ensure more complete coverage of
special cases.

Bugzilla ID: 1775
Reported-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
Suggested-by: Morten Brørup <mb@smartsharesystems.com>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test/test_hash.c       |  12 +-
 lib/hash/rte_cuckoo_hash.c | 233 +++++++++++++++++++++++++++----------
 2 files changed, 179 insertions(+), 66 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index a70e2620c0..1d140ec2cc 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -35,8 +35,16 @@
  */
 static rte_hash_function hashtest_funcs[] = {rte_jhash, rte_hash_crc};
 static uint32_t hashtest_initvals[] = {0};
-static uint32_t hashtest_key_lens[] = {0, 2, 4, 5, 6, 7, 8, 10, 11, 15, 16, 21, 31, 32, 33, 63, 64};
-#define MAX_KEYSIZE 64
+
+/*
+ * Test common hash key lengths. Make sure and cover all the special cases
+ * in the cmp_jump_table.
+ */
+static uint32_t hashtest_key_lens[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 20,
+	21, 31, 32, 33, 36, 48, 63, 64, 80, 96, 112, 128, 254
+};
+#define MAX_KEYSIZE 256
 /******************************************************************************/
 #define LOCAL_FBK_HASH_ENTRIES_MAX (1 << 15)
 
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index ce66308c5e..e8e625b369 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -49,9 +49,20 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
  * Not in rte_cuckoo_hash.h to avoid ABI issues.
  */
 enum cmp_jump_table_case {
-	KEY_CUSTOM = 0,
+	KEY_CUSTOM,
+	KEY_2_BYTES,
+	KEY_3_BYTES,
+	KEY_4_BYTES,
+	KEY_5_BYTES,
+	KEY_6_BYTES,
+	KEY_8_BYTES,
+	KEY_10_BYTES,
+	KEY_12_BYTES,
+	KEY_14_BYTES,
 	KEY_16_BYTES,
+	KEY_20_BYTES,
 	KEY_32_BYTES,
+	KEY_36_BYTES,
 	KEY_48_BYTES,
 	KEY_64_BYTES,
 	KEY_80_BYTES,
@@ -62,6 +73,17 @@ enum cmp_jump_table_case {
 	NUM_KEY_CMP_CASES,
 };
 
+/* Table of custom key sizes. */
+static const unsigned int cmp_jump_key_size[] = {
+	0,	/* Custom */
+	2,	3,	4,	5,	6,	8,	10,	12,	14,	16,	20,
+	32,	36,	48,	64,	80,	96,	112,	128,
+	UINT32_MAX /* Other */
+};
+
+static_assert(RTE_DIM(cmp_jump_key_size) == NUM_KEY_CMP_CASES,
+	      "cmp_jump_key_size table mismatch");
+
 /*
  * Comparison functions for different key sizes.
  * Each function is only called with a specific fixed key size.
@@ -85,56 +107,154 @@ enum cmp_jump_table_case {
 #include "rte_cmp_generic.h"
 #endif
 
+static inline int
+rte_hash_k2_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const unaligned_uint16_t *k1 = key1;
+	const unaligned_uint16_t *k2 = key2;
+
+	return !!(k1[0] ^ k2[0]);
+}
+
+static int
+rte_hash_k3_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k2_cmp_eq(key1, key2, 2)
+		| (((const uint8_t *)key1)[2] ^ ((const uint8_t *)key2)[2]);
+}
+
+static inline int
+rte_hash_k4_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const unaligned_uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return !!(k1[0] ^ k2[0]);
+}
+
+static int
+rte_hash_k5_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint8_t *k1 = key1;
+	const uint8_t *k2 = key2;
+
+	return rte_hash_k4_cmp_eq(key1, key2, 4) | (k1[4] ^ k2[4]);
+}
+
+static int
+rte_hash_k6_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const unaligned_uint16_t *k1 = key1;
+	const unaligned_uint16_t *k2 = key2;
+
+	return !!((k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]));
+}
+
+static inline int
+rte_hash_k8_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+#ifdef RTE_ARCH_64
+	const unaligned_uint64_t *k1 = key1;
+	const unaligned_uint64_t *k2 = key2;
+
+	return !!(k1[0] ^ k2[0]);
+#else
+	const unaligned_uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]);
+#endif
+}
+
+static int
+rte_hash_k10_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k8_cmp_eq(key1, key2, 8) |
+		rte_hash_k2_cmp_eq((const uint8_t *)key1 + 8,
+				   (const uint8_t *)key2 + 8, 2);
+}
+
 static int
-rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k12_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
-	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
-		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
-				    (const uint8_t *) key2 + 16, key_len) |
-		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
-				    (const uint8_t *) key2 + 32, key_len);
+	const unaligned_uint32_t *k1 = key1;
+	const unaligned_uint32_t *k2 = key2;
+
+	return !!((k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) | (k1[2] ^ k2[2]));
 }
 
 static int
-rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k14_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
-	return rte_hash_k32_cmp_eq(key1, key2, key_len) |
-		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 32,
-				    (const uint8_t *) key2 + 32, key_len);
+	return rte_hash_k8_cmp_eq(key1, key2, 8) |
+		rte_hash_k6_cmp_eq((const uint8_t *)key1 + 8,
+				   (const uint8_t *)key2 + 8, 6);
 }
 
 static int
-rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k20_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
-		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 64,
-				    (const uint8_t *) key2 + 64, key_len);
+	return rte_hash_k16_cmp_eq(key1, key2, 16) |
+		rte_hash_k4_cmp_eq((const uint8_t *)key1 + 16,
+				   (const uint8_t *)key2 + 16, 4);
 }
 
 static int
-rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k36_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
-		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
-				    (const uint8_t *) key2 + 64, key_len);
+	return rte_hash_k32_cmp_eq(key1, key2, 32) |
+		rte_hash_k4_cmp_eq((const uint8_t *)key1 + 32,
+				   (const uint8_t *)key2 + 32, 4);
 }
 
 static int
-rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return	rte_hash_k32_cmp_eq(key1, key2, 32) |
+		rte_hash_k16_cmp_eq((const uint8_t *)key1 + 32,
+				    (const uint8_t *)key2 + 32, 16);
+}
+
+static inline int
+rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
-		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
-				    (const uint8_t *) key2 + 64, key_len) |
-		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 96,
-				    (const uint8_t *) key2 + 96, key_len);
+	return rte_hash_k32_cmp_eq(key1, key2, 32) |
+		rte_hash_k32_cmp_eq((const uint8_t *)key1 + 32,
+				    (const uint8_t *)key2 + 32, 32);
 }
 
 static int
-rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
+rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
 {
-	return rte_hash_k64_cmp_eq(key1, key2, key_len) |
-		rte_hash_k64_cmp_eq((const uint8_t *) key1 + 64,
-				(const uint8_t *) key2 + 64, key_len);
+	return rte_hash_k64_cmp_eq(key1, key2, 64) |
+		rte_hash_k16_cmp_eq((const uint8_t *)key1 + 64,
+				    (const uint8_t *)key2 + 64, 64);
+}
+
+static int
+rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, 64) |
+		rte_hash_k32_cmp_eq((const uint8_t *)key1 + 64,
+				    (const uint8_t *)key2 + 64, 32);
+}
+
+static int
+rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, 64) |
+		rte_hash_k32_cmp_eq((const uint8_t *)key1 + 64,
+				    (const uint8_t *)key2 + 64, 32) |
+		rte_hash_k16_cmp_eq((const uint8_t *)key1 + 96,
+				    (const uint8_t *)key2 + 96, 16);
+}
+
+static int
+rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, 64) |
+		rte_hash_k64_cmp_eq((const uint8_t *)key1 + 64,
+				    (const uint8_t *)key2 + 64, 64);
 }
 
 /* Enum used to select the implementation of the signature comparison function to use
@@ -226,8 +346,19 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
  */
 static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_CUSTOM] = NULL,
+	[KEY_2_BYTES] = rte_hash_k2_cmp_eq,
+	[KEY_3_BYTES] = rte_hash_k3_cmp_eq,
+	[KEY_4_BYTES] = rte_hash_k4_cmp_eq,
+	[KEY_5_BYTES] = rte_hash_k5_cmp_eq,
+	[KEY_6_BYTES] = rte_hash_k6_cmp_eq,
+	[KEY_8_BYTES] = rte_hash_k8_cmp_eq,
+	[KEY_10_BYTES] = rte_hash_k10_cmp_eq,
+	[KEY_12_BYTES] = rte_hash_k12_cmp_eq,
+	[KEY_14_BYTES] = rte_hash_k14_cmp_eq,
 	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
+	[KEY_20_BYTES] = rte_hash_k20_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
+	[KEY_36_BYTES] = rte_hash_k36_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
 	[KEY_64_BYTES] = rte_hash_k64_cmp_eq,
 	[KEY_80_BYTES] = rte_hash_k80_cmp_eq,
@@ -510,41 +641,15 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		goto err_unlock;
 	}
 
-	/* Select function to compare keys */
-	switch (params->key_len) {
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-	/*
-	 * If x86 architecture is used, select appropriate compare function,
-	 * which may use x86 intrinsics, otherwise use memcmp
-	 */
-	case 16:
-		h->cmp_jump_table_idx = KEY_16_BYTES;
-		break;
-	case 32:
-		h->cmp_jump_table_idx = KEY_32_BYTES;
-		break;
-	case 48:
-		h->cmp_jump_table_idx = KEY_48_BYTES;
-		break;
-	case 64:
-		h->cmp_jump_table_idx = KEY_64_BYTES;
-		break;
-	case 80:
-		h->cmp_jump_table_idx = KEY_80_BYTES;
-		break;
-	case 96:
-		h->cmp_jump_table_idx = KEY_96_BYTES;
-		break;
-	case 112:
-		h->cmp_jump_table_idx = KEY_112_BYTES;
-		break;
-	case 128:
-		h->cmp_jump_table_idx = KEY_128_BYTES;
-		break;
-#endif
-	default:
-		/* If key is not multiple of 16, use generic memcmp */
-		h->cmp_jump_table_idx = KEY_OTHER_BYTES;
+	/* fallback if no special case */
+	h->cmp_jump_table_idx = KEY_OTHER_BYTES;
+
+	/* Search table of enum values, 0 is reserved for custom */
+	for (unsigned int key_idx = KEY_2_BYTES; key_idx < KEY_OTHER_BYTES; key_idx++) {
+		if (params->key_len == cmp_jump_key_size[key_idx]) {
+			h->cmp_jump_table_idx = key_idx;
+			break;
+		}
 	}
 
 	if (use_local_cache) {
-- 
2.51.0

