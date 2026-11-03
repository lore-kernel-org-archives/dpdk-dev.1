Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66C606B254
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DZUf93cX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 987224275A;
	Tue,  3 Nov 2026 16:04:21 +0100 (CET)
Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
 by mails.dpdk.org (Postfix) with ESMTPS id 5FF8A427E9
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:04:20 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=MvTKSgoki4bZuJW6iZ9ROLtV3srVZzeoD5aJN64c3j8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718260; v=1; x=1794323060;
 b=DZUf93cXOPRdWVM/jpFLsympUwNN2yuTtlSas3EKO5+7tfmDATEMSwAx2DyXCBxyei6eT1NK
 CaPuFLZFh38jZBsgoIXB1z9yyF96YEfZBOsiiF2RAl3Vu/b9tZY1SyEMWqtdhgh5jU7rS1gn2M2
 ObzEtqiwz7ACd4MZnbGPjjvA=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id b42961a151ba83eb;
 Tue, 03 Nov 2026 15:04:20 +0000
X-Mizu-Trace-ID: b42961a151ba83eb
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 067/227] crypto/dpaa2_sec: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:25 +0800
Message-ID: <20261103145306.487255-68-chengwen.feng@linux.dev>
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
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 7bcb472838..64fbf20d5a 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -2084,7 +2084,7 @@ dpaa2_sec_queue_pair_release(struct rte_cryptodev *dev, uint16_t queue_pair_id)
 static int
 dpaa2_sec_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		const struct rte_cryptodev_qp_conf *qp_conf,
-		__rte_unused int socket_id)
+		__rte_unused int numa_id)
 {
 	struct dpaa2_sec_dev_private *priv = dev->data->dev_private;
 	struct dpaa2_sec_qp *qp;
@@ -2137,7 +2137,7 @@ dpaa2_sec_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			FLE_POOL_BUF_SIZE,
 			FLE_POOL_CACHE_SIZE, 0,
 			NULL, NULL, NULL, NULL,
-			SOCKET_ID_ANY, MEMPOOL_F_SP_PUT | MEMPOOL_F_SC_GET);
+			RTE_NUMA_ID_ANY, MEMPOOL_F_SP_PUT | MEMPOOL_F_SC_GET);
 	if (!qp->fle_pool) {
 		DPAA2_SEC_ERR("Mempool (%s) creation failed", str);
 		return -ENOMEM;
@@ -4376,7 +4376,7 @@ dpaa2_sec_uninit(const struct rte_cryptodev *dev)
 	rte_free(dev->security_ctx);
 
 	DPAA2_SEC_INFO("Closing DPAA2_SEC device %s on numa socket %u",
-		       dev->data->name, rte_socket_id());
+		       dev->data->name, rte_numa_id());
 
 	return 0;
 }
-- 
2.55.0

