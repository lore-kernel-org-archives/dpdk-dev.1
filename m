Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0690CD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 10:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B49F140652;
	Mon, 18 May 2026 12:01:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 18F0140652
 for <dev@dpdk.org>; Mon, 18 May 2026 12:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779098490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1P41S0bzN3maytTYfn9/1W28wFs4yTogAzkq3Mq/EAA=;
 b=cBYSOWjvtB9+dPdIcQezT6w9J/EBiFAWEgJzXc6epoR2EPx8U2v1ueuSUnFwZFVNrrz78D
 mME4eobOyWkbwm1CluoYZSbqR81e1H9+tzfcsfoncaYxESS2ovDcak1MtMGKLhcAxZvRL8
 8yTEk0ejK+V5RyTngEdz9Lz9GRd1F9E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-M653kxBUNpm19Wjby-5gAA-1; Mon,
 18 May 2026 06:01:26 -0400
X-MC-Unique: M653kxBUNpm19Wjby-5gAA-1
X-Mimecast-MFC-AGG-ID: M653kxBUNpm19Wjby-5gAA_1779098485
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 260AF180044D; Mon, 18 May 2026 10:01:25 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.250])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C96711800352; Mon, 18 May 2026 10:01:23 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk 2/2] rib: add mode to include top-level route in traversal
Date: Mon, 18 May 2026 11:59:05 +0200
Message-ID: <20260518095900.29655-8-rjarry@redhat.com>
In-Reply-To: <20260518095900.29655-6-rjarry@redhat.com>
References: <20260518095900.29655-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hy6Piyh3s4FCPl7EouS9kET-GLmVdrPb37-z3B86M6Y_1779098485
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

rte_rib_get_nxt() and rte_rib6_get_nxt() skip the exact match
top-level route when iterating subroutes. This is the expected behavior
in most cases but some users need the full subtree including the root.

Add a RTE_RIB_GET_NXT_ALL_TOP (and RTE_RIB6_GET_NXT_ALL_TOP) mode
that uses >= instead of > when comparing depths so that the top-level
route is returned as well.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_rib.c  | 16 ++++++++++++++++
 app/test/test_rib6.c | 16 ++++++++++++++++
 lib/rib/rte_rib.c    | 12 ++++++++++--
 lib/rib/rte_rib.h    |  4 ++++
 lib/rib/rte_rib6.c   | 12 ++++++++++--
 lib/rib/rte_rib6.h   |  4 ++++
 6 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/app/test/test_rib.c b/app/test/test_rib.c
index a4a683140df3..f56490e67ec0 100644
--- a/app/test/test_rib.c
+++ b/app/test/test_rib.c
@@ -300,6 +300,7 @@ test_tree_traversal(void)
 	uint32_t ip1 = RTE_IPV4(10, 10, 10, 0);
 	uint32_t ip2 = RTE_IPV4(10, 10, 130, 80);
 	uint8_t depth = 30;
+	unsigned int num;
 
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
@@ -313,11 +314,26 @@ test_tree_traversal(void)
 	node = rte_rib_insert(rib, ip2, depth);
 	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
 
+	node = rte_rib_insert(rib, 0, 0);
+	RTE_TEST_ASSERT(node != NULL, "Failed to insert default rule\n");
+
 	node = NULL;
 	node = rte_rib_get_nxt(rib, RTE_IPV4(10, 10, 130, 0), 24, node,
 			RTE_RIB_GET_NXT_ALL);
 	RTE_TEST_ASSERT(node != NULL, "Failed to get rib_node\n");
 
+	num = 0;
+	node = NULL;
+	while ((node = rte_rib_get_nxt(rib, 0, 0, node, RTE_RIB_GET_NXT_ALL)) != NULL)
+		num++;
+	RTE_TEST_ASSERT(num == 2, "Invalid number of routes\n");
+
+	num = 0;
+	node = NULL;
+	while ((node = rte_rib_get_nxt(rib, 0, 0, node, RTE_RIB_GET_NXT_ALL_TOP)) != NULL)
+		num++;
+	RTE_TEST_ASSERT(num == 3, "Default route not returned by rte_rib_get_nxt\n");
+
 	rte_rib_free(rib);
 
 	return TEST_SUCCESS;
diff --git a/app/test/test_rib6.c b/app/test/test_rib6.c
index 0295a9640cfa..542c955eee8c 100644
--- a/app/test/test_rib6.c
+++ b/app/test/test_rib6.c
@@ -300,7 +300,9 @@ test_tree_traversal(void)
 	struct rte_ipv6_addr ip = RTE_IPV6(0x0a00, 0x0282, 0, 0, 0, 0, 0, 0);
 	struct rte_ipv6_addr ip1 = RTE_IPV6(0x0a00, 0x0200, 0, 0, 0, 0, 0, 0);
 	struct rte_ipv6_addr ip2 = RTE_IPV6(0x0a00, 0x0282, 0, 0, 0, 0, 0, 0x0050);
+	struct rte_ipv6_addr unspec = RTE_IPV6(0, 0, 0, 0, 0, 0, 0, 0);
 	uint8_t depth = 126;
+	unsigned int num;
 
 	config.max_nodes = MAX_RULES;
 	config.ext_sz = 0;
@@ -312,11 +314,25 @@ test_tree_traversal(void)
 	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
 	node = rte_rib6_insert(rib, &ip2, depth);
 	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
+	node = rte_rib6_insert(rib, &unspec, 0);
+	RTE_TEST_ASSERT(node != NULL, "Failed to insert default route\n");
 
 	node = NULL;
 	node = rte_rib6_get_nxt(rib, &ip, 32, node, RTE_RIB6_GET_NXT_ALL);
 	RTE_TEST_ASSERT(node != NULL, "Failed to get rib_node\n");
 
+	num = 0;
+	node = NULL;
+	while ((node = rte_rib6_get_nxt(rib, 0, 0, node, RTE_RIB6_GET_NXT_ALL)) != NULL)
+		num++;
+	RTE_TEST_ASSERT(num == 2, "Invalid number of routes\n");
+
+	num = 0;
+	node = NULL;
+	while ((node = rte_rib6_get_nxt(rib, 0, 0, node, RTE_RIB6_GET_NXT_ALL_TOP)) != NULL)
+		num++;
+	RTE_TEST_ASSERT(num == 3, "Default route not returned by rte_rib6_get_nxt\n");
+
 	rte_rib6_free(rib);
 
 	return TEST_SUCCESS;
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 89061829a23c..a3c287e215ec 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -167,6 +167,14 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	return __rib_lookup_exact(rib, ip, depth);
 }
 
+static bool
+depth_match(struct rte_rib_node *node, uint8_t depth, int flag)
+{
+	if (flag == RTE_RIB_GET_NXT_ALL_TOP)
+		return node->depth >= depth;
+	return node->depth > depth;
+}
+
 /*
  *  Traverses on subtree and retrieves more specific routes
  *  for a given in args ip/depth prefix
@@ -195,7 +203,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 			tmp = tmp->parent;
 			if (is_valid_node(tmp) &&
 					(is_covered(tmp->ip, ip, depth) &&
-					(tmp->depth > depth)))
+					(depth_match(tmp, depth, mode))))
 				return tmp;
 		}
 		tmp = (tmp->parent) ? tmp->parent->right : NULL;
@@ -203,7 +211,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	while (tmp) {
 		if (is_valid_node(tmp) &&
 				(is_covered(tmp->ip, ip, depth) &&
-				(tmp->depth > depth))) {
+				(depth_match(tmp, depth, mode)))) {
 			prev = tmp;
 			if (mode == RTE_RIB_GET_NXT_COVER)
 				return prev;
diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
index 0fabfb2a41a6..5e72fa9273e2 100644
--- a/lib/rib/rte_rib.h
+++ b/lib/rib/rte_rib.h
@@ -31,6 +31,8 @@ enum rte_rib_nxt_mode {
 	RTE_RIB_GET_NXT_ALL,
 	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB_GET_NXT_COVER,
+	/** get all subroutes in a RIB tree, including the exact match top-level route, if any */
+	RTE_RIB_GET_NXT_ALL_TOP,
 };
 
 struct rte_rib;
@@ -125,6 +127,8 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
  *   get all prefixes from subtrie
  *  -RTE_RIB_GET_NXT_COVER
  *   get only first more specific prefix even if it have more specifics
+ *  -RTE_RIB_GET_NXT_ALL_TOP
+ *   get the top-level exact matching prefix, if any
  * @return
  *  pointer to the next more specific prefix
  *  NULL if there is no prefixes left
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index c23881f6247e..5114fb522e3e 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -186,6 +186,14 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
 	return NULL;
 }
 
+static bool
+depth_match(struct rte_rib6_node *node, uint8_t depth, enum rte_rib6_nxt_mode mode)
+{
+	if (mode == RTE_RIB6_GET_NXT_ALL_TOP)
+		return node->depth >= depth;
+	return node->depth > depth;
+}
+
 /*
  *  Traverses on subtree and retrieves more specific routes
  *  for a given in args ip/depth prefix
@@ -219,7 +227,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 			tmp = tmp->parent;
 			if (is_valid_node(tmp) &&
 					(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
-					(tmp->depth > depth)))
+					(depth_match(tmp, depth, mode))))
 				return tmp;
 		}
 		tmp = (tmp->parent != NULL) ? tmp->parent->right : NULL;
@@ -227,7 +235,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 	while (tmp) {
 		if (is_valid_node(tmp) &&
 				(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
-				(tmp->depth > depth))) {
+				(depth_match(tmp, depth, mode)))) {
 			prev = tmp;
 			if (mode == RTE_RIB6_GET_NXT_COVER)
 				return prev;
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index ed2761492bc8..1d8b56b89b13 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -32,6 +32,8 @@ enum rte_rib6_nxt_mode {
 	RTE_RIB6_GET_NXT_ALL,
 	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB6_GET_NXT_COVER,
+	/** get all subroutes in a RIB tree, including the exact match top-level route, if any */
+	RTE_RIB6_GET_NXT_ALL_TOP,
 };
 
 struct rte_rib6;
@@ -184,6 +186,8 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
  *   get all prefixes from subtrie
  *  -RTE_RIB6_GET_NXT_COVER
  *   get only first more specific prefix even if it have more specifics
+ *  -RTE_RIB6_GET_NXT_ALL_TOP
+ *   get the top-level exact matching prefix, if any
  * @return
  *  pointer to the next more specific prefix
  *  NULL if there is no prefixes left
-- 
2.54.0

