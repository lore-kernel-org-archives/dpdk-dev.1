Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9F4C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 10:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9569D402DF;
	Wed, 26 Mar 2025 11:39:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 99A25402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 11:39:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742985585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fdlpuvW5Al8PoY+am9yIppgy/zsFJ22RJ6AywcNypkg=;
 b=cEJloBmciGsLRCEWI2fQq1faNWOdKKgkqGGvXNmgzQSYJkOx/ow0HbvsgNfqqOn9D5zsXR
 ONexhc2DscwA+CGFoppgxNQ8/8nzJP9kTIwSdxiBQSk/9mlGIZ6ng6NeKM44du4NkLTZpX
 s4CCB5pF3NAN+ko3kzxYL4TNgfLePKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-8CSougsDPeyJ8lnPA1Nw6A-1; Wed,
 26 Mar 2025 06:39:41 -0400
X-MC-Unique: 8CSougsDPeyJ8lnPA1Nw6A-1
X-Mimecast-MFC-AGG-ID: 8CSougsDPeyJ8lnPA1Nw6A_1742985580
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D122180025A; Wed, 26 Mar 2025 10:39:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DAD4180175A; Wed, 26 Mar 2025 10:39:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bluca@debian.org, stable@dpdk.org,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 David Christensen <drc@linux.ibm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] acl: fix build with GCC 15 on aarch64
Date: Wed, 26 Mar 2025 11:39:28 +0100
Message-ID: <20250326103928.1189243-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -D9K7KBS-BVUvpgeHRKUVGahoEWB-gp6wU7uJ5HjCPo_1742985580
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

Caught in OBS for Fedora Rawhide on aarch64:

[  198s] In file included from ../lib/acl/acl_run_neon.h:7,
[  198s]                  from ../lib/acl/acl_run_neon.c:5:
[  198s] In function ‘alloc_completion’,
[  198s]     inlined from ‘acl_start_next_trie’ at
	../lib/acl/acl_run.h:140:24,
[  198s]     inlined from ‘search_neon_4.isra’ at
	../lib/acl/acl_run_neon.h:239:20:
[  198s] ../lib/acl/acl_run.h:93:25: error: ‘cmplt’ may be used
	uninitialized [-Werror=maybe-uninitialized]
[  198s]    93 |                 if (p[n].count == 0) {
[  198s]       |                     ~~~~^~~~~~
[  198s] ../lib/acl/acl_run_neon.h: In function ‘search_neon_4.isra’:
[  198s] ../lib/acl/acl_run_neon.h:230:27: note: ‘cmplt’ declared here
[  198s]   230 |         struct completion cmplt[4];
[  198s]       |                           ^~~~~

The code was resetting sequentially cmpl[].count at the exact index that
later call to alloc_completion uses.
While this code seems correct, GCC 15 does not understand this (probably
when applying some optimisations).

Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup the
various vectorized implementations accordingly.

Bugzilla ID: 1678
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/acl/acl_run.h         | 5 +++++
 lib/acl/acl_run_altivec.h | 8 ++------
 lib/acl/acl_run_avx2.h    | 4 +---
 lib/acl/acl_run_neon.h    | 8 ++------
 lib/acl/acl_run_scalar.c  | 4 +---
 lib/acl/acl_run_sse.h     | 8 ++------
 6 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/lib/acl/acl_run.h b/lib/acl/acl_run.h
index 7f092413cd..9fd3e60021 100644
--- a/lib/acl/acl_run.h
+++ b/lib/acl/acl_run.h
@@ -176,6 +176,8 @@ acl_set_flow(struct acl_flow_data *flows, struct completion *cmplt,
 	uint32_t cmplt_size, const uint8_t **data, uint32_t *results,
 	uint32_t data_num, uint32_t categories, const uint64_t *trans)
 {
+	unsigned int i;
+
 	flows->num_packets = 0;
 	flows->started = 0;
 	flows->trie = 0;
@@ -187,6 +189,9 @@ acl_set_flow(struct acl_flow_data *flows, struct completion *cmplt,
 	flows->data = data;
 	flows->results = results;
 	flows->trans = trans;
+
+	for (i = 0; i < cmplt_size; i++)
+		cmplt[i].count = 0;
 }
 
 typedef void (*resolve_priority_t)
diff --git a/lib/acl/acl_run_altivec.h b/lib/acl/acl_run_altivec.h
index 2d398ffded..d5ccdb94f0 100644
--- a/lib/acl/acl_run_altivec.h
+++ b/lib/acl/acl_run_altivec.h
@@ -199,10 +199,8 @@ search_altivec_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < MAX_SEARCHES_ALTIVEC8; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < MAX_SEARCHES_ALTIVEC8; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	 /* Check for any matches. */
 	acl_match_check_x4(0, ctx, parms, &flows, (uint64_t *)&index_array[0]);
@@ -270,10 +268,8 @@ search_altivec_4(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < MAX_SEARCHES_ALTIVEC4; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < MAX_SEARCHES_ALTIVEC4; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	/* Check for any matches. */
 	acl_match_check_x4(0, ctx, parms, &flows, index_array);
diff --git a/lib/acl/acl_run_avx2.h b/lib/acl/acl_run_avx2.h
index 0b8967f22e..e069fb85b2 100644
--- a/lib/acl/acl_run_avx2.h
+++ b/lib/acl/acl_run_avx2.h
@@ -171,10 +171,8 @@ search_avx2x16(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < RTE_DIM(cmplt); n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < RTE_DIM(cmplt); n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	t0 = _mm256_set_epi64x(index_array[5], index_array[4],
 		index_array[1], index_array[0]);
diff --git a/lib/acl/acl_run_neon.h b/lib/acl/acl_run_neon.h
index 63074f871d..3b9bd0cc39 100644
--- a/lib/acl/acl_run_neon.h
+++ b/lib/acl/acl_run_neon.h
@@ -172,10 +172,8 @@ search_neon_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		     total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < 8; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < 8; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	 /* Check for any matches. */
 	acl_match_check_x4(0, ctx, parms, &flows, &index_array[0]);
@@ -234,10 +232,8 @@ search_neon_4(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		     total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < 4; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < 4; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	/* Check for any matches. */
 	acl_match_check_x4(0, ctx, parms, &flows, index_array);
diff --git a/lib/acl/acl_run_scalar.c b/lib/acl/acl_run_scalar.c
index 3d61e79409..a3661b1b6b 100644
--- a/lib/acl/acl_run_scalar.c
+++ b/lib/acl/acl_run_scalar.c
@@ -121,10 +121,8 @@ rte_acl_classify_scalar(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results, num,
 		categories, ctx->trans_table);
 
-	for (n = 0; n < MAX_SEARCHES_SCALAR; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < MAX_SEARCHES_SCALAR; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	transition0 = index_array[0];
 	transition1 = index_array[1];
diff --git a/lib/acl/acl_run_sse.h b/lib/acl/acl_run_sse.h
index 93286a2c38..4ec819a215 100644
--- a/lib/acl/acl_run_sse.h
+++ b/lib/acl/acl_run_sse.h
@@ -205,10 +205,8 @@ search_sse_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < MAX_SEARCHES_SSE8; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < MAX_SEARCHES_SSE8; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	/*
 	 * indices1 contains index_array[0,1]
@@ -293,10 +291,8 @@ search_sse_4(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
 		total_packets, categories, ctx->trans_table);
 
-	for (n = 0; n < MAX_SEARCHES_SSE4; n++) {
-		cmplt[n].count = 0;
+	for (n = 0; n < MAX_SEARCHES_SSE4; n++)
 		index_array[n] = acl_start_next_trie(&flows, parms, n, ctx);
-	}
 
 	indices1 = _mm_loadu_si128((xmm_t *) &index_array[0]);
 	indices2 = _mm_loadu_si128((xmm_t *) &index_array[2]);
-- 
2.48.1

