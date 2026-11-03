Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470E606B25D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dK3ZtYxL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9AB427D3;
	Tue,  3 Nov 2026 16:01:54 +0100 (CET)
Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 2BC82427E8
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=haN903zIgwdoc4TokUjZPzb1RycV/wLVRBoiq6MTbZM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718111; v=1; x=1794322911;
 b=dK3ZtYxLNHPFSM455c6Yv3Dl4NxebGcn00osFx03EGVLWIbdT/hLLtJ32Fje140lxGl/H9T1
 MuEhhdBjdU35iDz3riT6dkC8I2kzmFpL350gnibtxcDQ1BmW82EkCp4z3+M1JJxF8Gvg6rXOfYy
 boTRQNCKRBzbuD41YAb/wsaY=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 4874dff6a222d95d;
 Tue, 03 Nov 2026 15:01:51 +0000
X-Mizu-Trace-ID: 4874dff6a222d95d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 054/227] common/zsda: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:12 +0800
Message-ID: <20261103145306.487255-55-chengwen.feng@linux.dev>
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
 drivers/common/zsda/zsda_device.c |  4 ++--
 drivers/common/zsda/zsda_qp.c     | 18 +++++++++---------
 drivers/common/zsda/zsda_qp.h     |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/common/zsda/zsda_device.c b/drivers/common/zsda/zsda_device.c
index 280a51f9b3..1041a29f02 100644
--- a/drivers/common/zsda/zsda_device.c
+++ b/drivers/common/zsda/zsda_device.c
@@ -69,7 +69,7 @@ zsda_pci_device_allocate(struct rte_pci_device *pci_dev)
 	struct zsda_pci_device *zsda_pci_dev;
 	uint8_t zsda_dev_id;
 	char name[ZSDA_DEV_NAME_MAX_LEN];
-	unsigned int socket_id = rte_socket_id();
+	unsigned int numa_id = rte_numa_id();
 
 	rte_pci_device_name(&pci_dev->addr, name, sizeof(name));
 	snprintf(name + strlen(name), (ZSDA_DEV_NAME_MAX_LEN - strlen(name)),
@@ -99,7 +99,7 @@ zsda_pci_device_allocate(struct rte_pci_device *pci_dev)
 
 	zsda_devs[zsda_dev_id].mz =
 		rte_memzone_reserve(name, sizeof(struct zsda_pci_device),
-				    (int)(socket_id & 0xfff), 0);
+				    (int)(numa_id & 0xfff), 0);
 
 	if (zsda_devs[zsda_dev_id].mz == NULL) {
 		ZSDA_LOG(ERR, "Failed! malloc");
diff --git a/drivers/common/zsda/zsda_qp.c b/drivers/common/zsda/zsda_qp.c
index 79172234af..257898bed5 100644
--- a/drivers/common/zsda/zsda_qp.c
+++ b/drivers/common/zsda/zsda_qp.c
@@ -543,15 +543,15 @@ zsda_qps_hw_per_service(struct zsda_pci_device *zsda_pci_dev,
 static const struct rte_memzone *
 zsda_queue_dma_zone_reserve(const char *queue_name,
 				const unsigned int queue_size,
-				const unsigned int socket_id)
+				const unsigned int numa_id)
 {
 	const struct rte_memzone *mz;
 
 	mz = rte_memzone_lookup(queue_name);
 	if (mz != 0) {
 		if (((size_t)queue_size <= mz->len) &&
-		    ((socket_id == (SOCKET_ID_ANY & 0xffff)) ||
-		     (socket_id == (mz->socket_id & 0xffff)))) {
+		    ((numa_id == (RTE_NUMA_ID_ANY & 0xffff)) ||
+		     (numa_id == (mz->socket_id & 0xffff)))) {
 			ZSDA_LOG(DEBUG,
 				 "re-use memzone already allocated for %s",
 				 queue_name);
@@ -562,7 +562,7 @@ zsda_queue_dma_zone_reserve(const char *queue_name,
 	}
 
 	mz = rte_memzone_reserve_aligned(queue_name, queue_size,
-					   (int)(socket_id & 0xfff),
+					   (int)(numa_id & 0xfff),
 					   RTE_MEMZONE_IOVA_CONTIG, queue_size);
 
 	return mz;
@@ -602,7 +602,7 @@ zsda_queue_create(const uint8_t dev_id, struct zsda_queue *queue,
 			 queue->hw_queue_number);
 
 	qp_mz = zsda_queue_dma_zone_reserve(queue->memz_name, queue_size_bytes,
-				       rte_socket_id());
+				       rte_numa_id());
 	if (qp_mz == NULL) {
 		ZSDA_LOG(ERR, "Failed! qp_mz is NULL");
 		return -ENOMEM;
@@ -652,11 +652,11 @@ zsda_cookie_init(const uint8_t dev_id, struct zsda_qp *qp,
 
 	qp->srv[type].nb_descriptors = zsda_qp_conf->nb_descriptors;
 
-	qp->srv[type].op_cookies = rte_zmalloc_socket(
+	qp->srv[type].op_cookies = rte_zmalloc_numa(
 		"zsda PMD op cookie pointer",
 		zsda_qp_conf->nb_descriptors *
 			sizeof(*qp->srv[type].op_cookies),
-		RTE_CACHE_LINE_SIZE, zsda_qp_conf->socket_id);
+		RTE_CACHE_LINE_SIZE, zsda_qp_conf->numa_id);
 
 	if (qp->srv[type].op_cookies == NULL) {
 		ZSDA_LOG(ERR, "Failed! op_cookies is NULL");
@@ -671,7 +671,7 @@ zsda_cookie_init(const uint8_t dev_id, struct zsda_qp *qp,
 		qp->srv[type].op_cookie_pool = rte_mempool_create(
 			op_cookie_pool_name, qp->srv[type].nb_descriptors,
 			zsda_qp_conf->cookie_size, 64, 0, NULL, NULL, NULL,
-			NULL, (int)(rte_socket_id() & 0xfff), 0);
+			NULL, (int)(rte_numa_id() & 0xfff), 0);
 	if (!qp->srv[type].op_cookie_pool) {
 		ZSDA_LOG(ERR, "Failed! op_cookie_pool is NULL");
 		goto exit;
@@ -782,7 +782,7 @@ zsda_task_queue_setup(struct zsda_pci_device *zsda_pci_dev,
 	conf.service_type = type;
 	conf.cookie_size = sizeof(struct zsda_op_cookie);
 	conf.nb_descriptors = task_q_info->nb_des;
-	conf.socket_id = task_q_info->socket_id;
+	conf.numa_id = task_q_info->numa_id;
 	conf.service_str = task_q_info->service_str;
 
 	ret = zsda_common_qp_setup(zsda_pci_dev->zsda_dev_id, qp, qp_id, &conf);
diff --git a/drivers/common/zsda/zsda_qp.h b/drivers/common/zsda/zsda_qp.h
index 4dbefe7bbd..5ba20673c9 100644
--- a/drivers/common/zsda/zsda_qp.h
+++ b/drivers/common/zsda/zsda_qp.h
@@ -137,7 +137,7 @@ struct zsda_qp_config {
 	const struct zsda_qp_hw_data *hw;
 	uint16_t nb_descriptors;
 	uint32_t cookie_size;
-	int socket_id;
+	int numa_id;
 	const char *service_str;
 };
 
@@ -157,7 +157,7 @@ struct zsda_op_cookie {
 struct task_queue_info {
 	uint16_t qp_id;
 	uint16_t nb_des;
-	int socket_id;
+	int numa_id;
 	enum zsda_service_type type;
 	const char *service_str;
 
-- 
2.55.0

