Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814C606D801
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QSj4eRGp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1827542DC5;
	Tue,  3 Nov 2026 16:05:48 +0100 (CET)
Received: from mta1.migadu.com (out-253.mta1.migadu.com [95.215.58.253])
 by mails.dpdk.org (Postfix) with ESMTPS id 0080842C24
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:46 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=TzTd8gTfFMtN9VUO/FJZ4OQiFoMIWVXNTdsouDr91xA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718346; v=1; x=1794323146;
 b=QSj4eRGpMEPwdg2TBoMYnnIVSQeis22DknUUnsesHGJG618TkUJMkRf7xTs3fYLllBg1M0Jl
 maeOiu68xWesVudsw2hlH6iq2wvSmP7bYqDt5l0uQtzSjMId0Wa89miPMDWbK9bYtPKPqNl10DY
 Nap7JQdN965QXhN3GCcwEwRQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 42f48fb3d373a34a;
 Tue, 03 Nov 2026 15:05:46 +0000
X-Mizu-Trace-ID: 42f48fb3d373a34a
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 076/227] crypto/openssl: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:34 +0800
Message-ID: <20261103145306.487255-77-chengwen.feng@linux.dev>
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
 drivers/crypto/openssl/rte_openssl_pmd.c     |  4 ++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 1b33470c8f..c105d6a263 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -4218,7 +4218,7 @@ cryptodev_openssl_probe(struct rte_vdev_device *vdev)
 	struct rte_cryptodev_pmd_init_params init_params = {
 		"",
 		sizeof(struct openssl_private),
-		rte_socket_id(),
+		rte_numa_id(),
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS
 	};
 	const char *name;
@@ -4265,7 +4265,7 @@ RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_OPENSSL_PMD,
 	cryptodev_openssl_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_OPENSSL_PMD,
 	"max_nb_queue_pairs=<int> "
-	"socket_id=<int>");
+	"numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(openssl_crypto_drv,
 		cryptodev_openssl_pmd_drv.driver, cryptodev_driver_id);
 RTE_LOG_REGISTER_DEFAULT(openssl_logtype_driver, INFO);
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d3718c28e4..d6a2dfb549 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -1080,7 +1080,7 @@ openssl_pmd_qp_set_unique_name(struct rte_cryptodev *dev,
 /** Create a ring to place processed operations on */
 static struct rte_ring *
 openssl_pmd_qp_create_processed_ops_ring(struct openssl_qp *qp,
-		unsigned int ring_size, int socket_id)
+		unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 
@@ -1099,7 +1099,7 @@ openssl_pmd_qp_create_processed_ops_ring(struct openssl_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 }
 
@@ -1108,7 +1108,7 @@ openssl_pmd_qp_create_processed_ops_ring(struct openssl_qp *qp,
 static int
 openssl_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id)
+		int numa_id)
 {
 	struct openssl_qp *qp = NULL;
 
@@ -1117,8 +1117,8 @@ openssl_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		openssl_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("OPENSSL PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("OPENSSL PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL)
 		return -ENOMEM;
 
@@ -1129,7 +1129,7 @@ openssl_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		goto qp_setup_cleanup;
 
 	qp->processed_ops = openssl_pmd_qp_create_processed_ops_ring(qp,
-			qp_conf->nb_descriptors, socket_id);
+			qp_conf->nb_descriptors, numa_id);
 	if (qp->processed_ops == NULL)
 		goto qp_setup_cleanup;
 
-- 
2.55.0

