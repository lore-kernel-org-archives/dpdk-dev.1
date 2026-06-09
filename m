Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8FCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB4840A4B;
	Tue,  9 Jun 2026 15:55:47 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 98D864025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 15:55:36 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-307d0405e07so1044453eec.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781013335;
 x=1781618135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEcRZTkCqrt/TuOX/ThPoZsN3Jy2HZdzIXM0tLh1arQ=;
 b=SVE53/GdmSkTHn4VX+TTlcLZIULd882e5FiX1nvm2ZHN2lFW3yDYeC1P5mfLfAWALb
 XCXh5beCzRRNE//IVMC6KpuTR7ETJV5Zs3BOBZC688jC2fsFcmsH+nF6UK/Xeey2AX3x
 25opn7v50pzFYHTJDH+qxlhPDAkABC8VX60/467hn+HO4pQ6iNEVc8FJnWxLv7nb6Qr/
 luQ/59tTKcinz23utezJmLR7+6Nzq7n6qbKi22STPXA6/fDhKY1jKG0Lm84PTwmONm9M
 ylsZSWQlIWqBYBNxFt04xTK1IKK/SGT4kHQOWdKG36bjrVfziwwz3027QzT+WVrC0OTt
 +2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013335; x=1781618135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GEcRZTkCqrt/TuOX/ThPoZsN3Jy2HZdzIXM0tLh1arQ=;
 b=WmpAr5SWiYUb+a3sLy7svbqnBdPrEpstThXqk4Jb1mZzqFABdoyI20EBF1CKALzRU2
 eR7YvuvGLjqTyL0s39RtSrwrSXEImQiVmIplwOX9xJLjH/ujIpedyXbAKaFGAFBwLJC3
 DNkm/bDfalnQZpbIEIdo3Zr2fLsX0cPLkjQr72KWfeGflTAkAhS7Z/QznM/YEkrcrK8o
 nrbhJrk3TMNHvCpN33EDrJ9Xu26rAEeqJ05xG732/dyE5BOTWJV7XS0nVRlTzru6Gp4U
 LtWgzPK1itNTwIJsXKwRiDb+pAsYrg8p5CzGdAIgoMWJAi8END/9cLFr+S3k2C8xC9ZI
 AWag==
X-Gm-Message-State: AOJu0Yzv02s3ydSvhtTD4iiS28kv4nnJ5pjIKFLRzAF2+WLG1IUZQdqI
 DCQ5RZdTgwbyZ9Va3yPMv4LHnPDv5XeEnpQqNGh0b5UScHSj9vJLbPDpvSwRGppGkyw3rTLArg5
 LsdmB
X-Gm-Gg: Acq92OGIWkh1UGYZHruhd2drYm6WsNGewSnVFlBjCyIRfGO4HmkD1QKGRyL5oubYhdt
 5G3USjrFU9tA2ZHQ/d8w6yiZaFASR8AfFK0fmOdwju/T7xhR8KDDyW48SUfg1lyn7EAfaY8OpHo
 H4wCoA8p844JekshiYMMq6JIPN0At00LFZDH6ulEUabIQaODsNvKwvux1fzGknLxNBQxZ8+JvOh
 EpoZT+OQXqKT+Qi4i2pOxQvymnUd8j9w02fD270znuGEdWZcBd0Zs8XLWLBe/hY3nyxetOjVQdh
 KzqMiRwW64ntVfGFyY3IW9tEnjdo7mQx/Tb2RqHk/Gbm5KA93bRhtGLeTmS3wrZldLacROKMJ+s
 QWE9Y1RA8Dn0iy2+jv5wNqHOmxI0kTcEgKRAzg2jJLxOfVKJqUtXCcV54WeRVY1eP7N5ZVUQbtz
 xL9K9qfUiZgh5oiataoj9eIXzP8ZlQXFdYYS1Ey7c0FiYIl+J4eTxxQQM/gQ87dD2+egiZ/AuM
X-Received: by 2002:a05:7300:ca4:b0:304:885f:2db0 with SMTP id
 5a478bee46e88-3077b22a7demr12725084eec.20.1781013335436; 
 Tue, 09 Jun 2026 06:55:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea8708sm22489639eec.15.2026.06.09.06.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:55:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] eal: fix function versioning with LTO
Date: Tue,  9 Jun 2026 06:54:16 -0700
Message-ID: <20260609135532.80396-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602225722.950617-1-stephen@networkplumber.org>
References: <20260602225722.950617-1-stephen@networkplumber.org>
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

When using function versioning and building with LTO,
GCC gets confused by the symbol versioning using __asm__.
There are no uses of function versioning in upstream repo.
This was found when adding additional parameter to
rte_eth_dev_get_name_by_port.

Assembler messages:
Error: invalid attempt to declare external version name as default in symbol `rte_eth_dev_get_name_by_port@@DPDK_27'

The workaround GCC 10 introduced was an additional function attribute;
clang doesn't have or need this attribute. No need to backport this to
LTS since there is no function versioning in those releases.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - reword commit message


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

