Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C820CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 06:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 078FA40651;
	Fri, 22 Aug 2025 08:04:35 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 3355740292
 for <dev@dpdk.org>; Fri, 22 Aug 2025 08:04:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c7V1r48lNz1R90b;
 Fri, 22 Aug 2025 14:01:36 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 7AB68140109;
 Fri, 22 Aug 2025 14:04:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 14:04:29 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 1/4] net/hns3: fix inconsistent lock
Date: Fri, 22 Aug 2025 14:04:26 +0800
Message-ID: <20250822060429.1799167-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250822060429.1799167-1-huangdengdui@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250822060429.1799167-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

The hns3 driver supports configuring RSS through both ops API and
rte_flow API. The ops API uses spink lock, while the rte_flow API uses
pthread mutex lock. When concurrent calls occur, issues may arise.
This patch replaces the lock in the flow API with spink lock.

Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.h |  2 --
 drivers/net/hns3/hns3_fdir.c   | 13 --------
 drivers/net/hns3/hns3_flow.c   | 60 +++++++++++++---------------------
 3 files changed, 22 insertions(+), 53 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index d602bfa02f..f6bb1b5d43 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -5,7 +5,6 @@
 #ifndef HNS3_ETHDEV_H
 #define HNS3_ETHDEV_H
 
-#include <pthread.h>
 #include <ethdev_driver.h>
 #include <rte_byteorder.h>
 #include <rte_io.h>
@@ -679,7 +678,6 @@ struct hns3_hw {
 
 	struct hns3_port_base_vlan_config port_base_vlan_cfg;
 
-	pthread_mutex_t flows_lock; /* rte_flow ops lock */
 	struct hns3_fdir_rule_list flow_fdir_list; /* flow fdir rule list */
 	struct hns3_rss_filter_list flow_rss_list; /* flow RSS rule list */
 	struct hns3_flow_mem_list flow_list;
diff --git a/drivers/net/hns3/hns3_fdir.c b/drivers/net/hns3/hns3_fdir.c
index aacad40e61..50572ae430 100644
--- a/drivers/net/hns3/hns3_fdir.c
+++ b/drivers/net/hns3/hns3_fdir.c
@@ -1145,17 +1145,6 @@ int hns3_restore_all_fdir_filter(struct hns3_adapter *hns)
 	if (hns->is_vf)
 		return 0;
 
-	/*
-	 * This API is called in the reset recovery process, the parent function
-	 * must hold hw->lock.
-	 * There maybe deadlock if acquire hw->flows_lock directly because rte
-	 * flow driver ops first acquire hw->flows_lock and then may acquire
-	 * hw->lock.
-	 * So here first release the hw->lock and then acquire the
-	 * hw->flows_lock to avoid deadlock.
-	 */
-	rte_spinlock_unlock(&hw->lock);
-	pthread_mutex_lock(&hw->flows_lock);
 	TAILQ_FOREACH(fdir_filter, &fdir_info->fdir_list, entries) {
 		ret = hns3_config_action(hw, &fdir_filter->fdir_conf);
 		if (!ret)
@@ -1166,8 +1155,6 @@ int hns3_restore_all_fdir_filter(struct hns3_adapter *hns)
 				break;
 		}
 	}
-	pthread_mutex_unlock(&hw->flows_lock);
-	rte_spinlock_lock(&hw->lock);
 
 	if (err) {
 		hns3_err(hw, "Fail to restore FDIR filter, ret = %d", ret);
diff --git a/drivers/net/hns3/hns3_flow.c b/drivers/net/hns3/hns3_flow.c
index c0238d2bfa..f2d1e4ec3a 100644
--- a/drivers/net/hns3/hns3_flow.c
+++ b/drivers/net/hns3/hns3_flow.c
@@ -2210,18 +2210,6 @@ hns3_reconfig_all_rss_filter(struct hns3_hw *hw)
 	return 0;
 }
 
-static int
-hns3_restore_rss_filter(struct hns3_hw *hw)
-{
-	int ret;
-
-	pthread_mutex_lock(&hw->flows_lock);
-	ret = hns3_reconfig_all_rss_filter(hw);
-	pthread_mutex_unlock(&hw->flows_lock);
-
-	return ret;
-}
-
 int
 hns3_restore_filter(struct hns3_adapter *hns)
 {
@@ -2232,7 +2220,7 @@ hns3_restore_filter(struct hns3_adapter *hns)
 	if (ret != 0)
 		return ret;
 
-	return hns3_restore_rss_filter(hw);
+	return hns3_reconfig_all_rss_filter(hw);
 }
 
 static int
@@ -2624,10 +2612,10 @@ hns3_flow_validate_wrap(struct rte_eth_dev *dev,
 	struct hns3_filter_info filter_info = {0};
 	int ret;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 	ret = hns3_flow_validate(dev, attr, pattern, actions, error,
 				 &filter_info);
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 
 	return ret;
 }
@@ -2641,9 +2629,9 @@ hns3_flow_create_wrap(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_flow *flow;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 	flow = hns3_flow_create(dev, attr, pattern, actions, error);
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 
 	return flow;
 }
@@ -2655,9 +2643,9 @@ hns3_flow_destroy_wrap(struct rte_eth_dev *dev, struct rte_flow *flow,
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int ret;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 	ret = hns3_flow_destroy(dev, flow, error);
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 
 	return ret;
 }
@@ -2668,9 +2656,9 @@ hns3_flow_flush_wrap(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int ret;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 	ret = hns3_flow_flush(dev, error);
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 
 	return ret;
 }
@@ -2683,9 +2671,9 @@ hns3_flow_query_wrap(struct rte_eth_dev *dev, struct rte_flow *flow,
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int ret;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 	ret = hns3_flow_query(dev, flow, actions, data, error);
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 
 	return ret;
 }
@@ -2733,7 +2721,7 @@ hns3_flow_action_create(struct rte_eth_dev *dev,
 	if (hns3_check_indir_action(conf, action, error))
 		return NULL;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 
 	act_count = (const struct rte_flow_action_count *)action->conf;
 	if (act_count->id >= pf->fdir.fd_cfg.cnt_num[HNS3_FD_STAGE_1]) {
@@ -2758,11 +2746,11 @@ hns3_flow_action_create(struct rte_eth_dev *dev,
 	handle.indirect_type = HNS3_INDIRECT_ACTION_TYPE_COUNT;
 	handle.counter_id = counter->id;
 
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 	return (struct rte_flow_action_handle *)handle.val64;
 
 err_exit:
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 	return NULL;
 }
 
@@ -2775,11 +2763,11 @@ hns3_flow_action_destroy(struct rte_eth_dev *dev,
 	struct rte_flow_action_handle indir;
 	struct hns3_flow_counter *counter;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 
 	indir.val64 = (uint64_t)handle;
 	if (indir.indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT) {
-		pthread_mutex_unlock(&hw->flows_lock);
+		rte_spinlock_unlock(&hw->lock);
 		return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 					handle, "Invalid indirect type");
@@ -2787,14 +2775,14 @@ hns3_flow_action_destroy(struct rte_eth_dev *dev,
 
 	counter = hns3_counter_lookup(dev, indir.counter_id);
 	if (counter == NULL) {
-		pthread_mutex_unlock(&hw->flows_lock);
+		rte_spinlock_unlock(&hw->lock);
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				handle, "Counter id not exist");
 	}
 
 	if (counter->ref_cnt > 1) {
-		pthread_mutex_unlock(&hw->flows_lock);
+		rte_spinlock_unlock(&hw->lock);
 		return rte_flow_error_set(error, EBUSY,
 				RTE_FLOW_ERROR_TYPE_HANDLE,
 				handle, "Counter id in use");
@@ -2802,7 +2790,7 @@ hns3_flow_action_destroy(struct rte_eth_dev *dev,
 
 	(void)hns3_counter_release(dev, indir.counter_id);
 
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 	return 0;
 }
 
@@ -2817,11 +2805,11 @@ hns3_flow_action_query(struct rte_eth_dev *dev,
 	struct rte_flow flow;
 	int ret;
 
-	pthread_mutex_lock(&hw->flows_lock);
+	rte_spinlock_lock(&hw->lock);
 
 	indir.val64 = (uint64_t)handle;
 	if (indir.indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT) {
-		pthread_mutex_unlock(&hw->flows_lock);
+		rte_spinlock_unlock(&hw->lock);
 		return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 					handle, "Invalid indirect type");
@@ -2831,7 +2819,7 @@ hns3_flow_action_query(struct rte_eth_dev *dev,
 	flow.counter_id = indir.counter_id;
 	ret = hns3_counter_query(dev, &flow,
 				 (struct rte_flow_query_count *)data, error);
-	pthread_mutex_unlock(&hw->flows_lock);
+	rte_spinlock_unlock(&hw->lock);
 	return ret;
 }
 
@@ -2865,14 +2853,10 @@ void
 hns3_flow_init(struct rte_eth_dev *dev)
 {
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	pthread_mutexattr_t attr;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return;
 
-	pthread_mutexattr_init(&attr);
-	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
-	pthread_mutex_init(&hw->flows_lock, &attr);
 	dev->data->dev_flags |= RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE;
 
 	TAILQ_INIT(&hw->flow_fdir_list);
-- 
2.33.0

