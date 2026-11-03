Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F081606B257
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QqgdaRRj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B1E427C5;
	Tue,  3 Nov 2026 16:03:55 +0100 (CET)
Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
 by mails.dpdk.org (Postfix) with ESMTPS id 65E0342791
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:03:55 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=gDsX37hj5vQUsMfhxUqhWSOhwq/Iqcg7Y0HPG2uxmtw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718235; v=1; x=1794323035;
 b=QqgdaRRjrPGSToTOLEANCSQdP+qS6vJ69QsITUC2+62Dgxw7BgR2PKHOjI/2uFl9w1FXscgJ
 cCbQleOK+Mqp//yccdsOkPbwn/UtnYzdWu9az20tRuI9hHgP8ebAGxWyiNAtytfOWNPwH7I85QI
 S+VF5KjVG3s+l7gGxqcbflVk=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 40dd033b3c4dcf91;
 Tue, 03 Nov 2026 15:03:55 +0000
X-Mizu-Trace-ID: 40dd033b3c4dcf91
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 064/227] crypto/caam_jr: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:22 +0800
Message-ID: <20261103145306.487255-65-chengwen.feng@linux.dev>
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
 drivers/crypto/caam_jr/caam_jr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index 01a9bed1ff..7d3355975b 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -1514,7 +1514,7 @@ static int
 caam_jr_queue_pair_setup(
 		struct rte_cryptodev *dev, uint16_t qp_id,
 		__rte_unused const struct rte_cryptodev_qp_conf *qp_conf,
-		__rte_unused int socket_id)
+		__rte_unused int numa_id)
 {
 	struct sec_job_ring_t *internals;
 	struct caam_jr_qp *qp = NULL;
@@ -1962,7 +1962,7 @@ caam_jr_dev_configure(struct rte_cryptodev *dev,
 						sizeof(struct caam_jr_op_ctx),
 						CTX_POOL_CACHE_SIZE, 0,
 						NULL, NULL, NULL, NULL,
-						SOCKET_ID_ANY, 0);
+						RTE_NUMA_ID_ANY, 0);
 		if (!internals->ctx_pool) {
 			CAAM_JR_ERR("%s create failed", str);
 			return -ENOMEM;
@@ -2373,7 +2373,7 @@ cryptodev_caam_jr_probe(struct rte_vdev_device *vdev)
 	struct rte_cryptodev_pmd_init_params init_params = {
 		"",
 		sizeof(struct sec_job_ring_t),
-		rte_socket_id(),
+		rte_numa_id(),
 		RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS
 	};
 	const char *name;
@@ -2455,7 +2455,7 @@ static struct cryptodev_driver caam_jr_crypto_drv;
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_CAAM_JR_PMD, cryptodev_caam_jr_drv);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_CAAM_JR_PMD,
 	"max_nb_queue_pairs=<int>"
-	"socket_id=<int>");
+	"numa_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(caam_jr_crypto_drv, cryptodev_caam_jr_drv.driver,
 		cryptodev_driver_id);
 
-- 
2.55.0

