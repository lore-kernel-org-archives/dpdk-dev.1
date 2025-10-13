Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27CACCD183
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 09:22:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83A60402E0;
	Mon, 13 Oct 2025 11:22:20 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 41CC74021E
 for <dev@dpdk.org>; Mon, 13 Oct 2025 11:22:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/eoAGMiKYa1G9lfgtgR04HuaUOI386Spg0g3bcSu6RY=;
 b=rfJTb6XMz3pcSAG/mvPjw1ebtyotbbuGx3/9rMf3ypEcXqDZD6IQbSGjvsugIvir7j/5KL1Aa
 LgRtQfMU2LxDMfsrRQXrGhpuskVW0nOO5c0TpY3dlzH+d6Icmlw3lGUHq0WJAWpKBvLPWkYiQv8
 Olxt3cvPDVBKHVqMGfDowLc=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4clX124fNyzKm54;
 Mon, 13 Oct 2025 17:21:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 98E201A0188;
 Mon, 13 Oct 2025 17:22:17 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 17:22:17 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] dma/hisilicon: fix stop dmadev fail
Date: Mon, 13 Oct 2025 17:22:11 +0800
Message-ID: <20251013092211.6804-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Stop dmadev may fail if there are pending DMA transfers, we need make
sure there are no pending DMA transfers when stop.

This commit uses following scheme:
1. flag stop proc so that new request will not process.
2. setting drop flag for all descriptor to quick complete.
3. waiting dmadev to complete.

Fixes: 3c5f5f03a047 ("dma/hisilicon: add control path")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma/hisilicon/hisi_dmadev.c | 36 +++++++++++++++++++++++++++--
 drivers/dma/hisilicon/hisi_dmadev.h |  2 ++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/hisilicon/hisi_dmadev.c b/drivers/dma/hisilicon/hisi_dmadev.c
index 019c4a8189..ff6eb10167 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.c
+++ b/drivers/dma/hisilicon/hisi_dmadev.c
@@ -376,6 +376,7 @@ hisi_dma_start(struct rte_dma_dev *dev)
 	hw->cq_head = 0;
 	hw->cqs_completed = 0;
 	hw->cqe_vld = 1;
+	hw->stop_proc = 0;
 	hw->submitted = 0;
 	hw->completed = 0;
 	hw->errors = 0;
@@ -387,9 +388,37 @@ hisi_dma_start(struct rte_dma_dev *dev)
 	return 0;
 }
 
+static int
+hisi_dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan,
+		      enum rte_dma_vchan_status *status);
 static int
 hisi_dma_stop(struct rte_dma_dev *dev)
 {
+#define MAX_WAIT_MSEC	10
+	struct hisi_dma_dev *hw = dev->data->dev_private;
+	enum rte_dma_vchan_status status;
+	uint32_t i;
+
+	/* Flag stop processing new requests. */
+	hw->stop_proc = 1;
+	rte_delay_ms(1);
+
+	/* Force set drop flag so that the hardware can quickly complete. */
+	for (i = 0; i <= hw->sq_depth_mask; i++)
+		hw->sqe[i].dw0 |= SQE_DROP_FLAG;
+
+	i = 0;
+	do {
+		hisi_dma_vchan_status(dev, 0, &status);
+		if (status != RTE_DMA_VCHAN_ACTIVE)
+			break;
+		rte_delay_ms(1);
+	} while (i++ < MAX_WAIT_MSEC);
+	if (status == RTE_DMA_VCHAN_ACTIVE) {
+		HISI_DMA_ERR(hw, "dev is still active!");
+		return -EBUSY;
+	}
+
 	return hisi_dma_reset_hw(dev->data->dev_private);
 }
 
@@ -548,14 +577,14 @@ hisi_dma_dump(const struct rte_dma_dev *dev, FILE *f)
 		"    revision: 0x%x queue_id: %u ring_size: %u\n"
 		"    ridx: %u cridx: %u\n"
 		"    sq_head: %u sq_tail: %u cq_sq_head: %u\n"
-		"    cq_head: %u cqs_completed: %u cqe_vld: %u\n"
+		"    cq_head: %u cqs_completed: %u cqe_vld: %u stop_proc: %u\n"
 		"    submitted: %" PRIu64 " completed: %" PRIu64 " errors: %"
 		PRIu64 " qfulls: %" PRIu64 "\n",
 		hw->revision, hw->queue_id,
 		hw->sq_depth_mask > 0 ? hw->sq_depth_mask + 1 : 0,
 		hw->ridx, hw->cridx,
 		hw->sq_head, hw->sq_tail, hw->cq_sq_head,
-		hw->cq_head, hw->cqs_completed, hw->cqe_vld,
+		hw->cq_head, hw->cqs_completed, hw->cqe_vld, hw->stop_proc,
 		hw->submitted, hw->completed, hw->errors, hw->qfulls);
 	hisi_dma_dump_queue(hw, f);
 	hisi_dma_dump_common(hw, f);
@@ -573,6 +602,9 @@ hisi_dma_copy(void *dev_private, uint16_t vchan,
 
 	RTE_SET_USED(vchan);
 
+	if (unlikely(hw->stop_proc > 0))
+		return -EPERM;
+
 	if (((hw->sq_tail + 1) & hw->sq_depth_mask) == hw->sq_head) {
 		hw->qfulls++;
 		return -ENOSPC;
diff --git a/drivers/dma/hisilicon/hisi_dmadev.h b/drivers/dma/hisilicon/hisi_dmadev.h
index 90301e6b00..aab87c40be 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.h
+++ b/drivers/dma/hisilicon/hisi_dmadev.h
@@ -141,6 +141,7 @@ enum {
 
 struct hisi_dma_sqe {
 	uint32_t dw0;
+#define SQE_DROP_FLAG	BIT(4)
 #define SQE_FENCE_FLAG	BIT(10)
 #define SQE_OPCODE_M2M	0x4
 	uint32_t dw1;
@@ -211,6 +212,7 @@ struct hisi_dma_dev {
 	 */
 	uint16_t cqs_completed;
 	uint8_t cqe_vld; /**< valid bit for CQE, will change for every round. */
+	volatile uint8_t stop_proc; /**< whether stop processing new requests. */
 
 	uint64_t submitted;
 	uint64_t completed;
-- 
2.17.1

