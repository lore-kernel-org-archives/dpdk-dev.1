Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1BFC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 09:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AF3C4066E;
	Tue,  1 Jul 2025 11:10:12 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id AD86940647
 for <dev@dpdk.org>; Tue,  1 Jul 2025 11:10:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bWccT6VSqz13MMr;
 Tue,  1 Jul 2025 17:07:37 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 52513180064;
 Tue,  1 Jul 2025 17:10:06 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:10:05 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v3 3/6] net/hns3: refactor DCB module code
Date: Tue, 1 Jul 2025 17:10:01 +0800
Message-ID: <20250701091004.531704-4-huangdengdui@huawei.com>
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

The DCB-related fields span in multiple structures, this patch moves
them into struct hns3_dcb_info.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_dcb.c       | 13 +++++------
 drivers/net/hns3/hns3_ethdev.c    | 38 +++++++++++++++----------------
 drivers/net/hns3/hns3_ethdev.h    |  8 +++----
 drivers/net/hns3/hns3_ethdev_vf.c |  4 ++--
 drivers/net/hns3/hns3_rss.c       |  8 +++----
 5 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
index 88c6242d66..9a1f4120d0 100644
--- a/drivers/net/hns3/hns3_dcb.c
+++ b/drivers/net/hns3/hns3_dcb.c
@@ -678,7 +678,7 @@ hns3_tc_queue_mapping_cfg(struct hns3_hw *hw, uint16_t nb_tx_q)
 	hw->tx_qnum_per_tc = tx_qnum_per_tc;
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
 		tc_queue = &hw->tc_queue[i];
-		if (hw->hw_tc_map & BIT(i) && i < hw->dcb_info.num_tc) {
+		if (hw->dcb_info.hw_tc_map & BIT(i) && i < hw->dcb_info.num_tc) {
 			tc_queue->enable = true;
 			tc_queue->tqp_offset = i * hw->tx_qnum_per_tc;
 			tc_queue->tqp_count = hw->tx_qnum_per_tc;
@@ -762,7 +762,7 @@ hns3_dcb_info_init(struct hns3_hw *hw)
 		if (i != 0)
 			continue;
 
-		hw->dcb_info.pg_info[i].tc_bit_map = hw->hw_tc_map;
+		hw->dcb_info.pg_info[i].tc_bit_map = hw->dcb_info.hw_tc_map;
 		for (k = 0; k < hw->dcb_info.num_tc; k++)
 			hw->dcb_info.pg_info[i].tc_dwrr[k] = BW_MAX_PERCENT;
 	}
@@ -1395,15 +1395,14 @@ static int
 hns3_dcb_info_cfg(struct hns3_adapter *hns)
 {
 	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
-	struct hns3_pf *pf = &hns->pf;
 	struct hns3_hw *hw = &hns->hw;
 	uint8_t tc_bw, bw_rest;
 	uint8_t i, j;
 	int ret;
 
 	dcb_rx_conf = &hw->data->dev_conf.rx_adv_conf.dcb_rx_conf;
-	pf->local_max_tc = (uint8_t)dcb_rx_conf->nb_tcs;
-	pf->pfc_max = (uint8_t)dcb_rx_conf->nb_tcs;
+	hw->dcb_info.local_max_tc = (uint8_t)dcb_rx_conf->nb_tcs;
+	hw->dcb_info.pfc_max = (uint8_t)dcb_rx_conf->nb_tcs;
 
 	/* Config pg0 */
 	memset(hw->dcb_info.pg_info, 0,
@@ -1412,7 +1411,7 @@ hns3_dcb_info_cfg(struct hns3_adapter *hns)
 	hw->dcb_info.pg_info[0].pg_id = 0;
 	hw->dcb_info.pg_info[0].pg_sch_mode = HNS3_SCH_MODE_DWRR;
 	hw->dcb_info.pg_info[0].bw_limit = hw->max_tm_rate;
-	hw->dcb_info.pg_info[0].tc_bit_map = hw->hw_tc_map;
+	hw->dcb_info.pg_info[0].tc_bit_map = hw->dcb_info.hw_tc_map;
 
 	/* Each tc has same bw for valid tc by default */
 	tc_bw = BW_MAX_PERCENT / hw->dcb_info.num_tc;
@@ -1482,7 +1481,7 @@ hns3_dcb_info_update(struct hns3_adapter *hns, uint8_t num_tc)
 		bit_map = 1;
 		hw->dcb_info.num_tc = 1;
 	}
-	hw->hw_tc_map = bit_map;
+	hw->dcb_info.hw_tc_map = bit_map;
 
 	return hns3_dcb_info_cfg(hns);
 }
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 6b8fd3383a..5af11d9228 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -1876,7 +1876,6 @@ hns3_check_mq_mode(struct rte_eth_dev *dev)
 	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
 	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct hns3_pf *pf = HNS3_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
 	struct rte_eth_dcb_tx_conf *dcb_tx_conf;
 	uint8_t num_tc;
@@ -1894,9 +1893,9 @@ hns3_check_mq_mode(struct rte_eth_dev *dev)
 	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
 	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
 	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
-		if (dcb_rx_conf->nb_tcs > pf->tc_max) {
+		if (dcb_rx_conf->nb_tcs > hw->dcb_info.tc_max) {
 			hns3_err(hw, "nb_tcs(%u) > max_tc(%u) driver supported.",
-				 dcb_rx_conf->nb_tcs, pf->tc_max);
+				 dcb_rx_conf->nb_tcs, hw->dcb_info.tc_max);
 			return -EINVAL;
 		}
 
@@ -2837,25 +2836,25 @@ hns3_get_board_configuration(struct hns3_hw *hw)
 		return ret;
 	}
 
-	pf->tc_max = cfg.tc_num;
-	if (pf->tc_max > HNS3_MAX_TC_NUM || pf->tc_max < 1) {
+	hw->dcb_info.tc_max = cfg.tc_num;
+	if (hw->dcb_info.tc_max > HNS3_MAX_TC_NUM || hw->dcb_info.tc_max < 1) {
 		PMD_INIT_LOG(WARNING,
 			     "Get TC num(%u) from flash, set TC num to 1",
-			     pf->tc_max);
-		pf->tc_max = 1;
+			     hw->dcb_info.tc_max);
+		hw->dcb_info.tc_max = 1;
 	}
 
 	/* Dev does not support DCB */
 	if (!hns3_dev_get_support(hw, DCB)) {
-		pf->tc_max = 1;
-		pf->pfc_max = 0;
+		hw->dcb_info.tc_max = 1;
+		hw->dcb_info.pfc_max = 0;
 	} else
-		pf->pfc_max = pf->tc_max;
+		hw->dcb_info.pfc_max = hw->dcb_info.tc_max;
 
 	hw->dcb_info.num_tc = 1;
 	hw->alloc_rss_size = RTE_MIN(hw->rss_size_max,
 				     hw->tqps_num / hw->dcb_info.num_tc);
-	hns3_set_bit(hw->hw_tc_map, 0, 1);
+	hns3_set_bit(hw->dcb_info.hw_tc_map, 0, 1);
 	pf->tx_sch_mode = HNS3_FLAG_TC_BASE_SCH_MODE;
 
 	pf->wanted_umv_size = cfg.umv_space;
@@ -3025,7 +3024,7 @@ hns3_tx_buffer_calc(struct hns3_hw *hw, struct hns3_pkt_buf_alloc *buf_alloc)
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
 		priv = &buf_alloc->priv_buf[i];
 
-		if (hw->hw_tc_map & BIT(i)) {
+		if (hw->dcb_info.hw_tc_map & BIT(i)) {
 			if (total_size < pf->tx_buf_size)
 				return -ENOMEM;
 
@@ -3076,7 +3075,7 @@ hns3_get_tc_num(struct hns3_hw *hw)
 	uint8_t i;
 
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++)
-		if (hw->hw_tc_map & BIT(i))
+		if (hw->dcb_info.hw_tc_map & BIT(i))
 			cnt++;
 	return cnt;
 }
@@ -3136,7 +3135,7 @@ hns3_get_no_pfc_priv_num(struct hns3_hw *hw,
 
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
 		priv = &buf_alloc->priv_buf[i];
-		if (hw->hw_tc_map & BIT(i) &&
+		if (hw->dcb_info.hw_tc_map & BIT(i) &&
 		    !(hw->dcb_info.hw_pfc_map & BIT(i)) && priv->enable)
 			cnt++;
 	}
@@ -3235,7 +3234,7 @@ hns3_rx_buf_calc_all(struct hns3_hw *hw, bool max,
 		priv->wl.high = 0;
 		priv->buf_size = 0;
 
-		if (!(hw->hw_tc_map & BIT(i)))
+		if (!(hw->dcb_info.hw_tc_map & BIT(i)))
 			continue;
 
 		priv->enable = 1;
@@ -3274,7 +3273,7 @@ hns3_drop_nopfc_buf_till_fit(struct hns3_hw *hw,
 	for (i = HNS3_MAX_TC_NUM - 1; i >= 0; i--) {
 		priv = &buf_alloc->priv_buf[i];
 		mask = BIT((uint8_t)i);
-		if (hw->hw_tc_map & mask &&
+		if (hw->dcb_info.hw_tc_map & mask &&
 		    !(hw->dcb_info.hw_pfc_map & mask)) {
 			/* Clear the no pfc TC private buffer */
 			priv->wl.low = 0;
@@ -3311,7 +3310,7 @@ hns3_drop_pfc_buf_till_fit(struct hns3_hw *hw,
 	for (i = HNS3_MAX_TC_NUM - 1; i >= 0; i--) {
 		priv = &buf_alloc->priv_buf[i];
 		mask = BIT((uint8_t)i);
-		if (hw->hw_tc_map & mask && hw->dcb_info.hw_pfc_map & mask) {
+		if (hw->dcb_info.hw_tc_map & mask && hw->dcb_info.hw_pfc_map & mask) {
 			/* Reduce the number of pfc TC with private buffer */
 			priv->wl.low = 0;
 			priv->enable = 0;
@@ -3369,7 +3368,7 @@ hns3_only_alloc_priv_buff(struct hns3_hw *hw,
 		priv->wl.high = 0;
 		priv->buf_size = 0;
 
-		if (!(hw->hw_tc_map & BIT(i)))
+		if (!(hw->dcb_info.hw_tc_map & BIT(i)))
 			continue;
 
 		priv->enable = 1;
@@ -5494,13 +5493,12 @@ static int
 hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
 {
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct hns3_pf *pf = HNS3_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	enum rte_eth_rx_mq_mode mq_mode = dev->data->dev_conf.rxmode.mq_mode;
 	int i;
 
 	rte_spinlock_lock(&hw->lock);
 	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
-		dcb_info->nb_tcs = pf->local_max_tc;
+		dcb_info->nb_tcs = hw->dcb_info.local_max_tc;
 	else
 		dcb_info->nb_tcs = 1;
 
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index e4160f6eae..d7a55c134f 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -130,7 +130,11 @@ struct hns3_tc_info {
 };
 
 struct hns3_dcb_info {
+	uint8_t tc_max;     /* max number of tc driver supported */
 	uint8_t num_tc;     /* Total number of enabled TCs */
+	uint8_t hw_tc_map;
+	uint8_t local_max_tc; /* max number of local tc */
+	uint8_t pfc_max;
 	uint8_t num_pg;     /* It must be 1 if vNET-Base schd */
 	uint8_t pg_dwrr[HNS3_PG_NUM];
 	uint8_t prio_tc[HNS3_MAX_USER_PRIO];
@@ -534,7 +538,6 @@ struct hns3_hw {
 	uint16_t rss_ind_tbl_size;
 	uint16_t rss_key_size;
 
-	uint8_t hw_tc_map;
 	enum hns3_fc_mode requested_fc_mode; /* FC mode requested by user */
 	struct hns3_dcb_info dcb_info;
 	enum hns3_fc_status current_fc_status; /* current flow control status */
@@ -831,9 +834,6 @@ struct hns3_pf {
 	uint16_t mps; /* Max packet size */
 
 	uint8_t tx_sch_mode;
-	uint8_t tc_max; /* max number of tc driver supported */
-	uint8_t local_max_tc; /* max number of local tc */
-	uint8_t pfc_max;
 	uint16_t pause_time;
 	bool support_fc_autoneg;       /* support FC autonegotiate */
 	bool support_multi_tc_pause;
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index 5f4ae1d979..1cb8a9ccc1 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -830,7 +830,7 @@ hns3vf_get_num_tc(struct hns3_hw *hw)
 	uint32_t i;
 
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
-		if (hw->hw_tc_map & BIT(i))
+		if (hw->dcb_info.hw_tc_map & BIT(i))
 			num_tc++;
 	}
 	return num_tc;
@@ -853,7 +853,7 @@ hns3vf_get_basic_info(struct hns3_hw *hw)
 	}
 
 	basic_info = (struct hns3_basic_info *)resp_msg;
-	hw->hw_tc_map = basic_info->hw_tc_map;
+	hw->dcb_info.hw_tc_map = basic_info->hw_tc_map;
 	hw->dcb_info.num_tc = hns3vf_get_num_tc(hw);
 	hw->pf_vf_if_version = basic_info->pf_vf_if_version;
 	hns3vf_update_caps(hw, basic_info->caps);
diff --git a/drivers/net/hns3/hns3_rss.c b/drivers/net/hns3/hns3_rss.c
index 3eae4caf52..508b3e26d0 100644
--- a/drivers/net/hns3/hns3_rss.c
+++ b/drivers/net/hns3/hns3_rss.c
@@ -940,13 +940,13 @@ hns3_set_rss_tc_mode_entry(struct hns3_hw *hw, uint8_t *tc_valid,
 			 * has to enable the unused TC by using TC0 queue
 			 * mapping configuration.
 			 */
-			tc_valid[i] = (hw->hw_tc_map & BIT(i)) ?
-					!!(hw->hw_tc_map & BIT(i)) : 1;
+			tc_valid[i] = (hw->dcb_info.hw_tc_map & BIT(i)) ?
+					!!(hw->dcb_info.hw_tc_map & BIT(i)) : 1;
 			tc_size[i] = roundup_size;
-			tc_offset[i] = (hw->hw_tc_map & BIT(i)) ?
+			tc_offset[i] = (hw->dcb_info.hw_tc_map & BIT(i)) ?
 					rss_size * i : 0;
 		} else {
-			tc_valid[i] = !!(hw->hw_tc_map & BIT(i));
+			tc_valid[i] = !!(hw->dcb_info.hw_tc_map & BIT(i));
 			tc_size[i] = tc_valid[i] ? roundup_size : 0;
 			tc_offset[i] = tc_valid[i] ? rss_size * i : 0;
 		}
-- 
2.33.0

