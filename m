Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8809D79767
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:07:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB52940654;
	Sat, 31 Jan 2026 11:06:54 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 0F67C402EE
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=KQZz7t2H2R0i677ZAAYNyJXlGXj2bHDQugU7IgQMB0c=;
 b=i/4WDt65JnnOw7mNbkCEODrDGyzoYvUGnu758h9jf+zWCrqbg4oaBtMQUA60MQ
 EIovzbDTG7OSy34rNGsur+WDNp75hy3zAJbqtdOVzVe0l7lqRaEznjof65wUw5CX
 SUrmJhWcRJhEb2cUex9SCXNPW/gbzUIPegFM1IbgkeDRo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S11;
 Sat, 31 Jan 2026 18:06:47 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 7/7] net/hinic3: use different callback func to support htn
 fdir
Date: Sat, 31 Jan 2026 18:06:03 +0800
Message-ID: <20260131100608.12429-8-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-1-wff_light@vip.163.com>
References: <20260131100608.12429-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S11
X-Coremail-Antispam: 1Uf129KBjvAXoWDWrW7Zr13Cr4kXr4xZF17GFg_yoW7ZF18Ao
 W3X3y3tw1Sqw1xCayjvw4kGFy3Xwn0k3Z5Jayq9ws7Zw45tayrtFy3AF18JFWUu390yFnr
 ZF97Ja40q3ZFqas7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrYFCUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBf7Bml91DdZtwAA3H
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
 drivers/net/hinic3/base/hinic3_nic_cfg.c |  43 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.h |  22 +-
 drivers/net/hinic3/hinic3_fdir.c         | 589 ++++++++++++++++-------
 drivers/net/hinic3/hinic3_fdir.h         | 373 ++++++++++++--
 4 files changed, 778 insertions(+), 249 deletions(-)

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index f12a2aedee..7aa9cf9cb0 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -1026,7 +1026,7 @@ hinic3_set_rx_lro_timer(struct hinic3_hwdev *hwdev, uint32_t timer_value)
 }
 
 int
-hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32_t lro_timer,
+hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, bool lro_en, uint32_t lro_timer,
 			uint32_t lro_max_pkt_len)
 {
 	uint8_t ipv4_en = 0, ipv6_en = 0;
@@ -1465,38 +1465,41 @@ hinic3_vf_get_default_cos(struct hinic3_hwdev *hwdev, uint8_t *cos_id)
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
 int
-hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev,
-			 uint8_t pkt_type, uint16_t queue_id, uint8_t en)
+hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev, uint8_t pkt_type,
+								 struct hinic3_ethertype_filter *ethertype_filter,
+								 uint8_t en)
 {
+	struct hinic3_nic_dev *nic_dev = NULL;
 	struct hinic3_set_fdir_ethertype_rule ethertype_cmd;
 	uint16_t out_size = sizeof(ethertype_cmd);
+	uint16_t block_id;
+	uint32_t index = 0;
 	int err;
 
-	if (!hwdev)
+	if (!hwdev || !hwdev->dev_handle)
 		return -EINVAL;
+	nic_dev = (struct hinic3_nic_dev*)hwdev->dev_handle;
+
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0)
+		if (en != 0) {
+			index = hinic3_tcam_alloc_index(nic_dev, &block_id);
+			if (index == HINIC3_TCAM_INVALID_INDEX) {
+			return -ENOMEM;
+		}
+
+		index += HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_id);
+	} else {
+		index = ethertype_filter->tcam_index[pkt_type];
+	}
 
 	memset(&ethertype_cmd, 0,
 	       sizeof(struct hinic3_set_fdir_ethertype_rule));
 	ethertype_cmd.func_id = hinic3_global_func_id(hwdev);
 	ethertype_cmd.pkt_type = pkt_type;
 	ethertype_cmd.pkt_type_en = en;
-	ethertype_cmd.qid = (uint8_t)queue_id;
+	ethertype_cmd.index = index;
+	ethertype_cmd.qid = (uint8_t)ethertype_filter->queue;
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_FDIR_STATUS,
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 34372a0678..024bbb9bf8 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -1204,7 +1204,7 @@ int hinic3_set_rx_vlan_offload(struct hinic3_hwdev *hwdev, uint8_t en);
  * @return
  * 0 on success, non-zero on failure.
  */
-int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, uint8_t lro_en, uint32_t lro_timer,
+int hinic3_set_rx_lro_state(struct hinic3_hwdev *hwdev, bool lro_en, uint32_t lro_timer,
 			    uint32_t lro_max_pkt_len);
 
 /**
@@ -1523,8 +1523,24 @@ int hinic3_get_feature_from_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature,
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
+int hinic3_set_fdir_ethertype_filter(struct hinic3_hwdev *hwdev, uint8_t pkt_type,
+									 struct hinic3_ethertype_filter *ethertype_filter,
+									 uint8_t en);
 
 int hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 				  enum hinic3_link_follow_status status);
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
index 263a281729..47dbd519d9 100644
--- a/drivers/net/hinic3/hinic3_fdir.c
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -8,9 +8,7 @@
 #include "base/hinic3_nic_cfg.h"
 #include "hinic3_ethdev.h"
 
-#define HINIC3_UINT1_MAX  0x1
-#define HINIC3_UINT4_MAX  0xf
-#define HINIC3_UINT15_MAX 0x7fff
+#define HINIC3_INVALID_INDEX	-1
 
 #define HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev) \
 	(&((struct hinic3_nic_dev *)(nic_dev))->tcam)
@@ -77,6 +75,8 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	tcam_key->key_mask.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info.vlan_flag = 0;
 
 	/* Fill src IPv4. */
 	tcam_key->key_mask.sipv4_h =
@@ -99,15 +99,9 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);
 }
 
-static void
-hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
-			   struct hinic3_tcam_key *tcam_key)
+static void hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *rule,
+							struct hinic3_tcam_key *tcam_key)
 {
-	/* Fill type of ip. */
-	tcam_key->key_mask_ipv6.ip_type = HINIC3_UINT1_MAX;
-	tcam_key->key_info_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
-
-	/* Fill src IPv6. */
 	tcam_key->key_mask_ipv6.sipv6_key0 =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
 	tcam_key->key_mask_ipv6.sipv6_key1 =
@@ -140,8 +134,11 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
 	tcam_key->key_info_ipv6.sipv6_key7 =
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
+}
 
-	/* Fill dst IPv6. */
+static void hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *rule,
+							struct hinic3_tcam_key *tcam_key)
+{
 	tcam_key->key_mask_ipv6.dipv6_key0 =
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
 	tcam_key->key_mask_ipv6.dipv6_key1 =
@@ -176,6 +173,26 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
 }
 
+static void hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule,
+							struct hinic3_tcam_key *tcam_key)
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
@@ -204,6 +221,10 @@ hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *dev,
 	tcam_key->key_info.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
 
 	tcam_key->key_mask.function_id = HINIC3_UINT15_MAX;
+
+	tcam_key->key_mask.vlan_flag = 1;
+	tcam_key->key_info.vlan_flag = 0;
+
 	tcam_key->key_info.function_id = hinic3_global_func_id(nic_dev->hwdev) &
 					 HINIC3_UINT15_MAX;
 
@@ -223,6 +244,8 @@ hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	tcam_key->key_mask.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info.vlan_flag = 0;
 
 	/* Fill src ipv4. */
 	tcam_key->key_mask.sipv4_h =
@@ -252,6 +275,8 @@ hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,
 	/* Fill type of ip. */
 	tcam_key->key_mask_vxlan_ipv6.ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info_vxlan_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+	tcam_key->key_mask_vxlan_ipv6.vlan_flag = HINIC3_UINT1_MAX;
+	tcam_key->key_info_vxlan_ipv6.vlan_flag = 0;
 
 	/* Use inner dst ipv6 to fill the dst ipv6 of tcam_key. */
 	tcam_key->key_mask_vxlan_ipv6.dipv6_key0 =
@@ -288,77 +313,6 @@ hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,
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
@@ -370,11 +324,15 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
 	tcam_key->key_info_ipv6.ip_proto = rule->key_spec.proto;
 
 	tcam_key->key_mask_ipv6.tunnel_type = HINIC3_UINT4_MAX;
-	tcam_key->key_info_ipv6.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+	tcam_key->key_info_ipv6.tunnel_type = rule->tunnel_type;
 
 	tcam_key->key_mask_ipv6.outer_ip_type = HINIC3_UINT1_MAX;
 	tcam_key->key_info_ipv6.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
 
+	tcam_key->key_mask_ipv6.function_id = HINIC3_UINT15_MAX;
+	tcam_key->key_mask_ipv6.vlan_flag = HINIC3_UINT1_MAX;
+
+	tcam_key->key_info_ipv6.vlan_flag = 0;
 	tcam_key->key_mask_ipv6.function_id = HINIC3_UINT15_MAX;
 	tcam_key->key_info_ipv6.function_id =
 		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT15_MAX;
@@ -386,7 +344,7 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
 	tcam_key->key_info_ipv6.sport = rule->key_spec.src_port;
 
 	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_ANY)
-		hinic3_fdir_tcam_outer_ipv6_init(rule, tcam_key);
+		hinic3_fdir_ipv6_tcam_key_init(rule, tcam_key);
 }
 
 /**
@@ -448,9 +406,11 @@ hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);
 
 	tcam_key->key_mask.tunnel_type = HINIC3_UINT4_MAX;
-	tcam_key->key_info.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+	tcam_key->key_info.tunnel_type = rule->tunnel_type;
 
+	tcam_key->key_mask.vlan_flag = 1;
 	tcam_key->key_mask.function_id = HINIC3_UINT15_MAX;
+	tcam_key->key_info.vlan_flag = 0;
 	tcam_key->key_info.function_id = hinic3_global_func_id(nic_dev->hwdev) &
 					 HINIC3_UINT15_MAX;
 
@@ -479,6 +439,258 @@ hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,
 	tcam_key_calculate(tcam_key, fdir_tcam_rule);
 }
 
+static void
+hinic3_fdir_tcam_key_set_ipv4_sip_dip(struct rte_eth_ipv4_flow *ipv4_mask,
+						  struct rte_eth_ipv4_flow *ipv4_spec,
+						  struct hinic3_tcam_key *tcam_key)
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
+					      struct rte_eth_ipv6_flow *ipv6_spec,
+					      struct hinic3_tcam_key *tcam_key)
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
+					      struct rte_eth_ipv6_flow *ipv6_spec,
+					      struct hinic3_tcam_key *tcam_key)
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
+							struct rte_eth_ipv4_flow *ipv4_spec,
+							struct hinic3_tcam_key *tcam_key)
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
+					       struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	hinic3_fdir_tcam_key_set_ipv4_sip_dip(&rule->key_mask.ipv4,
+								&rule->key_spec.ipv4, tcam_key);
+}
+
+static void hinic3_fdir_tcam_key_set_ipv6_info(struct hinic3_fdir_filter *rule,
+					       struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_ipv6_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	hinic3_fdir_tcam_key_set_ipv6_sip(&rule->key_mask.ipv6,
+								&rule->key_spec.ipv6, tcam_key);
+	hinic3_fdir_tcam_key_set_ipv6_dip(&rule->key_mask.ipv6,
+								&rule->key_spec.ipv6, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_notunnel_htn_init(struct hinic3_fdir_filter *rule,
+					       struct hinic3_tcam_key *tcam_key)
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
+						     struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6_htn.outer_ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6_htn.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	hinic3_fdir_tcam_key_set_outer_ipv4_sip_dip(&rule->key_mask.ipv4,
+									&rule->key_spec.ipv4, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_key_set_inner_ipv4_info(struct hinic3_fdir_filter *rule,
+						     struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	hinic3_fdir_tcam_key_set_ipv4_sip_dip(&rule->key_mask.inner_ipv4,
+								&rule->key_spec.inner_ipv4, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_key_set_inner_ipv6_info(struct hinic3_fdir_filter *rule,
+						     struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_vxlan_ipv6_htn.ip_type = HINIC3_UINT2_MAX;
+	tcam_key->key_info_vxlan_ipv6_htn.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	hinic3_fdir_tcam_key_set_ipv6_dip(&rule->key_mask.inner_ipv6,
+							&rule->key_spec.inner_ipv6, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_tunnel_htn_init(struct hinic3_fdir_filter *rule,
+					    struct hinic3_tcam_key *tcam_key)
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
+void
+hinic3_fdir_tcam_info_htn_init(struct rte_eth_dev *dev,
+				    struct hinic3_fdir_filter *rule,
+				    struct hinic3_tcam_key *tcam_key,
+				    struct hinic3_tcam_cfg_rule *fdir_tcam_rule)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	tcam_key->key_mask_htn.function_id_h = HINIC3_UINT5_MAX;
+	tcam_key->key_mask_htn.function_id_l = HINIC3_UINT5_MAX;
+	tcam_key->key_info_htn.function_id_l = hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT5_MAX;
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
@@ -513,19 +725,30 @@ hinic3_ethertype_filter_lookup(struct hinic3_ethertype_filter_list *ethertype_li
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
+			  			  struct hinic3_tcam_key *key,
+						  uint8_t action_type, uint16_t tcam_index)
 {
 	struct hinic3_tcam_filter *it;
 
-	TAILQ_FOREACH(it, filter_list, entries) {
-		if (memcmp(key, &it->tcam_key,
-			   sizeof(struct hinic3_tcam_key)) == 0) {
-			return it;
+	if (action_type == HINIC3_ACTION_ADD) {
+		TAILQ_FOREACH (it, filter_list, entries) {
+			if (memcmp(key, &it->tcam_key, sizeof(struct hinic3_tcam_key)) == 0)
+				return it;
+		}
+	} else {
+		TAILQ_FOREACH(it, filter_list, entries) {
+			if ((it->index + HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(it->dynamic_block_id))
+																			== tcam_index)
+				return it;
 		}
 	}
 
@@ -588,12 +811,8 @@ hinic3_free_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,
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
@@ -601,9 +820,7 @@ hinic3_free_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,
  */
 static struct hinic3_tcam_dynamic_block *
 hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
-				  struct hinic3_tcam_cfg_rule *fdir_tcam_rule,
 				  struct hinic3_tcam_info *tcam_info,
-				  struct hinic3_tcam_filter *tcam_filter,
 				  uint16_t *tcam_index)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -616,6 +833,9 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
 	uint16_t index;
 	int err;
 
+	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) != 0)
+		rule_nums += nic_dev->ethertype_rule_nums;
+
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
@@ -702,6 +914,51 @@ hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
 	return NULL;
 }
 
+uint16_t
+hinic3_tcam_alloc_index(struct hinic3_nic_dev nic_dev, uint16_t *block_id)
+{
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
+void
+hinic3_tcam_index_free(struct hinic3_nic_dev nic_dev, uint16_t index, uint16_t *block_id)
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
+	if (tmp->dynamic_index_cnt ==0) {
+		hinic3_free_tcam_block(nic_dev->hwdev, &block_id);
+		hinic3_free_dynamic_block_resource(tcam_info, tmp);
+	}
+}
+
 /**
  * Add a TCAM filter.
  *
@@ -722,11 +979,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
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
@@ -737,35 +990,11 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 
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
+														tcam_filter->index;
 
 	/* Add a new TCAM rule to the network device. */
 	err = hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule,
@@ -785,10 +1014,6 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 	/* Add a filter to the end of the queue. */
 	TAILQ_INSERT_TAIL(&tcam_info->tcam_list, tcam_filter, entries);
 
-	/* Update dynamic index. */
-	tmp->dynamic_index[index] = 1;
-	tmp->dynamic_index_cnt++;
-
 	nic_dev->tcam_rule_nums++;
 
 	PMD_DRV_LOG(INFO,
@@ -796,7 +1021,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 		    hinic3_global_func_id(nic_dev->hwdev));
 	PMD_DRV_LOG(INFO,
 		    "tcam_block_id: %d, local_index: %d, global_index: %d, queue: %d, tcam_rule_nums: %d",
-		    tcam_filter->dynamic_block_id, index, fdir_tcam_rule->index,
+		    tcam_filter->dynamic_block_id, tcam_filter->index, fdir_tcam_rule->index,
 		    fdir_tcam_rule->data.qid, nic_dev->tcam_rule_nums);
 	return 0;
 
@@ -807,13 +1032,7 @@ hinic3_add_tcam_filter(struct rte_eth_dev *dev,
 
 add_tcam_rules_failed:
 lookup_tcam_index_failed:
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
@@ -873,14 +1092,9 @@ hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *dev,
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
@@ -930,6 +1144,7 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 				struct hinic3_fdir_filter *fdir_filter,
 				bool add)
 {
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_tcam_info *tcam_info =
 		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
 	struct hinic3_tcam_filter *tcam_filter;
@@ -940,11 +1155,15 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
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
+								HINIC3_ACTION_ADD, HINIC3_INVALID_INDEX);
 	if (tcam_filter != NULL && add) {
 		PMD_DRV_LOG(ERR, "Filter exists.");
 		return -EEXIST;
@@ -965,6 +1184,12 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
 
 		fdir_filter->tcam_index = (int)(fdir_tcam_rule.index);
 	} else {
+		tcam_filter = hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key,
+							HINIC3_ACTION_NOT_ADD, fdir_filter->tcam_index);
+		if (tcam_filter == NULL) {
+			PMD_DRV_LOG(ERR, "Filter doesn't exist.");
+			return -ENOENT;
+		}
 		PMD_DRV_LOG(INFO, "begin to del tcam filter");
 		ret = hinic3_del_tcam_filter(dev, tcam_filter);
 		if (ret)
@@ -1088,7 +1313,7 @@ hinic3_free_fdir_filter(struct rte_eth_dev *dev)
 
 static int
 hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
-			   struct rte_eth_ethertype_filter *ethertype_filter,
+			   struct hinic3_ethertype_filter *ethertype_filter,
 			   bool add)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -1097,7 +1322,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 	/* Setting the ARP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_ARP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1107,7 +1332,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 	/* Setting the ARP Request Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_ARP_REQ,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s arp request rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1117,7 +1342,7 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
 	/* Setting the ARP Response Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_ARP_REP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s arp response rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1129,19 +1354,19 @@ hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
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
@@ -1150,7 +1375,7 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
 	/* Setting the LACP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_LACP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s lacp fdir rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1160,7 +1385,7 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
 	/* Setting the OAM Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_OAM,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s oam rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1172,14 +1397,14 @@ hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
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
@@ -1188,7 +1413,7 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
 	/* Setting the LLDP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_LLDP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s lldp fdir rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1198,7 +1423,7 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
 	/* Setting the CDCP Filter. */
 	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
 					       HINIC3_PKT_TYPE_CDCP,
-					       ethertype_filter->queue, add);
+					       ethertype_filter, add);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "%s cdcp fdir rule failed, err: %d",
 			    add ? "Add" : "Del", ret);
@@ -1210,14 +1435,14 @@ hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
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
@@ -1245,7 +1470,7 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
 		return hinic3_flow_set_arp_filter(dev, ethertype_filter, add);
 	case RTE_ETHER_TYPE_RARP:
 		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
-			HINIC3_PKT_TYPE_RARP, ethertype_filter->queue, add);
+			HINIC3_PKT_TYPE_RARP, ethertype_filter, add);
 
 	case RTE_ETHER_TYPE_SLOW:
 		return hinic3_flow_set_slow_filter(dev, ethertype_filter, add);
@@ -1255,11 +1480,11 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
 
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
@@ -1270,7 +1495,7 @@ hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
 }
 
 static int
-hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype_filter)
+hinic3_flow_ethertype_rule_nums(struct hinic3_ethertype_filter *ethertype_filter)
 {
 	switch (ethertype_filter->ether_type) {
 	case RTE_ETHER_TYPE_ARP:
@@ -1309,7 +1534,7 @@ hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype_filte
  */
 int
 hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,
-				     struct rte_eth_ethertype_filter *ethertype_filter,
+				     struct hinic3_ethertype_filter *ethertype_filter,
 				     bool add)
 {
 	/* Get dev private info. */
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_fdir.h
index 8659f588d9..6522950e13 100644
--- a/drivers/net/hinic3/hinic3_fdir.h
+++ b/drivers/net/hinic3/hinic3_fdir.h
@@ -14,9 +14,39 @@
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
+enum hinic3_rule_type {
+	HINIC3_RULE_TYPE_FILTER,
+	HINIC3_RULE_TYPE_PFE,
+};
+
 /* Indicate a traffic filtering rule. */
 struct rte_flow {
 	TAILQ_ENTRY(rte_flow) node;
+	enum hinic3_rule_type rule_type;
 	enum rte_filter_type filter_type;
 	void *rule;
 };
@@ -30,6 +60,8 @@ struct hinic3_fdir_rule_key {
 	uint16_t src_port;
 	uint16_t dst_port;
 	uint8_t proto;
+	uint8_t vlan_flag;
+	uint16_t ether_type;
 };
 
 struct hinic3_fdir_filter {
@@ -42,17 +74,34 @@ struct hinic3_fdir_filter {
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
@@ -61,7 +110,6 @@ enum hinic3_fdir_ip_type {
 	HINIC3_FDIR_IP_TYPE_ANY = 2,
 };
 
-/* Describe the key structure of the TCAM. */
 struct hinic3_tcam_key_mem {
 #if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
 	uint32_t rsvd0 : 16;
@@ -69,32 +117,34 @@ struct hinic3_tcam_key_mem {
 	uint32_t tunnel_type : 4;
 	uint32_t rsvd1 : 4;
 
+
 	uint32_t function_id : 15;
 	uint32_t ip_type : 1;
-
 	uint32_t sipv4_h : 16;
-	uint32_t sipv4_l : 16;
 
+	uint32_t sipv4_l : 16;
 	uint32_t dipv4_h : 16;
+
 	uint32_t dipv4_l : 16;
-	uint32_t rsvd2 : 16;
+	uint32_t vlan_flag : 1;
+	uint32_t rsvd2 : 15;
 
 	uint32_t rsvd3;
 
-	uint32_t rsvd4 : 16;
+	uint32_t ether_type : 16;
 	uint32_t dport : 16;
 
 	uint32_t sport : 16;
 	uint32_t rsvd5 : 16;
-
 	uint32_t rsvd6 : 16;
+
 	uint32_t outer_sipv4_h : 16;
 	uint32_t outer_sipv4_l : 16;
 
 	uint32_t outer_dipv4_h : 16;
 	uint32_t outer_dipv4_l : 16;
-	uint32_t vni_h : 16;
 
+	uint32_t vni_h : 16;
 	uint32_t vni_l : 16;
 	uint32_t rsvd7 : 16;
 #else
@@ -110,13 +160,14 @@ struct hinic3_tcam_key_mem {
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
@@ -135,18 +186,90 @@ struct hinic3_tcam_key_mem {
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
@@ -179,7 +302,9 @@ struct hinic3_tcam_key_ipv6_mem {
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
@@ -218,10 +343,86 @@ struct hinic3_tcam_key_ipv6_mem {
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
@@ -246,7 +447,8 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {
 	uint32_t dport : 16;
 
 	uint32_t sport : 16;
-	uint32_t rsvd2 : 16;
+	uint32_t vlan_flag : 1;
+	uint32_t rsvd2 : 15;
 
 	uint32_t rsvd3 : 16;
 	uint32_t outer_sipv4_h : 16;
@@ -281,7 +483,8 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {
 	uint32_t dport : 16;
 	uint32_t dipv6_key7 : 16;
 
-	uint32_t rsvd2 : 16;
+	uint32_t rsvd2 : 15;
+	uint32_t vlan_flag : 1;
 	uint32_t sport : 16;
 
 	uint32_t outer_sipv4_h : 16;
@@ -298,6 +501,88 @@ struct hinic3_tcam_key_vxlan_ipv6_mem {
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
@@ -307,18 +592,25 @@ struct hinic3_tcam_key {
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
+	TAILQ_ENTRY(hinic3_tcam_filter) entries; /**< Filter entry, used for linked list operations. */
 	uint16_t dynamic_block_id;	 /**< Dynamic block ID. */
 	uint16_t index;			 /**< TCAM index. */
 	struct hinic3_tcam_key tcam_key; /**< Indicate TCAM key. */
@@ -362,37 +654,30 @@ struct hinic3_tcam_info {
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
 int hinic3_flow_parse_attr(const struct rte_flow_attr *attr,
 			   struct rte_flow_error *error);
+uint16_t hinic3_tcam_alloc_index(struct hinic3_nic_dev nic_dev, uint16_t *block_id);
+void hinic3_tcam_index_free(struct hinic3_nic_dev nic_dev, uint16_t index, uint16_t *block_id)
 
 #endif /**< _HINIC3_FDIR_H_ */
-- 
2.45.1.windows.1

