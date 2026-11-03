Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC14606D810
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=urYYNbtS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E849442E15;
	Tue,  3 Nov 2026 16:07:15 +0100 (CET)
Received: from mta1.migadu.com (out-114.mta1.migadu.com [95.215.58.114])
 by mails.dpdk.org (Postfix) with ESMTPS id E0DB342DE3
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:14 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=jAU5Vh6fthu6eTbeiFWxz3c29mqt248/DT8Rb1QEz/g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718433; v=1; x=1794323233;
 b=urYYNbtSk92DhIAR3UJQ6B2MrDzYrd+avNqk/NUyOT5ldTJxGQZgLqbI3aA99igj0lH6mK/l
 P7Y3lKa1WEYzyFZRNCzhnlv/BphPZNgQLB2V1Z/uuYbKZ6C+GTvFUDjRK/RgvtH9xhWKcx2YDZR
 lYKnaa+6Pnii1CnW6ylwxRF4=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 370b23a65d193c23;
 Tue, 03 Nov 2026 15:07:13 +0000
X-Mizu-Trace-ID: 370b23a65d193c23
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 084/227] dma/dpaa2: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:42 +0800
Message-ID: <20261103145306.487255-85-chengwen.feng@linux.dev>
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
 drivers/dma/dpaa2/dpaa2_qdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 8d10edfd04..2650d07695 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1400,7 +1400,7 @@ dpaa2_qdma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	qdma_dev->vqs[vchan].fle_pool = rte_mempool_create(pool_name,
 			DPAA2_QDMA_MAX_DESC * 2, pool_size,
 			512, 0, NULL, NULL, NULL, NULL,
-			SOCKET_ID_ANY, 0);
+			RTE_NUMA_ID_ANY, 0);
 	if (!qdma_dev->vqs[vchan].fle_pool) {
 		DPAA2_QDMA_ERR("%s create failed", pool_name);
 		return -ENOMEM;
@@ -1749,7 +1749,7 @@ dpaa2_qdma_probe(struct rte_dpaa2_driver *dpaa2_drv,
 	RTE_SET_USED(dpaa2_drv);
 
 	dmadev = rte_dma_pmd_allocate(dpaa2_dev->device.name,
-		rte_socket_id(),
+		rte_numa_id(),
 		sizeof(struct dpaa2_dpdmai_dev));
 	if (!dmadev) {
 		DPAA2_QDMA_ERR("Unable to allocate dmadevice");
-- 
2.55.0

