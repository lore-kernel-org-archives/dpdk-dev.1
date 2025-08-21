Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06749CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 20:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2586F40653;
	Thu, 21 Aug 2025 22:36:59 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 60EF240652
 for <dev@dpdk.org>; Thu, 21 Aug 2025 22:36:58 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45b4d892175so5685175e9.2
 for <dev@dpdk.org>; Thu, 21 Aug 2025 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755808618;
 x=1756413418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QV2qF8Nhe/j+/xgG+MY9TCcmWxtYggK1G9JKG3N6yRg=;
 b=voyPXDvHmRMZRLpix+HjPrzicSBBi/w5tN6wD/h+SiGNvqUHceZGy/vKkvUEne+OOk
 6hFn5NRUyJVKsCWDHtOLSfbCwswEK3OdjdXeJrzCgO49/9bj7SP/rKPtQj0KGR9SbKV5
 QzzF9394DxTDVt6epwexXh+po8uUjFpp8kNZp0XZvSmoSC1s7CWJe9cLuxECa9SY2R6D
 L6595nz+AA4KPvEkxD1vkem+imLmAu8ZuDNdGRhP7I4hhLl2KMVVliTlPtvmZRgSdMd/
 pOiFm7hY7NBEM9/nnFLEgP8bg7qI5xnOB2ep6ywabvtalRQuzJ6hUsb8GaWc93aYdyjP
 4bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755808618; x=1756413418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QV2qF8Nhe/j+/xgG+MY9TCcmWxtYggK1G9JKG3N6yRg=;
 b=edem10VoOE/XZ8EYvy+c4cqvHwE/b11t1/N1BNDx0+P06bUrVnN4d57YvYv/HjHKy2
 Zhf6FTCk3hGQLzU5NPIWagEmvzF5T7mdURUVzYbj9gPcxLEiUs6OHCIjMAX0pXL/MGcO
 DNC5hO51PchNcd4E0f+1eh+ybdqvaA3Dzwgbc2KuotOzXLk/rYiZflCrfvjqa4abOBrB
 5lSg8QXEDhJRLxPK5zI/8GZUtmSMJR5OZaXAp+ZbgNktIQDe/RXAI5apePxV13KqYGKZ
 G7t/KL49JCKzySjHQTjFAYJKuv/KUAfacv9ufWSL3ay0ugpq67MAXVHyItEww0B6Y3mA
 RZqQ==
X-Gm-Message-State: AOJu0Yx2KqqiR3fKB6jRlEXyikfOPQp8YBq9CCtoPPBt96uFAJdxH5R/
 bpHBxbmPSXsnLDZFJL+3a+0t5kRtiIIg/ZnIPpzoRvTP8oyD4/gTkywkTiGaSdhOWGRAfCg8iyL
 PeRPu
X-Gm-Gg: ASbGnct0JqqLxXbytEF/iPMczm3om1vdI6RExy2kJowB2fLSrom5ZcsjKvZlyVVJ8sl
 EIs6WfVnrw8aFGxR0ylnho0SNQHHJ7YqLBbxInHyIvmhdXpf1dAu4VorfjgJ24i2BVGvSZXAD8g
 9Bco9Ky6e9E878kuIib3YmAbjGBokZwY7WRMLHqICvOiyTCl92gWa/G0ZFGHB6qn13cI2otBbdL
 7uYBJVJyuZgtwRc73YP12VAgZEw1TXal6hTOw+IPNYtNsr/lCdTmaLfUcCWOVf+yBjg14XO9Yc6
 vYzvpgG/p+5Q+JA0IJ/ZB+GqftN6+G2MbosxWAOrr5fxa9K9ria9lIBOP7kPL0eM4OJj4eBDYM/
 XNzx1F3czmyJfgEgbiP/z4X+VJiB3DbtPs8GJ4RzxrjCorxiHAUWzgg4vgDuqR6RJJmBk7HZd
X-Google-Smtp-Source: AGHT+IFdJELQDbHynGO4GIZBtlIiKa+FuK7pQC6poQ5CmJgkDYm2sp60YlpNo009cVnycjWfj75TTw==
X-Received: by 2002:a05:600c:1c87:b0:456:173c:8a53 with SMTP id
 5b1f17b1804b1-45b5179cdd5mr2946035e9.2.1755808617850; 
 Thu, 21 Aug 2025 13:36:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e8de85bsm17962675e9.7.2025.08.21.13.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 13:36:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 2/3] hash: reduce architecture special cases
Date: Thu, 21 Aug 2025 13:35:09 -0700
Message-ID: <20250821203646.133506-3-stephen@networkplumber.org>
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

Make comparison of power of 2 sizes compatible across platforms.
Keep the special case code for 16 bytes for x86 and arm64 but
also add simple xor for others.

Need to make rte_hash_k32_cmp_eq() exposed because ip_frag
code poaches it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cmp_arm64.h   | 52 ----------------------
 lib/hash/rte_cmp_x86.h     | 56 +-----------------------
 lib/hash/rte_cuckoo_hash.c | 90 +++++++++++++++++++++++++++++++++-----
 3 files changed, 80 insertions(+), 118 deletions(-)

diff --git a/lib/hash/rte_cmp_arm64.h b/lib/hash/rte_cmp_arm64.h
index a3e85635eb..c7c56526d0 100644
--- a/lib/hash/rte_cmp_arm64.h
+++ b/lib/hash/rte_cmp_arm64.h
@@ -31,55 +31,3 @@ rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
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
diff --git a/lib/hash/rte_cmp_x86.h b/lib/hash/rte_cmp_x86.h
index ddfbef462f..62ac320b25 100644
--- a/lib/hash/rte_cmp_x86.h
+++ b/lib/hash/rte_cmp_x86.h
@@ -19,58 +19,6 @@ static inline int
 rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
 {
 	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
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
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				(const uint8_t *) key2 + 16, key_len);
 }
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 619fe0c691..3212695d92 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -42,14 +42,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
 #define RETURN_IF_TRUE(cond, retval)
 #endif
 
-#if defined(RTE_ARCH_X86)
-#include "rte_cmp_x86.h"
-#endif
-
-#if defined(RTE_ARCH_ARM64)
-#include "rte_cmp_arm64.h"
-#endif
-
 /*
  * All different options to select a key compare function,
  * based on the key size and custom function.
@@ -57,7 +49,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
  */
 enum cmp_jump_table_case {
 	KEY_CUSTOM = 0,
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	KEY_16_BYTES,
 	KEY_32_BYTES,
 	KEY_48_BYTES,
@@ -66,11 +57,88 @@ enum cmp_jump_table_case {
 	KEY_96_BYTES,
 	KEY_112_BYTES,
 	KEY_128_BYTES,
-#endif
 	KEY_OTHER_BYTES,
 	NUM_KEY_CMP_CASES,
 };
 
+
+#if defined(RTE_ARCH_X86)
+#include "rte_cmp_x86.h"
+#elif defined(RTE_ARCH_ARM64)
+#include "rte_cmp_arm64.h"
+#else
+
+static inline int
+rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint64_t *k1 = key1;
+	const uint64_t *k2 = key2;
+
+	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]);
+}
+
+static inline int
+rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				(const uint8_t *) key2 + 16, key_len);
+}
+#endif
+
+
+static inline int
+rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
+				(const uint8_t *) key2 + 16, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
+				(const uint8_t *) key2 + 32, key_len);
+}
+
+static inline int
+rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 32,
+				(const uint8_t *) key2 + 32, key_len);
+}
+
+static inline int
+rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 64,
+				(const uint8_t *) key2 + 64, key_len);
+}
+
+static inline int
+rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
+				(const uint8_t *) key2 + 64, key_len);
+}
+
+static inline int
+rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
+				(const uint8_t *) key2 + 64, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 96,
+				(const uint8_t *) key2 + 96, key_len);
+}
+
+static inline int
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
@@ -160,7 +228,6 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
  */
 static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_CUSTOM] = NULL,
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
 	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
 	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
@@ -169,7 +236,6 @@ static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
 	[KEY_96_BYTES] = rte_hash_k96_cmp_eq,
 	[KEY_112_BYTES] = rte_hash_k112_cmp_eq,
 	[KEY_128_BYTES] = rte_hash_k128_cmp_eq,
-#endif
 	[KEY_OTHER_BYTES] = memcmp,
 };
 
-- 
2.47.2

