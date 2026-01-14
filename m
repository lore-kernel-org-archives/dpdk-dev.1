Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D932D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBE1C40B9E;
	Wed, 14 Jan 2026 16:45:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 69B2140B8D;
 Wed, 14 Jan 2026 16:45:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405511; x=1799941511;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vTeKnZ6MWQuwaWKEHlamXAilNAVP4treVH4cMNGFb4M=;
 b=UPcLXYWbyHvWvsBrXb6gPya5fLawp08kN6qLO2NlAPIgUOmRy0g1GkaP
 EgbTdMtIODnlkFy+d6+73dNUvl+l8INGcbJDy/YgYXAzuMMRaNKumgTxA
 Cy7d49PJx6b7cKgxTgxA+rnyRrIYCichhHOXrIGnKDE2rfAllKOUJGvGC
 vQrvJfk6N/eCUK9/lgJJOD5q1j2oDhM934Esv9HYgTlt3nAoSAwvU0Iz4
 Kz2yWaIrVj7k63BWflF07OlgXMzSbTHvZ6DP8rIWPpHbODuoyiRv4xnBp
 o6SG4jzKdYwMhg2FcLpGF6DkVPQkAu6ie9GNhP2ICytRiK0z4a3U208NX A==;
X-CSE-ConnectionGUID: cH3ftN0wSTGStv3QFfcw0w==
X-CSE-MsgGUID: L1PMvrrfR/qZYlHOfsq8ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870814"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870814"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:11 -0800
X-CSE-ConnectionGUID: B3yTkoUIT6CIEr7C0BkXag==
X-CSE-MsgGUID: nUcfqueVSnCMj/7qABaxTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924972"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:08 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Kamalakannan R <kamalakannan.r@intel.com>
Subject: [PATCH v4 06/31] pipeline: fix variable shadowing
Date: Wed, 14 Jan 2026 15:44:20 +0000
Message-ID: <20260114154450.2969716-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

Remove unnecessary inner variables and rename others in order to remove
variable shadowing warnings from the code.

Fixes: ea5ab65f5743 ("pipeline: relax table match field requirements")
Fixes: cdaa937d3eaa ("pipeline: support selector table")
Fixes: 5f3e6104227c ("pipeline: prepare for variable size headers")
Fixes: 724f3ef422e9 ("pipeline: generate custom instruction functions")
Fixes: 68b95704a6a3 ("pipeline: add API for shared library-based pipeline build")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pipeline/rte_swx_ctl.c               | 11 +++++------
 lib/pipeline/rte_swx_pipeline.c          | 21 ++++++++++-----------
 lib/pipeline/rte_swx_pipeline_internal.h | 10 +++++-----
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index 4e9bb842a1..d24764cbbe 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -210,7 +210,7 @@ table_params_get(struct rte_swx_ctl_pipeline *ctl, uint32_t table_id)
 	uint32_t key_size = 0, key_offset = 0, action_data_size = 0, i;
 
 	if (table->info.n_match_fields) {
-		uint32_t n_match_fields_em = 0, i;
+		uint32_t n_match_fields_em = 0;
 
 		/* Find first (smallest offset) and last (biggest offset) match fields. */
 		first = &table->mf[0];
@@ -855,22 +855,21 @@ selector_free(struct rte_swx_ctl_pipeline *ctl)
 
 	for (i = 0; i < ctl->info.n_selectors; i++) {
 		struct selector *s = &ctl->selectors[i];
-		uint32_t i;
 
 		/* selector_fields. */
 		free(s->selector_fields);
 
 		/* groups. */
 		if (s->groups)
-			for (i = 0; i < s->info.n_groups_max; i++)
-				selector_group_members_free(s, i);
+			for (uint32_t j = 0; j < s->info.n_groups_max; j++)
+				selector_group_members_free(s, j);
 
 		free(s->groups);
 
 		/* pending_groups. */
 		if (s->pending_groups)
-			for (i = 0; i < s->info.n_groups_max; i++)
-				selector_pending_group_members_free(s, i);
+			for (uint32_t j = 0; j < s->info.n_groups_max; j++)
+				selector_pending_group_members_free(s, j);
 
 		free(s->pending_groups);
 
diff --git a/lib/pipeline/rte_swx_pipeline.c b/lib/pipeline/rte_swx_pipeline.c
index 2193bc4ebf..a9157815e4 100644
--- a/lib/pipeline/rte_swx_pipeline.c
+++ b/lib/pipeline/rte_swx_pipeline.c
@@ -1515,10 +1515,10 @@ static int
 header_build(struct rte_swx_pipeline *p)
 {
 	struct header *h;
-	uint32_t n_bytes = 0, i;
+	uint32_t total_bytes = 0, i;
 
 	TAILQ_FOREACH(h, &p->headers, node) {
-		n_bytes += h->st->n_bits / 8;
+		total_bytes += h->st->n_bits / 8;
 	}
 
 	for (i = 0; i < RTE_SWX_PIPELINE_THREADS_MAX; i++) {
@@ -1533,10 +1533,10 @@ header_build(struct rte_swx_pipeline *p)
 					sizeof(struct header_out_runtime));
 		CHECK(t->headers_out, ENOMEM);
 
-		t->header_storage = calloc(1, n_bytes);
+		t->header_storage = calloc(1, total_bytes);
 		CHECK(t->header_storage, ENOMEM);
 
-		t->header_out_storage = calloc(1, n_bytes);
+		t->header_out_storage = calloc(1, total_bytes);
 		CHECK(t->header_out_storage, ENOMEM);
 
 		TAILQ_FOREACH(h, &p->headers, node) {
@@ -14031,7 +14031,6 @@ instruction_group_list_create(struct rte_swx_pipeline *p)
 
 		for (i = 0; i < p->n_instructions; i++) {
 			struct instruction_data *data = &p->instruction_data[i];
-			struct instruction_group *g;
 			uint32_t j;
 
 			/* Continue when the current instruction is not a jump destination. */
@@ -14746,11 +14745,11 @@ rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **pipeline,
 
 	/* Action instructions. */
 	TAILQ_FOREACH(a, &p->actions, node) {
-		char name[RTE_SWX_NAME_SIZE * 2];
+		char action_name[RTE_SWX_NAME_SIZE * 2];
 
-		snprintf(name, sizeof(name), "action_%s_run", a->name);
+		snprintf(action_name, sizeof(action_name), "action_%s_run", a->name);
 
-		p->action_funcs[a->id] = dlsym(lib, name);
+		p->action_funcs[a->id] = dlsym(lib, action_name);
 		if (!p->action_funcs[a->id]) {
 			status = -EINVAL;
 			goto free;
@@ -14765,14 +14764,14 @@ rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **pipeline,
 	}
 
 	TAILQ_FOREACH(g, igl, node) {
-		char name[RTE_SWX_NAME_SIZE * 2];
+		char pipeline_name[RTE_SWX_NAME_SIZE * 2];
 
 		if (g->first_instr_id == g->last_instr_id)
 			continue;
 
-		snprintf(name, sizeof(name), "pipeline_func_%u", g->group_id);
+		snprintf(pipeline_name, sizeof(pipeline_name), "pipeline_func_%u", g->group_id);
 
-		g->func = dlsym(lib, name);
+		g->func = dlsym(lib, pipeline_name);
 		if (!g->func) {
 			status = -EINVAL;
 			goto free;
diff --git a/lib/pipeline/rte_swx_pipeline_internal.h b/lib/pipeline/rte_swx_pipeline_internal.h
index df864ea066..f527857861 100644
--- a/lib/pipeline/rte_swx_pipeline_internal.h
+++ b/lib/pipeline/rte_swx_pipeline_internal.h
@@ -1772,14 +1772,14 @@ emit_handler(struct thread *t)
 	if ((t->n_headers_out == 2) &&
 	    (h1->ptr + h1->n_bytes == t->ptr) &&
 	    (h0->ptr == h0->ptr0)) {
-		uint32_t offset;
+		uint32_t ofs;
 
 		TRACE("Emit handler: header encapsulation.\n");
 
-		offset = h0->n_bytes + h1->n_bytes;
-		memcpy(t->ptr - offset, h0->ptr, h0->n_bytes);
-		t->pkt.offset -= offset;
-		t->pkt.length += offset;
+		ofs = h0->n_bytes + h1->n_bytes;
+		memcpy(t->ptr - ofs, h0->ptr, h0->n_bytes);
+		t->pkt.offset -= ofs;
+		t->pkt.length += ofs;
 
 		return;
 	}
-- 
2.51.0

