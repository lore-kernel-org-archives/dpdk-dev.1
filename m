Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D9CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B4EA40DFD;
	Fri, 22 Aug 2025 20:21:20 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 90EB340DDA
 for <dev@dpdk.org>; Fri, 22 Aug 2025 20:21:18 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3c6743a10e3so528499f8f.0
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755886878;
 x=1756491678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UavgWd9tshkT/onUCS7P0c32eEb5klQ6kO/YJ0PDTfw=;
 b=Zh9rlZZuOEtUI/gy8FQl9bIeWNipSHuSAddwFxfDa2+Qbn1nWw2WFSMk9tkcmAlbfZ
 /PUBG2DG2NngDComJHF9feTgPxueLaMtxEkXkzH90PddyI4OIj7tDeabpycnfMtvBFZf
 APfxoGM9WrnbOuceUH4cPBuUJ+mgLgAfXa2z+hoIEmf7WTKT+JF3Fl9+2PE1i4RHqM4p
 DRwYUVjLyIpA2V2+uYeqJXBekEI3xtRrb6Y2d86BGZhOIYYUSmb0Q5qa5UMyg/e5EA65
 Pc1lalqTtvSTeWRHith6ATOA3lF0y24j6ajT7ZQH/1MBT64d0xBzX9hO4/k0WRHEud2L
 rh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755886878; x=1756491678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UavgWd9tshkT/onUCS7P0c32eEb5klQ6kO/YJ0PDTfw=;
 b=S1dmfQc7ctpzO6W+pKvcF5E5EWrVXUEogKPaBVvaWnHkf8VuhsAL93bpKrdvEtKyGF
 07oqJ3kj7Cwqr3Dtt75YhTERAVDt8NK+wogbzAtFiNLXbNY3Ka003YAS1TKbX85zwLQN
 9399OxMjH/khfENl6/6L5xwHmVVwEJ+UoPk7NjIHQm+chB0n+iXixEWj/VIEe0GVkcfk
 MTvJoCgZYrzi9Tp9WVkwaIYAHzRCcoBcrTLa0I79InibIZ2Om1i9r1GFeF1o3FBV5MDR
 2lQAz1+GPrYFPZbzLpf9SoZkw6hY2mO2gFKJMNnuHdPVjW3Zb6MuIqTpbKROe7eDF7C0
 C80w==
X-Gm-Message-State: AOJu0Yys3l3kZq2spmhqaTkOmF15QGQv03KE47n26PoRIhU6wLFebOku
 OzS3cRuQTOkB1MrRsKfqzfzdw0hPTsw09uYsghTCAtsZbYs4BHzpKduzZq/CGyWFswjeuyzcQFj
 dKi14
X-Gm-Gg: ASbGncuJ/SiaQtTBgw8iIFlgqJkFjtOOMvTHNifj+AScpG5ifc+DOnhb3JS7HvnMWsX
 TK4NRwncezEqYtllcCG+TjA0Bm1wq6Gu1M86UlUDT58p2JQ7DG/vkBiRd0MNRW6VqKmS7/hxkqV
 1AE3XTgeuREol2aY4QDVVx7qu3vc9mpah9zF+ar3dLk8ALtka+68cwMGUDxbN/eEgXo/95d/dL7
 RSv51Uw3WSnHzg++qIq78pwgpiLL+f/JIl5zTjMMwEGbO78fd/mLN/gS7J/6oURA6sclp48J0iy
 UBm3/W40jKuti/X5MiTa1XapYT4mWqbDpVKpFdpGV+9nyKIdaRfl/N5HoUqTRXHHJOuG2HpG1f2
 P2ojHIMyJHg5BIFHkJT2l1htMnrXO7jBWgrgpg6ApVVQr6YmfBNy9yKJt6DJe7T8+8gR83J+a
X-Google-Smtp-Source: AGHT+IGbIcZ9PDDyxGQufLbpKQyN33lkjr9wuduQ79ZljzB22VaPT9Yk1bQ40e/c+ve4sJoJx33kQw==
X-Received: by 2002:a05:6000:2404:b0:3b7:9b81:73f6 with SMTP id
 ffacd0b85a97d-3c5dcff3702mr3480958f8f.54.1755886878018; 
 Fri, 22 Aug 2025 11:21:18 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711ca61d8sm376441f8f.61.2025.08.22.11.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 11:21:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 1/4] hash: move table of hash compare functions out of
 header
Date: Fri, 22 Aug 2025 11:19:31 -0700
Message-ID: <20250822182110.27599-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822182110.27599-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
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

