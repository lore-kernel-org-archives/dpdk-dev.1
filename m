Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A4CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD32F40DCD;
	Sat, 30 Aug 2025 14:41:12 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 08DF140A82
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=E+BoFnrLvtTySp1W5M55bnGnE1u2nElQitZH5u6BpO4=;
 b=nvDMsMxSoyKOG7ExIW0C0frtgd70P5oREeOi6yqyZ431f7fGXmEf2ihfEIFPEB
 vLAQp+uEWypAAIx5rKzdYcAoOupSaGYm9rP8URjTA/aH9SkzA1UhVJqkPPUi42TX
 rJYTu8x5ympdBfEjrZLvhhskskzZvoKGlR3E7uIFuvMRQ=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S20;
 Sat, 30 Aug 2025 20:41:05 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V5 16/18] net/hinic3: add RSS promiscuous ops
Date: Sat, 30 Aug 2025 20:39:28 +0800
Message-ID: <20250830123942.5037-17-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S20
X-Coremail-Antispam: 1Uf129KBjvAXoW3CFWkZF1rKry7KF43ZF18Xwb_yoW8Gr1xWo
 WxGrsxKwnxtr1Sy34vqrs3AFZrXFWkC3Z3C39YkrsxXFs7XFyUGFy5Xan3Jw1jqr90vr9r
 AFnaqFy0qa97J3Wrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUo73vUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQO5CmiydD3F6AAAsP
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

From: Xin Wang <wangxin679@h-partners.com>=0D

Add RSS and promiscuous ops related function codes.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c | 370 +++++++++++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_ethdev.h |  31 +++=0D
 2 files changed, 401 insertions(+)=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index ac36c49afc..0807e017c2 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -2277,6 +2277,281 @@ hinic3_dev_allmulticast_disable(struct rte_eth_dev =
*dev)=0D
 	return 0;=0D
 }=0D
 =0D
+/**=0D
+ * Enable promiscuous mode.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_promiscuous_enable(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u32 rx_mode;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&nic_dev->rx_mode_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rx_mode =3D nic_dev->rx_mode | HINIC3_RX_MODE_PROMISC;=0D
+=0D
+	err =3D hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);=0D
+	if (err) {=0D
+		hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+		PMD_DRV_LOG(ERR, "Enable promiscuous failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	nic_dev->rx_mode =3D rx_mode;=0D
+=0D
+	hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Enable promiscuous, nic_dev: %s, port_id: %d, promisc: %d",=0D
+		    nic_dev->dev_name, dev->data->port_id,=0D
+		    dev->data->promiscuous);=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Disable promiscuous mode.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_promiscuous_disable(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u32 rx_mode;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&nic_dev->rx_mode_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rx_mode =3D nic_dev->rx_mode & (~HINIC3_RX_MODE_PROMISC);=0D
+=0D
+	err =3D hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);=0D
+	if (err) {=0D
+		hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+		PMD_DRV_LOG(ERR, "Disable promiscuous failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	nic_dev->rx_mode =3D rx_mode;=0D
+=0D
+	hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		"Disable promiscuous, nic_dev: %s, port_id: %d, promisc: %d",=0D
+		nic_dev->dev_name, dev->data->port_id, dev->data->promiscuous);=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get flow control configuration, including auto-negotiation and RX/TX pa=
use=0D
+ * settings.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @param[out] fc_conf=0D
+ * The flow control configuration to be filled.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+=0D
+/**=0D
+ * Update the RSS hash key and RSS hash type.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] rss_conf=0D
+ * RSS configuration data.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_rss_hash_update(struct rte_eth_dev *dev,=0D
+		       struct rte_eth_rss_conf *rss_conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_rss_type rss_type =3D {0};=0D
+	u64 rss_hf =3D rss_conf->rss_hf;=0D
+	int err =3D 0;=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_DISABLE) {=0D
+		if (rss_hf !=3D 0)=0D
+			return -EINVAL;=0D
+=0D
+		PMD_DRV_LOG(INFO, "RSS is not enabled");=0D
+		return 0;=0D
+	}=0D
+=0D
+	if (rss_conf->rss_key_len > HINIC3_RSS_KEY_SIZE) {=0D
+		PMD_DRV_LOG(ERR, "Invalid RSS key, rss_key_len: %d",=0D
+			    rss_conf->rss_key_len);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (rss_conf->rss_key) {=0D
+		err =3D hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_key,=0D
+					      HINIC3_RSS_KEY_SIZE);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Set RSS hash key failed");=0D
+			return err;=0D
+		}=0D
+		memcpy((void *)nic_dev->rss_key, (void *)rss_conf->rss_key,=0D
+		       (size_t)rss_conf->rss_key_len);=0D
+	}=0D
+=0D
+	rss_type.ipv4 =3D (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |=0D
+				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER))=0D
+				? 1=0D
+				: 0;=0D
+	rss_type.tcp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;=0D
+	rss_type.ipv6 =3D (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |=0D
+				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER))=0D
+				? 1=0D
+				: 0;=0D
+	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
+	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
+	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
+	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
+=0D
+	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Set RSS type failed");=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Get the RSS hash configuration.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] rss_conf=0D
+ * RSS configuration data.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_=
conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_rss_type rss_type =3D {0};=0D
+	int err;=0D
+=0D
+	if (!rss_conf)=0D
+		return -EINVAL;=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_DISABLE) {=0D
+		rss_conf->rss_hf =3D 0;=0D
+		PMD_DRV_LOG(INFO, "RSS is not enabled");=0D
+		return 0;=0D
+	}=0D
+=0D
+	if (rss_conf->rss_key && rss_conf->rss_key_len >=3D HINIC3_RSS_KEY_SIZE) =
{=0D
+		/*=0D
+		 * Get RSS key from driver to reduce the frequency of the MPU=0D
+		 * accessing the RSS memory.=0D
+		 */=0D
+		rss_conf->rss_key_len =3D sizeof(nic_dev->rss_key);=0D
+		memcpy((void *)rss_conf->rss_key, (void *)nic_dev->rss_key,=0D
+		       (size_t)rss_conf->rss_key_len);=0D
+	}=0D
+=0D
+	err =3D hinic3_get_rss_type(nic_dev->hwdev, &rss_type);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rss_conf->rss_hf =3D 0;=0D
+	rss_conf->rss_hf |=3D=0D
+		rss_type.ipv4 ? (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |=0D
+				 RTE_ETH_RSS_NONFRAG_IPV4_OTHER)=0D
+			      : 0;=0D
+	rss_conf->rss_hf |=3D rss_type.tcp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_TCP=0D
+					      : 0;=0D
+	rss_conf->rss_hf |=3D=0D
+		rss_type.ipv6 ? (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |=0D
+				 RTE_ETH_RSS_NONFRAG_IPV6_OTHER)=0D
+			      : 0;=0D
+	rss_conf->rss_hf |=3D rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;=0D
+	rss_conf->rss_hf |=3D rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP=0D
+					      : 0;=0D
+	rss_conf->rss_hf |=3D rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0=
;=0D
+	rss_conf->rss_hf |=3D rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP=0D
+					      : 0;=0D
+	rss_conf->rss_hf |=3D rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP=0D
+					      : 0;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get the RETA indirection table.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] reta_conf=0D
+ * Pointer to RETA configuration structure array.=0D
+ * @param[in] reta_size=0D
+ * Size of the RETA table.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_rss_reta_query(struct rte_eth_dev *dev,=0D
+		      struct rte_eth_rss_reta_entry64 *reta_conf,=0D
+		      uint16_t reta_size)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u32 indirtbl[HINIC3_RSS_INDIR_SIZE] =3D {0};=0D
+	u16 idx, shift;=0D
+	u16 i;=0D
+	int err;=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_DISABLE) {=0D
+		PMD_DRV_LOG(INFO, "RSS is not enabled");=0D
+		return 0;=0D
+	}=0D
+=0D
+	if (reta_size !=3D HINIC3_RSS_INDIR_SIZE) {=0D
+		PMD_DRV_LOG(ERR, "Invalid reta size, reta_size: %d", reta_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,=0D
+				       HINIC3_RSS_INDIR_SIZE);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get RSS retas table failed, error: %d", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	for (i =3D 0; i < reta_size; i++) {=0D
+		idx =3D i / RTE_ETH_RETA_GROUP_SIZE;=0D
+		shift =3D i % RTE_ETH_RETA_GROUP_SIZE;=0D
+		if (reta_conf[idx].mask & (1ULL << shift))=0D
+			reta_conf[idx].reta[shift] =3D (uint16_t)indirtbl[i];=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 static int=0D
 hinic3_get_eeprom(__rte_unused struct rte_eth_dev *dev,=0D
 		  struct rte_dev_eeprom_info *info)=0D
@@ -2287,6 +2562,68 @@ hinic3_get_eeprom(__rte_unused struct rte_eth_dev *d=
ev,=0D
 				  &info->length, MAX_BUF_OUT_LEN);=0D
 }=0D
 =0D
+/**=0D
+ * Update the RETA indirection table.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] reta_conf=0D
+ * Pointer to RETA configuration structure array.=0D
+ * @param[in] reta_size=0D
+ * Size of the RETA table.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_rss_reta_update(struct rte_eth_dev *dev,=0D
+		       struct rte_eth_rss_reta_entry64 *reta_conf,=0D
+		       uint16_t reta_size)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u32 indirtbl[HINIC3_RSS_INDIR_SIZE] =3D {0};=0D
+	u16 idx, shift;=0D
+	u16 i;=0D
+	int err;=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_DISABLE)=0D
+		return 0;=0D
+=0D
+	if (reta_size !=3D HINIC3_RSS_INDIR_SIZE) {=0D
+		PMD_DRV_LOG(ERR, "Invalid reta size, reta_size: %d", reta_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,=0D
+				       HINIC3_RSS_INDIR_SIZE);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	/* Update RSS reta table. */=0D
+	for (i =3D 0; i < reta_size; i++) {=0D
+		idx =3D i / RTE_ETH_RETA_GROUP_SIZE;=0D
+		shift =3D i % RTE_ETH_RETA_GROUP_SIZE;=0D
+		if (reta_conf[idx].mask & (1ULL << shift))=0D
+			indirtbl[i] =3D reta_conf[idx].reta[shift];=0D
+	}=0D
+=0D
+	for (i =3D 0; i < reta_size; i++) {=0D
+		if (indirtbl[i] >=3D nic_dev->num_rqs) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"Invalid reta entry, index: %d, num_rqs: %d",=0D
+				indirtbl[i], nic_dev->num_rqs);=0D
+			return -EFAULT;=0D
+		}=0D
+	}=0D
+=0D
+	err =3D hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl,=0D
+				       HINIC3_RSS_INDIR_SIZE);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Set RSS reta table failed");=0D
+=0D
+	return err;=0D
+}=0D
+=0D
 /**=0D
  * Get device generic statistics.=0D
  *=0D
@@ -2857,6 +3194,29 @@ hinic3_set_mc_addr_list(struct rte_eth_dev *dev,=0D
 	return 0;=0D
 }=0D
 =0D
+/**=0D
+ * Manage flow director filter operations.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] filter_type=0D
+ * Filter type.=0D
+ * @param[in] filter_op=0D
+ * Operation to perform.=0D
+ * @param[in] arg=0D
+ * Pointer to operation-specific structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_filter_ctrl(struct rte_eth_dev *dev, const struct rte_flow_ops =
**arg)=0D
+{=0D
+	RTE_SET_USED(dev);=0D
+	*arg =3D &hinic3_flow_ops;=0D
+	return 0;=0D
+}=0D
+=0D
 static int=0D
 hinic3_get_reg(__rte_unused struct rte_eth_dev *dev,=0D
 	       __rte_unused struct rte_dev_reg_info *regs)=0D
@@ -2890,6 +3250,12 @@ static const struct eth_dev_ops hinic3_pmd_ops =3D {=
=0D
 	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
 	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
 	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.promiscuous_enable            =3D hinic3_dev_promiscuous_enable,=0D
+	.promiscuous_disable           =3D hinic3_dev_promiscuous_disable,=0D
+	.rss_hash_update               =3D hinic3_rss_hash_update,=0D
+	.rss_hash_conf_get             =3D hinic3_rss_conf_get,=0D
+	.reta_update                   =3D hinic3_rss_reta_update,=0D
+	.reta_query                    =3D hinic3_rss_reta_query,=0D
 	.get_eeprom                    =3D hinic3_get_eeprom,=0D
 	.stats_get                     =3D hinic3_dev_stats_get,=0D
 	.stats_reset                   =3D hinic3_dev_stats_reset,=0D
@@ -2931,6 +3297,10 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops =
=3D {=0D
 	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
 	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
 	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.rss_hash_update               =3D hinic3_rss_hash_update,=0D
+	.rss_hash_conf_get             =3D hinic3_rss_conf_get,=0D
+	.reta_update                   =3D hinic3_rss_reta_update,=0D
+	.reta_query                    =3D hinic3_rss_reta_query,=0D
 	.get_eeprom                    =3D hinic3_get_eeprom,=0D
 	.stats_get                     =3D hinic3_dev_stats_get,=0D
 	.stats_reset                   =3D hinic3_dev_stats_reset,=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index e0d5b4602c..90ca21491f 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -97,6 +97,10 @@ struct hinic3_nic_dev {=0D
 	u16 rx_buff_len;=0D
 	u16 mtu_size;=0D
 =0D
+	u16 rss_state;=0D
+	u8 num_rss; /**< Number of RSS queues. */=0D
+	u8 rsvd0;   /**< Reserved field 0. */=0D
+=0D
 	u32 rx_mode;=0D
 	u8 rx_queue_list[HINIC3_MAX_QUEUE_NUM];=0D
 	rte_spinlock_t queue_list_lock;=0D
@@ -106,6 +110,8 @@ struct hinic3_nic_dev {=0D
 	u32 default_cos;=0D
 	u32 rx_csum_en;=0D
 =0D
+	u8 rss_key[HINIC3_RSS_KEY_SIZE];=0D
+=0D
 	RTE_ATOMIC(u64) dev_status;=0D
 =0D
 	struct rte_ether_addr default_addr;=0D
@@ -116,4 +122,29 @@ struct hinic3_nic_dev {=0D
 	u32 vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */=0D
 };=0D
 =0D
+/**=0D
+ * Enable interrupt for the specified RX queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] queue_id=0D
+ * The ID of the receive queue for which the interrupt is being enabled.=0D
+ * @return=0D
+ * 0 on success, a negative error code on failure.=0D
+ */=0D
+int hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queu=
e_id);=0D
+=0D
+/**=0D
+ * Disable interrupt for the specified RX queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] queue_id=0D
+ * The ID of the receive queue for which the interrupt is being disabled.=
=0D
+ * @return=0D
+ * 0 on success, a negative error code on failure.=0D
+ */=0D
+int hinic3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev,=0D
+				     uint16_t queue_id);=0D
+=0D
 #endif /* _HINIC3_ETHDEV_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

