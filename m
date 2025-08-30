Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1007CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCF39406BA;
	Sat, 30 Aug 2025 14:41:03 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 1F69640689
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=r73AQs/Cs2buxyz6e/GL488TaU3RQNSZi/qT9U4ouE4=;
 b=GtH9XrQsAbqfRct4oqZS9rVDW7WECo1XObFNdZVKfXuRFbGsNWstefm5+iW+Fx
 LXtxazfrYgQeG/WStnK1u6Wi0NGSiYsKcaIt+lDogrqNTj8cZCXg26uTneIBApLL
 8ZoHitYAqErrz8HCzNzC3BoTlCUmVi9FwUfRAIt3+6NkE=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S14;
 Sat, 30 Aug 2025 20:40:58 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V5 10/18] net/hinic3: add context and work queue support
Date: Sat, 30 Aug 2025 20:39:22 +0800
Message-ID: <20250830123942.5037-11-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S14
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw1DuF4DuF17KF1kGw48Zwb_yoW3JF1xpF
 WqgF98Jw4kWF429wn3Jw4xZwnxCw18Ja47t34rX3Z0yrZ8XF90van5trZ0yr95X3srWF4a
 vFs8trn7trnYvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUdb8UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAgS5Cmiydh7CPQAAs4
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

From: Xin Wang <wangxin679@h-partners.com>=0D

Work queue is used for cmdq and tx/rx buff description.=0D
Nic business needs to configure cmdq context and txq/rxq=0D
context. This patch adds data structures and function codes=0D
for work queue and context.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_wq.c | 148 ++++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_wq.h | 109 ++++++++++++++++++++=0D
 2 files changed, 257 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_wq.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_wq.c b/drivers/net/hinic3/base/=
hinic3_wq.c=0D
new file mode 100644=0D
index 0000000000..9bccb10c9a=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_wq.c=0D
@@ -0,0 +1,148 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+#include <rte_bus_pci.h>=0D
+#include <rte_errno.h>=0D
+#include <rte_ether.h>=0D
+#include <rte_malloc.h>=0D
+#include <rte_mbuf.h>=0D
+#include <rte_mempool.h>=0D
+#include <rte_pci.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+static void=0D
+free_wq_pages(struct hinic3_wq *wq)=0D
+{=0D
+	hinic3_memzone_free(wq->wq_mz);=0D
+=0D
+	wq->queue_buf_paddr =3D 0;=0D
+	wq->queue_buf_vaddr =3D 0;=0D
+}=0D
+=0D
+static int=0D
+alloc_wq_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, int qid)=
=0D
+{=0D
+	const struct rte_memzone *wq_mz;=0D
+=0D
+	wq_mz =3D hinic3_dma_zone_reserve(hwdev->eth_dev, "hinic3_wq_mz",=0D
+					(uint16_t)qid, wq->wq_buf_size,=0D
+					RTE_PGSIZE_256K, SOCKET_ID_ANY);=0D
+	if (!wq_mz) {=0D
+		PMD_DRV_LOG(ERR, "Allocate wq[%d] rq_mz failed", qid);=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	memset(wq_mz->addr, 0, wq->wq_buf_size);=0D
+	wq->wq_mz =3D wq_mz;=0D
+	wq->queue_buf_paddr =3D wq_mz->iova;=0D
+	wq->queue_buf_vaddr =3D (u64)(u64 *)wq_mz->addr;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+void=0D
+hinic3_put_wqe(struct hinic3_wq *wq, int num_wqebbs)=0D
+{=0D
+	wq->cons_idx +=3D num_wqebbs;=0D
+	rte_atomic_fetch_add_explicit(&wq->delta, num_wqebbs,=0D
+				      rte_memory_order_seq_cst);=0D
+}=0D
+=0D
+void *=0D
+hinic3_read_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *cons_idx)=0D
+{=0D
+	u16 curr_cons_idx;=0D
+=0D
+	if ((rte_atomic_load_explicit(&wq->delta, rte_memory_order_seq_cst) +=0D
+	     num_wqebbs) > wq->q_depth)=0D
+		return NULL;=0D
+=0D
+	curr_cons_idx =3D (u16)(wq->cons_idx);=0D
+=0D
+	curr_cons_idx =3D MASKED_WQE_IDX(wq, curr_cons_idx);=0D
+=0D
+	*cons_idx =3D curr_cons_idx;=0D
+=0D
+	return WQ_WQE_ADDR(wq, (u32)(*cons_idx));=0D
+}=0D
+=0D
+int=0D
+hinic3_cmdq_alloc(struct hinic3_wq *wq, void *dev, int cmdq_blocks,=0D
+		  u32 wq_buf_size, u32 wqebb_shift, u16 q_depth)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+	int i, j;=0D
+	int err;=0D
+=0D
+	/* Validate q_depth is power of 2 & wqebb_size is not 0. */=0D
+	for (i =3D 0; i < cmdq_blocks; i++) {=0D
+		wq[i].wqebb_size =3D 1U << wqebb_shift;=0D
+		wq[i].wqebb_shift =3D wqebb_shift;=0D
+		wq[i].wq_buf_size =3D wq_buf_size;=0D
+		wq[i].q_depth =3D q_depth;=0D
+=0D
+		err =3D alloc_wq_pages(hwdev, &wq[i], i);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Failed to alloc CMDQ blocks");=0D
+			goto cmdq_block_err;=0D
+		}=0D
+=0D
+		wq[i].cons_idx =3D 0;=0D
+		wq[i].prod_idx =3D 0;=0D
+		rte_atomic_store_explicit(&wq[i].delta, q_depth,=0D
+					  rte_memory_order_seq_cst);=0D
+=0D
+		wq[i].mask =3D q_depth - 1;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+cmdq_block_err:=0D
+	for (j =3D 0; j < i; j++)=0D
+		free_wq_pages(&wq[j]);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+void=0D
+hinic3_cmdq_free(struct hinic3_wq *wq, int cmdq_blocks)=0D
+{=0D
+	int i;=0D
+=0D
+	for (i =3D 0; i < cmdq_blocks; i++)=0D
+		free_wq_pages(&wq[i]);=0D
+}=0D
+=0D
+void=0D
+hinic3_wq_wqe_pg_clear(struct hinic3_wq *wq)=0D
+{=0D
+	wq->cons_idx =3D 0;=0D
+	wq->prod_idx =3D 0;=0D
+=0D
+	memset((void *)wq->queue_buf_vaddr, 0, wq->wq_buf_size);=0D
+}=0D
+=0D
+void *=0D
+hinic3_get_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *prod_idx)=0D
+{=0D
+	u16 curr_prod_idx;=0D
+=0D
+	rte_atomic_fetch_sub_explicit(&wq->delta, num_wqebbs,=0D
+				      rte_memory_order_seq_cst);=0D
+	curr_prod_idx =3D (u16)(wq->prod_idx);=0D
+	wq->prod_idx +=3D num_wqebbs;=0D
+	*prod_idx =3D MASKED_WQE_IDX(wq, curr_prod_idx);=0D
+=0D
+	return WQ_WQE_ADDR(wq, (u32)(*prod_idx));=0D
+}=0D
+=0D
+void=0D
+hinic3_set_sge(struct hinic3_sge *sge, uint64_t addr, u32 len)=0D
+{=0D
+	sge->hi_addr =3D upper_32_bits(addr);=0D
+	sge->lo_addr =3D lower_32_bits(addr);=0D
+	sge->len =3D len;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_wq.h b/drivers/net/hinic3/base/=
hinic3_wq.h=0D
new file mode 100644=0D
index 0000000000..84d54c2aeb=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_wq.h=0D
@@ -0,0 +1,109 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_WQ_H_=0D
+#define _HINIC3_WQ_H_=0D
+=0D
+/* Use 0-level CLA, page size must be: SQ 16B(wqe) * 64k(max_q_depth). */=
=0D
+#define HINIC3_DEFAULT_WQ_PAGE_SIZE 0x100000=0D
+#define HINIC3_HW_WQ_PAGE_SIZE	    0x1000=0D
+=0D
+#define MASKED_WQE_IDX(wq, idx) ((idx) & (wq)->mask)=0D
+=0D
+#define WQ_WQE_ADDR(wq, idx)                                              =
             \=0D
+	({                                                                       =
      \=0D
+		typeof(wq) __wq =3D (wq);                                               =
 \=0D
+		(void *)((u64)(__wq->queue_buf_vaddr) + ((idx) << __wq->wqebb_shift)); \=
=0D
+	})=0D
+=0D
+struct hinic3_sge {=0D
+	u32 hi_addr;=0D
+	u32 lo_addr;=0D
+	u32 len;=0D
+};=0D
+=0D
+struct hinic3_wq {=0D
+	/* The addresses are 64 bit in the HW. */=0D
+	u64 queue_buf_vaddr;=0D
+=0D
+	u16 q_depth;=0D
+	u16 mask;=0D
+	RTE_ATOMIC(int32_t)delta;=0D
+=0D
+	u32 cons_idx;=0D
+	u32 prod_idx;=0D
+=0D
+	u64 queue_buf_paddr;=0D
+=0D
+	u32 wqebb_size;=0D
+	u32 wqebb_shift;=0D
+=0D
+	u32 wq_buf_size;=0D
+=0D
+	const struct rte_memzone *wq_mz;=0D
+=0D
+	u32 rsvd[5];=0D
+};=0D
+=0D
+void hinic3_put_wqe(struct hinic3_wq *wq, int num_wqebbs);=0D
+=0D
+/**=0D
+ * Read a WQE and update CI.=0D
+ *=0D
+ * @param[in] wq=0D
+ * The work queue structure.=0D
+ * @param[in] num_wqebbs=0D
+ * The number of work queue elements to read.=0D
+ * @param[out] cons_idx=0D
+ * The updated consumer index.=0D
+ *=0D
+ * @return=0D
+ * The address of WQE, or NULL if not enough elements are available.=0D
+ */=0D
+void *hinic3_read_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *cons_idx)=
;=0D
+=0D
+/**=0D
+ * Allocate command queue blocks and initialize related parameters.=0D
+ *=0D
+ * @param[in] wq=0D
+ * The cmdq->wq structure.=0D
+ * @param[in] dev=0D
+ * The device context for the hardware.=0D
+ * @param[in] cmdq_blocks=0D
+ * The number of command queue blocks to allocate.=0D
+ * @param[in] wq_buf_size=0D
+ * The size of each work queue buffer.=0D
+ * @param[in] wqebb_shift=0D
+ * The shift value for determining the work queue element size.=0D
+ * @param[in] q_depth=0D
+ * The depth of each command queue.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_cmdq_alloc(struct hinic3_wq *wq, void *dev, int cmdq_blocks,=0D
+		      u32 wq_buf_size, u32 wqebb_shift, u16 q_depth);=0D
+=0D
+void hinic3_cmdq_free(struct hinic3_wq *wq, int cmdq_blocks);=0D
+=0D
+void hinic3_wq_wqe_pg_clear(struct hinic3_wq *wq);=0D
+=0D
+/**=0D
+ * Get WQE and update PI.=0D
+ *=0D
+ * @param[in] wq=0D
+ * The cmdq->wq structure.=0D
+ * @param[in] num_wqebbs=0D
+ * The number of work queue elements to allocate.=0D
+ * @param[out] prod_idx=0D
+ * The updated producer index, masked according to the queue size.=0D
+ *=0D
+ * @return=0D
+ * The address of the work queue element.=0D
+ */=0D
+void *hinic3_get_wqe(struct hinic3_wq *wq, int num_wqebbs, u16 *prod_idx);=
=0D
+=0D
+void hinic3_set_sge(struct hinic3_sge *sge, uint64_t addr, u32 len);=0D
+=0D
+#endif /* _HINIC3_WQ_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

