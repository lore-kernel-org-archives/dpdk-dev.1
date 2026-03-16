Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9998AF506D2
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:45:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0899D4067A;
	Mon, 16 Mar 2026 14:44:12 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 7B53A40663
 for <dev@dpdk.org>; Mon, 16 Mar 2026 14:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=dAmzBUF+lgDvfjX4JDeSJ3vN0I+quF9KCyhWbdFr0a8=;
 b=ZzlLLbZUNcUFHpcEFNC54ewC+S1XJpUz69nnaQ62krHsGwxVLfAqqUC1XKvqOI
 TsrWn1brK6CciAuc3amQuCR5vAHaaAhhvRXwf/2Mf7qPc2fa5oXokjjxL+Qgeb4a
 76I45zGkHE8FZNMhzK72QR7a9YVi98tFgfZz/Ion2p/E0=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgAXOR4WCbhpaIrGAg--.46641S11;
 Mon, 16 Mar 2026 21:44:04 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V2 7/7] net/hinic3: use different callback func to support htn fdir
Date: Mon, 16 Mar 2026 21:43:29 +0800
Message-ID: <20260316134335.1640-8-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260316134335.1640-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260316134335.1640-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgAXOR4WCbhpaIrGAg--.46641S11
X-Coremail-Antispam: 1Uf129KBjvAXoWDAFyxCF17ur4DAr1UKr48WFg_yoW3GrWUto
 WfX3y3tw1Sqw1xCa4jvw1kGF9xX3s8t3Z5Jayqkrs7Xa13ta4rtFy3AF1rJFWUuayYyFnr
 ZF97Ja40qwnrX3s7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrJ5rDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwXT3Wm4CSWNHAAA3U
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

For new SPx NIC, the way flow rules created is different from previous
SPx NIC, so use different callback func to split them.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  55 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.h      |  19 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  41 +-
 drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----
 drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--
 drivers/net/hinic3/hinic3_nic_io.h            |  16 -
 drivers/net/hinic3/hinic3_rx.c                |  26 +-
 drivers/net/hinic3/hinic3_tx.c                |  16 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    |  22 +-
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |   8 +
 drivers/net/hinic3/meson.build                |   8 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    |   2 +-
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |   8 +
 13 files changed, 888 insertions(+), 351 deletions(-)

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 22caac0457..5387626b98 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -970,7 +970,7 @@ hinic3_set_vlan_filter(struct hinic3_hwdev *hwdev, uint32_t vlan_filter_ctrl)
 
 static int
 hinic3_set_rx_lro(struct hinic3_hwdev *hwdev, uint8_t ipv4_en,
-				uint8_t ipv6_en, uint8_t lro_max_pkt_len)
+		  uint8_t ipv6_en, uint8_t lro_max_pkt_len)
 {
 	struct hinic3_cmd_lro_config lro_cfg = {0};
 	uint16_t out_size = sizeof(lro_cfg);
@@ -1029,7 +1029,7 @@ hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, uint32_t timer_value)
 }
 
 int
-hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32_t lro_timer,
+hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, bool lro_en, uint32_t lro_timer,
 			uint32_t lro_max_pkt_len)
 {
 	uint8_t ipv4_en = 0, ipv6_en = 0;
@@ -1468,54 +1468,6 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
 	return 0;
 }
 
-/**
- * Set the Ethernet type filtering rule for the FDIR of a NIC.
- *
- * @param[in] hwdev
- * Pointer to hardware device structure.
- * @param[in] pkt_type
- * Indicate the packet type.
- * @param[in] queue_id
- * Indicate the queue id.
- * @param[in] en
- * Indicate whether to add or delete an operation. 1 - add; 0 - delete.
- *
- * @return
- * 0 on success, non-zero on failure.
- */
-int
-hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,
-			 uint8_t pkt_type, uint16_t queue_id, uint8_t en)
-{
-	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;
-	uint16_t out_size = sizeof(ethertype_cmd);
-	int err;
-
-	if (!hwdev)
-		return -EINVAL;
-
-	memset(&ethertype_cmd, 0,
-	       sizeof(struct hinic3_set_fdir_ethertype_rule));
-	ethertype_cmd.func_id = hinic3_global_func_id(hwdev);
-	ethertype_cmd.pkt_type = pkt_type;
-	ethertype_cmd.pkt_type_en = en;
-	ethertype_cmd.qid = (uint8_t)queue_id;
-
-	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
-				      HINIC3_NIC_CMD_SET_FDIR_STATUS,
-				      &ethertype_cmd, sizeof(ethertype_cmd),
-				      &ethertype_cmd, &out_size);
-	if (err || ethertype_cmd.head.status || !out_size) {
-		PMD_DRV_LOG(ERR,
-			    "set fdir ethertype rule failed, err: %d, status: 0x%x, out size: 0x%x, func_id %d",
-			    err, ethertype_cmd.head.status, out_size,
-			    ethertype_cmd.func_id);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 int
 hinic3_add_tcam_rule(struct hinic3_hwdev *hwdev, struct hinic3_tcam_cfg_rule *tcam_rule,
 		     uint8_t tcam_rule_type)
@@ -1543,8 +1495,7 @@ hinic3_add_tcam_rule(struct hinic3_hwdev *hwdev, struct hinic3_tcam_cfg_rule *tc
 				      &tcam_cmd, sizeof(tcam_cmd),
 				      &tcam_cmd, &out_size);
 	if (err || tcam_cmd.msg_head.status || !out_size) {
-		PMD_DRV_LOG(ERR,
-			    "Add tcam rule failed, err: %d, status: 0x%x, out size: 0x%x",
+		PMD_DRV_LOG(ERR, "Add tcam rule failed, err: %d, status: 0x%x, out size: 0x%x",
 			    err, tcam_cmd.msg_head.status, out_size);
 		return -EIO;
 	}
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 06d5bc7d1b..6d3eb433bd 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -1203,7 +1203,7 @@ int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, uint8_t en);
  * @return
  * 0 on success, non-zero on failure.
  */
-int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32_t lro_timer,
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, bool lro_en, uint32_t lro_timer,
 			    uint32_t lro_max_pkt_len);
 
 /**
@@ -1522,8 +1522,21 @@ int hinic3_get_feature_from_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature,
  */
 int hinic3_set_feature_to_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature, uint16_t size);
 
-int hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,
-				     uint8_t pkt_type, uint16_t queue_id, uint8_t en);
+/**
+ * Set the Ethernet type filtering rule for the FDIR of a NIC.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ * @param[in] pkt_type
+ * Indicate the packet type.
+ * @param[in] ethertype_filter
+ * Pointer to ethertype_filter structure.
+ * @param[in] en
+ * Indicate whether to add or delete an operation. 1 - add; 0 - delete.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
 
 int hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 				  enum hinic3_link_follow_status status);
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index ed2edb51c1..4495ce954b 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -975,8 +975,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 			    "RX queue depth is out of range from %d to %d",
 			    HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_QUEUE_DEPTH);
 		PMD_DRV_LOG(ERR,
-				"nb_desc: %d, q_depth: %d, port: %d queue: %d",
-				nb_desc, rq_depth, dev->data->port_id, qid);
+			    "nb_desc: %d, q_depth: %d, port: %d queue: %d",
+			    nb_desc, rq_depth, dev->data->port_id, qid);
 		return -EINVAL;
 	}
 
@@ -2159,8 +2159,7 @@ hinic3_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 	}
 
 	/* Update max frame size. */
-	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) =
-		HINIC3_MTU_TO_PKTLEN(mtu);
+	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) = HINIC3_MTU_TO_PKTLEN(mtu);
 	nic_dev->mtu_size = mtu;
 	return err;
 }
@@ -2358,6 +2357,12 @@ hinic3_dev_promiscuous_enable(struct rte_eth_dev *dev)
 	uint32_t rx_mode;
 	int err;
 
+	if (!(nic_dev->feature_cap & NIC_F_PROMISC)) {
+		PMD_DRV_LOG(ERR, "nic_dev: %s, port_id: %d, do not support vf promisc: %" PRIu64 "",
+			    nic_dev->dev_name, dev->data->port_id, nic_dev->feature_cap);
+		return -ENOTSUP;
+	}
+
 	rx_mode = nic_dev->rx_mode | HINIC3_RX_MODE_PROMISC;
 
 	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
@@ -2528,20 +2533,22 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,
 	}
 
 	rss_type.ipv4 = (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
-				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER))
-				? 1
-				: 0;
+				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER)) ? 1 : 0;
 	rss_type.tcp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;
 	rss_type.ipv6 = (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
-				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER))
-				? 1
-				: 0;
-	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
+				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER)) ? 1 : 0;
 	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
-	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
 	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
 	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
 
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
+		rss_type.ipv6_ext = rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
+		rss_type.tcp_ipv6_ext = rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
+	} else {
+		rss_type.ipv6_ext = 0;
+		rss_type.ipv6_ext = 0;
+	}
+
 	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
 	if (err)
 		PMD_DRV_LOG(ERR, "Set RSS type failed");
@@ -2598,12 +2605,16 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
 	rss_conf->rss_hf |=
 		rss_type.ipv6 ? (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
 				 RTE_ETH_RSS_NONFRAG_IPV6_OTHER) : 0;
-	rss_conf->rss_hf |= rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
 	rss_conf->rss_hf |= rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP : 0;
-	rss_conf->rss_hf |= rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
 	rss_conf->rss_hf |= rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP : 0;
 	rss_conf->rss_hf |= rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP : 0;
-
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
+		rss_conf->rss_hf |= rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
+		rss_conf->rss_hf |= rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
+	} else {
+		rss_conf->rss_hf |= 0;
+		rss_conf->rss_hf |= 0;
+	}
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
index 263a281729..37a4f0cf52 100644
--- a/drivers/net/hinic3/hinic3_fdir.c
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -2,15 +2,15 @@
  * Copyright(c) 2025 Huawei Technologies Co., Ltd
  */
 
+#include "base/hinic3_cmd.h"
 #include "base/hinic3_compat.h"
 #include "base/hinic3_hwdev.h"
 #include "base/hinic3_hwif.h"
 #include "base/hinic3_nic_cfg.h"
 #include "hinic3_ethdev.h"
+#include "hinic3_nic_io.h"
 
-#define HINIC3_UINT1_MAX  0x1
-#define HINIC3_UINT4_MAX  0xf
-#define HINIC3_UINT15_MAX 0x7fff
+#define HINIC3_INVALID_INDEX	-1
 
 #define HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev) \
 	(&((struct hinic3_nic_dev *)(nic_dev))->tcam)
@@ -77,6 +77,8 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	tcam_key->key_mask.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info.vlan_flag = 0;
 
 	/* Fill src IPv4. */
 	tcam_key->key_mask.sipv4_h =
@@ -99,15 +101,9 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);
 }
 
-static void
-hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
-			   struct hinic3_tcam_key *tcam_key)
+static void hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *rule,
+					       struct hinic3_tcam_key *tcam_key)
 {
-	/* Fill type of ip. */
-	tcam_key->key_mask_ipv6.ip_type = HINIC3_UINT1_MAX;
-	tcam_key->key_info_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
-
-	/* Fill src IPv6. */
 	tcam_key->key_mask_ipv6.sipv6_key0 =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
 	tcam_key->key_mask_ipv6.sipv6_key1 =
@@ -140,8 +136,11 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
 	tcam_key->key_info_ipv6.sipv6_key7 =
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
+}
 
-	/* Fill dst IPv6. */
+static void hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *rule,
+					       struct hinic3_tcam_key *tcam_key)
+{
 	tcam_key->key_mask_ipv6.dipv6_key0 =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
 	tcam_key->key_mask_ipv6.dipv6_key1 =
@@ -176,6 +175,26 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
 }
 
+static void hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule,
+					   struct hinic3_tcam_key *tcam_key)
+{
+	hinic3_fdir_ipv6_tcam_key_init_sip(rule, tcam_key);
+	hinic3_fdir_ipv6_tcam_key_init_dip(rule, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
+			   struct hinic3_tcam_key *tcam_key)
+{
+	/* Fill type of ip. */
+	tcam_key->key_mask_ipv6.ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+	tcam_key->key_mask_ipv6.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6.vlan_flag = 0;
+
+	hinic3_fdir_ipv6_tcam_key_init(rule, tcam_key);
+}
+
 /**
  * Set the TCAM information in notunnel scenario.
  *
@@ -204,6 +223,10 @@ hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *dev,
 	tcam_key->key_info.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 
 	tcam_key->key_mask.function_id = HINIC3_UINT15_MAX;
+
+	tcam_key->key_mask.vlan_flag = 1;
+	tcam_key->key_info.vlan_flag = 0;
+
 	tcam_key->key_info.function_id = hinic3_global_func_id(nic_dev->hwdev) &
 					 HINIC3_UINT15_MAX;
 
@@ -223,6 +246,8 @@ hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	tcam_key->key_mask.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info.vlan_flag = 0;
 
 	/* Fill src ipv4. */
 	tcam_key->key_mask.sipv4_h =
@@ -252,6 +277,8 @@ hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask_vxlan_ipv6.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info_vxlan_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+	tcam_key->key_mask_vxlan_ipv6.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info_vxlan_ipv6.vlan_flag = 0;
 
 	/* Use inner dst ipv6 to fill the dst ipv6 of tcam_key. */
 	tcam_key->key_mask_vxlan_ipv6.dipv6_key0 =
@@ -288,77 +315,6 @@ hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x3]);
 }
 
-static void
-hinic3_fdir_tcam_outer_ipv6_init(struct hinic3_fdir_filter *rule,
-				 struct hinic3_tcam_key *tcam_key)
-{
-	tcam_key->key_mask_ipv6.sipv6_key0 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
-	tcam_key->key_mask_ipv6.sipv6_key1 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
-	tcam_key->key_mask_ipv6.sipv6_key2 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);
-	tcam_key->key_mask_ipv6.sipv6_key3 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);
-	tcam_key->key_mask_ipv6.sipv6_key4 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);
-	tcam_key->key_mask_ipv6.sipv6_key5 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);
-	tcam_key->key_mask_ipv6.sipv6_key6 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);
-	tcam_key->key_mask_ipv6.sipv6_key7 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);
-	tcam_key->key_info_ipv6.sipv6_key0 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0]);
-	tcam_key->key_info_ipv6.sipv6_key1 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0]);
-	tcam_key->key_info_ipv6.sipv6_key2 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);
-	tcam_key->key_info_ipv6.sipv6_key3 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);
-	tcam_key->key_info_ipv6.sipv6_key4 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);
-	tcam_key->key_info_ipv6.sipv6_key5 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);
-	tcam_key->key_info_ipv6.sipv6_key6 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
-	tcam_key->key_info_ipv6.sipv6_key7 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
-
-	tcam_key->key_mask_ipv6.dipv6_key0 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
-	tcam_key->key_mask_ipv6.dipv6_key1 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
-	tcam_key->key_mask_ipv6.dipv6_key2 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);
-	tcam_key->key_mask_ipv6.dipv6_key3 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);
-	tcam_key->key_mask_ipv6.dipv6_key4 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);
-	tcam_key->key_mask_ipv6.dipv6_key5 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);
-	tcam_key->key_mask_ipv6.dipv6_key6 =
-		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);
-	tcam_key->key_mask_ipv6.dipv6_key7 =
-		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);
-	tcam_key->key_info_ipv6.dipv6_key0 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);
-	tcam_key->key_info_ipv6.dipv6_key1 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);
-	tcam_key->key_info_ipv6.dipv6_key2 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);
-	tcam_key->key_info_ipv6.dipv6_key3 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);
-	tcam_key->key_info_ipv6.dipv6_key4 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);
-	tcam_key->key_info_ipv6.dipv6_key5 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);
-	tcam_key->key_info_ipv6.dipv6_key6 =
-		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
-	tcam_key->key_info_ipv6.dipv6_key7 =
-		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
-}
-
 static void
 hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
 				 struct hinic3_fdir_filter *rule,
@@ -370,11 +326,14 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
 	tcam_key->key_info_ipv6.ip_proto = rule->key_spec.proto;
 
 	tcam_key->key_mask_ipv6.tunnel_type = HINIC3_UINT4_MAX;
-	tcam_key->key_info_ipv6.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+	tcam_key->key_info_ipv6.tunnel_type = rule->tunnel_type;
 
 	tcam_key->key_mask_ipv6.outer_ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info_ipv6.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
 
+	tcam_key->key_mask_ipv6.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6.vlan_flag = 0;
+
 	tcam_key->key_mask_ipv6.function_id = HINIC3_UINT15_MAX;
 	tcam_key->key_info_ipv6.function_id =
 		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT15_MAX;
@@ -386,7 +345,7 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
 	tcam_key->key_info_ipv6.sport = rule->key_spec.src_port;
 
 	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_ANY)
-		hinic3_fdir_tcam_outer_ipv6_init(rule, tcam_key);
+		hinic3_fdir_ipv6_tcam_key_init(rule, tcam_key);
 }
 
 /**
@@ -448,9 +407,11 @@ hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);
 
 	tcam_key->key_mask.tunnel_type = HINIC3_UINT4_MAX;
-	tcam_key->key_info.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+	tcam_key->key_info.tunnel_type = rule->tunnel_type;
 
+	tcam_key->key_mask.vlan_flag = 1;
 	tcam_key->key_mask.function_id = HINIC3_UINT15_MAX;
+	tcam_key->key_info.vlan_flag = 0;
 	tcam_key->key_info.function_id = hinic3_global_func_id(nic_dev->hwdev) &
 					 HINIC3_UINT15_MAX;
 
@@ -479,6 +440,259 @@ hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,
 	tcam_key_calculate(tcam_key, fdir_tcam_rule);
 }
 
+static void
+hinic3_fdir_tcam_key_set_ipv4_sip_dip(struct rte_eth_ipv4_flow *ipv4_mask,
+				      struct rte_eth_ipv4_flow *ipv4_spec,
+				      struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.sipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->src_ip);
+	tcam_key->key_mask_htn.sipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->src_ip);
+	tcam_key->key_info_htn.sipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->src_ip);
+	tcam_key->key_info_htn.sipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->src_ip);
+
+	tcam_key->key_mask_htn.dipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->dst_ip);
+	tcam_key->key_mask_htn.dipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->dst_ip);
+	tcam_key->key_info_htn.dipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->dst_ip);
+	tcam_key->key_info_htn.dipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->dst_ip);
+}
+
+static void
+hinic3_fdir_tcam_key_set_ipv6_sip(struct rte_eth_ipv6_flow *ipv6_mask,
+				  struct rte_eth_ipv6_flow *ipv6_spec,
+				  struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6_htn.sipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0x1]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0x1]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0x2]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0x2]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->src_ip[0x3]);
+	tcam_key->key_mask_ipv6_htn.sipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->src_ip[0x3]);
+	tcam_key->key_info_ipv6_htn.sipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0]);
+	tcam_key->key_info_ipv6_htn.sipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0]);
+	tcam_key->key_info_ipv6_htn.sipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0x1]);
+	tcam_key->key_info_ipv6_htn.sipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0x1]);
+	tcam_key->key_info_ipv6_htn.sipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0x2]);
+	tcam_key->key_info_ipv6_htn.sipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0x2]);
+	tcam_key->key_info_ipv6_htn.sipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->src_ip[0x3]);
+	tcam_key->key_info_ipv6_htn.sipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->src_ip[0x3]);
+}
+
+static void
+hinic3_fdir_tcam_key_set_ipv6_dip(struct rte_eth_ipv6_flow *ipv6_mask,
+				  struct rte_eth_ipv6_flow *ipv6_spec,
+				  struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6_htn.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0x1]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0x1]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0x2]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0x2]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(ipv6_mask->dst_ip[0x3]);
+	tcam_key->key_mask_ipv6_htn.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(ipv6_mask->dst_ip[0x3]);
+	tcam_key->key_info_ipv6_htn.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0]);
+	tcam_key->key_info_ipv6_htn.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0]);
+	tcam_key->key_info_ipv6_htn.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0x1]);
+	tcam_key->key_info_ipv6_htn.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0x1]);
+	tcam_key->key_info_ipv6_htn.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0x2]);
+	tcam_key->key_info_ipv6_htn.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0x2]);
+	tcam_key->key_info_ipv6_htn.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(ipv6_spec->dst_ip[0x3]);
+	tcam_key->key_info_ipv6_htn.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(ipv6_spec->dst_ip[0x3]);
+}
+
+static void
+hinic3_fdir_tcam_key_set_outer_ipv4_sip_dip(struct rte_eth_ipv4_flow *ipv4_mask,
+					    struct rte_eth_ipv4_flow *ipv4_spec,
+					    struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.outer_sipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->src_ip);
+	tcam_key->key_mask_htn.outer_sipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->src_ip);
+	tcam_key->key_info_htn.outer_sipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->src_ip);
+	tcam_key->key_info_htn.outer_sipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->src_ip);
+
+	tcam_key->key_mask_htn.outer_dipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_mask->dst_ip);
+	tcam_key->key_mask_htn.outer_dipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_mask->dst_ip);
+	tcam_key->key_info_htn.outer_dipv4_h =
+		HINIC3_32_UPPER_16_BITS(ipv4_spec->dst_ip);
+	tcam_key->key_info_htn.outer_dipv4_l =
+		HINIC3_32_LOWER_16_BITS(ipv4_spec->dst_ip);
+}
+
+static void
+hinic3_fdir_tcam_key_set_ipv4_info(struct hinic3_fdir_filter *rule,
+				   struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	hinic3_fdir_tcam_key_set_ipv4_sip_dip(&rule->key_mask.ipv4,
+					      &rule->key_spec.ipv4, tcam_key);
+}
+
+static void hinic3_fdir_tcam_key_set_ipv6_info(struct hinic3_fdir_filter *rule,
+					       struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_ipv6_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	hinic3_fdir_tcam_key_set_ipv6_sip(&rule->key_mask.ipv6,
+					  &rule->key_spec.ipv6, tcam_key);
+	hinic3_fdir_tcam_key_set_ipv6_dip(&rule->key_mask.ipv6,
+					  &rule->key_spec.ipv6, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_notunnel_htn_init(struct hinic3_fdir_filter *rule,
+				   struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.tunnel_type = HINIC3_UINT3_MAX;
+	tcam_key->key_info_htn.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+
+	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV4)
+		hinic3_fdir_tcam_key_set_ipv4_info(rule, tcam_key);
+	else if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV6)
+		hinic3_fdir_tcam_key_set_ipv6_info(rule, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_key_set_outer_ipv4_info(struct hinic3_fdir_filter *rule,
+					 struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6_htn.outer_ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6_htn.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	hinic3_fdir_tcam_key_set_outer_ipv4_sip_dip(&rule->key_mask.ipv4,
+						    &rule->key_spec.ipv4, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_key_set_inner_ipv4_info(struct hinic3_fdir_filter *rule,
+					 struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	hinic3_fdir_tcam_key_set_ipv4_sip_dip(&rule->key_mask.inner_ipv4,
+					      &rule->key_spec.inner_ipv4, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_key_set_inner_ipv6_info(struct hinic3_fdir_filter *rule,
+					 struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_vxlan_ipv6_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_vxlan_ipv6_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	hinic3_fdir_tcam_key_set_ipv6_dip(&rule->key_mask.inner_ipv6,
+					  &rule->key_spec.inner_ipv6, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_tunnel_htn_init(struct hinic3_fdir_filter *rule,
+				 struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.tunnel_type = HINIC3_UINT3_MAX;
+	tcam_key->key_info_htn.tunnel_type = rule->tunnel_type;
+
+	tcam_key->key_mask_htn.vni_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.tunnel.tunnel_id);
+	tcam_key->key_mask_htn.vni_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.tunnel.tunnel_id);
+	tcam_key->key_info_htn.vni_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.tunnel.tunnel_id);
+	tcam_key->key_info_htn.vni_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);
+
+	if (rule->outer_ip_type == HINIC3_FDIR_IP_TYPE_IPV4)
+		hinic3_fdir_tcam_key_set_outer_ipv4_info(rule, tcam_key);
+
+	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV4)
+		hinic3_fdir_tcam_key_set_inner_ipv4_info(rule, tcam_key);
+	else if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV6)
+		hinic3_fdir_tcam_key_set_inner_ipv6_info(rule, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_info_htn_init(struct rte_eth_dev *dev,
+			       struct hinic3_fdir_filter *rule,
+			       struct hinic3_tcam_key *tcam_key,
+			       struct hinic3_tcam_cfg_rule *fdir_tcam_rule)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	tcam_key->key_mask_htn.function_id_h = HINIC3_UINT5_MAX;
+	tcam_key->key_mask_htn.function_id_l = HINIC3_UINT5_MAX;
+	tcam_key->key_info_htn.function_id_l =
+		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT5_MAX;
+	tcam_key->key_info_htn.function_id_h =
+		(hinic3_global_func_id(nic_dev->hwdev) >> HINIC3_UINT5_WIDTH) & HINIC3_UINT5_MAX;
+
+	tcam_key->key_mask_htn.ip_proto = rule->key_mask.proto;
+	tcam_key->key_info_htn.ip_proto = rule->key_spec.proto;
+
+	tcam_key->key_mask_htn.sport = rule->key_mask.src_port;
+	tcam_key->key_info_htn.sport = rule->key_spec.src_port;
+
+	tcam_key->key_mask_htn.dport = rule->key_mask.dst_port;
+	tcam_key->key_info_htn.dport = rule->key_spec.dst_port;
+	if (rule->tunnel_type == HINIC3_FDIR_TUNNEL_MODE_NORMAL)
+		hinic3_fdir_tcam_notunnel_htn_init(rule, tcam_key);
+	else
+		hinic3_fdir_tcam_tunnel_htn_init(rule, tcam_key);
+
+	fdir_tcam_rule->data.qid = rule->rq_index;
+
+	tcam_key_calculate(tcam_key, fdir_tcam_rule);
+}
+
 /**
  * Find filter in given ethertype filter list.
  *
@@ -513,19 +727,30 @@ hinic3_ethertype_filter_lookup(struct hinic3_ethertype_filter_list *ethertype_li
  * Point to the tcam filter list.
  * @param[in] key
  * The tcam key to find.
+ * @param[in] action_type
+ * The type of action.
+ * @param[in] tcam_index
+ * The index of tcam.
  * @return
  * If a matching filter is found, the filter is returned, otherwise NULL.
  */
 static inline struct hinic3_tcam_filter *
 hinic3_tcam_filter_lookup(struct hinic3_tcam_filter_list *filter_list,
-			  struct hinic3_tcam_key *key)
+			  struct hinic3_tcam_key *key,
+			  uint8_t action_type, uint16_t tcam_index)
 {
 	struct hinic3_tcam_filter *it;
 
-	TAILQ_FOREACH(it, filter_list, entries) {
-		if (memcmp(key, &it->tcam_key,
-			   sizeof(struct hinic3_tcam_key)) == 0) {
-			return it;
+	if (action_type == HINIC3_ACTION_ADD) {
+		TAILQ_FOREACH(it, filter_list, entries) {
+			if (memcmp(key, &it->tcam_key, sizeof(struct hinic3_tcam_key)) == 0)
+				return it;
+		}
+	} else {
+		TAILQ_FOREACH(it, filter_list, entries) {
+			if (tcam_index ==
+			   (it->index + HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(it->dynamic_block_id)))
+				return it;
 		}
 	}
 
@@ -588,25 +813,18 @@ hinic3_free_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,
  *
  * @param[in] dev
  * Pointer to ethernet device structure.
- * @param[in] fdir_tcam_rule
- * Indicate the filtering rule to be searched for.
  * @param[in] tcam_info
  * Ternary Content-Addressable Memory (TCAM) information.
- * @param[in] tcam_filter
- * Point to the TCAM filter.
  * @param[out] tcam_index
  * Indicate the TCAM index to be searched for.
  * @result
  * Pointer to the TCAM dynamic block. If the search fails, NULL is returned.
  */
 static struct hinic3_tcam_dynamic_block *
-hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
-				  struct hinic3_tcam_cfg_rule *fdir_tcam_rule,
+hinic3_dynamic_lookup_tcam_filter(struct hinic3_nic_dev *nic_dev,
 				  struct hinic3_tcam_info *tcam_info,
-				  struct hinic3_tcam_filter *tcam_filter,
 				  uint16_t *tcam_index)
 {
-	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	uint16_t block_cnt = tcam_info->tcam_dynamic_info.dynamic_block_cnt;
 	struct hinic3_tcam_dynamic_block *dynamic_block_ptr = NULL;
 	struct hinic3_tcam_dynamic_block *tmp = NULL;
@@ -616,6 +834,8 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
 	uint16_t index;
 	int err;
 
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0)
+		rule_nums += nic_dev->ethertype_rule_nums;
 	/*
 	 * Check whether the number of filtering rules reaches the maximum
 	 * capacity of dynamic TCAM blocks.
@@ -662,8 +882,7 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
 
 	if (tmp == NULL ||
 	    tmp->dynamic_index_cnt >= HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {
-		PMD_DRV_LOG(ERR,
-			    "Fdir filter dynamic lookup for index failed!");
+		PMD_DRV_LOG(ERR, "Fdir filter dynamic lookup for index failed!");
 		goto look_up_failed;
 	}
 
@@ -674,20 +893,13 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
 
 	/* Find the first free position. */
 	if (index == HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {
-		PMD_DRV_LOG(ERR,
-			    "tcam block 0x%x supports filter rules is full!",
+		PMD_DRV_LOG(ERR, "tcam block 0x%x supports filter rules is full!",
 			    tmp->dynamic_block_id);
 		goto look_up_failed;
 	}
 
-	tcam_filter->dynamic_block_id = tmp->dynamic_block_id;
-	tcam_filter->index = index;
 	*tcam_index = index;
 
-	fdir_tcam_rule->index =
-		HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tmp->dynamic_block_id) +
-		index;
-
 	return tmp;
 
 look_up_failed:
@@ -702,6 +914,107 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
 	return NULL;
 }
 
+static void
+hinic3_tcam_index_free(struct hinic3_nic_dev *nic_dev, uint16_t index, uint16_t block_id)
+{
+	struct hinic3_tcam_info *tcam_info = HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev);
+	struct hinic3_tcam_dynamic_block *tmp = NULL;
+
+	TAILQ_FOREACH(tmp, &tcam_info->tcam_dynamic_info.tcam_dynamic_list, entries) {
+			if (tmp->dynamic_block_id == block_id)
+				break;
+	}
+
+	if (tmp == NULL || tmp->dynamic_block_id != block_id) {
+		PMD_DRV_LOG(ERR, "Fdir filter del dynamic lookup for block failed!");
+		return;
+	}
+
+	tmp->dynamic_index[index] = 0;
+	tmp->dynamic_index_cnt--;
+	if (tmp->dynamic_index_cnt == 0) {
+		hinic3_free_tcam_block(nic_dev->hwdev, &block_id);
+		hinic3_free_dynamic_block_resource(tcam_info, tmp);
+	}
+}
+
+static uint16_t
+hinic3_tcam_alloc_index(void *dev, uint16_t *block_id)
+{
+	struct hinic3_nic_dev *nic_dev = (struct hinic3_nic_dev *)dev;
+	struct hinic3_tcam_info *tcam_info = HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev);
+	struct hinic3_tcam_dynamic_block *tmp = NULL;
+	uint16_t index = 0;
+
+	tmp = hinic3_dynamic_lookup_tcam_filter(nic_dev, tcam_info, &index);
+	if (tmp == NULL) {
+		PMD_DRV_LOG(ERR, "Dynamic lookup tcam filter failed!");
+		return HINIC3_TCAM_INVALID_INDEX;
+	}
+
+	tmp->dynamic_index[index] = 1;
+	tmp->dynamic_index_cnt++;
+
+	*block_id = tmp->dynamic_block_id;
+
+	return index;
+}
+
+static int
+hinic3_set_fdir_ethertype_filter(void *hwdev, uint8_t pkt_type, void *filter, uint8_t en)
+{
+	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;
+	struct hinic3_ethertype_filter *ethertype_filter = (struct hinic3_ethertype_filter *)filter;
+	uint16_t out_size = sizeof(ethertype_cmd);
+	uint16_t block_id;
+	uint32_t index = 0;
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+	struct hinic3_nic_dev *nic_dev =
+		(struct hinic3_nic_dev *)((struct hinic3_hwdev *)hwdev)->dev_handle;
+
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0) {
+		if (en != 0) {
+			index = hinic3_tcam_alloc_index(nic_dev, &block_id);
+			if (index == HINIC3_TCAM_INVALID_INDEX)
+				return -ENOMEM;
+			index += HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_id);
+		} else {
+			index = ethertype_filter->tcam_index[pkt_type];
+		}
+	}
+
+	memset(&ethertype_cmd, 0, sizeof(struct hinic3_set_fdir_ethertype_rule));
+	ethertype_cmd.func_id = hinic3_global_func_id(hwdev);
+	ethertype_cmd.pkt_type = pkt_type;
+	ethertype_cmd.pkt_type_en = en;
+	ethertype_cmd.index = index;
+	ethertype_cmd.qid = (uint8_t)ethertype_filter->queue;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
+				     HINIC3_NIC_CMD_SET_FDIR_STATUS,
+				     &ethertype_cmd, sizeof(ethertype_cmd),
+				     &ethertype_cmd, &out_size);
+	if (err || ethertype_cmd.head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "set fdir ethertype rule failed, err: %d, status: 0x%x, out size: 0x%x, func_id %d",
+			    err, ethertype_cmd.head.status, out_size, ethertype_cmd.func_id);
+		return -EIO;
+	}
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0) {
+		if (en == 0) {
+			hinic3_tcam_index_free(nic_dev, HINIC3_TCAM_GET_INDEX_IN_BLOCK(index),
+					       HINIC3_TCAM_GET_DYNAMIC_BLOCK_INDEX(index));
+		} else {
+			ethertype_filter->tcam_index[pkt_type] = index;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * Add a TCAM filter.
  *
@@ -722,11 +1035,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 	struct hinic3_tcam_info *tcam_info =
 		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	struct hinic3_tcam_dynamic_block *dynamic_block_ptr = NULL;
-	struct hinic3_tcam_dynamic_block *tmp = NULL;
 	struct hinic3_tcam_filter *tcam_filter;
-	uint16_t tcam_block_index = 0;
-	uint16_t index = 0;
 	int err;
 
 	/* Alloc TCAM filter memory. */
@@ -737,39 +1046,14 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 
 	tcam_filter->tcam_key = *tcam_key;
 	tcam_filter->queue = (uint16_t)(fdir_tcam_rule->data.qid);
-
-	/* Add new TCAM rules. */
-	if (nic_dev->tcam_rule_nums == 0) {
-		err = hinic3_alloc_tcam_block(nic_dev->hwdev, &tcam_block_index);
-		if (err) {
-			PMD_DRV_LOG(ERR,
-				    "Fdir filter tcam alloc block failed!");
-			goto failed;
-		}
-
-		dynamic_block_ptr =
-			hinic3_alloc_dynamic_block_resource(tcam_info,
-							    tcam_block_index);
-		if (dynamic_block_ptr == NULL) {
-			PMD_DRV_LOG(ERR, "Fdir filter alloc dynamic first block memory failed!");
-			goto alloc_block_failed;
-		}
-	}
-
-	/*
-	 * Look for an available index in the dynamic block to store the new
-	 * TCAM filter.
-	 */
-	tmp = hinic3_dynamic_lookup_tcam_filter(dev, fdir_tcam_rule, tcam_info,
-						tcam_filter, &index);
-	if (tmp == NULL) {
-		PMD_DRV_LOG(ERR, "Dynamic lookup tcam filter failed!");
-		goto lookup_tcam_index_failed;
-	}
+	tcam_filter->index = hinic3_tcam_alloc_index(nic_dev, &tcam_filter->dynamic_block_id);
+	if (tcam_filter->index == HINIC3_TCAM_INVALID_INDEX)
+		goto failed;
+	fdir_tcam_rule->index = HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tcam_filter->dynamic_block_id) +
+								    tcam_filter->index;
 
 	/* Add a new TCAM rule to the network device. */
-	err = hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule,
-				   TCAM_RULE_FDIR_TYPE);
+	err = hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule, TCAM_RULE_FDIR_TYPE);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Fdir_tcam_rule add failed!");
 		goto add_tcam_rules_failed;
@@ -785,10 +1069,6 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 	/* Add a filter to the end of the queue. */
 	TAILQ_INSERT_TAIL(&tcam_info->tcam_list, tcam_filter, entries);
 
-	/* Update dynamic index. */
-	tmp->dynamic_index[index] = 1;
-	tmp->dynamic_index_cnt++;
-
 	nic_dev->tcam_rule_nums++;
 
 	PMD_DRV_LOG(INFO,
@@ -796,7 +1076,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 		    hinic3_global_func_id(nic_dev->hwdev));
 	PMD_DRV_LOG(INFO,
 		    "tcam_block_id: %d, local_index: %d, global_index: %d, queue: %d, tcam_rule_nums: %d",
-		    tcam_filter->dynamic_block_id, index, fdir_tcam_rule->index,
+		    tcam_filter->dynamic_block_id, tcam_filter->index, fdir_tcam_rule->index,
 		    fdir_tcam_rule->data.qid, nic_dev->tcam_rule_nums);
 	return 0;
 
@@ -806,14 +1086,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 			     TCAM_RULE_FDIR_TYPE);
 
 add_tcam_rules_failed:
-lookup_tcam_index_failed:
-	if (nic_dev->tcam_rule_nums == 0 && dynamic_block_ptr != NULL)
-		hinic3_free_dynamic_block_resource(tcam_info,
-						   dynamic_block_ptr);
-
-alloc_block_failed:
-	if (nic_dev->tcam_rule_nums == 0)
-		hinic3_free_tcam_block(nic_dev->hwdev, &tcam_block_index);
+	hinic3_tcam_index_free(nic_dev, tcam_filter->index, tcam_filter->dynamic_block_id);
 
 failed:
 	rte_free(tcam_filter);
@@ -850,8 +1123,7 @@ hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *dev,
 	}
 
 	if (tmp == NULL || tmp->dynamic_block_id != dynamic_block_id) {
-		PMD_DRV_LOG(ERR,
-			    "Fdir filter del dynamic lookup for block failed!");
+		PMD_DRV_LOG(ERR, "Fdir filter del dynamic lookup for block failed!");
 		return -EINVAL;
 	}
 	/* Calculate TCAM index. */
@@ -873,14 +1145,9 @@ hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *dev,
 		    dynamic_block_id, tcam_filter->index, index,
 		    tmp->dynamic_index_cnt - 1, nic_dev->tcam_rule_nums - 1);
 
-	tmp->dynamic_index[tcam_filter->index] = 0;
-	tmp->dynamic_index_cnt--;
-	nic_dev->tcam_rule_nums--;
-	if (tmp->dynamic_index_cnt == 0) {
-		hinic3_free_tcam_block(nic_dev->hwdev, &dynamic_block_id);
+	hinic3_tcam_index_free(nic_dev, tcam_filter->index, tmp->dynamic_block_id);
 
-		hinic3_free_dynamic_block_resource(tcam_info, tmp);
-	}
+	nic_dev->tcam_rule_nums--;
 
 	/* If the number of rules is 0, the TCAM filter is disabled. */
 	if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums))
@@ -930,6 +1197,7 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 				struct hinic3_fdir_filter *fdir_filter,
 				bool add)
 {
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_tcam_info *tcam_info =
 		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
 	struct hinic3_tcam_filter *tcam_filter;
@@ -940,11 +1208,15 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 	memset(&fdir_tcam_rule, 0, sizeof(struct hinic3_tcam_cfg_rule));
 	memset((void *)&tcam_key, 0, sizeof(struct hinic3_tcam_key));
 
-	hinic3_fdir_tcam_info_init(dev, fdir_filter, &tcam_key,
-				   &fdir_tcam_rule);
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) == 0)
+		hinic3_fdir_tcam_info_init(dev, fdir_filter, &tcam_key, &fdir_tcam_rule);
+	else
+		hinic3_fdir_tcam_info_htn_init(dev, fdir_filter, &tcam_key, &fdir_tcam_rule);
+
 	/* Search for a filter. */
 	tcam_filter =
-		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key);
+		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key,
+					  HINIC3_ACTION_ADD, HINIC3_INVALID_INDEX);
 	if (tcam_filter != NULL && add) {
 		PMD_DRV_LOG(ERR, "Filter exists.");
 		return -EEXIST;
@@ -965,6 +1237,13 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 
 		fdir_filter->tcam_index = (int)(fdir_tcam_rule.index);
 	} else {
+		tcam_filter = hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key,
+							HINIC3_ACTION_NOT_ADD,
+							fdir_filter->tcam_index);
+		if (tcam_filter == NULL) {
+			PMD_DRV_LOG(ERR, "Filter doesn't exist.");
+			return -ENOENT;
+		}
 		PMD_DRV_LOG(INFO, "begin to del tcam filter");
 		ret = hinic3_del_tcam_filter(dev, tcam_filter);
 		if (ret)
@@ -1088,7 +1367,7 @@ hinic3_free_fdir_filter(struct rte_eth_dev *dev)
 
 static int
 hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
-			   struct rte_eth_ethertype_filter *ethertype_filter,
+			   struct hinic3_ethertype_filter *ethertype_filter,
 			   bool add)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -1097,7 +1376,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 	/* Setting the ARP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_ARP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1107,7 +1386,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 	/* Setting the ARP Request Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_ARP_REQ,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s arp request rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1117,7 +1396,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 	/* Setting the ARP Response Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_ARP_REP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s arp response rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1129,19 +1408,19 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 set_arp_rep_failed:
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					 HINIC3_PKT_TYPE_ARP_REQ,
-					 ethertype_filter->queue, !add);
+					 ethertype_filter, !add);
 
 set_arp_req_failed:
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					 HINIC3_PKT_TYPE_ARP,
-					 ethertype_filter->queue, !add);
+					 ethertype_filter, !add);
 
 	return ret;
 }
 
 static int
 hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
-			    struct rte_eth_ethertype_filter *ethertype_filter,
+			    struct hinic3_ethertype_filter *ethertype_filter,
 			    bool add)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -1150,7 +1429,7 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
 	/* Setting the LACP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_LACP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s lacp fdir rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1160,7 +1439,7 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
 	/* Setting the OAM Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_OAM,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s oam rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1172,14 +1451,14 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
 set_arp_oam_failed:
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					 HINIC3_PKT_TYPE_LACP,
-					 ethertype_filter->queue, !add);
+					 ethertype_filter, !add);
 
 	return ret;
 }
 
 static int
 hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
-			    struct rte_eth_ethertype_filter *ethertype_filter,
+			    struct hinic3_ethertype_filter *ethertype_filter,
 			    bool add)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -1188,7 +1467,7 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
 	/* Setting the LLDP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_LLDP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s lldp fdir rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1198,7 +1477,7 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
 	/* Setting the CDCP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_CDCP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s cdcp fdir rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1210,14 +1489,14 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
 set_arp_cdcp_failed:
 	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					 HINIC3_PKT_TYPE_LLDP,
-					 ethertype_filter->queue, !add);
+					 ethertype_filter, !add);
 
 	return ret;
 }
 
 static int
 hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
-					  struct rte_eth_ethertype_filter *ethertype_filter,
+					  struct hinic3_ethertype_filter *ethertype_filter,
 					  bool add)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -1245,7 +1524,7 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
 		return hinic3_flow_set_arp_filter(dev, ethertype_filter, add);
 	case RTE_ETHER_TYPE_RARP:
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
-			HINIC3_PKT_TYPE_RARP, ethertype_filter->queue, add);
+			HINIC3_PKT_TYPE_RARP, ethertype_filter, add);
 
 	case RTE_ETHER_TYPE_SLOW:
 		return hinic3_flow_set_slow_filter(dev, ethertype_filter, add);
@@ -1255,11 +1534,11 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
 
 	case RTE_ETHER_TYPE_CNM:
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
-			HINIC3_PKT_TYPE_CNM, ethertype_filter->queue, add);
+			HINIC3_PKT_TYPE_CNM, ethertype_filter, add);
 
 	case RTE_ETHER_TYPE_ECP:
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
-			HINIC3_PKT_TYPE_ECP, ethertype_filter->queue, add);
+			HINIC3_PKT_TYPE_ECP, ethertype_filter, add);
 
 	default:
 		PMD_DRV_LOG(ERR, "Unknown ethertype %d queue_id %d",
@@ -1270,7 +1549,7 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
 }
 
 static int
-hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype_filter)
+hinic3_flow_ethertype_rule_nums(struct hinic3_ethertype_filter *ethertype_filter)
 {
 	switch (ethertype_filter->ether_type) {
 	case RTE_ETHER_TYPE_ARP:
@@ -1309,7 +1588,7 @@ hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype_filte
  */
 int
 hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,
-				     struct rte_eth_ethertype_filter *ethertype_filter,
+				     struct hinic3_ethertype_filter *ethertype_filter,
 				     bool add)
 {
 	/* Get dev private info. */
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_fdir.h
index 8659f588d9..277d89d4fd 100644
--- a/drivers/net/hinic3/hinic3_fdir.h
+++ b/drivers/net/hinic3/hinic3_fdir.h
@@ -14,6 +14,30 @@
 #define HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_index) \
 	(HINIC3_TCAM_DYNAMIC_BLOCK_SIZE * (block_index))
 
+#define HINIC3_TCAM_GET_DYNAMIC_BLOCK_INDEX(index) \
+		((index) / HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)
+
+#define HINIC3_TCAM_GET_INDEX_IN_BLOCK(index) \
+		((index) % HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)
+
+#define HINIC3_TCAM_INVALID_INDEX 0xFFFF
+
+enum hinic3_ether_type {
+	HINIC3_PKT_TYPE_ARP = 1,
+	HINIC3_PKT_TYPE_ARP_REQ,
+	HINIC3_PKT_TYPE_ARP_REP,
+	HINIC3_PKT_TYPE_RARP,
+	HINIC3_PKT_TYPE_LACP,
+	HINIC3_PKT_TYPE_LLDP,
+	HINIC3_PKT_TYPE_OAM,
+	HINIC3_PKT_TYPE_CDCP,
+	HINIC3_PKT_TYPE_CNM,
+	HINIC3_PKT_TYPE_ECP = 10,
+	HINIC3_PKT_TYPE_BUTT,
+
+	HINIC3_PKT_UNKNOWN = 31,
+};
+
 /* Indicate a traffic filtering rule. */
 struct rte_flow {
 	TAILQ_ENTRY(rte_flow) node;
@@ -30,6 +54,8 @@ struct hinic3_fdir_rule_key {
 	uint16_t src_port;
 	uint16_t dst_port;
 	uint8_t proto;
+	uint8_t vlan_flag;
+	uint16_t ether_type;
 };
 
 struct hinic3_fdir_filter {
@@ -42,17 +68,34 @@ struct hinic3_fdir_filter {
 	uint32_t rq_index; /**< Queue assigned when matched. */
 };
 
+struct hinic3_ethertype_filter {
+	int tcam_index[HINIC3_PKT_TYPE_BUTT];
+	uint16_t ether_type;	/**< Ether type to match */
+	uint16_t queue;		/**< Queue assigned to when match*/
+};
+
 /* This structure is used to describe a basic filter type. */
 struct hinic3_filter_t {
 	uint16_t filter_rule_nums;
 	enum rte_filter_type filter_type;
-	struct rte_eth_ethertype_filter ethertype_filter;
+	struct hinic3_ethertype_filter ethertype_filter;
 	struct hinic3_fdir_filter fdir_filter;
 };
 
+enum hinic3_action_type {
+	HINIC3_ACTION_ADD,
+	HINIC3_ACTION_NOT_ADD,
+};
+
 enum hinic3_fdir_tunnel_mode {
 	HINIC3_FDIR_TUNNEL_MODE_NORMAL = 0,
-	HINIC3_FDIR_TUNNEL_MODE_VXLAN = 1,
+	HINIC3_FDIR_TUNNEL_MODE_VXLAN  = 1,
+	HINIC3_FDIR_TUNNEL_MODE_NVGRE  = 2,
+	HINIC3_FDIR_TUNNEL_MODE_FC     = 3,
+	HINIC3_FDIR_TUNNEL_MODE_GPE    = 4,
+	HINIC3_FDIR_TUNNEL_MODE_GENEVE = 5,
+	HINIC3_FDIR_TUNNEL_MODE_NSH    = 6,
+	HINIC3_FDIR_TUNNEL_MODE_IPIP   = 7,
 };
 
 enum hinic3_fdir_ip_type {
@@ -61,7 +104,6 @@ enum hinic3_fdir_ip_type {
 	HINIC3_FDIR_IP_TYPE_ANY = 2,
 };
 
-/* Describe the key structure of the TCAM. */
 struct hinic3_tcam_key_mem {
 #if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
 	uint32_t rsvd0 : 16;
@@ -77,11 +119,13 @@ struct hinic3_tcam_key_mem {
 
 	uint32_t dipv4_h : 16;
 	uint32_t dipv4_l : 16;
-	uint32_t rsvd2 : 16;
+
+	uint32_t vlan_flag : 1;
+	uint32_t rsvd2 : 15;
 
 	uint32_t rsvd3;
 
-	uint32_t rsvd4 : 16;
+	uint32_t ether_type : 16;
 	uint32_t dport : 16;
 
 	uint32_t sport : 16;
@@ -89,9 +133,10 @@ struct hinic3_tcam_key_mem {
 
 	uint32_t rsvd6 : 16;
 	uint32_t outer_sipv4_h : 16;
-	uint32_t outer_sipv4_l : 16;
 
+	uint32_t outer_sipv4_l : 16;
 	uint32_t outer_dipv4_h : 16;
+
 	uint32_t outer_dipv4_l : 16;
 	uint32_t vni_h : 16;
 
@@ -110,13 +155,14 @@ struct hinic3_tcam_key_mem {
 	uint32_t dipv4_h : 16;
 	uint32_t sipv4_l : 16;
 
-	uint32_t rsvd2 : 16;
+	uint32_t rsvd2 : 15;
+	uint32_t vlan_flag : 1;
 	uint32_t dipv4_l : 16;
 
 	uint32_t rsvd3;
 
 	uint32_t dport : 16;
-	uint32_t rsvd4 : 16;
+	uint32_t ether_type : 16;
 
 	uint32_t rsvd5 : 16;
 	uint32_t sport : 16;
@@ -135,18 +181,90 @@ struct hinic3_tcam_key_mem {
 #endif
 };
 
-/*
- * Define the IPv6-related TCAM key data structure in common
- * scenarios or IPv6 tunnel scenarios.
- */
+struct hinic3_tcam_key_mem_htn {
+#if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
+	uint32_t rsvd0 : 16;
+	uint32_t ip_proto : 8;
+	uint32_t tunnel_type : 3;
+	uint32_t function_id_h: 5;
+
+	uint32_t function_id_l : 5;
+	uint32_t ip_type : 2;
+	uint32_t outer_ip_type : 1;
+	uint32_t rsvd1 : 8;
+	uint32_t outer_sipv4_h : 16;
+
+	uint32_t outer_sipv4_l : 16;
+	uint32_t outer_dipv4_h : 16;
+
+	uint32_t outer_dipv4_l : 16;
+	uint32_t rsvd2 : 8;
+	uint32_t vni_h : 8;
+
+	uint32_t vni_l : 16;
+	uint32_t sipv4_h : 16;
+
+	uint32_t sipv4_l : 16;
+	uint32_t rsvd5 : 16;
+
+	uint32_t rsvd6;
+	uint32_t rsvd7;
+
+	uint32_t rsvd8 : 16;
+	uint32_t dipv4_h : 16;
+
+	uint32_t dipv4_l : 16;
+	uint32_t sport : 16;
+
+	uint32_t dport : 16;
+	uint32_t rsvd5 : 16;
+#else
+	uint32_t function_id_h : 5;
+	uint32_t tunnel_type : 3;
+	uint32_t ip_proto : 8;
+	uint32_t rsvd0 : 16;
+
+	uint32_t outer_sipv4_h : 16;
+	uint32_t rsvd1 : 8;
+	uint32_t outer_ip_type : 1;
+	uint32_t ip_type : 2;
+	uint32_t function_id_l : 5;
+
+	uint32_t outer_dipv4_h : 16;
+	uint32_t outer_sipv4_l : 16;
+
+	uint32_t vni_h : 8;
+	uint32_t rsvd2 : 8;
+	uint32_t outer_dipv4_l : 16;
+
+	uint32_t sipv4_h : 16;
+	uint32_t vni_l : 16;
+
+	uint32_t rsvd5 : 16;
+	uint32_t sipv4_l : 16;
+
+	uint32_t rsvd6;
+	uint32_t rsvd7;
+
+	uint32_t dipv4_h : 16;
+	uint32_t rsvd8 : 16;
+
+	uint32_t sport : 16;
+	uint32_t dipv4_l :16;
+
+	uint32_t rsvd9 : 16;
+	uint32_t dport : 16;
+#endif
+};
+
 struct hinic3_tcam_key_ipv6_mem {
 #if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
 	uint32_t rsvd0 : 16;
-	/* Indicates the normal IPv6 nextHdr or inner IPv4/IPv6 next proto. */
 	uint32_t ip_proto : 8;
 	uint32_t tunnel_type : 4;
 	uint32_t outer_ip_type : 1;
-	uint32_t rsvd1 : 3;
+	uint32_t vlan_flag : 1;
+	uint32_t rsvd1 : 2;
 
 	uint32_t function_id : 15;
 	uint32_t ip_type : 1;
@@ -179,7 +297,9 @@ struct hinic3_tcam_key_ipv6_mem {
 	uint32_t dipv6_key7 : 16;
 	uint32_t rsvd2 : 16;
 #else
-	uint32_t rsvd1 : 3;
+	uint32_t rsvd1 : 2;
+	uint32_t vlan_flag : 1;
+
 	uint32_t outer_ip_type : 1;
 	uint32_t tunnel_type : 4;
 	uint32_t ip_proto : 8;
@@ -218,10 +338,86 @@ struct hinic3_tcam_key_ipv6_mem {
 #endif
 };
 
-/*
- * Define the tcam key value data structure related to IPv6 in
- * the VXLAN scenario.
- */
+struct hinic3_tcam_key_ipv6_mem_htn {
+#if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
+	uint32_t rsvd0 : 16;
+	uint32_t ip_proto : 8;
+	uint32_t tunnel_type : 3;
+	uint32_t function_id_h : 5;
+
+	uint32_t function_id_l : 5;
+	uint32_t ip_type : 2;
+	uint32_t outer_ip_type : 1;
+	uint32_t rsvd1 : 8;
+	uint32_t sipv6_key0 : 16;
+
+	uint32_t sipv6_key1 : 16;
+	uint32_t sipv6_key2 : 16;
+
+	uint32_t sipv6_key3 : 16;
+	uint32_t sipv6_key4 : 16;
+
+	uint32_t sipv6_key5 : 16;
+	uint32_t sipv6_key6 : 16;
+
+	uint32_t sipv6_key7 : 16;
+	uint32_t dipv6_key0 : 16;
+
+	uint32_t dipv6_key1 : 16;
+	uint32_t dipv6_key2 : 16;
+
+	uint32_t dipv6_key3 : 16;
+	uint32_t dipv6_key4 : 16;
+
+	uint32_t dipv6_key5 : 16;
+	uint32_t dipv6_key6 : 16;
+
+	uint32_t dipv6_key7 : 16;
+	uint32_t sport : 16;
+
+	uint32_t dport : 16;
+	uint32_t rsvd2 : 16;
+#else
+	uint32_t function_id_h : 5;
+	uint32_t tunnel_type : 3;
+	uint32_t ip_proto : 8;
+	uint32_t rsvd0 : 16;
+
+	uint32_t sipv6_key0 : 16;
+	uint32_t rsvd1 : 8;
+	uint32_t outer_ip_type : 1;
+	uint32_t ip_type : 2;
+	uint32_t function_id_l : 5;
+
+	uint32_t sipv6_key2 : 16;
+	uint32_t sipv6_key1 : 16;
+
+	uint32_t sipv6_key4 : 16;
+	uint32_t sipv6_key3 : 16;
+
+	uint32_t sipv6_key6 : 16;
+	uint32_t sipv6_key5 : 16;
+
+	uint32_t dipv6_key0 : 16;
+	uint32_t sipv6_key7 : 16;
+
+	uint32_t dipv6_key2 : 16;
+	uint32_t dipv6_key1 : 16;
+
+	uint32_t dipv6_key4 : 16;
+	uint32_t dipv6_key3 : 16;
+
+	uint32_t dipv6_key6 : 16;
+	uint32_t dipv6_key5 : 16;
+
+	uint32_t sport : 16;
+	uint32_t dipv6_key7 : 16;
+
+	uint32_t rsvd2 : 16;
+	uint32_t dport : 16;
+#endif
+};
+
 struct hinic3_tcam_key_vxlan_ipv6_mem {
 #if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
 	uint32_t rsvd0 : 16;
@@ -246,7 +442,8 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {
 	uint32_t dport : 16;
 
 	uint32_t sport : 16;
-	uint32_t rsvd2 : 16;
+	uint32_t vlan_flag : 1;
+	uint32_t rsvd2 : 15;
 
 	uint32_t rsvd3 : 16;
 	uint32_t outer_sipv4_h : 16;
@@ -281,7 +478,8 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {
 	uint32_t dport : 16;
 	uint32_t dipv6_key7 : 16;
 
-	uint32_t rsvd2 : 16;
+	uint32_t rsvd2 : 15;
+	uint32_t vlan_flag : 1;
 	uint32_t sport : 16;
 
 	uint32_t outer_sipv4_h : 16;
@@ -298,6 +496,88 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {
 #endif
 };
 
+struct hinic3_tcam_key_vxlan_ipv6_mem_htn {
+#if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
+	uint32_t rsvd0 : 16;
+	uint32_t ip_proto : 8;
+	uint32_t tunnel_type : 3;
+	uint32_t function_id_h : 5;
+
+	uint32_t function_id_l : 5;
+	uint32_t ip_type : 2;
+	uint32_t outer_ip_type : 1;
+	uint32_t rsvd1 : 8;
+	uint32_t outer_sipv4_h : 16;
+
+	uint32_t outer_sipv4_l : 16;
+	uint32_t outer_dipv4_h : 16;
+
+	uint32_t outer_dipv4_l : 16;
+	uint32_t rsvd2 : 8;
+	uint32_t vni_h : 8;
+
+	uint32_t vni_l : 16;
+	uint32_t rsvd3 : 16;
+
+	uint32_t rsvd4 : 16;
+	uint32_t dipv6_key0 : 16;
+
+	uint32_t dipv6_key1 : 16;
+	uint32_t dipv6_key2 : 16;
+
+	uint32_t dipv6_key3 : 16;
+	uint32_t dipv6_key4 : 16;
+
+	uint32_t dipv6_key5 : 16;
+	uint32_t dipv6_key6 : 16;
+
+	uint32_t dipv6_key7 : 16;
+	uint32_t sport : 16;
+
+	uint32_t dport : 16;
+	uint32_t rsvd2 : 16;
+#else
+	uint32_t function_id_h : 5;
+	uint32_t tunnel_type : 3;
+	uint32_t ip_proto : 8;
+	uint32_t rsvd0 : 16;
+
+	uint32_t outer_sipv4_h : 16;
+	uint32_t rsvd1 : 8;
+	uint32_t outer_ip_type : 1;
+	uint32_t ip_type : 2;
+	uint32_t function_id_l : 5;
+
+	uint32_t outer_dipv4_h : 16;
+	uint32_t outer_sipv4_l : 16;
+
+	uint32_t vni_h : 8;
+	uint32_t rsvd2 : 8;
+	uint32_t outer_dipv4_l : 16;
+
+	uint32_t rsvd3 : 16;
+	uint32_t vni_l : 16;
+
+	uint32_t dipv6_key0 : 16;
+	uint32_t rsvd4 : 16;
+
+	uint32_t dipv6_key2 : 16;
+	uint32_t dipv6_key1 : 16;
+
+	uint32_t dipv6_key4 : 16;
+	uint32_t dipv6_key3 : 16;
+
+	uint32_t dipv6_key6 : 16;
+	uint32_t dipv6_key5 : 16;
+
+	uint32_t sport : 16;
+	uint32_t dipv6_key7 : 16;
+
+	uint32_t rsvd5 : 16;
+	uint32_t dport : 16;
+#endif
+};
+
 /*
  * TCAM key structure. The two unions indicate the key and mask respectively.
  * The TCAM key is consistent with the TCAM entry.
@@ -307,18 +587,26 @@ struct hinic3_tcam_key {
 		struct hinic3_tcam_key_mem key_info;
 		struct hinic3_tcam_key_ipv6_mem key_info_ipv6;
 		struct hinic3_tcam_key_vxlan_ipv6_mem key_info_vxlan_ipv6;
+
+		struct hinic3_tcam_key_mem_htn key_info_htn;
+		struct hinic3_tcam_key_ipv6_mem_htn key_info_ipv6_htn;
+		struct hinic3_tcam_key_vxlan_ipv6_mem_htn key_info_vxlan_ipv6_htn;
 	};
 	union {
 		struct hinic3_tcam_key_mem key_mask;
 		struct hinic3_tcam_key_ipv6_mem key_mask_ipv6;
 		struct hinic3_tcam_key_vxlan_ipv6_mem key_mask_vxlan_ipv6;
+
+		struct hinic3_tcam_key_mem_htn key_mask_htn;
+		struct hinic3_tcam_key_ipv6_mem_htn key_mask_ipv6_htn;
+		struct hinic3_tcam_key_vxlan_ipv6_mem_htn key_mask_vxlan_ipv6_htn;
 	};
 };
 
 /* Structure indicates the TCAM filter. */
 struct hinic3_tcam_filter {
-	TAILQ_ENTRY(hinic3_tcam_filter)
-	entries; /**< Filter entry, used for linked list operations. */
+	/** Filter entry, used for linked list operations. */
+	TAILQ_ENTRY(hinic3_tcam_filter) entries;
 	uint16_t dynamic_block_id;	 /**< Dynamic block ID. */
 	uint16_t index;			 /**< TCAM index. */
 	struct hinic3_tcam_key tcam_key; /**< Indicate TCAM key. */
@@ -362,33 +650,24 @@ struct hinic3_tcam_info {
 #define HINIC3_CNM_RULE_NUM  1
 #define HINIC3_ECP_RULE_NUM  2
 
+#define HINIC3_UINT1_MAX	0x1
+#define HINIC3_UINT2_MAX	0x3
+#define HINIC3_UINT3_MAX	0x7
+#define HINIC3_UINT4_MAX	0xf
+#define HINIC3_UINT5_WIDTH	0x5
+#define HINIC3_UINT5_MAX	0x1f
+#define HINIC3_UINT15_MAX	0x7fff
+
 /* Define Ethernet type. */
 #define RTE_ETHER_TYPE_CNM 0x22e7
 #define RTE_ETHER_TYPE_ECP 0x8940
 
-/* Protocol type of the data packet. */
-enum hinic3_ether_type {
-	HINIC3_PKT_TYPE_ARP = 1,
-	HINIC3_PKT_TYPE_ARP_REQ,
-	HINIC3_PKT_TYPE_ARP_REP,
-	HINIC3_PKT_TYPE_RARP,
-	HINIC3_PKT_TYPE_LACP,
-	HINIC3_PKT_TYPE_LLDP,
-	HINIC3_PKT_TYPE_OAM,
-	HINIC3_PKT_TYPE_CDCP,
-	HINIC3_PKT_TYPE_CNM,
-	HINIC3_PKT_TYPE_ECP = 10,
-
-	HINIC3_PKT_UNKNOWN = 31,
-};
-
 int hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 				    struct hinic3_fdir_filter *fdir_filter,
 				    bool add);
 int hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,
-					 struct rte_eth_ethertype_filter *ethertype_filter,
+					 struct hinic3_ethertype_filter *ethertype_filter,
 					 bool add);
-
 void hinic3_free_fdir_filter(struct rte_eth_dev *dev);
 int hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_id,
 				  uint32_t able);
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
index a803861199..e1741d1156 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -277,22 +277,6 @@ int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
  */
 void hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev);
 
-/**
- * Get cmdq ops software tile NIC(stn) supported.
- *
- * @return
- * Pointer to ops.
- */
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void);
-
-/**
- * Get cmdq ops hardware tile NIC(htn) supported.
- *
- * @return
- * Pointer to ops.
- */
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void);
-
 /**
  * Update driver feature capabilities.
  *
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
index e5a5f21df3..4452103e7e 100644
--- a/drivers/net/hinic3/hinic3_rx.c
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -22,8 +22,7 @@
  * Current pi.
  */
 static inline void
-hinic3_get_rq_wqe(struct hinic3_rxq *rxq, struct hinic3_rq_wqe **rq_wqe,
-		  uint16_t *pi)
+hinic3_get_rq_wqe(struct hinic3_rxq *rxq, struct hinic3_rq_wqe **rq_wqe, uint16_t *pi)
 {
 	*pi = MASKED_QUEUE_IDX(rxq, rxq->prod_idx);
 
@@ -84,8 +83,7 @@ hinic3_rx_fill_wqe(struct hinic3_rxq *rxq)
 
 		if (rxq->wqe_type == HINIC3_EXTEND_RQ_WQE) {
 			/* Unit of cqe length is 16B. */
-			hinic3_set_sge(&rq_wqe->extend_wqe.cqe_sect.sge,
-				       cqe_dma,
+			hinic3_set_sge(&rq_wqe->extend_wqe.cqe_sect.sge, cqe_dma,
 				       HINIC3_CQE_LEN >> HINIC3_CQE_SIZE_SHIFT);
 			/* Use fixed len. */
 			rq_wqe->extend_wqe.buf_desc.sge.len = nic_dev->rx_buff_len;
@@ -436,12 +434,18 @@ hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,
 	rss_type.ipv4 = (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4)) ? 1 : 0;
 	rss_type.tcp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;
 	rss_type.ipv6 = (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6)) ? 1 : 0;
-	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
 	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
-	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
 	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
 	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
 
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
+		rss_type.ipv6_ext = rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
+		rss_type.tcp_ipv6_ext = rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
+	} else {
+		rss_type.ipv6_ext = 0;
+		rss_type.ipv6_ext = 0;
+	}
+
 	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
 	return err;
 }
@@ -488,8 +492,7 @@ hinic3_update_rss_config(struct rte_eth_dev *dev,
 		goto init_rss_fail;
 	}
 
-	err = hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_ENABLE, num_tc,
-			     prio_tc);
+	err = hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_ENABLE, num_tc, prio_tc);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Enable rss failed, err: %d", err);
 		goto init_rss_fail;
@@ -796,7 +799,7 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 		}
 	}
 
-	hinic3_rearm_rxq_mbuf(rxq);
+	(void)hinic3_rearm_rxq_mbuf(rxq);
 	if (rxq->nic_dev->num_rss == 1) {
 		err = hinic3_set_vport_enable(nic_dev->hwdev, true);
 		if (err)
@@ -812,7 +815,6 @@ hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
 	return err;
 }
 
-
 static inline uint64_t
 hinic3_rx_vlan(uint8_t vlan_offload, uint16_t vlan_tag, uint16_t *vlan_tci)
 {
@@ -1016,8 +1018,8 @@ hinic3_rx_get_cqe_info(struct hinic3_rxq *rxq __rte_unused, volatile struct hini
 	uint32_t dw2 = hinic3_hw_cpu32(rx_cqe->offload_type);
 	uint32_t dw3 = hinic3_hw_cpu32(rx_cqe->hash_val);
 
-	cqe_info->lro_num =  RQ_CQE_STATUS_GET(dw0, NUM_LRO);
-	cqe_info->csum_err =  RQ_CQE_STATUS_GET(dw0, CSUM_ERR);
+	cqe_info->lro_num = RQ_CQE_STATUS_GET(dw0, NUM_LRO);
+	cqe_info->csum_err = RQ_CQE_STATUS_GET(dw0, CSUM_ERR);
 
 	cqe_info->pkt_len = RQ_CQE_SGE_GET(dw1, LEN);
 	cqe_info->vlan_tag = RQ_CQE_SGE_GET(dw1, VLAN);
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index fca94dd08e..1a864d0775 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -393,7 +393,7 @@ static int
 hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
 		      struct rte_mbuf *mbuf,
 		      struct hinic3_sq_wqe_combo *wqe_combo,
-					  struct hinic3_wqe_info *wqe_info)
+		      struct hinic3_wqe_info *wqe_info)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 	struct hinic3_offload_info *offload_info = &wqe_info->offload_info;
@@ -409,7 +409,7 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
 
 	/* Tso offload. */
 	if (ol_flags & HINIC3_PKT_TX_TCP_SEG) {
-		wqe_info->queue_info.payload_offset = wqe_info->payload_offset;
+		wqe_info->queue_info.payload_offset = wqe_info->payload_offset >> 1;
 		if ((wqe_info->payload_offset >> 1) > MAX_PAYLOAD_OFFSET)
 			return -EINVAL;
 
@@ -457,7 +457,7 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
 		offload_info->out_l4_en = 1;
 
 set_tx_wqe_offload:
-	nic_dev->tx_ops->tx_set_wqe_offload(wqe_info, wqe_combo);
+	nic_dev->tx_ops->nic_tx_set_wqe_offload(wqe_info, wqe_combo);
 
 	return 0;
 }
@@ -627,9 +627,8 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 		return err;
 
 	/* Non-tso mbuf only check sge num. */
-	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {
+	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG)))
 		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
-	}
 
 	/* Tso mbuf. */
 	wqe_info->payload_offset =
@@ -647,8 +646,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 }
 
 static inline void
-hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr,
-		    uint32_t len)
+hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs, rte_iova_t addr, uint32_t len)
 {
 	buf_descs->hi_addr = hinic3_hw_be32(upper_32_bits(addr));
 	buf_descs->lo_addr = hinic3_hw_be32(lower_32_bits(addr));
@@ -832,14 +830,14 @@ hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
 	if (wqe_combo->wqe_type == SQ_WQE_EXTENDED_TYPE) {
 		wqe_desc->ctrl_len |= SQ_CTRL_SET(wqe_info->sge_cnt, BUFDESC_NUM) |
 				      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
-				      SQ_CTRL_SET(SQ_WQE_SGL, DATA_FORMAT);
+				      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT);
 
 		*qsf = SQ_CTRL_QUEUE_INFO_SET(1, UC) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->sctp, SCTP) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->udp_dp_en, TCPUDP_CS) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->tso, TSO) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->ufo, UFO) |
-		       SQ_CTRL_QUEUE_INFO_SET(queue_info->payload_offset >> 1, PLDOFF) |
+		       SQ_CTRL_QUEUE_INFO_SET(queue_info->payload_offset, PLDOFF) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->pkt_type, PKT_TYPE) |
 		       SQ_CTRL_QUEUE_INFO_SET(queue_info->mss, MSS);
 
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
index dd944c0cf4..634dfe7239 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
@@ -97,6 +97,17 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf,
 	return HINIC3_HTN_CMD_SVLAN_MODIFY;
 }
 
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
 static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_dev,
 						   const uint32_t *indir_table,
 						   struct hinic3_cmd_buf *cmd_buf)
@@ -119,17 +130,6 @@ static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_de
 	return HINIC3_HTN_CMD_SET_RSS_INDIR_TABLE;
 }
 
-static void prepare_rss_indir_table_cmd_header(struct hinic3_nic_dev *nic_dev,
-					       struct hinic3_cmd_buf *cmd_buf)
-{
-	struct hinic3_rss_cmd_header *header = cmd_buf->buf;
-
-	header->dest_func_id = hinic3_global_func_id(nic_dev->hwdev);
-
-	rte_atomic_thread_fence(rte_memory_order_seq_cst);
-	hinic3_cpu_to_be32(header, sizeof(*header));
-}
-
 static uint8_t prepare_cmd_buf_get_rss_indir_table(struct hinic3_nic_dev *nic_dev,
 						   struct hinic3_cmd_buf *cmd_buf)
 {
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
index ffafe39fb5..73f4922734 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
@@ -52,4 +52,12 @@ struct hinic3_htn_vlan_ctx {
 	uint16_t dest_func_id;
 };
 
+/**
+ * Get cmdq ops hardware tile NIC(htn) supported.
+ *
+ * @return
+ * Pointer to ops.
+ */
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void);
+
 #endif /* _HINIC3_HTN_CMDQ_H_ */
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.build
index b79b753716..b286cdb79c 100644
--- a/drivers/net/hinic3/meson.build
+++ b/drivers/net/hinic3/meson.build
@@ -16,8 +16,6 @@ endif
 
 cflags += ['-DHW_CONVERT_ENDIAN']
 
-subdir('base')
-
 sources = files(
         'hinic3_ethdev.c',
         'hinic3_nic_io.c',
@@ -28,3 +26,9 @@ sources = files(
 )
 
 includes += include_directories('base')
+includes += include_directories('stn_adapt')
+includes += include_directories('stn_adapt')
+
+subdir('base')
+subdir('htn_adapt')
+subdir('stn_adapt')
\ No newline at end of file
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
index 5e6594f518..00c3b8b895 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
@@ -94,7 +94,7 @@ static uint8_t prepare_cmd_buf_modify_svlan(struct hinic3_cmd_buf *cmd_buf, uint
 	return HINIC3_UCODE_CMD_MODIFY_VLAN_CTX;
 }
 
-static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_dev,
+static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_dev __rte_unused,
 						   const uint32_t *indir_table,
 						   struct hinic3_cmd_buf *cmd_buf)
 {
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
index a40c4faa89..f1720c29c7 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
@@ -35,4 +35,12 @@ struct hinic3_stn_vlan_ctx {
 	uint32_t vlan_sel;
 };
 
+/**
+ * Get cmdq ops software tile NIC(stn) supported.
+ *
+ * @return
+ * Pointer to ops.
+ */
+struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void);
+
 #endif /* _HINIC3_STN_CMDQ_H_ */
-- 
2.45.1.windows.1

