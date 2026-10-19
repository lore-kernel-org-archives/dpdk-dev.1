Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9688609F0D1
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXMEvj9d
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43DC740297;
	Mon, 19 Oct 2026 17:16:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3D2824028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422964; x=1823958964;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Rw/UHbDBYjkaqLiSdlQqrXGsqwEbrSVgHN0yVpHu4wM=;
 b=DXMEvj9dAr5l8hfdbvpK6msz7jc7OnjAtmRQS1f9zSXK5N1+otM9+8EI
 lfzLHB3yXtgNdSdBFCDa6VC4rWyTL49v/N7f2bjwa8iD8P3NTmR+hfO9Q
 8wHkiJllJ6WbCC0aULiHKU7ewQU2nXOT5Bs2pv70TLYw52DXmLHG0xWC6
 y1WYAxFcbcRmMXpUGsZp77Mks/GZqV93pvkc8PpJ8cSu/ib3eTP8d+Aca
 LvgnpnLbPVytveDz7OChmj6GJ2pxiS10zEDdsolA5eLiQdrBt1dcVnn6m
 zzihF0cka72lNVnwCrzdSREa9m3HLIXgyFZhIsEC/uJ1IdimCstJqyauX Q==;
X-CSE-ConnectionGUID: 2s8FPKfrSr62ikJERnhXNw==
X-CSE-MsgGUID: D2cpNDKLTGybNT9tQg0LCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1125849"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1125849"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:16:03 -0700
X-CSE-ConnectionGUID: DCnyb2dXQQKo1/6Dec1KLQ==
X-CSE-MsgGUID: 5/aOJc3BRUGLzOgPkVCsKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2860273"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 19 Oct 2026 08:16:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/1] net/ice: remove obsolete shared counter support
Date: Mon, 19 Oct 2026 16:16:00 +0100
Message-ID: <c0048e1fcd107079bc21a08bf3843a631792edb0.1792422953.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The shared attribute was removed from the `COUNT` action, with indirect
actions replacing it. ICE still carries shared-counter handling, but
its FDIR path always allocates a dedicated counter.

Remove the unreachable shared-counter lookup and reference counting,
along with the saved action ID used only for sharing.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    The API was removed in 92ef4b8f1688 ("ethdev: remove deprecated shared counter attribute")
    
    However, it may not be reasonable to pin a Fixline on that commit because that
    would imply that it *should have* updated ice driver's plubmbing to not support
    shared counters any more, which I do not believe is reasonable. I'm leaving
    this note for posterity and in case it is determined that the Fixline is needed
    after all.

 drivers/net/intel/ice/ice_ethdev.h      |  4 --
 drivers/net/intel/ice/ice_fdir_filter.c | 61 +++----------------------
 2 files changed, 7 insertions(+), 58 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 08c2b61519..afef59d6bd 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -389,7 +389,6 @@ struct ice_fdir_filter_conf {
 	enum ice_fdir_tunnel_type tunnel_type;
 
 	struct ice_fdir_counter *counter; /* flow specific counter context */
-	struct rte_flow_action_count act_count;
 
 	uint64_t input_set_o; /* used for non-tunnel or tunnel outer fields */
 	uint64_t input_set_i; /* only for tunnel inner fields */
@@ -431,9 +430,6 @@ struct ice_fdir_counter_pool;
 struct ice_fdir_counter {
 	TAILQ_ENTRY(ice_fdir_counter) next;
 	struct ice_fdir_counter_pool *pool;
-	uint8_t shared;
-	uint32_t ref_cnt;
-	uint32_t id;
 	uint64_t hits;
 	uint64_t bytes;
 	uint32_t hw_index;
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 517c32cecf..f4b0d01e35 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -329,30 +329,7 @@ ice_fdir_counter_release(struct ice_pf *pf)
 }
 
 static struct ice_fdir_counter *
-ice_fdir_counter_shared_search(struct ice_fdir_counter_pool_container
-					*container,
-			       uint32_t id)
-{
-	struct ice_fdir_counter_pool *pool;
-	struct ice_fdir_counter *counter;
-	int i;
-
-	TAILQ_FOREACH(pool, &container->pool_list, next) {
-		for (i = 0; i < ICE_FDIR_COUNTERS_PER_BLOCK; i++) {
-			counter = &pool->counters[i];
-
-			if (counter->shared &&
-			    counter->ref_cnt &&
-			    counter->id == id)
-				return counter;
-		}
-	}
-
-	return NULL;
-}
-
-static struct ice_fdir_counter *
-ice_fdir_counter_alloc(struct ice_pf *pf, uint32_t shared, uint32_t id)
+ice_fdir_counter_alloc(struct ice_pf *pf)
 {
 	struct ice_hw *hw = ICE_PF_TO_HW(pf);
 	struct ice_fdir_info *fdir_info = &pf->fdir;
@@ -361,18 +338,6 @@ ice_fdir_counter_alloc(struct ice_pf *pf, uint32_t shared, uint32_t id)
 	struct ice_fdir_counter_pool *pool = NULL;
 	struct ice_fdir_counter *counter_free = NULL;
 
-	if (shared) {
-		counter_free = ice_fdir_counter_shared_search(container, id);
-		if (counter_free) {
-			if (counter_free->ref_cnt + 1 == 0) {
-				rte_errno = E2BIG;
-				return NULL;
-			}
-			counter_free->ref_cnt++;
-			return counter_free;
-		}
-	}
-
 	TAILQ_FOREACH(pool, &container->pool_list, next) {
 		counter_free = TAILQ_FIRST(&pool->counter_list);
 		if (counter_free)
@@ -385,9 +350,6 @@ ice_fdir_counter_alloc(struct ice_pf *pf, uint32_t shared, uint32_t id)
 		return NULL;
 	}
 
-	counter_free->shared = shared;
-	counter_free->id = id;
-	counter_free->ref_cnt = 1;
 	counter_free->pool = pool;
 
 	/* reset statistic counter value */
@@ -404,17 +366,14 @@ ice_fdir_counter_alloc(struct ice_pf *pf, uint32_t shared, uint32_t id)
 }
 
 static void
-ice_fdir_counter_free(__rte_unused struct ice_pf *pf,
-		      struct ice_fdir_counter *counter)
+ice_fdir_counter_free(struct ice_fdir_counter *counter)
 {
 	if (!counter)
 		return;
 
-	if (--counter->ref_cnt == 0) {
-		struct ice_fdir_counter_pool *pool = counter->pool;
+	struct ice_fdir_counter_pool *pool = counter->pool;
 
-		TAILQ_INSERT_TAIL(&pool->counter_list, counter, next);
-	}
+	TAILQ_INSERT_TAIL(&pool->counter_list, counter, next);
 }
 
 static int
@@ -1642,9 +1601,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 
 	/* alloc counter for FDIR */
 	if (filter->input.cnt_ena) {
-		struct rte_flow_action_count *act_count = &filter->act_count;
-
-		filter->counter = ice_fdir_counter_alloc(pf, 0, act_count->id);
+		filter->counter = ice_fdir_counter_alloc(pf);
 		if (!filter->counter) {
 			rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
@@ -1681,7 +1638,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 
 free_counter:
 	if (filter->counter) {
-		ice_fdir_counter_free(pf, filter->counter);
+		ice_fdir_counter_free(filter->counter);
 		filter->counter = NULL;
 	}
 
@@ -1748,7 +1705,7 @@ ice_fdir_destroy_filter(struct ice_adapter *ad,
 	is_tun = ice_fdir_is_tunnel_profile(filter->tunnel_type);
 
 	if (filter->counter) {
-		ice_fdir_counter_free(pf, filter->counter);
+		ice_fdir_counter_free(filter->counter);
 		filter->counter = NULL;
 	}
 
@@ -2870,11 +2827,7 @@ ice_fdir_parse_action(struct ice_adapter *ad,
 		}
 		case RTE_FLOW_ACTION_TYPE_COUNT:
 		{
-			const struct rte_flow_action_count *act_count = act->conf;
-
 			filter->input.cnt_ena = ICE_FXD_FLTR_QW0_STAT_ENA_PKTS;
-			rte_memcpy(&filter->act_count, act_count,
-						sizeof(filter->act_count));
 			break;
 		}
 		default:
-- 
2.52.0

