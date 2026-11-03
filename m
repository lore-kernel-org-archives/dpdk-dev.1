Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A4606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qytz66nU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41BC5427A8;
	Tue,  3 Nov 2026 18:36:17 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 94A6E411F3
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:36:14 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-93efc0452b5so288776385a.0
 for <dev@dpdk.org>; Tue, 03 Nov 2026 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793727373; x=1794332173; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HBZLh8awxjdllxQ2l2KOVjmzUoYYdgbl4P1sK9UtGr0=;
 b=Qytz66nUjKkVMdE+2F7HdoaPU9qroRhevvOSr0m0FZk8n201KHOb8jg9mxMc2Lj71p
 R0QSEhklFI+YnDL/VJNfd10Iz6377xmuV25y7tC3bMTowuQgM90Tv1TH556bhLpZgYTW
 8wTDqz6wiP821MwNG7NckXGCHwupZFp7EcoPnXq8bMvc43s7/VAm7OrqQXzNdzb1TOm2
 e5b5GUASU26F5I74rZxJ7rdkJoYFtfoXBdltOczubvrCVTT2CL7iJh3jVEFxlsPDlv1J
 zFit7iVJ3oIqz5YCqm7xsXqj6VHNfvff+u36in6RGvQuL+yTRdtKzz3mvIq1rWGl/NaC
 eQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793727373; x=1794332173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HBZLh8awxjdllxQ2l2KOVjmzUoYYdgbl4P1sK9UtGr0=;
 b=HdLCXBua8dc9vGK7Z6PevCxJQJQ9g3nXBDkaCKF+nozwDNreTmwYq/NQSy8SIF4bHG
 2XEoMKy2pEGAG3g0ypF1ctGVeEdmiyR1seAaoxVIZDmpqC+VJZmN9ZwI/sBoug5TYvGt
 H5E4U/yqQ2/tkciP0mVTWFhdSMZhtWJdSo4fCFVihp7WndoP5zu2drhuuYCvJYIe1Gx7
 we6U017G1tN4KFdrYgg/1jgBnYUr3ByoAlRmMB6nafnSZSBTGHYGJtP8L7qSb76x9T5K
 70YvHifT5wjmM/1M3dQ6fvduOZ+OSO/yBqf+rsr01Vs0I49WczOue4UhHvFBHZpuvCGp
 F+6g==
X-Gm-Message-State: APuU4Z+K9bMsY7mTlbikiNFrnLkGqrZqRkJ0a03qmKwLyZqgGTnKnr0x
 +qonIZFbI61rdPgkfadRCwwJruBQHccI5+lsAvZqjyEj0hJBLAsPRHLzPqKWQOdg
X-Gm-Gg: AYBFou3TNmA18tA/5Z6HWKbQqqP7ddRqCESlPV52/J4h9OhpZbnjN2h/AK0v2odzHkr
 yk4R5DQJPU0rO7XavKrf/XMbFbe8YCmk+wLlR73EEvcg0vY9dGqC2WSOVMH87XaZbD3mxAVsXAp
 K52SrstncCcydFDzbqcfFyXLuuI1hCAM7qNxn95h4uPgt4SCWnH2nWNY8uswpd+VicWt6U2D0d8
 wuxCzZ9dfN/SQuzIOssm6ZEqUv9mLFEJa3XaDeW5n1Mrb22vL4w/wp2RWYthBRh6czqnrzxSS8S
 WGuD3sVg7aeuY5ESd8ECgi4IvluztBccDG6N1PssTjOUa3N1gFnxaHyaIUgAsQHiK5/uY5hbifW
 3AolOVns20FRImYnNHfzbfMp/RvjXM7QAORBOLiyleUpW97BusdxeELp1dZ3/BKbOh0Jw1L4353
 3TNEZwOWT8B+pYAYhbpoBYxot6D63WWqDhlP5VTKhPJLZqIk+jl5Eg+aVVRq80TNuMiQCKajXy5
 zwFZ4ZKN7lLFP77OYg/kboZxPeTIpV25CveDB3AL9yuiro+fkSF9lgXtodAX/revaitZD2dXZf6
 LZ+ZhZ+yT+Kp6ZzEfeAsAGUzyihAyKpUGFI6EWyqSr5OLz2MyPhzOikhutt19ExT4WjFYTprMpw
 XnmcmEubKptih3AJQz4SFC/A1YpFuhw2Eo8deKiGy5fFPEb6u84O4ee6eFPMm2vU7smEKNn8e3i
 UL
X-Received: by 2002:a05:620a:1a20:b0:944:9dd:b6 with SMTP id
 af79cd13be357-944217cf692mr2259762285a.80.1793727373336; 
 Tue, 03 Nov 2026 09:36:13 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d33c0052sm15113385a.8.2026.11.03.09.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:36:12 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v2 2/3] mempool: fix dump of unpopulated pool
Date: Tue,  3 Nov 2026 12:35:42 -0500
Message-Id: <20261103173543.130142-3-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103173543.130142-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103173543.130142-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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

In rte_mempool_dump() and in the telemetry callback, query the mempool
driver only when RTE_MEMPOOL_F_POOL_CREATED is set, and report a common
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
RTE_MEMPOOL_F_POOL_CREATED before querying the mempool driver.

Fixes: 449c49b93a6b ("mempool: support handler operations")
Fixes: ab8a1cc4e3d8 ("mempool: add object usage counts in telemetry")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/mempool/rte_mempool.c | 36 ++++++++++++++++++++++++++++++++----
 lib/mempool/rte_mempool.h |  9 +++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index d9f339a3c2..c9da42441a 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -294,6 +294,21 @@ rte_mempool_free_memchunks(struct rte_mempool *mp)
 	}
 }
 
+/*
+ * Check whether the mempool driver has allocated its store. Mempools are on
+ * the mempool list before that, so rte_mempool_dump() and rte_mempool_walk()
+ * callbacks can find them while another thread populates them.
+ * Acquire: pairs with the release in mempool_ops_alloc_once().
+ */
+static bool
+mempool_is_created(const struct rte_mempool *mp)
+{
+	return (rte_atomic_load_explicit(
+			(const RTE_ATOMIC(unsigned int) *)&mp->flags,
+			rte_memory_order_acquire) &
+		RTE_MEMPOOL_F_POOL_CREATED) != 0;
+}
+
 static int
 mempool_ops_alloc_once(struct rte_mempool *mp)
 {
@@ -304,7 +319,13 @@ mempool_ops_alloc_once(struct rte_mempool *mp)
 		ret = rte_mempool_ops_alloc(mp);
 		if (ret != 0)
 			return ret;
-		mp->flags |= RTE_MEMPOOL_F_POOL_CREATED;
+		/*
+		 * Release: make the store visible before the flag, see
+		 * mempool_is_created().
+		 */
+		rte_atomic_fetch_or_explicit(
+			(RTE_ATOMIC(unsigned int) *)&mp->flags,
+			RTE_MEMPOOL_F_POOL_CREATED, rte_memory_order_release);
 	}
 	return 0;
 }
@@ -1283,10 +1304,14 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 	unsigned common_count;
 	unsigned cache_count;
 	size_t mem_len = 0;
+	bool created;
 
 	RTE_ASSERT(f != NULL);
 	RTE_ASSERT(mp != NULL);
 
+	/* the mempool driver can only be queried once the store exists */
+	created = mempool_is_created(mp);
+
 	fprintf(f, "mempool <%s>@%p\n", mp->name, mp);
 	fprintf(f, "  flags=%x\n", mp->flags);
 	fprintf(f, "  socket_id=%d\n", mp->socket_id);
@@ -1318,14 +1343,16 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
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
@@ -1653,7 +1680,8 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
 			cache_count += cache->len;
 	}
 	rte_tel_data_add_dict_uint(info->d, "total_cache_count", cache_count);
-	common_count = rte_mempool_ops_get_count(mp);
+	/* the mempool driver can only be queried once the store exists */
+	common_count = mempool_is_created(mp) ? rte_mempool_ops_get_count(mp) : 0;
 	if ((cache_count + common_count) > mp->size)
 		common_count = mp->size - cache_count;
 	rte_tel_data_add_dict_uint(info->d, "common_pool_count", common_count);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index bd58d8a9d5..d8413aa4bf 100644
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
@@ -1950,6 +1953,12 @@ uint32_t rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
  * The mempool list is locked while the iterator function runs, so the
  * iterator function must not create or free a mempool.
  *
+ * The iterator function is also called for mempools that are not
+ * populated yet, which do not have RTE_MEMPOOL_F_POOL_CREATED set in
+ * their flags. Such a mempool has no store yet, so the iterator function
+ * must check this flag before calling functions that query the mempool
+ * driver, such as rte_mempool_avail_count().
+ *
  * @param func
  *   Iterator function
  * @param arg
-- 
2.34.1

