Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91846FCD0BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 06:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 129F4402B3;
	Wed, 18 Mar 2026 07:22:08 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 459AE402A0
 for <dev@dpdk.org>; Wed, 18 Mar 2026 07:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9zdDS7+kUrqpHQeVdHi0HkA5P3dToLPx3ypYSQwFLbo=;
 b=pdy9cW0SNiMSH88gfiH1xjYZWwbKDrIs8l7ISA7EFLcFg6fa/Vh59cHV0Ub5hI
 3DCltfWsojvxi96jt8PVWBLHg2sz61RFsBHirwuKn5JMWChYez/GAB9GGqNr8TVs
 tawFtAE8PTc3rmY3pCpRJRBv9PJkqSsLQFbFW2X6BmVPI=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAn2mxjRLpp3_HsAg--.63347S7;
 Wed, 18 Mar 2026 14:22:04 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V4 3/7] net/hinic3: use different callback func to split new/old
 cmdq operations
Date: Wed, 18 Mar 2026 14:20:55 +0800
Message-ID: <20260318062105.1972-4-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260318062105.1972-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260318062105.1972-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgAn2mxjRLpp3_HsAg--.63347S7
X-Coremail-Antispam: 1Uf129KBjvAXoWfCw13Aw45tF4fWFWftF43Jrb_yoW5uryxKo
 WfJr4Syw18trWIk39Igr4ktF4DZ34DXFn8Jws5Kr9rXas7Ja47WFnxJw4Fva43XayrA3Zr
 ZFW7J3ZFq39xGw1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUro7KDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMww9R2m6RIyW0QAA3Z
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

From: Feifei Wang <wangfeifei40@huawei.com>=0D

For new SPx series NIC with enhance cmdq, it send control message to=0D
hardware tile in NIC(htn), this is different from previous SPx NIC, which=0D
send control message to software tile in NIC(stn).=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  50 ++----=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  79 +++++----=0D
 drivers/net/hinic3/hinic3_ethdev.c            |  16 +-=0D
 drivers/net/hinic3/hinic3_nic_io.h            | 130 ++++++++++++++=0D
 drivers/net/hinic3/hinic3_rx.c                |   3 +-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 161 ++++++++++++++++++=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  55 ++++++=0D
 drivers/net/hinic3/htn_adapt/meson.build      |   7 +=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 145 ++++++++++++++++=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  38 +++++=0D
 drivers/net/hinic3/stn_adapt/meson.build      |   7 +=0D
 11 files changed, 618 insertions(+), 73 deletions(-)=0D
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
 create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
 create mode 100644 drivers/net/hinic3/htn_adapt/meson.build=0D
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
 create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
 create mode 100644 drivers/net/hinic3/stn_adapt/meson.build=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index ac44da46c2..22caac0457 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -11,6 +11,7 @@=0D
 #include "hinic3_mbox.h"=0D
 #include "hinic3_nic_cfg.h"=0D
 #include "hinic3_wq.h"=0D
+#include "hinic3_nic_io.h"=0D
 =0D
 struct vf_msg_handler {=0D
 	uint16_t cmd;=0D
@@ -442,6 +443,7 @@ int=0D
 hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)=0D
 {=0D
 	struct hinic3_vport_state en_state;=0D
+	struct hinic3_nic_dev *nic_dev =3D hwdev->dev_handle;=0D
 	uint16_t out_size =3D sizeof(en_state);=0D
 	int err;=0D
 =0D
@@ -451,6 +453,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, boo=
l enable)=0D
 	memset(&en_state, 0, sizeof(en_state));=0D
 	en_state.func_id =3D hinic3_global_func_id(hwdev);=0D
 	en_state.state =3D enable ? 1 : 0;=0D
+	en_state.num_qps =3D nic_dev->num_rqs;=0D
 =0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,=0D
@@ -1159,13 +1162,12 @@ hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev,=
 uint8_t *key, uint16_t key_s=0D
 }=0D
 =0D
 int=0D
-hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev,=0D
-			 uint32_t *indir_table, uint32_t indir_table_size)=0D
+hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table=
)=0D
 {=0D
 	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
-	uint16_t *indir_tbl =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	uint8_t cmd;=0D
 	int err;=0D
-	uint32_t i;=0D
 =0D
 	if (!hwdev || !indir_table)=0D
 		return -EINVAL;=0D
@@ -1177,31 +1179,28 @@ hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev=
,=0D
 	}=0D
 =0D
 	cmd_buf->size =3D sizeof(struct nic_rss_indirect_tbl);=0D
-	err =3D hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC,=0D
-				      HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,=0D
-				      cmd_buf, cmd_buf, 0);=0D
+	nic_dev =3D (struct hinic3_nic_dev *)hwdev->dev_handle;=0D
+=0D
+	cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_get_rss_indir_table(nic_dev, c=
md_buf);=0D
+	err =3D hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, cm=
d_buf, 0);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Get rss indir table failed");=0D
 		hinic3_free_cmd_buf(cmd_buf);=0D
 		return err;=0D
 	}=0D
 =0D
-	indir_tbl =3D (uint16_t *)cmd_buf->buf;=0D
-	for (i =3D 0; i < indir_table_size; i++)=0D
-		indir_table[i] =3D *(indir_tbl + i);=0D
+	nic_dev->cmdq_ops->cmd_buf_to_rss_indir_table(cmd_buf, indir_table);=0D
 =0D
 	hinic3_free_cmd_buf(cmd_buf);=0D
 	return 0;=0D
 }=0D
 =0D
 int=0D
-hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir=
_table,=0D
-			 uint32_t indir_table_size)=0D
+hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir=
_table)=0D
 {=0D
-	struct nic_rss_indirect_tbl *indir_tbl =3D NULL;=0D
 	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
-	uint32_t i, size;=0D
-	uint32_t *temp =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	uint8_t cmd;=0D
 	uint64_t out_param =3D 0;=0D
 	int err;=0D
 =0D
@@ -1214,22 +1213,9 @@ hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev,=
 const uint32_t *indir_table=0D
 		return -ENOMEM;=0D
 	}=0D
 =0D
-	cmd_buf->size =3D sizeof(struct nic_rss_indirect_tbl);=0D
-	indir_tbl =3D (struct nic_rss_indirect_tbl *)cmd_buf->buf;=0D
-	memset(indir_tbl, 0, sizeof(*indir_tbl));=0D
-=0D
-	for (i =3D 0; i < indir_table_size; i++)=0D
-		indir_tbl->entry[i] =3D (uint16_t)(*(indir_table + i));=0D
-=0D
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
-	size =3D sizeof(indir_tbl->entry) / sizeof(uint16_t);=0D
-	temp =3D (uint32_t *)indir_tbl->entry;=0D
-	for (i =3D 0; i < size; i++)=0D
-		temp[i] =3D rte_cpu_to_be_32(temp[i]);=0D
-=0D
-	err =3D hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,=0D
-				      HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,=0D
-				      cmd_buf, &out_param, 0);=0D
+	nic_dev =3D (struct hinic3_nic_dev *)hwdev->dev_handle;=0D
+	cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_set_rss_indir_table(nic_dev, i=
ndir_table, cmd_buf);=0D
+	err =3D hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, &o=
ut_param, 0);=0D
 	if (err || out_param !=3D 0) {=0D
 		PMD_DRV_LOG(ERR, "Set rss indir table failed");=0D
 		err =3D -EFAULT;=0D
@@ -1477,7 +1463,7 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev,=
 uint8_t *cos_id)=0D
 		return -EIO;=0D
 	}=0D
 =0D
-	*cos_id =3D vf_dcb.state.default_cos;=0D
+	*cos_id =3D vf_dcb.state.default_cos % HINIC3_COS_NUM_MAX_HTN;=0D
 =0D
 	return 0;=0D
 }=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index a88d62333d..06d5bc7d1b 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -14,16 +14,17 @@=0D
 #define OS_VF_ID_TO_HW(os_vf_id) ((os_vf_id) + 1)=0D
 #define HW_VF_ID_TO_OS(hw_vf_id) ((hw_vf_id) - 1)=0D
 =0D
-#define HINIC3_DCB_UP_MAX 0x8=0D
+#define HINIC3_DCB_UP_MAX		0x8=0D
 =0D
-#define HINIC3_MAX_NUM_RQ 256=0D
+#define HINIC3_MAX_NUM_RQ		256=0D
 =0D
-#define HINIC3_MAX_MTU_SIZE 9600=0D
-#define HINIC3_MIN_MTU_SIZE 256=0D
+#define HINIC3_MAX_MTU_SIZE		9600=0D
+#define HINIC3_MIN_MTU_SIZE		256=0D
 =0D
-#define HINIC3_COS_NUM_MAX 8=0D
+#define HINIC3_COS_NUM_MAX		8=0D
+#define HINIC3_COS_NUM_MAX_HTN		4=0D
 =0D
-#define HINIC3_VLAN_TAG_SIZE 4=0D
+#define HINIC3_VLAN_TAG_SIZE	4=0D
 #define HINIC3_ETH_OVERHEAD \=0D
 	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + HINIC3_VLAN_TAG_SIZE * 2)=0D
 =0D
@@ -34,28 +35,41 @@=0D
 =0D
 #define HINIC3_PKTLEN_TO_MTU(pktlen) (pktlen)=0D
 =0D
-#define HINIC3_PF_SET_VF_ALREADY 0x4=0D
-#define HINIC3_MGMT_STATUS_EXIST 0x6=0D
-#define CHECK_IPSU_15BIT	 0x8000=0D
+#define HINIC3_PF_SET_VF_ALREADY		0x4=0D
+#define HINIC3_MGMT_STATUS_EXIST		0x6=0D
+#define CHECK_IPSU_15BIT				0x8000=0D
 =0D
-#define HINIC3_MGMT_STATUS_TABLE_EMPTY 0xB=0D
-#define HINIC3_MGMT_STATUS_TABLE_FULL  0xC=0D
+#define HINIC3_MGMT_STATUS_TABLE_EMPTY	0xB=0D
+#define HINIC3_MGMT_STATUS_TABLE_FULL	0xC=0D
 =0D
-#define HINIC3_MGMT_CMD_UNSUPPORTED 0xFF=0D
+#define HINIC3_MGMT_CMD_UNSUPPORTED		0xFF=0D
 =0D
-#define HINIC3_MAX_UC_MAC_ADDRS 128=0D
-#define HINIC3_MAX_MC_MAC_ADDRS 2048=0D
+#define HINIC3_MAX_UC_MAC_ADDRS			128=0D
+#define HINIC3_MAX_MC_MAC_ADDRS			2048=0D
 =0D
-#define CAP_INFO_MAX_LEN 512=0D
-#define VENDOR_MAX_LEN	 17=0D
+#define CAP_INFO_MAX_LEN		512=0D
+#define VENDOR_MAX_LEN			17=0D
 =0D
 /* Structures for RSS config. */=0D
-#define HINIC3_RSS_INDIR_SIZE	   256=0D
-#define HINIC3_RSS_INDIR_CMDQ_SIZE 128=0D
-#define HINIC3_RSS_KEY_SIZE	   40=0D
-#define HINIC3_RSS_ENABLE	   0x01=0D
-#define HINIC3_RSS_DISABLE	   0x00=0D
-#define HINIC3_INVALID_QID_BASE	   0xffff=0D
+#define HINIC3_RSS_INDIR_SIZE			256=0D
+#define HINIC3_RSS_INDIR_CMDQ_SIZE		128=0D
+#define HINIC3_RSS_KEY_SIZE			40=0D
+#define HINIC3_RSS_ENABLE			0x01=0D
+#define HINIC3_RSS_DISABLE			0x00=0D
+#define HINIC3_INVALID_QID_BASE			0xffff=0D
+=0D
+#define HINIC3_SUPPORT_FEATURE(dev, feature) \=0D
+	((hinic3_get_driver_feature(dev) & NIC_F_##feature) !=3D 0)=0D
+#define HINIC3_SUPPORT_RX_HW_COMPACT_CQE(dev) \=0D
+	HINIC3_SUPPORT_FEATURE(dev, RX_HW_COMPACT_CQE)=0D
+#define HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(dev) \=0D
+	HINIC3_SUPPORT_FEATURE(dev, TX_WQE_COMPACT_TASK)=0D
+#define HINIC3_SUPPORT_VXLAN_OFFLOAD(dev) \=0D
+	HINIC3_SUPPORT_FEATURE(dev, VXLAN_OFFLOAD)=0D
+#define HINIC3_SUPPORT_GENEVE_OFFLOAD(dev) \=0D
+	HINIC3_SUPPORT_FEATURE(dev, GENEVE_OFFLOAD)=0D
+#define HINIC3_SUPPORT_IPXIP_OFFLOAD(dev) \=0D
+	HINIC3_SUPPORT_FEATURE(dev, IPXIP_OFFLOAD)=0D
 =0D
 struct hinic3_rss_type {=0D
 	uint8_t tcp_ipv6_ext;=0D
@@ -312,7 +326,9 @@ struct hinic3_vport_state {=0D
 	uint16_t func_id;=0D
 	uint16_t rsvd1;=0D
 	uint8_t state; /**< 0:disable, 1:enable. */=0D
-	uint8_t rsvd2[3];=0D
+	uint8_t num_qps;=0D
+	uint8_t rx_compact_wqe_en;=0D
+	uint8_t rsvd2;=0D
 };=0D
 =0D
 #define MAG_CMD_PORT_DISABLE 0x0=0D
@@ -670,12 +686,15 @@ enum hinic3_func_tbl_cfg_bitmap {=0D
 	FUNC_CFG_INIT,=0D
 	FUNC_CFG_RX_BUF_SIZE,=0D
 	FUNC_CFG_MTU,=0D
+	FUNC_CFG_RX_COMPACT_WQE_EN, /**< Enable 8Byte WQE. */=0D
 };=0D
 =0D
 struct hinic3_func_tbl_cfg {=0D
 	uint16_t rx_wqe_buf_size;=0D
 	uint16_t mtu;=0D
-	uint32_t rsvd[9];=0D
+	uint8_t rx_compact_wqe_en; /**< Enable Rx 8Byte compact WQE. */=0D
+	uint8_t rsvd0[3];=0D
+	uint32_t rsvd1[8];=0D
 };=0D
 =0D
 struct hinic3_cmd_set_func_tbl {=0D
@@ -895,7 +914,7 @@ struct hinic3_set_fdir_ethertype_rule {=0D
 	struct mgmt_msg_head head;=0D
 =0D
 	uint16_t func_id;=0D
-	uint16_t rsvd1;=0D
+	uint16_t index;=0D
 	uint8_t pkt_type_en;=0D
 	uint8_t pkt_type;=0D
 	uint8_t qid;=0D
@@ -1231,14 +1250,11 @@ int hinic3_rss_template_free(struct hinic3_hwdev *h=
wdev);=0D
  * Device pointer to hwdev.=0D
  * @param[in] indir_table=0D
  * RSS indirect table.=0D
- * @param[in] indir_table_size=0D
- * RSS indirect table size.=0D
  *=0D
  * @return=0D
  * 0 on success, non-zero on failure.=0D
  */=0D
-int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *i=
ndir_table,=0D
-			     uint32_t indir_table_size);=0D
+int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *i=
ndir_table);=0D
 =0D
 /**=0D
  * Get RSS indirect table.=0D
@@ -1247,14 +1263,11 @@ int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *h=
wdev, const uint32_t *indir_t=0D
  * Device pointer to hwdev.=0D
  * @param[out] indir_table=0D
  * RSS indirect table.=0D
- * @param[in] indir_table_size=0D
- * RSS indirect table size.=0D
  *=0D
  * @return=0D
  * 0 on success, non-zero on failure.=0D
  */=0D
-int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_t=
able,=0D
-			     uint32_t indir_table_size);=0D
+int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_t=
able);=0D
 =0D
 /**=0D
  * Set RSS type.=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index da2d6722d2..780b17414a 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -15,6 +15,8 @@=0D
 #include "base/hinic3_hw_comm.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "base/hinic3_nic_event.h"=0D
+#include "htn_adapt/hinic3_htn_cmdq.h"=0D
+#include "stn_adapt/hinic3_stn_cmdq.h"=0D
 #include "hinic3_nic_io.h"=0D
 #include "hinic3_tx.h"=0D
 #include "hinic3_rx.h"=0D
@@ -2577,8 +2579,7 @@ hinic3_rss_reta_query(struct rte_eth_dev *dev,=0D
 		return -EINVAL;=0D
 	}=0D
 =0D
-	err =3D hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,=0D
-				       HINIC3_RSS_INDIR_SIZE);=0D
+	err =3D hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Get RSS retas table failed, error: %d", err);=0D
 		return err;=0D
@@ -2626,8 +2627,7 @@ hinic3_rss_reta_update(struct rte_eth_dev *dev,=0D
 		return -EINVAL;=0D
 	}=0D
 =0D
-	err =3D hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,=0D
-				       HINIC3_RSS_INDIR_SIZE);=0D
+	err =3D hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl);=0D
 	if (err)=0D
 		return err;=0D
 =0D
@@ -2648,8 +2648,7 @@ hinic3_rss_reta_update(struct rte_eth_dev *dev,=0D
 		}=0D
 	}=0D
 =0D
-	err =3D hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl,=0D
-				       HINIC3_RSS_INDIR_SIZE);=0D
+	err =3D hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl);=0D
 	if (err)=0D
 		PMD_DRV_LOG(ERR, "Set RSS reta table failed");=0D
 =0D
@@ -3387,6 +3386,11 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto get_cap_fail;=0D
 	}=0D
 =0D
+	if (!(nic_dev->feature_cap & NIC_F_HTN_CMDQ))=0D
+		nic_dev->cmdq_ops =3D hinic3_cmdq_get_stn_ops();=0D
+	else=0D
+		nic_dev->cmdq_ops =3D hinic3_cmdq_get_htn_ops();=0D
+=0D
 	err =3D hinic3_init_sw_rxtxqs(nic_dev);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3=
_nic_io.h=0D
index db5802e4b7..c8e690981b 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.h=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.h=0D
@@ -6,6 +6,7 @@=0D
 #define _HINIC3_NIC_IO_H_=0D
 =0D
 #include "hinic3_ethdev.h"=0D
+#include "base/hinic3_cmdq.h"=0D
 =0D
 #define HINIC3_SQ_WQEBB_SHIFT 4=0D
 #define HINIC3_RQ_WQEBB_SHIFT 3=0D
@@ -25,6 +26,13 @@=0D
 #define HINIC3_CI_PADDR(base_paddr, q_id) \=0D
 	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)=0D
 =0D
+#define HINIC3_Q_CTXT_MAX ((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PK=
TMBUF_HEADROOM) / 64))=0D
+=0D
+#define SQ_CTXT_SIZE(num_sqs) ((uint16_t)(sizeof(struct hinic3_qp_ctxt_hea=
der) \=0D
+					  + (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
+#define RQ_CTXT_SIZE(num_rqs) ((uint16_t)(sizeof(struct hinic3_qp_ctxt_hea=
der) \=0D
+					  + (num_rqs) * sizeof(struct hinic3_rq_ctxt)))=0D
+=0D
 enum hinic3_rq_wqe_type {=0D
 	HINIC3_COMPACT_RQ_WQE,=0D
 	HINIC3_NORMAL_RQ_WQE,=0D
@@ -37,12 +45,119 @@ enum hinic3_queue_type {=0D
 	HINIC3_MAX_QUEUE_TYPE,=0D
 };=0D
 =0D
+enum hinic3_qp_ctxt_type {=0D
+	HINIC3_QP_CTXT_TYPE_SQ,=0D
+	HINIC3_QP_CTXT_TYPE_RQ,=0D
+};=0D
+=0D
+/* Prepare cmd to clean tso/lro space */=0D
+typedef uint8_t  (*prepare_cmd_buf_clean_tso_lro_space_t)(struct hinic3_ni=
c_dev *nic_dev,=0D
+							  struct hinic3_cmd_buf *cmd_buf,=0D
+							  enum hinic3_qp_ctxt_type ctxt_type);=0D
+/* Prepare cmd to store RQ and TQ ctxt */=0D
+typedef uint8_t  (*prepare_cmd_buf_qp_context_multi_store_t)(struct hinic3=
_nic_dev *nic_dev,=0D
+							     struct hinic3_cmd_buf *cmd_buf,=0D
+							     enum hinic3_qp_ctxt_type ctxt_type,=0D
+							     uint16_t start_qid,=0D
+							     uint16_t max_ctxts);=0D
+/* Prepare cmd to modify vlan tag */=0D
+typedef uint8_t  (*prepare_cmd_buf_modify_svlan_t)(struct hinic3_cmd_buf *=
cmd_buf, uint16_t func_id,=0D
+						   uint16_t vlan_tag, uint16_t q_id,=0D
+						   uint8_t vlan_mode);=0D
+/* Prepare cmd to set RSS indir table */=0D
+typedef uint8_t  (*prepare_cmd_buf_set_rss_indir_table_t)(struct hinic3_ni=
c_dev *nic_dev,=0D
+							  const uint32_t *indir_table,=0D
+							  struct hinic3_cmd_buf *cmd_buf);=0D
+/* Prepare cmd to get RSS indir table */=0D
+typedef uint8_t  (*prepare_cmd_buf_get_rss_indir_table_t)(struct hinic3_ni=
c_dev *nic_dev,=0D
+							  struct hinic3_cmd_buf *cmd_buf);=0D
+/* Configure RSS indir table */=0D
+typedef void     (*cmd_buf_to_rss_indir_table_t)(const struct hinic3_cmd_b=
uf *cmd_buf,=0D
+						 uint32_t *indir_table);=0D
+=0D
+struct hinic3_nic_cmdq_ops {=0D
+	prepare_cmd_buf_clean_tso_lro_space_t		prepare_cmd_buf_clean_tso_lro_spac=
e;=0D
+	prepare_cmd_buf_qp_context_multi_store_t	prepare_cmd_buf_qp_context_multi=
_store;=0D
+	prepare_cmd_buf_modify_svlan_t			prepare_cmd_buf_modify_svlan;=0D
+	prepare_cmd_buf_set_rss_indir_table_t		prepare_cmd_buf_set_rss_indir_tabl=
e;=0D
+	prepare_cmd_buf_get_rss_indir_table_t		prepare_cmd_buf_get_rss_indir_tabl=
e;=0D
+	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;=0D
+};=0D
+=0D
 /* Doorbell info. */=0D
 struct hinic3_db {=0D
 	uint32_t db_info;=0D
 	uint32_t pi_hi;=0D
 };=0D
 =0D
+struct hinic3_sq_ctxt {=0D
+	uint32_t ci_pi;=0D
+	uint32_t drop_mode_sp;=0D
+	uint32_t wq_pfn_hi_owner;=0D
+	uint32_t wq_pfn_lo;=0D
+=0D
+	uint32_t rsvd0;=0D
+	uint32_t pkt_drop_thd;=0D
+	uint32_t global_sq_id;=0D
+	uint32_t vlan_ceq_attr;=0D
+=0D
+	uint32_t pref_cache;=0D
+	uint32_t pref_ci_owner;=0D
+	uint32_t pref_wq_pfn_hi_ci;=0D
+	uint32_t pref_wq_pfn_lo;=0D
+=0D
+	uint32_t rsvd8;=0D
+	uint32_t rsvd9;=0D
+	uint32_t wq_block_pfn_hi;=0D
+	uint32_t wq_block_pfn_lo;=0D
+};=0D
+=0D
+struct hinic3_rq_ctxt {=0D
+	uint32_t ci_pi;=0D
+	uint32_t ceq_attr;=0D
+	uint32_t wq_pfn_hi_type_owner;=0D
+	uint32_t wq_pfn_lo;=0D
+=0D
+	uint32_t rsvd[3];=0D
+	uint32_t cqe_sge_len;=0D
+=0D
+	uint32_t pref_cache;=0D
+	uint32_t pref_ci_owner;=0D
+	uint32_t pref_wq_pfn_hi_ci;=0D
+	uint32_t pref_wq_pfn_lo;=0D
+=0D
+	uint32_t pi_paddr_hi;=0D
+	uint32_t pi_paddr_lo;=0D
+	uint32_t wq_block_pfn_hi;=0D
+	uint32_t wq_block_pfn_lo;=0D
+};=0D
+=0D
+struct hinic3_rq_cqe_ctx {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	uint8_t cqe_type;=0D
+	uint8_t rq_id;=0D
+	uint8_t threshold_cqe_num;=0D
+	uint8_t rsvd1;=0D
+=0D
+	uint16_t msix_entry_idx;=0D
+	uint16_t rsvd2;=0D
+=0D
+	uint32_t ci_addr_hi;=0D
+	uint32_t ci_addr_lo;=0D
+=0D
+	uint16_t timer_loop;=0D
+	uint16_t rsvd3;=0D
+};=0D
+=0D
+struct hinic3_rq_enable {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	uint32_t rq_id;=0D
+	uint8_t rq_enable;=0D
+	uint8_t rsvd[3];=0D
+};=0D
+=0D
 #define DB_INFO_QID_SHIFT	 0=0D
 #define DB_INFO_NON_FILTER_SHIFT 22=0D
 #define DB_INFO_CFLAG_SHIFT	 23=0D
@@ -142,6 +257,21 @@ int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_de=
v);=0D
  */=0D
 void hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev);=0D
 =0D
+/**=0D
+ * Get cmdq ops software tile NIC(stn) supported.=0D
+ *=0D
+ * @return=0D
+ * Pointer to ops.=0D
+ */=0D
+struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_stn_ops(void);=0D
+=0D
+/**=0D
+ * Get cmdq ops hardware tile NIC(htn) supported.=0D
+ *=0D
+ * @retval Pointer to ops.=0D
+ */=0D
+struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_htn_ops(void);=0D
+=0D
 /**=0D
  * Update driver feature capabilities.=0D
  *=0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index e8e417b474..3d5f4e4524 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -407,8 +407,7 @@ hinic3_refill_indir_rqid(struct hinic3_rxq *rxq)=0D
 	/* Build indir tbl according to the number of rss queue. */=0D
 	hinic3_fill_indir_tbl(nic_dev, indir_tbl);=0D
 =0D
-	err =3D hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl,=0D
-				       HINIC3_RSS_INDIR_SIZE);=0D
+	err =3D hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR,=0D
 			"Set indirect table failed, eth_dev:%s, queue_idx:%d",=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.c=0D
new file mode 100644=0D
index 0000000000..d997647f48=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
@@ -0,0 +1,161 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_htn_cmdq.h"=0D
+=0D
+static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *=
nic_dev,=0D
+						   struct hinic3_cmd_buf *cmd_buf,=0D
+						   enum hinic3_qp_ctxt_type ctxt_type)=0D
+{=0D
+	struct hinic3_clean_queue_ctxt *ctxt_block =3D NULL;=0D
+=0D
+	ctxt_block =3D cmd_buf->buf;=0D
+	ctxt_block->cmdq_hdr.num_queues =3D nic_dev->max_sqs;=0D
+	ctxt_block->cmdq_hdr.queue_type =3D ctxt_type;=0D
+	ctxt_block->cmdq_hdr.start_qid =3D 0;=0D
+	ctxt_block->cmdq_hdr.dest_func_id =3D hinic3_global_func_id(nic_dev->hwde=
v);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));=0D
+=0D
+	cmd_buf->size =3D sizeof(*ctxt_block);=0D
+	return HINIC3_HTN_CMD_TSO_LRO_SPACE_CLEAN;=0D
+}=0D
+=0D
+static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_h=
dr,=0D
+				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,=0D
+				   uint16_t q_id, uint16_t func_id)=0D
+{=0D
+	qp_ctxt_hdr->queue_type =3D ctxt_type;=0D
+	qp_ctxt_hdr->num_queues =3D num_queues;=0D
+	qp_ctxt_hdr->start_qid =3D q_id;=0D
+	qp_ctxt_hdr->dest_func_id =3D func_id;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_de=
v *nic_dev,=0D
+						      struct hinic3_cmd_buf *cmd_buf,=0D
+						      enum hinic3_qp_ctxt_type ctxt_type,=0D
+						      uint16_t start_qid, uint16_t max_ctxts)=0D
+{=0D
+	struct hinic3_qp_ctxt_block *qp_ctxt_block =3D NULL;=0D
+	uint16_t func_id;=0D
+	uint16_t i;=0D
+=0D
+	qp_ctxt_block =3D cmd_buf->buf;=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+	qp_prepare_cmdq_header(&qp_ctxt_block->cmdq_hdr, ctxt_type,=0D
+			       max_ctxts, start_qid, func_id);=0D
+=0D
+	for (i =3D 0; i < max_ctxts; i++) {=0D
+		if (ctxt_type =3D=3D HINIC3_QP_CTXT_TYPE_RQ)=0D
+			hinic3_rq_prepare_ctxt(nic_dev->rxqs[start_qid + i],=0D
+					       &qp_ctxt_block->rq_ctxt[i]);=0D
+		else=0D
+			hinic3_sq_prepare_ctxt(nic_dev->txqs[start_qid + i],=0D
+					       start_qid + i,=0D
+					       &qp_ctxt_block->sq_ctxt[i]);=0D
+	}=0D
+=0D
+	if (ctxt_type =3D=3D HINIC3_QP_CTXT_TYPE_RQ)=0D
+		cmd_buf->size =3D RQ_CTXT_SIZE(max_ctxts);=0D
+	else=0D
+		cmd_buf->size =3D SQ_CTXT_SIZE(max_ctxts);=0D
+=0D
+	return HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_ST;=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf=
,=0D
+			uint16_t func_id, uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)=
=0D
+{=0D
+	struct hinic3_vlan_ctx *vlan_ctx =3D NULL;=0D
+=0D
+	cmd_buf->size =3D sizeof(struct hinic3_vlan_ctx);=0D
+	vlan_ctx =3D (struct hinic3_vlan_ctx *)cmd_buf->buf;=0D
+=0D
+	vlan_ctx->dest_func_id =3D func_id;=0D
+	vlan_ctx->start_qid =3D q_id;=0D
+	vlan_ctx->vlan_tag =3D vlan_tag;=0D
+	vlan_ctx->vlan_sel =3D 0; /* TPID0 in IPSU */=0D
+	vlan_ctx->vlan_mode =3D vlan_mode;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));=0D
+	return HINIC3_HTN_CMD_SVLAN_MODIFY;=0D
+}=0D
+=0D
+static void prepare_rss_indir_table_cmd_header(struct hinic3_nic_dev *nic_=
dev,=0D
+					       struct hinic3_cmd_buf *cmd_buf)=0D
+{=0D
+	struct hinic3_rss_cmd_header *header =3D cmd_buf->buf;=0D
+=0D
+	header->dest_func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(header, sizeof(*header));=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *=
nic_dev,=0D
+						   const uint32_t *indir_table,=0D
+						   struct hinic3_cmd_buf *cmd_buf)=0D
+{=0D
+	uint32_t i;=0D
+	uint8_t *indir_tbl =3D NULL;=0D
+=0D
+	indir_tbl =3D (uint8_t *)cmd_buf->buf + sizeof(struct hinic3_rss_cmd_head=
er);=0D
+	cmd_buf->size =3D sizeof(struct hinic3_rss_cmd_header) + HINIC3_RSS_INDIR=
_SIZE;=0D
+	memset(indir_tbl, 0, HINIC3_RSS_INDIR_SIZE);=0D
+=0D
+	prepare_rss_indir_table_cmd_header(nic_dev, cmd_buf);=0D
+=0D
+	for (i =3D 0; i < HINIC3_RSS_INDIR_SIZE; i++)=0D
+		indir_tbl[i] =3D (uint8_t)(*(indir_table + i));=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(indir_tbl, HINIC3_RSS_INDIR_SIZE);=0D
+=0D
+	return HINIC3_HTN_CMD_SET_RSS_INDIR_TABLE;=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_get_rss_indir_table(struct hinic3_nic_dev *=
nic_dev,=0D
+						   struct hinic3_cmd_buf *cmd_buf)=0D
+{=0D
+	memset(cmd_buf->buf, 0, cmd_buf->size);=0D
+	prepare_rss_indir_table_cmd_header(nic_dev, cmd_buf);=0D
+=0D
+	return HINIC3_HTN_CMD_GET_RSS_INDIR_TABLE;=0D
+}=0D
+=0D
+static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_bu=
f, uint32_t *indir_table)=0D
+{=0D
+	uint32_t i;=0D
+	uint8_t *indir_tbl =3D NULL;=0D
+=0D
+	indir_tbl =3D (uint8_t *)cmd_buf->buf;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_be32_to_cpu(cmd_buf->buf, HINIC3_RSS_INDIR_SIZE);=0D
+	for (i =3D 0; i < HINIC3_RSS_INDIR_SIZE; i++)=0D
+		indir_table[i] =3D *(indir_tbl + i);=0D
+}=0D
+=0D
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void)=0D
+{=0D
+	static struct hinic3_nic_cmdq_ops cmdq_ops =3D {=0D
+		.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lr=
o_space,=0D
+		.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_m=
ulti_store,=0D
+		.prepare_cmd_buf_modify_svlan =3D           prepare_cmd_buf_modify_svlan=
,=0D
+		.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indi=
r_table,=0D
+		.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indi=
r_table,=0D
+		.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=
=0D
+	};=0D
+=0D
+	return &cmdq_ops;=0D
+}=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.h=0D
new file mode 100644=0D
index 0000000000..1245b9c8d8=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
@@ -0,0 +1,55 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_HTN_CMDQ_H_=0D
+#define _HINIC3_HTN_CMDQ_H_=0D
+=0D
+#include "hinic3_nic_io.h"=0D
+=0D
+struct hinic3_qp_ctxt_header {=0D
+	uint32_t rsvd[2];=0D
+	uint16_t num_queues;=0D
+	uint16_t queue_type;=0D
+	uint16_t start_qid;=0D
+	uint16_t dest_func_id;=0D
+};=0D
+=0D
+struct hinic3_clean_queue_ctxt {=0D
+	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+};=0D
+=0D
+struct hinic3_qp_ctxt_block {=0D
+	struct hinic3_qp_ctxt_header   cmdq_hdr;=0D
+	union {=0D
+		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];=0D
+		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];=0D
+	};=0D
+};=0D
+=0D
+struct hinic3_rss_cmd_header {=0D
+	uint32_t rsv[3];=0D
+	uint16_t rsv1;=0D
+	uint16_t dest_func_id;=0D
+};=0D
+=0D
+/* NIC HTN CMD */=0D
+enum hinic3_htn_cmd {=0D
+	HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_ST =3D 0x20,=0D
+	HINIC3_HTN_CMD_SQ_RQ_CONTEXT_MULTI_LD,=0D
+	HINIC3_HTN_CMD_TSO_LRO_SPACE_CLEAN,=0D
+	HINIC3_HTN_CMD_SVLAN_MODIFY,=0D
+	HINIC3_HTN_CMD_SET_RSS_INDIR_TABLE,=0D
+	HINIC3_HTN_CMD_GET_RSS_INDIR_TABLE=0D
+};=0D
+=0D
+struct hinic3_vlan_ctx {=0D
+	uint32_t rsv[2];=0D
+	uint16_t vlan_tag;=0D
+	uint8_t vlan_sel;=0D
+	uint8_t vlan_mode;=0D
+	uint16_t start_qid;=0D
+	uint16_t dest_func_id;=0D
+};=0D
+=0D
+#endif /* _HINIC3_HTN_CMDQ_H_ */=0D
diff --git a/drivers/net/hinic3/htn_adapt/meson.build b/drivers/net/hinic3/=
htn_adapt/meson.build=0D
new file mode 100644=0D
index 0000000000..17f7ad09e3=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/htn_adapt/meson.build=0D
@@ -0,0 +1,7 @@=0D
+# SPDX-License-Identifier: BSD-3-Clause=0D
+# Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+=0D
+includes +=3D include_directories('.')=0D
+sources +=3D files(=0D
+        'hinic3_htn_cmdq.c',=0D
+)=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.c=0D
new file mode 100644=0D
index 0000000000..3d4becf07c=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
@@ -0,0 +1,145 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_stn_cmdq.h"=0D
+=0D
+static uint8_t prepare_cmd_buf_clean_tso_lro_space(struct hinic3_nic_dev *=
nic_dev,=0D
+						   struct hinic3_cmd_buf *cmd_buf,=0D
+						   enum hinic3_qp_ctxt_type ctxt_type)=0D
+{=0D
+	struct hinic3_clean_queue_ctxt *ctxt_block =3D NULL;=0D
+=0D
+	ctxt_block =3D cmd_buf->buf;=0D
+	ctxt_block->cmdq_hdr.num_queues =3D nic_dev->max_sqs;=0D
+	ctxt_block->cmdq_hdr.queue_type =3D ctxt_type;=0D
+	ctxt_block->cmdq_hdr.start_qid =3D 0;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));=0D
+=0D
+	cmd_buf->size =3D sizeof(*ctxt_block);=0D
+	return HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT;=0D
+}=0D
+=0D
+static void qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_h=
dr,=0D
+				   enum hinic3_qp_ctxt_type ctxt_type, uint16_t num_queues,=0D
+				   uint16_t q_id)=0D
+{=0D
+	qp_ctxt_hdr->queue_type =3D ctxt_type;=0D
+	qp_ctxt_hdr->num_queues =3D num_queues;=0D
+	qp_ctxt_hdr->start_qid =3D q_id;=0D
+	qp_ctxt_hdr->rsvd =3D 0;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_qp_context_multi_store(struct hinic3_nic_de=
v *nic_dev,=0D
+						 struct hinic3_cmd_buf *cmd_buf,=0D
+						 enum hinic3_qp_ctxt_type ctxt_type,=0D
+						 uint16_t start_qid, uint16_t max_ctxts)=0D
+{=0D
+	struct hinic3_qp_ctxt_block *qp_ctxt_block =3D NULL;=0D
+	uint16_t i;=0D
+=0D
+	qp_ctxt_block =3D cmd_buf->buf;=0D
+=0D
+	qp_prepare_cmdq_header(&qp_ctxt_block->cmdq_hdr, ctxt_type,=0D
+				   max_ctxts, start_qid);=0D
+=0D
+	for (i =3D 0; i < max_ctxts; i++) {=0D
+		if (ctxt_type =3D=3D HINIC3_QP_CTXT_TYPE_RQ)=0D
+			hinic3_rq_prepare_ctxt(nic_dev->rxqs[start_qid + i],=0D
+					       &qp_ctxt_block->rq_ctxt[i]);=0D
+		else=0D
+			hinic3_sq_prepare_ctxt(nic_dev->txqs[start_qid + i], start_qid + i,=0D
+					       &qp_ctxt_block->sq_ctxt[i]);=0D
+	}=0D
+=0D
+	if (ctxt_type =3D=3D HINIC3_QP_CTXT_TYPE_RQ)=0D
+		cmd_buf->size =3D RQ_CTXT_SIZE(max_ctxts);=0D
+	else=0D
+		cmd_buf->size =3D SQ_CTXT_SIZE(max_ctxts);=0D
+=0D
+	return HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX;=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf=
, uint16_t func_id,=0D
+					    uint16_t vlan_tag, uint16_t q_id, uint8_t vlan_mode)=0D
+{=0D
+	struct hinic3_vlan_ctx *vlan_ctx =3D NULL;=0D
+=0D
+	cmd_buf->size =3D sizeof(struct hinic3_vlan_ctx);=0D
+	vlan_ctx =3D (struct hinic3_vlan_ctx *)cmd_buf->buf;=0D
+=0D
+	vlan_ctx->func_id =3D func_id;=0D
+	vlan_ctx->qid =3D q_id;=0D
+	vlan_ctx->vlan_id =3D vlan_tag;=0D
+	vlan_ctx->vlan_sel =3D 0; /* TPID0 in IPSU */=0D
+	vlan_ctx->vlan_mode =3D vlan_mode;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+	hinic3_cpu_to_be32(vlan_ctx, sizeof(struct hinic3_vlan_ctx));=0D
+	return HINIC3_UCODE_CMD_MODIFY_VLAN_CTX;=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *=
nic_dev,=0D
+						   const uint32_t *indir_table,=0D
+						   struct hinic3_cmd_buf *cmd_buf)=0D
+{=0D
+	uint32_t i, size;=0D
+	uint32_t *temp =3D NULL;=0D
+	struct nic_rss_indirect_tbl *indir_tbl =3D NULL;=0D
+=0D
+	indir_tbl =3D (struct nic_rss_indirect_tbl *)cmd_buf->buf;=0D
+	cmd_buf->size =3D sizeof(struct nic_rss_indirect_tbl);=0D
+	memset(indir_tbl, 0, sizeof(*indir_tbl));=0D
+=0D
+	for (i =3D 0; i < HINIC3_RSS_INDIR_SIZE; i++)=0D
+		indir_tbl->entry[i] =3D (uint16_t)(*(indir_table + i));=0D
+	size =3D sizeof(indir_tbl->entry) / 4;=0D
+	temp =3D (uint32_t *)indir_tbl->entry;=0D
+	for (i =3D 0; i < size; i++) {=0D
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+		temp[i] =3D rte_cpu_to_be_32(temp[i]);=0D
+	}=0D
+	return HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE;=0D
+}=0D
+=0D
+static uint8_t prepare_cmd_buf_get_rss_indir_table(struct hinic3_nic_dev *=
nic_dev,=0D
+						   struct hinic3_cmd_buf *cmd_buf)=0D
+{=0D
+	(void)nic_dev;=0D
+	memset(cmd_buf->buf, 0, cmd_buf->size);=0D
+=0D
+	return HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE;=0D
+}=0D
+=0D
+static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_bu=
f, uint32_t *indir_table)=0D
+{=0D
+	uint32_t i;=0D
+	uint16_t *indir_tbl =3D NULL;=0D
+=0D
+	indir_tbl =3D (uint16_t *)cmd_buf->buf;=0D
+	for (i =3D 0; i < HINIC3_RSS_INDIR_SIZE; i++)=0D
+		indir_table[i] =3D *(indir_tbl + i);=0D
+}=0D
+=0D
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void)=0D
+{=0D
+	static struct hinic3_nic_cmdq_ops cmdq_ops =3D {=0D
+		.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lr=
o_space,=0D
+		.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_m=
ulti_store,=0D
+		.prepare_cmd_buf_modify_svlan =3D           prepare_cmd_buf_modify_svlan=
,=0D
+		.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indi=
r_table,=0D
+		.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indi=
r_table,=0D
+		.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=
=0D
+	};=0D
+=0D
+	return &cmdq_ops;=0D
+}=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.h=0D
new file mode 100644=0D
index 0000000000..f8d26e9397=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
@@ -0,0 +1,38 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_STN_CMDQ_H_=0D
+#define _HINIC3_STN_CMDQ_H_=0D
+=0D
+#include "hinic3_nic_io.h"=0D
+=0D
+struct hinic3_qp_ctxt_header {=0D
+	uint16_t num_queues;=0D
+	uint16_t queue_type;=0D
+	uint16_t start_qid;=0D
+	uint16_t rsvd;=0D
+};=0D
+=0D
+struct hinic3_clean_queue_ctxt {=0D
+	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+	uint32_t rsvd;=0D
+};=0D
+=0D
+struct hinic3_qp_ctxt_block {=0D
+	struct hinic3_qp_ctxt_header   cmdq_hdr;=0D
+	union {=0D
+		struct hinic3_sq_ctxt  sq_ctxt[HINIC3_Q_CTXT_MAX];=0D
+		struct hinic3_rq_ctxt  rq_ctxt[HINIC3_Q_CTXT_MAX];=0D
+	};=0D
+};=0D
+=0D
+struct hinic3_vlan_ctx {=0D
+	uint32_t func_id;=0D
+	uint32_t qid; /* if qid =3D 0xFFFF, config for all queues */=0D
+	uint32_t vlan_id;=0D
+	uint32_t vlan_mode;=0D
+	uint32_t vlan_sel;=0D
+};=0D
+=0D
+#endif /* _HINIC3_STN_CMDQ_H_ */=0D
diff --git a/drivers/net/hinic3/stn_adapt/meson.build b/drivers/net/hinic3/=
stn_adapt/meson.build=0D
new file mode 100644=0D
index 0000000000..99f7f66ab4=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/stn_adapt/meson.build=0D
@@ -0,0 +1,7 @@=0D
+# SPDX-License-Identifier: BSD-3-Clause=0D
+# Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+=0D
+includes +=3D include_directories('.')=0D
+sources +=3D files(=0D
+        'hinic3_stn_cmdq.c',=0D
+)=0D
-- =0D
2.45.1.windows.1=0D
=0D

