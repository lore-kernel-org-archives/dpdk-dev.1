Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79903CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:43:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D8240DD7;
	Sat, 30 Aug 2025 14:41:14 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id BC53940B94
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=G8M8AC247KDRzTktqr2cO5xOLvsG9rARiCKzRX7SvH0=;
 b=MzqUHRb+JOFDDSD1kgTeq1MLJe6Nl+V3x8PTLf9v9iwacfweH+nQgmLkmF/95+
 0XhfnsUYvSnk/GY2oG9GF2WYc52I2hxXrPYyF5QrOCcxmg+R2rJywlDYNjis0C4X
 PQLTDcH1tgywtaH19vKnCQfm7HGQUlfJmikfh1PSVaPtw=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S21;
 Sat, 30 Aug 2025 20:41:06 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 17/18] net/hinic3: add FDIR flow control module
Date: Sat, 30 Aug 2025 20:39:29 +0800
Message-ID: <20250830123942.5037-18-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S21
X-Coremail-Antispam: 1Uf129KBjvAXoWkGF4DWFWkWF1rtw4DZr48Xrb_yoWkuF1rKo
 WfXrs8tr1rtw1xGa10vrs7Aa4xW39Y9FnYyFWa9ws7Za15tr15tFWfAF4rJ3yq9398tFnx
 AryrJanaqwnFq3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUo73vUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAhq5Cmiydh7CSAAAsT
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

From: Yi Chen <chenyi221@huawei.com>=0D

Added support for rte_flow, including ethertype, IPv4,=0D
IPv6, and tunnel VXLAN. In addition, user can add or delete filters.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c |   82 ++=0D
 drivers/net/hinic3/hinic3_ethdev.h |   17 +=0D
 drivers/net/hinic3/hinic3_fdir.c   | 1394 +++++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_fdir.h   |  398 +++++++=0D
 drivers/net/hinic3/hinic3_flow.c   | 1700 ++++++++++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_flow.h   |   42 +=0D
 6 files changed, 3633 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/hinic3_fdir.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_fdir.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_flow.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_flow.h=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 0807e017c2..a10ca3c7cb 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -2369,6 +2369,84 @@ hinic3_dev_promiscuous_disable(struct rte_eth_dev *d=
ev)=0D
  * @return=0D
  * 0 on success, non-zero on failure.=0D
  */=0D
+static int=0D
+hinic3_dev_flow_ctrl_get(struct rte_eth_dev *dev,=0D
+			 struct rte_eth_fc_conf *fc_conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct nic_pause_config nic_pause;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&nic_dev->pause_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	memset(&nic_pause, 0, sizeof(nic_pause));=0D
+	err =3D hinic3_get_pause_info(nic_dev->hwdev, &nic_pause);=0D
+	if (err) {=0D
+		hinic3_mutex_unlock(&nic_dev->pause_mutex);=0D
+		return err;=0D
+	}=0D
+=0D
+	if (nic_dev->pause_set || !nic_pause.auto_neg) {=0D
+		nic_pause.rx_pause =3D nic_dev->nic_pause.rx_pause;=0D
+		nic_pause.tx_pause =3D nic_dev->nic_pause.tx_pause;=0D
+	}=0D
+=0D
+	fc_conf->autoneg =3D nic_pause.auto_neg;=0D
+=0D
+	if (nic_pause.tx_pause && nic_pause.rx_pause)=0D
+		fc_conf->mode =3D RTE_ETH_FC_FULL;=0D
+	else if (nic_pause.tx_pause)=0D
+		fc_conf->mode =3D RTE_ETH_FC_TX_PAUSE;=0D
+	else if (nic_pause.rx_pause)=0D
+		fc_conf->mode =3D RTE_ETH_FC_RX_PAUSE;=0D
+	else=0D
+		fc_conf->mode =3D RTE_ETH_FC_NONE;=0D
+=0D
+	hinic3_mutex_unlock(&nic_dev->pause_mutex);=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_flow_ctrl_set(struct rte_eth_dev *dev,=0D
+			 struct rte_eth_fc_conf *fc_conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct nic_pause_config nic_pause;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&nic_dev->pause_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	memset(&nic_pause, 0, sizeof(nic_pause));=0D
+	if ((fc_conf->mode & RTE_ETH_FC_FULL) =3D=3D RTE_ETH_FC_FULL ||=0D
+	    (fc_conf->mode & RTE_ETH_FC_TX_PAUSE))=0D
+		nic_pause.tx_pause =3D true;=0D
+=0D
+	if ((fc_conf->mode & RTE_ETH_FC_FULL) =3D=3D RTE_ETH_FC_FULL ||=0D
+	    (fc_conf->mode & RTE_ETH_FC_RX_PAUSE))=0D
+		nic_pause.rx_pause =3D true;=0D
+=0D
+	err =3D hinic3_set_pause_info(nic_dev->hwdev, nic_pause);=0D
+	if (err) {=0D
+		hinic3_mutex_unlock(&nic_dev->pause_mutex);=0D
+		return err;=0D
+	}=0D
+=0D
+	nic_dev->pause_set =3D true;=0D
+	nic_dev->nic_pause.rx_pause =3D nic_pause.rx_pause;=0D
+	nic_dev->nic_pause.tx_pause =3D nic_pause.tx_pause;=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Just support set tx or rx pause info, tx: %s, rx: %s",=0D
+		    nic_pause.tx_pause ? "on" : "off",=0D
+		    nic_pause.rx_pause ? "on" : "off");=0D
+=0D
+	hinic3_mutex_unlock(&nic_dev->pause_mutex);=0D
+	return 0;=0D
+}=0D
 =0D
 /**=0D
  * Update the RSS hash key and RSS hash type.=0D
@@ -3252,6 +3330,8 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
 	.promiscuous_enable            =3D hinic3_dev_promiscuous_enable,=0D
 	.promiscuous_disable           =3D hinic3_dev_promiscuous_disable,=0D
+	.flow_ctrl_get                 =3D hinic3_dev_flow_ctrl_get,=0D
+	.flow_ctrl_set                 =3D hinic3_dev_flow_ctrl_set,=0D
 	.rss_hash_update               =3D hinic3_rss_hash_update,=0D
 	.rss_hash_conf_get             =3D hinic3_rss_conf_get,=0D
 	.reta_update                   =3D hinic3_rss_reta_update,=0D
@@ -3269,6 +3349,7 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 	.mac_addr_remove               =3D hinic3_mac_addr_remove,=0D
 	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
 	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
+	.flow_ops_get                  =3D hinic3_dev_filter_ctrl,=0D
 	.get_reg                       =3D hinic3_get_reg,=0D
 };=0D
 =0D
@@ -3313,6 +3394,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =3D=
 {=0D
 	.mac_addr_remove               =3D hinic3_mac_addr_remove,=0D
 	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
 	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
+	.flow_ops_get                  =3D hinic3_dev_filter_ctrl,=0D
 };=0D
 =0D
 /**=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 90ca21491f..f71183d722 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -8,6 +8,8 @@=0D
 #include <rte_ethdev.h>=0D
 #include <rte_ethdev_core.h>=0D
 =0D
+#include "hinic3_fdir.h"=0D
+=0D
 #define HINIC3_PMD_DRV_VERSION "B106"=0D
 =0D
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)=0D
@@ -83,6 +85,9 @@ enum nic_feature_cap {=0D
 =0D
 #define DEFAULT_DRV_FEATURE 0x3FFF=0D
 =0D
+TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);=0D
+TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);=0D
+=0D
 struct hinic3_nic_dev {=0D
 	struct hinic3_hwdev *hwdev; /**< Hardware device. */=0D
 	struct hinic3_txq **txqs;=0D
@@ -114,14 +119,26 @@ struct hinic3_nic_dev {=0D
 =0D
 	RTE_ATOMIC(u64) dev_status;=0D
 =0D
+	u8 pause_set; /**< Flag of PAUSE frame setting. */=0D
+	pthread_mutex_t pause_mutex;=0D
+	struct nic_pause_config nic_pause;=0D
+=0D
 	struct rte_ether_addr default_addr;=0D
 	struct rte_ether_addr *mc_list;=0D
 =0D
 	char dev_name[HINIC3_DEV_NAME_LEN];=0D
 	u64 feature_cap;=0D
 	u32 vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */=0D
+=0D
+	u16 tcam_rule_nums;=0D
+	u16 ethertype_rule_nums;=0D
+	struct hinic3_tcam_info tcam;=0D
+	struct hinic3_ethertype_filter_list filter_ethertype_list;=0D
+	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;=0D
 };=0D
 =0D
+extern const struct rte_flow_ops hinic3_flow_ops;=0D
+=0D
 /**=0D
  * Enable interrupt for the specified RX queue.=0D
  *=0D
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_f=
dir.c=0D
new file mode 100644=0D
index 0000000000..32fc5472bd=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_fdir.c=0D
@@ -0,0 +1,1394 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <errno.h>=0D
+#include <stdint.h>=0D
+#include <stdio.h>=0D
+#include <string.h>=0D
+#include <unistd.h>=0D
+=0D
+#include <rte_byteorder.h>=0D
+#include <rte_common.h>=0D
+#include <rte_ethdev.h>=0D
+#include <rte_ether.h>=0D
+#include <rte_flow.h>=0D
+#include <rte_flow_driver.h>=0D
+#include <rte_malloc.h>=0D
+=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_hwdev.h"=0D
+#include "base/hinic3_hwif.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_fdir.h"=0D
+=0D
+#define HINIC3_UINT1_MAX  0x1=0D
+#define HINIC3_UINT4_MAX  0xf=0D
+#define HINIC3_UINT15_MAX 0x7fff=0D
+=0D
+#define HINIC3_DEV_PRIVATE_TO_TCAM_INFO(nic_dev) \=0D
+	(&((struct hinic3_nic_dev *)(nic_dev))->tcam)=0D
+=0D
+/**=0D
+ * Perform a bitwise AND operation on the input key value and mask, and st=
ores=0D
+ * the result in the key_y array.=0D
+ *=0D
+ * @param[out] key_y=0D
+ * Array for storing results.=0D
+ * @param[in] src_input=0D
+ * Input key array.=0D
+ * @param[in] mask=0D
+ * Mask array.=0D
+ * @param[in] len=0D
+ * Length of the key value and mask.=0D
+ */=0D
+static void=0D
+tcam_translate_key_y(u8 *key_y, u8 *src_input, u8 *mask, u8 len)=0D
+{=0D
+	u8 idx;=0D
+=0D
+	for (idx =3D 0; idx < len; idx++)=0D
+		key_y[idx] =3D src_input[idx] & mask[idx];=0D
+}=0D
+=0D
+/**=0D
+ * Convert key_y to key_x using the exclusive OR operation.=0D
+ *=0D
+ * @param[out] key_x=0D
+ * Array for storing results.=0D
+ * @param[in] key_y=0D
+ * Input key array.=0D
+ * @param[in] mask=0D
+ * Mask array.=0D
+ * @param[in] len=0D
+ * Length of the key value and mask.=0D
+ */=0D
+static void=0D
+tcam_translate_key_x(u8 *key_x, u8 *key_y, u8 *mask, u8 len)=0D
+{=0D
+	u8 idx;=0D
+=0D
+	for (idx =3D 0; idx < len; idx++)=0D
+		key_x[idx] =3D key_y[idx] ^ mask[idx];=0D
+}=0D
+=0D
+static void=0D
+tcam_key_calculate(struct hinic3_tcam_key *tcam_key,=0D
+		   struct hinic3_tcam_cfg_rule *fdir_tcam_rule)=0D
+{=0D
+	tcam_translate_key_y(fdir_tcam_rule->key.y, (u8 *)(&tcam_key->key_info),=
=0D
+			     (u8 *)(&tcam_key->key_mask),=0D
+			     HINIC3_TCAM_FLOW_KEY_SIZE);=0D
+	tcam_translate_key_x(fdir_tcam_rule->key.x, fdir_tcam_rule->key.y,=0D
+			     (u8 *)(&tcam_key->key_mask),=0D
+			     HINIC3_TCAM_FLOW_KEY_SIZE);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rule,=0D
+			   struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	/* Fill type of ip. */=0D
+	tcam_key->key_mask.ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+	/* Fill src IPv4. */=0D
+	tcam_key->key_mask.sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.src_ip);=0D
+	tcam_key->key_mask.sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.src_ip);=0D
+	tcam_key->key_info.sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.src_ip);=0D
+	tcam_key->key_info.sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.src_ip);=0D
+=0D
+	/* Fill dst IPv4. */=0D
+	tcam_key->key_mask.dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.dst_ip);=0D
+	tcam_key->key_mask.dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.dst_ip);=0D
+	tcam_key->key_info.dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.dst_ip);=0D
+	tcam_key->key_info.dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *rule,=0D
+			   struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	/* Fill type of ip. */=0D
+	tcam_key->key_mask_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+	/* Fill src IPv6. */=0D
+	tcam_key->key_mask_ipv6.sipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.sipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0]);=0D
+	tcam_key->key_info_ipv6.sipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0]);=0D
+	tcam_key->key_info_ipv6.sipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.sipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.sipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.sipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.sipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.sipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
+=0D
+	/* Fill dst IPv6. */=0D
+	tcam_key->key_mask_ipv6.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);=0D
+	tcam_key->key_info_ipv6.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);=0D
+	tcam_key->key_info_ipv6.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
+}=0D
+=0D
+/**=0D
+ * Set the TCAM information in notunnel scenario.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] rule=0D
+ * Pointer to the filtering rule.=0D
+ * @param[in] tcam_key=0D
+ * Pointer to the TCAM key.=0D
+ */=0D
+static void=0D
+hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *dev,=0D
+			       struct hinic3_fdir_filter *rule,=0D
+			       struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	/* Fill tcam_key info. */=0D
+	tcam_key->key_mask.sport =3D rule->key_mask.src_port;=0D
+	tcam_key->key_info.sport =3D rule->key_spec.src_port;=0D
+=0D
+	tcam_key->key_mask.dport =3D rule->key_mask.dst_port;=0D
+	tcam_key->key_info.dport =3D rule->key_spec.dst_port;=0D
+=0D
+	tcam_key->key_mask.tunnel_type =3D HINIC3_UINT4_MAX;=0D
+	tcam_key->key_info.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+=0D
+	tcam_key->key_mask.function_id =3D HINIC3_UINT15_MAX;=0D
+	tcam_key->key_info.function_id =3D hinic3_global_func_id(nic_dev->hwdev) =
&=0D
+					 HINIC3_UINT15_MAX;=0D
+=0D
+	tcam_key->key_mask.ip_proto =3D rule->key_mask.proto;=0D
+	tcam_key->key_info.ip_proto =3D rule->key_spec.proto;=0D
+=0D
+	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4)=0D
+		hinic3_fdir_tcam_ipv4_init(rule, tcam_key);=0D
+	else if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV6)=0D
+		hinic3_fdir_tcam_ipv6_init(rule, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,=0D
+				 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	/* Fill type of ip. */=0D
+	tcam_key->key_mask.ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+	/* Fill src ipv4. */=0D
+	tcam_key->key_mask.sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv4.src_ip);=0D
+	tcam_key->key_mask.sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv4.src_ip);=0D
+	tcam_key->key_info.sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv4.src_ip);=0D
+	tcam_key->key_info.sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv4.src_ip);=0D
+=0D
+	/* Fill dst ipv4. */=0D
+	tcam_key->key_mask.dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv4.dst_ip);=0D
+	tcam_key->key_mask.dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv4.dst_ip);=0D
+	tcam_key->key_info.dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv4.dst_ip);=0D
+	tcam_key->key_info.dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv4.dst_ip);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,=0D
+				 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	/* Fill type of ip. */=0D
+	tcam_key->key_mask_vxlan_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_vxlan_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+	/* Use inner dst ipv6 to fill the dst ipv6 of tcam_key. */=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_mask_vxlan_ipv6.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.inner_ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_info_vxlan_ipv6.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.inner_ipv6.dst_ip[0x3]);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_outer_ipv6_init(struct hinic3_fdir_filter *rule,=0D
+				 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	tcam_key->key_mask_ipv6.sipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);=0D
+	tcam_key->key_mask_ipv6.sipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.src_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.sipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0]);=0D
+	tcam_key->key_info_ipv6.sipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0]);=0D
+	tcam_key->key_info_ipv6.sipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.sipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.sipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.sipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.sipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.sipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
+=0D
+	tcam_key->key_mask_ipv6.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_mask_ipv6.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.dipv6_key0 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);=0D
+	tcam_key->key_info_ipv6.dipv6_key1 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0]);=0D
+	tcam_key->key_info_ipv6.dipv6_key2 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.dipv6_key3 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x1]);=0D
+	tcam_key->key_info_ipv6.dipv6_key4 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.dipv6_key5 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x2]);=0D
+	tcam_key->key_info_ipv6.dipv6_key6 =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
+	tcam_key->key_info_ipv6.dipv6_key7 =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *dev,=0D
+				 struct hinic3_fdir_filter *rule,=0D
+				 struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	tcam_key->key_mask_ipv6.ip_proto =3D rule->key_mask.proto;=0D
+	tcam_key->key_info_ipv6.ip_proto =3D rule->key_spec.proto;=0D
+=0D
+	tcam_key->key_mask_ipv6.tunnel_type =3D HINIC3_UINT4_MAX;=0D
+	tcam_key->key_info_ipv6.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+=0D
+	tcam_key->key_mask_ipv6.outer_ip_type =3D HINIC3_UINT1_MAX;=0D
+	tcam_key->key_info_ipv6.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+	tcam_key->key_mask_ipv6.function_id =3D HINIC3_UINT15_MAX;=0D
+	tcam_key->key_info_ipv6.function_id =3D=0D
+		hinic3_global_func_id(nic_dev->hwdev) & HINIC3_UINT15_MAX;=0D
+=0D
+	tcam_key->key_mask_ipv6.dport =3D rule->key_mask.dst_port;=0D
+	tcam_key->key_info_ipv6.dport =3D rule->key_spec.dst_port;=0D
+=0D
+	tcam_key->key_mask_ipv6.sport =3D rule->key_mask.src_port;=0D
+	tcam_key->key_info_ipv6.sport =3D rule->key_spec.src_port;=0D
+=0D
+	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_ANY)=0D
+		hinic3_fdir_tcam_outer_ipv6_init(rule, tcam_key);=0D
+}=0D
+=0D
+/**=0D
+ * Sets the TCAM information in the VXLAN scenario.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] rule=0D
+ * Pointer to the filtering rule.=0D
+ * @param[in] tcam_key=0D
+ * Pointer to the TCAM key.=0D
+ */=0D
+static void=0D
+hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,=0D
+			    struct hinic3_fdir_filter *rule,=0D
+			    struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (rule->outer_ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV6) {=0D
+		hinic3_fdir_tcam_ipv6_vxlan_init(dev, rule, tcam_key);=0D
+		return;=0D
+	}=0D
+=0D
+	tcam_key->key_mask.ip_proto =3D rule->key_mask.proto;=0D
+	tcam_key->key_info.ip_proto =3D rule->key_spec.proto;=0D
+=0D
+	tcam_key->key_mask.sport =3D rule->key_mask.src_port;=0D
+	tcam_key->key_info.sport =3D rule->key_spec.src_port;=0D
+=0D
+	tcam_key->key_mask.dport =3D rule->key_mask.dst_port;=0D
+	tcam_key->key_info.dport =3D rule->key_spec.dst_port;=0D
+=0D
+	tcam_key->key_mask.outer_sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.src_ip);=0D
+	tcam_key->key_mask.outer_sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.src_ip);=0D
+	tcam_key->key_info.outer_sipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.src_ip);=0D
+	tcam_key->key_info.outer_sipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.src_ip);=0D
+=0D
+	tcam_key->key_mask.outer_dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv4.dst_ip);=0D
+	tcam_key->key_mask.outer_dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.ipv4.dst_ip);=0D
+	tcam_key->key_info.outer_dipv4_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.ipv4.dst_ip);=0D
+	tcam_key->key_info.outer_dipv4_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);=0D
+=0D
+	tcam_key->key_mask.vni_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_mask.tunnel.tunnel_id);=0D
+	tcam_key->key_mask.vni_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_mask.tunnel.tunnel_id);=0D
+	tcam_key->key_info.vni_h =3D=0D
+		HINIC3_32_UPPER_16_BITS(rule->key_spec.tunnel.tunnel_id);=0D
+	tcam_key->key_info.vni_l =3D=0D
+		HINIC3_32_LOWER_16_BITS(rule->key_spec.tunnel.tunnel_id);=0D
+=0D
+	tcam_key->key_mask.tunnel_type =3D HINIC3_UINT4_MAX;=0D
+	tcam_key->key_info.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+=0D
+	tcam_key->key_mask.function_id =3D HINIC3_UINT15_MAX;=0D
+	tcam_key->key_info.function_id =3D hinic3_global_func_id(nic_dev->hwdev) =
&=0D
+					 HINIC3_UINT15_MAX;=0D
+=0D
+	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4)=0D
+		hinic3_fdir_tcam_vxlan_ipv4_init(rule, tcam_key);=0D
+=0D
+	else if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV6)=0D
+		hinic3_fdir_tcam_vxlan_ipv6_init(rule, tcam_key);=0D
+}=0D
+=0D
+static void=0D
+hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,=0D
+			   struct hinic3_fdir_filter *rule,=0D
+			   struct hinic3_tcam_key *tcam_key,=0D
+			   struct hinic3_tcam_cfg_rule *fdir_tcam_rule)=0D
+{=0D
+	/* Initialize the TCAM based on the tunnel type. */=0D
+	if (rule->tunnel_type =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL)=0D
+		hinic3_fdir_tcam_notunnel_init(dev, rule, tcam_key);=0D
+	else=0D
+		hinic3_fdir_tcam_vxlan_init(dev, rule, tcam_key);=0D
+=0D
+	/* Set the queue index. */=0D
+	fdir_tcam_rule->data.qid =3D rule->rq_index;=0D
+	/* Calculate key of TCAM. */=0D
+	tcam_key_calculate(tcam_key, fdir_tcam_rule);=0D
+}=0D
+=0D
+/**=0D
+ * Find filter in given ethertype filter list.=0D
+ *=0D
+ * @param[in] filter_list=0D
+ * Point to the Ether filter list.=0D
+ * @param[in] key=0D
+ * The tcam key to find.=0D
+ * @return=0D
+ * If a matching filter is found, the filter is returned, otherwise=0D
+ * RTE_ETH_FILTER_NONE.=0D
+ */=0D
+static inline uint16_t=0D
+hinic3_ethertype_filter_lookup(struct hinic3_ethertype_filter_list *ethert=
ype_list,=0D
+			       uint16_t type)=0D
+{=0D
+	struct rte_flow *it;=0D
+	struct hinic3_filter_t *filter_rules;=0D
+=0D
+	TAILQ_FOREACH(it, ethertype_list, node) {=0D
+		filter_rules =3D it->rule;=0D
+		if (type =3D=3D filter_rules->ethertype_filter.ether_type)=0D
+			return filter_rules->ethertype_filter.ether_type;=0D
+	}=0D
+=0D
+	return RTE_ETH_FILTER_NONE;=0D
+}=0D
+=0D
+/**=0D
+ * Find the filter that matches the given key in the TCAM filter list.=0D
+ *=0D
+ * @param[in] filter_list=0D
+ * Point to the tcam filter list.=0D
+ * @param[in] key=0D
+ * The tcam key to find.=0D
+ * @return=0D
+ * If a matching filter is found, the filter is returned, otherwise NULL.=
=0D
+ */=0D
+static inline struct hinic3_tcam_filter *=0D
+hinic3_tcam_filter_lookup(struct hinic3_tcam_filter_list *filter_list,=0D
+			  struct hinic3_tcam_key *key)=0D
+{=0D
+	struct hinic3_tcam_filter *it;=0D
+=0D
+	TAILQ_FOREACH(it, filter_list, entries) {=0D
+		if (memcmp(key, &it->tcam_key,=0D
+			   sizeof(struct hinic3_tcam_key)) =3D=3D 0) {=0D
+			return it;=0D
+		}=0D
+	}=0D
+=0D
+	return NULL;=0D
+}=0D
+/**=0D
+ * Allocate memory for dynamic blocks and then add them to the queue.=0D
+ *=0D
+ * @param[in] tcam_info=0D
+ * Point to TCAM information.=0D
+ * @param[in] dynamic_block_id=0D
+ * Indicate the ID of a dynamic block.=0D
+ * @return=0D
+ * Return the pointer to the dynamic block, or NULL if the allocation fail=
s.=0D
+ */=0D
+static struct hinic3_tcam_dynamic_block *=0D
+hinic3_alloc_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,=0D
+				    u16 dynamic_block_id)=0D
+{=0D
+	struct hinic3_tcam_dynamic_block *dynamic_block_ptr =3D NULL;=0D
+=0D
+	dynamic_block_ptr =3D=0D
+		rte_zmalloc("hinic3_tcam_dynamic_mem",=0D
+			    sizeof(struct hinic3_tcam_dynamic_block), 0);=0D
+	if (dynamic_block_ptr =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Alloc fdir filter dynamic block index %d memory "=0D
+			    "failed!",=0D
+			    dynamic_block_id);=0D
+		return NULL;=0D
+	}=0D
+=0D
+	dynamic_block_ptr->dynamic_block_id =3D dynamic_block_id;=0D
+=0D
+	/* Add new block to the end of the TCAM dynamic block list. */=0D
+	TAILQ_INSERT_TAIL(&tcam_info->tcam_dynamic_info.tcam_dynamic_list,=0D
+			  dynamic_block_ptr, entries);=0D
+=0D
+	tcam_info->tcam_dynamic_info.dynamic_block_cnt++;=0D
+=0D
+	return dynamic_block_ptr;=0D
+}=0D
+=0D
+static void=0D
+hinic3_free_dynamic_block_resource(struct hinic3_tcam_info *tcam_info,=0D
+				   struct hinic3_tcam_dynamic_block *dynamic_block_ptr)=0D
+{=0D
+	if (dynamic_block_ptr =3D=3D NULL)=0D
+		return;=0D
+=0D
+	/* Remove the incoming dynamic block from the TCAM dynamic list. */=0D
+	TAILQ_REMOVE(&tcam_info->tcam_dynamic_info.tcam_dynamic_list,=0D
+		     dynamic_block_ptr, entries);=0D
+	rte_free(dynamic_block_ptr);=0D
+=0D
+	tcam_info->tcam_dynamic_info.dynamic_block_cnt--;=0D
+}=0D
+=0D
+/**=0D
+ * Check whether there are free positions in the dynamic TCAM filter.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] fdir_tcam_rule=0D
+ * Indicate the filtering rule to be searched for.=0D
+ * @param[in] tcam_info=0D
+ * Ternary Content-Addressable Memory (TCAM) information.=0D
+ * @param[in] tcam_filter=0D
+ * Point to the TCAM filter.=0D
+ * @param[out] tcam_index=0D
+ * Indicate the TCAM index to be searched for.=0D
+ * @result=0D
+ * Pointer to the TCAM dynamic block. If the search fails, NULL is returne=
d.=0D
+ */=0D
+static struct hinic3_tcam_dynamic_block *=0D
+hinic3_dynamic_lookup_tcam_filter(struct rte_eth_dev *dev,=0D
+				  struct hinic3_tcam_cfg_rule *fdir_tcam_rule,=0D
+				  struct hinic3_tcam_info *tcam_info,=0D
+				  struct hinic3_tcam_filter *tcam_filter,=0D
+				  u16 *tcam_index)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u16 block_cnt =3D tcam_info->tcam_dynamic_info.dynamic_block_cnt;=0D
+	struct hinic3_tcam_dynamic_block *dynamic_block_ptr =3D NULL;=0D
+	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
+	u16 rule_nums =3D nic_dev->tcam_rule_nums;=0D
+	int block_alloc_flag =3D 0;=0D
+	u16 dynamic_block_id =3D 0;=0D
+	u16 index;=0D
+	int err;=0D
+=0D
+	/*=0D
+	 * Check whether the number of filtering rules reaches the maximum=0D
+	 * capacity of dynamic TCAM blocks.=0D
+	 */=0D
+	if (rule_nums >=3D block_cnt * HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {=0D
+		if (block_cnt >=3D (HINIC3_TCAM_DYNAMIC_MAX_FILTERS /=0D
+				  HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"Dynamic tcam block is full, alloc failed!");=0D
+			goto failed;=0D
+		}=0D
+		/*=0D
+		 * The TCAM blocks are insufficient.=0D
+		 * Apply for a new TCAM block.=0D
+		 */=0D
+		err =3D hinic3_alloc_tcam_block(nic_dev->hwdev,=0D
+					      &dynamic_block_id);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"Fdir filter dynamic tcam alloc block failed!");=0D
+			goto failed;=0D
+		}=0D
+=0D
+		block_alloc_flag =3D 1;=0D
+=0D
+		/* Applying for Memory. */=0D
+		dynamic_block_ptr =3D=0D
+			hinic3_alloc_dynamic_block_resource(tcam_info,=0D
+							    dynamic_block_id);=0D
+		if (dynamic_block_ptr =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "Fdir filter dynamic alloc block "=0D
+					 "memory failed!");=0D
+			goto block_alloc_failed;=0D
+		}=0D
+	}=0D
+=0D
+	/*=0D
+	 * Find the first dynamic TCAM block that meets dynamci_index_cnt <=0D
+	 * HINIC3_TCAM_DYNAMIC_BLOCK_SIZE.=0D
+	 */=0D
+	TAILQ_FOREACH(tmp, &tcam_info->tcam_dynamic_info.tcam_dynamic_list,=0D
+		      entries) {=0D
+		if (tmp->dynamic_index_cnt < HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)=0D
+			break;=0D
+	}=0D
+=0D
+	if (tmp =3D=3D NULL ||=0D
+	    tmp->dynamic_index_cnt >=3D HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Fdir filter dynamic lookup for index failed!");=0D
+		goto look_up_failed;=0D
+	}=0D
+=0D
+	for (index =3D 0; index < HINIC3_TCAM_DYNAMIC_BLOCK_SIZE; index++) {=0D
+		if (tmp->dynamic_index[index] =3D=3D 0)=0D
+			break;=0D
+	}=0D
+=0D
+	/* Find the first free position. */=0D
+	if (index =3D=3D HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "tcam block 0x%x supports filter rules is full!",=0D
+			    tmp->dynamic_block_id);=0D
+		goto look_up_failed;=0D
+	}=0D
+=0D
+	tcam_filter->dynamic_block_id =3D tmp->dynamic_block_id;=0D
+	tcam_filter->index =3D index;=0D
+	*tcam_index =3D index;=0D
+=0D
+	fdir_tcam_rule->index =3D=0D
+		HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tmp->dynamic_block_id) +=0D
+		index;=0D
+=0D
+	return tmp;=0D
+=0D
+look_up_failed:=0D
+	if (dynamic_block_ptr !=3D NULL)=0D
+		hinic3_free_dynamic_block_resource(tcam_info,=0D
+						   dynamic_block_ptr);=0D
+=0D
+block_alloc_failed:=0D
+	if (block_alloc_flag =3D=3D 1)=0D
+		hinic3_free_tcam_block(nic_dev->hwdev, &dynamic_block_id);=0D
+=0D
+failed:=0D
+	return NULL;=0D
+}=0D
+=0D
+/**=0D
+ * Add a TCAM filter.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] tcam_key=0D
+ * Pointer to the TCAM key.=0D
+ * @param[in] fdir_tcam_rule=0D
+ * Pointer to the  TCAM filtering rule.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_add_tcam_filter(struct rte_eth_dev *dev,=0D
+		       struct hinic3_tcam_key *tcam_key,=0D
+		       struct hinic3_tcam_cfg_rule *fdir_tcam_rule)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D=0D
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_tcam_dynamic_block *dynamic_block_ptr =3D NULL;=0D
+	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
+	struct hinic3_tcam_filter *tcam_filter;=0D
+	u16 tcam_block_index =3D 0;=0D
+	u16 index =3D 0;=0D
+	int err;=0D
+=0D
+	/* Alloc TCAM filter memory. */=0D
+	tcam_filter =3D rte_zmalloc("hinic3_fdir_filter",=0D
+				  sizeof(struct hinic3_tcam_filter), 0);=0D
+	if (tcam_filter =3D=3D NULL)=0D
+		return -ENOMEM;=0D
+=0D
+	tcam_filter->tcam_key =3D *tcam_key;=0D
+	tcam_filter->queue =3D (u16)(fdir_tcam_rule->data.qid);=0D
+=0D
+	/* Add new TCAM rules. */=0D
+	if (nic_dev->tcam_rule_nums =3D=3D 0) {=0D
+		err =3D hinic3_alloc_tcam_block(nic_dev->hwdev,=0D
+					      &tcam_block_index);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Fdir filter tcam alloc block failed!");=0D
+			goto failed;=0D
+		}=0D
+=0D
+		dynamic_block_ptr =3D=0D
+			hinic3_alloc_dynamic_block_resource(tcam_info,=0D
+							    tcam_block_index);=0D
+		if (dynamic_block_ptr =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "Fdir filter alloc dynamic first "=0D
+					 "block memory failed!");=0D
+			goto alloc_block_failed;=0D
+		}=0D
+	}=0D
+=0D
+	/*=0D
+	 * Look for an available index in the dynamic block to store the new=0D
+	 * TCAM filter.=0D
+	 */=0D
+	tmp =3D hinic3_dynamic_lookup_tcam_filter(dev, fdir_tcam_rule, tcam_info,=
=0D
+						tcam_filter, &index);=0D
+	if (tmp =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Dynamic lookup tcam filter failed!");=0D
+		goto lookup_tcam_index_failed;=0D
+	}=0D
+=0D
+	/* Add a new TCAM rule to the network device. */=0D
+	err =3D hinic3_add_tcam_rule(nic_dev->hwdev, fdir_tcam_rule,=0D
+				   TCAM_RULE_FDIR_TYPE);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Fdir_tcam_rule add failed!");=0D
+		goto add_tcam_rules_failed;=0D
+	}=0D
+=0D
+	/* If there are no rules, TCAM filtering is enabled. */=0D
+	if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums)) {=0D
+		err =3D hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev, true);=0D
+		if (err)=0D
+			goto enable_failed;=0D
+	}=0D
+=0D
+	/* Add a filter to the end of the queue. */=0D
+	TAILQ_INSERT_TAIL(&tcam_info->tcam_list, tcam_filter, entries);=0D
+=0D
+	/* Update dynamic index. */=0D
+	tmp->dynamic_index[index] =3D 1;=0D
+	tmp->dynamic_index_cnt++;=0D
+=0D
+	nic_dev->tcam_rule_nums++;=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Add fdir tcam rule, function_id: 0x%x, "=0D
+		    "tcam_block_id: %d, local_index: %d, global_index: %d, "=0D
+		    "queue: %d, "=0D
+		    "tcam_rule_nums: %d succeed",=0D
+		    hinic3_global_func_id(nic_dev->hwdev),=0D
+		    tcam_filter->dynamic_block_id, index, fdir_tcam_rule->index,=0D
+		    fdir_tcam_rule->data.qid, nic_dev->tcam_rule_nums);=0D
+=0D
+	return 0;=0D
+=0D
+enable_failed:=0D
+	hinic3_del_tcam_rule(nic_dev->hwdev, fdir_tcam_rule->index,=0D
+				   TCAM_RULE_FDIR_TYPE);=0D
+=0D
+add_tcam_rules_failed:=0D
+lookup_tcam_index_failed:=0D
+	if (nic_dev->tcam_rule_nums =3D=3D 0 && dynamic_block_ptr !=3D NULL)=0D
+		hinic3_free_dynamic_block_resource(tcam_info,=0D
+						   dynamic_block_ptr);=0D
+=0D
+alloc_block_failed:=0D
+	if (nic_dev->tcam_rule_nums =3D=3D 0)=0D
+		hinic3_free_tcam_block(nic_dev->hwdev, &tcam_block_index);=0D
+=0D
+failed:=0D
+	rte_free(tcam_filter);=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+/**=0D
+ * Delete a TCAM filter.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] tcam_filter=0D
+ * TCAM Filters to Delete.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_del_dynamic_tcam_filter(struct rte_eth_dev *dev,=0D
+			       struct hinic3_tcam_filter *tcam_filter)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D=0D
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u16 dynamic_block_id =3D tcam_filter->dynamic_block_id;=0D
+	struct hinic3_tcam_dynamic_block *tmp =3D NULL;=0D
+	u32 index =3D 0;=0D
+	int err;=0D
+=0D
+	/* Traverse to find the block that matches the given ID. */=0D
+	TAILQ_FOREACH(tmp, &tcam_info->tcam_dynamic_info.tcam_dynamic_list,=0D
+		      entries) {=0D
+		if (tmp->dynamic_block_id =3D=3D dynamic_block_id)=0D
+			break;=0D
+	}=0D
+=0D
+	if (tmp =3D=3D NULL || tmp->dynamic_block_id !=3D dynamic_block_id) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Fdir filter del dynamic lookup for block failed!");=0D
+		return -EINVAL;=0D
+	}=0D
+	/* Calculate TCAM index. */=0D
+	index =3D HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(tmp->dynamic_block_id) +=0D
+		tcam_filter->index;=0D
+=0D
+	/* Delete a specified rule. */=0D
+	err =3D hinic3_del_tcam_rule(nic_dev->hwdev, index, TCAM_RULE_FDIR_TYPE);=
=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Fdir tcam rule del failed!");=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Del fdir_tcam_dynamic_rule function_id: 0x%x, "=0D
+		    "tcam_block_id: %d, local_index: %d, global_index: %d, "=0D
+		    "local_rules_nums: %d, global_rule_nums: %d succeed",=0D
+		    hinic3_global_func_id(nic_dev->hwdev), dynamic_block_id,=0D
+		    tcam_filter->index, index, tmp->dynamic_index_cnt - 1,=0D
+		    nic_dev->tcam_rule_nums - 1);=0D
+=0D
+	tmp->dynamic_index[tcam_filter->index] =3D 0;=0D
+	tmp->dynamic_index_cnt--;=0D
+	nic_dev->tcam_rule_nums--;=0D
+	if (tmp->dynamic_index_cnt =3D=3D 0) {=0D
+		hinic3_free_tcam_block(nic_dev->hwdev, &dynamic_block_id);=0D
+=0D
+		hinic3_free_dynamic_block_resource(tcam_info, tmp);=0D
+	}=0D
+=0D
+	/* If the number of rules is 0, the TCAM filter is disabled. */=0D
+	if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums))=0D
+		hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev, false);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_del_tcam_filter(struct rte_eth_dev *dev,=0D
+		       struct hinic3_tcam_filter *tcam_filter)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D=0D
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
+	int err;=0D
+=0D
+	err =3D hinic3_del_dynamic_tcam_filter(dev, tcam_filter);=0D
+	if (err < 0) {=0D
+		PMD_DRV_LOG(ERR, "Del dynamic tcam filter failed!");=0D
+		return err;=0D
+	}=0D
+=0D
+	/* Remove the filter from the TCAM list. */=0D
+	TAILQ_REMOVE(&tcam_info->tcam_list, tcam_filter, entries);=0D
+=0D
+	rte_free(tcam_filter);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Add or deletes an fdir filter rule. This is the core function for opera=
ting=0D
+ * filters.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] fdir_filter=0D
+ * Pointer to the fdir filter.=0D
+ * @param[in] add=0D
+ * This is a Boolean value (of the bool type) indicating whether the actio=
n to=0D
+ * be performed is to add (true) or delete (false) the filter rule.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,=0D
+				struct hinic3_fdir_filter *fdir_filter,=0D
+				bool add)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D=0D
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
+	struct hinic3_tcam_filter *tcam_filter;=0D
+	struct hinic3_tcam_cfg_rule fdir_tcam_rule;=0D
+	struct hinic3_tcam_key tcam_key;=0D
+	int ret;=0D
+=0D
+	memset(&fdir_tcam_rule, 0, sizeof(struct hinic3_tcam_cfg_rule));=0D
+	memset((void *)&tcam_key, 0, sizeof(struct hinic3_tcam_key));=0D
+=0D
+	hinic3_fdir_tcam_info_init(dev, fdir_filter, &tcam_key,=0D
+				   &fdir_tcam_rule);=0D
+	/* Search for a filter. */=0D
+	tcam_filter =3D=0D
+		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key);=0D
+	if (tcam_filter !=3D NULL && add) {=0D
+		PMD_DRV_LOG(ERR, "Filter exists.");=0D
+		return -EEXIST;=0D
+	}=0D
+	if (tcam_filter =3D=3D NULL && !add) {=0D
+		PMD_DRV_LOG(ERR, "Filter doesn't exist.");=0D
+		return -ENOENT;=0D
+	}=0D
+=0D
+	/*=0D
+	 * If the value of Add is true, the system performs the adding=0D
+	 * operation.=0D
+	 */=0D
+	if (add) {=0D
+		ret =3D hinic3_add_tcam_filter(dev, &tcam_key, &fdir_tcam_rule);=0D
+		if (ret)=0D
+			goto cfg_tcam_filter_err;=0D
+=0D
+		fdir_filter->tcam_index =3D (int)(fdir_tcam_rule.index);=0D
+	} else {=0D
+		PMD_DRV_LOG(INFO, "begin to del tcam filter");=0D
+		ret =3D hinic3_del_tcam_filter(dev, tcam_filter);=0D
+		if (ret)=0D
+			goto cfg_tcam_filter_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+cfg_tcam_filter_err:=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ * Enable or disable the TCAM filter for the receive queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] able=0D
+ * Flag to enable or disable the filter.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, u32 queue_id, u32 a=
ble)=0D
+{=0D
+	struct hinic3_tcam_info *tcam_info =3D=0D
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_tcam_filter *it;=0D
+	struct hinic3_tcam_cfg_rule fdir_tcam_rule;=0D
+	int ret;=0D
+	u32 queue_res;=0D
+	uint16_t index;=0D
+=0D
+	memset(&fdir_tcam_rule, 0, sizeof(struct hinic3_tcam_cfg_rule));=0D
+=0D
+	if (able) {=0D
+		TAILQ_FOREACH(it, &tcam_info->tcam_list, entries) {=0D
+			if (queue_id =3D=3D it->queue) {=0D
+				index =3D (u16)(HINIC3_PKT_TCAM_DYNAMIC_INDEX_START=0D
+					      (it->dynamic_block_id) + it->index);=0D
+=0D
+				/*=0D
+				 * When the rxq is start, find invalid rxq_id=0D
+				 * and delete the fdir rule from the tcam.=0D
+				 */=0D
+				ret =3D hinic3_del_tcam_rule(nic_dev->hwdev,=0D
+							   index,=0D
+							   TCAM_RULE_FDIR_TYPE);=0D
+				if (ret) {=0D
+					PMD_DRV_LOG(ERR, "del invalid tcam "=0D
+							 "rule failed!");=0D
+					return -EFAULT;=0D
+				}=0D
+=0D
+				fdir_tcam_rule.index =3D index;=0D
+				fdir_tcam_rule.data.qid =3D queue_id;=0D
+				tcam_key_calculate(&it->tcam_key,=0D
+						   &fdir_tcam_rule);=0D
+=0D
+				/* To enable a rule, add a rule. */=0D
+				ret =3D hinic3_add_tcam_rule(nic_dev->hwdev,=0D
+							   &fdir_tcam_rule,=0D
+							   TCAM_RULE_FDIR_TYPE);=0D
+				if (ret) {=0D
+					PMD_DRV_LOG(ERR, "add correct tcam "=0D
+							 "rule failed!");=0D
+					return -EFAULT;=0D
+				}=0D
+			}=0D
+		}=0D
+	} else {=0D
+		queue_res =3D HINIC3_INVALID_QID_BASE | queue_id;=0D
+=0D
+		TAILQ_FOREACH(it, &tcam_info->tcam_list, entries) {=0D
+			if (queue_id =3D=3D it->queue) {=0D
+				index =3D (u16)(HINIC3_PKT_TCAM_DYNAMIC_INDEX_START=0D
+					      (it->dynamic_block_id) + it->index);=0D
+=0D
+				/*=0D
+				 * When the rxq is stop, delete the fdir rule=0D
+				 * from the tcam and add the correct fdir rule=0D
+				 * from the tcam.=0D
+				 */=0D
+				ret =3D hinic3_del_tcam_rule(nic_dev->hwdev,=0D
+							   index,=0D
+							   TCAM_RULE_FDIR_TYPE);=0D
+				if (ret) {=0D
+					PMD_DRV_LOG(ERR, "del correct tcam "=0D
+							 "rule failed!");=0D
+					return -EFAULT;=0D
+				}=0D
+=0D
+				fdir_tcam_rule.index =3D index;=0D
+				fdir_tcam_rule.data.qid =3D queue_res;=0D
+				tcam_key_calculate(&it->tcam_key,=0D
+						   &fdir_tcam_rule);=0D
+=0D
+				/* Add the correct fdir rule from the tcam. */=0D
+				ret =3D hinic3_add_tcam_rule(nic_dev->hwdev,=0D
+							   &fdir_tcam_rule,=0D
+							   TCAM_RULE_FDIR_TYPE);=0D
+				if (ret) {=0D
+					PMD_DRV_LOG(ERR, "add invalid tcam "=0D
+							 "rule failed!");=0D
+					return -EFAULT;=0D
+				}=0D
+			}=0D
+		}=0D
+	}=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+void=0D
+hinic3_free_fdir_filter(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev, false);=0D
+=0D
+	hinic3_flush_tcam_rule(nic_dev->hwdev);=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_set_arp_filter(struct rte_eth_dev *dev,=0D
+			   struct rte_eth_ethertype_filter *ethertype_filter,=0D
+			   bool add)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int ret;=0D
+=0D
+	/* Setting the ARP Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_ARP,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		return ret;=0D
+	}=0D
+=0D
+	/* Setting the ARP Request Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_ARP_REQ,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s arp request rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		goto set_arp_req_failed;=0D
+	}=0D
+=0D
+	/* Setting the ARP Response Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_ARP_REP,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s arp response rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		goto set_arp_rep_failed;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+set_arp_rep_failed:=0D
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_ARP_REQ,=0D
+					       ethertype_filter->queue, !add);=0D
+=0D
+set_arp_req_failed:=0D
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_ARP,=0D
+					       ethertype_filter->queue, !add);=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_set_slow_filter(struct rte_eth_dev *dev,=0D
+			    struct rte_eth_ethertype_filter *ethertype_filter,=0D
+			    bool add)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int ret;=0D
+=0D
+	/* Setting the LACP Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_LACP,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s lacp fdir rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		return ret;=0D
+	}=0D
+=0D
+	/* Setting the OAM Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_OAM,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s oam rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		goto set_arp_oam_failed;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+set_arp_oam_failed:=0D
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_LACP,=0D
+					       ethertype_filter->queue, !add);=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_set_lldp_filter(struct rte_eth_dev *dev,=0D
+			    struct rte_eth_ethertype_filter *ethertype_filter,=0D
+			    bool add)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int ret;=0D
+=0D
+	/* Setting the LLDP Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_LLDP,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s lldp fdir rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		return ret;=0D
+	}=0D
+=0D
+	/* Setting the CDCP Filter. */=0D
+	ret =3D hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_CDCP,=0D
+					       ethertype_filter->queue, add);=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s cdcp fdir rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		goto set_arp_cdcp_failed;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+set_arp_cdcp_failed:=0D
+	hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+					       HINIC3_PKT_TYPE_LLDP,=0D
+					       ethertype_filter->queue, !add);=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_add_del_ethertype_filter_rule(struct rte_eth_dev *dev,=0D
+					  struct rte_eth_ethertype_filter *ethertype_filter,=0D
+					  bool add)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_ethertype_filter_list *ethertype_list =3D=0D
+		&nic_dev->filter_ethertype_list;=0D
+=0D
+	/* Check whether the transferred rule exists. */=0D
+	if (hinic3_ethertype_filter_lookup(ethertype_list,=0D
+					   ethertype_filter->ether_type)) {=0D
+		if (add) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"The rule already exists, can not to be added");=0D
+			return -EPERM;=0D
+		}=0D
+	} else {=0D
+		if (!add) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"The rule not exists, can not to be delete");=0D
+			return -EPERM;=0D
+		}=0D
+	}=0D
+	/* Create a filter based on the protocol type. */=0D
+	switch (ethertype_filter->ether_type) {=0D
+	case RTE_ETHER_TYPE_ARP:=0D
+		return hinic3_flow_set_arp_filter(dev, ethertype_filter, add);=0D
+	case RTE_ETHER_TYPE_RARP:=0D
+		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+			HINIC3_PKT_TYPE_RARP, ethertype_filter->queue, add);=0D
+=0D
+	case RTE_ETHER_TYPE_SLOW:=0D
+		return hinic3_flow_set_slow_filter(dev, ethertype_filter, add);=0D
+=0D
+	case RTE_ETHER_TYPE_LLDP:=0D
+		return hinic3_flow_set_lldp_filter(dev, ethertype_filter, add);=0D
+=0D
+	case RTE_ETHER_TYPE_CNM:=0D
+		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+			HINIC3_PKT_TYPE_CNM, ethertype_filter->queue, add);=0D
+=0D
+	case RTE_ETHER_TYPE_ECP:=0D
+		return hinic3_set_fdir_ethertype_filter(nic_dev->hwdev,=0D
+			HINIC3_PKT_TYPE_ECP, ethertype_filter->queue, add);=0D
+=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "Unknown ethertype %d queue_id %d",=0D
+			    ethertype_filter->ether_type,=0D
+			    ethertype_filter->queue);=0D
+		return -EPERM;=0D
+	}=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_ethertype_rule_nums(struct rte_eth_ethertype_filter *ethertype=
_filter)=0D
+{=0D
+	switch (ethertype_filter->ether_type) {=0D
+	case RTE_ETHER_TYPE_ARP:=0D
+		return HINIC3_ARP_RULE_NUM;=0D
+	case RTE_ETHER_TYPE_RARP:=0D
+		return HINIC3_RARP_RULE_NUM;=0D
+	case RTE_ETHER_TYPE_SLOW:=0D
+		return HINIC3_SLOW_RULE_NUM;=0D
+	case RTE_ETHER_TYPE_LLDP:=0D
+		return HINIC3_LLDP_RULE_NUM;=0D
+	case RTE_ETHER_TYPE_CNM:=0D
+		return HINIC3_CNM_RULE_NUM;=0D
+	case RTE_ETHER_TYPE_ECP:=0D
+		return HINIC3_ECP_RULE_NUM;=0D
+=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "Unknown ethertype %d",=0D
+			    ethertype_filter->ether_type);=0D
+		return 0;=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Add or delete an Ethernet type filter rule.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] ethertype_filter=0D
+ * Pointer to ethertype filter.=0D
+ * @param[in] add=0D
+ * This is a Boolean value (of the bool type) indicating whether the actio=
n to=0D
+ * be performed is to add (true) or delete (false) the Ethernet type filte=
r=0D
+ * rule.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,=0D
+				     struct rte_eth_ethertype_filter *ethertype_filter,=0D
+				     bool add)=0D
+{=0D
+	/* Get dev private info. */=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int ret;=0D
+	/* Add or remove an Ethernet type filter rule. */=0D
+	ret =3D hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter,=
=0D
+							add);=0D
+=0D
+	if (ret) {=0D
+		PMD_DRV_LOG(ERR, "%s fdir ethertype rule failed, err: %d",=0D
+			    add ? "Add" : "Del", ret);=0D
+		return ret;=0D
+	}=0D
+	/*=0D
+	 * If a rule is added and the rule is the first rule, rule filtering is=0D
+	 * enabled. If a rule is deleted and the rule is the last one, rule=0D
+	 * filtering is disabled.=0D
+	 */=0D
+	if (add) {=0D
+		if (nic_dev->ethertype_rule_nums =3D=3D 0) {=0D
+			ret =3D hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev,=0D
+							       true);=0D
+			if (ret) {=0D
+				PMD_DRV_LOG(ERR,=0D
+					    "enable fdir rule failed, err: %d",=0D
+					    ret);=0D
+				goto enable_fdir_failed;=0D
+			}=0D
+		}=0D
+		nic_dev->ethertype_rule_nums =3D=0D
+			nic_dev->ethertype_rule_nums +=0D
+			hinic3_flow_ethertype_rule_nums(ethertype_filter);=0D
+	} else {=0D
+		nic_dev->ethertype_rule_nums =3D=0D
+			nic_dev->ethertype_rule_nums -=0D
+			hinic3_flow_ethertype_rule_nums(ethertype_filter);=0D
+=0D
+		if (!(nic_dev->ethertype_rule_nums + nic_dev->tcam_rule_nums)) {=0D
+			ret =3D hinic3_set_fdir_tcam_rule_filter(nic_dev->hwdev,=0D
+							       false);=0D
+			if (ret) {=0D
+				PMD_DRV_LOG(ERR,=0D
+					    "disable fdir rule failed, err: %d",=0D
+					    ret);=0D
+			}=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+enable_fdir_failed:=0D
+	hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter,=0D
+							!add);=0D
+	return ret;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_f=
dir.h=0D
new file mode 100644=0D
index 0000000000..fbb2461a44=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_fdir.h=0D
@@ -0,0 +1,398 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_FDIR_H_=0D
+#define _HINIC3_FDIR_H_=0D
+=0D
+#define HINIC3_FLOW_MAX_PATTERN_NUM 16=0D
+=0D
+#define HINIC3_TCAM_DYNAMIC_BLOCK_SIZE 16=0D
+=0D
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS 1024=0D
+=0D
+#define HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_index) \=0D
+	(HINIC3_TCAM_DYNAMIC_BLOCK_SIZE * (block_index))=0D
+=0D
+/* Indicate a traffic filtering rule. */=0D
+struct rte_flow {=0D
+	TAILQ_ENTRY(rte_flow) node;=0D
+	enum rte_filter_type filter_type;=0D
+	void *rule;=0D
+};=0D
+=0D
+struct hinic3_fdir_rule_key {=0D
+	struct rte_eth_ipv4_flow ipv4;=0D
+	struct rte_eth_ipv6_flow ipv6;=0D
+	struct rte_eth_ipv4_flow inner_ipv4;=0D
+	struct rte_eth_ipv6_flow inner_ipv6;=0D
+	struct rte_eth_tunnel_flow tunnel;=0D
+	uint16_t src_port;=0D
+	uint16_t dst_port;=0D
+	uint8_t proto;=0D
+};=0D
+=0D
+struct hinic3_fdir_filter {=0D
+	int tcam_index;=0D
+	uint8_t ip_type; /**< Inner ip type. */=0D
+	uint8_t outer_ip_type;=0D
+	uint8_t tunnel_type;=0D
+	struct hinic3_fdir_rule_key key_mask;=0D
+	struct hinic3_fdir_rule_key key_spec;=0D
+	uint32_t rq_index; /**< Queue assigned when matched. */=0D
+};=0D
+=0D
+/* This structure is used to describe a basic filter type. */=0D
+struct hinic3_filter_t {=0D
+	u16 filter_rule_nums;=0D
+	enum rte_filter_type filter_type;=0D
+	struct rte_eth_ethertype_filter ethertype_filter;=0D
+	struct hinic3_fdir_filter fdir_filter;=0D
+};=0D
+=0D
+enum hinic3_fdir_tunnel_mode {=0D
+	HINIC3_FDIR_TUNNEL_MODE_NORMAL =3D 0,=0D
+	HINIC3_FDIR_TUNNEL_MODE_VXLAN =3D 1,=0D
+};=0D
+=0D
+enum hinic3_fdir_ip_type {=0D
+	HINIC3_FDIR_IP_TYPE_IPV4 =3D 0,=0D
+	HINIC3_FDIR_IP_TYPE_IPV6 =3D 1,=0D
+	HINIC3_FDIR_IP_TYPE_ANY =3D 2,=0D
+};=0D
+=0D
+/* Describe the key structure of the TCAM. */=0D
+struct hinic3_tcam_key_mem {=0D
+#if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
+	u32 rsvd0 : 16;=0D
+	u32 ip_proto : 8;=0D
+	u32 tunnel_type : 4;=0D
+	u32 rsvd1 : 4;=0D
+=0D
+	u32 function_id : 15;=0D
+	u32 ip_type : 1;=0D
+=0D
+	u32 sipv4_h : 16;=0D
+	u32 sipv4_l : 16;=0D
+=0D
+	u32 dipv4_h : 16;=0D
+	u32 dipv4_l : 16;=0D
+	u32 rsvd2 : 16;=0D
+=0D
+	u32 rsvd3;=0D
+=0D
+	u32 rsvd4 : 16;=0D
+	u32 dport : 16;=0D
+=0D
+	u32 sport : 16;=0D
+	u32 rsvd5 : 16;=0D
+=0D
+	u32 rsvd6 : 16;=0D
+	u32 outer_sipv4_h : 16;=0D
+	u32 outer_sipv4_l : 16;=0D
+=0D
+	u32 outer_dipv4_h : 16;=0D
+	u32 outer_dipv4_l : 16;=0D
+	u32 vni_h : 16;=0D
+=0D
+	u32 vni_l : 16;=0D
+	u32 rsvd7 : 16;=0D
+#else=0D
+	u32 rsvd1 : 4;=0D
+	u32 tunnel_type : 4;=0D
+	u32 ip_proto : 8;=0D
+	u32 rsvd0 : 16;=0D
+=0D
+	u32 sipv4_h : 16;=0D
+	u32 ip_type : 1;=0D
+	u32 function_id : 15;=0D
+=0D
+	u32 dipv4_h : 16;=0D
+	u32 sipv4_l : 16;=0D
+=0D
+	u32 rsvd2 : 16;=0D
+	u32 dipv4_l : 16;=0D
+=0D
+	u32 rsvd3;=0D
+=0D
+	u32 dport : 16;=0D
+	u32 rsvd4 : 16;=0D
+=0D
+	u32 rsvd5 : 16;=0D
+	u32 sport : 16;=0D
+=0D
+	u32 outer_sipv4_h : 16;=0D
+	u32 rsvd6 : 16;=0D
+=0D
+	u32 outer_dipv4_h : 16;=0D
+	u32 outer_sipv4_l : 16;=0D
+=0D
+	u32 vni_h : 16;=0D
+	u32 outer_dipv4_l : 16;=0D
+=0D
+	u32 rsvd7 : 16;=0D
+	u32 vni_l : 16;=0D
+#endif=0D
+};=0D
+=0D
+/*=0D
+ * Define the IPv6-related TCAM key data structure in common=0D
+ * scenarios or IPv6 tunnel scenarios.=0D
+ */=0D
+struct hinic3_tcam_key_ipv6_mem {=0D
+#if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
+	u32 rsvd0 : 16;=0D
+	/* Indicates the normal IPv6 nextHdr or inner IPv4/IPv6 next proto. */=0D
+	u32 ip_proto : 8;=0D
+	u32 tunnel_type : 4;=0D
+	u32 outer_ip_type : 1;=0D
+	u32 rsvd1 : 3;=0D
+=0D
+	u32 function_id : 15;=0D
+	u32 ip_type : 1;=0D
+	u32 sipv6_key0 : 16;=0D
+=0D
+	u32 sipv6_key1 : 16;=0D
+	u32 sipv6_key2 : 16;=0D
+=0D
+	u32 sipv6_key3 : 16;=0D
+	u32 sipv6_key4 : 16;=0D
+=0D
+	u32 sipv6_key5 : 16;=0D
+	u32 sipv6_key6 : 16;=0D
+=0D
+	u32 sipv6_key7 : 16;=0D
+	u32 dport : 16;=0D
+=0D
+	u32 sport : 16;=0D
+	u32 dipv6_key0 : 16;=0D
+=0D
+	u32 dipv6_key1 : 16;=0D
+	u32 dipv6_key2 : 16;=0D
+=0D
+	u32 dipv6_key3 : 16;=0D
+	u32 dipv6_key4 : 16;=0D
+=0D
+	u32 dipv6_key5 : 16;=0D
+	u32 dipv6_key6 : 16;=0D
+=0D
+	u32 dipv6_key7 : 16;=0D
+	u32 rsvd2 : 16;=0D
+#else=0D
+	u32 rsvd1 : 3;=0D
+	u32 outer_ip_type : 1;=0D
+	u32 tunnel_type : 4;=0D
+	u32 ip_proto : 8;=0D
+	u32 rsvd0 : 16;=0D
+=0D
+	u32 sipv6_key0 : 16;=0D
+	u32 ip_type : 1;=0D
+	u32 function_id : 15;=0D
+=0D
+	u32 sipv6_key2 : 16;=0D
+	u32 sipv6_key1 : 16;=0D
+=0D
+	u32 sipv6_key4 : 16;=0D
+	u32 sipv6_key3 : 16;=0D
+=0D
+	u32 sipv6_key6 : 16;=0D
+	u32 sipv6_key5 : 16;=0D
+=0D
+	u32 dport : 16;=0D
+	u32 sipv6_key7 : 16;=0D
+=0D
+	u32 dipv6_key0 : 16;=0D
+	u32 sport : 16;=0D
+=0D
+	u32 dipv6_key2 : 16;=0D
+	u32 dipv6_key1 : 16;=0D
+=0D
+	u32 dipv6_key4 : 16;=0D
+	u32 dipv6_key3 : 16;=0D
+=0D
+	u32 dipv6_key6 : 16;=0D
+	u32 dipv6_key5 : 16;=0D
+=0D
+	u32 rsvd2 : 16;=0D
+	u32 dipv6_key7 : 16;=0D
+#endif=0D
+};=0D
+=0D
+/*=0D
+ * Define the tcam key value data structure related to IPv6 in=0D
+ * the VXLAN scenario.=0D
+ */=0D
+struct hinic3_tcam_key_vxlan_ipv6_mem {=0D
+#if (RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN)=0D
+	u32 rsvd0 : 16;=0D
+	u32 ip_proto : 8;=0D
+	u32 tunnel_type : 4;=0D
+	u32 rsvd1 : 4;=0D
+=0D
+	u32 function_id : 15;=0D
+	u32 ip_type : 1;=0D
+	u32 dipv6_key0 : 16;=0D
+=0D
+	u32 dipv6_key1 : 16;=0D
+	u32 dipv6_key2 : 16;=0D
+=0D
+	u32 dipv6_key3 : 16;=0D
+	u32 dipv6_key4 : 16;=0D
+=0D
+	u32 dipv6_key5 : 16;=0D
+	u32 dipv6_key6 : 16;=0D
+=0D
+	u32 dipv6_key7 : 16;=0D
+	u32 dport : 16;=0D
+=0D
+	u32 sport : 16;=0D
+	u32 rsvd2 : 16;=0D
+=0D
+	u32 rsvd3 : 16;=0D
+	u32 outer_sipv4_h : 16;=0D
+=0D
+	u32 outer_sipv4_l : 16;=0D
+	u32 outer_dipv4_h : 16;=0D
+=0D
+	u32 outer_dipv4_l : 16;=0D
+	u32 vni_h : 16;=0D
+=0D
+	u32 vni_l : 16;=0D
+	u32 rsvd4 : 16;=0D
+#else=0D
+	u32 rsvd1 : 4;=0D
+	u32 tunnel_type : 4;=0D
+	u32 ip_proto : 8;=0D
+	u32 rsvd0 : 16;=0D
+=0D
+	u32 dipv6_key0 : 16;=0D
+	u32 ip_type : 1;=0D
+	u32 function_id : 15;=0D
+=0D
+	u32 dipv6_key2 : 16;=0D
+	u32 dipv6_key1 : 16;=0D
+=0D
+	u32 dipv6_key4 : 16;=0D
+	u32 dipv6_key3 : 16;=0D
+=0D
+	u32 dipv6_key6 : 16;=0D
+	u32 dipv6_key5 : 16;=0D
+=0D
+	u32 dport : 16;=0D
+	u32 dipv6_key7 : 16;=0D
+=0D
+	u32 rsvd2 : 16;=0D
+	u32 sport : 16;=0D
+=0D
+	u32 outer_sipv4_h : 16;=0D
+	u32 rsvd3 : 16;=0D
+=0D
+	u32 outer_dipv4_h : 16;=0D
+	u32 outer_sipv4_l : 16;=0D
+=0D
+	u32 vni_h : 16;=0D
+	u32 outer_dipv4_l : 16;=0D
+=0D
+	u32 rsvd4 : 16;=0D
+	u32 vni_l : 16;=0D
+#endif=0D
+};=0D
+=0D
+/*=0D
+ * TCAM key structure. The two unions indicate the key and mask respective=
ly.=0D
+ * The TCAM key is consistent with the TCAM entry.=0D
+ */=0D
+struct hinic3_tcam_key {=0D
+	union {=0D
+		struct hinic3_tcam_key_mem key_info;=0D
+		struct hinic3_tcam_key_ipv6_mem key_info_ipv6;=0D
+		struct hinic3_tcam_key_vxlan_ipv6_mem key_info_vxlan_ipv6;=0D
+	};=0D
+	union {=0D
+		struct hinic3_tcam_key_mem key_mask;=0D
+		struct hinic3_tcam_key_ipv6_mem key_mask_ipv6;=0D
+		struct hinic3_tcam_key_vxlan_ipv6_mem key_mask_vxlan_ipv6;=0D
+	};=0D
+};=0D
+=0D
+/* Structure indicates the TCAM filter. */=0D
+struct hinic3_tcam_filter {=0D
+	TAILQ_ENTRY(hinic3_tcam_filter)=0D
+	entries; /**< Filter entry, used for linked list operations. */=0D
+	uint16_t dynamic_block_id;	 /**< Dynamic block ID. */=0D
+	uint16_t index;			 /**< TCAM index. */=0D
+	struct hinic3_tcam_key tcam_key; /**< Indicate TCAM key. */=0D
+	uint16_t queue;			 /**< Allocated RX queue. */=0D
+};=0D
+=0D
+/* Define a linked list header for storing hinic3_tcam_filter data. */=0D
+TAILQ_HEAD(hinic3_tcam_filter_list, hinic3_tcam_filter);=0D
+=0D
+struct hinic3_tcam_dynamic_block {=0D
+	TAILQ_ENTRY(hinic3_tcam_dynamic_block) entries;=0D
+	u16 dynamic_block_id;=0D
+	u16 dynamic_index_cnt;=0D
+	u8 dynamic_index[HINIC3_TCAM_DYNAMIC_BLOCK_SIZE];=0D
+};=0D
+=0D
+/* Define a linked list header for storing hinic3_tcam_dynamic_block data.=
 */=0D
+TAILQ_HEAD(hinic3_tcam_dynamic_filter_list, hinic3_tcam_dynamic_block);=0D
+=0D
+/* Indicate TCAM dynamic block info. */=0D
+struct hinic3_tcam_dynamic_block_info {=0D
+	struct hinic3_tcam_dynamic_filter_list tcam_dynamic_list;=0D
+	u16 dynamic_block_cnt;=0D
+};=0D
+=0D
+/* Structure is used to store TCAM information. */=0D
+struct hinic3_tcam_info {=0D
+	struct hinic3_tcam_filter_list tcam_list;=0D
+	struct hinic3_tcam_dynamic_block_info tcam_dynamic_info;=0D
+};=0D
+=0D
+/* Obtain the upper and lower 16 bits. */=0D
+#define HINIC3_32_UPPER_16_BITS(n) ((((n) >> 16)) & 0xffff)=0D
+#define HINIC3_32_LOWER_16_BITS(n) ((n) & 0xffff)=0D
+=0D
+/* Number of protocol rules */=0D
+#define HINIC3_ARP_RULE_NUM  3=0D
+#define HINIC3_RARP_RULE_NUM 1=0D
+#define HINIC3_SLOW_RULE_NUM 2=0D
+#define HINIC3_LLDP_RULE_NUM 2=0D
+#define HINIC3_CNM_RULE_NUM  1=0D
+#define HINIC3_ECP_RULE_NUM  2=0D
+=0D
+/* Define Ethernet type. */=0D
+#define RTE_ETHER_TYPE_CNM 0x22e7=0D
+#define RTE_ETHER_TYPE_ECP 0x8940=0D
+=0D
+/* Protocol type of the data packet. */=0D
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
+=0D
+	HINIC3_PKT_UNKNOWN =3D 31,=0D
+};=0D
+=0D
+int hinic3_flow_add_del_fdir_filter(struct rte_eth_dev *dev,=0D
+				    struct hinic3_fdir_filter *fdir_filter,=0D
+				    bool add);=0D
+int hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,=0D
+					 struct rte_eth_ethertype_filter *ethertype_filter,=0D
+					 bool add);=0D
+=0D
+void hinic3_free_fdir_filter(struct rte_eth_dev *dev);=0D
+int hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, u32 queue_id,=0D
+				  u32 able);=0D
+int hinic3_flow_parse_attr(const struct rte_flow_attr *attr,=0D
+			   struct rte_flow_error *error);=0D
+=0D
+#endif /**< _HINIC3_FDIR_H_ */=0D
diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_f=
low.c=0D
new file mode 100644=0D
index 0000000000..b3fde10c62=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_flow.c=0D
@@ -0,0 +1,1700 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <errno.h>=0D
+#include <stdio.h>=0D
+#include <stdint.h>=0D
+#include <string.h>=0D
+#include <unistd.h>=0D
+=0D
+#include <rte_byteorder.h>=0D
+#include <rte_common.h>=0D
+#include <rte_ether.h>=0D
+#include <rte_ethdev.h>=0D
+#include <rte_flow.h>=0D
+#include <rte_flow_driver.h>=0D
+#include <rte_malloc.h>=0D
+=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_hwdev.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_fdir.h"=0D
+#include "hinic3_flow.h"=0D
+=0D
+#define HINIC3_UINT8_MAX 0xff=0D
+=0D
+/* Indicate the type of the IPv4 ICPM matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_icmp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_ICMP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 any protocol matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_any[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_ANY,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the Ether matching pattern. */=0D
+static enum rte_flow_item_type pattern_ethertype[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ethertype_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ethertype_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan any protocol matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_any[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ANY, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan IPv4 matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan IPv4 TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan IPv4 UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan IPv6 matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan IPv6 TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 vxlan IPv6 UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv4 TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv4_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV4,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH,=0D
+	HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6_vxlan[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 VXLAN any protocol matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6_vxlan_any[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_ANY, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 VXLAN TCP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6_vxlan_tcp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_TCP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+/* Indicate the type of the IPv6 VXLAN UDP matching pattern. */=0D
+static enum rte_flow_item_type pattern_ipv6_vxlan_udp[] =3D {=0D
+	HINIC3_FLOW_ITEM_TYPE_ETH, HINIC3_FLOW_ITEM_TYPE_IPV6,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_VXLAN,=0D
+	HINIC3_FLOW_ITEM_TYPE_UDP, HINIC3_FLOW_ITEM_TYPE_END,=0D
+};=0D
+=0D
+typedef int (*hinic3_parse_filter_t)(struct rte_eth_dev *dev,=0D
+				     const struct rte_flow_attr *attr,=0D
+				     const struct rte_flow_item pattern[],=0D
+				     const struct rte_flow_action actions[],=0D
+				     struct rte_flow_error *error,=0D
+				     struct hinic3_filter_t *filter);=0D
+=0D
+/* Indicate valid filter mode . */=0D
+struct hinic3_valid_pattern {=0D
+	enum rte_flow_item_type *items;=0D
+	hinic3_parse_filter_t parse_filter;=0D
+};=0D
+=0D
+static int hinic3_flow_parse_fdir_filter(struct rte_eth_dev *dev,=0D
+					 const struct rte_flow_attr *attr,=0D
+					 const struct rte_flow_item pattern[],=0D
+					 const struct rte_flow_action actions[],=0D
+					 struct rte_flow_error *error,=0D
+					 struct hinic3_filter_t *filter);=0D
+=0D
+static int hinic3_flow_parse_ethertype_filter(struct rte_eth_dev *dev,=0D
+					      const struct rte_flow_attr *attr,=0D
+					      const struct rte_flow_item pattern[],=0D
+					      const struct rte_flow_action actions[],=0D
+					      struct rte_flow_error *error,=0D
+					      struct hinic3_filter_t *filter);=0D
+=0D
+static int hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,=0D
+					       const struct rte_flow_attr *attr,=0D
+					       const struct rte_flow_item pattern[],=0D
+					       const struct rte_flow_action actions[],=0D
+					       struct rte_flow_error *error,=0D
+					       struct hinic3_filter_t *filter);=0D
+=0D
+/*=0D
+ * Define a supported pattern array, including the matching patterns of=0D
+ * various network protocols and corresponding parsing functions.=0D
+ */=0D
+static const struct hinic3_valid_pattern hinic3_supported_patterns[] =3D {=
=0D
+	/* Support ethertype. */=0D
+	{pattern_ethertype, hinic3_flow_parse_ethertype_filter},=0D
+	/* Support ipv4 but not tunnel, and any field can be masked. */=0D
+	{pattern_ipv4, hinic3_flow_parse_fdir_filter},=0D
+	{pattern_ipv4_any, hinic3_flow_parse_fdir_filter},=0D
+	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */=0D
+	{pattern_ipv4_udp, hinic3_flow_parse_fdir_filter},=0D
+	{pattern_ipv4_tcp, hinic3_flow_parse_fdir_filter},=0D
+	/* Support ipv4 + icmp not tunnel, and any field can be masked. */=0D
+	{pattern_ipv4_icmp, hinic3_flow_parse_fdir_filter},=0D
+=0D
+	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */=0D
+	{pattern_ethertype_udp, hinic3_flow_parse_fdir_filter},=0D
+	{pattern_ethertype_tcp, hinic3_flow_parse_fdir_filter},=0D
+=0D
+	/* Support ipv4 + vxlan + any, and any field can be masked. */=0D
+	{pattern_ipv4_vxlan, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	/* Support ipv4 + vxlan + ipv4, and any field can be masked. */=0D
+	{pattern_ipv4_vxlan_ipv4, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	/* Support ipv4 + vxlan + ipv4 + l4, and any field can be masked. */=0D
+	{pattern_ipv4_vxlan_ipv4_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	{pattern_ipv4_vxlan_ipv4_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	/* Support ipv4 + vxlan + ipv6, and any field can be masked. */=0D
+	{pattern_ipv4_vxlan_ipv6, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	/* Support ipv4 + vxlan + ipv6 + l4, and any field can be masked. */=0D
+	{pattern_ipv4_vxlan_ipv6_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	{pattern_ipv4_vxlan_ipv6_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	/* Support ipv4 + vxlan + l4, and any field can be masked. */=0D
+	{pattern_ipv4_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	{pattern_ipv4_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	{pattern_ipv4_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},=0D
+=0D
+	/* Support ipv6 but not tunnel, and any field can be masked. */=0D
+	{pattern_ipv6, hinic3_flow_parse_fdir_filter},=0D
+	/* Support ipv6 + l4 but not tunnel, and any field can be masked. */=0D
+	{pattern_ipv6_udp, hinic3_flow_parse_fdir_filter},=0D
+	{pattern_ipv6_tcp, hinic3_flow_parse_fdir_filter},=0D
+=0D
+	/* Support ipv6 + vxlan + any, and any field can be masked. */=0D
+	{pattern_ipv6_vxlan, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	{pattern_ipv6_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},=0D
+=0D
+	/* Support ipv6 + vxlan + l4, and any field can be masked. */=0D
+	{pattern_ipv6_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+	{pattern_ipv6_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
+=0D
+};=0D
+=0D
+static inline void=0D
+net_addr_to_host(uint32_t *dst, const uint32_t *src, size_t len)=0D
+{=0D
+	size_t i;=0D
+	for (i =3D 0; i < len; i++)=0D
+		dst[i] =3D rte_be_to_cpu_32(src[i]);=0D
+}=0D
+=0D
+static bool=0D
+hinic3_match_pattern(enum rte_flow_item_type *item_array,=0D
+		     const struct rte_flow_item *pattern)=0D
+{=0D
+	const struct rte_flow_item *item =3D pattern;=0D
+=0D
+	/* skip the first void item. */=0D
+	while (item->type =3D=3D HINIC3_FLOW_ITEM_TYPE_VOID)=0D
+		item++;=0D
+=0D
+	/* Find no void item. */=0D
+	while (((*item_array =3D=3D item->type) &&=0D
+		(*item_array !=3D HINIC3_FLOW_ITEM_TYPE_END)) ||=0D
+	       (item->type =3D=3D HINIC3_FLOW_ITEM_TYPE_VOID)) {=0D
+		if (item->type =3D=3D HINIC3_FLOW_ITEM_TYPE_VOID) {=0D
+			item++;=0D
+		} else {=0D
+			item_array++;=0D
+			item++;=0D
+		}=0D
+	}=0D
+=0D
+	return (*item_array =3D=3D HINIC3_FLOW_ITEM_TYPE_END &&=0D
+		item->type =3D=3D HINIC3_FLOW_ITEM_TYPE_END);=0D
+}=0D
+=0D
+/**=0D
+ * Find matching parsing filter functions.=0D
+ *=0D
+ * @param[in] pattern=0D
+ * Pattern to match.=0D
+ * @return=0D
+ * Matched resolution filter. If no resolution filter is found, return NUL=
L.=0D
+ */=0D
+static hinic3_parse_filter_t=0D
+hinic3_find_parse_filter_func(const struct rte_flow_item *pattern)=0D
+{=0D
+	hinic3_parse_filter_t parse_filter =3D NULL;=0D
+	uint8_t i;=0D
+	/* Traverse all supported patterns. */=0D
+	for (i =3D 0; i < RTE_DIM(hinic3_supported_patterns); i++) {=0D
+		if (hinic3_match_pattern(hinic3_supported_patterns[i].items,=0D
+					 pattern)) {=0D
+			parse_filter =3D=0D
+				hinic3_supported_patterns[i].parse_filter;=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	return parse_filter;=0D
+}=0D
+=0D
+/**=0D
+ * Action for parsing and processing Ethernet types.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @param[out] filter=0D
+ * Filter information, its used to store and manipulate packet filtering r=
ules.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_parse_action(struct rte_eth_dev *dev,=0D
+			 const struct rte_flow_action *actions,=0D
+			 struct rte_flow_error *error,=0D
+			 struct hinic3_filter_t *filter)=0D
+{=0D
+	const struct rte_flow_action_queue *act_q;=0D
+	const struct rte_flow_action *act =3D actions;=0D
+=0D
+	/* skip the first void item. */=0D
+	while (act->type =3D=3D RTE_FLOW_ACTION_TYPE_VOID)=0D
+		act++;=0D
+=0D
+	switch (act->type) {=0D
+	case RTE_FLOW_ACTION_TYPE_QUEUE:=0D
+		act_q =3D (const struct rte_flow_action_queue *)act->conf;=0D
+		filter->fdir_filter.rq_index =3D act_q->index;=0D
+		if (filter->fdir_filter.rq_index >=3D dev->data->nb_rx_queues) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ACTION, act,=0D
+					   "Invalid action param.");=0D
+			return -rte_errno;=0D
+		}=0D
+		break;=0D
+	default:=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ACTION,=0D
+				   act, "Invalid action type.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_flow_parse_attr(const struct rte_flow_attr *attr,=0D
+		       struct rte_flow_error *error)=0D
+{=0D
+	/* Not supported. */=0D
+	if (!attr->ingress || attr->egress || attr->priority || attr->group) {=0D
+		rte_flow_error_set(error, EINVAL,=0D
+				   HINIC3_FLOW_ERROR_TYPE_UNSPECIFIED, attr,=0D
+				   "Only support ingress.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_item,=0D
+		      struct hinic3_filter_t *filter,=0D
+		      struct rte_flow_error *error)=0D
+{=0D
+	const struct rte_flow_item_ipv4 *spec_ipv4, *mask_ipv4;=0D
+=0D
+	mask_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->mask;=0D
+	spec_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->spec;=0D
+	if (!mask_ipv4 || !spec_ipv4) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter ipv4 mask or spec");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/*=0D
+	 * Only support src address , dst addresses, proto,=0D
+	 * others should be masked.=0D
+	 */=0D
+	if (mask_ipv4->hdr.version_ihl || mask_ipv4->hdr.type_of_service ||=0D
+	    mask_ipv4->hdr.total_length || mask_ipv4->hdr.packet_id ||=0D
+	    mask_ipv4->hdr.fragment_offset || mask_ipv4->hdr.time_to_live ||=0D
+	    mask_ipv4->hdr.hdr_checksum) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Not supported by fdir filter, ipv4 only "=0D
+				   "support src ip, dst ip, proto");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Set the filter information. */=0D
+	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+	filter->fdir_filter.key_mask.ipv4.src_ip =3D=0D
+		rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);=0D
+	filter->fdir_filter.key_spec.ipv4.src_ip =3D=0D
+		rte_be_to_cpu_32(spec_ipv4->hdr.src_addr);=0D
+	filter->fdir_filter.key_mask.ipv4.dst_ip =3D=0D
+		rte_be_to_cpu_32(mask_ipv4->hdr.dst_addr);=0D
+	filter->fdir_filter.key_spec.ipv4.dst_ip =3D=0D
+		rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);=0D
+	filter->fdir_filter.key_mask.proto =3D mask_ipv4->hdr.next_proto_id;=0D
+	filter->fdir_filter.key_spec.proto =3D spec_ipv4->hdr.next_proto_id;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_ipv6(const struct rte_flow_item *flow_item,=0D
+		      struct hinic3_filter_t *filter,=0D
+		      struct rte_flow_error *error)=0D
+{=0D
+	const struct rte_flow_item_ipv6 *spec_ipv6, *mask_ipv6;=0D
+=0D
+	mask_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->mask;=0D
+	spec_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->spec;=0D
+	if (!mask_ipv6 || !spec_ipv6) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter ipv6 mask or spec");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Only support dst addresses, src addresses, proto. */=0D
+	if (mask_ipv6->hdr.vtc_flow || mask_ipv6->hdr.payload_len ||=0D
+	    mask_ipv6->hdr.hop_limits) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Not supported by fdir filter, ipv6 only "=0D
+				   "support src ip, dst ip, proto");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Set the filter information. */=0D
+	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+	net_addr_to_host(filter->fdir_filter.key_mask.ipv6.src_ip,=0D
+			 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);=0D
+	net_addr_to_host(filter->fdir_filter.key_spec.ipv6.src_ip,=0D
+			 (const uint32_t *)spec_ipv6->hdr.src_addr.a, 4);=0D
+	net_addr_to_host(filter->fdir_filter.key_mask.ipv6.dst_ip,=0D
+			 (const uint32_t *)mask_ipv6->hdr.dst_addr.a, 4);=0D
+	net_addr_to_host(filter->fdir_filter.key_spec.ipv6.dst_ip,=0D
+			 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);=0D
+	filter->fdir_filter.key_mask.proto =3D mask_ipv6->hdr.proto;=0D
+	filter->fdir_filter.key_spec.proto =3D spec_ipv6->hdr.proto;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_tcp(const struct rte_flow_item *flow_item,=0D
+		     struct hinic3_filter_t *filter,=0D
+		     struct rte_flow_error *error)=0D
+{=0D
+	const struct rte_flow_item_tcp *spec_tcp, *mask_tcp;=0D
+=0D
+	mask_tcp =3D (const struct rte_flow_item_tcp *)flow_item->mask;=0D
+	spec_tcp =3D (const struct rte_flow_item_tcp *)flow_item->spec;=0D
+=0D
+	filter->fdir_filter.key_mask.proto =3D HINIC3_UINT8_MAX;=0D
+	filter->fdir_filter.key_spec.proto =3D IPPROTO_TCP;=0D
+=0D
+	if (!mask_tcp && !spec_tcp)=0D
+		return 0;=0D
+=0D
+	if (!mask_tcp || !spec_tcp) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter tcp mask or spec");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Only support src, dst ports, others should be masked. */=0D
+	if (mask_tcp->hdr.sent_seq || mask_tcp->hdr.recv_ack ||=0D
+	    mask_tcp->hdr.data_off || mask_tcp->hdr.rx_win ||=0D
+	    mask_tcp->hdr.tcp_flags || mask_tcp->hdr.cksum ||=0D
+	    mask_tcp->hdr.tcp_urp) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Not supported by fdir filter, tcp only "=0D
+				   "support src port, dst port");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Set the filter information. */=0D
+	filter->fdir_filter.key_mask.src_port =3D=0D
+		(u16)rte_be_to_cpu_16(mask_tcp->hdr.src_port);=0D
+	filter->fdir_filter.key_spec.src_port =3D=0D
+		(u16)rte_be_to_cpu_16(spec_tcp->hdr.src_port);=0D
+	filter->fdir_filter.key_mask.dst_port =3D=0D
+		(u16)rte_be_to_cpu_16(mask_tcp->hdr.dst_port);=0D
+	filter->fdir_filter.key_spec.dst_port =3D=0D
+		(u16)rte_be_to_cpu_16(spec_tcp->hdr.dst_port);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_udp(const struct rte_flow_item *flow_item,=0D
+		     struct hinic3_filter_t *filter,=0D
+		     struct rte_flow_error *error)=0D
+{=0D
+	const struct rte_flow_item_udp *spec_udp, *mask_udp;=0D
+=0D
+	mask_udp =3D (const struct rte_flow_item_udp *)flow_item->mask;=0D
+	spec_udp =3D (const struct rte_flow_item_udp *)flow_item->spec;=0D
+=0D
+	filter->fdir_filter.key_mask.proto =3D HINIC3_UINT8_MAX;=0D
+	filter->fdir_filter.key_spec.proto =3D IPPROTO_UDP;=0D
+=0D
+	if (!mask_udp && !spec_udp)=0D
+		return 0;=0D
+=0D
+	if (!mask_udp || !spec_udp) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter udp mask or spec");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Set the filter information. */=0D
+	filter->fdir_filter.key_mask.src_port =3D=0D
+		(u16)rte_be_to_cpu_16(mask_udp->hdr.src_port);=0D
+	filter->fdir_filter.key_spec.src_port =3D=0D
+		(u16)rte_be_to_cpu_16(spec_udp->hdr.src_port);=0D
+	filter->fdir_filter.key_mask.dst_port =3D=0D
+		(u16)rte_be_to_cpu_16(mask_udp->hdr.dst_port);=0D
+	filter->fdir_filter.key_spec.dst_port =3D=0D
+		(u16)rte_be_to_cpu_16(spec_udp->hdr.dst_port);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Parse the pattern of network traffic and apply the parsing result to th=
e=0D
+ * traffic filter.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] pattern=0D
+ * Indicates the pattern or matching condition of a traffic rule.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @param[out] filter=0D
+ * Filter information, Its used to store and manipulate packet filtering r=
ules.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_parse_fdir_pattern(__rte_unused struct rte_eth_dev *dev,=0D
+			       const struct rte_flow_item *pattern,=0D
+			       struct rte_flow_error *error,=0D
+			       struct hinic3_filter_t *filter)=0D
+{=0D
+	const struct rte_flow_item *flow_item =3D pattern;=0D
+	enum rte_flow_item_type type;=0D
+	int err;=0D
+=0D
+	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_ANY;=0D
+	/* Traverse all modes until HINIC3_FLOW_ITEM_TYPE_END is reached. */=0D
+	for (; flow_item->type !=3D HINIC3_FLOW_ITEM_TYPE_END; flow_item++) {=0D
+		if (flow_item->last) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item, "Not support range");=0D
+			return -rte_errno;=0D
+		}=0D
+		type =3D flow_item->type;=0D
+		switch (type) {=0D
+		case HINIC3_FLOW_ITEM_TYPE_ETH:=0D
+			if (flow_item->spec || flow_item->mask) {=0D
+				rte_flow_error_set(error, EINVAL,=0D
+						   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+						   flow_item,=0D
+						   "Not supported by fdir "=0D
+						   "filter, not support mac");=0D
+				return -rte_errno;=0D
+			}=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_IPV4:=0D
+			err =3D hinic3_flow_fdir_ipv4(flow_item, filter, error);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_IPV6:=0D
+			err =3D hinic3_flow_fdir_ipv6(flow_item, filter, error);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_TCP:=0D
+			err =3D hinic3_flow_fdir_tcp(flow_item, filter, error);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_UDP:=0D
+			err =3D hinic3_flow_fdir_udp(flow_item, filter, error);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		default:=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Resolve rules for network traffic filters.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] attr=0D
+ * Indicates the attribute of a flow rule.=0D
+ * @param[in] pattern=0D
+ * Indicates the pattern or matching condition of a traffic rule.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @param[out] filter=0D
+ * Filter information, Its used to store and manipulate packet filtering r=
ules.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_parse_fdir_filter(struct rte_eth_dev *dev,=0D
+			      const struct rte_flow_attr *attr,=0D
+			      const struct rte_flow_item pattern[],=0D
+			      const struct rte_flow_action actions[],=0D
+			      struct rte_flow_error *error,=0D
+			      struct hinic3_filter_t *filter)=0D
+{=0D
+	int ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_fdir_pattern(dev, pattern, error, filter);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_action(dev, actions, error, filter);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_attr(attr, error);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	filter->filter_type =3D RTE_ETH_FILTER_FDIR;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Parse and process the actions of the Ethernet type.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @param[out] filter=0D
+ * Filter information, Its used to store and manipulate packet filtering r=
ules.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_parse_ethertype_action(struct rte_eth_dev *dev,=0D
+				   const struct rte_flow_action *actions,=0D
+				   struct rte_flow_error *error,=0D
+				   struct hinic3_filter_t *filter)=0D
+{=0D
+	const struct rte_flow_action *act =3D actions;=0D
+	const struct rte_flow_action_queue *act_q;=0D
+=0D
+	/* Skip the firset void item. */=0D
+	while (act->type =3D=3D RTE_FLOW_ACTION_TYPE_VOID)=0D
+		act++;=0D
+=0D
+	switch (act->type) {=0D
+	case RTE_FLOW_ACTION_TYPE_QUEUE:=0D
+		act_q =3D (const struct rte_flow_action_queue *)act->conf;=0D
+		filter->ethertype_filter.queue =3D act_q->index;=0D
+		if (filter->ethertype_filter.queue >=3D dev->data->nb_rx_queues) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ACTION, act,=0D
+					   "Invalid action param.");=0D
+			return -rte_errno;=0D
+		}=0D
+		break;=0D
+=0D
+	default:=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ACTION,=0D
+				   act, "Invalid action type.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_parse_ethertype_pattern(__rte_unused struct rte_eth_dev *dev,=
=0D
+				    const struct rte_flow_item *pattern,=0D
+				    struct rte_flow_error *error,=0D
+				    struct hinic3_filter_t *filter)=0D
+{=0D
+	const struct rte_flow_item_eth *ether_spec, *ether_mask;=0D
+	const struct rte_flow_item *flow_item =3D pattern;=0D
+	enum rte_flow_item_type type;=0D
+=0D
+	/* Traverse all modes until HINIC3_FLOW_ITEM_TYPE_END is reached. */=0D
+	for (; flow_item->type !=3D HINIC3_FLOW_ITEM_TYPE_END; flow_item++) {=0D
+		if (flow_item->last) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item, "Not support range");=0D
+			return -rte_errno;=0D
+		}=0D
+		type =3D flow_item->type;=0D
+		switch (type) {=0D
+		case HINIC3_FLOW_ITEM_TYPE_ETH:=0D
+			/* Obtaining Ethernet Specifications and Masks. */=0D
+			ether_spec =3D (const struct rte_flow_item_eth *)=0D
+					     flow_item->spec;=0D
+			ether_mask =3D (const struct rte_flow_item_eth *)=0D
+					     flow_item->mask;=0D
+			if (!ether_spec || !ether_mask) {=0D
+				rte_flow_error_set(error, EINVAL,=0D
+						   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+						   flow_item,=0D
+						   "NULL ETH spec/mask");=0D
+				return -rte_errno;=0D
+			}=0D
+=0D
+			/*=0D
+			 * Mask bits of source MAC address must be full of 0.=0D
+			 * Mask bits of destination MAC address must be full 0.=0D
+			 * Filters traffic based on the type of Ethernet.=0D
+			 */=0D
+			if (!rte_is_zero_ether_addr(&ether_mask->src) ||=0D
+			    (!rte_is_zero_ether_addr(&ether_mask->dst))) {=0D
+				rte_flow_error_set(error, EINVAL,=0D
+						   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+						   flow_item,=0D
+						   "Invalid ether address mask");=0D
+				return -rte_errno;=0D
+			}=0D
+=0D
+			if ((ether_mask->type & UINT16_MAX) !=3D UINT16_MAX) {=0D
+				rte_flow_error_set(error, EINVAL,=0D
+						   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+						   flow_item,=0D
+						   "Invalid ethertype mask");=0D
+				return -rte_errno;=0D
+			}=0D
+=0D
+			filter->ethertype_filter.ether_type =3D=0D
+				(u16)rte_be_to_cpu_16(ether_spec->type);=0D
+=0D
+			switch (filter->ethertype_filter.ether_type) {=0D
+			case RTE_ETHER_TYPE_SLOW:=0D
+				break;=0D
+=0D
+			case RTE_ETHER_TYPE_ARP:=0D
+				break;=0D
+=0D
+			case RTE_ETHER_TYPE_RARP:=0D
+				break;=0D
+=0D
+			case RTE_ETHER_TYPE_LLDP:=0D
+				break;=0D
+=0D
+			default:=0D
+				rte_flow_error_set(error, EINVAL,=0D
+						   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+						   flow_item,=0D
+						   "Unsupported ether_type in"=0D
+						   " control packet filter.");=0D
+				return -rte_errno;=0D
+			}=0D
+			break;=0D
+=0D
+		default:=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_parse_ethertype_filter(struct rte_eth_dev *dev,=0D
+				   const struct rte_flow_attr *attr,=0D
+				   const struct rte_flow_item pattern[],=0D
+				   const struct rte_flow_action actions[],=0D
+				   struct rte_flow_error *error,=0D
+				   struct hinic3_filter_t *filter)=0D
+{=0D
+	int ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_ethertype_pattern(dev, pattern, error, filter);=
=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_ethertype_action(dev, actions, error, filter);=
=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_attr(attr, error);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	filter->filter_type =3D RTE_ETH_FILTER_ETHERTYPE;=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,=0D
+			     struct hinic3_filter_t *filter,=0D
+			     const struct rte_flow_item *flow_item,=0D
+			     enum hinic3_fdir_tunnel_mode tunnel_mode)=0D
+{=0D
+	const struct rte_flow_item_ipv4 *spec_ipv4, *mask_ipv4;=0D
+	mask_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->mask;=0D
+	spec_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->spec;=0D
+=0D
+	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+		filter->fdir_filter.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+		if (!mask_ipv4 && !spec_ipv4)=0D
+			return 0;=0D
+=0D
+		if (!mask_ipv4 || !spec_ipv4) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item,=0D
+					   "Invalid fdir filter, vxlan outer "=0D
+					   "ipv4 mask or spec");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/*=0D
+		 * Only support src address , dst addresses, others should be=0D
+		 * masked.=0D
+		 */=0D
+		if (mask_ipv4->hdr.version_ihl ||=0D
+		    mask_ipv4->hdr.type_of_service ||=0D
+		    mask_ipv4->hdr.total_length || mask_ipv4->hdr.packet_id ||=0D
+		    mask_ipv4->hdr.fragment_offset ||=0D
+		    mask_ipv4->hdr.time_to_live ||=0D
+		    mask_ipv4->hdr.next_proto_id ||=0D
+		    mask_ipv4->hdr.hdr_checksum) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item,=0D
+					   "Not supported by fdir filter, "=0D
+					   "vxlan outer ipv4 only support "=0D
+					   "src ip, dst ip");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/* Set the filter information. */=0D
+		filter->fdir_filter.key_mask.ipv4.src_ip =3D=0D
+			rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);=0D
+		filter->fdir_filter.key_spec.ipv4.src_ip =3D=0D
+			rte_be_to_cpu_32(spec_ipv4->hdr.src_addr);=0D
+		filter->fdir_filter.key_mask.ipv4.dst_ip =3D=0D
+			rte_be_to_cpu_32(mask_ipv4->hdr.dst_addr);=0D
+		filter->fdir_filter.key_spec.ipv4.dst_ip =3D=0D
+			rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);=0D
+	} else {=0D
+		filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+=0D
+		if (!mask_ipv4 && !spec_ipv4)=0D
+			return 0;=0D
+=0D
+		if (!mask_ipv4 || !spec_ipv4) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item,=0D
+					   "Invalid fdir filter, vxlan inner "=0D
+					   "ipv4 mask or spec");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/*=0D
+		 * Only support src addr , dst addr, ip proto, others should be=0D
+		 * masked.=0D
+		 */=0D
+		if (mask_ipv4->hdr.version_ihl ||=0D
+		    mask_ipv4->hdr.type_of_service ||=0D
+		    mask_ipv4->hdr.total_length || mask_ipv4->hdr.packet_id ||=0D
+		    mask_ipv4->hdr.fragment_offset ||=0D
+		    mask_ipv4->hdr.time_to_live ||=0D
+		    mask_ipv4->hdr.hdr_checksum) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item,=0D
+					   "Not supported by fdir filter, "=0D
+					   "vxlan inner ipv4 only support "=0D
+					   "src ip, dst ip, proto");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/* Set the filter information. */=0D
+		filter->fdir_filter.key_mask.inner_ipv4.src_ip =3D=0D
+			rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);=0D
+		filter->fdir_filter.key_spec.inner_ipv4.src_ip =3D=0D
+			rte_be_to_cpu_32(spec_ipv4->hdr.src_addr);=0D
+		filter->fdir_filter.key_mask.inner_ipv4.dst_ip =3D=0D
+			rte_be_to_cpu_32(mask_ipv4->hdr.dst_addr);=0D
+		filter->fdir_filter.key_spec.inner_ipv4.dst_ip =3D=0D
+			rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);=0D
+		filter->fdir_filter.key_mask.proto =3D=0D
+			mask_ipv4->hdr.next_proto_id;=0D
+		filter->fdir_filter.key_spec.proto =3D=0D
+			spec_ipv4->hdr.next_proto_id;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_tunnel_ipv6(struct rte_flow_error *error,=0D
+			     struct hinic3_filter_t *filter,=0D
+			     const struct rte_flow_item *flow_item,=0D
+			     enum hinic3_fdir_tunnel_mode tunnel_mode)=0D
+{=0D
+	const struct rte_flow_item_ipv6 *spec_ipv6, *mask_ipv6;=0D
+=0D
+	mask_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->mask;=0D
+	spec_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->spec;=0D
+=0D
+	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+		filter->fdir_filter.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+		if (!mask_ipv6 && !spec_ipv6)=0D
+			return 0;=0D
+=0D
+		if (!mask_ipv6 || !spec_ipv6) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+				HINIC3_FLOW_ERROR_TYPE_ITEM, flow_item,=0D
+				"Invalid fdir filter ipv6 mask or spec");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/* Only support dst addresses, src addresses. */=0D
+		if (mask_ipv6->hdr.vtc_flow || mask_ipv6->hdr.payload_len ||=0D
+		    mask_ipv6->hdr.hop_limits || mask_ipv6->hdr.proto) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+				HINIC3_FLOW_ERROR_TYPE_ITEM, flow_item,=0D
+				"Not supported by fdir filter, ipv6 only "=0D
+				"support src ip, dst ip, proto");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		net_addr_to_host(filter->fdir_filter.key_mask.ipv6.src_ip,=0D
+				 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);=0D
+		net_addr_to_host(filter->fdir_filter.key_spec.ipv6.src_ip,=0D
+				 (const uint32_t *)spec_ipv6->hdr.src_addr.a, 4);=0D
+		net_addr_to_host(filter->fdir_filter.key_mask.ipv6.dst_ip,=0D
+				 (const uint32_t *)mask_ipv6->hdr.dst_addr.a, 4);=0D
+		net_addr_to_host(filter->fdir_filter.key_spec.ipv6.dst_ip,=0D
+				 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);=0D
+	} else {=0D
+		filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+=0D
+		if (!mask_ipv6 && !spec_ipv6)=0D
+			return 0;=0D
+=0D
+		if (!mask_ipv6 || !spec_ipv6) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+				HINIC3_FLOW_ERROR_TYPE_ITEM, flow_item,=0D
+				"Invalid fdir filter ipv6 mask or spec");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/* Only support dst addresses, src addresses, proto. */=0D
+		if (mask_ipv6->hdr.vtc_flow || mask_ipv6->hdr.payload_len ||=0D
+		    mask_ipv6->hdr.hop_limits) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+				HINIC3_FLOW_ERROR_TYPE_ITEM, flow_item,=0D
+				"Not supported by fdir filter, ipv6 only "=0D
+				"support src ip, dst ip, proto");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		net_addr_to_host(filter->fdir_filter.key_mask.inner_ipv6.src_ip,=0D
+				 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);=0D
+		net_addr_to_host(filter->fdir_filter.key_spec.inner_ipv6.src_ip,=0D
+				 (const uint32_t *)spec_ipv6->hdr.src_addr.a, 4);=0D
+		net_addr_to_host(filter->fdir_filter.key_mask.inner_ipv6.dst_ip,=0D
+				 (const uint32_t *)mask_ipv6->hdr.dst_addr.a, 4);=0D
+		net_addr_to_host(filter->fdir_filter.key_spec.inner_ipv6.dst_ip,=0D
+				 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);=0D
+=0D
+		filter->fdir_filter.key_mask.proto =3D mask_ipv6->hdr.proto;=0D
+		filter->fdir_filter.key_spec.proto =3D spec_ipv6->hdr.proto;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_tunnel_tcp(struct rte_flow_error *error,=0D
+			    struct hinic3_filter_t *filter,=0D
+			    enum hinic3_fdir_tunnel_mode tunnel_mode,=0D
+			    const struct rte_flow_item *flow_item)=0D
+{=0D
+	const struct rte_flow_item_tcp *spec_tcp, *mask_tcp;=0D
+=0D
+	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Not supported by fdir filter, vxlan only "=0D
+				   "support inner tcp");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	filter->fdir_filter.key_mask.proto =3D HINIC3_UINT8_MAX;=0D
+	filter->fdir_filter.key_spec.proto =3D IPPROTO_TCP;=0D
+=0D
+	mask_tcp =3D (const struct rte_flow_item_tcp *)flow_item->mask;=0D
+	spec_tcp =3D (const struct rte_flow_item_tcp *)flow_item->spec;=0D
+	if (!mask_tcp && !spec_tcp)=0D
+		return 0;=0D
+	if (!mask_tcp || !spec_tcp) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter tcp mask or spec");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Only support src, dst ports, others should be masked. */=0D
+	if (mask_tcp->hdr.sent_seq || mask_tcp->hdr.recv_ack ||=0D
+	    mask_tcp->hdr.data_off || mask_tcp->hdr.rx_win ||=0D
+	    mask_tcp->hdr.tcp_flags || mask_tcp->hdr.cksum ||=0D
+	    mask_tcp->hdr.tcp_urp) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Not supported by fdir filter, vxlan inner "=0D
+				   "tcp only support src port,dst port");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	/* Set the filter information. */=0D
+	filter->fdir_filter.key_mask.src_port =3D=0D
+		(u16)rte_be_to_cpu_16(mask_tcp->hdr.src_port);=0D
+	filter->fdir_filter.key_spec.src_port =3D=0D
+		(u16)rte_be_to_cpu_16(spec_tcp->hdr.src_port);=0D
+	filter->fdir_filter.key_mask.dst_port =3D=0D
+		(u16)rte_be_to_cpu_16(mask_tcp->hdr.dst_port);=0D
+	filter->fdir_filter.key_spec.dst_port =3D=0D
+		(u16)rte_be_to_cpu_16(spec_tcp->hdr.dst_port);=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *error,=0D
+			    struct hinic3_filter_t *filter,=0D
+			    enum hinic3_fdir_tunnel_mode tunnel_mode,=0D
+			    const struct rte_flow_item *flow_item)=0D
+{=0D
+	const struct rte_flow_item_udp *spec_udp, *mask_udp;=0D
+=0D
+	mask_udp =3D (const struct rte_flow_item_udp *)flow_item->mask;=0D
+	spec_udp =3D (const struct rte_flow_item_udp *)flow_item->spec;=0D
+=0D
+	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+		/*=0D
+		 * UDP is used to describe protocol,=0D
+		 * spec and mask should be NULL.=0D
+		 */=0D
+		if (flow_item->spec || flow_item->mask) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item, "Invalid UDP item");=0D
+			return -rte_errno;=0D
+		}=0D
+	} else {=0D
+		filter->fdir_filter.key_mask.proto =3D HINIC3_UINT8_MAX;=0D
+		filter->fdir_filter.key_spec.proto =3D IPPROTO_UDP;=0D
+		if (!mask_udp && !spec_udp)=0D
+			return 0;=0D
+=0D
+		if (!mask_udp || !spec_udp) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item,=0D
+					   "Invalid fdir filter vxlan inner "=0D
+					   "udp mask or spec");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		/* Set the filter information. */=0D
+		filter->fdir_filter.key_mask.src_port =3D=0D
+			(u16)rte_be_to_cpu_16(mask_udp->hdr.src_port);=0D
+		filter->fdir_filter.key_spec.src_port =3D=0D
+			(u16)rte_be_to_cpu_16(spec_udp->hdr.src_port);=0D
+		filter->fdir_filter.key_mask.dst_port =3D=0D
+			(u16)rte_be_to_cpu_16(mask_udp->hdr.dst_port);=0D
+		filter->fdir_filter.key_spec.dst_port =3D=0D
+			(u16)rte_be_to_cpu_16(spec_udp->hdr.dst_port);=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_fdir_vxlan(struct rte_flow_error *error,=0D
+		       struct hinic3_filter_t *filter,=0D
+		       const struct rte_flow_item *flow_item)=0D
+{=0D
+	const struct rte_flow_item_vxlan *spec_vxlan, *mask_vxlan;=0D
+	uint32_t vxlan_vni_id =3D 0;=0D
+=0D
+	spec_vxlan =3D (const struct rte_flow_item_vxlan *)flow_item->spec;=0D
+	mask_vxlan =3D (const struct rte_flow_item_vxlan *)flow_item->mask;=0D
+=0D
+	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+=0D
+	if (!spec_vxlan && !mask_vxlan) {=0D
+		return 0;=0D
+	} else if (filter->fdir_filter.outer_ip_type =3D=3D HINIC3_FDIR_IP_TYPE_I=
PV6) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter vxlan mask or spec, "=0D
+				   "ipv6 vxlan, don't support vni");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	if (!spec_vxlan || !mask_vxlan) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   flow_item,=0D
+				   "Invalid fdir filter vxlan mask or spec");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	rte_memcpy(((uint8_t *)&vxlan_vni_id + 1), spec_vxlan->vni, 3);=0D
+	filter->fdir_filter.key_mask.tunnel.tunnel_id =3D=0D
+		rte_be_to_cpu_32(vxlan_vni_id);=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,=
=0D
+				     const struct rte_flow_item *pattern,=0D
+				     struct rte_flow_error *error,=0D
+				     struct hinic3_filter_t *filter)=0D
+{=0D
+	const struct rte_flow_item *flow_item =3D pattern;=0D
+	enum hinic3_fdir_tunnel_mode tunnel_mode =3D=0D
+		HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+	enum rte_flow_item_type type;=0D
+	int err;=0D
+=0D
+	/* Inner and outer ip type, set it to any by default */=0D
+	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_ANY;=0D
+	filter->fdir_filter.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_ANY;=0D
+=0D
+	for (; flow_item->type !=3D HINIC3_FLOW_ITEM_TYPE_END; flow_item++) {=0D
+		if (flow_item->last) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+					   flow_item, "Not support range");=0D
+			return -rte_errno;=0D
+		}=0D
+=0D
+		type =3D flow_item->type;=0D
+		switch (type) {=0D
+		case HINIC3_FLOW_ITEM_TYPE_ETH:=0D
+			/* All should be masked. */=0D
+			if (flow_item->spec || flow_item->mask) {=0D
+				rte_flow_error_set(error, EINVAL,=0D
+						   HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+						   flow_item,=0D
+						   "Not supported by fdir "=0D
+						   "filter, not support mac");=0D
+				return -rte_errno;=0D
+			}=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_IPV4:=0D
+			err =3D hinic3_flow_fdir_tunnel_ipv4(error,=0D
+				filter, flow_item, tunnel_mode);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_IPV6:=0D
+			err =3D hinic3_flow_fdir_tunnel_ipv6(error,=0D
+				filter, flow_item, tunnel_mode);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_TCP:=0D
+			err =3D hinic3_flow_fdir_tunnel_tcp(error,=0D
+				filter, tunnel_mode, flow_item);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_UDP:=0D
+			err =3D hinic3_flow_fdir_tunnel_udp(error,=0D
+				filter, tunnel_mode, flow_item);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			break;=0D
+=0D
+		case HINIC3_FLOW_ITEM_TYPE_VXLAN:=0D
+			err =3D hinic3_flow_fdir_vxlan(error, filter, flow_item);=0D
+			if (err !=3D 0)=0D
+				return -rte_errno;=0D
+			tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+			break;=0D
+=0D
+		default:=0D
+			break;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Resolve VXLAN Filters in Flow Filters.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] attr=0D
+ * Indicates the attribute of a flow rule.=0D
+ * @param[in] pattern=0D
+ * Indicates the pattern or matching condition of a traffic rule.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @param[out] filter=0D
+ * Filter information, its used to store and manipulate packet filtering r=
ules.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,=0D
+				    const struct rte_flow_attr *attr,=0D
+				    const struct rte_flow_item pattern[],=0D
+				    const struct rte_flow_action actions[],=0D
+				    struct rte_flow_error *error,=0D
+				    struct hinic3_filter_t *filter)=0D
+{=0D
+	int ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_fdir_vxlan_pattern(dev, pattern, error, filter)=
;=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_action(dev, actions, error, filter);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D hinic3_flow_parse_attr(attr, error);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	filter->filter_type =3D RTE_ETH_FILTER_FDIR;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Parse patterns and actions of network traffic.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] attr=0D
+ * Indicates the attribute of a flow rule.=0D
+ * @param[in] pattern=0D
+ * Indicates the pattern or matching condition of a traffic rule.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @param[out] filter=0D
+ * Filter information, its used to store and manipulate packet filtering r=
ules.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_parse(struct rte_eth_dev *dev, const struct rte_flow_attr *att=
r,=0D
+		  const struct rte_flow_item pattern[],=0D
+		  const struct rte_flow_action actions[],=0D
+		  struct rte_flow_error *error, struct hinic3_filter_t *filter)=0D
+{=0D
+	hinic3_parse_filter_t parse_filter;=0D
+	uint32_t pattern_num =3D 0;=0D
+	int ret =3D 0;=0D
+	/* Check whether the parameter is valid. */=0D
+	if (!pattern || !actions || !attr) {=0D
+		rte_flow_error_set(error, EINVAL,=0D
+				   HINIC3_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,=0D
+				   "NULL param.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	while ((pattern + pattern_num)->type !=3D HINIC3_FLOW_ITEM_TYPE_END) {=0D
+		pattern_num++;=0D
+		if (pattern_num > HINIC3_FLOW_MAX_PATTERN_NUM) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_MAX_PATTERN_NUM, NULL,=0D
+					   "Too many patterns.");=0D
+			return -rte_errno;=0D
+		}=0D
+	}=0D
+	/*=0D
+	 * The corresponding filter is returned. If the filter is not found,=0D
+	 * NULL is returned.=0D
+	 */=0D
+	parse_filter =3D hinic3_find_parse_filter_func(pattern);=0D
+	if (!parse_filter) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_ITEM,=0D
+				   pattern, "Unsupported pattern");=0D
+		return -rte_errno;=0D
+	}=0D
+	/* Parsing with filters. */=0D
+	ret =3D parse_filter(dev, attr, pattern, actions, error, filter);=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ * Check whether the traffic rule provided by the user is valid.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] attr=0D
+ * Indicates the attribute of a flow rule.=0D
+ * @param[in] pattern=0D
+ * Indicates the pattern or matching condition of a traffic rule.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *=
attr,=0D
+		     const struct rte_flow_item pattern[],=0D
+		     const struct rte_flow_action actions[],=0D
+		     struct rte_flow_error *error)=0D
+{=0D
+	struct hinic3_filter_t filter_rules =3D {0};=0D
+=0D
+	return hinic3_flow_parse(dev, attr, pattern, actions, error,=0D
+				 &filter_rules);=0D
+}=0D
+=0D
+/**=0D
+ * Create a flow item.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] attr=0D
+ * Indicates the attribute of a flow rule.=0D
+ * @param[in] pattern=0D
+ * Indicates the pattern or matching condition of a traffic rule.=0D
+ * @param[in] actions=0D
+ * Indicates the action to be taken on the matched traffic.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @return=0D
+ * If the operation is successful, the created flow is returned. Otherwise=
, NULL=0D
+ * is returned.=0D
+ *=0D
+ */=0D
+static struct rte_flow *=0D
+hinic3_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *at=
tr,=0D
+		   const struct rte_flow_item pattern[],=0D
+		   const struct rte_flow_action actions[],=0D
+		   struct rte_flow_error *error)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_filter_t *filter_rules =3D NULL;=0D
+	struct rte_flow *flow =3D NULL;=0D
+	int ret;=0D
+=0D
+	filter_rules =3D=0D
+		rte_zmalloc("filter_rules", sizeof(struct hinic3_filter_t), 0);=0D
+	if (!filter_rules) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_HANDLE,=0D
+				   NULL,=0D
+				   "Failed to allocate filter rules memory.");=0D
+		return NULL;=0D
+	}=0D
+=0D
+	flow =3D rte_zmalloc("hinic3_rte_flow", sizeof(struct rte_flow), 0);=0D
+	if (!flow) {=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_HANDLE,=0D
+				   NULL, "Failed to allocate flow memory.");=0D
+		rte_free(filter_rules);=0D
+		return NULL;=0D
+	}=0D
+	/* Parses the flow rule to be created and generates a filter. */=0D
+	ret =3D hinic3_flow_parse(dev, attr, pattern, actions, error,=0D
+				filter_rules);=0D
+	if (ret < 0)=0D
+		goto free_flow;=0D
+=0D
+	switch (filter_rules->filter_type) {=0D
+	case RTE_ETH_FILTER_ETHERTYPE:=0D
+		ret =3D hinic3_flow_add_del_ethertype_filter(dev,=0D
+			&filter_rules->ethertype_filter, true);=0D
+		if (ret) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_HANDLE, NULL,=0D
+					   "Create ethertype filter failed.");=0D
+			goto free_flow;=0D
+		}=0D
+=0D
+		flow->rule =3D filter_rules;=0D
+		flow->filter_type =3D filter_rules->filter_type;=0D
+		TAILQ_INSERT_TAIL(&nic_dev->filter_ethertype_list, flow, node);=0D
+		break;=0D
+=0D
+	case RTE_ETH_FILTER_FDIR:=0D
+		ret =3D hinic3_flow_add_del_fdir_filter(dev,=0D
+			&filter_rules->fdir_filter, true);=0D
+		if (ret) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   HINIC3_FLOW_ERROR_TYPE_HANDLE, NULL,=0D
+					   "Create fdir filter failed.");=0D
+			goto free_flow;=0D
+		}=0D
+=0D
+		flow->rule =3D filter_rules;=0D
+		flow->filter_type =3D filter_rules->filter_type;=0D
+		TAILQ_INSERT_TAIL(&nic_dev->filter_fdir_rule_list, flow, node);=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "Filter type %d not supported",=0D
+			    filter_rules->filter_type);=0D
+		rte_flow_error_set(error, EINVAL, HINIC3_FLOW_ERROR_TYPE_HANDLE,=0D
+				   NULL, "Unsupported filter type.");=0D
+		goto free_flow;=0D
+	}=0D
+=0D
+	return flow;=0D
+=0D
+free_flow:=0D
+	rte_free(flow);=0D
+	rte_free(filter_rules);=0D
+=0D
+	return NULL;=0D
+}=0D
+=0D
+static int=0D
+hinic3_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,=0D
+		    struct rte_flow_error *error)=0D
+{=0D
+	int ret =3D -EINVAL;=0D
+	enum rte_filter_type type;=0D
+	struct hinic3_filter_t *rules =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (!flow) {=0D
+		PMD_DRV_LOG(ERR, "Invalid flow parameter!");=0D
+		return -EPERM;=0D
+	}=0D
+=0D
+	type =3D flow->filter_type;=0D
+	rules =3D (struct hinic3_filter_t *)flow->rule;=0D
+	/* Perform operations based on the type. */=0D
+	switch (type) {=0D
+	case RTE_ETH_FILTER_ETHERTYPE:=0D
+		ret =3D hinic3_flow_add_del_ethertype_filter(dev,=0D
+			&rules->ethertype_filter, false);=0D
+		if (!ret)=0D
+			TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow,=0D
+				     node);=0D
+=0D
+		flow->rule =3D rules;=0D
+		flow->filter_type =3D rules->filter_type;=0D
+		TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);=0D
+		break;=0D
+=0D
+	case RTE_ETH_FILTER_FDIR:=0D
+		ret =3D hinic3_flow_add_del_fdir_filter(dev, &rules->fdir_filter,=0D
+						      false);=0D
+		if (!ret)=0D
+			TAILQ_REMOVE(&nic_dev->filter_fdir_rule_list, flow,=0D
+				     node);=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(WARNING, "Filter type %d not supported", type);=0D
+		ret =3D -EINVAL;=0D
+		break;=0D
+	}=0D
+=0D
+	/* Deleted successfully. Resources are released. */=0D
+	if (!ret) {=0D
+		rte_free(rules);=0D
+		rte_free(flow);=0D
+	} else {=0D
+		rte_flow_error_set(error, -ret, HINIC3_FLOW_ERROR_TYPE_HANDLE,=0D
+				   NULL, "Failed to destroy flow.");=0D
+	}=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ * Clear all fdir type flow rules on the network device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_flush_fdir_filter(struct rte_eth_dev *dev)=0D
+{=0D
+	int ret =3D 0;=0D
+	struct hinic3_filter_t *filter_rules =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_flow *flow;=0D
+=0D
+	while (true) {=0D
+		flow =3D TAILQ_FIRST(&nic_dev->filter_fdir_rule_list);=0D
+		if (flow =3D=3D NULL)=0D
+			break;=0D
+		filter_rules =3D (struct hinic3_filter_t *)flow->rule;=0D
+=0D
+		/* Delete flow rules. */=0D
+		ret =3D hinic3_flow_add_del_fdir_filter(dev,=0D
+			&filter_rules->fdir_filter, false);=0D
+=0D
+		if (ret)=0D
+			return ret;=0D
+=0D
+		TAILQ_REMOVE(&nic_dev->filter_fdir_rule_list, flow, node);=0D
+		rte_free(filter_rules);=0D
+		rte_free(flow);=0D
+	}=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ * Clear all ether type flow rules on the network device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_flush_ethertype_filter(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_filter_t *filter_rules =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_flow *flow;=0D
+	int ret =3D 0;=0D
+=0D
+	while (true) {=0D
+		flow =3D TAILQ_FIRST(&nic_dev->filter_ethertype_list);=0D
+		if (flow =3D=3D NULL)=0D
+			break;=0D
+		filter_rules =3D (struct hinic3_filter_t *)flow->rule;=0D
+=0D
+		/* Delete flow rules. */=0D
+		ret =3D hinic3_flow_add_del_ethertype_filter(dev,=0D
+			&filter_rules->ethertype_filter, false);=0D
+=0D
+		if (ret)=0D
+			return ret;=0D
+=0D
+		TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);=0D
+		rte_free(filter_rules);=0D
+		rte_free(flow);=0D
+	}=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ * Clear all flow rules on the network device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] error=0D
+ * Structure that contains error information, such as error code and error=
=0D
+ * description.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)=0D
+{=0D
+	int ret;=0D
+=0D
+	ret =3D hinic3_flow_flush_fdir_filter(dev);=0D
+	if (ret) {=0D
+		rte_flow_error_set(error, -ret, HINIC3_FLOW_ERROR_TYPE_HANDLE,=0D
+				   NULL, "Failed to flush fdir flows.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	ret =3D hinic3_flow_flush_ethertype_filter(dev);=0D
+	if (ret) {=0D
+		rte_flow_error_set(error, -ret, HINIC3_FLOW_ERROR_TYPE_HANDLE,=0D
+				   NULL, "Failed to flush ethertype flows.");=0D
+		return -rte_errno;=0D
+	}=0D
+	return ret;=0D
+}=0D
+=0D
+/* Structure for managing flow table operations. */=0D
+const struct rte_flow_ops hinic3_flow_ops =3D {=0D
+	.validate =3D hinic3_flow_validate,=0D
+	.create =3D hinic3_flow_create,=0D
+	.destroy =3D hinic3_flow_destroy,=0D
+	.flush =3D hinic3_flow_flush,=0D
+};=0D
diff --git a/drivers/net/hinic3/hinic3_flow.h b/drivers/net/hinic3/hinic3_f=
low.h=0D
new file mode 100644=0D
index 0000000000..a3376588e5=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_flow.h=0D
@@ -0,0 +1,42 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_FLOW_H_=0D
+#define _HINIC3_FLOW_H_=0D
+=0D
+#include <rte_flow.h>=0D
+=0D
+/* Flow item type. */=0D
+#define HINIC3_FLOW_ITEM_TYPE_END                  RTE_FLOW_ITEM_TYPE_END=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_VOID                 RTE_FLOW_ITEM_TYPE_VOID=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_ANY                  RTE_FLOW_ITEM_TYPE_ANY=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_ETH                  RTE_FLOW_ITEM_TYPE_ETH=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_IPV4                 RTE_FLOW_ITEM_TYPE_IPV4=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_IPV6                 RTE_FLOW_ITEM_TYPE_IPV6=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_ICMP                 RTE_FLOW_ITEM_TYPE_ICMP=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_UDP                  RTE_FLOW_ITEM_TYPE_UDP=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_TCP                  RTE_FLOW_ITEM_TYPE_TCP=
=0D
+#define HINIC3_FLOW_ITEM_TYPE_VXLAN                RTE_FLOW_ITEM_TYPE_VXLA=
N=0D
+=0D
+=0D
+/* Flow error type. */=0D
+#define HINIC3_FLOW_ERROR_TYPE_NONE                RTE_FLOW_ERROR_TYPE_NON=
E=0D
+#define HINIC3_FLOW_ERROR_TYPE_UNSPECIFIED         RTE_FLOW_ERROR_TYPE_UNS=
PECIFIED=0D
+#define HINIC3_FLOW_ERROR_TYPE_HANDLE              RTE_FLOW_ERROR_TYPE_HAN=
DLE=0D
+#define HINIC3_FLOW_ERROR_TYPE_ATTR_GROUP          RTE_FLOW_ERROR_TYPE_ATT=
R_GROUP=0D
+#define HINIC3_FLOW_ERROR_TYPE_ATTR_PRIORITY       RTE_FLOW_ERROR_TYPE_ATT=
R_PRIORITY=0D
+#define HINIC3_FLOW_ERROR_TYPE_ATTR_INGRESS        RTE_FLOW_ERROR_TYPE_ATT=
R_INGRESS=0D
+#define HINIC3_FLOW_ERROR_TYPE_ATTR_EGRESS         RTE_FLOW_ERROR_TYPE_ATT=
R_EGRESS=0D
+#define HINIC3_FLOW_ERROR_TYPE_ATTR_TRANSFER       RTE_FLOW_ERROR_TYPE_ATT=
R_TRANSFER=0D
+#define HINIC3_FLOW_ERROR_TYPE_ATTR                RTE_FLOW_ERROR_TYPE_ATT=
R=0D
+#define HINIC3_FLOW_ERROR_TYPE_ITEM_NUM            RTE_FLOW_ERROR_TYPE_ITE=
M_NUM=0D
+#define HINIC3_FLOW_ERROR_TYPE_ITEM_SPEC           RTE_FLOW_ERROR_TYPE_ITE=
M_SPEC=0D
+#define HINIC3_FLOW_ERROR_TYPE_ITEM_LAST           RTE_FLOW_ERROR_TYPE_ITE=
M_LAST=0D
+#define HINIC3_FLOW_ERROR_TYPE_ITEM_MASK           RTE_FLOW_ERROR_TYPE_ITE=
M_MASK=0D
+#define HINIC3_FLOW_ERROR_TYPE_ITEM                RTE_FLOW_ERROR_TYPE_ITE=
M=0D
+#define HINIC3_FLOW_ERROR_TYPE_ACTION_NUM          RTE_FLOW_ERROR_TYPE_ACT=
ION_NUM=0D
+#define HINIC3_FLOW_ERROR_TYPE_ACTION_CONF         RTE_FLOW_ERROR_TYPE_ACT=
ION_CONF=0D
+#define HINIC3_FLOW_ERROR_TYPE_ACTION              RTE_FLOW_ERROR_TYPE_ACT=
ION=0D
+=0D
+#endif /**< _HINIC3_FLOW_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

