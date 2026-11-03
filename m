Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB1606A7B7
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dwjnJokJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9417542FD1;
	Tue,  3 Nov 2026 16:21:53 +0100 (CET)
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
 by mails.dpdk.org (Postfix) with ESMTPS id B082342FD5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:21:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=btmZebftc+/ae++7pOYULfcirw31tcb+9kJt98WQ/8c=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719312; v=1; x=1794324112;
 b=dwjnJokJu2GamEYTctjKsuS9Pd98QEWEvsL8t1laKqM3SHW/G3R7DbRyClChlX5388W32ZMN
 uDFI69lAXydLiCQNwclOC2C/3QCNaGX0E5pegRytKKfbtV5tQ9DkHcWhdSYNCrmhyqr05MmNTMF
 yvU8thvkSor5t1gjv8Mk4ZTQ=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 3593c953ff50bf4e;
 Tue, 03 Nov 2026 15:21:52 +0000
X-Mizu-Trace-ID: 3593c953ff50bf4e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 181/227] app/test-security-perf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:19 +0800
Message-ID: <20261103145306.487255-182-chengwen.feng@linux.dev>
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
 app/test-security-perf/test_security_perf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/app/test-security-perf/test_security_perf.c b/app/test-security-perf/test_security_perf.c
index dd377a6027..bebcdf922a 100644
--- a/app/test-security-perf/test_security_perf.c
+++ b/app/test-security-perf/test_security_perf.c
@@ -58,7 +58,7 @@ cryptodev_init(struct test_ctx *ctx, uint8_t nb_lcores)
 	struct rte_cryptodev_info dev_info;
 	struct rte_cryptodev_config config;
 	unsigned int j, nb_qp, qps_reqd;
-	uint8_t socket_id;
+	uint8_t numa_id;
 	uint32_t dev_cnt;
 	int ret, core_id;
 	void *sec_ctx;
@@ -86,7 +86,7 @@ cryptodev_init(struct test_ctx *ctx, uint8_t nb_lcores)
 	sec_ctx = rte_cryptodev_get_sec_ctx(0);
 	ctx->sec_ctx = sec_ctx;
 
-	socket_id = rte_socket_id();
+	numa_id = rte_numa_id();
 	qps_reqd = nb_lcores;
 	core_id = 0;
 	i = 0;
@@ -108,7 +108,7 @@ cryptodev_init(struct test_ctx *ctx, uint8_t nb_lcores)
 
 		memset(&config, 0, sizeof(config));
 		config.nb_queue_pairs = nb_qp;
-		config.socket_id = socket_id;
+		config.numa_id = numa_id;
 
 		ret = rte_cryptodev_configure(i, &config);
 		if (ret < 0) {
@@ -123,7 +123,7 @@ cryptodev_init(struct test_ctx *ctx, uint8_t nb_lcores)
 
 		for (j = 0; j < nb_qp; j++) {
 			ret = rte_cryptodev_queue_pair_setup(i, j, &qp_conf,
-							     socket_id);
+							     numa_id);
 			if (ret < 0) {
 				RTE_LOG(ERR, USER1,
 					"Could not configure queue pair:"
@@ -178,7 +178,7 @@ mempool_init(struct test_ctx *ctx, uint8_t nb_lcores)
 
 	sess_mpool = rte_cryptodev_sym_session_pool_create("test_sess_mp",
 			nb_sess_total, sec_sess_sz, RTE_MEMPOOL_CACHE_MAX_SIZE,
-			0, SOCKET_ID_ANY);
+			0, RTE_NUMA_ID_ANY);
 	if (sess_mpool == NULL) {
 		RTE_LOG(ERR, USER1, "Could not create mempool\n");
 		return -1;
-- 
2.55.0

