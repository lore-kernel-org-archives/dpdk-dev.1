Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59541606D2DF
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Hljb2OUw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DB16427AF;
	Tue,  3 Nov 2026 16:00:11 +0100 (CET)
Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
 by mails.dpdk.org (Postfix) with ESMTPS id 4C18C410FC
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:00:10 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=qsM9/SlsOy26qg72UNtK0EXaAvRs6oUpStu/OKiv5wg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718008; v=1; x=1794322808;
 b=Hljb2OUwdPdp68XnZYMksOhnePoDc4kYM+MWSNKXlN7yvnZ5cf4WYU5BAwHcne+3ZlAzcbvl
 kY8y5AIdYqBVu62WlE9mtmWCiTaDFwgQcg+So3nWR7QpaBKsQnNDRmZ80a5hCUxcrhyyGxo/5Uc
 BUR4ooh//99OXPEREZH2l36o=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 2d7498e5f8a45312;
 Tue, 03 Nov 2026 15:00:08 +0000
X-Mizu-Trace-ID: 2d7498e5f8a45312
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 042/227] baseband/null: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:00 +0800
Message-ID: <20261103145306.487255-43-chengwen.feng@linux.dev>
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
 drivers/baseband/null/bbdev_null.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index 10d02da856..9f0e2adf1b 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -29,13 +29,13 @@ RTE_LOG_REGISTER_DEFAULT(bbdev_null_logtype, NOTICE);
 
 /*  Initialisation params structure that can be used by null BBDEV driver */
 struct bbdev_null_params {
-	int socket_id;
+	int numa_id;
 	uint16_t queues_num;
 };
 
 /* Acceptable params for null BBDEV devices */
 #define BBDEV_NULL_MAX_NB_QUEUES_ARG  "max_nb_queues"
-#define BBDEV_NULL_SOCKET_ID_ARG      "socket_id"
+#define BBDEV_NULL_SOCKET_ID_ARG      "numa_id"
 
 static const char * const bbdev_null_valid_params[] = {
 	BBDEV_NULL_MAX_NB_QUEUES_ARG,
@@ -117,15 +117,15 @@ q_setup(struct rte_bbdev *dev, uint16_t q_id,
 				dev->data->dev_id, q_id);
 
 	/* Allocate the queue data structure. */
-	q = rte_zmalloc_socket(RTE_STR(DRIVER_NAME), sizeof(*q),
-			RTE_CACHE_LINE_SIZE, queue_conf->socket);
+	q = rte_zmalloc_numa(RTE_STR(DRIVER_NAME), sizeof(*q),
+			RTE_CACHE_LINE_SIZE, queue_conf->numa_id);
 	if (q == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate queue memory");
 		return -ENOMEM;
 	}
 
 	q->processed_pkts = rte_ring_create(ring_name, queue_conf->queue_size,
-			queue_conf->socket, RING_F_SP_ENQ | RING_F_SC_DEQ);
+			queue_conf->numa_id, RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (q->processed_pkts == NULL) {
 		rte_bbdev_log(ERR, "Failed to create ring");
 		goto free_q;
@@ -242,11 +242,11 @@ parse_bbdev_null_params(struct bbdev_null_params *params,
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist, bbdev_null_valid_params[1],
-					&parse_u16_arg, &params->socket_id);
+					&parse_u16_arg, &params->numa_id);
 		if (ret < 0)
 			goto exit;
 
-		if (params->socket_id >= RTE_MAX_NUMA_NODES) {
+		if (params->numa_id >= RTE_MAX_NUMA_NODES) {
 			rte_bbdev_log(ERR, "Invalid socket, must be < %u",
 					RTE_MAX_NUMA_NODES);
 			goto exit;
@@ -270,9 +270,9 @@ null_bbdev_create(struct rte_vdev_device *vdev,
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
@@ -280,7 +280,7 @@ null_bbdev_create(struct rte_vdev_device *vdev,
 
 	bbdev->dev_ops = &pmd_ops;
 	bbdev->device = &vdev->device;
-	bbdev->data->numa_id = init_params->socket_id;
+	bbdev->data->numa_id = init_params->numa_id;
 	bbdev->intr_handle = NULL;
 
 	/* register rx/tx burst functions for data path */
@@ -299,7 +299,7 @@ static int
 null_bbdev_probe(struct rte_vdev_device *vdev)
 {
 	struct bbdev_null_params init_params = {
-		rte_socket_id(),
+		rte_numa_id(),
 		RTE_BBDEV_DEFAULT_MAX_NB_QUEUES
 	};
 	const char *name;
@@ -316,7 +316,7 @@ null_bbdev_probe(struct rte_vdev_device *vdev)
 	parse_bbdev_null_params(&init_params, input_args);
 
 	rte_bbdev_log_debug("Init %s on NUMA node %d with max queues: %d",
-			name, init_params.socket_id, init_params.queues_num);
+			name, init_params.numa_id, init_params.queues_num);
 
 	return null_bbdev_create(vdev, &init_params);
 }
-- 
2.55.0

