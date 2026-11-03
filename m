Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C51606BA34
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V2ku3CDH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC68042791;
	Tue,  3 Nov 2026 16:04:08 +0100 (CET)
Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F00142C24
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:07 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=2jYbWovWsTmw5ZaalpmbWSol5qCkeR1lrRkRBhJ5KVM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718246; v=1; x=1794323046;
 b=V2ku3CDH/E/YfMBnjIKDHCieTvyoxaYfK63xz9Kk6Em+V+r5uyuu7UzxTaOsynkAAvHPVXeT
 bnFBf28XWVZPN8uEYx5dhNaPHp0zPcpdRgUPxAXPbyzvzlPmDyZ3skIjTxlDsoOgy4aRm6Jw9ID
 DRFa/CVY7f4wlrIIFCgA1yRE=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id eb22bbcdeaff280d;
 Tue, 03 Nov 2026 15:04:06 +0000
X-Mizu-Trace-ID: eb22bbcdeaff280d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 065/227] crypto/ccp: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:23 +0800
Message-ID: <20261103145306.487255-66-chengwen.feng@linux.dev>
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
 drivers/crypto/ccp/ccp_dev.c     | 14 +++++++-------
 drivers/crypto/ccp/ccp_pmd_ops.c | 14 +++++++-------
 drivers/crypto/ccp/rte_ccp_pmd.c |  8 ++++----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/ccp/ccp_dev.c b/drivers/crypto/ccp/ccp_dev.c
index a75816cdfc..defbb1e5a8 100644
--- a/drivers/crypto/ccp/ccp_dev.c
+++ b/drivers/crypto/ccp/ccp_dev.c
@@ -85,15 +85,15 @@ ccp_read_hwrng(uint32_t *value)
 static const struct rte_memzone *
 ccp_queue_dma_zone_reserve(const char *queue_name,
 			   uint32_t queue_size,
-			   int socket_id)
+			   int numa_id)
 {
 	const struct rte_memzone *mz;
 
 	mz = rte_memzone_lookup(queue_name);
 	if (mz != 0) {
 		if (((size_t)queue_size <= mz->len) &&
-		    ((socket_id == SOCKET_ID_ANY) ||
-		     (socket_id == mz->socket_id))) {
+		    ((numa_id == RTE_NUMA_ID_ANY) ||
+		     (numa_id == mz->socket_id))) {
 			CCP_LOG_INFO("re-use memzone already "
 				     "allocated for %s", queue_name);
 			return mz;
@@ -102,15 +102,15 @@ ccp_queue_dma_zone_reserve(const char *queue_name,
 			    "allocated %s, size %u, socket %d. "
 			    "Requested size %u, socket %u",
 			    queue_name, (uint32_t)mz->len,
-			    mz->socket_id, queue_size, socket_id);
+			    mz->socket_id, queue_size, numa_id);
 		return NULL;
 	}
 
 	CCP_LOG_INFO("Allocate memzone for %s, size %u on socket %u",
-		     queue_name, queue_size, socket_id);
+		     queue_name, queue_size, numa_id);
 
 	return rte_memzone_reserve_aligned(queue_name, queue_size,
-			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
+			numa_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
 }
 
 /* bitmap support apis */
@@ -545,7 +545,7 @@ ccp_add_device(struct ccp_device *dev)
 			 (int)dev->id, "queue",
 			 (int)cmd_q->id, "mem");
 		q_mz = ccp_queue_dma_zone_reserve(cmd_q->memz_name,
-						  cmd_q->qsize, SOCKET_ID_ANY);
+						  cmd_q->qsize, RTE_NUMA_ID_ANY);
 		cmd_q->qbase_addr = (void *)q_mz->addr;
 		cmd_q->qbase_desc = (void *)q_mz->addr;
 		cmd_q->qbase_phys_addr =  q_mz->iova;
diff --git a/drivers/crypto/ccp/ccp_pmd_ops.c b/drivers/crypto/ccp/ccp_pmd_ops.c
index 52f320b02b..3e22653df1 100644
--- a/drivers/crypto/ccp/ccp_pmd_ops.c
+++ b/drivers/crypto/ccp/ccp_pmd_ops.c
@@ -660,7 +660,7 @@ ccp_pmd_qp_set_unique_name(struct rte_cryptodev *dev,
 
 static struct rte_ring *
 ccp_pmd_qp_create_batch_info_ring(struct ccp_qp *qp,
-				  unsigned int ring_size, int socket_id)
+				  unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 
@@ -678,14 +678,14 @@ ccp_pmd_qp_create_batch_info_ring(struct ccp_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 }
 
 static int
 ccp_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		 const struct rte_cryptodev_qp_conf *qp_conf,
-		 int socket_id)
+		 int numa_id)
 {
 	struct ccp_private *internals = dev->data->dev_private;
 	struct ccp_qp *qp;
@@ -702,8 +702,8 @@ ccp_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		ccp_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("CCP Crypto PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("CCP Crypto PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL) {
 		CCP_LOG_ERR("Failed to allocate queue pair memory");
 		return (-ENOMEM);
@@ -720,7 +720,7 @@ ccp_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	}
 
 	qp->processed_pkts = ccp_pmd_qp_create_batch_info_ring(qp,
-			qp_conf->nb_descriptors, socket_id);
+			qp_conf->nb_descriptors, numa_id);
 	if (qp->processed_pkts == NULL) {
 		CCP_LOG_ERR("Failed to create batch info ring");
 		goto qp_setup_cleanup;
@@ -735,7 +735,7 @@ ccp_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 				sizeof(struct ccp_batch_info),
 				RTE_CACHE_LINE_SIZE,
 				0, NULL, NULL, NULL, NULL,
-				SOCKET_ID_ANY, 0);
+				RTE_NUMA_ID_ANY, 0);
 	if (qp->batch_mp == NULL)
 		goto qp_setup_cleanup;
 	memset(&qp->qp_stats, 0, sizeof(qp->qp_stats));
diff --git a/drivers/crypto/ccp/rte_ccp_pmd.c b/drivers/crypto/ccp/rte_ccp_pmd.c
index ab19f8fd9c..50e2adb6d0 100644
--- a/drivers/crypto/ccp/rte_ccp_pmd.c
+++ b/drivers/crypto/ccp/rte_ccp_pmd.c
@@ -29,7 +29,7 @@ struct ccp_pmd_init_params {
 };
 
 #define CCP_CRYPTODEV_PARAM_NAME		("name")
-#define CCP_CRYPTODEV_PARAM_SOCKET_ID		("socket_id")
+#define CCP_CRYPTODEV_PARAM_SOCKET_ID		("numa_id")
 #define CCP_CRYPTODEV_PARAM_MAX_NB_QP		("max_nb_queue_pairs")
 #define CCP_CRYPTODEV_PARAM_AUTH_OPT		("ccp_auth_opt")
 
@@ -194,7 +194,7 @@ cryptodev_ccp_remove(struct rte_pci_device *pci_dev)
 
 	ccp_pmd_init_done = 0;
 
-	CCP_LOG_INFO("Closing ccp device %s on numa socket %u", name, rte_socket_id());
+	CCP_LOG_INFO("Closing ccp device %s on numa socket %u", name, rte_numa_id());
 
 	return rte_cryptodev_pmd_destroy(dev);
 }
@@ -271,7 +271,7 @@ cryptodev_ccp_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		.def_p = {
 			"",
 			sizeof(struct ccp_private),
-			rte_socket_id(),
+			rte_numa_id(),
 			CCP_PMD_MAX_QUEUE_PAIRS
 		},
 		.auth_opt = CCP_PMD_AUTH_OPT_CCP,
@@ -316,7 +316,7 @@ RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CCP_PMD, cryptodev_ccp_pmd_drv);
 RTE_PMD_REGISTER_KMOD_DEP(CRYPTODEV_NAME_CCP_PMD, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_CCP_PMD,
 	"max_nb_queue_pairs=<int> "
-	"socket_id=<int> "
+	"numa_id=<int> "
 	"ccp_auth_opt=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(ccp_crypto_drv, cryptodev_ccp_pmd_drv.driver,
 			       ccp_cryptodev_driver_id);
-- 
2.55.0

