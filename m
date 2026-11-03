Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA243606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=POz8HwSZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C1B542FA7;
	Tue,  3 Nov 2026 16:21:10 +0100 (CET)
Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
 by mails.dpdk.org (Postfix) with ESMTPS id C5DF342F6B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:21:08 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=xnVgMD9yrkqG3uQ2x9iD/G2/yg9Zg37QSoyekc44O6g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719268; v=1; x=1794324068;
 b=POz8HwSZJzkKhSoGVkDcJnV7XqYYSBTIj0o+kZY/SaeF5vS31oGTXr5GNviSYu5Ppo96ci/b
 w6YLBJKLj+m1o0uYFL7OYIVxMY2wpJZ+L4qQqYzlZ2/SJ1fWvqGP+05fVwInz0KynW2DFne2CjX
 fQ//wbUmOsfDZoihxJt6ZZnA=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 9a3fe15b7fb1d3a4;
 Tue, 03 Nov 2026 15:21:08 +0000
X-Mizu-Trace-ID: 9a3fe15b7fb1d3a4
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 179/227] app/test-crypto-perf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:17 +0800
Message-ID: <20261103145306.487255-180-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-crypto-perf/cperf_test_common.c |  6 +--
 app/test-crypto-perf/main.c              | 54 ++++++++++++------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index 0bcaa6dfd8..1e333163d5 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -155,11 +155,11 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 	if (cperf_is_asym_test(options)) {
 		crypto_op_size += sizeof(struct rte_crypto_asym_op);
 		snprintf(pool_name, RTE_MEMPOOL_NAMESIZE, "perf_asym_op_pool%u",
-			 rte_socket_id());
+			 rte_numa_id());
 		*pool = rte_crypto_op_pool_create(
 			pool_name, RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
 			options->pool_sz, RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
-			rte_socket_id());
+			rte_numa_id());
 		if (*pool == NULL) {
 			RTE_LOG(ERR, USER1,
 				"Cannot allocate mempool for device %u\n",
@@ -234,7 +234,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 
 	*pool = rte_mempool_create_empty(pool_name,
 			options->pool_sz, obj_size, 512, 0,
-			rte_socket_id(), 0);
+			rte_numa_id(), 0);
 	if (*pool == NULL) {
 		RTE_LOG(ERR, USER1,
 			"Cannot allocate mempool for device %u\n",
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index c4d844d225..6dfbd03c14 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -87,51 +87,51 @@ const struct cperf_test cperf_testmap[] = {
 };
 
 static int
-create_asym_op_pool_socket(int32_t socket_id, uint32_t nb_sessions)
+create_asym_op_pool_socket(int32_t numa_id, uint32_t nb_sessions)
 {
 	char mp_name[RTE_MEMPOOL_NAMESIZE];
 	struct rte_mempool *mpool = NULL;
 
-	if (session_pool_socket[socket_id].sess_mp == NULL) {
+	if (session_pool_socket[numa_id].sess_mp == NULL) {
 		snprintf(mp_name, RTE_MEMPOOL_NAMESIZE, "perf_asym_sess_pool%u",
-			 socket_id);
+			 numa_id);
 		mpool = rte_cryptodev_asym_session_pool_create(mp_name,
-				nb_sessions, 0, 0, socket_id);
+				nb_sessions, 0, 0, numa_id);
 		if (mpool == NULL) {
 			printf("Cannot create pool \"%s\" on socket %d\n",
-			       mp_name, socket_id);
+			       mp_name, numa_id);
 			return -ENOMEM;
 		}
-		session_pool_socket[socket_id].sess_mp = mpool;
+		session_pool_socket[numa_id].sess_mp = mpool;
 	}
 	return 0;
 }
 
 static int
-fill_session_pool_socket(int32_t socket_id, uint32_t session_priv_size,
+fill_session_pool_socket(int32_t numa_id, uint32_t session_priv_size,
 		uint32_t nb_sessions)
 {
 	char mp_name[RTE_MEMPOOL_NAMESIZE];
 	struct rte_mempool *sess_mp;
 
-	if (session_pool_socket[socket_id].sess_mp == NULL) {
+	if (session_pool_socket[numa_id].sess_mp == NULL) {
 
 		snprintf(mp_name, RTE_MEMPOOL_NAMESIZE,
-			"sess_mp_%u", socket_id);
+			"sess_mp_%u", numa_id);
 
 		sess_mp = rte_cryptodev_sym_session_pool_create(mp_name,
 					nb_sessions, session_priv_size, 0, 0,
-					socket_id);
+					numa_id);
 
 		if (sess_mp == NULL) {
 			printf("Cannot create pool \"%s\" on socket %d\n",
-				mp_name, socket_id);
+				mp_name, numa_id);
 			return -ENOMEM;
 		}
 
 		printf("Allocated pool \"%s\" on socket %d\n",
-			mp_name, socket_id);
-		session_pool_socket[socket_id].sess_mp = sess_mp;
+			mp_name, numa_id);
+		session_pool_socket[numa_id].sess_mp = sess_mp;
 	}
 
 	return 0;
@@ -211,11 +211,11 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 #endif
 
 		struct rte_cryptodev_info cdev_info;
-		int socket_id = rte_cryptodev_socket_id(cdev_id);
+		int numa_id = rte_cryptodev_numa_id(cdev_id);
 
-		/* Use the first socket if SOCKET_ID_ANY is returned. */
-		if (socket_id == SOCKET_ID_ANY)
-			socket_id = 0;
+		/* Use the first socket if RTE_NUMA_ID_ANY is returned. */
+		if (numa_id == RTE_NUMA_ID_ANY)
+			numa_id = 0;
 
 		rte_cryptodev_info_get(cdev_id, &cdev_info);
 
@@ -235,7 +235,7 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 		}
 		struct rte_cryptodev_config conf = {
 			.nb_queue_pairs = opts->nb_qps,
-			.socket_id = socket_id,
+			.numa_id = numa_id,
 		};
 
 		switch (opts->op_type) {
@@ -317,15 +317,15 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 		}
 
 		if (cperf_is_asym_test(opts))
-			ret = create_asym_op_pool_socket(socket_id,
+			ret = create_asym_op_pool_socket(numa_id,
 							 sessions_needed);
 		else
-			ret = fill_session_pool_socket(socket_id, max_sess_size,
+			ret = fill_session_pool_socket(numa_id, max_sess_size,
 						       sessions_needed);
 		if (ret < 0)
 			return ret;
 
-		qp_conf.mp_session = session_pool_socket[socket_id].sess_mp;
+		qp_conf.mp_session = session_pool_socket[numa_id].sess_mp;
 
 		if (cperf_is_asym_test(opts))
 			qp_conf.mp_session = NULL;
@@ -341,7 +341,7 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 				qp_conf.priority = RTE_CRYPTODEV_QP_PRIORITY_LOWEST;
 
 			ret = rte_cryptodev_queue_pair_setup(cdev_id, j,
-				&qp_conf, socket_id);
+				&qp_conf, numa_id);
 			if (ret < 0) {
 				printf("Failed to setup queue pair %u on "
 					"cryptodev %u",	j, cdev_id);
@@ -846,14 +846,14 @@ main(int argc, char **argv)
 
 		cdev_id = enabled_cdevs[cdev_index];
 
-		int socket_id = rte_cryptodev_socket_id(cdev_id);
+		int numa_id = rte_cryptodev_numa_id(cdev_id);
 
-		/* Use the first socket if SOCKET_ID_ANY is returned. */
-		if (socket_id == SOCKET_ID_ANY)
-			socket_id = 0;
+		/* Use the first socket if RTE_NUMA_ID_ANY is returned. */
+		if (numa_id == RTE_NUMA_ID_ANY)
+			numa_id = 0;
 
 		ctx[i] = cperf_testmap[opts.test].constructor(
-				session_pool_socket[socket_id].sess_mp,
+				session_pool_socket[numa_id].sess_mp,
 				cdev_id, qp_id,
 				&opts, t_vec, &op_fns, &sess);
 
-- 
2.55.0

