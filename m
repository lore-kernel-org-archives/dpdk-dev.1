Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB96071C28
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QLKuDSWG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74A35427E2;
	Tue,  3 Nov 2026 16:01:45 +0100 (CET)
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
 by mails.dpdk.org (Postfix) with ESMTPS id 6C211427DA
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:44 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=lyhQtVjvd9dpABiD3AaODvrJDiI+zg4TZDhRn2QDgxE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718104; v=1; x=1794322904;
 b=QLKuDSWG/zrS0hRteRfN5Kqay17muSLnEYzEWuMSjMX9EwWFuShfmPPHkpZWoGLLTBQzCA6/
 Drsc58bjf9ivzfpOqese8ScjFOHxat/PjBbSDrbTTl8nFbmXtXsn0NJfVViwZVe1ExzMqKpYWZb
 XY/FKJvb20cdxTLlRW+m1tdY=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 65c7bc433533f4bd;
 Tue, 03 Nov 2026 15:01:44 +0000
X-Mizu-Trace-ID: 65c7bc433533f4bd
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 053/227] common/nitrox: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:11 +0800
Message-ID: <20261103145306.487255-54-chengwen.feng@linux.dev>
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
 drivers/common/nitrox/nitrox_device.c |  2 +-
 drivers/common/nitrox/nitrox_qp.c     | 16 ++++++++--------
 drivers/common/nitrox/nitrox_qp.h     |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/common/nitrox/nitrox_device.c b/drivers/common/nitrox/nitrox_device.c
index 74c7a859a4..27a4d69ac0 100644
--- a/drivers/common/nitrox/nitrox_device.c
+++ b/drivers/common/nitrox/nitrox_device.c
@@ -19,7 +19,7 @@ ndev_allocate(struct rte_pci_device *pdev)
 {
 	struct nitrox_device *ndev;
 
-	ndev = rte_zmalloc_socket("nitrox device", sizeof(*ndev),
+	ndev = rte_zmalloc_numa("nitrox device", sizeof(*ndev),
 				   RTE_CACHE_LINE_SIZE,
 				   pdev->device.numa_node);
 	if (!ndev)
diff --git a/drivers/common/nitrox/nitrox_qp.c b/drivers/common/nitrox/nitrox_qp.c
index 8f481e6876..1c0279e63f 100644
--- a/drivers/common/nitrox/nitrox_qp.c
+++ b/drivers/common/nitrox/nitrox_qp.c
@@ -15,7 +15,7 @@
 
 static int
 nitrox_setup_cmdq(struct nitrox_qp *qp, uint8_t *bar_addr,
-		  const char *dev_name, uint8_t instr_size, int socket_id)
+		  const char *dev_name, uint8_t instr_size, int numa_id)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *mz;
@@ -24,7 +24,7 @@ nitrox_setup_cmdq(struct nitrox_qp *qp, uint8_t *bar_addr,
 	int err = 0;
 
 	snprintf(mz_name, sizeof(mz_name), "%s_cmdq_%d", dev_name, qp->qno);
-	mz = rte_memzone_reserve_aligned(mz_name, cmdq_size, socket_id,
+	mz = rte_memzone_reserve_aligned(mz_name, cmdq_size, numa_id,
 					 RTE_MEMZONE_SIZE_HINT_ONLY |
 					 RTE_MEMZONE_256MB,
 					 CMDQ_PKT_IN_ALIGN);
@@ -66,13 +66,13 @@ nitrox_setup_cmdq(struct nitrox_qp *qp, uint8_t *bar_addr,
 }
 
 static int
-nitrox_setup_ridq(struct nitrox_qp *qp, int socket_id)
+nitrox_setup_ridq(struct nitrox_qp *qp, int numa_id)
 {
 	size_t ridq_size = qp->count * sizeof(*qp->ridq);
 
-	qp->ridq = rte_zmalloc_socket("nitrox ridq", ridq_size,
+	qp->ridq = rte_zmalloc_numa("nitrox ridq", ridq_size,
 				   RTE_CACHE_LINE_SIZE,
-				   socket_id);
+				   numa_id);
 	if (!qp->ridq) {
 		NITROX_LOG_LINE(ERR, "Failed to create rid queue");
 		return -ENOMEM;
@@ -107,7 +107,7 @@ nitrox_release_cmdq(struct nitrox_qp *qp, uint8_t *bar_addr)
 RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_setup)
 int
 nitrox_qp_setup(struct nitrox_qp *qp, uint8_t *bar_addr, const char *dev_name,
-		uint32_t nb_descriptors, uint8_t instr_size, int socket_id)
+		uint32_t nb_descriptors, uint8_t instr_size, int numa_id)
 {
 	int err;
 	uint32_t count;
@@ -126,11 +126,11 @@ nitrox_qp_setup(struct nitrox_qp *qp, uint8_t *bar_addr, const char *dev_name,
 	qp->head = qp->tail = 0;
 	rte_atomic_store_explicit(&qp->pending_count, 0,
 				  rte_memory_order_relaxed);
-	err = nitrox_setup_cmdq(qp, bar_addr, dev_name, instr_size, socket_id);
+	err = nitrox_setup_cmdq(qp, bar_addr, dev_name, instr_size, numa_id);
 	if (err)
 		return err;
 
-	err = nitrox_setup_ridq(qp, socket_id);
+	err = nitrox_setup_ridq(qp, numa_id);
 	if (err)
 		goto ridq_err;
 
diff --git a/drivers/common/nitrox/nitrox_qp.h b/drivers/common/nitrox/nitrox_qp.h
index c328b88926..6aa3480cac 100644
--- a/drivers/common/nitrox/nitrox_qp.h
+++ b/drivers/common/nitrox/nitrox_qp.h
@@ -139,7 +139,7 @@ nitrox_qp_dequeue(struct nitrox_qp *qp)
 __rte_internal
 int nitrox_qp_setup(struct nitrox_qp *qp, uint8_t *bar_addr,
 		    const char *dev_name, uint32_t nb_descriptors,
-		    uint8_t inst_size, int socket_id);
+		    uint8_t inst_size, int numa_id);
 __rte_internal
 int nitrox_qp_release(struct nitrox_qp *qp, uint8_t *bar_addr);
 
-- 
2.55.0

