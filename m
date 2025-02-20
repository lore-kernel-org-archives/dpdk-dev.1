Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA1C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 13:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E142402DA;
	Thu, 20 Feb 2025 14:16:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 959264003C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 14:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740057407; x=1771593407;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=a8Y0ABHUk1YZtEGjYnpwHlxvUade34wjtey7Wgim+G4=;
 b=ZF0BMptZONolknv/UJBNotUxD8FKJ8umxUAPqH149mZDFxVEZZ+gxIL2
 tbSB+vHcJ3EIdkzwH4SBlzE18wb7qeEgvAr9gHHQ87sPI8gwmddC52oxy
 H5zHO//tj6ZSOekhqLeXGN+HVc/s8WzNAgOTm56VHQ7bxSGT5vufQGRWL
 S2CxN8ovQKqNI61Bl29s2h9lngKtbG2IiPGjcAQx3bEGUWVew+lrh/mI/
 LZJ35BNYgJTJoybSnFhPBMROJxUQRUdJAHyrAPwMp9KYi9X3s7MJpdSe2
 z4n24HYv+GwVPwuxsFA4OLqVaMxSKP1cPcJ0Ydgh+6HX7JrZaSrG/3IF/ g==;
X-CSE-ConnectionGUID: 1cAcMSp6Sk+M2diTox3JiQ==
X-CSE-MsgGUID: kgIvBVAlS7ilr+nM7mmgsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44751053"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="44751053"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 05:16:46 -0800
X-CSE-ConnectionGUID: /78L8zC6QiSudt4voEjngg==
X-CSE-MsgGUID: FRQ69WaaRE2zWxFoKgS8Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="152234256"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 05:16:44 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 2/3] fbarray: flatten the loop in find next n
Date: Thu, 20 Feb 2025 13:16:39 +0000
Message-ID: <0988472f146c3de7e491d3765a0d6d40584b7d38.1740057387.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <602f4e304295ed06a999c93f70096dd5d4c0cba8.1740057387.git.anatoly.burakov@intel.com>
References: <47e02f706d284a2e2a49db51ce75081e62aee393.1724405387.git.anatoly.burakov@intel.com>
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

Currently, find_next_n() is implemented as a nested loop due to lookahead
functionality. This is not very efficient because when doing lookahead,
we essentially scan some of the indices twice, and in general the
lookahead functionality has been a source of bugs because it is
overcomplicated. The bit ignore feature on lookahead is also unnecessary
because we don't really gain anything by ignoring bits we have already
scanned, as they would not trigger any matches anyway.

This patch reworks find_next_n() to flatten the loop and remove the
lookahead and bit-ignore functionality, instead replacing it with state
machine-like behavior. This makes the code simpler to reason about.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_fbarray.c | 195 +++++++++++++---------------
 1 file changed, 93 insertions(+), 102 deletions(-)

diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 22b43073c6..487600ae1b 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -117,9 +117,11 @@ find_next_n(const struct rte_fbarray *arr, unsigned int start, unsigned int n,
 {
 	const struct used_mask *msk = get_used_mask(arr->data, arr->elt_sz,
 			arr->len);
-	unsigned int msk_idx, lookahead_idx, first, first_mod;
+	unsigned int msk_idx, first, first_mod;
 	unsigned int last, last_mod;
-	uint64_t last_msk, ignore_msk;
+	uint64_t last_msk, first_msk;
+	unsigned int run_start, left = 0;
+	bool run_started = false;
 
 	/*
 	 * mask only has granularity of MASK_ALIGN, but start may not be aligned
@@ -128,7 +130,7 @@ find_next_n(const struct rte_fbarray *arr, unsigned int start, unsigned int n,
 	 */
 	first = MASK_LEN_TO_IDX(start);
 	first_mod = MASK_LEN_TO_MOD(start);
-	ignore_msk = ~((1ULL << first_mod) - 1);
+	first_msk = ~((1ULL << first_mod) - 1);
 
 	/* array length may not be aligned, so calculate ignore mask for last
 	 * mask index.
@@ -137,131 +139,120 @@ find_next_n(const struct rte_fbarray *arr, unsigned int start, unsigned int n,
 	last_mod = MASK_LEN_TO_MOD(arr->len);
 	last_msk = ~(UINT64_MAX << last_mod);
 
+	left = n;
+
 	for (msk_idx = first; msk_idx < msk->n_masks; msk_idx++) {
-		uint64_t cur_msk, lookahead_msk;
-		unsigned int run_start, clz, left;
-		bool found = false;
+		unsigned int s_idx, clz, need;
+		uint64_t cur_msk, tmp_msk;
+
 		/*
-		 * The process of getting n consecutive bits for arbitrary n is
-		 * a bit involved, but here it is in a nutshell:
+		 * In order to find N consecutive bits for arbitrary N, we need
+		 * to be aware of the following:
 		 *
-		 *  1. let n be the number of consecutive bits we're looking for
-		 *  2. check if n can fit in one mask, and if so, do n-1
-		 *     rshift-ands to see if there is an appropriate run inside
-		 *     our current mask
-		 *    2a. if we found a run, bail out early
-		 *    2b. if we didn't find a run, proceed
-		 *  3. invert the mask and count leading zeroes (that is, count
-		 *     how many consecutive set bits we had starting from the
-		 *     end of current mask) as k
-		 *    3a. if k is 0, continue to next mask
-		 *    3b. if k is not 0, we have a potential run
-		 *  4. to satisfy our requirements, next mask must have n-k
-		 *     consecutive set bits right at the start, so we will do
-		 *     (n-k-1) rshift-ands and check if first bit is set.
+		 *  1. To find N number of consecutive bits within a mask, we
+		 *     need to do N-1 rshift-ands and see if we still have set
+		 *     bits anywhere in the mask
+		 *  2. N may be larger than mask size, in which case we need to
+		 *     do a search in multiple consecutive masks
+		 *  3. For multi-mask search to be meaningful, we need to anchor
+		 *     our searches, i.e. first we find a run of M bits at the
+		 *     end of current mask, then we look for N-M bits at the
+		 *     beginning of next mask (or multiple masks)
 		 *
-		 * Step 4 will need to be repeated if (n-k) > MASK_ALIGN until
-		 * we either run out of masks, lose the run, or find what we
-		 * were looking for.
+		 * With all of the above, the algorithm looks as follows:
+		 *
+		 *  1. let N be the number of consecutive bits we're looking for
+		 *  2. if we already started a run, check if we can continue it
+		 *     by looking for remainder of N at the beginning of current
+		 *     mask
+		 *  3. if we lost a run or if we never had a run, we look for N
+		 *     bits anywhere within the current mask (up to mask size,
+		 *     we can finish this run in the next mask if N > mask size)
+		 *  4. if we didn't find anything up to this point, check if any
+		 *     topmost bits of the mask are set (meaning we can start a
+		 *     run and finish it in the next mask)
+		 *  5. at any point in steps 2-4, we may do an early exit due to
+		 *     finding what we were looking for, or continue searching
+		 *     further
 		 */
 		cur_msk = msk->data[msk_idx];
-		left = n;
 
 		/* if we're looking for free spaces, invert the mask */
 		if (!used)
 			cur_msk = ~cur_msk;
 
-		/* combine current ignore mask with last index ignore mask */
+		/* first and last mask may not be aligned */
+		if (msk_idx == first)
+			cur_msk &= first_msk;
 		if (msk_idx == last)
-			ignore_msk &= last_msk;
+			cur_msk &= last_msk;
 
-		/* if we have an ignore mask, ignore once */
-		if (ignore_msk) {
-			cur_msk &= ignore_msk;
-			ignore_msk = 0;
-		}
+		/* do we have an active previous run? */
+		if (run_started) {
+			/* figure out how many consecutive bits we need here */
+			need = RTE_MIN(left, MASK_ALIGN);
 
-		/* if n can fit in within a single mask, do a search */
-		if (n <= MASK_ALIGN) {
-			uint64_t tmp_msk = cur_msk;
-			unsigned int s_idx;
-			for (s_idx = 0; s_idx < n - 1; s_idx++)
+			/* see if we get a run of needed length */
+			tmp_msk = cur_msk;
+			for (s_idx = 0; s_idx < need - 1; s_idx++)
 				tmp_msk &= tmp_msk >> 1ULL;
-			/* we found what we were looking for */
-			if (tmp_msk != 0) {
-				run_start = rte_ctz64(tmp_msk);
-				return MASK_GET_IDX(msk_idx, run_start);
+
+			/* if first bit is set, we keep the run */
+			if (tmp_msk & 1) {
+				left -= need;
+
+				/* did we find what we were looking for? */
+				if (left == 0)
+					return run_start;
+
+				/* keep looking */
+				continue;
 			}
+			/* we lost the run, reset */
+			run_started = false;
+			left = n;
 		}
 
-		/*
-		 * we didn't find our run within the mask, or n > MASK_ALIGN,
-		 * so we're going for plan B.
-		 */
+		/* if we're here, we either lost the run or never had it */
+
+		/* figure out how many consecutive bits we need here */
+		need = RTE_MIN(left, MASK_ALIGN);
+
+		/* do a search */
+		tmp_msk = cur_msk;
+		for (s_idx = 0; s_idx < need - 1; s_idx++)
+			tmp_msk &= tmp_msk >> 1ULL;
+
+		/* have we found something? */
+		if (tmp_msk != 0) {
+			/* figure out where the run started */
+			run_start = MASK_GET_IDX(msk_idx, rte_ctz64(tmp_msk));
+			run_started = true;
+			left -= need;
+
+			/* do we need to look further? */
+			if (left == 0)
+				return run_start;
+
+			/* we need to keep looking */
+			continue;
+		}
+
+		/* we didn't find our run within current mask, go for plan B. */
 
 		/* count leading zeroes on inverted mask */
-		if (~cur_msk == 0)
-			clz = sizeof(cur_msk) * 8;
-		else
-			clz = rte_clz64(~cur_msk);
+		clz = rte_clz64(~cur_msk);
 
-		/* if there aren't any runs at the end either, just continue */
+		/* if there aren't any set bits at the end, just continue */
 		if (clz == 0)
 			continue;
 
-		/* we have a partial run at the end, so try looking ahead */
-		run_start = MASK_ALIGN - clz;
+		/* we have a partial run at the end */
+		run_start = MASK_GET_IDX(msk_idx, MASK_ALIGN - clz);
+		run_started = true;
 		left -= clz;
 
-		for (lookahead_idx = msk_idx + 1; lookahead_idx < msk->n_masks;
-				lookahead_idx++) {
-			unsigned int s_idx, need;
-			uint64_t first_bit = 1;
-
-			lookahead_msk = msk->data[lookahead_idx];
-
-			/* if we're looking for free space, invert the mask */
-			if (!used)
-				lookahead_msk = ~lookahead_msk;
-
-			/* figure out how many consecutive bits we need here */
-			need = RTE_MIN(left, MASK_ALIGN);
-
-			/* count number of shifts we performed */
-			for (s_idx = 0; s_idx < need - 1; s_idx++) {
-				lookahead_msk &= lookahead_msk >> 1ULL;
-				/* did we lose the run yet? */
-				if ((lookahead_msk & first_bit) == 0)
-					break;
-			}
-
-			/* if first bit is not set, we've lost the run */
-			if ((lookahead_msk & first_bit) == 0) {
-				/*
-				 * we've scanned this far, so we know there are
-				 * no runs in the space we've lookahead-scanned
-				 * as well, so skip that on next iteration.
-				 */
-				ignore_msk = ~((1ULL << (s_idx + 1)) - 1);
-				/* outer loop will increment msk_idx so add 1 */
-				msk_idx = lookahead_idx - 1;
-				break;
-			}
-
-			left -= need;
-
-			/* check if we've found what we were looking for */
-			if (left == 0) {
-				found = true;
-				break;
-			}
-		}
-
-		/* we didn't find anything, so continue */
-		if (!found)
-			continue;
-
-		return MASK_GET_IDX(msk_idx, run_start);
+		/* we'll figure this out in the next iteration */
 	}
 	/* we didn't find anything */
 	rte_errno = used ? ENOENT : ENOSPC;
-- 
2.43.5

