Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DB606A78E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nu4XG/wV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1A2042E37;
	Tue,  3 Nov 2026 16:07:25 +0100 (CET)
Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
 by mails.dpdk.org (Postfix) with ESMTPS id 47F0142E3A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:07:24 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=6aElbVx+zg3S+T7jeJAMlaP3oEmwCKOkeN2TcE97tt4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718442; v=1; x=1794323242;
 b=nu4XG/wVGT2THnKx5Y1kGtqKMFN/wNPdGUudTI78QzDaNAUFcpZwyyopGFSrUu4uMrxPz4cB
 xT4AOyESD3/fcI6v4/DxlICxXXizWcIo5zu6xHyjLsMWm4NUBZPYfQFliwRJCDiTvgsU4N4CcvS
 wn5duyHHOsMAdHN8Y5mDmhf0=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id c5f210c89d94628b;
 Tue, 03 Nov 2026 15:07:22 +0000
X-Mizu-Trace-ID: c5f210c89d94628b
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 085/227] dma/hisi_acc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:43 +0800
Message-ID: <20261103145306.487255-86-chengwen.feng@linux.dev>
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
 drivers/dma/hisi_acc/hisi_acc_dmadev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hisi_acc/hisi_acc_dmadev.c b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
index 196aaadc05..7754d27b40 100644
--- a/drivers/dma/hisi_acc/hisi_acc_dmadev.c
+++ b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
@@ -631,7 +631,7 @@ hacc_dma_create(struct rte_uacce_device *uacce_dev, uint16_t queue_id)
 			uacce_dev->qfrt_sz[RTE_UACCE_QFRT_DUS] - sizeof(uint32_t));
 	hw->cq_status = hw->sq_status - 1;
 
-	hw->status = rte_zmalloc_socket(NULL, sizeof(uint16_t) * hw->sq_depth,
+	hw->status = rte_zmalloc_numa(NULL, sizeof(uint16_t) * hw->sq_depth,
 					RTE_CACHE_LINE_SIZE, uacce_dev->numa_node);
 	if (hw->status == NULL) {
 		HACC_DMA_ERR(hw, "malloc status region fail!");
-- 
2.55.0

