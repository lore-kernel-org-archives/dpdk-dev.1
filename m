Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B1C9EC7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BD1340BA5;
	Mon, 12 Jan 2026 13:04:19 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id D278840DCF
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:04:17 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8b25dd7ab33so480637285a.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768219456; x=1768824256; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eYDnzNFclYspi/5q1R0P5kqWaE/baUUEbcmEHBWJhk=;
 b=F8mNJ//CvwhSK7N/6m6u6HM5BNrh9b19VGDFH41F0HVN8J5cV7WN6THunrwkurwZPk
 5myUA3beOqxINX/0pINe1xpX0hNRMSQZojBfMeN1SJpePMif9Ose9+EaxvFuQGImdQpU
 tbTU5FNxGLYutPRns3bK+h/dQu7yne4gq8adVHI7mesrteOle4o+bZxrhbJdNPhtNlfW
 5J0LrBEn1imPhoqF5JcZlOLAM3hEDLUwYH3LYLXs/F87ZfbM6p24m7+NOyKiEmeXohq/
 XzZHMUNnyeBoB/88lP/vCOoRVjhZ+1U0JXjOVSlsaeDToJ/c/kpEa5Rm3Dv41yPtdGpH
 mLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768219456; x=1768824256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4eYDnzNFclYspi/5q1R0P5kqWaE/baUUEbcmEHBWJhk=;
 b=r+CqPZNYkUroKRfJp8U88qraqu1RSvgAp2sYfmFsMw2rSeIkqAAXUzUEUK4JV/AKwR
 ZXb4j/T2gTndG6bcH6FGS90y5W0vDhK6ozOhgZsGEi7vd97oXd01VRDXQRSDdvjwt+TZ
 BUorL56XYszeFSTd/qWOUJ+nvm13lrmJrq2X7pJ2ssVqeXZdP14myvw5d8s4877hSZBf
 TKek8sUJeVXCb+f8g+Bk0rzz2/sgiPa+NHhXDv+Xhod0ZxG99xNspdiQP7bm3qcSwaFT
 v2jBSn2blgBqGhVsJoz5pV9SzPFQkJMfirOn2hmxUFKTHv9aKpF/Zu/WEkQgtO3I59I9
 Ae5Q==
X-Gm-Message-State: AOJu0YxYK+Ve5A8L+fcdozUIIpmobmT7eh+wbi57i9sbbkLpVCZFxpti
 RvB2QevyzKHIshjxfYgbMIEtZmmdHH9L4HJXiF6VePUlQccUYf3hI7l+UsR8kg==
X-Gm-Gg: AY/fxX4fLn6rmYmuHvuN2ut753FaIUjxiXMZ1H6HfCWWzMo30OnifFiZNxH5FiW8BuO
 MVXst2E1Ak8YCE6LnsR7XiW2rKlgxhD4Nr1pxSpuTnwkWr2PtzWdx8Odo5XZOKgMAXYx7F6K9yx
 heWaa2YywZt77XredilYR2ZBLWYGzLMwwhrADVk5+aohi65KBHACoRy2QveQNFOFqOs5uJNQg3s
 sjrGWVG6CES2xh17VdfT2KlBwnlaTAcCBF8uxjUj6RH14AytQoWcvKKwsJAyA0hsCOYGUTxmqFw
 XbWt75/5XYPnceKMzoAVvXFYtdJMqfXjUVX5bcgU/jAK/0awl5haBxjMCgMz5xG+mHe6GQ9jaxK
 B6THn7raxTKnlGY4FWZ8AONoSdUM8Pa4A5SaFNVlDQkN+4CadNtzWgjV/v7OOGP6fXnoQxH9QTU
 bfeeAZCddA7rZbM9nWGBJVQkWrcphRcNMxvZXsjCwIiA==
X-Google-Smtp-Source: AGHT+IHmj1R1+lIO7Gq++F0625P4Y24ToSqB45PH1VpD7nniG9GFP4QCGErBLz8/os4gXk0P329IyA==
X-Received: by 2002:a05:620a:404b:b0:8b2:d2c9:f6a with SMTP id
 af79cd13be357-8c38940d09emr2490559085a.89.1768219456166; 
 Mon, 12 Jan 2026 04:04:16 -0800 (PST)
Received: from st47p01nt-relayp04.apple.com ([2620:149:13c1:500::12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f5433c6sm1547713885a.52.2026.01.12.04.04.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 04:04:15 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v14 1/2] eal: add __rte_may_alias to unaligned typedefs
Date: Mon, 12 Jan 2026 07:04:10 -0500
Message-Id: <20260112120411.27314-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
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

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 lib/eal/include/rte_common.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..ac70270cfb 100644
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

