Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8085C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7798340EE3;
	Tue,  8 Apr 2025 10:31:10 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 3F99040E4C
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZWzgL5vt6z1f1qB;
 Tue,  8 Apr 2025 16:26:06 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 45855140145;
 Tue,  8 Apr 2025 16:31:03 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:02 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 4/7] net/hns3: fix memory leakage for indirect action
Date: Tue, 8 Apr 2025 16:30:57 +0800
Message-ID: <20250408083100.2845040-5-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250408083100.2845040-1-huangdengdui@huawei.com>
References: <20250408083100.2845040-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Currently, when the application creates an indirect action,
the hns3 driver allocates a memory for the structure
rte_flow_action_handle and returns this structure pointer to
application. When the application invokes the destroy function
to destroy the indirect action, the driver releases the memory.

However, when the application destroys all flows by using the
flush function before destroying the indirect action, the memory
is not released. This patch fix it by using uint64_t instead of
rte_flow_action_handle* to store indirect action avoids memory
leakage.

Fixes: fdfcb94d8fb3 ("net/hns3: support indirect counter flow action")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_flow.c | 41 ++++++++++++++++--------------------
 drivers/net/hns3/hns3_flow.h |  9 ++++++--
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/hns3/hns3_flow.c b/drivers/net/hns3/hns3_flow.c
index 266934b45b..c0238d2bfa 100644
--- a/drivers/net/hns3/hns3_flow.c
+++ b/drivers/net/hns3/hns3_flow.c
@@ -473,19 +473,20 @@ hns3_handle_action_indirect(struct rte_eth_dev *dev,
 			    struct hns3_fdir_rule *rule,
 			    struct rte_flow_error *error)
 {
-	const struct rte_flow_action_handle *indir = action->conf;
+	struct rte_flow_action_handle indir;
 
-	if (indir->indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT)
+	indir.val64 = (uint64_t)action->conf;
+	if (indir.indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT)
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				action, "Invalid indirect type");
 
-	if (hns3_counter_lookup(dev, indir->counter_id) == NULL)
+	if (hns3_counter_lookup(dev, indir.counter_id) == NULL)
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				action, "Counter id not exist");
 
-	rule->act_cnt.id = indir->counter_id;
+	rule->act_cnt.id = indir.counter_id;
 	rule->flags |= (HNS3_RULE_FLAG_COUNTER | HNS3_RULE_FLAG_COUNTER_INDIR);
 
 	return 0;
@@ -2726,20 +2727,12 @@ hns3_flow_action_create(struct rte_eth_dev *dev,
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct hns3_pf *pf = HNS3_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	const struct rte_flow_action_count *act_count;
-	struct rte_flow_action_handle *handle = NULL;
+	struct rte_flow_action_handle handle;
 	struct hns3_flow_counter *counter;
 
 	if (hns3_check_indir_action(conf, action, error))
 		return NULL;
 
-	handle = rte_zmalloc("hns3 action handle",
-			     sizeof(struct rte_flow_action_handle), 0);
-	if (handle == NULL) {
-		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
-				   NULL, "Failed to allocate action memory");
-		return NULL;
-	}
-
 	pthread_mutex_lock(&hw->flows_lock);
 
 	act_count = (const struct rte_flow_action_count *)action->conf;
@@ -2762,15 +2755,14 @@ hns3_flow_action_create(struct rte_eth_dev *dev,
 	}
 
 	counter->indirect = true;
-	handle->indirect_type = HNS3_INDIRECT_ACTION_TYPE_COUNT;
-	handle->counter_id = counter->id;
+	handle.indirect_type = HNS3_INDIRECT_ACTION_TYPE_COUNT;
+	handle.counter_id = counter->id;
 
 	pthread_mutex_unlock(&hw->flows_lock);
-	return handle;
+	return (struct rte_flow_action_handle *)handle.val64;
 
 err_exit:
 	pthread_mutex_unlock(&hw->flows_lock);
-	rte_free(handle);
 	return NULL;
 }
 
@@ -2780,18 +2772,20 @@ hns3_flow_action_destroy(struct rte_eth_dev *dev,
 			 struct rte_flow_error *error)
 {
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_flow_action_handle indir;
 	struct hns3_flow_counter *counter;
 
 	pthread_mutex_lock(&hw->flows_lock);
 
-	if (handle->indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT) {
+	indir.val64 = (uint64_t)handle;
+	if (indir.indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT) {
 		pthread_mutex_unlock(&hw->flows_lock);
 		return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 					handle, "Invalid indirect type");
 	}
 
-	counter = hns3_counter_lookup(dev, handle->counter_id);
+	counter = hns3_counter_lookup(dev, indir.counter_id);
 	if (counter == NULL) {
 		pthread_mutex_unlock(&hw->flows_lock);
 		return rte_flow_error_set(error, EINVAL,
@@ -2806,8 +2800,7 @@ hns3_flow_action_destroy(struct rte_eth_dev *dev,
 				handle, "Counter id in use");
 	}
 
-	(void)hns3_counter_release(dev, handle->counter_id);
-	rte_free(handle);
+	(void)hns3_counter_release(dev, indir.counter_id);
 
 	pthread_mutex_unlock(&hw->flows_lock);
 	return 0;
@@ -2820,12 +2813,14 @@ hns3_flow_action_query(struct rte_eth_dev *dev,
 		 struct rte_flow_error *error)
 {
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_flow_action_handle indir;
 	struct rte_flow flow;
 	int ret;
 
 	pthread_mutex_lock(&hw->flows_lock);
 
-	if (handle->indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT) {
+	indir.val64 = (uint64_t)handle;
+	if (indir.indirect_type != HNS3_INDIRECT_ACTION_TYPE_COUNT) {
 		pthread_mutex_unlock(&hw->flows_lock);
 		return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF,
@@ -2833,7 +2828,7 @@ hns3_flow_action_query(struct rte_eth_dev *dev,
 	}
 
 	memset(&flow, 0, sizeof(flow));
-	flow.counter_id = handle->counter_id;
+	flow.counter_id = indir.counter_id;
 	ret = hns3_counter_query(dev, &flow,
 				 (struct rte_flow_query_count *)data, error);
 	pthread_mutex_unlock(&hw->flows_lock);
diff --git a/drivers/net/hns3/hns3_flow.h b/drivers/net/hns3/hns3_flow.h
index 1b49673f11..612890391d 100644
--- a/drivers/net/hns3/hns3_flow.h
+++ b/drivers/net/hns3/hns3_flow.h
@@ -50,8 +50,13 @@ enum {
 };
 
 struct rte_flow_action_handle {
-	int indirect_type;
-	uint32_t counter_id;
+	union {
+		uint64_t val64;
+		struct {
+			int indirect_type;
+			uint32_t counter_id;
+		};
+	};
 };
 
 union hns3_filter_conf {
-- 
2.33.0

