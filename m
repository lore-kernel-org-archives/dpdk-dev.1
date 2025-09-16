Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEAECAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05FDF4065B;
	Tue, 16 Sep 2025 17:02:34 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 8C3D74064E
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:02:32 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-76b8fd4ba2cso34956976d6.3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758034952;
 x=1758639752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkA/cn5oiL2mQMil6FnbWz68K4FdjgJpZToX08p7HW8=;
 b=OzhlYkOOqH73l2pZI2mNg1C31wgvDHByoPlr5Ozz+ZVxYparh4b905kX5hnKVSsOCh
 ovAvPwzD3POlqdFJE/NWivK/fFXIBmo2uziS63tkV9qCqYcUbLPHPhjKTjUh29I9Teku
 Jv/2eP4YxR3Thc8xtKbvCFZePRFMtivrB3X5RpGvPIOFiktMpn4KrJpeWhzsoqE6dp+8
 N1lHra11STvzx0OXuW6AXtOSw034zrBJKNnavkoPxa5c0yo4pCyIcaMlGySjF65JWKhf
 pqty1cQDGBLV1gj+xDqHPjHjr/7r76f2nxqDHqlgcx0gI8OoVEurLSoXMA2qQM38erLy
 xcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758034952; x=1758639752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkA/cn5oiL2mQMil6FnbWz68K4FdjgJpZToX08p7HW8=;
 b=HFUzan2cFNXCjZmuSPimA7waOxrCUe2PTj8f9xBFkeJv13yd0N3uCdWl0+6ZD3J94j
 jguMkCPN49Pzwk8usWW1z8WgWXI/euLLshW+TaolHYxD/ByQPL6jTgZO+AVBrF1LxrhV
 Um63RRw65HutvkPCct3LHVPVZjsTjPCH0pPCocjQ0/8Cj93nykbRYaHt7egMiBmzLI3t
 fANUAf4t0kxrSniK11kLw1HC29CnYsGIQXjUJDN5dEmUNi1L1brfWVgJA/fT1niG3sxB
 +f7oOhfkQeVtTqLtZekorbzk7Nrocdmpo2+JRopuhagTMeN2roFZrY59618GgmEy0OmN
 5JIQ==
X-Gm-Message-State: AOJu0YzndYSS8LSjlo5cSPyXVD1RnSNhFzG/tqnowEiI47lSxRlyt0bg
 JGOoyWU+0fos3v+PmOmIRyvERwZjzdfynru/5L7TuvqZU0cdA/b7+gw5yIL4QVxdEayCUKNhmVw
 EzTpr
X-Gm-Gg: ASbGncuHJEVxzGQYGg13Md2NBGQD77svlIk0JQkH9JunGLCFLv19MLNDMhZrrd5jGeP
 zNL0bfko/BOsiGd4rpdefjasDpm/gqjXQCvyLzz6KCUhm0oE6ijQ/NFzPyV2MqyY4FpEU8ZB7mr
 Sk9/EidilQL/LvY5oYkyH0YBH/CKmZq1o656VdEveh/1fdkVcCtIR4tEoCU1qWl636xqA2fJ06p
 cySSXOLu6Ne5jv8bFR90ez9XEii+6lwoX7JWJmACrz/6T7qtlaWGZounRvz1+23JfhIuJwnl6Bb
 ADid4TZx0VFEnPzNJvQS6nkfhL6HxPM9v0FlNNmDBun4lE0lI035razvSSYBzAr8Xxl7lRNoTGi
 xIp7xLBBmBHRt4A/YJvIojm9Fs4dju2C2TWBDYPNn8L1rM56Xan3pZRfeBnbIlhzLMnsV9cgI
X-Google-Smtp-Source: AGHT+IF/HmZQHm5wEqXTb9K+jpw4cjNXNwHEOWNdb1zhk8fj+cWTxZZFz5bLFmZrXynkcVEjXdgqyQ==
X-Received: by 2002:a05:6214:19cd:b0:789:d698:d386 with SMTP id
 6a1803df08f44-789d698dcffmr80246966d6.19.1758034950914; 
 Tue, 16 Sep 2025 08:02:30 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763bee7c80dsm94324306d6.52.2025.09.16.08.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 08:02:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 1/4] hash: move table of hash compare functions out of
 header
Date: Tue, 16 Sep 2025 08:00:44 -0700
Message-ID: <20250916150219.104936-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916150219.104936-1-stephen@networkplumber.org>
References: <0250818233102.180207-1-stephen@networkplumber.org>
 <20250916150219.104936-1-stephen@networkplumber.org>
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
2.47.3

