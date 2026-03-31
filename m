Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758F10F9304
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 684D940B95;
	Tue, 31 Mar 2026 23:41:40 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 0EB4E40B8D
 for <dev@dpdk.org>; Tue, 31 Mar 2026 23:41:39 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so56595455e9.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774993298; x=1775598098; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnmKQmxMyQIf7Ob2mcMwDK4kFOqR2Eo/On37mRhnoeI=;
 b=A38NJJZ5Jko+s4qk15utYaSTJ+k7d6LT3ZT2j4Pouw40bvwEyI21i+YjIWGAsLd/A0
 xsPTP8kRqmpTugXSKGAyHbcnB++fJ1HycwByGyCJBf4iDcuEPhpEjEkzyXrRLTCSYF/5
 2i08ms3pweAJSY4Dw286w14YnNySlwAZdzLgvzD30cUXRNVODwPF6aPArkk68SA2cIr/
 TwlhiwOB88Ja0J89xwqglhGBlh4YH/RB/b7ls53nYjbwyJ4V31nyIqTgLuCGZ2zKFLIE
 as8xP2JL3uF5z+uMyZLd9uZbrNmqqWxfPf1EYZLilfd67LByjwIr+M+1wX5qLEbTKTh8
 hgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774993298; x=1775598098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnmKQmxMyQIf7Ob2mcMwDK4kFOqR2Eo/On37mRhnoeI=;
 b=beHPuTG7sWAi8781bKiS/iZjJP2cHriopP6H4JpqLGQ2+ThKZ49dbtluAMI89ftUcI
 6eisqWEKptRB/wM5xuM2OpZ8kFbRyUrmPZG01DSpQk2ss5J+mZlEJeaaoUVcQOUYDj1S
 25s2O0N9bS54jLrwK4h8FvxotD8MdGJRKbzwZlOW81hL8aLfpLJI/QcwpVBHdNu3XtPD
 8/YsYGLh8Sbljf3KGUQcMn8JApu9R71a+8yDUH1VG9lPbsA03bYCVvC9hTPMkyQPRiQ+
 LhnQfUt/1SWcAQAxTXbsXI5LHTbdSv9X1gAn6ms6pcjI1NEHiNLngN0LF0UGG48wV6CV
 NqQQ==
X-Gm-Message-State: AOJu0YznJGBHm+4z8bzd/Vo8uEBkJ8Igv5+Isfv0nMHYCFMqvVTGjVGm
 Xy3E0lrFtLYAzOCEyrEvNtDng3CK09HDE5FUEt+aYELfdQizY8jQQwglHhJEzA==
X-Gm-Gg: ATEYQzxE6/xFVYCm4HlrpwsU+iYWEDHA9HXhBPJwF6GJw/lGG0AC35waThyBnHoEGVH
 0daFG0UDPE+kBjEbs5kLMHuJ+3HgHhaVz9wld4VRNB6aoU7KL/v6dJVFsK0VT0uClRB2ordxfmW
 WT/v0g5ieV1ebqXo4PhWMjiWf2gMXC+Mobj7IDy9mlbwXwNETvNWAlKA554kjFGaAW9xIvhNZbu
 Gg58jHD5w9QHgKA9DBhnkUiiJ00Y7auDVXisMgxjP+eTYUAUgNMVja4C3GAzJ0uPdv9zcPVWpV9
 izlmFCXGvg/EqwbNF8M6/eiBUDyuxyY1iPgIhAhKxC21gFsePFtX68oh3asaO7p2R5ZMdW0l5dT
 AgzbR37wTL3chqhwGlr5jB2P0U2uF3DgHrWqnyeaYOlBiOhRzHHakjfDv++mZwD4QKEw24xXsvL
 orF7gZEB3z7HCtPvoV
X-Received: by 2002:a05:600c:450f:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48883568af7mr16404815e9.5.1774993298421; 
 Tue, 31 Mar 2026 14:41:38 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:5eee:7f89:5053:515f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e884dacsm93524725e9.15.2026.03.31.14.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 14:41:37 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, rjarry@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 2/5] fib: share tbl8 definitions between fib and fib6
Date: Tue, 31 Mar 2026 23:41:14 +0200
Message-ID: <20260331214117.142495-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
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

Extract common tbl8 definitions shared by dir24_8 and trie backends
into a new fib_tbl8.h header:
  - FIB_TBL8_GRP_NUM_ENT constant (was DIR24_8_TBL8_GRP_NUM_ENT
    and TRIE_TBL8_GRP_NUM_ENT)
  - enum fib_nh_sz with static_asserts against public enums
  - fib_tbl8_write() inline (was write_to_fib and write_to_dp)

Convert dir24_8 tbl8 index allocator from bitmap to stack, aligned
with the trie backend which already uses a stack-based allocator.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/dir24_8.c  | 151 +++++++++++++++++++--------------------------
 lib/fib/dir24_8.h  |  17 +++--
 lib/fib/fib_tbl8.h |  50 +++++++++++++++
 lib/fib/trie.c     |  80 +++++++++---------------
 lib/fib/trie.h     |  11 +---
 5 files changed, 155 insertions(+), 154 deletions(-)
 create mode 100644 lib/fib/fib_tbl8.h

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 489d2ef427..935eca12c3 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -17,6 +17,11 @@
 #include "dir24_8.h"
 #include "fib_log.h"
 
+static_assert((int)FIB_NH_SZ_1B == (int)RTE_FIB_DIR24_8_1B, "nh_sz 1B mismatch");
+static_assert((int)FIB_NH_SZ_2B == (int)RTE_FIB_DIR24_8_2B, "nh_sz 2B mismatch");
+static_assert((int)FIB_NH_SZ_4B == (int)RTE_FIB_DIR24_8_4B, "nh_sz 4B mismatch");
+static_assert((int)FIB_NH_SZ_8B == (int)RTE_FIB_DIR24_8_8B, "nh_sz 8B mismatch");
+
 #ifdef CC_AVX512_SUPPORT
 
 #include "dir24_8_avx512.h"
@@ -147,57 +152,27 @@ dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 	return NULL;
 }
 
-static void
-write_to_fib(void *ptr, uint64_t val, enum rte_fib_dir24_8_nh_sz size, int n)
+/*
+ * Get an index of a free tbl8 from the pool
+ */
+static inline int32_t
+tbl8_get(struct dir24_8_tbl *dp)
 {
-	int i;
-	uint8_t *ptr8 = (uint8_t *)ptr;
-	uint16_t *ptr16 = (uint16_t *)ptr;
-	uint32_t *ptr32 = (uint32_t *)ptr;
-	uint64_t *ptr64 = (uint64_t *)ptr;
-
-	switch (size) {
-	case RTE_FIB_DIR24_8_1B:
-		for (i = 0; i < n; i++)
-			ptr8[i] = (uint8_t)val;
-		break;
-	case RTE_FIB_DIR24_8_2B:
-		for (i = 0; i < n; i++)
-			ptr16[i] = (uint16_t)val;
-		break;
-	case RTE_FIB_DIR24_8_4B:
-		for (i = 0; i < n; i++)
-			ptr32[i] = (uint32_t)val;
-		break;
-	case RTE_FIB_DIR24_8_8B:
-		for (i = 0; i < n; i++)
-			ptr64[i] = (uint64_t)val;
-		break;
-	}
-}
+	if (dp->tbl8_pool_pos == dp->number_tbl8s)
+		/* no more free tbl8 */
+		return -ENOSPC;
 
-static int
-tbl8_get_idx(struct dir24_8_tbl *dp)
-{
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
@@ -206,34 +181,32 @@ tbl8_alloc(struct dir24_8_tbl *dp, uint64_t nh)
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
 	tbl8_ptr = (uint8_t *)dp->tbl8 +
-		((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) <<
+		((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) <<
 		dp->nh_sz);
 	/*Init tbl8 entries with nexthop from tbl24*/
-	write_to_fib((void *)tbl8_ptr, nh|
+	fib_tbl8_write((void *)tbl8_ptr, nh|
 		DIR24_8_EXT_ENT, dp->nh_sz,
-		DIR24_8_TBL8_GRP_NUM_ENT);
-	dp->cur_tbl8s++;
+		FIB_TBL8_GRP_NUM_ENT);
 	return tbl8_idx;
 }
 
 static void
 tbl8_cleanup_and_free(struct dir24_8_tbl *dp, uint64_t tbl8_idx)
 {
-	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 
-	memset(ptr, 0, DIR24_8_TBL8_GRP_NUM_ENT << dp->nh_sz);
-	tbl8_free_idx(dp, tbl8_idx);
-	dp->cur_tbl8s--;
+	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	tbl8_put(dp, tbl8_idx);
 }
 
 static void
@@ -258,9 +231,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 	switch (dp->nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
 		ptr8 = &((uint8_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr8;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr8[i])
 				return;
 		}
@@ -269,9 +242,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	case RTE_FIB_DIR24_8_2B:
 		ptr16 = &((uint16_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr16;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr16[i])
 				return;
 		}
@@ -280,9 +253,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	case RTE_FIB_DIR24_8_4B:
 		ptr32 = &((uint32_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr32;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr32[i])
 				return;
 		}
@@ -291,9 +264,9 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 		break;
 	case RTE_FIB_DIR24_8_8B:
 		ptr64 = &((uint64_t *)dp->tbl8)[tbl8_idx *
-				DIR24_8_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr64;
-		for (i = 1; i < DIR24_8_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr64[i])
 				return;
 		}
@@ -337,32 +310,32 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
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
-				write_to_fib(get_tbl24_p(dp, ledge,
+				fib_tbl8_write(get_tbl24_p(dp, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
 					DIR24_8_EXT_ENT,
 					dp->nh_sz, 1);
 			} else
 				tbl8_idx = tbl24_tmp >> 1;
 			tbl8_ptr = (uint8_t *)dp->tbl8 +
-				(((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) +
+				(((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) +
 				(ledge & ~DIR24_8_TBL24_MASK)) <<
 				dp->nh_sz);
 			/*update tbl8 with new next hop*/
-			write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
+			fib_tbl8_write((void *)tbl8_ptr, (next_hop << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, ROUNDUP(ledge, 24) - ledge);
 			tbl8_recycle(dp, ledge, tbl8_idx);
 		}
-		write_to_fib(get_tbl24_p(dp, ROUNDUP(ledge, 24), dp->nh_sz),
+		fib_tbl8_write(get_tbl24_p(dp, ROUNDUP(ledge, 24), dp->nh_sz),
 			next_hop << 1, dp->nh_sz, len);
 		if (redge & ~DIR24_8_TBL24_MASK) {
 			tbl24_tmp = get_tbl24(dp, redge, dp->nh_sz);
@@ -372,17 +345,17 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				if (tbl8_idx < 0)
 					return -ENOSPC;
 				/*update dir24 entry with tbl8 index*/
-				write_to_fib(get_tbl24_p(dp, redge,
+				fib_tbl8_write(get_tbl24_p(dp, redge,
 					dp->nh_sz), (tbl8_idx << 1)|
 					DIR24_8_EXT_ENT,
 					dp->nh_sz, 1);
 			} else
 				tbl8_idx = tbl24_tmp >> 1;
 			tbl8_ptr = (uint8_t *)dp->tbl8 +
-				((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) <<
+				((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) <<
 				dp->nh_sz);
 			/*update tbl8 with new next hop*/
-			write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
+			fib_tbl8_write((void *)tbl8_ptr, (next_hop << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, redge & ~DIR24_8_TBL24_MASK);
 			tbl8_recycle(dp, redge, tbl8_idx);
@@ -395,18 +368,18 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 			if (tbl8_idx < 0)
 				return -ENOSPC;
 			/*update dir24 entry with tbl8 index*/
-			write_to_fib(get_tbl24_p(dp, ledge, dp->nh_sz),
+			fib_tbl8_write(get_tbl24_p(dp, ledge, dp->nh_sz),
 				(tbl8_idx << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, 1);
 		} else
 			tbl8_idx = tbl24_tmp >> 1;
 		tbl8_ptr = (uint8_t *)dp->tbl8 +
-			(((tbl8_idx * DIR24_8_TBL8_GRP_NUM_ENT) +
+			(((tbl8_idx * FIB_TBL8_GRP_NUM_ENT) +
 			(ledge & ~DIR24_8_TBL24_MASK)) <<
 			dp->nh_sz);
 		/*update tbl8 with new next hop*/
-		write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
+		fib_tbl8_write((void *)tbl8_ptr, (next_hop << 1)|
 			DIR24_8_EXT_ENT,
 			dp->nh_sz, redge - ledge);
 		tbl8_recycle(dp, ledge, tbl8_idx);
@@ -561,7 +534,9 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	char mem_name[DIR24_8_NAMESIZE];
 	struct dir24_8_tbl *dp;
 	uint64_t	def_nh;
+	uint64_t	tbl8_sz;
 	uint32_t	num_tbl8;
+	uint32_t	i;
 	enum rte_fib_dir24_8_nh_sz	nh_sz;
 
 	if ((name == NULL) || (fib_conf == NULL) ||
@@ -578,8 +553,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 
 	def_nh = fib_conf->default_nh;
 	nh_sz = fib_conf->dir24_8.nh_sz;
-	num_tbl8 = RTE_ALIGN_CEIL(fib_conf->dir24_8.num_tbl8,
-			BITMAP_SLAB_BIT_SIZE);
+	num_tbl8 = fib_conf->dir24_8.num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
 	dp = rte_zmalloc_socket(name, sizeof(struct dir24_8_tbl) +
@@ -590,11 +564,8 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 		return NULL;
 	}
 
-	/* Init table with default value */
-	write_to_fib(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
-
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	uint64_t tbl8_sz = DIR24_8_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
+	tbl8_sz = FIB_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
 			(num_tbl8 + 1);
 	dp->tbl8 = rte_zmalloc_socket(mem_name, tbl8_sz,
 			RTE_CACHE_LINE_SIZE, socket_id);
@@ -608,16 +579,24 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
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
+	fib_tbl8_write(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
+
 	return dp;
 }
 
@@ -627,7 +606,7 @@ dir24_8_free(void *p)
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
 	rte_rcu_qsbr_dq_delete(dp->dq);
-	rte_free(dp->tbl8_idxes);
+	rte_free(dp->tbl8_pool);
 	rte_free(dp->tbl8);
 	rte_free(dp);
 }
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..e75bd120ad 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -14,24 +14,21 @@
 #include <rte_branch_prediction.h>
 #include <rte_rcu_qsbr.h>
 
+#include "fib_tbl8.h"
+
 /**
  * @file
  * DIR24_8 algorithm
  */
 
 #define DIR24_8_TBL24_NUM_ENT		(1 << 24)
-#define DIR24_8_TBL8_GRP_NUM_ENT	256U
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
@@ -39,7 +36,7 @@ struct dir24_8_tbl {
 	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
 	uint64_t	def_nh;		/**< Default next hop */
 	uint64_t	*tbl8;		/**< tbl8 table. */
-	uint64_t	*tbl8_idxes;	/**< bitmap containing free tbl8 idxes*/
+	uint32_t	*tbl8_pool;	/**< Stack of free tbl8 indices */
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
@@ -72,7 +69,7 @@ get_tbl24_idx(uint32_t ip)
 static  inline uint32_t
 get_tbl8_idx(uint32_t res, uint32_t ip)
 {
-	return (res >> 1) * DIR24_8_TBL8_GRP_NUM_ENT + (uint8_t)ip;
+	return (res >> 1) * FIB_TBL8_GRP_NUM_ENT + (uint8_t)ip;
 }
 
 static inline uint64_t
@@ -133,14 +130,14 @@ static inline void dir24_8_lookup_bulk_##suffix(void *p, const uint32_t *ips, \
 		tmp = ((type *)dp->tbl24)[ips[i] >> 8];			\
 		if (unlikely(is_entry_extended(tmp)))			\
 			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +	\
-				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)]; \
+				((tmp >> 1) * FIB_TBL8_GRP_NUM_ENT)]; \
 		next_hops[i] = tmp >> 1;				\
 	}								\
 	for (; i < n; i++) {						\
 		tmp = ((type *)dp->tbl24)[ips[i] >> 8];			\
 		if (unlikely(is_entry_extended(tmp)))			\
 			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +	\
-				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)]; \
+				((tmp >> 1) * FIB_TBL8_GRP_NUM_ENT)]; \
 		next_hops[i] = tmp >> 1;				\
 	}								\
 }									\
diff --git a/lib/fib/fib_tbl8.h b/lib/fib/fib_tbl8.h
new file mode 100644
index 0000000000..b345c1e489
--- /dev/null
+++ b/lib/fib/fib_tbl8.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Maxime Leroy, Free Mobile
+ */
+
+#ifndef _FIB_TBL8_H_
+#define _FIB_TBL8_H_
+
+/**
+ * @file
+ * Common tbl8 definitions shared by dir24_8 and trie backends.
+ */
+
+#include <stdint.h>
+
+#define FIB_TBL8_GRP_NUM_ENT	256U
+
+/** Nexthop size (log2 of byte width) */
+enum fib_nh_sz {
+	FIB_NH_SZ_1B = 0,
+	FIB_NH_SZ_2B = 1,
+	FIB_NH_SZ_4B = 2,
+	FIB_NH_SZ_8B = 3,
+};
+
+static inline void
+fib_tbl8_write(void *ptr, uint64_t val, uint8_t nh_sz, int n)
+{
+	int i;
+
+	switch (nh_sz) {
+	case FIB_NH_SZ_1B:
+		for (i = 0; i < n; i++)
+			((uint8_t *)ptr)[i] = (uint8_t)val;
+		break;
+	case FIB_NH_SZ_2B:
+		for (i = 0; i < n; i++)
+			((uint16_t *)ptr)[i] = (uint16_t)val;
+		break;
+	case FIB_NH_SZ_4B:
+		for (i = 0; i < n; i++)
+			((uint32_t *)ptr)[i] = (uint32_t)val;
+		break;
+	case FIB_NH_SZ_8B:
+		for (i = 0; i < n; i++)
+			((uint64_t *)ptr)[i] = (uint64_t)val;
+		break;
+	}
+}
+
+#endif /* _FIB_TBL8_H_ */
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..198fc54395 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -16,6 +16,10 @@
 #include "fib_log.h"
 #include "trie.h"
 
+static_assert((int)FIB_NH_SZ_2B == (int)RTE_FIB6_TRIE_2B, "nh_sz 2B mismatch");
+static_assert((int)FIB_NH_SZ_4B == (int)RTE_FIB6_TRIE_4B, "nh_sz 4B mismatch");
+static_assert((int)FIB_NH_SZ_8B == (int)RTE_FIB6_TRIE_8B, "nh_sz 8B mismatch");
+
 #ifdef CC_AVX512_SUPPORT
 
 #include "trie_avx512.h"
@@ -95,30 +99,6 @@ trie_get_lookup_fn(void *p, enum rte_fib6_lookup_type type)
 	return NULL;
 }
 
-static void
-write_to_dp(void *ptr, uint64_t val, enum rte_fib_trie_nh_sz size, int n)
-{
-	int i;
-	uint16_t *ptr16 = (uint16_t *)ptr;
-	uint32_t *ptr32 = (uint32_t *)ptr;
-	uint64_t *ptr64 = (uint64_t *)ptr;
-
-	switch (size) {
-	case RTE_FIB6_TRIE_2B:
-		for (i = 0; i < n; i++)
-			ptr16[i] = (uint16_t)val;
-		break;
-	case RTE_FIB6_TRIE_4B:
-		for (i = 0; i < n; i++)
-			ptr32[i] = (uint32_t)val;
-		break;
-	case RTE_FIB6_TRIE_8B:
-		for (i = 0; i < n; i++)
-			ptr64[i] = (uint64_t)val;
-		break;
-	}
-}
-
 static void
 tbl8_pool_init(struct rte_trie_tbl *dp)
 {
@@ -170,19 +150,19 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	if (tbl8_idx < 0)
 		return tbl8_idx;
 	tbl8_ptr = get_tbl_p_by_idx(dp->tbl8,
-		tbl8_idx * TRIE_TBL8_GRP_NUM_ENT, dp->nh_sz);
+		tbl8_idx * FIB_TBL8_GRP_NUM_ENT, dp->nh_sz);
 	/*Init tbl8 entries with nexthop from tbl24*/
-	write_to_dp((void *)tbl8_ptr, nh, dp->nh_sz,
-		TRIE_TBL8_GRP_NUM_ENT);
+	fib_tbl8_write((void *)tbl8_ptr, nh, dp->nh_sz,
+		FIB_TBL8_GRP_NUM_ENT);
 	return tbl8_idx;
 }
 
 static void
 tbl8_cleanup_and_free(struct rte_trie_tbl *dp, uint64_t tbl8_idx)
 {
-	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * TRIE_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 
-	memset(ptr, 0, TRIE_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	memset(ptr, 0, FIB_TBL8_GRP_NUM_ENT << dp->nh_sz);
 	tbl8_put(dp, tbl8_idx);
 }
 
@@ -206,39 +186,39 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 	switch (dp->nh_sz) {
 	case RTE_FIB6_TRIE_2B:
 		ptr16 = &((uint16_t *)dp->tbl8)[tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr16;
 		if (nh & TRIE_EXT_ENT)
 			return;
-		for (i = 1; i < TRIE_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr16[i])
 				return;
 		}
-		write_to_dp(par, nh, dp->nh_sz, 1);
+		fib_tbl8_write(par, nh, dp->nh_sz, 1);
 		break;
 	case RTE_FIB6_TRIE_4B:
 		ptr32 = &((uint32_t *)dp->tbl8)[tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr32;
 		if (nh & TRIE_EXT_ENT)
 			return;
-		for (i = 1; i < TRIE_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr32[i])
 				return;
 		}
-		write_to_dp(par, nh, dp->nh_sz, 1);
+		fib_tbl8_write(par, nh, dp->nh_sz, 1);
 		break;
 	case RTE_FIB6_TRIE_8B:
 		ptr64 = &((uint64_t *)dp->tbl8)[tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT];
+				FIB_TBL8_GRP_NUM_ENT];
 		nh = *ptr64;
 		if (nh & TRIE_EXT_ENT)
 			return;
-		for (i = 1; i < TRIE_TBL8_GRP_NUM_ENT; i++) {
+		for (i = 1; i < FIB_TBL8_GRP_NUM_ENT; i++) {
 			if (nh != ptr64[i])
 				return;
 		}
-		write_to_dp(par, nh, dp->nh_sz, 1);
+		fib_tbl8_write(par, nh, dp->nh_sz, 1);
 		break;
 	}
 
@@ -265,7 +245,7 @@ get_idx(const struct rte_ipv6_addr *ip, uint32_t prev_idx, int bytes, int first_
 		bitshift = (int8_t)(((first_byte + bytes - 1) - i)*BYTE_SIZE);
 		idx |= ip->a[i] <<  bitshift;
 	}
-	return (prev_idx * TRIE_TBL8_GRP_NUM_ENT) + idx;
+	return (prev_idx * FIB_TBL8_GRP_NUM_ENT) + idx;
 }
 
 static inline uint64_t
@@ -303,7 +283,7 @@ recycle_root_path(struct rte_trie_tbl *dp, const uint8_t *ip_part,
 
 	if (common_tbl8 != 0) {
 		p = get_tbl_p_by_idx(dp->tbl8, (val >> 1) *
-			TRIE_TBL8_GRP_NUM_ENT + *ip_part, dp->nh_sz);
+			FIB_TBL8_GRP_NUM_ENT + *ip_part, dp->nh_sz);
 		recycle_root_path(dp, ip_part + 1, common_tbl8 - 1, p);
 	}
 	tbl8_recycle(dp, prev, val >> 1);
@@ -327,7 +307,7 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 			idx = tbl8_alloc(dp, val);
 			if (unlikely(idx < 0))
 				return idx;
-			write_to_dp(tbl_ptr, (idx << 1) |
+			fib_tbl8_write(tbl_ptr, (idx << 1) |
 				TRIE_EXT_ENT, dp->nh_sz, 1);
 			prev_idx = idx;
 		} else
@@ -336,7 +316,7 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
 		j = i;
 		cur_tbl = dp->tbl8;
 	}
-	*tbl = get_tbl_p_by_idx(cur_tbl, prev_idx * TRIE_TBL8_GRP_NUM_ENT,
+	*tbl = get_tbl_p_by_idx(cur_tbl, prev_idx * FIB_TBL8_GRP_NUM_ENT,
 		dp->nh_sz);
 	return 0;
 }
@@ -361,22 +341,22 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
 			val = (tbl8_idx << 1)|TRIE_EXT_ENT;
 		}
 		p = get_tbl_p_by_idx(dp->tbl8, (tbl8_idx *
-			TRIE_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
+			FIB_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);
 		ret = write_edge(dp, ip_part + 1, next_hop, len - 1, edge, p);
 		if (ret < 0)
 			return ret;
 		if (edge == LEDGE) {
-			write_to_dp(RTE_PTR_ADD(p, (uintptr_t)(1) << dp->nh_sz),
+			fib_tbl8_write(RTE_PTR_ADD(p, (uintptr_t)(1) << dp->nh_sz),
 				next_hop << 1, dp->nh_sz, UINT8_MAX - *ip_part);
 		} else {
-			write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
-				TRIE_TBL8_GRP_NUM_ENT, dp->nh_sz),
+			fib_tbl8_write(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
+				FIB_TBL8_GRP_NUM_ENT, dp->nh_sz),
 				next_hop << 1, dp->nh_sz, *ip_part);
 		}
 		tbl8_recycle(dp, &val, tbl8_idx);
 	}
 
-	write_to_dp(ent, val, dp->nh_sz, 1);
+	fib_tbl8_write(ent, val, dp->nh_sz, 1);
 	return ret;
 }
 
@@ -444,7 +424,7 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
 	if (right_idx > left_idx + 1) {
 		ent = get_tbl_p_by_idx(common_root_tbl, left_idx + 1,
 			dp->nh_sz);
-		write_to_dp(ent, next_hop << 1, dp->nh_sz,
+		fib_tbl8_write(ent, next_hop << 1, dp->nh_sz,
 			right_idx - (left_idx + 1));
 	}
 	ent = get_tbl_p_by_idx(common_root_tbl, right_idx, dp->nh_sz);
@@ -686,10 +666,10 @@ trie_create(const char *name, int socket_id,
 		return dp;
 	}
 
-	write_to_dp(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
+	fib_tbl8_write(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	dp->tbl8 = rte_zmalloc_socket(mem_name, TRIE_TBL8_GRP_NUM_ENT *
+	dp->tbl8 = rte_zmalloc_socket(mem_name, FIB_TBL8_GRP_NUM_ENT *
 			(1ll << nh_sz) * (num_tbl8 + 1),
 			RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp->tbl8 == NULL) {
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index c34cc2c057..30fa886792 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -11,6 +11,8 @@
 #include <rte_common.h>
 #include <rte_fib6.h>
 
+#include "fib_tbl8.h"
+
 /**
  * @file
  * RTE IPv6 Longest Prefix Match (LPM)
@@ -18,21 +20,14 @@
 
 /* @internal Total number of tbl24 entries. */
 #define TRIE_TBL24_NUM_ENT	(1 << 24)
-/* @internal Number of entries in a tbl8 group. */
-#define TRIE_TBL8_GRP_NUM_ENT	256ULL
 /* @internal Total number of tbl8 groups in the tbl8. */
 #define TRIE_TBL8_NUM_GROUPS	65536
 /* @internal bitmask with valid and valid_group fields set */
 #define TRIE_EXT_ENT		1
 
-#define BITMAP_SLAB_BIT_SIZE_LOG2	6
-#define BITMAP_SLAB_BIT_SIZE		(1ULL << BITMAP_SLAB_BIT_SIZE_LOG2)
-#define BITMAP_SLAB_BITMASK		(BITMAP_SLAB_BIT_SIZE - 1)
-
 struct rte_trie_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
-	uint32_t	cur_tbl8s;	/**< Current cumber of tbl8s */
 	uint64_t	def_nh;		/**< Default next hop */
 	enum rte_fib_trie_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	uint64_t	*tbl8;		/**< tbl8 table. */
@@ -124,7 +119,7 @@ static inline void rte_trie_lookup_bulk_##suffix(void *p,		\
 		j = 3;							\
 		while (is_entry_extended(tmp)) {			\
 			tmp = ((type *)dp->tbl8)[ips[i].a[j++] +	\
-				((tmp >> 1) * TRIE_TBL8_GRP_NUM_ENT)];	\
+				((tmp >> 1) * FIB_TBL8_GRP_NUM_ENT)];	\
 		}							\
 		next_hops[i] = tmp >> 1;				\
 	}								\
-- 
2.43.0

