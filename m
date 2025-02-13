Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB65C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BD3D40613;
	Thu, 13 Feb 2025 23:18:35 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 6BBAE402F2
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:33 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fa2eb7eb45so4146992a91.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485112;
 x=1740089912; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDJEmF/Kxqut4fqC01LqbnxieZQJdgOyhSVGx6oqKFA=;
 b=jasRuB5A2hsY0P11luvQsHLDal7OxCHsIFVqsolv99XtFuoJ6AOKKeznZGdrwcZ89P
 FTBnI6RcUp/wg5sdZTSH96VIwL/UuDR19dn0tR/zF9osRS92Lgr0UoTnVvwvnbJvSA4U
 z//+1iUYaNepo6/4od6ye5UYTO2B/kkY2/FaPbi1RNJmGxhg0c6NBKwJ/lpC2cO1cbmF
 ekXT9pjmjg0kBg10z2XHmMlmDyHo3JHCp72O7O7k1LDpAbUF+N5cn2RCD8Pm1Pdo7gU7
 /iPQGeqpCrDLA2LndoktW7SVMoEZQReNYljrcjNraiMhx5f3XhsEtrNHBU9DIG5jbZY8
 1uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485112; x=1740089912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDJEmF/Kxqut4fqC01LqbnxieZQJdgOyhSVGx6oqKFA=;
 b=QhL6zcASikJXu51Gw6IPZjcy9Xp1jCYJr6F12JSpSv6fgTPTmNsr3RUwJ/U7yKUsax
 xxBKqL8VuhzIhmyNrFeo4phe1XMhF3DGY0WIkbEHQ9N+rWVdZD2hvZ3j9U6bZkvU3uPB
 eeW+C7TiqFZu/df0JAi5+r7DZrvJ6G8PuEE/EjEriMG120nefC1QcQlFwb+lVOoFyP22
 +QFchDLqKqu+tJ2H+YYX6ORHCMkrjyS9+Kp79MjXu0Mdt7hT4oQQY8nsfGgGTK0BLofn
 kWSIjiMbSDfz92b4bGXyVIdGNMULWyiFUzU1ifpd2FqCS0Ze1rlVnR/9fXQI8953l238
 S+Lw==
X-Gm-Message-State: AOJu0Yx/QRDKJHokY58PZq0+6BvP48g0elk17kCM1agCmmnd8abr9Rz3
 R+nqsQLJVFE+ZPQIT7Ab/XeJsuxNti2jBCQAMdvb0inVyDJSLWEzgrAY2Ej3lvg9nsPMd3+KZpY
 H
X-Gm-Gg: ASbGnctATZsCugCGEOoba8rK6utSbA6ScsSl5ZHdwe4UyDHi5zvO91URmbOf9WZGj0O
 SY3RGp7LJ3OSxF0Fc8lDz+hIuUQZpzhPiOlNBw5NlBAT22dU8Irrws4fuVDzcnlnMC3sfuNJy8k
 ib4V4HZIJDdWtNsSe91WGiyEw4zFhVJ6QjUuMP+1636Rab8dL2c0evLGBCefhHDKtMY6RppFVVv
 /Lln++EzG+2TOkoQNUycLK/rvzeKE2pi1D9/WB1CMf8W/uLcI6OhWnsQ0PDY92mqYKF7Lq+H6Ds
 N4SHmrjK50FRo/F6owVnoDt6bL+VnI5bdnYAPY8OcoxSV7awewRwd9+Y6Z6m1wZUgysU
X-Google-Smtp-Source: AGHT+IFFozhayyUOAbId64lwn3gjdR5+DXMMweEhqo4FeTtJcT1K26hs9IeQoYdPzQkL5ylPJRrfJw==
X-Received: by 2002:a17:90b:3c0a:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2fc0f92452cmr7752784a91.2.1739485112575; 
 Thu, 13 Feb 2025 14:18:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v6 02/11] eal: add new secure free function
Date: Thu, 13 Feb 2025 14:16:15 -0800
Message-ID: <20250213221819.1856769-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

Although internally rte_free does poison the buffer in most
cases, it is useful to have function that explicitly does
this to avoid any security issues.

Name of new API is chosen to be similar to Linux kernel
kfree_sensitive() to make porting drivers easier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_malloc.c  | 30 ++++++++++++++++++++++++------
 lib/eal/include/rte_malloc.h | 20 ++++++++++++++++++++
 lib/eal/version.map          |  3 +++
 3 files changed, 47 insertions(+), 6 deletions(-)

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
index c8836de67c..69c965099d 100644
--- a/lib/eal/include/rte_malloc.h
+++ b/lib/eal/include/rte_malloc.h
@@ -51,6 +51,26 @@ struct rte_malloc_socket_stats {
 void
 rte_free(void *ptr);
 
+
+/**
+ * Frees the memory space pointed to by the provided pointer
+ * and guarantees it will be zero'd before reuse. Since this
+ * function is slower than simple rte_free() it should only
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
index a20c713eb1..fa67ff44d5 100644
--- a/lib/eal/version.map
+++ b/lib/eal/version.map
@@ -398,6 +398,9 @@ EXPERIMENTAL {
 	# added in 24.11
 	rte_bitset_to_str;
 	rte_lcore_var_alloc;
+
+	# added in 25.03
+	rte_free_sensitive;
 };
 
 INTERNAL {
-- 
2.47.2

