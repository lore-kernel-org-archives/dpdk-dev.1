Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10B606B254
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZT3XUF4y
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B4B42D68;
	Tue,  3 Nov 2026 16:04:16 +0100 (CET)
Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
 by mails.dpdk.org (Postfix) with ESMTPS id E08A54113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:14 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=w5cCs4fXcaI7BZUr4EVEqU6SQKlsDVTGxwDd6n+2uok=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718254; v=1; x=1794323054;
 b=ZT3XUF4ykAWfWkCs/PoIA1KauvQnlFoyu/ct4g1ezllwKrWWFaFq5vMXvPz1dA9il1Ma5BFM
 dXZ5jzt4wPTIXHxY/pUKV1Qqwll3nwoDzwzM9z3j7karbBGOa5xitE1Uctbyd9IIVOgy8S2gcqr
 pC5kU8BVbJd1WiUWPDii6Epg=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 387a4dc6e5c7f85a;
 Tue, 03 Nov 2026 15:04:14 +0000
X-Mizu-Trace-ID: 387a4dc6e5c7f85a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 066/227] crypto/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:24 +0800
Message-ID: <20261103145306.487255-67-chengwen.feng@linux.dev>
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
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 12 ++++++------
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index a5b8aff146..f0bb698390 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -356,7 +356,7 @@ cnxk_cpt_metabuf_mempool_create(const struct rte_cryptodev *dev,
 		 dev->data->dev_id, qp_id);
 
 	pool = rte_mempool_create(mempool_name, mb_pool_sz, mlen, cache_sz, 0,
-				  NULL, NULL, NULL, NULL, rte_socket_id(), 0);
+				  NULL, NULL, NULL, NULL, rte_numa_id(), 0);
 
 	if (pool == NULL) {
 		plt_err("Could not create mempool for metabuf");
@@ -394,7 +394,7 @@ cnxk_cpt_qp_create(const struct rte_cryptodev *dev, uint16_t qp_id,
 	int ret;
 
 	/* Allocate queue pair */
-	qp = rte_zmalloc_socket("CNXK Crypto PMD Queue Pair", sizeof(*qp),
+	qp = rte_zmalloc_numa("CNXK Crypto PMD Queue Pair", sizeof(*qp),
 				ROC_ALIGN, 0);
 	if (qp == NULL) {
 		plt_err("Could not allocate queue pair");
@@ -407,7 +407,7 @@ cnxk_cpt_qp_create(const struct rte_cryptodev *dev, uint16_t qp_id,
 
 		qp_memzone_name_get(name, RTE_MEMZONE_NAMESIZE, dev->data->dev_id, qp_id);
 
-		pq_mem = rte_memzone_reserve_aligned(name, len, rte_socket_id(),
+		pq_mem = rte_memzone_reserve_aligned(name, len, rte_numa_id(),
 						     RTE_MEMZONE_SIZE_HINT_ONLY | RTE_MEMZONE_256MB,
 						     RTE_CACHE_LINE_SIZE);
 		if (pq_mem == NULL) {
@@ -499,7 +499,7 @@ cnxk_cpt_queue_pair_release(struct rte_cryptodev *dev, uint16_t qp_id)
 int
 cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			  const struct rte_cryptodev_qp_conf *conf,
-			  int socket_id __rte_unused)
+			  int numa_id __rte_unused)
 {
 	struct cnxk_cpt_vf *vf = dev->data->dev_private;
 	struct roc_cpt *roc_cpt = &vf->cpt;
@@ -593,7 +593,7 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 
 int
 cnxk_cpt_queue_pair_reset(struct rte_cryptodev *dev, uint16_t qp_id,
-			  const struct rte_cryptodev_qp_conf *conf, int socket_id)
+			  const struct rte_cryptodev_qp_conf *conf, int numa_id)
 {
 	if (conf == NULL) {
 		struct cnxk_cpt_vf *vf = dev->data->dev_private;
@@ -618,7 +618,7 @@ cnxk_cpt_queue_pair_reset(struct rte_cryptodev *dev, uint16_t qp_id,
 		return 0;
 	}
 
-	return cnxk_cpt_queue_pair_setup(dev, qp_id, conf, socket_id);
+	return cnxk_cpt_queue_pair_setup(dev, qp_id, conf, numa_id);
 }
 
 uint32_t
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 6c4265f339..a605ceb613 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -139,10 +139,10 @@ void cnxk_cpt_dev_info_get(struct rte_cryptodev *dev,
 
 int cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			      const struct rte_cryptodev_qp_conf *conf,
-			      int socket_id __rte_unused);
+			      int numa_id __rte_unused);
 
 int cnxk_cpt_queue_pair_reset(struct rte_cryptodev *dev, uint16_t qp_id,
-			      const struct rte_cryptodev_qp_conf *conf, int socket_id);
+			      const struct rte_cryptodev_qp_conf *conf, int numa_id);
 
 int cnxk_cpt_queue_pair_release(struct rte_cryptodev *dev, uint16_t qp_id);
 
-- 
2.55.0

