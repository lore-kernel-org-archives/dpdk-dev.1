Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB6DC021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5904A40B97;
	Sat, 15 Feb 2025 20:06:02 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id A335040A81
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:05:59 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-220e6028214so48037065ad.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646359;
 x=1740251159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfv7YouX/mn3U/ivFt/42eQhcDQdoQM4ulomb8xL3+Y=;
 b=kjqZk81UgnUJSa+2j0GnQepUSpyjCjsAbVUaWQHX46CKs9JWQiUpJ8JDDt0Ktc8lNc
 bEpGIyngFyLrg9kcc7dQ2ok/wd9gezIBMqni9Wu98c/5vKZ60MNWw20H417xl5VsU4t7
 LxLGChS7Fmb2+0oO5JMtVPbvKMJT6pv6CGAYswCRzUaZQGlQkhcoG/Ec9XWCGqS8CA/o
 luB7o6R0txYFsHrzhyq28K+Zi3XPmbkUMDwmPDadSTNfmzoHkzmtbg4rCf+ro0+8tOoq
 +kfA4yg/c3aeT5xN42rDDH0BhUP8mYLiqtlt1w9VydwzorOewGGjFRe2p2go5zX6YvJh
 OgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646359; x=1740251159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfv7YouX/mn3U/ivFt/42eQhcDQdoQM4ulomb8xL3+Y=;
 b=jjCaOt/UHb48pkpuXU39scPLymMH44b8bBubp5HkcEhdwakgx/sz2ajSqx7Yae0X10
 uJkBCcUTdfMsdLs9bSL9odg62SLGCdbGsSgJ+VpYAkAYOOj9PqHQqLAnZRybWdTWLsP0
 iE2g3FT002CQfaQhzBjT4hdJpOBYwxDFD4tyMtd3avVxAfWvEPcfsQfwh2bYLHWg2cro
 Zngy+1bnFej8Mk+ggSzPTxlWfU2m+8qBxLstjuxqyhdrzjVsaTJsiNL9cQParznooGCt
 BaLl6b6iXrXm03xjcLzxZQLvgMWrU+ov5rGnbPxoBlHF/kLJxUsdHVuqrbDNHegd/7L4
 VZkQ==
X-Gm-Message-State: AOJu0YziEJXKbBF+B7oISn08sJ8JKPuomHhe0d0FoaNmeG5H+c1ZAHg5
 rganoyymczvYkWXP5iClf7SQmWIxM10JV/KdEmGD1I5oxxtvGMsVxwO2aMjeMvyseVYR4d+W1w2
 W
X-Gm-Gg: ASbGncsD5H9Kp8Z64M01uhClunTCcTIzWr7s8V7FzissxfpFIa5HNdf/+eZdNU3sxUg
 ZN6cdFIWnP3NdwDg/GFdUrBdyi16lH6iIRbMRgYj4bodqSZS9OGLTECZr5ocjdMSpSDPKCDhcGl
 Sv0jtvi6f8JSSpldkszIX43UFSvdNrEl4JH2y5D0OznEbHat3eK30GJmmWVswv2KyfjJTqrn7DH
 Y80yBvr5cgHbxK3F4NN2bETEqZC207Prtb/BbB6b0MZ3oWTi0wS1JRBbYY1CnSho0b33Cl1hU4t
 FSr2I9omi1bYFDdMzn36yG+60CjEeTCi+3gFWWGw2ryb/89C+37PqZITdU0D/P2NI71/
X-Google-Smtp-Source: AGHT+IEmIDzwnCW5wHs0wc/TaEGVvzRAr8iViPbb7oMJIENOKiwDdAKBKRu9xaf7QF5XXjOtRSWjJA==
X-Received: by 2002:a05:6a00:198c:b0:730:4598:ddb5 with SMTP id
 d2e1a72fcca58-7326177622emr7209842b3a.2.1739646358855; 
 Sat, 15 Feb 2025 11:05:58 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:05:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 04/16] eal: add new secure free function
Date: Sat, 15 Feb 2025 11:04:32 -0800
Message-ID: <20250215190544.988310-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

