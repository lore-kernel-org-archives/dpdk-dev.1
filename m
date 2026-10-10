Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F8CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 053314067B;
	Sat, 10 Oct 2026 16:45:22 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 8860F4028C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=V6ZiD7TYvNnXIKBbihpzHJSK92bcrdWT4IpFdCT0Rok=;
 b=MoXADtfJV7pjQdTwGOeEauBnGnN1+Z2m/98mVD2XXvhB8dv1n/6aRfoTfH8gQy
 LgUkvQq27SV/qyJ/KRw8fVGlwQLLVLZtNcJhAA7/lZQTuXMoLNb5F8dKoS2YHXE5
 Js/iTj6i1eKVcNbLT0fEwV6xY+P05mUUnokZjXv4WIvLg=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 03/17] net/hinic3: add FEC mode get/set and capability
 support
Date: Sat, 10 Oct 2026 22:44:54 +0800
Message-ID: <20261010144509.2731-4-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S5
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw17Aw47tw4kCr4rXrW3Awb_yoWkAryUpa
 yUGFZ8Jr98GF4Ivrn8Gws7A3W5Jw1fJ3y0ga4xCFySk3Zavr4qya45Ga9FvF13KrW7XFyI
 vF4UuFWDKw4Yq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8sqAUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRs-SWrKT3svkAAA3z
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

High-speed links need a configurable FEC mode to interoperate with the=0D
peer, so add FEC get/set/capability callbacks.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst     |   1 +=0D
 drivers/net/hinic3/base/hinic3_hwdev.h     |   1 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c   | 110 +++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h   |  42 ++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_event.c |   1 +=0D
 drivers/net/hinic3/hinic3_ethdev.c         |  92 +++++++++++++++++=0D
 drivers/net/hinic3/hinic3_ethdev.h         |   1 +=0D
 7 files changed, 248 insertions(+)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index 0c02cbf67f..31109a16a7 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -95,6 +95,7 @@ New Features=0D
 * **Updated Huawei hinic3 ethernet driver.**=0D
 =0D
   * Added CIR drop statistics and VF link aggregation (LAG) support.=0D
+  * Added FEC mode get and set support.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/ba=
se/hinic3_hwdev.h=0D
index c6661aa1a6..5601f93190 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hwdev.h=0D
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h=0D
@@ -158,6 +158,7 @@ struct hinic3_hwdev {=0D
 =0D
 	uint16_t max_vfs;=0D
 	uint16_t link_status;=0D
+	uint32_t speed;=0D
 	uint64_t features[HINIC3_MAX_FEATURE_QWORD];=0D
 };=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index 48dee29750..c67779349f 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -1752,6 +1752,116 @@ hinic3_set_link_status_follow(struct hinic3_hwdev *=
hwdev,=0D
 	return follow.head.status;=0D
 }=0D
 =0D
+static void=0D
+hinic3_fec_param_covert(uint32_t opcode, uint8_t in_fec_param, uint8_t *ou=
t_fec_param)=0D
+{=0D
+	uint8_t fec_value_table_length;=0D
+	uint8_t i;=0D
+=0D
+	struct hinic3_fec_param_value_map fec_value_table[] =3D {=0D
+		{HINIC3_PORT_FEC_NOT_SET, RTE_BIT32(HINIC3_PORT_FEC_NOT_SET), HINIC3_FEC=
_MODE_NONE},=0D
+		{HINIC3_PORT_FEC_RSFEC, RTE_BIT32(HINIC3_PORT_FEC_RSFEC), HINIC3_FEC_MOD=
E_RS},=0D
+		{HINIC3_PORT_FEC_BASEFEC, RTE_BIT32(HINIC3_PORT_FEC_BASEFEC),=0D
+		 HINIC3_FEC_MODE_BASER},=0D
+		{HINIC3_PORT_FEC_NOFEC, RTE_BIT32(HINIC3_PORT_FEC_NOFEC), HINIC3_FEC_MOD=
E_OFF},=0D
+		{HINIC3_PORT_FEC_LLRSFEC, RTE_BIT32(HINIC3_PORT_FEC_LLRSFEC), HINIC3_FEC=
_MODE_LLRS},=0D
+		{HINIC3_PORT_FEC_AUTO, RTE_BIT32(HINIC3_PORT_FEC_AUTO), HINIC3_FEC_MODE_=
AUTO}=0D
+	};=0D
+=0D
+	*out_fec_param =3D 0;=0D
+	fec_value_table_length =3D=0D
+		(uint8_t)(sizeof(fec_value_table) / sizeof(struct hinic3_fec_param_value=
_map));=0D
+=0D
+	if (opcode =3D=3D HINIC3_FEC_MODE_OPCODE_SET) {=0D
+		for (i =3D 0; i < fec_value_table_length; i++) {=0D
+			if ((in_fec_param & fec_value_table[i].ethtool_fec_value) !=3D 0)=0D
+				*out_fec_param =3D fec_value_table[i].fec_offset;=0D
+		}=0D
+	}=0D
+=0D
+	if (opcode =3D=3D HINIC3_FEC_MODE_OPCODE_GET) {=0D
+		for (i =3D 0; i < fec_value_table_length; i++) {=0D
+			if ((in_fec_param & fec_value_table[i].hinic3_fec_value) !=3D 0)=0D
+				*out_fec_param |=3D fec_value_table[i].ethtool_fec_value;=0D
+		}=0D
+	}=0D
+}=0D
+=0D
+int=0D
+hinic3_set_fec_mode(struct hinic3_hwdev *hwdev, uint8_t fecparam)=0D
+{=0D
+	struct mag_cmd_cfg_fec_mode fec_msg =3D { 0 };=0D
+	uint16_t out_size =3D sizeof(fec_msg);=0D
+	uint8_t advertised_fec =3D 0;=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	hinic3_fec_param_covert(HINIC3_FEC_MODE_OPCODE_SET, fecparam, &advertised=
_fec);=0D
+	fec_msg.opcode =3D HINIC3_FEC_MODE_OPCODE_SET;=0D
+	fec_msg.port_id =3D hinic3_physical_port_id(hwdev);=0D
+	fec_msg.advertised_fec =3D advertised_fec;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK,=0D
+				      MAG_CMD_CFG_FEC_MODE,=0D
+				      &fec_msg, sizeof(fec_msg),=0D
+				      &fec_msg, &out_size);=0D
+=0D
+	if (fec_msg.head.status !=3D 0 || err) {=0D
+		PMD_DRV_LOG(ERR, "Failed to set fec mode failed, err: %d, status: 0x%x, =
out size: 0x%x",=0D
+			    err, fec_msg.head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(INFO, "Set fec mode success, active fec capa mode: %d", fecpa=
ram);=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_fec_mode(struct hinic3_hwdev *hwdev, uint8_t *advertised_fec,=0D
+		    uint8_t *supported_fec)=0D
+{=0D
+	struct mag_cmd_cfg_fec_mode fec_msg =3D { 0 };=0D
+	uint16_t out_size =3D sizeof(fec_msg);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	if (advertised_fec !=3D NULL)=0D
+		*advertised_fec =3D 0;=0D
+=0D
+	if (supported_fec !=3D NULL)=0D
+		*supported_fec =3D 0;=0D
+=0D
+	fec_msg.opcode =3D HINIC3_FEC_MODE_OPCODE_GET;=0D
+	fec_msg.port_id =3D hinic3_physical_port_id(hwdev);=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_HILINK,=0D
+				      MAG_CMD_CFG_FEC_MODE,=0D
+				      &fec_msg, sizeof(fec_msg),=0D
+				      &fec_msg, &out_size);=0D
+=0D
+	if (fec_msg.head.status !=3D 0 || err) {=0D
+		PMD_DRV_LOG(ERR, "Failed to get fec mode failed, err: %d, status: 0x%x, =
out size: 0x%x",=0D
+			    err, fec_msg.head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (advertised_fec !=3D NULL)=0D
+		hinic3_fec_param_covert(HINIC3_FEC_MODE_OPCODE_GET,=0D
+					RTE_BIT32(fec_msg.advertised_fec),=0D
+					advertised_fec);=0D
+=0D
+	if (supported_fec !=3D NULL)=0D
+		hinic3_fec_param_covert(HINIC3_FEC_MODE_OPCODE_GET,=0D
+					fec_msg.supported_fec,=0D
+					supported_fec);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 uint8_t=0D
 hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode)=0D
 {=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index 5f08d49a72..42a7b7010d 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -967,6 +967,43 @@ int hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev=
, enum hinic3_mod_type mod=0D
 =0D
 int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr =
*attr);=0D
 =0D
+enum hinic3_fec_mode_opcode {=0D
+	HINIC3_FEC_MODE_OPCODE_GET =3D 0,=0D
+	HINIC3_FEC_MODE_OPCODE_SET =3D 1,=0D
+};=0D
+=0D
+struct mag_cmd_cfg_fec_mode {=0D
+	struct mgmt_msg_head head;=0D
+	uint8_t port_id;=0D
+	uint8_t opcode;=0D
+	uint8_t advertised_fec;=0D
+	uint8_t supported_fec;=0D
+};=0D
+=0D
+enum hinic3_cmd_port_fec {=0D
+	HINIC3_PORT_FEC_NOT_SET =3D 0,=0D
+	HINIC3_PORT_FEC_RSFEC =3D 1,=0D
+	HINIC3_PORT_FEC_BASEFEC =3D 2,=0D
+	HINIC3_PORT_FEC_NOFEC =3D 3,=0D
+	HINIC3_PORT_FEC_LLRSFEC =3D 4,=0D
+	HINIC3_PORT_FEC_AUTO =3D 5,=0D
+};=0D
+=0D
+enum hinic3_fec_mode {=0D
+	HINIC3_FEC_MODE_NONE	=3D 0,=0D
+	HINIC3_FEC_MODE_OFF	=3D 1,=0D
+	HINIC3_FEC_MODE_AUTO	=3D 2,=0D
+	HINIC3_FEC_MODE_BASER	=3D 4,=0D
+	HINIC3_FEC_MODE_RS	=3D 8,=0D
+	HINIC3_FEC_MODE_LLRS	=3D 16,=0D
+};=0D
+=0D
+struct hinic3_fec_param_value_map {=0D
+	uint8_t fec_offset;=0D
+	uint8_t hinic3_fec_value;=0D
+	uint8_t ethtool_fec_value;=0D
+};=0D
+=0D
 /**=0D
  * Update MAC address to hardware.=0D
  *=0D
@@ -1583,4 +1620,9 @@ int hinic3_get_cir_drop(void *hwdev, struct hinic3_ci=
r_drop *stats);=0D
 =0D
 uint8_t hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode);=
=0D
 =0D
+int hinic3_set_fec_mode(struct hinic3_hwdev *hwdev, uint8_t fecparam);=0D
+=0D
+int hinic3_get_fec_mode(struct hinic3_hwdev *hwdev, uint8_t *advertised_fe=
c,=0D
+			uint8_t *supported_fec);=0D
+=0D
 #endif /* _HINIC3_NIC_CFG_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic=
3/base/hinic3_nic_event.c=0D
index 981a5f5083..be8a1fc576 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_event.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c=0D
@@ -57,6 +57,7 @@ hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, uin=
t8_t link_state,=0D
 				port_speed[port_info.speed % LINK_SPEED_LEVELS];=0D
 			link->link_duplex =3D port_info.duplex;=0D
 			link->link_autoneg =3D port_info.autoneg_state;=0D
+			hwdev->speed =3D link->link_speed;=0D
 		}=0D
 	}=0D
 }=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index ecf7df3ec0..6d789565d5 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -3335,6 +3335,95 @@ hinic3_dev_filter_ctrl(struct rte_eth_dev *dev, cons=
t struct rte_flow_ops **arg)=0D
 	return 0;=0D
 }=0D
 =0D
+static const uint32_t HINIC3_FEC_CAPA_NUM_PER_SPEED =3D 1;=0D
+=0D
+static bool=0D
+hinic3_fec_param_valid(uint32_t fec_param)=0D
+{=0D
+	if (fec_param =3D=3D HINIC3_FEC_MODE_LLRS ||=0D
+	    fec_param =3D=3D HINIC3_FEC_MODE_RS ||=0D
+	    fec_param =3D=3D HINIC3_FEC_MODE_BASER ||=0D
+	    fec_param =3D=3D HINIC3_FEC_MODE_OFF) {=0D
+		return true;=0D
+	}=0D
+=0D
+	return false;=0D
+}=0D
+=0D
+static int=0D
+hinic3_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int err;=0D
+=0D
+	if (hinic3_fec_param_valid(fec_capa) =3D=3D false) {=0D
+		PMD_DRV_LOG(ERR, "Fec param is valid, failed to set fec param.");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D hinic3_set_fec_mode(nic_dev->hwdev, (uint8_t)fec_capa);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set fec param failed: %d.", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	nic_dev->fec_mode =3D fec_capa;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	uint8_t advertised_fec =3D 0;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_get_fec_mode(nic_dev->hwdev, &advertised_fec, 0);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get fec parma failed: %d.", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	*fec_capa =3D (uint32_t)advertised_fec;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_fec_capability_get(struct rte_eth_dev *dev,=0D
+			  struct rte_eth_fec_capa *speed_fec_capa,=0D
+			  unsigned int num)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	uint8_t supported_fec =3D 0;=0D
+	int err;=0D
+=0D
+	if (speed_fec_capa =3D=3D NULL)=0D
+		return HINIC3_FEC_CAPA_NUM_PER_SPEED;=0D
+=0D
+	if (num < HINIC3_FEC_CAPA_NUM_PER_SPEED) {=0D
+		PMD_DRV_LOG(ERR, "Not enough array size(%u) to store FEC capabilities, s=
hould not be less than %u.",=0D
+			    num, HINIC3_FEC_CAPA_NUM_PER_SPEED);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D hinic3_get_fec_mode(nic_dev->hwdev, 0, &supported_fec);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Failed to get fec capability, err: %d.", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	speed_fec_capa->speed =3D nic_dev->hwdev->speed;=0D
+	speed_fec_capa->capa =3D (uint32_t)supported_fec;=0D
+=0D
+	if (speed_fec_capa->speed =3D=3D RTE_ETH_SPEED_NUM_NONE ||=0D
+		speed_fec_capa->capa =3D=3D 0)=0D
+		return -ENOTSUP;=0D
+=0D
+	return HINIC3_FEC_CAPA_NUM_PER_SPEED;=0D
+}=0D
+=0D
 static const struct eth_dev_ops hinic3_pmd_ops =3D {=0D
 	.dev_configure                 =3D hinic3_dev_configure,=0D
 	.dev_infos_get                 =3D hinic3_dev_infos_get,=0D
@@ -3381,6 +3470,9 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
 	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
 	.flow_ops_get                  =3D hinic3_dev_filter_ctrl,=0D
+	.fec_get_capability            =3D hinic3_fec_capability_get,=0D
+	.fec_get                       =3D hinic3_fec_get,=0D
+	.fec_set                       =3D hinic3_fec_set,=0D
 };=0D
 =0D
 static const struct eth_dev_ops hinic3_pmd_vf_ops =3D {=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 6e21672a4d..c1bba21486 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -152,6 +152,7 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_nic_cmdq_ops *cmdq_ops;=0D
 	struct hinic3_nic_rx_ops *rx_ops;=0D
 	struct hinic3_nic_tx_ops *tx_ops;=0D
+	uint32_t fec_mode;  /**< Current FEC mode for ethdev. */=0D
 =0D
 };=0D
 =0D
-- =0D
2.33.0=0D
=0D

