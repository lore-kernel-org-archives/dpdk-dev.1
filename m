Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0553606BA1B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vJ54dQi0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABDC941149;
	Tue,  3 Nov 2026 16:03:39 +0100 (CET)
Received: from mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
 by mails.dpdk.org (Postfix) with ESMTPS id 330674113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:03:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=nxFAUH/M65Id0gBGUOH2por3bp8YZIDzARJda7nZfBA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718217; v=1; x=1794323017;
 b=vJ54dQi0iNq6EiJduMajQsmH8AwS+2BHUF0Dppzz9muy9FR0wS0M2PObpcztVJg7TgESVtbJ
 ptHQqeZh2vpskZGAJiltZK5AcuvsO13dH6zb08be0BxH/FfnLTggLJ2gthV4QEWZPhKu7440dwi
 r6VJcnyatL3cQA0Q+/2UpC3U=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id b2f684fe07532552;
 Tue, 03 Nov 2026 15:03:37 +0000
X-Mizu-Trace-ID: b2f684fe07532552
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 062/227] crypto/armv8: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:20 +0800
Message-ID: <20261103145306.487255-63-chengwen.feng@linux.dev>
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
 drivers/crypto/armv8/rte_armv8_pmd.c     |  6 +++---
 drivers/crypto/armv8/rte_armv8_pmd_ops.c | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
index 582dbadbdd..86378ddf4d 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd.c
@@ -807,7 +807,7 @@ cryptodev_armv8_crypto_init(struct rte_vdev_device *vdev)
 	struct rte_cryptodev_pmd_init_params init_params = {
 		"",
 		sizeof(struct armv8_crypto_private),
-		rte_socket_id(),
+		rte_numa_id(),
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS
 	};
 	const char *name;
@@ -835,7 +835,7 @@ cryptodev_armv8_crypto_uninit(struct rte_vdev_device *vdev)
 
 	ARMV8_CRYPTO_LOG_INFO(
 		"Closing ARMv8 crypto device %s on numa socket %u",
-		name, rte_socket_id());
+		name, rte_numa_id());
 
 	cryptodev = rte_cryptodev_pmd_get_named_dev(name);
 	if (cryptodev == NULL)
@@ -857,6 +857,6 @@ RTE_LOG_REGISTER_DEFAULT(crypto_armv8_log_type, ERR);
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ARMV8_PMD, armv8_crypto_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_ARMV8_PMD,
 	"max_nb_queue_pairs=<int> "
-	"socket_id=<int>");
+	"numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(armv8_crypto_drv, armv8_crypto_pmd_drv.driver,
 		cryptodev_driver_id);
diff --git a/drivers/crypto/armv8/rte_armv8_pmd_ops.c b/drivers/crypto/armv8/rte_armv8_pmd_ops.c
index c4964bc112..7d78ac94b9 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd_ops.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd_ops.c
@@ -190,7 +190,7 @@ armv8_crypto_pmd_qp_set_unique_name(struct rte_cryptodev *dev,
 /** Create a ring to place processed operations on */
 static struct rte_ring *
 armv8_crypto_pmd_qp_create_processed_ops_ring(struct armv8_crypto_qp *qp,
-		unsigned int ring_size, int socket_id)
+		unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 
@@ -209,7 +209,7 @@ armv8_crypto_pmd_qp_create_processed_ops_ring(struct armv8_crypto_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 }
 
@@ -218,7 +218,7 @@ armv8_crypto_pmd_qp_create_processed_ops_ring(struct armv8_crypto_qp *qp,
 static int
 armv8_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id)
+		int numa_id)
 {
 	struct armv8_crypto_qp *qp = NULL;
 
@@ -227,8 +227,8 @@ armv8_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		armv8_crypto_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("ARMv8 PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("ARMv8 PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL)
 		return -ENOMEM;
 
@@ -239,7 +239,7 @@ armv8_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		goto qp_setup_cleanup;
 
 	qp->processed_ops = armv8_crypto_pmd_qp_create_processed_ops_ring(qp,
-			qp_conf->nb_descriptors, socket_id);
+			qp_conf->nb_descriptors, numa_id);
 	if (qp->processed_ops == NULL)
 		goto qp_setup_cleanup;
 
-- 
2.55.0

