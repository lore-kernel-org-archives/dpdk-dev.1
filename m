Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB96FC72CB
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 15:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D010540657;
	Sun, 22 Mar 2026 16:42:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 395F7402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 16:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774194143; x=1805730143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LTECUDXhSkCjMJ8cehMogiLXCNF+BBAhw5CzBKy85Yg=;
 b=A5dKwOSYdXjt6AK7c7TqDARh8inMddOeyDf5hqzlK7cw9nNupNtQDELS
 Fby4joVeWND5lQEfqxtaAoomjfB37OtVsL1gMPSsiN9lfKWrLl/7BHgCI
 2QuCxtLXmhU1IqBW9YjCXM4Jt8imIAoiisNOl/X23Yt9vzBe8+KHxhJCi
 iMB8PyIia64RqAO01KhYomJQOMpMdiY/wT/dkAX0X9uDUjSIV9+0I7vkr
 9j1vptTx59+s0IMVgbgM2sp4ODBlls/Hr4nWRMTzmvS6Bb2PzY5YVLKks
 lLhXj+jFETp7WEXx0Lh+jgK8NwLCBIakO4mm9qV+qshDxvMa6o4EQKKF9 Q==;
X-CSE-ConnectionGUID: cF0VxfTYQU6vLKXAjw9AHw==
X-CSE-MsgGUID: +ItG8KwtT/aM2e1SLs+Grw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97832216"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="97832216"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 08:42:22 -0700
X-CSE-ConnectionGUID: T4nNPI4sQ/Ws72aYMDRZQg==
X-CSE-MsgGUID: G9iYsp9DTfGJZiqmbmFW6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="221020818"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2026 08:42:20 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, nsaxena16@gmail.com, mb@smartsharesystems.com,
 adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: [RFC PATCH 1/4] fib: add multi-VRF support
Date: Sun, 22 Mar 2026 15:42:12 +0000
Message-ID: <20260322154215.3686528-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
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

Add VRF (Virtual Routing and Forwarding) support to the IPv4
FIB library, allowing multiple independent routing tables
within a single FIB instance.

Introduce max_vrfs and vrf_default_nh fields in rte_fib_conf
to configure the number of VRFs and per-VRF default nexthops.

Add four new experimental APIs:
- rte_fib_vrf_add() and rte_fib_vrf_delete() to manage routes
  per VRF
- rte_fib_vrf_lookup_bulk() for multi-VRF bulk lookups
- rte_fib_vrf_get_rib() to retrieve a per-VRF RIB handle

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/dir24_8.c        | 241 ++++++++++++++++------
 lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
 lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
 lib/fib/dir24_8_avx512.h |  80 +++++++-
 lib/fib/rte_fib.c        | 158 ++++++++++++---
 lib/fib/rte_fib.h        |  94 ++++++++-
 6 files changed, 988 insertions(+), 260 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 489d2ef427..ad295c5f16 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -32,41 +32,80 @@
 #define ROUNDUP(x, y)	 RTE_ALIGN_CEIL(x, (1 << (32 - y)))
 
 static inline rte_fib_lookup_fn_t
-get_scalar_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
+get_scalar_fn(const struct dir24_8_tbl *dp, enum rte_fib_dir24_8_nh_sz nh_sz,
+	bool be_addr)
 {
+	bool single_vrf = dp->num_vrfs <= 1;
+
 	switch (nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
-		return be_addr ? dir24_8_lookup_bulk_1b_be : dir24_8_lookup_bulk_1b;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_1b_be :
+				dir24_8_lookup_bulk_1b;
+		return be_addr ? dir24_8_lookup_bulk_vrf_1b_be :
+			dir24_8_lookup_bulk_vrf_1b;
 	case RTE_FIB_DIR24_8_2B:
-		return be_addr ? dir24_8_lookup_bulk_2b_be : dir24_8_lookup_bulk_2b;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_2b_be :
+				dir24_8_lookup_bulk_2b;
+		return be_addr ? dir24_8_lookup_bulk_vrf_2b_be :
+			dir24_8_lookup_bulk_vrf_2b;
 	case RTE_FIB_DIR24_8_4B:
-		return be_addr ? dir24_8_lookup_bulk_4b_be : dir24_8_lookup_bulk_4b;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_4b_be :
+				dir24_8_lookup_bulk_4b;
+		return be_addr ? dir24_8_lookup_bulk_vrf_4b_be :
+			dir24_8_lookup_bulk_vrf_4b;
 	case RTE_FIB_DIR24_8_8B:
-		return be_addr ? dir24_8_lookup_bulk_8b_be : dir24_8_lookup_bulk_8b;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_8b_be :
+				dir24_8_lookup_bulk_8b;
+		return be_addr ? dir24_8_lookup_bulk_vrf_8b_be :
+			dir24_8_lookup_bulk_vrf_8b;
 	default:
 		return NULL;
 	}
 }
 
 static inline rte_fib_lookup_fn_t
-get_scalar_fn_inlined(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
+get_scalar_fn_inlined(const struct dir24_8_tbl *dp,
+	enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
 {
+	bool single_vrf = dp->num_vrfs <= 1;
+
 	switch (nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
-		return be_addr ? dir24_8_lookup_bulk_0_be : dir24_8_lookup_bulk_0;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_0_be :
+				dir24_8_lookup_bulk_0;
+		return be_addr ? dir24_8_lookup_bulk_vrf_0_be :
+			dir24_8_lookup_bulk_vrf_0;
 	case RTE_FIB_DIR24_8_2B:
-		return be_addr ? dir24_8_lookup_bulk_1_be : dir24_8_lookup_bulk_1;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_1_be :
+				dir24_8_lookup_bulk_1;
+		return be_addr ? dir24_8_lookup_bulk_vrf_1_be :
+			dir24_8_lookup_bulk_vrf_1;
 	case RTE_FIB_DIR24_8_4B:
-		return be_addr ? dir24_8_lookup_bulk_2_be : dir24_8_lookup_bulk_2;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_2_be :
+				dir24_8_lookup_bulk_2;
+		return be_addr ? dir24_8_lookup_bulk_vrf_2_be :
+			dir24_8_lookup_bulk_vrf_2;
 	case RTE_FIB_DIR24_8_8B:
-		return be_addr ? dir24_8_lookup_bulk_3_be : dir24_8_lookup_bulk_3;
+		if (single_vrf)
+			return be_addr ? dir24_8_lookup_bulk_3_be :
+				dir24_8_lookup_bulk_3;
+		return be_addr ? dir24_8_lookup_bulk_vrf_3_be :
+			dir24_8_lookup_bulk_vrf_3;
 	default:
 		return NULL;
 	}
 }
 
 static inline rte_fib_lookup_fn_t
-get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
+get_vector_fn(const struct dir24_8_tbl *dp, enum rte_fib_dir24_8_nh_sz nh_sz,
+	bool be_addr)
 {
 #ifdef CC_AVX512_SUPPORT
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
@@ -77,24 +116,63 @@ get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
 	if (be_addr && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) <= 0)
 		return NULL;
 
+	if (dp->num_vrfs <= 1) {
+		switch (nh_sz) {
+		case RTE_FIB_DIR24_8_1B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_1b_be :
+				rte_dir24_8_vec_lookup_bulk_1b;
+		case RTE_FIB_DIR24_8_2B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_2b_be :
+				rte_dir24_8_vec_lookup_bulk_2b;
+		case RTE_FIB_DIR24_8_4B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_4b_be :
+				rte_dir24_8_vec_lookup_bulk_4b;
+		case RTE_FIB_DIR24_8_8B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_8b_be :
+				rte_dir24_8_vec_lookup_bulk_8b;
+		default:
+			return NULL;
+		}
+	}
+
+	if (dp->num_vrfs >= 256) {
+		switch (nh_sz) {
+		case RTE_FIB_DIR24_8_1B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_1b_be_large :
+				rte_dir24_8_vec_lookup_bulk_vrf_1b_large;
+		case RTE_FIB_DIR24_8_2B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_2b_be_large :
+				rte_dir24_8_vec_lookup_bulk_vrf_2b_large;
+		case RTE_FIB_DIR24_8_4B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_4b_be_large :
+				rte_dir24_8_vec_lookup_bulk_vrf_4b_large;
+		case RTE_FIB_DIR24_8_8B:
+			return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_8b_be_large :
+				rte_dir24_8_vec_lookup_bulk_vrf_8b_large;
+		default:
+			return NULL;
+		}
+	}
+
 	switch (nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
-		return be_addr ? rte_dir24_8_vec_lookup_bulk_1b_be :
-			rte_dir24_8_vec_lookup_bulk_1b;
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_1b_be :
+			rte_dir24_8_vec_lookup_bulk_vrf_1b;
 	case RTE_FIB_DIR24_8_2B:
-		return be_addr ? rte_dir24_8_vec_lookup_bulk_2b_be :
-			rte_dir24_8_vec_lookup_bulk_2b;
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_2b_be :
+			rte_dir24_8_vec_lookup_bulk_vrf_2b;
 	case RTE_FIB_DIR24_8_4B:
-		return be_addr ? rte_dir24_8_vec_lookup_bulk_4b_be :
-			rte_dir24_8_vec_lookup_bulk_4b;
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_4b_be :
+			rte_dir24_8_vec_lookup_bulk_vrf_4b;
 	case RTE_FIB_DIR24_8_8B:
-		return be_addr ? rte_dir24_8_vec_lookup_bulk_8b_be :
-			rte_dir24_8_vec_lookup_bulk_8b;
+		return be_addr ? rte_dir24_8_vec_lookup_bulk_vrf_8b_be :
+			rte_dir24_8_vec_lookup_bulk_vrf_8b;
 	default:
 		return NULL;
 	}
 #elif defined(RTE_RISCV_FEATURE_V)
 	RTE_SET_USED(be_addr);
+	RTE_SET_USED(dp);
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V) <= 0)
 		return NULL;
 	switch (nh_sz) {
@@ -130,16 +208,17 @@ dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
 
 	switch (type) {
 	case RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO:
-		return get_scalar_fn(nh_sz, be_addr);
+		return get_scalar_fn(dp, nh_sz, be_addr);
 	case RTE_FIB_LOOKUP_DIR24_8_SCALAR_INLINE:
-		return get_scalar_fn_inlined(nh_sz, be_addr);
+		return get_scalar_fn_inlined(dp, nh_sz, be_addr);
 	case RTE_FIB_LOOKUP_DIR24_8_SCALAR_UNI:
-		return be_addr ? dir24_8_lookup_bulk_uni_be : dir24_8_lookup_bulk_uni;
+		return be_addr ? dir24_8_lookup_bulk_uni_be :
+			dir24_8_lookup_bulk_uni;
 	case RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512:
-		return get_vector_fn(nh_sz, be_addr);
+		return get_vector_fn(dp, nh_sz, be_addr);
 	case RTE_FIB_LOOKUP_DEFAULT:
-		ret_fn = get_vector_fn(nh_sz, be_addr);
-		return ret_fn != NULL ? ret_fn : get_scalar_fn(nh_sz, be_addr);
+		ret_fn = get_vector_fn(dp, nh_sz, be_addr);
+		return ret_fn != NULL ? ret_fn : get_scalar_fn(dp, nh_sz, be_addr);
 	default:
 		return NULL;
 	}
@@ -246,15 +325,18 @@ __rcu_qsbr_free_resource(void *p, void *data, unsigned int n __rte_unused)
 }
 
 static void
-tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
+tbl8_recycle(struct dir24_8_tbl *dp, uint16_t vrf_id, uint32_t ip, uint64_t tbl8_idx)
 {
 	uint32_t i;
 	uint64_t nh;
+	uint64_t tbl24_idx;
 	uint8_t *ptr8;
 	uint16_t *ptr16;
 	uint32_t *ptr32;
 	uint64_t *ptr64;
 
+	tbl24_idx = get_tbl24_idx(vrf_id, ip);
+
 	switch (dp->nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
 		ptr8 = &((uint8_t *)dp->tbl8)[tbl8_idx *
@@ -264,7 +346,7 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 			if (nh != ptr8[i])
 				return;
 		}
-		((uint8_t *)dp->tbl24)[ip >> 8] =
+		((uint8_t *)dp->tbl24)[tbl24_idx] =
 			nh & ~DIR24_8_EXT_ENT;
 		break;
 	case RTE_FIB_DIR24_8_2B:
@@ -275,7 +357,7 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 			if (nh != ptr16[i])
 				return;
 		}
-		((uint16_t *)dp->tbl24)[ip >> 8] =
+		((uint16_t *)dp->tbl24)[tbl24_idx] =
 			nh & ~DIR24_8_EXT_ENT;
 		break;
 	case RTE_FIB_DIR24_8_4B:
@@ -286,7 +368,7 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 			if (nh != ptr32[i])
 				return;
 		}
-		((uint32_t *)dp->tbl24)[ip >> 8] =
+		((uint32_t *)dp->tbl24)[tbl24_idx] =
 			nh & ~DIR24_8_EXT_ENT;
 		break;
 	case RTE_FIB_DIR24_8_8B:
@@ -297,7 +379,7 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 			if (nh != ptr64[i])
 				return;
 		}
-		((uint64_t *)dp->tbl24)[ip >> 8] =
+		((uint64_t *)dp->tbl24)[tbl24_idx] =
 			nh & ~DIR24_8_EXT_ENT;
 		break;
 	}
@@ -314,7 +396,7 @@ tbl8_recycle(struct dir24_8_tbl *dp, uint32_t ip, uint64_t tbl8_idx)
 }
 
 static int
-install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
+install_to_fib(struct dir24_8_tbl *dp, uint16_t vrf_id, uint32_t ledge, uint32_t redge,
 	uint64_t next_hop)
 {
 	uint64_t	tbl24_tmp;
@@ -328,7 +410,7 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 
 	if (((ledge >> 8) != (redge >> 8)) || (len == 1 << 24)) {
 		if ((ROUNDUP(ledge, 24) - ledge) != 0) {
-			tbl24_tmp = get_tbl24(dp, ledge, dp->nh_sz);
+			tbl24_tmp = get_tbl24(dp, vrf_id, ledge, dp->nh_sz);
 			if ((tbl24_tmp & DIR24_8_EXT_ENT) !=
 					DIR24_8_EXT_ENT) {
 				/**
@@ -346,7 +428,7 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 				}
 				tbl8_free_idx(dp, tmp_tbl8_idx);
 				/*update dir24 entry with tbl8 index*/
-				write_to_fib(get_tbl24_p(dp, ledge,
+				write_to_fib(get_tbl24_p(dp, vrf_id, ledge,
 					dp->nh_sz), (tbl8_idx << 1)|
 					DIR24_8_EXT_ENT,
 					dp->nh_sz, 1);
@@ -360,19 +442,19 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 			write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, ROUNDUP(ledge, 24) - ledge);
-			tbl8_recycle(dp, ledge, tbl8_idx);
+			tbl8_recycle(dp, vrf_id, ledge, tbl8_idx);
 		}
-		write_to_fib(get_tbl24_p(dp, ROUNDUP(ledge, 24), dp->nh_sz),
+		write_to_fib(get_tbl24_p(dp, vrf_id, ROUNDUP(ledge, 24), dp->nh_sz),
 			next_hop << 1, dp->nh_sz, len);
 		if (redge & ~DIR24_8_TBL24_MASK) {
-			tbl24_tmp = get_tbl24(dp, redge, dp->nh_sz);
+			tbl24_tmp = get_tbl24(dp, vrf_id, redge, dp->nh_sz);
 			if ((tbl24_tmp & DIR24_8_EXT_ENT) !=
 					DIR24_8_EXT_ENT) {
 				tbl8_idx = tbl8_alloc(dp, tbl24_tmp);
 				if (tbl8_idx < 0)
 					return -ENOSPC;
 				/*update dir24 entry with tbl8 index*/
-				write_to_fib(get_tbl24_p(dp, redge,
+				write_to_fib(get_tbl24_p(dp, vrf_id, redge,
 					dp->nh_sz), (tbl8_idx << 1)|
 					DIR24_8_EXT_ENT,
 					dp->nh_sz, 1);
@@ -385,17 +467,17 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 			write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, redge & ~DIR24_8_TBL24_MASK);
-			tbl8_recycle(dp, redge, tbl8_idx);
+			tbl8_recycle(dp, vrf_id, redge, tbl8_idx);
 		}
 	} else if ((redge - ledge) != 0) {
-		tbl24_tmp = get_tbl24(dp, ledge, dp->nh_sz);
+		tbl24_tmp = get_tbl24(dp, vrf_id, ledge, dp->nh_sz);
 		if ((tbl24_tmp & DIR24_8_EXT_ENT) !=
 				DIR24_8_EXT_ENT) {
 			tbl8_idx = tbl8_alloc(dp, tbl24_tmp);
 			if (tbl8_idx < 0)
 				return -ENOSPC;
 			/*update dir24 entry with tbl8 index*/
-			write_to_fib(get_tbl24_p(dp, ledge, dp->nh_sz),
+			write_to_fib(get_tbl24_p(dp, vrf_id, ledge, dp->nh_sz),
 				(tbl8_idx << 1)|
 				DIR24_8_EXT_ENT,
 				dp->nh_sz, 1);
@@ -409,13 +491,13 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 		write_to_fib((void *)tbl8_ptr, (next_hop << 1)|
 			DIR24_8_EXT_ENT,
 			dp->nh_sz, redge - ledge);
-		tbl8_recycle(dp, ledge, tbl8_idx);
+		tbl8_recycle(dp, vrf_id, ledge, tbl8_idx);
 	}
 	return 0;
 }
 
 static int
-modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
+modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint16_t vrf_id, uint32_t ip,
 	uint8_t depth, uint64_t next_hop)
 {
 	struct rte_rib_node *tmp = NULL;
@@ -438,7 +520,7 @@ modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 					(uint32_t)(1ULL << (32 - tmp_depth));
 				continue;
 			}
-			ret = install_to_fib(dp, ledge, redge,
+			ret = install_to_fib(dp, vrf_id, ledge, redge,
 				next_hop);
 			if (ret != 0)
 				return ret;
@@ -454,7 +536,7 @@ modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 			redge = ip + (uint32_t)(1ULL << (32 - depth));
 			if (ledge == redge && ledge != 0)
 				break;
-			ret = install_to_fib(dp, ledge, redge,
+			ret = install_to_fib(dp, vrf_id, ledge, redge,
 				next_hop);
 			if (ret != 0)
 				return ret;
@@ -465,7 +547,7 @@ modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 }
 
 int
-dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op)
 {
 	struct dir24_8_tbl *dp;
@@ -480,8 +562,13 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 		return -EINVAL;
 
 	dp = rte_fib_get_dp(fib);
-	rib = rte_fib_get_rib(fib);
-	RTE_ASSERT((dp != NULL) && (rib != NULL));
+	RTE_ASSERT(dp != NULL);
+
+	if (vrf_id >= dp->num_vrfs)
+		return -EINVAL;
+
+	rib = rte_fib_vrf_get_rib(fib, vrf_id);
+	RTE_ASSERT(rib != NULL);
 
 	if (next_hop > get_max_nh(dp->nh_sz))
 		return -EINVAL;
@@ -495,7 +582,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			rte_rib_get_nh(node, &node_nh);
 			if (node_nh == next_hop)
 				return 0;
-			ret = modify_fib(dp, rib, ip, depth, next_hop);
+			ret = modify_fib(dp, rib, vrf_id, ip, depth, next_hop);
 			if (ret == 0)
 				rte_rib_set_nh(node, next_hop);
 			return 0;
@@ -518,7 +605,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			if (par_nh == next_hop)
 				goto successfully_added;
 		}
-		ret = modify_fib(dp, rib, ip, depth, next_hop);
+		ret = modify_fib(dp, rib, vrf_id, ip, depth, next_hop);
 		if (ret != 0) {
 			rte_rib_remove(rib, ip, depth);
 			return ret;
@@ -536,9 +623,9 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			rte_rib_get_nh(parent, &par_nh);
 			rte_rib_get_nh(node, &node_nh);
 			if (par_nh != node_nh)
-				ret = modify_fib(dp, rib, ip, depth, par_nh);
+				ret = modify_fib(dp, rib, vrf_id, ip, depth, par_nh);
 		} else
-			ret = modify_fib(dp, rib, ip, depth, dp->def_nh);
+			ret = modify_fib(dp, rib, vrf_id, ip, depth, dp->def_nh[vrf_id]);
 		if (ret == 0) {
 			rte_rib_remove(rib, ip, depth);
 			if (depth > 24) {
@@ -562,7 +649,10 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	struct dir24_8_tbl *dp;
 	uint64_t	def_nh;
 	uint32_t	num_tbl8;
+	uint16_t	num_vrfs;
 	enum rte_fib_dir24_8_nh_sz	nh_sz;
+	uint64_t	tbl24_sz;
+	uint16_t	vrf;
 
 	if ((name == NULL) || (fib_conf == NULL) ||
 			(fib_conf->dir24_8.nh_sz < RTE_FIB_DIR24_8_1B) ||
@@ -580,19 +670,56 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	nh_sz = fib_conf->dir24_8.nh_sz;
 	num_tbl8 = RTE_ALIGN_CEIL(fib_conf->dir24_8.num_tbl8,
 			BITMAP_SLAB_BIT_SIZE);
+	num_vrfs = (fib_conf->max_vrfs == 0) ? 1 : fib_conf->max_vrfs;
+
+	/* Validate per-VRF default nexthops if provided */
+	if (fib_conf->vrf_default_nh != NULL) {
+		for (vrf = 0; vrf < num_vrfs; vrf++) {
+			if (fib_conf->vrf_default_nh[vrf] > get_max_nh(nh_sz)) {
+				rte_errno = EINVAL;
+				return NULL;
+			}
+		}
+	}
+
+	tbl24_sz = (uint64_t)num_vrfs * DIR24_8_TBL24_NUM_ENT * (1 << nh_sz);
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
 	dp = rte_zmalloc_socket(name, sizeof(struct dir24_8_tbl) +
-		DIR24_8_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
+		tbl24_sz + sizeof(uint32_t),
 		RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
 	}
 
-	/* Init table with default value */
-	write_to_fib(dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
+	dp->num_vrfs = num_vrfs;
+	dp->nh_sz = nh_sz;
+	dp->number_tbl8s = num_tbl8;
+
+	/* Allocate per-VRF default nexthop array */
+	snprintf(mem_name, sizeof(mem_name), "DEFNH_%p", dp);
+	dp->def_nh = rte_zmalloc_socket(mem_name, num_vrfs * sizeof(uint64_t),
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->def_nh == NULL) {
+		rte_errno = ENOMEM;
+		rte_free(dp);
+		return NULL;
+	}
+
+	/* Initialize all VRFs with default nexthop */
+	for (vrf = 0; vrf < num_vrfs; vrf++) {
+		uint64_t vrf_def_nh = (fib_conf->vrf_default_nh != NULL) ?
+			fib_conf->vrf_default_nh[vrf] : def_nh;
+		dp->def_nh[vrf] = vrf_def_nh;
 
+		/* Init TBL24 for this VRF with default value */
+		uint64_t vrf_offset = (uint64_t)vrf * DIR24_8_TBL24_NUM_ENT;
+		void *vrf_tbl24 = (void *)&((uint8_t *)dp->tbl24)[vrf_offset << nh_sz];
+		write_to_fib(vrf_tbl24, (vrf_def_nh << 1), nh_sz, 1 << 24);
+	}
+
+	/* Allocate shared TBL8 for all VRFs */
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
 	uint64_t tbl8_sz = DIR24_8_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
 			(num_tbl8 + 1);
@@ -600,12 +727,10 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 			RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp->tbl8 == NULL) {
 		rte_errno = ENOMEM;
+		rte_free(dp->def_nh);
 		rte_free(dp);
 		return NULL;
 	}
-	dp->def_nh = def_nh;
-	dp->nh_sz = nh_sz;
-	dp->number_tbl8s = num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
 	dp->tbl8_idxes = rte_zmalloc_socket(mem_name,
@@ -614,6 +739,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	if (dp->tbl8_idxes == NULL) {
 		rte_errno = ENOMEM;
 		rte_free(dp->tbl8);
+		rte_free(dp->def_nh);
 		rte_free(dp);
 		return NULL;
 	}
@@ -629,6 +755,7 @@ dir24_8_free(void *p)
 	rte_rcu_qsbr_dq_delete(dp->dq);
 	rte_free(dp->tbl8_idxes);
 	rte_free(dp->tbl8);
+	rte_free(dp->def_nh);
 	rte_free(dp);
 }
 
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..37a73a3cc2 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -12,6 +12,7 @@
 #include <rte_byteorder.h>
 #include <rte_prefetch.h>
 #include <rte_branch_prediction.h>
+#include <rte_debug.h>
 #include <rte_rcu_qsbr.h>
 
 /**
@@ -32,24 +33,19 @@ struct dir24_8_tbl {
 	uint32_t	number_tbl8s;	/**< Total number of tbl8s */
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
 	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
+	uint16_t	num_vrfs;	/**< Number of VRFs */
 	enum rte_fib_dir24_8_nh_sz	nh_sz;	/**< Size of nexthop entry */
 	/* RCU config. */
 	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
 	struct rte_rcu_qsbr *v;		/* RCU QSBR variable. */
 	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
-	uint64_t	def_nh;		/**< Default next hop */
+	uint64_t	*def_nh;	/**< Per-VRF default next hop array */
 	uint64_t	*tbl8;		/**< tbl8 table. */
 	uint64_t	*tbl8_idxes;	/**< bitmap containing free tbl8 idxes*/
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
 
-static inline void *
-get_tbl24_p(struct dir24_8_tbl *dp, uint32_t ip, uint8_t nh_sz)
-{
-	return (void *)&((uint8_t *)dp->tbl24)[(ip &
-		DIR24_8_TBL24_MASK) >> (8 - nh_sz)];
-}
 
 static inline  uint8_t
 bits_in_nh(uint8_t nh_sz)
@@ -63,14 +59,21 @@ get_max_nh(uint8_t nh_sz)
 	return ((1ULL << (bits_in_nh(nh_sz) - 1)) - 1);
 }
 
-static  inline uint32_t
-get_tbl24_idx(uint32_t ip)
+static  inline uint64_t
+get_tbl24_idx(uint16_t vrf_id, uint32_t ip)
+{
+	return ((uint64_t)vrf_id << 24) + (ip >> 8);
+}
+
+static inline void *
+get_tbl24_p(struct dir24_8_tbl *dp, uint16_t vrf_id, uint32_t ip, uint8_t nh_sz)
 {
-	return ip >> 8;
+	uint64_t idx = get_tbl24_idx(vrf_id, ip);
+	return (void *)&((uint8_t *)dp->tbl24)[idx << nh_sz];
 }
 
-static  inline uint32_t
-get_tbl8_idx(uint32_t res, uint32_t ip)
+static  inline uint64_t
+get_tbl8_idx(uint64_t res, uint32_t ip)
 {
 	return (res >> 1) * DIR24_8_TBL8_GRP_NUM_ENT + (uint8_t)ip;
 }
@@ -87,17 +90,18 @@ get_psd_idx(uint32_t val, uint8_t nh_sz)
 	return val & ((1 << (3 - nh_sz)) - 1);
 }
 
-static inline uint32_t
-get_tbl_idx(uint32_t val, uint8_t nh_sz)
+static inline uint64_t
+get_tbl_idx(uint64_t val, uint8_t nh_sz)
 {
 	return val >> (3 - nh_sz);
 }
 
 static inline uint64_t
-get_tbl24(struct dir24_8_tbl *dp, uint32_t ip, uint8_t nh_sz)
+get_tbl24(struct dir24_8_tbl *dp, uint16_t vrf_id, uint32_t ip, uint8_t nh_sz)
 {
-	return ((dp->tbl24[get_tbl_idx(get_tbl24_idx(ip), nh_sz)] >>
-		(get_psd_idx(get_tbl24_idx(ip), nh_sz) *
+	uint64_t idx = get_tbl24_idx(vrf_id, ip);
+	return ((dp->tbl24[get_tbl_idx(idx, nh_sz)] >>
+		(get_psd_idx(idx, nh_sz) *
 		bits_in_nh(nh_sz))) & lookup_msk(nh_sz));
 }
 
@@ -115,62 +119,92 @@ is_entry_extended(uint64_t ent)
 	return (ent & DIR24_8_EXT_ENT) == DIR24_8_EXT_ENT;
 }
 
-#define LOOKUP_FUNC(suffix, type, bulk_prefetch, nh_sz)			\
-static inline void dir24_8_lookup_bulk_##suffix(void *p, const uint32_t *ips, \
-	uint64_t *next_hops, const unsigned int n)			\
-{									\
-	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;		\
-	uint64_t tmp;							\
-	uint32_t i;							\
-	uint32_t prefetch_offset =					\
-		RTE_MIN((unsigned int)bulk_prefetch, n);		\
-									\
-	for (i = 0; i < prefetch_offset; i++)				\
-		rte_prefetch0(get_tbl24_p(dp, ips[i], nh_sz));		\
-	for (i = 0; i < (n - prefetch_offset); i++) {			\
-		rte_prefetch0(get_tbl24_p(dp,				\
-			ips[i + prefetch_offset], nh_sz));		\
-		tmp = ((type *)dp->tbl24)[ips[i] >> 8];			\
-		if (unlikely(is_entry_extended(tmp)))			\
-			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +	\
-				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)]; \
-		next_hops[i] = tmp >> 1;				\
-	}								\
-	for (; i < n; i++) {						\
-		tmp = ((type *)dp->tbl24)[ips[i] >> 8];			\
-		if (unlikely(is_entry_extended(tmp)))			\
-			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +	\
-				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)]; \
-		next_hops[i] = tmp >> 1;				\
-	}								\
-}									\
-
-LOOKUP_FUNC(1b, uint8_t, 5, 0)
-LOOKUP_FUNC(2b, uint16_t, 6, 1)
-LOOKUP_FUNC(4b, uint32_t, 15, 2)
-LOOKUP_FUNC(8b, uint64_t, 12, 3)
+
+#define LOOKUP_FUNC(suffix, type, bulk_prefetch, nh_sz, is_vrf)			\
+static inline void dir24_8_lookup_bulk_##suffix(void *p,			\
+	const uint16_t *vrf_ids, const uint32_t *ips,				\
+	uint64_t *next_hops, const unsigned int n)				\
+{										\
+	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;			\
+	uint64_t tmp;								\
+	uint32_t i;								\
+	uint32_t prefetch_offset = RTE_MIN((unsigned int)bulk_prefetch, n);	\
+										\
+	if (!is_vrf)								\
+		RTE_SET_USED(vrf_ids);						\
+										\
+	for (i = 0; i < prefetch_offset; i++) {					\
+		uint16_t vid = is_vrf ? vrf_ids[i] : 0;				\
+		RTE_ASSERT(vid < dp->num_vrfs);					\
+		rte_prefetch0(get_tbl24_p(dp, vid, ips[i], nh_sz));		\
+	}									\
+	for (i = 0; i < (n - prefetch_offset); i++) {				\
+		uint16_t vid = is_vrf ? vrf_ids[i] : 0;				\
+		uint16_t vid_next = is_vrf ? vrf_ids[i + prefetch_offset] : 0;	\
+		RTE_ASSERT(vid < dp->num_vrfs);					\
+		RTE_ASSERT(vid_next < dp->num_vrfs);				\
+		rte_prefetch0(get_tbl24_p(dp, vid_next,				\
+			ips[i + prefetch_offset], nh_sz));			\
+		tmp = ((type *)dp->tbl24)[get_tbl24_idx(vid, ips[i])];		\
+		if (unlikely(is_entry_extended(tmp)))				\
+			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +		\
+				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)];	\
+		next_hops[i] = tmp >> 1;					\
+	}									\
+	for (; i < n; i++) {							\
+		uint16_t vid = is_vrf ? vrf_ids[i] : 0;				\
+		RTE_ASSERT(vid < dp->num_vrfs);				\
+		tmp = ((type *)dp->tbl24)[get_tbl24_idx(vid, ips[i])];		\
+		if (unlikely(is_entry_extended(tmp)))				\
+			tmp = ((type *)dp->tbl8)[(uint8_t)ips[i] +		\
+				((tmp >> 1) * DIR24_8_TBL8_GRP_NUM_ENT)];	\
+		next_hops[i] = tmp >> 1;					\
+	}									\
+}
+
+LOOKUP_FUNC(1b, uint8_t, 5, 0, false)
+LOOKUP_FUNC(2b, uint16_t, 6, 1, false)
+LOOKUP_FUNC(4b, uint32_t, 15, 2, false)
+LOOKUP_FUNC(8b, uint64_t, 12, 3, false)
+LOOKUP_FUNC(vrf_1b, uint8_t, 5, 0, true)
+LOOKUP_FUNC(vrf_2b, uint16_t, 6, 1, true)
+LOOKUP_FUNC(vrf_4b, uint32_t, 15, 2, true)
+LOOKUP_FUNC(vrf_8b, uint64_t, 12, 3, true)
 
 static inline void
-dir24_8_lookup_bulk(struct dir24_8_tbl *dp, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n, uint8_t nh_sz)
+__dir24_8_lookup_bulk(struct dir24_8_tbl *dp, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n,
+	uint8_t nh_sz, bool is_vrf)
 {
 	uint64_t tmp;
 	uint32_t i;
 	uint32_t prefetch_offset = RTE_MIN(15U, n);
 
-	for (i = 0; i < prefetch_offset; i++)
-		rte_prefetch0(get_tbl24_p(dp, ips[i], nh_sz));
+	if (!is_vrf)
+		RTE_SET_USED(vrf_ids);
+
+	for (i = 0; i < prefetch_offset; i++) {
+		uint16_t vid = is_vrf ? vrf_ids[i] : 0;
+		RTE_ASSERT(vid < dp->num_vrfs);
+		rte_prefetch0(get_tbl24_p(dp, vid, ips[i], nh_sz));
+	}
 	for (i = 0; i < (n - prefetch_offset); i++) {
-		rte_prefetch0(get_tbl24_p(dp, ips[i + prefetch_offset],
-			nh_sz));
-		tmp = get_tbl24(dp, ips[i], nh_sz);
+		uint16_t vid = is_vrf ? vrf_ids[i] : 0;
+		uint16_t vid_next = is_vrf ? vrf_ids[i + prefetch_offset] : 0;
+		RTE_ASSERT(vid < dp->num_vrfs);
+		RTE_ASSERT(vid_next < dp->num_vrfs);
+		rte_prefetch0(get_tbl24_p(dp, vid_next,
+			ips[i + prefetch_offset], nh_sz));
+		tmp = get_tbl24(dp, vid, ips[i], nh_sz);
 		if (unlikely(is_entry_extended(tmp)))
 			tmp = get_tbl8(dp, tmp, ips[i], nh_sz);
 
 		next_hops[i] = tmp >> 1;
 	}
 	for (; i < n; i++) {
-		tmp = get_tbl24(dp, ips[i], nh_sz);
+		uint16_t vid = is_vrf ? vrf_ids[i] : 0;
+		RTE_ASSERT(vid < dp->num_vrfs);
+		tmp = get_tbl24(dp, vid, ips[i], nh_sz);
 		if (unlikely(is_entry_extended(tmp)))
 			tmp = get_tbl8(dp, tmp, ips[i], nh_sz);
 
@@ -179,43 +213,79 @@ dir24_8_lookup_bulk(struct dir24_8_tbl *dp, const uint32_t *ips,
 }
 
 static inline void
-dir24_8_lookup_bulk_0(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_0(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
-	dir24_8_lookup_bulk(dp, ips, next_hops, n, 0);
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 0, false);
+}
+
+static inline void
+dir24_8_lookup_bulk_vrf_0(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
+
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 0, true);
 }
 
 static inline void
-dir24_8_lookup_bulk_1(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_1(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
-	dir24_8_lookup_bulk(dp, ips, next_hops, n, 1);
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 1, false);
 }
 
 static inline void
-dir24_8_lookup_bulk_2(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_vrf_1(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
+
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 1, true);
+}
+
+static inline void
+dir24_8_lookup_bulk_2(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
-	dir24_8_lookup_bulk(dp, ips, next_hops, n, 2);
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 2, false);
 }
 
 static inline void
-dir24_8_lookup_bulk_3(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_vrf_2(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
+
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 2, true);
+}
+
+static inline void
+dir24_8_lookup_bulk_3(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
 
-	dir24_8_lookup_bulk(dp, ips, next_hops, n, 3);
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 3, false);
 }
 
 static inline void
-dir24_8_lookup_bulk_uni(void *p, const uint32_t *ips,
+dir24_8_lookup_bulk_vrf_3(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
+
+	__dir24_8_lookup_bulk(dp, vrf_ids, ips, next_hops, n, 3, true);
+}
+
+static inline void
+dir24_8_lookup_bulk_uni(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
@@ -224,66 +294,83 @@ dir24_8_lookup_bulk_uni(void *p, const uint32_t *ips,
 	uint32_t prefetch_offset = RTE_MIN(15U, n);
 	uint8_t nh_sz = dp->nh_sz;
 
-	for (i = 0; i < prefetch_offset; i++)
-		rte_prefetch0(get_tbl24_p(dp, ips[i], nh_sz));
+	for (i = 0; i < prefetch_offset; i++) {
+		uint16_t vid = vrf_ids[i];
+		RTE_ASSERT(vid < dp->num_vrfs);
+		rte_prefetch0(get_tbl24_p(dp, vid, ips[i], nh_sz));
+	}
 	for (i = 0; i < (n - prefetch_offset); i++) {
-		rte_prefetch0(get_tbl24_p(dp, ips[i + prefetch_offset],
-			nh_sz));
-		tmp = get_tbl24(dp, ips[i], nh_sz);
+		uint16_t vid = vrf_ids[i];
+		uint16_t vid_next = vrf_ids[i + prefetch_offset];
+		RTE_ASSERT(vid < dp->num_vrfs);
+		RTE_ASSERT(vid_next < dp->num_vrfs);
+		rte_prefetch0(get_tbl24_p(dp, vid_next,
+			ips[i + prefetch_offset], nh_sz));
+		tmp = get_tbl24(dp, vid, ips[i], nh_sz);
 		if (unlikely(is_entry_extended(tmp)))
 			tmp = get_tbl8(dp, tmp, ips[i], nh_sz);
 
 		next_hops[i] = tmp >> 1;
 	}
 	for (; i < n; i++) {
-		tmp = get_tbl24(dp, ips[i], nh_sz);
+		uint16_t vid = vrf_ids[i];
+		RTE_ASSERT(vid < dp->num_vrfs);
+		tmp = get_tbl24(dp, vid, ips[i], nh_sz);
 		if (unlikely(is_entry_extended(tmp)))
 			tmp = get_tbl8(dp, tmp, ips[i], nh_sz);
 
 		next_hops[i] = tmp >> 1;
 	}
 }
-
 #define BSWAP_MAX_LENGTH	64
 
-typedef void (*dir24_8_lookup_bulk_be_cb)(void *p, const uint32_t *ips, uint64_t *next_hops,
-	const unsigned int n);
+typedef void (*dir24_8_lookup_bulk_be_cb)(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 static inline void
-dir24_8_lookup_bulk_be(void *p, const uint32_t *ips, uint64_t *next_hops, const unsigned int n,
-	dir24_8_lookup_bulk_be_cb cb)
+dir24_8_lookup_bulk_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n, dir24_8_lookup_bulk_be_cb cb)
 {
 	uint32_t le_ips[BSWAP_MAX_LENGTH];
 	unsigned int i;
 
 #if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
-	cb(p, ips, next_hops, n);
+	cb(p, vrf_ids, ips, next_hops, n);
 #else
 	for (i = 0; i < n; i += BSWAP_MAX_LENGTH) {
 		int j;
 		for (j = 0; j < BSWAP_MAX_LENGTH && i + j < n; j++)
 			le_ips[j] = rte_be_to_cpu_32(ips[i + j]);
 
-		cb(p, le_ips, next_hops + i, j);
+		cb(p, vrf_ids + i, le_ips, next_hops + i, j);
 	}
 #endif
 }
 
 #define DECLARE_BE_LOOKUP_FN(name) \
 static inline void \
-name##_be(void *p, const uint32_t *ips, uint64_t *next_hops, const unsigned int n) \
+name##_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips, \
+	uint64_t *next_hops, const unsigned int n) \
 { \
-	dir24_8_lookup_bulk_be(p, ips, next_hops, n, name); \
+	dir24_8_lookup_bulk_be(p, vrf_ids, ips, next_hops, n, name); \
 }
 
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_1b)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_2b)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_4b)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_8b)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_1b)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_2b)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_4b)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_8b)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_0)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_1)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_2)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_3)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_0)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_1)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_2)
+DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_vrf_3)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_uni)
 
 void *
@@ -296,7 +383,7 @@ rte_fib_lookup_fn_t
 dir24_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr);
 
 int
-dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op);
 
 int
diff --git a/lib/fib/dir24_8_avx512.c b/lib/fib/dir24_8_avx512.c
index 89b43583c7..3e576e410e 100644
--- a/lib/fib/dir24_8_avx512.c
+++ b/lib/fib/dir24_8_avx512.c
@@ -4,75 +4,132 @@
 
 #include <rte_vect.h>
 #include <rte_fib.h>
+#include <rte_debug.h>
 
 #include "dir24_8.h"
 #include "dir24_8_avx512.h"
 
+enum vrf_scale {
+	VRF_SCALE_SINGLE = 0,
+	VRF_SCALE_SMALL = 1,
+	VRF_SCALE_LARGE = 2,
+};
+
 static __rte_always_inline void
-dir24_8_vec_lookup_x16(void *p, const uint32_t *ips,
-	uint64_t *next_hops, int size, bool be_addr)
+dir24_8_vec_lookup_x8_64b_path(struct dir24_8_tbl *dp, __m256i ip_vec_256,
+	__m256i vrf32_256, uint64_t *next_hops, int size)
 {
-	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
-	__mmask16 msk_ext;
-	__mmask16 exp_msk = 0x5555;
-	__m512i ip_vec, idxes, res, bytes;
-	const __m512i zero = _mm512_set1_epi32(0);
-	const __m512i lsb = _mm512_set1_epi32(1);
-	const __m512i lsbyte_msk = _mm512_set1_epi32(0xff);
-	__m512i tmp1, tmp2, res_msk;
-	__m256i tmp256;
-	/* used to mask gather values if size is 1/2 (8/16 bit next hops) */
+	const __m512i zero_64 = _mm512_set1_epi64(0);
+	const __m512i lsb_64 = _mm512_set1_epi64(1);
+	const __m512i lsbyte_msk_64 = _mm512_set1_epi64(0xff);
+	__m512i res_msk_64, vrf64, idxes_64, res, bytes_64;
+	__mmask8 msk_ext_64;
+
 	if (size == sizeof(uint8_t))
-		res_msk = _mm512_set1_epi32(UINT8_MAX);
+		res_msk_64 = _mm512_set1_epi64(UINT8_MAX);
 	else if (size == sizeof(uint16_t))
-		res_msk = _mm512_set1_epi32(UINT16_MAX);
+		res_msk_64 = _mm512_set1_epi64(UINT16_MAX);
+	else if (size == sizeof(uint32_t))
+		res_msk_64 = _mm512_set1_epi64(UINT32_MAX);
 
-	ip_vec = _mm512_loadu_si512(ips);
-	if (be_addr) {
-		const __m512i bswap32 = _mm512_set_epi32(
-			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203,
-			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203,
-			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203,
-			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203
-		);
-		ip_vec = _mm512_shuffle_epi8(ip_vec, bswap32);
+	vrf64 = _mm512_cvtepu32_epi64(vrf32_256);
+
+	/* Compute index: (vrf_id << 24) + (ip >> 8) using 64-bit shift */
+	idxes_64 = _mm512_slli_epi64(vrf64, 24);
+	idxes_64 = _mm512_add_epi64(idxes_64, _mm512_cvtepu32_epi64(
+		_mm256_srli_epi32(ip_vec_256, 8)));
+
+	/* lookup in tbl24 */
+	if (size == sizeof(uint8_t)) {
+		res = _mm512_i64gather_epi64(idxes_64, (const void *)dp->tbl24, 1);
+		res = _mm512_and_epi64(res, res_msk_64);
+	} else if (size == sizeof(uint16_t)) {
+		res = _mm512_i64gather_epi64(idxes_64, (const void *)dp->tbl24, 2);
+		res = _mm512_and_epi64(res, res_msk_64);
+	} else {
+		res = _mm512_i64gather_epi64(idxes_64, (const void *)dp->tbl24, 4);
+		res = _mm512_and_epi64(res, res_msk_64);
+	}
+
+	/* get extended entries indexes */
+	msk_ext_64 = _mm512_test_epi64_mask(res, lsb_64);
+
+	if (msk_ext_64 != 0) {
+		bytes_64 = _mm512_cvtepu32_epi64(ip_vec_256);
+		idxes_64 = _mm512_srli_epi64(res, 1);
+		idxes_64 = _mm512_slli_epi64(idxes_64, 8);
+		bytes_64 = _mm512_and_epi64(bytes_64, lsbyte_msk_64);
+		idxes_64 = _mm512_maskz_add_epi64(msk_ext_64, idxes_64, bytes_64);
+
+		if (size == sizeof(uint8_t))
+			idxes_64 = _mm512_mask_i64gather_epi64(zero_64, msk_ext_64,
+				idxes_64, (const void *)dp->tbl8, 1);
+		else if (size == sizeof(uint16_t))
+			idxes_64 = _mm512_mask_i64gather_epi64(zero_64, msk_ext_64,
+				idxes_64, (const void *)dp->tbl8, 2);
+		else
+			idxes_64 = _mm512_mask_i64gather_epi64(zero_64, msk_ext_64,
+				idxes_64, (const void *)dp->tbl8, 4);
+
+		res = _mm512_mask_blend_epi64(msk_ext_64, res, idxes_64);
 	}
 
-	/* mask 24 most significant bits */
-	idxes = _mm512_srli_epi32(ip_vec, 8);
+	res = _mm512_srli_epi64(res, 1);
+	_mm512_storeu_si512(next_hops, res);
+}
+
+static __rte_always_inline void
+dir24_8_vec_lookup_x16_32b_path(struct dir24_8_tbl *dp, __m512i ip_vec,
+	__m512i idxes, uint64_t *next_hops, int size)
+{
+	__mmask16 msk_ext;
+	const __mmask16 exp_msk = 0x5555;
+	const __m512i zero_32 = _mm512_set1_epi32(0);
+	const __m512i lsb_32 = _mm512_set1_epi32(1);
+	const __m512i lsbyte_msk_32 = _mm512_set1_epi32(0xff);
+	__m512i res, bytes, tmp1, tmp2;
+	__m256i tmp256;
+	__m512i res_msk_32;
+
+	if (size == sizeof(uint8_t))
+		res_msk_32 = _mm512_set1_epi32(UINT8_MAX);
+	else if (size == sizeof(uint16_t))
+		res_msk_32 = _mm512_set1_epi32(UINT16_MAX);
 
-	/**
+	/*
 	 * lookup in tbl24
 	 * Put it inside branch to make compiler happy with -O0
 	 */
 	if (size == sizeof(uint8_t)) {
 		res = _mm512_i32gather_epi32(idxes, (const int *)dp->tbl24, 1);
-		res = _mm512_and_epi32(res, res_msk);
+		res = _mm512_and_epi32(res, res_msk_32);
 	} else if (size == sizeof(uint16_t)) {
 		res = _mm512_i32gather_epi32(idxes, (const int *)dp->tbl24, 2);
-		res = _mm512_and_epi32(res, res_msk);
-	} else
+		res = _mm512_and_epi32(res, res_msk_32);
+	} else {
 		res = _mm512_i32gather_epi32(idxes, (const int *)dp->tbl24, 4);
+	}
 
 	/* get extended entries indexes */
-	msk_ext = _mm512_test_epi32_mask(res, lsb);
+	msk_ext = _mm512_test_epi32_mask(res, lsb_32);
 
 	if (msk_ext != 0) {
 		idxes = _mm512_srli_epi32(res, 1);
 		idxes = _mm512_slli_epi32(idxes, 8);
-		bytes = _mm512_and_epi32(ip_vec, lsbyte_msk);
+		bytes = _mm512_and_epi32(ip_vec, lsbyte_msk_32);
 		idxes = _mm512_maskz_add_epi32(msk_ext, idxes, bytes);
 		if (size == sizeof(uint8_t)) {
-			idxes = _mm512_mask_i32gather_epi32(zero, msk_ext,
+			idxes = _mm512_mask_i32gather_epi32(zero_32, msk_ext,
 				idxes, (const int *)dp->tbl8, 1);
-			idxes = _mm512_and_epi32(idxes, res_msk);
+			idxes = _mm512_and_epi32(idxes, res_msk_32);
 		} else if (size == sizeof(uint16_t)) {
-			idxes = _mm512_mask_i32gather_epi32(zero, msk_ext,
+			idxes = _mm512_mask_i32gather_epi32(zero_32, msk_ext,
 				idxes, (const int *)dp->tbl8, 2);
-			idxes = _mm512_and_epi32(idxes, res_msk);
-		} else
-			idxes = _mm512_mask_i32gather_epi32(zero, msk_ext,
+			idxes = _mm512_and_epi32(idxes, res_msk_32);
+		} else {
+			idxes = _mm512_mask_i32gather_epi32(zero_32, msk_ext,
 				idxes, (const int *)dp->tbl8, 4);
+		}
 
 		res = _mm512_mask_blend_epi32(msk_ext, res, idxes);
 	}
@@ -86,16 +143,74 @@ dir24_8_vec_lookup_x16(void *p, const uint32_t *ips,
 	_mm512_storeu_si512(next_hops + 8, tmp2);
 }
 
+/* Unified function with vrf_scale parameter similar to be_addr */
+static __rte_always_inline void
+dir24_8_vec_lookup_x16(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
+	uint64_t *next_hops, int size, bool be_addr, enum vrf_scale vrf_scale)
+{
+	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
+	__m512i ip_vec, idxes;
+	__m256i ip_vec_256, vrf32_256;
+
+	ip_vec = _mm512_loadu_si512(ips);
+	if (be_addr) {
+		const __m512i bswap32 = _mm512_set_epi32(
+			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203,
+			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203,
+			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203,
+			0x0c0d0e0f, 0x08090a0b, 0x04050607, 0x00010203
+		);
+		ip_vec = _mm512_shuffle_epi8(ip_vec, bswap32);
+	}
+
+	if (vrf_scale == VRF_SCALE_SINGLE) {
+		/* mask 24 most significant bits */
+		idxes = _mm512_srli_epi32(ip_vec, 8);
+		dir24_8_vec_lookup_x16_32b_path(dp, ip_vec, idxes, next_hops, size);
+	} else if (vrf_scale == VRF_SCALE_SMALL) {
+		/* For < 256 VRFs: use 32-bit indices with 32-bit shift */
+		__m512i vrf32;
+		uint32_t i;
+
+		for (i = 0; i < 16; i++)
+			RTE_ASSERT(vrf_ids[i] < dp->num_vrfs);
+
+		vrf32 = _mm512_cvtepu16_epi32(_mm256_loadu_si256((const void *)vrf_ids));
+
+		/* mask 24 most significant bits */
+		idxes = _mm512_srli_epi32(ip_vec, 8);
+		idxes = _mm512_add_epi32(idxes, _mm512_slli_epi32(vrf32, 24));
+		dir24_8_vec_lookup_x16_32b_path(dp, ip_vec, idxes, next_hops, size);
+	} else {
+		/* For >= 256 VRFs: use 64-bit indices to avoid overflow */
+		uint32_t i;
+
+		for (i = 0; i < 16; i++)
+			RTE_ASSERT(vrf_ids[i] < dp->num_vrfs);
+
+		/* Extract first 8 IPs and VRF IDs */
+		ip_vec_256 = _mm512_castsi512_si256(ip_vec);
+		vrf32_256 = _mm256_cvtepu16_epi32(_mm_loadu_si128((const void *)vrf_ids));
+		dir24_8_vec_lookup_x8_64b_path(dp, ip_vec_256, vrf32_256, next_hops, size);
+
+		/* Process next 8 IPs from the second half of the vector */
+		ip_vec_256 = _mm512_extracti32x8_epi32(ip_vec, 1);
+		vrf32_256 = _mm256_cvtepu16_epi32(_mm_loadu_si128((const void *)(vrf_ids + 8)));
+		dir24_8_vec_lookup_x8_64b_path(dp, ip_vec_256, vrf32_256, next_hops + 8, size);
+	}
+}
+
+/* Unified function with vrf_scale parameter */
 static __rte_always_inline void
-dir24_8_vec_lookup_x8_8b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, bool be_addr)
+dir24_8_vec_lookup_x8_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, bool be_addr, enum vrf_scale vrf_scale)
 {
 	struct dir24_8_tbl *dp = (struct dir24_8_tbl *)p;
-	const __m512i zero = _mm512_set1_epi32(0);
-	const __m512i lsbyte_msk = _mm512_set1_epi64(0xff);
-	const __m512i lsb = _mm512_set1_epi64(1);
+	const __m512i zero_64 = _mm512_set1_epi64(0);
+	const __m512i lsbyte_msk_64 = _mm512_set1_epi64(0xff);
+	const __m512i lsb_64 = _mm512_set1_epi64(1);
 	__m512i res, idxes, bytes;
-	__m256i idxes_256, ip_vec;
+	__m256i ip_vec, vrf32_256;
 	__mmask8 msk_ext;
 
 	ip_vec = _mm256_loadu_si256((const void *)ips);
@@ -106,66 +221,207 @@ dir24_8_vec_lookup_x8_8b(void *p, const uint32_t *ips,
 		);
 		ip_vec = _mm256_shuffle_epi8(ip_vec, bswap32);
 	}
-	/* mask 24 most significant bits */
-	idxes_256 = _mm256_srli_epi32(ip_vec, 8);
 
-	/* lookup in tbl24 */
-	res = _mm512_i32gather_epi64(idxes_256, (const void *)dp->tbl24, 8);
+	if (vrf_scale == VRF_SCALE_SINGLE) {
+		/* For single VRF: use 32-bit indices without vrf_ids */
+		__m256i idxes_256;
 
-	/* get extended entries indexes */
-	msk_ext = _mm512_test_epi64_mask(res, lsb);
+		/* mask 24 most significant bits */
+		idxes_256 = _mm256_srli_epi32(ip_vec, 8);
 
-	if (msk_ext != 0) {
-		bytes = _mm512_cvtepi32_epi64(ip_vec);
-		idxes = _mm512_srli_epi64(res, 1);
-		idxes = _mm512_slli_epi64(idxes, 8);
-		bytes = _mm512_and_epi64(bytes, lsbyte_msk);
-		idxes = _mm512_maskz_add_epi64(msk_ext, idxes, bytes);
-		idxes = _mm512_mask_i64gather_epi64(zero, msk_ext, idxes,
-			(const void *)dp->tbl8, 8);
-
-		res = _mm512_mask_blend_epi64(msk_ext, res, idxes);
-	}
+		/* lookup in tbl24 */
+		res = _mm512_i32gather_epi64(idxes_256, (const void *)dp->tbl24, 8);
 
-	res = _mm512_srli_epi64(res, 1);
-	_mm512_storeu_si512(next_hops, res);
+		/* get extended entries indexes */
+		msk_ext = _mm512_test_epi64_mask(res, lsb_64);
+
+		if (msk_ext != 0) {
+			bytes = _mm512_cvtepu32_epi64(ip_vec);
+			idxes = _mm512_srli_epi64(res, 1);
+			idxes = _mm512_slli_epi64(idxes, 8);
+			bytes = _mm512_and_epi64(bytes, lsbyte_msk_64);
+			idxes = _mm512_maskz_add_epi64(msk_ext, idxes, bytes);
+			idxes = _mm512_mask_i64gather_epi64(zero_64, msk_ext, idxes,
+				(const void *)dp->tbl8, 8);
+
+			res = _mm512_mask_blend_epi64(msk_ext, res, idxes);
+		}
+
+		res = _mm512_srli_epi64(res, 1);
+		_mm512_storeu_si512(next_hops, res);
+	} else if (vrf_scale == VRF_SCALE_SMALL) {
+		/* For < 256 VRFs: use 32-bit indices with 32-bit shift */
+		__m256i idxes_256;
+		uint32_t i;
+
+		for (i = 0; i < 8; i++)
+			RTE_ASSERT(vrf_ids[i] < dp->num_vrfs);
+
+		/* mask 24 most significant bits */
+		idxes_256 = _mm256_srli_epi32(ip_vec, 8);
+		vrf32_256 = _mm256_cvtepu16_epi32(_mm_loadu_si128((const void *)vrf_ids));
+		idxes_256 = _mm256_add_epi32(idxes_256, _mm256_slli_epi32(vrf32_256, 24));
+
+		/* lookup in tbl24 */
+		res = _mm512_i32gather_epi64(idxes_256, (const void *)dp->tbl24, 8);
+
+		/* get extended entries indexes */
+		msk_ext = _mm512_test_epi64_mask(res, lsb_64);
+
+		if (msk_ext != 0) {
+			bytes = _mm512_cvtepu32_epi64(ip_vec);
+			idxes = _mm512_srli_epi64(res, 1);
+			idxes = _mm512_slli_epi64(idxes, 8);
+			bytes = _mm512_and_epi64(bytes, lsbyte_msk_64);
+			idxes = _mm512_maskz_add_epi64(msk_ext, idxes, bytes);
+			idxes = _mm512_mask_i64gather_epi64(zero_64, msk_ext, idxes,
+				(const void *)dp->tbl8, 8);
+
+			res = _mm512_mask_blend_epi64(msk_ext, res, idxes);
+		}
+
+		res = _mm512_srli_epi64(res, 1);
+		_mm512_storeu_si512(next_hops, res);
+	} else {
+		/* For >= 256 VRFs: use 64-bit indices to avoid overflow */
+		uint32_t i;
+
+		for (i = 0; i < 8; i++)
+			RTE_ASSERT(vrf_ids[i] < dp->num_vrfs);
+
+		vrf32_256 = _mm256_cvtepu16_epi32(_mm_loadu_si128((const void *)vrf_ids));
+		__m512i vrf64 = _mm512_cvtepu32_epi64(vrf32_256);
+
+		/* Compute index: (vrf_id << 24) + (ip >> 8) using 64-bit arithmetic */
+		idxes = _mm512_slli_epi64(vrf64, 24);
+		idxes = _mm512_add_epi64(idxes, _mm512_cvtepu32_epi64(
+			_mm256_srli_epi32(ip_vec, 8)));
+
+		/* lookup in tbl24 with 64-bit gather */
+		res = _mm512_i64gather_epi64(idxes, (const void *)dp->tbl24, 8);
+
+		/* get extended entries indexes */
+		msk_ext = _mm512_test_epi64_mask(res, lsb_64);
+
+		if (msk_ext != 0) {
+			bytes = _mm512_cvtepu32_epi64(ip_vec);
+			idxes = _mm512_srli_epi64(res, 1);
+			idxes = _mm512_slli_epi64(idxes, 8);
+			bytes = _mm512_and_epi64(bytes, lsbyte_msk_64);
+			idxes = _mm512_maskz_add_epi64(msk_ext, idxes, bytes);
+			idxes = _mm512_mask_i64gather_epi64(zero_64, msk_ext, idxes,
+				(const void *)dp->tbl8, 8);
+
+			res = _mm512_mask_blend_epi64(msk_ext, res, idxes);
+		}
+
+		res = _mm512_srli_epi64(res, 1);
+		_mm512_storeu_si512(next_hops, res);
+	}
 }
 
-#define DECLARE_VECTOR_FN(suffix, nh_type, be_addr) \
+#define DECLARE_VECTOR_FN(suffix, scalar_suffix, nh_type, be_addr, vrf_scale) \
 void \
-rte_dir24_8_vec_lookup_bulk_##suffix(void *p, const uint32_t *ips, uint64_t *next_hops, \
-	const unsigned int n) \
+rte_dir24_8_vec_lookup_bulk_##suffix(void *p, const uint16_t *vrf_ids, \
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n) \
 { \
 	uint32_t i; \
 	for (i = 0; i < (n / 16); i++) \
-		dir24_8_vec_lookup_x16(p, ips + i * 16, next_hops + i * 16, sizeof(nh_type), \
-			be_addr); \
-	dir24_8_lookup_bulk_##suffix(p, ips + i * 16, next_hops + i * 16, n - i * 16); \
+		dir24_8_vec_lookup_x16(p, vrf_ids + i * 16, ips + i * 16, \
+			next_hops + i * 16, sizeof(nh_type), be_addr, vrf_scale); \
+	dir24_8_lookup_bulk_##scalar_suffix(p, vrf_ids + i * 16, ips + i * 16, \
+		next_hops + i * 16, n - i * 16); \
+}
+
+DECLARE_VECTOR_FN(1b, 1b, uint8_t, false, VRF_SCALE_SINGLE)
+DECLARE_VECTOR_FN(1b_be, 1b_be, uint8_t, true, VRF_SCALE_SINGLE)
+DECLARE_VECTOR_FN(2b, 2b, uint16_t, false, VRF_SCALE_SINGLE)
+DECLARE_VECTOR_FN(2b_be, 2b_be, uint16_t, true, VRF_SCALE_SINGLE)
+DECLARE_VECTOR_FN(4b, 4b, uint32_t, false, VRF_SCALE_SINGLE)
+DECLARE_VECTOR_FN(4b_be, 4b_be, uint32_t, true, VRF_SCALE_SINGLE)
+
+DECLARE_VECTOR_FN(vrf_1b, vrf_1b, uint8_t, false, VRF_SCALE_SMALL)
+DECLARE_VECTOR_FN(vrf_1b_be, vrf_1b_be, uint8_t, true, VRF_SCALE_SMALL)
+DECLARE_VECTOR_FN(vrf_2b, vrf_2b, uint16_t, false, VRF_SCALE_SMALL)
+DECLARE_VECTOR_FN(vrf_2b_be, vrf_2b_be, uint16_t, true, VRF_SCALE_SMALL)
+DECLARE_VECTOR_FN(vrf_4b, vrf_4b, uint32_t, false, VRF_SCALE_SMALL)
+DECLARE_VECTOR_FN(vrf_4b_be, vrf_4b_be, uint32_t, true, VRF_SCALE_SMALL)
+
+DECLARE_VECTOR_FN(vrf_1b_large, vrf_1b, uint8_t, false, VRF_SCALE_LARGE)
+DECLARE_VECTOR_FN(vrf_1b_be_large, vrf_1b_be, uint8_t, true, VRF_SCALE_LARGE)
+DECLARE_VECTOR_FN(vrf_2b_large, vrf_2b, uint16_t, false, VRF_SCALE_LARGE)
+DECLARE_VECTOR_FN(vrf_2b_be_large, vrf_2b_be, uint16_t, true, VRF_SCALE_LARGE)
+DECLARE_VECTOR_FN(vrf_4b_large, vrf_4b, uint32_t, false, VRF_SCALE_LARGE)
+DECLARE_VECTOR_FN(vrf_4b_be_large, vrf_4b_be, uint32_t, true, VRF_SCALE_LARGE)
+
+void
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+	for (i = 0; i < (n / 8); i++)
+		dir24_8_vec_lookup_x8_8b(p, vrf_ids + i * 8, ips + i * 8,
+			next_hops + i * 8, false, VRF_SCALE_SINGLE);
+	dir24_8_lookup_bulk_8b(p, vrf_ids + i * 8, ips + i * 8,
+		next_hops + i * 8, n - i * 8);
+}
+
+void
+rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+	for (i = 0; i < (n / 8); i++)
+		dir24_8_vec_lookup_x8_8b(p, vrf_ids + i * 8, ips + i * 8,
+			next_hops + i * 8, true, VRF_SCALE_SINGLE);
+	dir24_8_lookup_bulk_8b_be(p, vrf_ids + i * 8, ips + i * 8,
+		next_hops + i * 8, n - i * 8);
+}
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+	for (i = 0; i < (n / 8); i++)
+		dir24_8_vec_lookup_x8_8b(p, vrf_ids + i * 8, ips + i * 8,
+			next_hops + i * 8, false, VRF_SCALE_SMALL);
+	dir24_8_lookup_bulk_vrf_8b(p, vrf_ids + i * 8, ips + i * 8,
+		next_hops + i * 8, n - i * 8);
 }
 
-DECLARE_VECTOR_FN(1b, uint8_t, false)
-DECLARE_VECTOR_FN(1b_be, uint8_t, true)
-DECLARE_VECTOR_FN(2b, uint16_t, false)
-DECLARE_VECTOR_FN(2b_be, uint16_t, true)
-DECLARE_VECTOR_FN(4b, uint32_t, false)
-DECLARE_VECTOR_FN(4b_be, uint32_t, true)
+void
+rte_dir24_8_vec_lookup_bulk_vrf_8b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	uint32_t i;
+	for (i = 0; i < (n / 8); i++)
+		dir24_8_vec_lookup_x8_8b(p, vrf_ids + i * 8, ips + i * 8,
+			next_hops + i * 8, true, VRF_SCALE_SMALL);
+	dir24_8_lookup_bulk_vrf_8b_be(p, vrf_ids + i * 8, ips + i * 8,
+		next_hops + i * 8, n - i * 8);
+}
 
 void
-rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n)
+rte_dir24_8_vec_lookup_bulk_vrf_8b_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
 	for (i = 0; i < (n / 8); i++)
-		dir24_8_vec_lookup_x8_8b(p, ips + i * 8, next_hops + i * 8, false);
-	dir24_8_lookup_bulk_8b(p, ips + i * 8, next_hops + i * 8, n - i * 8);
+		dir24_8_vec_lookup_x8_8b(p, vrf_ids + i * 8, ips + i * 8,
+			next_hops + i * 8, false, VRF_SCALE_LARGE);
+	dir24_8_lookup_bulk_vrf_8b(p, vrf_ids + i * 8, ips + i * 8,
+		next_hops + i * 8, n - i * 8);
 }
 
 void
-rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n)
+rte_dir24_8_vec_lookup_bulk_vrf_8b_be_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
 	uint32_t i;
 	for (i = 0; i < (n / 8); i++)
-		dir24_8_vec_lookup_x8_8b(p, ips + i * 8, next_hops + i * 8, true);
-	dir24_8_lookup_bulk_8b_be(p, ips + i * 8, next_hops + i * 8, n - i * 8);
+		dir24_8_vec_lookup_x8_8b(p, vrf_ids + i * 8, ips + i * 8,
+			next_hops + i * 8, true, VRF_SCALE_LARGE);
+	dir24_8_lookup_bulk_vrf_8b_be(p, vrf_ids + i * 8, ips + i * 8,
+		next_hops + i * 8, n - i * 8);
 }
diff --git a/lib/fib/dir24_8_avx512.h b/lib/fib/dir24_8_avx512.h
index 3e2bbc2490..d42ef1d17f 100644
--- a/lib/fib/dir24_8_avx512.h
+++ b/lib/fib/dir24_8_avx512.h
@@ -6,35 +6,99 @@
 #define _DIR248_AVX512_H_
 
 void
-rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_1b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_1b(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_1b_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_1b_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_1b_be_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_2b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_2b(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_2b_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_1b_be(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_2b_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_2b_be_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_4b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_4b(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_2b_be(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_4b_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_4b_be(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_4b_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_4b_be_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_8b(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
 void
-rte_dir24_8_vec_lookup_bulk_8b_be(void *p, const uint32_t *ips,
+rte_dir24_8_vec_lookup_bulk_vrf_8b_be(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
 	uint64_t *next_hops, const unsigned int n);
 
+void
+rte_dir24_8_vec_lookup_bulk_vrf_8b_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_vrf_8b_be_large(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
+
 #endif /* _DIR248_AVX512_H_ */
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..efc0595a7f 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -14,12 +14,15 @@
 #include <rte_string_fns.h>
 #include <rte_tailq.h>
 
+#include <rte_debug.h>
 #include <rte_rib.h>
 #include <rte_fib.h>
 
 #include "dir24_8.h"
 #include "fib_log.h"
 
+#define FIB_MAX_LOOKUP_BULK 64U
+
 RTE_LOG_REGISTER_DEFAULT(fib_logtype, INFO);
 
 TAILQ_HEAD(rte_fib_list, rte_tailq_entry);
@@ -40,52 +43,61 @@ EAL_REGISTER_TAILQ(rte_fib_tailq)
 struct rte_fib {
 	char			name[RTE_FIB_NAMESIZE];
 	enum rte_fib_type	type;	/**< Type of FIB struct */
-	unsigned int flags;		/**< Flags */
-	struct rte_rib		*rib;	/**< RIB helper datastructure */
+	uint16_t flags;			/**< Flags */
+	uint16_t		num_vrfs;/**< Number of VRFs */
+	struct rte_rib		**ribs;	/**< RIB helper datastructures per VRF */
 	void			*dp;	/**< pointer to the dataplane struct*/
 	rte_fib_lookup_fn_t	lookup;	/**< FIB lookup function */
 	rte_fib_modify_fn_t	modify; /**< modify FIB datastructure */
-	uint64_t		def_nh;
+	uint64_t		*def_nh;/**< Per-VRF default next hop array */
 };
 
 static void
-dummy_lookup(void *fib_p, const uint32_t *ips, uint64_t *next_hops,
-	const unsigned int n)
+dummy_lookup(void *fib_p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
 {
 	unsigned int i;
 	struct rte_fib *fib = fib_p;
 	struct rte_rib_node *node;
+	struct rte_rib *rib;
 
 	for (i = 0; i < n; i++) {
-		node = rte_rib_lookup(fib->rib, ips[i]);
+		RTE_ASSERT(vrf_ids[i] < fib->num_vrfs);
+		rib = rte_fib_vrf_get_rib(fib, vrf_ids[i]);
+		node = rte_rib_lookup(rib, ips[i]);
 		if (node != NULL)
 			rte_rib_get_nh(node, &next_hops[i]);
 		else
-			next_hops[i] = fib->def_nh;
+			next_hops[i] = fib->def_nh[vrf_ids[i]];
 	}
 }
 
 static int
-dummy_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
-	uint64_t next_hop, int op)
+dummy_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop, int op)
 {
 	struct rte_rib_node *node;
+	struct rte_rib *rib;
 	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
 
-	node = rte_rib_lookup_exact(fib->rib, ip, depth);
+	rib = rte_fib_vrf_get_rib(fib, vrf_id);
+	if (rib == NULL)
+		return -EINVAL;
+
+	node = rte_rib_lookup_exact(rib, ip, depth);
 
 	switch (op) {
 	case RTE_FIB_ADD:
 		if (node == NULL)
-			node = rte_rib_insert(fib->rib, ip, depth);
+			node = rte_rib_insert(rib, ip, depth);
 		if (node == NULL)
 			return -rte_errno;
 		return rte_rib_set_nh(node, next_hop);
 	case RTE_FIB_DEL:
 		if (node == NULL)
 			return -ENOENT;
-		rte_rib_remove(fib->rib, ip, depth);
+		rte_rib_remove(rib, ip, depth);
 		return 0;
 	}
 	return -EINVAL;
@@ -125,7 +137,7 @@ rte_fib_add(struct rte_fib *fib, uint32_t ip, uint8_t depth, uint64_t next_hop)
 	if ((fib == NULL) || (fib->modify == NULL) ||
 			(depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
-	return fib->modify(fib, ip, depth, next_hop, RTE_FIB_ADD);
+	return fib->modify(fib, 0, ip, depth, next_hop, RTE_FIB_ADD);
 }
 
 RTE_EXPORT_SYMBOL(rte_fib_delete)
@@ -135,7 +147,7 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth)
 	if ((fib == NULL) || (fib->modify == NULL) ||
 			(depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
-	return fib->modify(fib, ip, depth, 0, RTE_FIB_DEL);
+	return fib->modify(fib, 0, ip, depth, 0, RTE_FIB_DEL);
 }
 
 RTE_EXPORT_SYMBOL(rte_fib_lookup_bulk)
@@ -143,24 +155,73 @@ int
 rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	uint64_t *next_hops, int n)
 {
+	static const uint16_t zero_vrf_ids[FIB_MAX_LOOKUP_BULK];
+	unsigned int off = 0;
+	unsigned int total = (unsigned int)n;
+
 	FIB_RETURN_IF_TRUE(((fib == NULL) || (ips == NULL) ||
 		(next_hops == NULL) || (fib->lookup == NULL)), -EINVAL);
 
-	fib->lookup(fib->dp, ips, next_hops, n);
+	while (off < total) {
+		unsigned int chunk = RTE_MIN(total - off,
+			FIB_MAX_LOOKUP_BULK);
+		fib->lookup(fib->dp, zero_vrf_ids, ips + off,
+			next_hops + off, chunk);
+		off += chunk;
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_lookup_bulk, 26.07)
+int
+rte_fib_vrf_lookup_bulk(struct rte_fib *fib, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, int n)
+{
+	FIB_RETURN_IF_TRUE(((fib == NULL) || (vrf_ids == NULL) ||
+		(ips == NULL) || (next_hops == NULL) ||
+		(fib->lookup == NULL)), -EINVAL);
+
+	fib->lookup(fib->dp, vrf_ids, ips, next_hops, (unsigned int)n);
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_add, 26.07)
+int
+rte_fib_vrf_add(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop)
+{
+	if ((fib == NULL) || (fib->modify == NULL) ||
+			(depth > RTE_FIB_MAXDEPTH))
+		return -EINVAL;
+	return fib->modify(fib, vrf_id, ip, depth, next_hop, RTE_FIB_ADD);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_delete, 26.07)
+int
+rte_fib_vrf_delete(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth)
+{
+	if ((fib == NULL) || (fib->modify == NULL) ||
+			(depth > RTE_FIB_MAXDEPTH))
+		return -EINVAL;
+	return fib->modify(fib, vrf_id, ip, depth, 0, RTE_FIB_DEL);
+}
+
 RTE_EXPORT_SYMBOL(rte_fib_create)
 struct rte_fib *
 rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 {
 	char mem_name[RTE_FIB_NAMESIZE];
+	char rib_name[RTE_FIB_NAMESIZE];
 	int ret;
 	struct rte_fib *fib = NULL;
 	struct rte_rib *rib = NULL;
 	struct rte_tailq_entry *te;
 	struct rte_fib_list *fib_list;
 	struct rte_rib_conf rib_conf;
+	uint16_t num_vrfs;
+	uint16_t vrf;
 
 	/* Check user arguments. */
 	if ((name == NULL) || (conf == NULL) ||	(conf->max_routes < 0) ||
@@ -170,16 +231,42 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		return NULL;
 	}
 
+	num_vrfs = (conf->max_vrfs == 0) ? 1 : conf->max_vrfs;
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib_create(name, socket_id, &rib_conf);
-	if (rib == NULL) {
-		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
+	struct rte_rib **ribs = rte_zmalloc_socket("FIB_RIBS",
+		num_vrfs * sizeof(*fib->ribs), RTE_CACHE_LINE_SIZE, socket_id);
+	if (ribs == NULL) {
+		FIB_LOG(ERR, "FIB %s RIB array allocation failed", name);
+		rte_errno = ENOMEM;
 		return NULL;
 	}
 
+	uint64_t *def_nh = rte_zmalloc_socket("FIB_DEF_NH",
+		num_vrfs * sizeof(*def_nh), RTE_CACHE_LINE_SIZE, socket_id);
+	if (def_nh == NULL) {
+		FIB_LOG(ERR, "FIB %s default nexthop array allocation failed", name);
+		rte_errno = ENOMEM;
+		rte_free(ribs);
+		return NULL;
+	}
+
+	for (vrf = 0; vrf < num_vrfs; vrf++) {
+		if (num_vrfs == 1)
+			snprintf(rib_name, sizeof(rib_name), "%s", name);
+		else
+			snprintf(rib_name, sizeof(rib_name), "%s_vrf%u", name, vrf);
+		rib = rte_rib_create(rib_name, socket_id, &rib_conf);
+		if (rib == NULL) {
+			FIB_LOG(ERR, "Can not allocate RIB %s", rib_name);
+			goto free_ribs;
+		}
+		ribs[vrf] = rib;
+		def_nh[vrf] = (conf->vrf_default_nh != NULL) ?
+			conf->vrf_default_nh[vrf] : conf->default_nh;
+	}
+
 	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
 	fib_list = RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
 
@@ -215,11 +302,13 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		goto free_te;
 	}
 
+	fib->num_vrfs = num_vrfs;
+	fib->ribs = ribs;
+	fib->def_nh = def_nh;
+
 	rte_strlcpy(fib->name, name, sizeof(fib->name));
-	fib->rib = rib;
 	fib->type = conf->type;
 	fib->flags = conf->flags;
-	fib->def_nh = conf->default_nh;
 	ret = init_dataplane(fib, socket_id, conf);
 	if (ret < 0) {
 		FIB_LOG(ERR,
@@ -242,8 +331,12 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	rte_free(te);
 exit:
 	rte_mcfg_tailq_write_unlock();
-	rte_rib_free(rib);
+free_ribs:
+	for (vrf = 0; vrf < num_vrfs; vrf++)
+		rte_rib_free(ribs[vrf]);
 
+	rte_free(def_nh);
+	rte_free(ribs);
 	return NULL;
 }
 
@@ -311,7 +404,13 @@ rte_fib_free(struct rte_fib *fib)
 	rte_mcfg_tailq_write_unlock();
 
 	free_dataplane(fib);
-	rte_rib_free(fib->rib);
+	if (fib->ribs != NULL) {
+		uint16_t vrf;
+		for (vrf = 0; vrf < fib->num_vrfs; vrf++)
+			rte_rib_free(fib->ribs[vrf]);
+	}
+	rte_free(fib->ribs);
+	rte_free(fib->def_nh);
 	rte_free(fib);
 	rte_free(te);
 }
@@ -327,7 +426,18 @@ RTE_EXPORT_SYMBOL(rte_fib_get_rib)
 struct rte_rib *
 rte_fib_get_rib(struct rte_fib *fib)
 {
-	return (fib == NULL) ? NULL : fib->rib;
+	return (fib == NULL || fib->ribs == NULL) ? NULL : fib->ribs[0];
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_vrf_get_rib, 26.07)
+struct rte_rib *
+rte_fib_vrf_get_rib(struct rte_fib *fib, uint16_t vrf_id)
+{
+	if (fib == NULL || fib->ribs == NULL)
+		return NULL;
+	if (vrf_id >= fib->num_vrfs)
+		return NULL;
+	return fib->ribs[vrf_id];
 }
 
 RTE_EXPORT_SYMBOL(rte_fib_select_lookup)
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535..883195c7d6 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -53,11 +53,11 @@ enum rte_fib_type {
 };
 
 /** Modify FIB function */
-typedef int (*rte_fib_modify_fn_t)(struct rte_fib *fib, uint32_t ip,
-	uint8_t depth, uint64_t next_hop, int op);
+typedef int (*rte_fib_modify_fn_t)(struct rte_fib *fib, uint16_t vrf_id,
+	uint32_t ip, uint8_t depth, uint64_t next_hop, int op);
 /** FIB bulk lookup function */
-typedef void (*rte_fib_lookup_fn_t)(void *fib, const uint32_t *ips,
-	uint64_t *next_hops, const unsigned int n);
+typedef void (*rte_fib_lookup_fn_t)(void *fib, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n);
 
 enum rte_fib_op {
 	RTE_FIB_ADD,
@@ -110,6 +110,10 @@ struct rte_fib_conf {
 		} dir24_8;
 	};
 	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
+	/** Number of VRFs to support (0 or 1 = single VRF for backward compat) */
+	uint16_t max_vrfs;
+	/** Per-VRF default nexthops (NULL = use default_nh for all) */
+	uint64_t *vrf_default_nh;
 };
 
 /** FIB RCU QSBR configuration structure. */
@@ -224,6 +228,71 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth);
 int
 rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 		uint64_t *next_hops, int n);
+
+/**
+ * Add a route to the FIB with VRF ID.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max_vrfs-1)
+ * @param ip
+ *   IPv4 prefix address to be added to the FIB
+ * @param depth
+ *   Prefix length
+ * @param next_hop
+ *   Next hop to be added to the FIB
+ * @return
+ *   0 on success, negative value otherwise
+ */
+__rte_experimental
+int
+rte_fib_vrf_add(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop);
+
+/**
+ * Delete a rule from the FIB with VRF ID.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max_vrfs-1)
+ * @param ip
+ *   IPv4 prefix address to be deleted from the FIB
+ * @param depth
+ *   Prefix length
+ * @return
+ *   0 on success, negative value otherwise
+ */
+__rte_experimental
+int
+rte_fib_vrf_delete(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth);
+
+/**
+ * Lookup multiple IP addresses in the FIB with per-packet VRF IDs.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_ids
+ *   Array of VRF IDs
+ * @param ips
+ *   Array of IPs to be looked up in the FIB
+ * @param next_hops
+ *   Next hop of the most specific rule found for IP in the corresponding VRF.
+ *   This is an array of eight byte values.
+ *   If the lookup for the given IP failed, then corresponding element would
+ *   contain default nexthop value configured for that VRF.
+ * @param n
+ *   Number of elements in vrf_ids, ips (and next_hops) arrays to lookup.
+ * @return
+ *   -EINVAL for incorrect arguments, otherwise 0
+ */
+__rte_experimental
+int
+rte_fib_vrf_lookup_bulk(struct rte_fib *fib, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, int n);
+
 /**
  * Get pointer to the dataplane specific struct
  *
@@ -237,7 +306,7 @@ void *
 rte_fib_get_dp(struct rte_fib *fib);
 
 /**
- * Get pointer to the RIB
+ * Get pointer to the RIB for VRF 0
  *
  * @param fib
  *   FIB object handle
@@ -248,6 +317,21 @@ rte_fib_get_dp(struct rte_fib *fib);
 struct rte_rib *
 rte_fib_get_rib(struct rte_fib *fib);
 
+/**
+ * Get pointer to the RIB for a specific VRF
+ *
+ * @param fib
+ *   FIB object handle
+ * @param vrf_id
+ *   VRF ID (0 to max_vrfs-1)
+ * @return
+ *   Pointer on the RIB on success
+ *   NULL otherwise
+ */
+__rte_experimental
+struct rte_rib *
+rte_fib_vrf_get_rib(struct rte_fib *fib, uint16_t vrf_id);
+
 /**
  * Set lookup function based on type
  *
-- 
2.43.0

