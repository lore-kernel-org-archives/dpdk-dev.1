Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8CDD46BF6
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7824D402F0;
	Wed, 28 Jan 2026 20:43:27 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 17796402DE
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:43:26 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b7070acfdcso319611eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769629405; x=1770234205; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4uhrP6Qinj/0HR6JEltRwPNRiTBXqGLsi4Vgjk//5s=;
 b=Kw7ZCum04bq3+cgCYKmJehksc3A5AKmodxExHLV7gvJzJjWiM8rTpxs7yhj8Z7xAnm
 zyToXKLshPqiwOP4yse7vDH7r/m2Sk0038kDwF2OkTvfT3A7x/JzbBiAFB1deeLwFyzf
 TNKoakz/VX2F0BTyeO8WIYimBMhleYSZUsm2mnI8l0E08n8STi7RvJUZw7UIvMiBPgMe
 MNQB4ytcgEFMSLjpawJaFpsonWE/T5sDAM+aqg9aacT0gQybhR6LAJxh9BIBsTqWlfCQ
 4sRNdcbbeUhIDLsJz406YV3l2YEXzlRYH8nt55Avmbd8sLNGv7gLS4g8Ct3OdGQVS1Ry
 r3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629405; x=1770234205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q4uhrP6Qinj/0HR6JEltRwPNRiTBXqGLsi4Vgjk//5s=;
 b=lXtHn6z7kaor2IGslZepmUUakRxcsdgmc5DUtcFZ9bqx1dHiTMhbkX6x+EJzh1OlQN
 946yH+9agMmBSFzOPn/6jmQUjBc4pK5dCWxa/Z1ZCm9jizS6SpfdqAB8MMO8StGUYLnd
 AyC4TbnpeTqSB34FHkWozziJHdCg7AlhjBkhXwjVH4c01W021mP56p5/y/flaZxgY+O/
 rgGjq23ftiID5+PtaY7LOXxjgXB/Y8xL8BKejfhwUACRtmeLw3G0KVjcsdmbdzOa5z1k
 wS9W76D87MHjJ8333Ve2MNHNVQJjAGVSB5tCJqgRtxCHyly3nz6rQl66cb2CwnpMRGoD
 SIBQ==
X-Gm-Message-State: AOJu0YzcPSvpRkn0JeipJdi0KypkOdjBmc5T9RRFKljVtNNR5kzWgvKq
 CqGAR3DOTgSHV/lMFk6z313+dG5zzHQJaH9Clvd9JW9soHS8orw0JbgV6MM1/A==
X-Gm-Gg: AZuq6aKY5dUHteZnjIUeyaWMJMZuRpHqDOPVATcgidGVZdGgbFrXhGvXCulFDD+18IV
 Ozd7plopJPImi4lPKm7QPG3ocC/B+5fJJeJz9CWMPkaGxHmUt3eGKFFVQQZt/Ln+GgNFlKe+dZf
 eaoCM9WHNd+lAimUcXIEsF0Nnk5sS3Dgc+sODNTgeD0nIxePtAmaifZrD/ZLyYSRVf8NLhSTgPQ
 Rb4k9bUXk9iqEhylcZONpEXwQWHAhRFvo6qcmwpCNYIaL/8MLWKMQtnILJwX+ePUjRw195BTGYw
 FrdPA+PCJOdDBnURSEAQITf6B96L7jIPDPKFCZ9x47Uder+kEwJXRV/dEVjaFp7tFmkZ1cz6of/
 YlnuYjNZrSDvpRByRTk2drmQLCGKUcRM/43+FHmsTjGJr4CONH5v3ur/PioIukC4KuQ+Lh4ckxt
 Rpwguy+z28n4rEVAuuUOvR62MYvnSPN9bdQnjpDb+TM4Ae53Z1hVfAg4wD1H5V
X-Received: by 2002:a05:7300:72c5:b0:2b6:ffb9:9632 with SMTP id
 5a478bee46e88-2b78da04a08mr4095631eec.28.1769629404875; 
 Wed, 28 Jan 2026 11:43:24 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1adef97sm3928968eec.29.2026.01.28.11.43.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 11:43:24 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, david.marchand@redhat.com,
 Scott Mitchell <scott.k.mitch1@gmail.com>,
 Cyril Chemparathy <cchemparathy@ezchip.com>, stable@dpdk.org
Subject: [PATCH v18 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Date: Wed, 28 Jan 2026 11:41:40 -0800
Message-Id: <20260128194141.90018-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
References: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
 <20260128194141.90018-1-scott.k.mitch1@gmail.com>
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
 app/test/test_hash_functions.c |  2 +-
 lib/eal/include/rte_common.h   | 45 ++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/app/test/test_hash_functions.c b/app/test/test_hash_functions.c
index 70820d1f19..5b8b9c3e5d 100644
--- a/app/test/test_hash_functions.c
+++ b/app/test/test_hash_functions.c
@@ -199,7 +199,7 @@ verify_jhash_32bits(void)
 				hash = rte_jhash(key, hashtest_key_lens[i],
 						hashtest_initvals[j]);
 				/* Divide key length by 4 in rte_jhash for 32 bits */
-				hash32 = rte_jhash_32b((const unaligned_uint32_t *)key,
+				hash32 = rte_jhash_32b((const uint32_t *)key,
 						hashtest_key_lens[i] >> 2,
 						hashtest_initvals[j]);
 				if (hash != hash32) {
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..b10816d0d7 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -121,14 +121,36 @@ extern "C" {
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
+#endif
+
+/**
+ * Types for potentially unaligned access.
+ *
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
+#ifdef RTE_TOOLCHAIN_MSVC
+typedef __rte_may_alias __rte_aligned(1) uint64_t unaligned_uint64_t;
+typedef __rte_may_alias __rte_aligned(1) uint32_t unaligned_uint32_t;
+typedef __rte_may_alias __rte_aligned(1) uint16_t unaligned_uint16_t;
+#else
+typedef uint64_t unaligned_uint64_t __rte_may_alias __rte_aligned(1);
+typedef uint32_t unaligned_uint32_t __rte_may_alias __rte_aligned(1);
+typedef uint16_t unaligned_uint16_t __rte_may_alias __rte_aligned(1);
 #endif
 
 /**
@@ -159,15 +181,6 @@ typedef uint16_t unaligned_uint16_t;
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

