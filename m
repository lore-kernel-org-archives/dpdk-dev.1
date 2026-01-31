Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB546D79769
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A3740656;
	Sat, 31 Jan 2026 11:06:53 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 18FF0402F2
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Rv65Nv5py1FErH257bNDZmdh4xn39LEioa1o7XNMoqo=;
 b=pYACXHyVwBZStq0zil+V0c7dkHtXzMVbvE88D3d9qeGK1SuscgPMai7xJFm2GS
 aK/+/UMiuebaSqHXdOQrDBx7yNGgUm/EpZCQqlAHT5Pu1iFphPCFEVTtoZpyH0kf
 pdqRQn2NRw6nOd/lfl15yMHFPbLQgP7j5pnUpQ2VYSO38=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S7;
 Sat, 31 Jan 2026 18:06:43 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 3/7] net/hinic3: use different callback func to split new/old
 cmdq operations
Date: Sat, 31 Jan 2026 18:05:59 +0800
Message-ID: <20260131100608.12429-4-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-1-wff_light@vip.163.com>
References: <20260131100608.12429-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S7
X-Coremail-Antispam: 1Uf129KBjvAXoWfCw13Aw1kXr13ZF4xtFWkZwb_yoW5uF18to
 WfJr4ayw1rtrWIk39Fgr4ktF4DZ34DWFn8Jws5Kr9rXas7Ja47WFnxJw4Fva47XayrA3W7
 ZFWxJ3Z2q3sxGw1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUro7KDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhP6BWl91DNIIQAA3A
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

From: Feifei Wang <wangfeifei40@huawei.com>

For new SPx series NIC with enhance cmdq, it send control message to
hardware tile in NIC(htn), this is different from previous SPx NIC, which
send control message to software tile in NIC(stn).

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  50 ++----
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  82 +++++----
 drivers/net/hinic3/hinic3_ethdev.c            |  16 +-
 drivers/net/hinic3/hinic3_nic_io.h            | 122 +++++++++++++
 drivers/net/hinic3/hinic3_rx.c                |   3 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 163 ++++++++++++++++++
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  55 ++++++
 drivers/net/hinic3/htn_adapt/meson.build      |   7 +
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 147 ++++++++++++++++
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  38 ++++
 drivers/net/hinic3/stn_adapt/meson.build      |   7 +
 11 files changed, 616 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
 create mode 100644 drivers/net/hinic3/htn_adapt/meson.build
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
 create mode 100644 drivers/net/hinic3/stn_adapt/meson.build

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 0bee1ae3fc..f12a2aedee 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -11,6 +11,7 @@
 #include "hinic3_mbox.h"
 #include "hinic3_nic_cfg.h"
 #include "hinic3_wq.h"
+#include "hinic3_nic_io.h"
 
 struct vf_msg_handler {
 	uint16_t cmd;
@@ -439,6 +440,7 @@ int
 hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 {
 	struct hinic3_vport_state en_state;
+	struct hinic3_nic_dev *nic_dev = (struct hinic3_nic_dev*)hwdev->dev_handle;
 	uint16_t out_size = sizeof(en_state);
 	int err;
 
@@ -448,6 +450,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 	memset(&en_state, 0, sizeof(en_state));
 	en_state.func_id = hinic3_global_func_id(hwdev);
 	en_state.state = enable ? 1 : 0;
+	en_state.num_qps = nic_dev->num_rqs;
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,
@@ -1156,13 +1159,12 @@ hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, uint8_t *key, uint16_t key_s
 }
 
 int
-hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev,
-			 uint32_t *indir_table, uint32_t indir_table_size)
+hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table)
 {
 	struct hinic3_cmd_buf *cmd_buf = NULL;
-	uint16_t *indir_tbl = NULL;
+	struct hinic3_nic_dev *nic_dev = NULL;
+	uint8_t cmd;
 	int err;
-	uint32_t i;
 
 	if (!hwdev || !indir_table)
 		return -EINVAL;
@@ -1174,31 +1176,28 @@ hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev,
 	}
 
 	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl);
-	err = hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC,
-				      HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,
-				      cmd_buf, cmd_buf, 0);
+	nic_dev = (struct hinic3_nic_dev *)hwdev->dev_handle;
+
+	cmd = nic_dev->cmdq_ops->prepare_cmd_buf_get_rss_indir_table(nic_dev, cmd_buf);
+	err = hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, cmd_buf, 0);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Get rss indir table failed");
 		hinic3_free_cmd_buf(cmd_buf);
 		return err;
 	}
 
-	indir_tbl = (uint16_t *)cmd_buf->buf;
-	for (i = 0; i < indir_table_size; i++)
-		indir_table[i] = *(indir_tbl + i);
+	nic_dev->cmdq_ops->cmd_buf_to_rss_indir_table(cmd_buf,indir_table);
 
 	hinic3_free_cmd_buf(cmd_buf);
 	return 0;
 }
 
 int
-hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table,
-			 uint32_t indir_table_size)
+hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table)
 {
-	struct nic_rss_indirect_tbl *indir_tbl = NULL;
 	struct hinic3_cmd_buf *cmd_buf = NULL;
-	uint32_t i, size;
-	uint32_t *temp = NULL;
+	struct hinic3_nic_dev *nic_dev = NULL;
+	uint8_t cmd;
 	uint64_t out_param = 0;
 	int err;
 
@@ -1211,22 +1210,9 @@ hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table
 		return -ENOMEM;
 	}
 
-	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl);
-	indir_tbl = (struct nic_rss_indirect_tbl *)cmd_buf->buf;
-	memset(indir_tbl, 0, sizeof(*indir_tbl));
-
-	for (i = 0; i < indir_table_size; i++)
-		indir_tbl->entry[i] = (uint16_t)(*(indir_table + i));
-
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);
-	size = sizeof(indir_tbl->entry) / sizeof(uint16_t);
-	temp = (uint32_t *)indir_tbl->entry;
-	for (i = 0; i < size; i++)
-		temp[i] = rte_cpu_to_be_32(temp[i]);
-
-	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
-				      HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,
-				      cmd_buf, &out_param, 0);
+	nic_dev = (struct hinic3_nic_dev *)hwdev->dev_handle;
+	cmd = nic_dev->cmdq_ops->prepare_cmd_buf_set_rss_indir_table(nic_dev, indir_table, cmd_buf);
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, &out_param, 0);
 	if (err || out_param != 0) {
 		PMD_DRV_LOG(ERR, "Set rss indir table failed");
 		err = -EFAULT;
@@ -1474,7 +1460,7 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 		return -EIO;
 	}
 
-	*cos_id = vf_dcb.state.default_cos;
+	*cos_id = vf_dcb.state.default_cos % HINIC3_COS_NUM_MAX_HTN;
 
 	return 0;
 }
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index a88d62333d..34372a0678 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -14,16 +14,18 @@
 #define OS_VF_ID_TO_HW(os_vf_id) ((os_vf_id) + 1)
 #define HW_VF_ID_TO_OS(hw_vf_id) ((hw_vf_id) - 1)
 
-#define HINIC3_DCB_UP_MAX 0x8
+#define HINIC3_DCB_UP_MAX		0x8
 
-#define HINIC3_MAX_NUM_RQ 256
+#define HINIC3_MAX_NUM_RQ		256
 
-#define HINIC3_MAX_MTU_SIZE 9600
-#define HINIC3_MIN_MTU_SIZE 256
+#define HINIC3_MAX_MTU_SIZE		9600
+#define HINIC3_MIN_MTU_SIZE		256
 
-#define HINIC3_COS_NUM_MAX 8
+#define HINIC3_COS_NUM_MAX		8
+#define HINIC3_COS_NUM_MAX_HTN	4
 
-#define HINIC3_VLAN_TAG_SIZE 4
+
+#define HINIC3_VLAN_TAG_SIZE	4
 #define HINIC3_ETH_OVERHEAD \
 	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + HINIC3_VLAN_TAG_SIZE * 2)
 
@@ -34,28 +36,41 @@
 
 #define HINIC3_PKTLEN_TO_MTU(pktlen) (pktlen)
 
-#define HINIC3_PF_SET_VF_ALREADY 0x4
-#define HINIC3_MGMT_STATUS_EXIST 0x6
-#define CHECK_IPSU_15BIT	 0x8000
+#define HINIC3_PF_SET_VF_ALREADY		0x4
+#define HINIC3_MGMT_STATUS_EXIST		0x6
+#define CHECK_IPSU_15BIT				0x8000
 
-#define HINIC3_MGMT_STATUS_TABLE_EMPTY 0xB
-#define HINIC3_MGMT_STATUS_TABLE_FULL  0xC
+#define HINIC3_MGMT_STATUS_TABLE_EMPTY	0xB
+#define HINIC3_MGMT_STATUS_TABLE_FULL	0xC
 
-#define HINIC3_MGMT_CMD_UNSUPPORTED 0xFF
+#define HINIC3_MGMT_CMD_UNSUPPORTED		0xFF
 
-#define HINIC3_MAX_UC_MAC_ADDRS 128
-#define HINIC3_MAX_MC_MAC_ADDRS 2048
+#define HINIC3_MAX_UC_MAC_ADDRS			128
+#define HINIC3_MAX_MC_MAC_ADDRS			2048
 
-#define CAP_INFO_MAX_LEN 512
-#define VENDOR_MAX_LEN	 17
+#define CAP_INFO_MAX_LEN				512
+#define VENDOR_MAX_LEN					17
 
 /* Structures for RSS config. */
-#define HINIC3_RSS_INDIR_SIZE	   256
-#define HINIC3_RSS_INDIR_CMDQ_SIZE 128
-#define HINIC3_RSS_KEY_SIZE	   40
-#define HINIC3_RSS_ENABLE	   0x01
-#define HINIC3_RSS_DISABLE	   0x00
-#define HINIC3_INVALID_QID_BASE	   0xffff
+#define HINIC3_RSS_INDIR_SIZE			256
+#define HINIC3_RSS_INDIR_CMDQ_SIZE		128
+#define HINIC3_RSS_KEY_SIZE				40
+#define HINIC3_RSS_ENABLE				0x01
+#define HINIC3_RSS_DISABLE				0x00
+#define HINIC3_INVALID_QID_BASE			0xffff
+
+#define HINIC3_SUPPORT_FEATURE(dev, feature) \
+	((hinic3_get_driver_feature(dev) & NIC_F_##feature) != 0)
+#define HINIC3_SUPPORT_RX_HW_COMPACT_CQE(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, RX_HW_COMPACT_CQE)
+#define HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, TX_WQE_COMPACT_TASK)
+#define HINIC3_SUPPORT_VXLAN_OFFLOAD(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, VXLAN_OFFLOAD)
+#define HINIC3_SUPPORT_GENEVE_OFFLOAD(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, GENEVE_OFFLOAD)
+#define HINIC3_SUPPORT_IPXIP_OFFLOAD(dev) \
+	HINIC3_SUPPORT_FEATURE(dev, IPXIP_OFFLOAD)
 
 struct hinic3_rss_type {
 	uint8_t tcp_ipv6_ext;
@@ -312,7 +327,9 @@ struct hinic3_vport_state {
 	uint16_t func_id;
 	uint16_t rsvd1;
 	uint8_t state; /**< 0:disable, 1:enable. */
-	uint8_t rsvd2[3];
+	uint8_t num_qps;
+	uint8_t rx_compact_wqe_en;
+	uint8_t rsvd2;
 };
 
 #define MAG_CMD_PORT_DISABLE 0x0
@@ -382,7 +399,7 @@ struct hinic3_cmd_vport_stats {
 	uint32_t stats_size;
 	uint32_t rsvd1;
 	struct hinic3_vport_stats stats;
-	uint64_t rsvd2[6];
+	uint64_t rsvd2[5];
 };
 
 struct hinic3_phy_port_stats {
@@ -670,12 +687,15 @@ enum hinic3_func_tbl_cfg_bitmap {
 	FUNC_CFG_INIT,
 	FUNC_CFG_RX_BUF_SIZE,
 	FUNC_CFG_MTU,
+	FUNC_CFG_RX_COMPACT_WQE_EN, /**< Enable 8Byte WQE. */
 };
 
 struct hinic3_func_tbl_cfg {
 	uint16_t rx_wqe_buf_size;
 	uint16_t mtu;
-	uint32_t rsvd[9];
+	uint8_t rx_compact_wqe_en; /**< Enable Rx 8Byte compact WQE. */
+	uint8_t rsvd0[3];
+	uint32_t rsvd[8];
 };
 
 struct hinic3_cmd_set_func_tbl {
@@ -895,7 +915,7 @@ struct hinic3_set_fdir_ethertype_rule {
 	struct mgmt_msg_head head;
 
 	uint16_t func_id;
-	uint16_t rsvd1;
+	uint16_t index;
 	uint8_t pkt_type_en;
 	uint8_t pkt_type;
 	uint8_t qid;
@@ -1231,14 +1251,11 @@ int hinic3_rss_template_free(struct hinic3_hwdev *hwdev);
  * Device pointer to hwdev.
  * @param[in] indir_table
  * RSS indirect table.
- * @param[in] indir_table_size
- * RSS indirect table size.
  *
  * @return
  * 0 on success, non-zero on failure.
  */
-int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table,
-			     uint32_t indir_table_size);
+int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table);
 
 /**
  * Get RSS indirect table.
@@ -1247,14 +1264,11 @@ int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_t
  * Device pointer to hwdev.
  * @param[out] indir_table
  * RSS indirect table.
- * @param[in] indir_table_size
- * RSS indirect table size.
  *
  * @return
  * 0 on success, non-zero on failure.
  */
-int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table,
-			     uint32_t indir_table_size);
+int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table);
 
 /**
  * Set RSS type.
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index a5116264b0..ecdfcd5654 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -15,6 +15,8 @@
 #include "base/hinic3_hw_comm.h"
 #include "base/hinic3_nic_cfg.h"
 #include "base/hinic3_nic_event.h"
+#include "htn_adapt/hinic3_htn_cmdq.h"
+#include "stn_adapt/hinic3_stn_cmdq.h"
 #include "hinic3_nic_io.h"
 #include "hinic3_tx.h"
 #include "hinic3_rx.h"
@@ -2581,8 +2583,7 @@ hinic3_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,
-				       HINIC3_RSS_INDIR_SIZE);
+	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Get RSS retas table failed, error: %d", err);
 		return err;
@@ -2630,8 +2631,7 @@ hinic3_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,
-				       HINIC3_RSS_INDIR_SIZE);
+	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl);
 	if (err)
 		return err;
 
@@ -2652,8 +2652,7 @@ hinic3_rss_reta_update(struct rte_eth_dev *dev,
 		}
 	}
 
-	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl,
-				       HINIC3_RSS_INDIR_SIZE);
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl);
 	if (err)
 		PMD_DRV_LOG(ERR, "Set RSS reta table failed");
 
@@ -3391,6 +3390,11 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto get_cap_fail;
 	}
 
+	if (!(nic_dev->feature_cap & NIC_F_HTN_CMDQ))
+		nic_dev->cmdq_ops = hinic3_cmdq_get_stn_ops();
+	else
+		nic_dev->cmdq_ops = hinic3_cmdq_get_htn_ops();
+
 	err = hinic3_init_sw_rxtxqs(nic_dev);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
index db5802e4b7..697e781bd0 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -6,6 +6,7 @@
 #define _HINIC3_NIC_IO_H_
 
 #include "hinic3_ethdev.h"
+#include "base/hinic3_cmdq.h"
 
 #define HINIC3_SQ_WQEBB_SHIFT 4
 #define HINIC3_RQ_WQEBB_SHIFT 3
@@ -25,6 +26,13 @@
 #define HINIC3_CI_PADDR(base_paddr, q_id) \
 	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
 
+#define HINIC3_Q_CTXT_MAX	((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))
+
+#define SQ_CTXT_SIZE(num_sqs)	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) \
+									+ (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
+#define RQ_CTXT_SIZE(num_rqs)	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) \
+									+ (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
+
 enum hinic3_rq_wqe_type {
 	HINIC3_COMPACT_RQ_WQE,
 	HINIC3_NORMAL_RQ_WQE,
@@ -37,12 +45,111 @@ enum hinic3_queue_type {
 	HINIC3_MAX_QUEUE_TYPE,
 };
 
+/* Prepare cmd to clean tso/lro space */
+typedef uint8_t  (*prepare_cmd_buf_clean_tso_lro_space_t)(struct hinic3_nic_dev *nic_dev,
+													   struct hinic3_cmd_buf *cmd_buf,
+													   enum hinic3_qp_ctxt_type ctxt_type);
+/* Prepare cmd to store RQ and TQ ctxt */
+typedef uint8_t  (*prepare_cmd_buf_qp_context_multi_store_t)(struct hinic3_nic_dev *nic_dev,
+														   struct hinic3_cmd_buf *cmd_buf,
+														   enum hinic3_qp_ctxt_type ctxt_type,
+														   uint16_t start_qid, uint16_t max_ctxts);
+/* Prepare cmd to modify vlan tag */
+typedef uint8_t  (*prepare_cmd_buf_modify_svlan_t)(struct hinic3_cmd_buf *cmd_buf, uint16_t func_id,
+												   uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode);
+/* Prepare cmd to set RSS indir table */
+typedef uint8_t  (*prepare_cmd_buf_set_rss_indir_table_t)(struct hinic3_nic_dev *nic_dev,
+														  const uint32_t *indir_table,
+														  struct hinic3_cmd_buf *cmd_buf);
+/* Prepare cmd to get RSS indir table */
+typedef uint8_t  (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_nic_dev *nic_dev,
+														  struct hinic3_cmd_buf *cmd_buf);
+/* Configure RSS indir table */
+typedef void     (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_buf *cmd_buf, uint32_t *indir_table);
+
+struct hinic3_nic_cmdq_ops {
+	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_space
+	prepare_cmd_buf_qp_context_multi_store_t	prepare_cmd_buf_qp_context_multi_store
+	prepare_cmd_buf_modify_svlan_t				prepare_cmd_buf_modify_svlan
+	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_table
+	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_table
+	cmd_buf_to_rss_indir_table_t				cmd_buf_to_rss_indir_table
+};
+
 /* Doorbell info. */
 struct hinic3_db {
 	uint32_t db_info;
 	uint32_t pi_hi;
 };
 
+struct hinic3_sq_ctxt {
+	uint32_t ci_pi;
+	uint32_t drop_mode_sp;
+	uint32_t wq_pfn_hi_owner;
+	uint32_t wq_pfn_lo;
+
+	uint32_t rsvd0;
+	uint32_t pkt_drop_thd;
+	uint32_t global_sq_id;
+	uint32_t vlan_ceq_attr;
+
+	uint32_t pref_cache;
+	uint32_t pref_ci_owner;
+	uint32_t pref_wq_pfn_hi_ci;
+	uint32_t pref_wq_pfn_lo;
+
+	uint32_t rsvd8;
+	uint32_t rsvd9;
+	uint32_t wq_block_pfn_hi;
+	uint32_t wq_block_pfn_lo;
+};
+
+struct hinic3_rq_ctxt {
+	uint32_t ci_pi;
+	uint32_t ceq_attr;
+	uint32_t wq_pfn_hi_type_owner;
+	uint32_t wq_pfn_lo;
+
+	uint32_t rsvd[3];
+	uint32_t cqe_sge_len;
+
+	uint32_t pref_cache;
+	uint32_t pref_ci_owner;
+	uint32_t pref_wq_pfn_hi_ci;
+	uint32_t pref_wq_pfn_lo;
+
+	uint32_t pi_paddr_hi;
+	uint32_t pi_paddr_lo;
+	uint32_t wq_block_pfn_hi;
+	uint32_t wq_block_pfn_lo;
+};
+
+struct hinic3_rq_cqe_ctx {
+	struct mgmt_msg_head msg_head;
+
+	uint8_t cqe_type;
+	uint8_t rq_id;
+	uint8_t threshold_cqe_num;
+	uint8_t rsvd1;
+
+	uint16_t msix_entry_idx;
+	uint16_t rsvd2;
+
+	uint32_t ci_addr_hi;
+	uint32_t ci_addr_lo;
+
+	uint16_t timer_loop;
+	uint16_t rsvd3;
+};
+
+struct hinic3_rq_enable {
+	struct mgmt_msg_head msg_head;
+
+	uint32_t rq_id;
+	uint8_t rq_enable;
+	uint8_t rsvd[3];
+};
+
 #define DB_INFO_QID_SHIFT	 0
 #define DB_INFO_NON_FILTER_SHIFT 22
 #define DB_INFO_CFLAG_SHIFT	 23
@@ -142,6 +249,21 @@ int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
  */
 void hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev);
 
+/**
+ * Get cmdq ops software tile NIC(stn) supported.
+ *
+ * @return
+ * Pointer to ops.
+ */
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void);
+
+/**
+ * Get cmdq ops hardware tile NIC(htn) supported.
+ *
+ * @retval Pointer to ops.
+ */
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void);
+
 /**
  * Update driver feature capabilities.
  *
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index e8e417b474..3d5f4e4524 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -407,8 +407,7 @@ hinic3_refill_indir_rqid(struct hinic3_rxq *rxq)
 	/* Build indir tbl according to the number of rss queue. */
 	hinic3_fill_indir_tbl(nic_dev, indir_tbl);
 
-	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl,
-				       HINIC3_RSS_INDIR_SIZE);
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			"Set indirect table failed, eth_dev:%s, queue_idx:%d",
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
new file mode 100644
index 0000000000..5c94a8b683
--- /dev/null
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#include "hinic3_compat.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_cmd.h"
+#include "hinic3_hwif.h"
+#include "hinic3_htn_cmdq.h"
+
+static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *nic_dev,
+					      struct hinic3_cmd_buf *cmd_buf,
+					      enum hinic3_qp_ctxt_type ctxt_type)
+{
+	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
+
+	ctxt_block = cmd_buf->buf;
+	ctxt_block->cmdq_hdr.num_queues = nic_dev->max_sqs;
+	ctxt_block->cmdq_hdr.queue_type = ctxt_type;
+	ctxt_block->cmdq_hdr.start_qid = 0;
+	ctxt_block->cmdq_hdr.dest_func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));
+
+	cmd_buf->size = sizeof(*ctxt_block);
+	return (uint8_t)HINIC3_HTN_CMD_TSO_LRO_SPACE_CLEAN;
+}
+
+static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,
+				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,
+				   uint16_t q_id, uint16_t func_id)
+{
+	qp_ctxt_hdr->queue_type = ctxt_type;
+	qp_ctxt_hdr->num_queues = num_queues;
+	qp_ctxt_hdr->start_qid = q_id;
+	qp_ctxt_hdr->dest_func_id = func_id;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
+}
+
+static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic_dev,
+						 struct hinic3_cmd_buf *cmd_buf,
+						 enum hinic3_qp_ctxt_type ctxt_type,
+						 uint16_t start_qid, uint16_t max_ctxts)
+{
+	struct hinic3_qp_ctxt_block *qp_ctxt_block = NULL;
+	uint16_t func_id;
+	uint16_t i;
+
+	qp_ctxt_block = cmd_buf->buf;
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	qp_prepare_cmdq_header(&qp_ctxt_block->cmdq_hdr, ctxt_type,
+			       max_ctxts, start_qid, func_id);
+
+	for (i = 0; i < max_ctxts; i++) {
+		if (ctxt_type == HINIC3_QP_CTXT_TYPE_RQ)
+			hinic3_rq_prepare_ctxt(nic_dev->rxqs[start_qid + i],
+					       &qp_ctxt_block->rq_ctxt[i]);
+		else
+			hinic3_sq_prepare_ctxt(nic_dev->txqs[start_qid + i],
+					       start_qid + i,
+					       &qp_ctxt_block->sq_ctxt[i]);
+	}
+
+	if (ctxt_type == HINIC3_QP_CTXT_TYPE_RQ)
+		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+	else
+		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+
+	return (uint8_t)HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_ST;
+}
+
+static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf,
+				       uint16_t func_id, uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)
+{
+	struct hinic3_vlan_ctx *vlan_ctx = NULL;
+
+	cmd_buf->size = sizeof(struct hinic3_vlan_ctx);
+	vlan_ctx = (struct hinic3_vlan_ctx *)cmd_buf->buf;
+
+	vlan_ctx->dest_func_id = func_id;
+	vlan_ctx->start_qid = q_id;
+	vlan_ctx->vlan_tag = vlan_tag;
+	vlan_ctx->vlan_sel = 0; /* TPID0 in IPSU */
+	vlan_ctx->vlan_mode = vlan_mode;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));
+	return (uint8_t)HINIC3_HTN_CMD_SVLAN_MODIFY;
+}
+
+static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_dev,
+					      const uint32_t *indir_table,
+					      struct hinic3_cmd_buf *cmd_buf)
+{
+	uint32_t i;
+	uint8_t *indir_tbl = NULL;
+
+	indir_tbl = (uint8_t *)cmd_buf->buf + sizeof(struct hinic3_rss_cmd_header);
+	cmd_buf->size = sizeof(struct hinic3_rss_cmd_header) + HINIC3_RSS_INDIR_SIZE;
+	memset(indir_tbl, 0, HINIC3_RSS_INDIR_SIZE);
+
+	prepare_rss_indir_table_cmd_header(nic_dev, cmd_buf);
+
+	for (i = 0; i < HINIC3_RSS_INDIR_SIZE; i++) {
+		indir_tbl[i] = (uint8_t)(*(indir_table + i));
+	}
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(indir_tbl, HINIC3_RSS_INDIR_SIZE);
+
+	return (uint8_t)HINIC3_HTN_CMD_SET_RSS_INDIR_TABLE;
+}
+
+static void prepare_rss_indir_table_cmd_header(struct hinic3_nic_dev *nic_dev,
+					       struct hinic3_cmd_buf *cmd_buf)
+{
+	struct hinic3_rss_cmd_header *header = cmd_buf->buf;
+
+	header->dest_func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(header, sizeof(*header));
+}
+
+static uint8_t prepare_cmd_buf_get_rss_indir_table(struct hinic3_nic_dev *nic_dev,
+					      struct hinic3_cmd_buf *cmd_buf)
+{
+	memset(cmd_buf->buf, 0, cmd_buf->size);
+	prepare_rss_indir_table_cmd_header(nic_dev, cmd_buf);
+
+	return (uint8_t)HINIC3_HTN_CMD_GET_RSS_INDIR_TABLE;
+}
+
+static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uint32_t *indir_table)
+{
+	uint32_t i;
+	uint8_t *indir_tbl = NULL;
+
+	indir_tbl = (uint8_t *)cmd_buf->buf;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_be32_to_cpu(cmd_buf->buf, HINIC3_RSS_INDIR_SIZE);
+	for (i = 0; i < HINIC3_RSS_INDIR_SIZE; i++) {
+		indir_table[i] = *(indir_tbl + i);
+	}
+}
+
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void)
+{
+	static struct hinic3_nic_cmdq_ops cmdq_ops = {
+		.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
+		.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
+		.prepare_cmd_buf_modify_svlan =           prepare_cmd_buf_modify_svlan,
+		.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
+		.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
+		.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+	};
+
+	return &cmdq_ops;
+}
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
new file mode 100644
index 0000000000..d4d5a733df
--- /dev/null
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_HTN_CMDQ_H_
+#define _HINIC3_HTN_CMDQ_H_
+
+#include "hinic3_nic_io.h"
+
+struct hinic3_qp_ctxt_header {
+	u32 rsvd[2];
+	u16 num_queues;
+	u16 queue_type;
+	u16 start_qid;
+	u16 dest_func_id;
+};
+
+struct hinic3_clean_queue_ctxt {
+	struct hinic3_qp_ctxt_header cmdq_hdr;
+};
+
+struct hinic3_qp_ctxt_block {
+	struct hinic3_qp_ctxt_header   cmdq_hdr;
+	union {
+		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];
+		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];
+	};
+};
+
+struct hinic3_rss_cmd_header {
+	u32 rsv[3];
+	u16 rsv1;
+	u16 dest_func_id;
+};
+
+/* NIC HTN CMD */
+enum hinic3_htn_cmd {
+	HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_ST = 0x20,
+	HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_LD,
+	HINIC3_HTN_CMD_TSO_LRO_SPACE_CLEAN,
+	HINIC3_HTN_CMD_SVLAN_MODIFY,
+	HINIC3_HTN_CMD_SET_RSS_INDIR_TABLE,
+	HINIC3_HTN_CMD_GET_RSS_INDIR_TABLE
+};
+
+struct hinic3_vlan_ctx {
+	u32 rsv[2];
+	u16 vlan_tag;
+	u8 vlan_sel;
+	u8 vlan_mode;
+	u16 start_qid;
+	u16 dest_func_id;
+};
+
+#endif /* _HINIC3_HTN_CMDQ_H_ */
diff --git a/drivers/net/hinic3/htn_adapt/meson.build b/drivers/net/hinic3/htn_adapt/meson.build
new file mode 100644
index 0000000000..17f7ad09e3
--- /dev/null
+++ b/drivers/net/hinic3/htn_adapt/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Huawei Technologies Co., Ltd
+
+includes += include_directories('.')
+sources += files(
+        'hinic3_htn_cmdq.c',
+)
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
new file mode 100644
index 0000000000..cf50b06beb
--- /dev/null
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#include "hinic3_compat.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_cmd.h"
+#include "hinic3_hwif.h"
+#include "hinic3_stn_cmdq.h"
+
+static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *nic_dev,
+					      struct hinic3_cmd_buf *cmd_buf,
+					      enum hinic3_qp_ctxt_type ctxt_type)
+{
+	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
+
+	ctxt_block = cmd_buf->buf;
+	ctxt_block->cmdq_hdr.num_queues = nic_dev->max_sqs;
+	ctxt_block->cmdq_hdr.queue_type = ctxt_type;
+	ctxt_block->cmdq_hdr.start_qid = 0;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));
+
+	cmd_buf->size = sizeof(*ctxt_block);
+	return (uint8_t)HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT;
+}
+
+static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,
+				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,
+				   uint16_t q_id)
+{
+	qp_ctxt_hdr->queue_type = ctxt_type;
+	qp_ctxt_hdr->num_queues = num_queues;
+	qp_ctxt_hdr->start_qid = q_id;
+	qp_ctxt_hdr->rsvd = 0;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
+}
+
+static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_dev *nic_dev,
+						 struct hinic3_cmd_buf *cmd_buf,
+						 enum hinic3_qp_ctxt_type ctxt_type,
+						 uint16_t start_qid, uint16_t max_ctxts)
+{
+	struct hinic3_qp_ctxt_block *qp_ctxt_block = NULL;
+	uint16_t i;
+
+	qp_ctxt_block = cmd_buf->buf;
+
+	qp_prepare_cmdq_header(&qp_ctxt_block->cmdq_hdr, ctxt_type,
+				   max_ctxts, start_qid);
+
+	for (i = 0; i < max_ctxts; i++) {
+		if (ctxt_type == HINIC3_QP_CTXT_TYPE_RQ)
+			hinic3_rq_prepare_ctxt(nic_dev->rxqs[start_qid + i],
+					       &qp_ctxt_block->rq_ctxt[i]);
+		else
+			hinic3_sq_prepare_ctxt(nic_dev->txqs[start_qid + i], start_qid + i,
+					       &qp_ctxt_block->sq_ctxt[i]);
+	}
+
+	if (ctxt_type == HINIC3_QP_CTXT_TYPE_RQ)
+		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+	else
+		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+
+	return (uint8_t)HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX;
+}
+
+static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf,
+				       uint16_t func_id, uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)
+{
+	struct hinic3_vlan_ctx *vlan_ctx = NULL;
+
+	cmd_buf->size = sizeof(struct hinic3_vlan_ctx);
+	vlan_ctx = (struct hinic3_vlan_ctx *)cmd_buf->buf;
+
+	vlan_ctx->func_id = func_id;
+	vlan_ctx->qid = q_id;
+	vlan_ctx->vlan_id = vlan_tag;
+	vlan_ctx->vlan_sel = 0; /* TPID0 in IPSU */
+	vlan_ctx->vlan_mode = vlan_mode;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));
+	return (uint8_t)HINIC3_UCODE_CMD_MODIFY_VLAN_CTX;
+}
+
+static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_dev,
+					      const uint32_t *indir_table,
+					      struct hinic3_cmd_buf *cmd_buf)
+{
+	uint32_t i, size;
+	uint32_t *temp = NULL;
+	struct nic_rss_indirect_tbl *indir_tbl = NULL;
+
+	indir_tbl = (struct nic_rss_indirect_tbl *)cmd_buf->buf;
+	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl);
+	memset(indir_tbl, 0, sizeof(*indir_tbl));
+
+	for (i = 0; i < HINIC3_RSS_INDIR_SIZE; i++) {
+		indir_tbl->entry[i] = (uint16_t)(*(indir_table + i));
+	}
+	size = sizeof(indir_tbl->entry) / sizeof(uint32_t);
+	temp = (uint32_t *)indir_tbl->entry;
+	for (i = 0; i < size; i++) {
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
+		temp[i] = cpu_to_be32(temp[i]);
+	}
+	return (uint8_t)HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE;
+}
+
+static uint8_t prepare_cmd_buf_get_rss_indir_table(struct hinic3_nic_dev *nic_dev,
+					      struct hinic3_cmd_buf *cmd_buf)
+{
+	(void)nic_dev;
+	memset(cmd_buf->buf, 0, cmd_buf->size);
+
+	return (uint8_t)HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE;
+}
+
+static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uint32_t *indir_table)
+{
+	uint32_t i;
+	uint16_t *indir_tbl = NULL;
+
+	indir_tbl = (uint16_t *)cmd_buf->buf;
+	for (i = 0; i < HINIC3_RSS_INDIR_SIZE; i++) {
+		indir_table[i] = *(indir_tbl + i);
+	}
+}
+
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void)
+{
+	static struct hinic3_nic_cmdq_ops cmdq_ops = {
+		.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
+		.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
+		.prepare_cmd_buf_modify_svlan =           prepare_cmd_buf_modify_svlan,
+		.prepare_cmd_buf_set_rss_indir_table = 	  prepare_cmd_buf_set_rss_indir_table,
+		.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
+		.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+	};
+
+	return &cmdq_ops;
+}
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
new file mode 100644
index 0000000000..f8d26e9397
--- /dev/null
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_STN_CMDQ_H_
+#define _HINIC3_STN_CMDQ_H_
+
+#include "hinic3_nic_io.h"
+
+struct hinic3_qp_ctxt_header {
+	uint16_t num_queues;
+	uint16_t queue_type;
+	uint16_t start_qid;
+	uint16_t rsvd;
+};
+
+struct hinic3_clean_queue_ctxt {
+	struct hinic3_qp_ctxt_header cmdq_hdr;
+	uint32_t rsvd;
+};
+
+struct hinic3_qp_ctxt_block {
+	struct hinic3_qp_ctxt_header   cmdq_hdr;
+	union {
+		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];
+		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];
+	};
+};
+
+struct hinic3_vlan_ctx {
+	uint32_t func_id;
+	uint32_t qid; /* if qid = 0xFFFF, config for all queues */
+	uint32_t vlan_id;
+	uint32_t vlan_mode;
+	uint32_t vlan_sel;
+};
+
+#endif /* _HINIC3_STN_CMDQ_H_ */
diff --git a/drivers/net/hinic3/stn_adapt/meson.build b/drivers/net/hinic3/stn_adapt/meson.build
new file mode 100644
index 0000000000..99f7f66ab4
--- /dev/null
+++ b/drivers/net/hinic3/stn_adapt/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Huawei Technologies Co., Ltd
+
+includes += include_directories('.')
+sources += files(
+        'hinic3_stn_cmdq.c',
+)
-- 
2.45.1.windows.1

