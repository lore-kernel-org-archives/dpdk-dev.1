Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FF606C80F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N2fAQAyG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7518242D87;
	Tue,  3 Nov 2026 16:04:34 +0100 (CET)
Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
 by mails.dpdk.org (Postfix) with ESMTPS id A981D42D92
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:33 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=ikaBeNUe0TyoPo1PRHXz50mzGDGrsLtqanYF5wSs86A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718273; v=1; x=1794323073;
 b=N2fAQAyGo95GV8jHj7g+pPuSCM8CoNoVdleVSAiu62slMmeZqeLEO57XfdeInLWybkQgbTVl
 9GRv8kPh2FUF0icLrYUT9esJC8mpT7DkmIR1nT69fOqMNgezm2zJ0/RhJWIqW8zBMfc0imyGIRT
 Wm5m4feHxgDvExf7HvQeukFs=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 40331042ed2a2f95;
 Tue, 03 Nov 2026 15:04:33 +0000
X-Mizu-Trace-ID: 40331042ed2a2f95
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 069/227] crypto/ionic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:27 +0800
Message-ID: <20261103145306.487255-70-chengwen.feng@linux.dev>
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
 drivers/crypto/ionic/ionic_crypto.h      |  6 ++--
 drivers/crypto/ionic/ionic_crypto_main.c | 42 ++++++++++++------------
 drivers/crypto/ionic/ionic_crypto_ops.c  |  8 ++---
 drivers/crypto/ionic/ionic_crypto_vdev.c |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/ionic/ionic_crypto.h b/drivers/crypto/ionic/ionic_crypto.h
index 5a03260486..4054f0beb1 100644
--- a/drivers/crypto/ionic/ionic_crypto.h
+++ b/drivers/crypto/ionic/ionic_crypto.h
@@ -234,7 +234,7 @@ struct iocpt_dev {
 	uint32_t max_sessions;
 	uint16_t state;
 	uint8_t driver_id;
-	uint8_t socket_id;
+	uint8_t numa_id;
 
 	rte_spinlock_t adminq_lock;
 	rte_spinlock_t adminq_service_lock;
@@ -285,7 +285,7 @@ struct iocpt_admin_ctx {
 
 int iocpt_probe(void *bus_dev, struct rte_device *rte_dev,
 	struct iocpt_dev_bars *bars, const struct iocpt_dev_intf *intf,
-	uint8_t driver_id, uint8_t socket_id);
+	uint8_t driver_id, uint8_t numa_id);
 int iocpt_remove(struct rte_device *rte_dev);
 
 void iocpt_configure(struct iocpt_dev *dev);
@@ -301,7 +301,7 @@ void iocpt_dev_reset(struct iocpt_dev *dev);
 
 int iocpt_adminq_post_wait(struct iocpt_dev *dev, struct iocpt_admin_ctx *ctx);
 
-int iocpt_cryptoq_alloc(struct iocpt_dev *dev, uint32_t socket_id,
+int iocpt_cryptoq_alloc(struct iocpt_dev *dev, uint32_t numa_id,
 	uint32_t index, uint16_t ndescs);
 void iocpt_cryptoq_free(struct iocpt_crypto_q *cptq);
 
diff --git a/drivers/crypto/ionic/ionic_crypto_main.c b/drivers/crypto/ionic/ionic_crypto_main.c
index f670d6e658..01adbb6769 100644
--- a/drivers/crypto/ionic/ionic_crypto_main.c
+++ b/drivers/crypto/ionic/ionic_crypto_main.c
@@ -68,7 +68,7 @@ iocpt_cq_service(struct iocpt_cq *cq, uint32_t work_to_do,
 
 static int
 iocpt_q_init(struct iocpt_queue *q, uint8_t type, uint32_t index,
-	uint16_t num_descs, uint16_t num_segs, uint32_t socket_id)
+	uint16_t num_descs, uint16_t num_segs, uint32_t numa_id)
 {
 	uint32_t ring_size;
 
@@ -87,9 +87,9 @@ iocpt_q_init(struct iocpt_queue *q, uint8_t type, uint32_t index,
 	q->head_idx = 0;
 	q->tail_idx = 0;
 
-	q->info = rte_calloc_socket("iocpt",
+	q->info = rte_calloc_numa("iocpt",
 				(uint64_t)num_descs * num_segs, sizeof(void *),
-				rte_mem_page_size(), socket_id);
+				rte_mem_page_size(), numa_id);
 	if (q->info == NULL) {
 		IOCPT_PRINT(ERR, "Cannot allocate queue info");
 		return -ENOMEM;
@@ -303,7 +303,7 @@ iocpt_session_deinit(struct iocpt_session_priv *priv)
 
 static const struct rte_memzone *
 iocpt_dma_zone_reserve(const char *type_name, uint16_t qid, size_t size,
-			unsigned int align, int socket_id)
+			unsigned int align, int numa_id)
 {
 	char zone_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -320,7 +320,7 @@ iocpt_dma_zone_reserve(const char *type_name, uint16_t qid, size_t size,
 	if (mz != NULL)
 		return mz;
 
-	return rte_memzone_reserve_aligned(zone_name, size, socket_id,
+	return rte_memzone_reserve_aligned(zone_name, size, numa_id,
 			RTE_MEMZONE_IOVA_CONTIG, align);
 }
 
@@ -328,7 +328,7 @@ static int
 iocpt_commonq_alloc(struct iocpt_dev *dev,
 		uint8_t type,
 		size_t struct_size,
-		uint32_t socket_id,
+		uint32_t numa_id,
 		uint32_t index,
 		const char *type_name,
 		uint16_t flags,
@@ -364,8 +364,8 @@ iocpt_commonq_alloc(struct iocpt_dev *dev,
 	if (flags & IOCPT_Q_F_SG)
 		total_size += RTE_ALIGN(sg_size, page_size) + page_size;
 
-	new = rte_zmalloc_socket("iocpt", struct_size,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	new = rte_zmalloc_numa("iocpt", struct_size,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (new == NULL) {
 		IOCPT_PRINT(ERR, "Cannot allocate queue structure");
 		return -ENOMEM;
@@ -374,7 +374,7 @@ iocpt_commonq_alloc(struct iocpt_dev *dev,
 	new->dev = dev;
 
 	err = iocpt_q_init(&new->q, type, index, num_descs, num_segs,
-			socket_id);
+			numa_id);
 	if (err != 0) {
 		IOCPT_PRINT(ERR, "Queue initialization failed");
 		goto err_free_q;
@@ -387,7 +387,7 @@ iocpt_commonq_alloc(struct iocpt_dev *dev,
 	}
 
 	new->base_z = iocpt_dma_zone_reserve(type_name, index, total_size,
-					IONIC_ALIGN, socket_id);
+					IONIC_ALIGN, numa_id);
 	if (new->base_z == NULL) {
 		IOCPT_PRINT(ERR, "Cannot reserve queue DMA memory");
 		err = -ENOMEM;
@@ -428,7 +428,7 @@ iocpt_commonq_alloc(struct iocpt_dev *dev,
 }
 
 int
-iocpt_cryptoq_alloc(struct iocpt_dev *dev, uint32_t socket_id, uint32_t index,
+iocpt_cryptoq_alloc(struct iocpt_dev *dev, uint32_t numa_id, uint32_t index,
 		uint16_t num_descs)
 {
 	struct iocpt_crypto_q *cptq;
@@ -444,7 +444,7 @@ iocpt_cryptoq_alloc(struct iocpt_dev *dev, uint32_t socket_id, uint32_t index,
 	err = iocpt_commonq_alloc(dev,
 		IOCPT_QTYPE_CRYPTOQ,
 		sizeof(struct iocpt_crypto_q),
-		socket_id,
+		numa_id,
 		index,
 		"crypto",
 		flags,
@@ -589,7 +589,7 @@ iocpt_adminq_alloc(struct iocpt_dev *dev)
 	err = iocpt_commonq_alloc(dev,
 		IOCPT_QTYPE_ADMINQ,
 		sizeof(struct iocpt_admin_q),
-		rte_socket_id(),
+		rte_numa_id(),
 		0,
 		"admin",
 		flags,
@@ -645,9 +645,9 @@ iocpt_alloc_objs(struct iocpt_dev *dev)
 
 	IOCPT_PRINT(DEBUG, "Crypto: %s", dev->name);
 
-	dev->cryptoqs = rte_calloc_socket("iocpt",
+	dev->cryptoqs = rte_calloc_numa("iocpt",
 				dev->max_qps, sizeof(*dev->cryptoqs),
-				RTE_CACHE_LINE_SIZE, dev->socket_id);
+				RTE_CACHE_LINE_SIZE, dev->numa_id);
 	if (dev->cryptoqs == NULL) {
 		IOCPT_PRINT(ERR, "Cannot allocate tx queues array");
 		return -ENOMEM;
@@ -665,7 +665,7 @@ iocpt_alloc_objs(struct iocpt_dev *dev)
 
 	dev->info_sz = RTE_ALIGN(sizeof(*dev->info), rte_mem_page_size());
 	dev->info_z = iocpt_dma_zone_reserve("info", 0, dev->info_sz,
-					IONIC_ALIGN, dev->socket_id);
+					IONIC_ALIGN, dev->numa_id);
 	if (dev->info_z == NULL) {
 		IOCPT_PRINT(ERR, "Cannot allocate dev info memory");
 		err = -ENOMEM;
@@ -676,8 +676,8 @@ iocpt_alloc_objs(struct iocpt_dev *dev)
 	dev->info_pa = dev->info_z->iova;
 
 	bmsize = rte_bitmap_get_memory_footprint(dev->max_sessions);
-	bm = rte_malloc_socket("iocpt", bmsize,
-			RTE_CACHE_LINE_SIZE, dev->socket_id);
+	bm = rte_malloc_numa("iocpt", bmsize,
+			RTE_CACHE_LINE_SIZE, dev->numa_id);
 	if (bm == NULL) {
 		IOCPT_PRINT(ERR, "Cannot allocate %uB bitmap memory", bmsize);
 		err = -ENOMEM;
@@ -849,12 +849,12 @@ iocpt_devargs(struct rte_devargs *devargs, struct iocpt_dev *dev)
 int
 iocpt_probe(void *bus_dev, struct rte_device *rte_dev,
 	struct iocpt_dev_bars *bars, const struct iocpt_dev_intf *intf,
-	uint8_t driver_id, uint8_t socket_id)
+	uint8_t driver_id, uint8_t numa_id)
 {
 	struct rte_cryptodev_pmd_init_params init_params = {
 		"iocpt",
 		sizeof(struct iocpt_dev),
-		socket_id,
+		numa_id,
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS
 	};
 	struct rte_cryptodev *cdev;
@@ -883,7 +883,7 @@ iocpt_probe(void *bus_dev, struct rte_device *rte_dev,
 	dev->bus_dev = bus_dev;
 	dev->intf = intf;
 	dev->driver_id = driver_id;
-	dev->socket_id = socket_id;
+	dev->numa_id = numa_id;
 
 	for (i = 0; i < bars->num_bars; i++) {
 		struct ionic_dev_bar *bar = &bars->bar[i];
diff --git a/drivers/crypto/ionic/ionic_crypto_ops.c b/drivers/crypto/ionic/ionic_crypto_ops.c
index 839bbf69d1..405c282fd7 100644
--- a/drivers/crypto/ionic/ionic_crypto_ops.c
+++ b/drivers/crypto/ionic/ionic_crypto_ops.c
@@ -101,7 +101,7 @@ iocpt_op_queue_release(struct rte_cryptodev *cdev, uint16_t queue_id)
 static int
 iocpt_op_queue_setup(struct rte_cryptodev *cdev, uint16_t queue_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id)
+		int numa_id)
 {
 	struct iocpt_dev *dev = cdev->data->dev_private;
 	int err;
@@ -119,7 +119,7 @@ iocpt_op_queue_setup(struct rte_cryptodev *cdev, uint16_t queue_id,
 
 	IOCPT_PRINT(DEBUG, "queue_id %u", queue_id);
 
-	err = iocpt_cryptoq_alloc(dev, socket_id, queue_id,
+	err = iocpt_cryptoq_alloc(dev, numa_id, queue_id,
 				qp_conf->nb_descriptors);
 	if (err != 0)
 		return err;
@@ -428,8 +428,8 @@ iocpt_enqueue_wdog(struct iocpt_crypto_q *cptq)
 	if (avail < 1)
 		goto out_flush;
 
-	wdog_op = rte_zmalloc_socket("iocpt", sizeof(*wdog_op),
-				RTE_CACHE_LINE_SIZE, rte_socket_id());
+	wdog_op = rte_zmalloc_numa("iocpt", sizeof(*wdog_op),
+				RTE_CACHE_LINE_SIZE, rte_numa_id());
 	if (wdog_op == NULL)
 		goto out_flush;
 
diff --git a/drivers/crypto/ionic/ionic_crypto_vdev.c b/drivers/crypto/ionic/ionic_crypto_vdev.c
index d15acf660a..e4a7d56e5d 100644
--- a/drivers/crypto/ionic/ionic_crypto_vdev.c
+++ b/drivers/crypto/ionic/ionic_crypto_vdev.c
@@ -107,7 +107,7 @@ iocpt_vdev_probe(struct rte_vdev_device *vdev)
 
 	return iocpt_probe((void *)vdev, &vdev->device,
 			&bars, &iocpt_vdev_intf,
-			iocpt_vdev_driver_id, rte_socket_id());
+			iocpt_vdev_driver_id, rte_numa_id());
 }
 
 static int
-- 
2.55.0

