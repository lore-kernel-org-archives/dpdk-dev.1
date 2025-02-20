Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B92C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B51C5402F1;
	Thu, 20 Feb 2025 17:42:07 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id DC62F402DF
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:04 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso31937755ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069724;
 x=1740674524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfv7YouX/mn3U/ivFt/42eQhcDQdoQM4ulomb8xL3+Y=;
 b=mQEnjiat2SlxeRGu67bT3JPO1Tc8zPqfozv1iceAtvmlgASKaTWPKVzTJoMkckJDON
 nOXv9FTqAay8qv8asEpFZ4Bl4cVfmgINU+5LOhtFHU+CYZC2d0dpNAxWfm5notWrGR26
 d3de9i3yBW9vv49r21Id7px++k9kRHDnXCmhIkbLIurTmG1SGXL/FGyhmpgNwDxnFG0B
 X6kxI/KZjNlxRXqvQOe8m6Mn4huddDrkfzQVbmelP/2KkvujHVeSZQaN8VebG60oFkw0
 EhCGv6wl/fUPI2bB1hHFO+I2Xix/jtzlJRZNWQEaTQo+hsWDVvKpOBVc/jb7ZKQj3FwP
 +Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069724; x=1740674524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfv7YouX/mn3U/ivFt/42eQhcDQdoQM4ulomb8xL3+Y=;
 b=OERzoBaJcNBBs2M36TScHQGS5uTnHSQ/8094MAueY1x2oecMP3ovdl0xpkEvdy+QvZ
 KJEBUmbs9tldNyZWFciYJ4G6AR2TuiKvnjaAT/J6UcVUmBo9sxUHh0ZZNPIQtJ3JDlQ+
 UOAdyrzj3r2zXtkv2kT7nWan68+jSbYBOTOhfX+ROb72Vp9PO9xu06OpAVBU6goGYZud
 eTBjQne1Xre1qI7hTwif90VH7EABDHhnvJgVovjO1XbFUXbMWQtCwokMLjqSAci1Uppn
 u+s3vKaAjIBKaECSgkMDpor3UWpx4B32n1rkSQsCy0OaGe+CiZBm0+eFmI/g5udYt1sa
 l0SQ==
X-Gm-Message-State: AOJu0YyxUU+AFqbiQf1sAxbp1oRCk1q1KPVXhmHPiRrXnhENqmVs6nL1
 LWzOoPj+XKiqn/sokfoGoHbo7KzUtkDWcZyG/4JkACQ7iPIA4p+p3O8IPH0x2gBJbdGqxUUnVMR
 z
X-Gm-Gg: ASbGncscBMxWIDaFiWE4sxB0YMgELoW203TkDikffIF5faBqlG2j+5RiJU8VD65fOL3
 QK93/QY0Z0bg/OEl9cr84mM+ZUFuCMkXJ9jvLpMmFovaysuxtWfCThdlskm1ygiCqD6IN35tmfC
 EhA8OmLxdBKemEiRMg+0A4KTbYr7wpMR/80payusOBrrbTjZyuaVvONt7soTWgJOiBvPjHEZAOO
 apPrpEx+vSZ01OsG1CiX0/oKDDUGXrS55jw7W1t7DlKUi9SynRC7nQV5YiwBMn5iVYjgWtecX9w
 bysDJQb3XeBT8/2xOinWatlbXhK/wAIoXz17I/7LfbiG85aH19knAY6SxjN+pC6PAdjj
X-Google-Smtp-Source: AGHT+IFZJpWp5H9YHMCYObDpHiNKhM53TXFFym8lhgj2k0/6H5CR2Cp5ra/OxyKS1KJ7GUW8VxvGTA==
X-Received: by 2002:a17:902:fc4e:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22103efeebcmr400414555ad.5.1740069723924; 
 Thu, 20 Feb 2025 08:42:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v9 03/15] eal: add new secure free function
Date: Thu, 20 Feb 2025 08:27:09 -0800
Message-ID: <20250220164151.9606-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

