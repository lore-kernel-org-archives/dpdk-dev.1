Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8166F606B254
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Et4mIamn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BBAA42D2E;
	Tue,  3 Nov 2026 16:05:03 +0100 (CET)
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
 by mails.dpdk.org (Postfix) with ESMTPS id 28FC44113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:01 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=lhEGPuizYtUaIzdbxh9Bc+31Cw2HWVIhOewuTYyCKe0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718300; v=1; x=1794323100;
 b=Et4mIamng2isk3Df6njatbLiuprIx2AhcWCM+FO6D9m+cc4Qu9IW/8exyrs4w0Z89KnNE7CF
 xB33Hrsajua/J+zpY/hqfcIhPAnDB+l2k8nlcV2hl/FEmeeJprDLjCoYvQJDTydMHCDBhAinK+A
 I6Mf5Yczf6b1GQpYsZUNopUk=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 6db11b77f21c050b;
 Tue, 03 Nov 2026 15:05:00 +0000
X-Mizu-Trace-ID: 6db11b77f21c050b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 072/227] crypto/mvsam: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:30 +0800
Message-ID: <20261103145306.487255-73-chengwen.feng@linux.dev>
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
 drivers/crypto/mvsam/rte_mrvl_pmd.c     | 4 ++--
 drivers/crypto/mvsam/rte_mrvl_pmd_ops.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index c69f526c52..26069d9db3 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -1258,7 +1258,7 @@ cryptodev_mrvl_crypto_uninit(struct rte_vdev_device *vdev)
 		return -EINVAL;
 
 	MRVL_LOG(INFO, "Closing Marvell crypto device %s on numa socket %u.",
-		 name, rte_socket_id());
+		 name, rte_numa_id());
 
 	sam_deinit();
 	rte_mvep_deinit(MVEP_MOD_T_SAM);
@@ -1285,7 +1285,7 @@ RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_MRVL_PMD, cryptodev_mrvl_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_MRVL_PMD,
 	"max_nb_queue_pairs=<int> "
 	"max_nb_sessions=<int> "
-	"socket_id=<int>");
+	"numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(mrvl_crypto_drv, cryptodev_mrvl_pmd_drv.driver,
 		cryptodev_driver_id);
 RTE_LOG_REGISTER_DEFAULT(mrvl_logtype_driver, NOTICE);
diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd_ops.c b/drivers/crypto/mvsam/rte_mrvl_pmd_ops.c
index 5a0658cf83..d485c3dd52 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd_ops.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd_ops.c
@@ -628,21 +628,21 @@ mrvl_crypto_pmd_close(struct rte_cryptodev *dev)
  * @param dev Pointer to the device structure.
  * @param qp_id ID of the Queue Pair.
  * @param qp_conf Queue pair configuration (nb of descriptors).
- * @param socket_id NUMA socket to allocate memory on.
+ * @param numa_id NUMA socket to allocate memory on.
  * @returns 0 upon success, negative value otherwise.
  */
 static int
 mrvl_crypto_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		int socket_id)
+		int numa_id)
 {
 	struct mrvl_crypto_qp *qp = NULL;
 	char match[RTE_CRYPTODEV_NAME_MAX_LEN];
 	unsigned int n;
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("MRVL Crypto PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("MRVL Crypto PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL)
 		return -ENOMEM;
 
-- 
2.55.0

