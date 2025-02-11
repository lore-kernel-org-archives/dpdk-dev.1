Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2678AC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBCFE40A89;
	Tue, 11 Feb 2025 18:37:36 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id DD4AD4069F
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:34 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso4728645a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295454;
 x=1739900254; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKYjSR4pi38r6mJmyG4S3BECFAEkR6nV3M4PYe0T5po=;
 b=PoMzmlr05J4oyozI271404XtdRkzhwOSE6gAbbn0R2zfLsJDYt5bYQ+QOGPhZhPs35
 9RV1qGAZvHjrtGIeNOwKI5Sex+xBprKcq8gjwgn3JKw+6UIfdCYEQYg1zHLGLqWMASZe
 Zy3KXvNPDQT+Y+JTG0ha6d7W/peK7yLFq1w6tTgI+Itb/z38C7Od9M5bDhhNJEsZCV8s
 q1x6Oani0sVEifZ3K/zE2PKKtbChBVNTWZJ4sjSWW9FT3yE033e6kiKeXJ/pkw9H9c6h
 SPt7idi3mh/5Dcvh/VfU+4dS7afCU53jmKa50RFeXOEqVVskMCrqW0jW9XjRmni33iMU
 17Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295454; x=1739900254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKYjSR4pi38r6mJmyG4S3BECFAEkR6nV3M4PYe0T5po=;
 b=T78B7wj8B13jbPCVfmnp28kDGUmcRjg+ZU33Fyc5zlqhynj0YnK4p3V1QcyRXtNTBc
 Mf7uzsRtpesdsnNMMYt9xq0TSDwTa30n05aw00Bi5nSIUYdyD4tdG3NXc7cMK9GplqGN
 QU0vNyMd1RvVPaao/THgl4x5cS/drXjFdU0iX+v5WwVDvfDl3zIKGJoAVtxZ1Hl6qxAr
 buG0WkyEFbn4GMkII357aw/D2TFltHJNhYyVHi1UB1D03P8fdXhZ1teKPeFlJRvb2i2L
 jr5GJoUy2gtgRx6NO5m6WuwNiSvpV3KIjCtyUWtxZVrtVt5lURaaLQIuwlOpkXPUEAll
 IwAw==
X-Gm-Message-State: AOJu0YxeSHFfYUvg6lvTwoEzqzAA4BBqEFEUrBU9PmBXl/5KT51GP6/3
 xLRjdo2+EOhUlvzo72gdpIezc5Ee0vob00fa74ZSb1gwImUHPM8oed+YSEC8YYOra5KuJJycF2w
 q
X-Gm-Gg: ASbGncsFsXVmTIxLQvgCNFEtU4yrYR+8WJKRWvtJ/qCaYqkOypZ2dTAKcsybEr8zu4j
 M+YZb+lJ6EV4iJlopXCXbU6ixpAMZsZt5gJI+PBei7Fe2ITJffJNesLpuHoUNwaAw3NCcKr1zM9
 kciAh5ne6C3bi8rjM9iPSMH2d1Ya42SfzWMOU2TQcPnzDpIQTjLY51M5S8yvMclNiX8aZDqLrWf
 uSY0yiyZwPxZDjE7Ke2nBDHcQCN/PVGP3vmPi8MCC6U7/Qfu96SACr9l0BqDOAs6Oick847B+If
 NXNzfXo1gDP614kOcr/EK2cUnMAiXvJlEYKy7+Jvj4r8bDJWVxCqn3y6e9pI2vuPnF/x
X-Google-Smtp-Source: AGHT+IG+u+vstDNJ2jJbFGHIZE3zFiNiUwmX+J6HjKnp1BtM8z/d3UOXfHKpzW6VSJvx8UbzAT898g==
X-Received: by 2002:a17:90b:2346:b0:2f2:a664:df20 with SMTP id
 98e67ed59e1d1-2fa23f55106mr28850541a91.7.1739295454098; 
 Tue, 11 Feb 2025 09:37:34 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v5 02/11] eal: add new secure free function
Date: Tue, 11 Feb 2025 09:35:22 -0800
Message-ID: <20250211173720.1188517-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_malloc.c  | 30 ++++++++++++++++++++++++------
 lib/eal/include/rte_malloc.h | 18 ++++++++++++++++++
 lib/eal/version.map          |  3 +++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3eed4d4be6..c9e0f4724f 100644
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
+		rte_memset_sensitive(addr, 0, data_len);
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
index c8836de67c..d472ebb7db 100644
--- a/lib/eal/include/rte_malloc.h
+++ b/lib/eal/include/rte_malloc.h
@@ -51,6 +51,24 @@ struct rte_malloc_socket_stats {
 void
 rte_free(void *ptr);
 
+
+/**
+ * Frees the memory space pointed to by the provided pointer
+ * and guarantees it will be zero'd before reuse.
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

