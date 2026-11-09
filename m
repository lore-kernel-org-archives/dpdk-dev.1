Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C97606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEVYDza7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7ED40A6C;
	Mon,  9 Nov 2026 15:41:24 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 24FC540689
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:41:22 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-91ea43af0caso10006566d6.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794235281; x=1794840081; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fCUIQajhkggB3hoY/AMui25ne+VQf3/Z7Q5T8lhDBGQ=;
 b=vEVYDza7pHxobcNBmk8vvnAWfhIuINoxc2c8YMSPAZy2/XHcNBT0dsKDeRfzhNVkas
 e7SkrTIzwq5oAPEVMkAG3foDaRqK4U+GC+rAFUir2Dvlklied1jx1lxnbs1uePR3Erc0
 uC62FiK0JLP97hsNK5GFCSA07QVfLjF6xNrutFYFXZAq6CnYVaMAFUHfKU9JoDR/QHwN
 TnRA2ZRXKxAsPb7WlJ3D22XlFXW3vDRYyLo0YZT4C0tZKcEowPEXN3W/y3qmcMCYEctX
 uuPm9FjAo38PySFrHyaLRofDZP7drdxXR43Resh6qSkpa/i19nVn7eeUanFKTns0C33T
 Y87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235281; x=1794840081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fCUIQajhkggB3hoY/AMui25ne+VQf3/Z7Q5T8lhDBGQ=;
 b=I5j1nLAberlEJ6sZrTUAF3EGAqAiGYCNCi2tMrznotE4RWOsOt+76cN1hS4vliYKTz
 tAOx8wiTbztg9cYu1cD1+8n66jl5WdNQ+vOV2Uq+dj28niWQcyIVOly+IbIrlzLJ6haL
 W3FexUD9iHYQKelAMK7fIPNQ8MTqqgq68xstqe05ciGMeTRJKRugJfsasGI8/c5PRmpt
 GzF31ZsshYHFQLG1Zeh+Oo0erMUZzcQijOlFJD4kKW6SemwdXiU7E4LfK0SXi4SB5EDn
 VYq6GtXTCsCgOHuw3uqoD/x23ESqISneQ4R/E4mf9ttFzZNNy552uHmzxy+GcS8lOEI/
 NEfQ==
X-Gm-Message-State: APuU4Z+womUgsoVz0VfAb8b+XElCd2rQz9KHMlGCXK0httSoF0APjr4X
 Foz7O7VvheP0ggBhjhRKkqmUjARRk7r8KQOsVMMx/gJP9T/0MFuLCWKyUtzzJKQP
X-Gm-Gg: AYBFou3vP8YT5bis3s6pV0FfxVyCWkG6Z11BnP7tZ8r9IJi7JsYh3yySFa8uC5wsOFO
 +yzZjgeOFG80/gJ3iVaki/Wl7liMn8ER9bE4gSPxsEAuZ/hGpG8Rk6tnbR+kOA64NVMbo7pqr6O
 PSx1W+OSzcLOxS6m4v8HJ6HLhBujfATLRyRH3apeqJerZ4fqnqdDI0412eNp/DeTre0MxdLQeLX
 UHnzW0S6lCHJM5Hs4ge8skw6OcaDxeeS+6JcVOlKuz/8nPm0jVOGtAZbyd4rZmPBqIVSSFbGoib
 5RbyWsGvqsQu0OaNqAtXrhlPHPUOlortfRKLe7Wf5DblaGHUkFKHUSjvl1fISKGtPEyXBl3cGgK
 q+YVC0v4Sb2AetMyStuEhpZujLXGw8uC5ldVERBArAEkFuG+2UCz+30C5i7RQShRb8qVe5Bc/si
 YsxKDIGPqYMWHusqjEt7Y1FkwOeN0MJBzsrR5rQtgPFbGPyQAuYwBAdVgmXyj2ASHnNKh0C+FHc
 ABe7qykNRCifXCJYXMXxQdspyvi+dP7SEOOfuO9thDjtN9JwNdWn2/kYFcdHOrUTLXPAUUFxiw+
 osRrKx8d53HtO77PeHtiu3fIxtgxqxS+1yYJRHOjSyeXxL4EY1FXMjfgXHW6bzFrfdv51/FGj5Q
 aW4e6A83gqaJl3E7iEGP6xC0/+zAIrsugOBOcEaJp8bukE8+2KTK1cNvSkl7aiWLDL+tG0Xrxav
 Y=
X-Received: by 2002:ad4:5e87:0:b0:91e:a0c2:630 with SMTP id
 6a1803df08f44-91ed241b4ecmr55400886d6.21.1794235280788; 
 Mon, 09 Nov 2026 06:41:20 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91eceed448dsm43579846d6.45.2026.11.09.06.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:41:19 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v3 2/3] mempool: fix dump of unpopulated pool
Date: Mon,  9 Nov 2026 09:40:53 -0500
Message-Id: <20261109144054.3784583-3-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109144054.3784583-1-rsanford2@gmail.com>
References: <20261103173543.130142-1-rsanford2@gmail.com>
 <20261109144054.3784583-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

rte_mempool_create_empty() adds a mempool to the mempool list before
the mempool has a store. The store is allocated, and
RTE_MEMPOOL_F_POOL_CREATED is set, by the first populate call. In
between, rte_mempool_dump() queries the mempool driver for the number
of objects in the store. With the ring driver this dereferences a NULL
ring, and the process crashes. rte_mempool_list_dump() calls
rte_mempool_dump() for every mempool on the list, so it crashes when
another thread has created a mempool but not populated it yet. The
telemetry /mempool/info handler has the same problem: its
rte_mempool_walk() callback queries the driver for the same count.

Add rte_mempool_is_created(), which tests RTE_MEMPOOL_F_POOL_CREATED.
In rte_mempool_dump() and in the telemetry callback, query the mempool
driver only when it returns true, and report a common
pool count of 0 otherwise, since the mempool has no objects yet. The
rest of the mempool information is still reported. In statistics
builds, rte_mempool_dump() also skips rte_mempool_ops_get_info() for
such a mempool. The info is now zeroed first; it was left uninitialized
for drivers without a get_info operation.

The populating thread sets the flag without holding a lock, so set it
with an atomic fetch-or with release ordering, and test it with an
atomic load with acquire ordering. A reader that sees the flag then
also sees the store.

rte_mempool_walk() still passes mempools that are not populated yet to
its callback. Document that the callback must check
rte_mempool_is_created() before querying the mempool driver.

Fixes: 449c49b93a6b ("mempool: support handler operations")
Fixes: ab8a1cc4e3d8 ("mempool: add object usage counts in telemetry")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/release_26_11.rst |  7 +++++
 lib/mempool/rte_mempool.c              | 37 +++++++++++++++++++++++---
 lib/mempool/rte_mempool.h              | 26 ++++++++++++++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..1d839398b8 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -82,6 +82,13 @@ New Features
   but objects within each bulk are not ordered as expected by a stack.
   Furthermore, it is not strictly bounded by its size, but might hold more objects.
 
+* **Added function to check if a mempool is created.**
+
+  Added the ``rte_mempool_is_created()`` function
+  to check whether the store of a mempool has been created.
+  ``rte_mempool_walk()`` callbacks can use it to skip mempools
+  that are not populated yet before querying the mempool driver.
+
 * **Added unplug operation support to DPAA bus.**
 
   Implemented device unplug operation to allow runtime removal of DPAA devices.
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index d9f339a3c2..6dc0f146a1 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -294,6 +294,22 @@ rte_mempool_free_memchunks(struct rte_mempool *mp)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_mempool_is_created)
+bool
+rte_mempool_is_created(const struct rte_mempool *mp)
+{
+	/*
+	 * Mempools are on the mempool list before the store is allocated, so
+	 * rte_mempool_dump() and rte_mempool_walk() callbacks can find them
+	 * while another thread populates them.
+	 * Acquire: pairs with the release in mempool_ops_alloc_once().
+	 */
+	return (rte_atomic_load_explicit(
+			(const RTE_ATOMIC(unsigned int) *)&mp->flags,
+			rte_memory_order_acquire) &
+		RTE_MEMPOOL_F_POOL_CREATED) != 0;
+}
+
 static int
 mempool_ops_alloc_once(struct rte_mempool *mp)
 {
@@ -304,7 +320,13 @@ mempool_ops_alloc_once(struct rte_mempool *mp)
 		ret = rte_mempool_ops_alloc(mp);
 		if (ret != 0)
 			return ret;
-		mp->flags |= RTE_MEMPOOL_F_POOL_CREATED;
+		/*
+		 * Release: make the store visible before the flag, see
+		 * rte_mempool_is_created().
+		 */
+		rte_atomic_fetch_or_explicit(
+			(RTE_ATOMIC(unsigned int) *)&mp->flags,
+			RTE_MEMPOOL_F_POOL_CREATED, rte_memory_order_release);
 	}
 	return 0;
 }
@@ -1283,10 +1305,14 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 	unsigned common_count;
 	unsigned cache_count;
 	size_t mem_len = 0;
+	bool created;
 
 	RTE_ASSERT(f != NULL);
 	RTE_ASSERT(mp != NULL);
 
+	/* the mempool driver can only be queried once the store exists */
+	created = rte_mempool_is_created(mp);
+
 	fprintf(f, "mempool <%s>@%p\n", mp->name, mp);
 	fprintf(f, "  flags=%x\n", mp->flags);
 	fprintf(f, "  socket_id=%d\n", mp->socket_id);
@@ -1318,14 +1344,16 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 	}
 
 	cache_count = rte_mempool_dump_cache(f, mp);
-	common_count = rte_mempool_ops_get_count(mp);
+	common_count = created ? rte_mempool_ops_get_count(mp) : 0;
 	if ((cache_count + common_count) > mp->size)
 		common_count = mp->size - cache_count;
 	fprintf(f, "  common_pool_count=%u\n", common_count);
 
 	/* sum and dump statistics */
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
-	rte_mempool_ops_get_info(mp, &info);
+	memset(&info, 0, sizeof(info));
+	if (created)
+		rte_mempool_ops_get_info(mp, &info);
 	memset(&sum, 0, sizeof(sum));
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE + 1; lcore_id++) {
 		sum.put_bulk += mp->stats[lcore_id].put_bulk;
@@ -1653,7 +1681,8 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
 			cache_count += cache->len;
 	}
 	rte_tel_data_add_dict_uint(info->d, "total_cache_count", cache_count);
-	common_count = rte_mempool_ops_get_count(mp);
+	/* the mempool driver can only be queried once the store exists */
+	common_count = rte_mempool_is_created(mp) ? rte_mempool_ops_get_count(mp) : 0;
 	if ((cache_count + common_count) > mp->size)
 		common_count = mp->size - cache_count;
 	rte_tel_data_add_dict_uint(info->d, "common_pool_count", common_count);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index bd58d8a9d5..9bf1220b71 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1325,6 +1325,9 @@ void rte_mempool_stats_reset(struct rte_mempool *mp);
 /**
  * Dump the status of the mempool to a file.
  *
+ * For a mempool that is not populated yet, the mempool driver is not
+ * queried, and the common pool count is reported as 0.
+ *
  * @param f
  *   A pointer to a file for output
  * @param mp
@@ -1791,6 +1794,24 @@ rte_mempool_get_contig_blocks(struct rte_mempool *mp,
 	return ret;
 }
 
+/**
+ * Check if the mempool driver has created the store of a mempool.
+ *
+ * rte_mempool_create_empty() adds a mempool to the mempool list, and
+ * assigns the default mempool driver, before the store exists. The
+ * mempool driver can still be changed with rte_mempool_set_ops_byname()
+ * until the store is created by the first populate call. Functions that
+ * query the mempool driver, such as rte_mempool_avail_count(), must only
+ * be called for a mempool that is created. rte_mempool_walk() callbacks
+ * can see mempools that are not created yet.
+ *
+ * @param mp
+ *   A pointer to the mempool structure.
+ * @return
+ *   true if the store has been created, false otherwise.
+ */
+bool rte_mempool_is_created(const struct rte_mempool *mp);
+
 /**
  * Return the number of entries in the mempool.
  *
@@ -1950,6 +1971,11 @@ uint32_t rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
  * The mempool list is locked while the iterator function runs, so the
  * iterator function must not create or free a mempool.
  *
+ * The iterator function is also called for mempools that are not
+ * populated yet. Such a mempool has no store yet, so the iterator function
+ * must check rte_mempool_is_created() before calling functions that query
+ * the mempool driver, such as rte_mempool_avail_count().
+ *
  * @param func
  *   Iterator function
  * @param arg
-- 
2.34.1

