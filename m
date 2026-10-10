Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A7BCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:45:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D8140658;
	Sat, 10 Oct 2026 16:45:20 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 5870140274
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=C2gjpabXC+oRFXktg49TO/hv/PP9CO0YzJDL/thV8FY=;
 b=puS2TpqUJME2K77vN2JZtl53p2cy3ADJzDkrqnbClzhy6LpHMRbRswh8eLUVgh
 0otv50UmPdSWazg+Q73b7XI1GOWMMlntIps28p/IXirx8jt6kBDRlyoaMQMLtPy2
 PmIxGq3vZt+ogDd6NYSJzDSUIsy8VxZ9hephPXYbUiGqc=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 06/17] net/hinic3: add VF link state and promiscuous support
Date: Sat, 10 Oct 2026 22:44:57 +0800
Message-ID: <20261010144509.2731-7-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFyfZw4rAw1xKF15tF4UCFg_yoWxZrykpa
 yUGFZ3tF9rWF42q3Z8Gw47uF15W3WxG3y7Kas3Ca4Yv3W5XrZ8A34xJrW2vrn0y3srAa17
 ZF48ur4qvF18KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j58n5UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRxASmrKT3wvkwAA3M
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

Every VF link previously followed the PF, so a VF could not be brought down=
=0D
while the PF stayed up. Track vf_valid_status and combine it with the=0D
physical link so the VF link can be set down independently.=0D
=0D
Register the promiscuous callbacks in the VF eth_dev_ops and add the=0D
symmetric feature-capability check to the disable path so a VF can enter=0D
promiscuous mode independently as well.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_hwdev.h     |  3 +-=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c   |  5 ++-=0D
 drivers/net/hinic3/base/hinic3_nic_event.c |  6 +++=0D
 drivers/net/hinic3/hinic3_ethdev.c         | 47 +++++++++++++++++++++-=0D
 4 files changed, 57 insertions(+), 4 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/ba=
se/hinic3_hwdev.h=0D
index 5601f93190..04487f9b42 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hwdev.h=0D
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h=0D
@@ -157,7 +157,8 @@ struct hinic3_hwdev {=0D
 	char mgmt_ver[MGMT_VERSION_MAX_LEN];=0D
 =0D
 	uint16_t max_vfs;=0D
-	uint16_t link_status;=0D
+	uint8_t link_status : 1;=0D
+	uint8_t vf_valid_status : 1; /* vport_enable: 1, vport_disable: 0 */=0D
 	uint32_t speed;=0D
 	uint64_t features[HINIC3_MAX_FEATURE_QWORD];=0D
 };=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index 0a0c7e74e0..2241908004 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -443,12 +443,13 @@ int=0D
 hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)=0D
 {=0D
 	struct hinic3_vport_state en_state;=0D
-	struct hinic3_nic_dev *nic_dev =3D hwdev->dev_handle;=0D
+	struct hinic3_nic_dev *nic_dev;=0D
 	uint16_t out_size =3D sizeof(en_state);=0D
 	int err;=0D
 =0D
 	if (!hwdev)=0D
 		return -EINVAL;=0D
+	nic_dev =3D hwdev->dev_handle;=0D
 =0D
 	memset(&en_state, 0, sizeof(en_state));=0D
 	en_state.func_id =3D hinic3_global_func_id(hwdev);=0D
@@ -467,6 +468,8 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, boo=
l enable)=0D
 		return -EIO;=0D
 	}=0D
 =0D
+	hwdev->vf_valid_status =3D enable;=0D
+=0D
 	return 0;=0D
 }=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic=
3/base/hinic3_nic_event.c=0D
index be8a1fc576..2f2d6aa75b 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_event.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c=0D
@@ -112,6 +112,12 @@ link_status_event_handler(struct hinic3_hwdev *hwdev, =
struct hinic3_handler_info=0D
 =0D
 	/* Link event reported only after set vport enable. */=0D
 	hinic3_get_link_port_info(hwdev, link_status->state, &link);=0D
+=0D
+	if (HINIC3_IS_VF(hwdev)) {=0D
+		hwdev->link_status =3D link.link_status;=0D
+		link.link_status =3D hwdev->link_status & hwdev->vf_valid_status;=0D
+	}=0D
+=0D
 	err =3D rte_eth_linkstatus_set(hwdev->eth_dev, &link);=0D
 	if (!err && hwdev->eth_dev->data->dev_conf.intr_conf.lsc !=3D 0)=0D
 		rte_eth_dev_callback_process(hwdev->eth_dev,=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 5a0e93ed8a..f4be6cdc06 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -820,6 +820,7 @@ static int=0D
 hinic3_dev_set_link_up(struct rte_eth_dev *dev)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_eth_link link =3D { 0 };=0D
 	int err;=0D
 =0D
 	/*=0D
@@ -844,6 +845,23 @@ hinic3_dev_set_link_up(struct rte_eth_dev *dev)=0D
 		return err;=0D
 	}=0D
 =0D
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {=0D
+		link =3D dev->data->dev_link;=0D
+		link.link_status =3D nic_dev->hwdev->link_status &=0D
+					nic_dev->hwdev->vf_valid_status;=0D
+		if (link.link_status =3D=3D RTE_ETH_LINK_DOWN) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"Set VF link up failed, dev_name: %s, port_id: %d,"=0D
+				" link_status: %d, vf_valid_status: %d",=0D
+				nic_dev->dev_name, dev->data->port_id,=0D
+				nic_dev->hwdev->link_status,=0D
+				nic_dev->hwdev->vf_valid_status);=0D
+			return -EAGAIN;=0D
+		}=0D
+=0D
+		(void)rte_eth_linkstatus_set(dev, &link);=0D
+	}=0D
+=0D
 	return 0;=0D
 }=0D
 =0D
@@ -860,6 +878,7 @@ static int=0D
 hinic3_dev_set_link_down(struct rte_eth_dev *dev)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_eth_link link =3D {0};=0D
 	int err;=0D
 =0D
 	err =3D hinic3_set_vport_enable(nic_dev->hwdev, false);=0D
@@ -873,11 +892,19 @@ hinic3_dev_set_link_down(struct rte_eth_dev *dev)=0D
 	err =3D hinic3_set_port_enable(nic_dev->hwdev, false);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR,=0D
-			"Set MAC link down failed, dev_name: %s, port_id: %d",=0D
-			nic_dev->dev_name, dev->data->port_id);=0D
+			    "Set MAC link down failed, dev_name: %s, port_id: %d",=0D
+			    nic_dev->dev_name, dev->data->port_id);=0D
 		return err;=0D
 	}=0D
 =0D
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {=0D
+		link =3D dev->data->dev_link;=0D
+		link.link_status =3D nic_dev->hwdev->link_status &=0D
+					nic_dev->hwdev->vf_valid_status;=0D
+=0D
+		(void)rte_eth_linkstatus_set(dev, &link);=0D
+	}=0D
+=0D
 	return 0;=0D
 }=0D
 =0D
@@ -925,6 +952,12 @@ hinic3_link_update(struct rte_eth_dev *dev, int wait_t=
o_complete)=0D
 	} while (rep_cnt--);=0D
 =0D
 out:=0D
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {=0D
+		nic_dev->hwdev->link_status =3D link.link_status;=0D
+		link.link_status =3D nic_dev->hwdev->link_status &=0D
+					nic_dev->hwdev->vf_valid_status;=0D
+	}=0D
+=0D
 	return rte_eth_linkstatus_set(dev, &link);=0D
 }=0D
 =0D
@@ -2470,6 +2503,12 @@ hinic3_dev_promiscuous_disable(struct rte_eth_dev *d=
ev)=0D
 	uint32_t rx_mode;=0D
 	int err;=0D
 =0D
+	if (!(nic_dev->feature_cap & NIC_F_PROMISC)) {=0D
+		PMD_DRV_LOG(ERR, "nic_dev: %s, port_id: %d, do not support vf promisc: %=
" PRIu64,=0D
+			    nic_dev->dev_name, dev->data->port_id, nic_dev->feature_cap);=0D
+		return -ENOTSUP;=0D
+	}=0D
+=0D
 	rx_mode =3D nic_dev->rx_mode & (~HINIC3_RX_MODE_PROMISC);=0D
 =0D
 	err =3D hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);=0D
@@ -3522,6 +3561,8 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =3D=
 {=0D
 	.dev_configure                 =3D hinic3_dev_configure,=0D
 	.dev_infos_get                 =3D hinic3_dev_infos_get,=0D
 	.fw_version_get                =3D hinic3_fw_version_get,=0D
+	.dev_set_link_up               =3D hinic3_dev_set_link_up,=0D
+	.dev_set_link_down             =3D hinic3_dev_set_link_down,=0D
 	.rx_queue_setup                =3D hinic3_rx_queue_setup,=0D
 	.tx_queue_setup                =3D hinic3_tx_queue_setup,=0D
 	.rx_queue_intr_enable          =3D hinic3_dev_rx_queue_intr_enable,=0D
@@ -3543,6 +3584,8 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =3D=
 {=0D
 	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
 	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
 	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.promiscuous_enable            =3D hinic3_dev_promiscuous_enable,=0D
+	.promiscuous_disable           =3D hinic3_dev_promiscuous_disable,=0D
 	.rss_hash_update               =3D hinic3_rss_hash_update,=0D
 	.rss_hash_conf_get             =3D hinic3_rss_conf_get,=0D
 	.reta_update                   =3D hinic3_rss_reta_update,=0D
-- =0D
2.33.0=0D
=0D

