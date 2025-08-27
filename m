Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46AC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E478340298;
	Wed, 27 Aug 2025 11:27:34 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 8B46F4028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 11:27:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cBfLz6zSSz14MVF;
 Wed, 27 Aug 2025 17:27:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id DC8DF180B68;
 Wed, 27 Aug 2025 17:27:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 17:27:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <liuyonglong@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 2/4] dma/acc: add control path ops
Date: Wed, 27 Aug 2025 17:27:27 +0800
Message-ID: <20250827092729.10719-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250827092729.10719-1-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
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

This commit adds control path ops for accelerator DMA driver.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma/acc/acc_dmadev.c | 156 +++++++++++++++++++++++++++++++++++
 drivers/dma/acc/acc_dmadev.h |  42 ++++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/dma/acc/acc_dmadev.c b/drivers/dma/acc/acc_dmadev.c
index b479d52c91..ce2f45cedb 100644
--- a/drivers/dma/acc/acc_dmadev.c
+++ b/drivers/dma/acc/acc_dmadev.c
@@ -34,6 +34,161 @@ RTE_LOG_REGISTER_DEFAULT(acc_dma_logtype, INFO);
 #define ACC_DMA_ERR(hw, ...) \
 	ACC_DMA_DEV_LOG(hw, ERR, __VA_ARGS__)
 
+static int
+acc_dma_info_get(const struct rte_dma_dev *dev,
+		 struct rte_dma_info *dev_info,
+		 uint32_t info_sz)
+{
+	struct acc_dma_dev *hw = dev->data->dev_private;
+
+	RTE_SET_USED(info_sz);
+
+	dev_info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM |
+			     RTE_DMA_CAPA_SVA |
+			     RTE_DMA_CAPA_OPS_COPY |
+			     RTE_DMA_CAPA_OPS_FILL;
+	dev_info->max_vchans = 1;
+	dev_info->max_desc = hw->sq_depth;
+	dev_info->min_desc = hw->sq_depth;
+
+	return 0;
+}
+
+static int
+acc_dma_configure(struct rte_dma_dev *dev,
+		  const struct rte_dma_conf *conf,
+		  uint32_t conf_sz)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(conf);
+	RTE_SET_USED(conf_sz);
+	return 0;
+}
+
+static int
+acc_dma_start(struct rte_dma_dev *dev)
+{
+	struct acc_dma_dev *hw = dev->data->dev_private;
+	int ret;
+
+	if (hw->started) {
+		hw->ridx = 0;
+		hw->cridx = 0;
+		return 0;
+	}
+
+	memset(hw->sqe, 0, hw->sqe_size * hw->sq_depth);
+	memset(hw->cqe, 0, sizeof(struct acc_dma_cqe) * hw->cq_depth);
+	memset(hw->status, 0, sizeof(uint16_t) * hw->sq_depth);
+	hw->ridx = 0;
+	hw->cridx = 0;
+	hw->sq_head = 0;
+	hw->sq_tail = 0;
+	hw->cq_sq_head = 0;
+	hw->avail_sqes = hw->sq_depth - ACC_DMA_SQ_GAP_NUM - 1;
+	hw->cq_head = 0;
+	hw->cqs_completed = 0;
+	hw->cqe_vld = 1;
+	hw->submitted = 0;
+	hw->completed = 0;
+	hw->errors = 0;
+	hw->invalid_lens = 0;
+	hw->qfulls = 0;
+
+	ret = rte_uacce_queue_start(&hw->qctx);
+	if (ret == 0)
+		hw->started = true;
+
+	return ret;
+}
+
+static int
+acc_dma_stop(struct rte_dma_dev *dev)
+{
+	RTE_SET_USED(dev);
+	return 0;
+}
+
+static int
+acc_dma_close(struct rte_dma_dev *dev)
+{
+	struct acc_dma_dev *hw = dev->data->dev_private;
+	/* The dmadev already stopped */
+	rte_free(hw->status);
+	rte_uacce_queue_unmap(&hw->qctx, RTE_UACCE_QFRT_DUS);
+	rte_uacce_queue_unmap(&hw->qctx, RTE_UACCE_QFRT_MMIO);
+	rte_uacce_queue_free(&hw->qctx);
+	return 0;
+}
+
+static int
+acc_dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
+		    const struct rte_dma_vchan_conf *conf,
+		    uint32_t conf_sz)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(vchan);
+	RTE_SET_USED(conf);
+	RTE_SET_USED(conf_sz);
+	return 0;
+}
+
+static int
+acc_dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan,
+		  struct rte_dma_stats *stats,
+		  uint32_t stats_sz)
+{
+	struct acc_dma_dev *hw = dev->data->dev_private;
+
+	RTE_SET_USED(vchan);
+	RTE_SET_USED(stats_sz);
+	stats->submitted = hw->submitted;
+	stats->completed = hw->completed;
+	stats->errors    = hw->errors;
+
+	return 0;
+}
+
+static int
+acc_dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan)
+{
+	struct acc_dma_dev *hw = dev->data->dev_private;
+
+	RTE_SET_USED(vchan);
+	hw->submitted    = 0;
+	hw->completed    = 0;
+	hw->errors       = 0;
+	hw->invalid_lens = 0;
+	hw->io_errors    = 0;
+	hw->qfulls       = 0;
+
+	return 0;
+}
+
+static int
+acc_dma_dump(const struct rte_dma_dev *dev, FILE *f)
+{
+	struct acc_dma_dev *hw = dev->data->dev_private;
+
+	fprintf(f, "  sqn: %u sq_status: %s cq_status: %s\n"
+		"  sqe_size: %u sq_depth: %u sq_depth_mask: %u cq_depth: %u\n",
+		hw->sqn, (*hw->sq_status != 0) ? "ERR" : "OK",
+		(*hw->cq_status != 0) ? "ERR" : "OK",
+		hw->sqe_size, hw->sq_depth, hw->sq_depth_mask, hw->cq_depth);
+	fprintf(f, "  ridx: %u cridx: %u\n"
+		"  sq_head: %u sq_tail: %u cq_sq_head: %u avail_sqes: %u\n"
+		"  cq_head: %u cqs_completed: %u cqe_vld: %u\n",
+		hw->ridx, hw->cridx,
+		hw->sq_head, hw->sq_tail, hw->cq_sq_head, hw->avail_sqes,
+		hw->cq_head, hw->cqs_completed, hw->cqe_vld);
+	fprintf(f, "  submitted: %" PRIu64 " completed: %" PRIu64 " errors: %" PRIu64
+		" invalid_lens: %" PRIu64 " io_errors: %" PRIu64 " qfulls: %" PRIu64 "\n",
+		hw->submitted, hw->completed, hw->errors, hw->invalid_lens,
+		hw->io_errors, hw->qfulls);
+
+	return 0;
+}
+
 static void
 acc_dma_gen_dev_name(const struct rte_uacce_device *uacce_dev,
 		     uint16_t queue_id, char *dev_name, size_t size)
@@ -104,6 +259,7 @@ acc_dma_create(struct rte_uacce_device *uacce_dev, uint16_t queue_id)
 	}
 
 	dev->device = &uacce_dev->device;
+	dev->dev_ops = &acc_dmadev_ops;
 	dev->fp_obj->dev_private = dev->data->dev_private;
 
 	hw = dev->data->dev_private;
diff --git a/drivers/dma/acc/acc_dmadev.h b/drivers/dma/acc/acc_dmadev.h
index ce613541c0..b87626c244 100644
--- a/drivers/dma/acc/acc_dmadev.h
+++ b/drivers/dma/acc/acc_dmadev.h
@@ -13,6 +13,9 @@
 #define ACC_DMA_DEVARG_QUEUES		"queues"
 #define ACC_DMA_DEFAULT_QUEUES		1
 
+#define ACC_DMA_CQ_DOORBELL_PACE	64
+#define ACC_DMA_SQ_GAP_NUM		ACC_DMA_CQ_DOORBELL_PACE
+
 struct acc_dma_config {
 	uint16_t queues;
 
@@ -36,7 +39,45 @@ struct acc_dma_dev {
 	uint16_t sqn;           /**< SQ global number, inited when created. */
 	uint16_t sq_depth_mask; /**< SQ depth - 1, the SQ depth is power of 2. */
 
+	uint16_t ridx;  /**< ring index which will assign to the next request. */
+	uint16_t cridx; /**< ring index which returned by completed APIs. */
+
+	/**
+	 * SQE array management fields:
+	 *
+	 *  -----------------------------------------------------
+	 *  | SQE0 | SQE1 | SQE2 |   ...  | SQEx | ... | SQEn-1 |
+	 *  -----------------------------------------------------
+	 *     ^             ^               ^
+	 *     |             |               |
+	 *   sq_head     cq_sq_head       sq_tail
+	 *
+	 *  sq_head: index to the oldest completed request, this filed was
+	 *           updated by completed* APIs.
+	 *  sq_tail: index of the next new request, this field was updated by
+	 *           copy API.
+	 *  cq_sq_head: next index of index that has been completed by hardware,
+	 *              this filed was updated by completed* APIs.
+	 *
+	 *  [sq_head, cq_sq_head): the SQEs that hardware already completed.
+	 *  [cq_sq_head, sq_tail): the SQEs that hardware processing.
+	 */
+	uint16_t sq_head;
+	uint16_t sq_tail;
+	uint16_t cq_sq_head;
+	uint16_t avail_sqes;
+
 	uint16_t cq_depth;      /**< CQ depth, inited when created. */
+	uint16_t cq_head;       /**< CQ index for next scans. */
+	uint16_t cqs_completed; /**< accumulated number of completed CQs. */
+	uint8_t  cqe_vld;       /**< valid bit for CQE, will change for every round. */
+
+	uint64_t submitted;
+	uint64_t completed;
+	uint64_t errors;
+	uint64_t invalid_lens;
+	uint64_t io_errors;
+	uint64_t qfulls;
 
 	/**
 	 * The following fields are not accessed in the I/O path, so they are
@@ -48,6 +89,7 @@ struct acc_dma_dev {
 	void *dus_base;
 	uint32_t sqe_size;
 	uint16_t sq_depth;
+	bool started;
 };
 
 #endif /* ACC_DMADEV_H */
-- 
2.17.1

