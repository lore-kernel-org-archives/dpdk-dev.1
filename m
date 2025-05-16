Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D3C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 17:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFB1F4064C;
	Fri, 16 May 2025 19:36:52 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3B433402EB
 for <dev@dpdk.org>; Fri, 16 May 2025 19:36:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F19DC201DB2A; Fri, 16 May 2025 10:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F19DC201DB2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747417007;
 bh=1hHR83i2yzh4o2DZEatVlUEbF0D2+I96RHSKQJHmFWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pfb21wiVEHbene98icMIomRPFUk2Xn/2z381sESLyeOYGDB03Bp96FwZn/aEdLtEM
 1JgjRe0vu4wIS4kzWS0DuAV3kyP95k10Hsm1P3uCDUKhBNM12IZXtaGuRo/bGL6nvQ
 elmv2x1WEo5EoiXb2iYMVrzwKU6pDmdHno6S/n/I=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com,
	dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v2 1/2] lib/lpm: use standard atomic_store_explicit
Date: Fri, 16 May 2025 10:36:41 -0700
Message-Id: <1747417002-28419-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
References: <1733278801-19296-1-git-send-email-andremue@linux.microsoft.com>
 <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
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

MSVC issues the warning below:

../lib/lpm/rte_lpm.c(297): warning C4013
    '__atomic_store' undefined; assuming extern returning int
../lib/lpm/rte_lpm.c(298): error C2065:
    '__ATOMIC_RELAXED': undeclared identifier

The fix is to use standard atomic_store_explicit() instead of
gcc specific __atomic_store().
atomic_store_explicit() was already being used in other parts
of DPDK and is compatible with many compilers, including MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/lpm/rte_lpm.c | 108 ++++++++++++++++++++++++++++++----------------
 lib/lpm/rte_lpm.h |  56 ++++++++++++++----------
 2 files changed, 104 insertions(+), 60 deletions(-)

diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 7058be6918..6dab86a05e 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -298,8 +298,8 @@ __lpm_rcu_qsbr_free_resource(void *p, void *data, unsigned int n)
 
 	RTE_SET_USED(n);
 	/* Set tbl8 group invalid */
-	__atomic_store(&tbl8[tbl8_group_index], &zero_tbl8_entry,
-		__ATOMIC_RELAXED);
+	rte_atomic_store_explicit(&tbl8[tbl8_group_index].val,
+			zero_tbl8_entry.val, rte_memory_order_relaxed);
 }
 
 /* Associate QSBR variable with an LPM object.
@@ -520,8 +520,8 @@ _tbl8_alloc(struct __rte_lpm *i_lpm)
 					RTE_LPM_TBL8_GROUP_NUM_ENTRIES *
 					sizeof(tbl8_entry[0]));
 
-			__atomic_store(tbl8_entry, &new_tbl8_entry,
-					__ATOMIC_RELAXED);
+			rte_atomic_store_explicit(&tbl8_entry->val, new_tbl8_entry.val,
+					rte_memory_order_relaxed);
 
 			/* Return group index for allocated tbl8 group. */
 			return group_idx;
@@ -556,15 +556,19 @@ tbl8_free(struct __rte_lpm *i_lpm, uint32_t tbl8_group_start)
 
 	if (i_lpm->v == NULL) {
 		/* Set tbl8 group invalid*/
-		__atomic_store(&i_lpm->lpm.tbl8[tbl8_group_start], &zero_tbl8_entry,
-				__ATOMIC_RELAXED);
+		struct rte_lpm_tbl_entry *tbl8_entry =
+				&i_lpm->lpm.tbl8[tbl8_group_start];
+		rte_atomic_store_explicit(&tbl8_entry->val, zero_tbl8_entry.val,
+				rte_memory_order_relaxed);
 	} else if (i_lpm->rcu_mode == RTE_LPM_QSBR_MODE_SYNC) {
 		/* Wait for quiescent state change. */
 		rte_rcu_qsbr_synchronize(i_lpm->v,
 			RTE_QSBR_THRID_INVALID);
 		/* Set tbl8 group invalid*/
-		__atomic_store(&i_lpm->lpm.tbl8[tbl8_group_start], &zero_tbl8_entry,
-				__ATOMIC_RELAXED);
+		struct rte_lpm_tbl_entry *tbl8_entry =
+				&i_lpm->lpm.tbl8[tbl8_group_start];
+		rte_atomic_store_explicit(&tbl8_entry->val, zero_tbl8_entry.val,
+				rte_memory_order_relaxed);
 	} else if (i_lpm->rcu_mode == RTE_LPM_QSBR_MODE_DQ) {
 		/* Push into QSBR defer queue. */
 		status = rte_rcu_qsbr_dq_enqueue(i_lpm->dq,
@@ -607,8 +611,10 @@ add_depth_small(struct __rte_lpm *i_lpm, uint32_t ip, uint8_t depth,
 			/* Setting tbl24 entry in one go to avoid race
 			 * conditions
 			 */
-			__atomic_store(&i_lpm->lpm.tbl24[i], &new_tbl24_entry,
-					__ATOMIC_RELEASE);
+			struct rte_lpm_tbl_entry *tbl24_entry =
+					&i_lpm->lpm.tbl24[i];
+			rte_atomic_store_explicit(&tbl24_entry->val, new_tbl24_entry.val,
+					rte_memory_order_release);
 
 			continue;
 		}
@@ -637,9 +643,11 @@ add_depth_small(struct __rte_lpm *i_lpm, uint32_t ip, uint8_t depth,
 					 * Setting tbl8 entry in one go to avoid
 					 * race conditions
 					 */
-					__atomic_store(&i_lpm->lpm.tbl8[j],
-						&new_tbl8_entry,
-						__ATOMIC_RELAXED);
+					struct rte_lpm_tbl_entry *tbl8_entry =
+							&i_lpm->lpm.tbl8[j];
+					rte_atomic_store_explicit(&tbl8_entry->val,
+							new_tbl8_entry.val,
+							rte_memory_order_relaxed);
 
 					continue;
 				}
@@ -684,8 +692,10 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 				.valid_group = i_lpm->lpm.tbl8[i].valid_group,
 				.next_hop = next_hop,
 			};
-			__atomic_store(&i_lpm->lpm.tbl8[i], &new_tbl8_entry,
-					__ATOMIC_RELAXED);
+			struct rte_lpm_tbl_entry *tbl8_entry =
+					&i_lpm->lpm.tbl8[i];
+			rte_atomic_store_explicit(&tbl8_entry->val, new_tbl8_entry.val,
+					rte_memory_order_relaxed);
 		}
 
 		/*
@@ -704,8 +714,10 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 		/* The tbl24 entry must be written only after the
 		 * tbl8 entries are written.
 		 */
-		__atomic_store(&i_lpm->lpm.tbl24[tbl24_index], &new_tbl24_entry,
-				__ATOMIC_RELEASE);
+		struct rte_lpm_tbl_entry *tbl24_entry =
+				&i_lpm->lpm.tbl24[tbl24_index];
+		rte_atomic_store_explicit(&tbl24_entry->val, new_tbl24_entry.val,
+				rte_memory_order_release);
 
 	} /* If valid entry but not extended calculate the index into Table8. */
 	else if (i_lpm->lpm.tbl24[tbl24_index].valid_group == 0) {
@@ -729,8 +741,10 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 				.valid_group = i_lpm->lpm.tbl8[i].valid_group,
 				.next_hop = i_lpm->lpm.tbl24[tbl24_index].next_hop,
 			};
-			__atomic_store(&i_lpm->lpm.tbl8[i], &new_tbl8_entry,
-					__ATOMIC_RELAXED);
+			struct rte_lpm_tbl_entry *tbl8_entry =
+					&i_lpm->lpm.tbl8[i];
+			rte_atomic_store_explicit(&tbl8_entry->val, new_tbl8_entry.val,
+					rte_memory_order_relaxed);
 		}
 
 		tbl8_index = tbl8_group_start + (ip_masked & 0xFF);
@@ -743,8 +757,10 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 				.valid_group = i_lpm->lpm.tbl8[i].valid_group,
 				.next_hop = next_hop,
 			};
-			__atomic_store(&i_lpm->lpm.tbl8[i], &new_tbl8_entry,
-					__ATOMIC_RELAXED);
+			struct rte_lpm_tbl_entry *tbl8_entry =
+					&i_lpm->lpm.tbl8[i];
+			rte_atomic_store_explicit(&tbl8_entry->val, new_tbl8_entry.val,
+					rte_memory_order_relaxed);
 		}
 
 		/*
@@ -763,8 +779,10 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 		/* The tbl24 entry must be written only after the
 		 * tbl8 entries are written.
 		 */
-		__atomic_store(&i_lpm->lpm.tbl24[tbl24_index], &new_tbl24_entry,
-				__ATOMIC_RELEASE);
+		struct rte_lpm_tbl_entry *tbl24_entry =
+				&i_lpm->lpm.tbl24[tbl24_index];
+		rte_atomic_store_explicit(&tbl24_entry->val, new_tbl24_entry.val,
+				rte_memory_order_release);
 
 	} else { /*
 		* If it is valid, extended entry calculate the index into tbl8.
@@ -789,8 +807,10 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 				 * Setting tbl8 entry in one go to avoid race
 				 * condition
 				 */
-				__atomic_store(&i_lpm->lpm.tbl8[i], &new_tbl8_entry,
-						__ATOMIC_RELAXED);
+				struct rte_lpm_tbl_entry *tbl8_entry =
+						&i_lpm->lpm.tbl8[i];
+				rte_atomic_store_explicit(&tbl8_entry->val,
+						new_tbl8_entry.val, rte_memory_order_relaxed);
 
 				continue;
 			}
@@ -931,8 +951,10 @@ delete_depth_small(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 
 			if (i_lpm->lpm.tbl24[i].valid_group == 0 &&
 					i_lpm->lpm.tbl24[i].depth <= depth) {
-				__atomic_store(&i_lpm->lpm.tbl24[i],
-					&zero_tbl24_entry, __ATOMIC_RELEASE);
+				struct rte_lpm_tbl_entry *tbl24_entry =
+						&i_lpm->lpm.tbl24[i];
+				rte_atomic_store_explicit(&tbl24_entry->val,
+						zero_tbl24_entry.val, rte_memory_order_release);
 			} else if (i_lpm->lpm.tbl24[i].valid_group == 1) {
 				/*
 				 * If TBL24 entry is extended, then there has
@@ -977,8 +999,10 @@ delete_depth_small(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 
 			if (i_lpm->lpm.tbl24[i].valid_group == 0 &&
 					i_lpm->lpm.tbl24[i].depth <= depth) {
-				__atomic_store(&i_lpm->lpm.tbl24[i], &new_tbl24_entry,
-						__ATOMIC_RELEASE);
+				struct rte_lpm_tbl_entry *tbl24_entry =
+						&i_lpm->lpm.tbl24[i];
+				rte_atomic_store_explicit(&tbl24_entry->val,
+						new_tbl24_entry.val, rte_memory_order_release);
 			} else  if (i_lpm->lpm.tbl24[i].valid_group == 1) {
 				/*
 				 * If TBL24 entry is extended, then there has
@@ -993,10 +1017,13 @@ delete_depth_small(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 				for (j = tbl8_index; j < (tbl8_index +
 					RTE_LPM_TBL8_GROUP_NUM_ENTRIES); j++) {
 
-					if (i_lpm->lpm.tbl8[j].depth <= depth)
-						__atomic_store(&i_lpm->lpm.tbl8[j],
-							&new_tbl8_entry,
-							__ATOMIC_RELAXED);
+					if (i_lpm->lpm.tbl8[j].depth <= depth) {
+						struct rte_lpm_tbl_entry *tbl8_entry =
+								&i_lpm->lpm.tbl8[j];
+						rte_atomic_store_explicit(&tbl8_entry->val,
+								new_tbl8_entry.val,
+								rte_memory_order_relaxed);
+					}
 				}
 			}
 		}
@@ -1104,9 +1131,12 @@ delete_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 		 * rule_to_delete must be modified.
 		 */
 		for (i = tbl8_index; i < (tbl8_index + tbl8_range); i++) {
-			if (i_lpm->lpm.tbl8[i].depth <= depth)
-				__atomic_store(&i_lpm->lpm.tbl8[i], &new_tbl8_entry,
-						__ATOMIC_RELAXED);
+			if (i_lpm->lpm.tbl8[i].depth <= depth) {
+				struct rte_lpm_tbl_entry *tbl8_entry =
+						&i_lpm->lpm.tbl8[i];
+				rte_atomic_store_explicit(&tbl8_entry->val,
+						new_tbl8_entry.val, rte_memory_order_relaxed);
+			}
 		}
 	}
 
@@ -1137,8 +1167,10 @@ delete_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 		/* Set tbl24 before freeing tbl8 to avoid race condition.
 		 * Prevent the free of the tbl8 group from hoisting.
 		 */
-		__atomic_store(&i_lpm->lpm.tbl24[tbl24_index], &new_tbl24_entry,
-				__ATOMIC_RELAXED);
+		struct rte_lpm_tbl_entry *tbl24_entry =
+				&i_lpm->lpm.tbl24[tbl24_index];
+		rte_atomic_store_explicit(&tbl24_entry->val, new_tbl24_entry.val,
+				rte_memory_order_relaxed);
 		rte_atomic_thread_fence(rte_memory_order_release);
 		status = tbl8_free(i_lpm, tbl8_group_start);
 	}
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index 7df64f06b1..6bf8d9d883 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -77,38 +77,50 @@ enum rte_lpm_qsbr_mode {
 /** @internal Tbl24 entry structure. */
 __extension__
 struct rte_lpm_tbl_entry {
-	/**
-	 * Stores Next hop (tbl8 or tbl24 when valid_group is not set) or
-	 * a group index pointing to a tbl8 structure (tbl24 only, when
-	 * valid_group is set)
-	 */
-	uint32_t next_hop    :24;
-	/* Using single uint8_t to store 3 values. */
-	uint32_t valid       :1;   /**< Validation flag. */
-	/**
-	 * For tbl24:
-	 *  - valid_group == 0: entry stores a next hop
-	 *  - valid_group == 1: entry stores a group_index pointing to a tbl8
-	 * For tbl8:
-	 *  - valid_group indicates whether the current tbl8 is in use or not
-	 */
-	uint32_t valid_group :1;
-	uint32_t depth       :6; /**< Rule depth. */
+	union {
+		RTE_ATOMIC(uint32_t) val;
+		struct {
+			/**
+			 * Stores Next hop (tbl8 or tbl24 when valid_group is not set) or
+			 * a group index pointing to a tbl8 structure (tbl24 only, when
+			 * valid_group is set)
+			 */
+			uint32_t next_hop    :24;
+			/* Using single uint8_t to store 3 values. */
+			uint32_t valid       :1;   /**< Validation flag. */
+			/**
+			 * For tbl24:
+			 *  - valid_group == 0: entry stores a next hop
+			 *  - valid_group == 1: entry stores a group_index pointing to a tbl8
+			 * For tbl8:
+			 *  - valid_group indicates whether the current tbl8 is in use or not
+			 */
+			uint32_t valid_group :1;
+			uint32_t depth       :6; /**< Rule depth. */
+		};
+	};
 };
 
 #else
 
 __extension__
 struct rte_lpm_tbl_entry {
-	uint32_t depth       :6;
-	uint32_t valid_group :1;
-	uint32_t valid       :1;
-	uint32_t next_hop    :24;
-
+	union {
+		RTE_ATOMIC(uint32_t) val;
+		struct {
+			uint32_t depth       :6;
+			uint32_t valid_group :1;
+			uint32_t valid       :1;
+			uint32_t next_hop    :24;
+		};
+	};
 };
 
 #endif
 
+static_assert(sizeof(struct rte_lpm_tbl_entry) == sizeof(uint32_t),
+		"sizeof(struct rte_lpm_tbl_entry) == sizeof(uint32_t)");
+
 /** LPM configuration structure. */
 struct rte_lpm_config {
 	uint32_t max_rules;      /**< Max number of rules. */
-- 
2.49.0.vfs.0.3

