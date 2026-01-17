Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647FBC98338
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 21:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF4042F02;
	Sat, 17 Jan 2026 22:21:23 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 97DF74025E
 for <dev@dpdk.org>; Sat, 17 Jan 2026 22:21:19 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-121a0bcd364so3939454c88.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 13:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768684878; x=1769289678; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eYDnzNFclYspi/5q1R0P5kqWaE/baUUEbcmEHBWJhk=;
 b=FjpdjujhskM36dNPxMd8BSShn+PlOArdmjCnrI9Oy9qj5zSpn46MTVd0SQztV2R5pr
 zdZy+gZfpfOP3FQ4vR/vCwUEnZwtcLvLlxMTpu3kATrISyMwH9wmCs1y750B6CmY/DJ6
 XT7aSoSrpyIjXWswuTWwBVE6/2EqP9+2WzXL7tq1CCskUrH6t7q4zPRA1pwuybjgqI6v
 Nga7ku7kxn4sYLCkH9JS4TaiFo98eJMZJpRKz8VMqzJQU9F9H6s4iyS2/f69M8B8yHKf
 1iUzMLhf3NgFfDLWX7X7E77ziM/BU2Ah3JNtwHs+Oo39S/pLK0OyfGmvI3wYMgxJlxPm
 Gnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768684878; x=1769289678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4eYDnzNFclYspi/5q1R0P5kqWaE/baUUEbcmEHBWJhk=;
 b=Cb5If0tMeVxK9kuxnZtGPw+fTSaYLPdw4DX1/hVOIjh38YgDq+eTuwMCsuTWkzlhFO
 Pb7zRSp+mYxtGhNW8aksxx3nbvcrIIeanZvsjrp8WSJjSQbv+9h0HA5/bJmwzwlI9LWS
 DYwsb9/uo2aUseU8XzN1rnBve774ETJtcI4jHm6zE9oMDcOoO0jqJ8dM3zIOkiGhC9Bs
 +/zQp8csTNlZFKL6MwBEuImJYEgseoGG3nAIibXXEboCtbXzCB5E6wWGPygWpm14b6Co
 OVOb3vFx0bh8vB/yA9loiEHOaTkM554IQ2Q173NboEVf9eOO2roRnEqE9emVVrVdQoGF
 ezxQ==
X-Gm-Message-State: AOJu0Yxt5f+Fyq0kyhcfNVQPSeW4yYJVfDACQ7mNTwXfnHA5+5470iD2
 ers+rkRWRZ8jHjEu8j1USJlKDNAOkPHbCOrq5Kk6Iihp5jzIiQ7eoc9LIbmm7w==
X-Gm-Gg: AY/fxX6oMZkVCnN0bedgS49iF0xl3o2wmrjRRhHdKu7T+NP0SYsREHWxYZwuGv6WR+Q
 dBTDiiT4t+SLEYGGy7xSQ3UaOw9Cj3IYmI7FFiFsPOhdA7f8g3LgpzmA6KjcOwav3PMtbkLPrxg
 GTkphewVedmUToRYdy+hGQC1+JplJIDiY/bIU3LXdmSvlD9TNdx0Se6yu0GP4meA5iTNIYleyIg
 jrQgFCascHfLUF91VKKhc4CVIgN1Flb7XhCepFIjZrSNAIAHNdBrbFER+3oX80secUeFS9OsGmy
 Ij/mtq7XlfgqeBpL3ZqqZq8JeuSgQkvkyDO0ae0v0bdgjbaR7Eq6d5vI7d+UV3G3BjZnPlPRwzG
 YznL4F0xCeJzKjX3edKw2GBU/CfrleXa57PYvK911Qsda07+9JITiP6pPBcnp+I1p/tHMJVeiMS
 OV0ZUTcaYla8RtU+lKht6TXQ==
X-Received: by 2002:a05:7022:160c:b0:11d:f464:38b3 with SMTP id
 a92af1059eb24-1244a7150a0mr5798890c88.2.1768684878425; 
 Sat, 17 Jan 2026 13:21:18 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1244af10736sm8480076c88.14.2026.01.17.13.21.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 13:21:18 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v15 1/2] eal: add __rte_may_alias to unaligned typedefs
Date: Sat, 17 Jan 2026 13:21:13 -0800
Message-Id: <20260117212114.10466-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
 <20260117212114.10466-1-scott.k.mitch1@gmail.com>
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

