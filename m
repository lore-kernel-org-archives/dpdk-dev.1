Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E615606C811
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GVq/4TcA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FE6A42670;
	Tue,  3 Nov 2026 16:05:21 +0100 (CET)
Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
 by mails.dpdk.org (Postfix) with ESMTPS id 6570C4113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:05:19 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=/79lYiM7sS6+wzm3WZJY7jnbUqlHXace0fJcAHAn29g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718319; v=1; x=1794323119;
 b=GVq/4TcAoHeKFBmyFkbET7SJxwXlki7uWB2kIFgmfIw3wNiGl3YVWJWgZIiu7Y5az8OomCRr
 sNBY5/LcEn7lNca4bOZkRhr3olY6gEa8lnSptHubanl+GV1sHIwfg3j+7n4pdQMfoc7F8q5Nbnz
 BslqHD4KAspZDuOMG2FPJiWc=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id d7bf5f02ee010169;
 Tue, 03 Nov 2026 15:05:13 +0000
X-Mizu-Trace-ID: d7bf5f02ee010169
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 073/227] crypto/nitrox: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:31 +0800
Message-ID: <20261103145306.487255-74-chengwen.feng@linux.dev>
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
 drivers/crypto/nitrox/nitrox_sym.c        | 10 +++++-----
 drivers/crypto/nitrox/nitrox_sym_reqmgr.c |  4 ++--
 drivers/crypto/nitrox/nitrox_sym_reqmgr.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/nitrox/nitrox_sym.c b/drivers/crypto/nitrox/nitrox_sym.c
index 510d6059b1..5f7a37573c 100644
--- a/drivers/crypto/nitrox/nitrox_sym.c
+++ b/drivers/crypto/nitrox/nitrox_sym.c
@@ -170,7 +170,7 @@ nitrox_sym_dev_stats_reset(struct rte_cryptodev *cdev)
 static int
 nitrox_sym_dev_qp_setup(struct rte_cryptodev *cdev, uint16_t qp_id,
 			const struct rte_cryptodev_qp_conf *qp_conf,
-			int socket_id)
+			int numa_id)
 {
 	struct nitrox_sym_device *sym_dev = cdev->data->dev_private;
 	struct nitrox_device *ndev = sym_dev->ndev;
@@ -190,9 +190,9 @@ nitrox_sym_dev_qp_setup(struct rte_cryptodev *cdev, uint16_t qp_id,
 			return err;
 	}
 
-	qp = rte_zmalloc_socket("nitrox PMD qp", sizeof(*qp),
+	qp = rte_zmalloc_numa("nitrox PMD qp", sizeof(*qp),
 				RTE_CACHE_LINE_SIZE,
-				socket_id);
+				numa_id);
 	if (!qp) {
 		NITROX_LOG_LINE(ERR, "Failed to allocate nitrox qp");
 		return -ENOMEM;
@@ -202,12 +202,12 @@ nitrox_sym_dev_qp_setup(struct rte_cryptodev *cdev, uint16_t qp_id,
 	qp->qno = qp_id;
 	err = nitrox_qp_setup(qp, ndev->bar_addr, cdev->data->name,
 			      qp_conf->nb_descriptors, NPS_PKT_IN_INSTR_SIZE,
-			      socket_id);
+			      numa_id);
 	if (unlikely(err))
 		goto qp_setup_err;
 
 	qp->sr_mp = nitrox_sym_req_pool_create(cdev, qp->count, qp_id,
-					       socket_id);
+					       numa_id);
 	if (unlikely(!qp->sr_mp))
 		goto req_pool_err;
 
diff --git a/drivers/crypto/nitrox/nitrox_sym_reqmgr.c b/drivers/crypto/nitrox/nitrox_sym_reqmgr.c
index 7751c1a9fc..dd2809935c 100644
--- a/drivers/crypto/nitrox/nitrox_sym_reqmgr.c
+++ b/drivers/crypto/nitrox/nitrox_sym_reqmgr.c
@@ -888,7 +888,7 @@ req_pool_obj_init(__rte_unused struct rte_mempool *mp,
 
 struct rte_mempool *
 nitrox_sym_req_pool_create(struct rte_cryptodev *cdev, uint32_t nobjs,
-			   uint16_t qp_id, int socket_id)
+			   uint16_t qp_id, int numa_id)
 {
 	char softreq_pool_name[RTE_RING_NAMESIZE];
 	struct rte_mempool *mp;
@@ -899,7 +899,7 @@ nitrox_sym_req_pool_create(struct rte_cryptodev *cdev, uint32_t nobjs,
 				RTE_ALIGN_MUL_CEIL(nobjs, 64),
 				sizeof(struct nitrox_softreq),
 				64, 0, NULL, NULL, req_pool_obj_init, NULL,
-				socket_id, 0);
+				numa_id, 0);
 	if (unlikely(!mp))
 		NITROX_LOG_LINE(ERR, "Failed to create req pool, qid %d, err %d",
 			   qp_id, rte_errno);
diff --git a/drivers/crypto/nitrox/nitrox_sym_reqmgr.h b/drivers/crypto/nitrox/nitrox_sym_reqmgr.h
index fa2637bdb8..37e557360f 100644
--- a/drivers/crypto/nitrox/nitrox_sym_reqmgr.h
+++ b/drivers/crypto/nitrox/nitrox_sym_reqmgr.h
@@ -17,7 +17,7 @@ int nitrox_check_se_req(struct nitrox_softreq *sr, struct rte_crypto_op **op);
 void *nitrox_sym_instr_addr(struct nitrox_softreq *sr);
 struct rte_mempool *nitrox_sym_req_pool_create(struct rte_cryptodev *cdev,
 					       uint32_t nobjs, uint16_t qp_id,
-					       int socket_id);
+					       int numa_id);
 void nitrox_sym_req_pool_free(struct rte_mempool *mp);
 
 #endif /* _NITROX_SYM_REQMGR_H_ */
-- 
2.55.0

