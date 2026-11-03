Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61169606B24E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s98u7kBJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1A0D42D0C;
	Tue,  3 Nov 2026 16:03:44 +0100 (CET)
Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
 by mails.dpdk.org (Postfix) with ESMTPS id 26B9542707
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:03:44 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=mG+lPIGWM35ldtZRbzxO65xcd+zDxx1nEdCaNB49FD4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718223; v=1; x=1794323023;
 b=s98u7kBJeeHeGT0/YWVleWGGAGbUZ1JZxH3221Etl4woupkxWDugV8rxTtYFHOVFAnqDoePp
 kAc/p6k4+p6I1k8FMcdMu+VjUkekjUZx6BKPc0n9v1apDFh2r8COg5rOMhuB4bkhWQfB09X4NXT
 LJyi9Sku3gAWiF5W01zHL/Ds=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 642f5543dcd54eed;
 Tue, 03 Nov 2026 15:03:43 +0000
X-Mizu-Trace-ID: 642f5543dcd54eed
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 063/227] crypto/bcmfs: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:21 +0800
Message-ID: <20261103145306.487255-64-chengwen.feng@linux.dev>
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
 drivers/crypto/bcmfs/bcmfs_qp.c      | 16 ++++++++--------
 drivers/crypto/bcmfs/bcmfs_qp.h      |  2 +-
 drivers/crypto/bcmfs/bcmfs_sym_pmd.c | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/bcmfs/bcmfs_qp.c b/drivers/crypto/bcmfs/bcmfs_qp.c
index 59e39a6c14..feaaa81015 100644
--- a/drivers/crypto/bcmfs/bcmfs_qp.c
+++ b/drivers/crypto/bcmfs/bcmfs_qp.c
@@ -63,15 +63,15 @@ bcmfs_queue_delete(struct bcmfs_queue *queue,
 
 static const struct rte_memzone *
 queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
-		       int socket_id, unsigned int align)
+		       int numa_id, unsigned int align)
 {
 	const struct rte_memzone *mz;
 
 	mz = rte_memzone_lookup(queue_name);
 	if (mz != NULL) {
 		if (((size_t)queue_size <= mz->len) &&
-		    (socket_id == SOCKET_ID_ANY ||
-		     socket_id == mz->socket_id)) {
+		    (numa_id == RTE_NUMA_ID_ANY ||
+		     numa_id == mz->socket_id)) {
 			BCMFS_LOG(DEBUG, "re-use memzone already "
 					"allocated for %s", queue_name);
 			return mz;
@@ -81,14 +81,14 @@ queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
 				"allocated %s, size %u, socket %d. "
 				"Requested size %u, socket %u",
 				queue_name, (uint32_t)mz->len,
-				mz->socket_id, queue_size, socket_id);
+				mz->socket_id, queue_size, numa_id);
 		return NULL;
 	}
 
 	BCMFS_LOG(DEBUG, "Allocate memzone for %s, size %u on socket %u",
-		  queue_name, queue_size, socket_id);
+		  queue_name, queue_size, numa_id);
 	return rte_memzone_reserve_aligned(queue_name, queue_size,
-		socket_id, RTE_MEMZONE_IOVA_CONTIG, align);
+		numa_id, RTE_MEMZONE_IOVA_CONTIG, align);
 }
 
 static int
@@ -216,9 +216,9 @@ bcmfs_qp_setup(struct bcmfs_qp **qp_addr,
 		return -EINVAL;
 	}
 
-	qp = rte_zmalloc_socket("BCM FS PMD qp metadata",
+	qp = rte_zmalloc_numa("BCM FS PMD qp metadata",
 				sizeof(*qp), RTE_CACHE_LINE_SIZE,
-				qp_conf->socket_id);
+				qp_conf->numa_id);
 	if (qp == NULL) {
 		BCMFS_LOG(ERR, "Failed to alloc mem for qp struct");
 		return -ENOMEM;
diff --git a/drivers/crypto/bcmfs/bcmfs_qp.h b/drivers/crypto/bcmfs/bcmfs_qp.h
index 42adff9033..dbcb19e628 100644
--- a/drivers/crypto/bcmfs/bcmfs_qp.h
+++ b/drivers/crypto/bcmfs/bcmfs_qp.h
@@ -44,7 +44,7 @@ struct bcmfs_qp_stats {
 
 struct bcmfs_qp_config {
 	/* Socket to allocate memory on */
-	int socket_id;
+	int numa_id;
 	/* Mapped iobase for qp */
 	void *iobase;
 	/* nb_descriptors or requests a h/w queue can accommodate */
diff --git a/drivers/crypto/bcmfs/bcmfs_sym_pmd.c b/drivers/crypto/bcmfs/bcmfs_sym_pmd.c
index 3f2ff40cd8..bd1758fa0c 100644
--- a/drivers/crypto/bcmfs/bcmfs_sym_pmd.c
+++ b/drivers/crypto/bcmfs/bcmfs_sym_pmd.c
@@ -149,7 +149,7 @@ req_pool_obj_init(__rte_unused struct rte_mempool *mp,
 static struct rte_mempool *
 bcmfs_sym_req_pool_create(struct rte_cryptodev *cdev __rte_unused,
 			  uint32_t nobjs, uint16_t qp_id,
-			  int socket_id)
+			  int numa_id)
 {
 	char softreq_pool_name[RTE_RING_NAMESIZE];
 	struct rte_mempool *mp;
@@ -161,7 +161,7 @@ bcmfs_sym_req_pool_create(struct rte_cryptodev *cdev __rte_unused,
 				RTE_ALIGN_MUL_CEIL(nobjs, 64),
 				sizeof(struct bcmfs_sym_request),
 				64, 0, NULL, NULL, req_pool_obj_init, NULL,
-				socket_id, 0);
+				numa_id, 0);
 	if (mp == NULL)
 		BCMFS_LOG(ERR, "Failed to create req pool, qid %d, err %d",
 				qp_id, rte_errno);
@@ -172,7 +172,7 @@ bcmfs_sym_req_pool_create(struct rte_cryptodev *cdev __rte_unused,
 static int
 bcmfs_sym_qp_setup(struct rte_cryptodev *cdev, uint16_t qp_id,
 		   const struct rte_cryptodev_qp_conf *qp_conf,
-		   int socket_id)
+		   int numa_id)
 {
 	int ret = 0;
 	struct bcmfs_qp *qp = NULL;
@@ -197,7 +197,7 @@ bcmfs_sym_qp_setup(struct rte_cryptodev *cdev, uint16_t qp_id,
 	}
 
 	bcmfs_qp_conf.nb_descriptors = qp_conf->nb_descriptors;
-	bcmfs_qp_conf.socket_id = socket_id;
+	bcmfs_qp_conf.numa_id = numa_id;
 	bcmfs_qp_conf.max_descs_req = BCMFS_CRYPTO_MAX_HW_DESCS_PER_REQ;
 	bcmfs_qp_conf.iobase = BCMFS_QP_IOBASE_XLATE(fsdev->mmap_addr, qp_id);
 	bcmfs_qp_conf.ops = fsdev->sym_hw_qp_ops;
@@ -209,7 +209,7 @@ bcmfs_sym_qp_setup(struct rte_cryptodev *cdev, uint16_t qp_id,
 	qp = (struct bcmfs_qp *)*qp_addr;
 
 	qp->sr_mp = bcmfs_sym_req_pool_create(cdev, qp_conf->nb_descriptors,
-					      qp_id, socket_id);
+					      qp_id, numa_id);
 	if (qp->sr_mp == NULL)
 		return -ENOMEM;
 
-- 
2.55.0

