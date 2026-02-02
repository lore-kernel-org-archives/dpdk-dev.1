Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62ED172C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 04:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92AD140689;
	Mon,  2 Feb 2026 05:48:49 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 39FFB40661
 for <dev@dpdk.org>; Mon,  2 Feb 2026 05:48:48 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2ae2eb49b4bso7927220eec.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 20:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770007727; x=1770612527; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkA25M5bB705bk3ADBbMT4b9l4NNGHF4jcxNLwvovz4=;
 b=K+pZ2J5Y9sdPZ+ztCzraiD0He5DvW/QY74pBqye3JRfglEcXMRcti0GysK5KHq/7oL
 7CkMyE6lX2iHq5/wUdKrB6LNyNzOZqOjya4yE/UKryt3qP7TqRaq1Iwdf7VJMDsIwFGT
 XtSFi5cG4qeVySSF6sZnSJe246Ush/TfbivlCC/pe+prXA2GZjjAqXwzGZGpliZ4VIWd
 6SWeRSWH/yUKHHgH0YzKtKFxp3KDL79Gfy4PhpD8vybTJA3gz8FHdl/orR2V6bIphRga
 FItGGIrJ9GOpveDBtTOW5DjFRd50vI/sqt40smGKfNitOadGj1YbIFxtvMX7IYxirCf7
 PNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770007727; x=1770612527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fkA25M5bB705bk3ADBbMT4b9l4NNGHF4jcxNLwvovz4=;
 b=SgF2OT7ib7MTBrKN9im2WV4ItMttkDFNgYF2kLrfuvU+JIIXlLKhACwEAeN1BxUtqA
 Uj7mZmuCLcedOygmrxm137gcM2EjbPAXcr8lOen1bYBOfX5PGLmWs9fgOGdBneEve2Xi
 OdcKQMYIKNVGaoWoK3lq7uFb7HgCvP1WFdwFq7ViCM9JW11vXm+Ak5PNYVUUezROojmH
 Y01879Fi+gDJrwRDKSC+QA3OTVlWcw8DcM1/rmprPPMWKD7ANlp2SbF9T24/2KcaVt7n
 Y5ujoS/7B7b3VrPpBnf14pUlqvzaLqbIiqN/DxaiqG6n0K0lcjchCYCv478j1WTqocZp
 8sJA==
X-Gm-Message-State: AOJu0YwVHW6S2FTxj8UFIuOlKg7nTRMYmunL4RsJeAdwDG9M8pjw8P5v
 I/wUSO1vUxZyVs0lAvH3a5dipqLueNjYLWtaH5AAbo5kI2dbjafAxsc3Sep53A==
X-Gm-Gg: AZuq6aKUhaR+rTPmurozGB5rdcyvsSvYb19bn2VQo7Tv0yfqFtMegkPraNfIw3JaB6Z
 kRtdHiUCE1shkUXacH6VP1Yj6hAF58mpuins62BXKkwz6NcaJSHuPhCi+eN6zbTKbgRiLzA1+CO
 KYzZRY8MoSMZQfVpxSbosQHblTN7wdoW3BHa5HuzQSlDufaLccSTNVK6QzbHE8FwotE5SzTU4yR
 5trGm6yRxgoByRDWSfwh2SMEnZQG8AHvxAKRlX/YG6dk5+qMJTM3dRfL9C9xHXwqAgOiBD0ttC5
 FmSYDVmzEwruUUsj1dxikM0A4J/GHz32jzwCNflsrMYUBcoq/WeRfp4UUGL0ehRIWNbTwyTLcDc
 sKMv5VYx5dLuPZWc1+qlssQK8pS/r9SISH4/cWDPu+oZ6ZIlnT1DjUOlHXTA2PeBj75uqqUdELC
 F9bhehK0KBZAxTMllHHXR8bZUo6Yc=
X-Received: by 2002:a05:7300:5720:b0:2b7:f25b:9229 with SMTP id
 5a478bee46e88-2b7f25b95f8mr2005383eec.8.1770007726951; 
 Sun, 01 Feb 2026 20:48:46 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9d7f789sm16784293c88.6.2026.02.01.20.48.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 20:48:46 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, david.marchand@redhat.com,
 Scott Mitchell <scott.k.mitch1@gmail.com>,
 Cyril Chemparathy <cchemparathy@ezchip.com>, stable@dpdk.org
Subject: [PATCH v19 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Date: Sun,  1 Feb 2026 20:48:40 -0800
Message-Id: <20260202044841.90945-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260202044841.90945-1-scott.k.mitch1@gmail.com>
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Add __rte_may_alias attribute to unaligned_uint{16,32,64}_t typedefs
to prevent GCC strict-aliasing optimization bugs. GCC has a bug where
it incorrectly elides struct initialization when strict aliasing is
enabled, causing reads from uninitialized memory.

Add __rte_aligned(1) attribute to unaligned_uint{16,32,64}_t typedefs
which allows for safe access at any alignment. Without this, accessing
a uint16_t at an odd address is undefined behavior. Without this
UBSan detects `UndefinedBehaviorSanitizer: undefined-behavior`.

Fixes: 7621d6a8d0bd ("eal: add and use unaligned integer types")
Cc: Cyril Chemparathy <cchemparathy@ezchip.com>
Cc: stable@dpdk.org
Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 app/test/test_hash_functions.c |  6 ++++-
 lib/eal/include/rte_common.h   | 49 +++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/app/test/test_hash_functions.c b/app/test/test_hash_functions.c
index 70820d1f19..9524e3135f 100644
--- a/app/test/test_hash_functions.c
+++ b/app/test/test_hash_functions.c
@@ -187,11 +187,15 @@ verify_jhash_32bits(void)
 {
 	unsigned i, j;
 	uint8_t key[64];
+	/* to guarantee alignment for rte_jhash_32b, use u32 and copy data */
+	uint32_t key32[sizeof(key) / sizeof(uint32_t)];
 	uint32_t hash, hash32;
 
 	for (i = 0; i < 64; i++)
 		key[i] = rand() & 0xff;
 
+	memcpy(key32, key, sizeof(key));
+
 	for (i = 0; i < RTE_DIM(hashtest_key_lens); i++) {
 		for (j = 0; j < RTE_DIM(hashtest_initvals); j++) {
 			/* Key size must be multiple of 4 (32 bits) */
@@ -199,7 +203,7 @@ verify_jhash_32bits(void)
 				hash = rte_jhash(key, hashtest_key_lens[i],
 						hashtest_initvals[j]);
 				/* Divide key length by 4 in rte_jhash for 32 bits */
-				hash32 = rte_jhash_32b((const unaligned_uint32_t *)key,
+				hash32 = rte_jhash_32b(key32,
 						hashtest_key_lens[i] >> 2,
 						hashtest_initvals[j]);
 				if (hash != hash32) {
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..7b36966019 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -121,16 +121,42 @@ extern "C" {
 #define __rte_aligned(a) __attribute__((__aligned__(a)))
 #endif
 
-#ifdef RTE_ARCH_STRICT_ALIGN
-typedef uint64_t unaligned_uint64_t __rte_aligned(1);
-typedef uint32_t unaligned_uint32_t __rte_aligned(1);
-typedef uint16_t unaligned_uint16_t __rte_aligned(1);
+/**
+ * Macro to mark a type that is not subject to type-based aliasing rules
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_may_alias
 #else
-typedef uint64_t unaligned_uint64_t;
-typedef uint32_t unaligned_uint32_t;
-typedef uint16_t unaligned_uint16_t;
+#define __rte_may_alias __attribute__((__may_alias__))
 #endif
 
+/* Unaligned types implementation notes:
+ * __rte_aligned(1) - Reduces alignment requirement to 1 byte, allowing
+ *                    these types to safely access memory at any address.
+ *                    Without this, accessing a uint16_t at an odd address
+ *                    is undefined behavior (even on x86 where hardware
+ *                    handles it).
+ *
+ * __rte_may_alias  - Prevents strict-aliasing optimization bugs where
+ *                    compilers may incorrectly elide memory operations
+ *                    when casting between pointer types.
+ */
+
+/**
+ * Type for safe unaligned u64 access.
+ */
+typedef __rte_may_alias __rte_aligned(1) uint64_t unaligned_uint64_t;
+
+/**
+ * Type for safe unaligned u32 access.
+ */
+typedef __rte_may_alias __rte_aligned(1) uint32_t unaligned_uint32_t;
+
+/**
+ * Type for safe unaligned u16 access.
+ */
+typedef __rte_may_alias __rte_aligned(1) uint16_t unaligned_uint16_t;
+
 /**
  * @deprecated
  * @see __rte_packed_begin
@@ -159,15 +185,6 @@ typedef uint16_t unaligned_uint16_t;
 #define __rte_packed_end __attribute__((__packed__))
 #endif
 
-/**
- * Macro to mark a type that is not subject to type-based aliasing rules
- */
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_may_alias
-#else
-#define __rte_may_alias __attribute__((__may_alias__))
-#endif
-
 /******* Macro to mark functions and fields scheduled for removal *****/
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_deprecated
-- 
2.39.5 (Apple Git-154)

