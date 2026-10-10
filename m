Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D72CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 078574064F;
	Sat, 10 Oct 2026 16:45:23 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 3DC1E4026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=FfzG4pdoOe+q5NUj3NoDTkrUSxFZcOlMmjFzf5awn9E=;
 b=P3AWExfhk9AuumARQtwRuHowJX1GeEnXCp8fyZEeI/2frv9FrRcayFEKZGCSO7
 fF/52LJ4J0arYvcXLzQCX0iPFiXHSsEpO0HQjNBcQYwDa1PPQC98tZA15aWZZrrI
 Jhx1/0jrOuY396dVi2eXkKjUi9qNjn+VWc3/vZQaZI0KM=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 05/17] net/hinic3: add COS mask and COS map support
Date: Sat, 10 Oct 2026 22:44:56 +0800
Message-ID: <20261010144509.2731-6-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFykJryxCrWUAr4DCF1fXrb_yoW3Xw45pF
 WUGayDAFZrtr47t3Z8J3yDA3W5XasFy34Ik340ka4Y9Fs5ZFyDZ34qkFW7Ar1rXrW7AF17
 Zr4jk39Fgw10q37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUnYwUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhs-SWrKT3s2EgAA3r
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

Apply the firmware COS mask/map when setting up Tx queues so the configured=
=0D
COS value selects the intended queue.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst   |  1 +=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.c  |  2 +=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.h  |  9 +++-=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c |  2 +-=0D
 drivers/net/hinic3/hinic3_ethdev.c       | 57 +++++++++++++++++++++---=0D
 drivers/net/hinic3/hinic3_ethdev.h       |  2 +=0D
 6 files changed, 63 insertions(+), 10 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index 31109a16a7..e1132b379a 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -96,6 +96,7 @@ New Features=0D
 =0D
   * Added CIR drop statistics and VF link aggregation (LAG) support.=0D
   * Added FEC mode get and set support.=0D
+  * Added Class of Service (COS) mask and map support.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.c b/drivers/net/hinic3/b=
ase/hinic3_hw_cfg.c=0D
index 8899f98515..e7971509d5 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hw_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.c=0D
@@ -22,6 +22,8 @@ parse_pub_res_cap(struct service_cap *cap,=0D
 	cap->chip_svc_type =3D cap->svc_type;=0D
 =0D
 	cap->cos_valid_bitmap =3D dev_cap->valid_cos_bitmap;=0D
+	cap->cos_mask_mode =3D dev_cap->cos_mask_mode;=0D
+	cap->cos_mask_bitmap =3D dev_cap->cos_mask_bitmap;=0D
 	cap->flexq_en =3D dev_cap->flexq_en;=0D
 =0D
 	cap->host_total_function =3D dev_cap->host_total_func;=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.h b/drivers/net/hinic3/b=
ase/hinic3_hw_cfg.h=0D
index 46a9c9bf4b..217ecc92e0 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hw_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.h=0D
@@ -40,6 +40,9 @@ struct service_cap {=0D
 =0D
 	uint8_t flexq_en;=0D
 	uint8_t cos_valid_bitmap;=0D
+	uint8_t port_cos_valid_bitmap;=0D
+	uint8_t cos_mask_mode;=0D
+	uint8_t cos_mask_bitmap;=0D
 	uint16_t max_vf; /**< Max VF number that PF supported. */=0D
 =0D
 	struct nic_service_cap nic_cap; /**< NIC capability. */=0D
@@ -80,9 +83,11 @@ struct hinic3_cfg_cmd_dev_cap {=0D
 	uint8_t flexq_en;=0D
 	uint8_t valid_cos_bitmap;=0D
 	/* Reserved for func_valid_cos_bitmap. */=0D
-	uint16_t rsvd_cos;=0D
+	uint16_t rsvd_valid_cos[2];=0D
+	uint8_t cos_mask_mode;=0D
+	uint8_t cos_mask_bitmap;=0D
 =0D
-	uint32_t rsvd[11];=0D
+	uint32_t rsvd[10];=0D
 =0D
 	/* l2nic */=0D
 	uint16_t nic_max_sq_id;=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index c67779349f..0a0c7e74e0 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -1491,7 +1491,7 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev,=
 uint8_t *cos_id)=0D
 		return -EIO;=0D
 	}=0D
 =0D
-	*cos_id =3D vf_dcb.state.default_cos % HINIC3_COS_NUM_MAX_HTN;=0D
+	*cos_id =3D vf_dcb.state.default_cos;=0D
 =0D
 	return 0;=0D
 }=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 6d789565d5..5a0e93ed8a 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -75,6 +75,9 @@ enum hinic3_rx_mod {=0D
 #define HINIC3_DEFAULT_RX_MODE \=0D
 	(HINIC3_RX_MODE_UC | HINIC3_RX_MODE_MC | HINIC3_RX_MODE_BC)=0D
 =0D
+#define HINIC3_DEFAULT_COS_MASK		0x7=0D
+#define HINIC3_DEFAULT_COS_MASK_BITMAP	0xff=0D
+=0D
 struct hinic3_xstats_name_off {=0D
 	char name[RTE_ETH_XSTATS_NAME_SIZE];=0D
 	uint32_t offset;=0D
@@ -448,10 +451,8 @@ hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev)=0D
 static int=0D
 hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)=0D
 {=0D
-	struct hinic3_nic_dev *nic_dev =3D hwdev->dev_handle;=0D
 	uint8_t default_cos =3D 0;=0D
 	uint8_t valid_cos_bitmap;=0D
-	uint8_t cos_num_max;=0D
 	uint8_t i;=0D
 =0D
 	valid_cos_bitmap =3D hwdev->cfg_mgmt->svc_cap.cos_valid_bitmap;=0D
@@ -460,10 +461,7 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, =
uint8_t *cos_id)=0D
 		return -EFAULT;=0D
 	}=0D
 =0D
-	cos_num_max =3D nic_dev->feature_cap & NIC_F_HTN_CMDQ ?=0D
-		      HINIC3_COS_NUM_MAX_HTN : HINIC3_COS_NUM_MAX;=0D
-=0D
-	for (i =3D 0; i < cos_num_max; i++) {=0D
+	for (i =3D 0; i < HINIC3_COS_NUM_MAX; i++) {=0D
 		if (valid_cos_bitmap & RTE_BIT32(i))=0D
 			/* Find max cos id as default cos. */=0D
 			default_cos =3D i;=0D
@@ -474,12 +472,53 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev,=
 uint8_t *cos_id)=0D
 	return 0;=0D
 }=0D
 =0D
+static void=0D
+hinic3_get_cos_mask(struct hinic3_hwdev *hwdev, uint8_t *cos_mask)=0D
+{=0D
+	uint8_t cos_mask_mode;=0D
+=0D
+	cos_mask_mode =3D hwdev->cfg_mgmt->svc_cap.cos_mask_mode;=0D
+	if (!cos_mask_mode) {=0D
+		*cos_mask =3D HINIC3_DEFAULT_COS_MASK; /* default: 8 COS*/=0D
+		PMD_DRV_LOG(INFO,=0D
+			"cos mask not provided by firmware, use default 0x%x",=0D
+			HINIC3_DEFAULT_COS_MASK);=0D
+		return;=0D
+	}=0D
+=0D
+	*cos_mask =3D cos_mask_mode;=0D
+}=0D
+=0D
+static void=0D
+hinic3_get_cos_mask_bitmap(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	int i;=0D
+	uint8_t default_cos =3D 0;=0D
+	uint8_t cos_mask_bitmap =3D nic_dev->hwdev->cfg_mgmt->svc_cap.cos_mask_bi=
tmap =3D=3D 0=0D
+			? HINIC3_DEFAULT_COS_MASK_BITMAP=0D
+			: nic_dev->hwdev->cfg_mgmt->svc_cap.cos_mask_bitmap;=0D
+=0D
+	PMD_DRV_LOG(INFO, "cos_mask_bitmap: 0x%x", cos_mask_bitmap);=0D
+	for (i =3D HINIC3_COS_NUM_MAX - 1; i >=3D 0; i--) {=0D
+		if (cos_mask_bitmap & RTE_BIT32(i)) {=0D
+			default_cos =3D i;=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	for (i =3D 0; i < HINIC3_COS_NUM_MAX; i++)=0D
+		nic_dev->cos_map[i] =3D ((RTE_BIT32(i) & cos_mask_bitmap) =3D=3D 0) ? de=
fault_cos : i;=0D
+}=0D
+=0D
 static int=0D
 hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
+	uint8_t cos_mask =3D 0;=0D
 	uint8_t cos_id =3D 0;=0D
 	int err;=0D
 =0D
+	hinic3_get_cos_mask(nic_dev->hwdev, &cos_mask);=0D
+=0D
 	if (!HINIC3_IS_VF(nic_dev->hwdev)) {=0D
 		err =3D hinic3_pf_get_default_cos(nic_dev->hwdev, &cos_id);=0D
 		if (err) {=0D
@@ -494,8 +533,9 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev)=
=0D
 		}=0D
 	}=0D
 =0D
+	nic_dev->cos_mask =3D cos_mask;=0D
 	nic_dev->default_cos =3D cos_id;=0D
-	PMD_DRV_LOG(DEBUG, "Default cos %d", nic_dev->default_cos);=0D
+	PMD_DRV_LOG(DEBUG, "Default cos %d, cos mask %d", nic_dev->default_cos, n=
ic_dev->cos_mask);=0D
 	return 0;=0D
 }=0D
 =0D
@@ -514,6 +554,7 @@ hinic3_set_default_hw_feature(struct hinic3_nic_dev *ni=
c_dev)=0D
 {=0D
 	int err;=0D
 =0D
+	hinic3_get_cos_mask_bitmap(nic_dev);=0D
 	err =3D hinic3_init_default_cos(nic_dev);=0D
 	if (err)=0D
 		return err;=0D
@@ -1275,6 +1316,8 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	else=0D
 		txq->cos =3D nic_dev->default_cos;=0D
 =0D
+	txq->cos =3D nic_dev->cos_map[(int)(txq->cos) & nic_dev->cos_mask];=0D
+=0D
 	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;=0D
 	txq->tx_wqe_compact_task =3D HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);=
=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index c1bba21486..73f47731bf 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -127,6 +127,7 @@ struct hinic3_nic_dev {=0D
 	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];=0D
 	rte_spinlock_t queue_list_lock;=0D
 =0D
+	uint32_t cos_mask;=0D
 	uint32_t default_cos;=0D
 	uint32_t rx_csum_en;=0D
 =0D
@@ -149,6 +150,7 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_tcam_info tcam;=0D
 	struct hinic3_ethertype_filter_list filter_ethertype_list;=0D
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;=0D
+	uint8_t cos_map[HINIC3_COS_NUM_MAX];=0D
 	struct hinic3_nic_cmdq_ops *cmdq_ops;=0D
 	struct hinic3_nic_rx_ops *rx_ops;=0D
 	struct hinic3_nic_tx_ops *tx_ops;=0D
-- =0D
2.33.0=0D
=0D

