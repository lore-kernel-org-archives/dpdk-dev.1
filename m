Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B7CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 04:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 242E140BA5;
	Tue,  2 Sep 2025 06:02:47 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 1467C40A71
 for <dev@dpdk.org>; Tue,  2 Sep 2025 06:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=y4cxDeBCNL2soSvAng95akejsvC4iOOuITJg6/qKHuo=;
 b=h/sdPEdLwbX6XdSmDrzBVvlHXKUPsElo9v/iHAFcAAqzumTkJuyztDTIf9M/F1
 WQVgBhaErwYlVny/BivSvOjdbt/NhtdHLSEqk3pebIsKPuifKZk4EEpyDr77lb+Z
 xqSMWd+4H6Oohgv2lntet4WpVwDad6m6WJGD+rmm81QB8=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgC3XbtJbLZoaQXrAg--.25878S20;
 Tue, 02 Sep 2025 12:02:36 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V7 16/17] net/hinic3: add flow control and FDIR module
Date: Tue,  2 Sep 2025 12:01:50 +0800
Message-ID: <20250902040204.9572-17-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250902040204.9572-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250902040204.9572-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgC3XbtJbLZoaQXrAg--.25878S20
X-Coremail-Antispam: 1Uf129KBjvAXoWkGF4DWFWkWF1rtw4DZr48Xrb_yoWkCF43Go
 WfXrs8tr1rtw4xGa1vvr4xAa4xX3yv93ZYyFWa9ws7Za15tr15trZayF4rJayj93y5tFnx
 ZryxJa1SqrnFqas3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzGQDUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAga8Cmi2Um5rYAAAsb
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

From: Yi Chen <chenyi221@huawei.com>

Added support for rte_flow, including ethertype, IPv4,
IPv6, and tunnel VXLAN. In addition, user can add or delete filters.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c |   65 ++
 drivers/net/hinic3/hinic3_ethdev.h |   16 +
 drivers/net/hinic3/hinic3_fdir.c   | 1379 +++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_fdir.h   |  398 ++++++++
 drivers/net/hinic3/hinic3_flow.c   | 1501 ++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_flow.h   |  196 ++++
 drivers/net/hinic3/meson.build     |    2 +
 7 files changed, 3557 insertions(+)
 create mode 100644 drivers/net/hinic3/hinic3_fdir.c
 create mode 100644 drivers/net/hinic3/hinic3_fdir.h
 create mode 100644 drivers/net/hinic3/hinic3_flow.c
 create mode 100644 drivers/net/hinic3/hinic3_flow.h

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 77c835b18a..493151317a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2322,6 +2322,67 @@ hinic3_dev_promiscuous_disable(struct rte_eth_dev *dev)
  * @return
  * 0 on success, non-zero on failure.
  */
+static int
+hinic3_dev_flow_ctrl_get(struct rte_eth_dev *dev,
+			 struct rte_eth_fc_conf *fc_conf)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct nic_pause_config nic_pause;
+	int err;
+
+	memset(&nic_pause, 0, sizeof(nic_pause));
+	err = hinic3_get_pause_info(nic_dev->hwdev, &nic_pause);
+	if (err)
+		return err;
+	if (nic_dev->pause_set || !nic_pause.auto_neg) {
+		nic_pause.rx_pause = nic_dev->nic_pause.rx_pause;
+		nic_pause.tx_pause = nic_dev->nic_pause.tx_pause;
+	}
+
+	fc_conf->autoneg = nic_pause.auto_neg;
+
+	if (nic_pause.tx_pause && nic_pause.rx_pause)
+		fc_conf->mode = RTE_ETH_FC_FULL;
+	else if (nic_pause.tx_pause)
+		fc_conf->mode = RTE_ETH_FC_TX_PAUSE;
+	else if (nic_pause.rx_pause)
+		fc_conf->mode = RTE_ETH_FC_RX_PAUSE;
+	else
+		fc_conf->mode = RTE_ETH_FC_NONE;
+
+	return 0;
+}
+
+static int
+hinic3_dev_flow_ctrl_set(struct rte_eth_dev *dev,
+			 struct rte_eth_fc_conf *fc_conf)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct nic_pause_config nic_pause;
+	int err;
+
+	memset(&nic_pause, 0, sizeof(nic_pause));
+	if ((fc_conf->mode & RTE_ETH_FC_FULL) == RTE_ETH_FC_FULL ||
+	    (fc_conf->mode & RTE_ETH_FC_TX_PAUSE))
+		nic_pause.tx_pause = true;
+
+	if ((fc_conf->mode & RTE_ETH_FC_FULL) == RTE_ETH_FC_FULL ||
+	    (fc_conf->mode & RTE_ETH_FC_RX_PAUSE))
+		nic_pause.rx_pause = true;
+
+	err = hinic3_set_pause_info(nic_dev->hwdev, nic_pause);
+	if (err)
+		return err;
+	nic_dev->pause_set = true;
+	nic_dev->nic_pause.rx_pause = nic_pause.rx_pause;
+	nic_dev->nic_pause.tx_pause = nic_pause.tx_pause;
+
+	PMD_DRV_LOG(INFO,
+		    "Just support set tx or rx pause info, tx: %s, rx: %s",
+		    nic_pause.tx_pause ? "on" : "off",
+		    nic_pause.rx_pause ? "on" : "off");
+	return 0;
+}
 
 /**
  * Update the RSS hash key and RSS hash type.
@@ -3195,6 +3256,8 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
 	.promiscuous_enable            = hinic3_dev_promiscuous_enable,
 	.promiscuous_disable           = hinic3_dev_promiscuous_disable,
+	.flow_ctrl_get                 = hinic3_dev_flow_ctrl_get,
+	.flow_ctrl_set                 = hinic3_dev_flow_ctrl_set,
 	.rss_hash_update               = hinic3_rss_hash_update,
 	.rss_hash_conf_get             = hinic3_rss_conf_get,
 	.reta_update                   = hinic3_rss_reta_update,
@@ -3212,6 +3275,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.mac_addr_remove               = hinic3_mac_addr_remove,
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
+	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 	.get_reg                       = hinic3_get_reg,
 };
 
@@ -3256,6 +3320,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.mac_addr_remove               = hinic3_mac_addr_remove,
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
+	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 };
 
 /*
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index bb3644b087..0aa3f4807d 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
 
+#include "hinic3_fdir.h"
+
 #define HINIC3_PMD_DRV_VERSION "B106"
 
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
@@ -84,6 +86,9 @@ enum nic_feature_cap {
 
 #define DEFAULT_DRV_FEATURE 0x3FFF
 
+TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);
+TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);
+
 struct hinic3_nic_dev {
 	struct hinic3_hwdev *hwdev; /**< Hardware device. */
 	struct hinic3_txq **txqs;
@@ -113,14 +118,25 @@ struct hinic3_nic_dev {
 
 	RTE_ATOMIC(uint64_t)dev_status;
 
+	uint8_t pause_set; /**< Flag of PAUSE frame setting. */
+	struct nic_pause_config nic_pause;
+
 	struct rte_ether_addr default_addr;
 	struct rte_ether_addr *mc_list;
 
 	char dev_name[HINIC3_DEV_NAME_LEN];
 	uint64_t feature_cap;
 	uint32_t vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */
+
+	uint16_t tcam_rule_nums;
+	uint16_t ethertype_rule_nums;
+	struct hinic3_tcam_info tcam;
+	struct hinic3_ethertype_filter_list filter_ethertype_list;
+	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
 };
 
+extern const struct rte_flow_ops hinic3_flow_ops;
+
 /**
  * Enable interrupt for the specified RX queue.
  *
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_fdir.c
new file mode 100644
index 0000000000..3886c946fa
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_fdir.c
@@ -0,0 +1,1379 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "base/hinic3_compat.h"
+#include "base/hinic3_hwdev.h"
+#include "base/hinic3_hwif.h"
+#include "base/hinic3_nic_cfg.h"
+#include "hinic3_ethdev.h"
+
+#define HINIC3_UINT1_MAX  0x1
+#define HINIC3_UINT4_MAX  0xf
+#define HINIC3_UINT15_MAX 0x7fff
+
+#define HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev) \
+	(&((struct hinic3_nic_dev *)(nic_dev))->tcam)
+
+/**
+ * Perform a bitwise AND operation on the input key value and mask, and stores
+ * the result in the key_y array.
+ *
+ * @param[out] key_y
+ * Array for storing results.
+ * @param[in] src_input
+ * Input key array.
+ * @param[in] mask
+ * Mask array.
+ * @param[in] len
+ * Length of the key value and mask.
+ */
+static void
+tcam_translate_key_y(uint8_t *key_y, uint8_t *src_input, uint8_t *mask, uint8_t len)
+{
+	uint8_t idx;
+
+	for (idx = 0; idx < len; idx++)
+		key_y[idx] = src_input[idx] & mask[idx];
+}
+
+/**
+ * Convert key_y to key_x using the exclusive OR operation.
+ *
+ * @param[out] key_x
+ * Array for storing results.
+ * @param[in] key_y
+ * Input key array.
+ * @param[in] mask
+ * Mask array.
+ * @param[in] len
+ * Length of the key value and mask.
+ */
+static void
+tcam_translate_key_x(uint8_t *key_x, uint8_t *key_y, uint8_t *mask, uint8_t len)
+{
+	uint8_t idx;
+
+	for (idx = 0; idx < len; idx++)
+		key_x[idx] = key_y[idx] ^ mask[idx];
+}
+
+static void
+tcam_key_calculate(struct hinic3_tcam_key *tcam_key,
+		   struct hinic3_tcam_cfg_rule *fdir_tcam_rule)
+{
+	tcam_translate_key_y(fdir_tcam_rule->key.y, (uint8_t *)(&tcam_key->key_info),
+			     (uint8_t *)(&tcam_key->key_mask),
+			     HINIC3_TCAM_FLOW_KEY_SIZE);
+	tcam_translate_key_x(fdir_tcam_rule->key.x, fdir_tcam_rule->key.y,
+			     (uint8_t *)(&tcam_key->key_mask),
+			     HINIC3_TCAM_FLOW_KEY_SIZE);
+}
+
+static void
+hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,
+			   struct hinic3_tcam_key *tcam_key)
+{
+	/* Fill type of ip. */
+	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	/* Fill src IPv4. */
+	tcam_key->key_mask.sipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.src_ip);
+	tcam_key->key_mask.sipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.src_ip);
+	tcam_key->key_info.sipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.src_ip);
+	tcam_key->key_info.sipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.src_ip);
+
+	/* Fill dst IPv4. */
+	tcam_key->key_mask.dipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.dst_ip);
+	tcam_key->key_mask.dipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.dst_ip);
+	tcam_key->key_info.dipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.dst_ip);
+	tcam_key->key_info.dipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);
+}
+
+static void
+hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,
+			   struct hinic3_tcam_key *tcam_key)
+{
+	/* Fill type of ip. */
+	tcam_key->key_mask_ipv6.ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	/* Fill src IPv6. */
+	tcam_key->key_mask_ipv6.sipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
+	tcam_key->key_mask_ipv6.sipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
+	tcam_key->key_mask_ipv6.sipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);
+	tcam_key->key_mask_ipv6.sipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);
+	tcam_key->key_mask_ipv6.sipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);
+	tcam_key->key_mask_ipv6.sipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);
+	tcam_key->key_mask_ipv6.sipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);
+	tcam_key->key_mask_ipv6.sipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);
+	tcam_key->key_info_ipv6.sipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0]);
+	tcam_key->key_info_ipv6.sipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0]);
+	tcam_key->key_info_ipv6.sipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);
+	tcam_key->key_info_ipv6.sipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);
+	tcam_key->key_info_ipv6.sipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);
+	tcam_key->key_info_ipv6.sipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);
+	tcam_key->key_info_ipv6.sipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
+	tcam_key->key_info_ipv6.sipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
+
+	/* Fill dst IPv6. */
+	tcam_key->key_mask_ipv6.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
+	tcam_key->key_mask_ipv6.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
+	tcam_key->key_mask_ipv6.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);
+	tcam_key->key_mask_ipv6.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);
+	tcam_key->key_mask_ipv6.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);
+	tcam_key->key_mask_ipv6.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);
+	tcam_key->key_mask_ipv6.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);
+	tcam_key->key_mask_ipv6.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);
+	tcam_key->key_info_ipv6.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);
+	tcam_key->key_info_ipv6.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);
+	tcam_key->key_info_ipv6.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);
+	tcam_key->key_info_ipv6.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);
+	tcam_key->key_info_ipv6.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);
+	tcam_key->key_info_ipv6.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);
+	tcam_key->key_info_ipv6.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
+	tcam_key->key_info_ipv6.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
+}
+
+/**
+ * Set the TCAM information in notunnel scenario.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] rule
+ * Pointer to the filtering rule.
+ * @param[in] tcam_key
+ * Pointer to the TCAM key.
+ */
+static void
+hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *dev,
+			       struct hinic3_fdir_filter *rule,
+			       struct hinic3_tcam_key *tcam_key)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	/* Fill tcam_key info. */
+	tcam_key->key_mask.sport = rule->key_mask.src_port;
+	tcam_key->key_info.sport = rule->key_spec.src_port;
+
+	tcam_key->key_mask.dport = rule->key_mask.dst_port;
+	tcam_key->key_info.dport = rule->key_spec.dst_port;
+
+	tcam_key->key_mask.tunnel_type = HINIC3_UINT4_MAX;
+	tcam_key->key_info.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+
+	tcam_key->key_mask.function_id = HINIC3_UINT15_MAX;
+	tcam_key->key_info.function_id = hinic3_global_func_id(nic_dev->hwdev) &
+					 HINIC3_UINT15_MAX;
+
+	tcam_key->key_mask.ip_proto = rule->key_mask.proto;
+	tcam_key->key_info.ip_proto = rule->key_spec.proto;
+
+	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV4)
+		hinic3_fdir_tcam_ipv4_init(rule, tcam_key);
+	else if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV6)
+		hinic3_fdir_tcam_ipv6_init(rule, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,
+				 struct hinic3_tcam_key *tcam_key)
+{
+	/* Fill type of ip. */
+	tcam_key->key_mask.ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+	/* Fill src ipv4. */
+	tcam_key->key_mask.sipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv4.src_ip);
+	tcam_key->key_mask.sipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv4.src_ip);
+	tcam_key->key_info.sipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv4.src_ip);
+	tcam_key->key_info.sipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv4.src_ip);
+
+	/* Fill dst ipv4. */
+	tcam_key->key_mask.dipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv4.dst_ip);
+	tcam_key->key_mask.dipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv4.dst_ip);
+	tcam_key->key_info.dipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv4.dst_ip);
+	tcam_key->key_info.dipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv4.dst_ip);
+}
+
+static void
+hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,
+				 struct hinic3_tcam_key *tcam_key)
+{
+	/* Fill type of ip. */
+	tcam_key->key_mask_vxlan_ipv6.ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info_vxlan_ipv6.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	/* Use inner dst ipv6 to fill the dst ipv6 of tcam_key. */
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x1]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x1]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x2]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x2]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x3]);
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x3]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x1]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x1]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x2]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x2]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x3]);
+	tcam_key->key_info_vxlan_ipv6.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x3]);
+}
+
+static void
+hinic3_fdir_tcam_outer_ipv6_init(struct hinic3_fdir_filter *rule,
+				 struct hinic3_tcam_key *tcam_key)
+{
+	tcam_key->key_mask_ipv6.sipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
+	tcam_key->key_mask_ipv6.sipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0]);
+	tcam_key->key_mask_ipv6.sipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);
+	tcam_key->key_mask_ipv6.sipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);
+	tcam_key->key_mask_ipv6.sipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);
+	tcam_key->key_mask_ipv6.sipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);
+	tcam_key->key_mask_ipv6.sipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);
+	tcam_key->key_mask_ipv6.sipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);
+	tcam_key->key_info_ipv6.sipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0]);
+	tcam_key->key_info_ipv6.sipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0]);
+	tcam_key->key_info_ipv6.sipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);
+	tcam_key->key_info_ipv6.sipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);
+	tcam_key->key_info_ipv6.sipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);
+	tcam_key->key_info_ipv6.sipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);
+	tcam_key->key_info_ipv6.sipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
+	tcam_key->key_info_ipv6.sipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);
+
+	tcam_key->key_mask_ipv6.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
+	tcam_key->key_mask_ipv6.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);
+	tcam_key->key_mask_ipv6.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);
+	tcam_key->key_mask_ipv6.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);
+	tcam_key->key_mask_ipv6.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);
+	tcam_key->key_mask_ipv6.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);
+	tcam_key->key_mask_ipv6.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);
+	tcam_key->key_mask_ipv6.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);
+	tcam_key->key_info_ipv6.dipv6_key0 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);
+	tcam_key->key_info_ipv6.dipv6_key1 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);
+	tcam_key->key_info_ipv6.dipv6_key2 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);
+	tcam_key->key_info_ipv6.dipv6_key3 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);
+	tcam_key->key_info_ipv6.dipv6_key4 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);
+	tcam_key->key_info_ipv6.dipv6_key5 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);
+	tcam_key->key_info_ipv6.dipv6_key6 =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
+	tcam_key->key_info_ipv6.dipv6_key7 =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);
+}
+
+static void
+hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,
+				 struct hinic3_fdir_filter *rule,
+				 struct hinic3_tcam_key *tcam_key)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	tcam_key->key_mask_ipv6.ip_proto = rule->key_mask.proto;
+	tcam_key->key_info_ipv6.ip_proto = rule->key_spec.proto;
+
+	tcam_key->key_mask_ipv6.tunnel_type = HINIC3_UINT4_MAX;
+	tcam_key->key_info_ipv6.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+
+	tcam_key->key_mask_ipv6.outer_ip_type = HINIC3_UINT1_MAX;
+	tcam_key->key_info_ipv6.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+	tcam_key->key_mask_ipv6.function_id = HINIC3_UINT15_MAX;
+	tcam_key->key_info_ipv6.function_id =
+		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT15_MAX;
+
+	tcam_key->key_mask_ipv6.dport = rule->key_mask.dst_port;
+	tcam_key->key_info_ipv6.dport = rule->key_spec.dst_port;
+
+	tcam_key->key_mask_ipv6.sport = rule->key_mask.src_port;
+	tcam_key->key_info_ipv6.sport = rule->key_spec.src_port;
+
+	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_ANY)
+		hinic3_fdir_tcam_outer_ipv6_init(rule, tcam_key);
+}
+
+/**
+ * Sets the TCAM information in the VXLAN scenario.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] rule
+ * Pointer to the filtering rule.
+ * @param[in] tcam_key
+ * Pointer to the TCAM key.
+ */
+static void
+hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,
+			    struct hinic3_fdir_filter *rule,
+			    struct hinic3_tcam_key *tcam_key)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	if (rule->outer_ip_type == HINIC3_FDIR_IP_TYPE_IPV6) {
+		hinic3_fdir_tcam_ipv6_vxlan_init(dev, rule, tcam_key);
+		return;
+	}
+
+	tcam_key->key_mask.ip_proto = rule->key_mask.proto;
+	tcam_key->key_info.ip_proto = rule->key_spec.proto;
+
+	tcam_key->key_mask.sport = rule->key_mask.src_port;
+	tcam_key->key_info.sport = rule->key_spec.src_port;
+
+	tcam_key->key_mask.dport = rule->key_mask.dst_port;
+	tcam_key->key_info.dport = rule->key_spec.dst_port;
+
+	tcam_key->key_mask.outer_sipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.src_ip);
+	tcam_key->key_mask.outer_sipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.src_ip);
+	tcam_key->key_info.outer_sipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.src_ip);
+	tcam_key->key_info.outer_sipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.src_ip);
+
+	tcam_key->key_mask.outer_dipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.dst_ip);
+	tcam_key->key_mask.outer_dipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.dst_ip);
+	tcam_key->key_info.outer_dipv4_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.dst_ip);
+	tcam_key->key_info.outer_dipv4_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);
+
+	tcam_key->key_mask.vni_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.tunnel.tunnel_id);
+	tcam_key->key_mask.vni_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.tunnel.tunnel_id);
+	tcam_key->key_info.vni_h =
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.tunnel.tunnel_id);
+	tcam_key->key_info.vni_l =
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);
+
+	tcam_key->key_mask.tunnel_type = HINIC3_UINT4_MAX;
+	tcam_key->key_info.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+
+	tcam_key->key_mask.function_id = HINIC3_UINT15_MAX;
+	tcam_key->key_info.function_id = hinic3_global_func_id(nic_dev->hwdev) &
+					 HINIC3_UINT15_MAX;
+
+	if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV4)
+		hinic3_fdir_tcam_vxlan_ipv4_init(rule, tcam_key);
+
+	else if (rule->ip_type == HINIC3_FDIR_IP_TYPE_IPV6)
+		hinic3_fdir_tcam_vxlan_ipv6_init(rule, tcam_key);
+}
+
+static void
+hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,
+			   struct hinic3_fdir_filter *rule,
+			   struct hinic3_tcam_key *tcam_key,
+			   struct hinic3_tcam_cfg_rule *fdir_tcam_rule)
+{
+	/* Initialize the TCAM based on the tunnel type. */
+	if (rule->tunnel_type == HINIC3_FDIR_TUNNEL_MODE_NORMAL)
+		hinic3_fdir_tcam_notunnel_init(dev, rule, tcam_key);
+	else
+		hinic3_fdir_tcam_vxlan_init(dev, rule, tcam_key);
+
+	/* Set the queue index. */
+	fdir_tcam_rule->data.qid = rule->rq_index;
+	/* Calculate key of TCAM. */
+	tcam_key_calculate(tcam_key, fdir_tcam_rule);
+}
+
+/**
+ * Find filter in given ethertype filter list.
+ *
+ * @param[in] filter_list
+ * Point to the Ether filter list.
+ * @param[in] key
+ * The tcam key to find.
+ * @return
+ * If a matching filter is found, the filter is returned, otherwise
+ * RTE_ETH_FILTER_NONE.
+ */
+static inline uint16_t
+hinic3_ethertype_filter_lookup(struct hinic3_ethertype_filter_list *ethertype_list,
+			       uint16_t type)
+{
+	struct rte_flow *it;
+	struct hinic3_filter_t *filter_rules;
+
+	TAILQ_FOREACH(it, ethertype_list, node) {
+		filter_rules = it->rule;
+		if (type == filter_rules->ethertype_filter.ether_type)
+			return filter_rules->ethertype_filter.ether_type;
+	}
+
+	return RTE_ETH_FILTER_NONE;
+}
+
+/**
+ * Find the filter that matches the given key in the TCAM filter list.
+ *
+ * @param[in] filter_list
+ * Point to the tcam filter list.
+ * @param[in] key
+ * The tcam key to find.
+ * @return
+ * If a matching filter is found, the filter is returned, otherwise NULL.
+ */
+static inline struct hinic3_tcam_filter *
+hinic3_tcam_filter_lookup(struct hinic3_tcam_filter_list *filter_list,
+			  struct hinic3_tcam_key *key)
+{
+	struct hinic3_tcam_filter *it;
+
+	TAILQ_FOREACH(it, filter_list, entries) {
+		if (memcmp(key, &it->tcam_key,
+			   sizeof(struct hinic3_tcam_key)) == 0) {
+			return it;
+		}
+	}
+
+	return NULL;
+}
+/**
+ * Allocate memory for dynamic blocks and then add them to the queue.
+ *
+ * @param[in] tcam_info
+ * Point to TCAM information.
+ * @param[in] dynamic_block_id
+ * Indicate the ID of a dynamic block.
+ * @return
+ * Return the pointer to the dynamic block, or NULL if the allocation fails.
+ */
+static struct hinic3_tcam_dynamic_block *
+hinic3_alloc_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,
+				    uint16_t dynamic_block_id)
+{
+	struct hinic3_tcam_dynamic_block *dynamic_block_ptr = NULL;
+
+	dynamic_block_ptr =
+		rte_zmalloc("hinic3_tcam_dynamic_mem",
+			    sizeof(struct hinic3_tcam_dynamic_block), 0);
+	if (dynamic_block_ptr == NULL) {
+		PMD_DRV_LOG(ERR,
+			    "Alloc fdir filter dynamic block index %d memory "
+			    "failed!",
+			    dynamic_block_id);
+		return NULL;
+	}
+
+	dynamic_block_ptr->dynamic_block_id = dynamic_block_id;
+
+	/* Add new block to the end of the TCAM dynamic block list. */
+	TAILQ_INSERT_TAIL(&tcam_info->tcam_dynamic_info.tcam_dynamic_list,
+			  dynamic_block_ptr, entries);
+
+	tcam_info->tcam_dynamic_info.dynamic_block_cnt++;
+
+	return dynamic_block_ptr;
+}
+
+static void
+hinic3_free_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,
+				   struct hinic3_tcam_dynamic_block *dynamic_block_ptr)
+{
+	if (dynamic_block_ptr == NULL)
+		return;
+
+	/* Remove the incoming dynamic block from the TCAM dynamic list. */
+	TAILQ_REMOVE(&tcam_info->tcam_dynamic_info.tcam_dynamic_list,
+		     dynamic_block_ptr, entries);
+	rte_free(dynamic_block_ptr);
+
+	tcam_info->tcam_dynamic_info.dynamic_block_cnt--;
+}
+
+/**
+ * Check whether there are free positions in the dynamic TCAM filter.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] fdir_tcam_rule
+ * Indicate the filtering rule to be searched for.
+ * @param[in] tcam_info
+ * Ternary Content-Addressable Memory (TCAM) information.
+ * @param[in] tcam_filter
+ * Point to the TCAM filter.
+ * @param[out] tcam_index
+ * Indicate the TCAM index to be searched for.
+ * @result
+ * Pointer to the TCAM dynamic block. If the search fails, NULL is returned.
+ */
+static struct hinic3_tcam_dynamic_block *
+hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,
+				  struct hinic3_tcam_cfg_rule *fdir_tcam_rule,
+				  struct hinic3_tcam_info *tcam_info,
+				  struct hinic3_tcam_filter *tcam_filter,
+				  uint16_t *tcam_index)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t block_cnt = tcam_info->tcam_dynamic_info.dynamic_block_cnt;
+	struct hinic3_tcam_dynamic_block *dynamic_block_ptr = NULL;
+	struct hinic3_tcam_dynamic_block *tmp = NULL;
+	uint16_t rule_nums = nic_dev->tcam_rule_nums;
+	int block_alloc_flag = 0;
+	uint16_t dynamic_block_id = 0;
+	uint16_t index;
+	int err;
+
+	/*
+	 * Check whether the number of filtering rules reaches the maximum
+	 * capacity of dynamic TCAM blocks.
+	 */
+	if (rule_nums >= block_cnt * HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {
+		if (block_cnt >= (HINIC3_TCAM_DYNAMIC_MAX_FILTERS /
+				  HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)) {
+			PMD_DRV_LOG(ERR,
+				"Dynamic tcam block is full, alloc failed!");
+			goto failed;
+		}
+		/*
+		 * The TCAM blocks are insufficient.
+		 * Apply for a new TCAM block.
+		 */
+		err = hinic3_alloc_tcam_block(nic_dev->hwdev,
+					      &dynamic_block_id);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				"Fdir filter dynamic tcam alloc block failed!");
+			goto failed;
+		}
+
+		block_alloc_flag = 1;
+
+		/* Applying for Memory. */
+		dynamic_block_ptr =
+			hinic3_alloc_dynamic_block_resource(tcam_info,
+							    dynamic_block_id);
+		if (dynamic_block_ptr == NULL) {
+			PMD_DRV_LOG(ERR, "Fdir filter dynamic alloc block "
+					 "memory failed!");
+			goto block_alloc_failed;
+		}
+	}
+
+	/*
+	 * Find the first dynamic TCAM block that meets dynamci_index_cnt <
+	 * HINIC3_TCAM_DYNAMIC_BLOCK_SIZE.
+	 */
+	TAILQ_FOREACH(tmp, &tcam_info->tcam_dynamic_info.tcam_dynamic_list,
+		      entries) {
+		if (tmp->dynamic_index_cnt < HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)
+			break;
+	}
+
+	if (tmp == NULL ||
+	    tmp->dynamic_index_cnt >= HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {
+		PMD_DRV_LOG(ERR,
+			    "Fdir filter dynamic lookup for index failed!");
+		goto look_up_failed;
+	}
+
+	for (index = 0; index < HINIC3_TCAM_DYNAMIC_BLOCK_SIZE; index++) {
+		if (tmp->dynamic_index[index] == 0)
+			break;
+	}
+
+	/* Find the first free position. */
+	if (index == HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {
+		PMD_DRV_LOG(ERR,
+			    "tcam block 0x%x supports filter rules is full!",
+			    tmp->dynamic_block_id);
+		goto look_up_failed;
+	}
+
+	tcam_filter->dynamic_block_id = tmp->dynamic_block_id;
+	tcam_filter->index = index;
+	*tcam_index = index;
+
+	fdir_tcam_rule->index =
+		HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tmp->dynamic_block_id) +
+		index;
+
+	return tmp;
+
+look_up_failed:
+	if (dynamic_block_ptr != NULL)
+		hinic3_free_dynamic_block_resource(tcam_info,
+						   dynamic_block_ptr);
+
+block_alloc_failed:
+	if (block_alloc_flag == 1)
+		hinic3_free_tcam_block(nic_dev->hwdev, &dynamic_block_id);
+
+failed:
+	return NULL;
+}
+
+/**
+ * Add a TCAM filter.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] tcam_key
+ * Pointer to the TCAM key.
+ * @param[in] fdir_tcam_rule
+ * Pointer to the  TCAM filtering rule.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_add_tcam_filter(struct rte_eth_dev *dev,
+		       struct hinic3_tcam_key *tcam_key,
+		       struct hinic3_tcam_cfg_rule *fdir_tcam_rule)
+{
+	struct hinic3_tcam_info *tcam_info =
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_tcam_dynamic_block *dynamic_block_ptr = NULL;
+	struct hinic3_tcam_dynamic_block *tmp = NULL;
+	struct hinic3_tcam_filter *tcam_filter;
+	uint16_t tcam_block_index = 0;
+	uint16_t index = 0;
+	int err;
+
+	/* Alloc TCAM filter memory. */
+	tcam_filter = rte_zmalloc("hinic3_fdir_filter",
+				  sizeof(struct hinic3_tcam_filter), 0);
+	if (tcam_filter == NULL)
+		return -ENOMEM;
+
+	tcam_filter->tcam_key = *tcam_key;
+	tcam_filter->queue = (uint16_t)(fdir_tcam_rule->data.qid);
+
+	/* Add new TCAM rules. */
+	if (nic_dev->tcam_rule_nums == 0) {
+		err = hinic3_alloc_tcam_block(nic_dev->hwdev,
+					      &tcam_block_index);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Fdir filter tcam alloc block failed!");
+			goto failed;
+		}
+
+		dynamic_block_ptr =
+			hinic3_alloc_dynamic_block_resource(tcam_info,
+							    tcam_block_index);
+		if (dynamic_block_ptr == NULL) {
+			PMD_DRV_LOG(ERR, "Fdir filter alloc dynamic first "
+					 "block memory failed!");
+			goto alloc_block_failed;
+		}
+	}
+
+	/*
+	 * Look for an available index in the dynamic block to store the new
+	 * TCAM filter.
+	 */
+	tmp = hinic3_dynamic_lookup_tcam_filter(dev, fdir_tcam_rule, tcam_info,
+						tcam_filter, &index);
+	if (tmp == NULL) {
+		PMD_DRV_LOG(ERR, "Dynamic lookup tcam filter failed!");
+		goto lookup_tcam_index_failed;
+	}
+
+	/* Add a new TCAM rule to the network device. */
+	err = hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule,
+				   TCAM_RULE_FDIR_TYPE);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Fdir_tcam_rule add failed!");
+		goto add_tcam_rules_failed;
+	}
+
+	/* If there are no rules, TCAM filtering is enabled. */
+	if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums)) {
+		err = hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev, true);
+		if (err)
+			goto enable_failed;
+	}
+
+	/* Add a filter to the end of the queue. */
+	TAILQ_INSERT_TAIL(&tcam_info->tcam_list, tcam_filter, entries);
+
+	/* Update dynamic index. */
+	tmp->dynamic_index[index] = 1;
+	tmp->dynamic_index_cnt++;
+
+	nic_dev->tcam_rule_nums++;
+
+	PMD_DRV_LOG(INFO,
+		    "Add fdir tcam rule, function_id: 0x%x, "
+		    "tcam_block_id: %d, local_index: %d, global_index: %d, "
+		    "queue: %d, "
+		    "tcam_rule_nums: %d succeed",
+		    hinic3_global_func_id(nic_dev->hwdev),
+		    tcam_filter->dynamic_block_id, index, fdir_tcam_rule->index,
+		    fdir_tcam_rule->data.qid, nic_dev->tcam_rule_nums);
+
+	return 0;
+
+enable_failed:
+	hinic3_del_tcam_rule(nic_dev->hwdev, fdir_tcam_rule->index,
+				   TCAM_RULE_FDIR_TYPE);
+
+add_tcam_rules_failed:
+lookup_tcam_index_failed:
+	if (nic_dev->tcam_rule_nums == 0 && dynamic_block_ptr != NULL)
+		hinic3_free_dynamic_block_resource(tcam_info,
+						   dynamic_block_ptr);
+
+alloc_block_failed:
+	if (nic_dev->tcam_rule_nums == 0)
+		hinic3_free_tcam_block(nic_dev->hwdev, &tcam_block_index);
+
+failed:
+	rte_free(tcam_filter);
+	return -EFAULT;
+}
+
+/**
+ * Delete a TCAM filter.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] tcam_filter
+ * TCAM Filters to Delete.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *dev,
+			       struct hinic3_tcam_filter *tcam_filter)
+{
+	struct hinic3_tcam_info *tcam_info =
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t dynamic_block_id = tcam_filter->dynamic_block_id;
+	struct hinic3_tcam_dynamic_block *tmp = NULL;
+	uint32_t index = 0;
+	int err;
+
+	/* Traverse to find the block that matches the given ID. */
+	TAILQ_FOREACH(tmp, &tcam_info->tcam_dynamic_info.tcam_dynamic_list,
+		      entries) {
+		if (tmp->dynamic_block_id == dynamic_block_id)
+			break;
+	}
+
+	if (tmp == NULL || tmp->dynamic_block_id != dynamic_block_id) {
+		PMD_DRV_LOG(ERR,
+			    "Fdir filter del dynamic lookup for block failed!");
+		return -EINVAL;
+	}
+	/* Calculate TCAM index. */
+	index = HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tmp->dynamic_block_id) +
+		tcam_filter->index;
+
+	/* Delete a specified rule. */
+	err = hinic3_del_tcam_rule(nic_dev->hwdev, index, TCAM_RULE_FDIR_TYPE);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Fdir tcam rule del failed!");
+		return -EFAULT;
+	}
+
+	PMD_DRV_LOG(INFO,
+		    "Del fdir_tcam_dynamic_rule function_id: 0x%x, "
+		    "tcam_block_id: %d, local_index: %d, global_index: %d, "
+		    "local_rules_nums: %d, global_rule_nums: %d succeed",
+		    hinic3_global_func_id(nic_dev->hwdev), dynamic_block_id,
+		    tcam_filter->index, index, tmp->dynamic_index_cnt - 1,
+		    nic_dev->tcam_rule_nums - 1);
+
+	tmp->dynamic_index[tcam_filter->index] = 0;
+	tmp->dynamic_index_cnt--;
+	nic_dev->tcam_rule_nums--;
+	if (tmp->dynamic_index_cnt == 0) {
+		hinic3_free_tcam_block(nic_dev->hwdev, &dynamic_block_id);
+
+		hinic3_free_dynamic_block_resource(tcam_info, tmp);
+	}
+
+	/* If the number of rules is 0, the TCAM filter is disabled. */
+	if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums))
+		hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev, false);
+
+	return 0;
+}
+
+static int
+hinic3_del_tcam_filter(struct rte_eth_dev *dev,
+		       struct hinic3_tcam_filter *tcam_filter)
+{
+	struct hinic3_tcam_info *tcam_info =
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
+	int err;
+
+	err = hinic3_del_dynamic_tcam_filter(dev, tcam_filter);
+	if (err < 0) {
+		PMD_DRV_LOG(ERR, "Del dynamic tcam filter failed!");
+		return err;
+	}
+
+	/* Remove the filter from the TCAM list. */
+	TAILQ_REMOVE(&tcam_info->tcam_list, tcam_filter, entries);
+
+	rte_free(tcam_filter);
+
+	return 0;
+}
+
+/**
+ * Add or deletes an fdir filter rule. This is the core function for operating
+ * filters.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] fdir_filter
+ * Pointer to the fdir filter.
+ * @param[in] add
+ * This is a Boolean value (of the bool type) indicating whether the action to
+ * be performed is to add (true) or delete (false) the filter rule.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int
+hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
+				struct hinic3_fdir_filter *fdir_filter,
+				bool add)
+{
+	struct hinic3_tcam_info *tcam_info =
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
+	struct hinic3_tcam_filter *tcam_filter;
+	struct hinic3_tcam_cfg_rule fdir_tcam_rule;
+	struct hinic3_tcam_key tcam_key;
+	int ret;
+
+	memset(&fdir_tcam_rule, 0, sizeof(struct hinic3_tcam_cfg_rule));
+	memset((void *)&tcam_key, 0, sizeof(struct hinic3_tcam_key));
+
+	hinic3_fdir_tcam_info_init(dev, fdir_filter, &tcam_key,
+				   &fdir_tcam_rule);
+	/* Search for a filter. */
+	tcam_filter =
+		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key);
+	if (tcam_filter != NULL && add) {
+		PMD_DRV_LOG(ERR, "Filter exists.");
+		return -EEXIST;
+	}
+	if (tcam_filter == NULL && !add) {
+		PMD_DRV_LOG(ERR, "Filter doesn't exist.");
+		return -ENOENT;
+	}
+
+	/*
+	 * If the value of Add is true, the system performs the adding
+	 * operation.
+	 */
+	if (add) {
+		ret = hinic3_add_tcam_filter(dev, &tcam_key, &fdir_tcam_rule);
+		if (ret)
+			goto cfg_tcam_filter_err;
+
+		fdir_filter->tcam_index = (int)(fdir_tcam_rule.index);
+	} else {
+		PMD_DRV_LOG(INFO, "begin to del tcam filter");
+		ret = hinic3_del_tcam_filter(dev, tcam_filter);
+		if (ret)
+			goto cfg_tcam_filter_err;
+	}
+
+	return 0;
+
+cfg_tcam_filter_err:
+
+	return ret;
+}
+
+/**
+ * Enable or disable the TCAM filter for the receive queue.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] able
+ * Flag to enable or disable the filter.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int
+hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_id, uint32_t able)
+{
+	struct hinic3_tcam_info *tcam_info =
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_tcam_filter *it;
+	struct hinic3_tcam_cfg_rule fdir_tcam_rule;
+	int ret;
+	uint32_t queue_res;
+	uint16_t index;
+
+	memset(&fdir_tcam_rule, 0, sizeof(struct hinic3_tcam_cfg_rule));
+
+	if (able) {
+		TAILQ_FOREACH(it, &tcam_info->tcam_list, entries) {
+			if (queue_id == it->queue) {
+				index = (uint16_t)(HINIC3_PKT_TCAM_DYNAMIC_INDEX_START
+					      (it->dynamic_block_id) + it->index);
+
+				/*
+				 * When the rxq is start, find invalid rxq_id
+				 * and delete the fdir rule from the tcam.
+				 */
+				ret = hinic3_del_tcam_rule(nic_dev->hwdev,
+							   index,
+							   TCAM_RULE_FDIR_TYPE);
+				if (ret) {
+					PMD_DRV_LOG(ERR, "del invalid tcam "
+							 "rule failed!");
+					return -EFAULT;
+				}
+
+				fdir_tcam_rule.index = index;
+				fdir_tcam_rule.data.qid = queue_id;
+				tcam_key_calculate(&it->tcam_key,
+						   &fdir_tcam_rule);
+
+				/* To enable a rule, add a rule. */
+				ret = hinic3_add_tcam_rule(nic_dev->hwdev,
+							   &fdir_tcam_rule,
+							   TCAM_RULE_FDIR_TYPE);
+				if (ret) {
+					PMD_DRV_LOG(ERR, "add correct tcam "
+							 "rule failed!");
+					return -EFAULT;
+				}
+			}
+		}
+	} else {
+		queue_res = HINIC3_INVALID_QID_BASE | queue_id;
+
+		TAILQ_FOREACH(it, &tcam_info->tcam_list, entries) {
+			if (queue_id == it->queue) {
+				index = (uint16_t)(HINIC3_PKT_TCAM_DYNAMIC_INDEX_START
+					      (it->dynamic_block_id) + it->index);
+
+				/*
+				 * When the rxq is stop, delete the fdir rule
+				 * from the tcam and add the correct fdir rule
+				 * from the tcam.
+				 */
+				ret = hinic3_del_tcam_rule(nic_dev->hwdev,
+							   index,
+							   TCAM_RULE_FDIR_TYPE);
+				if (ret) {
+					PMD_DRV_LOG(ERR, "del correct tcam "
+							 "rule failed!");
+					return -EFAULT;
+				}
+
+				fdir_tcam_rule.index = index;
+				fdir_tcam_rule.data.qid = queue_res;
+				tcam_key_calculate(&it->tcam_key,
+						   &fdir_tcam_rule);
+
+				/* Add the correct fdir rule from the tcam. */
+				ret = hinic3_add_tcam_rule(nic_dev->hwdev,
+							   &fdir_tcam_rule,
+							   TCAM_RULE_FDIR_TYPE);
+				if (ret) {
+					PMD_DRV_LOG(ERR, "add invalid tcam "
+							 "rule failed!");
+					return -EFAULT;
+				}
+			}
+		}
+	}
+
+	return ret;
+}
+
+void
+hinic3_free_fdir_filter(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev, false);
+
+	hinic3_flush_tcam_rule(nic_dev->hwdev);
+}
+
+static int
+hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,
+			   struct rte_eth_ethertype_filter *ethertype_filter,
+			   bool add)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int ret;
+
+	/* Setting the ARP Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_ARP,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		return ret;
+	}
+
+	/* Setting the ARP Request Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_ARP_REQ,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s arp request rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		goto set_arp_req_failed;
+	}
+
+	/* Setting the ARP Response Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_ARP_REP,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s arp response rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		goto set_arp_rep_failed;
+	}
+
+	return 0;
+
+set_arp_rep_failed:
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_ARP_REQ,
+					       ethertype_filter->queue, !add);
+
+set_arp_req_failed:
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_ARP,
+					       ethertype_filter->queue, !add);
+
+	return ret;
+}
+
+static int
+hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,
+			    struct rte_eth_ethertype_filter *ethertype_filter,
+			    bool add)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int ret;
+
+	/* Setting the LACP Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_LACP,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s lacp fdir rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		return ret;
+	}
+
+	/* Setting the OAM Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_OAM,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s oam rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		goto set_arp_oam_failed;
+	}
+
+	return 0;
+
+set_arp_oam_failed:
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_LACP,
+					       ethertype_filter->queue, !add);
+
+	return ret;
+}
+
+static int
+hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,
+			    struct rte_eth_ethertype_filter *ethertype_filter,
+			    bool add)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int ret;
+
+	/* Setting the LLDP Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_LLDP,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s lldp fdir rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		return ret;
+	}
+
+	/* Setting the CDCP Filter. */
+	ret = hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_CDCP,
+					       ethertype_filter->queue, add);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s cdcp fdir rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		goto set_arp_cdcp_failed;
+	}
+
+	return 0;
+
+set_arp_cdcp_failed:
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+					       HINIC3_PKT_TYPE_LLDP,
+					       ethertype_filter->queue, !add);
+
+	return ret;
+}
+
+static int
+hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,
+					  struct rte_eth_ethertype_filter *ethertype_filter,
+					  bool add)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_ethertype_filter_list *ethertype_list =
+		&nic_dev->filter_ethertype_list;
+
+	/* Check whether the transferred rule exists. */
+	if (hinic3_ethertype_filter_lookup(ethertype_list,
+					   ethertype_filter->ether_type)) {
+		if (add) {
+			PMD_DRV_LOG(ERR,
+				"The rule already exists, can not to be added");
+			return -EPERM;
+		}
+	} else {
+		if (!add) {
+			PMD_DRV_LOG(ERR,
+				"The rule not exists, can not to be delete");
+			return -EPERM;
+		}
+	}
+	/* Create a filter based on the protocol type. */
+	switch (ethertype_filter->ether_type) {
+	case RTE_ETHER_TYPE_ARP:
+		return hinic3_flow_set_arp_filter(dev, ethertype_filter, add);
+	case RTE_ETHER_TYPE_RARP:
+		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+			HINIC3_PKT_TYPE_RARP, ethertype_filter->queue, add);
+
+	case RTE_ETHER_TYPE_SLOW:
+		return hinic3_flow_set_slow_filter(dev, ethertype_filter, add);
+
+	case RTE_ETHER_TYPE_LLDP:
+		return hinic3_flow_set_lldp_filter(dev, ethertype_filter, add);
+
+	case RTE_ETHER_TYPE_CNM:
+		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+			HINIC3_PKT_TYPE_CNM, ethertype_filter->queue, add);
+
+	case RTE_ETHER_TYPE_ECP:
+		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,
+			HINIC3_PKT_TYPE_ECP, ethertype_filter->queue, add);
+
+	default:
+		PMD_DRV_LOG(ERR, "Unknown ethertype %d queue_id %d",
+			    ethertype_filter->ether_type,
+			    ethertype_filter->queue);
+		return -EPERM;
+	}
+}
+
+static int
+hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype_filter)
+{
+	switch (ethertype_filter->ether_type) {
+	case RTE_ETHER_TYPE_ARP:
+		return HINIC3_ARP_RULE_NUM;
+	case RTE_ETHER_TYPE_RARP:
+		return HINIC3_RARP_RULE_NUM;
+	case RTE_ETHER_TYPE_SLOW:
+		return HINIC3_SLOW_RULE_NUM;
+	case RTE_ETHER_TYPE_LLDP:
+		return HINIC3_LLDP_RULE_NUM;
+	case RTE_ETHER_TYPE_CNM:
+		return HINIC3_CNM_RULE_NUM;
+	case RTE_ETHER_TYPE_ECP:
+		return HINIC3_ECP_RULE_NUM;
+
+	default:
+		PMD_DRV_LOG(ERR, "Unknown ethertype %d",
+			    ethertype_filter->ether_type);
+		return 0;
+	}
+}
+
+/**
+ * Add or delete an Ethernet type filter rule.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] ethertype_filter
+ * Pointer to ethertype filter.
+ * @param[in] add
+ * This is a Boolean value (of the bool type) indicating whether the action to
+ * be performed is to add (true) or delete (false) the Ethernet type filter
+ * rule.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int
+hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,
+				     struct rte_eth_ethertype_filter *ethertype_filter,
+				     bool add)
+{
+	/* Get dev private info. */
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int ret;
+	/* Add or remove an Ethernet type filter rule. */
+	ret = hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter,
+							add);
+
+	if (ret) {
+		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",
+			    add ? "Add" : "Del", ret);
+		return ret;
+	}
+	/*
+	 * If a rule is added and the rule is the first rule, rule filtering is
+	 * enabled. If a rule is deleted and the rule is the last one, rule
+	 * filtering is disabled.
+	 */
+	if (add) {
+		if (nic_dev->ethertype_rule_nums == 0) {
+			ret = hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev,
+							       true);
+			if (ret) {
+				PMD_DRV_LOG(ERR,
+					    "enable fdir rule failed, err: %d",
+					    ret);
+				goto enable_fdir_failed;
+			}
+		}
+		nic_dev->ethertype_rule_nums =
+			nic_dev->ethertype_rule_nums +
+			hinic3_flow_ethertype_rule_nums(ethertype_filter);
+	} else {
+		nic_dev->ethertype_rule_nums =
+			nic_dev->ethertype_rule_nums -
+			hinic3_flow_ethertype_rule_nums(ethertype_filter);
+
+		if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums)) {
+			ret = hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev,
+							       false);
+			if (ret) {
+				PMD_DRV_LOG(ERR,
+					    "disable fdir rule failed, err: %d",
+					    ret);
+			}
+		}
+	}
+
+	return 0;
+
+enable_fdir_failed:
+	hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter,
+							!add);
+	return ret;
+}
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_fdir.h
new file mode 100644
index 0000000000..8659f588d9
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_fdir.h
@@ -0,0 +1,398 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_FDIR_H_
+#define _HINIC3_FDIR_H_
+
+#define HINIC3_FLOW_MAX_PATTERN_NUM 16
+
+#define HINIC3_TCAM_DYNAMIC_BLOCK_SIZE 16
+
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS 1024
+
+#define HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_index) \
+	(HINIC3_TCAM_DYNAMIC_BLOCK_SIZE * (block_index))
+
+/* Indicate a traffic filtering rule. */
+struct rte_flow {
+	TAILQ_ENTRY(rte_flow) node;
+	enum rte_filter_type filter_type;
+	void *rule;
+};
+
+struct hinic3_fdir_rule_key {
+	struct rte_eth_ipv4_flow ipv4;
+	struct rte_eth_ipv6_flow ipv6;
+	struct rte_eth_ipv4_flow inner_ipv4;
+	struct rte_eth_ipv6_flow inner_ipv6;
+	struct rte_eth_tunnel_flow tunnel;
+	uint16_t src_port;
+	uint16_t dst_port;
+	uint8_t proto;
+};
+
+struct hinic3_fdir_filter {
+	int tcam_index;
+	uint8_t ip_type; /**< Inner ip type. */
+	uint8_t outer_ip_type;
+	uint8_t tunnel_type;
+	struct hinic3_fdir_rule_key key_mask;
+	struct hinic3_fdir_rule_key key_spec;
+	uint32_t rq_index; /**< Queue assigned when matched. */
+};
+
+/* This structure is used to describe a basic filter type. */
+struct hinic3_filter_t {
+	uint16_t filter_rule_nums;
+	enum rte_filter_type filter_type;
+	struct rte_eth_ethertype_filter ethertype_filter;
+	struct hinic3_fdir_filter fdir_filter;
+};
+
+enum hinic3_fdir_tunnel_mode {
+	HINIC3_FDIR_TUNNEL_MODE_NORMAL = 0,
+	HINIC3_FDIR_TUNNEL_MODE_VXLAN = 1,
+};
+
+enum hinic3_fdir_ip_type {
+	HINIC3_FDIR_IP_TYPE_IPV4 = 0,
+	HINIC3_FDIR_IP_TYPE_IPV6 = 1,
+	HINIC3_FDIR_IP_TYPE_ANY = 2,
+};
+
+/* Describe the key structure of the TCAM. */
+struct hinic3_tcam_key_mem {
+#if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
+	uint32_t rsvd0 : 16;
+	uint32_t ip_proto : 8;
+	uint32_t tunnel_type : 4;
+	uint32_t rsvd1 : 4;
+
+	uint32_t function_id : 15;
+	uint32_t ip_type : 1;
+
+	uint32_t sipv4_h : 16;
+	uint32_t sipv4_l : 16;
+
+	uint32_t dipv4_h : 16;
+	uint32_t dipv4_l : 16;
+	uint32_t rsvd2 : 16;
+
+	uint32_t rsvd3;
+
+	uint32_t rsvd4 : 16;
+	uint32_t dport : 16;
+
+	uint32_t sport : 16;
+	uint32_t rsvd5 : 16;
+
+	uint32_t rsvd6 : 16;
+	uint32_t outer_sipv4_h : 16;
+	uint32_t outer_sipv4_l : 16;
+
+	uint32_t outer_dipv4_h : 16;
+	uint32_t outer_dipv4_l : 16;
+	uint32_t vni_h : 16;
+
+	uint32_t vni_l : 16;
+	uint32_t rsvd7 : 16;
+#else
+	uint32_t rsvd1 : 4;
+	uint32_t tunnel_type : 4;
+	uint32_t ip_proto : 8;
+	uint32_t rsvd0 : 16;
+
+	uint32_t sipv4_h : 16;
+	uint32_t ip_type : 1;
+	uint32_t function_id : 15;
+
+	uint32_t dipv4_h : 16;
+	uint32_t sipv4_l : 16;
+
+	uint32_t rsvd2 : 16;
+	uint32_t dipv4_l : 16;
+
+	uint32_t rsvd3;
+
+	uint32_t dport : 16;
+	uint32_t rsvd4 : 16;
+
+	uint32_t rsvd5 : 16;
+	uint32_t sport : 16;
+
+	uint32_t outer_sipv4_h : 16;
+	uint32_t rsvd6 : 16;
+
+	uint32_t outer_dipv4_h : 16;
+	uint32_t outer_sipv4_l : 16;
+
+	uint32_t vni_h : 16;
+	uint32_t outer_dipv4_l : 16;
+
+	uint32_t rsvd7 : 16;
+	uint32_t vni_l : 16;
+#endif
+};
+
+/*
+ * Define the IPv6-related TCAM key data structure in common
+ * scenarios or IPv6 tunnel scenarios.
+ */
+struct hinic3_tcam_key_ipv6_mem {
+#if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
+	uint32_t rsvd0 : 16;
+	/* Indicates the normal IPv6 nextHdr or inner IPv4/IPv6 next proto. */
+	uint32_t ip_proto : 8;
+	uint32_t tunnel_type : 4;
+	uint32_t outer_ip_type : 1;
+	uint32_t rsvd1 : 3;
+
+	uint32_t function_id : 15;
+	uint32_t ip_type : 1;
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
+	uint32_t dport : 16;
+
+	uint32_t sport : 16;
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
+	uint32_t rsvd2 : 16;
+#else
+	uint32_t rsvd1 : 3;
+	uint32_t outer_ip_type : 1;
+	uint32_t tunnel_type : 4;
+	uint32_t ip_proto : 8;
+	uint32_t rsvd0 : 16;
+
+	uint32_t sipv6_key0 : 16;
+	uint32_t ip_type : 1;
+	uint32_t function_id : 15;
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
+	uint32_t dport : 16;
+	uint32_t sipv6_key7 : 16;
+
+	uint32_t dipv6_key0 : 16;
+	uint32_t sport : 16;
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
+	uint32_t rsvd2 : 16;
+	uint32_t dipv6_key7 : 16;
+#endif
+};
+
+/*
+ * Define the tcam key value data structure related to IPv6 in
+ * the VXLAN scenario.
+ */
+struct hinic3_tcam_key_vxlan_ipv6_mem {
+#if (RTE_BYTE_ORDER == RTE_BIG_ENDIAN)
+	uint32_t rsvd0 : 16;
+	uint32_t ip_proto : 8;
+	uint32_t tunnel_type : 4;
+	uint32_t rsvd1 : 4;
+
+	uint32_t function_id : 15;
+	uint32_t ip_type : 1;
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
+	uint32_t dport : 16;
+
+	uint32_t sport : 16;
+	uint32_t rsvd2 : 16;
+
+	uint32_t rsvd3 : 16;
+	uint32_t outer_sipv4_h : 16;
+
+	uint32_t outer_sipv4_l : 16;
+	uint32_t outer_dipv4_h : 16;
+
+	uint32_t outer_dipv4_l : 16;
+	uint32_t vni_h : 16;
+
+	uint32_t vni_l : 16;
+	uint32_t rsvd4 : 16;
+#else
+	uint32_t rsvd1 : 4;
+	uint32_t tunnel_type : 4;
+	uint32_t ip_proto : 8;
+	uint32_t rsvd0 : 16;
+
+	uint32_t dipv6_key0 : 16;
+	uint32_t ip_type : 1;
+	uint32_t function_id : 15;
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
+	uint32_t dport : 16;
+	uint32_t dipv6_key7 : 16;
+
+	uint32_t rsvd2 : 16;
+	uint32_t sport : 16;
+
+	uint32_t outer_sipv4_h : 16;
+	uint32_t rsvd3 : 16;
+
+	uint32_t outer_dipv4_h : 16;
+	uint32_t outer_sipv4_l : 16;
+
+	uint32_t vni_h : 16;
+	uint32_t outer_dipv4_l : 16;
+
+	uint32_t rsvd4 : 16;
+	uint32_t vni_l : 16;
+#endif
+};
+
+/*
+ * TCAM key structure. The two unions indicate the key and mask respectively.
+ * The TCAM key is consistent with the TCAM entry.
+ */
+struct hinic3_tcam_key {
+	union {
+		struct hinic3_tcam_key_mem key_info;
+		struct hinic3_tcam_key_ipv6_mem key_info_ipv6;
+		struct hinic3_tcam_key_vxlan_ipv6_mem key_info_vxlan_ipv6;
+	};
+	union {
+		struct hinic3_tcam_key_mem key_mask;
+		struct hinic3_tcam_key_ipv6_mem key_mask_ipv6;
+		struct hinic3_tcam_key_vxlan_ipv6_mem key_mask_vxlan_ipv6;
+	};
+};
+
+/* Structure indicates the TCAM filter. */
+struct hinic3_tcam_filter {
+	TAILQ_ENTRY(hinic3_tcam_filter)
+	entries; /**< Filter entry, used for linked list operations. */
+	uint16_t dynamic_block_id;	 /**< Dynamic block ID. */
+	uint16_t index;			 /**< TCAM index. */
+	struct hinic3_tcam_key tcam_key; /**< Indicate TCAM key. */
+	uint16_t queue;			 /**< Allocated RX queue. */
+};
+
+/* Define a linked list header for storing hinic3_tcam_filter data. */
+TAILQ_HEAD(hinic3_tcam_filter_list, hinic3_tcam_filter);
+
+struct hinic3_tcam_dynamic_block {
+	TAILQ_ENTRY(hinic3_tcam_dynamic_block) entries;
+	uint16_t dynamic_block_id;
+	uint16_t dynamic_index_cnt;
+	uint8_t dynamic_index[HINIC3_TCAM_DYNAMIC_BLOCK_SIZE];
+};
+
+/* Define a linked list header for storing hinic3_tcam_dynamic_block data. */
+TAILQ_HEAD(hinic3_tcam_dynamic_filter_list, hinic3_tcam_dynamic_block);
+
+/* Indicate TCAM dynamic block info. */
+struct hinic3_tcam_dynamic_block_info {
+	struct hinic3_tcam_dynamic_filter_list tcam_dynamic_list;
+	uint16_t dynamic_block_cnt;
+};
+
+/* Structure is used to store TCAM information. */
+struct hinic3_tcam_info {
+	struct hinic3_tcam_filter_list tcam_list;
+	struct hinic3_tcam_dynamic_block_info tcam_dynamic_info;
+};
+
+/* Obtain the upper and lower 16 bits. */
+#define HINIC3_32_UPPER_16_BITS(n) ((((n) >> 16)) & 0xffff)
+#define HINIC3_32_LOWER_16_BITS(n) ((n) & 0xffff)
+
+/* Number of protocol rules */
+#define HINIC3_ARP_RULE_NUM  3
+#define HINIC3_RARP_RULE_NUM 1
+#define HINIC3_SLOW_RULE_NUM 2
+#define HINIC3_LLDP_RULE_NUM 2
+#define HINIC3_CNM_RULE_NUM  1
+#define HINIC3_ECP_RULE_NUM  2
+
+/* Define Ethernet type. */
+#define RTE_ETHER_TYPE_CNM 0x22e7
+#define RTE_ETHER_TYPE_ECP 0x8940
+
+/* Protocol type of the data packet. */
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
+
+	HINIC3_PKT_UNKNOWN = 31,
+};
+
+int hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,
+				    struct hinic3_fdir_filter *fdir_filter,
+				    bool add);
+int hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,
+					 struct rte_eth_ethertype_filter *ethertype_filter,
+					 bool add);
+
+void hinic3_free_fdir_filter(struct rte_eth_dev *dev);
+int hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_id,
+				  uint32_t able);
+int hinic3_flow_parse_attr(const struct rte_flow_attr *attr,
+			   struct rte_flow_error *error);
+
+#endif /**< _HINIC3_FDIR_H_ */
diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_flow.c
new file mode 100644
index 0000000000..004d5a4889
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_flow.c
@@ -0,0 +1,1501 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include <rte_flow_driver.h>
+
+#include "base/hinic3_compat.h"
+#include "base/hinic3_hwdev.h"
+#include "base/hinic3_nic_cfg.h"
+#include "hinic3_ethdev.h"
+#include "hinic3_flow.h"
+
+#define HINIC3_UINT8_MAX 0xff
+
+typedef int (*hinic3_parse_filter_t)(struct rte_eth_dev *dev,
+				     const struct rte_flow_attr *attr,
+				     const struct rte_flow_item pattern[],
+				     const struct rte_flow_action actions[],
+				     struct rte_flow_error *error,
+				     struct hinic3_filter_t *filter);
+
+/* Indicate valid filter mode . */
+struct hinic3_valid_pattern {
+	enum rte_flow_item_type *items;
+	hinic3_parse_filter_t parse_filter;
+};
+
+static int hinic3_flow_parse_fdir_filter(struct rte_eth_dev *dev,
+					 const struct rte_flow_attr *attr,
+					 const struct rte_flow_item pattern[],
+					 const struct rte_flow_action actions[],
+					 struct rte_flow_error *error,
+					 struct hinic3_filter_t *filter);
+
+static int hinic3_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
+					      const struct rte_flow_attr *attr,
+					      const struct rte_flow_item pattern[],
+					      const struct rte_flow_action actions[],
+					      struct rte_flow_error *error,
+					      struct hinic3_filter_t *filter);
+
+static int hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,
+					       const struct rte_flow_attr *attr,
+					       const struct rte_flow_item pattern[],
+					       const struct rte_flow_action actions[],
+					       struct rte_flow_error *error,
+					       struct hinic3_filter_t *filter);
+
+/*
+ * Define a supported pattern array, including the matching patterns of
+ * various network protocols and corresponding parsing functions.
+ */
+static const struct hinic3_valid_pattern hinic3_supported_patterns[] = {
+	/* Support ethertype. */
+	{pattern_ethertype, hinic3_flow_parse_ethertype_filter},
+	/* Support ipv4 but not tunnel, and any field can be masked. */
+	{pattern_ipv4, hinic3_flow_parse_fdir_filter},
+	{pattern_ipv4_any, hinic3_flow_parse_fdir_filter},
+	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */
+	{pattern_ipv4_udp, hinic3_flow_parse_fdir_filter},
+	{pattern_ipv4_tcp, hinic3_flow_parse_fdir_filter},
+	/* Support ipv4 + icmp not tunnel, and any field can be masked. */
+	{pattern_ipv4_icmp, hinic3_flow_parse_fdir_filter},
+
+	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */
+	{pattern_ethertype_udp, hinic3_flow_parse_fdir_filter},
+	{pattern_ethertype_tcp, hinic3_flow_parse_fdir_filter},
+
+	/* Support ipv4 + vxlan + any, and any field can be masked. */
+	{pattern_ipv4_vxlan, hinic3_flow_parse_fdir_vxlan_filter},
+	/* Support ipv4 + vxlan + ipv4, and any field can be masked. */
+	{pattern_ipv4_vxlan_ipv4, hinic3_flow_parse_fdir_vxlan_filter},
+	/* Support ipv4 + vxlan + ipv4 + l4, and any field can be masked. */
+	{pattern_ipv4_vxlan_ipv4_tcp, hinic3_flow_parse_fdir_vxlan_filter},
+	{pattern_ipv4_vxlan_ipv4_udp, hinic3_flow_parse_fdir_vxlan_filter},
+	/* Support ipv4 + vxlan + ipv6, and any field can be masked. */
+	{pattern_ipv4_vxlan_ipv6, hinic3_flow_parse_fdir_vxlan_filter},
+	/* Support ipv4 + vxlan + ipv6 + l4, and any field can be masked. */
+	{pattern_ipv4_vxlan_ipv6_tcp, hinic3_flow_parse_fdir_vxlan_filter},
+	{pattern_ipv4_vxlan_ipv6_udp, hinic3_flow_parse_fdir_vxlan_filter},
+	/* Support ipv4 + vxlan + l4, and any field can be masked. */
+	{pattern_ipv4_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},
+	{pattern_ipv4_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},
+	{pattern_ipv4_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},
+
+	/* Support ipv6 but not tunnel, and any field can be masked. */
+	{pattern_ipv6, hinic3_flow_parse_fdir_filter},
+	/* Support ipv6 + l4 but not tunnel, and any field can be masked. */
+	{pattern_ipv6_udp, hinic3_flow_parse_fdir_filter},
+	{pattern_ipv6_tcp, hinic3_flow_parse_fdir_filter},
+
+	/* Support ipv6 + vxlan + any, and any field can be masked. */
+	{pattern_ipv6_vxlan, hinic3_flow_parse_fdir_vxlan_filter},
+	{pattern_ipv6_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},
+
+	/* Support ipv6 + vxlan + l4, and any field can be masked. */
+	{pattern_ipv6_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},
+	{pattern_ipv6_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},
+
+};
+
+static inline void
+net_addr_to_host(uint32_t *dst, const uint32_t *src, size_t len)
+{
+	size_t i;
+	for (i = 0; i < len; i++)
+		dst[i] = rte_be_to_cpu_32(src[i]);
+}
+
+static bool
+hinic3_match_pattern(enum rte_flow_item_type *item_array,
+		     const struct rte_flow_item *pattern)
+{
+	const struct rte_flow_item *item = pattern;
+
+	/* skip the first void item. */
+	while (item->type == RTE_FLOW_ITEM_TYPE_VOID)
+		item++;
+
+	/* Find no void item. */
+	while (((*item_array == item->type) &&
+		(*item_array != RTE_FLOW_ITEM_TYPE_END)) ||
+	       (item->type == RTE_FLOW_ITEM_TYPE_VOID)) {
+		if (item->type == RTE_FLOW_ITEM_TYPE_VOID) {
+			item++;
+		} else {
+			item_array++;
+			item++;
+		}
+	}
+
+	return (*item_array == RTE_FLOW_ITEM_TYPE_END &&
+		item->type == RTE_FLOW_ITEM_TYPE_END);
+}
+
+/**
+ * Find matching parsing filter functions.
+ *
+ * @param[in] pattern
+ * Pattern to match.
+ * @return
+ * Matched resolution filter. If no resolution filter is found, return NULL.
+ */
+static hinic3_parse_filter_t
+hinic3_find_parse_filter_func(const struct rte_flow_item *pattern)
+{
+	hinic3_parse_filter_t parse_filter = NULL;
+	uint8_t i;
+	/* Traverse all supported patterns. */
+	for (i = 0; i < RTE_DIM(hinic3_supported_patterns); i++) {
+		if (hinic3_match_pattern(hinic3_supported_patterns[i].items,
+					 pattern)) {
+			parse_filter =
+				hinic3_supported_patterns[i].parse_filter;
+			break;
+		}
+	}
+
+	return parse_filter;
+}
+
+/**
+ * Action for parsing and processing Ethernet types.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @param[out] filter
+ * Filter information, its used to store and manipulate packet filtering rules.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_parse_action(struct rte_eth_dev *dev,
+			 const struct rte_flow_action *actions,
+			 struct rte_flow_error *error,
+			 struct hinic3_filter_t *filter)
+{
+	const struct rte_flow_action_queue *act_q;
+	const struct rte_flow_action *act = actions;
+
+	/* skip the first void item. */
+	while (act->type == RTE_FLOW_ACTION_TYPE_VOID)
+		act++;
+
+	switch (act->type) {
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		act_q = (const struct rte_flow_action_queue *)act->conf;
+		filter->fdir_filter.rq_index = act_q->index;
+		if (filter->fdir_filter.rq_index >= dev->data->nb_rx_queues) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ACTION, act,
+					   "Invalid action param.");
+			return -rte_errno;
+		}
+		break;
+	default:
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				   act, "Invalid action type.");
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+int
+hinic3_flow_parse_attr(const struct rte_flow_attr *attr,
+		       struct rte_flow_error *error)
+{
+	/* Not supported. */
+	if (!attr->ingress || attr->egress || attr->priority || attr->group) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, attr,
+				   "Only support ingress.");
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_item,
+		      struct hinic3_filter_t *filter,
+		      struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *spec_ipv4, *mask_ipv4;
+
+	mask_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->mask;
+	spec_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->spec;
+	if (!mask_ipv4 || !spec_ipv4) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter ipv4 mask or spec");
+		return -rte_errno;
+	}
+
+	/*
+	 * Only support src address , dst addresses, proto,
+	 * others should be masked.
+	 */
+	if (mask_ipv4->hdr.version_ihl || mask_ipv4->hdr.type_of_service ||
+	    mask_ipv4->hdr.total_length || mask_ipv4->hdr.packet_id ||
+	    mask_ipv4->hdr.fragment_offset || mask_ipv4->hdr.time_to_live ||
+	    mask_ipv4->hdr.hdr_checksum) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, ipv4 only "
+				   "support src ip, dst ip, proto");
+		return -rte_errno;
+	}
+
+	/* Set the filter information. */
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+	filter->fdir_filter.key_mask.ipv4.src_ip =
+		rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);
+	filter->fdir_filter.key_spec.ipv4.src_ip =
+		rte_be_to_cpu_32(spec_ipv4->hdr.src_addr);
+	filter->fdir_filter.key_mask.ipv4.dst_ip =
+		rte_be_to_cpu_32(mask_ipv4->hdr.dst_addr);
+	filter->fdir_filter.key_spec.ipv4.dst_ip =
+		rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);
+	filter->fdir_filter.key_mask.proto = mask_ipv4->hdr.next_proto_id;
+	filter->fdir_filter.key_spec.proto = spec_ipv4->hdr.next_proto_id;
+
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_ipv6(const struct rte_flow_item *flow_item,
+		      struct hinic3_filter_t *filter,
+		      struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv6 *spec_ipv6, *mask_ipv6;
+
+	mask_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->mask;
+	spec_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->spec;
+	if (!mask_ipv6 || !spec_ipv6) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter ipv6 mask or spec");
+		return -rte_errno;
+	}
+
+	/* Only support dst addresses, src addresses, proto. */
+	if (mask_ipv6->hdr.vtc_flow || mask_ipv6->hdr.payload_len ||
+	    mask_ipv6->hdr.hop_limits) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, ipv6 only "
+				   "support src ip, dst ip, proto");
+		return -rte_errno;
+	}
+
+	/* Set the filter information. */
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+	net_addr_to_host(filter->fdir_filter.key_mask.ipv6.src_ip,
+			 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);
+	net_addr_to_host(filter->fdir_filter.key_spec.ipv6.src_ip,
+			 (const uint32_t *)spec_ipv6->hdr.src_addr.a, 4);
+	net_addr_to_host(filter->fdir_filter.key_mask.ipv6.dst_ip,
+			 (const uint32_t *)mask_ipv6->hdr.dst_addr.a, 4);
+	net_addr_to_host(filter->fdir_filter.key_spec.ipv6.dst_ip,
+			 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);
+	filter->fdir_filter.key_mask.proto = mask_ipv6->hdr.proto;
+	filter->fdir_filter.key_spec.proto = spec_ipv6->hdr.proto;
+
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_tcp(const struct rte_flow_item *flow_item,
+		     struct hinic3_filter_t *filter,
+		     struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *spec_tcp, *mask_tcp;
+
+	mask_tcp = (const struct rte_flow_item_tcp *)flow_item->mask;
+	spec_tcp = (const struct rte_flow_item_tcp *)flow_item->spec;
+
+	filter->fdir_filter.key_mask.proto = HINIC3_UINT8_MAX;
+	filter->fdir_filter.key_spec.proto = IPPROTO_TCP;
+
+	if (!mask_tcp && !spec_tcp)
+		return 0;
+
+	if (!mask_tcp || !spec_tcp) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter tcp mask or spec");
+		return -rte_errno;
+	}
+
+	/* Only support src, dst ports, others should be masked. */
+	if (mask_tcp->hdr.sent_seq || mask_tcp->hdr.recv_ack ||
+	    mask_tcp->hdr.data_off || mask_tcp->hdr.rx_win ||
+	    mask_tcp->hdr.tcp_flags || mask_tcp->hdr.cksum ||
+	    mask_tcp->hdr.tcp_urp) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, tcp only "
+				   "support src port, dst port");
+		return -rte_errno;
+	}
+
+	/* Set the filter information. */
+	filter->fdir_filter.key_mask.src_port =
+		(uint16_t)rte_be_to_cpu_16(mask_tcp->hdr.src_port);
+	filter->fdir_filter.key_spec.src_port =
+		(uint16_t)rte_be_to_cpu_16(spec_tcp->hdr.src_port);
+	filter->fdir_filter.key_mask.dst_port =
+		(uint16_t)rte_be_to_cpu_16(mask_tcp->hdr.dst_port);
+	filter->fdir_filter.key_spec.dst_port =
+		(uint16_t)rte_be_to_cpu_16(spec_tcp->hdr.dst_port);
+
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_udp(const struct rte_flow_item *flow_item,
+		     struct hinic3_filter_t *filter,
+		     struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *spec_udp, *mask_udp;
+
+	mask_udp = (const struct rte_flow_item_udp *)flow_item->mask;
+	spec_udp = (const struct rte_flow_item_udp *)flow_item->spec;
+
+	filter->fdir_filter.key_mask.proto = HINIC3_UINT8_MAX;
+	filter->fdir_filter.key_spec.proto = IPPROTO_UDP;
+
+	if (!mask_udp && !spec_udp)
+		return 0;
+
+	if (!mask_udp || !spec_udp) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter udp mask or spec");
+		return -rte_errno;
+	}
+
+	/* Set the filter information. */
+	filter->fdir_filter.key_mask.src_port =
+		(uint16_t)rte_be_to_cpu_16(mask_udp->hdr.src_port);
+	filter->fdir_filter.key_spec.src_port =
+		(uint16_t)rte_be_to_cpu_16(spec_udp->hdr.src_port);
+	filter->fdir_filter.key_mask.dst_port =
+		(uint16_t)rte_be_to_cpu_16(mask_udp->hdr.dst_port);
+	filter->fdir_filter.key_spec.dst_port =
+		(uint16_t)rte_be_to_cpu_16(spec_udp->hdr.dst_port);
+
+	return 0;
+}
+
+/**
+ * Parse the pattern of network traffic and apply the parsing result to the
+ * traffic filter.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] pattern
+ * Indicates the pattern or matching condition of a traffic rule.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @param[out] filter
+ * Filter information, Its used to store and manipulate packet filtering rules.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_parse_fdir_pattern(__rte_unused struct rte_eth_dev *dev,
+			       const struct rte_flow_item *pattern,
+			       struct rte_flow_error *error,
+			       struct hinic3_filter_t *filter)
+{
+	const struct rte_flow_item *flow_item = pattern;
+	enum rte_flow_item_type type;
+	int err;
+
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_ANY;
+	/* Traverse all modes until RTE_FLOW_ITEM_TYPE_END is reached. */
+	for (; flow_item->type != RTE_FLOW_ITEM_TYPE_END; flow_item++) {
+		if (flow_item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item, "Not support range");
+			return -rte_errno;
+		}
+		type = flow_item->type;
+		switch (type) {
+		case RTE_FLOW_ITEM_TYPE_ETH:
+			if (flow_item->spec || flow_item->mask) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   flow_item,
+						   "Not supported by fdir "
+						   "filter, not support mac");
+				return -rte_errno;
+			}
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_IPV4:
+			err = hinic3_flow_fdir_ipv4(flow_item, filter, error);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_IPV6:
+			err = hinic3_flow_fdir_ipv6(flow_item, filter, error);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			err = hinic3_flow_fdir_tcp(flow_item, filter, error);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			err = hinic3_flow_fdir_udp(flow_item, filter, error);
+			if (err)
+				return -rte_errno;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * Resolve rules for network traffic filters.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] attr
+ * Indicates the attribute of a flow rule.
+ * @param[in] pattern
+ * Indicates the pattern or matching condition of a traffic rule.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @param[out] filter
+ * Filter information, Its used to store and manipulate packet filtering rules.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_parse_fdir_filter(struct rte_eth_dev *dev,
+			      const struct rte_flow_attr *attr,
+			      const struct rte_flow_item pattern[],
+			      const struct rte_flow_action actions[],
+			      struct rte_flow_error *error,
+			      struct hinic3_filter_t *filter)
+{
+	int ret;
+
+	ret = hinic3_flow_parse_fdir_pattern(dev, pattern, error, filter);
+	if (ret)
+		return ret;
+
+	ret = hinic3_flow_parse_action(dev, actions, error, filter);
+	if (ret)
+		return ret;
+
+	ret = hinic3_flow_parse_attr(attr, error);
+	if (ret)
+		return ret;
+
+	filter->filter_type = RTE_ETH_FILTER_FDIR;
+
+	return 0;
+}
+
+/**
+ * Parse and process the actions of the Ethernet type.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @param[out] filter
+ * Filter information, Its used to store and manipulate packet filtering rules.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_parse_ethertype_action(struct rte_eth_dev *dev,
+				   const struct rte_flow_action *actions,
+				   struct rte_flow_error *error,
+				   struct hinic3_filter_t *filter)
+{
+	const struct rte_flow_action *act = actions;
+	const struct rte_flow_action_queue *act_q;
+
+	/* Skip the firset void item. */
+	while (act->type == RTE_FLOW_ACTION_TYPE_VOID)
+		act++;
+
+	switch (act->type) {
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		act_q = (const struct rte_flow_action_queue *)act->conf;
+		filter->ethertype_filter.queue = act_q->index;
+		if (filter->ethertype_filter.queue >= dev->data->nb_rx_queues) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ACTION, act,
+					   "Invalid action param.");
+			return -rte_errno;
+		}
+		break;
+
+	default:
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				   act, "Invalid action type.");
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_flow_parse_ethertype_pattern(__rte_unused struct rte_eth_dev *dev,
+				    const struct rte_flow_item *pattern,
+				    struct rte_flow_error *error,
+				    struct hinic3_filter_t *filter)
+{
+	const struct rte_flow_item_eth *ether_spec, *ether_mask;
+	const struct rte_flow_item *flow_item = pattern;
+	enum rte_flow_item_type type;
+
+	/* Traverse all modes until RTE_FLOW_ITEM_TYPE_END is reached. */
+	for (; flow_item->type != RTE_FLOW_ITEM_TYPE_END; flow_item++) {
+		if (flow_item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item, "Not support range");
+			return -rte_errno;
+		}
+		type = flow_item->type;
+		switch (type) {
+		case RTE_FLOW_ITEM_TYPE_ETH:
+			/* Obtaining Ethernet Specifications and Masks. */
+			ether_spec = (const struct rte_flow_item_eth *)
+					     flow_item->spec;
+			ether_mask = (const struct rte_flow_item_eth *)
+					     flow_item->mask;
+			if (!ether_spec || !ether_mask) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   flow_item,
+						   "NULL ETH spec/mask");
+				return -rte_errno;
+			}
+
+			/*
+			 * Mask bits of source MAC address must be full of 0.
+			 * Mask bits of destination MAC address must be full 0.
+			 * Filters traffic based on the type of Ethernet.
+			 */
+			if (!rte_is_zero_ether_addr(&ether_mask->src) ||
+			    (!rte_is_zero_ether_addr(&ether_mask->dst))) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   flow_item,
+						   "Invalid ether address mask");
+				return -rte_errno;
+			}
+
+			if ((ether_mask->type & UINT16_MAX) != UINT16_MAX) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   flow_item,
+						   "Invalid ethertype mask");
+				return -rte_errno;
+			}
+
+			filter->ethertype_filter.ether_type =
+				(uint16_t)rte_be_to_cpu_16(ether_spec->type);
+
+			switch (filter->ethertype_filter.ether_type) {
+			case RTE_ETHER_TYPE_SLOW:
+				break;
+
+			case RTE_ETHER_TYPE_ARP:
+				break;
+
+			case RTE_ETHER_TYPE_RARP:
+				break;
+
+			case RTE_ETHER_TYPE_LLDP:
+				break;
+
+			default:
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   flow_item,
+						   "Unsupported ether_type in"
+						   " control packet filter.");
+				return -rte_errno;
+			}
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int
+hinic3_flow_parse_ethertype_filter(struct rte_eth_dev *dev,
+				   const struct rte_flow_attr *attr,
+				   const struct rte_flow_item pattern[],
+				   const struct rte_flow_action actions[],
+				   struct rte_flow_error *error,
+				   struct hinic3_filter_t *filter)
+{
+	int ret;
+
+	ret = hinic3_flow_parse_ethertype_pattern(dev, pattern, error, filter);
+	if (ret)
+		return ret;
+
+	ret = hinic3_flow_parse_ethertype_action(dev, actions, error, filter);
+	if (ret)
+		return ret;
+
+	ret = hinic3_flow_parse_attr(attr, error);
+	if (ret)
+		return ret;
+
+	filter->filter_type = RTE_ETH_FILTER_ETHERTYPE;
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,
+			     struct hinic3_filter_t *filter,
+			     const struct rte_flow_item *flow_item,
+			     enum hinic3_fdir_tunnel_mode tunnel_mode)
+{
+	const struct rte_flow_item_ipv4 *spec_ipv4, *mask_ipv4;
+	mask_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->mask;
+	spec_ipv4 = (const struct rte_flow_item_ipv4 *)flow_item->spec;
+
+	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+		filter->fdir_filter.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+		if (!mask_ipv4 && !spec_ipv4)
+			return 0;
+
+		if (!mask_ipv4 || !spec_ipv4) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item,
+					   "Invalid fdir filter, vxlan outer "
+					   "ipv4 mask or spec");
+			return -rte_errno;
+		}
+
+		/*
+		 * Only support src address , dst addresses, others should be
+		 * masked.
+		 */
+		if (mask_ipv4->hdr.version_ihl ||
+		    mask_ipv4->hdr.type_of_service ||
+		    mask_ipv4->hdr.total_length || mask_ipv4->hdr.packet_id ||
+		    mask_ipv4->hdr.fragment_offset ||
+		    mask_ipv4->hdr.time_to_live ||
+		    mask_ipv4->hdr.next_proto_id ||
+		    mask_ipv4->hdr.hdr_checksum) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item,
+					   "Not supported by fdir filter, "
+					   "vxlan outer ipv4 only support "
+					   "src ip, dst ip");
+			return -rte_errno;
+		}
+
+		/* Set the filter information. */
+		filter->fdir_filter.key_mask.ipv4.src_ip =
+			rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);
+		filter->fdir_filter.key_spec.ipv4.src_ip =
+			rte_be_to_cpu_32(spec_ipv4->hdr.src_addr);
+		filter->fdir_filter.key_mask.ipv4.dst_ip =
+			rte_be_to_cpu_32(mask_ipv4->hdr.dst_addr);
+		filter->fdir_filter.key_spec.ipv4.dst_ip =
+			rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);
+	} else {
+		filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV4;
+
+		if (!mask_ipv4 && !spec_ipv4)
+			return 0;
+
+		if (!mask_ipv4 || !spec_ipv4) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item,
+					   "Invalid fdir filter, vxlan inner "
+					   "ipv4 mask or spec");
+			return -rte_errno;
+		}
+
+		/*
+		 * Only support src addr , dst addr, ip proto, others should be
+		 * masked.
+		 */
+		if (mask_ipv4->hdr.version_ihl ||
+		    mask_ipv4->hdr.type_of_service ||
+		    mask_ipv4->hdr.total_length || mask_ipv4->hdr.packet_id ||
+		    mask_ipv4->hdr.fragment_offset ||
+		    mask_ipv4->hdr.time_to_live ||
+		    mask_ipv4->hdr.hdr_checksum) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item,
+					   "Not supported by fdir filter, "
+					   "vxlan inner ipv4 only support "
+					   "src ip, dst ip, proto");
+			return -rte_errno;
+		}
+
+		/* Set the filter information. */
+		filter->fdir_filter.key_mask.inner_ipv4.src_ip =
+			rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);
+		filter->fdir_filter.key_spec.inner_ipv4.src_ip =
+			rte_be_to_cpu_32(spec_ipv4->hdr.src_addr);
+		filter->fdir_filter.key_mask.inner_ipv4.dst_ip =
+			rte_be_to_cpu_32(mask_ipv4->hdr.dst_addr);
+		filter->fdir_filter.key_spec.inner_ipv4.dst_ip =
+			rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);
+		filter->fdir_filter.key_mask.proto =
+			mask_ipv4->hdr.next_proto_id;
+		filter->fdir_filter.key_spec.proto =
+			spec_ipv4->hdr.next_proto_id;
+	}
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_tunnel_ipv6(struct rte_flow_error *error,
+			     struct hinic3_filter_t *filter,
+			     const struct rte_flow_item *flow_item,
+			     enum hinic3_fdir_tunnel_mode tunnel_mode)
+{
+	const struct rte_flow_item_ipv6 *spec_ipv6, *mask_ipv6;
+
+	mask_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->mask;
+	spec_ipv6 = (const struct rte_flow_item_ipv6 *)flow_item->spec;
+
+	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+		filter->fdir_filter.outer_ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+		if (!mask_ipv6 && !spec_ipv6)
+			return 0;
+
+		if (!mask_ipv6 || !spec_ipv6) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, flow_item,
+				"Invalid fdir filter ipv6 mask or spec");
+			return -rte_errno;
+		}
+
+		/* Only support dst addresses, src addresses. */
+		if (mask_ipv6->hdr.vtc_flow || mask_ipv6->hdr.payload_len ||
+		    mask_ipv6->hdr.hop_limits || mask_ipv6->hdr.proto) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, flow_item,
+				"Not supported by fdir filter, ipv6 only "
+				"support src ip, dst ip, proto");
+			return -rte_errno;
+		}
+
+		net_addr_to_host(filter->fdir_filter.key_mask.ipv6.src_ip,
+				 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);
+		net_addr_to_host(filter->fdir_filter.key_spec.ipv6.src_ip,
+				 (const uint32_t *)spec_ipv6->hdr.src_addr.a, 4);
+		net_addr_to_host(filter->fdir_filter.key_mask.ipv6.dst_ip,
+				 (const uint32_t *)mask_ipv6->hdr.dst_addr.a, 4);
+		net_addr_to_host(filter->fdir_filter.key_spec.ipv6.dst_ip,
+				 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);
+	} else {
+		filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_IPV6;
+
+		if (!mask_ipv6 && !spec_ipv6)
+			return 0;
+
+		if (!mask_ipv6 || !spec_ipv6) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, flow_item,
+				"Invalid fdir filter ipv6 mask or spec");
+			return -rte_errno;
+		}
+
+		/* Only support dst addresses, src addresses, proto. */
+		if (mask_ipv6->hdr.vtc_flow || mask_ipv6->hdr.payload_len ||
+		    mask_ipv6->hdr.hop_limits) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, flow_item,
+				"Not supported by fdir filter, ipv6 only "
+				"support src ip, dst ip, proto");
+			return -rte_errno;
+		}
+
+		net_addr_to_host(filter->fdir_filter.key_mask.inner_ipv6.src_ip,
+				 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);
+		net_addr_to_host(filter->fdir_filter.key_spec.inner_ipv6.src_ip,
+				 (const uint32_t *)spec_ipv6->hdr.src_addr.a, 4);
+		net_addr_to_host(filter->fdir_filter.key_mask.inner_ipv6.dst_ip,
+				 (const uint32_t *)mask_ipv6->hdr.dst_addr.a, 4);
+		net_addr_to_host(filter->fdir_filter.key_spec.inner_ipv6.dst_ip,
+				 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);
+
+		filter->fdir_filter.key_mask.proto = mask_ipv6->hdr.proto;
+		filter->fdir_filter.key_spec.proto = spec_ipv6->hdr.proto;
+	}
+
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_tunnel_tcp(struct rte_flow_error *error,
+			    struct hinic3_filter_t *filter,
+			    enum hinic3_fdir_tunnel_mode tunnel_mode,
+			    const struct rte_flow_item *flow_item)
+{
+	const struct rte_flow_item_tcp *spec_tcp, *mask_tcp;
+
+	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, vxlan only "
+				   "support inner tcp");
+		return -rte_errno;
+	}
+
+	filter->fdir_filter.key_mask.proto = HINIC3_UINT8_MAX;
+	filter->fdir_filter.key_spec.proto = IPPROTO_TCP;
+
+	mask_tcp = (const struct rte_flow_item_tcp *)flow_item->mask;
+	spec_tcp = (const struct rte_flow_item_tcp *)flow_item->spec;
+	if (!mask_tcp && !spec_tcp)
+		return 0;
+	if (!mask_tcp || !spec_tcp) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter tcp mask or spec");
+		return -rte_errno;
+	}
+
+	/* Only support src, dst ports, others should be masked. */
+	if (mask_tcp->hdr.sent_seq || mask_tcp->hdr.recv_ack ||
+	    mask_tcp->hdr.data_off || mask_tcp->hdr.rx_win ||
+	    mask_tcp->hdr.tcp_flags || mask_tcp->hdr.cksum ||
+	    mask_tcp->hdr.tcp_urp) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Not supported by fdir filter, vxlan inner "
+				   "tcp only support src port,dst port");
+		return -rte_errno;
+	}
+
+	/* Set the filter information. */
+	filter->fdir_filter.key_mask.src_port =
+		(uint16_t)rte_be_to_cpu_16(mask_tcp->hdr.src_port);
+	filter->fdir_filter.key_spec.src_port =
+		(uint16_t)rte_be_to_cpu_16(spec_tcp->hdr.src_port);
+	filter->fdir_filter.key_mask.dst_port =
+		(uint16_t)rte_be_to_cpu_16(mask_tcp->hdr.dst_port);
+	filter->fdir_filter.key_spec.dst_port =
+		(uint16_t)rte_be_to_cpu_16(spec_tcp->hdr.dst_port);
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *error,
+			    struct hinic3_filter_t *filter,
+			    enum hinic3_fdir_tunnel_mode tunnel_mode,
+			    const struct rte_flow_item *flow_item)
+{
+	const struct rte_flow_item_udp *spec_udp, *mask_udp;
+
+	mask_udp = (const struct rte_flow_item_udp *)flow_item->mask;
+	spec_udp = (const struct rte_flow_item_udp *)flow_item->spec;
+
+	if (tunnel_mode == HINIC3_FDIR_TUNNEL_MODE_NORMAL) {
+		/*
+		 * UDP is used to describe protocol,
+		 * spec and mask should be NULL.
+		 */
+		if (flow_item->spec || flow_item->mask) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item, "Invalid UDP item");
+			return -rte_errno;
+		}
+	} else {
+		filter->fdir_filter.key_mask.proto = HINIC3_UINT8_MAX;
+		filter->fdir_filter.key_spec.proto = IPPROTO_UDP;
+		if (!mask_udp && !spec_udp)
+			return 0;
+
+		if (!mask_udp || !spec_udp) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item,
+					   "Invalid fdir filter vxlan inner "
+					   "udp mask or spec");
+			return -rte_errno;
+		}
+
+		/* Set the filter information. */
+		filter->fdir_filter.key_mask.src_port =
+			(uint16_t)rte_be_to_cpu_16(mask_udp->hdr.src_port);
+		filter->fdir_filter.key_spec.src_port =
+			(uint16_t)rte_be_to_cpu_16(spec_udp->hdr.src_port);
+		filter->fdir_filter.key_mask.dst_port =
+			(uint16_t)rte_be_to_cpu_16(mask_udp->hdr.dst_port);
+		filter->fdir_filter.key_spec.dst_port =
+			(uint16_t)rte_be_to_cpu_16(spec_udp->hdr.dst_port);
+	}
+
+	return 0;
+}
+
+static int
+hinic3_flow_fdir_vxlan(struct rte_flow_error *error,
+		       struct hinic3_filter_t *filter,
+		       const struct rte_flow_item *flow_item)
+{
+	const struct rte_flow_item_vxlan *spec_vxlan, *mask_vxlan;
+	uint32_t vxlan_vni_id = 0;
+
+	spec_vxlan = (const struct rte_flow_item_vxlan *)flow_item->spec;
+	mask_vxlan = (const struct rte_flow_item_vxlan *)flow_item->mask;
+
+	filter->fdir_filter.tunnel_type = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+
+	if (!spec_vxlan && !mask_vxlan) {
+		return 0;
+	} else if (filter->fdir_filter.outer_ip_type == HINIC3_FDIR_IP_TYPE_IPV6) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter vxlan mask or spec, "
+				   "ipv6 vxlan, don't support vni");
+		return -rte_errno;
+	}
+
+	if (!spec_vxlan || !mask_vxlan) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   flow_item,
+				   "Invalid fdir filter vxlan mask or spec");
+		return -rte_errno;
+	}
+
+	rte_memcpy(((uint8_t *)&vxlan_vni_id + 1), spec_vxlan->vni, 3);
+	filter->fdir_filter.key_mask.tunnel.tunnel_id =
+		rte_be_to_cpu_32(vxlan_vni_id);
+	return 0;
+}
+
+static int
+hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,
+				     const struct rte_flow_item *pattern,
+				     struct rte_flow_error *error,
+				     struct hinic3_filter_t *filter)
+{
+	const struct rte_flow_item *flow_item = pattern;
+	enum hinic3_fdir_tunnel_mode tunnel_mode =
+		HINIC3_FDIR_TUNNEL_MODE_NORMAL;
+	enum rte_flow_item_type type;
+	int err;
+
+	/* Inner and outer ip type, set it to any by default */
+	filter->fdir_filter.ip_type = HINIC3_FDIR_IP_TYPE_ANY;
+	filter->fdir_filter.outer_ip_type = HINIC3_FDIR_IP_TYPE_ANY;
+
+	for (; flow_item->type != RTE_FLOW_ITEM_TYPE_END; flow_item++) {
+		if (flow_item->last) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   flow_item, "Not support range");
+			return -rte_errno;
+		}
+
+		type = flow_item->type;
+		switch (type) {
+		case RTE_FLOW_ITEM_TYPE_ETH:
+			/* All should be masked. */
+			if (flow_item->spec || flow_item->mask) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   flow_item,
+						   "Not supported by fdir "
+						   "filter, not support mac");
+				return -rte_errno;
+			}
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_IPV4:
+			err = hinic3_flow_fdir_tunnel_ipv4(error,
+				filter, flow_item, tunnel_mode);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_IPV6:
+			err = hinic3_flow_fdir_tunnel_ipv6(error,
+				filter, flow_item, tunnel_mode);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			err = hinic3_flow_fdir_tunnel_tcp(error,
+				filter, tunnel_mode, flow_item);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			err = hinic3_flow_fdir_tunnel_udp(error,
+				filter, tunnel_mode, flow_item);
+			if (err)
+				return -rte_errno;
+			break;
+
+		case RTE_FLOW_ITEM_TYPE_VXLAN:
+			err = hinic3_flow_fdir_vxlan(error, filter, flow_item);
+			if (err)
+				return -rte_errno;
+			tunnel_mode = HINIC3_FDIR_TUNNEL_MODE_VXLAN;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * Resolve VXLAN Filters in Flow Filters.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] attr
+ * Indicates the attribute of a flow rule.
+ * @param[in] pattern
+ * Indicates the pattern or matching condition of a traffic rule.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @param[out] filter
+ * Filter information, its used to store and manipulate packet filtering rules.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,
+				    const struct rte_flow_attr *attr,
+				    const struct rte_flow_item pattern[],
+				    const struct rte_flow_action actions[],
+				    struct rte_flow_error *error,
+				    struct hinic3_filter_t *filter)
+{
+	int ret;
+
+	ret = hinic3_flow_parse_fdir_vxlan_pattern(dev, pattern, error, filter);
+	if (ret)
+		return ret;
+
+	ret = hinic3_flow_parse_action(dev, actions, error, filter);
+	if (ret)
+		return ret;
+
+	ret = hinic3_flow_parse_attr(attr, error);
+	if (ret)
+		return ret;
+
+	filter->filter_type = RTE_ETH_FILTER_FDIR;
+
+	return 0;
+}
+
+/**
+ * Parse patterns and actions of network traffic.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] attr
+ * Indicates the attribute of a flow rule.
+ * @param[in] pattern
+ * Indicates the pattern or matching condition of a traffic rule.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @param[out] filter
+ * Filter information, its used to store and manipulate packet filtering rules.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_parse(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		  const struct rte_flow_item pattern[],
+		  const struct rte_flow_action actions[],
+		  struct rte_flow_error *error, struct hinic3_filter_t *filter)
+{
+	hinic3_parse_filter_t parse_filter;
+	uint32_t pattern_num = 0;
+	int ret = 0;
+	/* Check whether the parameter is valid. */
+	if (!pattern || !actions || !attr) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "NULL param.");
+		return -rte_errno;
+	}
+
+	while ((pattern + pattern_num)->type != RTE_FLOW_ITEM_TYPE_END) {
+		pattern_num++;
+		if (pattern_num > HINIC3_FLOW_MAX_PATTERN_NUM) {
+			rte_flow_error_set(error, EINVAL,
+					   HINIC3_FLOW_MAX_PATTERN_NUM, NULL,
+					   "Too many patterns.");
+			return -rte_errno;
+		}
+	}
+	/*
+	 * The corresponding filter is returned. If the filter is not found,
+	 * NULL is returned.
+	 */
+	parse_filter = hinic3_find_parse_filter_func(pattern);
+	if (!parse_filter) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				   pattern, "Unsupported pattern");
+		return -rte_errno;
+	}
+	/* Parsing with filters. */
+	ret = parse_filter(dev, attr, pattern, actions, error, filter);
+
+	return ret;
+}
+
+/**
+ * Check whether the traffic rule provided by the user is valid.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] attr
+ * Indicates the attribute of a flow rule.
+ * @param[in] pattern
+ * Indicates the pattern or matching condition of a traffic rule.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		     const struct rte_flow_item pattern[],
+		     const struct rte_flow_action actions[],
+		     struct rte_flow_error *error)
+{
+	struct hinic3_filter_t filter_rules = {0};
+
+	return hinic3_flow_parse(dev, attr, pattern, actions, error,
+				 &filter_rules);
+}
+
+/**
+ * Create a flow item.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] attr
+ * Indicates the attribute of a flow rule.
+ * @param[in] pattern
+ * Indicates the pattern or matching condition of a traffic rule.
+ * @param[in] actions
+ * Indicates the action to be taken on the matched traffic.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @return
+ * If the operation is successful, the created flow is returned. Otherwise, NULL
+ * is returned.
+ *
+ */
+static struct rte_flow *
+hinic3_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		   const struct rte_flow_item pattern[],
+		   const struct rte_flow_action actions[],
+		   struct rte_flow_error *error)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_filter_t *filter_rules = NULL;
+	struct rte_flow *flow = NULL;
+	int ret;
+
+	filter_rules =
+		rte_zmalloc("filter_rules", sizeof(struct hinic3_filter_t), 0);
+	if (!filter_rules) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL,
+				   "Failed to allocate filter rules memory.");
+		return NULL;
+	}
+
+	flow = rte_zmalloc("hinic3_rte_flow", sizeof(struct rte_flow), 0);
+	if (!flow) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL, "Failed to allocate flow memory.");
+		rte_free(filter_rules);
+		return NULL;
+	}
+	/* Parses the flow rule to be created and generates a filter. */
+	ret = hinic3_flow_parse(dev, attr, pattern, actions, error,
+				filter_rules);
+	if (ret < 0)
+		goto free_flow;
+
+	switch (filter_rules->filter_type) {
+	case RTE_ETH_FILTER_ETHERTYPE:
+		ret = hinic3_flow_add_del_ethertype_filter(dev,
+			&filter_rules->ethertype_filter, true);
+		if (ret) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					   "Create ethertype filter failed.");
+			goto free_flow;
+		}
+
+		flow->rule = filter_rules;
+		flow->filter_type = filter_rules->filter_type;
+		TAILQ_INSERT_TAIL(&nic_dev->filter_ethertype_list, flow, node);
+		break;
+
+	case RTE_ETH_FILTER_FDIR:
+		ret = hinic3_flow_add_del_fdir_filter(dev,
+			&filter_rules->fdir_filter, true);
+		if (ret) {
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					   "Create fdir filter failed.");
+			goto free_flow;
+		}
+
+		flow->rule = filter_rules;
+		flow->filter_type = filter_rules->filter_type;
+		TAILQ_INSERT_TAIL(&nic_dev->filter_fdir_rule_list, flow, node);
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Filter type %d not supported",
+			    filter_rules->filter_type);
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL, "Unsupported filter type.");
+		goto free_flow;
+	}
+
+	return flow;
+
+free_flow:
+	rte_free(flow);
+	rte_free(filter_rules);
+
+	return NULL;
+}
+
+static int
+hinic3_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
+		    struct rte_flow_error *error)
+{
+	int ret = -EINVAL;
+	enum rte_filter_type type;
+	struct hinic3_filter_t *rules = NULL;
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	if (!flow) {
+		PMD_DRV_LOG(ERR, "Invalid flow parameter!");
+		return -EPERM;
+	}
+
+	type = flow->filter_type;
+	rules = (struct hinic3_filter_t *)flow->rule;
+	/* Perform operations based on the type. */
+	switch (type) {
+	case RTE_ETH_FILTER_ETHERTYPE:
+		ret = hinic3_flow_add_del_ethertype_filter(dev,
+			&rules->ethertype_filter, false);
+		if (!ret)
+			TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow,
+				     node);
+
+		flow->rule = rules;
+		flow->filter_type = rules->filter_type;
+		TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);
+		break;
+
+	case RTE_ETH_FILTER_FDIR:
+		ret = hinic3_flow_add_del_fdir_filter(dev, &rules->fdir_filter,
+						      false);
+		if (!ret)
+			TAILQ_REMOVE(&nic_dev->filter_fdir_rule_list, flow,
+				     node);
+		break;
+	default:
+		PMD_DRV_LOG(WARNING, "Filter type %d not supported", type);
+		ret = -EINVAL;
+		break;
+	}
+
+	/* Deleted successfully. Resources are released. */
+	if (!ret) {
+		rte_free(rules);
+		rte_free(flow);
+	} else {
+		rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL, "Failed to destroy flow.");
+	}
+
+	return ret;
+}
+
+/**
+ * Clear all fdir type flow rules on the network device.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_flush_fdir_filter(struct rte_eth_dev *dev)
+{
+	int ret = 0;
+	struct hinic3_filter_t *filter_rules = NULL;
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_flow *flow;
+
+	while (true) {
+		flow = TAILQ_FIRST(&nic_dev->filter_fdir_rule_list);
+		if (flow == NULL)
+			break;
+		filter_rules = (struct hinic3_filter_t *)flow->rule;
+
+		/* Delete flow rules. */
+		ret = hinic3_flow_add_del_fdir_filter(dev,
+			&filter_rules->fdir_filter, false);
+
+		if (ret)
+			return ret;
+
+		TAILQ_REMOVE(&nic_dev->filter_fdir_rule_list, flow, node);
+		rte_free(filter_rules);
+		rte_free(flow);
+	}
+
+	return ret;
+}
+
+/**
+ * Clear all ether type flow rules on the network device.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_flush_ethertype_filter(struct rte_eth_dev *dev)
+{
+	struct hinic3_filter_t *filter_rules = NULL;
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_flow *flow;
+	int ret = 0;
+
+	while (true) {
+		flow = TAILQ_FIRST(&nic_dev->filter_ethertype_list);
+		if (flow == NULL)
+			break;
+		filter_rules = (struct hinic3_filter_t *)flow->rule;
+
+		/* Delete flow rules. */
+		ret = hinic3_flow_add_del_ethertype_filter(dev,
+			&filter_rules->ethertype_filter, false);
+
+		if (ret)
+			return ret;
+
+		TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);
+		rte_free(filter_rules);
+		rte_free(flow);
+	}
+
+	return ret;
+}
+
+/**
+ * Clear all flow rules on the network device.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] error
+ * Structure that contains error information, such as error code and error
+ * description.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
+{
+	int ret;
+
+	ret = hinic3_flow_flush_fdir_filter(dev);
+	if (ret) {
+		rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL, "Failed to flush fdir flows.");
+		return -rte_errno;
+	}
+
+	ret = hinic3_flow_flush_ethertype_filter(dev);
+	if (ret) {
+		rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL, "Failed to flush ethertype flows.");
+		return -rte_errno;
+	}
+	return ret;
+}
+
+/* Structure for managing flow table operations. */
+const struct rte_flow_ops hinic3_flow_ops = {
+	.validate = hinic3_flow_validate,
+	.create = hinic3_flow_create,
+	.destroy = hinic3_flow_destroy,
+	.flush = hinic3_flow_flush,
+};
diff --git a/drivers/net/hinic3/hinic3_flow.h b/drivers/net/hinic3/hinic3_flow.h
new file mode 100644
index 0000000000..c4b38e44e7
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_flow.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_FLOW_H_
+#define _HINIC3_FLOW_H_
+
+#include <rte_flow.h>
+
+/* Indicate the type of the IPv4 ICPM matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_icmp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_ICMP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 any protocol matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_any[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_ANY,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the Ether matching pattern. */
+static enum rte_flow_item_type pattern_ethertype[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the TCP matching pattern. */
+static enum rte_flow_item_type pattern_ethertype_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the UDP matching pattern. */
+static enum rte_flow_item_type pattern_ethertype_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan any protocol matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_any[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ANY, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan UDP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan IPv4 matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan IPv4 TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan IPv4 UDP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan IPv6 matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan IPv6 TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 vxlan IPv6 UDP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 matching pattern. */
+static enum rte_flow_item_type pattern_ipv4[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 UDP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv4 TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv4_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 matching pattern. */
+static enum rte_flow_item_type pattern_ipv6[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 UDP matching pattern. */
+static enum rte_flow_item_type pattern_ipv6_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv6_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv6_vxlan[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 VXLAN any protocol matching pattern. */
+static enum rte_flow_item_type pattern_ipv6_vxlan_any[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_ANY, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 VXLAN TCP matching pattern. */
+static enum rte_flow_item_type pattern_ipv6_vxlan_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+/* Indicate the type of the IPv6 VXLAN UDP matching pattern. */
+static enum rte_flow_item_type pattern_ipv6_vxlan_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,
+	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,
+};
+
+#endif /**< _HINIC3_FLOW_H_ */
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.build
index 2f19381cd0..25b73fbe00 100644
--- a/drivers/net/hinic3/meson.build
+++ b/drivers/net/hinic3/meson.build
@@ -22,6 +22,8 @@ objs = [base_objs]
 sources = files(
         'hinic3_ethdev.c',
         'hinic3_nic_io.c',
+        'hinic3_fdir.c',
+        'hinic3_flow.c',
         'hinic3_rx.c',
         'hinic3_tx.c',
 )
-- 
2.47.0.windows.2

