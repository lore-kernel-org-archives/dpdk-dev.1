Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B8606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D9jydgV9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7829940679;
	Tue, 20 Oct 2026 15:22:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D9A3140283;
 Tue, 20 Oct 2026 15:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792502521; x=1824038521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dyF+GGRI9DR4GgoI0Wzh+ZTU2nMxufNTatU2WRTX6nE=;
 b=D9jydgV9vKL7mjjRslDqzTDYDGHIWsj6lAIzKSyP6HK+ijIjseACBrTZ
 nFPd/UxScXS8wKgzGr+po030dwx95KYP3lUv3WdQN7X7DAeHIIHaQzLDN
 NSwzPHLFNfTK6D9mGHnP83rVoZChNfrKPdn5+I4iVfrZxP31AXvNWE9jY
 3oXhc/LTMz166e8XaV8pGEW3IpsWunf7VuF6Szs5bS9wpeowcQ/msx7d2
 gZLPQMf/NLOwBLzXO1ScGKs/0KTSbvShMHExDZtyh4/9Bv5jMuSkv+hfh
 RXv2Jh0c7swQ6fKF6juG7+ymWWkExS+0cOnMdtGw+BNy02JUZniJFJ2Zd g==;
X-CSE-ConnectionGUID: 8RNtgqU4S96jDt8X/23b0Q==
X-CSE-MsgGUID: zDjDm7vQT9uNMTRJjuMo2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1092341"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1092341"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:22:00 -0700
X-CSE-ConnectionGUID: Pfd45PI+RyGbJlyJrK0Bww==
X-CSE-MsgGUID: yMI4NeKVSsionsGyZZtGfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4561254"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa012.fm.intel.com with ESMTP; 20 Oct 2026 06:21:58 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: maxime@leroys.fr,
	rjarry@redhat.com,
	stable@dpdk.org
Subject: [PATCH 2/3] fib6: fix tbl8 reservation with RCU defer queue
Date: Tue, 20 Oct 2026 13:21:54 +0000
Message-ID: <20261020132155.980174-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
References: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, `trie_modify()` admits an update when `rsvd_tbl8s`, the number
of tbl8 levels the route set needs, fits the pool. The dataplane update
then takes tbl8s only within this reservation and is not expected to
fail half way.

In `RTE_FIB6_QSBR_MODE_DQ` mode, a tbl8 released by an update goes to the
defer queue and returns to the pool only once readers report a quiescent
state. Meanwhile `rsvd_tbl8s` already dropped if a prefix was deleted.
The deferred tbl8s are out of the pool but not accounted for, so while a
reader holds the grace period an add may run out of tbl8s inside
`modify_dp()`.

Fix it by counting the tbl8s used by the dataplane in `cur_tbl8s`, which
was unused so far. The tbl8s taken from the pool but not used,
`tbl8_pool_pos - cur_tbl8s`, are those waiting in the defer queue. Take
the reservation of an added prefix before writing the dataplane, and
check at the start of `modify_dp()` that the reserved tbl8s plus the
deferred ones fit the pool. If they do not, reclaim the defer queue once,
and return `-ENOSPC` before touching the dataplane if they still do not
fit.

Bugzilla ID: 1970
Fixes: 200ccb9ebd8e ("fib6: implement RCU rule reclamation")
Cc: rjarry@redhat.com
Cc: stable@dpdk.org

Reported-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 0ae669c689..9ede1a5bf7 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -175,6 +175,7 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	/*Init tbl8 entries with nexthop from tbl24*/
 	write_to_dp((void *)tbl8_ptr, nh, dp->nh_sz,
 		TRIE_TBL8_GRP_NUM_ENT);
+	dp->cur_tbl8s++;
 	return tbl8_idx;
 }
 
@@ -243,6 +244,7 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 		break;
 	}
 
+	dp->cur_tbl8s--;
 	if (dp->v == NULL) {
 		tbl8_cleanup_and_free(dp, tbl8_idx);
 	} else if (dp->rcu_mode == RTE_FIB6_QSBR_MODE_SYNC) {
@@ -508,6 +510,18 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	if (next_hop > get_max_nh(dp->nh_sz))
 		return -EINVAL;
 
+	/*
+	 * Check if we can safely allocate new tbl8s further in process of modifying the dataplane.
+	 */
+	uint32_t tbl8s_in_defer_queue = dp->tbl8_pool_pos - dp->cur_tbl8s;
+	if (dp->rsvd_tbl8s + tbl8s_in_defer_queue > dp->number_tbl8s) {
+		rte_rcu_qsbr_dq_reclaim(dp->dq, dp->tbl8_pool_pos - dp->cur_tbl8s,
+			NULL, NULL, NULL);
+		tbl8s_in_defer_queue = dp->tbl8_pool_pos - dp->cur_tbl8s;
+		if (dp->rsvd_tbl8s + tbl8s_in_defer_queue > dp->number_tbl8s)
+			return -ENOSPC;
+	}
+
 	ledge = *ip;
 	do {
 		tmp = rte_rib6_get_nxt(rib, ip, depth, tmp,
@@ -624,6 +638,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return -ENOSPC;
 		}
+		dp->rsvd_tbl8s += new_levels;
 
 		rte_rib6_set_nh(node, next_hop);
 		parent = rte_rib6_lookup_parent(node);
@@ -634,11 +649,11 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		}
 		ret = modify_dp(dp, rib, &ip_masked, depth, next_hop);
 		if (ret != 0) {
+			dp->rsvd_tbl8s -= new_levels;
 			rte_rib6_remove(rib, &ip_masked, depth);
 			return ret;
 		}
 successfully_added:
-		dp->rsvd_tbl8s += new_levels;
 		return 0;
 	case RTE_FIB6_DEL:
 		if (node == NULL)
-- 
2.43.0

