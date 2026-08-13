Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E6C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 982EE40298;
	Thu, 13 Aug 2026 19:14:30 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 57AB84026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:14:29 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so2695416b3a.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786641268;
 x=1787246068; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ws1xF2kUt2ZE1ka5Qf2hlVoYCa/IN+iRBUKieXjsuNE=;
 b=xqbwylyLO2bnfZ9w0kq3nTvhWpephYA7WJpQsE0C5hDcN3cfZQZ6rK2e4apAjm3r0i
 1HAqJ31PLhtzTGRREptaG1uegCdI0fjjRhf3uct3nOZQ2jyQWwl4xAhqktT+oMuMGNP2
 G1ugX7tmJywc9/4eRMGqporlhCKlSDHP9vcvdvTmk+K646WCgL5CINoOpinae3FgrWP5
 ViU21eRMMw6Lz9WtnRHUevFw+eRnwEg9A0zdQuoUpKZgHubbzB171oO4E/dujLHnO1bR
 c93uC0pBHKP8Q3A10p7nMns8r8l26dGkmPjBGiVdue3gZd7kxXccwTmYBXuqpaiutmDl
 BgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641268; x=1787246068;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ws1xF2kUt2ZE1ka5Qf2hlVoYCa/IN+iRBUKieXjsuNE=;
 b=UEqmcP39sNezznj4zwzyMk2ZANjRqZ0KjGpHBxBSoGg62IXhv/hdAXDnHYT8ow+Tky
 O23q5T4JuxlBAsu7vmAhljw91QKoKfdfzC3y9aVOCvW3LUdVUkh8qvFyZ8Ythl245kd/
 mXyUYkVbbwWzfrTWs5qhPXLEAmxbZ0PhSd2eBsVQXZJJWOC2dWqC4XbZvPDFtoUOKK5C
 sgQXs2nmnsntBvxR7CrKTcKCnex4MOa5LZCD2YXmZ7t6CJIRSEhq+P6Zdy/SGpNVGHo4
 irk07753oevfVmXsKwXlJXX22La9s45oIbn1m39gBP2KC5nMnISWdSjBRmgQOVA6C+o6
 Y+BQ==
X-Gm-Message-State: AOJu0YyR2snkYvTaegExDx95gFPWrBtpJcE6YaZkidZ+h2U3g1uyYQWw
 U9qxN95CeAzfLCoA4bwFDYtx0OEc8EFUAkVd7Y/gzpHERlva563v8bgP/K+wNPpFNldYpO3hXSv
 nCWu1
X-Gm-Gg: AR+sD119iTjuwGgWkcEkFSsAXV2rbEWwAsTgWbLFnchaVjGUl9I83eJBkxs42DzjY1o
 1ShWQV6VXTgyuIQMFCUhpSwuqzRkQHjGJiw1kEtToNOFgArYmXVFwASrEjGvlBKs/ADTlgrHYF2
 qFYeq+0HI9YzwmFhL/0FCs+fAGdIJEwBeulKC9gsI8A7cvZkqimH4TzbN5adLFCdLzo+2BUG7+s
 k6bB58bOQHsd0xs1cBi+dpL8NuMSki7XGN/HNkQavLFuyCP/tWzkHdws93fv+1hOXM4u5jpkqAi
 mMSTAcMeHFEIePd0rHdWfJz5AKu3rjqMXShZtJaiyoBqUa/Q+aTuBi75QpUkEXzOFokX+QZjO/W
 lH+w/of2pQuz83v+xI24hRYF4Ybm22EM7qIu9Z8Gvm7c4hmG0syqQMP1Rgehi15d6tsQ31vVMuM
 NpSOE7AVqI2B/BqB3FZJ4OhrFu5uh7pz0ZnGnq+gzrP94FG7qghExGC9pGcVn9EF4lGBUWTEiXQ
 2h3FoSsOLnGHeUTzCVv9Fu1GJQ=
X-Received: by 2002:a05:6a21:7002:b0:3cb:eca6:ce5 with SMTP id
 adf61e73a8af0-3cc5539af60mr10657288637.24.1786641268171; 
 Thu, 13 Aug 2026 10:14:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebcb6a97asm10137573eec.7.2026.08.13.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:14:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC] increase name sizes and reorder structures
Date: Thu, 13 Aug 2026 10:12:43 -0700
Message-ID: <20260813171418.568620-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This is a trial balloon to see what Morten's suggestion would
look like.

Increase memzone name size to 64 and reorder structure
to keep it cache friendly.  Move the zone name to the end of
struct rte_memzone and order the remaining members by size.
The structure is then naturally aligned
with no internal padding on both 64-bit and 32-bit targets, so the
__rte_packed_begin/end markers can be removed.

With memzone size of 64 but don't need all that for stack names.
Increase the size to 32 which adds some space without impacting
cache layout.

The memzone increase to 64 allows ring names to grow to 32 characters.
Don't need to go larger which could cause cache changes when ring is
embedded in structures.

Bugzilla ID: 1984

Reported-by: Morten Brørup <mb@smartsharesystems.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/eal/include/rte_memzone.h          | 15 ++++++---------
 lib/ring/rte_ring_core.h               |  7 +++++--
 lib/stack/rte_stack.h                  |  6 ++++--
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..4732e0ec72 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -93,6 +93,15 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Increased maximum name sizes.**
+
+  * memzone: The maximum length of a memory zone name ``RTE_MEMZONE_NAMESIZE``
+    was increased from 32 to 64.
+  * mempool: The maximum length of a mempool name ``RTE_MEMPOOL_NAMESIZE`` incre    from 26 to 29.
+  * ring: The maximum length of a ring name ``RTE_RING_NAMESIZE`` was increased from 29 to 32.
+  * stack: The maximum length of a stack name ``RTE_STACK_NAMESIZE`` was increased from 28 to 32.
+  * rcu: The maximum length of a defer queue name ``RTE_RCU_QSBR_DQ_NAMESIZE`` increased from 29 to 32.
+
 
 ABI Changes
 -----------
@@ -109,6 +118,12 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Increased size of names in structures.**
+
+  * memzone: Moved the zone name to the end of ``rte_memzone``
+    and expanded to 64 bytes. Other names in``rte_ring``,
+    ``rte_stack``, ``rte_mempool`` and ``rcu_dq_name`` also increased.
+
 
 Known Issues
 ------------
diff --git a/lib/eal/include/rte_memzone.h b/lib/eal/include/rte_memzone.h
index 5a0e1b8a15..5aef676e3b 100644
--- a/lib/eal/include/rte_memzone.h
+++ b/lib/eal/include/rte_memzone.h
@@ -45,24 +45,21 @@ extern "C" {
  * A structure describing a memzone, which is a contiguous portion of
  * physical memory identified by a name.
  */
-struct __rte_packed_begin rte_memzone {
-
-#define RTE_MEMZONE_NAMESIZE 32       /**< Maximum length of memory zone name.*/
-	char name[RTE_MEMZONE_NAMESIZE];  /**< Name of the memory zone. */
-
+struct rte_memzone {
 	rte_iova_t iova;                  /**< Start IO address. */
 	union {
 		void *addr;                   /**< Start virtual address. */
 		uint64_t addr_64;             /**< Makes sure addr is always 64-bits */
 	};
-	size_t len;                       /**< Length of the memzone. */
-
 	uint64_t hugepage_sz;             /**< The page size of underlying memory */
+	size_t len;                       /**< Length of the memzone. */
 
 	int32_t socket_id;                /**< NUMA socket ID. */
-
 	uint32_t flags;                   /**< Characteristics of this memzone. */
-} __rte_packed_end;
+
+#define RTE_MEMZONE_NAMESIZE 64           /**< Maximum length of memory zone name.*/
+	char name[RTE_MEMZONE_NAMESIZE];  /**< Name of the memory zone. */
+};
 
 /**
  * Set the maximum number of memzones.
diff --git a/lib/ring/rte_ring_core.h b/lib/ring/rte_ring_core.h
index 6cd6ce9884..cdd0ec4428 100644
--- a/lib/ring/rte_ring_core.h
+++ b/lib/ring/rte_ring_core.h
@@ -19,6 +19,7 @@
  * instead.
  */
 
+#include <assert.h>
 #include <stdalign.h>
 #include <stdio.h>
 #include <stdint.h>
@@ -46,8 +47,10 @@ enum rte_ring_queue_behavior {
 
 #define RTE_RING_MZ_PREFIX "RG_"
 /** The maximum length of a ring name. */
-#define RTE_RING_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
-			   sizeof(RTE_RING_MZ_PREFIX) + 1)
+#define RTE_RING_NAMESIZE 32
+
+static_assert(RTE_RING_NAMESIZE <= RTE_MEMZONE_NAMESIZE - sizeof(RTE_RING_MZ_PREFIX) + 1,
+	      "rte_ring name size needs to fit in memzone with 3 character prefix");
 
 /** prod/cons sync types */
 enum rte_ring_sync_type {
diff --git a/lib/stack/rte_stack.h b/lib/stack/rte_stack.h
index fd17ac791d..0a74efad6c 100644
--- a/lib/stack/rte_stack.h
+++ b/lib/stack/rte_stack.h
@@ -15,6 +15,7 @@
 #ifndef _RTE_STACK_H_
 #define _RTE_STACK_H_
 
+#include <assert.h>
 #include <stdalign.h>
 
 #include <rte_debug.h>
@@ -25,8 +26,9 @@
 #define RTE_TAILQ_STACK_NAME "RTE_STACK"
 #define RTE_STACK_MZ_PREFIX "STK_"
 /** The maximum length of a stack name. */
-#define RTE_STACK_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
-			   sizeof(RTE_STACK_MZ_PREFIX) + 1)
+#define RTE_STACK_NAMESIZE 32
+static_assert(RTE_STACK_NAMESIZE <= RTE_MEMZONE_NAMESIZE - sizeof(RTE_STACK_MZ_PREFIX) + 1,
+	      "rte_stack name size needs to fit in memzone with 4 character prefix");
 
 struct rte_stack_lf_elem {
 	void *data;			/**< Data pointer */
-- 
2.53.0

