Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19517606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e+D56Pqi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC05842DC1;
	Tue,  3 Nov 2026 16:05:55 +0100 (CET)
Received: from mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 8302A42DC1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:54 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=+npdv3aMlJ8+Y0cSKvArmmcWnBnEPpRwayZfi1qB3bo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718354; v=1; x=1794323154;
 b=e+D56PqikuRNISu2PDXfTAZSxQ5ahpP3tuJk7oi6L5cIqCQr5uomDqF1iA9z9iSkZDBx6Sm5
 nuaL+Mtg+PhRdupfm+uOt4NGpm3c+qlSkNMp3XqHoCVQ15o9Fj1K910dxU9OkyZAjCAFXVLbuEC
 ZgDkdh+OyfO413FY4M4GFrzA=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id f5f658bb1b9a48c8;
 Tue, 03 Nov 2026 15:05:54 +0000
X-Mizu-Trace-ID: f5f658bb1b9a48c8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 077/227] crypto/scheduler: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:35 +0800
Message-ID: <20261103145306.487255-78-chengwen.feng@linux.dev>
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
 .../scheduler/rte_cryptodev_scheduler.c       | 16 +++++++-------
 drivers/crypto/scheduler/scheduler_failover.c |  4 ++--
 .../crypto/scheduler/scheduler_multicore.c    | 12 +++++-----
 .../scheduler/scheduler_pkt_size_distr.c      |  8 +++----
 drivers/crypto/scheduler/scheduler_pmd.c      | 22 +++++++++----------
 drivers/crypto/scheduler/scheduler_pmd_ops.c  | 10 ++++-----
 .../crypto/scheduler/scheduler_roundrobin.c   |  4 ++--
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 1ca8443431..d69b8b237d 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -258,9 +258,9 @@ update_scheduler_capability(struct scheduler_ctx *sched_ctx)
 			return -1;
 	}
 
-	sched_ctx->capabilities = rte_zmalloc_socket(NULL,
+	sched_ctx->capabilities = rte_zmalloc_numa(NULL,
 			sizeof(struct rte_cryptodev_capabilities) *
-			(nb_caps + 1), 0, SOCKET_ID_ANY);
+			(nb_caps + 1), 0, RTE_NUMA_ID_ANY);
 	if (!sched_ctx->capabilities)
 		return -ENOMEM;
 
@@ -277,16 +277,16 @@ update_scheduler_capability(struct scheduler_ctx *sched_ctx)
 			nb_sec_caps, rte_security_capabilities_get(sec_ctx));
 	}
 
-	sched_ctx->sec_capabilities = rte_zmalloc_socket(NULL,
+	sched_ctx->sec_capabilities = rte_zmalloc_numa(NULL,
 					sizeof(struct rte_security_capability) *
-					(nb_sec_caps + 1), 0, SOCKET_ID_ANY);
+					(nb_sec_caps + 1), 0, RTE_NUMA_ID_ANY);
 	if (!sched_ctx->sec_capabilities)
 		return -ENOMEM;
 
-	sched_ctx->sec_crypto_capabilities = rte_zmalloc_socket(NULL,
+	sched_ctx->sec_crypto_capabilities = rte_zmalloc_numa(NULL,
 				sizeof(struct rte_cryptodev_capabilities *) *
 				(nb_sec_caps + 1),
-				0, SOCKET_ID_ANY);
+				0, RTE_NUMA_ID_ANY);
 	if (!sched_ctx->sec_crypto_capabilities)
 		return -ENOMEM;
 
@@ -300,9 +300,9 @@ update_scheduler_capability(struct scheduler_ctx *sched_ctx)
 			nb_sec_crypto_caps++;
 
 		sched_ctx->sec_crypto_capabilities[i] =
-			rte_zmalloc_socket(NULL,
+			rte_zmalloc_numa(NULL,
 				sizeof(struct rte_cryptodev_capabilities) *
-				(nb_sec_crypto_caps + 1), 0, SOCKET_ID_ANY);
+				(nb_sec_crypto_caps + 1), 0, RTE_NUMA_ID_ANY);
 		if (!sched_ctx->sec_crypto_capabilities[i])
 			return -ENOMEM;
 
diff --git a/drivers/crypto/scheduler/scheduler_failover.c b/drivers/crypto/scheduler/scheduler_failover.c
index 52ff2ffbb7..1a60a531ec 100644
--- a/drivers/crypto/scheduler/scheduler_failover.c
+++ b/drivers/crypto/scheduler/scheduler_failover.c
@@ -194,8 +194,8 @@ scheduler_config_qp(struct rte_cryptodev *dev, uint16_t qp_id)
 	struct scheduler_qp_ctx *qp_ctx = dev->data->queue_pairs[qp_id];
 	struct fo_scheduler_qp_ctx *fo_qp_ctx;
 
-	fo_qp_ctx = rte_zmalloc_socket(NULL, sizeof(*fo_qp_ctx), 0,
-			rte_socket_id());
+	fo_qp_ctx = rte_zmalloc_numa(NULL, sizeof(*fo_qp_ctx), 0,
+			rte_numa_id());
 	if (!fo_qp_ctx) {
 		CR_SCHED_LOG(ERR, "failed allocate memory for private queue pair");
 		return -ENOMEM;
diff --git a/drivers/crypto/scheduler/scheduler_multicore.c b/drivers/crypto/scheduler/scheduler_multicore.c
index 70f8a25b70..4146e97335 100644
--- a/drivers/crypto/scheduler/scheduler_multicore.c
+++ b/drivers/crypto/scheduler/scheduler_multicore.c
@@ -324,8 +324,8 @@ scheduler_config_qp(struct rte_cryptodev *dev, uint16_t qp_id)
 	struct scheduler_ctx *sched_ctx = dev->data->dev_private;
 	struct mc_scheduler_ctx *mc_ctx = sched_ctx->private_ctx;
 
-	mc_qp_ctx = rte_zmalloc_socket(NULL, sizeof(*mc_qp_ctx), 0,
-			rte_socket_id());
+	mc_qp_ctx = rte_zmalloc_numa(NULL, sizeof(*mc_qp_ctx), 0,
+			rte_numa_id());
 	if (!mc_qp_ctx) {
 		CR_SCHED_LOG(ERR, "failed allocate memory for private queue pair");
 		return -ENOMEM;
@@ -350,8 +350,8 @@ scheduler_create_private_ctx(struct rte_cryptodev *dev)
 		sched_ctx->private_ctx = NULL;
 	}
 
-	mc_ctx = rte_zmalloc_socket(NULL, sizeof(struct mc_scheduler_ctx), 0,
-			rte_socket_id());
+	mc_ctx = rte_zmalloc_numa(NULL, sizeof(struct mc_scheduler_ctx), 0,
+			rte_numa_id());
 	if (!mc_ctx) {
 		CR_SCHED_LOG(ERR, "failed allocate memory");
 		return -ENOMEM;
@@ -367,7 +367,7 @@ scheduler_create_private_ctx(struct rte_cryptodev *dev)
 		if (!mc_ctx->sched_enq_ring[i]) {
 			mc_ctx->sched_enq_ring[i] = rte_ring_create(r_name,
 						PER_WORKER_BUFF_SIZE,
-						rte_socket_id(),
+						rte_numa_id(),
 						RING_F_SC_DEQ | RING_F_SP_ENQ);
 			if (!mc_ctx->sched_enq_ring[i]) {
 				CR_SCHED_LOG(ERR, "Cannot create ring for worker %u",
@@ -381,7 +381,7 @@ scheduler_create_private_ctx(struct rte_cryptodev *dev)
 		if (!mc_ctx->sched_deq_ring[i]) {
 			mc_ctx->sched_deq_ring[i] = rte_ring_create(r_name,
 						PER_WORKER_BUFF_SIZE,
-						rte_socket_id(),
+						rte_numa_id(),
 						RING_F_SC_DEQ | RING_F_SP_ENQ);
 			if (!mc_ctx->sched_deq_ring[i]) {
 				CR_SCHED_LOG(ERR, "Cannot create ring for worker %u",
diff --git a/drivers/crypto/scheduler/scheduler_pkt_size_distr.c b/drivers/crypto/scheduler/scheduler_pkt_size_distr.c
index 1334a79b7b..2c455406c0 100644
--- a/drivers/crypto/scheduler/scheduler_pkt_size_distr.c
+++ b/drivers/crypto/scheduler/scheduler_pkt_size_distr.c
@@ -325,8 +325,8 @@ scheduler_config_qp(struct rte_cryptodev *dev, uint16_t qp_id)
 	struct scheduler_qp_ctx *qp_ctx = dev->data->queue_pairs[qp_id];
 	struct psd_scheduler_qp_ctx *ps_qp_ctx;
 
-	ps_qp_ctx = rte_zmalloc_socket(NULL, sizeof(*ps_qp_ctx), 0,
-			rte_socket_id());
+	ps_qp_ctx = rte_zmalloc_numa(NULL, sizeof(*ps_qp_ctx), 0,
+			rte_numa_id());
 	if (!ps_qp_ctx) {
 		CR_SCHED_LOG(ERR, "failed allocate memory for private queue pair");
 		return -ENOMEM;
@@ -348,8 +348,8 @@ scheduler_create_private_ctx(struct rte_cryptodev *dev)
 		sched_ctx->private_ctx = NULL;
 	}
 
-	psd_ctx = rte_zmalloc_socket(NULL, sizeof(struct psd_scheduler_ctx), 0,
-			rte_socket_id());
+	psd_ctx = rte_zmalloc_numa(NULL, sizeof(struct psd_scheduler_ctx), 0,
+			rte_numa_id());
 	if (!psd_ctx) {
 		CR_SCHED_LOG(ERR, "failed allocate memory");
 		return -ENOMEM;
diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/scheduler/scheduler_pmd.c
index 8ca09ba3d0..d76cf96f8b 100644
--- a/drivers/crypto/scheduler/scheduler_pmd.c
+++ b/drivers/crypto/scheduler/scheduler_pmd.c
@@ -38,7 +38,7 @@ struct scheduler_init_params {
 #define RTE_CRYPTODEV_VDEV_MODE_PARAM		("mode_param")
 #define RTE_CRYPTODEV_VDEV_ORDERING		("ordering")
 #define RTE_CRYPTODEV_VDEV_MAX_NB_QP_ARG	("max_nb_queue_pairs")
-#define RTE_CRYPTODEV_VDEV_SOCKET_ID		("socket_id")
+#define RTE_CRYPTODEV_VDEV_SOCKET_ID		("numa_id")
 #define RTE_CRYPTODEV_VDEV_COREMASK		("coremask")
 #define RTE_CRYPTODEV_VDEV_CORELIST		("corelist")
 
@@ -217,10 +217,10 @@ cryptodev_scheduler_create(const char *name,
 
 	for (i = 0; i < init_params->nb_workers; i++) {
 		sched_ctx->init_worker_names[sched_ctx->nb_init_workers] =
-			rte_zmalloc_socket(
+			rte_zmalloc_numa(
 				NULL,
 				RTE_CRYPTODEV_SCHEDULER_NAME_MAX_LEN, 0,
-				SOCKET_ID_ANY);
+				RTE_NUMA_ID_ANY);
 
 		if (!sched_ctx->init_worker_names[
 				sched_ctx->nb_init_workers]) {
@@ -241,9 +241,9 @@ cryptodev_scheduler_create(const char *name,
 	 * Initialize capabilities structure as an empty structure,
 	 * in case device information is requested when no workers are attached
 	 */
-	sched_ctx->capabilities = rte_zmalloc_socket(NULL,
+	sched_ctx->capabilities = rte_zmalloc_numa(NULL,
 			sizeof(struct rte_cryptodev_capabilities),
-			0, SOCKET_ID_ANY);
+			0, RTE_NUMA_ID_ANY);
 
 	if (!sched_ctx->capabilities) {
 		CR_SCHED_LOG(ERR, "Not enough memory for capability information");
@@ -253,9 +253,9 @@ cryptodev_scheduler_create(const char *name,
 
 	/* Initialize security context */
 	struct rte_security_ctx *security_instance;
-	security_instance = rte_zmalloc_socket(NULL,
+	security_instance = rte_zmalloc_numa(NULL,
 					sizeof(struct rte_security_ctx),
-					RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+					RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	if (!security_instance) {
 		CR_SCHED_LOG(ERR, "Not enough memory for security context");
 		free_mem(dev);
@@ -271,9 +271,9 @@ cryptodev_scheduler_create(const char *name,
 	 * Initialize security capabilities structure as an empty structure,
 	 * in case device information is requested when no workers are attached
 	 */
-	sched_ctx->sec_capabilities = rte_zmalloc_socket(NULL,
+	sched_ctx->sec_capabilities = rte_zmalloc_numa(NULL,
 					sizeof(struct rte_security_capability),
-					0, SOCKET_ID_ANY);
+					0, RTE_NUMA_ID_ANY);
 
 	if (!sched_ctx->sec_capabilities) {
 		CR_SCHED_LOG(ERR, "Not enough memory for security capability information");
@@ -588,7 +588,7 @@ cryptodev_scheduler_probe(struct rte_vdev_device *vdev)
 		.def_p = {
 			"",
 			sizeof(struct scheduler_ctx),
-			rte_socket_id(),
+			rte_numa_id(),
 			RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS
 		},
 		.nb_workers = 0,
@@ -622,7 +622,7 @@ RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SCHEDULER_PMD,
 	cryptodev_scheduler_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_SCHEDULER_PMD,
 	"max_nb_queue_pairs=<int> "
-	"socket_id=<int> "
+	"numa_id=<int> "
 	"worker=<name>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(scheduler_crypto_drv,
 		cryptodev_scheduler_pmd_drv.driver,
diff --git a/drivers/crypto/scheduler/scheduler_pmd_ops.c b/drivers/crypto/scheduler/scheduler_pmd_ops.c
index 105d9cf02a..06a0e23fc0 100644
--- a/drivers/crypto/scheduler/scheduler_pmd_ops.c
+++ b/drivers/crypto/scheduler/scheduler_pmd_ops.c
@@ -302,7 +302,7 @@ update_order_ring(struct rte_cryptodev *dev, uint16_t qp_id)
 		}
 
 		qp_ctx->order_ring = rte_ring_create(order_ring_name,
-				buff_size, rte_socket_id(),
+				buff_size, rte_numa_id(),
 				RING_F_SP_ENQ | RING_F_SC_DEQ);
 		if (!qp_ctx->order_ring) {
 			CR_SCHED_LOG(ERR, "failed to create order ring");
@@ -576,7 +576,7 @@ scheduler_pmd_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 /** Setup a queue pair */
 static int
 scheduler_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
-	const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
+	const struct rte_cryptodev_qp_conf *qp_conf, int numa_id)
 {
 	struct scheduler_ctx *sched_ctx = dev->data->dev_private;
 	struct scheduler_qp_ctx *qp_ctx;
@@ -604,14 +604,14 @@ scheduler_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		 * must be big enough for all the drivers used.
 		 */
 		ret = rte_cryptodev_queue_pair_setup(worker_id, qp_id,
-				qp_conf, socket_id);
+				qp_conf, numa_id);
 		if (ret < 0)
 			return ret;
 	}
 
 	/* Allocate the queue pair data structure. */
-	qp_ctx = rte_zmalloc_socket(name, sizeof(*qp_ctx), RTE_CACHE_LINE_SIZE,
-			socket_id);
+	qp_ctx = rte_zmalloc_numa(name, sizeof(*qp_ctx), RTE_CACHE_LINE_SIZE,
+			numa_id);
 	if (qp_ctx == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/scheduler/scheduler_roundrobin.c b/drivers/crypto/scheduler/scheduler_roundrobin.c
index 08041887a8..cce4c4030f 100644
--- a/drivers/crypto/scheduler/scheduler_roundrobin.c
+++ b/drivers/crypto/scheduler/scheduler_roundrobin.c
@@ -174,8 +174,8 @@ scheduler_config_qp(struct rte_cryptodev *dev, uint16_t qp_id)
 	struct scheduler_qp_ctx *qp_ctx = dev->data->queue_pairs[qp_id];
 	struct rr_scheduler_qp_ctx *rr_qp_ctx;
 
-	rr_qp_ctx = rte_zmalloc_socket(NULL, sizeof(*rr_qp_ctx), 0,
-			rte_socket_id());
+	rr_qp_ctx = rte_zmalloc_numa(NULL, sizeof(*rr_qp_ctx), 0,
+			rte_numa_id());
 	if (!rr_qp_ctx) {
 		CR_SCHED_LOG(ERR, "failed allocate memory for private queue pair");
 		return -ENOMEM;
-- 
2.55.0

