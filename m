Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB5BD74EF5
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:03:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A97B440395;
	Fri, 23 Jan 2026 17:03:16 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 44BF1402E1
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:03:15 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b1981ca515so2708937eec.1
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769184194; x=1769788994; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzRQp61yAvAB9gmU8ZlF71n1Vaz/zQwLcc6k3ojQuFg=;
 b=EzaCKlR9jqO4N4sbz1a4IiohUo6f+nJAnlC6+3+oz5qxB53TdebRjkrGvZIF4XEzng
 g2mKy3faOE/6eRgudjibTJVaUSMeVWCv8G1nKiDB2PEOy1olms56My3oMOU0O1S/K4Se
 jgzuAZKZHUy2e9I4LiX3Ark25SlL5+tQC0ZmY/ieCzMmgOMyWghb48MW60J5y7LtsjkD
 wp98hIQ4oBTJmkAsfvxX/essgV0GcB5N1EkqKiARkgdGncKj5l20c9f4rykX9lcUa1H0
 fgWkTjFipJMpnrO9cbQgWIKoSTRLfYivcID9hDzE2a0olGF9Rvh6z5Z8KrQZ3UcYw+jb
 BdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184194; x=1769788994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hzRQp61yAvAB9gmU8ZlF71n1Vaz/zQwLcc6k3ojQuFg=;
 b=GbEX+NJLYzSPwmZ6u1R32i/LISfxF6g+NWcTykGKonzcKXHc9D6TX17SNq2644f5/2
 m/tyDiPYwZ3MrHVBIfiCwSKdoWQdfh2iy2S63x/7FLS2JEe1efzdheABFMXO+EpelBZx
 GO5sJzFTbLGsHBcZnslWYKOJFjSC97Olv5Xof+wuM0YCLlJbbm0t0kSM6cRSlOmiMm7M
 BgKY8kWWXSx9QAeQ1aUjYjlJLLRm5nEFKbq0vWP7D4n5pV6pnHuvMi2SQn4NFxQ227yb
 HB37cLnhMYRtNkvYCEG2fduvrUXjYncufPzTHnCQziJWXvWw5BAbtiMayVd6bHY7L1Es
 GlNA==
X-Gm-Message-State: AOJu0Yye4ruqM9FlOP9t/wbJROlWJ7ArWWob0OacRWOffHGcE18WAItO
 UJfebr7rNjTaty95v4oPgJ425mUe+KRjk8Wy2aXYGT8D+gy7SMskROcxuvuxjQ==
X-Gm-Gg: AZuq6aI0mNaYUSocoOE/SHIZ3LsScSRYtsfzKfZq0na/6p5HKkqrd7YrJhHdnmDsQ5J
 6HYDuegeTf+CkxNYX52ue9h+Mp1sn93VsVG42NJr0LSPBtmBe74iHxlyaRCvxoD2FXr5VRaBinT
 FxQQ0iz40deACOtNVQW/LsDVhliSdBOWS1sfPgqKE3mF5o8zDiHQmHCw2qRHck/0WYlgmVgrJI+
 nHaQfJleFFU1KO2y82rFiBTWKY9YWbTWvozFjQBItCisZdWL2GKH2uDRvgnBWYsciUuMAt5FL2d
 rGXBa8falX7bfaehjhb5cU7UZa6h5e6BDnZFiTWpP4aJDIrQBvtyXtsakTmzKM1xgxzgcVs/zJC
 3UD+VikJvMW/ys45EqfgqkwJNZuXALcaLNigQo8ytkYtwSI7ouQEw4KtMidlbiIJfUII3f6mF54
 KxXWBxEhiLu9iCcT2LaXzXRw==
X-Received: by 2002:a05:7300:ed0e:b0:2ae:5e93:b69 with SMTP id
 5a478bee46e88-2b739b94bf7mr1543522eec.29.1769184193946; 
 Fri, 23 Jan 2026 08:03:13 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73a6f5d2asm3514158eec.14.2026.01.23.08.03.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Jan 2026 08:03:13 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>,
 Cyril Chemparathy <cchemparathy@ezchip.com>, stable@dpdk.org
Subject: [PATCH v16 1/2] eal: add __rte_may_alias to unaligned typedefs
Date: Fri, 23 Jan 2026 08:02:43 -0800
Message-Id: <20260123160244.57335-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
References: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-1-scott.k.mitch1@gmail.com>
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

The __rte_may_alias attribute signals to the compiler that these types
can alias other types, preventing the incorrect optimization.

Fixes: 7621d6a8d0bd ("eal: add and use unaligned integer types")
Cc: Cyril Chemparathy <cchemparathy@ezchip.com>
Cc: stable@dpdk.org
Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 lib/eal/include/rte_common.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..8a9623ea74 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -121,14 +121,27 @@ extern "C" {
 #define __rte_aligned(a) __attribute__((__aligned__(a)))
 #endif
 
+/**
+ * Macro to mark a type that is not subject to type-based aliasing rules
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_may_alias
+#else
+#define __rte_may_alias __attribute__((__may_alias__))
+#endif
+
+/**
+ * __rte_may_alias avoids compiler bugs (GCC) that elide initialization
+ * of memory when strict-aliasing is enabled.
+ */
 #ifdef RTE_ARCH_STRICT_ALIGN
-typedef uint64_t unaligned_uint64_t __rte_aligned(1);
-typedef uint32_t unaligned_uint32_t __rte_aligned(1);
-typedef uint16_t unaligned_uint16_t __rte_aligned(1);
+typedef uint64_t unaligned_uint64_t __rte_may_alias __rte_aligned(1);
+typedef uint32_t unaligned_uint32_t __rte_may_alias __rte_aligned(1);
+typedef uint16_t unaligned_uint16_t __rte_may_alias __rte_aligned(1);
 #else
-typedef uint64_t unaligned_uint64_t;
-typedef uint32_t unaligned_uint32_t;
-typedef uint16_t unaligned_uint16_t;
+typedef uint64_t unaligned_uint64_t __rte_may_alias;
+typedef uint32_t unaligned_uint32_t __rte_may_alias;
+typedef uint16_t unaligned_uint16_t __rte_may_alias;
 #endif
 
 /**
@@ -159,15 +172,6 @@ typedef uint16_t unaligned_uint16_t;
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

