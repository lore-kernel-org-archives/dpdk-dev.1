Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF89606A7AF
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M2R7txHK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C66B42DC7;
	Tue,  3 Nov 2026 16:06:54 +0100 (CET)
Received: from mta1.migadu.com (out-96.mta1.migadu.com [95.215.58.96])
 by mails.dpdk.org (Postfix) with ESMTPS id 1A6BD4113D
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:06:53 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=H3FBLaNehdr8qXXBWAw56MqWNYjcmDuyBeybg8aTHIQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718412; v=1; x=1794323212;
 b=M2R7txHKFmY4OVw0Xl53b8ktpGUa1dS5x7nedZSMjVv0pJB0Ly630KZLJ2+oJyPSP7UmoHZZ
 Rh/aPMXpwZS2KOvR7sLhlEQtAphG3MkM9vs61DDM5n7PXGYTNVLXj7qYeEtqZEQyNk5UpfiV2i1
 q/DDvv3mkVayE6bJlPIYjxEc=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 26bcb8f8d903d583;
 Tue, 03 Nov 2026 15:06:52 +0000
X-Mizu-Trace-ID: 26bcb8f8d903d583
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 081/227] dma/ae4dma: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:39 +0800
Message-ID: <20261103145306.487255-82-chengwen.feng@linux.dev>
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
 drivers/dma/ae4dma/ae4dma_dmadev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
index 64c19955eb..fdce20df2d 100644
--- a/drivers/dma/ae4dma/ae4dma_dmadev.c
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -26,9 +26,9 @@ RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
 #define AE4DMA_PMD_NAME dmadev_ae4dma
 
 static const struct rte_memzone *
-ae4dma_queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size, int socket_id)
+ae4dma_queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size, int numa_id)
 {
-	return rte_memzone_reserve_aligned(queue_name, queue_size, socket_id,
+	return rte_memzone_reserve_aligned(queue_name, queue_size, numa_id,
 		RTE_MEMZONE_IOVA_CONTIG, queue_size);
 }
 
@@ -507,7 +507,7 @@ ae4dma_add_queue(struct ae4dma_dmadev *dev, struct rte_pci_device *pci, uint8_t
 	snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name), "ae4dma_%s_q%u", pci_name,
 		(unsigned int)qn);
 
-	q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name, cmd_q->qsize, rte_socket_id());
+	q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name, cmd_q->qsize, rte_numa_id());
 	if (q_mz == NULL) {
 		AE4DMA_PMD_ERR("memzone reserve failed for %s", cmd_q->memz_name);
 		return -ENOMEM;
-- 
2.55.0

