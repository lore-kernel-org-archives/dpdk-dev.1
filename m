Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F2FCA1005
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 11:13:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA83040B98;
	Mon,  1 Sep 2025 13:12:31 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 91B1640A84
 for <dev@dpdk.org>; Mon,  1 Sep 2025 13:12:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=3mdyvfoGqR4Ra1ms0OgcxeJCjIwqPtmdE9NVaRI4yiw=;
 b=k2Rq/zCKK6fbKNIfxKtf7pIneYLTRuUNdoJ4qhiQ4DVDYFsrULQO6b0iwWrCFd
 Q4bmWr5kbjSmkpEFpIkQse/6WzZlcbahSzXtji7jsAQ+hbK43W580orYmD5SmAeZ
 vjBpuLQkw0rgaFNaXNIGR7QEW/W3AnC5MYcSUgkDGkxM8=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgDnT6lXf7Vo9Y1rAQ--.56050S19;
 Mon, 01 Sep 2025 19:12:24 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V7 15/17] net/hinic3: add RSS promiscuous ops
Date: Mon,  1 Sep 2025 19:10:48 +0800
Message-ID: <20250901111102.9280-16-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250901111102.9280-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250901111102.9280-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDnT6lXf7Vo9Y1rAQ--.56050S19
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cw1UAFy5Xw4rAF15XrW7twb_yoWkKr4kpF
 48Ga4kta4DJFyaqws8Gay7C3W5uws2y3yIg397Ga4Yka15Zry8AryYkayUtFn8Z3sxW3W7
 Za95ZrZ8ua1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uia9-UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiBhK7Cmi1RQT-YQAAsn
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

From: Xin Wang <wangxin679@h-partners.com>

Add RSS and promiscuous ops related function codes.

Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
Reviewed-by: Yi Chen <chenyi221@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 358 +++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h |   6 +
 2 files changed, 364 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 0bca2c930f..77c835b18a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2244,6 +2244,329 @@ hinic3_dev_allmulticast_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/**
+ * Enable promiscuous mode.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t rx_mode;
+	int err;
+
+	rx_mode = nic_dev->rx_mode | HINIC3_RX_MODE_PROMISC;
+
+	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Enable promiscuous failed");
+		return err;
+	}
+
+	nic_dev->rx_mode = rx_mode;
+
+	PMD_DRV_LOG(INFO,
+		    "Enable promiscuous, nic_dev: %s, port_id: %d, promisc: %d",
+		    nic_dev->dev_name, dev->data->port_id,
+		    dev->data->promiscuous);
+	return 0;
+}
+
+/**
+ * Disable promiscuous mode.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t rx_mode;
+	int err;
+
+	rx_mode = nic_dev->rx_mode & (~HINIC3_RX_MODE_PROMISC);
+
+	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Disable promiscuous failed");
+		return err;
+	}
+
+	nic_dev->rx_mode = rx_mode;
+
+	PMD_DRV_LOG(INFO,
+		"Disable promiscuous, nic_dev: %s, port_id: %d, promisc: %d",
+		nic_dev->dev_name, dev->data->port_id, dev->data->promiscuous);
+	return 0;
+}
+
+/**
+ * Get flow control configuration, including auto-negotiation and RX/TX pause
+ * settings.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @param[out] fc_conf
+ * The flow control configuration to be filled.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+
+/**
+ * Update the RSS hash key and RSS hash type.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] rss_conf
+ * RSS configuration data.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_rss_hash_update(struct rte_eth_dev *dev,
+		       struct rte_eth_rss_conf *rss_conf)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_rss_type rss_type = {0};
+	uint64_t rss_hf = rss_conf->rss_hf;
+	int err = 0;
+
+	if (nic_dev->rss_state == HINIC3_RSS_DISABLE) {
+		if (rss_hf != 0)
+			return -EINVAL;
+
+		PMD_DRV_LOG(INFO, "RSS is not enabled");
+		return 0;
+	}
+
+	if (rss_conf->rss_key_len > HINIC3_RSS_KEY_SIZE) {
+		PMD_DRV_LOG(ERR, "Invalid RSS key, rss_key_len: %d",
+			    rss_conf->rss_key_len);
+		return -EINVAL;
+	}
+
+	if (rss_conf->rss_key) {
+		err = hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_key,
+					      HINIC3_RSS_KEY_SIZE);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Set RSS hash key failed");
+			return err;
+		}
+		memcpy((void *)nic_dev->rss_key, (void *)rss_conf->rss_key,
+		       (size_t)rss_conf->rss_key_len);
+	}
+
+	rss_type.ipv4 = (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
+				   RTE_ETH_RSS_NONFRAG_IPV4_OTHER))
+				? 1
+				: 0;
+	rss_type.tcp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;
+	rss_type.ipv6 = (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
+				   RTE_ETH_RSS_NONFRAG_IPV6_OTHER))
+				? 1
+				: 0;
+	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
+	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
+	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
+	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
+	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
+	if (err)
+		PMD_DRV_LOG(ERR, "Set RSS type failed");
+
+	return err;
+}
+
+/**
+ * Get the RSS hash configuration.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] rss_conf
+ * RSS configuration data.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_rss_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_rss_type rss_type = {0};
+	int err;
+
+	if (!rss_conf)
+		return -EINVAL;
+
+	if (nic_dev->rss_state == HINIC3_RSS_DISABLE) {
+		rss_conf->rss_hf = 0;
+		PMD_DRV_LOG(INFO, "RSS is not enabled");
+		return 0;
+	}
+
+	if (rss_conf->rss_key && rss_conf->rss_key_len >= HINIC3_RSS_KEY_SIZE) {
+		/*
+		 * Get RSS key from driver to reduce the frequency of the MPU
+		 * accessing the RSS memory.
+		 */
+		rss_conf->rss_key_len = sizeof(nic_dev->rss_key);
+		memcpy((void *)rss_conf->rss_key, (void *)nic_dev->rss_key,
+		       (size_t)rss_conf->rss_key_len);
+	}
+
+	err = hinic3_get_rss_type(nic_dev->hwdev, &rss_type);
+	if (err)
+		return err;
+
+	rss_conf->rss_hf = 0;
+	rss_conf->rss_hf |=
+		rss_type.ipv4 ? (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
+				 RTE_ETH_RSS_NONFRAG_IPV4_OTHER)
+			      : 0;
+	rss_conf->rss_hf |= rss_type.tcp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_TCP
+					      : 0;
+	rss_conf->rss_hf |=
+		rss_type.ipv6 ? (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
+				 RTE_ETH_RSS_NONFRAG_IPV6_OTHER)
+			      : 0;
+	rss_conf->rss_hf |= rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;
+	rss_conf->rss_hf |= rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP
+					      : 0;
+	rss_conf->rss_hf |= rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0;
+	rss_conf->rss_hf |= rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP
+					      : 0;
+	rss_conf->rss_hf |= rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP
+					      : 0;
+
+	return 0;
+}
+
+/**
+ * Get the RETA indirection table.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] reta_conf
+ * Pointer to RETA configuration structure array.
+ * @param[in] reta_size
+ * Size of the RETA table.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_rss_reta_query(struct rte_eth_dev *dev,
+		      struct rte_eth_rss_reta_entry64 *reta_conf,
+		      uint16_t reta_size)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t indirtbl[HINIC3_RSS_INDIR_SIZE] = {0};
+	uint16_t idx, shift;
+	uint16_t i;
+	int err;
+
+	if (nic_dev->rss_state == HINIC3_RSS_DISABLE) {
+		PMD_DRV_LOG(INFO, "RSS is not enabled");
+		return 0;
+	}
+
+	if (reta_size != HINIC3_RSS_INDIR_SIZE) {
+		PMD_DRV_LOG(ERR, "Invalid reta size, reta_size: %d", reta_size);
+		return -EINVAL;
+	}
+
+	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,
+				       HINIC3_RSS_INDIR_SIZE);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get RSS retas table failed, error: %d", err);
+		return err;
+	}
+
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		if (reta_conf[idx].mask & (1ULL << shift))
+			reta_conf[idx].reta[shift] = (uint16_t)indirtbl[i];
+	}
+
+	return 0;
+}
+
+/**
+ * Update the RETA indirection table.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] reta_conf
+ * Pointer to RETA configuration structure array.
+ * @param[in] reta_size
+ * Size of the RETA table.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_rss_reta_update(struct rte_eth_dev *dev,
+		       struct rte_eth_rss_reta_entry64 *reta_conf,
+		       uint16_t reta_size)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t indirtbl[HINIC3_RSS_INDIR_SIZE] = {0};
+	uint16_t idx, shift;
+	uint16_t i;
+	int err;
+
+	if (nic_dev->rss_state == HINIC3_RSS_DISABLE)
+		return 0;
+
+	if (reta_size != HINIC3_RSS_INDIR_SIZE) {
+		PMD_DRV_LOG(ERR, "Invalid reta size, reta_size: %d", reta_size);
+		return -EINVAL;
+	}
+
+	err = hinic3_rss_get_indir_tbl(nic_dev->hwdev, indirtbl,
+				       HINIC3_RSS_INDIR_SIZE);
+	if (err)
+		return err;
+
+	/* Update RSS reta table. */
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		if (reta_conf[idx].mask & (1ULL << shift))
+			indirtbl[i] = reta_conf[idx].reta[shift];
+	}
+
+	for (i = 0; i < reta_size; i++) {
+		if (indirtbl[i] >= nic_dev->num_rqs) {
+			PMD_DRV_LOG(ERR,
+				"Invalid reta entry, index: %d, num_rqs: %d",
+				indirtbl[i], nic_dev->num_rqs);
+			return -EFAULT;
+		}
+	}
+
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indirtbl,
+				       HINIC3_RSS_INDIR_SIZE);
+	if (err)
+		PMD_DRV_LOG(ERR, "Set RSS reta table failed");
+
+	return err;
+}
+
 /**
  * Get device generic statistics.
  *
@@ -2814,6 +3137,29 @@ hinic3_set_mc_addr_list(struct rte_eth_dev *dev,
 	return 0;
 }
 
+/**
+ * Manage flow director filter operations.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] filter_type
+ * Filter type.
+ * @param[in] filter_op
+ * Operation to perform.
+ * @param[in] arg
+ * Pointer to operation-specific structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_filter_ctrl(struct rte_eth_dev *dev, const struct rte_flow_ops **arg)
+{
+	RTE_SET_USED(dev);
+	*arg = &hinic3_flow_ops;
+	return 0;
+}
+
 static int
 hinic3_get_reg(__rte_unused struct rte_eth_dev *dev,
 	       __rte_unused struct rte_dev_reg_info *regs)
@@ -2847,6 +3193,13 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.vlan_offload_set              = hinic3_vlan_offload_set,
 	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
 	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
+	.promiscuous_enable            = hinic3_dev_promiscuous_enable,
+	.promiscuous_disable           = hinic3_dev_promiscuous_disable,
+	.rss_hash_update               = hinic3_rss_hash_update,
+	.rss_hash_conf_get             = hinic3_rss_conf_get,
+	.reta_update                   = hinic3_rss_reta_update,
+	.reta_query                    = hinic3_rss_reta_query,
+
 	.stats_get                     = hinic3_dev_stats_get,
 	.stats_reset                   = hinic3_dev_stats_reset,
 	.xstats_get                    = hinic3_dev_xstats_get,
@@ -2887,6 +3240,11 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.vlan_offload_set              = hinic3_vlan_offload_set,
 	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
 	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
+	.rss_hash_update               = hinic3_rss_hash_update,
+	.rss_hash_conf_get             = hinic3_rss_conf_get,
+	.reta_update                   = hinic3_rss_reta_update,
+	.reta_query                    = hinic3_rss_reta_query,
+
 	.stats_get                     = hinic3_dev_stats_get,
 	.stats_reset                   = hinic3_dev_stats_reset,
 	.xstats_get                    = hinic3_dev_xstats_get,
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 7d49035c67..bb3644b087 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -98,6 +98,10 @@ struct hinic3_nic_dev {
 	uint16_t rx_buff_len;
 	uint16_t mtu_size;
 
+	uint16_t rss_state;
+	uint8_t num_rss; /**< Number of RSS queues. */
+	uint8_t rsvd0;   /**< Reserved field 0. */
+
 	uint32_t rx_mode;
 	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];
 	rte_spinlock_t queue_list_lock;
@@ -105,6 +109,8 @@ struct hinic3_nic_dev {
 	uint32_t default_cos;
 	uint32_t rx_csum_en;
 
+	uint8_t rss_key[HINIC3_RSS_KEY_SIZE];
+
 	RTE_ATOMIC(uint64_t)dev_status;
 
 	struct rte_ether_addr default_addr;
-- 
2.47.0.windows.2

