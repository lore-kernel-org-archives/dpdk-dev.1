Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37FC98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B315142E6E;
	Tue, 22 Sep 2026 17:52:56 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id C872540ED8
 for <dev@dpdk.org>; Tue, 22 Sep 2026 17:52:53 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so66443a12.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790092373;
 x=1790697173; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dH9KP42bbZpVsrup2F/1LkP6Pr3SvcX7D+RGI6hGPSQ=;
 b=eZmcTJR9Rodug9EnOQNcl84oLEwTAKNsZrzO4d1pIbSa3ngoPraDv44QouurY/WpB+
 +kwuBV7DrQhKHv42jFJAwzfYVyxJ8nZ5QfjmAQz0MnMB2gThIrC5m48wuTXrGrgGjxym
 0qNYFIS+L7bVMsUXJ9rSzm+S13+5g/pkpaR24gQROc4PEMVwxdaTcRQaw26dD6oJLLyr
 5QsmXf/Sm+TqC2ijB6XL5R1JHH/mQBEB6krYlStWhfitho4DGnrSj9qeYMHa8Ojcg3/E
 MsVpUKAqDWE+LUlw7XjIQ81luP4S+QqJp+lmf7/y90swznUf8Nw4hFyg5MPPDeAuQGFp
 gVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092373; x=1790697173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dH9KP42bbZpVsrup2F/1LkP6Pr3SvcX7D+RGI6hGPSQ=;
 b=CHC1xwJ1tOUg0eHNOrJei7/Sv331aq0CXJr+Ltj3XE467DPBV8CvQfSYH8hlrxWFoU
 Y6LEqmgZ/ASDPWVtQbkaE3+7h61aNOC4rmXIKJVAiQlkOa2g8BetcKB7X/2y6GJbyZwD
 n3jmyw+h8b6WOZBlCsQuf1xQuLWZQB6HSgWBTgceWkUxF27rDrdaDdQpepdXs91eMTCt
 qYrNrA7vtriXSjOBiekuqtY1aGp5/nc1aDSUvKHMxWd5KIzCiaFD4jEyVYiFTZMt0oQm
 gTtNd8sVyu/U230Z3n15h+Fyj0LnPQ0aAlrAfSFbxejMwQbk5ZEVV80X5Y7wPZfJmsy4
 eJzA==
X-Gm-Message-State: AFuF++mNOH7tJYyIBkPGKkUkFumn17QBxXduc2xUPKrD5Vlfqout+a1p
 tXFltwMM2TsKyfr+sTX4v5G3jTzh4r/v/bjN6akiVNaPIMDPePH6+Gz2hoi58xR+3SuH1f+tIRz
 fQ7yn
X-Gm-Gg: AYBFou1i+Xi+pSrs8QHtB3yZkgp3yJewqicNwAZ62xmgv5bOxEayRPjazFKWVMbeWaM
 pJsAPWuZmw4mRFclGQcPzUprKszOS9LxxSGZNy5QReaOQRHKXiHThDG3fcYqzWjri5qIHLcpUQu
 9611iI+t0WtywDbc9ovWCUtec+V3NToYD4l68f/FY1lAJxHrGY8OJPJo8so4aAVon0L/1JoUeO8
 18ppM0pKc0qqn9+PPQAVf4uQnu8cLMdVpvyRDRJmqb4m6kEV6fuSmFG38Ecs0noHGrIUkaKfTdI
 to5CbEGQ0PbwAFUM39AxSDAcHQWycbwn40J+53MO7MTKKD0VsCtiULue7GSzdaxL3HhkQxyQkM3
 N6l3T7K5j7vydOVBD4JHZ7b3kSo+pUfCexkwUMG3D8XtZQ4VhqmWHz4v7hEWfnnua7E8yQweIwm
 TaA6s0Gir4AZqh+NukPaur1YVONZq4BWeEZLITKzNOmIed2Bym0Dwomwc/ti4n04wo/oQuPa/Bn
 UgAjy1wB75/5K3VXCdzs2vRyV2s9Fnlvxg/pYg=
X-Received: by 2002:a05:6a20:9f49:b0:3dd:a196:9074 with SMTP id
 adf61e73a8af0-3ddec82bf71mr2228442637.62.1790092372767; 
 Tue, 22 Sep 2026 08:52:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756b5c2e7sm1219347a12.27.2026.09.22.08.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:52:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v2 2/3] eal: increase memzone name size to 64
Date: Tue, 22 Sep 2026 08:52:09 -0700
Message-ID: <20260922155249.3115271-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922155249.3115271-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20260922155249.3115271-1-stephen@networkplumber.org>
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

Reorder struct rte_ring and struct rte_mempool so the larger name
does not push datapath fields into another cache line.

For rte_ring, flags and the size fields come first, followed by the
memzone pointer and the name. The cache alignment moves from the
first field to the structure itself. struct rte_ring grows by one
cache line.

For rte_mempool the fields used in the datapath are gathered at the
start: pool_data/pool_id, local_cache, ops_index and cache_size.
The remaining fields, along with pool_config, mz and name, follow.
Previously local_cache and ops_index were in the second cache line.
struct rte_mempool stays 192 bytes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 21 +++++++++++++++++++
 lib/eal/include/rte_memzone.h          |  2 +-
 lib/mempool/rte_mempool.h              | 29 +++++++++++++-------------
 lib/ring/rte_ring_core.h               |  9 ++++----
 4 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..99847e9745 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -139,6 +139,27 @@ ABI Changes
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
+    and ``memzone`` and ``name`` were moved after the size fields
+    to keep the datapath fields in the first cache line.
+
+  * ``struct rte_mempool`` is unchanged in size,
+    but the fields were reordered so the datapath fields
+    (``pool_data``/``pool_id``, ``local_cache``, ``ops_index``
+    and ``cache_size``) come first,
+    and ``name``, ``pool_config`` and ``mz`` were moved after them.
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
index 50d958c7c6..5c7fd46720 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -230,34 +230,35 @@ struct __rte_cache_aligned rte_mempool_info {
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
+	/**
+	 * Index into rte_mempool_ops_table array of mempool ops
+	 * structs, which contain callback function pointers.
+	 * We're using an index here rather than pointers to the callbacks
+	 * to facilitate any secondary processes that may want to use
+	 * this mempool.
+	 */
+	int32_t ops_index;
+	uint32_t cache_size;
+	/**< Size of per-lcore default local cache. */
+
 	unsigned int flags;              /**< Flags of the mempool. */
 	int socket_id;                   /**< Socket id passed at create. */
 	uint32_t size;                   /**< Max size of the mempool. */
-	uint32_t cache_size;
-	/**< Size of per-lcore default local cache. */
 
 	uint32_t elt_size;               /**< Size of an element. */
 	uint32_t header_size;            /**< Size of header (before elt). */
 	uint32_t trailer_size;           /**< Size of trailer (after elt). */
 
 	unsigned private_data_size;      /**< Size of private data. */
-	/**
-	 * Index into rte_mempool_ops_table array of mempool ops
-	 * structs, which contain callback function pointers.
-	 * We're using an index here rather than pointers to the callbacks
-	 * to facilitate any secondary processes that may want to use
-	 * this mempool.
-	 */
-	int32_t ops_index;
 
-	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
+	void *pool_config;               /**< optional args for ops alloc. */
+	const struct rte_memzone *mz;    /**< Memzone where pool is alloc'd. */
+	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
 
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
diff --git a/lib/ring/rte_ring_core.h b/lib/ring/rte_ring_core.h
index 6cd6ce9884..5425cdcef2 100644
--- a/lib/ring/rte_ring_core.h
+++ b/lib/ring/rte_ring_core.h
@@ -113,15 +113,14 @@ struct rte_ring_hts_headtail {
  * values in a modulo-32bit base: that's why the overflow of the indexes is not
  * a problem.
  */
-struct rte_ring {
-	alignas(RTE_CACHE_LINE_SIZE) char name[RTE_RING_NAMESIZE];
-	/**< Name of the ring. */
+struct __rte_cache_aligned rte_ring {
 	int flags;               /**< Flags supplied at creation. */
-	const struct rte_memzone *memzone;
-			/**< Memzone, if any, containing the rte_ring */
 	uint32_t size;           /**< Size of ring. */
 	uint32_t mask;           /**< Mask (size-1) of ring. */
 	uint32_t capacity;       /**< Usable size of ring */
+	const struct rte_memzone *memzone;
+			/**< Memzone, if any, containing the rte_ring */
+	char name[RTE_RING_NAMESIZE]; /**< Name of the ring. */
 
 	RTE_CACHE_GUARD;
 
-- 
2.53.0

