Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E5CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 22:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1250402DD;
	Wed,  3 Jun 2026 00:57:28 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 8266E402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 00:57:27 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304f0039c02so8953613eec.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 15:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780441046;
 x=1781045846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/nbAe84xToFXrqKiV/TP+wdvAodJ10RSUYcMQEras9s=;
 b=N/e99MckABwt1Owk1YA5/zWKTLmFCcCN/D8pRXQBNF/qRjWNJHQDLIRz3GHM6GnVQN
 VawUuGID1C59OVT4ZbdexsqWTd5N/cderrF3c7Vz7S3ZoME9/DJId1i/M+2fYbs/c0Vi
 EqemWuX4Qtq7CKOQxbD6E/FPeK/+rWpjVOtWR0a0nmWpWWS+jVBBwIjq5tC4C7sC3yj2
 F0M4KcAeY3FVOuPAzvz/HnKwuno+6uHmyHoOkNDuJ4jwHMUqewzDyB/tpyRmJ/z+0TuT
 OpXdEHT7Ygg2RUtzfFMPB2Z3FuZeYS3yq1f/oD/FJ7oo460TRDcE+X4/W3e48cVeowYv
 xflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780441046; x=1781045846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nbAe84xToFXrqKiV/TP+wdvAodJ10RSUYcMQEras9s=;
 b=UJWz9Fn+X6Cl3XDTAEwhYNj7c/s8e1PvxCorFhuUq84RL5SOom/8DRSud072IAudLt
 Hom83aTuLGA1ykw9qxshv+EFWP42n+ly+qkRdD3zZkA834cVMgPI5/034DSct/kftU/q
 NQs48AhANpAv6KdO2TZcNGq+msiosFIxXmQYkczISafQKbDSm2h4yiNnY11bBjmhCF4U
 0JxprurAHE7TJHtyCFmBFfOJaXe2Bj4ucoY3esnB95Nqjl3napuNIzyODpeG3x+GRGbl
 l1h2qZFjTDZ578eulfEzRuMltCv9E/lnCRvVs71uEdavDwulSuLOpD1tWCb9/Uqs7w0L
 Fr3A==
X-Gm-Message-State: AOJu0YxRo9WpbKK+EZTzqT3dHtfcH5hZ++1MAAh85FMBQsPdoidx956S
 lVHyVj2jwj/zg14GekSk9svWV2yYaCMLmluQun9XQ0LiQgrht3M0dEG0Mc5GrwH0y4KpniVS14W
 ZBaJt
X-Gm-Gg: Acq92OFoXvpWv5UuF28lUromiRVWAo8BD6y/VKFQFN2mcxQlU/NFiEGAAfda+RrRmIb
 nq5W5vaYpDUTvThCgqOAAMSdyRb+Ony0aVjTTkFd3mViYe7RHp9CeImp+SsJHWBJdnxXxloRA8R
 gYtqzbKlFME8OcPkQiBEQTebYqqthl6r75ZlRUr4mrkgsAacJ7Fquuwu5W9gbtIjO5xU7pe7J9y
 T6jwo/naYUyLEW4B34XmPXlC6hEU2uL9zP0OwykkkGWYik9/h5oi2v3YP6oPRnoFtr4gxSQ2UFw
 fMSBAFoBgyHmFvf7dYyLCZGJ3p6xSWWOH4e1H/pRoOK+N2LWnN2Z0DaGussp3rnNso/WCLg7As4
 lrUMTJEWSEYkTh/zSbNzqIIHjtk5fjqN2VGK6YwXmvubxSBHOjMmhwF2sIPzAI1SceI0z85pBji
 j+TyeMJsW/KBNdHdd0Ty5Qs3h/gvU50ycamjO0aNuWwP3pmNdqRYoMnbIfhGwcZ7vPrjIcfuTc
X-Received: by 2002:a05:7301:4b17:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-3074fa52181mr429947eec.4.1780441046210; 
 Tue, 02 Jun 2026 15:57:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dba046esm662531eec.9.2026.06.02.15.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:57:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH] eal: fix function versioning with LTO
Date: Tue,  2 Jun 2026 15:57:22 -0700
Message-ID: <20260602225722.950617-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

When using function versioning and building with Link Time Optimization,
the compiler does not see the __asm__ annotation of symbols and
therefore thinks there are two versions of the same symbol.

The fix is to use compiler symver attribute on the function which
was added in GCC 10. Keep the older method for backward compatibility
with older compilers.

Bugzilla ID: 1949
Fixes: e30e194c4d06 ("eal: rework function versioning macros")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_export.h | 46 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/lib/eal/common/eal_export.h b/lib/eal/common/eal_export.h
index 7e47d34064..1318e6278d 100644
--- a/lib/eal/common/eal_export.h
+++ b/lib/eal/common/eal_export.h
@@ -30,39 +30,61 @@
  * new functionality, behavior, etc.  When that occurs, it is desirable to
  * allow for backwards compatibility for a time with older binaries that are
  * dynamically linked to the dpdk.
+ *
+ * RTE_VERSION_SYMBOL
+ * Create a symbol version table entry binding symbol <name>@DPDK_<ver> to the internal
+ * function name <name>_v<ver>.
+ *
+ * RTE_VERSION_EXPERIMENTAL_SYMBOL similar to RTE_VERSION_SYMBOL but for experimental API symbols.
+ * This is mainly used for keeping compatibility for symbols that get promoted to stable ABI.
+ *
+ * RTE_DEFAULT_SYMBOL
+ * Create a symbol version entry instructing the linker to bind references to
+ * symbol <name> to the internal symbol <name>_v<ver>.
  */
 
 #ifdef RTE_BUILD_SHARED_LIB
 
-/*
- * Create a symbol version table entry binding symbol <name>@DPDK_<ver> to the internal
- * function name <name>_v<ver>.
- */
+/* Prefer the compiler method of versioning which uses attributes */
+#if  __has_attribute(symver)
+
+#define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN	\
+	__attribute__((__symver__(RTE_STR(name) "@DPDK_" RTE_STR(ver)))) \
+	type name ## _v ## ver args;					\
+	type name ## _v ## ver args
+
+#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) VERSIONING_WARN \
+	__attribute__((__symver__(RTE_STR(name) "@EXPERIMENTAL")))	\
+	type name ## _exp args;						\
+	type name ## _exp args
+
+#define RTE_DEFAULT_SYMBOL(ver, type, name, args) VERSIONING_WARN	\
+	__attribute__((__symver__(RTE_STR(name) "@@DPDK_" RTE_STR(ver)))) \
+	type name ## _v ## ver args;					\
+	type name ## _v ## ver args
+#else /* !__has_attribute(symver) */
+
+/* Use asm tag to create symbol table entry */
 #define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN \
 __asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@DPDK_" RTE_STR(ver)); \
 __rte_used type name ## _v ## ver args; \
 type name ## _v ## ver args
 
-/*
- * Similar to RTE_VERSION_SYMBOL but for experimental API symbols.
- * This is mainly used for keeping compatibility for symbols that get promoted to stable ABI.
- */
 #define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) VERSIONING_WARN \
 __asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
 __rte_used type name ## _exp args; \
 type name ## _exp args
 
-/*
- * Create a symbol version entry instructing the linker to bind references to
- * symbol <name> to the internal symbol <name>_v<ver>.
- */
 #define RTE_DEFAULT_SYMBOL(ver, type, name, args) VERSIONING_WARN \
 __asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_" RTE_STR(ver)); \
 __rte_used type name ## _v ## ver args; \
 type name ## _v ## ver args
 
+#endif /* __has_attribute(symver) */
+
 #else /* !RTE_BUILD_SHARED_LIB */
 
+/* static library does not have versioned symbols */
 #define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN \
 type name ## _v ## ver args; \
 type name ## _v ## ver args
-- 
2.53.0

