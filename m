Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA01C36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 10:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B059D4066E;
	Mon, 28 Apr 2025 12:37:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 66D684066E
 for <dev@dpdk.org>; Mon, 28 Apr 2025 12:37:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SA11A9028084;
 Mon, 28 Apr 2025 03:37:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 5SkhhytWjM8N5eGmPzqvObeAxu8kepmzMWv0FHejJo=; b=aWHzOtU9y2CxxG5LM
 2LXBPQ+ZskF/HpBd96oMRhlaa0EOAYpHTlNBBNl6STV6ZiOVE3ZMNtkD535jRVb1
 wg74+Ejicfn7V9RShaazF4LMhtUfG/wDovMz6IxCAxgSffRd5/9ykoC1aSv+1Ip0
 tFaTsXRnmYK82XrWtov+OdN/qQ1sX5qc18JyDKec4cRUtcClemwJRMRzIYCBzl8o
 IbgJ7G5xE5U9pLtuqf1i4qGdC8vi7MfxB0xdE2gJ1MI+TYjDtlzlDm4tpO+GK/RJ
 V2xOY25z3tNRwM2LpoAc0Su2MFruE4OuquulCpxMbzJ7O0C8JpBNOfcIliEcZleI
 MkC9Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 468y0kk0ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 03:37:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Apr 2025 03:37:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Apr 2025 03:37:21 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id D16C63F7040;
 Mon, 28 Apr 2025 03:37:18 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v6 2/2] node: use node mbuf dynfield in ip4 nodes
Date: Mon, 28 Apr 2025 16:07:07 +0530
Message-ID: <20250428103711.3317231-3-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428103711.3317231-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250428103711.3317231-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XYuJzJ55 c=1 sm=1 tr=0 ts=680f5a62 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=ku94CzlV7n_3oAq-ZpMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: kGs1-_zeQbbKWVNuvQLz3Hx4O5hCNyEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA4NyBTYWx0ZWRfX7qlcOOC2ngCc
 phZtaAnQME5PvH/bZbxWgUnkvLT5rUVxOQVLexlf7tiMKb02fALcU0AZSMRIChXIE/k97JovW74
 rMuE+gOyySaOeJXMV0RXt8X7BS+632pZuyY8piAZ3TcnwsAR9noCAA6F/ofzeA6LY+rl5q0VqgV
 FmCT+6NdXstfsc6wsggwhSamw1AVw6OAS/rzDwM6Yd629Qud0bBEfXRsPNrw+jx1RO7K6bL+ZIx
 9u2euGZlmDy+nfj3V8BxGmmPTHRYYZmPjsLEn/fKudLPx42UojiR0jLAlP042C3AieqZ3ELqR8p
 ldUk5QtMzp3MIafJFG0fBRMav7yKSbe3kEvgClCxDnPHr6XD6v1bXi00CT9C9Sqhe7hEmf7qGUo
 cNhb2hjgjWMpIBU9vlWd0refDMHbtmqlLARrcaEsFN7Bd1EEA978fiTdqbOea5gpskMoJ0xL
X-Proofpoint-GUID: kGs1-_zeQbbKWVNuvQLz3Hx4O5hCNyEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
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

- Used global node mbuf in ip[4|6]_lookup/rewrite nodes
- Redefine node_mbuf_priv1() to rte_node_mbuf_overload_fields_get()

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 lib/node/ip4_lookup.c             | 14 ++++-------
 lib/node/ip4_rewrite.c            | 15 +++++-------
 lib/node/ip6_lookup.c             | 15 +++++-------
 lib/node/ip6_rewrite.c            | 14 ++++-------
 lib/node/node_private.h           | 40 +++----------------------------
 lib/node/rte_node_mbuf_dynfield.h |  9 +++++++
 6 files changed, 34 insertions(+), 73 deletions(-)

diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index 604fcb267a..f6db3219f0 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -32,8 +32,6 @@ struct ip4_lookup_node_ctx {
 	int mbuf_priv1_off;
 };

-int node_mbuf_priv1_dynfield_offset = -1;
-
 static struct ip4_lookup_node_main ip4_lookup_nm;

 #define IP4_LOOKUP_NODE_LPM(ctx) \
@@ -182,17 +180,15 @@ ip4_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
 	uint16_t socket, lcore_id;
 	static uint8_t init_once;
-	int rc;
+	int rc, dyn;

 	RTE_SET_USED(graph);
 	RTE_BUILD_BUG_ON(sizeof(struct ip4_lookup_node_ctx) > RTE_NODE_CTX_SZ);

+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0)
+		return -rte_errno;
 	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
-
 		/* Setup LPM tables for all sockets */
 		RTE_LCORE_FOREACH(lcore_id)
 		{
@@ -210,7 +206,7 @@ ip4_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)

 	/* Update socket's LPM and mbuf dyn priv1 offset in node ctx */
 	IP4_LOOKUP_NODE_LPM(node->ctx) = ip4_lookup_nm.lpm_tbl[graph->socket];
-	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) = dyn;

 #if defined(__ARM_NEON) || defined(RTE_ARCH_X86)
 	if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)
diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index a9ab5eaa57..dfa4382350 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -259,19 +259,16 @@ ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 static int
 ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
-	static bool init_once;
+	int dyn;

 	RTE_SET_USED(graph);
 	RTE_BUILD_BUG_ON(sizeof(struct ip4_rewrite_node_ctx) > RTE_NODE_CTX_SZ);

-	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
-		init_once = true;
-	}
-	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0)
+		return -rte_errno;
+
+	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) = dyn;

 	node_dbg("ip4_rewrite", "Initialized ip4_rewrite node initialized");

diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index 827fc2f379..83c0500c76 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -318,18 +318,16 @@ ip6_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
 	uint16_t socket, lcore_id;
 	static uint8_t init_once;
-	int rc;
+	int rc, dyn;

 	RTE_SET_USED(graph);
 	RTE_BUILD_BUG_ON(sizeof(struct ip6_lookup_node_ctx) > RTE_NODE_CTX_SZ);

-	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset =
-			rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0)
+		return -rte_errno;

+	if (!init_once) {
 		/* Setup LPM tables for all sockets */
 		RTE_LCORE_FOREACH(lcore_id)
 		{
@@ -347,8 +345,7 @@ ip6_lookup_node_init(const struct rte_graph *graph, struct rte_node *node)

 	/* Update socket's LPM and mbuf dyn priv1 offset in node ctx */
 	IP6_LOOKUP_NODE_LPM(node->ctx) = ip6_lookup_nm.lpm_tbl[graph->socket];
-	IP6_LOOKUP_NODE_PRIV1_OFF(node->ctx) =
-					node_mbuf_priv1_dynfield_offset;
+	IP6_LOOKUP_NODE_PRIV1_OFF(node->ctx) = dyn;

 	node_dbg("ip6_lookup", "Initialized ip6_lookup node");

diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
index e157964c6a..d5488e7fa3 100644
--- a/lib/node/ip6_rewrite.c
+++ b/lib/node/ip6_rewrite.c
@@ -243,19 +243,15 @@ ip6_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 static int
 ip6_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
-	static bool init_once;
+	int dyn;

 	RTE_SET_USED(graph);
 	RTE_BUILD_BUG_ON(sizeof(struct ip6_rewrite_node_ctx) > RTE_NODE_CTX_SZ);

-	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
-		init_once = true;
-	}
-	IP6_REWRITE_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0)
+		return -rte_errno;
+	IP6_REWRITE_NODE_PRIV1_OFF(node->ctx) = dyn;

 	node_dbg("ip6_rewrite", "Initialized ip6_rewrite node");

diff --git a/lib/node/node_private.h b/lib/node/node_private.h
index 4fafab19be..7fb2aff0b8 100644
--- a/lib/node/node_private.h
+++ b/lib/node/node_private.h
@@ -13,6 +13,7 @@
 #include <rte_mbuf_dyn.h>

 #include <rte_graph_worker_common.h>
+#include <rte_node_mbuf_dynfield.h>

 extern int rte_node_logtype;
 #define RTE_LOGTYPE_NODE rte_node_logtype
@@ -26,28 +27,8 @@ extern int rte_node_logtype;
 #define node_info(node_name, ...) NODE_LOG(INFO, node_name, __VA_ARGS__)
 #define node_dbg(node_name, ...) NODE_LOG(DEBUG, node_name, __VA_ARGS__)

-/**
- * Node mbuf private data to store next hop, ttl and checksum.
- */
-struct node_mbuf_priv1 {
-	union {
-		/* IP4/IP6 rewrite */
-		struct {
-			uint16_t nh;
-			uint16_t ttl;
-			uint32_t cksum;
-		};
-
-		uint64_t u;
-	};
-};
-
-static const struct rte_mbuf_dynfield node_mbuf_priv1_dynfield_desc = {
-	.name = "rte_node_dynfield_priv1",
-	.size = sizeof(struct node_mbuf_priv1),
-	.align = alignof(struct node_mbuf_priv1),
-};
-extern int node_mbuf_priv1_dynfield_offset;
+/* define internal function used by nodes */
+#define node_mbuf_priv1 rte_node_mbuf_overload_fields_get

 /**
  * Node mbuf private area 2.
@@ -60,21 +41,6 @@ struct __rte_cache_aligned node_mbuf_priv2 {

 #define OBJS_PER_CLINE (RTE_CACHE_LINE_SIZE / sizeof(void *))

-/**
- * Get mbuf_priv1 pointer from rte_mbuf.
- *
- * @param
- *   Pointer to the rte_mbuf.
- *
- * @return
- *   Pointer to the mbuf_priv1.
- */
-static __rte_always_inline struct node_mbuf_priv1 *
-node_mbuf_priv1(struct rte_mbuf *m, const int offset)
-{
-	return RTE_MBUF_DYNFIELD(m, offset, struct node_mbuf_priv1 *);
-}
-
 /**
  * Get mbuf_priv2 pointer from rte_mbuf.
  *
diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_dynfield.h
index 4db5382f91..0b22fbf718 100644
--- a/lib/node/rte_node_mbuf_dynfield.h
+++ b/lib/node/rte_node_mbuf_dynfield.h
@@ -40,6 +40,15 @@ extern "C" {
  */
 typedef struct rte_node_mbuf_overload_fields {
 	union {
+		/* Following fields used by ip[4|6]-lookup -> ip[4|6]-rewrite nodes */
+		union {
+			struct {
+				uint16_t nh;
+				uint16_t ttl;
+				uint32_t cksum;
+			};
+			uint64_t u;
+		};
 		uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
 	};
 } rte_node_mbuf_overload_fields_t;
--
2.43.0

