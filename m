Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC6606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqB/qqBh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0DE74067C;
	Tue, 24 Nov 2026 19:03:31 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 75D624067A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:30 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so3335654f8f.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543410; x=1796148210; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZSZvAOs0g45JH5aFs+wIfMcDiHDBglFz37R8EtVleSo=;
 b=NqB/qqBh0dt2KKFOzgU68fjeMH3tIoWwdaMDQSl6glGp9XUVVtZ6DD7pK3k7Lr8TG1
 3yn1GsUAH6gg9E2+nTLMHFb4oqfihR8RvfZJ4kdYorNEUu9Bs+Sxqo6zDRw5rEi/d+jg
 flBUHegSxUojTgiHdtyPLO2p2Pr86YVuMmhox8LwYAynT0jumPOEzcQ5yH7+EPxCcIHJ
 pE+q5nrWE4+8x00dGDSOmYZqqdXsx5B3J6x0mQU33NoiJmyGdXWNF5x1HThKgaF2TyUb
 bLKN0r0aVkTh63BSMgap20xsd3/ivfd/XGO7HyHCdpaW09MJp1rvYq5BI15uvx8sWRxU
 46Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543410; x=1796148210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZSZvAOs0g45JH5aFs+wIfMcDiHDBglFz37R8EtVleSo=;
 b=aOahbVLgxxeypT5EY6+g6As7s5v++fZmQYBCyQPKRn8PXpIIaO+NBxBC0sXoMxaTy7
 B4c/AVLnVz5RBKt350D7QesqbbfXNiQepoVcu6E+8PTo8l10mLluwdloigthPE5bvp9K
 HR1SNg66af38V0ma2Jrj7Z3yLMBM0+gqRggJsiOWmir9JmjIrmE9rjjH1SHpNq1HNDPZ
 fU6mq4r1xr49jqWL3Fu+MDztqzdM1mbzqTWmhjeQvrGyPycz1E5Zufnk1Au+rSy5T04y
 awIhkzPHm7X5vY8wM4dKiLOlWXByxgCN5CIPJ/kmjOaK9wC+Sl8AyXU4H9R8i/HwXdRI
 YTrQ==
X-Gm-Message-State: APuU4Z/HN+L7q0mZ0mY6CihXdtnRXaalKs4aazToxoNQmj+JjpBTAbfc
 FaDp+lx5k9wH9b++gL97jBgdEIYpuiys8OT8xKMMFDp8ywBZ3uOq7MoB
X-Gm-Gg: AZFdTZccmueCJakIgZQNaLfEtMsZ4iRnJurVaA+a4+LabgF8PZOLVw+peKgBQmFYMuD
 eflL1zuOpyYyzb7eYzxj4gdvT/b6mZYEnYFsubeha5ehnn+it8MM2qA245aCA8CwCvOnC9pIML+
 cDWfh89q3EoINFSjtIilmxMEJ+SD4woYtr8wEXVZKll5IRsC5GV/cjogpmRkVBg71++8r+SZ9Bm
 Vv3kuRLPukOeBhFYpqFoMZhfqqA+56O3VERSoaG/q14GC22etFPImRfYUwjrBbFhyLu9YN/cDU2
 FAlkfSndQVDQ+rjtF1y3ZaApc4miWwdhzDtwOG0WQ5iFii6CulBsD+73y+fM3oXg8/IDUc4Z0QF
 mvbKO0dIcNwGJZe2Z384gjfsBmXBvYnBH8vuGVO1ojS5gSwhJ11YMdBkVmlP+BMaWegZqiTqIH6
 6rt6u6wxKlzYBZ6uuwPKZ+3+L8xY1MmrZ085lWCUP3q+Vxmr5AIAilm6jDjfBJ3/0sRKuuhGOj8
 VF/fdZB/B9iGdk7hon+C+dblW7TkOM0XPihLGaSwDPY9Fj1JgzcEJgm1eXxGGuIS9YA+daKV4XX
 SDNT5QbjjNC5FlEwAKRB3OeaFyOlpmn9gKKGtzb6xMo/Fu/Ms/SYVsamIWLB
X-Received: by 2002:a05:6000:2c13:b0:4a6:9f2f:4153 with SMTP id
 ffacd0b85a97d-4abaac57ba9mr29396487f8f.1.1795543409927; 
 Tue, 24 Nov 2026 10:03:29 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf680fsm33630303f8f.14.2026.11.24.10.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:29 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 05/13] fib: use a stack of free tbl8 groups for IPv4
Date: Tue, 24 Nov 2026 19:02:41 +0100
Message-ID: <20261124180249.1099506-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dir24_8 backend finds a free tbl8 group by scanning a bitmap,
while the trie backend pops it from a stack of free indexes. Use the
same stack in dir24_8, so that both backends can share one allocator.

The bitmap worked on 64-bit words, so num_tbl8 was rounded up to a
multiple of 64. The stack holds exactly num_tbl8 groups: a FIB created
with num_tbl8 = 100 now gets 100 groups instead of 128.

Remove the cur_tbl8s counter, which was updated but never read.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/dir24_8.c | 73 ++++++++++++++++++++++++-----------------------
 lib/fib/dir24_8.h |  8 ++----
 2 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 68029c6165..cf924621a2 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -176,28 +176,27 @@ write_to_fib(void *ptr, uint64_t val, enum rte_fib_dir24_8_nh_sz size, int n)
 	}
 }
 
-static int
-tbl8_get_idx(struct dir24_8_tbl *dp)
+/*
+ * Get an index of a free tbl8 from the pool
+ */
+static inline int32_t
+tbl8_get(struct dir24_8_tbl *dp)
 {
-	uint32_t i;
-	int bit_idx;
-
-	for (i = 0; (i < (dp->number_tbl8s >> BITMAP_SLAB_BIT_SIZE_LOG2)) &&
-			(dp->tbl8_idxes[i] == UINT64_MAX); i++)
-		;
-	if (i < (dp->number_tbl8s >> BITMAP_SLAB_BIT_SIZE_LOG2)) {
-		bit_idx = rte_ctz64(~dp->tbl8_idxes[i]);
-		dp->tbl8_idxes[i] |= (1ULL << bit_idx);
-		return (i << BITMAP_SLAB_BIT_SIZE_LOG2) + bit_idx;
-	}
-	return -ENOSPC;
+	if (dp->tbl8_pool_pos == dp->number_tbl8s)
+		/* no more free tbl8 */
+		return -ENOSPC;
+
+	/* next index */
+	return dp->tbl8_pool[dp->tbl8_pool_pos++];
 }
 
+/*
+ * Put an index of a free tbl8 back to the pool
+ */
 static inline void
-tbl8_free_idx(struct dir24_8_tbl *dp, int idx)
+tbl8_put(struct dir24_8_tbl *dp, uint32_t tbl8_ind)
 {
-	dp->tbl8_idxes[idx >> BITMAP_SLAB_BIT_SIZE_LOG2] &=
-		~(1ULL << (idx & BITMAP_SLAB_BITMASK));
+	dp->tbl8_pool[--dp->tbl8_pool_pos] = tbl8_ind;
 }
 
 static int
@@ -206,12 +205,12 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 	int64_t	tbl8_idx;
 	uint8_t	*tbl8_ptr;
 
-	tbl8_idx = tbl8_get_idx(dp);
+	tbl8_idx = tbl8_get(dp);
 
 	/* If there are no tbl8 groups try to reclaim one. */
 	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
 			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
-		tbl8_idx = tbl8_get_idx(dp);
+		tbl8_idx = tbl8_get(dp);
 
 	if (tbl8_idx < 0)
 		return tbl8_idx;
@@ -222,7 +221,6 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
 	write_to_fib((void *)tbl8_ptr, nh|
 		DIR24_8_EXT_ENT, dp->nh_sz,
 		DIR24_8_TBL8_GRP_NUM_ENT);
-	dp->cur_tbl8s++;
 	return tbl8_idx;
 }
 
@@ -232,8 +230,7 @@ tbl8_cleanup_and_free(struct dir24_8_tbl *dp, uint64_t tbl8_idx)
 	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT << dp->nh_sz);
 
 	memset(ptr, 0, DIR24_8_TBL8_GRP_NUM_ENT << dp->nh_sz);
-	tbl8_free_idx(dp, tbl8_idx);
-	dp->cur_tbl8s--;
+	tbl8_put(dp, tbl8_idx);
 }
 
 static void
@@ -337,14 +334,14 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				 * needs tbl8 for ledge and redge.
 				 */
 				tbl8_idx = tbl8_alloc(dp, tbl24_tmp);
-				tmp_tbl8_idx = tbl8_get_idx(dp);
+				tmp_tbl8_idx = tbl8_get(dp);
 				if (tbl8_idx < 0)
 					return -ENOSPC;
 				else if (tmp_tbl8_idx < 0) {
-					tbl8_free_idx(dp, tbl8_idx);
+					tbl8_put(dp, tbl8_idx);
 					return -ENOSPC;
 				}
-				tbl8_free_idx(dp, tmp_tbl8_idx);
+				tbl8_put(dp, tmp_tbl8_idx);
 				/*update dir24 entry with tbl8 index*/
 				write_to_fib(get_tbl24_p(dp, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
@@ -567,7 +564,9 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	char mem_name[DIR24_8_NAMESIZE];
 	struct dir24_8_tbl *dp;
 	uint64_t	def_nh;
+	uint64_t	tbl8_sz;
 	uint32_t	num_tbl8;
+	uint32_t	i;
 	enum rte_fib_dir24_8_nh_sz	nh_sz;
 
 	if ((name == NULL) || (fib_conf == NULL) ||
@@ -584,8 +583,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 
 	def_nh = fib_conf->default_nh;
 	nh_sz = fib_conf->dir24_8.nh_sz;
-	num_tbl8 = RTE_ALIGN_CEIL(fib_conf->dir24_8.num_tbl8,
-			BITMAP_SLAB_BIT_SIZE);
+	num_tbl8 = fib_conf->dir24_8.num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
 	dp = rte_zmalloc_socket(name, sizeof(struct dir24_8_tbl) +
@@ -596,11 +594,8 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 		return NULL;
 	}
 
-	/* Init table with default value */
-	write_to_fib(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
-
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	uint64_t tbl8_sz = DIR24_8_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
+	tbl8_sz = DIR24_8_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
 			(num_tbl8 + 1);
 	dp->tbl8 = rte_zmalloc_socket(mem_name, tbl8_sz,
 			RTE_CACHE_LINE_SIZE, socket_id);
@@ -614,16 +609,24 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	dp->number_tbl8s = num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
-	dp->tbl8_idxes = rte_zmalloc_socket(mem_name,
-			RTE_ALIGN_CEIL(dp->number_tbl8s, 64) >> 3,
+	dp->tbl8_pool = rte_zmalloc_socket(mem_name,
+			sizeof(uint32_t) * dp->number_tbl8s,
 			RTE_CACHE_LINE_SIZE, socket_id);
-	if (dp->tbl8_idxes == NULL) {
+	if (dp->tbl8_pool == NULL) {
 		rte_errno = ENOMEM;
 		rte_free(dp->tbl8);
 		rte_free(dp);
 		return NULL;
 	}
 
+	/* Init pool with all tbl8 indices free */
+	for (i = 0; i < dp->number_tbl8s; i++)
+		dp->tbl8_pool[i] = i;
+	dp->tbl8_pool_pos = 0;
+
+	/* Init table with default value */
+	write_to_fib(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
+
 	return dp;
 }
 
@@ -633,7 +636,7 @@ dir24_8_free(void *p)
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
 	rte_rcu_qsbr_dq_delete(dp->dq);
-	rte_free(dp->tbl8_idxes);
+	rte_free(dp->tbl8_pool);
 	rte_free(dp->tbl8);
 	rte_free(dp);
 }
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..8e74fd4a62 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -24,14 +24,10 @@
 #define DIR24_8_EXT_ENT			1
 #define DIR24_8_TBL24_MASK		0xffffff00
 
-#define BITMAP_SLAB_BIT_SIZE_LOG2	6
-#define BITMAP_SLAB_BIT_SIZE		(1 << BITMAP_SLAB_BIT_SIZE_LOG2)
-#define BITMAP_SLAB_BITMASK		(BITMAP_SLAB_BIT_SIZE - 1)
-
 struct dir24_8_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
-	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
+	uint32_t	tbl8_pool_pos;	/**< Next free index in pool */
 	enum rte_fib_dir24_8_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	/* RCU config. */
 	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
@@ -39,7 +35,7 @@ struct dir24_8_tbl {
 	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
 	uint64_t	def_nh;		/**< Default next hop */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint64_t	*tbl8_idxes;	/**< bitmap containing free tbl8 idxes*/
+	uint32_t	*tbl8_pool;	/**< Stack of free tbl8 indices */
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
-- 
2.43.0

