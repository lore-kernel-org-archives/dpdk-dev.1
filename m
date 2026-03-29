Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010C9FF4927
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 816B74042F;
	Mon, 30 Mar 2026 01:24:25 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id BE2664042C
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:23 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so1803858a91.1
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826663;
 x=1775431463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNjS2h95hzHnkaYN6pKGrRVVgFqa3+D6Q53tlwyMFqw=;
 b=e8vw7ygxJJvVq8xAsELRGCs1BtaAAt8wWeXILMzSlggK1VqtxzoXe0DZB+QdrGBR8Q
 8D8/Q0Jfmh5Fl7fwYukA9dGzOXQe6mmGjTSvWJ25k4ATAt+J1nCv7kpjYvEruV9h0LLO
 I1UgUqxv8EqfwDxooBB4o88lPPex09flllcNdEZa7Kp0JlZ2yvExZJFzlO9K+/Ri6MPb
 R9/hxPr04mWN16IpA2a5v++e4IyMufXkGTgrVQsrNy8/M2FlXt1R06F89MCnKDKjN69f
 hzSoIubHmXOwXDFMKmAuwTDE5UvPgyLqTFqptE1BiBgP00qwNKBJUrF7CJogyAZNTRFJ
 yb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826663; x=1775431463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HNjS2h95hzHnkaYN6pKGrRVVgFqa3+D6Q53tlwyMFqw=;
 b=BkS15ULtEKMEshjwq5hYknKhK7a/FiwPVwma2sPyBg1ayzkRDQrU2xFit65MMGGc9T
 7njqvvo+YCTUudPnGnxI/J92SeXdyKf6lUeHPMTpiVmjcnqTs8dZ+yrtTSsYq4fCvkhS
 gFfSRHhH4BLKDEqGHJ67hL7OdN5o4HmaYWe4XqoKwaB0Gr/S8oZMAmKePgnIDg7LMQQz
 YhyfKTNmA9W0RlWDlYbh4B0I+/ZvimN/Bj3SE/LVI4aFlH7V/asLD0hL6GEuWYYkqIUo
 ysY2rID21WjVmxmRD93bRlAFoPuLLi6aW8O2HwVcbwe5OMS5tNsEswYlIYIvcO6c1xpk
 zYyw==
X-Gm-Message-State: AOJu0YyxGScjHctStNbM79c1hHZIXSyq9o1WS0o9tWKrwRa2t8od8plw
 IHF2EeKLffS75vP3xWfE+TLUdBi18speUxMvcdQfsBgHPBsoxWzSvlHCISOs0KFxqPnasMfq2d0
 AmU54
X-Gm-Gg: ATEYQzySECMKAMnLZENN8MbYr0NicL4/rtLrdm53f6jl88sDYHBfdKLeUFrA1BfphK2
 pupKcQ52dPVlFtvWIfrLre95LmY7peyamsFQABnWZVazgaJ6JsLYl7KsaMVEz9HEmLju8Zq+YB9
 DGW2i5HYkPpILkm02BA0/pJVT9vMqncFZHoru84TrxG0FWXx2eewJ2NxaypzwP/dlaCdfmVPvY4
 COiMUA3vlxxX5e9Aa7dcGx6fgVOJW4YxGxosEHQlgRB+6KY6AdLTtxM1AV5VWfPCNxA1C6hhJ6B
 bqgUgPuNxwzPhnVJnoA62lrkBx5QkS2BzKPxmTnSAH7oOuV4ZVjTV3ZsyRK17wkUOLHT5anVprB
 a2Y8vcI0B7YsDZPxg9RVNYIt4M4k+AmZDRZD5v70xrvDShlrA/SzaWqsPSBUG8VIPIcXBFmBJFO
 jxNuoJv67sX92xlV5gOKVsdPHceX7g/Keh
X-Received: by 2002:a17:90a:d403:b0:35d:a3b4:2f0d with SMTP id
 98e67ed59e1d1-35da3b43086mr2324800a91.6.1774826662847; 
 Sun, 29 Mar 2026 16:24:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 1/7] hash: move table of hash compare functions out of
 header
Date: Sun, 29 Mar 2026 16:22:35 -0700
Message-ID: <20260329232409.205940-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329232409.205940-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260329232409.205940-1-stephen@networkplumber.org>
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

Remove the definition of the compare jump table from the
header file so the internal details are not exposed.
Prevents future ABI breakage if new sizes are added.

Make other macros local if possible, header should
only contain exposed API.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/hash/rte_cuckoo_hash.c | 74 ++++++++++++++++++++++++++++++-----
 lib/hash/rte_cuckoo_hash.h | 79 +-------------------------------------
 2 files changed, 65 insertions(+), 88 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 69dcfdfc39..9af02f2abd 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -25,14 +25,51 @@
 #include <rte_tailq.h>
 
 #include "rte_hash.h"
+#include "rte_cuckoo_hash.h"
 
-/* needs to be before rte_cuckoo_hash.h */
 RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
 #define RTE_LOGTYPE_HASH hash_logtype
 #define HASH_LOG(level, ...) \
 	RTE_LOG_LINE(level, HASH, "" __VA_ARGS__)
 
-#include "rte_cuckoo_hash.h"
+/* Macro to enable/disable run-time checking of function parameters */
+#if defined(RTE_LIBRTE_HASH_DEBUG)
+#define RETURN_IF_TRUE(cond, retval) do { \
+	if (cond) \
+		return retval; \
+} while (0)
+#else
+#define RETURN_IF_TRUE(cond, retval)
+#endif
+
+#if defined(RTE_ARCH_X86)
+#include "rte_cmp_x86.h"
+#endif
+
+#if defined(RTE_ARCH_ARM64)
+#include "rte_cmp_arm64.h"
+#endif
+
+/*
+ * All different options to select a key compare function,
+ * based on the key size and custom function.
+ * Not in rte_cuckoo_hash.h to avoid ABI issues.
+ */
+enum cmp_jump_table_case {
+	KEY_CUSTOM = 0,
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+	KEY_16_BYTES,
+	KEY_32_BYTES,
+	KEY_48_BYTES,
+	KEY_64_BYTES,
+	KEY_80_BYTES,
+	KEY_96_BYTES,
+	KEY_112_BYTES,
+	KEY_128_BYTES,
+#endif
+	KEY_OTHER_BYTES,
+	NUM_KEY_CMP_CASES,
+};
 
 /* Enum used to select the implementation of the signature comparison function to use
  * eg: a system supporting SVE might want to use a NEON or scalar implementation.
@@ -118,6 +155,25 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
 	h->rte_hash_custom_cmp_eq = func;
 }
 
+/*
+ * Table storing all different key compare functions
+ * (multi-process supported)
+ */
+static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
+	[KEY_CUSTOM] = NULL,
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
+	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
+	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
+	[KEY_64_BYTES] = rte_hash_k64_cmp_eq,
+	[KEY_80_BYTES] = rte_hash_k80_cmp_eq,
+	[KEY_96_BYTES] = rte_hash_k96_cmp_eq,
+	[KEY_112_BYTES] = rte_hash_k112_cmp_eq,
+	[KEY_128_BYTES] = rte_hash_k128_cmp_eq,
+#endif
+	[KEY_OTHER_BYTES] = memcmp,
+};
+
 static inline int
 rte_hash_cmp_eq(const void *key1, const void *key2, const struct rte_hash *h)
 {
@@ -406,13 +462,13 @@ rte_hash_create(const struct rte_hash_parameters *params)
 		goto err_unlock;
 	}
 
-/*
- * If x86 architecture is used, select appropriate compare function,
- * which may use x86 intrinsics, otherwise use memcmp
- */
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	/* Select function to compare keys */
 	switch (params->key_len) {
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+	/*
+	 * If x86 architecture is used, select appropriate compare function,
+	 * which may use x86 intrinsics, otherwise use memcmp
+	 */
 	case 16:
 		h->cmp_jump_table_idx = KEY_16_BYTES;
 		break;
@@ -437,13 +493,11 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	case 128:
 		h->cmp_jump_table_idx = KEY_128_BYTES;
 		break;
+#endif
 	default:
 		/* If key is not multiple of 16, use generic memcmp */
 		h->cmp_jump_table_idx = KEY_OTHER_BYTES;
 	}
-#else
-	h->cmp_jump_table_idx = KEY_OTHER_BYTES;
-#endif
 
 	if (use_local_cache) {
 		local_free_slots = rte_zmalloc_socket(NULL,
diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index cf5cd29144..5b3c51348e 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -12,86 +12,9 @@
 #define _RTE_CUCKOO_HASH_H_
 
 #include <stdalign.h>
-
-#if defined(RTE_ARCH_X86)
-#include "rte_cmp_x86.h"
-#endif
-
-#if defined(RTE_ARCH_ARM64)
-#include "rte_cmp_arm64.h"
-#endif
-
-/* Macro to enable/disable run-time checking of function parameters */
-#if defined(RTE_LIBRTE_HASH_DEBUG)
-#define RETURN_IF_TRUE(cond, retval) do { \
-	if (cond) \
-		return retval; \
-} while (0)
-#else
-#define RETURN_IF_TRUE(cond, retval)
-#endif
-
 #include <rte_hash_crc.h>
 #include <rte_jhash.h>
 
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-/*
- * All different options to select a key compare function,
- * based on the key size and custom function.
- */
-enum cmp_jump_table_case {
-	KEY_CUSTOM = 0,
-	KEY_16_BYTES,
-	KEY_32_BYTES,
-	KEY_48_BYTES,
-	KEY_64_BYTES,
-	KEY_80_BYTES,
-	KEY_96_BYTES,
-	KEY_112_BYTES,
-	KEY_128_BYTES,
-	KEY_OTHER_BYTES,
-	NUM_KEY_CMP_CASES,
-};
-
-/*
- * Table storing all different key compare functions
- * (multi-process supported)
- */
-const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
-	NULL,
-	rte_hash_k16_cmp_eq,
-	rte_hash_k32_cmp_eq,
-	rte_hash_k48_cmp_eq,
-	rte_hash_k64_cmp_eq,
-	rte_hash_k80_cmp_eq,
-	rte_hash_k96_cmp_eq,
-	rte_hash_k112_cmp_eq,
-	rte_hash_k128_cmp_eq,
-	memcmp
-};
-#else
-/*
- * All different options to select a key compare function,
- * based on the key size and custom function.
- */
-enum cmp_jump_table_case {
-	KEY_CUSTOM = 0,
-	KEY_OTHER_BYTES,
-	NUM_KEY_CMP_CASES,
-};
-
-/*
- * Table storing all different key compare functions
- * (multi-process supported)
- */
-const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
-	NULL,
-	memcmp
-};
-
-#endif
-
-
 /**
  * Number of items per bucket.
  * 8 is a tradeoff between performance and memory consumption.
@@ -189,7 +112,7 @@ struct __rte_cache_aligned rte_hash {
 	uint32_t hash_func_init_val;    /**< Init value used by hash_func. */
 	rte_hash_cmp_eq_t rte_hash_custom_cmp_eq;
 	/**< Custom function used to compare keys. */
-	enum cmp_jump_table_case cmp_jump_table_idx;
+	unsigned int cmp_jump_table_idx;
 	/**< Indicates which compare function to use. */
 	unsigned int sig_cmp_fn;
 	/**< Indicates which signature compare function to use. */
-- 
2.53.0

