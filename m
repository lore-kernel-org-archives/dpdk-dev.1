Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CEBCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3504E40649;
	Tue, 26 Aug 2025 16:49:32 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id CDC5D402AE
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:49:29 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b001f55so30745505e9.0
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756219769;
 x=1756824569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UavgWd9tshkT/onUCS7P0c32eEb5klQ6kO/YJ0PDTfw=;
 b=bo2ZIrwe7va/aV9L7xGdDOMRoXgdxV1AO/gAcKD66GfWuvvVaI7vit7hSWXMLEHs82
 dMG8/l+Ih4tXxk01I7bX8mZ1A/iNtCz9fJa1I2XzeOi/4yUspbzTQqI4SMTnz1/ouQx1
 SLicnomnAUGiXIXvotSECgiwsRh+tSc1MWqoqqUa0FSB7UkO8QWMGuo+J+C9a3VF9s7M
 naxQFKqyGZfQdkJTWM7vfwYCbmIojMSyDJIfrWgaHeilXIth2F5DIQA04GofniTBe3UA
 9cNC+brddgADkiQljFREr8ELV08bh1BAzFBpLkEynE6y6R5xG/JmLUTOJ6XfJuxPk/ly
 wtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219769; x=1756824569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UavgWd9tshkT/onUCS7P0c32eEb5klQ6kO/YJ0PDTfw=;
 b=K6GBAcRxxG0GdZW57duGJulsv/nF73TKFneNS1vNhNKygFc/6RDM1h8V1TXT7EHC/r
 bn3YIXp8SGSykB1KgtcB6g1k2fgEgu/A5W8L1iRzPOL5UzcLyZGfD8GSM0Mgv512YzRg
 2nLEgXGux1E9S41iqVLtoLRkY0mGTsi/FdEoUPSNbuqTWhJkNFuzoErjJJl7jQxaAcOJ
 tvQJSoqQzdu3DGVV15E0J7FH4arU870y6uAMg9AoTt+vi3XsTpNgce5BDgQhkBRUZCh5
 HoyvFuZ9Kf00Bzzx7JNt7+KU6SM8Ww/7hbMkjgpKkWQYpzOWMUKDlb1EvsrlBO5XtueJ
 RfQg==
X-Gm-Message-State: AOJu0YwNhBStS6W1mGLrhhJj+eIw4ngWSH7mJ8RSPprXWuUteQ90WTou
 7U8BjTk71zNDbnGxG8nXfuCagSH6OuWAtNiR3bh0idbVMSIO16Sejm+klILewame5ifevqqItB8
 5qrSg
X-Gm-Gg: ASbGncsNWVkwCsXG7Loo8/iJyzuVtG1/b5CJOnfQTp46TI59oyBuR2suAfdQI+rMmyt
 v3+Ju+M3RtTsc5QS8Evlw7gcJAGlgzFU9gt45fOwDiMq6T208LEcLk8350F9WmLnR5FA8nvLSWA
 Ph/qUrUdtOR/xyvUkC8xZrkny73S3/H4Js5IWGXB9M4KeWE1bSkg58rCghHtWxMCNNaFYVInmKi
 ggDiDQNTOTbIHDAQxHuUniPBcDEyku5HotStPQcNT59YVq0cHIJJUO0xFTXEJ5SWityDl5gnLuk
 JtWH85R1Y9Co+nPd7k4SIjaJUrnbbaX9eB2jFlxyr0lVhYBB33QxXtaKPC+RVxCizGts2siPutZ
 wfXYNdNTQKW6lCKlbK074p/lZYcGt4UN0XnB0Uh7cFCPRVYuJS5/brDvbarufoFpf4o+Qa2pN
X-Google-Smtp-Source: AGHT+IGRBTGp6Q7HoNyFl7YwjU7fzhwPutABdaGLVg8a+Gz/m8vlsU2G2nvkaYN82I6qDwP25tc4rA==
X-Received: by 2002:a05:600c:1386:b0:45b:69c0:1909 with SMTP id
 5b1f17b1804b1-45b69c01d6cmr8447795e9.8.1756219769221; 
 Tue, 26 Aug 2025 07:49:29 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492459sm154566785e9.18.2025.08.26.07.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:49:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 1/4] hash: move table of hash compare functions out of
 header
Date: Tue, 26 Aug 2025 07:48:28 -0700
Message-ID: <20250826144922.74010-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826144922.74010-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250826144922.74010-1-stephen@networkplumber.org>
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
index 2c92c51624..619fe0c691 100644
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
@@ -117,6 +154,25 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
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
@@ -390,13 +446,13 @@ rte_hash_create(const struct rte_hash_parameters *params)
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
@@ -421,13 +477,11 @@ rte_hash_create(const struct rte_hash_parameters *params)
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
index 26a992419a..16fe999c4c 100644
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
2.47.2

