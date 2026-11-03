Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F5606B26C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KARJuutV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E595E42D35;
	Tue,  3 Nov 2026 16:02:35 +0100 (CET)
Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 386B942D26
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:02:35 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=I+bfHTwpEK6RMH4zHvsTooETHYBH7FfbuCbQmnHgl2k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718154; v=1; x=1794322954;
 b=KARJuutV6y7hSbqecRbM98Q4Pn1IUumf0b6aC7+un39PywkR8dchgKsLX8y0La7Gtc7oMw40
 iPxgPnaexbsayyJOq4dBN7xJllzcW6azhPd/C9EbYosYgEeTn9IAqoQ4eKaOJXzR9veJWgBdZHr
 uQ8C0aH/QPMFFLHN5qky7/ys=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id fb8e181f79bb9f09;
 Tue, 03 Nov 2026 15:02:34 +0000
X-Mizu-Trace-ID: fb8e181f79bb9f09
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 058/227] compress/octeontx: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:16 +0800
Message-ID: <20261103145306.487255-59-chengwen.feng@linux.dev>
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
 drivers/compress/octeontx/otx_zip_pmd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/compress/octeontx/otx_zip_pmd.c b/drivers/compress/octeontx/otx_zip_pmd.c
index 74e3e942ad..a70e9ddfa5 100644
--- a/drivers/compress/octeontx/otx_zip_pmd.c
+++ b/drivers/compress/octeontx/otx_zip_pmd.c
@@ -225,7 +225,7 @@ zip_pmd_config(struct rte_compressdev *dev,
 			NULL,
 			NULL,
 			NULL,
-			SOCKET_ID_ANY,
+			RTE_NUMA_ID_ANY,
 			0);
 
 	if (zip_buf_mp == NULL) {
@@ -246,7 +246,7 @@ zip_pmd_config(struct rte_compressdev *dev,
 			NULL,
 			NULL,
 			NULL,
-			SOCKET_ID_ANY,
+			RTE_NUMA_ID_ANY,
 			MEMPOOL_F_NO_SPREAD);
 
 	if (zip_sg_mp == NULL) {
@@ -356,7 +356,7 @@ zip_pmd_qp_release(struct rte_compressdev *dev, uint16_t qp_id)
 /** Create a ring to place process packets on */
 static struct rte_ring *
 zip_pmd_qp_create_processed_pkts_ring(struct zipvf_qp *qp,
-		unsigned int ring_size, int socket_id)
+		unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 
@@ -373,14 +373,14 @@ zip_pmd_qp_create_processed_pkts_ring(struct zipvf_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 						RING_F_EXACT_SZ);
 }
 
 /** Setup a queue pair */
 static int
 zip_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		uint32_t max_inflight_ops, int socket_id)
+		uint32_t max_inflight_ops, int numa_id)
 {
 	struct zipvf_qp *qp = NULL;
 	struct zip_vf *vf;
@@ -406,8 +406,8 @@ zip_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		 dev->data->dev_id, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket(name, sizeof(*qp),
-				RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa(name, sizeof(*qp),
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL) {
 		rte_free(name);
 		return (-ENOMEM);
@@ -417,7 +417,7 @@ zip_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 
 	/* Create completion queue up to max_inflight_ops */
 	qp->processed_pkts = zip_pmd_qp_create_processed_pkts_ring(qp,
-						max_inflight_ops, socket_id);
+						max_inflight_ops, numa_id);
 	if (qp->processed_pkts == NULL)
 		goto qp_setup_cleanup;
 
@@ -629,7 +629,7 @@ zip_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	struct rte_compressdev *compressdev;
 	struct rte_compressdev_pmd_init_params init_params = {
 		"",
-		rte_socket_id(),
+		rte_numa_id(),
 	};
 
 	ZIP_PMD_INFO("vendor_id=0x%x device_id=0x%x",
-- 
2.55.0

