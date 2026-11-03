Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47018606D2F8
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LhawPIAv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2B842F4D;
	Tue,  3 Nov 2026 16:19:33 +0100 (CET)
Received: from mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
 by mails.dpdk.org (Postfix) with ESMTPS id 9B71B427E0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:31 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=utT6ybrGbQtHGmvWrpF3num2NgOpd8CK7ainhmXqsUU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719171; v=1; x=1794323971;
 b=LhawPIAv+5k0a2qmdDFd2mnBArQbSDbOsrnu+KLhuNNlcndK9/zTJMuphkMrM2d2sFtPc2Gv
 k01CuTVxVFdhQWVmtd2lGoXUW3mb3zt/biPKtlBHNSvhpZ1qxhCvrlTL1jr6Y1FB78mYEJJu6K1
 B4CVXmTTfocA83Xq1OYzsQVg=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 446a2ef5b5e191a3;
 Tue, 03 Nov 2026 15:19:31 +0000
X-Mizu-Trace-ID: 446a2ef5b5e191a3
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 168/227] drivers: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:06 +0800
Message-ID: <20261103145306.487255-169-chengwen.feng@linux.dev>
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
and comments to the NUMA node terminology across the qat common,
crypto and compress drivers, and switch calls to the NUMA-named
APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/common/qat/qat_device.c               |  2 +-
 drivers/common/qat/qat_qp.c                   | 22 +++++++-------
 drivers/common/qat/qat_qp.h                   |  2 +-
 drivers/compress/qat/qat_comp.c               | 14 ++++-----
 drivers/compress/qat/qat_comp.h               |  2 +-
 drivers/compress/qat/qat_comp_pmd.c           | 22 +++++++-------
 drivers/compress/qat/qat_comp_pmd.h           |  2 +-
 drivers/crypto/qat/asym/qat_asym.c            |  2 +-
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c    |  2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c  |  6 ++--
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c  |  2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c  |  4 +--
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c  |  2 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c  |  2 +-
 .../crypto/qat/dev/qat_crypto_pmd_gen_lce.c   |  2 +-
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c     |  2 +-
 drivers/crypto/qat/qat_crypto.c               |  4 +--
 drivers/crypto/qat/qat_crypto.h               |  2 +-
 drivers/crypto/qat/qat_sym.c                  |  2 +-
 drivers/net/mlx5/mlx5_flow.c                  | 29 ++++++++++---------
 drivers/net/mlx5/mlx5_rxq.c                   | 24 ++++++++-------
 drivers/net/mlx5/mlx5_txq.c                   | 13 +++++----
 22 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index f0ed115b30..041f4cf880 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -320,7 +320,7 @@ qat_pci_device_allocate(struct rte_pci_device *pci_dev)
 	qat_dev_size = sizeof(struct qat_pci_device) + sizeof(void *) *
 				QAT_MAX_SERVICES + extra_size;
 	qat_dev_mz = rte_memzone_reserve(name, qat_dev_size,
-		rte_socket_id(), 0);
+		rte_numa_id(), 0);
 
 	if (qat_dev_mz == NULL) {
 		QAT_LOG(ERR, "Error when allocating memzone for QAT_%d",
diff --git a/drivers/common/qat/qat_qp.c b/drivers/common/qat/qat_qp.c
index fe28cb160d..0d4d2dda52 100644
--- a/drivers/common/qat/qat_qp.c
+++ b/drivers/common/qat/qat_qp.c
@@ -84,7 +84,7 @@ static int adf_queue_arb_disable(enum qat_device_gen qat_dev_gen,
 static int qat_qp_build_ring_base(struct qat_pci_device *qat_dev,
 	void *io_addr, struct qat_queue *queue);
 static const struct rte_memzone *queue_dma_zone_reserve(const char *queue_name,
-	uint32_t queue_size, int socket_id);
+	uint32_t queue_size, int numa_id);
 static int qat_qp_csr_setup(struct qat_pci_device *qat_dev, void *io_addr,
 	struct qat_qp *qp);
 
@@ -128,17 +128,17 @@ qat_qp_setup(struct qat_pci_device *qat_dev,
 	}
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("qat PMD qp metadata",
+	qp = rte_zmalloc_numa("qat PMD qp metadata",
 				sizeof(*qp), RTE_CACHE_LINE_SIZE,
-				qat_qp_conf->socket_id);
+				qat_qp_conf->numa_id);
 	if (qp == NULL) {
 		QAT_LOG(ERR, "Failed to alloc mem for qp struct");
 		return -ENOMEM;
 	}
 	qp->nb_descriptors = qat_qp_conf->nb_descriptors;
-	qp->op_cookies = rte_zmalloc_socket("qat PMD op cookie pointer",
+	qp->op_cookies = rte_zmalloc_numa("qat PMD op cookie pointer",
 			qat_qp_conf->nb_descriptors * sizeof(*qp->op_cookies),
-			RTE_CACHE_LINE_SIZE, qat_qp_conf->socket_id);
+			RTE_CACHE_LINE_SIZE, qat_qp_conf->numa_id);
 	if (qp->op_cookies == NULL) {
 		QAT_LOG(ERR, "Failed to alloc mem for cookie");
 		rte_free(qp);
@@ -309,15 +309,15 @@ qat_queue_create(struct qat_pci_device *qat_dev, struct qat_queue *queue,
 
 static const struct rte_memzone *
 queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
-		int socket_id)
+		int numa_id)
 {
 	const struct rte_memzone *mz;
 
 	mz = rte_memzone_lookup(queue_name);
 	if (mz != 0) {
 		if (((size_t)queue_size <= mz->len) &&
-				((socket_id == SOCKET_ID_ANY) ||
-					(socket_id == mz->socket_id))) {
+				((numa_id == RTE_NUMA_ID_ANY) ||
+					(numa_id == mz->socket_id))) {
 			QAT_LOG(DEBUG, "re-use memzone already "
 					"allocated for %s", queue_name);
 			return mz;
@@ -327,14 +327,14 @@ queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
 				"allocated %s, size %u, socket %d. "
 				"Requested size %u, socket %u",
 				queue_name, (uint32_t)mz->len,
-				mz->socket_id, queue_size, socket_id);
+				mz->socket_id, queue_size, numa_id);
 		return NULL;
 	}
 
 	QAT_LOG(DEBUG, "Allocate memzone for %s, size %u on socket %u",
-					queue_name, queue_size, socket_id);
+					queue_name, queue_size, numa_id);
 	return rte_memzone_reserve_aligned(queue_name, queue_size,
-		socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
+		numa_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
 }
 
 int
diff --git a/drivers/common/qat/qat_qp.h b/drivers/common/qat/qat_qp.h
index 5ccaedefa7..be57e00dd4 100644
--- a/drivers/common/qat/qat_qp.h
+++ b/drivers/common/qat/qat_qp.h
@@ -120,7 +120,7 @@ struct qat_qp_config {
 	const struct qat_qp_hw_data *hw;
 	uint32_t nb_descriptors;
 	uint32_t cookie_size;
-	int socket_id;
+	int numa_id;
 	const char *service_str;
 };
 
diff --git a/drivers/compress/qat/qat_comp.c b/drivers/compress/qat/qat_comp.c
index 559948a46a..1f4973f614 100644
--- a/drivers/compress/qat/qat_comp.c
+++ b/drivers/compress/qat/qat_comp.c
@@ -63,10 +63,10 @@ qat_comp_allocate_split_op_memzones(struct qat_comp_op_cookie *cookie,
 	unsigned int i;
 
 	/* allocate the array of memzone pointers */
-	cookie->dst_memzones = rte_zmalloc_socket("qat PMD im buf mz pointers",
+	cookie->dst_memzones = rte_zmalloc_numa("qat PMD im buf mz pointers",
 			(nb_descriptors_needed - 1) *
 				sizeof(const struct rte_memzone *),
-			RTE_CACHE_LINE_SIZE, cookie->socket_id);
+			RTE_CACHE_LINE_SIZE, cookie->numa_id);
 
 	if (cookie->dst_memzones == NULL) {
 		QAT_DP_LOG(ERR,
@@ -84,7 +84,7 @@ qat_comp_allocate_split_op_memzones(struct qat_comp_op_cookie *cookie,
 
 		cookie->dst_memzones[i] = rte_memzone_reserve_aligned(
 				dst_memz_name, RTE_PMD_QAT_COMP_IM_BUFFER_SIZE,
-				cookie->socket_id, RTE_MEMZONE_IOVA_CONTIG,
+				cookie->numa_id, RTE_MEMZONE_IOVA_CONTIG,
 				RTE_CACHE_LINE_SIZE);
 
 		if (cookie->dst_memzones[i] == NULL) {
@@ -211,11 +211,11 @@ qat_comp_build_request(void *in_op, uint8_t *out_msg,
 			/* we need to allocate more elements in SGL*/
 			void *tmp;
 
-			tmp = rte_realloc_socket(cookie->qat_sgl_src_d,
+			tmp = rte_realloc_numa(cookie->qat_sgl_src_d,
 					  sizeof(struct qat_sgl) +
 					  sizeof(struct qat_flat_buf) *
 					  op->m_src->nb_segs, 64,
-					  cookie->socket_id);
+					  cookie->numa_id);
 
 			if (unlikely(tmp == NULL)) {
 				QAT_DP_LOG(ERR, "QAT PMD can't allocate memory"
@@ -252,11 +252,11 @@ qat_comp_build_request(void *in_op, uint8_t *out_msg,
 			/* we need to allocate more elements in SGL*/
 			struct qat_sgl *tmp;
 
-			tmp = rte_realloc_socket(cookie->qat_sgl_dst_d,
+			tmp = rte_realloc_numa(cookie->qat_sgl_dst_d,
 					  sizeof(struct qat_sgl) +
 					  sizeof(struct qat_flat_buf) *
 					  op->m_dst->nb_segs, 64,
-					  cookie->socket_id);
+					  cookie->numa_id);
 
 			if (unlikely(tmp == NULL)) {
 				QAT_DP_LOG(ERR, "QAT PMD can't allocate memory"
diff --git a/drivers/compress/qat/qat_comp.h b/drivers/compress/qat/qat_comp.h
index 18d5fd4b02..016459f311 100644
--- a/drivers/compress/qat/qat_comp.h
+++ b/drivers/compress/qat/qat_comp.h
@@ -61,7 +61,7 @@ struct qat_comp_op_cookie {
 	phys_addr_t qat_sgl_dst_phys_addr;
 	/* dynamically created SGLs */
 	uint8_t error;
-	uint8_t socket_id;
+	uint8_t numa_id;
 	uint16_t src_nb_elems;
 	uint16_t dst_nb_elems;
 	struct qat_sgl *qat_sgl_src_d;
diff --git a/drivers/compress/qat/qat_comp_pmd.c b/drivers/compress/qat/qat_comp_pmd.c
index 5ac49318da..4a699e63b6 100644
--- a/drivers/compress/qat/qat_comp_pmd.c
+++ b/drivers/compress/qat/qat_comp_pmd.c
@@ -20,7 +20,7 @@ struct qat_comp_gen_dev_ops qat_comp_gen_dev_ops[QAT_N_GENS];
 
 struct stream_create_info {
 	struct qat_comp_dev_private *comp_dev;
-	int socket_id;
+	int numa_id;
 	int error;
 };
 
@@ -103,7 +103,7 @@ qat_comp_qp_release(struct rte_compressdev *dev, uint16_t queue_pair_id)
 
 int
 qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		uint32_t max_inflight_ops, int socket_id)
+		uint32_t max_inflight_ops, int numa_id)
 {
 	struct qat_qp_config qat_qp_conf = {0};
 	struct qat_qp **qp_addr =
@@ -135,7 +135,7 @@ qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 	}
 	qat_qp_conf.cookie_size = sizeof(struct qat_comp_op_cookie);
 	qat_qp_conf.nb_descriptors = max_inflight_ops;
-	qat_qp_conf.socket_id = socket_id;
+	qat_qp_conf.numa_id = numa_id;
 	qat_qp_conf.service_str = "comp";
 
 	ret = qat_qp_setup(qat_private->qat_dev, qp_addr, qp_id, &qat_qp_conf);
@@ -156,13 +156,13 @@ qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		cookie->qp = qp;
 		cookie->cookie_index = i;
 
-		cookie->qat_sgl_src_d = rte_zmalloc_socket(NULL,
+		cookie->qat_sgl_src_d = rte_zmalloc_numa(NULL,
 					sizeof(struct qat_sgl) +
 					sizeof(struct qat_flat_buf) *
 					QAT_PMD_COMP_SGL_DEF_SEGMENTS,
 					64, dev->data->numa_id);
 
-		cookie->qat_sgl_dst_d = rte_zmalloc_socket(NULL,
+		cookie->qat_sgl_dst_d = rte_zmalloc_numa(NULL,
 					sizeof(struct qat_sgl) +
 					sizeof(struct qat_flat_buf) *
 					QAT_PMD_COMP_SGL_DEF_SEGMENTS,
@@ -185,7 +185,7 @@ qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		cookie->dst_nb_elems = cookie->src_nb_elems =
 				QAT_PMD_COMP_SGL_DEF_SEGMENTS;
 
-		cookie->socket_id = dev->data->numa_id;
+		cookie->numa_id = dev->data->numa_id;
 
 		cookie->error = 0;
 	}
@@ -386,7 +386,7 @@ qat_comp_stream_init(struct rte_mempool *mp __rte_unused, void *opaque,
 			QAT_STATE_REGISTERS_MAX_SIZE
 				+ sizeof(struct qat_inter_sgl)
 				+ QAT_INFLATE_CONTEXT_SIZE,
-			info->socket_id,
+			info->numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, QAT_64_BYTE_ALIGN);
 		if (memzone == NULL) {
 			QAT_LOG(ERR,
@@ -428,7 +428,7 @@ qat_comp_stream_destroy(struct rte_mempool *mp __rte_unused,
 
 static struct rte_mempool *
 qat_comp_create_stream_pool(struct qat_comp_dev_private *comp_dev,
-			    int socket_id,
+			    int numa_id,
 			    uint32_t num_elements)
 {
 	char stream_pool_name[RTE_MEMPOOL_NAMESIZE];
@@ -454,14 +454,14 @@ qat_comp_create_stream_pool(struct qat_comp_dev_private *comp_dev,
 	if (mp == NULL) {
 		struct stream_create_info info = {
 			.comp_dev = comp_dev,
-			.socket_id = socket_id,
+			.numa_id = numa_id,
 			.error = 0
 		};
 		mp = rte_mempool_create(stream_pool_name,
 				num_elements,
 				qat_comp_stream_size(), 0, 0,
 				NULL, NULL, qat_comp_stream_init, &info,
-				socket_id, 0);
+				numa_id, 0);
 		if (mp == NULL) {
 			QAT_LOG(ERR,
 			     "Err creating mempool %s w %d elements of size %d",
@@ -758,7 +758,7 @@ qat_comp_dev_create(struct qat_pci_device *qat_pci_dev)
 	if (comp_dev->capa_mz == NULL) {
 		comp_dev->capa_mz = rte_memzone_reserve(capa_memz_name,
 			capa_size,
-			rte_socket_id(), 0);
+			rte_numa_id(), 0);
 	}
 	if (comp_dev->capa_mz == NULL) {
 		QAT_LOG(DEBUG,
diff --git a/drivers/compress/qat/qat_comp_pmd.h b/drivers/compress/qat/qat_comp_pmd.h
index 01a8983287..6506ba0e4e 100644
--- a/drivers/compress/qat/qat_comp_pmd.h
+++ b/drivers/compress/qat/qat_comp_pmd.h
@@ -100,7 +100,7 @@ qat_comp_qp_release(struct rte_compressdev *dev, uint16_t queue_pair_id);
 
 int
 qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		uint32_t max_inflight_ops, int socket_id);
+		uint32_t max_inflight_ops, int numa_id);
 
 const struct rte_memzone *
 qat_comp_setup_inter_buffers(struct qat_comp_dev_private *comp_dev,
diff --git a/drivers/crypto/qat/asym/qat_asym.c b/drivers/crypto/qat/asym/qat_asym.c
index 9276b86c0e..9630355a57 100644
--- a/drivers/crypto/qat/asym/qat_asym.c
+++ b/drivers/crypto/qat/asym/qat_asym.c
@@ -1700,7 +1700,7 @@ qat_asym_dev_create(struct qat_pci_device *qat_pci_dev)
 		&qat_pci_devs[qat_pci_dev->qat_dev_id];
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = qat_dev_instance->pci_dev->device.numa_node,
+		.numa_id = qat_dev_instance->pci_dev->device.numa_node,
 		.private_data_size = sizeof(struct qat_cryptodev_private)
 	};
 	const struct qat_crypto_gen_dev_ops *gen_dev_ops =
diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
index c96608dd37..d4408a17c4 100644
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
@@ -65,7 +65,7 @@ qat_asym_crypto_cap_get_gen1(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
index 89c51c8f80..3982995901 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
@@ -139,13 +139,13 @@ static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen2[] = {
 
 static int
 qat_sym_crypto_qp_setup_gen2(struct rte_cryptodev *dev, uint16_t qp_id,
-		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
+		const struct rte_cryptodev_qp_conf *qp_conf, int numa_id)
 {
 	struct qat_cryptodev_private *qat_sym_private = dev->data->dev_private;
 	struct qat_qp *qp;
 	int ret;
 
-	if (qat_cryptodev_qp_setup(dev, qp_id, qp_conf, socket_id)) {
+	if (qat_cryptodev_qp_setup(dev, qp_id, qp_conf, numa_id)) {
 		QAT_LOG(DEBUG, "QAT qp setup failed");
 		return -1;
 	}
@@ -296,7 +296,7 @@ qat_sym_crypto_cap_get_gen2(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index 91546046f1..eaa2cbd809 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -211,7 +211,7 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 41cad29142..b7cba0c2a0 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -178,7 +178,7 @@ qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
@@ -216,7 +216,7 @@ qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
index 2680116d6e..4a32d17feb 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -147,7 +147,7 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c
index 7f810cfcc1..ba887fdf47 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c
@@ -84,7 +84,7 @@ qat_sym_crypto_cap_get_gen6(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
index ec075bbf68..410d566389 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
@@ -267,7 +267,7 @@ qat_sym_crypto_cap_get_gen_lce(struct qat_cryptodev_private *internals,
 
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
-		internals->capa_mz = rte_memzone_reserve(capa_memz_name, size, rte_socket_id(), 0);
+		internals->capa_mz = rte_memzone_reserve(capa_memz_name, size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG, "Error allocating memzone for capabilities");
 			return -1;
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
index 6da0f6c645..d96eeab734 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -170,7 +170,7 @@ qat_sym_crypto_cap_get_gen1(struct qat_cryptodev_private *internals,
 	internals->capa_mz = rte_memzone_lookup(capa_memz_name);
 	if (internals->capa_mz == NULL) {
 		internals->capa_mz = rte_memzone_reserve(capa_memz_name,
-				size, rte_socket_id(), 0);
+				size, rte_numa_id(), 0);
 		if (internals->capa_mz == NULL) {
 			QAT_LOG(DEBUG,
 				"Error allocating memzone for capabilities");
diff --git a/drivers/crypto/qat/qat_crypto.c b/drivers/crypto/qat/qat_crypto.c
index daa36c5eed..88e73efd96 100644
--- a/drivers/crypto/qat/qat_crypto.c
+++ b/drivers/crypto/qat/qat_crypto.c
@@ -120,7 +120,7 @@ qat_cryptodev_qp_release(struct rte_cryptodev *dev, uint16_t queue_pair_id)
 
 int
 qat_cryptodev_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
-	const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
+	const struct rte_cryptodev_qp_conf *qp_conf, int numa_id)
 {
 	struct qat_qp **qp_addr =
 			(struct qat_qp **)&(dev->data->queue_pairs[qp_id]);
@@ -154,7 +154,7 @@ qat_cryptodev_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			sizeof(struct qat_sym_op_cookie) :
 			sizeof(struct qat_asym_op_cookie);
 	qat_qp_conf.nb_descriptors = qp_conf->nb_descriptors;
-	qat_qp_conf.socket_id = socket_id;
+	qat_qp_conf.numa_id = numa_id;
 	qat_qp_conf.service_str = qat_service_get_str(service_type);
 
 	ret = qat_qp_setup(qat_dev, qp_addr, qp_id, &qat_qp_conf);
diff --git a/drivers/crypto/qat/qat_crypto.h b/drivers/crypto/qat/qat_crypto.h
index fcd62eda27..1b390047d0 100644
--- a/drivers/crypto/qat/qat_crypto.h
+++ b/drivers/crypto/qat/qat_crypto.h
@@ -94,7 +94,7 @@ qat_cryptodev_stats_reset(struct rte_cryptodev *dev);
 
 int
 qat_cryptodev_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
-	const struct rte_cryptodev_qp_conf *qp_conf, int socket_id);
+	const struct rte_cryptodev_qp_conf *qp_conf, int numa_id);
 
 int
 qat_cryptodev_qp_release(struct rte_cryptodev *dev, uint16_t queue_pair_id);
diff --git a/drivers/crypto/qat/qat_sym.c b/drivers/crypto/qat/qat_sym.c
index 83f1084030..21fdf7c44c 100644
--- a/drivers/crypto/qat/qat_sym.c
+++ b/drivers/crypto/qat/qat_sym.c
@@ -206,7 +206,7 @@ qat_sym_dev_create(struct qat_pci_device *qat_pci_dev)
 			&qat_pci_devs[qat_pci_dev->qat_dev_id];
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = qat_dev_instance->pci_dev->device.numa_node,
+		.numa_id = qat_dev_instance->pci_dev->device.numa_node,
 		.private_data_size = sizeof(struct qat_cryptodev_private)
 	};
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 37654918b5..bba466562c 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -4642,7 +4642,7 @@ flow_action_handles_translate(struct rte_eth_dev *dev,
 	if (!copied_n)
 		return 0;
 	actions_size = sizeof(struct rte_flow_action) * n;
-	translated = mlx5_malloc(MLX5_MEM_ZERO, actions_size, 0, SOCKET_ID_ANY);
+	translated = mlx5_malloc(MLX5_MEM_ZERO, actions_size, 0, RTE_NUMA_ID_ANY);
 	if (!translated) {
 		rte_errno = ENOMEM;
 		return -ENOMEM;
@@ -6683,7 +6683,7 @@ flow_create_split_metadata(struct rte_eth_dev *dev,
 			   sizeof(struct rte_flow_action_set_tag) +
 			   sizeof(struct rte_flow_action_jump);
 		ext_actions = mlx5_malloc(MLX5_MEM_ZERO, act_size, 0,
-					  SOCKET_ID_ANY);
+					  RTE_NUMA_ID_ANY);
 		if (!ext_actions)
 			return rte_flow_error_set(error, ENOMEM,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
@@ -6710,7 +6710,7 @@ flow_create_split_metadata(struct rte_eth_dev *dev,
 		act_size = sizeof(struct rte_flow_action) * (actions_n + 1) +
 			   sizeof(struct mlx5_flow_action_copy_mreg);
 		ext_actions = mlx5_malloc(MLX5_MEM_ZERO, act_size, 0,
-					  SOCKET_ID_ANY);
+					  RTE_NUMA_ID_ANY);
 		if (!ext_actions)
 			return rte_flow_error_set(error, ENOMEM,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
@@ -6998,7 +6998,7 @@ flow_create_split_meter(struct rte_eth_dev *dev,
 		item_size = sizeof(struct rte_flow_item) * (METER_SUFFIX_ITEM + vlan_items_n) +
 			    sizeof(struct mlx5_rte_flow_item_tag) * 2;
 		sfx_actions = mlx5_malloc(MLX5_MEM_ZERO, (act_size + item_size),
-					  0, SOCKET_ID_ANY);
+					  0, RTE_NUMA_ID_ANY);
 		if (!sfx_actions)
 			return rte_flow_error_set(error, ENOMEM,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
@@ -7148,7 +7148,7 @@ flow_create_split_sample(struct rte_eth_dev *dev,
 		item_size = sizeof(struct rte_flow_item) * SAMPLE_SUFFIX_ITEM +
 			    sizeof(struct mlx5_rte_flow_item_tag) * 2;
 		sfx_actions = mlx5_malloc(MLX5_MEM_ZERO, (act_size +
-					  item_size), 0, SOCKET_ID_ANY);
+					  item_size), 0, RTE_NUMA_ID_ANY);
 		if (!sfx_actions)
 			return rte_flow_error_set(error, ENOMEM,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
@@ -7767,7 +7767,7 @@ mlx5_flow_cache_flow_info(struct rte_eth_dev *dev,
 	struct rte_flow_error error;
 	int len, ret;
 
-	flow_info = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*flow_info), 0, SOCKET_ID_ANY);
+	flow_info = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*flow_info), 0, RTE_NUMA_ID_ANY);
 	if (!flow_info) {
 		DRV_LOG(ERR, "No enough memory for flow_info caching.");
 		return -1;
@@ -7784,7 +7784,7 @@ mlx5_flow_cache_flow_info(struct rte_eth_dev *dev,
 		goto end;
 	}
 	len = RTE_ALIGN(ret, 16);
-	flow_info->items = mlx5_malloc(MLX5_MEM_ZERO, len, 0, SOCKET_ID_ANY);
+	flow_info->items = mlx5_malloc(MLX5_MEM_ZERO, len, 0, RTE_NUMA_ID_ANY);
 	if (!flow_info->items) {
 		DRV_LOG(ERR, "No enough memory for items caching.");
 		goto end;
@@ -7802,7 +7802,7 @@ mlx5_flow_cache_flow_info(struct rte_eth_dev *dev,
 		goto end;
 	}
 	len = RTE_ALIGN(ret, 16);
-	flow_info->actions = mlx5_malloc(MLX5_MEM_ZERO, len, 0, SOCKET_ID_ANY);
+	flow_info->actions = mlx5_malloc(MLX5_MEM_ZERO, len, 0, RTE_NUMA_ID_ANY);
 	if (!flow_info->actions) {
 		DRV_LOG(ERR, "No enough memory for actions caching.");
 		goto end;
@@ -8557,7 +8557,8 @@ mlx5_ctrl_flow_vlan(struct rte_eth_dev *dev,
 	for (i = 0; i != priv->reta_idx_n; ++i)
 		queue[i] = (*priv->reta_idx)[i];
 
-	entry = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*entry), alignof(typeof(*entry)), SOCKET_ID_ANY);
+	entry = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*entry), alignof(typeof(*entry)),
+				RTE_NUMA_ID_ANY);
 	if (entry == NULL) {
 		rte_errno = ENOMEM;
 		goto err;
@@ -9670,7 +9671,7 @@ mlx5_flow_create_counter_stat_mem_mng(struct mlx5_dev_ctx_shared *sh)
 		rte_errno = ENOMEM;
 		return -ENOMEM;
 	}
-	mem = mlx5_malloc(MLX5_MEM_ZERO, size, pgsize, SOCKET_ID_ANY);
+	mem = mlx5_malloc(MLX5_MEM_ZERO, size, pgsize, RTE_NUMA_ID_ANY);
 	if (!mem) {
 		rte_errno = ENOMEM;
 		return -ENOMEM;
@@ -11175,7 +11176,7 @@ flow_tunnel_add_default_miss(struct rte_eth_dev *dev,
 		miss_actions[1].type = RTE_FLOW_ACTION_TYPE_RSS;
 		q_size = priv->reta_idx_n * sizeof(ctx->queue[0]);
 		ctx->queue = mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO, q_size,
-					 0, SOCKET_ID_ANY);
+					 0, RTE_NUMA_ID_ANY);
 		if (!ctx->queue)
 			return rte_flow_error_set
 				(error, ENOMEM,
@@ -11304,7 +11305,7 @@ mlx5_flow_tunnel_grp2tbl_create_cb(void *tool_ctx, void *cb_ctx)
 
 	tte = mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO,
 			  sizeof(*tte), 0,
-			  SOCKET_ID_ANY);
+			  RTE_NUMA_ID_ANY);
 	if (!tte)
 		goto err;
 	mlx5_ipool_malloc(sh->ipool[MLX5_IPOOL_TNL_TBL_ID],
@@ -11334,7 +11335,7 @@ mlx5_flow_tunnel_grp2tbl_clone_cb(void *tool_ctx __rte_unused,
 				  void *cb_ctx __rte_unused)
 {
 	struct tunnel_tbl_entry *tte = mlx5_malloc(MLX5_MEM_SYS, sizeof(*tte),
-						   0, SOCKET_ID_ANY);
+						   0, RTE_NUMA_ID_ANY);
 
 	if (!tte)
 		return NULL;
@@ -11588,7 +11589,7 @@ int mlx5_alloc_tunnel_hub(struct mlx5_dev_ctx_shared *sh)
 	struct mlx5_flow_tunnel_hub *thub;
 
 	thub = mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO, sizeof(*thub),
-			   0, SOCKET_ID_ANY);
+			   0, RTE_NUMA_ID_ANY);
 	if (!thub)
 		return -ENOMEM;
 	LIST_INIT(&thub->tunnels);
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 25dba7f4d9..e525cc853d 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -994,7 +994,7 @@ mlx5_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	}
 	/* Allocate RXQ. */
 	rxq = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*rxq), 0,
-			  SOCKET_ID_ANY);
+			  RTE_NUMA_ID_ANY);
 	if (!rxq) {
 		DRV_LOG(ERR, "port %u unable to allocate rx queue index %u private data",
 			dev->data->port_id, idx);
@@ -1083,7 +1083,7 @@ mlx5_rx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t idx,
 		}
 	}
 	rxq = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*rxq), 0,
-			  SOCKET_ID_ANY);
+			  RTE_NUMA_ID_ANY);
 	if (!rxq) {
 		DRV_LOG(ERR, "port %u unable to allocate hairpin rx queue index %u private data",
 			dev->data->port_id, idx);
@@ -1875,7 +1875,7 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		desc >>= mprq_log_actual_stride_num;
 		alloc_size += desc * sizeof(struct mlx5_mprq_buf *);
 	}
-	if (socket != (unsigned int)SOCKET_ID_ANY) {
+	if (socket != (unsigned int)RTE_NUMA_ID_ANY) {
 		tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0, socket);
 	} else {
 		tmpl = mlx5_malloc_numa_tolerant(MLX5_MEM_RTE | MLX5_MEM_ZERO, alloc_size, 0,
@@ -1983,7 +1983,7 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		goto error;
 	}
 	tmpl->is_hairpin = false;
-	if (socket != (unsigned int)SOCKET_ID_ANY) {
+	if (socket != (unsigned int)RTE_NUMA_ID_ANY) {
 		if (mlx5_mr_ctrl_init(&tmpl->rxq.mr_ctrl,
 					&priv->sh->cdev->mr_scache.dev_gen, socket))
 			/* rte_errno is already set. */
@@ -1993,13 +1993,14 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 					&priv->sh->cdev->mr_scache.dev_gen, dev->device->numa_node);
 		if (ret == -ENOMEM) {
 			ret = mlx5_mr_ctrl_init(&tmpl->rxq.mr_ctrl,
-						&priv->sh->cdev->mr_scache.dev_gen, SOCKET_ID_ANY);
+						&priv->sh->cdev->mr_scache.dev_gen,
+							RTE_NUMA_ID_ANY);
 		}
 		if (ret)
 			/* rte_errno is already set. */
 			goto error;
 	}
-	tmpl->socket = (socket == (unsigned int)SOCKET_ID_ANY ?
+	tmpl->socket = (socket == (unsigned int)RTE_NUMA_ID_ANY ?
 			(unsigned int)dev->device->numa_node : socket);
 	if (dev->data->dev_conf.intr_conf.rxq)
 		tmpl->irq = 1;
@@ -2159,7 +2160,7 @@ mlx5_rxq_hairpin_new(struct rte_eth_dev *dev, struct mlx5_rxq_priv *rxq,
 	struct mlx5_rxq_ctrl *tmpl;
 
 	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl), 0,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 	if (!tmpl) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -2168,7 +2169,7 @@ mlx5_rxq_hairpin_new(struct rte_eth_dev *dev, struct mlx5_rxq_priv *rxq,
 	rxq->ctrl = tmpl;
 	LIST_INSERT_HEAD(&tmpl->owners, rxq, owner_entry);
 	tmpl->is_hairpin = true;
-	tmpl->socket = SOCKET_ID_ANY;
+	tmpl->socket = RTE_NUMA_ID_ANY;
 	tmpl->rxq.rss_hash = 0;
 	tmpl->rxq.port_id = dev->data->port_id;
 	tmpl->sh = priv->sh;
@@ -2769,7 +2770,7 @@ mlx5_ind_table_obj_new(struct rte_eth_dev *dev, const uint16_t *queues,
 	 */
 	ind_tbl = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*ind_tbl) +
 			      (standalone ? max_queues_n : queues_n) *
-			      sizeof(uint16_t), 0, SOCKET_ID_ANY);
+			      sizeof(uint16_t), 0, RTE_NUMA_ID_ANY);
 	if (!ind_tbl) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -3276,7 +3277,8 @@ mlx5_drop_action_create(struct rte_eth_dev *dev)
 
 	if (priv->drop_queue.hrxq)
 		return priv->drop_queue.hrxq;
-	hrxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hrxq) + MLX5_RSS_HASH_KEY_LEN, 0, SOCKET_ID_ANY);
+	hrxq = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hrxq) + MLX5_RSS_HASH_KEY_LEN,
+			0, RTE_NUMA_ID_ANY);
 	if (!hrxq) {
 		DRV_LOG(WARNING,
 			"Port %u cannot allocate memory for drop queue.",
@@ -3286,7 +3288,7 @@ mlx5_drop_action_create(struct rte_eth_dev *dev)
 	}
 	priv->drop_queue.hrxq = hrxq;
 	hrxq->ind_table = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*hrxq->ind_table),
-				      0, SOCKET_ID_ANY);
+				      0, RTE_NUMA_ID_ANY);
 	if (!hrxq->ind_table) {
 		rte_errno = ENOMEM;
 		goto error;
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index aa43cb1612..e2c85f389c 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1128,7 +1128,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	uint16_t max_wqe;
 	uint32_t wqebb_cnt, log_desc_n;
 
-	if (socket != (unsigned int)SOCKET_ID_ANY) {
+	if (socket != (unsigned int)RTE_NUMA_ID_ANY) {
 		tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl) +
 			   desc * sizeof(struct rte_mbuf *), 0, socket);
 	} else {
@@ -1140,7 +1140,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		rte_errno = ENOMEM;
 		return NULL;
 	}
-	if (socket != (unsigned int)SOCKET_ID_ANY) {
+	if (socket != (unsigned int)RTE_NUMA_ID_ANY) {
 		if (mlx5_mr_ctrl_init(&tmpl->txq.mr_ctrl,
 					&priv->sh->cdev->mr_scache.dev_gen, socket))
 			/* rte_errno is already set. */
@@ -1150,7 +1150,8 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 					&priv->sh->cdev->mr_scache.dev_gen, dev->device->numa_node);
 		if (ret == -ENOMEM) {
 			ret = mlx5_mr_ctrl_init(&tmpl->txq.mr_ctrl,
-						&priv->sh->cdev->mr_scache.dev_gen, SOCKET_ID_ANY);
+						&priv->sh->cdev->mr_scache.dev_gen,
+							RTE_NUMA_ID_ANY);
 		}
 		if (ret)
 			/* rte_errno is already set. */
@@ -1160,7 +1161,7 @@ mlx5_txq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	tmpl->txq.offloads = conf->offloads |
 			     dev->data->dev_conf.txmode.offloads;
 	tmpl->priv = priv;
-	tmpl->socket = (socket == (unsigned int)SOCKET_ID_ANY ?
+	tmpl->socket = (socket == (unsigned int)RTE_NUMA_ID_ANY ?
 			(unsigned int)dev->device->numa_node : socket);
 	tmpl->txq.elts_n = log2above(desc);
 	tmpl->txq.elts_s = desc;
@@ -1221,13 +1222,13 @@ mlx5_txq_hairpin_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 	struct mlx5_txq_ctrl *tmpl;
 
 	tmpl = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO, sizeof(*tmpl), 0,
-			   SOCKET_ID_ANY);
+			   RTE_NUMA_ID_ANY);
 	if (!tmpl) {
 		rte_errno = ENOMEM;
 		return NULL;
 	}
 	tmpl->priv = priv;
-	tmpl->socket = SOCKET_ID_ANY;
+	tmpl->socket = RTE_NUMA_ID_ANY;
 	tmpl->txq.elts_n = log2above(desc);
 	tmpl->txq.port_id = dev->data->port_id;
 	tmpl->txq.idx = idx;
-- 
2.55.0

