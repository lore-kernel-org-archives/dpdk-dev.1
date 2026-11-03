Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233D606BA02
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o7Osfjin
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6E2442D68;
	Tue,  3 Nov 2026 16:02:45 +0100 (CET)
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 9127242C24
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:02:43 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=PDYl8/OKMZwQrWZ0JrrfRIDztnKv7IQHbvXnO5lJWqk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718163; v=1; x=1794322963;
 b=o7Osfjin5C26vZ42nL5A6WoN5pEf3D0cbm/J2mQzfc/Zw42O5kyii5YnGQjVT9GQBRZ3RXTr
 FN4ovD4z7CktywMMgsuZXmeepYQfTQx8RKc6C/IB8gfOQaeVEL2vNz3RHIpS9DtJ6YhCWBFl83x
 m06yhIkcFYZzk3jpKpxcur6g=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 17c1be2f09dfc4c5;
 Tue, 03 Nov 2026 15:02:43 +0000
X-Mizu-Trace-ID: 17c1be2f09dfc4c5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 059/227] compress/uadk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:17 +0800
Message-ID: <20261103145306.487255-60-chengwen.feng@linux.dev>
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
 drivers/compress/uadk/uadk_compress_pmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/compress/uadk/uadk_compress_pmd.c b/drivers/compress/uadk/uadk_compress_pmd.c
index 0d5cd21bec..2810b22b0c 100644
--- a/drivers/compress/uadk/uadk_compress_pmd.c
+++ b/drivers/compress/uadk/uadk_compress_pmd.c
@@ -157,7 +157,7 @@ uadk_pmd_qp_set_unique_name(struct rte_compressdev *dev,
 
 static struct rte_ring *
 uadk_pmd_qp_create_processed_pkts_ring(struct uadk_compress_qp *qp,
-				       unsigned int ring_size, int socket_id)
+				       unsigned int ring_size, int numa_id)
 {
 	struct rte_ring *r = qp->processed_pkts;
 
@@ -173,13 +173,13 @@ uadk_pmd_qp_create_processed_pkts_ring(struct uadk_compress_qp *qp,
 		return NULL;
 	}
 
-	return rte_ring_create(qp->name, ring_size, socket_id,
+	return rte_ring_create(qp->name, ring_size, numa_id,
 			       RING_F_EXACT_SZ);
 }
 
 static int
 uadk_compress_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
-			   uint32_t max_inflight_ops, int socket_id)
+			   uint32_t max_inflight_ops, int numa_id)
 {
 	struct uadk_compress_qp *qp = NULL;
 
@@ -188,8 +188,8 @@ uadk_compress_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		uadk_compress_pmd_qp_release(dev, qp_id);
 
 	/* Allocate the queue pair data structure. */
-	qp = rte_zmalloc_socket("uadk PMD Queue Pair", sizeof(*qp),
-				RTE_CACHE_LINE_SIZE, socket_id);
+	qp = rte_zmalloc_numa("uadk PMD Queue Pair", sizeof(*qp),
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (qp == NULL)
 		return (-ENOMEM);
 
@@ -200,7 +200,7 @@ uadk_compress_pmd_qp_setup(struct rte_compressdev *dev, uint16_t qp_id,
 		goto qp_setup_cleanup;
 
 	qp->processed_pkts = uadk_pmd_qp_create_processed_pkts_ring(qp,
-						max_inflight_ops, socket_id);
+						max_inflight_ops, numa_id);
 	if (qp->processed_pkts == NULL)
 		goto qp_setup_cleanup;
 
@@ -422,7 +422,7 @@ uadk_compress_probe(struct rte_vdev_device *vdev)
 {
 	struct rte_compressdev_pmd_init_params init_params = {
 		"",
-		rte_socket_id(),
+		rte_numa_id(),
 	};
 	struct rte_compressdev *compressdev;
 	struct uacce_dev *udev;
-- 
2.55.0

