Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D5D46BEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B1B4066A;
	Wed, 28 Jan 2026 19:06:44 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 424624065E
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:06:43 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b70abe3417so387146eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769623602; x=1770228402; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy+r6kzx+eJCzk11anqKMx+88xr04wU5NnWR6tQ0Alw=;
 b=OzlG40lWndY4ZjyVyjQJyg+CiXt/Ail5izAgn8dbk3bvvGczXTJ4q8ctCsw7J4yGWy
 duUogKRV20RYu7t4e3tM6BmSZfzRgFPyB2IrYSgRdHTackLZkwaGHOYkXDgfZhPuizmz
 hOVcmpN3Z3aBA2XUo3ZWgK/XrkuqCHZXwlhmV2vpZHpZ+55+quFSaQBYVn049RfRs8Jz
 l9vu3PeW8Uuu40MKG4i9yTd7W8F28c3um0435wpbJXma/1/9t+ul0kbfs6TYvezL9F6n
 ovpdpFIrf8VCHR4MomSnDx5hwwUe0bRHfnX2PRfRmYu6h5k5w76KGoBarUNLJlgqYJjV
 XjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769623602; x=1770228402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xy+r6kzx+eJCzk11anqKMx+88xr04wU5NnWR6tQ0Alw=;
 b=eQleVOQSXIt14mGPCukJj7puVO0ziD0iPyqK6NEB/DPS/hjMAqFEuZtR5xQR3LnSaC
 XZT01sIrH5wmFPsBf4w55CPhDRo3PHZ1sAMxAyr/Jj0YjJsUdwxsb8V+oRulv9+pPA+m
 EBWFTLGf7C7bPP2gFOTfyIXUzHrfTi7yUab/luh4nyllhoEfTODHL9gqpN64j2glIvqr
 ZcTI5YQzgEVCyVy//0OSXAWUIYe70V41AjSYshJ8ZZfaA066t0XfKgdtkBS1w6jnztxZ
 POrOlJOsYKoubddZivXQz6ZVPUIACD3CzPMoT6G1CuzP6LWT4nN5Gu1QQiVlwMpJZ1Dr
 AV1A==
X-Gm-Message-State: AOJu0YxN+xSJ5letJeTcssm2bXCBf4UH3EK0xCwDyMFGs2xSRi7oVbii
 0euqVR1qTos5NG6jdgOS6zLreKPKPi5i1L+yUkR0lk4bmEKndx3wvfFtJvv4WA==
X-Gm-Gg: AZuq6aKZkReAYdpi86iaOkg7F7k2T3LjKo0LZMkYvgZPmaurT5vmAaBrNASohme6ETn
 fwOFUjLRguSSGRFe16Tym2MMICeuK+4MnLOqb3bIDTdZ9aEn/ZwjTqeDnCu3u0y2FB4jg6QfA9a
 AXo2DNtEz8DKET1iqzfwM1PbZzT6FuobrUm7fWTL1S+O9YFwbDJnKCfNhKKpt8RuXS/k8DKIscW
 0xCm8Kkzs88Y2gnPcvWua7GWktuDHMyXUU/VR5pSqX4DtZmkIa6RNeAbZhaHuh5lccVftDzupEN
 YUFp0UzN0dYU/QiepxQW11eIQ+l4ZvISlmS51EGE1c4d3j2xmPl3AZi7RrTgQld9FHFjQlSyyPO
 GsF/wrepe0WlssxTsQz5f39E1q6FQCURpEyvZfBxZtvuvtfmZBSjMsg734euv0dfrUBtmOkiakM
 oEWKWbeAJwnokkXfzTYF6DZJl/JM+gNM/ou4Vdh8hZA6orWTyu1A==
X-Received: by 2002:a05:7300:6d08:b0:2b7:1cbe:fd1f with SMTP id
 5a478bee46e88-2b78da0b511mr3641369eec.36.1769623601897; 
 Wed, 28 Jan 2026 10:06:41 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1af898asm4013042eec.33.2026.01.28.10.06.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 10:06:41 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, david.marchand@redhat.com,
 Scott Mitchell <scott.k.mitch1@gmail.com>,
 Cyril Chemparathy <cchemparathy@ezchip.com>, stable@dpdk.org
Subject: [PATCH v17 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Date: Wed, 28 Jan 2026 10:05:15 -0800
Message-Id: <20260128180516.76786-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
References: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
 <20260128180516.76786-1-scott.k.mitch1@gmail.com>
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
 lib/eal/include/rte_common.h | 39 +++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..15d379619a 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -121,16 +121,32 @@ extern "C" {
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
+typedef uint64_t unaligned_uint64_t __rte_may_alias __rte_aligned(1);
+typedef uint32_t unaligned_uint32_t __rte_may_alias __rte_aligned(1);
+typedef uint16_t unaligned_uint16_t __rte_may_alias __rte_aligned(1);
+
 /**
  * @deprecated
  * @see __rte_packed_begin
@@ -159,15 +175,6 @@ typedef uint16_t unaligned_uint16_t;
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

