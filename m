Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550CCCA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 08:51:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B864065D;
	Wed, 10 Sep 2025 10:51:10 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id CEEE2402E8
 for <dev@dpdk.org>; Wed, 10 Sep 2025 10:51:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cMDq55mlLz1R8wp;
 Wed, 10 Sep 2025 16:48:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 531F11A0171;
 Wed, 10 Sep 2025 16:51:04 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 16:51:03 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH v3 3/4] dma/acc: add data path ops
Date: Wed, 10 Sep 2025 16:51:01 +0800
Message-ID: <20250910085102.3563-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250910085102.3563-1-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <20250910085102.3563-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

This commit adds data path ops for accelerator DMA driver.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma/acc/acc_dmadev.c | 274 +++++++++++++++++++++++++++++++++++
 drivers/dma/acc/acc_dmadev.h |  75 +++++++++-
 2 files changed, 347 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/acc/acc_dmadev.c b/drivers/dma/acc/acc_dmadev.c
index bc0a995c7a..e93354fe72 100644
--- a/drivers/dma/acc/acc_dmadev.c
+++ b/drivers/dma/acc/acc_dmadev.c
@@ -189,6 +189,274 @@ acc_dma_dump(const struct rte_dma_dev *dev, FILE *f)
 	return 0;
 }
 
+static inline void
+acc_dma_sq_doorbell(struct acc_dma_dev *hw)
+{
+	uint64_t doorbell = (uint64_t)(hw->sqn & ACC_DMA_DOORBELL_SQN_MASK) |
+			    (ACC_DMA_DOORBELL_SQ_CMD << ACC_DMA_DOORBELL_CMD_SHIFT) |
+			    (((uint64_t)hw->sq_tail) << ACC_DMA_DOORBELL_IDX_SHIFT);
+	rte_io_wmb();
+	*(volatile uint64_t *)hw->doorbell_reg = doorbell;
+}
+
+static int
+acc_dma_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t dst,
+	     uint32_t length, uint64_t flags)
+{
+	struct acc_dma_dev *hw = dev_private;
+	struct acc_dma_sqe *sqe = &hw->sqe[hw->sq_tail];
+
+	RTE_SET_USED(vchan);
+
+	if (unlikely(length > ACC_DMA_MAX_OP_SIZE)) {
+		hw->invalid_lens++;
+		return -EINVAL;
+	}
+
+	if (unlikely(*hw->sq_status != 0)) {
+		hw->io_errors++;
+		return -EIO;
+	}
+
+	if (hw->avail_sqes == 0) {
+		hw->qfulls++;
+		return -ENOSPC;
+	}
+
+	sqe->bd_type       = ACC_DMA_SQE_TYPE;
+	sqe->task_type     = ACC_DMA_TASK_TYPE;
+	sqe->task_type_ext = ACC_DMA_DATA_MEMCPY;
+	sqe->init_val      = 0;
+	sqe->addr_array    = src;
+	sqe->dst_addr      = dst;
+	sqe->data_size     = length;
+	sqe->dw0           = ACC_DMA_SVA_PREFETCH_EN;
+	sqe->wb_field      = 0;
+
+	hw->sq_tail = (hw->sq_tail + 1) & hw->sq_depth_mask;
+	hw->avail_sqes--;
+	hw->submitted++;
+
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
+		acc_dma_sq_doorbell(hw);
+
+	return hw->ridx++;
+}
+
+static int
+acc_dma_fill(void *dev_private, uint16_t vchan, uint64_t pattern,
+	     rte_iova_t dst, uint32_t length, uint64_t flags)
+{
+	struct acc_dma_dev *hw = dev_private;
+	struct acc_dma_sqe *sqe = &hw->sqe[hw->sq_tail];
+
+	RTE_SET_USED(vchan);
+
+	if (unlikely(length > ACC_DMA_MAX_OP_SIZE)) {
+		hw->invalid_lens++;
+		return -EINVAL;
+	}
+
+	if (unlikely(*hw->sq_status != 0)) {
+		hw->io_errors++;
+		return -EIO;
+	}
+
+	if (hw->avail_sqes == 0) {
+		hw->qfulls++;
+		return -ENOSPC;
+	}
+
+	sqe->bd_type       = ACC_DMA_SQE_TYPE;
+	sqe->task_type     = ACC_DMA_TASK_TYPE;
+	sqe->task_type_ext = ACC_DMA_DATA_MEMSET;
+	sqe->init_val      = pattern;
+	sqe->addr_array    = 0;
+	sqe->dst_addr      = dst;
+	sqe->data_size     = length;
+	sqe->dw0           = ACC_DMA_SVA_PREFETCH_EN;
+	sqe->wb_field      = 0;
+
+	hw->sq_tail = (hw->sq_tail + 1) & hw->sq_depth_mask;
+	hw->avail_sqes--;
+	hw->submitted++;
+
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
+		acc_dma_sq_doorbell(hw);
+
+	return hw->ridx++;
+}
+
+static int
+acc_dma_submit(void *dev_private, uint16_t vchan)
+{
+	struct acc_dma_dev *hw = dev_private;
+
+	RTE_SET_USED(vchan);
+
+	if (unlikely(*hw->sq_status != 0)) {
+		hw->io_errors++;
+		return -EIO;
+	}
+
+	acc_dma_sq_doorbell(hw);
+
+	return 0;
+}
+
+static inline void
+acc_dma_cq_doorbell(struct acc_dma_dev *hw)
+{
+	uint64_t doorbell = (uint64_t)(hw->sqn & ACC_DMA_DOORBELL_SQN_MASK) |
+			    (ACC_DMA_DOORBELL_CQ_CMD << ACC_DMA_DOORBELL_CMD_SHIFT) |
+			    (((uint64_t)hw->cq_head) << ACC_DMA_DOORBELL_IDX_SHIFT);
+	rte_io_wmb();
+	*(volatile uint64_t *)hw->doorbell_reg = doorbell;
+}
+
+static inline void
+acc_dma_scan_cq(struct acc_dma_dev *hw)
+{
+	volatile struct acc_dma_cqe *cqe;
+	struct acc_dma_sqe *sqe;
+	uint16_t csq_head = hw->cq_sq_head;
+	uint16_t cq_head = hw->cq_head;
+	uint16_t count = 0;
+	uint64_t misc;
+
+	if (unlikely(*hw->cq_status != 0)) {
+		hw->io_errors++;
+		return;
+	}
+
+	while (count < hw->cq_depth) {
+		cqe = &hw->cqe[cq_head];
+		misc = cqe->misc;
+		misc = rte_le_to_cpu_64(misc);
+		if (RTE_FIELD_GET64(ACC_DMA_CQE_VALID_B, misc) != hw->cqe_vld)
+			break;
+
+		csq_head = RTE_FIELD_GET64(ACC_DMA_SQ_HEAD_MASK, misc);
+		if (unlikely(csq_head > hw->sq_depth_mask)) {
+			/**
+			 * Defensive programming to prevent overflow of the
+			 * status array indexed by csq_head. Only error logs
+			 * are used for prompting.
+			 */
+			ACC_DMA_ERR(hw, "invalid csq_head: %u!", csq_head);
+			count = 0;
+			break;
+		}
+		sqe = &hw->sqe[csq_head];
+		if (sqe->done_flag != ACC_DMA_TASK_DONE ||
+			sqe->err_type || sqe->ext_err_type || sqe->wtype) {
+			hw->status[csq_head] = RTE_DMA_STATUS_ERROR_UNKNOWN;
+		}
+
+		count++;
+		cq_head++;
+		if (cq_head == hw->cq_depth) {
+			hw->cqe_vld = !hw->cqe_vld;
+			cq_head = 0;
+		}
+	}
+
+	if (count == 0)
+		return;
+
+	hw->cq_head = cq_head;
+	hw->cq_sq_head = (csq_head + 1) & hw->sq_depth_mask;
+	hw->avail_sqes += count;
+	hw->cqs_completed += count;
+	if (hw->cqs_completed >= ACC_DMA_CQ_DOORBELL_PACE) {
+		acc_dma_cq_doorbell(hw);
+		hw->cqs_completed = 0;
+	}
+}
+
+static inline uint16_t
+acc_dma_calc_cpls(struct acc_dma_dev *hw, const uint16_t nb_cpls)
+{
+	uint16_t cpl_num;
+
+	if (hw->cq_sq_head >= hw->sq_head)
+		cpl_num = hw->cq_sq_head - hw->sq_head;
+	else
+		cpl_num = hw->sq_depth_mask + 1 - hw->sq_head + hw->cq_sq_head;
+
+	if (cpl_num > nb_cpls)
+		cpl_num = nb_cpls;
+
+	return cpl_num;
+}
+
+static uint16_t
+acc_dma_completed(void *dev_private,
+		  uint16_t vchan, const uint16_t nb_cpls,
+		  uint16_t *last_idx, bool *has_error)
+{
+	struct acc_dma_dev *hw = dev_private;
+	uint16_t sq_head = hw->sq_head;
+	uint16_t cpl_num, i;
+
+	RTE_SET_USED(vchan);
+	acc_dma_scan_cq(hw);
+
+	cpl_num = acc_dma_calc_cpls(hw, nb_cpls);
+	for (i = 0; i < cpl_num; i++) {
+		if (hw->status[sq_head]) {
+			*has_error = true;
+			break;
+		}
+		sq_head = (sq_head + 1) & hw->sq_depth_mask;
+	}
+	*last_idx = hw->cridx + i - 1;
+	if (i > 0) {
+		hw->cridx += i;
+		hw->sq_head = sq_head;
+		hw->completed += i;
+	}
+
+	return i;
+}
+
+static uint16_t
+acc_dma_completed_status(void *dev_private,
+			 uint16_t vchan, const uint16_t nb_cpls,
+			 uint16_t *last_idx, enum rte_dma_status_code *status)
+{
+	struct acc_dma_dev *hw = dev_private;
+	uint16_t sq_head = hw->sq_head;
+	uint16_t cpl_num, i;
+
+	RTE_SET_USED(vchan);
+	acc_dma_scan_cq(hw);
+
+	cpl_num = acc_dma_calc_cpls(hw, nb_cpls);
+	for (i = 0; i < cpl_num; i++) {
+		status[i] = hw->status[sq_head];
+		hw->errors += !!status[i];
+		hw->status[sq_head] = 0;
+		sq_head = (sq_head + 1) & hw->sq_depth_mask;
+	}
+	*last_idx = hw->cridx + cpl_num - 1;
+	if (likely(cpl_num > 0)) {
+		hw->cridx += cpl_num;
+		hw->sq_head = sq_head;
+		hw->completed += cpl_num;
+	}
+
+	return cpl_num;
+}
+
+static uint16_t
+acc_dma_burst_capacity(const void *dev_private, uint16_t vchan)
+{
+	const struct acc_dma_dev *hw = dev_private;
+	RTE_SET_USED(vchan);
+	return hw->avail_sqes;
+}
+
 static const struct rte_dma_dev_ops acc_dmadev_ops = {
 	.dev_info_get     = acc_dma_info_get,
 	.dev_configure    = acc_dma_configure,
@@ -280,6 +548,12 @@ acc_dma_create(struct rte_uacce_device *uacce_dev, uint16_t queue_id)
 	dev->device = &uacce_dev->device;
 	dev->dev_ops = &acc_dmadev_ops;
 	dev->fp_obj->dev_private = dev->data->dev_private;
+	dev->fp_obj->copy = acc_dma_copy;
+	dev->fp_obj->fill = acc_dma_fill;
+	dev->fp_obj->submit = acc_dma_submit;
+	dev->fp_obj->completed = acc_dma_completed;
+	dev->fp_obj->completed_status = acc_dma_completed_status;
+	dev->fp_obj->burst_capacity = acc_dma_burst_capacity;
 
 	hw = dev->data->dev_private;
 	hw->data = dev->data; /* make sure ACC_DMA_DEBUG/INFO/WARN/ERR was available. */
diff --git a/drivers/dma/acc/acc_dmadev.h b/drivers/dma/acc/acc_dmadev.h
index fca0ff79dd..dd8c7e0cfd 100644
--- a/drivers/dma/acc/acc_dmadev.h
+++ b/drivers/dma/acc/acc_dmadev.h
@@ -25,9 +25,80 @@ struct acc_dma_config {
 };
 
 #define ACC_DMA_DOORBELL_OFFSET		0x1000u
+#define ACC_DMA_DOORBELL_SQN_MASK	0x3FFu
+#define ACC_DMA_DOORBELL_SQ_CMD		0ull
+#define ACC_DMA_DOORBELL_CQ_CMD		1ull
+#define ACC_DMA_DOORBELL_CMD_SHIFT	12
+#define ACC_DMA_DOORBELL_IDX_SHIFT	32
+
+#define ACC_DMA_TASK_TYPE		0x3
+#define ACC_DMA_SQE_TYPE		0x1
+#define ACC_DMA_SVA_PREFETCH_EN		RTE_BIT32(15)
+#define ACC_DMA_MAX_OP_SIZE		(RTE_BIT32(24) - 1)
+
+enum {
+	ACC_DMA_DATA_MEMCPY = 0,
+	ACC_DMA_DATA_MEMSET = 7,
+};
+
+enum {
+	ACC_DMA_TASK_DONE = 1,
+	ACC_DMA_TASK_ERROR,
+};
 
-struct acc_dma_sqe {};
-struct acc_dma_cqe {};
+struct acc_dma_sqe {
+	uint32_t bd_type : 6;
+	uint32_t resv1 : 2;
+	uint32_t task_type : 6;
+	uint32_t resv2 : 2;
+	uint32_t task_type_ext : 6;
+	uint32_t resv3 : 9;
+	uint32_t bd_invlid : 1;
+	uint32_t rsv4[2];
+	uint32_t low_tag;
+	uint32_t hi_tag;
+	/* The number of bytes to be copied or filled for single address. */
+	uint32_t data_size;
+	uint32_t rsv5;
+	/*
+	 * 0 ~ 13 bits: reserved,
+	 * 14 bit: single address or multi addresses,
+	 * 15 bit: sva prefetch en.
+	 */
+	uint16_t dw0;
+	/*
+	 * 0 ~5 bits: reserved,
+	 * 6 ~ 13 bits: address num,
+	 * 14 ~15 bits: reserved.
+	 */
+	uint16_t dw1;
+	uint64_t init_val;
+	uint32_t rsv6[12];
+	/* dst addr for single address task. */
+	uint64_t dst_addr;
+	uint32_t rsv7[2];
+	/* src addr for single address task, addr array for multi addresses. */
+	uint64_t addr_array;
+	union {
+		uint32_t wb_field;
+		struct {
+			uint32_t done_flag : 3;
+			uint32_t rsv8 : 1;
+			uint32_t ext_err_type : 12;
+			uint32_t err_type : 8;
+			uint32_t wtype : 8;
+		};
+	};
+	uint32_t rsv9[3];
+};
+
+#define ACC_DMA_SQ_HEAD_MASK		RTE_GENMASK64(15, 0)
+#define ACC_DMA_CQE_VALID_B		RTE_BIT64(48)
+
+struct acc_dma_cqe {
+	uint64_t rsv;
+	uint64_t misc;
+};
 
 struct acc_dma_dev {
 	struct acc_dma_sqe *sqe;
-- 
2.17.1

