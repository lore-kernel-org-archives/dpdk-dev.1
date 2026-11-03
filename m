Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3A606D2D2
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rb82a2lM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A75642D83;
	Tue,  3 Nov 2026 16:05:39 +0100 (CET)
Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
 by mails.dpdk.org (Postfix) with ESMTPS id 2D0F44113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=vNLoK9qnZCkmoav/ZUnW4cJhI6I2uvqIynyvUqOiVBM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718337; v=1; x=1794323137;
 b=rb82a2lMm8hz7X13I3w6N+DZvG5f9rGRG1kMQAHpVl3KmMKG8Q66Q1sihXxr6L40yPIrNRDy
 46OencgaUlGc4dRrr0zis1/SRePPq3wDh26xqD3pYW6i21ev9CtEdMfY6rImWcuICtyOFf7eC5C
 UjGjKnAPE7X1GCp+m0fG+zeQ=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 2b09cf95399ce67e;
 Tue, 03 Nov 2026 15:05:37 +0000
X-Mizu-Trace-ID: 2b09cf95399ce67e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 075/227] crypto/octeontx: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:33 +0800
Message-ID: <20261103145306.487255-76-chengwen.feng@linux.dev>
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
 drivers/crypto/octeontx/otx_cryptodev.c           | 2 +-
 drivers/crypto/octeontx/otx_cryptodev_hw_access.c | 2 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c       | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev.c b/drivers/crypto/octeontx/otx_cryptodev.c
index b2f6f53ee3..8ddfa28865 100644
--- a/drivers/crypto/octeontx/otx_cryptodev.c
+++ b/drivers/crypto/octeontx/otx_cryptodev.c
@@ -42,7 +42,7 @@ otx_cpt_pci_probe(struct rte_pci_driver *pci_drv,
 
 	rte_pci_device_name(&pci_dev->addr, name, sizeof(name));
 
-	cryptodev = rte_cryptodev_pmd_allocate(name, rte_socket_id());
+	cryptodev = rte_cryptodev_pmd_allocate(name, rte_numa_id());
 	if (cryptodev == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/octeontx/otx_cryptodev_hw_access.c b/drivers/crypto/octeontx/otx_cryptodev_hw_access.c
index 27604459e4..6c91a82564 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_hw_access.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_hw_access.c
@@ -458,7 +458,7 @@ otx_cpt_metabuf_mempool_create(const struct rte_cryptodev *dev,
 
 	pool = rte_mempool_create_empty(mempool_name, mb_pool_sz, max_mlen,
 					METABUF_POOL_CACHE_SIZE, 0,
-					rte_socket_id(), 0);
+					rte_numa_id(), 0);
 
 	if (pool == NULL) {
 		CPT_LOG_ERR("Could not create mempool for metabuf");
diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index 40f565cd78..abb94bf8d1 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -137,7 +137,7 @@ static int
 otx_cpt_que_pair_setup(struct rte_cryptodev *dev,
 		       uint16_t que_pair_id,
 		       const struct rte_cryptodev_qp_conf *qp_conf,
-		       int socket_id __rte_unused)
+		       int numa_id __rte_unused)
 {
 	struct cpt_instance *instance = NULL;
 	struct rte_pci_device *pci_dev;
@@ -1017,9 +1017,9 @@ otx_cpt_dev_create(struct rte_cryptodev *c_dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	cptvf = rte_zmalloc_socket("otx_cryptodev_private_mem",
+	cptvf = rte_zmalloc_numa("otx_cryptodev_private_mem",
 			sizeof(struct cpt_vf), RTE_CACHE_LINE_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 
 	if (cptvf == NULL) {
 		CPT_LOG_ERR("Cannot allocate memory for device private data");
-- 
2.55.0

