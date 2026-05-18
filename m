Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF85CD4F52
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 08:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61DE2402D9;
	Mon, 18 May 2026 10:40:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4D9BD40265
 for <dev@dpdk.org>; Mon, 18 May 2026 10:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779093601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pwBCFVjLKj3fmDB0vT4Y6nS5qIP1zJgagxt5qUZsXdM=;
 b=O98S23on1V5GU/eReebVbSLw8+ELpGcI4OB77lZQA7/QJqFWZwrRGNoXQWHcaZHQvCbrs5
 L5caSG9pDcUtAnRY+7Pf8EAVZmE3ho6O9NtMPphzHk7P1g6SlXPW2EmA1VFiI7+ylgc3SF
 SQ16hzJUzjErfBJfj46jy8pbp9g041I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-jzlE8WrtOOWqvXERIoNQdA-1; Mon,
 18 May 2026 04:40:00 -0400
X-MC-Unique: jzlE8WrtOOWqvXERIoNQdA-1
X-Mimecast-MFC-AGG-ID: jzlE8WrtOOWqvXERIoNQdA_1779093599
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04DB619560BB; Mon, 18 May 2026 08:39:59 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.17])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EB8618004A3; Mon, 18 May 2026 08:39:57 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk] fib,rib: implement full network order support for IPv4
Date: Mon, 18 May 2026 10:39:37 +0200
Message-ID: <20260518083935.15173-3-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vQlyFktTm4eJ06_fDg9zGKO7oPwghu_K-XsJf4EHpRI_1779093599
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

Control plane stacks deal exclusively with network byte order addresses.
The existing RTE_FIB_F_LOOKUP_NETWORK_ORDER flag only covers datapath
lookups, forcing callers to convert every address back and forth when
adding or deleting routes.

Rename RTE_FIB_F_LOOKUP_NETWORK_ORDER to RTE_FIB_F_NETWORK_ORDER (keep
the old name with a deprecation notice) and add a new opt-in flag:
RTE_RIB_F_NETWORK_ORDER.

When these flags are specified, *all* user-facing IPv4 functions accept
and return addresses in network byte order. Internally, both libraries
keep operating in host order; the conversion happens at the public API
boundary only.

For rte_rib, a per-node flag bit tracks whether rte_rib_get_ip()
should convert back to network order, since that function does not
take a rib pointer.

When creating a FIB with RTE_FIB_F_NETWORK_ORDER, make sure that its
internal RIB object has the corresponding RTE_RIB_F_NETWORK_ORDER.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_fib.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 app/test/test_rib.c | 59 +++++++++++++++++++++++++++++++++
 lib/fib/dir24_8.c   | 29 ++++++++++++----
 lib/fib/dir24_8.h   |  1 +
 lib/fib/rte_fib.c   |  6 ++--
 lib/fib/rte_fib.h   |  8 +++--
 lib/rib/rte_rib.c   | 74 +++++++++++++++++++++++++++++++----------
 lib/rib/rte_rib.h   |  5 +++
 8 files changed, 233 insertions(+), 29 deletions(-)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d565c..84b57eef3b5a 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -7,6 +7,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 
+#include <rte_byteorder.h>
 #include <rte_ip.h>
 #include <rte_log.h>
 #include <rte_fib.h>
@@ -24,6 +25,7 @@ static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
+static int32_t test_network_order(void);
 
 #define MAX_ROUTES	(1 << 16)
 #define MAX_TBL8	(1 << 15)
@@ -588,6 +590,83 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+int32_t
+test_network_order(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint32_t ip_he = RTE_IPV4(192, 0, 2, 0);
+	uint32_t ip_be = rte_cpu_to_be_32(ip_he);
+	uint32_t ip_miss_be = rte_cpu_to_be_32(RTE_IPV4(10, 0, 0, 1));
+	uint64_t def_nh = 100;
+	uint64_t nh_set = 42;
+	uint64_t nh_arr[3];
+	uint32_t ip_arr[3];
+	int ret;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB_DUMMY;
+	config.flags = RTE_FIB_F_NETWORK_ORDER;
+
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib_add(fib, ip_be, 24, nh_set);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route\n");
+
+	ip_arr[0] = ip_be;
+	ip_arr[1] = rte_cpu_to_be_32(RTE_IPV4(192, 0, 2, 123));
+	ip_arr[2] = ip_miss_be;
+
+	ret = rte_fib_lookup_bulk(fib, ip_arr, nh_arr, 3);
+	RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
+	RTE_TEST_ASSERT(nh_arr[0] == nh_set,
+		"Failed to get proper nexthop for prefix\n");
+	RTE_TEST_ASSERT(nh_arr[1] == nh_set,
+		"Failed to get proper nexthop for covered IP\n");
+	RTE_TEST_ASSERT(nh_arr[2] == def_nh,
+		"Failed to get default nexthop for missing IP\n");
+
+	ret = rte_fib_delete(fib, ip_be, 24);
+	RTE_TEST_ASSERT(ret == 0, "Failed to delete route\n");
+
+	ret = rte_fib_lookup_bulk(fib, ip_arr, nh_arr, 1);
+	RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
+	RTE_TEST_ASSERT(nh_arr[0] == def_nh,
+		"Failed to get default nexthop after delete\n");
+
+	rte_fib_free(fib);
+
+	/* repeat with DIR24_8 */
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create DIR24_8 FIB\n");
+
+	ret = rte_fib_add(fib, ip_be, 24, nh_set);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route\n");
+
+	ret = rte_fib_lookup_bulk(fib, ip_arr, nh_arr, 3);
+	RTE_TEST_ASSERT(ret == 0, "Failed to lookup\n");
+	RTE_TEST_ASSERT(nh_arr[0] == nh_set,
+		"Failed to get proper nexthop for prefix\n");
+	RTE_TEST_ASSERT(nh_arr[1] == nh_set,
+		"Failed to get proper nexthop for covered IP\n");
+	RTE_TEST_ASSERT(nh_arr[2] == def_nh,
+		"Failed to get default nexthop for missing IP\n");
+
+	ret = rte_fib_delete(fib, ip_be, 24);
+	RTE_TEST_ASSERT(ret == 0, "Failed to delete route\n");
+
+	rte_fib_free(fib);
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib_fast_tests = {
 	.suite_name = "fib autotest",
 	.setup = NULL,
@@ -600,6 +679,7 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_lookup),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
+	TEST_CASE(test_network_order),
 	TEST_CASES_END()
 	}
 };
diff --git a/app/test/test_rib.c b/app/test/test_rib.c
index a4a683140df3..200533e84e09 100644
--- a/app/test/test_rib.c
+++ b/app/test/test_rib.c
@@ -21,6 +21,7 @@ static int32_t test_insert_invalid(void);
 static int32_t test_get_fn(void);
 static int32_t test_basic(void);
 static int32_t test_tree_traversal(void);
+static int32_t test_network_order(void);
 
 #define MAX_DEPTH 32
 #define MAX_RULES (1 << 22)
@@ -323,6 +324,63 @@ test_tree_traversal(void)
 	return TEST_SUCCESS;
 }
 
+int32_t
+test_network_order(void)
+{
+	struct rte_rib *rib = NULL;
+	struct rte_rib_node *node;
+	struct rte_rib_conf config;
+
+	uint32_t ip_he = RTE_IPV4(192, 0, 2, 0);
+	uint32_t ip_be = rte_cpu_to_be_32(ip_he);
+	uint32_t ip_ret;
+	uint64_t nh_set = 42;
+	uint64_t nh_ret;
+	uint8_t depth = 24;
+	int ret;
+
+	config.max_nodes = MAX_RULES;
+	config.ext_sz = 0;
+	config.flags = RTE_RIB_F_NETWORK_ORDER;
+
+	rib = rte_rib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(rib != NULL, "Failed to create RIB\n");
+
+	node = rte_rib_insert(rib, ip_be, depth);
+	RTE_TEST_ASSERT(node != NULL, "Failed to insert rule\n");
+
+	ret = rte_rib_set_nh(node, nh_set);
+	RTE_TEST_ASSERT(ret == 0, "Failed to set nh\n");
+
+	/* lookup with network-order IP */
+	node = rte_rib_lookup(rib, ip_be);
+	RTE_TEST_ASSERT(node != NULL, "Failed to lookup\n");
+
+	ret = rte_rib_get_nh(node, &nh_ret);
+	RTE_TEST_ASSERT((ret == 0) && (nh_ret == nh_set),
+		"Failed to get proper nexthop\n");
+
+	/* get_ip must return network-order IP */
+	ret = rte_rib_get_ip(node, &ip_ret);
+	RTE_TEST_ASSERT((ret == 0) && (ip_ret == ip_be),
+		"Failed to get proper IP in network order\n");
+
+	/* exact lookup with network-order IP */
+	node = rte_rib_lookup_exact(rib, ip_be, depth);
+	RTE_TEST_ASSERT(node != NULL, "Failed to exact lookup\n");
+
+	/* remove with network-order IP */
+	rte_rib_remove(rib, ip_be, depth);
+
+	node = rte_rib_lookup(rib, ip_be);
+	RTE_TEST_ASSERT(node == NULL,
+		"Lookup returns non existent rule\n");
+
+	rte_rib_free(rib);
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite rib_tests = {
 	.suite_name = "rib autotest",
 	.setup = NULL,
@@ -334,6 +392,7 @@ static struct unit_test_suite rib_tests = {
 		TEST_CASE(test_get_fn),
 		TEST_CASE(test_basic),
 		TEST_CASE(test_tree_traversal),
+		TEST_CASE(test_network_order),
 		TEST_CASES_END()
 	}
 };
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 489d2ef427c6..781ecbe9e64e 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -414,24 +414,33 @@ install_to_fib(struct dir24_8_tbl *dp, uint32_t ledge, uint32_t redge,
 	return 0;
 }
 
+/*
+ * modify_fib operates in host byte order. When the RIB carries the
+ * network-order flag, rte_rib_get_nxt/rte_rib_get_ip return addresses
+ * in network order, so this helper converts them back to host order
+ * for DIR24_8 table operations.
+ */
 static int
 modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 	uint8_t depth, uint64_t next_hop)
 {
 	struct rte_rib_node *tmp = NULL;
 	uint32_t ledge, redge, tmp_ip;
+	uint32_t rib_ip = dp->be_addr ? rte_cpu_to_be_32(ip) : ip;
 	int ret;
 	uint8_t tmp_depth;
 
 	ledge = ip;
 	do {
-		tmp = rte_rib_get_nxt(rib, ip, depth, tmp,
+		tmp = rte_rib_get_nxt(rib, rib_ip, depth, tmp,
 			RTE_RIB_GET_NXT_COVER);
 		if (tmp != NULL) {
 			rte_rib_get_depth(tmp, &tmp_depth);
 			if (tmp_depth == depth)
 				continue;
 			rte_rib_get_ip(tmp, &tmp_ip);
+			if (dp->be_addr)
+				tmp_ip = rte_be_to_cpu_32(tmp_ip);
 			redge = tmp_ip & rte_rib_depth_to_mask(tmp_depth);
 			if (ledge == redge) {
 				ledge = redge +
@@ -475,6 +484,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 	struct rte_rib_node *parent;
 	int ret = 0;
 	uint64_t par_nh, node_nh;
+	uint32_t ip_he;
 
 	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
 		return -EINVAL;
@@ -486,7 +496,13 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 	if (next_hop > get_max_nh(dp->nh_sz))
 		return -EINVAL;
 
-	ip &= rte_rib_depth_to_mask(depth);
+	/*
+	 * The RIB API handles byte order conversion when the
+	 * network-order flag is set. DIR24_8 table operations
+	 * require host-order addresses.
+	 */
+	ip_he = dp->be_addr ? rte_be_to_cpu_32(ip) : ip;
+	ip_he &= rte_rib_depth_to_mask(depth);
 
 	node = rte_rib_lookup_exact(rib, ip, depth);
 	switch (op) {
@@ -495,7 +511,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			rte_rib_get_nh(node, &node_nh);
 			if (node_nh == next_hop)
 				return 0;
-			ret = modify_fib(dp, rib, ip, depth, next_hop);
+			ret = modify_fib(dp, rib, ip_he, depth, next_hop);
 			if (ret == 0)
 				rte_rib_set_nh(node, next_hop);
 			return 0;
@@ -518,7 +534,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			if (par_nh == next_hop)
 				goto successfully_added;
 		}
-		ret = modify_fib(dp, rib, ip, depth, next_hop);
+		ret = modify_fib(dp, rib, ip_he, depth, next_hop);
 		if (ret != 0) {
 			rte_rib_remove(rib, ip, depth);
 			return ret;
@@ -536,9 +552,9 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 			rte_rib_get_nh(parent, &par_nh);
 			rte_rib_get_nh(node, &node_nh);
 			if (par_nh != node_nh)
-				ret = modify_fib(dp, rib, ip, depth, par_nh);
+				ret = modify_fib(dp, rib, ip_he, depth, par_nh);
 		} else
-			ret = modify_fib(dp, rib, ip, depth, dp->def_nh);
+			ret = modify_fib(dp, rib, ip_he, depth, dp->def_nh);
 		if (ret == 0) {
 			rte_rib_remove(rib, ip, depth);
 			if (depth > 24) {
@@ -606,6 +622,7 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	dp->def_nh = def_nh;
 	dp->nh_sz = nh_sz;
 	dp->number_tbl8s = num_tbl8;
+	dp->be_addr = !!(fib_conf->flags & RTE_FIB_F_NETWORK_ORDER);
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
 	dp->tbl8_idxes = rte_zmalloc_socket(mem_name,
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d6866d..d4fa248cfb88 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -33,6 +33,7 @@ struct dir24_8_tbl {
 	uint32_t	rsvd_tbl8s;	/**< Number of reserved tbl8s */
 	uint32_t	cur_tbl8s;	/**< Current number of tbl8s */
 	enum rte_fib_dir24_8_nh_sz	nh_sz;	/**< Size of nexthop entry */
+	bool		be_addr;	/**< User addresses in network order */
 	/* RCU config. */
 	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
 	struct rte_rcu_qsbr *v;		/* RCU QSBR variable. */
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f38070..3e4c15cfc809 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -109,7 +109,7 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 		if (fib->dp == NULL)
 			return -rte_errno;
 		fib->lookup = dir24_8_get_lookup_fn(fib->dp,
-			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_NETWORK_ORDER));
 		fib->modify = dir24_8_modify;
 		return 0;
 	default:
@@ -172,6 +172,8 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
+	rib_conf.flags = (conf->flags & RTE_FIB_F_NETWORK_ORDER) ?
+		RTE_RIB_F_NETWORK_ORDER : 0;
 
 	rib = rte_rib_create(name, socket_id, &rib_conf);
 	if (rib == NULL) {
@@ -340,7 +342,7 @@ rte_fib_select_lookup(struct rte_fib *fib,
 	switch (fib->type) {
 	case RTE_FIB_DIR24_8:
 		fn = dir24_8_get_lookup_fn(fib->dp, type,
-			!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+			!!(fib->flags & RTE_FIB_F_NETWORK_ORDER));
 		if (fn == NULL)
 			return -EINVAL;
 		fib->lookup = fn;
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535cf..5542e735b6f3 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -91,9 +91,11 @@ enum rte_fib_lookup_type {
 	/**< Vector implementation using AVX512 */
 };
 
-/** If set, fib lookup is expecting IPv4 address in network byte order */
-#define RTE_FIB_F_LOOKUP_NETWORK_ORDER 1
-#define RTE_FIB_ALLOWED_FLAGS (RTE_FIB_F_LOOKUP_NETWORK_ORDER)
+/** If set, all user-facing IPv4 addresses are in network byte order */
+#define RTE_FIB_F_NETWORK_ORDER 1
+#define RTE_FIB_F_LOOKUP_NETWORK_ORDER \
+	(RTE_DEPRECATED(RTE_FIB_F_LOOKUP_NETWORK_ORDER) RTE_FIB_F_NETWORK_ORDER)
+#define RTE_FIB_ALLOWED_FLAGS (RTE_FIB_F_NETWORK_ORDER)
 
 /** FIB configuration structure */
 struct rte_fib_conf {
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca00..c6dbe684d211 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -8,6 +8,7 @@
 #include <sys/queue.h>
 
 #include <eal_export.h>
+#include <rte_byteorder.h>
 #include <rte_eal_memconfig.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
@@ -28,6 +29,8 @@ static struct rte_tailq_elem rte_rib_tailq = {
 EAL_REGISTER_TAILQ(rte_rib_tailq)
 
 #define RTE_RIB_VALID_NODE	1
+#define RIB_NODE_NET_ORDER	2
+#define RTE_RIB_ALLOWED_FLAGS	(RTE_RIB_F_NETWORK_ORDER)
 /* Maximum depth value possible for IPv4 RIB. */
 #define RIB_MAXDEPTH		32
 /* Maximum length of a RIB name. */
@@ -51,6 +54,7 @@ struct rte_rib {
 	uint32_t		cur_nodes;
 	uint32_t		cur_routes;
 	uint32_t		max_nodes;
+	unsigned int		flags;
 };
 
 static inline bool
@@ -112,6 +116,8 @@ rte_rib_lookup(struct rte_rib *rib, uint32_t ip)
 		rte_errno = EINVAL;
 		return NULL;
 	}
+	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
+		ip = rte_be_to_cpu_32(ip);
 
 	cur = rib->tree;
 	while ((cur != NULL) && is_covered(ip, cur->ip, cur->depth)) {
@@ -162,6 +168,8 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 		rte_errno = EINVAL;
 		return NULL;
 	}
+	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
+		ip = rte_be_to_cpu_32(ip);
 	ip &= rte_rib_depth_to_mask(depth);
 
 	return __rib_lookup_exact(rib, ip, depth);
@@ -172,18 +180,12 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
  *  for a given in args ip/depth prefix
  *  last = NULL means the first invocation
  */
-RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
-struct rte_rib_node *
-rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
+static struct rte_rib_node *
+__rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	uint8_t depth, struct rte_rib_node *last, int flag)
 {
 	struct rte_rib_node *tmp, *prev = NULL;
 
-	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH)) {
-		rte_errno = EINVAL;
-		return NULL;
-	}
-
 	if (last == NULL) {
 		tmp = rib->tree;
 		while ((tmp) && (tmp->depth < depth))
@@ -213,13 +215,28 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	return prev;
 }
 
-RTE_EXPORT_SYMBOL(rte_rib_remove)
-void
-rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
+RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
+struct rte_rib_node *
+rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
+	uint8_t depth, struct rte_rib_node *last, int flag)
+{
+	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
+		ip = rte_be_to_cpu_32(ip);
+
+	return __rib_get_nxt(rib, ip, depth, last, flag);
+}
+
+static void
+__rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
 	struct rte_rib_node *cur, *prev, *child;
 
-	cur = rte_rib_lookup_exact(rib, ip, depth);
+	ip &= rte_rib_depth_to_mask(depth);
+	cur = __rib_lookup_exact(rib, ip, depth);
 	if (cur == NULL)
 		return;
 
@@ -246,6 +263,17 @@ rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_remove)
+void
+rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
+{
+	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH))
+		return;
+	if (rib->flags & RTE_RIB_F_NETWORK_ORDER)
+		ip = rte_be_to_cpu_32(ip);
+	__rib_remove(rib, ip, depth);
+}
+
 RTE_EXPORT_SYMBOL(rte_rib_insert)
 struct rte_rib_node *
 rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
@@ -257,12 +285,18 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	int d = 0;
 	uint32_t common_prefix;
 	uint8_t common_depth;
+	uint8_t net_order = 0;
 
 	if (unlikely(rib == NULL || depth > RIB_MAXDEPTH)) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
 
+	if (rib->flags & RTE_RIB_F_NETWORK_ORDER) {
+		ip = rte_be_to_cpu_32(ip);
+		net_order = RIB_NODE_NET_ORDER;
+	}
+
 	tmp = &rib->tree;
 	ip &= rte_rib_depth_to_mask(depth);
 	new_node = __rib_lookup_exact(rib, ip, depth);
@@ -281,7 +315,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	new_node->parent = NULL;
 	new_node->ip = ip;
 	new_node->depth = depth;
-	new_node->flag = RTE_RIB_VALID_NODE;
+	new_node->flag = RTE_RIB_VALID_NODE | net_order;
 
 	/* traverse down the tree to find matching node or closest matching */
 	while (1) {
@@ -300,7 +334,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 		 */
 		if ((ip == (*tmp)->ip) && (depth == (*tmp)->depth)) {
 			node_free(rib, new_node);
-			(*tmp)->flag |= RTE_RIB_VALID_NODE;
+			(*tmp)->flag |= RTE_RIB_VALID_NODE | net_order;
 			++rib->cur_routes;
 			return *tmp;
 		}
@@ -336,7 +370,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 		}
 		common_node->ip = common_prefix;
 		common_node->depth = common_depth;
-		common_node->flag = 0;
+		common_node->flag = net_order;
 		common_node->parent = (*tmp)->parent;
 		new_node->parent = common_node;
 		(*tmp)->parent = common_node;
@@ -362,6 +396,8 @@ rte_rib_get_ip(const struct rte_rib_node *node, uint32_t *ip)
 		return -1;
 	}
 	*ip = node->ip;
+	if (node->flag & RIB_NODE_NET_ORDER)
+		*ip = rte_cpu_to_be_32(*ip);
 	return 0;
 }
 
@@ -419,7 +455,8 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	struct rte_mempool *node_pool;
 
 	/* Check user arguments. */
-	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
+	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0 ||
+			(conf->flags & ~RTE_RIB_ALLOWED_FLAGS))) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -473,6 +510,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	rte_strlcpy(rib->name, name, sizeof(rib->name));
 	rib->tree = NULL;
 	rib->max_nodes = conf->max_nodes;
+	rib->flags = conf->flags;
 	rib->node_pool = node_pool;
 	te->data = (void *)rib;
 	TAILQ_INSERT_TAIL(rib_list, te, next);
@@ -541,9 +579,9 @@ rte_rib_free(struct rte_rib *rib)
 
 	rte_mcfg_tailq_write_unlock();
 
-	while ((tmp = rte_rib_get_nxt(rib, 0, 0, tmp,
+	while ((tmp = __rib_get_nxt(rib, 0, 0, tmp,
 			RTE_RIB_GET_NXT_ALL)) != NULL)
-		rte_rib_remove(rib, tmp->ip, tmp->depth);
+		__rib_remove(rib, tmp->ip, tmp->depth);
 
 	rte_mempool_free(rib->node_pool);
 	rte_free(rib);
diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
index c325b3e3618c..085e507508be 100644
--- a/lib/rib/rte_rib.h
+++ b/lib/rib/rte_rib.h
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 
+#include <rte_byteorder.h>
 #include <rte_common.h>
 
 #ifdef __cplusplus
@@ -36,6 +37,9 @@ enum {
 struct rte_rib;
 struct rte_rib_node;
 
+/** If set, all user-facing IPv4 addresses are in network byte order */
+#define RTE_RIB_F_NETWORK_ORDER 1
+
 /** RIB configuration structure */
 struct rte_rib_conf {
 	/**
@@ -46,6 +50,7 @@ struct rte_rib_conf {
 	size_t	ext_sz;
 	/* size of rte_rib_node's pool */
 	int	max_nodes;
+	unsigned int flags; /**< Optional feature flags from RTE_RIB_F_* */
 };
 
 /**
-- 
2.54.0

