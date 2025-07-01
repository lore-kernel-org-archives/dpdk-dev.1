Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEAC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 06:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C60284066E;
	Tue,  1 Jul 2025 08:45:21 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id A33E64028C
 for <dev@dpdk.org>; Tue,  1 Jul 2025 08:45:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bWYMb3pX0zHrJL;
 Tue,  1 Jul 2025 14:41:15 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id EAD0B140159;
 Tue,  1 Jul 2025 14:45:15 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 14:45:15 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 6/6] net/hns3: VF support multi-TCs configure
Date: Tue, 1 Jul 2025 14:45:12 +0800
Message-ID: <20250701064512.3868175-7-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250701064512.3868175-1-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
 <20250701064512.3868175-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

From: Chengwen Feng <fengchengwen@huawei.com>

If VF has the multi-TCs capability, then application could configure the
multi-TCs feature through the DCB interface. Because VF does not have
its own ETS and PFC components, the constraints are as follows:

1. The DCB configuration (struct rte_eth_dcb_rx_conf and
   rte_eth_dcb_tx_conf) must be the same as that of the PF.
2. VF does not support RTE_ETH_DCB_PFC_SUPPORT configuration.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/hns3/hns3_dcb.c       | 106 ++++++++++++
 drivers/net/hns3/hns3_dcb.h       |   4 +
 drivers/net/hns3/hns3_dump.c      |   6 +-
 drivers/net/hns3/hns3_ethdev.c    |  98 +-----------
 drivers/net/hns3/hns3_ethdev_vf.c | 257 ++++++++++++++++++++++++++++--
 drivers/net/hns3/hns3_mbx.h       |  39 +++++
 6 files changed, 402 insertions(+), 108 deletions(-)

diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
index 9a1f4120d0..6d2945d9c5 100644
--- a/drivers/net/hns3/hns3_dcb.c
+++ b/drivers/net/hns3/hns3_dcb.c
@@ -1800,3 +1800,109 @@ hns3_fc_enable(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 
 	return ret;
 }
+
+int
+hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
+{
+	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	enum rte_eth_rx_mq_mode mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
+	int i;
+
+	if (hns->is_vf && !hns3_dev_get_support(hw, VF_MULTI_TCS))
+		return -ENOTSUP;
+
+	rte_spinlock_lock(&hw->lock);
+	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
+		dcb_info->nb_tcs = hw->dcb_info.local_max_tc;
+	else
+		dcb_info->nb_tcs = 1;
+
+	for (i = 0; i < HNS3_MAX_USER_PRIO; i++)
+		dcb_info->prio_tc[i] = hw->dcb_info.prio_tc[i];
+	for (i = 0; i < dcb_info->nb_tcs; i++)
+		dcb_info->tc_bws[i] = hw->dcb_info.pg_info[0].tc_dwrr[i];
+
+	for (i = 0; i < hw->dcb_info.num_tc; i++) {
+		dcb_info->tc_queue.tc_rxq[0][i].base = hw->alloc_rss_size * i;
+		dcb_info->tc_queue.tc_txq[0][i].base =
+						hw->tc_queue[i].tqp_offset;
+		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = hw->alloc_rss_size;
+		dcb_info->tc_queue.tc_txq[0][i].nb_queue =
+						hw->tc_queue[i].tqp_count;
+	}
+	rte_spinlock_unlock(&hw->lock);
+
+	return 0;
+}
+
+int
+hns3_check_dev_mq_mode(struct rte_eth_dev *dev)
+{
+	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
+	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
+	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
+	struct rte_eth_dcb_tx_conf *dcb_tx_conf;
+	uint8_t num_tc;
+	int max_tc = 0;
+	int i;
+
+	if (((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) ||
+	    (tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
+	     tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY)) {
+		hns3_err(hw, "VMDQ is not supported, rx_mq_mode = %d, tx_mq_mode = %d.",
+			 rx_mq_mode, tx_mq_mode);
+		return -EOPNOTSUPP;
+	}
+
+	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
+	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
+		if (dcb_rx_conf->nb_tcs > hw->dcb_info.tc_max) {
+			hns3_err(hw, "nb_tcs(%u) > max_tc(%u) driver supported.",
+				 dcb_rx_conf->nb_tcs, hw->dcb_info.tc_max);
+			return -EINVAL;
+		}
+
+		/*
+		 * The PF driver supports only four or eight TCs. But the
+		 * number of TCs supported by the VF driver is flexible,
+		 * therefore, only the number of TCs in the PF is verified.
+		 */
+		if (!hns->is_vf && !(dcb_rx_conf->nb_tcs == HNS3_4_TCS ||
+				     dcb_rx_conf->nb_tcs == HNS3_8_TCS)) {
+			hns3_err(hw, "on RTE_ETH_MQ_RX_DCB_RSS mode, "
+				 "nb_tcs(%d) != %d or %d in rx direction.",
+				 dcb_rx_conf->nb_tcs, HNS3_4_TCS, HNS3_8_TCS);
+			return -EINVAL;
+		}
+
+		if (dcb_rx_conf->nb_tcs != dcb_tx_conf->nb_tcs) {
+			hns3_err(hw, "num_tcs(%d) of tx is not equal to rx(%d)",
+				 dcb_tx_conf->nb_tcs, dcb_rx_conf->nb_tcs);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < HNS3_MAX_USER_PRIO; i++) {
+			if (dcb_rx_conf->dcb_tc[i] != dcb_tx_conf->dcb_tc[i]) {
+				hns3_err(hw, "dcb_tc[%d] = %u in rx direction, "
+					 "is not equal to one in tx direction.",
+					 i, dcb_rx_conf->dcb_tc[i]);
+				return -EINVAL;
+			}
+			if (dcb_rx_conf->dcb_tc[i] > max_tc)
+				max_tc = dcb_rx_conf->dcb_tc[i];
+		}
+
+		num_tc = max_tc + 1;
+		if (num_tc > dcb_rx_conf->nb_tcs) {
+			hns3_err(hw, "max num_tc(%u) mapped > nb_tcs(%u)",
+				 num_tc, dcb_rx_conf->nb_tcs);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/hns3/hns3_dcb.h b/drivers/net/hns3/hns3_dcb.h
index d5bb5edf4d..552e9c3026 100644
--- a/drivers/net/hns3/hns3_dcb.h
+++ b/drivers/net/hns3/hns3_dcb.h
@@ -215,4 +215,8 @@ int hns3_update_queue_map_configure(struct hns3_adapter *hns);
 int hns3_port_shaper_update(struct hns3_hw *hw, uint32_t speed);
 uint8_t hns3_txq_mapped_tc_get(struct hns3_hw *hw, uint16_t txq_no);
 
+int hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
+
+int hns3_check_dev_mq_mode(struct rte_eth_dev *dev);
+
 #endif /* HNS3_DCB_H */
diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
index 678279e2ac..0e978dee60 100644
--- a/drivers/net/hns3/hns3_dump.c
+++ b/drivers/net/hns3/hns3_dump.c
@@ -210,7 +210,7 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
 		"  - Device Base Info:\n"
 		"\t  -- name: %s\n"
 		"\t  -- adapter_state=%s\n"
-		"\t  -- tc_max=%u tc_num=%u\n"
+		"\t  -- tc_max=%u tc_num=%u dwrr[%u %u %u %u]\n"
 		"\t  -- nb_rx_queues=%u nb_tx_queues=%u\n"
 		"\t  -- total_tqps_num=%u tqps_num=%u intr_tqps_num=%u\n"
 		"\t  -- rss_size_max=%u alloc_rss_size=%u tx_qnum_per_tc=%u\n"
@@ -224,6 +224,10 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
 		dev->data->name,
 		hns3_get_adapter_state_name(hw->adapter_state),
 		hw->dcb_info.tc_max, hw->dcb_info.num_tc,
+		hw->dcb_info.pg_info[0].tc_dwrr[0],
+		hw->dcb_info.pg_info[0].tc_dwrr[1],
+		hw->dcb_info.pg_info[0].tc_dwrr[2],
+		hw->dcb_info.pg_info[0].tc_dwrr[3],
 		dev->data->nb_rx_queues, dev->data->nb_tx_queues,
 		hw->total_tqps_num, hw->tqps_num, hw->intr_tqps_num,
 		hw->rss_size_max, hw->alloc_rss_size, hw->tx_qnum_per_tc,
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 5af11d9228..a809a47423 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -1870,71 +1870,6 @@ hns3_remove_mc_mac_addr(struct hns3_hw *hw, struct rte_ether_addr *mac_addr)
 	return ret;
 }
 
-static int
-hns3_check_mq_mode(struct rte_eth_dev *dev)
-{
-	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
-	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
-	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
-	struct rte_eth_dcb_tx_conf *dcb_tx_conf;
-	uint8_t num_tc;
-	int max_tc = 0;
-	int i;
-
-	if (((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) ||
-	    (tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
-	     tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY)) {
-		hns3_err(hw, "VMDQ is not supported, rx_mq_mode = %d, tx_mq_mode = %d.",
-			 rx_mq_mode, tx_mq_mode);
-		return -EOPNOTSUPP;
-	}
-
-	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
-	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
-	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
-		if (dcb_rx_conf->nb_tcs > hw->dcb_info.tc_max) {
-			hns3_err(hw, "nb_tcs(%u) > max_tc(%u) driver supported.",
-				 dcb_rx_conf->nb_tcs, hw->dcb_info.tc_max);
-			return -EINVAL;
-		}
-
-		if (!(dcb_rx_conf->nb_tcs == HNS3_4_TCS ||
-		      dcb_rx_conf->nb_tcs == HNS3_8_TCS)) {
-			hns3_err(hw, "on RTE_ETH_MQ_RX_DCB_RSS mode, "
-				 "nb_tcs(%d) != %d or %d in rx direction.",
-				 dcb_rx_conf->nb_tcs, HNS3_4_TCS, HNS3_8_TCS);
-			return -EINVAL;
-		}
-
-		if (dcb_rx_conf->nb_tcs != dcb_tx_conf->nb_tcs) {
-			hns3_err(hw, "num_tcs(%d) of tx is not equal to rx(%d)",
-				 dcb_tx_conf->nb_tcs, dcb_rx_conf->nb_tcs);
-			return -EINVAL;
-		}
-
-		for (i = 0; i < HNS3_MAX_USER_PRIO; i++) {
-			if (dcb_rx_conf->dcb_tc[i] != dcb_tx_conf->dcb_tc[i]) {
-				hns3_err(hw, "dcb_tc[%d] = %u in rx direction, "
-					 "is not equal to one in tx direction.",
-					 i, dcb_rx_conf->dcb_tc[i]);
-				return -EINVAL;
-			}
-			if (dcb_rx_conf->dcb_tc[i] > max_tc)
-				max_tc = dcb_rx_conf->dcb_tc[i];
-		}
-
-		num_tc = max_tc + 1;
-		if (num_tc > dcb_rx_conf->nb_tcs) {
-			hns3_err(hw, "max num_tc(%u) mapped > nb_tcs(%u)",
-				 num_tc, dcb_rx_conf->nb_tcs);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static int
 hns3_bind_ring_with_vector(struct hns3_hw *hw, uint16_t vector_id, bool en,
 			   enum hns3_ring_type queue_type, uint16_t queue_id)
@@ -2033,7 +1968,7 @@ hns3_check_dev_conf(struct rte_eth_dev *dev)
 	struct rte_eth_conf *conf = &dev->data->dev_conf;
 	int ret;
 
-	ret = hns3_check_mq_mode(dev);
+	ret = hns3_check_dev_mq_mode(dev);
 	if (ret)
 		return ret;
 
@@ -5489,37 +5424,6 @@ hns3_priority_flow_ctrl_set(struct rte_eth_dev *dev,
 	return ret;
 }
 
-static int
-hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
-{
-	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	enum rte_eth_rx_mq_mode mq_mode = dev->data->dev_conf.rxmode.mq_mode;
-	int i;
-
-	rte_spinlock_lock(&hw->lock);
-	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
-		dcb_info->nb_tcs = hw->dcb_info.local_max_tc;
-	else
-		dcb_info->nb_tcs = 1;
-
-	for (i = 0; i < HNS3_MAX_USER_PRIO; i++)
-		dcb_info->prio_tc[i] = hw->dcb_info.prio_tc[i];
-	for (i = 0; i < dcb_info->nb_tcs; i++)
-		dcb_info->tc_bws[i] = hw->dcb_info.pg_info[0].tc_dwrr[i];
-
-	for (i = 0; i < hw->dcb_info.num_tc; i++) {
-		dcb_info->tc_queue.tc_rxq[0][i].base = hw->alloc_rss_size * i;
-		dcb_info->tc_queue.tc_txq[0][i].base =
-						hw->tc_queue[i].tqp_offset;
-		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = hw->alloc_rss_size;
-		dcb_info->tc_queue.tc_txq[0][i].nb_queue =
-						hw->tc_queue[i].tqp_count;
-	}
-	rte_spinlock_unlock(&hw->lock);
-
-	return 0;
-}
-
 static int
 hns3_reinit_dev(struct hns3_adapter *hns)
 {
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index 41d8252540..f9ef3dbb06 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -379,6 +379,236 @@ hns3vf_bind_ring_with_vector(struct hns3_hw *hw, uint16_t vector_id,
 	return ret;
 }
 
+static int
+hns3vf_set_multi_tc(struct hns3_hw *hw, const struct hns3_mbx_tc_config *config)
+{
+	struct hns3_mbx_tc_config *payload;
+	struct hns3_vf_to_pf_msg req;
+	int ret;
+
+	hns3vf_mbx_setup(&req, HNS3_MBX_SET_TC, 0);
+	payload = (struct hns3_mbx_tc_config *)req.data;
+	memcpy(payload, config, sizeof(*payload));
+	payload->prio_tc_map = rte_cpu_to_le_32(config->prio_tc_map);
+	ret = hns3vf_mbx_send(hw, &req, true, NULL, 0);
+	if (ret)
+		hns3_err(hw, "failed to set multi-tc, ret = %d.", ret);
+
+	return ret;
+}
+
+static int
+hns3vf_unset_multi_tc(struct hns3_hw *hw)
+{
+	struct hns3_mbx_tc_config *paylod;
+	struct hns3_vf_to_pf_msg req;
+	int ret;
+
+	hns3vf_mbx_setup(&req, HNS3_MBX_SET_TC, 0);
+	paylod = (struct hns3_mbx_tc_config *)req.data;
+	paylod->tc_dwrr[0] = HNS3_ETS_DWRR_MAX;
+	paylod->num_tc = 1;
+	ret = hns3vf_mbx_send(hw, &req, true, NULL, 0);
+	if (ret)
+		hns3_err(hw, "failed to unset multi-tc, ret = %d.", ret);
+
+	return ret;
+}
+
+static int
+hns3vf_check_multi_tc_config(struct rte_eth_dev *dev, const struct hns3_mbx_tc_config *info)
+{
+	struct rte_eth_dcb_rx_conf *rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	uint32_t prio_tc_map = info->prio_tc_map;
+	uint8_t map;
+	int i;
+
+	if (rx_conf->nb_tcs != info->num_tc) {
+		hns3_err(hw, "num_tcs(%d) is not equal to PF config(%u)!",
+			 rx_conf->nb_tcs, info->num_tc);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < HNS3_MAX_USER_PRIO; i++) {
+		map = prio_tc_map & HNS3_MBX_PRIO_MASK;
+		prio_tc_map >>= HNS3_MBX_PRIO_SHIFT;
+		if (rx_conf->dcb_tc[i] != map) {
+			hns3_err(hw, "dcb_tc[%d] = %u is not equal to PF config(%u)!",
+				 i, rx_conf->dcb_tc[i], map);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int
+hns3vf_get_multi_tc_info(struct hns3_hw *hw, struct hns3_mbx_tc_config *info)
+{
+	uint8_t resp_msg[HNS3_MBX_MAX_RESP_DATA_SIZE];
+	struct hns3_mbx_tc_prio_map *map = (struct hns3_mbx_tc_prio_map *)resp_msg;
+	struct hns3_mbx_tc_ets_info *ets = (struct hns3_mbx_tc_ets_info *)resp_msg;
+	struct hns3_vf_to_pf_msg req;
+	int i, ret;
+
+	memset(info, 0, sizeof(*info));
+
+	hns3vf_mbx_setup(&req, HNS3_MBX_GET_TC, HNS3_MBX_GET_PRIO_MAP);
+	ret = hns3vf_mbx_send(hw, &req, true, resp_msg, sizeof(resp_msg));
+	if (ret) {
+		hns3_err(hw, "failed to get multi-tc prio map, ret = %d.", ret);
+		return ret;
+	}
+	info->prio_tc_map = rte_le_to_cpu_32(map->prio_tc_map);
+
+	hns3vf_mbx_setup(&req, HNS3_MBX_GET_TC, HNS3_MBX_GET_ETS_INFO);
+	ret = hns3vf_mbx_send(hw, &req, true, resp_msg, sizeof(resp_msg));
+	if (ret) {
+		hns3_err(hw, "failed to get multi-tc ETS info, ret = %d.", ret);
+		return ret;
+	}
+	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+		if (ets->sch_mode[i] == HNS3_ETS_SCHED_MODE_INVALID)
+			continue;
+		info->tc_dwrr[i] = ets->sch_mode[i];
+		info->num_tc++;
+		if (ets->sch_mode[i] > 0)
+			info->tc_sch_mode |= 1u << i;
+	}
+
+	return 0;
+}
+
+static void
+hns3vf_update_dcb_info(struct hns3_hw *hw, const struct hns3_mbx_tc_config *info)
+{
+	uint32_t prio_tc_map;
+	uint8_t map;
+	int i;
+
+	hw->dcb_info.local_max_tc = hw->dcb_info.num_tc;
+	hw->dcb_info.hw_tc_map = (1u << hw->dcb_info.num_tc) - 1u;
+	memset(hw->dcb_info.pg_info[0].tc_dwrr, 0, sizeof(hw->dcb_info.pg_info[0].tc_dwrr));
+
+	if (hw->dcb_info.num_tc == 1) {
+		memset(hw->dcb_info.prio_tc, 0, sizeof(hw->dcb_info.prio_tc));
+		hw->dcb_info.pg_info[0].tc_dwrr[0] = HNS3_ETS_DWRR_MAX;
+		return;
+	}
+
+	if (info == NULL)
+		return;
+
+	prio_tc_map = info->prio_tc_map;
+	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+		map = prio_tc_map & HNS3_MBX_PRIO_MASK;
+		prio_tc_map >>= HNS3_MBX_PRIO_SHIFT;
+		hw->dcb_info.prio_tc[i] = map;
+	}
+	for (i = 0; i < hw->dcb_info.num_tc; i++)
+		hw->dcb_info.pg_info[0].tc_dwrr[i] = info->tc_dwrr[i];
+}
+
+static int
+hns3vf_setup_dcb(struct rte_eth_dev *dev)
+{
+	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct hns3_mbx_tc_config info;
+	int ret;
+
+	if (!hns3_dev_get_support(hw, VF_MULTI_TCS)) {
+		hns3_err(hw, "this port does not support dcb configurations.");
+		return -ENOTSUP;
+	}
+
+	if (dev->data->dev_conf.dcb_capability_en & RTE_ETH_DCB_PFC_SUPPORT) {
+		hns3_err(hw, "VF don't support PFC!");
+		return -ENOTSUP;
+	}
+
+	ret = hns3vf_get_multi_tc_info(hw, &info);
+	if (ret)
+		return ret;
+
+	ret = hns3vf_check_multi_tc_config(dev, &info);
+	if (ret)
+		return ret;
+
+	/*
+	 * If multiple-TCs have been configured, cancel the configuration
+	 * first. Otherwise, the configuration will fail.
+	 */
+	if (hw->dcb_info.num_tc > 1) {
+		ret = hns3vf_unset_multi_tc(hw);
+		if (ret)
+			return ret;
+		hw->dcb_info.num_tc = 1;
+		hns3vf_update_dcb_info(hw, NULL);
+	}
+
+	ret = hns3vf_set_multi_tc(hw, &info);
+	if (ret)
+		return ret;
+
+	hw->dcb_info.num_tc = info.num_tc;
+	hns3vf_update_dcb_info(hw, &info);
+
+	return hns3_queue_to_tc_mapping(hw, hw->data->nb_rx_queues, hw->data->nb_rx_queues);
+}
+
+static int
+hns3vf_unset_dcb(struct rte_eth_dev *dev)
+{
+	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	int ret;
+
+	if (hw->dcb_info.num_tc > 1) {
+		ret = hns3vf_unset_multi_tc(hw);
+		if (ret)
+			return ret;
+	}
+
+	hw->dcb_info.num_tc = 1;
+	hns3vf_update_dcb_info(hw, NULL);
+
+	return hns3_queue_to_tc_mapping(hw, hw->data->nb_rx_queues, hw->data->nb_rx_queues);
+}
+
+static int
+hns3vf_config_dcb(struct rte_eth_dev *dev)
+{
+	struct rte_eth_conf *conf = &dev->data->dev_conf;
+	uint32_t rx_mq_mode = conf->rxmode.mq_mode;
+	int ret;
+
+	if (rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
+		ret = hns3vf_setup_dcb(dev);
+	else
+		ret = hns3vf_unset_dcb(dev);
+
+	return ret;
+}
+
+static int
+hns3vf_check_dev_conf(struct rte_eth_dev *dev)
+{
+	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_eth_conf *conf = &dev->data->dev_conf;
+	int ret;
+
+	ret = hns3_check_dev_mq_mode(dev);
+	if (ret)
+		return ret;
+
+	if (conf->link_speeds & RTE_ETH_LINK_SPEED_FIXED) {
+		hns3_err(hw, "setting link speed/duplex not supported");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int
 hns3vf_dev_configure(struct rte_eth_dev *dev)
 {
@@ -412,11 +642,13 @@ hns3vf_dev_configure(struct rte_eth_dev *dev)
 	}
 
 	hw->adapter_state = HNS3_NIC_CONFIGURING;
-	if (conf->link_speeds & RTE_ETH_LINK_SPEED_FIXED) {
-		hns3_err(hw, "setting link speed/duplex not supported");
-		ret = -EINVAL;
+	ret = hns3vf_check_dev_conf(dev);
+	if (ret)
+		goto cfg_err;
+
+	ret = hns3vf_config_dcb(dev);
+	if (ret)
 		goto cfg_err;
-	}
 
 	/* When RSS is not configured, redirect the packet queue 0 */
 	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) {
@@ -1496,6 +1728,15 @@ hns3vf_init_vf(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+static void
+hns3vf_notify_uninit(struct hns3_hw *hw)
+{
+	struct hns3_vf_to_pf_msg req;
+
+	hns3vf_mbx_setup(&req, HNS3_MBX_VF_UNINIT, 0);
+	(void)hns3vf_mbx_send(hw, &req, false, NULL, 0);
+}
+
 static void
 hns3vf_uninit_vf(struct rte_eth_dev *eth_dev)
 {
@@ -1515,6 +1756,7 @@ hns3vf_uninit_vf(struct rte_eth_dev *eth_dev)
 	rte_intr_disable(pci_dev->intr_handle);
 	hns3_intr_unregister(pci_dev->intr_handle, hns3vf_interrupt_handler,
 			     eth_dev);
+	(void)hns3vf_notify_uninit(hw);
 	hns3_cmd_uninit(hw);
 	hns3_cmd_destroy_queue(hw);
 	hw->io_base = NULL;
@@ -1652,14 +1894,8 @@ static int
 hns3vf_do_start(struct hns3_adapter *hns, bool reset_queue)
 {
 	struct hns3_hw *hw = &hns->hw;
-	uint16_t nb_rx_q = hw->data->nb_rx_queues;
-	uint16_t nb_tx_q = hw->data->nb_tx_queues;
 	int ret;
 
-	ret = hns3_queue_to_tc_mapping(hw, nb_rx_q, nb_tx_q);
-	if (ret)
-		return ret;
-
 	hns3_enable_rxd_adv_layout(hw);
 
 	ret = hns3_init_queues(hns, reset_queue);
@@ -2240,6 +2476,7 @@ static const struct eth_dev_ops hns3vf_eth_dev_ops = {
 	.vlan_filter_set    = hns3vf_vlan_filter_set,
 	.vlan_offload_set   = hns3vf_vlan_offload_set,
 	.get_reg            = hns3_get_regs,
+	.get_dcb_info       = hns3_get_dcb_info,
 	.dev_supported_ptypes_get = hns3_dev_supported_ptypes_get,
 	.tx_done_cleanup    = hns3_tx_done_cleanup,
 	.eth_dev_priv_dump  = hns3_eth_dev_priv_dump,
diff --git a/drivers/net/hns3/hns3_mbx.h b/drivers/net/hns3/hns3_mbx.h
index eec3dd2c7e..3f9007c77b 100644
--- a/drivers/net/hns3/hns3_mbx.h
+++ b/drivers/net/hns3/hns3_mbx.h
@@ -9,6 +9,8 @@
 
 #include <rte_spinlock.h>
 
+#include "hns3_cmd.h"
+
 enum HNS3_MBX_OPCODE {
 	HNS3_MBX_RESET = 0x01,          /* (VF -> PF) assert reset */
 	HNS3_MBX_ASSERTING_RESET,       /* (PF -> VF) PF is asserting reset */
@@ -45,11 +47,13 @@ enum HNS3_MBX_OPCODE {
 	HNS3_MBX_PUSH_VLAN_INFO = 34,   /* (PF -> VF) push port base vlan */
 
 	HNS3_MBX_PUSH_PROMISC_INFO = 36, /* (PF -> VF) push vf promisc info */
+	HNS3_MBX_VF_UNINIT,              /* (VF -> PF) vf is unintializing */
 
 	HNS3_MBX_HANDLE_VF_TBL = 38,    /* (VF -> PF) store/clear hw cfg tbl */
 	HNS3_MBX_GET_RING_VECTOR_MAP,   /* (VF -> PF) get ring-to-vector map */
 
 	HNS3_MBX_GET_TC = 47,           /* (VF -> PF) get tc info of PF configured */
+	HNS3_MBX_SET_TC,                /* (VF -> PF) set tc */
 
 	HNS3_MBX_PUSH_LINK_STATUS = 201, /* (IMP -> PF) get port link status */
 };
@@ -64,8 +68,43 @@ struct hns3_basic_info {
 
 enum hns3_mbx_get_tc_subcode {
 	HNS3_MBX_GET_PRIO_MAP = 0, /* query priority to tc map */
+	HNS3_MBX_GET_ETS_INFO,     /* query ets info */
+};
+
+struct hns3_mbx_tc_prio_map {
+	/*
+	 * Each four bits correspond to one priority's TC.
+	 * Bit0-3 correspond to priority-0's TC, bit4-7 correspond to
+	 * priority-1's TC, and so on.
+	 */
+	uint32_t prio_tc_map;
 };
 
+#define HNS3_ETS_SCHED_MODE_INVALID	255
+#define HNS3_ETS_DWRR_MAX		100
+struct hns3_mbx_tc_ets_info {
+	uint8_t sch_mode[HNS3_MAX_TC_NUM]; /* 1~100: DWRR, 0: SP; 255-invalid */
+};
+
+#define HNS3_MBX_PRIO_SHIFT	4
+#define HNS3_MBX_PRIO_MASK	0xFu
+struct __rte_packed_begin hns3_mbx_tc_config {
+	/*
+	 * Each four bits correspond to one priority's TC.
+	 * Bit0-3 correspond to priority-0's TC, bit4-7 correspond to
+	 * priority-1's TC, and so on.
+	 */
+	uint32_t prio_tc_map;
+	uint8_t tc_dwrr[HNS3_MAX_TC_NUM];
+	uint8_t num_tc;
+	/*
+	 * Each bit correspond to one TC's scheduling mode, 0 means SP
+	 * scheduling mode, 1 means DWRR scheduling mode.
+	 * Bit0 corresponds to TC0, bit1 corresponds to TC1, and so on.
+	 */
+	uint8_t tc_sch_mode;
+} __rte_packed_end;
+
 /* below are per-VF mac-vlan subcodes */
 enum hns3_mbx_mac_vlan_subcode {
 	HNS3_MBX_MAC_VLAN_UC_MODIFY = 0,        /* modify UC mac addr */
-- 
2.33.0

