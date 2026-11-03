Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78C606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WIUailZS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B2FB42DA1;
	Tue,  3 Nov 2026 16:05:28 +0100 (CET)
Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
 by mails.dpdk.org (Postfix) with ESMTPS id 54C6B42DA1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:27 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=GPuO1rmXBfV/FFmxv0jWMY3PJbEIZL+tKqIzYNDbyAc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718327; v=1; x=1794323127;
 b=WIUailZSg9MBCtnL75RYL19xN1vW/EXh4zeXEDNNa6Sb+ocH5XMR/4Lb1fFIHREFYNxf2jkh
 X0EAajTCIh2po3aJbfNkt0Kl1LB2PG7/f8Fd5Z2RiCheGNJDbbtDpamUmW0n3iGO0O0KrEueHzc
 suDMpdCq4ZNVsqVL++LYmQT0=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 7eb56481519edd25;
 Tue, 03 Nov 2026 15:05:26 +0000
X-Mizu-Trace-ID: 7eb56481519edd25
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 074/227] crypto/null: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:32 +0800
Message-ID: <20261103145306.487255-75-chengwen.feng@linux.dev>
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
 drivers/crypto/null/null_crypto_pmd.c     |  4 ++--
 drivers/crypto/null/null_crypto_pmd_ops.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/null/null_crypto_pmd.c b/drivers/crypto/null/null_crypto_pmd.c
index 6db9deaee8..a32eca5514 100644
--- a/drivers/crypto/null/null_crypto_pmd.c
+++ b/drivers/crypto/null/null_crypto_pmd.c
@@ -186,7 +186,7 @@ cryptodev_null_probe(struct rte_vdev_device *dev)
 	struct rte_cryptodev_pmd_init_params init_params = {
 		"",
 		sizeof(struct null_crypto_private),
-		rte_socket_id(),
+		rte_numa_id(),
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS
 	};
 	const char *name, *args;
@@ -237,7 +237,7 @@ static struct cryptodev_driver null_crypto_drv;
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_NULL_PMD, cryptodev_null_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_NULL_PMD,
 	"max_nb_queue_pairs=<int> "
-	"socket_id=<int>");
+	"numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(null_crypto_drv, cryptodev_null_pmd_drv.driver,
 		cryptodev_driver_id);
 RTE_LOG_REGISTER_DEFAULT(null_logtype_driver, INFO);
diff --git a/drivers/crypto/null/null_crypto_pmd_ops.c b/drivers/crypto/null/null_crypto_pmd_ops.c
index f07e9c2ea0..27bc9231b3 100644
--- a/drivers/crypto/null/null_crypto_pmd_ops.c
+++ b/drivers/crypto/null/null_crypto_pmd_ops.c
@@ -161,7 +161,7 @@ null_crypto_pmd_qp_set_unique_name(struct rte_cryptodev *dev,
 /** Create a ring to place process packets on */
 static struct rte_ring *
 null_crypto_pmd_qp_create_processed_pkts_ring(struct null_crypto_qp *qp,
-		unsigned ring_size, int socket_id)
+		unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 
@@ -180,7 +180,7 @@ null_crypto_pmd_qp_create_processed_pkts_ring(struct null_crypto_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 }
 
@@ -188,7 +188,7 @@ null_crypto_pmd_qp_create_processed_pkts_ring(struct null_crypto_qp *qp,
 static int
 null_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id)
+		int numa_id)
 {
 	struct null_crypto_private *internals = dev->data->dev_private;
 	struct null_crypto_qp *qp;
@@ -206,8 +206,8 @@ null_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		null_crypto_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("Null Crypto PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("Null Crypto PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL) {
 		NULL_LOG(ERR, "Failed to allocate queue pair memory");
 		return (-ENOMEM);
@@ -225,7 +225,7 @@ null_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	}
 
 	qp->processed_pkts = null_crypto_pmd_qp_create_processed_pkts_ring(qp,
-			qp_conf->nb_descriptors, socket_id);
+			qp_conf->nb_descriptors, numa_id);
 	if (qp->processed_pkts == NULL) {
 		NULL_LOG(ERR, "Failed to create unique name for null "
 				"crypto device");
-- 
2.55.0

