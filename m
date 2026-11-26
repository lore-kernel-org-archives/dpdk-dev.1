Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF75606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EE6A4064E;
	Thu, 26 Nov 2026 08:34:45 +0100 (CET)
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com
 [115.124.28.125])
 by mails.dpdk.org (Postfix) with ESMTPS id 01108402C4
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:41 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0308746-0.000694278-0.968431;
 FP=15006678127490895530|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033025068124; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1YrU_1795678477; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1YrU_1795678477 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:38 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 02/11] net/nbl: add draco HW layer
Date: Thu, 26 Nov 2026 15:34:19 +0800
Message-ID: <20261126073430.3168813-3-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement draco queue doorbell and mailbox register operations,
including mailbox queue configuration, stop and tail pointer access.
Flush posted mailbox writes with a register readback.

Add capture_bdf to read the function ID and managing PF from hardware.
Provide HW management, device mapping and cleanup for draco.

Replace the HW placeholders and keep probing disabled at channel
initialization until the channel layer is implemented.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |   1 +
 drivers/net/nbl/nbl_core.c                    |  13 +-
 drivers/net/nbl/nbl_hw/nbl_hw.h               |   4 +
 .../nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c   | 244 ++++++++++++++++++
 .../nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h   |  62 +++++
 drivers/net/nbl/nbl_include/nbl_def_hw.h      |   5 +
 6 files changed, 318 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index 58fb844..e2b1487 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -22,5 +22,6 @@ sources = files(
         'nbl_hw/nbl_resource.c',
         'nbl_hw/nbl_txrx.c',
         'nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c',
+        'nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c',
         'nbl_hw/nbl_hw_leonis/nbl_res_leonis.c',
 )
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index ae0632e..ecc681a 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -4,16 +4,6 @@
 
 #include "nbl_core.h"
 
-static int nbl_hw_init_draco_snic(void *adapter __rte_unused)
-{
-	/* Keep probing disabled until the Draco HW layer is implemented. */
-	return -ENOTSUP;
-}
-
-static void nbl_hw_remove_draco_snic(void *adapter __rte_unused)
-{
-}
-
 static int nbl_res_init_draco(void *adapter __rte_unused,
 			      struct rte_eth_dev *eth_dev __rte_unused)
 {
@@ -26,7 +16,8 @@ static void nbl_res_remove_draco(void *adapter __rte_unused)
 
 static int nbl_chan_init_draco(void *adapter __rte_unused)
 {
-	return 0;
+	/* Keep probing disabled until the Draco channel layer is implemented. */
+	return -ENOTSUP;
 }
 
 static void nbl_chan_remove_draco(void *adapter __rte_unused)
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw.h b/drivers/net/nbl/nbl_hw/nbl_hw.h
index 03500a0..d4bcde0 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw.h
+++ b/drivers/net/nbl/nbl_hw/nbl_hw.h
@@ -25,4 +25,8 @@ struct nbl_hw_mgt_leonis_snic {
 	struct nbl_hw_mgt hw_mgt;
 };
 
+struct nbl_hw_mgt_draco_snic {
+	struct nbl_hw_mgt hw_mgt;
+};
+
 #endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c
new file mode 100644
index 0000000..c1137a6
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c
@@ -0,0 +1,244 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_hw_draco_snic.h"
+
+static inline void nbl_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	rte_write32(rte_cpu_to_le_32(value), ((hw_mgt)->hw_addr + (reg)));
+}
+
+static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return rte_le_to_cpu_32(rte_read32(hw_mgt->mailbox_bar_hw_addr + reg));
+}
+
+static inline void nbl_mbx_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	rte_write32(rte_cpu_to_le_32(value), ((hw_mgt)->mailbox_bar_hw_addr + (reg)));
+	/* Flush the posted mailbox write. */
+	rte_read32(hw_mgt->mailbox_bar_hw_addr);
+}
+
+static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				 u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		*(u32 *)(data + i * sizeof(u32)) = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
+static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), *(u32 *)(data + i * sizeof(u32)));
+}
+
+static int nbl_hw_capture_bdf(void *priv, u16 *func_id, u16 *mgt_pf)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u32 value;
+
+	value = rte_le_to_cpu_32(rte_read32(hw_mgt->hw_addr +
+					 NBL_PCOMPLETER_BDF_CAPTURE_OFFSET));
+	*func_id = (value >> NBL_PCOMPLETER_FID_SHIFT) & NBL_PCOMPLETER_FID_MASK;
+	*mgt_pf = value >> NBL_PCOMPLETER_PF_SHIFT;
+	return 0;
+}
+
+static void nbl_hw_update_tail_ptr(void *priv, u16 notify_qid, u16 tail_ptr)
+{
+	nbl_wr32(priv, NBL_NOTIFY_ADDR, ((u32)tail_ptr << NBL_TAIL_PTR_OFT | (u32)notify_qid));
+}
+
+static u8 *nbl_hw_get_tail_ptr(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	return hw_mgt->hw_addr;
+}
+
+static void nbl_hw_config_mailbox_rxq(void *priv, u64 dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_rx_table qinfo_cfg_rx_table = { 0 };
+
+	qinfo_cfg_rx_table.rx_queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+
+	qinfo_cfg_rx_table.rx_queue_base_addr_l = NBL_LO_DWORD(dma_addr);
+	qinfo_cfg_rx_table.rx_queue_base_addr_h = NBL_HI_DWORD(dma_addr);
+	qinfo_cfg_rx_table.rx_queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_rx_table.rx_queue_rst = 0;
+	qinfo_cfg_rx_table.rx_queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_config_mailbox_txq(void *priv, u64 dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_tx_table qinfo_cfg_tx_table = { 0 };
+
+	qinfo_cfg_tx_table.tx_queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+
+	qinfo_cfg_tx_table.tx_queue_base_addr_l = NBL_LO_DWORD(dma_addr);
+	qinfo_cfg_tx_table.tx_queue_base_addr_h = NBL_HI_DWORD(dma_addr);
+	qinfo_cfg_tx_table.tx_queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_tx_table.tx_queue_rst = 0;
+	qinfo_cfg_tx_table.tx_queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static void nbl_hw_stop_mailbox_rxq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_rx_table qinfo_cfg_rx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_stop_mailbox_txq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_tx_table qinfo_cfg_tx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static u16 nbl_hw_get_mailbox_rx_tail_ptr(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_dbg_tbl cfg_dbg_tbl = { 0 };
+
+	nbl_hw_read_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR,
+			     (u8 *)&cfg_dbg_tbl, sizeof(cfg_dbg_tbl));
+	return cfg_dbg_tbl.rx_tail_ptr;
+}
+
+static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr, u8 txrx)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	/* local_qid 0 and 1 denote rx and tx queue respectively */
+	u32 local_qid = txrx;
+	u32 value = ((u32)tail_ptr << NBL_TAIL_PTR_OFT) | local_qid;
+
+	rte_wmb();
+	nbl_mbx_wr32(hw_mgt, NBL_MAILBOX_NOTIFY_ADDR, value);
+	rte_delay_us(NBL_NOTIFY_DELAY_MIN_TIME_FOR_REGS);
+}
+
+static const struct nbl_hw_ops nbl_hw_draco_ops = {
+	.capture_bdf			= nbl_hw_capture_bdf,
+	.update_tail_ptr		= nbl_hw_update_tail_ptr,
+	.get_tail_ptr			= nbl_hw_get_tail_ptr,
+
+	/* mailbox */
+	.config_mailbox_rxq		= nbl_hw_config_mailbox_rxq,
+	.config_mailbox_txq		= nbl_hw_config_mailbox_txq,
+	.stop_mailbox_rxq		= nbl_hw_stop_mailbox_rxq,
+	.stop_mailbox_txq		= nbl_hw_stop_mailbox_txq,
+	.get_mailbox_rx_tail_ptr	= nbl_hw_get_mailbox_rx_tail_ptr,
+	.update_mailbox_queue_tail_ptr	= nbl_hw_update_mailbox_queue_tail_ptr,
+};
+
+static int nbl_hw_setup_ops(struct nbl_hw_ops_tbl **hw_ops_tbl,
+			    struct nbl_hw_mgt_draco_snic *hw_mgt_draco_snic)
+{
+	*hw_ops_tbl = calloc(1, sizeof(**hw_ops_tbl));
+	if (!*hw_ops_tbl)
+		return -ENOMEM;
+
+	NBL_HW_OPS_TBL_TO_OPS(*hw_ops_tbl) = &nbl_hw_draco_ops;
+	NBL_HW_OPS_TBL_TO_PRIV(*hw_ops_tbl) = hw_mgt_draco_snic;
+
+	return 0;
+}
+
+static void nbl_hw_remove_ops(struct nbl_hw_ops_tbl **hw_ops_tbl)
+{
+	free(*hw_ops_tbl);
+	*hw_ops_tbl = NULL;
+}
+
+int nbl_hw_init_draco_snic(void *p)
+{
+	struct nbl_hw_mgt_draco_snic **hw_mgt_draco_snic;
+	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	int ret = 0;
+
+	hw_mgt_draco_snic = (struct nbl_hw_mgt_draco_snic **)&NBL_ADAPTER_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+
+	/* map device */
+	ret = nbl_pci_map_device(adapter);
+	if (ret)
+		return ret;
+
+	*hw_mgt_draco_snic = rte_zmalloc("nbl_hw_mgt", sizeof(**hw_mgt_draco_snic), 0);
+	if (!*hw_mgt_draco_snic) {
+		ret = -ENOMEM;
+		goto alloc_hw_mgt_failed;
+	}
+
+	hw_mgt = &(*hw_mgt_draco_snic)->hw_mgt;
+
+	hw_mgt->hw_addr = (u8 *)pci_dev->mem_resource[0].addr;
+	hw_mgt->memory_bar_pa = pci_dev->mem_resource[0].phys_addr;
+	hw_mgt->mailbox_bar_hw_addr = (u8 *)pci_dev->mem_resource[2].addr;
+
+	ret = nbl_hw_setup_ops(hw_ops_tbl, *hw_mgt_draco_snic);
+	if (ret)
+		goto setup_ops_failed;
+
+	return ret;
+
+setup_ops_failed:
+	rte_free(*hw_mgt_draco_snic);
+	*hw_mgt_draco_snic = NULL;
+alloc_hw_mgt_failed:
+	nbl_pci_unmap_device(adapter);
+	return ret;
+}
+
+void nbl_hw_remove_draco_snic(void *p)
+{
+	struct nbl_hw_mgt_draco_snic **hw_mgt_draco_snic;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	hw_mgt_draco_snic = (struct nbl_hw_mgt_draco_snic **)&adapter->core.hw_mgt;
+	hw_ops_tbl = &NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+
+	rte_free(*hw_mgt_draco_snic);
+	*hw_mgt_draco_snic = NULL;
+
+	nbl_hw_remove_ops(hw_ops_tbl);
+	nbl_pci_unmap_device(adapter);
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h
new file mode 100644
index 0000000..584d8c9
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_HW_DRACO_SNIC_H_
+#define _NBL_HW_DRACO_SNIC_H_
+
+#include "../nbl_hw.h"
+
+/* Function BAR0 BDF capture register. */
+#define NBL_PCOMPLETER_BDF_CAPTURE_OFFSET		(0x1010)
+#define NBL_PCOMPLETER_FID_SHIFT			(16)
+#define NBL_PCOMPLETER_FID_MASK			(0xfff)
+#define NBL_PCOMPLETER_PF_SHIFT			(28)
+
+/* MAILBOX BAR2 */
+#define NBL_MAILBOX_NOTIFY_ADDR			(0x00000000)
+#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	(0x10)
+#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	(0x20)
+#define NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR	(0x30)
+
+#define NBL_NOTIFY_DELAY_MIN_TIME_FOR_REGS	200
+
+/* mailbox BAR qinfo_cfg_rx_table */
+struct nbl_mailbox_qinfo_cfg_rx_table {
+	u32 rx_queue_base_addr_l;
+	u32 rx_queue_base_addr_h;
+	u32 rx_queue_size_bwind:4;
+	u32 rsv1:28;
+	u32 rx_queue_rst:1;
+	u32 rx_queue_en:1;
+	u32 rx_rdif_err:1;
+	u32 rx_ptr_err:1;
+	u32 rsv2:28;
+};
+
+/* mailbox BAR qinfo_cfg_tx_table */
+struct nbl_mailbox_qinfo_cfg_tx_table {
+	u32 tx_queue_base_addr_l;
+	u32 tx_queue_base_addr_h;
+	u32 tx_queue_size_bwind:4;
+	u32 rsv1:28;
+	u32 tx_queue_rst:1;
+	u32 tx_queue_en:1;
+	u32 tx_rdif_err:1;
+	u32 tx_ptr_err:1;
+	u32 rsv2:28;
+};
+
+/* mailbox BAR qinfo_cfg_dbg_table */
+struct nbl_mailbox_qinfo_cfg_dbg_tbl {
+	u16 rx_drop;
+	u16 rx_get;
+	u16 tx_drop;
+	u16 tx_out;
+	u16 rx_hd_ptr;
+	u16 tx_hd_ptr;
+	u16 rx_tail_ptr;
+	u16 tx_tail_ptr;
+};
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_hw.h b/drivers/net/nbl/nbl_include/nbl_def_hw.h
index 285ca98..4fd35f0 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_hw.h
@@ -11,6 +11,8 @@
 #define NBL_HW_OPS_TBL_TO_PRIV(hw_ops_tbl)	((hw_ops_tbl)->priv)
 
 struct nbl_hw_ops {
+	int (*capture_bdf)(void *priv, u16 *func_id, u16 *mgt_pf);
+
 	/* queue */
 	void (*update_tail_ptr)(void *priv, u16 notify_qid, u16 tail_ptr);
 	u8 *(*get_tail_ptr)(void *priv);
@@ -32,4 +34,7 @@ struct nbl_hw_ops_tbl {
 int nbl_hw_init_leonis_snic(void *adapter);
 void nbl_hw_remove_leonis_snic(void *adapter);
 
+int nbl_hw_init_draco_snic(void *adapter);
+void nbl_hw_remove_draco_snic(void *adapter);
+
 #endif
-- 
2.53.0

