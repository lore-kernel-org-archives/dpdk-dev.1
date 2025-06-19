Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D34C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B419D42E88;
	Thu, 19 Jun 2025 17:45:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2F9AB42E87
 for <dev@dpdk.org>; Thu, 19 Jun 2025 17:45:13 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8Sl83014407;
 Thu, 19 Jun 2025 08:45:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 aXfshpuD1pjDiH3Oj6F753rNGhsXXN/WapyHiQqRc0=; b=V+rZ3SK+ffxI/LPqR
 dzPcVmV31cFO7s3/Kf271b1Xa3wpJ1ZQUKPX0woCC+WoupA6clhNpnjwPhG4z2+k
 02fVtVaFqHP2e/t4e3SvtAVBz4PZNtHRR4YOV/yyureFK2rRIXNvo6LjodedD4S2
 puLNnFu8f/x1pRcNJRcvCYCi/LKdHrZB7kQzJzLkdn6hYhlAbNEzPbrc6PeYJEHy
 nHFZXpa7AVEyejYFVe2DInh3Vu2KX8Ow6blPgjaE/nhvB5EdmMexNs9h7DKKyWrw
 wHPtUVViMc4ICS2B3974l6F5Cq4DNZ/lGZhs+BemkOQXdAZKC7R6OjWHDGwa1Ro8
 Uo1pA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cf2u8va5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 08:45:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Jun 2025 08:45:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Jun 2025 08:45:10 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 5B38B3F707A;
 Thu, 19 Jun 2025 08:45:08 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v7 2/2] node: use node mbuf dynfield in ip4 nodes
Date: Thu, 19 Jun 2025 21:14:50 +0530
Message-ID: <20250619154501.3869031-3-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619154501.3869031-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250619154501.3869031-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEzMCBTYWx0ZWRfX/cxZoZgElEJN
 AKmkKkmeNval8XeL732kxmnIf+sskY0oWxhEJs0P4wZMyG+OCy9GfAlnWQKdMfbUyXQa8VJ1S87
 h478tlsH2UCJc1PasNk23Gof9mAl/zfhTfpgSp47otMCkhbqgKiECJAJSTU8bnqIeyexxo9AuSU
 EQG8nyo4Nd1lmetACTBFWKMydDrebVu9IwrenxEipgmSJsY1cBJu8P/WudwOkIsI2kIswfQL31q
 bbsNkODwoB4UmAbto3Mjmt+OqCijjXZSes291k5Ku2dr2nrbAAvy/Gm2g/VF/FGmKSlMQnDL5Cy
 LqEeAKulozfCWkGKEpRFAsqL/oHy6NrYEd2TZsxpDZczuPZ2uYBGpN0Ye/frcOfA9Lt2Ns5YDkh
 v4DaPnpmCSy2vgwE9fTDy9SbqONOJ/+JMnKa3u0RAh8ven0741JDCz2r02AJbK93RN6ebJVl
X-Proofpoint-GUID: 3nugZaOObNzetUD09lRIiOrPP7hDYaw-
X-Proofpoint-ORIG-GUID: 3nugZaOObNzetUD09lRIiOrPP7hDYaw-
X-Authority-Analysis: v=2.4 cv=dsXbC0g4 c=1 sm=1 tr=0 ts=68543088 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=enVnLOUNfkT2Or1lyk0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
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
 lib/node/ip4_lookup_fib.c         | 17 ++++++-------
 lib/node/ip4_rewrite.c            | 32 +++++++++++++------------
 lib/node/ip6_lookup.c             | 15 +++++-------
 lib/node/ip6_lookup_fib.c         | 17 ++++++-------
 lib/node/ip6_rewrite.c            | 14 ++++-------
 lib/node/node_private.h           | 40 +++----------------------------
 lib/node/rte_node_mbuf_dynfield.h |  9 +++++++
 8 files changed, 59 insertions(+), 99 deletions(-)

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
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index f9a5c5aa5a..0857d889fc 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -277,18 +277,15 @@ setup_fib(int socket)
 static int
 ip4_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
-	static uint8_t init_once;
-	int rc;
+	int rc, dyn;

 	RTE_BUILD_BUG_ON(sizeof(struct ip4_lookup_fib_node_ctx) > RTE_NODE_CTX_SZ);

-	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
-
-		init_once = 1;
+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0) {
+		node_err("ip4_lookup_fib", "Failed to register mbuf dynfield, rc=%d",
+			 -rte_errno);
+		return -rte_errno;
 	}

 	rc = setup_fib(graph->socket);
@@ -300,7 +297,7 @@ ip4_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)

 	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
 	IP4_LOOKUP_NODE_FIB(node->ctx) = ip4_lookup_fib_nm.fib[graph->socket];
-	IP4_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+	IP4_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = dyn;

 	node_dbg("ip4_lookup_fib", "Initialized ip4_lookup_fib node");

diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index b1fa386d9f..37bc3a511f 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -486,16 +486,18 @@ ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
 	rte_graph_feature_arc_t feature_arc = RTE_GRAPH_FEATURE_ARC_INITIALIZER;
 	static bool init_once;
+	int dyn;

 	RTE_SET_USED(graph);
 	RTE_BUILD_BUG_ON(sizeof(struct ip4_rewrite_node_ctx) > RTE_NODE_CTX_SZ);

-	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0) {
+		node_err("ip4_rewrite", "Failed to register mbuf dynfield");
+		return -rte_errno;
+	}

+	if (!init_once) {
 		/* Create ipv4-output feature arc, if not created
 		 */
 		if (rte_graph_feature_arc_lookup_by_name(RTE_IP4_OUTPUT_FEATURE_ARC_NAME,
@@ -507,19 +509,19 @@ ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 				 RTE_IP4_OUTPUT_FEATURE_ARC_NAME);
 		}

-		init_once = true;
-	}
-	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
-	IP4_REWRITE_NODE_OUTPUT_FEATURE_ARC(node->ctx) = feature_arc;
+		IP4_REWRITE_NODE_OUTPUT_FEATURE_ARC(node->ctx) = feature_arc;

-	if (rte_graph_feature_arc_get(feature_arc))
-		IP4_REWRITE_NODE_FEAT_OFF(node->ctx) =
-			rte_graph_feature_arc_get(feature_arc)->mbuf_dyn_offset;
+		if (rte_graph_feature_arc_get(feature_arc))
+			IP4_REWRITE_NODE_FEAT_OFF(node->ctx) =
+				rte_graph_feature_arc_get(feature_arc)->mbuf_dyn_offset;

-	/* By default, set cached next node to pkt_drop */
-	IP4_REWRITE_NODE_LAST_NEXT(node->ctx) = 0;
-	IP4_REWRITE_NODE_LAST_TX_IF(node->ctx) = 0;
+		/* By default, set cached next node to pkt_drop */
+		IP4_REWRITE_NODE_LAST_NEXT(node->ctx) = 0;
+		IP4_REWRITE_NODE_LAST_TX_IF(node->ctx) = 0;

+		init_once = true;
+	}
+	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) = dyn;
 	node_dbg("ip4_rewrite", "Initialized ip4_rewrite node initialized");

 	return 0;
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

diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 3df61890e9..40c5c753df 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -268,18 +268,15 @@ setup_fib6(int socket)
 static int
 ip6_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
-	static uint8_t init_once;
-	int rc;
+	int rc, dyn;

 	RTE_BUILD_BUG_ON(sizeof(struct ip6_lookup_fib_node_ctx) > RTE_NODE_CTX_SZ);

-	if (!init_once) {
-		node_mbuf_priv1_dynfield_offset = rte_mbuf_dynfield_register(
-				&node_mbuf_priv1_dynfield_desc);
-		if (node_mbuf_priv1_dynfield_offset < 0)
-			return -rte_errno;
-
-		init_once = 1;
+	dyn = rte_node_mbuf_dynfield_register();
+	if (dyn < 0) {
+		node_err("ip6_lookup_fib", "Failed to register mbuf dynfield, rc=%d",
+			 -rte_errno);
+		return -rte_errno;
 	}

 	rc = setup_fib6(graph->socket);
@@ -291,7 +288,7 @@ ip6_lookup_fib_node_init(const struct rte_graph *graph, struct rte_node *node)

 	/* Update socket's FIB and mbuf dyn priv1 offset in node ctx */
 	IP6_LOOKUP_FIB_NODE(node->ctx) = ip6_lookup_fib_nm.fib6[graph->socket];
-	IP6_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = node_mbuf_priv1_dynfield_offset;
+	IP6_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx) = dyn;

 	node_dbg("ip6_lookup_fib", "Initialized ip6_lookup_fib node");

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
index 9488df225c..a2b5a93681 100644
--- a/lib/node/node_private.h
+++ b/lib/node/node_private.h
@@ -14,6 +14,7 @@

 #include <rte_graph_worker_common.h>
 #include <rte_graph_feature_arc_worker.h>
+#include <rte_node_mbuf_dynfield.h>

 extern int rte_node_logtype;
 #define RTE_LOGTYPE_NODE rte_node_logtype
@@ -27,28 +28,8 @@ extern int rte_node_logtype;
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
@@ -61,21 +42,6 @@ struct __rte_cache_aligned node_mbuf_priv2 {

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
index 1069c07d44..045c13e352 100644
--- a/lib/node/rte_node_mbuf_dynfield.h
+++ b/lib/node/rte_node_mbuf_dynfield.h
@@ -46,6 +46,15 @@ extern "C" {
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

