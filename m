Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E605C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC71D40ED1;
	Mon,  5 May 2025 14:51:32 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id F314F400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 10:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:Subject:Date:Message-ID:
 MIME-Version; bh=NgoalfHnnC5vGNvbsAqXqQuQkKw9uKAwr6YMXmVSF2k=;
 b=Sblbf9CG4buzxeb2LeEn+98oLm8vvZP/ng+G/Ab0Sbz5LZem4NiP4bU1sgu8Oq
 5STmLUjZ+CWH8EIg2O/fPwcDxlCeIDyjcj4xut69NpSzXHpodrGvFgYWGNraRalc
 c2FtA+WvzXm6+asvsdpcp7K5QGUpSo3QbSNH+LJ+ul7KE=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAXqpe1CAJoAsjFAg--.56413S14;
 Fri, 18 Apr 2025 16:09:42 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [RFC 10/18] net/hinic3: add context and work queue support
Date: Fri, 18 Apr 2025 16:08:42 +0800
Message-ID: <20250418080908.9447-11-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418080908.9447-1-wff_light@vip.163.com>
References: <20250418080908.9447-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXqpe1CAJoAsjFAg--.56413S14
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw1DuF4DuF17KF1kGw48Zwb_yoW3JF1xpF
 WqgF98Jw4kWF429wn3Aw4xZwnxCw18Ja47t34rX3Z0yrZ8XF90van5trZ0yr95X3srWF4a
 vFs8trn7trnYvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6RRiUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHxQzCmgB7BqECgAAsj
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:05 +0200
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

From: Xin Wang <wangxin679@h-partners.com>

Work queue is used for cmdq and tx/rx buff description.
Nic business needs to configure cmdq context and txq/rxq
context. This patch adds data structures and function codes
for work queue and context.

Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
Reviewed-by: Yi Chen <chenyi221@huawei.com>
---
 drivers/net/hinic3/base/hinic3_wq.c | 148 ++++++++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_wq.h | 109 ++++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.h

diff --git a/drivers/net/hinic3/base/hinic3_wq.c b/drivers/net/hinic3/base/hinic3_wq.c
new file mode 100644
index 0000000000..9bccb10c9a
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_wq.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+#include <rte_bus_pci.h>
+#include <rte_errno.h>
+#include <rte_ether.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_pci.h>
+
+#include "hinic3_compat.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_wq.h"
+
+static void
+free_wq_pages(struct hinic3_wq *wq)
+{
+	hinic3_memzone_free(wq->wq_mz);
+
+	wq->queue_buf_paddr = 0;
+	wq->queue_buf_vaddr = 0;
+}
+
+static int
+alloc_wq_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, int qid)
+{
+	const struct rte_memzone *wq_mz;
+
+	wq_mz = hinic3_dma_zone_reserve(hwdev->eth_dev, "hinic3_wq_mz",
+					(uint16_t)qid, wq->wq_buf_size,
+					RTE_PGSIZE_256K, SOCKET_ID_ANY);
+	if (!wq_mz) {
+		PMD_DRV_LOG(ERR, "Allocate wq[%d] rq_mz failed", qid);
+		return -ENOMEM;
+	}
+
+	memset(wq_mz->addr, 0, wq->wq_buf_size);
+	wq->wq_mz = wq_mz;
+	wq->queue_buf_paddr = wq_mz->iova;
+	wq->queue_buf_vaddr = (u64)(u64 *)wq_mz->addr;
+
+	return 0;
+}
+
+void
+hinic3_put_wqe(struct hinic3_wq *wq, int num_wqebbs)
+{
+	wq->cons_idx += num_wqebbs;
+	rte_atomic_fetch_add_explicit(&wq->delta, num_wqebbs,
+				      rte_memory_order_seq_cst);
+}
+
+void *
+hinic3_read_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *cons_idx)
+{
+	u16 curr_cons_idx;
+
+	if ((rte_atomic_load_explicit(&wq->delta, rte_memory_order_seq_cst) +
+	     num_wqebbs) > wq->q_depth)
+		return NULL;
+
+	curr_cons_idx = (u16)(wq->cons_idx);
+
+	curr_cons_idx = MASKED_WQE_IDX(wq, curr_cons_idx);
+
+	*cons_idx = curr_cons_idx;
+
+	return WQ_WQE_ADDR(wq, (u32)(*cons_idx));
+}
+
+int
+hinic3_cmdq_alloc(struct hinic3_wq *wq, void *dev, int cmdq_blocks,
+		  u32 wq_buf_size, u32 wqebb_shift, u16 q_depth)
+{
+	struct hinic3_hwdev *hwdev = (struct hinic3_hwdev *)dev;
+	int i, j;
+	int err;
+
+	/* Validate q_depth is power of 2 & wqebb_size is not 0. */
+	for (i = 0; i < cmdq_blocks; i++) {
+		wq[i].wqebb_size = 1U << wqebb_shift;
+		wq[i].wqebb_shift = wqebb_shift;
+		wq[i].wq_buf_size = wq_buf_size;
+		wq[i].q_depth = q_depth;
+
+		err = alloc_wq_pages(hwdev, &wq[i], i);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to alloc CMDQ blocks");
+			goto cmdq_block_err;
+		}
+
+		wq[i].cons_idx = 0;
+		wq[i].prod_idx = 0;
+		rte_atomic_store_explicit(&wq[i].delta, q_depth,
+					  rte_memory_order_seq_cst);
+
+		wq[i].mask = q_depth - 1;
+	}
+
+	return 0;
+
+cmdq_block_err:
+	for (j = 0; j < i; j++)
+		free_wq_pages(&wq[j]);
+
+	return err;
+}
+
+void
+hinic3_cmdq_free(struct hinic3_wq *wq, int cmdq_blocks)
+{
+	int i;
+
+	for (i = 0; i < cmdq_blocks; i++)
+		free_wq_pages(&wq[i]);
+}
+
+void
+hinic3_wq_wqe_pg_clear(struct hinic3_wq *wq)
+{
+	wq->cons_idx = 0;
+	wq->prod_idx = 0;
+
+	memset((void *)wq->queue_buf_vaddr, 0, wq->wq_buf_size);
+}
+
+void *
+hinic3_get_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *prod_idx)
+{
+	u16 curr_prod_idx;
+
+	rte_atomic_fetch_sub_explicit(&wq->delta, num_wqebbs,
+				      rte_memory_order_seq_cst);
+	curr_prod_idx = (u16)(wq->prod_idx);
+	wq->prod_idx += num_wqebbs;
+	*prod_idx = MASKED_WQE_IDX(wq, curr_prod_idx);
+
+	return WQ_WQE_ADDR(wq, (u32)(*prod_idx));
+}
+
+void
+hinic3_set_sge(struct hinic3_sge *sge, uint64_t addr, u32 len)
+{
+	sge->hi_addr = upper_32_bits(addr);
+	sge->lo_addr = lower_32_bits(addr);
+	sge->len = len;
+}
diff --git a/drivers/net/hinic3/base/hinic3_wq.h b/drivers/net/hinic3/base/hinic3_wq.h
new file mode 100644
index 0000000000..84d54c2aeb
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_wq.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_WQ_H_
+#define _HINIC3_WQ_H_
+
+/* Use 0-level CLA, page size must be: SQ 16B(wqe) * 64k(max_q_depth). */
+#define HINIC3_DEFAULT_WQ_PAGE_SIZE 0x100000
+#define HINIC3_HW_WQ_PAGE_SIZE	    0x1000
+
+#define MASKED_WQE_IDX(wq, idx) ((idx) & (wq)->mask)
+
+#define WQ_WQE_ADDR(wq, idx)                                                           \
+	({                                                                             \
+		typeof(wq) __wq = (wq);                                                \
+		(void *)((u64)(__wq->queue_buf_vaddr) + ((idx) << __wq->wqebb_shift)); \
+	})
+
+struct hinic3_sge {
+	u32 hi_addr;
+	u32 lo_addr;
+	u32 len;
+};
+
+struct hinic3_wq {
+	/* The addresses are 64 bit in the HW. */
+	u64 queue_buf_vaddr;
+
+	u16 q_depth;
+	u16 mask;
+	RTE_ATOMIC(int32_t)delta;
+
+	u32 cons_idx;
+	u32 prod_idx;
+
+	u64 queue_buf_paddr;
+
+	u32 wqebb_size;
+	u32 wqebb_shift;
+
+	u32 wq_buf_size;
+
+	const struct rte_memzone *wq_mz;
+
+	u32 rsvd[5];
+};
+
+void hinic3_put_wqe(struct hinic3_wq *wq, int num_wqebbs);
+
+/**
+ * Read a WQE and update CI.
+ *
+ * @param[in] wq
+ * The work queue structure.
+ * @param[in] num_wqebbs
+ * The number of work queue elements to read.
+ * @param[out] cons_idx
+ * The updated consumer index.
+ *
+ * @return
+ * The address of WQE, or NULL if not enough elements are available.
+ */
+void *hinic3_read_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *cons_idx);
+
+/**
+ * Allocate command queue blocks and initialize related parameters.
+ *
+ * @param[in] wq
+ * The cmdq->wq structure.
+ * @param[in] dev
+ * The device context for the hardware.
+ * @param[in] cmdq_blocks
+ * The number of command queue blocks to allocate.
+ * @param[in] wq_buf_size
+ * The size of each work queue buffer.
+ * @param[in] wqebb_shift
+ * The shift value for determining the work queue element size.
+ * @param[in] q_depth
+ * The depth of each command queue.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_cmdq_alloc(struct hinic3_wq *wq, void *dev, int cmdq_blocks,
+		      u32 wq_buf_size, u32 wqebb_shift, u16 q_depth);
+
+void hinic3_cmdq_free(struct hinic3_wq *wq, int cmdq_blocks);
+
+void hinic3_wq_wqe_pg_clear(struct hinic3_wq *wq);
+
+/**
+ * Get WQE and update PI.
+ *
+ * @param[in] wq
+ * The cmdq->wq structure.
+ * @param[in] num_wqebbs
+ * The number of work queue elements to allocate.
+ * @param[out] prod_idx
+ * The updated producer index, masked according to the queue size.
+ *
+ * @return
+ * The address of the work queue element.
+ */
+void *hinic3_get_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *prod_idx);
+
+void hinic3_set_sge(struct hinic3_sge *sge, uint64_t addr, u32 len);
+
+#endif /* _HINIC3_WQ_H_ */
-- 
2.47.0.windows.2

