Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FBDC021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 13:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 794AA402E4;
	Thu, 20 Feb 2025 14:16:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 670BD402BB
 for <dev@dpdk.org>; Thu, 20 Feb 2025 14:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740057409; x=1771593409;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=tQAFPzoV41QfVCbzo8bJtUMizT/59H3TJIw+XYQiBm4=;
 b=m7DjfaRbNZKze4RcBfDHRPxjVdE74ekOmIKS86em9fqyMy8VmOmhQtCW
 cHB6CWUE+/P+TmpvrdimNKE7oyyCbDQlHowZfcZeU6wVzAqkdldn4IMIx
 vw4DUbJcSWLfbnDlHB5DMgRSyZw3pqGTkr233gTlKnKy6FBfl1ss7+5ty
 ke6JH0y8OUdB6wIzaE+mkL/VO787rpt5qdnFaQpNbrCPTb37223f6curt
 nYytp0TVT6nZMYAG9eGIpODNs3JHjDBrdgdWjgpQC/GoZLUgqwPdA4vRu
 b3HoZZQCrDEMTWfkldWoYfx3bdoJUMcdTgIzrJ7D0XX1lO3qYy2blwGiT Q==;
X-CSE-ConnectionGUID: 50MFuZoGTsS6aUwD/2CH2A==
X-CSE-MsgGUID: FPV5y9LvR66vS1PdBoLs+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44751058"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="44751058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 05:16:47 -0800
X-CSE-ConnectionGUID: r9odAURQScqNnyDCLlOhfg==
X-CSE-MsgGUID: cXTstgVoTJO8O51fkZeCMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="152234263"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa001.jf.intel.com with ESMTP; 20 Feb 2025 05:16:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 3/3] fbarray: flatten the loop in find prev n
Date: Thu, 20 Feb 2025 13:16:40 +0000
Message-ID: <dee6b268e5f37f8f1354c96e1d01a2fb06e0f3e1.1740057387.git.anatoly.burakov@intel.com>
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

Currently, find_prev_n() is implemented as a nested loop due to
lookbehind functionality. This is not very efficient because when doing
lookbehind, we essentially scan some of the indices twice, and in general
the lookbehind functionality has been a source of bugs because it is
overcomplicated. The bit ignore feature on lookbehind is also unnecessary
because we don't really win anything by ignoring bits we have already
scanned, as they would not trigger any matches anyway.

This patch reworks find_prev_n() to flatten the loop and remove the
lookbehind and bit-ignore functionality, instead replacing it with state
machine-like behavior. This makes the code simpler to reason about.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_fbarray.c | 223 +++++++++++++---------------
 1 file changed, 101 insertions(+), 122 deletions(-)

diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 487600ae1b..1a470376ac 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -382,164 +382,143 @@ find_prev_n(const struct rte_fbarray *arr, unsigned int start, unsigned int n,
 {
 	const struct used_mask *msk = get_used_mask(arr->data, arr->elt_sz,
 			arr->len);
-	unsigned int msk_idx, lookbehind_idx, first, first_mod;
-	uint64_t ignore_msk;
+	/* we're going backwards so we need negative space */
+	int64_t msk_idx;
+	unsigned int first, first_mod;
+	uint64_t first_msk;
+	unsigned int run_end, left;
+	bool run_started = false;
 
 	/*
 	 * mask only has granularity of MASK_ALIGN, but start may not be aligned
 	 * on that boundary, so construct a special mask to exclude anything we
-	 * don't want to see to avoid confusing ctz.
+	 * don't want to see to avoid confusing clz. this "first" mask is
+	 * actually our last because we're going backwards, so no second mask
+	 * is required like in find_next_n case.
 	 */
 	first = MASK_LEN_TO_IDX(start);
 	first_mod = MASK_LEN_TO_MOD(start);
 	/* we're going backwards, so mask must start from the top */
-	ignore_msk = first_mod == MASK_ALIGN - 1 ?
+	first_msk = first_mod == MASK_ALIGN - 1 ?
 				UINT64_MAX : /* prevent overflow */
 				~(UINT64_MAX << (first_mod + 1));
 
+	left = n;
+
 	/* go backwards, include zero */
-	msk_idx = first;
-	do {
-		uint64_t cur_msk, lookbehind_msk;
-		unsigned int run_start, run_end, ctz, left;
-		bool found = false;
+	for (msk_idx = first; msk_idx >= 0; msk_idx--) {
+		unsigned int s_idx, ctz, need;
+		uint64_t cur_msk, tmp_msk;
+
 		/*
-		 * The process of getting n consecutive bits from the top for
-		 * arbitrary n is a bit involved, but here it is in a nutshell:
+		 * In order to find N consecutive bits for arbitrary N, we need
+		 * to be aware of the following:
 		 *
-		 *  1. let n be the number of consecutive bits we're looking for
-		 *  2. check if n can fit in one mask, and if so, do n-1
-		 *     lshift-ands to see if there is an appropriate run inside
-		 *     our current mask
-		 *    2a. if we found a run, bail out early
-		 *    2b. if we didn't find a run, proceed
-		 *  3. invert the mask and count trailing zeroes (that is, count
-		 *     how many consecutive set bits we had starting from the
-		 *     start of current mask) as k
-		 *    3a. if k is 0, continue to next mask
-		 *    3b. if k is not 0, we have a potential run
-		 *  4. to satisfy our requirements, next mask must have n-k
-		 *     consecutive set bits at the end, so we will do (n-k-1)
-		 *     lshift-ands and check if last bit is set.
+		 *  1. To find N number of consecutive bits within a mask, we
+		 *     need to do N-1 lshift-ands and see if we still have set
+		 *     bits anywhere in the mask
+		 *  2. N may be larger than mask size, in which case we need to
+		 *     do a search in multiple consecutive masks
+		 *  3. For multi-mask search to be meaningful, we need to anchor
+		 *     our searches, i.e. first we find a run of M bits at the
+		 *     beginning of current mask, then we look for N-M bits at
+		 *     the end of previous mask (or multiple masks)
 		 *
-		 * Step 4 will need to be repeated if (n-k) > MASK_ALIGN until
-		 * we either run out of masks, lose the run, or find what we
-		 * were looking for.
+		 * With all of the above, the algorithm looks as follows:
+		 *
+		 *  1. let N be the number of consecutive bits we're looking for
+		 *  2. if we already started a run, check if we can continue it
+		 *     by looking for remainder of N at the end of current mask
+		 *  3. if we lost a run or if we never had a run, we look for N
+		 *     bits anywhere within the current mask (up to mask size,
+		 *     we can finish this run in the previous mask if N > mask
+		 *     size)
+		 *  4. if we didn't find anything up to this point, check if any
+		 *     first bits of the mask are set (meaning we can start a
+		 *     run and finish it in the previous mask)
+		 *  5. at any point in steps 2-4, we may do an early exit due to
+		 *     finding what we were looking for, or continue searching
+		 *     further
 		 */
 		cur_msk = msk->data[msk_idx];
-		left = n;
 
 		/* if we're looking for free spaces, invert the mask */
 		if (!used)
 			cur_msk = ~cur_msk;
 
-		/* if we have an ignore mask, ignore once */
-		if (ignore_msk) {
-			cur_msk &= ignore_msk;
-			ignore_msk = 0;
-		}
+		/* first mask may not be aligned */
+		if (msk_idx == first)
+			cur_msk &= first_msk;
 
-		/* if n can fit in within a single mask, do a search */
-		if (n <= MASK_ALIGN) {
-			uint64_t tmp_msk = cur_msk;
-			unsigned int s_idx;
-			for (s_idx = 0; s_idx < n - 1; s_idx++)
+		/* do we have an active previous run? */
+		if (run_started) {
+			uint64_t last_bit = 0x1ULL << (MASK_ALIGN - 1);
+
+			/* figure out how many consecutive bits we need here */
+			need = RTE_MIN(left, MASK_ALIGN);
+
+			/* see if we get a run of needed length */
+			tmp_msk = cur_msk;
+			for (s_idx = 0; s_idx < need - 1; s_idx++)
 				tmp_msk &= tmp_msk << 1ULL;
-			/* we found what we were looking for */
-			if (tmp_msk != 0) {
-				/* clz will give us offset from end of mask, and
-				 * we only get the end of our run, not start,
-				 * so adjust result to point to where start
-				 * would have been.
-				 */
-				run_start = MASK_ALIGN -
-						rte_clz64(tmp_msk) - n;
-				return MASK_GET_IDX(msk_idx, run_start);
+
+			/* if last bit is set, we keep the run */
+			if (tmp_msk & last_bit) {
+				left -= need;
+
+				/* did we find what we were looking for? */
+				if (left == 0)
+					return run_end - n;
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
+			tmp_msk &= tmp_msk << 1ULL;
+
+		/* have we found something? */
+		if (tmp_msk != 0) {
+			/* figure out where the run started */
+			run_end = MASK_GET_IDX(msk_idx, MASK_ALIGN - rte_clz64(tmp_msk));
+			run_started = true;
+			left -= need;
+
+			/* do we need to look further? */
+			if (left == 0)
+				return run_end - n;
+
+			/* we need to keep looking */
+			continue;
+		}
+
+		/* we didn't find our run within current mask, go for plan B. */
 
 		/* count trailing zeroes on inverted mask */
-		if (~cur_msk == 0)
-			ctz = sizeof(cur_msk) * 8;
-		else
-			ctz = rte_ctz64(~cur_msk);
+		ctz = rte_ctz64(~cur_msk);
 
-		/* if there aren't any runs at the start either, just
-		 * continue
-		 */
+		/* if there aren't any set bits at the beginning, just continue */
 		if (ctz == 0)
 			continue;
 
-		/* we have a partial run at the start, so try looking behind */
+		/* we have a partial run at the beginning */
 		run_end = MASK_GET_IDX(msk_idx, ctz);
+		run_started = true;
 		left -= ctz;
 
-		/* go backwards, include zero */
-		lookbehind_idx = msk_idx - 1;
-
-		/* we can't lookbehind as we've run out of masks, so stop */
-		if (msk_idx == 0)
-			break;
-
-		do {
-			const uint64_t last_bit = 1ULL << (MASK_ALIGN - 1);
-			unsigned int s_idx, need;
-
-			lookbehind_msk = msk->data[lookbehind_idx];
-
-			/* if we're looking for free space, invert the mask */
-			if (!used)
-				lookbehind_msk = ~lookbehind_msk;
-
-			/* figure out how many consecutive bits we need here */
-			need = RTE_MIN(left, MASK_ALIGN);
-
-			/* count number of shifts we performed */
-			for (s_idx = 0; s_idx < need - 1; s_idx++) {
-				lookbehind_msk &= lookbehind_msk << 1ULL;
-				/* did we lose the run yet? */
-				if ((lookbehind_msk & last_bit) == 0)
-					break;
-			}
-
-			/* if last bit is not set, we've lost the run */
-			if ((lookbehind_msk & last_bit) == 0) {
-				/*
-				 * we've scanned this far, so we know there are
-				 * no runs in the space we've lookbehind-scanned
-				 * as well, so skip that on next iteration.
-				 */
-				ignore_msk = ~(UINT64_MAX << (MASK_ALIGN - s_idx - 1));
-				/* outer loop will decrement msk_idx so add 1 */
-				msk_idx = lookbehind_idx + 1;
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
-		} while ((lookbehind_idx--) != 0); /* decrement after check to
-						    * include zero
-						    */
-
-		/* we didn't find anything, so continue */
-		if (!found)
-			continue;
-
-		/* we've found what we were looking for, but we only know where
-		 * the run ended, so calculate start position.
-		 */
-		return run_end - n;
-	} while (msk_idx-- != 0); /* decrement after check to include zero */
+		/* we'll figure this out in the next iteration */
+	}
 	/* we didn't find anything */
 	rte_errno = used ? ENOENT : ENOSPC;
 	return -1;
-- 
2.43.5

