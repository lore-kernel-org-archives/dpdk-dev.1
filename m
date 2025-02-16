Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F32BC02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:01:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23D7140E3A;
	Sun, 16 Feb 2025 18:01:30 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 5104440E11
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:25 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso3942987a91.0
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725284;
 x=1740330084; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfv7YouX/mn3U/ivFt/42eQhcDQdoQM4ulomb8xL3+Y=;
 b=j0s029aTOG5B5UK+qNRmnew2zHZvN1vC/SY+Ho55iJJd6AgaqP0YVfPJFLPrVBxJdr
 KWjYqrB2meyHwHlmvvi+9ANksXDUNdZiwB4nanyCbOUncqw/Q+J2vYgtL7phzMC1h3Wk
 vj7tiiFfHRpvcKUsn0QUEKEDtnH5PpGoRcqWr/2XAK88VJ1TEkQpAoa5zfYUSkgaU7OI
 3w7aAPRvEFTKDNCKCo5/xz6f1qL4Tt8BN/WyHg9/gsGf5naYW1t/3RvZcELgN/Q4yQlL
 lGtJlAamoTWzAMAyXkjzHFCUUOCyNUn+pXtXYxs481S0B7hTsw5Hf/P+Ee1HfAwqTbWg
 dApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725284; x=1740330084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfv7YouX/mn3U/ivFt/42eQhcDQdoQM4ulomb8xL3+Y=;
 b=SodDIBoSmSo/snlEQdNw4NARAOYfZpHcFOePvV9AEDiaBaKmZ5u2NFN3RKQJx+OrYd
 Tq5JI4wRdFAkpzHPtfA5RJ9B7bX0FkOMQP+Y62/hEjcByCz/MMIaT36LCfR4o5aQ67bS
 rls3sdqz2gqLmqAwLKB22OJ8OhYAsO0OX6g2Ir4pG2DkIAUt2jJdH2/Z9DIvJGttC7MR
 nM01/uIMjiKc2ZgEOVTsoWz9glxDZ4BVNJa7+NHDVL9O3LKImqMmjhgfycx1amgt+79D
 OezwNkGpbZEygPrToK+wrPSglopfvRS49ZfvD4S1FkZKrLUDTJBsOgpOs1Q5fuzalJeg
 JS2w==
X-Gm-Message-State: AOJu0YzMMTSdRGapYwi9RvnT3zPE9IL8FbWpAG4iTqqSFf2aeSlI903m
 yd7W5YGrKFziL9jjlh7Az0hOlgi1nH3iNATDPZ/kl/xCjijK4VpRWsKAh4m8ByoXbb3Onn7TfES
 G
X-Gm-Gg: ASbGnctpM5RJd3bS17gwavMtk6gqg5wTW70wBRYNxpigTKZLPBdefJ6iapvYmCtzFR/
 HsXxaT7lV+nnUrLUXcS6mKemZm6Sqh6q7d7V6CzfTyaw23rG4IIaNfkBk8x8zl5QCFEWP/OGC+3
 yl95BcAzmGlZHaAPmhBbEKusRPqqggJ4ECZJ2kR+qtbMiCeALTPsMx8AkJp/tYL2maGTBH4i7BF
 JcxX6d1oc7VAuU0G1YxjPmiobAFstt4fCP0sB54+IQc/wFCsAp/yuenstmIt/KecuRtijHsuZ0n
 tRslvFwy/TWCpoyY0eOawpO9oFLvkBM1aCjfDDei0FSbc2SClIiSMjLWLZ+T0JuIvJDQ
X-Google-Smtp-Source: AGHT+IG7yQr0GoP6KGeDERMkc2+oLwD664Jfcdeno0fXo+Dyc0IY8DiYsrwpCkmC3CDdZLpZeAdbjw==
X-Received: by 2002:a17:90b:3809:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2fc411509b7mr11136484a91.33.1739725284457; 
 Sun, 16 Feb 2025 09:01:24 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v8 05/17] eal: add new secure free function
Date: Sun, 16 Feb 2025 08:53:04 -0800
Message-ID: <20250216170110.7230-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Although internally rte_free does poison the buffer in most
cases, it is useful to have function that explicitly does
this to avoid any security issues.

Name of new API is chosen to be similar to Linux kernel
kfree_sensitive() to make porting drivers easier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/common/rte_malloc.c  | 30 ++++++++++++++++++++++++------
 lib/eal/include/rte_malloc.h | 23 +++++++++++++++++++++++
 lib/eal/version.map          |  1 +
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3eed4d4be6..fc2d2ae3f1 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -15,6 +15,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_common.h>
 #include <rte_spinlock.h>
+#include <rte_string_fns.h>
 
 #include <eal_trace_internal.h>
 
@@ -27,27 +28,44 @@
 
 
 /* Free the memory space back to heap */
-static void
-mem_free(void *addr, const bool trace_ena)
+static inline void
+mem_free(void *addr, const bool trace_ena, bool zero)
 {
+	struct malloc_elem *elem;
+
 	if (trace_ena)
 		rte_eal_trace_mem_free(addr);
 
-	if (addr == NULL) return;
-	if (malloc_heap_free(malloc_elem_from_data(addr)) < 0)
+	if (addr == NULL)
+		return;
+
+	elem = malloc_elem_from_data(addr);
+	if (zero) {
+		size_t data_len = elem->size - MALLOC_ELEM_OVERHEAD;
+
+		rte_memzero_explicit(addr, data_len);
+	}
+
+	if (malloc_heap_free(elem) < 0)
 		EAL_LOG(ERR, "Error: Invalid memory");
 }
 
 void
 rte_free(void *addr)
 {
-	mem_free(addr, true);
+	mem_free(addr, true, false);
+}
+
+void
+rte_free_sensitive(void *addr)
+{
+	mem_free(addr, true, true);
 }
 
 void
 eal_free_no_trace(void *addr)
 {
-	mem_free(addr, false);
+	mem_free(addr, false, false);
 }
 
 static void *
diff --git a/lib/eal/include/rte_malloc.h b/lib/eal/include/rte_malloc.h
index c8836de67c..0a397e7723 100644
--- a/lib/eal/include/rte_malloc.h
+++ b/lib/eal/include/rte_malloc.h
@@ -51,6 +51,29 @@ struct rte_malloc_socket_stats {
 void
 rte_free(void *ptr);
 
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Frees the memory space pointed to by the provided pointer
+ * and guarantees it will be zero'd before reuse.
+ * This function is slower than simple rte_free() it should only
+ * be used for security keys and other sensitive data.
+ *
+ * This pointer must have been returned by a previous call to
+ * rte_malloc(), rte_zmalloc(), rte_calloc() or rte_realloc(). The behaviour of
+ * rte_free() is undefined if the pointer does not match this requirement.
+ *
+ * If the pointer is NULL, the function does nothing.
+ *
+ * @param ptr
+ *   The pointer to memory to be freed.
+ */
+__rte_experimental
+void
+rte_free_sensitive(void *ptr);
+
 /**
  * This function allocates memory from the huge-page area of memory. The memory
  * is not cleared. In NUMA systems, the memory allocated resides on the same
diff --git a/lib/eal/version.map b/lib/eal/version.map
index 82a3e91c97..cc19c676f8 100644
--- a/lib/eal/version.map
+++ b/lib/eal/version.map
@@ -400,6 +400,7 @@ EXPERIMENTAL {
 	rte_lcore_var_alloc;
 
 	# added in 25.03
+	rte_free_sensitive;
 	rte_memzero_explicit;
 };
 
-- 
2.47.2

