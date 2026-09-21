Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7DC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 21:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 350B440B94;
	Mon, 21 Sep 2026 23:57:39 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 0C610402B0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 23:57:37 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so2159746a12.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790027856;
 x=1790632656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j12uOjUNps+L8T+tGmvHLBB00x2YeuL5Tt/jBEo3G84=;
 b=BxPTqAxbu/wGZhMDiiVWKD+vyx54FjNBy71tDmxWUJpeALiYMivzteAeQKxKl3P3R1
 RMto6VkiMx/xqpt/UrrbLL6+/PZfB6hDdz4+ehumseKpHxPR/ZuDTzD6X/gfNKnYlMB5
 KYc7P0p+RAjGnekg8Npf2ddhUR3XiOcxOOHMgUKNB+bFEmDyzNDmfHZ0RUVSLeDkW4qI
 laG15SUkc+6JS+HFFY3BEdY6FH5jZJ9D35+TdDE8eYrYII0kxD6wEmEgbhuCXizgWa/w
 zRfvKI7hPtqWXtbXURMhET1kbgDoBWSjtsGui0mvSgkJwjT+KThWkluBGbWf3J2XwQEB
 cfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027856; x=1790632656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j12uOjUNps+L8T+tGmvHLBB00x2YeuL5Tt/jBEo3G84=;
 b=U0CKWKAYRcgV2azUZ+pm4Jkfy6ZQ5HfLRrk1reHPy7aq2Y1CfqfVH48QX16dD4LT47
 dDLaBjLrT2w7HICtG+jgjYMKSRDYUsTHnVKPwRTy0gHGUWsi33ldq474TkIJBXDuXKkA
 1q7+LngESDucohI50NJj2FrWNyQTJdf0H0eMhE21TKdu2YOheix6Ti8VgJyYI0vR9270
 /BYMKLVzhhHR8TeTQtrSPVsK1OVzA9BeaxKpLZsOWm8UoGhMM+AxaF3/bs0+7mhy9xu0
 aZkaZ7ZMXolNR3zNvXcNeoA7bc4WCnT1vEO8/Z1KM123s+s7+KUIhL6Romg3Tu317wRx
 wPWw==
X-Gm-Message-State: AFuF++lNJh/LTmb3theuiij4CknirrWVNrjrQtr5c9lEREhEquAO/AvY
 eFONQQpY2H5VGyxTsTA0CS0FP+GcqbOxSx20z2UojkV1u4qVi2YomwgTs1iOlssWZS/OWDSOMd/
 6Swz9
X-Gm-Gg: AYBFou237LPg62mAQR9fcNP2QLsbj16toZUUuVMMwnU5bmLWOcBp1+8yE0FnM0qn1u5
 y9N1jXCUljayq3u+ftlJm5gcSrhwvTOmkQ9GTXZ7RCFz1vfYtYiaWf5aeaUCDqVJdAIKTqSRQRh
 ZsgYlO/rudDEQBT3eCzpPb6DtkNrnpJ0aI+HDBbP+0fDl7ohv9jQ6jo3jQwN9fNN9BPoqSmPDgj
 4NvoIdqDbNLE1/rbcFch77aW3rPGx/2DHsu1Eobd7eKzu+Xu4+WPzhpBs/gK1ixsVUstb9c23Kk
 GQy8r733CASzBmXhu7+W7ygXMf49LYBSmImO8+1t7emvZDNJMxOhv6AyyTrIr0jv5bKyphrSpg0
 6HSx4py/90HNHJ4Kk0DIFIUPnTf+/kcZHU9RDKPJJJKj4NL2M6eNxBzb27PSVUsYSsbf+lq5l09
 u8l9yhGNJ2Y/x3du2wXv0pSCSok6l+Eots+d0d46JuBzpyEMLp7cl3W6iMwhmvsGWR64i9gZD3O
 rwtdlfbrRYbDKGy5gdPdP+h0NoVox/rzyypY726hkbQu1rm
X-Received: by 2002:a17:903:390d:b0:2dd:ad73:c98a with SMTP id
 d9443c01a7336-2ddb1bd6f42mr167675955ad.34.1790027856056; 
 Mon, 21 Sep 2026 14:57:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5b7edaa6sm904595ad.75.2026.09.21.14.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:57:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] eal: increase memzone name size to 64
Date: Mon, 21 Sep 2026 14:57:09 -0700
Message-ID: <20260921215733.404686-1-stephen@networkplumber.org>
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

Memzone names are limited to 31 characters, and ring, mempool and
stack names lose the length of their prefixes on top of that.
A mempool name is limited to 25 characters, which leaves little room
for libraries such as rib and fib that derive names from the name
given by the application.

Increase RTE_MEMZONE_NAMESIZE to 64. The derived ring, mempool,
stack and RCU defer queue sizes follow.

Move name out of the first cache line of struct rte_ring and
struct rte_mempool so the larger name does not push datapath
fields into another cache line. For mempool this also brings
local_cache, cache_size and ops_index into the first cache line,
where previously they were in the second. struct rte_mempool
stays 192 bytes; struct rte_ring grows by one cache line.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 19 +++++++++++++++++++
 lib/eal/include/rte_memzone.h          |  2 +-
 lib/mempool/rte_mempool.h              |  8 ++++----
 lib/ring/rte_ring_core.h               |  5 ++---
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..380aecb5a7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -139,6 +139,25 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Increased memzone maximum name size.**
+
+  ``RTE_MEMZONE_NAMESIZE`` was increased from 32 to 64,
+  and the derived ``RTE_RING_NAMESIZE``, ``RTE_MEMPOOL_NAMESIZE``,
+  ``RTE_STACK_NAMESIZE`` and ``RTE_RCU_QSBR_DQ_NAMESIZE`` grew accordingly.
+  This impacts the following structures:
+
+  * ``struct rte_memzone`` grew by 32 bytes.
+
+  * ``struct rte_ring`` grew by one cache line,
+    and ``name`` was moved after the size fields
+    to keep the datapath fields in the first cache line.
+
+  * ``struct rte_mempool`` is unchanged in size,
+    but ``name``, ``pool_config`` and ``mz`` were moved
+    after the fields used in the datapath.
+
+  * ``struct rte_stack`` grew by one cache line.
+
 
 Known Issues
 ------------
diff --git a/lib/eal/include/rte_memzone.h b/lib/eal/include/rte_memzone.h
index 5a0e1b8a15..d5c92fe0ec 100644
--- a/lib/eal/include/rte_memzone.h
+++ b/lib/eal/include/rte_memzone.h
@@ -47,7 +47,7 @@ extern "C" {
  */
 struct __rte_packed_begin rte_memzone {
 
-#define RTE_MEMZONE_NAMESIZE 32       /**< Maximum length of memory zone name.*/
+#define RTE_MEMZONE_NAMESIZE 64       /**< Maximum length of memory zone name.*/
 	char name[RTE_MEMZONE_NAMESIZE];  /**< Name of the memory zone. */
 
 	rte_iova_t iova;                  /**< Start IO address. */
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..d2ae56e49f 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -230,13 +230,11 @@ struct __rte_cache_aligned rte_mempool_info {
  * The RTE mempool structure.
  */
 struct __rte_cache_aligned rte_mempool {
-	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
 	union {
 		void *pool_data;         /**< Ring or pool to store objects. */
 		uint64_t pool_id;        /**< External mempool identifier. */
 	};
-	void *pool_config;               /**< optional args for ops alloc. */
-	const struct rte_memzone *mz;    /**< Memzone where pool is alloc'd. */
+	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
 	unsigned int flags;              /**< Flags of the mempool. */
 	int socket_id;                   /**< Socket id passed at create. */
 	uint32_t size;                   /**< Max size of the mempool. */
@@ -257,7 +255,9 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	int32_t ops_index;
 
-	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
+	void *pool_config;               /**< optional args for ops alloc. */
+	const struct rte_memzone *mz;    /**< Memzone where pool is alloc'd. */
+	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
 
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
diff --git a/lib/ring/rte_ring_core.h b/lib/ring/rte_ring_core.h
index 6cd6ce9884..4359ca8006 100644
--- a/lib/ring/rte_ring_core.h
+++ b/lib/ring/rte_ring_core.h
@@ -114,14 +114,13 @@ struct rte_ring_hts_headtail {
  * a problem.
  */
 struct rte_ring {
-	alignas(RTE_CACHE_LINE_SIZE) char name[RTE_RING_NAMESIZE];
-	/**< Name of the ring. */
-	int flags;               /**< Flags supplied at creation. */
+	alignas(RTE_CACHE_LINE_SIZE) int flags; /**< Flags supplied at creation. */
 	const struct rte_memzone *memzone;
 			/**< Memzone, if any, containing the rte_ring */
 	uint32_t size;           /**< Size of ring. */
 	uint32_t mask;           /**< Mask (size-1) of ring. */
 	uint32_t capacity;       /**< Usable size of ring */
+	char name[RTE_RING_NAMESIZE]; /**< Name of the ring. */
 
 	RTE_CACHE_GUARD;
 
-- 
2.53.0

