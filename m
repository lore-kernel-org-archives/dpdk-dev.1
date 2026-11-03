Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A3606D2DF
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jqbCki9K
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2C37427C2;
	Tue,  3 Nov 2026 16:00:15 +0100 (CET)
Received: from mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
 by mails.dpdk.org (Postfix) with ESMTPS id 91D9B427C0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:00:14 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=HTEzoM48ruoXujWtpj0scgSq1KWKylh/6IJyfcwJNBk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718014; v=1; x=1794322814;
 b=jqbCki9KrUZdmVQz5CnOmeYvXLInw9ZdbCEWQG17p/EwgVn+418V/P+7IVqPZncAlFfawofE
 gRjB1PKRy9Uc+nFOk0FGIewIRUc7UwB2nKEuX78sMIs6dkH7HwkQAhgdwzQndT2y+pXv2dGGV4c
 6klDYhwOaoPfMeQJVibUdiZM=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id dc8d745d21b708d6;
 Tue, 03 Nov 2026 15:00:13 +0000
X-Mizu-Trace-ID: dc8d745d21b708d6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 043/227] baseband/turbo_sw: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:01 +0800
Message-ID: <20261103145306.487255-44-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 .../baseband/turbo_sw/bbdev_turbo_software.c  | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index 12d168666c..315f12fb5f 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -58,13 +58,13 @@ struct bbdev_private {
 
 /*  Initialisation params structure that can be used by Turbo SW driver */
 struct turbo_sw_params {
-	int socket_id;
+	int numa_id;
 	uint16_t queues_num;
 };
 
 /* Acceptable params for Turbo SW devices */
 #define TURBO_SW_MAX_NB_QUEUES_ARG  "max_nb_queues"
-#define TURBO_SW_SOCKET_ID_ARG      "socket_id"
+#define TURBO_SW_SOCKET_ID_ARG      "numa_id"
 
 static const char * const turbo_sw_valid_params[] = {
 	TURBO_SW_MAX_NB_QUEUES_ARG,
@@ -306,8 +306,8 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 	char name[RTE_RING_NAMESIZE];
 
 	/* Allocate the queue data structure. */
-	q = rte_zmalloc_socket(RTE_STR(DRIVER_NAME), sizeof(*q),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+	q = rte_zmalloc_numa(RTE_STR(DRIVER_NAME), sizeof(*q),
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate queue memory");
 		return -ENOMEM;
@@ -323,10 +323,10 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->enc_out = rte_zmalloc_socket(name,
+	q->enc_out = rte_zmalloc_numa(name,
 			((RTE_BBDEV_TURBO_MAX_TB_SIZE >> 3) + 3) *
 			sizeof(*q->enc_out) * 3,
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->enc_out == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -345,9 +345,9 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->enc_in = rte_zmalloc_socket(name,
+	q->enc_in = rte_zmalloc_numa(name,
 			(RTE_BBDEV_LDPC_MAX_CB_SIZE >> 3) * sizeof(*q->enc_in),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->enc_in == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -365,9 +365,9 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->ag = rte_zmalloc_socket(name,
+	q->ag = rte_zmalloc_numa(name,
 			RTE_BBDEV_TURBO_MAX_CB_SIZE * 10 * sizeof(*q->ag),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->ag == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -385,9 +385,9 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->code_block = rte_zmalloc_socket(name,
+	q->code_block = rte_zmalloc_numa(name,
 			RTE_BBDEV_TURBO_MAX_CB_SIZE * sizeof(*q->code_block),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->code_block == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -406,9 +406,9 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->deint_input = rte_zmalloc_socket(name,
+	q->deint_input = rte_zmalloc_numa(name,
 			DEINT_INPUT_BUF_SIZE * sizeof(*q->deint_input),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->deint_input == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -427,9 +427,9 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->deint_output = rte_zmalloc_socket(NULL,
+	q->deint_output = rte_zmalloc_numa(NULL,
 			DEINT_OUTPUT_BUF_SIZE * sizeof(*q->deint_output),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->deint_output == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -448,9 +448,9 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		ret = -ENAMETOOLONG;
 		goto free_q;
 	}
-	q->adapter_output = rte_zmalloc_socket(NULL,
+	q->adapter_output = rte_zmalloc_numa(NULL,
 			ADAPTER_OUTPUT_BUF_SIZE * sizeof(*q->adapter_output),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q->adapter_output == NULL) {
 		rte_bbdev_log(ERR,
 			"Failed to allocate queue memory for %s", name);
@@ -469,7 +469,7 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 		goto free_q;
 	}
 	q->processed_pkts = rte_ring_create(name, queue_conf->queue_size,
-			queue_conf->socket, RING_F_SP_ENQ | RING_F_SC_DEQ);
+			queue_conf->numa_id, RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (q->processed_pkts == NULL) {
 		rte_bbdev_log(ERR, "Failed to create ring for %s", name);
 		ret = -rte_errno;
@@ -1874,11 +1874,11 @@ parse_turbo_sw_params(struct turbo_sw_params *params, const char *input_args)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist, turbo_sw_valid_params[1],
-					&parse_u16_arg, &params->socket_id);
+					&parse_u16_arg, &params->numa_id);
 		if (ret < 0)
 			goto exit;
 
-		if (params->socket_id >= RTE_MAX_NUMA_NODES) {
+		if (params->numa_id >= RTE_MAX_NUMA_NODES) {
 			rte_bbdev_log(ERR, "Invalid socket, must be < %u",
 					RTE_MAX_NUMA_NODES);
 			goto exit;
@@ -1902,9 +1902,9 @@ turbo_sw_bbdev_create(struct rte_vdev_device *vdev,
 	if (bbdev == NULL)
 		return -ENODEV;
 
-	bbdev->data->dev_private = rte_zmalloc_socket(name,
+	bbdev->data->dev_private = rte_zmalloc_numa(name,
 			sizeof(struct bbdev_private), RTE_CACHE_LINE_SIZE,
-			init_params->socket_id);
+			init_params->numa_id);
 	if (bbdev->data->dev_private == NULL) {
 		rte_bbdev_release(bbdev);
 		return -ENOMEM;
@@ -1912,7 +1912,7 @@ turbo_sw_bbdev_create(struct rte_vdev_device *vdev,
 
 	bbdev->dev_ops = &pmd_ops;
 	bbdev->device = &vdev->device;
-	bbdev->data->numa_id = init_params->socket_id;
+	bbdev->data->numa_id = init_params->numa_id;
 	bbdev->intr_handle = NULL;
 
 	/* register rx/tx burst functions for data path */
@@ -1935,7 +1935,7 @@ static int
 turbo_sw_bbdev_probe(struct rte_vdev_device *vdev)
 {
 	struct turbo_sw_params init_params = {
-		rte_socket_id(),
+		rte_numa_id(),
 		RTE_BBDEV_DEFAULT_MAX_NB_QUEUES
 	};
 	const char *name;
@@ -1952,7 +1952,7 @@ turbo_sw_bbdev_probe(struct rte_vdev_device *vdev)
 
 	rte_bbdev_log_debug(
 			"Initialising %s on NUMA node %d with max queues: %d",
-			name, init_params.socket_id, init_params.queues_num);
+			name, init_params.numa_id, init_params.queues_num);
 
 	return turbo_sw_bbdev_create(vdev, &init_params);
 }
-- 
2.55.0

