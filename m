Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A3C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 09:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16B6B40678;
	Tue,  1 Jul 2025 11:10:13 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id B87BE4064E
 for <dev@dpdk.org>; Tue,  1 Jul 2025 11:10:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bWcf17259zqTF4;
 Tue,  1 Jul 2025 17:08:57 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id F2722180064;
 Tue,  1 Jul 2025 17:10:05 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:10:05 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v3 2/6] net/hns3: remove duplicate struct field
Date: Tue, 1 Jul 2025 17:10:00 +0800
Message-ID: <20250701091004.531704-3-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250701091004.531704-1-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
 <20250701091004.531704-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

The struct hns3_hw and hns3_hw.dcb_info both has num_tc field, their
meanings are the same, to ensure code readability, remove the num_tc
field of struct hns3_hw.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_dcb.c       | 44 ++++++++++++-------------------
 drivers/net/hns3/hns3_dump.c      |  2 +-
 drivers/net/hns3/hns3_ethdev.c    |  4 +--
 drivers/net/hns3/hns3_ethdev.h    |  3 +--
 drivers/net/hns3/hns3_ethdev_vf.c |  2 +-
 drivers/net/hns3/hns3_tm.c        |  6 ++---
 6 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
index 2f917fef9e..88c6242d66 100644
--- a/drivers/net/hns3/hns3_dcb.c
+++ b/drivers/net/hns3/hns3_dcb.c
@@ -623,7 +623,7 @@ hns3_set_rss_size(struct hns3_hw *hw, uint16_t nb_rx_q)
 	uint16_t used_rx_queues;
 	uint16_t i;
 
-	rx_qnum_per_tc = nb_rx_q / hw->num_tc;
+	rx_qnum_per_tc = nb_rx_q / hw->dcb_info.num_tc;
 	if (rx_qnum_per_tc > hw->rss_size_max) {
 		hns3_err(hw, "rx queue number of per tc (%u) is greater than "
 			 "value (%u) hardware supported.",
@@ -631,11 +631,11 @@ hns3_set_rss_size(struct hns3_hw *hw, uint16_t nb_rx_q)
 		return -EINVAL;
 	}
 
-	used_rx_queues = hw->num_tc * rx_qnum_per_tc;
+	used_rx_queues = hw->dcb_info.num_tc * rx_qnum_per_tc;
 	if (used_rx_queues != nb_rx_q) {
 		hns3_err(hw, "rx queue number (%u) configured must be an "
 			 "integral multiple of valid tc number (%u).",
-			 nb_rx_q, hw->num_tc);
+			 nb_rx_q, hw->dcb_info.num_tc);
 		return -EINVAL;
 	}
 	hw->alloc_rss_size = rx_qnum_per_tc;
@@ -665,12 +665,12 @@ hns3_tc_queue_mapping_cfg(struct hns3_hw *hw, uint16_t nb_tx_q)
 	uint16_t tx_qnum_per_tc;
 	uint8_t i;
 
-	tx_qnum_per_tc = nb_tx_q / hw->num_tc;
-	used_tx_queues = hw->num_tc * tx_qnum_per_tc;
+	tx_qnum_per_tc = nb_tx_q / hw->dcb_info.num_tc;
+	used_tx_queues = hw->dcb_info.num_tc * tx_qnum_per_tc;
 	if (used_tx_queues != nb_tx_q) {
 		hns3_err(hw, "tx queue number (%u) configured must be an "
 			 "integral multiple of valid tc number (%u).",
-			 nb_tx_q, hw->num_tc);
+			 nb_tx_q, hw->dcb_info.num_tc);
 		return -EINVAL;
 	}
 
@@ -678,7 +678,7 @@ hns3_tc_queue_mapping_cfg(struct hns3_hw *hw, uint16_t nb_tx_q)
 	hw->tx_qnum_per_tc = tx_qnum_per_tc;
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
 		tc_queue = &hw->tc_queue[i];
-		if (hw->hw_tc_map & BIT(i) && i < hw->num_tc) {
+		if (hw->hw_tc_map & BIT(i) && i < hw->dcb_info.num_tc) {
 			tc_queue->enable = true;
 			tc_queue->tqp_offset = i * hw->tx_qnum_per_tc;
 			tc_queue->tqp_count = hw->tx_qnum_per_tc;
@@ -720,15 +720,15 @@ hns3_queue_to_tc_mapping(struct hns3_hw *hw, uint16_t nb_rx_q, uint16_t nb_tx_q)
 {
 	int ret;
 
-	if (nb_rx_q < hw->num_tc) {
+	if (nb_rx_q < hw->dcb_info.num_tc) {
 		hns3_err(hw, "number of Rx queues(%u) is less than number of TC(%u).",
-			 nb_rx_q, hw->num_tc);
+			 nb_rx_q, hw->dcb_info.num_tc);
 		return -EINVAL;
 	}
 
-	if (nb_tx_q < hw->num_tc) {
+	if (nb_tx_q < hw->dcb_info.num_tc) {
 		hns3_err(hw, "number of Tx queues(%u) is less than number of TC(%u).",
-			 nb_tx_q, hw->num_tc);
+			 nb_tx_q, hw->dcb_info.num_tc);
 		return -EINVAL;
 	}
 
@@ -739,15 +739,6 @@ hns3_queue_to_tc_mapping(struct hns3_hw *hw, uint16_t nb_rx_q, uint16_t nb_tx_q)
 	return hns3_tc_queue_mapping_cfg(hw, nb_tx_q);
 }
 
-static int
-hns3_dcb_update_tc_queue_mapping(struct hns3_hw *hw, uint16_t nb_rx_q,
-				 uint16_t nb_tx_q)
-{
-	hw->num_tc = hw->dcb_info.num_tc;
-
-	return hns3_queue_to_tc_mapping(hw, nb_rx_q, nb_tx_q);
-}
-
 int
 hns3_dcb_info_init(struct hns3_hw *hw)
 {
@@ -1028,7 +1019,7 @@ hns3_q_to_qs_map(struct hns3_hw *hw)
 	uint32_t i, j;
 	int ret;
 
-	for (i = 0; i < hw->num_tc; i++) {
+	for (i = 0; i < hw->dcb_info.num_tc; i++) {
 		tc_queue = &hw->tc_queue[i];
 		for (j = 0; j < tc_queue->tqp_count; j++) {
 			q_id = tc_queue->tqp_offset + j;
@@ -1053,7 +1044,7 @@ hns3_pri_q_qs_cfg(struct hns3_hw *hw)
 		return -EINVAL;
 
 	/* Cfg qs -> pri mapping */
-	for (i = 0; i < hw->num_tc; i++) {
+	for (i = 0; i < hw->dcb_info.num_tc; i++) {
 		ret = hns3_qs_to_pri_map_cfg(hw, i, i);
 		if (ret) {
 			hns3_err(hw, "qs_to_pri mapping fail: %d", ret);
@@ -1448,8 +1439,8 @@ hns3_dcb_info_cfg(struct hns3_adapter *hns)
 	for (i = 0; i < HNS3_MAX_USER_PRIO; i++)
 		hw->dcb_info.prio_tc[i] = dcb_rx_conf->dcb_tc[i];
 
-	ret = hns3_dcb_update_tc_queue_mapping(hw, hw->data->nb_rx_queues,
-					       hw->data->nb_tx_queues);
+	ret = hns3_queue_to_tc_mapping(hw, hw->data->nb_rx_queues,
+				       hw->data->nb_tx_queues);
 	if (ret)
 		hns3_err(hw, "update tc queue mapping failed, ret = %d.", ret);
 
@@ -1635,8 +1626,7 @@ hns3_dcb_init(struct hns3_hw *hw)
 		 */
 		default_tqp_num = RTE_MIN(hw->rss_size_max,
 					  hw->tqps_num / hw->dcb_info.num_tc);
-		ret = hns3_dcb_update_tc_queue_mapping(hw, default_tqp_num,
-						       default_tqp_num);
+		ret = hns3_queue_to_tc_mapping(hw, default_tqp_num, default_tqp_num);
 		if (ret) {
 			hns3_err(hw,
 				 "update tc queue mapping failed, ret = %d.",
@@ -1673,7 +1663,7 @@ hns3_update_queue_map_configure(struct hns3_adapter *hns)
 	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
 		return 0;
 
-	ret = hns3_dcb_update_tc_queue_mapping(hw, nb_rx_q, nb_tx_q);
+	ret = hns3_queue_to_tc_mapping(hw, nb_rx_q, nb_tx_q);
 	if (ret) {
 		hns3_err(hw, "failed to update tc queue mapping, ret = %d.",
 			 ret);
diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
index f21d32e6a2..6c43ec486e 100644
--- a/drivers/net/hns3/hns3_dump.c
+++ b/drivers/net/hns3/hns3_dump.c
@@ -914,7 +914,7 @@ hns3_is_link_fc_mode(struct hns3_adapter *hns)
 	if (hw->current_fc_status == HNS3_FC_STATUS_PFC)
 		return false;
 
-	if (hw->num_tc > 1 && !pf->support_multi_tc_pause)
+	if (hw->dcb_info.num_tc > 1 && !pf->support_multi_tc_pause)
 		return false;
 
 	return true;
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 50c6ed0744..6b8fd3383a 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -5432,7 +5432,7 @@ hns3_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 		return -EOPNOTSUPP;
 	}
 
-	if (hw->num_tc > 1 && !pf->support_multi_tc_pause) {
+	if (hw->dcb_info.num_tc > 1 && !pf->support_multi_tc_pause) {
 		hns3_err(hw, "in multi-TC scenarios, MAC pause is not supported.");
 		return -EOPNOTSUPP;
 	}
@@ -5509,7 +5509,7 @@ hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
 	for (i = 0; i < dcb_info->nb_tcs; i++)
 		dcb_info->tc_bws[i] = hw->dcb_info.pg_info[0].tc_dwrr[i];
 
-	for (i = 0; i < hw->num_tc; i++) {
+	for (i = 0; i < hw->dcb_info.num_tc; i++) {
 		dcb_info->tc_queue.tc_rxq[0][i].base = hw->alloc_rss_size * i;
 		dcb_info->tc_queue.tc_txq[0][i].base =
 						hw->tc_queue[i].tqp_offset;
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index d164b9e38c..e4160f6eae 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -130,7 +130,7 @@ struct hns3_tc_info {
 };
 
 struct hns3_dcb_info {
-	uint8_t num_tc;
+	uint8_t num_tc;     /* Total number of enabled TCs */
 	uint8_t num_pg;     /* It must be 1 if vNET-Base schd */
 	uint8_t pg_dwrr[HNS3_PG_NUM];
 	uint8_t prio_tc[HNS3_MAX_USER_PRIO];
@@ -534,7 +534,6 @@ struct hns3_hw {
 	uint16_t rss_ind_tbl_size;
 	uint16_t rss_key_size;
 
-	uint8_t num_tc;             /* Total number of enabled TCs */
 	uint8_t hw_tc_map;
 	enum hns3_fc_mode requested_fc_mode; /* FC mode requested by user */
 	struct hns3_dcb_info dcb_info;
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index ea9225cd26..5f4ae1d979 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -854,7 +854,7 @@ hns3vf_get_basic_info(struct hns3_hw *hw)
 
 	basic_info = (struct hns3_basic_info *)resp_msg;
 	hw->hw_tc_map = basic_info->hw_tc_map;
-	hw->num_tc = hns3vf_get_num_tc(hw);
+	hw->dcb_info.num_tc = hns3vf_get_num_tc(hw);
 	hw->pf_vf_if_version = basic_info->pf_vf_if_version;
 	hns3vf_update_caps(hw, basic_info->caps);
 
diff --git a/drivers/net/hns3/hns3_tm.c b/drivers/net/hns3/hns3_tm.c
index 1c2ad71133..fe97b4ab92 100644
--- a/drivers/net/hns3/hns3_tm.c
+++ b/drivers/net/hns3/hns3_tm.c
@@ -519,13 +519,13 @@ hns3_tm_tc_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 
 	if (node_id >= pf->tm_conf.nb_nodes_max - 1 ||
 	    node_id < pf->tm_conf.nb_leaf_nodes_max ||
-	    hns3_tm_calc_node_tc_no(&pf->tm_conf, node_id) >= hw->num_tc) {
+	    hns3_tm_calc_node_tc_no(&pf->tm_conf, node_id) >= hw->dcb_info.num_tc) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
 		error->message = "invalid tc node ID";
 		return -EINVAL;
 	}
 
-	if (pf->tm_conf.nb_tc_node >= hw->num_tc) {
+	if (pf->tm_conf.nb_tc_node >= hw->dcb_info.num_tc) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
 		error->message = "too many TCs";
 		return -EINVAL;
@@ -974,7 +974,7 @@ hns3_tm_configure_check(struct hns3_hw *hw, struct rte_tm_error *error)
 		}
 
 		if (hns3_tm_calc_node_tc_no(tm_conf, tm_node->id) >=
-			hw->num_tc) {
+			hw->dcb_info.num_tc) {
 			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
 			error->message = "node's TC not exist";
 			return false;
-- 
2.33.0

