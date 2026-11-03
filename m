Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFB606EEB7
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ucwfWwRb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F90D4281D;
	Tue,  3 Nov 2026 16:01:56 +0100 (CET)
Received: from mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 7C75B4281D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:01:54 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=wt+c6ol7kbx+3phnPGAVX4ngzztTirPdvRPUVF7VWSQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718114; v=1; x=1794322914;
 b=ucwfWwRbuJnwEgj5lQT3fM+1c2EAfvcB3Jiuro5/DcgIIgi/BG8pTEY5F4wS5XcuJlS0xtgU
 AepRuu58BZzNSoZjwaJJ7RhZyXQS+WwY3151If3pscIo+LknNkzqXVgN30IB/xymZIEKXqsXiqw
 f/au3TBlZSPlBOv5iwLqJh3A=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 71186dcd5de6c4c6;
 Tue, 03 Nov 2026 15:01:54 +0000
X-Mizu-Trace-ID: 71186dcd5de6c4c6
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 055/227] compress/isal: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:13 +0800
Message-ID: <20261103145306.487255-56-chengwen.feng@linux.dev>
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
 drivers/compress/isal/isal_compress_pmd.c     |  4 ++--
 drivers/compress/isal/isal_compress_pmd_ops.c | 24 +++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/compress/isal/isal_compress_pmd.c b/drivers/compress/isal/isal_compress_pmd.c
index 0e783243a8..f021720a38 100644
--- a/drivers/compress/isal/isal_compress_pmd.c
+++ b/drivers/compress/isal/isal_compress_pmd.c
@@ -725,7 +725,7 @@ compdev_isal_probe(struct rte_vdev_device *dev)
 {
 	struct rte_compressdev_pmd_init_params init_params = {
 		"",
-		rte_socket_id(),
+		rte_numa_id(),
 	};
 	const char *name, *args;
 	int retval;
@@ -753,5 +753,5 @@ static struct rte_vdev_driver compdev_isal_pmd_drv = {
 
 RTE_PMD_REGISTER_VDEV(COMPDEV_NAME_ISAL_PMD, compdev_isal_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(COMPDEV_NAME_ISAL_PMD,
-	"socket_id=<int>");
+	"numa_id=<int>");
 RTE_LOG_REGISTER_DEFAULT(isal_logtype_driver, INFO);
diff --git a/drivers/compress/isal/isal_compress_pmd_ops.c b/drivers/compress/isal/isal_compress_pmd_ops.c
index be32a4c998..67cf060801 100644
--- a/drivers/compress/isal/isal_compress_pmd_ops.c
+++ b/drivers/compress/isal/isal_compress_pmd_ops.c
@@ -192,7 +192,7 @@ isal_comp_pmd_qp_release(struct rte_compressdev *dev, uint16_t qp_id)
 /** Create a ring to place process packets on */
 static struct rte_ring *
 isal_comp_pmd_qp_create_processed_pkts_ring(struct isal_comp_qp *qp,
-		unsigned int ring_size, int socket_id)
+		unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r;
 
@@ -212,7 +212,7 @@ isal_comp_pmd_qp_create_processed_pkts_ring(struct isal_comp_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 }
 
@@ -234,7 +234,7 @@ struct isal_comp_qp *qp)
 /* Setup a queue pair */
 static int
 isal_comp_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		uint32_t max_inflight_ops, int socket_id)
+		uint32_t max_inflight_ops, int numa_id)
 {
 	struct isal_comp_qp *qp = NULL;
 	int retval;
@@ -244,34 +244,34 @@ isal_comp_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		isal_comp_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("Isa-l compression PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("Isa-l compression PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL) {
 		ISAL_PMD_LOG(ERR, "Failed to allocate queue pair memory");
 		return (-ENOMEM);
 	}
 
 	/* Initialize memory for compression stream structure */
-	qp->stream = rte_zmalloc_socket("Isa-l compression stream ",
+	qp->stream = rte_zmalloc_numa("Isa-l compression stream ",
 			sizeof(struct isal_zstream),  RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (qp->stream == NULL) {
 		ISAL_PMD_LOG(ERR, "Failed to allocate compression stream memory");
 		goto qp_setup_cleanup;
 	}
 	/* Initialize memory for compression level buffer */
-	qp->stream->level_buf = rte_zmalloc_socket("Isa-l compression lev_buf",
+	qp->stream->level_buf = rte_zmalloc_numa("Isa-l compression lev_buf",
 			ISAL_DEF_LVL3_DEFAULT, RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (qp->stream->level_buf == NULL) {
 		ISAL_PMD_LOG(ERR, "Failed to allocate compression level_buf memory");
 		goto qp_setup_cleanup;
 	}
 
 	/* Initialize memory for decompression state structure */
-	qp->state = rte_zmalloc_socket("Isa-l decompression state",
+	qp->state = rte_zmalloc_numa("Isa-l decompression state",
 			sizeof(struct inflate_state), RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (qp->state == NULL) {
 		ISAL_PMD_LOG(ERR, "Failed to allocate decompression state memory");
 		goto qp_setup_cleanup;
@@ -288,7 +288,7 @@ isal_comp_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 	}
 
 	qp->processed_pkts = isal_comp_pmd_qp_create_processed_pkts_ring(qp,
-			max_inflight_ops, socket_id);
+			max_inflight_ops, numa_id);
 	if (qp->processed_pkts == NULL) {
 		ISAL_PMD_LOG(ERR, "Failed to create unique name for isal "
 				"compression device");
-- 
2.55.0

