Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79083606A79C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xMOUKSCP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABFB842FC7;
	Tue,  3 Nov 2026 16:23:06 +0100 (CET)
Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 4847342FC7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:23:05 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=IZi/E95BVtoWAEjKn5yQ1Pda+ydHk87xsEm01hv0KAM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719385; v=1; x=1794324185;
 b=xMOUKSCPSxXgi5KAVYirH4MritPoSdcx363YGi9/0MwnB6Ygu5kIlL2bX5tD9k3CKsM7MUHn
 PygvGNir8+g7jFL2ANOpGzYDb6Kn7zH08QiZMQtCwXd+tBs0BK82FT9vmH/phWzXYvldZlnECeG
 GoCMORwBNjPtXyvTx1Qxl/9Q=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id f86afade03f7b0d6;
 Tue, 03 Nov 2026 15:23:04 +0000
X-Mizu-Trace-ID: f86afade03f7b0d6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 190/227] examples/fips_validation: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:28 +0800
Message-ID: <20261103145306.487255-191-chengwen.feng@linux.dev>
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
 examples/fips_validation/fips_dev_self_test.c | 10 +++++-----
 examples/fips_validation/main.c               | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/examples/fips_validation/fips_dev_self_test.c b/examples/fips_validation/fips_dev_self_test.c
index 667f5da4e7..5807b4ac90 100644
--- a/examples/fips_validation/fips_dev_self_test.c
+++ b/examples/fips_validation/fips_dev_self_test.c
@@ -1533,7 +1533,7 @@ fips_dev_auto_test_init(uint8_t dev_id, struct fips_dev_auto_test_env *env)
 	char name[128];
 	int ret;
 
-	conf.socket_id = rte_cryptodev_socket_id(dev_id);
+	conf.numa_id = rte_cryptodev_numa_id(dev_id);
 	conf.nb_queue_pairs = 1;
 	conf.ff_disable = 0;
 
@@ -1547,7 +1547,7 @@ fips_dev_auto_test_init(uint8_t dev_id, struct fips_dev_auto_test_env *env)
 	memset(env, 0, sizeof(*env));
 
 	env->mpool = rte_pktmbuf_pool_create(name, 128, 0, 0,
-			UINT16_MAX, rte_cryptodev_socket_id(dev_id));
+			UINT16_MAX, rte_cryptodev_numa_id(dev_id));
 	if (!env->mpool) {
 		ret = -ENOMEM;
 		goto error_exit;
@@ -1561,7 +1561,7 @@ fips_dev_auto_test_init(uint8_t dev_id, struct fips_dev_auto_test_env *env)
 			RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 			16, 0,
 			16,
-			rte_socket_id());
+			rte_numa_id());
 	if (!env->op_pool) {
 		ret = -ENOMEM;
 		goto error_exit;
@@ -1571,7 +1571,7 @@ fips_dev_auto_test_init(uint8_t dev_id, struct fips_dev_auto_test_env *env)
 	snprintf(name, 128, "%s%u", "SELF_TEST_SESS_POOL", dev_id);
 
 	env->sess_pool = rte_cryptodev_sym_session_pool_create(name,
-			128, sess_sz, 0, 0, rte_cryptodev_socket_id(dev_id));
+			128, sess_sz, 0, 0, rte_cryptodev_numa_id(dev_id));
 	if (!env->sess_pool) {
 		ret = -ENOMEM;
 		goto error_exit;
@@ -1580,7 +1580,7 @@ fips_dev_auto_test_init(uint8_t dev_id, struct fips_dev_auto_test_env *env)
 	qp_conf.mp_session = env->sess_pool;
 
 	ret = rte_cryptodev_queue_pair_setup(dev_id, 0, &qp_conf,
-			rte_cryptodev_socket_id(dev_id));
+			rte_cryptodev_numa_id(dev_id));
 	if (ret < 0)
 		goto error_exit;
 
diff --git a/examples/fips_validation/main.c b/examples/fips_validation/main.c
index 2b6d55aa51..f17062f8b9 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -95,7 +95,7 @@ cryptodev_fips_validate_app_sym_init(void)
 
 	ret = -ENOMEM;
 	sym->sess_mpool = rte_cryptodev_sym_session_pool_create(
-			"FIPS_SYM_SESS_MEMPOOL", 16, sess_sz, 0, 0, rte_socket_id());
+			"FIPS_SYM_SESS_MEMPOOL", 16, sess_sz, 0, 0, rte_numa_id());
 	if (!sym->sess_mpool)
 		goto error_exit;
 
@@ -104,7 +104,7 @@ cryptodev_fips_validate_app_sym_init(void)
 			RTE_CRYPTO_OP_TYPE_SYMMETRIC,
 			1, 0,
 			16,
-			rte_socket_id());
+			rte_numa_id());
 	if (!sym->op_pool)
 		goto error_exit;
 
@@ -140,7 +140,7 @@ cryptodev_fips_validate_app_asym_init(void)
 
 	ret = -ENOMEM;
 	asym->sess_mpool = rte_cryptodev_asym_session_pool_create(
-			"FIPS_ASYM_SESS_MEMPOOL", 16, 0, 0, rte_socket_id());
+			"FIPS_ASYM_SESS_MEMPOOL", 16, 0, 0, rte_numa_id());
 	if (!asym->sess_mpool)
 		goto error_exit;
 
@@ -149,7 +149,7 @@ cryptodev_fips_validate_app_asym_init(void)
 			RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
 			1, 0,
 			16,
-			rte_socket_id());
+			rte_numa_id());
 	if (!asym->op_pool)
 		goto error_exit;
 
@@ -179,7 +179,7 @@ cryptodev_fips_validate_app_asym_uninit(void)
 static int
 cryptodev_fips_validate_app_init(void)
 {
-	struct rte_cryptodev_config conf = {rte_socket_id(), 1, 0};
+	struct rte_cryptodev_config conf = {rte_numa_id(), 1, 0};
 	struct rte_cryptodev_qp_conf qp_conf = {128, NULL};
 	uint32_t nb_mbufs = UINT16_MAX / env.mbuf_data_room + 1;
 	int ret;
@@ -201,7 +201,7 @@ cryptodev_fips_validate_app_init(void)
 	ret = -ENOMEM;
 	env.mpool = rte_pktmbuf_pool_create("FIPS_MEMPOOL", nb_mbufs,
 			0, 0, sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM +
-			env.mbuf_data_room, rte_socket_id());
+			env.mbuf_data_room, rte_numa_id());
 	if (!env.mpool)
 		return ret;
 
@@ -218,7 +218,7 @@ cryptodev_fips_validate_app_init(void)
 	qp_conf.mp_session = env.sym.sess_mpool;
 
 	ret = rte_cryptodev_queue_pair_setup(env.dev_id, 0, &qp_conf,
-			rte_socket_id());
+			rte_numa_id());
 	if (ret < 0)
 		goto error_exit;
 
-- 
2.55.0

