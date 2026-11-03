Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B61606D2DF
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hj1DyNkf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB6C42686;
	Tue,  3 Nov 2026 15:54:34 +0100 (CET)
Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
 by mails.dpdk.org (Postfix) with ESMTPS id 98FCD4111B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:32 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=An+dXzOmhEuBOnGtoQHiaADq35Xwdqy9+RMVMpUbvmU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717672; v=1; x=1794322472;
 b=hj1DyNkfFDYaXdNY3VMkvJ1o9UJDBF5bk8BUI36mXO2dwCmsMryKjpqFG+oBSe7ZHGmrEcGC
 fB46ZqVJjwuT3iHRKu7EB7spTnZ8D+D/BZXkVvuvW5c5uz28XG/oyVDsgPZIP4HGQXvtiDSjDd3
 0GrgQB2/DE0wUPo/9V8WsWSU=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id aeff6d19b84222d3;
 Tue, 03 Nov 2026 14:54:32 +0000
X-Mizu-Trace-ID: aeff6d19b84222d3
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 010/227] mldev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:28 +0800
Message-ID: <20261103145306.487255-11-chengwen.feng@linux.dev>
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

Rename the experimental function rte_ml_dev_socket_id() to
rte_ml_dev_numa_id() (experimental API may change without
compatibility alias), and rename the device data field to
numa_id.

Rename the numa_id field of rte_ml_dev_config (was socket_id),
keeping socket_id as a deprecated union alias, and update
in-tree users accordingly.

Also rename internal parameters and comments to the NUMA node
terminology.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-mldev/test_common.c     |  4 ++--
 app/test-mldev/test_device_ops.c |  2 +-
 drivers/ml/cnxk/cn10k_ml_dev.c   |  2 +-
 drivers/ml/cnxk/mvtvm_ml_dev.c   |  2 +-
 lib/mldev/rte_mldev.c            | 24 +++++++++++------------
 lib/mldev/rte_mldev.h            | 33 +++++++++++++++++++-------------
 lib/mldev/rte_mldev_core.h       | 10 +++++-----
 lib/mldev/rte_mldev_pmd.c        | 10 +++++-----
 lib/mldev/rte_mldev_pmd.h        | 10 +++++-----
 9 files changed, 52 insertions(+), 45 deletions(-)

diff --git a/app/test-mldev/test_common.c b/app/test-mldev/test_common.c
index 90e591f205..2f5e6156cf 100644
--- a/app/test-mldev/test_common.c
+++ b/app/test-mldev/test_common.c
@@ -101,7 +101,7 @@ ml_test_opt_check(struct ml_options *opt)
 		return -EINVAL;
 	}
 
-	socket_id = rte_ml_dev_socket_id(opt->dev_id);
+	socket_id = rte_ml_dev_numa_id(opt->dev_id);
 	if ((opt->socket_id != SOCKET_ID_ANY) && (opt->socket_id != socket_id)) {
 		ml_err("Invalid option, socket_id = %d\n", opt->socket_id);
 		return -EINVAL;
@@ -140,7 +140,7 @@ ml_test_device_configure(struct ml_test *test, struct ml_options *opt)
 	}
 
 	/* configure device */
-	dev_config.socket_id = opt->socket_id;
+	dev_config.numa_id = opt->socket_id;
 	dev_config.nb_models = t->dev_info.max_models;
 	dev_config.nb_queue_pairs = opt->queue_pairs;
 	ret = rte_ml_dev_configure(opt->dev_id, &dev_config);
diff --git a/app/test-mldev/test_device_ops.c b/app/test-mldev/test_device_ops.c
index dacc0232a2..6111bb106b 100644
--- a/app/test-mldev/test_device_ops.c
+++ b/app/test-mldev/test_device_ops.c
@@ -128,7 +128,7 @@ test_device_reconfigure(struct ml_test *test, struct ml_options *opt)
 	}
 
 	/* reconfigure device based on dev_info */
-	dev_config.socket_id = opt->socket_id;
+	dev_config.numa_id = opt->socket_id;
 	dev_config.nb_models = t->cmn.dev_info.max_models;
 	dev_config.nb_queue_pairs = t->cmn.dev_info.max_queue_pairs;
 	ret = rte_ml_dev_configure(opt->dev_id, &dev_config);
diff --git a/drivers/ml/cnxk/cn10k_ml_dev.c b/drivers/ml/cnxk/cn10k_ml_dev.c
index c35895dc14..cda8cee330 100644
--- a/drivers/ml/cnxk/cn10k_ml_dev.c
+++ b/drivers/ml/cnxk/cn10k_ml_dev.c
@@ -324,7 +324,7 @@ cn10k_ml_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_de
 	}
 
 	init_params = (struct rte_ml_dev_pmd_init_params){
-		.socket_id = rte_socket_id(), .private_data_size = sizeof(struct cnxk_ml_dev)};
+		.numa_id = rte_numa_id(), .private_data_size = sizeof(struct cnxk_ml_dev)};
 
 	ret = roc_plt_init();
 	if (ret < 0) {
diff --git a/drivers/ml/cnxk/mvtvm_ml_dev.c b/drivers/ml/cnxk/mvtvm_ml_dev.c
index 74959a12fc..7b490d000a 100644
--- a/drivers/ml/cnxk/mvtvm_ml_dev.c
+++ b/drivers/ml/cnxk/mvtvm_ml_dev.c
@@ -131,7 +131,7 @@ mvtvm_ml_vdev_probe(struct rte_vdev_device *vdev)
 	}
 
 	init_params = (struct rte_ml_dev_pmd_init_params){
-		.socket_id = rte_socket_id(), .private_data_size = sizeof(struct cnxk_ml_dev)};
+		.numa_id = rte_numa_id(), .private_data_size = sizeof(struct cnxk_ml_dev)};
 
 	name = rte_vdev_device_name(vdev);
 	if (name == NULL)
diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index 7fae867882..16f3087580 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -51,7 +51,7 @@ rte_ml_dev_pmd_get_named_dev(const char *name)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_allocate)
 struct rte_ml_dev *
-rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
+rte_ml_dev_pmd_allocate(const char *name, uint8_t numa_id)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -85,7 +85,7 @@ rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 		/* Reserve memzone name */
 		sprintf(mz_name, "rte_ml_dev_data_%d", dev_id);
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-			mz = rte_memzone_reserve(mz_name, sizeof(struct rte_ml_dev_data), socket_id,
+			mz = rte_memzone_reserve(mz_name, sizeof(struct rte_ml_dev_data), numa_id,
 						 0);
 			RTE_MLDEV_LOG(DEBUG, "PRIMARY: reserved memzone for %s (%p)", mz_name, mz);
 		} else {
@@ -105,13 +105,13 @@ rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			strlcpy(dev->data->name, name, RTE_ML_STR_MAX);
 			dev->data->dev_id = dev_id;
-			dev->data->socket_id = socket_id;
+			dev->data->numa_id = numa_id;
 			dev->data->dev_started = 0;
 			RTE_MLDEV_LOG(DEBUG, "PRIMARY: init mldev data");
 		}
 
-		RTE_MLDEV_LOG(DEBUG, "Data for %s: dev_id %d, socket %u", dev->data->name,
-			      dev->data->dev_id, dev->data->socket_id);
+		RTE_MLDEV_LOG(DEBUG, "Data for %s: dev_id %d, numa node %u", dev->data->name,
+			      dev->data->dev_id, dev->data->numa_id);
 
 		dev->attached = ML_DEV_ATTACHED;
 		ml_dev_globals.nb_devs++;
@@ -218,9 +218,9 @@ rte_ml_dev_is_valid_dev(int16_t dev_id)
 		return 1;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_socket_id, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_numa_id, 22.11)
 int
-rte_ml_dev_socket_id(int16_t dev_id)
+rte_ml_dev_numa_id(int16_t dev_id)
 {
 	struct rte_ml_dev *dev;
 
@@ -231,7 +231,7 @@ rte_ml_dev_socket_id(int16_t dev_id)
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
 
-	return dev->data->socket_id;
+	return dev->data->numa_id;
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_info_get, 22.11)
@@ -397,7 +397,7 @@ rte_ml_dev_queue_pair_count(int16_t dev_id)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_setup, 22.11)
 int
 rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
-			    const struct rte_ml_dev_qp_conf *qp_conf, int socket_id)
+			    const struct rte_ml_dev_qp_conf *qp_conf, int numa_id)
 {
 	struct rte_ml_dev *dev;
 
@@ -425,7 +425,7 @@ rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 		return -EBUSY;
 	}
 
-	return dev->dev_ops->dev_queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
+	return dev->dev_ops->dev_queue_pair_setup(dev, queue_pair_id, qp_conf, numa_id);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_get, 22.11)
@@ -808,7 +808,7 @@ ml_op_init(struct rte_mempool *mempool, __rte_unused void *opaque_arg, void *_op
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_create, 22.11)
 struct rte_mempool *
 rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache_size,
-		      uint16_t user_size, int socket_id)
+		      uint16_t user_size, int numa_id)
 {
 	struct rte_ml_op_pool_private *priv;
 	struct rte_mempool *mp;
@@ -833,7 +833,7 @@ rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache
 
 	mp = rte_mempool_create(name, nb_elts, elt_size, cache_size,
 				sizeof(struct rte_ml_op_pool_private), NULL, NULL, ml_op_init, NULL,
-				socket_id, 0);
+				numa_id, 0);
 	if (mp == NULL) {
 		RTE_MLDEV_LOG(ERR, "Failed to create mempool %s", name);
 		return NULL;
diff --git a/lib/mldev/rte_mldev.h b/lib/mldev/rte_mldev.h
index 594c46cf72..2f90f45499 100644
--- a/lib/mldev/rte_mldev.h
+++ b/lib/mldev/rte_mldev.h
@@ -199,19 +199,19 @@ int
 rte_ml_dev_is_valid_dev(int16_t dev_id);
 
 /**
- * Return the NUMA socket to which a device is connected.
+ * Return the NUMA node to which a device is connected.
  *
  * @param dev_id
  *   The identifier of the device.
  *
  * @return
- *   - The NUMA socket id to which the device is connected
- *   - 0 If the socket could not be determined.
+ *   - The NUMA node ID to which the device is connected
+ *   - 0 If the NUMA node could not be determined.
  *   - -EINVAL: if the dev_id value is not valid.
  */
 __rte_experimental
 int
-rte_ml_dev_socket_id(int16_t dev_id);
+rte_ml_dev_numa_id(int16_t dev_id);
 
 /**  ML device information */
 struct rte_ml_dev_info {
@@ -257,8 +257,15 @@ rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info);
 
 /** ML device configuration structure */
 struct rte_ml_dev_config {
-	int socket_id;
-	/**< Socket to allocate resources on. */
+	union {
+		/** NUMA node to allocate resources on. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint16_t nb_models;
 	/**< Number of models to be loaded on the device.
 	 * This value cannot exceed the max_models which is previously provided in
@@ -340,9 +347,9 @@ rte_ml_dev_queue_pair_count(int16_t dev_id);
  * previously supplied to rte_ml_dev_configure().
  * @param qp_conf
  *   The pointer to the configuration data to be used for the queue pair.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of NUMA.
- * The value can be *SOCKET_ID_ANY* if there is no NUMA constraint for the memory allocated
+ * @param numa_id
+ *   The *numa_id* argument is the socket identifier in case of NUMA.
+ * The value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for the memory allocated
  * for the queue pair.
  *
  * @return
@@ -352,7 +359,7 @@ rte_ml_dev_queue_pair_count(int16_t dev_id);
 __rte_experimental
 int
 rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
-			    const struct rte_ml_dev_qp_conf *qp_conf, int socket_id);
+			    const struct rte_ml_dev_qp_conf *qp_conf, int numa_id);
 
 /**
  * Start an ML device.
@@ -1555,8 +1562,8 @@ rte_ml_io_dequantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg *
  *   *rte_mempool_create* for further details about cache size
  * @param user_size
  *   Size of private data to allocate for user with each operation
- * @param socket_id
- *   Socket to identifier allocate memory on
+ * @param numa_id
+ *   NUMA node ID to allocate memory on
  * @return
  *  - On success pointer to mempool
  *  - On failure NULL
@@ -1564,7 +1571,7 @@ rte_ml_io_dequantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg *
 __rte_experimental
 struct rte_mempool *
 rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache_size,
-		      uint16_t user_size, int socket_id);
+		      uint16_t user_size, int numa_id);
 
 /**
  * Free an ML operation pool
diff --git a/lib/mldev/rte_mldev_core.h b/lib/mldev/rte_mldev_core.h
index 75d3466bc7..1fdb061a18 100644
--- a/lib/mldev/rte_mldev_core.h
+++ b/lib/mldev/rte_mldev_core.h
@@ -179,8 +179,8 @@ typedef int (*mldev_stop_t)(struct rte_ml_dev *dev);
  *	Queue pair index.
  * @param queue_pair_conf
  *	Queue pair configuration structure.
- * @param socket_id
- *	Socket index.
+ * @param numa_id
+ *	NUMA node index.
  *
  * @return
  *	- 0 on success.
@@ -188,7 +188,7 @@ typedef int (*mldev_stop_t)(struct rte_ml_dev *dev);
  */
 typedef int (*mldev_queue_pair_setup_t)(struct rte_ml_dev *dev, uint16_t queue_pair_id,
 					const struct rte_ml_dev_qp_conf *queue_pair_conf,
-					int socket_id);
+					int numa_id);
 
 /**
  * @internal
@@ -592,8 +592,8 @@ struct rte_ml_dev_data {
 	/** Device ID for this instance. */
 	int16_t dev_id;
 
-	/** Socket ID where memory is allocated. */
-	int16_t socket_id;
+	/** NUMA node ID where memory is allocated. */
+	int16_t numa_id;
 
 	/** Device state: STOPPED(0) / STARTED(1) */
 	__extension__ uint8_t dev_started : 1;
diff --git a/lib/mldev/rte_mldev_pmd.c b/lib/mldev/rte_mldev_pmd.c
index 434360f2d3..50d7224064 100644
--- a/lib/mldev/rte_mldev_pmd.c
+++ b/lib/mldev/rte_mldev_pmd.c
@@ -16,11 +16,11 @@ rte_ml_dev_pmd_create(const char *name, struct rte_device *device,
 {
 	struct rte_ml_dev *dev;
 
-	RTE_MLDEV_LOG(INFO, "ML device initialisation - name: %s, socket_id: %u", name,
-		      params->socket_id);
+	RTE_MLDEV_LOG(INFO, "ML device initialisation - name: %s, numa_id: %u", name,
+		      params->numa_id);
 
 	/* Allocate device structure */
-	dev = rte_ml_dev_pmd_allocate(name, params->socket_id);
+	dev = rte_ml_dev_pmd_allocate(name, params->numa_id);
 	if (dev == NULL) {
 		RTE_MLDEV_LOG(ERR, "Failed to allocate ML device for %s", name);
 		return NULL;
@@ -29,8 +29,8 @@ rte_ml_dev_pmd_create(const char *name, struct rte_device *device,
 	/* Allocate private device structure */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dev->data->dev_private =
-			rte_zmalloc_socket("ml_dev_private", params->private_data_size,
-					   RTE_CACHE_LINE_SIZE, params->socket_id);
+			rte_zmalloc_numa("ml_dev_private", params->private_data_size,
+					   RTE_CACHE_LINE_SIZE, params->numa_id);
 
 		if (dev->data->dev_private == NULL) {
 			RTE_MLDEV_LOG(ERR, "Cannot allocate memory for mldev %s private data",
diff --git a/lib/mldev/rte_mldev_pmd.h b/lib/mldev/rte_mldev_pmd.h
index 47c0f23223..674e4b7a3a 100644
--- a/lib/mldev/rte_mldev_pmd.h
+++ b/lib/mldev/rte_mldev_pmd.h
@@ -31,8 +31,8 @@ extern "C" {
  * Initialisation parameters for ML devices.
  */
 struct rte_ml_dev_pmd_init_params {
-	/** Socket to use for memory allocation. */
-	uint8_t socket_id;
+	/** NUMA node to use for memory allocation. */
+	uint8_t numa_id;
 
 	/** Size of device private data. */
 	uint64_t private_data_size;
@@ -78,15 +78,15 @@ rte_ml_dev_pmd_get_named_dev(const char *name);
  *
  * @param name
  *	Unique identifier name for each device.
- * @param socket_id
- *	Socket to allocate resources.
+ * @param numa_id
+ *	NUMA node to allocate resources.
  *
  * @return
  *	Slot in the rte_ml_dev_devices array for a new device.
  */
 __rte_internal
 struct rte_ml_dev *
-rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id);
+rte_ml_dev_pmd_allocate(const char *name, uint8_t numa_id);
 
 /**
  * @internal
-- 
2.55.0

