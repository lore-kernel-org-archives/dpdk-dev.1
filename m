Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C13606B254
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nvt0pRM3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCC3642D99;
	Tue,  3 Nov 2026 16:04:45 +0100 (CET)
Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 7ED7842D83
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:44 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=k1t1+JIV0fqojYAcefMUirrzM18OWaqdRyJb3RscGoU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718284; v=1; x=1794323084;
 b=Nvt0pRM3HGoKeDEKs6kblD8AYuTZj9/hPDSxn2cHRhJh8+lPSHnWcqNatUiwjP/TTVHAujHH
 kS7pGtTzcpa3yaGPN1eKBVZHteHq/5Ei2+PAD8r890/sJURD2x+tU0n7rKdNBdd+e2euo7X4pvt
 vv0wKjsHrjpVUqvkNopKnO50=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id e1ffafb9775bcbf5;
 Tue, 03 Nov 2026 15:04:44 +0000
X-Mizu-Trace-ID: e1ffafb9775bcbf5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 070/227] crypto/ipsec_mb: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:28 +0800
Message-ID: <20261103145306.487255-71-chengwen.feng@linux.dev>
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
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c     | 22 +++++++++++-----------
 drivers/crypto/ipsec_mb/ipsec_mb_private.c |  2 +-
 drivers/crypto/ipsec_mb/ipsec_mb_private.h |  4 ++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c    |  6 +++---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c     |  2 +-
 drivers/crypto/ipsec_mb/pmd_snow3g.c       |  2 +-
 drivers/crypto/ipsec_mb/pmd_zuc.c          |  2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
index 50ee140ccd..7a9a518c74 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
@@ -96,7 +96,7 @@ ipsec_mb_info_get(struct rte_cryptodev *dev,
 static int
 ipsec_mb_secondary_qp_op(int dev_id, int qp_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id, enum ipsec_mb_mp_req_type op_type)
+		int numa_id, enum ipsec_mb_mp_req_type op_type)
 {
 	int ret;
 	struct rte_mp_msg qp_req_msg;
@@ -114,7 +114,7 @@ ipsec_mb_secondary_qp_op(int dev_id, int qp_id,
 	req_param->type = op_type;
 	req_param->dev_id = dev_id;
 	req_param->qp_id = qp_id;
-	req_param->socket_id = socket_id;
+	req_param->numa_id = numa_id;
 	req_param->process_id = getpid();
 	if (qp_conf) {
 		req_param->nb_descriptors = qp_conf->nb_descriptors;
@@ -179,7 +179,7 @@ ipsec_mb_qp_set_unique_name(struct rte_cryptodev *dev,
 /** Create a ring to place processed operations on */
 static struct rte_ring
 *ipsec_mb_qp_create_processed_ops_ring(
-	struct ipsec_mb_qp *qp, unsigned int ring_size, int socket_id)
+	struct ipsec_mb_qp *qp, unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 	char ring_name[RTE_CRYPTODEV_NAME_MAX_LEN];
@@ -203,7 +203,7 @@ static struct rte_ring
 		return NULL;
 	}
 
-	return rte_ring_create(ring_name, ring_size, socket_id,
+	return rte_ring_create(ring_name, ring_size, numa_id,
 			       RING_F_SP_ENQ | RING_F_SC_DEQ);
 }
 
@@ -218,7 +218,7 @@ ipsec_mb_alloc_mgr_from_memzone(const struct rte_memzone **mb_mgr_mz,
 		if (*mb_mgr_mz == NULL) {
 			*mb_mgr_mz = rte_memzone_reserve(mb_mgr_mz_name,
 			imb_get_mb_mgr_size(),
-			rte_socket_id(), 0);
+			rte_numa_id(), 0);
 		}
 		if (*mb_mgr_mz == NULL) {
 			IPSEC_MB_LOG(DEBUG, "Error allocating memzone for %s",
@@ -244,7 +244,7 @@ ipsec_mb_alloc_mgr_from_memzone(const struct rte_memzone **mb_mgr_mz,
 int
 ipsec_mb_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 				const struct rte_cryptodev_qp_conf *qp_conf,
-				int socket_id)
+				int numa_id)
 {
 	struct ipsec_mb_qp *qp = NULL;
 	struct ipsec_mb_dev_private *internals = dev->data->dev_private;
@@ -258,7 +258,7 @@ ipsec_mb_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		if (qp == NULL) {
 			IPSEC_MB_LOG(DEBUG, "Secondary process setting up device qp.");
 			return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
-						qp_conf, socket_id,	RTE_IPSEC_MB_MP_REQ_QP_SET);
+						qp_conf, numa_id,	RTE_IPSEC_MB_MP_REQ_QP_SET);
 		}
 	} else {
 		/* Free memory prior to re-allocation if needed. */
@@ -267,8 +267,8 @@ ipsec_mb_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 
 		qp_size = sizeof(*qp) + pmd_data->qp_priv_size;
 		/* Allocate the queue pair data structure. */
-		qp = rte_zmalloc_socket("IPSEC PMD Queue Pair", qp_size,
-					RTE_CACHE_LINE_SIZE, socket_id);
+		qp = rte_zmalloc_numa("IPSEC PMD Queue Pair", qp_size,
+					RTE_CACHE_LINE_SIZE, numa_id);
 		if (qp == NULL)
 			return -ENOMEM;
 	}
@@ -297,7 +297,7 @@ ipsec_mb_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	qp->sess_mp = qp_conf->mp_session;
 
 	qp->ingress_queue = ipsec_mb_qp_create_processed_ops_ring(qp,
-		qp_conf->nb_descriptors, socket_id);
+		qp_conf->nb_descriptors, numa_id);
 	if (qp->ingress_queue == NULL) {
 		ret = -EINVAL;
 		goto qp_setup_cleanup;
@@ -356,7 +356,7 @@ ipsec_mb_ipc_request(const struct rte_mp_msg *mp_msg, const void *peer)
 			goto out;
 		}
 
-		ret = ipsec_mb_qp_setup(dev, qp_id,	&queue_conf, req_param->socket_id);
+		ret = ipsec_mb_qp_setup(dev, qp_id,	&queue_conf, req_param->numa_id);
 		if (!ret) {
 			qp = dev->data->queue_pairs[qp_id];
 			if (!qp) {
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.c b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
index 23ec99004b..92c60daacd 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.c
@@ -101,7 +101,7 @@ ipsec_mb_create(struct rte_vdev_device *vdev,
 		pmd_data->internals_priv_size;
 	init_params.max_nb_queue_pairs =
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS;
-	init_params.numa_id = rte_socket_id();
+	init_params.numa_id = rte_numa_id();
 
 	name = rte_vdev_device_name(vdev);
 	if (name == NULL)
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.h b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
index fc7d6f5f06..636b9d393e 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.h
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
@@ -163,7 +163,7 @@ struct ipsec_mb_mp_param {
 	/**< The identifier of the device */
 	int qp_id;
 	/**< The index of the queue pair to be configured */
-	int socket_id;
+	int numa_id;
 	/**< Socket to allocate resources on */
 	uint16_t process_id;
 	/**< The pid who send out the requested */
@@ -411,7 +411,7 @@ ipsec_mb_qp_set_unique_name(struct rte_cryptodev *dev, struct ipsec_mb_qp *qp);
 int
 ipsec_mb_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 				 const struct rte_cryptodev_qp_conf *qp_conf,
-				 int socket_id);
+				 int numa_id);
 
 /** Returns the size of the aesni multi-buffer session structure */
 unsigned
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 2a4bede7dd..57967653da 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -740,9 +740,9 @@ aesni_gcm_process_bulk(struct rte_cryptodev *dev __rte_unused,
 static int
 aesni_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 				const struct rte_cryptodev_qp_conf *qp_conf,
-				int socket_id)
+				int numa_id)
 {
-	int ret = ipsec_mb_qp_setup(dev, qp_id, qp_conf, socket_id);
+	int ret = ipsec_mb_qp_setup(dev, qp_id, qp_conf, numa_id);
 	if (ret < 0)
 		return ret;
 
@@ -790,7 +790,7 @@ static struct cryptodev_driver aesni_gcm_crypto_drv;
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_GCM_PMD,
 		      cryptodev_aesni_gcm_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_AESNI_GCM_PMD,
-			      "max_nb_queue_pairs=<int> socket_id=<int>");
+			      "max_nb_queue_pairs=<int> numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(aesni_gcm_crypto_drv,
 			       cryptodev_aesni_gcm_pmd_drv.driver,
 			       pmd_driver_id_aesni_gcm);
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index d39539d7aa..d1a044f205 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2552,7 +2552,7 @@ static struct cryptodev_driver aesni_mb_crypto_drv;
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_MB_PMD,
 	cryptodev_aesni_mb_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_AESNI_MB_PMD,
-			"max_nb_queue_pairs=<int> socket_id=<int>");
+			"max_nb_queue_pairs=<int> numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(
 	aesni_mb_crypto_drv,
 	cryptodev_aesni_mb_pmd_drv.driver,
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 28b078ea0c..54e8ba6588 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -575,7 +575,7 @@ static struct cryptodev_driver snow3g_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SNOW3G_PMD, cryptodev_snow3g_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_SNOW3G_PMD,
-			       "max_nb_queue_pairs=<int> socket_id=<int>");
+			       "max_nb_queue_pairs=<int> numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(snow3g_crypto_drv,
 				cryptodev_snow3g_pmd_drv.driver,
 				pmd_driver_id_snow3g);
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 102ac520bb..784c2aa2bf 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -378,7 +378,7 @@ static struct cryptodev_driver zuc_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ZUC_PMD, cryptodev_zuc_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_ZUC_PMD,
-	"max_nb_queue_pairs=<int> socket_id=<int>");
+	"max_nb_queue_pairs=<int> numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(zuc_crypto_drv, cryptodev_zuc_pmd_drv.driver,
 		pmd_driver_id_zuc);
 
-- 
2.55.0

