Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30647CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A1D442E60;
	Fri,  2 Oct 2026 12:16:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1510242DBD
 for <dev@dpdk.org>; Fri,  2 Oct 2026 12:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790936170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=um0ehb6AZNWFhGgTz0dQLluZds8+YGHBK1P4J6SReko=;
 b=AyezZ0+coYmW3BJZaO/0oqPA0/0IxVPiblapfS89DsfX9+OE1ruq3HcthorFkPXmQTmRi/
 Y+fjaQEZQ83sPtXNya6dIK4s7+p0YaG5XTYaEqq3EEFQ9DEhcJn2zrEqvRiSVXvaqR8w7C
 QBGKrMMWQ2kAe4MsFyfXaKvk/n7bgfQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-tsD9P4rkN_SvFg0dofkqRg-1; Fri,
 02 Oct 2026 06:16:09 -0400
X-MC-Unique: tsD9P4rkN_SvFg0dofkqRg-1
X-Mimecast-MFC-AGG-ID: tsD9P4rkN_SvFg0dofkqRg_1790936168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45AC51955D62; Fri,  2 Oct 2026 10:16:08 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D48D18002B6; Fri,  2 Oct 2026 10:16:07 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk v2 2/2] rib: add mode to include top-level route in
 traversal
Date: Fri,  2 Oct 2026 12:15:27 +0200
Message-ID: <20261002101523.383527-7-rjarry@redhat.com>
In-Reply-To: <20261002101523.383527-5-rjarry@redhat.com>
References: <20260518095900.29655-6-rjarry@redhat.com>
 <20261002101523.383527-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zMPjpNXLRTgx4xm46-ppQuX7A-oRYLzhyiVcbvmK5QI_1790936168
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
 app/test/test_rib.c                    | 16 ++++++++++++++++
 app/test/test_rib6.c                   | 16 ++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 lib/rib/rte_rib.c                      | 16 ++++++++++++----
 lib/rib/rte_rib.h                      |  5 +++++
 lib/rib/rte_rib6.c                     | 16 ++++++++++++----
 lib/rib/rte_rib6.h                     |  6 ++++++
 7 files changed, 73 insertions(+), 8 deletions(-)

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
index 0295a9640cfa..e97d2f49df1d 100644
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
+	while ((node = rte_rib6_get_nxt(rib, &unspec, 0, node, RTE_RIB6_GET_NXT_ALL)) != NULL)
+		num++;
+	RTE_TEST_ASSERT(num == 2, "Invalid number of routes\n");
+
+	num = 0;
+	node = NULL;
+	while ((node = rte_rib6_get_nxt(rib, &unspec, 0, node, RTE_RIB6_GET_NXT_ALL_TOP)) != NULL)
+		num++;
+	RTE_TEST_ASSERT(num == 3, "Default route not returned by rte_rib6_get_nxt\n");
+
 	rte_rib6_free(rib);
 
 	return TEST_SUCCESS;
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 030bd84cea04..5976db81157c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -138,6 +138,12 @@ New Features
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
   for a specific queue, complementing the existing device-level statistics API.
 
+* **Added a new mode for RIB and RIB6 traversal.**
+
+  ``rte_rib{,6}_get_nxt()`` now accept a new mode of traversal: ``RTE_RIB{,6}_GET_NXT_ALL_TOP``
+  which behaves like ``RTE_RIB{,6}_GET_NXT_ALL`` but also returns the top-level exact-match
+  route, if any.
+
 
 Removed Items
 -------------
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index c1dcb054d4e5..e15196f01954 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -167,6 +167,14 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	return __rib_lookup_exact(rib, ip, depth);
 }
 
+static bool
+depth_match(struct rte_rib_node *node, uint8_t depth, enum rte_rib_get_nxt_mode mode)
+{
+	if (mode == RTE_RIB_GET_NXT_ALL_TOP)
+		return node->depth >= depth;
+	return node->depth > depth;
+}
+
 /*
  *  Traverses on subtree and retrieves more specific routes
  *  for a given in args ip/depth prefix
@@ -194,16 +202,16 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 				(tmp->parent->right == NULL))) {
 			tmp = tmp->parent;
 			if (is_valid_node(tmp) &&
-					(is_covered(tmp->ip, ip, depth) &&
-					(tmp->depth > depth)))
+					is_covered(tmp->ip, ip, depth) &&
+					depth_match(tmp, depth, mode))
 				return tmp;
 		}
 		tmp = (tmp->parent) ? tmp->parent->right : NULL;
 	}
 	while (tmp) {
 		if (is_valid_node(tmp) &&
-				(is_covered(tmp->ip, ip, depth) &&
-				(tmp->depth > depth))) {
+				is_covered(tmp->ip, ip, depth) &&
+				depth_match(tmp, depth, mode)) {
 			prev = tmp;
 			if (mode == RTE_RIB_GET_NXT_COVER)
 				return prev;
diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
index bba9ad98823f..e23624ae39a0 100644
--- a/lib/rib/rte_rib.h
+++ b/lib/rib/rte_rib.h
@@ -31,6 +31,8 @@ enum rte_rib_get_nxt_mode {
 	RTE_RIB_GET_NXT_ALL,
 	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB_GET_NXT_COVER,
+	/** get all subroutes in a RIB tree, including the exact match top-level route, if any */
+	RTE_RIB_GET_NXT_ALL_TOP,
 };
 
 struct rte_rib;
@@ -125,6 +127,9 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
  *   get all prefixes from subtrie
  *  -RTE_RIB_GET_NXT_COVER
  *   get only first more specific prefix even if it have more specifics
+ *  -RTE_RIB_GET_NXT_ALL_TOP
+ *   get all prefixes from subtrie including the ip/depth prefix itself
+ *   if present. Top prefix is returned last.
  * @return
  *  pointer to the next more specific prefix
  *  NULL if there is no prefixes left
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 41561c4291e3..8384bc58cd63 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -187,6 +187,14 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
 	return NULL;
 }
 
+static bool
+depth_match(struct rte_rib6_node *node, uint8_t depth, enum rte_rib6_get_nxt_mode mode)
+{
+	if (mode == RTE_RIB6_GET_NXT_ALL_TOP)
+		return node->depth >= depth;
+	return node->depth > depth;
+}
+
 /*
  *  Traverses on subtree and retrieves more specific routes
  *  for a given in args ip/depth prefix
@@ -219,16 +227,16 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 				(tmp->parent->right == NULL))) {
 			tmp = tmp->parent;
 			if (is_valid_node(tmp) &&
-					(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
-					(tmp->depth > depth)))
+					rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
+					depth_match(tmp, depth, mode))
 				return tmp;
 		}
 		tmp = (tmp->parent != NULL) ? tmp->parent->right : NULL;
 	}
 	while (tmp) {
 		if (is_valid_node(tmp) &&
-				(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
-				(tmp->depth > depth))) {
+				rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
+				depth_match(tmp, depth, mode)) {
 			prev = tmp;
 			if (mode == RTE_RIB6_GET_NXT_COVER)
 				return prev;
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index 1a013e8fb4aa..a0a3ae98dc47 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -29,6 +29,8 @@ enum rte_rib6_get_nxt_mode {
 	RTE_RIB6_GET_NXT_ALL,
 	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB6_GET_NXT_COVER,
+	/** get all subroutes in a RIB tree, including the exact match top-level route, if any */
+	RTE_RIB6_GET_NXT_ALL_TOP,
 };
 
 struct rte_rib6;
@@ -110,6 +112,10 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
  *   get all prefixes from subtrie
  *  -RTE_RIB6_GET_NXT_COVER
  *   get only first more specific prefix even if it have more specifics
+ *  -RTE_RIB6_GET_NXT_ALL_TOP
+ *   get all prefixes from the subtrie, including the ip/depth prefix itself
+ *   if present. Top prefix is returned last.
+ *
  * @return
  *  pointer to the next more specific prefix
  *  NULL if there is no prefixes left
-- 
2.55.0

