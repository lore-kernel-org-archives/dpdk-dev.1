Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109ECA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2D040BA4;
	Sat, 30 Aug 2025 14:41:11 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 3B9C740A7D
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=XBpkims5mrkLkAe3Pfqjq9wrjjP3dz/MKINfAnHSlpM=;
 b=YUDyUU1Rc5DjLgITZxTXBqtVQWB46MbumBEosoytT7uYFh29grZwkCZsePZsWk
 2hUeu17M4HXudUPxBa7NL3NuiP213USUri6XWntJH+ccAZxRwT9JlNBXQY7/sKyG
 DIT5Fem4WDCnliqBAcBGzzm29aKhOLzrabQAu6BtraYlk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S19;
 Sat, 30 Aug 2025 20:41:04 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V5 15/18] net/hinic3: add MML and EEPROM access feature
Date: Sat, 30 Aug 2025 20:39:27 +0800
Message-ID: <20250830123942.5037-16-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S19
X-Coremail-Antispam: 1Uf129KBjvAXoWkXFWUJF45uryUWr18WFyUZFb_yoW3CF4DZo
 WfW3ZxGr1kJryrGw4kKF10kF1a9FWDAa9xuwsYvrZ3WFn7JFyaqFySvw15W3W2vr48tasr
 ZFWFqFyfJws7Jw1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUo73vUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAgu5Cmiydh7CRQAAsP
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

Add man-machine language support and implements the get eeprom method.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c        |  13 +=0D
 drivers/net/hinic3/mml/hinic3_dbg.c       | 171 +++++=0D
 drivers/net/hinic3/mml/hinic3_dbg.h       | 160 +++++=0D
 drivers/net/hinic3/mml/hinic3_mml_cmd.c   | 375 +++++++++++=0D
 drivers/net/hinic3/mml/hinic3_mml_cmd.h   | 131 ++++=0D
 drivers/net/hinic3/mml/hinic3_mml_ioctl.c | 215 +++++++=0D
 drivers/net/hinic3/mml/hinic3_mml_lib.c   | 136 ++++=0D
 drivers/net/hinic3/mml/hinic3_mml_lib.h   | 276 ++++++++=0D
 drivers/net/hinic3/mml/hinic3_mml_main.c  | 167 +++++=0D
 drivers/net/hinic3/mml/hinic3_mml_queue.c | 745 ++++++++++++++++++++++=0D
 drivers/net/hinic3/mml/hinic3_mml_queue.h | 256 ++++++++=0D
 drivers/net/hinic3/mml/meson.build        |  62 ++=0D
 12 files changed, 2707 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_dbg.h=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_cmd.h=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_ioctl.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_lib.h=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_main.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.c=0D
 create mode 100644 drivers/net/hinic3/mml/hinic3_mml_queue.h=0D
 create mode 100644 drivers/net/hinic3/mml/meson.build=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 47b47b7412..ac36c49afc 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -21,6 +21,7 @@=0D
 #include "base/hinic3_hw_comm.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "base/hinic3_nic_event.h"=0D
+#include "mml/hinic3_mml_lib.h"=0D
 #include "hinic3_nic_io.h"=0D
 #include "hinic3_tx.h"=0D
 #include "hinic3_rx.h"=0D
@@ -2276,6 +2277,16 @@ hinic3_dev_allmulticast_disable(struct rte_eth_dev *=
dev)=0D
 	return 0;=0D
 }=0D
 =0D
+static int=0D
+hinic3_get_eeprom(__rte_unused struct rte_eth_dev *dev,=0D
+		  struct rte_dev_eeprom_info *info)=0D
+{=0D
+#define MAX_BUF_OUT_LEN 2048=0D
+=0D
+	return hinic3_pmd_mml_lib(info->data, info->offset, info->data,=0D
+				  &info->length, MAX_BUF_OUT_LEN);=0D
+}=0D
+=0D
 /**=0D
  * Get device generic statistics.=0D
  *=0D
@@ -2879,6 +2890,7 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
 	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
 	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.get_eeprom                    =3D hinic3_get_eeprom,=0D
 	.stats_get                     =3D hinic3_dev_stats_get,=0D
 	.stats_reset                   =3D hinic3_dev_stats_reset,=0D
 	.xstats_get                    =3D hinic3_dev_xstats_get,=0D
@@ -2919,6 +2931,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =3D=
 {=0D
 	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
 	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
 	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.get_eeprom                    =3D hinic3_get_eeprom,=0D
 	.stats_get                     =3D hinic3_dev_stats_get,=0D
 	.stats_reset                   =3D hinic3_dev_stats_reset,=0D
 	.xstats_get                    =3D hinic3_dev_xstats_get,=0D
diff --git a/drivers/net/hinic3/mml/hinic3_dbg.c b/drivers/net/hinic3/mml/h=
inic3_dbg.c=0D
new file mode 100644=0D
index 0000000000..30051c8e6b=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_dbg.c=0D
@@ -0,0 +1,171 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_wq.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_rx.h"=0D
+#include "hinic3_tx.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_dbg.h"=0D
+=0D
+#define DB_IDX(db, db_base) \=0D
+	((u32)(((ulong)(db) - (ulong)(db_base)) / HINIC3_DB_PAGE_SIZE))=0D
+=0D
+int=0D
+hinic3_dbg_get_rq_info(void *hwdev, uint16_t q_id,=0D
+		       struct hinic3_dbg_rq_info *rq_info, u16 *msg_size)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D (struct hinic3_hwdev *)hwdev;=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		(struct hinic3_nic_dev *)dev->dev_handle;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+=0D
+	if (q_id >=3D nic_dev->num_rqs) {=0D
+		PMD_DRV_LOG(ERR, "Invalid rx queue id, q_id: %d, num_rqs: %d",=0D
+			    q_id, nic_dev->num_rqs);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	rq_info->q_id =3D q_id;=0D
+	rxq =3D nic_dev->rxqs[q_id];=0D
+=0D
+	rq_info->hw_pi =3D (u16)cpu_to_be16(*rxq->pi_virt_addr);=0D
+	rq_info->ci =3D rxq->cons_idx & rxq->q_mask;=0D
+	rq_info->sw_pi =3D rxq->prod_idx & rxq->q_mask;=0D
+	rq_info->wqebb_size =3D HINIC3_SQ_WQEBB_SIZE;=0D
+	rq_info->q_depth =3D rxq->q_depth;=0D
+	rq_info->buf_len =3D rxq->buf_len;=0D
+	rq_info->ci_wqe_page_addr =3D rxq->queue_buf_vaddr;=0D
+	rq_info->ci_cla_tbl_addr =3D NULL;=0D
+	rq_info->msix_idx =3D 0;=0D
+	rq_info->msix_vector =3D 0;=0D
+=0D
+	*msg_size =3D sizeof(*rq_info);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_dbg_get_rx_cqe_info(void *hwdev, uint16_t q_id, uint16_t idx,=0D
+			   void *buf_out, uint16_t *out_size)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D (struct hinic3_hwdev *)hwdev;=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		(struct hinic3_nic_dev *)dev->dev_handle;=0D
+=0D
+	if (q_id >=3D nic_dev->num_rqs || idx >=3D nic_dev->rxqs[q_id]->q_depth)=
=0D
+		return -EFAULT;=0D
+=0D
+	memcpy(buf_out, (void *)&nic_dev->rxqs[q_id]->rx_cqe[idx],=0D
+		     sizeof(struct hinic3_rq_cqe));=0D
+	*out_size =3D sizeof(struct hinic3_rq_cqe);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_dbg_get_sq_info(void *dev, u16 q_id, struct hinic3_dbg_sq_info *sq_=
info,=0D
+		       u16 *msg_size)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		(struct hinic3_nic_dev *)hwdev->dev_handle;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+=0D
+	if (q_id >=3D nic_dev->num_sqs) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Inputting tx queue id is larger than actual tx "=0D
+			    "queue number, qid: %d, num_sqs: %d",=0D
+			    q_id, nic_dev->num_sqs);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	sq_info->q_id =3D q_id;=0D
+	txq =3D nic_dev->txqs[q_id];=0D
+=0D
+	sq_info->pi =3D txq->prod_idx & txq->q_mask;=0D
+	sq_info->ci =3D txq->cons_idx & txq->q_mask;=0D
+	sq_info->fi =3D (*(volatile u16 *)txq->ci_vaddr_base) & txq->q_mask;=0D
+	sq_info->q_depth =3D txq->q_depth;=0D
+	sq_info->weqbb_size =3D HINIC3_SQ_WQEBB_SIZE;=0D
+	sq_info->ci_addr =3D=0D
+		(volatile u16 *)HINIC3_CI_VADDR(txq->ci_vaddr_base, q_id);=0D
+	sq_info->cla_addr =3D txq->queue_buf_paddr;=0D
+	sq_info->db_addr.phy_addr =3D (u64 *)txq->db_addr;=0D
+	sq_info->pg_idx =3D DB_IDX(txq->db_addr, hwdev->hwif->db_base);=0D
+=0D
+	*msg_size =3D sizeof(*sq_info);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_dbg_get_sq_wqe_info(void *dev, u16 q_id, u16 idx, u16 wqebb_cnt, u8=
 *wqe,=0D
+			   u16 *wqe_size)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		(struct hinic3_nic_dev *)hwdev->dev_handle;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	void *src_wqe =3D NULL;=0D
+	u32 offset;=0D
+=0D
+	if (q_id >=3D nic_dev->num_sqs) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Inputting tx queue id is larger than actual tx "=0D
+			    "queue number, qid: %d, num_sqs: %d",=0D
+			    q_id, nic_dev->num_sqs);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	txq =3D nic_dev->txqs[q_id];=0D
+	if (idx + wqebb_cnt > txq->q_depth)=0D
+		return -EFAULT;=0D
+=0D
+	src_wqe =3D (void *)txq->queue_buf_vaddr;=0D
+	offset =3D (u32)idx << txq->wqebb_shift;=0D
+=0D
+	memcpy((void *)wqe, (void *)((u8 *)src_wqe + offset),=0D
+		     (size_t)((u32)wqebb_cnt << txq->wqebb_shift));=0D
+=0D
+	*wqe_size =3D (u16)((u32)wqebb_cnt << txq->wqebb_shift);=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_dbg_get_rq_wqe_info(void *dev, u16 q_id, u16 idx, u16 wqebb_cnt, u8=
 *wqe,=0D
+			   u16 *wqe_size)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		(struct hinic3_nic_dev *)hwdev->dev_handle;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	void *src_wqe =3D NULL;=0D
+	u32 offset;=0D
+=0D
+	if (q_id >=3D nic_dev->num_rqs) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Inputting rx queue id is larger than actual rx "=0D
+			    "queue number, qid: %d, num_rqs: %d",=0D
+			    q_id, nic_dev->num_rqs);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	rxq =3D nic_dev->rxqs[q_id];=0D
+	if (idx + wqebb_cnt > rxq->q_depth)=0D
+		return -EFAULT;=0D
+=0D
+	src_wqe =3D (void *)rxq->queue_buf_vaddr;=0D
+	offset =3D (u32)idx << rxq->wqebb_shift;=0D
+=0D
+	memcpy((void *)wqe, (void *)((u8 *)src_wqe + offset),=0D
+		     (size_t)((u32)wqebb_cnt << rxq->wqebb_shift));=0D
+=0D
+	*wqe_size =3D (u16)((u32)wqebb_cnt << rxq->wqebb_shift);=0D
+	return 0;=0D
+}=0D
diff --git a/drivers/net/hinic3/mml/hinic3_dbg.h b/drivers/net/hinic3/mml/h=
inic3_dbg.h=0D
new file mode 100644=0D
index 0000000000..bac96c84a0=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_dbg.h=0D
@@ -0,0 +1,160 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#ifndef _HINIC3_MML_DBG_H=0D
+#define _HINIC3_MML_DBG_H=0D
+=0D
+/* nic_tool */=0D
+struct hinic3_tx_hw_page {=0D
+	u64 *phy_addr;=0D
+	u64 *map_addr;=0D
+};=0D
+=0D
+/* nic_tool */=0D
+struct hinic3_dbg_sq_info {=0D
+	u16 q_id;=0D
+	u16 pi;=0D
+	u16 ci; /**< sw_ci */=0D
+	u16 fi; /**< hw_ci */=0D
+=0D
+	u32 q_depth;=0D
+	u16 weqbb_size;=0D
+=0D
+	volatile u16 *ci_addr;=0D
+	u64 cla_addr;=0D
+=0D
+	struct hinic3_tx_hw_page db_addr;=0D
+	u32 pg_idx;=0D
+};=0D
+=0D
+/* nic_tool */=0D
+struct hinic3_dbg_rq_info {=0D
+	u16 q_id;=0D
+	u16 hw_pi;=0D
+	u16 ci; /**< sw_ci */=0D
+	u16 sw_pi;=0D
+	u16 wqebb_size;=0D
+	u16 q_depth;=0D
+	u16 buf_len;=0D
+=0D
+	void *ci_wqe_page_addr;=0D
+	void *ci_cla_tbl_addr;=0D
+	u16 msix_idx;=0D
+	u32 msix_vector;=0D
+};=0D
+=0D
+void *hinic3_dbg_get_sq_wq_handle(void *hwdev, u16 q_id);=0D
+=0D
+void *hinic3_dbg_get_rq_wq_handle(void *hwdev, u16 q_id);=0D
+=0D
+void *hinic3_dbg_get_sq_ci_addr(void *hwdev, u16 q_id);=0D
+=0D
+u16 hinic3_dbg_get_global_qpn(void *hwdev);=0D
+=0D
+/**=0D
+ * Get details of specified RX queue and store in `rq_info`.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to the hardware device.=0D
+ * @param[in] q_id=0D
+ * RX queue ID.=0D
+ * @param[out] rq_info=0D
+ * Structure to store RX queue information.=0D
+ * @param[out] msg_size=0D
+ * Size of the message.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_dbg_get_rq_info(void *hwdev, uint16_t q_id,=0D
+			   struct hinic3_dbg_rq_info *rq_info, u16 *msg_size);=0D
+=0D
+/**=0D
+ * Get the RX CQE at the specified index from the given RX queue.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] q_id=0D
+ * RX queue ID.=0D
+ * @param[in] idx=0D
+ * Index of the CQE.=0D
+ * @param[out] buf_out=0D
+ * Buffer to store the CQE.=0D
+ * @param[out] out_size=0D
+ * Size of the CQE.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_dbg_get_rx_cqe_info(void *hwdev, uint16_t q_id, uint16_t idx,=0D
+			       void *buf_out, uint16_t *out_size);=0D
+=0D
+/**=0D
+ * Get SQ information for debugging.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] q_id=0D
+ * ID of SQ to retrieve information for.=0D
+ * @param[out] sq_info=0D
+ * Pointer to the structure where the SQ information will be stored.=0D
+ * @param[out] msg_size=0D
+ * The size (in bytes) of the `sq_info` structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -EINVAL if the queue ID is invalid.=0D
+ */=0D
+int hinic3_dbg_get_sq_info(void *hwdev, u16 q_id,=0D
+			   struct hinic3_dbg_sq_info *sq_info, u16 *msg_size);=0D
+=0D
+/**=0D
+ * Get WQE information from a send queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] q_id=0D
+ * The ID of the send queue from which to retrieve WQE information.=0D
+ * @param[in] idx=0D
+ * The index of the first WQE to retrieve.=0D
+ * @param[in] wqebb_cnt=0D
+ * The number of WQEBBs to retrieve.=0D
+ * @param[out] wqe=0D
+ * Pointer to the buffer where the WQE data will be stored.=0D
+ * @param[out] wqe_size=0D
+ * The size (in bytes) of the retrieved WQE data.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -EINVAL if queue ID invalid.=0D
+ * - -EFAULT if index invalid.=0D
+ */=0D
+int hinic3_dbg_get_sq_wqe_info(void *hwdev, u16 q_id, u16 idx, u16 wqebb_c=
nt,=0D
+			       u8 *wqe, u16 *wqe_size);=0D
+=0D
+/**=0D
+ * Get WQE information from a receive queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to the device structure.=0D
+ * @param[in] q_id=0D
+ * The ID of the receive queue from which to retrieve WQE information.=0D
+ * @param[in] idx=0D
+ * The index of the first WQE to retrieve.=0D
+ * @param[in] wqebb_cnt=0D
+ * The number of WQEBBs to retrieve.=0D
+ * @param[out] wqe=0D
+ * Pointer to the buffer where the WQE data will be stored.=0D
+ * @param[out] wqe_size=0D
+ * The size (in bytes) of the retrieved WQE data.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -EINVAL if queue ID invalid.=0D
+ * - -EFAULT if index invalid.=0D
+ */=0D
+int hinic3_dbg_get_rq_wqe_info(void *hwdev, u16 q_id, u16 idx, u16 wqebb_c=
nt,=0D
+			       u8 *wqe, u16 *wqe_size);=0D
+=0D
+#endif /* _HINIC3_MML_DBG_H */=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_cmd.c b/drivers/net/hinic3/m=
ml/hinic3_mml_cmd.c=0D
new file mode 100644=0D
index 0000000000..797952b8c0=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_cmd.c=0D
@@ -0,0 +1,375 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#include "hinic3_mml_lib.h"=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_mml_cmd.h"=0D
+=0D
+/**=0D
+ * Compares two strings for equality.=0D
+ *=0D
+ * @param[in] command=0D
+ * The first string to compare.=0D
+ * @param[in] argument=0D
+ * The second string to compare.=0D
+ *=0D
+ * @return=0D
+ * UDA_TRUE if the strings are equal, otherwise UDA_FALSE.=0D
+ */=0D
+static int=0D
+string_cmp(const char *command, const char *argument)=0D
+{=0D
+	const char *cmd =3D command;=0D
+	const char *arg =3D argument;=0D
+=0D
+	if (!cmd || !arg)=0D
+		return UDA_FALSE;=0D
+=0D
+	if (strlen(cmd) !=3D strlen(arg))=0D
+		return UDA_FALSE;=0D
+=0D
+	do {=0D
+		if (*cmd !=3D *arg)=0D
+			return UDA_FALSE;=0D
+		cmd++;=0D
+		arg++;=0D
+	} while (*cmd !=3D '\0');=0D
+=0D
+	return UDA_TRUE;=0D
+}=0D
+=0D
+static void=0D
+show_tool_version(cmd_adapter_t *adapter)=0D
+{=0D
+	hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+			   "hinic3 pmd version %s", HINIC3_PMD_DRV_VERSION);=0D
+}=0D
+=0D
+static void=0D
+show_tool_help(cmd_adapter_t *adapter)=0D
+{=0D
+	int i;=0D
+	major_cmd_t *major_cmd =3D NULL;=0D
+=0D
+	if (!adapter)=0D
+		return;=0D
+=0D
+	hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+			   "\n Usage:evsadm exec dump-hinic-status <major_cmd> "=0D
+			   "[option]\n");=0D
+	hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+			   "	-h, --help show help information");=0D
+	hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+			   "	-v, --version show version information");=0D
+	hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+			   "\n Major Commands:\n");=0D
+=0D
+	for (i =3D 0; i < adapter->major_cmds; i++) {=0D
+		major_cmd =3D adapter->p_major_cmd[i];=0D
+		hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+				   "	%-23s %s", major_cmd->name,=0D
+				   major_cmd->description);=0D
+	}=0D
+	hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len, "\n");=0D
+}=0D
+=0D
+void=0D
+major_command_option(major_cmd_t *major_cmd, const char *little,=0D
+		     const char *large, uint32_t have_param,=0D
+		     command_record_t record)=0D
+{=0D
+	cmd_option_t *option =3D NULL;=0D
+=0D
+	if (major_cmd =3D=3D NULL || (little =3D=3D NULL && large =3D=3D NULL) ||=
 !record) {=0D
+		PMD_DRV_LOG(ERR, "Invalid input parameter.");=0D
+		return;=0D
+	}=0D
+=0D
+	if (major_cmd->option_count >=3D COMMAND_MAX_OPTIONS) {=0D
+		PMD_DRV_LOG(ERR, "Do not support more than %d options",=0D
+			    COMMAND_MAX_OPTIONS);=0D
+		return;=0D
+	}=0D
+=0D
+	option =3D &major_cmd->options[major_cmd->option_count];=0D
+	major_cmd->options_repeat_flag[major_cmd->option_count] =3D 0;=0D
+	major_cmd->option_count++;=0D
+=0D
+	option->record =3D record;=0D
+	option->little =3D little;=0D
+	option->large =3D large;=0D
+	option->have_param =3D have_param;=0D
+}=0D
+=0D
+void=0D
+major_command_register(cmd_adapter_t *adapter, major_cmd_t *major_cmd)=0D
+{=0D
+	int i =3D 0;=0D
+=0D
+	if (adapter =3D=3D NULL || major_cmd =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Invalid input parameter.");=0D
+		return;=0D
+	}=0D
+=0D
+	if (adapter->major_cmds >=3D COMMAND_MAX_MAJORS) {=0D
+		PMD_DRV_LOG(ERR, "Major Commands is full");=0D
+		return;=0D
+	}=0D
+	while (adapter->p_major_cmd[i] !=3D NULL)=0D
+		i++;=0D
+	adapter->p_major_cmd[i] =3D major_cmd;=0D
+	adapter->major_cmds++;=0D
+	major_cmd->adapter =3D adapter;=0D
+	major_cmd->err_no =3D UDA_SUCCESS;=0D
+	memset(major_cmd->err_str, 0, sizeof(major_cmd->err_str));=0D
+}=0D
+=0D
+static int=0D
+is_help_version(cmd_adapter_t *adapter, int argc, char *arg)=0D
+{=0D
+	if (COMMAND_HELP_POSITION(argc) &&=0D
+	    (string_cmp("-h", arg) || string_cmp("--help", arg))) {=0D
+		show_tool_help(adapter);=0D
+		return UDA_TRUE;=0D
+	}=0D
+=0D
+	if (COMMAND_VERSION_POSITION(argc) &&=0D
+	    (string_cmp("-v", arg) || string_cmp("--version", arg))) {=0D
+		show_tool_version(adapter);=0D
+		return UDA_TRUE;=0D
+	}=0D
+=0D
+	return UDA_FALSE;=0D
+}=0D
+=0D
+static int=0D
+check_command_length(int argc, char **argv)=0D
+{=0D
+	int i;=0D
+	unsigned long long str_len =3D 0;=0D
+=0D
+	for (i =3D 1; i < argc; i++)=0D
+		str_len +=3D strlen(argv[i]);=0D
+=0D
+	if (str_len > COMMAND_MAX_STRING)=0D
+		return -UDA_EINVAL;=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static inline int=0D
+char_check(const char cmd)=0D
+{=0D
+	if (cmd >=3D 'a' && cmd <=3D 'z')=0D
+		return UDA_SUCCESS;=0D
+=0D
+	if (cmd >=3D 'A' && cmd <=3D 'Z')=0D
+		return UDA_SUCCESS;=0D
+	return UDA_FAIL;=0D
+}=0D
+=0D
+static int=0D
+major_command_check_param(cmd_option_t *option, char *arg)=0D
+{=0D
+	if (!option)=0D
+		return -UDA_EINVAL;=0D
+	if (option->have_param !=3D 0) {=0D
+		if (!arg || ((arg[0] =3D=3D '-') && char_check(arg[1])))=0D
+			return -UDA_EINVAL;=0D
+		return UDA_SUCCESS;=0D
+	}=0D
+=0D
+	return -UDA_ENOOBJ;=0D
+}=0D
+=0D
+static int=0D
+major_cmd_repeat_option_set(major_cmd_t *major_cmd, const cmd_option_t *op=
tion,=0D
+			    u32 *options_repeat_flag)=0D
+{=0D
+	int err;=0D
+=0D
+	if (*options_repeat_flag !=3D 0) {=0D
+		major_cmd->err_no =3D -UDA_EINVAL;=0D
+		err =3D snprintf(major_cmd->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			       "Repeated option %s|%s.", option->little,=0D
+			       option->large);=0D
+		if (err <=3D 0) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"snprintf cmd repeat option failed, err: %d.",=0D
+				err);=0D
+		}=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+	*options_repeat_flag =3D 1;=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+major_cmd_option_check(major_cmd_t *major_cmd, char **argv, int *index)=0D
+{=0D
+	int j, ret, err, option_ok, intermediate_var;=0D
+	cmd_option_t *option =3D NULL;=0D
+	char *arg =3D argv[*index];=0D
+=0D
+	/* Find command. */=0D
+	for (j =3D 0; j < major_cmd->option_count; j++) {=0D
+		option =3D &major_cmd->options[j];=0D
+		option_ok =3D (((option->little !=3D NULL) &&=0D
+			      string_cmp(option->little, arg)) ||=0D
+			     ((option->large !=3D NULL) &&=0D
+			      string_cmp(option->large, arg)));=0D
+		if (!option_ok)=0D
+			continue;=0D
+		/* Find same option. */=0D
+		ret =3D major_cmd_repeat_option_set(major_cmd,=0D
+			option, &major_cmd->options_repeat_flag[j]);=0D
+		if (ret !=3D UDA_SUCCESS)=0D
+			return ret;=0D
+=0D
+		arg =3D NULL;=0D
+		/* If this option need parameters. */=0D
+		intermediate_var =3D (*index) + 1;=0D
+		ret =3D major_command_check_param(option, argv[intermediate_var]);=0D
+		if (ret =3D=3D UDA_SUCCESS) {=0D
+			(*index)++;=0D
+			arg =3D argv[*index];=0D
+		} else if (ret =3D=3D -UDA_EINVAL) {=0D
+			major_cmd->err_no =3D -UDA_EINVAL;=0D
+			err =3D snprintf(major_cmd->err_str,=0D
+				       COMMANDER_ERR_MAX_STRING - 1,=0D
+				       "%s|%s option need parameter.",=0D
+				       option->little, option->large);=0D
+			if (err <=3D 0) {=0D
+				PMD_DRV_LOG(ERR,=0D
+					    "snprintf cmd option need para "=0D
+					    "failed, err: %d.",=0D
+					    err);=0D
+			}=0D
+			return -UDA_EINVAL;=0D
+		}=0D
+=0D
+		/* Record messages. */=0D
+		ret =3D option->record(major_cmd, arg);=0D
+		if (ret !=3D UDA_SUCCESS)=0D
+			return ret;=0D
+		break;=0D
+	}=0D
+=0D
+	/* Illegal option. */=0D
+	if (j =3D=3D major_cmd->option_count) {=0D
+		major_cmd->err_no =3D -UDA_EINVAL;=0D
+		err =3D snprintf(major_cmd->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			       "%s is not option needed.", arg);=0D
+		if (err <=3D 0) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"snprintf cmd option invalid failed, err: %d.",=0D
+				err);=0D
+		}=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+major_command_parse(major_cmd_t *major_cmd, int argc, char **argv)=0D
+{=0D
+	int i, err;=0D
+=0D
+	for (i =3D 0; i < argc; i++) {=0D
+		err =3D major_cmd_option_check(major_cmd, argv, &i);=0D
+		if (err !=3D UDA_SUCCESS)=0D
+			return err;=0D
+	}=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+copy_result_to_buffer(void *buf_out, char *result, int len)=0D
+{=0D
+	int ret;=0D
+=0D
+	ret =3D snprintf(buf_out, len - 1, "%s", result);=0D
+	if (ret <=3D 0)=0D
+		return 0;=0D
+=0D
+	return ret + 1;=0D
+}=0D
+=0D
+void=0D
+command_parse(cmd_adapter_t *adapter, int argc, char **argv, void *buf_out=
,=0D
+	      uint32_t *out_len)=0D
+{=0D
+	int i;=0D
+	major_cmd_t *major_cmd =3D NULL;=0D
+	char *arg =3D argv[1];=0D
+=0D
+	if (is_help_version(adapter, argc, arg) =3D=3D UDA_TRUE) {=0D
+		*out_len =3D (u32)copy_result_to_buffer(buf_out,=0D
+			adapter->show_str, MAX_SHOW_STR_LEN);=0D
+		return;=0D
+	}=0D
+=0D
+	for (i =3D 0; i < adapter->major_cmds; i++) {=0D
+		major_cmd =3D adapter->p_major_cmd[i];=0D
+=0D
+		/* Find major command. */=0D
+		if (!string_cmp(major_cmd->name, arg))=0D
+			continue;=0D
+		if (check_command_length(argc, argv) !=3D UDA_SUCCESS) {=0D
+			major_cmd->err_no =3D -UDA_EINVAL;=0D
+			snprintf(major_cmd->err_str,=0D
+				       COMMANDER_ERR_MAX_STRING - 1,=0D
+				       "Command input too long.");=0D
+			break;=0D
+		}=0D
+=0D
+		/* Deal sub command. */=0D
+		if (argc > SUB_COMMAND_OFFSET) {=0D
+			if (major_command_parse(major_cmd,=0D
+				    argc - SUB_COMMAND_OFFSET,=0D
+				    argv + SUB_COMMAND_OFFSET) !=3D UDA_SUCCESS) {=0D
+				goto PARSE_OUT;=0D
+			}=0D
+		}=0D
+=0D
+		/* Command exec. */=0D
+		major_cmd->execute(major_cmd);=0D
+		break;=0D
+	}=0D
+=0D
+	/* Not find command. */=0D
+	if (i =3D=3D adapter->major_cmds) {=0D
+		hinic3_pmd_mml_log(adapter->show_str, &adapter->show_len,=0D
+				   "Unknown major command, assign 'evsadm exec "=0D
+				   "dump-hinic-status -h' for help.");=0D
+		*out_len =3D (u32)copy_result_to_buffer(buf_out,=0D
+			adapter->show_str, MAX_SHOW_STR_LEN);=0D
+		return;=0D
+	}=0D
+=0D
+PARSE_OUT:=0D
+	if (major_cmd->err_no !=3D UDA_SUCCESS &&=0D
+	    major_cmd->err_no !=3D -UDA_CANCEL) {=0D
+		PMD_DRV_LOG(ERR, "%s command error(%d): %s", major_cmd->name,=0D
+			    major_cmd->err_no, major_cmd->err_str);=0D
+=0D
+		hinic3_pmd_mml_log(major_cmd->show_str, &major_cmd->show_len,=0D
+				   "%s command error(%d): %s",=0D
+				   major_cmd->name, major_cmd->err_no,=0D
+				   major_cmd->err_str);=0D
+	}=0D
+	*out_len =3D (u32)copy_result_to_buffer(buf_out, major_cmd->show_str,=0D
+					      MAX_SHOW_STR_LEN);=0D
+}=0D
+=0D
+void=0D
+tool_target_init(int *bus_num, char *dev_name, int len)=0D
+{=0D
+	*bus_num =3D TRGET_UNKNOWN_BUS_NUM;=0D
+	memset(dev_name, 0, len);=0D
+}=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_cmd.h b/drivers/net/hinic3/m=
ml/hinic3_mml_cmd.h=0D
new file mode 100644=0D
index 0000000000..b9c32441b5=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_cmd.h=0D
@@ -0,0 +1,131 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#ifndef _HINIC3_MML_CMD=0D
+#define _HINIC3_MML_CMD=0D
+=0D
+#include <stdint.h>=0D
+=0D
+#define COMMAND_HELP_POSITION(argc)            \=0D
+	({                                    \=0D
+		typeof(argc) __argc =3D (argc); \=0D
+		(__argc =3D=3D 1 || __argc =3D=3D 2); \=0D
+	})=0D
+#define COMMAND_VERSION_POSITION(argc) ((argc) =3D=3D 2)=0D
+#define SUB_COMMAND_OFFSET	      2=0D
+=0D
+#define COMMAND_MAX_MAJORS	 128=0D
+#define COMMAND_MAX_OPTIONS	 64=0D
+#define PARAM_MAX_STRING	 128=0D
+#define COMMAND_MAX_STRING	 512=0D
+#define COMMANDER_ERR_MAX_STRING 128=0D
+=0D
+#define MAX_NAME_LEN	 32=0D
+#define MAX_DES_LEN	 128=0D
+#define MAX_SHOW_STR_LEN 2048=0D
+=0D
+struct tag_major_cmd_t;=0D
+struct tag_cmd_adapter_t;=0D
+=0D
+typedef int (*command_record_t)(struct tag_major_cmd_t *major, char *param=
);=0D
+typedef void (*command_executeute_t)(struct tag_major_cmd_t *major);=0D
+=0D
+typedef struct {=0D
+	const char *little;=0D
+	const char *large;=0D
+	unsigned int have_param;=0D
+	command_record_t record;=0D
+} cmd_option_t;=0D
+=0D
+/* Major command structure for save command details and options. */=0D
+typedef struct tag_major_cmd_t {=0D
+	struct tag_cmd_adapter_t *adapter;=0D
+	char name[MAX_NAME_LEN];=0D
+	int option_count;=0D
+	cmd_option_t options[COMMAND_MAX_OPTIONS];=0D
+	uint32_t options_repeat_flag[COMMAND_MAX_OPTIONS];=0D
+	command_executeute_t execute;=0D
+	int err_no;=0D
+	char err_str[COMMANDER_ERR_MAX_STRING];=0D
+	char show_str[MAX_SHOW_STR_LEN];=0D
+	int show_len;=0D
+	char description[MAX_DES_LEN];=0D
+	void *cmd_st; /**< Command show queue state structure. */=0D
+} major_cmd_t;=0D
+=0D
+typedef struct tag_cmd_adapter_t {=0D
+	const char *name;=0D
+	const char *version;=0D
+	major_cmd_t *p_major_cmd[COMMAND_MAX_MAJORS];=0D
+	int major_cmds;=0D
+	char show_str[MAX_SHOW_STR_LEN];=0D
+	int show_len;=0D
+	char *cmd_buf;=0D
+} cmd_adapter_t;=0D
+=0D
+/**=0D
+ * Add an option to a major command.=0D
+ *=0D
+ * This function adds a command option with its short and long forms, whet=
her it=0D
+ * requires a parameter, and the function to handle it.=0D
+ *=0D
+ * @param[in] major_cmd=0D
+ * Pointer to the major command structure.=0D
+ * @param[in] little=0D
+ * Short form of the option.=0D
+ * @param[in] large=0D
+ * Long form of the option.=0D
+ * @param[in] have_param=0D
+ * Flag indicating whether the option requires a parameter.=0D
+ * @param[in] record=0D
+ * Function to handle the option's action.=0D
+ */=0D
+void major_command_option(major_cmd_t *major_cmd, const char *little,=0D
+			  const char *large, uint32_t have_param,=0D
+			  command_record_t record);=0D
+=0D
+/**=0D
+ * Register a major command with adapter.=0D
+ *=0D
+ * @param[in] adapter=0D
+ * Pointer to command adapter.=0D
+ * @param[in] major_cmd=0D
+ * The major command to be registered with the adapter.=0D
+ */=0D
+void major_command_register(cmd_adapter_t *adapter, major_cmd_t *major_cmd=
);=0D
+=0D
+/**=0D
+ * Parse and execute commands.=0D
+ *=0D
+ * @param[in] adapter=0D
+ * Pointer to command adapter.=0D
+ * @param[in] argc=0D
+ * The number of command arguments.=0D
+ * @param[in] argv=0D
+ * The array of command arguments.=0D
+ * @param[out] buf_out=0D
+ * The buffer used to store the output result.=0D
+ * @param[out] out_len=0D
+ * The length (in bytes) of the output result.=0D
+ */=0D
+void command_parse(cmd_adapter_t *adapter, int argc, char **argv, void *bu=
f_out,=0D
+		   uint32_t *out_len);=0D
+=0D
+/**=0D
+ * Initialize the target bus number and device name.=0D
+ *=0D
+ * @param[out] bus_num=0D
+ * Pointer to the bus number, which will be set to a default unknown value=
.=0D
+ * @param[out] dev_name=0D
+ * Pointer to the device name buffer, which will be cleared (set to zeros)=
.=0D
+ * @param[in] len=0D
+ * The length of the device name buffer.=0D
+ */=0D
+void tool_target_init(int *bus_num, char *dev_name, int len);=0D
+=0D
+int cmd_show_q_init(cmd_adapter_t *adapter);=0D
+int cmd_show_xstats_init(cmd_adapter_t *adapter);=0D
+int cmd_show_dump_init(cmd_adapter_t *adapter);=0D
+=0D
+#endif /* _HINIC3_MML_CMD */=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_ioctl.c b/drivers/net/hinic3=
/mml/hinic3_mml_ioctl.c=0D
new file mode 100644=0D
index 0000000000..e0ae558f05=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_ioctl.c=0D
@@ -0,0 +1,215 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+#include <rte_ethdev.h>=0D
+#include <rte_pci.h>=0D
+#include <rte_bus_pci.h>=0D
+#include <rte_common.h>=0D
+#include <rte_ether.h>=0D
+#include <rte_ethdev_core.h>=0D
+#include "hinic3_mml_lib.h"=0D
+#include "hinic3_dbg.h"=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_csr.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_ethdev.h"=0D
+=0D
+static int=0D
+get_tx_info(struct rte_eth_dev *dev, void *buf_in, uint16_t in_size,=0D
+	    void *buf_out, uint16_t *out_size)=0D
+{=0D
+	uint16_t q_id =3D *((uint16_t *)buf_in);=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (in_size !=3D sizeof(int))=0D
+		return -UDA_EINVAL;=0D
+=0D
+	return hinic3_dbg_get_sq_info(nic_dev->hwdev, q_id, buf_out, out_size);=0D
+}=0D
+=0D
+static int=0D
+get_tx_wqe_info(struct rte_eth_dev *dev, void *buf_in, uint16_t in_size,=0D
+		void *buf_out, uint16_t *out_size)=0D
+{=0D
+	struct hinic_wqe_info *wqe_info =3D (struct hinic_wqe_info *)buf_in;=0D
+	uint16_t q_id =3D (uint16_t)wqe_info->q_id;=0D
+	uint16_t idx =3D (uint16_t)wqe_info->wqe_id;=0D
+	uint16_t wqebb_cnt =3D (uint16_t)wqe_info->wqebb_cnt;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (in_size !=3D sizeof(struct hinic_wqe_info))=0D
+		return -UDA_EINVAL;=0D
+=0D
+	return hinic3_dbg_get_sq_wqe_info(nic_dev->hwdev, q_id, idx, wqebb_cnt,=0D
+					  buf_out, out_size);=0D
+}=0D
+=0D
+static int=0D
+get_rx_info(struct rte_eth_dev *dev, void *buf_in, uint16_t in_size,=0D
+	    void *buf_out, uint16_t *out_size)=0D
+{=0D
+	uint16_t q_id =3D *((uint16_t *)buf_in);=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (in_size !=3D sizeof(int))=0D
+		return -UDA_EINVAL;=0D
+=0D
+	return hinic3_dbg_get_rq_info(nic_dev->hwdev, q_id, buf_out, out_size);=0D
+}=0D
+=0D
+static int=0D
+get_rx_wqe_info(struct rte_eth_dev *dev, void *buf_in, uint16_t in_size,=0D
+		void *buf_out, uint16_t *out_size)=0D
+{=0D
+	struct hinic_wqe_info *wqe_info =3D (struct hinic_wqe_info *)buf_in;=0D
+	uint16_t q_id =3D (uint16_t)wqe_info->q_id;=0D
+	uint16_t idx =3D (uint16_t)wqe_info->wqe_id;=0D
+	uint16_t wqebb_cnt =3D (uint16_t)wqe_info->wqebb_cnt;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (in_size !=3D sizeof(struct hinic_wqe_info))=0D
+		return -UDA_EINVAL;=0D
+=0D
+	return hinic3_dbg_get_rq_wqe_info(nic_dev->hwdev, q_id, idx, wqebb_cnt,=0D
+					  buf_out, out_size);=0D
+}=0D
+=0D
+static int=0D
+get_rx_cqe_info(struct rte_eth_dev *dev, void *buf_in, uint16_t in_size,=0D
+		void *buf_out, uint16_t *out_size)=0D
+{=0D
+	struct hinic_wqe_info *wqe_info =3D (struct hinic_wqe_info *)buf_in;=0D
+	uint16_t q_id =3D (uint16_t)wqe_info->q_id;=0D
+	uint16_t idx =3D (uint16_t)wqe_info->wqe_id;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (in_size !=3D sizeof(struct hinic_wqe_info))=0D
+		return -UDA_EINVAL;=0D
+=0D
+	return hinic3_dbg_get_rx_cqe_info(nic_dev->hwdev, q_id, idx, buf_out,=0D
+					  out_size);=0D
+}=0D
+=0D
+typedef int (*nic_drv_module)(struct rte_eth_dev *dev, void *buf_in,=0D
+			      uint16_t in_size, void *buf_out,=0D
+			      uint16_t *out_size);=0D
+=0D
+struct nic_drv_module_handle {=0D
+	enum driver_cmd_type drv_cmd_name;=0D
+	nic_drv_module drv_func;=0D
+};=0D
+=0D
+const struct nic_drv_module_handle g_nic_drv_module_cmd_handle[] =3D {=0D
+	{TX_INFO, get_tx_info},		{TX_WQE_INFO, get_tx_wqe_info},=0D
+	{RX_INFO, get_rx_info},		{RX_WQE_INFO, get_rx_wqe_info},=0D
+	{RX_CQE_INFO, get_rx_cqe_info},=0D
+};=0D
+=0D
+static int=0D
+send_to_nic_driver(struct rte_eth_dev *dev, struct msg_module *nt_msg)=0D
+{=0D
+	int index;=0D
+	int err =3D 0;=0D
+	enum driver_cmd_type cmd_type =3D=0D
+		(enum driver_cmd_type)nt_msg->msg_format;=0D
+	int num_cmds =3D sizeof(g_nic_drv_module_cmd_handle) /=0D
+		       sizeof(g_nic_drv_module_cmd_handle[0]);=0D
+=0D
+	for (index =3D 0; index < num_cmds; index++) {=0D
+		if (cmd_type =3D=3D=0D
+		    g_nic_drv_module_cmd_handle[index].drv_cmd_name) {=0D
+			err =3D g_nic_drv_module_cmd_handle[index].drv_func(dev,=0D
+				nt_msg->in_buf,=0D
+				(uint16_t)nt_msg->buf_in_size, nt_msg->out_buf,=0D
+				(uint16_t *)&nt_msg->buf_out_size);=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	if (index =3D=3D num_cmds) {=0D
+		PMD_DRV_LOG(ERR, "Unknown nic driver cmd: %d", cmd_type);=0D
+		err =3D -UDA_EINVAL;=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_msg_handle(struct rte_eth_dev *dev, struct msg_module *nt_msg)=0D
+{=0D
+	int err;=0D
+=0D
+	switch (nt_msg->module) {=0D
+	case SEND_TO_NIC_DRIVER:=0D
+		err =3D send_to_nic_driver(dev, nt_msg);=0D
+		if (err !=3D 0)=0D
+			PMD_DRV_LOG(ERR, "Send message to driver failed");=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "Unknown message module: %d", nt_msg->module);=0D
+		err =3D -UDA_EINVAL;=0D
+		break;=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static struct rte_eth_dev *=0D
+get_eth_dev_by_pci_addr(char *pci_addr, __rte_unused int len)=0D
+{=0D
+	uint32_t i;=0D
+	struct rte_eth_dev *eth_dev =3D NULL;=0D
+	struct rte_pci_device *pci_dev =3D NULL;=0D
+	int ret;=0D
+	uint32_t bus, devid, function;=0D
+=0D
+	ret =3D sscanf(pci_addr, "%02x:%02x.%x", &bus, &devid, &function);=0D
+	if (ret <=3D 0) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get pci bus devid and function id fail, err: %d",=0D
+			    ret);=0D
+		return NULL;=0D
+	}=0D
+=0D
+	for (i =3D 0; i < RTE_MAX_ETHPORTS; i++) {=0D
+		eth_dev =3D &rte_eth_devices[i];=0D
+		if (eth_dev->state !=3D RTE_ETH_DEV_ATTACHED)=0D
+			continue;=0D
+=0D
+		pci_dev =3D RTE_ETH_DEV_TO_PCI(eth_dev);=0D
+=0D
+#ifdef CONFIG_SP_VID_DID=0D
+		if (pci_dev->id.vendor_id =3D=3D PCI_VENDOR_ID_SPNIC &&=0D
+		    (pci_dev->id.device_id =3D=3D HINIC3_DEV_ID_STANDARD ||=0D
+		     pci_dev->id.device_id =3D=3D HINIC3_DEV_ID_VF) &&=0D
+#else=0D
+		if (pci_dev->id.vendor_id =3D=3D PCI_VENDOR_ID_HUAWEI &&=0D
+		    (pci_dev->id.device_id =3D=3D HINIC3_DEV_ID_STANDARD ||=0D
+		     pci_dev->id.device_id =3D=3D HINIC3_DEV_ID_VF) &&=0D
+#endif=0D
+		    pci_dev->addr.bus =3D=3D bus && pci_dev->addr.devid =3D=3D devid &&=
=0D
+		    pci_dev->addr.function =3D=3D function) {=0D
+			return eth_dev;=0D
+		}=0D
+	}=0D
+=0D
+	return NULL;=0D
+}=0D
+=0D
+int=0D
+hinic3_pmd_mml_ioctl(void *msg)=0D
+{=0D
+	struct msg_module *nt_msg =3D msg;=0D
+	struct rte_eth_dev *dev;=0D
+=0D
+	dev =3D get_eth_dev_by_pci_addr(nt_msg->device_name,=0D
+				      sizeof(nt_msg->device_name));=0D
+	if (!dev) {=0D
+		PMD_DRV_LOG(ERR, "Can not get the device %s correctly",=0D
+			    nt_msg->device_name);=0D
+		return UDA_FAIL;=0D
+	}=0D
+=0D
+	return hinic3_msg_handle(dev, nt_msg);=0D
+}=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_lib.c b/drivers/net/hinic3/m=
ml/hinic3_mml_lib.c=0D
new file mode 100644=0D
index 0000000000..c74777f50b=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_lib.c=0D
@@ -0,0 +1,136 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_mml_lib.h"=0D
+=0D
+int=0D
+tool_get_valid_target(char *name, struct tool_target *target)=0D
+{=0D
+	int ret =3D UDA_SUCCESS;=0D
+=0D
+	if (strlen(name) >=3D MAX_DEV_LEN) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Input parameter of device name is too long.");=0D
+		ret =3D -UDA_ELEN;=0D
+	} else {=0D
+		memcpy(target->dev_name, name, strlen(name));=0D
+		target->bus_num =3D 0;=0D
+	}=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+static void=0D
+fill_ioctl_msg_hd(struct msg_module *msg, unsigned int module,=0D
+		  unsigned int msg_format, unsigned int in_buff_len,=0D
+		  unsigned int out_buff_len, char *dev_name, int bus_num)=0D
+{=0D
+	memcpy(msg->device_name, dev_name, strlen(dev_name) + 1);=0D
+=0D
+	msg->module =3D module;=0D
+	msg->msg_format =3D msg_format;=0D
+	msg->buf_in_size =3D in_buff_len;=0D
+	msg->buf_out_size =3D out_buff_len;=0D
+	msg->bus_num =3D bus_num;=0D
+}=0D
+=0D
+static int=0D
+lib_ioctl(struct msg_module *in_buf, void *out_buf)=0D
+{=0D
+	in_buf->out_buf =3D out_buf;=0D
+=0D
+	return hinic3_pmd_mml_ioctl(in_buf);=0D
+}=0D
+=0D
+int=0D
+lib_tx_sq_info_get(struct tool_target target, struct nic_sq_info *sq_info,=
=0D
+		   int sq_id)=0D
+{=0D
+	struct msg_module msg_to_kernel;=0D
+=0D
+	memset(&msg_to_kernel, 0, sizeof(msg_to_kernel));=0D
+	fill_ioctl_msg_hd(&msg_to_kernel, SEND_TO_NIC_DRIVER, TX_INFO,=0D
+			  (unsigned int)sizeof(int),=0D
+			  (unsigned int)sizeof(struct nic_sq_info),=0D
+			  target.dev_name, target.bus_num);=0D
+	msg_to_kernel.in_buf =3D (void *)&sq_id;=0D
+=0D
+	return lib_ioctl(&msg_to_kernel, sq_info);=0D
+}=0D
+=0D
+int=0D
+lib_tx_wqe_info_get(struct tool_target target, struct nic_sq_info *sq_info=
,=0D
+		    int sq_id, int wqe_id, void *nwqe, int nwqe_size)=0D
+{=0D
+	struct msg_module msg_to_kernel;=0D
+	struct hinic_wqe_info wqe =3D {0};=0D
+=0D
+	wqe.wqe_id =3D wqe_id;=0D
+	wqe.q_id =3D sq_id;=0D
+	wqe.wqebb_cnt =3D nwqe_size / sq_info->sq_wqebb_size;=0D
+=0D
+	memset(&msg_to_kernel, 0, sizeof(msg_to_kernel));=0D
+	fill_ioctl_msg_hd(&msg_to_kernel, SEND_TO_NIC_DRIVER, TX_WQE_INFO,=0D
+			  (unsigned int)(sizeof(struct hinic_wqe_info)),=0D
+			  nwqe_size, target.dev_name, target.bus_num);=0D
+	msg_to_kernel.in_buf =3D (void *)&wqe;=0D
+=0D
+	return lib_ioctl(&msg_to_kernel, nwqe);=0D
+}=0D
+=0D
+int=0D
+lib_rx_rq_info_get(struct tool_target target, struct nic_rq_info *rq_info,=
=0D
+		   int rq_id)=0D
+{=0D
+	struct msg_module msg_to_kernel;=0D
+=0D
+	memset(&msg_to_kernel, 0, sizeof(msg_to_kernel));=0D
+	fill_ioctl_msg_hd(&msg_to_kernel, SEND_TO_NIC_DRIVER, RX_INFO,=0D
+			  (unsigned int)(sizeof(int)),=0D
+			  (unsigned int)sizeof(struct nic_rq_info),=0D
+			  target.dev_name, target.bus_num);=0D
+	msg_to_kernel.in_buf =3D &rq_id;=0D
+=0D
+	return lib_ioctl(&msg_to_kernel, rq_info);=0D
+}=0D
+=0D
+int=0D
+lib_rx_wqe_info_get(struct tool_target target, struct nic_rq_info *rq_info=
,=0D
+		    int rq_id, int wqe_id, void *nwqe, int nwqe_size)=0D
+{=0D
+	struct msg_module msg_to_kernel;=0D
+	struct hinic_wqe_info wqe =3D {0};=0D
+=0D
+	wqe.wqe_id =3D wqe_id;=0D
+	wqe.q_id =3D rq_id;=0D
+	wqe.wqebb_cnt =3D nwqe_size / rq_info->rq_wqebb_size;=0D
+=0D
+	memset(&msg_to_kernel, 0, sizeof(msg_to_kernel));=0D
+	fill_ioctl_msg_hd(&msg_to_kernel, SEND_TO_NIC_DRIVER, RX_WQE_INFO,=0D
+			  (unsigned int)(sizeof(struct hinic_wqe_info)),=0D
+			  nwqe_size, target.dev_name, target.bus_num);=0D
+	msg_to_kernel.in_buf =3D (void *)&wqe;=0D
+=0D
+	return lib_ioctl(&msg_to_kernel, nwqe);=0D
+}=0D
+=0D
+int=0D
+lib_rx_cqe_info_get(struct tool_target target,=0D
+		    __rte_unused struct nic_rq_info *rq_info, int rq_id,=0D
+		    int wqe_id, void *nwqe, int nwqe_size)=0D
+{=0D
+	struct msg_module msg_to_kernel;=0D
+	struct hinic_wqe_info wqe =3D {0};=0D
+=0D
+	wqe.wqe_id =3D wqe_id;=0D
+	wqe.q_id =3D rq_id;=0D
+=0D
+	memset(&msg_to_kernel, 0, sizeof(msg_to_kernel));=0D
+	fill_ioctl_msg_hd(&msg_to_kernel, SEND_TO_NIC_DRIVER, RX_CQE_INFO,=0D
+			  (unsigned int)(sizeof(struct hinic_wqe_info)),=0D
+			  nwqe_size, target.dev_name, target.bus_num);=0D
+	msg_to_kernel.in_buf =3D (void *)&wqe;=0D
+=0D
+	return lib_ioctl(&msg_to_kernel, nwqe);=0D
+}=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_lib.h b/drivers/net/hinic3/m=
ml/hinic3_mml_lib.h=0D
new file mode 100644=0D
index 0000000000..ab045525f3=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_lib.h=0D
@@ -0,0 +1,276 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#ifndef _HINIC3_MML_LIB=0D
+#define _HINIC3_MML_LIB=0D
+=0D
+#include <string.h>=0D
+#include <stdint.h>=0D
+=0D
+#include "hinic3_mml_cmd.h"=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_mgmt.h"=0D
+=0D
+#define MAX_DEV_LEN	      16=0D
+#define TRGET_UNKNOWN_BUS_NUM (-1)=0D
+=0D
+#ifndef DEV_NAME_LEN=0D
+#define DEV_NAME_LEN 64=0D
+#endif=0D
+=0D
+enum {=0D
+	UDA_SUCCESS =3D 0x0,=0D
+	UDA_FAIL,=0D
+	UDA_ENXIO,=0D
+	UDA_ENONMEM,=0D
+	UDA_EBUSY,=0D
+	UDA_ECRC,=0D
+	UDA_EINVAL,=0D
+	UDA_EFAULT,=0D
+	UDA_ELEN,=0D
+	UDA_ECMD,=0D
+	UDA_ENODRIVER,=0D
+	UDA_EXIST,=0D
+	UDA_EOVERSTEP,=0D
+	UDA_ENOOBJ,=0D
+	UDA_EOBJ,=0D
+	UDA_ENOMATCH,=0D
+	UDA_ETIMEOUT,=0D
+=0D
+	UDA_CONTOP,=0D
+=0D
+	UDA_REBOOT =3D 0xFD,=0D
+	UDA_CANCEL =3D 0xFE,=0D
+	UDA_KILLED =3D 0xFF,=0D
+};=0D
+=0D
+#define PARAM_NEED     1=0D
+#define PARAM_NOT_NEED 0=0D
+=0D
+#define BASE_ALL 0=0D
+#define BASE_8	 8=0D
+#define BASE_10	 10=0D
+#define BASE_16	 16=0D
+=0D
+enum module_name {=0D
+	SEND_TO_NPU =3D 1,=0D
+	SEND_TO_MPU,=0D
+	SEND_TO_SM,=0D
+=0D
+	SEND_TO_HW_DRIVER,=0D
+	SEND_TO_NIC_DRIVER,=0D
+	SEND_TO_OVS_DRIVER,=0D
+	SEND_TO_ROCE_DRIVER,=0D
+	SEND_TO_TOE_DRIVER,=0D
+	SEND_TO_IWAP_DRIVER,=0D
+	SEND_TO_FC_DRIVER,=0D
+	SEND_FCOE_DRIVER,=0D
+};=0D
+=0D
+enum driver_cmd_type {=0D
+	TX_INFO =3D 1,=0D
+	Q_NUM,=0D
+	TX_WQE_INFO,=0D
+	TX_MAPPING,=0D
+	RX_INFO,=0D
+	RX_WQE_INFO,=0D
+	RX_CQE_INFO=0D
+};=0D
+=0D
+struct tool_target {=0D
+	int bus_num;=0D
+	char dev_name[MAX_DEV_LEN];=0D
+	void *pri;=0D
+};=0D
+=0D
+struct nic_tx_hw_page {=0D
+	long long phy_addr;=0D
+	long long *map_addr;=0D
+};=0D
+=0D
+struct nic_sq_info {=0D
+	unsigned short q_id;=0D
+	unsigned short pi; /**< Ring buffer queue producer point. */=0D
+	unsigned short ci; /**< Ring buffer queue consumer point. */=0D
+	unsigned short fi; /**< Ring buffer queue complete point. */=0D
+	unsigned int sq_depth;=0D
+	unsigned short sq_wqebb_size;=0D
+	unsigned short *ci_addr;=0D
+	uint64_t cla_addr;=0D
+=0D
+	struct nic_tx_hw_page doorbell;=0D
+	unsigned int page_idx;=0D
+};=0D
+=0D
+struct comm_info_l2nic_sq_ci_attr {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	uint16_t func_idx;=0D
+	uint8_t dma_attr_off;=0D
+	uint8_t pending_limit;=0D
+=0D
+	uint8_t coalescing_time;=0D
+	uint8_t int_en;=0D
+	uint16_t int_offset;=0D
+=0D
+	uint32_t l2nic_sqn;=0D
+	uint32_t rsv;=0D
+	uint64_t ci_addr;=0D
+};=0D
+=0D
+struct nic_rq_info {=0D
+	unsigned short q_id; /**< Queue id in current function, 0, 1, 2... */=0D
+=0D
+	unsigned short hw_pi; /**< Where pkt buf allocated. */=0D
+	unsigned short ci;    /**< Where hw pkt received, owned by hw. */=0D
+	unsigned short sw_pi; /**< Where driver begin receive pkt. */=0D
+	unsigned short rq_wqebb_size; /**< wqebb size, default to 32 bytes. */=0D
+=0D
+	unsigned short rq_depth;=0D
+	unsigned short buf_len; /**< 2K. */=0D
+	void *ci_wqe_page_addr; /**< For queue context init. */=0D
+	void *ci_cla_tbl_addr;=0D
+	unsigned short int_num;	  /**< RSS support should consider int_num. */=0D
+	unsigned int msix_vector; /**< For debug. */=0D
+};=0D
+=0D
+struct hinic_wqe_info {=0D
+	int q_id;=0D
+	void *slq_handle;=0D
+	uint32_t wqe_id;=0D
+	uint32_t wqebb_cnt;=0D
+};=0D
+=0D
+struct npu_cmd_st {=0D
+	uint32_t mod : 8;=0D
+	uint32_t cmd : 8;=0D
+	uint32_t ack_type : 3;=0D
+	uint32_t direct_resp : 1;=0D
+	uint32_t len : 12;=0D
+};=0D
+=0D
+struct mpu_cmd_st {=0D
+	uint32_t api_type : 8;=0D
+	uint32_t mod : 8;=0D
+	uint32_t cmd : 16;=0D
+};=0D
+=0D
+struct msg_module {=0D
+	char device_name[DEV_NAME_LEN];=0D
+	uint32_t module;=0D
+	union {=0D
+		uint32_t msg_format; /**< For driver. */=0D
+		struct npu_cmd_st npu_cmd;=0D
+		struct mpu_cmd_st mpu_cmd;=0D
+	};=0D
+	uint32_t timeout; /**< For mpu/npu cmd. */=0D
+	uint32_t func_idx;=0D
+	uint32_t buf_in_size;=0D
+	uint32_t buf_out_size;=0D
+	void *in_buf;=0D
+	void *out_buf;=0D
+	int bus_num;=0D
+	uint32_t rsvd2[5];=0D
+};=0D
+=0D
+/**=0D
+ * Convert the provided string into `uint32_t` according to the specified =
base.=0D
+ *=0D
+ * @param[in] nptr=0D
+ * The string to be converted.=0D
+ * @param[in] base=0D
+ * The base to use for conversion (e.g., 10 for decimal, 16 for hexadecima=
l).=0D
+ * @param[out] value=0D
+ * The output variable where the converted `uint32_t` value will be stored=
.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -UDA_EINVAL if the string is invalid or the value is out of range.=0D
+ */=0D
+static inline int=0D
+string_toui(const char *nptr, int base, uint32_t *value)=0D
+{=0D
+	char *endptr =3D NULL;=0D
+	long tmp_value;=0D
+=0D
+	tmp_value =3D strtol(nptr, &endptr, base);=0D
+	if ((*endptr !=3D 0) || tmp_value >=3D 0x7FFFFFFF || tmp_value < 0)=0D
+		return -UDA_EINVAL;=0D
+	*value =3D (uint32_t)tmp_value;=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+#define UDA_TRUE  1=0D
+#define UDA_FALSE 0=0D
+=0D
+/**=0D
+ * Format and append a log message to a string buffer.=0D
+ *=0D
+ * @param[out] show_str=0D
+ * The string buffer where the formatted message will be appended.=0D
+ * @param[out] show_len=0D
+ * The current length of the string in the buffer. It is updated after=0D
+ * appending.=0D
+ * @param[in] fmt=0D
+ * The format string that specifies how to format the log message.=0D
+ * @param[in] args=0D
+ * The variable arguments to be formatted according to the format string.=
=0D
+ */=0D
+static inline void=0D
+__rte_format_printf(3, 4)=0D
+hinic3_pmd_mml_log(char *show_str, int *show_len, const char *fmt, ...)=0D
+{=0D
+	va_list args;=0D
+	int ret =3D 0;=0D
+=0D
+	va_start(args, fmt);=0D
+	ret =3D vsprintf(show_str + *show_len, fmt, args);=0D
+	va_end(args);=0D
+=0D
+	if (ret > 0) {=0D
+		*show_len +=3D ret;=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR, "MML show string snprintf failed, err: %d",=0D
+			    ret);=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Get a valid target device based on the given name.=0D
+ *=0D
+ * This function checks if the device name is valid (within the length lim=
it)=0D
+ * and then stores it in the target structure. The bus number is initializ=
ed to=0D
+ * 0.=0D
+ *=0D
+ * @param[in] name=0D
+ * The device name to be validated and stored.=0D
+ * @param[out] target=0D
+ * The structure where the device name and bus number will be stored.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int tool_get_valid_target(char *name, struct tool_target *target);=0D
+=0D
+int hinic3_pmd_mml_ioctl(void *msg);=0D
+=0D
+int lib_tx_sq_info_get(struct tool_target target, struct nic_sq_info *sq_i=
nfo,=0D
+		       int sq_id);=0D
+=0D
+int lib_tx_wqe_info_get(struct tool_target target, struct nic_sq_info *sq_=
info,=0D
+			int sq_id, int wqe_id, void *nwqe, int nwqe_size);=0D
+=0D
+int lib_rx_rq_info_get(struct tool_target target, struct nic_rq_info *rq_i=
nfo,=0D
+		       int rq_id);=0D
+=0D
+int lib_rx_wqe_info_get(struct tool_target target, struct nic_rq_info *rq_=
info,=0D
+			int rq_id, int wqe_id, void *nwqe, int nwqe_size);=0D
+=0D
+int lib_rx_cqe_info_get(struct tool_target target, struct nic_rq_info *rq_=
info,=0D
+			int rq_id, int wqe_id, void *nwqe, int nwqe_size);=0D
+=0D
+int hinic3_pmd_mml_lib(const char *buf_in, uint32_t in_size, char *buf_out=
,=0D
+		       uint32_t *out_len, uint32_t max_buf_out_len);=0D
+=0D
+#endif /* _HINIC3_MML_LIB */=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_main.c b/drivers/net/hinic3/=
mml/hinic3_mml_main.c=0D
new file mode 100644=0D
index 0000000000..0b508bc1c3=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_main.c=0D
@@ -0,0 +1,167 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#include "hinic3_mml_lib.h"=0D
+#include "hinic3_mml_cmd.h"=0D
+=0D
+#define MAX_ARGC 20=0D
+=0D
+/**=0D
+ * Free all memory associated with the command adapter, including the comm=
and=0D
+ * states and command buffer.=0D
+ *=0D
+ * @param[in] adapter=0D
+ * Pointer to command adapter.=0D
+ */=0D
+static void=0D
+cmd_deinit(cmd_adapter_t *adapter)=0D
+{=0D
+	int i;=0D
+=0D
+	for (i =3D 0; i < COMMAND_MAX_MAJORS; i++) {=0D
+		if (adapter->p_major_cmd[i]) {=0D
+			if (adapter->p_major_cmd[i]->cmd_st) {=0D
+				free(adapter->p_major_cmd[i]->cmd_st);=0D
+				adapter->p_major_cmd[i]->cmd_st =3D NULL;=0D
+			}=0D
+=0D
+			free(adapter->p_major_cmd[i]);=0D
+			adapter->p_major_cmd[i] =3D NULL;=0D
+		}=0D
+	}=0D
+=0D
+	if (adapter->cmd_buf) {=0D
+		free(adapter->cmd_buf);=0D
+		adapter->cmd_buf =3D NULL;=0D
+	}=0D
+}=0D
+=0D
+static int=0D
+cmd_init(cmd_adapter_t *adapter)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D cmd_show_q_init(adapter);=0D
+	if (err !=3D 0) {=0D
+		PMD_DRV_LOG(ERR, "Init cmd show queue fail");=0D
+		return err;=0D
+	}=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+/**=0D
+ * Separate the input command string into arguments.=0D
+ *=0D
+ * @param[in] adapter=0D
+ * Pointer to command adapter.=0D
+ * @param[in] buf_in=0D
+ * The input command string.=0D
+ * @param[in] in_size=0D
+ * The size of the input command string.=0D
+ * @param[out] argv=0D
+ * The array to store separated arguments.=0D
+ *=0D
+ * @return=0D
+ * The number of arguments on success, a negative error code otherwise.=0D
+ */=0D
+static int=0D
+cmd_separate(cmd_adapter_t *adapter, const char *buf_in, uint32_t in_size,=
=0D
+	     char **argv)=0D
+{=0D
+	char *cmd_buf =3D NULL;=0D
+	char *tmp =3D NULL;=0D
+	char *saveptr =3D NULL;=0D
+	int i;=0D
+=0D
+	cmd_buf =3D calloc(1, in_size + 1);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate cmd_buf");=0D
+		return -UDA_ENONMEM;=0D
+	}=0D
+=0D
+	memcpy(cmd_buf, buf_in, in_size);=0D
+=0D
+	tmp =3D cmd_buf;=0D
+	for (i =3D 1; i < MAX_ARGC; i++) {=0D
+		argv[i] =3D strtok_r(tmp, " ", &saveptr);=0D
+		if (!argv[i])=0D
+			break;=0D
+		tmp =3D NULL;=0D
+	}=0D
+=0D
+	if (i =3D=3D MAX_ARGC) {=0D
+		PMD_DRV_LOG(ERR, "Parameters is too many");=0D
+		free(cmd_buf);=0D
+		return -UDA_FAIL;=0D
+	}=0D
+=0D
+	adapter->cmd_buf =3D cmd_buf;=0D
+	return i;=0D
+}=0D
+=0D
+/**=0D
+ * Process the input command string, parse arguments, and return the resul=
t.=0D
+ *=0D
+ * @param[in] buf_in=0D
+ * The input command string.=0D
+ * @param[in] in_size=0D
+ * The size of the input command string.=0D
+ * @param[out] buf_out=0D
+ * The output buffer to store the command result.=0D
+ * @param[out] out_len=0D
+ * The length of the output buffer.=0D
+ * @param[in] max_buf_out_len=0D
+ * The maximum size of the output buffer.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_pmd_mml_lib(const char *buf_in, uint32_t in_size, char *buf_out,=0D
+		   uint32_t *out_len, uint32_t max_buf_out_len)=0D
+{=0D
+	cmd_adapter_t *adapter =3D NULL;=0D
+	char *argv[MAX_ARGC];=0D
+	int argc;=0D
+	int err =3D -UDA_EINVAL;=0D
+=0D
+	if (!buf_in || !in_size) {=0D
+		PMD_DRV_LOG(ERR, "Invalid param, buf_in: %d, in_size: 0x%x",=0D
+			    !!buf_in, in_size);=0D
+		return err;=0D
+	}=0D
+=0D
+	if (!buf_out || max_buf_out_len < MAX_SHOW_STR_LEN) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Invalid param, buf_out: %d, max_buf_out_len: 0x%x",=0D
+			!!buf_out, max_buf_out_len);=0D
+		return err;=0D
+	}=0D
+=0D
+	adapter =3D calloc(1, sizeof(cmd_adapter_t));=0D
+	if (!adapter) {=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate cmd adapter");=0D
+		return -UDA_ENONMEM;=0D
+	}=0D
+=0D
+	err =3D cmd_init(adapter);=0D
+	if (err !=3D 0)=0D
+		goto parse_cmd_fail;=0D
+=0D
+	argc =3D cmd_separate(adapter, buf_in, in_size, argv);=0D
+	if (argc < 0) {=0D
+		err =3D -UDA_FAIL;=0D
+		goto parse_cmd_fail;=0D
+	}=0D
+=0D
+	memset(buf_out, 0, max_buf_out_len);=0D
+	command_parse(adapter, argc, argv, buf_out, out_len);=0D
+=0D
+parse_cmd_fail:=0D
+	cmd_deinit(adapter);=0D
+	free(adapter);=0D
+=0D
+	return err;=0D
+}=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_queue.c b/drivers/net/hinic3=
/mml/hinic3_mml_queue.c=0D
new file mode 100644=0D
index 0000000000..2e0c4a284b=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_queue.c=0D
@@ -0,0 +1,745 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ */=0D
+=0D
+#include "hinic3_mml_lib.h"=0D
+#include "hinic3_mml_cmd.h"=0D
+#include "hinic3_mml_queue.h"=0D
+=0D
+#define ADDR_HI_BIT 32=0D
+=0D
+/**=0D
+ * This function perform similar operations as `hinic3_pmd_mml_log`, but i=
t=0D
+ * return a code.=0D
+ *=0D
+ * @param[out] show_str=0D
+ * The string buffer where the formatted message will be appended.=0D
+ * @param[out] show_len=0D
+ * The current length of the string in the buffer. It is updated after=0D
+ * appending.=0D
+ * @param[in] fmt=0D
+ * The format string that specifies how to format the log message.=0D
+ * @param[in] args=0D
+ * The variable arguments to be formatted according to the format string.=
=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - `-UDA_EINVAL` if an error occurs during the formatting process.=0D
+ *=0D
+ * @see hinic3_pmd_mml_log=0D
+ */=0D
+static int=0D
+__rte_format_printf(3, 4)=0D
+hinic3_pmd_mml_log_ret(char *show_str, int *show_len, const char *fmt, ...=
)=0D
+{=0D
+	va_list args;=0D
+	int ret =3D 0;=0D
+=0D
+	va_start(args, fmt);=0D
+	ret =3D vsprintf(show_str + *show_len, fmt, args);=0D
+	va_end(args);=0D
+=0D
+	if (ret > 0) {=0D
+		*show_len +=3D ret;=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR, "MML show string snprintf failed, err: %d",=0D
+			    ret);=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+/**=0D
+ * Format and log the information about the RQ by appending details such a=
s=0D
+ * queue ID, ci, sw pi, RQ depth, RQ WQE buffer size, buffer length, inter=
rupt=0D
+ * number, and MSIX vector to the output buffer.=0D
+ *=0D
+ * @param[in] self=0D
+ * Pointer to major command structure.=0D
+ * @param[in] rq_info=0D
+ * The receive queue information to be displayed, which includes various=0D
+ * properties like queue ID, depth, interrupt number, etc.=0D
+ */=0D
+static void=0D
+rx_show_rq_info(major_cmd_t *self, struct nic_rq_info *rq_info)=0D
+{=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "Receive queue information:");=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "queue_id:%u",=0D
+			   rq_info->q_id);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "ci:%u",=0D
+			   rq_info->ci);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "sw_pi:%u",=0D
+			   rq_info->sw_pi);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rq_depth:%u",=0D
+			   rq_info->rq_depth);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "rq_wqebb_size:%u", rq_info->rq_wqebb_size);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "buf_len:%u",=0D
+			   rq_info->buf_len);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "int_num:%u",=0D
+			   rq_info->int_num);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "msix_vector:%u",=0D
+			   rq_info->msix_vector);=0D
+}=0D
+=0D
+static void=0D
+rx_show_wqe(major_cmd_t *self, nic_rq_wqe *wqe)=0D
+{=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "Rx buffer section information:");=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "buf_addr:0x%" PRIx64=
,=0D
+		(((uint64_t)wqe->buf_desc.pkt_buf_addr_high) << ADDR_HI_BIT) |=0D
+			wqe->buf_desc.pkt_buf_addr_low);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "buf_len:%u",=0D
+			   wqe->buf_desc.len);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd0:%u",=0D
+			   wqe->rsvd0);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "Cqe buffer section information:");=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "buf_hi:0x%" PRIx64,=
=0D
+		(((uint64_t)wqe->cqe_sect.pkt_buf_addr_high) << ADDR_HI_BIT) |=0D
+			wqe->cqe_sect.pkt_buf_addr_low);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "buf_len:%u",=0D
+			   wqe->cqe_sect.len);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd1:%u",=0D
+			   wqe->rsvd1);=0D
+}=0D
+=0D
+static void=0D
+rx_show_cqe_info(major_cmd_t *self, struct tag_l2nic_rx_cqe *wqe_cs)=0D
+{=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "Rx cqe info:");=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "cs_dw0:0x%08x",=0D
+			   wqe_cs->dw0.value);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rx_done:0x%x",=0D
+			   wqe_cs->dw0.bs.rx_done);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "bp_en:0x%x",=0D
+			   wqe_cs->dw0.bs.bp_en);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "decry_pkt:0x%x",=0D
+			   wqe_cs->dw0.bs.decry_pkt);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "flush:0x%x",=0D
+			   wqe_cs->dw0.bs.flush);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "spec_flags:0x%x",=0D
+			   wqe_cs->dw0.bs.spec_flags);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd0:0x%x",=0D
+			   wqe_cs->dw0.bs.rsvd0);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "lro_num:0x%x",=0D
+			   wqe_cs->dw0.bs.lro_num);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "checksum_err:0x%x", wqe_cs->dw0.bs.checksum_err);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "cs_dw1:0x%08x",=0D
+			   wqe_cs->dw1.value);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "length:%u",=0D
+			   wqe_cs->dw1.bs.length);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "vlan:0x%x",=0D
+			   wqe_cs->dw1.bs.vlan);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "cs_dw2:0x%08x",=0D
+			   wqe_cs->dw2.value);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rss_type:0x%x",=0D
+			   wqe_cs->dw2.bs.rss_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd0:0x%x",=0D
+			   wqe_cs->dw2.bs.rsvd0);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "vlan_offload_en:0x%x",=0D
+			   wqe_cs->dw2.bs.vlan_offload_en);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "umbcast:0x%x",=0D
+			   wqe_cs->dw2.bs.umbcast);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd1:0x%x",=0D
+			   wqe_cs->dw2.bs.rsvd1);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "pkt_types:0x%x",=0D
+			   wqe_cs->dw2.bs.pkt_types);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "rss_hash_value:0x%08x",=0D
+			   wqe_cs->dw3.bs.rss_hash_value);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "cs_dw4:0x%08x",=0D
+			   wqe_cs->dw4.value);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "cs_dw5:0x%08x",=0D
+			   wqe_cs->dw5.value);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "mac_type:0x%x",=0D
+			   wqe_cs->dw5.ovs_bs.mac_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "l3_type:0x%x",=0D
+			   wqe_cs->dw5.ovs_bs.l3_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "l4_type:0x%x",=0D
+			   wqe_cs->dw5.ovs_bs.l4_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd0:0x%x",=0D
+			   wqe_cs->dw5.ovs_bs.rsvd0);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "traffic_type:0x%x",=0D
+			   wqe_cs->dw5.ovs_bs.traffic_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "traffic_from:0x%x",=0D
+			   wqe_cs->dw5.ovs_bs.traffic_from);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "cs_dw6:0x%08x",=0D
+			   wqe_cs->dw6.value);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "localtag:0x%08x",=0D
+			   wqe_cs->dw7.ovs_bs.localtag);=0D
+}=0D
+=0D
+#define HINIC3_PMD_MML_LOG_RET(fmt, ...)                             \=0D
+	hinic3_pmd_mml_log_ret(self->show_str, &self->show_len, fmt, \=0D
+			       ##__VA_ARGS__)=0D
+=0D
+/**=0D
+ * Display help information for queue command.=0D
+ *=0D
+ * @param[in] self=0D
+ * Pointer to major command structure.=0D
+ * @param[in] argc=0D
+ * A string representing the value associated with the command option (unu=
sed_).=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+cmd_queue_help(major_cmd_t *self, __rte_unused char *argc)=0D
+{=0D
+	int ret;=0D
+	ret =3D HINIC3_PMD_MML_LOG_RET("\n") ||=0D
+	      HINIC3_PMD_MML_LOG_RET(" Usage: %s %s", self->name,=0D
+				     "-i <device> -d <tx or rx> -t <type> "=0D
+				     "-q <queue id> [-w <wqe id>]") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("\n %s", self->description) ||=0D
+	      HINIC3_PMD_MML_LOG_RET("\n Options:\n") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "-h", "--help",=0D
+				     "display this help and exit") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "-i",=0D
+				     "--device=3D<device>",=0D
+				     "device target, e.g. 08:00.0") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "-d", "--direction",=0D
+				     "tx or rx") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "  ", "", "0: tx") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "  ", "", "1: rx") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "-t", "--type", "") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "  ", "",=0D
+				     "0: queue info") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "  ", "",=0D
+				     "1: wqe info") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "  ", "",=0D
+				     "2: cqe info(only for rx)") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "-q", "--queue_id",=0D
+				     "") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("	%s, %-25s %s", "-w", "--wqe_id", "") ||=0D
+	      HINIC3_PMD_MML_LOG_RET("\n");=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+static void=0D
+tx_show_sq_info(major_cmd_t *self, struct nic_sq_info *sq_info)=0D
+{=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "Send queue information:");=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "queue_id:%u",=0D
+			   sq_info->q_id);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "pi:%u",=0D
+			   sq_info->pi);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "ci:%u",=0D
+			   sq_info->ci);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "fi:%u",=0D
+			   sq_info->fi);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "sq_depth:%u",=0D
+			   sq_info->sq_depth);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "sq_wqebb_size:%u", sq_info->sq_wqebb_size);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "cla_addr:0x%" PRIu64,=0D
+			   sq_info->cla_addr);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "doorbell phy_addr:0x%" PRId64,=0D
+			   (uintptr_t)sq_info->doorbell.phy_addr);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "page_idx:%u",=0D
+			   sq_info->page_idx);=0D
+}=0D
+=0D
+static void=0D
+tx_show_wqe(major_cmd_t *self, struct nic_tx_wqe_desc *wqe)=0D
+{=0D
+	struct nic_tx_ctrl_section *control =3D NULL;=0D
+	struct nic_tx_task_section *task =3D NULL;=0D
+	unsigned int *val =3D (unsigned int *)wqe;=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw0:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw1:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw2:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw3:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw4:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw5:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw6:0x%08x",=0D
+			   *(val++));=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "dw7:0x%08x",=0D
+			   *(val++));=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "\nWqe may analyse as follows:");=0D
+	control =3D &wqe->control;=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "\nInformation about wqe control section:");=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "ctrl_format:0x%08x", control->ctrl_format);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "owner:%u",=0D
+			   control->ctrl_sec.o);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "extended_compact:%u", control->ctrl_sec.ec);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "direct_normal:%u", control->ctrl_sec.dn);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "inline_sgl:%u",=0D
+			   control->ctrl_sec.df);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "ts_size:%u",=0D
+			   control->ctrl_sec.tss);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "bds_len:%u",=0D
+			   control->ctrl_sec.bdsl);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd:%u",=0D
+			   control->ctrl_sec.r);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "1st_buf_len:%u",=0D
+			   control->ctrl_sec.len);=0D
+=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "queue_info:0x%08x", control->queue_info);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "pri:%u",=0D
+			   control->qsf.pri);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "uc:%u",=0D
+			   control->qsf.uc);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "sctp:%u",=0D
+			   control->qsf.sctp);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "mss:%u",=0D
+			   control->qsf.mss);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "tcp_udp_cs:%u",=0D
+			   control->qsf.tcp_udp_cs);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "tso:%u",=0D
+			   control->qsf.tso);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "ufo:%u",=0D
+			   control->qsf.ufo);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "payload_offset:%u", control->qsf.payload_offset);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "pkt_type:%u",=0D
+			   control->qsf.pkt_type);=0D
+=0D
+	/* First buffer section. */=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "bd0_hi_addr:0x%08x", wqe->bd0_hi_addr);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "bd0_lo_addr:0x%08x", wqe->bd0_lo_addr);=0D
+=0D
+	/* Show the task section. */=0D
+	task =3D &wqe->task;=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "\nInformation about wqe task section:");=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "vport_id:%u",=0D
+			   task->bs2.vport_id);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "vport_type:%u",=0D
+			   task->bs2.vport_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "traffic_type:%u",=0D
+			   task->bs2.traffic_type);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+			   "secondary_port_id:%u", task->bs2.secondary_port_id);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "rsvd0:%u",=0D
+			   task->bs2.rsvd0);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "crypto_en:%u",=0D
+			   task->bs2.crypto_en);=0D
+	hinic3_pmd_mml_log(self->show_str, &self->show_len, "pkt_type:%u",=0D
+			   task->bs2.pkt_type);=0D
+}=0D
+=0D
+static int=0D
+cmd_queue_target(major_cmd_t *self, char *argc)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+	int ret;=0D
+=0D
+	if (tool_get_valid_target(argc, &show_q->target) !=3D UDA_SUCCESS) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		ret =3D snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			       "Unknown device %s.", argc);=0D
+		if (ret <=3D 0) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "snprintf queue err msg failed, ret: %d",=0D
+				    ret);=0D
+		}=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+get_queue_type(major_cmd_t *self, char *argc)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+	unsigned int num =3D 0;=0D
+=0D
+	if (string_toui(argc, BASE_10, &num) !=3D UDA_SUCCESS) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			       "Unknown queuetype %u.", num);=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+=0D
+	show_q->qobj =3D (int)num;=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+get_queue_id(major_cmd_t *self, char *argc)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+	unsigned int num =3D 0;=0D
+=0D
+	if (string_toui(argc, BASE_10, &num) !=3D UDA_SUCCESS) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Invalid queue id.");=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+=0D
+	show_q->q_id =3D (int)num;=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+get_q_wqe_id(major_cmd_t *self, char *argc)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+	unsigned int num =3D 0;=0D
+=0D
+	if (string_toui(argc, BASE_10, &num) !=3D UDA_SUCCESS) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Invalid wqe id.");=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+=0D
+	show_q->wqe_id =3D (int)num;=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+/**=0D
+ * Set direction for queue query.=0D
+ *=0D
+ * @param[in] self=0D
+ * Pointer to major command structure.=0D
+ * @param[in] argc=0D
+ * The input argument representing the direction (as a string).=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -UDA_EINVAL If the input is invalid (not a number or out of range), i=
t sets=0D
+ * an error in `err_no` and `err_str`.=0D
+ */=0D
+static int=0D
+get_direction(major_cmd_t *self, char *argc)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+	unsigned int num =3D 0;=0D
+=0D
+	if (string_toui(argc, BASE_10, &num) !=3D UDA_SUCCESS || num > 1) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Unknown mode.");=0D
+		return -UDA_EINVAL;=0D
+	}=0D
+=0D
+	show_q->direction =3D (int)num;=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+rx_param_check(major_cmd_t *self, struct cmd_show_q_st *rx_param)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+=0D
+	if (rx_param->target.bus_num =3D=3D TRGET_UNKNOWN_BUS_NUM) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Need device name.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->qobj > OBJ_CQE_INFO || show_q->qobj < OBJ_Q_INFO) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Unknown queue type.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->q_id =3D=3D -1) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Need queue id.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->qobj !=3D OBJ_Q_INFO && show_q->wqe_id =3D=3D -1) {=0D
+		self->err_no =3D -UDA_FAIL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Get cqe_info or wqe_info, must set wqeid.");=0D
+		return -UDA_FAIL;=0D
+	}=0D
+=0D
+	if (show_q->qobj =3D=3D OBJ_Q_INFO && show_q->wqe_id !=3D -1) {=0D
+		self->err_no =3D -UDA_FAIL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Get queue info, need not set wqeid.");=0D
+		return -UDA_FAIL;=0D
+	}=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static int=0D
+tx_param_check(major_cmd_t *self, struct cmd_show_q_st *tx_param)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+=0D
+	if (tx_param->target.bus_num =3D=3D TRGET_UNKNOWN_BUS_NUM) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Need device name.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->qobj > OBJ_WQE_INFO || show_q->qobj < OBJ_Q_INFO) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Unknown queue type.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->q_id =3D=3D -1) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Need queue id.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->qobj =3D=3D OBJ_WQE_INFO && show_q->wqe_id =3D=3D -1) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Get wqe_info, must set wqeid.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	if (show_q->qobj !=3D OBJ_WQE_INFO && show_q->wqe_id !=3D -1) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Get queue info, need not set wqeid.");=0D
+		return self->err_no;=0D
+	}=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
+=0D
+static void=0D
+cmd_tx_execute(major_cmd_t *self)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+	int ret;=0D
+	struct nic_sq_info sq_info =3D {0};=0D
+	struct nic_tx_wqe_desc nwqe;=0D
+=0D
+	if (tx_param_check(self, show_q) !=3D UDA_SUCCESS)=0D
+		return;=0D
+=0D
+	if (show_q->qobj =3D=3D OBJ_Q_INFO || show_q->qobj =3D=3D OBJ_WQE_INFO) {=
=0D
+		ret =3D lib_tx_sq_info_get(show_q->target, (void *)&sq_info,=0D
+					 show_q->q_id);=0D
+		if (ret !=3D UDA_SUCCESS) {=0D
+			self->err_no =3D ret;=0D
+			snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+				     "Get tx sq_info failed.");=0D
+			return;=0D
+		}=0D
+=0D
+		if (show_q->qobj =3D=3D OBJ_Q_INFO) {=0D
+			tx_show_sq_info(self, &sq_info);=0D
+			return;=0D
+		}=0D
+=0D
+		if (show_q->wqe_id >=3D (int)sq_info.sq_depth) {=0D
+			self->err_no =3D -UDA_EINVAL;=0D
+			snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+				     "Max wqe id is %u.", sq_info.sq_depth - 1);=0D
+			return;=0D
+		}=0D
+=0D
+		memset(&nwqe, 0, sizeof(nwqe));=0D
+		ret =3D lib_tx_wqe_info_get(show_q->target, &sq_info,=0D
+					  show_q->q_id, show_q->wqe_id,=0D
+					  (void *)&nwqe, sizeof(nwqe));=0D
+		if (ret !=3D UDA_SUCCESS) {=0D
+			self->err_no =3D ret;=0D
+			snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+				     "Get tx wqe_info failed.");=0D
+			return;=0D
+		}=0D
+=0D
+		tx_show_wqe(self, &nwqe);=0D
+		return;=0D
+	}=0D
+}=0D
+=0D
+static void=0D
+cmd_rx_execute(major_cmd_t *self)=0D
+{=0D
+	int ret;=0D
+	struct nic_rq_info rq_info =3D {0};=0D
+	struct tag_l2nic_rx_cqe cqe;=0D
+	nic_rq_wqe wqe;=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+=0D
+	if (rx_param_check(self, show_q) !=3D UDA_SUCCESS)=0D
+		return;=0D
+=0D
+	ret =3D lib_rx_rq_info_get(show_q->target, &rq_info, show_q->q_id);=0D
+	if (ret !=3D UDA_SUCCESS) {=0D
+		self->err_no =3D ret;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Get rx rq_info failed.");=0D
+		return;=0D
+	}=0D
+=0D
+	if (show_q->qobj =3D=3D OBJ_Q_INFO) {=0D
+		rx_show_rq_info(self, &rq_info);=0D
+		return;=0D
+	}=0D
+=0D
+	if ((uint32_t)show_q->wqe_id >=3D rq_info.rq_depth) {=0D
+		self->err_no =3D -UDA_EINVAL;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Max wqe id is %u.", rq_info.rq_depth - 1);=0D
+		return;=0D
+	}=0D
+=0D
+	if (show_q->qobj =3D=3D OBJ_WQE_INFO) {=0D
+		memset(&wqe, 0, sizeof(wqe));=0D
+		ret =3D lib_rx_wqe_info_get(show_q->target, &rq_info,=0D
+					  show_q->q_id, show_q->wqe_id,=0D
+					  (void *)&wqe, sizeof(wqe));=0D
+		if (ret !=3D UDA_SUCCESS) {=0D
+			self->err_no =3D ret;=0D
+			snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+				     "Get rx wqe_info failed.");=0D
+			return;=0D
+		}=0D
+=0D
+		rx_show_wqe(self, &wqe);=0D
+		return;=0D
+	}=0D
+=0D
+	/* OBJ_CQE_INFO */=0D
+	memset(&cqe, 0, sizeof(cqe));=0D
+	ret =3D lib_rx_cqe_info_get(show_q->target, &rq_info, show_q->q_id,=0D
+				  show_q->wqe_id, (void *)&cqe, sizeof(cqe));=0D
+	if (ret !=3D UDA_SUCCESS) {=0D
+		self->err_no =3D ret;=0D
+		snprintf(self->err_str, COMMANDER_ERR_MAX_STRING - 1,=0D
+			     "Get rx cqe_info failed.");=0D
+		return;=0D
+	}=0D
+=0D
+	rx_show_cqe_info(self, &cqe);=0D
+}=0D
+=0D
+/**=0D
+ * Execute the NIC queue query command based on the direction.=0D
+ *=0D
+ * @param[in] self=0D
+ * Pointer to major command structure.=0D
+ */=0D
+static void=0D
+cmd_nic_queue_execute(major_cmd_t *self)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D self->cmd_st;=0D
+=0D
+	if (show_q->direction =3D=3D -1) {=0D
+		hinic3_pmd_mml_log(self->show_str, &self->show_len,=0D
+				   "Need -d parameter.");=0D
+		return;=0D
+	}=0D
+=0D
+	if (show_q->direction =3D=3D 0)=0D
+		cmd_tx_execute(self);=0D
+	else=0D
+		cmd_rx_execute(self);=0D
+}=0D
+=0D
+/**=0D
+ * Initialize and register the queue query command.=0D
+ *=0D
+ * @param[in] adapter=0D
+ * The command adapter, which holds the registered commands and their stat=
es.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -UDA_ENONMEM if memory allocation fail or an error occur.=0D
+ */=0D
+int=0D
+cmd_show_q_init(cmd_adapter_t *adapter)=0D
+{=0D
+	struct cmd_show_q_st *show_q =3D NULL;=0D
+	major_cmd_t *show_q_cmd;=0D
+=0D
+	show_q_cmd =3D calloc(1, sizeof(*show_q_cmd));=0D
+	if (!show_q_cmd) {=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate queue cmd");=0D
+		return -UDA_ENONMEM;=0D
+	}=0D
+=0D
+	snprintf(show_q_cmd->name, MAX_NAME_LEN - 1, "%s", "nic_queue");=0D
+	snprintf(show_q_cmd->description,=0D
+		MAX_DES_LEN - 1, "%s",=0D
+		"Query the rx/tx queue information of a specified pci_addr");=0D
+=0D
+	show_q_cmd->option_count =3D 0;=0D
+	show_q_cmd->execute =3D cmd_nic_queue_execute;=0D
+=0D
+	show_q =3D calloc(1, sizeof(*show_q));=0D
+	if (!show_q) {=0D
+		free(show_q_cmd);=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate show queue");=0D
+		return -UDA_ENONMEM;=0D
+	}=0D
+=0D
+	show_q->qobj =3D -1;=0D
+	show_q->q_id =3D -1;=0D
+	show_q->wqe_id =3D -1;=0D
+	show_q->direction =3D -1;=0D
+=0D
+	show_q_cmd->cmd_st =3D show_q;=0D
+=0D
+	tool_target_init(&show_q->target.bus_num, show_q->target.dev_name,=0D
+			 MAX_DEV_LEN);=0D
+=0D
+	major_command_option(show_q_cmd, "-h", "--help", PARAM_NOT_NEED,=0D
+			     cmd_queue_help);=0D
+	major_command_option(show_q_cmd, "-i", "--device", PARAM_NEED,=0D
+			     cmd_queue_target);=0D
+	major_command_option(show_q_cmd, "-t", "--type", PARAM_NEED,=0D
+			     get_queue_type);=0D
+	major_command_option(show_q_cmd, "-q", "--queue_id", PARAM_NEED,=0D
+			     get_queue_id);=0D
+	major_command_option(show_q_cmd, "-w", "--wqe_id", PARAM_NEED,=0D
+			     get_q_wqe_id);=0D
+	major_command_option(show_q_cmd, "-d", "--direction", PARAM_NEED,=0D
+			     get_direction);=0D
+=0D
+	major_command_register(adapter, show_q_cmd);=0D
+=0D
+	return UDA_SUCCESS;=0D
+}=0D
diff --git a/drivers/net/hinic3/mml/hinic3_mml_queue.h b/drivers/net/hinic3=
/mml/hinic3_mml_queue.h=0D
new file mode 100644=0D
index 0000000000..61b91fb115=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/hinic3_mml_queue.h=0D
@@ -0,0 +1,256 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+ * Description   : hinic3 mml for queue=0D
+ */=0D
+=0D
+#ifndef _HINIC3_MML_QUEUE=0D
+#define _HINIC3_MML_QUEUE=0D
+=0D
+#define OBJ_Q_INFO   0=0D
+#define OBJ_WQE_INFO 1=0D
+#define OBJ_CQE_INFO 2=0D
+=0D
+/* TX. */=0D
+struct nic_tx_ctrl_section {=0D
+	union {=0D
+		struct {=0D
+			unsigned int len : 18;=0D
+			unsigned int r : 1;=0D
+			unsigned int bdsl : 8;=0D
+			unsigned int tss : 1;=0D
+			unsigned int df : 1;=0D
+			unsigned int dn : 1;=0D
+			unsigned int ec : 1;=0D
+			unsigned int o : 1;=0D
+		} ctrl_sec;=0D
+		unsigned int ctrl_format;=0D
+	};=0D
+	union {=0D
+		struct {=0D
+			unsigned int pkt_type : 2;=0D
+			unsigned int payload_offset : 8;=0D
+			unsigned int ufo : 1;=0D
+			unsigned int tso : 1;=0D
+			unsigned int tcp_udp_cs : 1;=0D
+			unsigned int mss : 14;=0D
+			unsigned int sctp : 1;=0D
+			unsigned int uc : 1;=0D
+			unsigned int pri : 3;=0D
+		} qsf;=0D
+		unsigned int queue_info;=0D
+	};=0D
+};=0D
+=0D
+struct nic_tx_task_section {=0D
+	unsigned int dw0;=0D
+	unsigned int dw1;=0D
+=0D
+	/* dw2. */=0D
+	union {=0D
+		struct {=0D
+			/*=0D
+			 * When TX direct, output bond id;=0D
+			 * when RX direct, output function id.=0D
+			 */=0D
+			unsigned int vport_id : 12;=0D
+			unsigned int vport_type : 4;=0D
+			unsigned int traffic_type : 6;=0D
+			/*=0D
+			 * Only used in TX direct, ctrl pkt(LACP\LLDP) output=0D
+			 * port id.=0D
+			 */=0D
+			unsigned int secondary_port_id : 2;=0D
+			unsigned int rsvd0 : 6;=0D
+			unsigned int crypto_en : 1;=0D
+			unsigned int pkt_type : 1;=0D
+		} bs2;=0D
+		unsigned int dw2;=0D
+	};=0D
+=0D
+	unsigned int dw3;=0D
+};=0D
+=0D
+struct nic_tx_sge {=0D
+	union {=0D
+		struct {=0D
+			unsigned int length : 31; /**< SGE length. */=0D
+			unsigned int rsvd : 1;=0D
+		} bs0;=0D
+		unsigned int dw0;=0D
+	};=0D
+=0D
+	union {=0D
+		struct {=0D
+			/* Key or unused. */=0D
+			unsigned int key : 30;=0D
+			/* 0:normal, 1:pointer to next SGE. */=0D
+			unsigned int extension : 1;=0D
+			/* 0:list, 1:last. */=0D
+			unsigned int list : 1;=0D
+		} bs1;=0D
+		unsigned int dw1;=0D
+	};=0D
+=0D
+	unsigned int dma_addr_high;=0D
+	unsigned int dma_addr_low;=0D
+};=0D
+=0D
+struct nic_tx_wqe_desc {=0D
+	struct nic_tx_ctrl_section control;=0D
+	struct nic_tx_task_section task;=0D
+	unsigned int bd0_hi_addr;=0D
+	unsigned int bd0_lo_addr;=0D
+};=0D
+=0D
+/* RX. */=0D
+typedef struct tag_l2nic_rx_cqe {=0D
+	union {=0D
+		struct {=0D
+			unsigned int checksum_err : 16;=0D
+			unsigned int lro_num : 8;=0D
+			unsigned int rsvd0 : 1;=0D
+			unsigned int spec_flags : 3;=0D
+			unsigned int flush : 1;=0D
+			unsigned int decry_pkt : 1;=0D
+			unsigned int bp_en : 1;=0D
+			unsigned int rx_done : 1;=0D
+		} bs;=0D
+		unsigned int value;=0D
+	} dw0;=0D
+=0D
+	union {=0D
+		struct {=0D
+			unsigned int vlan : 16;=0D
+			unsigned int length : 16;=0D
+		} bs;=0D
+		unsigned int value;=0D
+	} dw1;=0D
+=0D
+	union {=0D
+		struct {=0D
+			unsigned int pkt_types : 12;=0D
+			unsigned int rsvd1 : 7;=0D
+			unsigned int umbcast : 2;=0D
+			unsigned int vlan_offload_en : 1;=0D
+			unsigned int rsvd0 : 2;=0D
+			unsigned int rss_type : 8;=0D
+		} bs;=0D
+		unsigned int value;=0D
+	} dw2;=0D
+=0D
+	union {=0D
+		struct {=0D
+			unsigned int rss_hash_value;=0D
+		} bs;=0D
+		unsigned int value;=0D
+	} dw3;=0D
+=0D
+	/* dw4~dw7 field for nic/ovs multipexing. */=0D
+	union {=0D
+		struct { /**< For nic. */=0D
+			unsigned int tx_ts_seq : 16;=0D
+			unsigned int msg_1588_offset : 8;=0D
+			unsigned int msg_1588_type : 4;=0D
+			unsigned int rsvd : 1;=0D
+			unsigned int if_rx_ts : 1;=0D
+			unsigned int if_tx_ts : 1;=0D
+			unsigned int if_1588 : 1;=0D
+		} bs;=0D
+=0D
+		struct { /**< For ovs. */=0D
+			unsigned int reserved;=0D
+		} ovs_bs;=0D
+=0D
+		struct {=0D
+			unsigned int xid;=0D
+		} crypt_bs;=0D
+=0D
+		unsigned int value;=0D
+	} dw4;=0D
+=0D
+	union {=0D
+		struct { /**< For nic. */=0D
+			unsigned int msg_1588_ts;=0D
+		} bs;=0D
+=0D
+		struct { /**< For ovs. */=0D
+			unsigned int traffic_from : 16;=0D
+			unsigned int traffic_type : 6;=0D
+			unsigned int rsvd0 : 2;=0D
+			unsigned int l4_type : 3;=0D
+			unsigned int l3_type : 3;=0D
+			unsigned int mac_type : 2;=0D
+		} ovs_bs;=0D
+=0D
+		struct { /**< For crypt. */=0D
+			unsigned int esp_next_head : 8;=0D
+			unsigned int decrypt_status : 8;=0D
+			unsigned int rsvd : 16;=0D
+		} crypt_bs;=0D
+=0D
+		unsigned int value;=0D
+	} dw5;=0D
+=0D
+	union {=0D
+		struct { /**< For nic. */=0D
+			unsigned int lro_ts;=0D
+		} bs;=0D
+=0D
+		struct { /**< For ovs. */=0D
+			unsigned int reserved;=0D
+		} ovs_bs;=0D
+=0D
+		unsigned int value;=0D
+	} dw6;=0D
+=0D
+	union {=0D
+		struct { /**< For nic. */=0D
+			/* Data len of the first or middle pkt size. */=0D
+			unsigned int first_len : 13;=0D
+			/* Data len of the last pkt size. */=0D
+			unsigned int last_len : 13;=0D
+			/* The number of packet. */=0D
+			unsigned int pkt_num : 5;=0D
+			/* Only this bit =3D 1, other dw fields is valid. */=0D
+			unsigned int super_cqe_en : 1;=0D
+		} bs;=0D
+=0D
+		struct { /**< For ovs. */=0D
+			unsigned int localtag;=0D
+		} ovs_bs;=0D
+=0D
+		unsigned int value;=0D
+	} dw7;=0D
+} l2nic_rx_cqe_s;=0D
+=0D
+struct nic_rq_bd_sec {=0D
+	unsigned int pkt_buf_addr_high; /**< Packet buffer address high. */=0D
+	unsigned int pkt_buf_addr_low;	/**< Packet buffer address low. */=0D
+	unsigned int len;=0D
+};=0D
+=0D
+typedef struct _nic_rq_wqe {=0D
+	/* RX buffer SGE. Notes, buf_desc.len limit in bit 0~13. */=0D
+	struct nic_rq_bd_sec buf_desc;=0D
+	/* Reserved field 0 for 16B align. */=0D
+	unsigned int rsvd0;=0D
+	/*=0D
+	 * CQE buffer SGE. Notes, cqe_sect.len is in unit of 16B and limit in=0D
+	 * bit 0~4.=0D
+	 */=0D
+	struct nic_rq_bd_sec cqe_sect;=0D
+	/* Reserved field 1 for unused. */=0D
+	unsigned int rsvd1;=0D
+} nic_rq_wqe;=0D
+=0D
+/* CMD. */=0D
+struct cmd_show_q_st {=0D
+	struct tool_target target;=0D
+=0D
+	int qobj;=0D
+	int q_id;=0D
+	int wqe_id;=0D
+	int direction;=0D
+};=0D
+=0D
+#endif /* _HINIC3_MML_QUEUE */=0D
diff --git a/drivers/net/hinic3/mml/meson.build b/drivers/net/hinic3/mml/me=
son.build=0D
new file mode 100644=0D
index 0000000000..f8d2650d8d=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/mml/meson.build=0D
@@ -0,0 +1,62 @@=0D
+# SPDX-License-Identifier: BSD-3-Clause=0D
+# Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+=0D
+sources =3D files(=0D
+    'hinic3_dbg.c',=0D
+    'hinic3_mml_cmd.c',=0D
+    'hinic3_mml_ioctl.c',=0D
+    'hinic3_mml_lib.c',=0D
+    'hinic3_mml_main.c',=0D
+    'hinic3_mml_queue.c',=0D
+)=0D
+=0D
+extra_flags =3D [=0D
+    '-Wno-cast-qual',=0D
+    '-Wno-format',=0D
+    '-Wno-format-nonliteral',=0D
+    '-Wno-format-security',=0D
+    '-Wno-missing-braces',=0D
+    '-Wno-missing-field-initializers',=0D
+    '-Wno-missing-prototypes',=0D
+    '-Wno-pointer-sign',=0D
+    '-Wno-pointer-to-int-cast',=0D
+    '-Wno-sign-compare',=0D
+    '-Wno-strict-aliasing',=0D
+    '-Wno-unused-parameter',=0D
+    '-Wno-unused-value',=0D
+    '-Wno-unused-variable',=0D
+]=0D
+=0D
+# The driver runs only on arch64 machine, remove 32bit warnings=0D
+if not dpdk_conf.get('RTE_ARCH_64')=0D
+    extra_flags +=3D [=0D
+        '-Wno-int-to-pointer-cast',=0D
+        '-Wno-pointer-to-int-cast',=0D
+    ]=0D
+endif=0D
+=0D
+foreach flag: extra_flags=0D
+    if cc.has_argument(flag)=0D
+        cflags +=3D flag=0D
+    endif=0D
+endforeach=0D
+=0D
+deps +=3D ['hash']=0D
+=0D
+c_args =3D cflags=0D
+includes +=3D include_directories('../')=0D
+includes +=3D include_directories('../base/')=0D
+=0D
+mml_lib =3D static_library(=0D
+    'hinic3_mml',=0D
+    sources,=0D
+    dependencies: [=0D
+        static_rte_eal,=0D
+        static_rte_ethdev,=0D
+        static_rte_bus_pci,=0D
+        static_rte_hash,=0D
+    ],=0D
+    include_directories: includes,=0D
+    c_args: c_args,=0D
+)=0D
+mml_objs =3D mml_lib.extract_all_objects()=0D
-- =0D
2.45.1.windows.1=0D
=0D

