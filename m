Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FDCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 20:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 082FE4060C;
	Thu, 21 Aug 2025 22:36:57 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id C5DE34042C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 22:36:55 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3c51f0158d8so734650f8f.1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755808615;
 x=1756413415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75ohAjnyP6RVaNnsSODtPlLJ27WLIQ5mRMgYL5rrURo=;
 b=rE24YwtNJM9GJI4h9v7u0xmWUpsZ5dEdx3Rs7R/FmBIEG/GlQQ0eoqMvNvJU7tMIVQ
 DCl/XUqBAOX1rZr2EJKxphH9jKDB3gyHaE3gO27IdVcx/UVPhu3uTNV8CFZOfX3Ma8wa
 RybjfRYXehUOy3n6Y8YN9eSMwQ64em4+QTcTaqvPQIsDbnzO9gqcLEb58UJfQdVtSl/1
 Nym7GxCDgLcK/yNSRJlJ6GRZe+P1qovx2da5pAGSbH2VNfiVbaWzxWEhJRBOpE3uFg/f
 ypbZ4WJlu/wPHo5G9DpdiPF1OHw9gNtvz7m3+yXLwNSum6bT/ebLqHKklh2FYC9oDgHC
 411g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755808615; x=1756413415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75ohAjnyP6RVaNnsSODtPlLJ27WLIQ5mRMgYL5rrURo=;
 b=tCDptbFHm2KPCo/mJ+4pc9Dj8uK/EhbOybzOEFG6PItkvcYkwiQDlybkUUBg3ru9rR
 w6CgUG10EQxnW9MgCG4pxxuYZmkD701q8yu5KxZZU5b+AxfyPxScryucipHajH72iolq
 lP4ItfPKEnOqZL5GTjx7L52Xv268RBSpuz1zj3HGggX4JLsH+YhhiCad9cK+HIXvfH5G
 ud1rYwASsSLq9XBBNKNGeoxsoRHYZRxa+6rOgQnm/ld6QEKzUbzPbXt5U5MvOAs4h5hK
 wGNJ6CrRWRJBgFzdjozVDuOw1dp26ZHmKrkrISwFbxS1WKN4VZ2nUJCKgiElEU+BhKUm
 P5kA==
X-Gm-Message-State: AOJu0YyLOor4QTotmJygJN9hToQMzMYE3JCsjnKEi7ugQC5o97HzY2X2
 sGPZD7uE3g/Ci8juEjm9XmrqiFD3nqDD2k4t4f6su3WaQ+aafMNeKF8TMD3bXPYj6qhV+GZcMMj
 0Ef3B
X-Gm-Gg: ASbGncu6Ljz12S1MdpoHO9LiypId/KfFSnQFkki+hlHieUEABqKdLPX5OBjl2BiojxK
 Mqciekp2fwUaHyIYc+3lHOBLr/GxN52kfYtMhbP/zPPd7WElLJvlMxdD0fgfYr+q/Gz041mav5H
 9olfsvuC3U2eqxWuRuKIK1mH2AxmP3ZbDCUEy3Yq2OTCzbxUd2Zfj5JiuzxLkPXAC11H48Z95Oc
 rNjxKPAmxJGVxp+gAEitu+NtbUqimW5zfHKgT3E3Z0tZV5p/1ZNGfES1DIDaEfUJHtAJLIMYbdt
 7hRioonKSrVI746DoMW7/JUnRgijjy7LzOLwuHOnQCdLOWktFBbPLrpyZ3aWDztCzhowN0qfBLt
 s6phJA8OUsg8id6UHBA+TNPUQVWS+osBXQj4uzJDSzHe6gxh3xqfRC/IxXBv9/GookUhDgmiT
X-Google-Smtp-Source: AGHT+IF8D7HI+sIcltdr+HEKz28OSBn5la2Y3ZZF8j9qJ67qv/eykZJyMUxx3m7blLoKz3ptqhaCpA==
X-Received: by 2002:a5d:5886:0:b0:3c0:7e02:67b8 with SMTP id
 ffacd0b85a97d-3c5dcefe359mr187553f8f.60.1755808615327; 
 Thu, 21 Aug 2025 13:36:55 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e8de85bsm17962675e9.7.2025.08.21.13.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 13:36:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 1/3] hash: move table of hash compare functions out of header
Date: Thu, 21 Aug 2025 13:35:08 -0700
Message-ID: <20250821203646.133506-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821203646.133506-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
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

Remove the definition of the compare jump table from the
header file so the internal details are not exposed.
Prevents future ABI breakage if new sizes are added.

Make other macros local if possible, header should
only contain exposed API.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

