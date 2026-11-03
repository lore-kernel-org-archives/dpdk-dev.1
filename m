Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CB606B259
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sXdzyTkH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B523B41141;
	Tue,  3 Nov 2026 16:03:25 +0100 (CET)
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
 by mails.dpdk.org (Postfix) with ESMTPS id 44B3F4113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:03:24 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=vmJoDiwsvGkTmH3xwuxv+vHkB5MpzpRiumrY8L1ebps=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718203; v=1; x=1794323003;
 b=sXdzyTkHPd+aRIP1uBOBsHsC3Ok7xlCSwRlilcbxMszKfqXbh9sATVArxCUVb46nCI3bM4zq
 yJ07c6pavW0pNz/7nTdwgCMBWmyqmdgq/HIt1P6Kk8cNDZ7erdYNNWNzeQJ+VUD6/gAWyQqiwUl
 U28ZP+gEywx1PUS+HNaowMBM=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 1761e73ffcaf115e;
 Tue, 03 Nov 2026 15:03:23 +0000
X-Mizu-Trace-ID: 1761e73ffcaf115e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 060/227] compress/zlib: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:18 +0800
Message-ID: <20261103145306.487255-61-chengwen.feng@linux.dev>
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
 drivers/compress/zlib/zlib_pmd.c     |  2 +-
 drivers/compress/zlib/zlib_pmd_ops.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index ed3905484c..6943367b6f 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -535,7 +535,7 @@ zlib_probe(struct rte_vdev_device *vdev)
 {
 	struct rte_compressdev_pmd_init_params init_params = {
 		"",
-		rte_socket_id()
+		rte_numa_id()
 	};
 	const char *name;
 	const char *input_args;
diff --git a/drivers/compress/zlib/zlib_pmd_ops.c b/drivers/compress/zlib/zlib_pmd_ops.c
index fb9cec8488..e240db25f4 100644
--- a/drivers/compress/zlib/zlib_pmd_ops.c
+++ b/drivers/compress/zlib/zlib_pmd_ops.c
@@ -155,7 +155,7 @@ zlib_pmd_qp_set_unique_name(struct rte_compressdev *dev,
 /** Create a ring to place process packets on */
 static struct rte_ring *
 zlib_pmd_qp_create_processed_pkts_ring(struct zlib_qp *qp,
-		unsigned int ring_size, int socket_id)
+		unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r = qp->processed_pkts;
 
@@ -171,14 +171,14 @@ zlib_pmd_qp_create_processed_pkts_ring(struct zlib_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 						RING_F_EXACT_SZ);
 }
 
 /** Setup a queue pair */
 static int
 zlib_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-		uint32_t max_inflight_ops, int socket_id)
+		uint32_t max_inflight_ops, int numa_id)
 {
 	struct zlib_qp *qp = NULL;
 
@@ -187,8 +187,8 @@ zlib_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		zlib_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("ZLIB PMD Queue Pair", sizeof(*qp),
-					RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("ZLIB PMD Queue Pair", sizeof(*qp),
+					RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL)
 		return (-ENOMEM);
 
@@ -199,7 +199,7 @@ zlib_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		goto qp_setup_cleanup;
 
 	qp->processed_pkts = zlib_pmd_qp_create_processed_pkts_ring(qp,
-			max_inflight_ops, socket_id);
+			max_inflight_ops, numa_id);
 	if (qp->processed_pkts == NULL)
 		goto qp_setup_cleanup;
 
-- 
2.55.0

