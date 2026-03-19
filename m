Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF7109022A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 13:54:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5370040671;
	Thu, 19 Mar 2026 14:53:12 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 7483E40430
 for <dev@dpdk.org>; Thu, 19 Mar 2026 14:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=8gzEwv4FYTrCUP7sj0NKhkhSb7HZvRBPZBlgey0S7w8=;
 b=kvWjLaj9NkQlnr/eQHISXPQcJFxJinXZaLgNf+UfS0HPYXOjxKWFEqwVbJs9ub
 +tfod3XI1J2R5dnJzh2Sq4Je5ITIntveEfbdcAB8Tcqsw+qRXGkZLauwxxHMTAfB
 7zqbizbVlvWXgw85oX4ztTX90w/zG0fqkauFfygNPC+Wk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAX3Gek_7tpacAQAw--.19162S11;
 Thu, 19 Mar 2026 21:53:04 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V6 7/7] net/hinic3: use different callback func to support htn fdir
Date: Thu, 19 Mar 2026 21:52:13 +0800
Message-ID: <20260319135220.2390-8-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260319135220.2390-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260319135220.2390-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: Ac8vCgAX3Gek_7tpacAQAw--.19162S11
X-Coremail-Antispam: 1Uf129KBjvAXoWDAFyxCF17ur4DAr1UKr48WFg_yoWxKw1xXo
 WfX3y3tw1Sqw1xCa4jvw4kGF9xX3s0k3Z5Jayqkrs7Xa13ta4rtFy3AF1rJFWUu390yFnr
 ZF97Ja40qwnrX3s7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwa9aDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNgB5g2m7-8CV+AAA3M
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

For new SPx NIC, the way flow rules created is different from previous=0D
SPx NIC, so use different callback func to split them.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  55 +-=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  19 +-=0D
 drivers/net/hinic3/hinic3_ethdev.c            |  41 +-=0D
 drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----=0D
 drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--=0D
 drivers/net/hinic3/hinic3_nic_io.h            |  16 -=0D
 drivers/net/hinic3/hinic3_rx.c                |  26 +-=0D
 drivers/net/hinic3/hinic3_tx.c                |  16 +-=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |   8 +=0D
 drivers/net/hinic3/meson.build                |   8 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   2 +-=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |   8 +=0D
 12 files changed, 877 insertions(+), 340 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index 22caac0457..5387626b98 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -970,7 +970,7 @@ hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, uint=
32_t vlan_filter_ctrl)=0D
 =0D
 static int=0D
 hinic3_set_rx_lro(struct hinic3_hwdev *hwdev, uint8_t ipv4_en,=0D
-				uint8_t ipv6_en, uint8_t lro_max_pkt_len)=0D
+		  uint8_t ipv6_en, uint8_t lro_max_pkt_len)=0D
 {=0D
 	struct hinic3_cmd_lro_config lro_cfg =3D {0};=0D
 	uint16_t out_size =3D sizeof(lro_cfg);=0D
@@ -1029,7 +1029,7 @@ hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, u=
int32_t timer_value)=0D
 }=0D
 =0D
 int=0D
-hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32=
_t lro_timer,=0D
+hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, bool lro_en, uint32_t =
lro_timer,=0D
 			uint32_t lro_max_pkt_len)=0D
 {=0D
 	uint8_t ipv4_en =3D 0, ipv6_en =3D 0;=0D
@@ -1468,54 +1468,6 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev=
, uint8_t *cos_id)=0D
 	return 0;=0D
 }=0D
 =0D
-/**=0D
- * Set the Ethernet type filtering rule for the FDIR of a NIC.=0D
- *=0D
- * @param[in] hwdev=0D
- * Pointer to hardware device structure.=0D
- * @param[in] pkt_type=0D
- * Indicate the packet type.=0D
- * @param[in] queue_id=0D
- * Indicate the queue id.=0D
- * @param[in] en=0D
- * Indicate whether to add or delete an operation. 1 - add; 0 - delete.=0D
- *=0D
- * @return=0D
- * 0 on success, non-zero on failure.=0D
- */=0D
-int=0D
-hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,=0D
-			 uint8_t pkt_type, uint16_t queue_id, uint8_t en)=0D
-{=0D
-	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;=0D
-	uint16_t out_size =3D sizeof(ethertype_cmd);=0D
-	int err;=0D
-=0D
-	if (!hwdev)=0D
-		return -EINVAL;=0D
-=0D
-	memset(&ethertype_cmd, 0,=0D
-	       sizeof(struct hinic3_set_fdir_ethertype_rule));=0D
-	ethertype_cmd.func_id =3D hinic3_global_func_id(hwdev);=0D
-	ethertype_cmd.pkt_type =3D pkt_type;=0D
-	ethertype_cmd.pkt_type_en =3D en;=0D
-	ethertype_cmd.qid =3D (uint8_t)queue_id;=0D
-=0D
-	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
-				      HINIC3_NIC_CMD_SET_FDIR_STATUS,=0D
-				      &ethertype_cmd, sizeof(ethertype_cmd),=0D
-				      &ethertype_cmd, &out_size);=0D
-	if (err || ethertype_cmd.head.status || !out_size) {=0D
-		PMD_DRV_LOG(ERR,=0D
-			    "set fdir ethertype rule failed, err: %d, status: 0x%x, out size: 0=
x%x, func_id %d",=0D
-			    err, ethertype_cmd.head.status, out_size,=0D
-			    ethertype_cmd.func_id);=0D
-		return -EIO;=0D
-	}=0D
-=0D
-	return 0;=0D
-}=0D
-=0D
 int=0D
 hinic3_add_tcam_rule(struct hinic3_hwdev *hwdev, struct hinic3_tcam_cfg_ru=
le *tcam_rule,=0D
 		     uint8_t tcam_rule_type)=0D
@@ -1543,8 +1495,7 @@ hinic3_add_tcam_rule(struct hinic3_hwdev *hwdev, stru=
ct hinic3_tcam_cfg_rule *tc=0D
 				      &tcam_cmd, sizeof(tcam_cmd),=0D
 				      &tcam_cmd, &out_size);=0D
 	if (err || tcam_cmd.msg_head.status || !out_size) {=0D
-		PMD_DRV_LOG(ERR,=0D
-			    "Add tcam rule failed, err: %d, status: 0x%x, out size: 0x%x",=0D
+		PMD_DRV_LOG(ERR, "Add tcam rule failed, err: %d, status: 0x%x, out size:=
 0x%x",=0D
 			    err, tcam_cmd.msg_head.status, out_size);=0D
 		return -EIO;=0D
 	}=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index 06d5bc7d1b..6d3eb433bd 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -1203,7 +1203,7 @@ int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *h=
wdev, uint8_t en);=0D
  * @return=0D
  * 0 on success, non-zero on failure.=0D
  */=0D
-int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, ui=
nt32_t lro_timer,=0D
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, bool lro_en, uint3=
2_t lro_timer,=0D
 			    uint32_t lro_max_pkt_len);=0D
 =0D
 /**=0D
@@ -1522,8 +1522,21 @@ int hinic3_get_feature_from_hw(struct hinic3_hwdev *=
hwdev, uint64_t *s_feature,=0D
  */=0D
 int hinic3_set_feature_to_hw(struct hinic3_hwdev *hwdev, uint64_t *s_featu=
re, uint16_t size);=0D
 =0D
-int hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,=0D
-				     uint8_t pkt_type, uint16_t queue_id, uint8_t en);=0D
+/**=0D
+ * Set the Ethernet type filtering rule for the FDIR of a NIC.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] pkt_type=0D
+ * Indicate the packet type.=0D
+ * @param[in] ethertype_filter=0D
+ * Pointer to ethertype_filter structure.=0D
+ * @param[in] en=0D
+ * Indicate whether to add or delete an operation. 1 - add; 0 - delete.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
 =0D
 int hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,=0D
 				  enum hinic3_link_follow_status status);=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 1010773ac1..adeae07f27 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -975,8 +975,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t=
 qid, uint16_t nb_desc,=0D
 			    "RX queue depth is out of range from %d to %d",=0D
 			    HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_QUEUE_DEPTH);=0D
 		PMD_DRV_LOG(ERR,=0D
-				"nb_desc: %d, q_depth: %d, port: %d queue: %d",=0D
-				nb_desc, rq_depth, dev->data->port_id, qid);=0D
+			    "nb_desc: %d, q_depth: %d, port: %d queue: %d",=0D
+			    nb_desc, rq_depth, dev->data->port_id, qid);=0D
 		return -EINVAL;=0D
 	}=0D
 =0D
@@ -2158,8 +2158,7 @@ hinic3_dev_set_mtu(struct rte_eth_dev *dev, uint16_t =
mtu)=0D
 	}=0D
 =0D
 	/* Update max frame size. */=0D
-	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) =3D=0D
-		HINIC3_MTU_TO_PKTLEN(mtu);=0D
+	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) =3D HINIC3_MTU_TO_PKTLE=
N(mtu);=0D
 	nic_dev->mtu_size =3D mtu;=0D
 	return err;=0D
 }=0D
@@ -2357,6 +2356,12 @@ hinic3_dev_promiscuous_enable(struct rte_eth_dev *de=
v)=0D
 	uint32_t rx_mode;=0D
 	int err;=0D
 =0D
+	if (!(nic_dev->feature_cap & NIC_F_PROMISC)) {=0D
+		PMD_DRV_LOG(ERR, "nic_dev: %s, port_id: %d, do not support vf promisc: %=
" PRIu64 "",=0D
+			    nic_dev->dev_name, dev->data->port_id, nic_dev->feature_cap);=0D
+		return -ENOTSUP;=0D
+	}=0D
+=0D
 	rx_mode =3D nic_dev->rx_mode | HINIC3_RX_MODE_PROMISC;=0D
 =0D
 	err =3D hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);=0D
@@ -2527,20 +2532,22 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,=0D
 	}=0D
 =0D
 	rss_type.ipv4 =3D (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |=0D
-				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER))=0D
-				? 1=0D
-				: 0;=0D
+				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER)) ? 1 : 0;=0D
 	rss_type.tcp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;=0D
 	rss_type.ipv6 =3D (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |=0D
-				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER))=0D
-				? 1=0D
-				: 0;=0D
-	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER)) ? 1 : 0;=0D
 	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
-	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
 	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
 	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
 =0D
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {=0D
+		rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+		rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
+	} else {=0D
+		rss_type.ipv6_ext =3D 0;=0D
+		rss_type.tcp_ipv6_ext =3D 0;=0D
+	}=0D
+=0D
 	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
 	if (err)=0D
 		PMD_DRV_LOG(ERR, "Set RSS type failed");=0D
@@ -2597,12 +2604,16 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct=
 rte_eth_rss_conf *rss_conf)=0D
 	rss_conf->rss_hf |=3D=0D
 		rss_type.ipv6 ? (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |=0D
 				 RTE_ETH_RSS_NONFRAG_IPV6_OTHER) : 0;=0D
-	rss_conf->rss_hf |=3D rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;=0D
 	rss_conf->rss_hf |=3D rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP : =
0;=0D
-	rss_conf->rss_hf |=3D rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0=
;=0D
 	rss_conf->rss_hf |=3D rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP : =
0;=0D
 	rss_conf->rss_hf |=3D rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP : =
0;=0D
-=0D
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {=0D
+		rss_conf->rss_hf |=3D rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;=0D
+		rss_conf->rss_hf |=3D rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : =
0;=0D
+	} else {=0D
+		rss_conf->rss_hf |=3D 0;=0D
+		rss_conf->rss_hf |=3D 0;=0D
+	}=0D
 	return 0;=0D
 }=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_f=
dir.c=0D
index 263a281729..37a4f0cf52 100644=0D
--- a/drivers/net/hinic3/hinic3_fdir.c=0D
+++ b/drivers/net/hinic3/hinic3_fdir.c=0D
@@ -2,15 +2,15 @@=0D
  * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
  */=0D
 =0D
+#include "base/hinic3_cmd.h"=0D
 #include "base/hinic3_compat.h"=0D
 #include "base/hinic3_hwdev.h"=0D
 #include "base/hinic3_hwif.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "hinic3_ethdev.h"=0D
+#include "hinic3_nic_io.h"=0D
 =0D
-#define HINIC3_UINT1_MAX  0x1=0D
-#define HINIC3_UINT4_MAX  0xf=0D
-#define HINIC3_UINT15_MAX 0x7fff=0D
+#define HINIC3_INVALID_INDEX	-1=0D
 =0D
 #define HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev) \=0D
 	(&((struct hinic3_nic_dev *)(nic_dev))->tcam)=0D
@@ -77,6 +77,8 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rul=
e,=0D
 	/* Fill type of ip. */=0D
 	tcam_key->key_mask.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+	tcam_key->key_mask.vlan_flag =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info.vlan_flag =3D 0;=0D
 =0D
 	/* Fill src IPv4. */=0D
 	tcam_key->key_mask.sipv4_h =3D=0D
@@ -99,15 +101,9 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *r=
ule,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);=0D
 }=0D
 =0D
-static void=0D
-hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,=0D
-			   struct hinic3_tcam_key *tcam_key)=0D
+static void hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *=
rule,=0D
+					       struct hinic3_tcam_key *tcam_key)=0D
 {=0D
-	/* Fill type of ip. */=0D
-	tcam_key->key_mask_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
-	tcam_key->key_info_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
-=0D
-	/* Fill src IPv6. */=0D
 	tcam_key->key_mask_ipv6.sipv6_key0 =3D=0D
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
 	tcam_key->key_mask_ipv6.sipv6_key1 =3D=0D
@@ -140,8 +136,11 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *=
rule,=0D
 		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
 	tcam_key->key_info_ipv6.sipv6_key7 =3D=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
+}=0D
 =0D
-	/* Fill dst IPv6. */=0D
+static void hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *=
rule,=0D
+					       struct hinic3_tcam_key *tcam_key)=0D
+{=0D
 	tcam_key->key_mask_ipv6.dipv6_key0 =3D=0D
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
 	tcam_key->key_mask_ipv6.dipv6_key1 =3D=0D
@@ -176,6 +175,26 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *=
rule,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
 }=0D
 =0D
+static void hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule=
,=0D
+					   struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	hinic3_fdir_ipv6_tcam_key_init_sip(rule, tcam_key);=0D
+	hinic3_fdir_ipv6_tcam_key_init_dip(rule, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,=0D
+			   struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	/* Fill type of ip. */=0D
+	tcam_key->key_mask_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+	tcam_key->key_mask_ipv6.vlan_flag =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_ipv6.vlan_flag =3D 0;=0D
+=0D
+	hinic3_fdir_ipv6_tcam_key_init(rule, tcam_key);=0D
+}=0D
+=0D
 /**=0D
  * Set the TCAM information in notunnel scenario.=0D
  *=0D
@@ -204,6 +223,10 @@ hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *dev=
,=0D
 	tcam_key->key_info.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
 =0D
 	tcam_key->key_mask.function_id =3D HINIC3_UINT15_MAX;=0D
+=0D
+	tcam_key->key_mask.vlan_flag =3D 1;=0D
+	tcam_key->key_info.vlan_flag =3D 0;=0D
+=0D
 	tcam_key->key_info.function_id =3D hinic3_global_func_id(nic_dev->hwdev) =
&=0D
 					 HINIC3_UINT15_MAX;=0D
 =0D
@@ -223,6 +246,8 @@ hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_fil=
ter *rule,=0D
 	/* Fill type of ip. */=0D
 	tcam_key->key_mask.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+	tcam_key->key_mask.vlan_flag =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info.vlan_flag =3D 0;=0D
 =0D
 	/* Fill src ipv4. */=0D
 	tcam_key->key_mask.sipv4_h =3D=0D
@@ -252,6 +277,8 @@ hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_fil=
ter *rule,=0D
 	/* Fill type of ip. */=0D
 	tcam_key->key_mask_vxlan_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info_vxlan_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+	tcam_key->key_mask_vxlan_ipv6.vlan_flag =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_vxlan_ipv6.vlan_flag =3D 0;=0D
 =0D
 	/* Use inner dst ipv6 to fill the dst ipv6 of tcam_key. */=0D
 	tcam_key->key_mask_vxlan_ipv6.dipv6_key0 =3D=0D
@@ -288,77 +315,6 @@ hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_fi=
lter *rule,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x3]);=0D
 }=0D
 =0D
-static void=0D
-hinic3_fdir_tcam_outer_ipv6_init(struct hinic3_fdir_filter *rule,=0D
-				 struct hinic3_tcam_key *tcam_key)=0D
-{=0D
-	tcam_key->key_mask_ipv6.sipv6_key0 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key1 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key2 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key3 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key4 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key5 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key6 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);=0D
-	tcam_key->key_mask_ipv6.sipv6_key7 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);=0D
-	tcam_key->key_info_ipv6.sipv6_key0 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0]);=0D
-	tcam_key->key_info_ipv6.sipv6_key1 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0]);=0D
-	tcam_key->key_info_ipv6.sipv6_key2 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);=0D
-	tcam_key->key_info_ipv6.sipv6_key3 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);=0D
-	tcam_key->key_info_ipv6.sipv6_key4 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);=0D
-	tcam_key->key_info_ipv6.sipv6_key5 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);=0D
-	tcam_key->key_info_ipv6.sipv6_key6 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
-	tcam_key->key_info_ipv6.sipv6_key7 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
-=0D
-	tcam_key->key_mask_ipv6.dipv6_key0 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key1 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key2 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key3 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key4 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key5 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key6 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);=0D
-	tcam_key->key_mask_ipv6.dipv6_key7 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);=0D
-	tcam_key->key_info_ipv6.dipv6_key0 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);=0D
-	tcam_key->key_info_ipv6.dipv6_key1 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);=0D
-	tcam_key->key_info_ipv6.dipv6_key2 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);=0D
-	tcam_key->key_info_ipv6.dipv6_key3 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);=0D
-	tcam_key->key_info_ipv6.dipv6_key4 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);=0D
-	tcam_key->key_info_ipv6.dipv6_key5 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);=0D
-	tcam_key->key_info_ipv6.dipv6_key6 =3D=0D
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
-	tcam_key->key_info_ipv6.dipv6_key7 =3D=0D
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
-}=0D
-=0D
 static void=0D
 hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,=0D
 				 struct hinic3_fdir_filter *rule,=0D
@@ -370,11 +326,14 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *=
dev,=0D
 	tcam_key->key_info_ipv6.ip_proto =3D rule->key_spec.proto;=0D
 =0D
 	tcam_key->key_mask_ipv6.tunnel_type =3D HINIC3_UINT4_MAX;=0D
-	tcam_key->key_info_ipv6.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+	tcam_key->key_info_ipv6.tunnel_type =3D rule->tunnel_type;=0D
 =0D
 	tcam_key->key_mask_ipv6.outer_ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info_ipv6.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
 =0D
+	tcam_key->key_mask_ipv6.vlan_flag =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_ipv6.vlan_flag =3D 0;=0D
+=0D
 	tcam_key->key_mask_ipv6.function_id =3D HINIC3_UINT15_MAX;=0D
 	tcam_key->key_info_ipv6.function_id =3D=0D
 		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT15_MAX;=0D
@@ -386,7 +345,7 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *de=
v,=0D
 	tcam_key->key_info_ipv6.sport =3D rule->key_spec.src_port;=0D
 =0D
 	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_ANY)=0D
-		hinic3_fdir_tcam_outer_ipv6_init(rule, tcam_key);=0D
+		hinic3_fdir_ipv6_tcam_key_init(rule, tcam_key);=0D
 }=0D
 =0D
 /**=0D
@@ -448,9 +407,11 @@ hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);=0D
 =0D
 	tcam_key->key_mask.tunnel_type =3D HINIC3_UINT4_MAX;=0D
-	tcam_key->key_info.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+	tcam_key->key_info.tunnel_type =3D rule->tunnel_type;=0D
 =0D
+	tcam_key->key_mask.vlan_flag =3D 1;=0D
 	tcam_key->key_mask.function_id =3D HINIC3_UINT15_MAX;=0D
+	tcam_key->key_info.vlan_flag =3D 0;=0D
 	tcam_key->key_info.function_id =3D hinic3_global_func_id(nic_dev->hwdev) =
&=0D
 					 HINIC3_UINT15_MAX;=0D
 =0D
@@ -479,6 +440,259 @@ hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,=0D
 	tcam_key_calculate(tcam_key, fdir_tcam_rule);=0D
 }=0D
 =0D
+static void=0D
+hinic3_fdir_tcam_key_set_ipv4_sip_dip(struct rte_eth_ipv4_flow *ipv4_mask,=
=0D
+				      struct rte_eth_ipv4_flow *ipv4_spec,=0D
+				      struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_htn.sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->src_ip);=0D
+	tcam_key->key_mask_htn.sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->src_ip);=0D
+	tcam_key->key_info_htn.sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->src_ip);=0D
+	tcam_key->key_info_htn.sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->src_ip);=0D
+=0D
+	tcam_key->key_mask_htn.dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->dst_ip);=0D
+	tcam_key->key_mask_htn.dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->dst_ip);=0D
+	tcam_key->key_info_htn.dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->dst_ip);=0D
+	tcam_key->key_info_htn.dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->dst_ip);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_ipv6_sip(struct rte_eth_ipv6_flow *ipv6_mask,=0D
+				  struct rte_eth_ipv6_flow *ipv6_spec,=0D
+				  struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0x3]);=0D
+	tcam_key->key_mask_ipv6_htn.sipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0x3]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0x1]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0x1]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0x2]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0x2]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0x3]);=0D
+	tcam_key->key_info_ipv6_htn.sipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0x3]);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_ipv6_dip(struct rte_eth_ipv6_flow *ipv6_mask,=0D
+				  struct rte_eth_ipv6_flow *ipv6_spec,=0D
+				  struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0x3]);=0D
+	tcam_key->key_mask_ipv6_htn.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0x3]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0x1]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0x1]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0x2]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0x2]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0x3]);=0D
+	tcam_key->key_info_ipv6_htn.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0x3]);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_outer_ipv4_sip_dip(struct rte_eth_ipv4_flow *ipv4=
_mask,=0D
+					    struct rte_eth_ipv4_flow *ipv4_spec,=0D
+					    struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_htn.outer_sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->src_ip);=0D
+	tcam_key->key_mask_htn.outer_sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->src_ip);=0D
+	tcam_key->key_info_htn.outer_sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->src_ip);=0D
+	tcam_key->key_info_htn.outer_sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->src_ip);=0D
+=0D
+	tcam_key->key_mask_htn.outer_dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->dst_ip);=0D
+	tcam_key->key_mask_htn.outer_dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->dst_ip);=0D
+	tcam_key->key_info_htn.outer_dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->dst_ip);=0D
+	tcam_key->key_info_htn.outer_dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->dst_ip);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_ipv4_info(struct hinic3_fdir_filter *rule,=0D
+				   struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_htn.ip_type =3D HINIC3_UINT2_MAX;=0D
+	tcam_key->key_info_htn.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+	hinic3_fdir_tcam_key_set_ipv4_sip_dip(&rule->key_mask.ipv4,=0D
+					      &rule->key_spec.ipv4, tcam_key);=0D
+}=0D
+=0D
+static void hinic3_fdir_tcam_key_set_ipv6_info(struct hinic3_fdir_filter *=
rule,=0D
+					       struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_ipv6_htn.ip_type =3D HINIC3_UINT2_MAX;=0D
+	tcam_key->key_info_ipv6_htn.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+	hinic3_fdir_tcam_key_set_ipv6_sip(&rule->key_mask.ipv6,=0D
+					  &rule->key_spec.ipv6, tcam_key);=0D
+	hinic3_fdir_tcam_key_set_ipv6_dip(&rule->key_mask.ipv6,=0D
+					  &rule->key_spec.ipv6, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_notunnel_htn_init(struct hinic3_fdir_filter *rule,=0D
+				   struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_htn.tunnel_type =3D HINIC3_UINT3_MAX;=0D
+	tcam_key->key_info_htn.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+=0D
+	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4)=0D
+		hinic3_fdir_tcam_key_set_ipv4_info(rule, tcam_key);=0D
+	else if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV6)=0D
+		hinic3_fdir_tcam_key_set_ipv6_info(rule, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_outer_ipv4_info(struct hinic3_fdir_filter *rule,=
=0D
+					 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_ipv6_htn.outer_ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_ipv6_htn.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+	hinic3_fdir_tcam_key_set_outer_ipv4_sip_dip(&rule->key_mask.ipv4,=0D
+						    &rule->key_spec.ipv4, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_inner_ipv4_info(struct hinic3_fdir_filter *rule,=
=0D
+					 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_htn.ip_type =3D HINIC3_UINT2_MAX;=0D
+	tcam_key->key_info_htn.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+	hinic3_fdir_tcam_key_set_ipv4_sip_dip(&rule->key_mask.inner_ipv4,=0D
+					      &rule->key_spec.inner_ipv4, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_key_set_inner_ipv6_info(struct hinic3_fdir_filter *rule,=
=0D
+					 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_vxlan_ipv6_htn.ip_type =3D HINIC3_UINT2_MAX;=0D
+	tcam_key->key_info_vxlan_ipv6_htn.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+	hinic3_fdir_tcam_key_set_ipv6_dip(&rule->key_mask.inner_ipv6,=0D
+					  &rule->key_spec.inner_ipv6, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_tunnel_htn_init(struct hinic3_fdir_filter *rule,=0D
+				 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_htn.tunnel_type =3D HINIC3_UINT3_MAX;=0D
+	tcam_key->key_info_htn.tunnel_type =3D rule->tunnel_type;=0D
+=0D
+	tcam_key->key_mask_htn.vni_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.tunnel.tunnel_id);=0D
+	tcam_key->key_mask_htn.vni_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.tunnel.tunnel_id);=0D
+	tcam_key->key_info_htn.vni_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.tunnel.tunnel_id);=0D
+	tcam_key->key_info_htn.vni_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);=0D
+=0D
+	if (rule->outer_ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4)=0D
+		hinic3_fdir_tcam_key_set_outer_ipv4_info(rule, tcam_key);=0D
+=0D
+	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4)=0D
+		hinic3_fdir_tcam_key_set_inner_ipv4_info(rule, tcam_key);=0D
+	else if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV6)=0D
+		hinic3_fdir_tcam_key_set_inner_ipv6_info(rule, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_info_htn_init(struct rte_eth_dev *dev,=0D
+			       struct hinic3_fdir_filter *rule,=0D
+			       struct hinic3_tcam_key *tcam_key,=0D
+			       struct hinic3_tcam_cfg_rule *fdir_tcam_rule)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	tcam_key->key_mask_htn.function_id_h =3D HINIC3_UINT5_MAX;=0D
+	tcam_key->key_mask_htn.function_id_l =3D HINIC3_UINT5_MAX;=0D
+	tcam_key->key_info_htn.function_id_l =3D=0D
+		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT5_MAX;=0D
+	tcam_key->key_info_htn.function_id_h =3D=0D
+		(hinic3_global_func_id(nic_dev->hwdev) >> HINIC3_UINT5_WIDTH) & HINIC3_U=
INT5_MAX;=0D
+=0D
+	tcam_key->key_mask_htn.ip_proto =3D rule->key_mask.proto;=0D
+	tcam_key->key_info_htn.ip_proto =3D rule->key_spec.proto;=0D
+=0D
+	tcam_key->key_mask_htn.sport =3D rule->key_mask.src_port;=0D
+	tcam_key->key_info_htn.sport =3D rule->key_spec.src_port;=0D
+=0D
+	tcam_key->key_mask_htn.dport =3D rule->key_mask.dst_port;=0D
+	tcam_key->key_info_htn.dport =3D rule->key_spec.dst_port;=0D
+	if (rule->tunnel_type =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL)=0D
+		hinic3_fdir_tcam_notunnel_htn_init(rule, tcam_key);=0D
+	else=0D
+		hinic3_fdir_tcam_tunnel_htn_init(rule, tcam_key);=0D
+=0D
+	fdir_tcam_rule->data.qid =3D rule->rq_index;=0D
+=0D
+	tcam_key_calculate(tcam_key, fdir_tcam_rule);=0D
+}=0D
+=0D
 /**=0D
  * Find filter in given ethertype filter list.=0D
  *=0D
@@ -513,19 +727,30 @@ hinic3_ethertype_filter_lookup(struct hinic3_ethertyp=
e_filter_list *ethertype_li=0D
  * Point to the tcam filter list.=0D
  * @param[in] key=0D
  * The tcam key to find.=0D
+ * @param[in] action_type=0D
+ * The type of action.=0D
+ * @param[in] tcam_index=0D
+ * The index of tcam.=0D
  * @return=0D
  * If a matching filter is found, the filter is returned, otherwise NULL.=
=0D
  */=0D
 static inline struct hinic3_tcam_filter *=0D
 hinic3_tcam_filter_lookup(struct hinic3_tcam_filter_list *filter_list,=0D
-			  struct hinic3_tcam_key *key)=0D
+			  struct hinic3_tcam_key *key,=0D
+			  uint8_t action_type, uint16_t tcam_index)=0D
 {=0D
 	struct hinic3_tcam_filter *it;=0D
 =0D
-	TAILQ_FOREACH(it, filter_list, entries) {=0D
-		if (memcmp(key, &it->tcam_key,=0D
-			   sizeof(struct hinic3_tcam_key)) =3D=3D 0) {=0D
-			return it;=0D
+	if (action_type =3D=3D HINIC3_ACTION_ADD) {=0D
+		TAILQ_FOREACH(it, filter_list, entries) {=0D
+			if (memcmp(key, &it->tcam_key, sizeof(struct hinic3_tcam_key)) =3D=3D 0=
)=0D
+				return it;=0D
+		}=0D
+	} else {=0D
+		TAILQ_FOREACH(it, filter_list, entries) {=0D
+			if (tcam_index =3D=3D=0D
+			   (it->index + HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(it->dynamic_block_i=
d)))=0D
+				return it;=0D
 		}=0D
 	}=0D
 =0D
@@ -588,25 +813,18 @@ hinic3_free_dynamic_block_resource(struct hinic3_tcam=
_info *tcam_info,=0D
  *=0D
  * @param[in] dev=0D
  * Pointer to ethernet device structure.=0D
- * @param[in] fdir_tcam_rule=0D
- * Indicate the filtering rule to be searched for.=0D
  * @param[in] tcam_info=0D
  * Ternary Content-Addressable Memory (TCAM) information.=0D
- * @param[in] tcam_filter=0D
- * Point to the TCAM filter.=0D
  * @param[out] tcam_index=0D
  * Indicate the TCAM index to be searched for.=0D
  * @result=0D
  * Pointer to the TCAM dynamic block. If the search fails, NULL is returne=
d.=0D
  */=0D
 static struct hinic3_tcam_dynamic_block *=0D
-hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,=0D
-				  struct hinic3_tcam_cfg_rule *fdir_tcam_rule,=0D
+hinic3_dynamic_lookup_tcam_filter(struct hinic3_nic_dev *nic_dev,=0D
 				  struct hinic3_tcam_info *tcam_info,=0D
-				  struct hinic3_tcam_filter *tcam_filter,=0D
 				  uint16_t *tcam_index)=0D
 {=0D
-	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
 	uint16_t block_cnt =3D tcam_info->tcam_dynamic_info.dynamic_block_cnt;=0D
 	struct hinic3_tcam_dynamic_block *dynamic_block_ptr =3D NULL;=0D
 	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
@@ -616,6 +834,8 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *d=
ev,=0D
 	uint16_t index;=0D
 	int err;=0D
 =0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) !=3D 0)=0D
+		rule_nums +=3D nic_dev->ethertype_rule_nums;=0D
 	/*=0D
 	 * Check whether the number of filtering rules reaches the maximum=0D
 	 * capacity of dynamic TCAM blocks.=0D
@@ -662,8 +882,7 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *d=
ev,=0D
 =0D
 	if (tmp =3D=3D NULL ||=0D
 	    tmp->dynamic_index_cnt >=3D HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {=0D
-		PMD_DRV_LOG(ERR,=0D
-			    "Fdir filter dynamic lookup for index failed!");=0D
+		PMD_DRV_LOG(ERR, "Fdir filter dynamic lookup for index failed!");=0D
 		goto look_up_failed;=0D
 	}=0D
 =0D
@@ -674,20 +893,13 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev =
*dev,=0D
 =0D
 	/* Find the first free position. */=0D
 	if (index =3D=3D HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {=0D
-		PMD_DRV_LOG(ERR,=0D
-			    "tcam block 0x%x supports filter rules is full!",=0D
+		PMD_DRV_LOG(ERR, "tcam block 0x%x supports filter rules is full!",=0D
 			    tmp->dynamic_block_id);=0D
 		goto look_up_failed;=0D
 	}=0D
 =0D
-	tcam_filter->dynamic_block_id =3D tmp->dynamic_block_id;=0D
-	tcam_filter->index =3D index;=0D
 	*tcam_index =3D index;=0D
 =0D
-	fdir_tcam_rule->index =3D=0D
-		HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tmp->dynamic_block_id) +=0D
-		index;=0D
-=0D
 	return tmp;=0D
 =0D
 look_up_failed:=0D
@@ -702,6 +914,107 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev =
*dev,=0D
 	return NULL;=0D
 }=0D
 =0D
+static void=0D
+hinic3_tcam_index_free(struct hinic3_nic_dev *nic_dev, uint16_t index, uin=
t16_t block_id)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D HINIC3_DEV_PRIVATE_TO_TCAM_INFO(ni=
c_dev);=0D
+	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
+=0D
+	TAILQ_FOREACH(tmp, &tcam_info->tcam_dynamic_info.tcam_dynamic_list, entri=
es) {=0D
+			if (tmp->dynamic_block_id =3D=3D block_id)=0D
+				break;=0D
+	}=0D
+=0D
+	if (tmp =3D=3D NULL || tmp->dynamic_block_id !=3D block_id) {=0D
+		PMD_DRV_LOG(ERR, "Fdir filter del dynamic lookup for block failed!");=0D
+		return;=0D
+	}=0D
+=0D
+	tmp->dynamic_index[index] =3D 0;=0D
+	tmp->dynamic_index_cnt--;=0D
+	if (tmp->dynamic_index_cnt =3D=3D 0) {=0D
+		hinic3_free_tcam_block(nic_dev->hwdev, &block_id);=0D
+		hinic3_free_dynamic_block_resource(tcam_info, tmp);=0D
+	}=0D
+}=0D
+=0D
+static uint16_t=0D
+hinic3_tcam_alloc_index(void *dev, uint16_t *block_id)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D (struct hinic3_nic_dev *)dev;=0D
+	struct hinic3_tcam_info *tcam_info =3D HINIC3_DEV_PRIVATE_TO_TCAM_INFO(ni=
c_dev);=0D
+	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
+	uint16_t index =3D 0;=0D
+=0D
+	tmp =3D hinic3_dynamic_lookup_tcam_filter(nic_dev, tcam_info, &index);=0D
+	if (tmp =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Dynamic lookup tcam filter failed!");=0D
+		return HINIC3_TCAM_INVALID_INDEX;=0D
+	}=0D
+=0D
+	tmp->dynamic_index[index] =3D 1;=0D
+	tmp->dynamic_index_cnt++;=0D
+=0D
+	*block_id =3D tmp->dynamic_block_id;=0D
+=0D
+	return index;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_fdir_ethertype_filter(void *hwdev, uint8_t pkt_type, void *filt=
er, uint8_t en)=0D
+{=0D
+	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;=0D
+	struct hinic3_ethertype_filter *ethertype_filter =3D (struct hinic3_ether=
type_filter *)filter;=0D
+	uint16_t out_size =3D sizeof(ethertype_cmd);=0D
+	uint16_t block_id;=0D
+	uint32_t index =3D 0;=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		(struct hinic3_nic_dev *)((struct hinic3_hwdev *)hwdev)->dev_handle;=0D
+=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) !=3D 0) {=0D
+		if (en !=3D 0) {=0D
+			index =3D hinic3_tcam_alloc_index(nic_dev, &block_id);=0D
+			if (index =3D=3D HINIC3_TCAM_INVALID_INDEX)=0D
+				return -ENOMEM;=0D
+			index +=3D HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_id);=0D
+		} else {=0D
+			index =3D ethertype_filter->tcam_index[pkt_type];=0D
+		}=0D
+	}=0D
+=0D
+	memset(&ethertype_cmd, 0, sizeof(struct hinic3_set_fdir_ethertype_rule));=
=0D
+	ethertype_cmd.func_id =3D hinic3_global_func_id(hwdev);=0D
+	ethertype_cmd.pkt_type =3D pkt_type;=0D
+	ethertype_cmd.pkt_type_en =3D en;=0D
+	ethertype_cmd.index =3D index;=0D
+	ethertype_cmd.qid =3D (uint8_t)ethertype_filter->queue;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
+				     HINIC3_NIC_CMD_SET_FDIR_STATUS,=0D
+				     &ethertype_cmd, sizeof(ethertype_cmd),=0D
+				     &ethertype_cmd, &out_size);=0D
+	if (err || ethertype_cmd.head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "set fdir ethertype rule failed, err: %d, status: 0x%x, out size: 0=
x%x, func_id %d",=0D
+			    err, ethertype_cmd.head.status, out_size, ethertype_cmd.func_id);=0D
+		return -EIO;=0D
+	}=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) !=3D 0) {=0D
+		if (en =3D=3D 0) {=0D
+			hinic3_tcam_index_free(nic_dev, HINIC3_TCAM_GET_INDEX_IN_BLOCK(index),=
=0D
+					       HINIC3_TCAM_GET_DYNAMIC_BLOCK_INDEX(index));=0D
+		} else {=0D
+			ethertype_filter->tcam_index[pkt_type] =3D index;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 /**=0D
  * Add a TCAM filter.=0D
  *=0D
@@ -722,11 +1035,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,=0D
 	struct hinic3_tcam_info *tcam_info =3D=0D
 		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
-	struct hinic3_tcam_dynamic_block *dynamic_block_ptr =3D NULL;=0D
-	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
 	struct hinic3_tcam_filter *tcam_filter;=0D
-	uint16_t tcam_block_index =3D 0;=0D
-	uint16_t index =3D 0;=0D
 	int err;=0D
 =0D
 	/* Alloc TCAM filter memory. */=0D
@@ -737,39 +1046,14 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,=0D
 =0D
 	tcam_filter->tcam_key =3D *tcam_key;=0D
 	tcam_filter->queue =3D (uint16_t)(fdir_tcam_rule->data.qid);=0D
-=0D
-	/* Add new TCAM rules. */=0D
-	if (nic_dev->tcam_rule_nums =3D=3D 0) {=0D
-		err =3D hinic3_alloc_tcam_block(nic_dev->hwdev, &tcam_block_index);=0D
-		if (err) {=0D
-			PMD_DRV_LOG(ERR,=0D
-				    "Fdir filter tcam alloc block failed!");=0D
-			goto failed;=0D
-		}=0D
-=0D
-		dynamic_block_ptr =3D=0D
-			hinic3_alloc_dynamic_block_resource(tcam_info,=0D
-							    tcam_block_index);=0D
-		if (dynamic_block_ptr =3D=3D NULL) {=0D
-			PMD_DRV_LOG(ERR, "Fdir filter alloc dynamic first block memory failed!"=
);=0D
-			goto alloc_block_failed;=0D
-		}=0D
-	}=0D
-=0D
-	/*=0D
-	 * Look for an available index in the dynamic block to store the new=0D
-	 * TCAM filter.=0D
-	 */=0D
-	tmp =3D hinic3_dynamic_lookup_tcam_filter(dev, fdir_tcam_rule, tcam_info,=
=0D
-						tcam_filter, &index);=0D
-	if (tmp =3D=3D NULL) {=0D
-		PMD_DRV_LOG(ERR, "Dynamic lookup tcam filter failed!");=0D
-		goto lookup_tcam_index_failed;=0D
-	}=0D
+	tcam_filter->index =3D hinic3_tcam_alloc_index(nic_dev, &tcam_filter->dyn=
amic_block_id);=0D
+	if (tcam_filter->index =3D=3D HINIC3_TCAM_INVALID_INDEX)=0D
+		goto failed;=0D
+	fdir_tcam_rule->index =3D HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tcam_filter=
->dynamic_block_id) +=0D
+								    tcam_filter->index;=0D
 =0D
 	/* Add a new TCAM rule to the network device. */=0D
-	err =3D hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule,=0D
-				   TCAM_RULE_FDIR_TYPE);=0D
+	err =3D hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule, TCAM_RULE_FD=
IR_TYPE);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Fdir_tcam_rule add failed!");=0D
 		goto add_tcam_rules_failed;=0D
@@ -785,10 +1069,6 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,=0D
 	/* Add a filter to the end of the queue. */=0D
 	TAILQ_INSERT_TAIL(&tcam_info->tcam_list, tcam_filter, entries);=0D
 =0D
-	/* Update dynamic index. */=0D
-	tmp->dynamic_index[index] =3D 1;=0D
-	tmp->dynamic_index_cnt++;=0D
-=0D
 	nic_dev->tcam_rule_nums++;=0D
 =0D
 	PMD_DRV_LOG(INFO,=0D
@@ -796,7 +1076,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,=0D
 		    hinic3_global_func_id(nic_dev->hwdev));=0D
 	PMD_DRV_LOG(INFO,=0D
 		    "tcam_block_id: %d, local_index: %d, global_index: %d, queue: %d, tc=
am_rule_nums: %d",=0D
-		    tcam_filter->dynamic_block_id, index, fdir_tcam_rule->index,=0D
+		    tcam_filter->dynamic_block_id, tcam_filter->index, fdir_tcam_rule->i=
ndex,=0D
 		    fdir_tcam_rule->data.qid, nic_dev->tcam_rule_nums);=0D
 	return 0;=0D
 =0D
@@ -806,14 +1086,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,=0D
 			     TCAM_RULE_FDIR_TYPE);=0D
 =0D
 add_tcam_rules_failed:=0D
-lookup_tcam_index_failed:=0D
-	if (nic_dev->tcam_rule_nums =3D=3D 0 && dynamic_block_ptr !=3D NULL)=0D
-		hinic3_free_dynamic_block_resource(tcam_info,=0D
-						   dynamic_block_ptr);=0D
-=0D
-alloc_block_failed:=0D
-	if (nic_dev->tcam_rule_nums =3D=3D 0)=0D
-		hinic3_free_tcam_block(nic_dev->hwdev, &tcam_block_index);=0D
+	hinic3_tcam_index_free(nic_dev, tcam_filter->index, tcam_filter->dynamic_=
block_id);=0D
 =0D
 failed:=0D
 	rte_free(tcam_filter);=0D
@@ -850,8 +1123,7 @@ hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *dev=
,=0D
 	}=0D
 =0D
 	if (tmp =3D=3D NULL || tmp->dynamic_block_id !=3D dynamic_block_id) {=0D
-		PMD_DRV_LOG(ERR,=0D
-			    "Fdir filter del dynamic lookup for block failed!");=0D
+		PMD_DRV_LOG(ERR, "Fdir filter del dynamic lookup for block failed!");=0D
 		return -EINVAL;=0D
 	}=0D
 	/* Calculate TCAM index. */=0D
@@ -873,14 +1145,9 @@ hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *de=
v,=0D
 		    dynamic_block_id, tcam_filter->index, index,=0D
 		    tmp->dynamic_index_cnt - 1, nic_dev->tcam_rule_nums - 1);=0D
 =0D
-	tmp->dynamic_index[tcam_filter->index] =3D 0;=0D
-	tmp->dynamic_index_cnt--;=0D
-	nic_dev->tcam_rule_nums--;=0D
-	if (tmp->dynamic_index_cnt =3D=3D 0) {=0D
-		hinic3_free_tcam_block(nic_dev->hwdev, &dynamic_block_id);=0D
+	hinic3_tcam_index_free(nic_dev, tcam_filter->index, tmp->dynamic_block_id=
);=0D
 =0D
-		hinic3_free_dynamic_block_resource(tcam_info, tmp);=0D
-	}=0D
+	nic_dev->tcam_rule_nums--;=0D
 =0D
 	/* If the number of rules is 0, the TCAM filter is disabled. */=0D
 	if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums))=0D
@@ -930,6 +1197,7 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *de=
v,=0D
 				struct hinic3_fdir_filter *fdir_filter,=0D
 				bool add)=0D
 {=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
 	struct hinic3_tcam_info *tcam_info =3D=0D
 		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
 	struct hinic3_tcam_filter *tcam_filter;=0D
@@ -940,11 +1208,15 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *=
dev,=0D
 	memset(&fdir_tcam_rule, 0, sizeof(struct hinic3_tcam_cfg_rule));=0D
 	memset((void *)&tcam_key, 0, sizeof(struct hinic3_tcam_key));=0D
 =0D
-	hinic3_fdir_tcam_info_init(dev, fdir_filter, &tcam_key,=0D
-				   &fdir_tcam_rule);=0D
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) =3D=3D 0)=0D
+		hinic3_fdir_tcam_info_init(dev, fdir_filter, &tcam_key, &fdir_tcam_rule)=
;=0D
+	else=0D
+		hinic3_fdir_tcam_info_htn_init(dev, fdir_filter, &tcam_key, &fdir_tcam_r=
ule);=0D
+=0D
 	/* Search for a filter. */=0D
 	tcam_filter =3D=0D
-		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key);=0D
+		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key,=0D
+					  HINIC3_ACTION_ADD, HINIC3_INVALID_INDEX);=0D
 	if (tcam_filter !=3D NULL && add) {=0D
 		PMD_DRV_LOG(ERR, "Filter exists.");=0D
 		return -EEXIST;=0D
@@ -965,6 +1237,13 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *d=
ev,=0D
 =0D
 		fdir_filter->tcam_index =3D (int)(fdir_tcam_rule.index);=0D
 	} else {=0D
+		tcam_filter =3D hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_k=
ey,=0D
+							HINIC3_ACTION_NOT_ADD,=0D
+							fdir_filter->tcam_index);=0D
+		if (tcam_filter =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "Filter doesn't exist.");=0D
+			return -ENOENT;=0D
+		}=0D
 		PMD_DRV_LOG(INFO, "begin to del tcam filter");=0D
 		ret =3D hinic3_del_tcam_filter(dev, tcam_filter);=0D
 		if (ret)=0D
@@ -1088,7 +1367,7 @@ hinic3_free_fdir_filter(struct rte_eth_dev *dev)=0D
 =0D
 static int=0D
 hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,=0D
-			   struct rte_eth_ethertype_filter *ethertype_filter,=0D
+			   struct hinic3_ethertype_filter *ethertype_filter,=0D
 			   bool add)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
@@ -1097,7 +1376,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,=0D
 	/* Setting the ARP Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_ARP,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1107,7 +1386,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,=0D
 	/* Setting the ARP Request Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_ARP_REQ,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s arp request rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1117,7 +1396,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,=0D
 	/* Setting the ARP Response Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_ARP_REP,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s arp response rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1129,19 +1408,19 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,=
=0D
 set_arp_rep_failed:=0D
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					 HINIC3_PKT_TYPE_ARP_REQ,=0D
-					 ethertype_filter->queue, !add);=0D
+					 ethertype_filter, !add);=0D
 =0D
 set_arp_req_failed:=0D
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					 HINIC3_PKT_TYPE_ARP,=0D
-					 ethertype_filter->queue, !add);=0D
+					 ethertype_filter, !add);=0D
 =0D
 	return ret;=0D
 }=0D
 =0D
 static int=0D
 hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,=0D
-			    struct rte_eth_ethertype_filter *ethertype_filter,=0D
+			    struct hinic3_ethertype_filter *ethertype_filter,=0D
 			    bool add)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
@@ -1150,7 +1429,7 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,=
=0D
 	/* Setting the LACP Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_LACP,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s lacp fdir rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1160,7 +1439,7 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,=
=0D
 	/* Setting the OAM Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_OAM,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s oam rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1172,14 +1451,14 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev=
,=0D
 set_arp_oam_failed:=0D
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					 HINIC3_PKT_TYPE_LACP,=0D
-					 ethertype_filter->queue, !add);=0D
+					 ethertype_filter, !add);=0D
 =0D
 	return ret;=0D
 }=0D
 =0D
 static int=0D
 hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,=0D
-			    struct rte_eth_ethertype_filter *ethertype_filter,=0D
+			    struct hinic3_ethertype_filter *ethertype_filter,=0D
 			    bool add)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
@@ -1188,7 +1467,7 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,=
=0D
 	/* Setting the LLDP Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_LLDP,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s lldp fdir rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1198,7 +1477,7 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,=
=0D
 	/* Setting the CDCP Filter. */=0D
 	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					       HINIC3_PKT_TYPE_CDCP,=0D
-					       ethertype_filter->queue, add);=0D
+					       ethertype_filter, add);=0D
 	if (ret) {=0D
 		PMD_DRV_LOG(ERR, "%s cdcp fdir rule failed, err: %d",=0D
 			    add ? "Add" : "Del", ret);=0D
@@ -1210,14 +1489,14 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev=
,=0D
 set_arp_cdcp_failed:=0D
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
 					 HINIC3_PKT_TYPE_LLDP,=0D
-					 ethertype_filter->queue, !add);=0D
+					 ethertype_filter, !add);=0D
 =0D
 	return ret;=0D
 }=0D
 =0D
 static int=0D
 hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,=0D
-					  struct rte_eth_ethertype_filter *ethertype_filter,=0D
+					  struct hinic3_ethertype_filter *ethertype_filter,=0D
 					  bool add)=0D
 {=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
@@ -1245,7 +1524,7 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_=
eth_dev *dev,=0D
 		return hinic3_flow_set_arp_filter(dev, ethertype_filter, add);=0D
 	case RTE_ETHER_TYPE_RARP:=0D
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
-			HINIC3_PKT_TYPE_RARP, ethertype_filter->queue, add);=0D
+			HINIC3_PKT_TYPE_RARP, ethertype_filter, add);=0D
 =0D
 	case RTE_ETHER_TYPE_SLOW:=0D
 		return hinic3_flow_set_slow_filter(dev, ethertype_filter, add);=0D
@@ -1255,11 +1534,11 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rt=
e_eth_dev *dev,=0D
 =0D
 	case RTE_ETHER_TYPE_CNM:=0D
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
-			HINIC3_PKT_TYPE_CNM, ethertype_filter->queue, add);=0D
+			HINIC3_PKT_TYPE_CNM, ethertype_filter, add);=0D
 =0D
 	case RTE_ETHER_TYPE_ECP:=0D
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
-			HINIC3_PKT_TYPE_ECP, ethertype_filter->queue, add);=0D
+			HINIC3_PKT_TYPE_ECP, ethertype_filter, add);=0D
 =0D
 	default:=0D
 		PMD_DRV_LOG(ERR, "Unknown ethertype %d queue_id %d",=0D
@@ -1270,7 +1549,7 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_=
eth_dev *dev,=0D
 }=0D
 =0D
 static int=0D
-hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype=
_filter)=0D
+hinic3_flow_ethertype_rule_nums(struct hinic3_ethertype_filter *ethertype_=
filter)=0D
 {=0D
 	switch (ethertype_filter->ether_type) {=0D
 	case RTE_ETHER_TYPE_ARP:=0D
@@ -1309,7 +1588,7 @@ hinic3_flow_ethertype_rule_nums(struct rte_eth_ethert=
ype_filter *ethertype_filte=0D
  */=0D
 int=0D
 hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,=0D
-				     struct rte_eth_ethertype_filter *ethertype_filter,=0D
+				     struct hinic3_ethertype_filter *ethertype_filter,=0D
 				     bool add)=0D
 {=0D
 	/* Get dev private info. */=0D
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_f=
dir.h=0D
index 8659f588d9..277d89d4fd 100644=0D
--- a/drivers/net/hinic3/hinic3_fdir.h=0D
+++ b/drivers/net/hinic3/hinic3_fdir.h=0D
@@ -14,6 +14,30 @@=0D
 #define HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_index) \=0D
 	(HINIC3_TCAM_DYNAMIC_BLOCK_SIZE * (block_index))=0D
 =0D
+#define HINIC3_TCAM_GET_DYNAMIC_BLOCK_INDEX(index) \=0D
+		((index) / HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)=0D
+=0D
+#define HINIC3_TCAM_GET_INDEX_IN_BLOCK(index) \=0D
+		((index) % HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)=0D
+=0D
+#define HINIC3_TCAM_INVALID_INDEX 0xFFFF=0D
+=0D
+enum hinic3_ether_type {=0D
+	HINIC3_PKT_TYPE_ARP =3D 1,=0D
+	HINIC3_PKT_TYPE_ARP_REQ,=0D
+	HINIC3_PKT_TYPE_ARP_REP,=0D
+	HINIC3_PKT_TYPE_RARP,=0D
+	HINIC3_PKT_TYPE_LACP,=0D
+	HINIC3_PKT_TYPE_LLDP,=0D
+	HINIC3_PKT_TYPE_OAM,=0D
+	HINIC3_PKT_TYPE_CDCP,=0D
+	HINIC3_PKT_TYPE_CNM,=0D
+	HINIC3_PKT_TYPE_ECP =3D 10,=0D
+	HINIC3_PKT_TYPE_BUTT,=0D
+=0D
+	HINIC3_PKT_UNKNOWN =3D 31,=0D
+};=0D
+=0D
 /* Indicate a traffic filtering rule. */=0D
 struct rte_flow {=0D
 	TAILQ_ENTRY(rte_flow) node;=0D
@@ -30,6 +54,8 @@ struct hinic3_fdir_rule_key {=0D
 	uint16_t src_port;=0D
 	uint16_t dst_port;=0D
 	uint8_t proto;=0D
+	uint8_t vlan_flag;=0D
+	uint16_t ether_type;=0D
 };=0D
 =0D
 struct hinic3_fdir_filter {=0D
@@ -42,17 +68,34 @@ struct hinic3_fdir_filter {=0D
 	uint32_t rq_index; /**< Queue assigned when matched. */=0D
 };=0D
 =0D
+struct hinic3_ethertype_filter {=0D
+	int tcam_index[HINIC3_PKT_TYPE_BUTT];=0D
+	uint16_t ether_type;	/**< Ether type to match */=0D
+	uint16_t queue;		/**< Queue assigned to when match*/=0D
+};=0D
+=0D
 /* This structure is used to describe a basic filter type. */=0D
 struct hinic3_filter_t {=0D
 	uint16_t filter_rule_nums;=0D
 	enum rte_filter_type filter_type;=0D
-	struct rte_eth_ethertype_filter ethertype_filter;=0D
+	struct hinic3_ethertype_filter ethertype_filter;=0D
 	struct hinic3_fdir_filter fdir_filter;=0D
 };=0D
 =0D
+enum hinic3_action_type {=0D
+	HINIC3_ACTION_ADD,=0D
+	HINIC3_ACTION_NOT_ADD,=0D
+};=0D
+=0D
 enum hinic3_fdir_tunnel_mode {=0D
 	HINIC3_FDIR_TUNNEL_MODE_NORMAL =3D 0,=0D
-	HINIC3_FDIR_TUNNEL_MODE_VXLAN =3D 1,=0D
+	HINIC3_FDIR_TUNNEL_MODE_VXLAN  =3D 1,=0D
+	HINIC3_FDIR_TUNNEL_MODE_NVGRE  =3D 2,=0D
+	HINIC3_FDIR_TUNNEL_MODE_FC     =3D 3,=0D
+	HINIC3_FDIR_TUNNEL_MODE_GPE    =3D 4,=0D
+	HINIC3_FDIR_TUNNEL_MODE_GENEVE =3D 5,=0D
+	HINIC3_FDIR_TUNNEL_MODE_NSH    =3D 6,=0D
+	HINIC3_FDIR_TUNNEL_MODE_IPIP   =3D 7,=0D
 };=0D
 =0D
 enum hinic3_fdir_ip_type {=0D
@@ -61,7 +104,6 @@ enum hinic3_fdir_ip_type {=0D
 	HINIC3_FDIR_IP_TYPE_ANY =3D 2,=0D
 };=0D
 =0D
-/* Describe the key structure of the TCAM. */=0D
 struct hinic3_tcam_key_mem {=0D
 #if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
 	uint32_t rsvd0 : 16;=0D
@@ -77,11 +119,13 @@ struct hinic3_tcam_key_mem {=0D
 =0D
 	uint32_t dipv4_h : 16;=0D
 	uint32_t dipv4_l : 16;=0D
-	uint32_t rsvd2 : 16;=0D
+=0D
+	uint32_t vlan_flag : 1;=0D
+	uint32_t rsvd2 : 15;=0D
 =0D
 	uint32_t rsvd3;=0D
 =0D
-	uint32_t rsvd4 : 16;=0D
+	uint32_t ether_type : 16;=0D
 	uint32_t dport : 16;=0D
 =0D
 	uint32_t sport : 16;=0D
@@ -89,9 +133,10 @@ struct hinic3_tcam_key_mem {=0D
 =0D
 	uint32_t rsvd6 : 16;=0D
 	uint32_t outer_sipv4_h : 16;=0D
-	uint32_t outer_sipv4_l : 16;=0D
 =0D
+	uint32_t outer_sipv4_l : 16;=0D
 	uint32_t outer_dipv4_h : 16;=0D
+=0D
 	uint32_t outer_dipv4_l : 16;=0D
 	uint32_t vni_h : 16;=0D
 =0D
@@ -110,13 +155,14 @@ struct hinic3_tcam_key_mem {=0D
 	uint32_t dipv4_h : 16;=0D
 	uint32_t sipv4_l : 16;=0D
 =0D
-	uint32_t rsvd2 : 16;=0D
+	uint32_t rsvd2 : 15;=0D
+	uint32_t vlan_flag : 1;=0D
 	uint32_t dipv4_l : 16;=0D
 =0D
 	uint32_t rsvd3;=0D
 =0D
 	uint32_t dport : 16;=0D
-	uint32_t rsvd4 : 16;=0D
+	uint32_t ether_type : 16;=0D
 =0D
 	uint32_t rsvd5 : 16;=0D
 	uint32_t sport : 16;=0D
@@ -135,18 +181,90 @@ struct hinic3_tcam_key_mem {=0D
 #endif=0D
 };=0D
 =0D
-/*=0D
- * Define the IPv6-related TCAM key data structure in common=0D
- * scenarios or IPv6 tunnel scenarios.=0D
- */=0D
+struct hinic3_tcam_key_mem_htn {=0D
+#if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
+	uint32_t rsvd0 : 16;=0D
+	uint32_t ip_proto : 8;=0D
+	uint32_t tunnel_type : 3;=0D
+	uint32_t function_id_h: 5;=0D
+=0D
+	uint32_t function_id_l : 5;=0D
+	uint32_t ip_type : 2;=0D
+	uint32_t outer_ip_type : 1;=0D
+	uint32_t rsvd1 : 8;=0D
+	uint32_t outer_sipv4_h : 16;=0D
+=0D
+	uint32_t outer_sipv4_l : 16;=0D
+	uint32_t outer_dipv4_h : 16;=0D
+=0D
+	uint32_t outer_dipv4_l : 16;=0D
+	uint32_t rsvd2 : 8;=0D
+	uint32_t vni_h : 8;=0D
+=0D
+	uint32_t vni_l : 16;=0D
+	uint32_t sipv4_h : 16;=0D
+=0D
+	uint32_t sipv4_l : 16;=0D
+	uint32_t rsvd5 : 16;=0D
+=0D
+	uint32_t rsvd6;=0D
+	uint32_t rsvd7;=0D
+=0D
+	uint32_t rsvd8 : 16;=0D
+	uint32_t dipv4_h : 16;=0D
+=0D
+	uint32_t dipv4_l : 16;=0D
+	uint32_t sport : 16;=0D
+=0D
+	uint32_t dport : 16;=0D
+	uint32_t rsvd5 : 16;=0D
+#else=0D
+	uint32_t function_id_h : 5;=0D
+	uint32_t tunnel_type : 3;=0D
+	uint32_t ip_proto : 8;=0D
+	uint32_t rsvd0 : 16;=0D
+=0D
+	uint32_t outer_sipv4_h : 16;=0D
+	uint32_t rsvd1 : 8;=0D
+	uint32_t outer_ip_type : 1;=0D
+	uint32_t ip_type : 2;=0D
+	uint32_t function_id_l : 5;=0D
+=0D
+	uint32_t outer_dipv4_h : 16;=0D
+	uint32_t outer_sipv4_l : 16;=0D
+=0D
+	uint32_t vni_h : 8;=0D
+	uint32_t rsvd2 : 8;=0D
+	uint32_t outer_dipv4_l : 16;=0D
+=0D
+	uint32_t sipv4_h : 16;=0D
+	uint32_t vni_l : 16;=0D
+=0D
+	uint32_t rsvd5 : 16;=0D
+	uint32_t sipv4_l : 16;=0D
+=0D
+	uint32_t rsvd6;=0D
+	uint32_t rsvd7;=0D
+=0D
+	uint32_t dipv4_h : 16;=0D
+	uint32_t rsvd8 : 16;=0D
+=0D
+	uint32_t sport : 16;=0D
+	uint32_t dipv4_l :16;=0D
+=0D
+	uint32_t rsvd9 : 16;=0D
+	uint32_t dport : 16;=0D
+#endif=0D
+};=0D
+=0D
 struct hinic3_tcam_key_ipv6_mem {=0D
 #if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
 	uint32_t rsvd0 : 16;=0D
-	/* Indicates the normal IPv6 nextHdr or inner IPv4/IPv6 next proto. */=0D
 	uint32_t ip_proto : 8;=0D
 	uint32_t tunnel_type : 4;=0D
 	uint32_t outer_ip_type : 1;=0D
-	uint32_t rsvd1 : 3;=0D
+	uint32_t vlan_flag : 1;=0D
+	uint32_t rsvd1 : 2;=0D
 =0D
 	uint32_t function_id : 15;=0D
 	uint32_t ip_type : 1;=0D
@@ -179,7 +297,9 @@ struct hinic3_tcam_key_ipv6_mem {=0D
 	uint32_t dipv6_key7 : 16;=0D
 	uint32_t rsvd2 : 16;=0D
 #else=0D
-	uint32_t rsvd1 : 3;=0D
+	uint32_t rsvd1 : 2;=0D
+	uint32_t vlan_flag : 1;=0D
+=0D
 	uint32_t outer_ip_type : 1;=0D
 	uint32_t tunnel_type : 4;=0D
 	uint32_t ip_proto : 8;=0D
@@ -218,10 +338,86 @@ struct hinic3_tcam_key_ipv6_mem {=0D
 #endif=0D
 };=0D
 =0D
-/*=0D
- * Define the tcam key value data structure related to IPv6 in=0D
- * the VXLAN scenario.=0D
- */=0D
+struct hinic3_tcam_key_ipv6_mem_htn {=0D
+#if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
+	uint32_t rsvd0 : 16;=0D
+	uint32_t ip_proto : 8;=0D
+	uint32_t tunnel_type : 3;=0D
+	uint32_t function_id_h : 5;=0D
+=0D
+	uint32_t function_id_l : 5;=0D
+	uint32_t ip_type : 2;=0D
+	uint32_t outer_ip_type : 1;=0D
+	uint32_t rsvd1 : 8;=0D
+	uint32_t sipv6_key0 : 16;=0D
+=0D
+	uint32_t sipv6_key1 : 16;=0D
+	uint32_t sipv6_key2 : 16;=0D
+=0D
+	uint32_t sipv6_key3 : 16;=0D
+	uint32_t sipv6_key4 : 16;=0D
+=0D
+	uint32_t sipv6_key5 : 16;=0D
+	uint32_t sipv6_key6 : 16;=0D
+=0D
+	uint32_t sipv6_key7 : 16;=0D
+	uint32_t dipv6_key0 : 16;=0D
+=0D
+	uint32_t dipv6_key1 : 16;=0D
+	uint32_t dipv6_key2 : 16;=0D
+=0D
+	uint32_t dipv6_key3 : 16;=0D
+	uint32_t dipv6_key4 : 16;=0D
+=0D
+	uint32_t dipv6_key5 : 16;=0D
+	uint32_t dipv6_key6 : 16;=0D
+=0D
+	uint32_t dipv6_key7 : 16;=0D
+	uint32_t sport : 16;=0D
+=0D
+	uint32_t dport : 16;=0D
+	uint32_t rsvd2 : 16;=0D
+#else=0D
+	uint32_t function_id_h : 5;=0D
+	uint32_t tunnel_type : 3;=0D
+	uint32_t ip_proto : 8;=0D
+	uint32_t rsvd0 : 16;=0D
+=0D
+	uint32_t sipv6_key0 : 16;=0D
+	uint32_t rsvd1 : 8;=0D
+	uint32_t outer_ip_type : 1;=0D
+	uint32_t ip_type : 2;=0D
+	uint32_t function_id_l : 5;=0D
+=0D
+	uint32_t sipv6_key2 : 16;=0D
+	uint32_t sipv6_key1 : 16;=0D
+=0D
+	uint32_t sipv6_key4 : 16;=0D
+	uint32_t sipv6_key3 : 16;=0D
+=0D
+	uint32_t sipv6_key6 : 16;=0D
+	uint32_t sipv6_key5 : 16;=0D
+=0D
+	uint32_t dipv6_key0 : 16;=0D
+	uint32_t sipv6_key7 : 16;=0D
+=0D
+	uint32_t dipv6_key2 : 16;=0D
+	uint32_t dipv6_key1 : 16;=0D
+=0D
+	uint32_t dipv6_key4 : 16;=0D
+	uint32_t dipv6_key3 : 16;=0D
+=0D
+	uint32_t dipv6_key6 : 16;=0D
+	uint32_t dipv6_key5 : 16;=0D
+=0D
+	uint32_t sport : 16;=0D
+	uint32_t dipv6_key7 : 16;=0D
+=0D
+	uint32_t rsvd2 : 16;=0D
+	uint32_t dport : 16;=0D
+#endif=0D
+};=0D
+=0D
 struct hinic3_tcam_key_vxlan_ipv6_mem {=0D
 #if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
 	uint32_t rsvd0 : 16;=0D
@@ -246,7 +442,8 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {=0D
 	uint32_t dport : 16;=0D
 =0D
 	uint32_t sport : 16;=0D
-	uint32_t rsvd2 : 16;=0D
+	uint32_t vlan_flag : 1;=0D
+	uint32_t rsvd2 : 15;=0D
 =0D
 	uint32_t rsvd3 : 16;=0D
 	uint32_t outer_sipv4_h : 16;=0D
@@ -281,7 +478,8 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {=0D
 	uint32_t dport : 16;=0D
 	uint32_t dipv6_key7 : 16;=0D
 =0D
-	uint32_t rsvd2 : 16;=0D
+	uint32_t rsvd2 : 15;=0D
+	uint32_t vlan_flag : 1;=0D
 	uint32_t sport : 16;=0D
 =0D
 	uint32_t outer_sipv4_h : 16;=0D
@@ -298,6 +496,88 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {=0D
 #endif=0D
 };=0D
 =0D
+struct hinic3_tcam_key_vxlan_ipv6_mem_htn {=0D
+#if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
+	uint32_t rsvd0 : 16;=0D
+	uint32_t ip_proto : 8;=0D
+	uint32_t tunnel_type : 3;=0D
+	uint32_t function_id_h : 5;=0D
+=0D
+	uint32_t function_id_l : 5;=0D
+	uint32_t ip_type : 2;=0D
+	uint32_t outer_ip_type : 1;=0D
+	uint32_t rsvd1 : 8;=0D
+	uint32_t outer_sipv4_h : 16;=0D
+=0D
+	uint32_t outer_sipv4_l : 16;=0D
+	uint32_t outer_dipv4_h : 16;=0D
+=0D
+	uint32_t outer_dipv4_l : 16;=0D
+	uint32_t rsvd2 : 8;=0D
+	uint32_t vni_h : 8;=0D
+=0D
+	uint32_t vni_l : 16;=0D
+	uint32_t rsvd3 : 16;=0D
+=0D
+	uint32_t rsvd4 : 16;=0D
+	uint32_t dipv6_key0 : 16;=0D
+=0D
+	uint32_t dipv6_key1 : 16;=0D
+	uint32_t dipv6_key2 : 16;=0D
+=0D
+	uint32_t dipv6_key3 : 16;=0D
+	uint32_t dipv6_key4 : 16;=0D
+=0D
+	uint32_t dipv6_key5 : 16;=0D
+	uint32_t dipv6_key6 : 16;=0D
+=0D
+	uint32_t dipv6_key7 : 16;=0D
+	uint32_t sport : 16;=0D
+=0D
+	uint32_t dport : 16;=0D
+	uint32_t rsvd2 : 16;=0D
+#else=0D
+	uint32_t function_id_h : 5;=0D
+	uint32_t tunnel_type : 3;=0D
+	uint32_t ip_proto : 8;=0D
+	uint32_t rsvd0 : 16;=0D
+=0D
+	uint32_t outer_sipv4_h : 16;=0D
+	uint32_t rsvd1 : 8;=0D
+	uint32_t outer_ip_type : 1;=0D
+	uint32_t ip_type : 2;=0D
+	uint32_t function_id_l : 5;=0D
+=0D
+	uint32_t outer_dipv4_h : 16;=0D
+	uint32_t outer_sipv4_l : 16;=0D
+=0D
+	uint32_t vni_h : 8;=0D
+	uint32_t rsvd2 : 8;=0D
+	uint32_t outer_dipv4_l : 16;=0D
+=0D
+	uint32_t rsvd3 : 16;=0D
+	uint32_t vni_l : 16;=0D
+=0D
+	uint32_t dipv6_key0 : 16;=0D
+	uint32_t rsvd4 : 16;=0D
+=0D
+	uint32_t dipv6_key2 : 16;=0D
+	uint32_t dipv6_key1 : 16;=0D
+=0D
+	uint32_t dipv6_key4 : 16;=0D
+	uint32_t dipv6_key3 : 16;=0D
+=0D
+	uint32_t dipv6_key6 : 16;=0D
+	uint32_t dipv6_key5 : 16;=0D
+=0D
+	uint32_t sport : 16;=0D
+	uint32_t dipv6_key7 : 16;=0D
+=0D
+	uint32_t rsvd5 : 16;=0D
+	uint32_t dport : 16;=0D
+#endif=0D
+};=0D
+=0D
 /*=0D
  * TCAM key structure. The two unions indicate the key and mask respective=
ly.=0D
  * The TCAM key is consistent with the TCAM entry.=0D
@@ -307,18 +587,26 @@ struct hinic3_tcam_key {=0D
 		struct hinic3_tcam_key_mem key_info;=0D
 		struct hinic3_tcam_key_ipv6_mem key_info_ipv6;=0D
 		struct hinic3_tcam_key_vxlan_ipv6_mem key_info_vxlan_ipv6;=0D
+=0D
+		struct hinic3_tcam_key_mem_htn key_info_htn;=0D
+		struct hinic3_tcam_key_ipv6_mem_htn key_info_ipv6_htn;=0D
+		struct hinic3_tcam_key_vxlan_ipv6_mem_htn key_info_vxlan_ipv6_htn;=0D
 	};=0D
 	union {=0D
 		struct hinic3_tcam_key_mem key_mask;=0D
 		struct hinic3_tcam_key_ipv6_mem key_mask_ipv6;=0D
 		struct hinic3_tcam_key_vxlan_ipv6_mem key_mask_vxlan_ipv6;=0D
+=0D
+		struct hinic3_tcam_key_mem_htn key_mask_htn;=0D
+		struct hinic3_tcam_key_ipv6_mem_htn key_mask_ipv6_htn;=0D
+		struct hinic3_tcam_key_vxlan_ipv6_mem_htn key_mask_vxlan_ipv6_htn;=0D
 	};=0D
 };=0D
 =0D
 /* Structure indicates the TCAM filter. */=0D
 struct hinic3_tcam_filter {=0D
-	TAILQ_ENTRY(hinic3_tcam_filter)=0D
-	entries; /**< Filter entry, used for linked list operations. */=0D
+	/** Filter entry, used for linked list operations. */=0D
+	TAILQ_ENTRY(hinic3_tcam_filter) entries;=0D
 	uint16_t dynamic_block_id;	 /**< Dynamic block ID. */=0D
 	uint16_t index;			 /**< TCAM index. */=0D
 	struct hinic3_tcam_key tcam_key; /**< Indicate TCAM key. */=0D
@@ -362,33 +650,24 @@ struct hinic3_tcam_info {=0D
 #define HINIC3_CNM_RULE_NUM  1=0D
 #define HINIC3_ECP_RULE_NUM  2=0D
 =0D
+#define HINIC3_UINT1_MAX	0x1=0D
+#define HINIC3_UINT2_MAX	0x3=0D
+#define HINIC3_UINT3_MAX	0x7=0D
+#define HINIC3_UINT4_MAX	0xf=0D
+#define HINIC3_UINT5_WIDTH	0x5=0D
+#define HINIC3_UINT5_MAX	0x1f=0D
+#define HINIC3_UINT15_MAX	0x7fff=0D
+=0D
 /* Define Ethernet type. */=0D
 #define RTE_ETHER_TYPE_CNM 0x22e7=0D
 #define RTE_ETHER_TYPE_ECP 0x8940=0D
 =0D
-/* Protocol type of the data packet. */=0D
-enum hinic3_ether_type {=0D
-	HINIC3_PKT_TYPE_ARP =3D 1,=0D
-	HINIC3_PKT_TYPE_ARP_REQ,=0D
-	HINIC3_PKT_TYPE_ARP_REP,=0D
-	HINIC3_PKT_TYPE_RARP,=0D
-	HINIC3_PKT_TYPE_LACP,=0D
-	HINIC3_PKT_TYPE_LLDP,=0D
-	HINIC3_PKT_TYPE_OAM,=0D
-	HINIC3_PKT_TYPE_CDCP,=0D
-	HINIC3_PKT_TYPE_CNM,=0D
-	HINIC3_PKT_TYPE_ECP =3D 10,=0D
-=0D
-	HINIC3_PKT_UNKNOWN =3D 31,=0D
-};=0D
-=0D
 int hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,=0D
 				    struct hinic3_fdir_filter *fdir_filter,=0D
 				    bool add);=0D
 int hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,=0D
-					 struct rte_eth_ethertype_filter *ethertype_filter,=0D
+					 struct hinic3_ethertype_filter *ethertype_filter,=0D
 					 bool add);=0D
-=0D
 void hinic3_free_fdir_filter(struct rte_eth_dev *dev);=0D
 int hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_=
id,=0D
 				  uint32_t able);=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3=
_nic_io.h=0D
index d0acba4cf4..e1741d1156 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.h=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.h=0D
@@ -277,22 +277,6 @@ int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_de=
v);=0D
  */=0D
 void hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev);=0D
 =0D
-/**=0D
- * Get cmdq ops software tile NIC(stn) supported.=0D
- *=0D
- * @return=0D
- * Pointer to ops.=0D
- */=0D
-struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_stn_ops(void);=0D
-=0D
-/**=0D
- * Get cmdq ops hardware tile NIC(htn) supported.=0D
- *=0D
- * @return=0D
- * Pointer to ops.=0D
- */=0D
-struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_htn_ops(void);=0D
-=0D
 /**=0D
  * Update driver feature capabilities.=0D
  *=0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index 9e2c80f759..4c12943a05 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -22,8 +22,7 @@=0D
  * Current pi.=0D
  */=0D
 static inline void=0D
-hinic3_get_rq_wqe(struct hinic3_rxq *rxq, struct hinic3_rq_wqe **rq_wqe,=0D
-		  uint16_t *pi)=0D
+hinic3_get_rq_wqe(struct hinic3_rxq *rxq, struct hinic3_rq_wqe **rq_wqe, u=
int16_t *pi)=0D
 {=0D
 	*pi =3D MASKED_QUEUE_IDX(rxq, rxq->prod_idx);=0D
 =0D
@@ -84,8 +83,7 @@ hinic3_rx_fill_wqe(struct hinic3_rxq *rxq)=0D
 =0D
 		if (rxq->wqe_type =3D=3D HINIC3_EXTEND_RQ_WQE) {=0D
 			/* Unit of cqe length is 16B. */=0D
-			hinic3_set_sge(&rq_wqe->extend_wqe.cqe_sect.sge,=0D
-				       cqe_dma,=0D
+			hinic3_set_sge(&rq_wqe->extend_wqe.cqe_sect.sge, cqe_dma,=0D
 				       HINIC3_CQE_LEN >> HINIC3_CQE_SIZE_SHIFT);=0D
 			/* Use fixed len. */=0D
 			rq_wqe->extend_wqe.buf_desc.sge.len =3D nic_dev->rx_buff_len;=0D
@@ -436,12 +434,18 @@ hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,=
=0D
 	rss_type.ipv4 =3D (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4)) ?=
 1 : 0;=0D
 	rss_type.tcp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;=0D
 	rss_type.ipv6 =3D (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6)) ?=
 1 : 0;=0D
-	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
 	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
-	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
 	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
 	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
 =0D
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {=0D
+		rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+		rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
+	} else {=0D
+		rss_type.ipv6_ext =3D 0;=0D
+		rss_type.ipv6_ext =3D 0;=0D
+	}=0D
+=0D
 	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
 	return err;=0D
 }=0D
@@ -488,8 +492,7 @@ hinic3_update_rss_config(struct rte_eth_dev *dev,=0D
 		goto init_rss_fail;=0D
 	}=0D
 =0D
-	err =3D hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_ENABLE, num_tc,=0D
-			     prio_tc);=0D
+	err =3D hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_ENABLE, num_tc, prio_tc=
);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Enable rss failed, err: %d", err);=0D
 		goto init_rss_fail;=0D
@@ -797,7 +800,7 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hin=
ic3_rxq *rxq)=0D
 		}=0D
 	}=0D
 =0D
-	hinic3_rearm_rxq_mbuf(rxq);=0D
+	(void)hinic3_rearm_rxq_mbuf(rxq);=0D
 	if (rxq->nic_dev->num_rss =3D=3D 1) {=0D
 		err =3D hinic3_set_vport_enable(nic_dev->hwdev, true);=0D
 		if (err)=0D
@@ -813,7 +816,6 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hin=
ic3_rxq *rxq)=0D
 	return err;=0D
 }=0D
 =0D
-=0D
 static inline uint64_t=0D
 hinic3_rx_vlan(uint8_t vlan_offload, uint16_t vlan_tag, uint16_t *vlan_tci=
)=0D
 {=0D
@@ -1018,8 +1020,8 @@ hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq __rte_u=
nused, volatile struct hini=0D
 	uint32_t dw2 =3D hinic3_hw_cpu32(rx_cqe->offload_type);=0D
 	uint32_t dw3 =3D hinic3_hw_cpu32(rx_cqe->hash_val);=0D
 =0D
-	cqe_info->lro_num =3D  RQ_CQE_STATUS_GET(dw0, NUM_LRO);=0D
-	cqe_info->csum_err =3D  RQ_CQE_STATUS_GET(dw0, CSUM_ERR);=0D
+	cqe_info->lro_num =3D RQ_CQE_STATUS_GET(dw0, NUM_LRO);=0D
+	cqe_info->csum_err =3D RQ_CQE_STATUS_GET(dw0, CSUM_ERR);=0D
 =0D
 	cqe_info->pkt_len =3D RQ_CQE_SGE_GET(dw1, LEN);=0D
 	cqe_info->vlan_tag =3D RQ_CQE_SGE_GET(dw1, VLAN);=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index e0ff095c04..6b2bffb14e 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -393,7 +393,7 @@ static int=0D
 hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=0D
 		      struct rte_mbuf *mbuf,=0D
 		      struct hinic3_sq_wqe_combo *wqe_combo,=0D
-					  struct hinic3_wqe_info *wqe_info)=0D
+		      struct hinic3_wqe_info *wqe_info)=0D
 {=0D
 	uint64_t ol_flags =3D mbuf->ol_flags;=0D
 	struct hinic3_offload_info *offload_info =3D &wqe_info->offload_info;=0D
@@ -409,7 +409,7 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=0D
 =0D
 	/* Tso offload. */=0D
 	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {=0D
-		wqe_info->queue_info.payload_offset =3D wqe_info->payload_offset;=0D
+		wqe_info->queue_info.payload_offset =3D wqe_info->payload_offset >> 1;=0D
 		if ((wqe_info->payload_offset >> 1) > MAX_PAYLOAD_OFFSET)=0D
 			return -EINVAL;=0D
 =0D
@@ -457,7 +457,7 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,=0D
 		offload_info->out_l4_en =3D 1;=0D
 =0D
 set_tx_wqe_offload:=0D
-	nic_dev->tx_ops->tx_set_wqe_offload(wqe_info, wqe_combo);=0D
+	nic_dev->tx_ops->nic_tx_set_wqe_offload(wqe_info, wqe_combo);=0D
 =0D
 	return 0;=0D
 }=0D
@@ -627,9 +627,8 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, s=
truct rte_mbuf *mbuf,=0D
 		return err;=0D
 =0D
 	/* Non-tso mbuf only check sge num. */=0D
-	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {=0D
+	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG)))=0D
 		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);=0D
-	}=0D
 =0D
 	/* Tso mbuf. */=0D
 	wqe_info->payload_offset =3D=0D
@@ -647,8 +646,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, s=
truct rte_mbuf *mbuf,=0D
 }=0D
 =0D
 static inline void=0D
-hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr,=
=0D
-		    uint32_t len)=0D
+hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr, =
uint32_t len)=0D
 {=0D
 	buf_descs->hi_addr =3D hinic3_hw_be32(upper_32_bits(addr));=0D
 	buf_descs->lo_addr =3D hinic3_hw_be32(lower_32_bits(addr));=0D
@@ -832,14 +830,14 @@ hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wq=
e_combo,=0D
 	if (wqe_combo->wqe_type =3D=3D SQ_WQE_EXTENDED_TYPE) {=0D
 		wqe_desc->ctrl_len |=3D SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |=0D
 				      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
-				      SQ_CTRL_SET(SQ_WQE_SGL, DATA_FORMAT);=0D
+				      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT);=0D
 =0D
 		*qsf =3D SQ_CTRL_QUEUE_INFO_SET(1, UC) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->sctp, SCTP) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->udp_dp_en, TCPUDP_CS) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->tso, TSO) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->ufo, UFO) |=0D
-		       SQ_CTRL_QUEUE_INFO_SET(queue_info->payload_offset >> 1, PLDOFF) |=
=0D
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->payload_offset, PLDOFF) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE) |=0D
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->mss, MSS);=0D
 =0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.h=0D
index ffafe39fb5..73f4922734 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
@@ -52,4 +52,12 @@ struct hinic3_htn_vlan_ctx {=0D
 	uint16_t dest_func_id;=0D
 };=0D
 =0D
+/**=0D
+ * Get cmdq ops hardware tile NIC(htn) supported.=0D
+ *=0D
+ * @return=0D
+ * Pointer to ops.=0D
+ */=0D
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void);=0D
+=0D
 #endif /* _HINIC3_HTN_CMDQ_H_ */=0D
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.buil=
d=0D
index b79b753716..b286cdb79c 100644=0D
--- a/drivers/net/hinic3/meson.build=0D
+++ b/drivers/net/hinic3/meson.build=0D
@@ -16,8 +16,6 @@ endif=0D
 =0D
 cflags +=3D ['-DHW_CONVERT_ENDIAN']=0D
 =0D
-subdir('base')=0D
-=0D
 sources =3D files(=0D
         'hinic3_ethdev.c',=0D
         'hinic3_nic_io.c',=0D
@@ -28,3 +26,9 @@ sources =3D files(=0D
 )=0D
 =0D
 includes +=3D include_directories('base')=0D
+includes +=3D include_directories('stn_adapt')=0D
+includes +=3D include_directories('stn_adapt')=0D
+=0D
+subdir('base')=0D
+subdir('htn_adapt')=0D
+subdir('stn_adapt')=0D
\ No newline at end of file=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.c=0D
index dfe8598f78..f41f060d17 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
@@ -94,7 +94,7 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3=
_cmd_buf *cmd_buf, uint=0D
 	return HINIC3_UCODE_CMD_MODIFY_VLAN_CTX;=0D
 }=0D
 =0D
-static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *=
nic_dev,=0D
+static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *=
nic_dev __rte_unused,=0D
 						   const uint32_t *indir_table,=0D
 						   struct hinic3_cmd_buf *cmd_buf)=0D
 {=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.h=0D
index a40c4faa89..f1720c29c7 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
@@ -35,4 +35,12 @@ struct hinic3_stn_vlan_ctx {=0D
 	uint32_t vlan_sel;=0D
 };=0D
 =0D
+/**=0D
+ * Get cmdq ops software tile NIC(stn) supported.=0D
+ *=0D
+ * @return=0D
+ * Pointer to ops.=0D
+ */=0D
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void);=0D
+=0D
 #endif /* _HINIC3_STN_CMDQ_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

