Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBA606C85A
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=licb6dbl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2ADD4114B;
	Tue,  3 Nov 2026 15:54:20 +0100 (CET)
Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
 by mails.dpdk.org (Postfix) with ESMTPS id 91D9A4111B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:19 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=DGTCS+ZvBsmCtqJ7IZtRJCgDg5Z/XN+2L17gCmJow40=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717659; v=1; x=1794322459;
 b=licb6dblv+e9msGR22fX/7RJkygMseuYDwCAvJ9cFYep3ci7i5Qsqk/6Iy4emEbsyCv4I0sk
 lMCaIgCCxLQ5SpHHCEym8usfi/+iJzHKY+XyR0zPa/xnryMLPtc8gPV75DhL3gfanNvv4wNr1YZ
 W7BnewRzjGwFz4yo4jEb7EQw=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 3d9333e66d5a154f;
 Tue, 03 Nov 2026 14:54:19 +0000
X-Mizu-Trace-ID: 3d9333e66d5a154f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 008/227] compressdev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:26 +0800
Message-ID: <20261103145306.487255-9-chengwen.feng@linux.dev>
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

Rename the exported function rte_compressdev_socket_id() to
rte_compressdev_numa_id(), keeping the old name as a functional
alias to be deprecated once the in-tree migration completes.

Rename the numa_id field of rte_compressdev_config (was socket_id),
keeping socket_id as a deprecated union alias, and update in-tree
users accordingly.

Also rename internal parameters and comments to the NUMA node
terminology.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 doc/guides/rel_notes/deprecation.rst          |  2 +-
 drivers/compress/isal/isal_compress_pmd_ops.c |  2 +-
 drivers/compress/mlx5/mlx5_compress.c         |  4 +--
 drivers/compress/nitrox/nitrox_comp.c         |  8 ++---
 drivers/compress/qat/qat_comp_pmd.c           | 16 ++++-----
 drivers/compress/zlib/zlib_pmd_ops.c          |  4 +--
 drivers/compress/zsda/zsda_comp_pmd.c         |  4 +--
 lib/compressdev/rte_comp.c                    |  4 +--
 lib/compressdev/rte_comp.h                    |  4 +--
 lib/compressdev/rte_compressdev.c             | 35 +++++++++++--------
 lib/compressdev/rte_compressdev.h             | 34 ++++++++++++++----
 lib/compressdev/rte_compressdev_internal.h    |  2 +-
 lib/compressdev/rte_compressdev_pmd.c         | 10 +++---
 lib/compressdev/rte_compressdev_pmd.h         | 12 +++----
 14 files changed, 85 insertions(+), 56 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index a6ff573d18..297ce8415c 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -22,7 +22,7 @@ Deprecation Notices
   as a deprecated union alias.
   The following structures are affected: ``rte_hash_parameters``,
   ``rte_fbk_hash_params``, ``rte_member_parameters`` /
-  ``rte_member_setsum`` and ``rte_mempool``
+  ``rte_member_setsum``, ``rte_mempool`` and ``rte_compressdev_config``
   (more structures will follow in this release).
   Applications should switch to ``numa_id``.
 
diff --git a/drivers/compress/isal/isal_compress_pmd_ops.c b/drivers/compress/isal/isal_compress_pmd_ops.c
index 9b42147a0b..be32a4c998 100644
--- a/drivers/compress/isal/isal_compress_pmd_ops.c
+++ b/drivers/compress/isal/isal_compress_pmd_ops.c
@@ -73,7 +73,7 @@ isal_comp_pmd_config(struct rte_compressdev *dev,
 				NULL, /* obj initialization constructor arg */
 				NULL, /**< obj constructor*/
 				NULL, /* obj constructor arg */
-				config->socket_id, /* socket id */
+				config->numa_id, /* socket id */
 				0); /* flags */
 	}
 
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index 1361dab630..d122715672 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -179,7 +179,7 @@ mlx5_compress_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 	}
 	dev->data->queue_pairs[qp_id] = qp;
 	if (mlx5_mr_ctrl_init(&qp->mr_ctrl, &priv->cdev->mr_scache.dev_gen,
-			      priv->dev_config.socket_id)) {
+			      priv->dev_config.numa_id)) {
 		DRV_LOG(ERR, "Cannot allocate MR Btree for qp %u.",
 			(uint32_t)qp_id);
 		rte_errno = ENOMEM;
@@ -369,7 +369,7 @@ mlx5_compress_xform_create(struct rte_compressdev *dev,
 	if (ret < 0)
 		return ret;
 	xfrm = rte_zmalloc_socket(__func__, sizeof(*xfrm), 0,
-						    priv->dev_config.socket_id);
+						    priv->dev_config.numa_id);
 	if (xfrm == NULL)
 		return -ENOMEM;
 	xfrm->opcode = MLX5_OPCODE_MMO;
diff --git a/drivers/compress/nitrox/nitrox_comp.c b/drivers/compress/nitrox/nitrox_comp.c
index 41a3ee0de8..56a90a35c5 100644
--- a/drivers/compress/nitrox/nitrox_comp.c
+++ b/drivers/compress/nitrox/nitrox_comp.c
@@ -68,7 +68,7 @@ static int nitrox_comp_dev_configure(struct rte_compressdev *dev,
 	comp_dev->xform_pool = rte_mempool_create(name,
 			xform_cnt, sizeof(struct nitrox_comp_xform),
 			0, 0, NULL, NULL, NULL, NULL,
-			config->socket_id, 0);
+			config->numa_id, 0);
 	if (comp_dev->xform_pool == NULL) {
 		NITROX_LOG_LINE(ERR, "Failed to create xform pool, err %d",
 			   rte_errno);
@@ -411,7 +411,7 @@ static int nitrox_comp_stream_create(struct rte_compressdev *dev,
 	}
 
 	nxform->history_window = rte_zmalloc_socket(NULL, nxform->window_size,
-					8, comp_dev->xform_pool->socket_id);
+					8, comp_dev->xform_pool->numa_id);
 	if (unlikely(nxform->history_window == NULL)) {
 		err = -ENOMEM;
 		goto err_exit;
@@ -422,7 +422,7 @@ static int nitrox_comp_stream_create(struct rte_compressdev *dev,
 
 	nxform->context = rte_zmalloc_socket(NULL,
 					NITROX_DECOMP_CTX_SIZE, 8,
-					comp_dev->xform_pool->socket_id);
+					comp_dev->xform_pool->numa_id);
 	if (unlikely(nxform->context == NULL)) {
 		err = -ENOMEM;
 		goto err_exit;
@@ -553,7 +553,7 @@ nitrox_comp_pmd_create(struct nitrox_device *ndev)
 	char name[RTE_COMPRESSDEV_NAME_MAX_LEN];
 	struct rte_compressdev_pmd_init_params init_params = {
 			.name = "",
-			.socket_id = ndev->pdev->device.numa_node,
+			.numa_id = ndev->pdev->device.numa_node,
 	};
 	struct rte_compressdev *cdev;
 
diff --git a/drivers/compress/qat/qat_comp_pmd.c b/drivers/compress/qat/qat_comp_pmd.c
index 92dac79423..5ac49318da 100644
--- a/drivers/compress/qat/qat_comp_pmd.c
+++ b/drivers/compress/qat/qat_comp_pmd.c
@@ -160,13 +160,13 @@ qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 					sizeof(struct qat_sgl) +
 					sizeof(struct qat_flat_buf) *
 					QAT_PMD_COMP_SGL_DEF_SEGMENTS,
-					64, dev->data->socket_id);
+					64, dev->data->numa_id);
 
 		cookie->qat_sgl_dst_d = rte_zmalloc_socket(NULL,
 					sizeof(struct qat_sgl) +
 					sizeof(struct qat_flat_buf) *
 					QAT_PMD_COMP_SGL_DEF_SEGMENTS,
-					64, dev->data->socket_id);
+					64, dev->data->numa_id);
 
 		if (cookie->qat_sgl_src_d == NULL ||
 				cookie->qat_sgl_dst_d == NULL) {
@@ -185,7 +185,7 @@ qat_comp_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		cookie->dst_nb_elems = cookie->src_nb_elems =
 				QAT_PMD_COMP_SGL_DEF_SEGMENTS;
 
-		cookie->socket_id = dev->data->socket_id;
+		cookie->socket_id = dev->data->numa_id;
 
 		cookie->error = 0;
 	}
@@ -240,7 +240,7 @@ qat_comp_setup_inter_buffers(struct qat_comp_dev_private *comp_dev,
 
 	memzone = rte_memzone_reserve_aligned(inter_buff_mz_name,
 			size_of_ptr_array,
-			comp_dev->compressdev->data->socket_id,
+			comp_dev->compressdev->data->numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, QAT_64_BYTE_ALIGN);
 	if (memzone == NULL) {
 		QAT_LOG(ERR,
@@ -268,7 +268,7 @@ qat_comp_setup_inter_buffers(struct qat_comp_dev_private *comp_dev,
 		if (mz == NULL) {
 			mz = rte_memzone_reserve_aligned(inter_buff_mz_name,
 					full_size,
-					comp_dev->compressdev->data->socket_id,
+					comp_dev->compressdev->data->numa_id,
 					RTE_MEMZONE_IOVA_CONTIG,
 					QAT_64_BYTE_ALIGN);
 			if (mz == NULL) {
@@ -355,7 +355,7 @@ qat_comp_create_xform_pool(struct qat_comp_dev_private *comp_dev,
 		mp = rte_mempool_create(xform_pool_name,
 				num_elements,
 				qat_comp_xform_size(), 0, 0,
-				NULL, NULL, NULL, NULL, config->socket_id,
+				NULL, NULL, NULL, NULL, config->numa_id,
 				0);
 	if (mp == NULL) {
 		QAT_LOG(ERR, "Err creating mempool %s w %d elements of size %d",
@@ -534,7 +534,7 @@ qat_comp_dev_config(struct rte_compressdev *dev,
 
 	if (config->max_nb_streams) {
 		comp_dev->streampool = qat_comp_create_stream_pool(comp_dev,
-				     config->socket_id, config->max_nb_streams);
+				     config->numa_id, config->max_nb_streams);
 		if (comp_dev->streampool == NULL) {
 			ret = -ENOMEM;
 			goto error_out;
@@ -678,7 +678,7 @@ qat_comp_dev_create(struct qat_pci_device *qat_pci_dev)
 			&qat_pci_devs[qat_pci_dev->qat_dev_id];
 	struct rte_compressdev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = qat_dev_instance->pci_dev->device.numa_node,
+		.numa_id = qat_dev_instance->pci_dev->device.numa_node,
 	};
 	char name[RTE_COMPRESSDEV_NAME_MAX_LEN];
 	char capa_memz_name[RTE_COMPRESSDEV_NAME_MAX_LEN];
diff --git a/drivers/compress/zlib/zlib_pmd_ops.c b/drivers/compress/zlib/zlib_pmd_ops.c
index a530d15119..fb9cec8488 100644
--- a/drivers/compress/zlib/zlib_pmd_ops.c
+++ b/drivers/compress/zlib/zlib_pmd_ops.c
@@ -45,11 +45,11 @@ zlib_pmd_config(struct rte_compressdev *dev,
 				config->max_nb_streams,
 				sizeof(struct zlib_priv_xform),
 				0, 0, NULL, NULL, NULL,
-				NULL, config->socket_id,
+				NULL, config->numa_id,
 				0);
 		if (mp == NULL) {
 			ZLIB_PMD_ERR("Cannot create private xform pool on socket %d",
-				config->socket_id);
+				config->numa_id);
 			return -ENOMEM;
 		}
 		internals->mp = mp;
diff --git a/drivers/compress/zsda/zsda_comp_pmd.c b/drivers/compress/zsda/zsda_comp_pmd.c
index 80d92a47dd..6d857be2f0 100644
--- a/drivers/compress/zsda/zsda_comp_pmd.c
+++ b/drivers/compress/zsda/zsda_comp_pmd.c
@@ -55,7 +55,7 @@ zsda_comp_xform_pool_create(struct zsda_comp_dev_private *comp_dev,
 	} else {
 		mp = rte_mempool_create(xform_pool_name, num_elements,
 					zsda_comp_xform_size(), 0, 0, NULL,
-					NULL, NULL, NULL, config->socket_id, 0);
+					NULL, NULL, NULL, config->numa_id, 0);
 		if (mp == NULL) {
 			ZSDA_LOG(ERR, "Failed! mp is NULL");
 			return NULL;
@@ -332,7 +332,7 @@ zsda_comp_dev_create(struct zsda_pci_device *zsda_pci_dev)
 
 	struct rte_compressdev_pmd_init_params init_params = {
 		.name = "",
-		.socket_id = (int)rte_socket_id(),
+		.numa_id = (int)rte_numa_id(),
 	};
 
 	char name[RTE_COMPRESSDEV_NAME_MAX_LEN];
diff --git a/lib/compressdev/rte_comp.c b/lib/compressdev/rte_comp.c
index 662691796a..d15af0aac3 100644
--- a/lib/compressdev/rte_comp.c
+++ b/lib/compressdev/rte_comp.c
@@ -129,7 +129,7 @@ RTE_EXPORT_SYMBOL(rte_comp_op_pool_create)
 struct rte_mempool *
 rte_comp_op_pool_create(const char *name,
 		unsigned int nb_elts, unsigned int cache_size,
-		uint16_t user_size, int socket_id)
+		uint16_t user_size, int numa_id)
 {
 	struct rte_comp_op_pool_private *priv;
 
@@ -165,7 +165,7 @@ rte_comp_op_pool_create(const char *name,
 			NULL,
 			rte_comp_op_init,
 			NULL,
-			socket_id,
+			numa_id,
 			0);
 
 	if (mp == NULL) {
diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
index 6384a388d4..92ce76e0da 100644
--- a/lib/compressdev/rte_comp.h
+++ b/lib/compressdev/rte_comp.h
@@ -527,7 +527,7 @@ rte_comp_op_free(struct rte_comp_op *op);
  *   *rte_mempool_create* for further details about cache size
  * @param user_size
  *   Size of private data to allocate for user with each operation
- * @param socket_id
+ * @param numa_id
  *   Socket to identifier allocate memory on
  * @return
  *  - On success pointer to mempool
@@ -536,7 +536,7 @@ rte_comp_op_free(struct rte_comp_op *op);
 struct rte_mempool *
 rte_comp_op_pool_create(const char *name,
 		unsigned int nb_elts, unsigned int cache_size,
-		uint16_t user_size, int socket_id)
+		uint16_t user_size, int numa_id)
 	__rte_malloc __rte_dealloc(rte_comp_op_free, 1);
 
 /**
diff --git a/lib/compressdev/rte_compressdev.c b/lib/compressdev/rte_compressdev.c
index 790b2cd658..b23f83a103 100644
--- a/lib/compressdev/rte_compressdev.c
+++ b/lib/compressdev/rte_compressdev.c
@@ -184,9 +184,9 @@ rte_compressdev_devices_get(const char *driver_name, uint8_t *devices,
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_compressdev_socket_id)
+RTE_EXPORT_SYMBOL(rte_compressdev_numa_id)
 int
-rte_compressdev_socket_id(uint8_t dev_id)
+rte_compressdev_numa_id(uint8_t dev_id)
 {
 	struct rte_compressdev *dev;
 
@@ -195,12 +195,19 @@ rte_compressdev_socket_id(uint8_t dev_id)
 
 	dev = rte_compressdev_get_dev(dev_id);
 
-	return dev->data->socket_id;
+	return dev->data->numa_id;
+}
+
+RTE_EXPORT_SYMBOL(rte_compressdev_socket_id)
+int
+rte_compressdev_socket_id(uint8_t dev_id)
+{
+	return rte_compressdev_numa_id(dev_id);
 }
 
 static inline int
 rte_compressdev_data_alloc(uint8_t dev_id, struct rte_compressdev_data **data,
-		int socket_id)
+		int numa_id)
 {
 	char mz_name[RTE_COMPRESSDEV_NAME_MAX_LEN];
 	const struct rte_memzone *mz;
@@ -215,7 +222,7 @@ rte_compressdev_data_alloc(uint8_t dev_id, struct rte_compressdev_data **data,
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve(mz_name,
 				sizeof(struct rte_compressdev_data),
-				socket_id, 0);
+				numa_id, 0);
 	} else
 		mz = rte_memzone_lookup(mz_name);
 
@@ -244,7 +251,7 @@ rte_compressdev_find_free_device_index(void)
 
 RTE_EXPORT_SYMBOL(rte_compressdev_pmd_allocate)
 struct rte_compressdev *
-rte_compressdev_pmd_allocate(const char *name, int socket_id)
+rte_compressdev_pmd_allocate(const char *name, int numa_id)
 {
 	struct rte_compressdev *compressdev;
 	uint8_t dev_id;
@@ -267,7 +274,7 @@ rte_compressdev_pmd_allocate(const char *name, int socket_id)
 				compressdev_globals.data[dev_id];
 
 		int retval = rte_compressdev_data_alloc(dev_id,
-				&compressdev_data, socket_id);
+				&compressdev_data, numa_id);
 
 		if (retval < 0 || compressdev_data == NULL)
 			return NULL;
@@ -278,7 +285,7 @@ rte_compressdev_pmd_allocate(const char *name, int socket_id)
 			RTE_COMPRESSDEV_NAME_MAX_LEN);
 
 		compressdev->data->dev_id = dev_id;
-		compressdev->data->socket_id = socket_id;
+		compressdev->data->numa_id = numa_id;
 		compressdev->data->dev_started = 0;
 
 		compressdev->attached = RTE_COMPRESSDEV_ATTACHED;
@@ -322,7 +329,7 @@ rte_compressdev_queue_pair_count(uint8_t dev_id)
 
 static int
 rte_compressdev_queue_pairs_config(struct rte_compressdev *dev,
-		uint16_t nb_qpairs, int socket_id)
+		uint16_t nb_qpairs, int numa_id)
 {
 	struct rte_compressdev_info dev_info;
 	void **qp;
@@ -351,10 +358,10 @@ rte_compressdev_queue_pairs_config(struct rte_compressdev *dev,
 	}
 
 	if (dev->data->queue_pairs == NULL) { /* first time configuration */
-		dev->data->queue_pairs = rte_zmalloc_socket(
+		dev->data->queue_pairs = rte_zmalloc_numa(
 				"compressdev->queue_pairs",
 				sizeof(dev->data->queue_pairs[0]) * nb_qpairs,
-				RTE_CACHE_LINE_SIZE, socket_id);
+				RTE_CACHE_LINE_SIZE, numa_id);
 
 		if (dev->data->queue_pairs == NULL) {
 			dev->data->nb_queue_pairs = 0;
@@ -461,7 +468,7 @@ rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 
 	/* Setup new number of queue pairs and reconfigure device. */
 	diag = rte_compressdev_queue_pairs_config(dev, config->nb_queue_pairs,
-			config->socket_id);
+			config->numa_id);
 	if (diag != 0) {
 		COMPRESSDEV_LOG(ERR,
 			"dev%d rte_comp_dev_queue_pairs_config = %d",
@@ -572,7 +579,7 @@ rte_compressdev_close(uint8_t dev_id)
 RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_setup)
 int
 rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
-		uint32_t max_inflight_ops, int socket_id)
+		uint32_t max_inflight_ops, int numa_id)
 {
 	struct rte_compressdev *dev;
 
@@ -602,7 +609,7 @@ rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	if (dev->dev_ops->queue_pair_setup == NULL)
 		return -ENOTSUP;
 
-	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, max_inflight_ops, socket_id);
+	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, max_inflight_ops, numa_id);
 }
 
 RTE_EXPORT_SYMBOL(rte_compressdev_dequeue_burst)
diff --git a/lib/compressdev/rte_compressdev.h b/lib/compressdev/rte_compressdev.h
index ec0dc09e5f..e96d2b328a 100644
--- a/lib/compressdev/rte_compressdev.h
+++ b/lib/compressdev/rte_compressdev.h
@@ -169,8 +169,23 @@ rte_compressdev_devices_get(const char *driver_name, uint8_t *devices,
 		uint8_t nb_devices);
 
 /*
+ * Return the NUMA node to which a device is connected.
+ *
+ * @param dev_id
+ *   Compress device identifier
+ * @return
+ *   The NUMA node ID to which the device is connected or
+ *   a default of zero if the NUMA node could not be determined.
+ *   -1 if returned is the dev_id value is out of range.
+ */
+int
+rte_compressdev_numa_id(uint8_t dev_id);
+
+/**
  * Return the NUMA socket to which a device is connected.
  *
+ * This is a legacy alias of rte_compressdev_numa_id().
+ *
  * @param dev_id
  *   Compress device identifier
  * @return
@@ -183,8 +198,15 @@ rte_compressdev_socket_id(uint8_t dev_id);
 
 /** Compress device configuration structure */
 struct rte_compressdev_config {
-	int socket_id;
-	/**< Socket on which to allocate resources */
+	union {
+		/** NUMA node on which to allocate resources */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint16_t nb_queue_pairs;
 	/**< Total number of queue pairs to configure on a device */
 	uint16_t max_nb_priv_xforms;
@@ -270,9 +292,9 @@ rte_compressdev_close(uint8_t dev_id);
  * @param max_inflight_ops
  *   Max number of ops which the qp will have to
  *   accommodate simultaneously
- * @param socket_id
- *   The *socket_id* argument is the socket identifier
- *   in case of NUMA. The value can be *SOCKET_ID_ANY*
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID
+ *   in case of NUMA. The value can be *RTE_NUMA_ID_ANY*
  *   if there is no NUMA constraint for the DMA memory
  *   allocated for the receive queue pair
  * @return
@@ -281,7 +303,7 @@ rte_compressdev_close(uint8_t dev_id);
  */
 int
 rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
-		uint32_t max_inflight_ops, int socket_id);
+		uint32_t max_inflight_ops, int numa_id);
 
 /**
  * Get the number of queue pairs on a specific comp device
diff --git a/lib/compressdev/rte_compressdev_internal.h b/lib/compressdev/rte_compressdev_internal.h
index a980d74cbf..54224c164f 100644
--- a/lib/compressdev/rte_compressdev_internal.h
+++ b/lib/compressdev/rte_compressdev_internal.h
@@ -99,7 +99,7 @@ struct __rte_cache_aligned rte_compressdev {
 struct __rte_cache_aligned rte_compressdev_data {
 	uint8_t dev_id;
 	/**< Compress device identifier */
-	int socket_id;
+	int numa_id;
 	/**< Socket identifier where memory is allocated */
 	char name[RTE_COMPRESSDEV_NAME_MAX_LEN];
 	/**< Unique identifier name */
diff --git a/lib/compressdev/rte_compressdev_pmd.c b/lib/compressdev/rte_compressdev_pmd.c
index 7e11ad7148..df03722f33 100644
--- a/lib/compressdev/rte_compressdev_pmd.c
+++ b/lib/compressdev/rte_compressdev_pmd.c
@@ -76,7 +76,7 @@ rte_compressdev_pmd_parse_input_args(
 		ret = rte_kvargs_process(kvlist,
 				RTE_COMPRESSDEV_PMD_SOCKET_ID_ARG,
 				&rte_compressdev_pmd_parse_uint_arg,
-				&params->socket_id);
+				&params->numa_id);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -111,10 +111,10 @@ rte_compressdev_pmd_create(const char *name,
 	COMPRESSDEV_LOG(INFO, "Creating compressdev %s", name);
 
 	COMPRESSDEV_LOG(INFO, "Init parameters - name: %s, socket id: %d",
-			name, params->socket_id);
+			name, params->numa_id);
 
 	/* allocate device structure */
-	compressdev = rte_compressdev_pmd_allocate(name, params->socket_id);
+	compressdev = rte_compressdev_pmd_allocate(name, params->numa_id);
 	if (compressdev == NULL) {
 		COMPRESSDEV_LOG(ERR, "Failed to allocate comp device %s", name);
 		return NULL;
@@ -123,10 +123,10 @@ rte_compressdev_pmd_create(const char *name,
 	/* allocate private device structure */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		compressdev->data->dev_private =
-				rte_zmalloc_socket("compressdev device private",
+				rte_zmalloc_numa("compressdev device private",
 						private_data_size,
 						RTE_CACHE_LINE_SIZE,
-						params->socket_id);
+						params->numa_id);
 
 		if (compressdev->data->dev_private == NULL) {
 			COMPRESSDEV_LOG(ERR,
diff --git a/lib/compressdev/rte_compressdev_pmd.h b/lib/compressdev/rte_compressdev_pmd.h
index ea721f014d..ce30262ec0 100644
--- a/lib/compressdev/rte_compressdev_pmd.h
+++ b/lib/compressdev/rte_compressdev_pmd.h
@@ -25,7 +25,7 @@ extern "C" {
 #endif
 
 #define RTE_COMPRESSDEV_PMD_NAME_ARG			("name")
-#define RTE_COMPRESSDEV_PMD_SOCKET_ID_ARG		("socket_id")
+#define RTE_COMPRESSDEV_PMD_SOCKET_ID_ARG		("numa_id")
 
 static const char * const compressdev_pmd_valid_params[] = {
 	RTE_COMPRESSDEV_PMD_NAME_ARG,
@@ -38,7 +38,7 @@ static const char * const compressdev_pmd_valid_params[] = {
  */
 struct rte_compressdev_pmd_init_params {
 	char name[RTE_COMPRESSDEV_NAME_MAX_LEN];
-	int socket_id;
+	int numa_id;
 };
 
 /** Global structure used for maintaining state of allocated comp devices */
@@ -151,13 +151,13 @@ typedef void (*compressdev_info_get_t)(struct rte_compressdev *dev,
  *   Queue pair identifier
  * @param max_inflight_ops
  *   Max inflight ops which qp must accommodate
- * @param socket_id
+ * @param numa_id
  *   Socket identifier
  * @return
  *   Returns 0 on success.
  */
 typedef int (*compressdev_queue_pair_setup_t)(struct rte_compressdev *dev,
-		uint16_t qp_id,	uint32_t max_inflight_ops, int socket_id);
+		uint16_t qp_id,	uint32_t max_inflight_ops, int numa_id);
 
 /**
  * Release memory resources allocated by given queue pair.
@@ -285,13 +285,13 @@ struct rte_compressdev_ops {
  *
  * @param name
  *   Unique identifier name for each device
- * @param socket_id
+ * @param numa_id
  *   Socket to allocate resources on
  * @return
  *   - Slot in the rte_dev_devices array for a new device;
  */
 struct rte_compressdev *
-rte_compressdev_pmd_allocate(const char *name, int socket_id);
+rte_compressdev_pmd_allocate(const char *name, int numa_id);
 
 /**
  * @internal
-- 
2.55.0

