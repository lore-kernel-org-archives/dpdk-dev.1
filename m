Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B3CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 001574066F;
	Tue, 26 Aug 2025 16:49:37 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 6D1F440658
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:49:36 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso30000255e9.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756219776;
 x=1756824576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gw9f8a0Dq6WKqyvnn0cAUVwaHJGT9cHQWrhBJfeY63A=;
 b=AXgLINSUQrP9JKe3XMUoA3citVqIpLDteqLkmH26q5GgPqPow051mYTJm4L5UlwLof
 fgMzci638WI1MFxocixgA3E6NyclDUA0FaSiBca1ov23jFHMjVVWyHicIxqAehlYQfEY
 No2YisK8RsET+xK4MHoRSL0IAYv+AmlPlDFDA1BTGJaEwjY7gqXYKkugGrgXjeLPzOA4
 g96EzDxeB3qOAV7tL+PGyfBCCjh7qQDyG25eedjhutoh4COiR4oHrGoCvvKgLfdjUOVi
 R7PQsj9wwwk4m9Z3CJthGknhbZaRY5mMJVmm3tJaXiHPyA6pbycc7wL4RFac5koxZSvK
 nXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219776; x=1756824576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gw9f8a0Dq6WKqyvnn0cAUVwaHJGT9cHQWrhBJfeY63A=;
 b=Tz9C+BEEIr61LWHInk2i5INNBEW73cDPG6l1P46/EjharjcCgX1bHUQfM2yr0azdNg
 oE4F5cW5w+mj3nOqzzZVh5r2d0nQYMD+RJkTKFtxW91r0haJ+wfnkIvWrUbsxelPsZsD
 JwBdSaYMiVB2D80bufAG1fOjyzNS6D5YZY7qzdOhxJIsCulp3OUP4EvFxZkBGCvGHZOo
 kcEdUib5vASWYi0fkItQGOzEFu4jPuDxlZYjK0/dmge4qdLvClCd22ucHvUWkyjdhpW9
 nfUzm5mpSUQXwE7vDRLj6HFg2ne0FGEg4uv7WtUTZFs4pe1sn8zVsmSWhR9ArUKFz4PB
 ui+w==
X-Gm-Message-State: AOJu0YxmLi+qYddpqieb9D48mgYsbn3+u9JPzOmFwV3Zn9+QVxoSrniP
 JMu3z7ztPe7HrH2O44lYVXO8HdKa5JSQVKgwnB3cls4KHL7Gglr74I1/Z3nZvE5FXWHqp/XTF3P
 9dIpf
X-Gm-Gg: ASbGncuyYEMQHRv3HwGptvdk7TnZu6lx5i04n0MpL1uN0vDYQxT/n89YdnGr2dqW8XI
 bswdvr33/fKL4P/DFPY6EQcdx6hAnEyhzN81YUoJYEsp0+4ay5SpHvtSShWPpdrZUjJ6RQj30O5
 0H7zmYf0rB7mrsExu8BwszGHq90L2D4ca79dMo8LFWsiFt90f/wgQkX0TvdThFgo/ZHgBvIZlnD
 bc35OC3F7JGFvRGL1tNPMgukejx7cT2V5eLDOkw/DWiV+GYZpWbOyUK5cOAHxZN9Eb8gbvMDsrr
 3/uE1ugktklkx0jhQ6nFght9APMozPSkd2emZuA+wB41DxD9X96n1XwFovkpmsJdVhKKaNhsUJ9
 u/28thmfzHhXcyumynQNjpN6eX4QhmjebhxqH/mcKnTso19t5vwhXmXpfUePWfNtzJBlKz7xy
X-Google-Smtp-Source: AGHT+IFBH4+RQwm7uhUgabN0P4oQr42FlCZBioEhpFo7V3CCfEZVeS1oxmgICgxgY/HrgLJsLnZwEw==
X-Received: by 2002:a5d:5f81:0:b0:3b8:f2f2:e417 with SMTP id
 ffacd0b85a97d-3c5dcdfc643mr12568364f8f.51.1756219774177; 
 Tue, 26 Aug 2025 07:49:34 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492459sm154566785e9.18.2025.08.26.07.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:49:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 3/4] hash: reduce architecture special cases
Date: Tue, 26 Aug 2025 07:48:30 -0700
Message-ID: <20250826144922.74010-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826144922.74010-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250826144922.74010-1-stephen@networkplumber.org>
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
index 0000000000..f871a794cb
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
+	const unaligned_uint64_t *k1 = key1;
+	const unaligned_uint64_t *k2 = key2;
+
+	return ((k1[0] ^ k2[0]) | (k1[1] ^ k2[1])) != 0;
+#else
+	const unaligned_uint32_t *k1 = key1;
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
index 619fe0c691..608d79d33d 100644
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
+ * Recommend using XOR and | orperator to avoid branching
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
+				    (const uint8_t *) key2 + 16, key_len) ||
+		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
+				    (const uint8_t *) key2 + 32, key_len);
+}
+
+static int
+rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
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

