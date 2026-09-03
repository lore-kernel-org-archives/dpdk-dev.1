Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4380C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D899427A6;
	Thu,  3 Sep 2026 03:56:18 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id BAFE4427A6
 for <dev@dpdk.org>; Thu,  3 Sep 2026 03:56:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADH9kC205hqaBdABw--.24604S2;
 Thu, 03 Sep 2026 09:56:06 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 23/48] net/sxe2: rename fnav cid manager symbols to flow
Date: Thu,  3 Sep 2026 09:56:06 +0800
Message-ID: <20260903015606.162102-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADH9kC205hqaBdABw--.24604S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF13CryDtr4kGFW5CF43trb_yoWfKF1DpF
 4rJr13ZF48XF18ua13Jr4xuryagw18JryYkFyrCwnYya18AFsFkF15Ka15Aw13Cr4kA3s3
 t3y29r1DCa1kWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Rename the sxe2_fnav_cid_mgr, sxe2_fnav_cid_mgr_list_t,
sxe2_fnav_count_resource and sxe2_fnav_get_filter_cid symbols to the
sxe2_flow_* prefix for consistency with the flow module naming.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c    |  2 +-
 drivers/net/sxe2/sxe2_cmd_chnl.h    |  2 +-
 drivers/net/sxe2/sxe2_flow.c        | 46 ++++++++++++++---------------
 drivers/net/sxe2/sxe2_flow.h        |  6 ++--
 drivers/net/sxe2/sxe2_flow_define.h | 12 ++++----
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b09989fe50..3229c72597 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -1800,7 +1800,7 @@ int32_t sxe2_drv_flow_fnav_free_stat(struct sxe2_adapter *adapter, uint32_t stat
 }
 
 int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
-		struct sxe2_fnav_cid_mgr *mgr)
+		struct sxe2_flow_cid_mgr *mgr)
 {
 	struct sxe2_drv_flow_fnav_query_stat_req req = { 0 };
 	struct sxe2_drv_flow_fnav_query_stat_resp resp = { 0 };
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 294ac15db4..cfea1a1f0e 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -159,7 +159,7 @@ int32_t sxe2_drv_flow_fnav_get_stat_id(struct sxe2_adapter *adapter, uint32_t *s
 int32_t sxe2_drv_flow_fnav_free_stat(struct sxe2_adapter *adapter, uint32_t stat_id);
 
 int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
-		struct sxe2_fnav_cid_mgr *mgr);
+		struct sxe2_flow_cid_mgr *mgr);
 
 int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
 		uint16_t *vsi_list, uint16_t vsi_cnt, bool set);
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index cf54803301..a33b8606df 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -857,7 +857,7 @@ static int32_t sxe2_flow_rte_list_free(struct sxe2_adapter *adapter,
 	struct rte_flow *flow_temp = NULL;
 	struct sxe2_flow *hw_flow = NULL;
 	struct sxe2_flow *hw_flow_temp = NULL;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 	rte_spinlock_lock(&adapter->flow_ctxt.flow_list_lock);
 	TAILQ_FOREACH(flow_temp, &adapter->flow_ctxt.rte_flow_list, next) {
 		if (flow_temp == flow)
@@ -1028,7 +1028,7 @@ static struct rte_flow *sxe2_flow_create(struct rte_eth_dev *dev,
 		goto l_free_flow;
 
 	TAILQ_FOREACH(flow, &flow_list->sxe2_flow_list, next) {
-		ret = sxe2_fnav_get_filter_cid(adapter, flow);
+		ret = sxe2_flow_get_filter_cid(adapter, flow);
 		if (ret != 0) {
 			PMD_LOG_ERR(DRV, "fnav get stats id failed, ret:%d", ret);
 			rte_flow_error_set(error, EIO,
@@ -1088,16 +1088,16 @@ static int32_t sxe2_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *e
 	return ret;
 }
 
-int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
+int32_t sxe2_flow_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list =
+				&adapter->flow_ctxt.hw_res.flow_cid_mgr_list;
 	uint32_t stat_index;
 	uint32_t user_id;
 	uint32_t driver_id;
-	struct sxe2_fnav_cid_mgr *temp = NULL;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *temp = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 
 	if (sxe2_test_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types)) {
 		user_id = flow->action.count.user_id;
@@ -1112,7 +1112,7 @@ int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow
 		}
 		if (mgr == NULL) {
 			mgr = rte_zmalloc("sxe2_fnav_cid_mgr",
-				sizeof(struct sxe2_fnav_cid_mgr), 0);
+				sizeof(struct sxe2_flow_cid_mgr), 0);
 			if (!mgr) {
 				PMD_LOG_ERR(DRV,
 					"Failed to alloc sxe2vf_fnav_cid_mgr memory.");
@@ -1143,13 +1143,13 @@ int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow
 
 int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 		       struct sxe2_flow *flow,
-		       struct sxe2_fnav_cid_mgr **mgr_ptr,
+		       struct sxe2_flow_cid_mgr **mgr_ptr,
 		       struct rte_flow_error *error)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
-	struct sxe2_fnav_cid_mgr *mgr = *mgr_ptr;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list =
+				&adapter->flow_ctxt.hw_res.flow_cid_mgr_list;
+	struct sxe2_flow_cid_mgr *mgr = *mgr_ptr;
 	uint32_t user_id = flow->action.count.user_id;
 	if (user_id == 0) {
 		TAILQ_REMOVE(cid_mgr_list, mgr, next);
@@ -1170,14 +1170,14 @@ int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 
 int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
 			struct sxe2_flow *flow,
-			struct sxe2_fnav_cid_mgr **mgr_ptr,
+			struct sxe2_flow_cid_mgr **mgr_ptr,
 			struct rte_flow_error *error)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
-	struct sxe2_fnav_cid_mgr *temp = NULL;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list =
+				&adapter->flow_ctxt.hw_res.flow_cid_mgr_list;
+	struct sxe2_flow_cid_mgr *temp = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 	uint32_t user_id = flow->action.count.user_id;
 	uint32_t driver_id = flow->action.count.driver_id;
 
@@ -1218,7 +1218,7 @@ static int32_t sxe2_flow_query_count(struct sxe2_adapter *adapter,
 				 struct rte_flow_error *error)
 {
 	int32_t ret = 0;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
 	switch (flow->action.count.stat_ctrl) {
 	case SXE2_FNAV_STAT_ENA_NONE:
 		count->hits_set = 0;
@@ -1348,7 +1348,7 @@ int32_t sxe2_flow_init(struct rte_eth_dev *dev)
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	int32_t ret = 0;
 	TAILQ_INIT(&adapter->flow_ctxt.rte_flow_list);
-	TAILQ_INIT(&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list);
+	TAILQ_INIT(&adapter->flow_ctxt.hw_res.flow_cid_mgr_list);
 	if (adapter->devargs.fnav_stat_type)
 		adapter->flow_ctxt.hw_res.count_type =
 			adapter->devargs.fnav_stat_type;
@@ -1370,10 +1370,10 @@ int32_t sxe2_flow_uninit(struct rte_eth_dev *dev)
 	int32_t ret = 0;
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	struct rte_flow_error error;
-	struct sxe2_fnav_cid_mgr *mgr = NULL;
-	struct sxe2_fnav_cid_mgr *temp = NULL;
-	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
-						&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	struct sxe2_flow_cid_mgr *mgr = NULL;
+	struct sxe2_flow_cid_mgr *temp = NULL;
+	struct sxe2_flow_cid_mgr_list_t *cid_mgr_list =
+						&adapter->flow_ctxt.hw_res.flow_cid_mgr_list;
 
 	ret = sxe2_flow_flush(dev, &error);
 	if (ret)
diff --git a/drivers/net/sxe2/sxe2_flow.h b/drivers/net/sxe2/sxe2_flow.h
index daaeedd4dc..8d47b11ff4 100644
--- a/drivers/net/sxe2/sxe2_flow.h
+++ b/drivers/net/sxe2/sxe2_flow.h
@@ -14,16 +14,16 @@ int32_t sxe2_flow_init(struct rte_eth_dev *dev);
 
 int32_t sxe2_flow_uninit(struct rte_eth_dev *dev);
 
-int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
+int32_t sxe2_flow_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
 
 int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
 		       struct sxe2_flow *flow,
-		       struct sxe2_fnav_cid_mgr **mgr_ptr,
+		       struct sxe2_flow_cid_mgr **mgr_ptr,
 		       struct rte_flow_error *error);
 
 int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
 			struct sxe2_flow *flow,
-			struct sxe2_fnav_cid_mgr **mgr_ptr,
+			struct sxe2_flow_cid_mgr **mgr_ptr,
 			struct rte_flow_error *error);
 
 int32_t sxe2_flow_init_udp_tunnel_port(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_flow_define.h b/drivers/net/sxe2/sxe2_flow_define.h
index 263a573f04..8a5d871978 100644
--- a/drivers/net/sxe2/sxe2_flow_define.h
+++ b/drivers/net/sxe2/sxe2_flow_define.h
@@ -98,8 +98,8 @@ struct rte_flow {
 };
 TAILQ_HEAD(rte_flow_list_t, rte_flow);
 
-struct sxe2_fnav_cid_mgr {
-	TAILQ_ENTRY(sxe2_fnav_cid_mgr) next;
+struct sxe2_flow_cid_mgr {
+	TAILQ_ENTRY(sxe2_flow_cid_mgr) next;
 	uint16_t stat_index;
 	uint32_t user_id;
 	uint32_t driver_id;
@@ -107,18 +107,18 @@ struct sxe2_fnav_cid_mgr {
 	uint64_t hits;
 	uint64_t bytes;
 };
-TAILQ_HEAD(sxe2_fnav_cid_mgr_list_t, sxe2_fnav_cid_mgr);
+TAILQ_HEAD(sxe2_flow_cid_mgr_list_t, sxe2_flow_cid_mgr);
 
-struct sxe2_fnav_count_resource {
+struct sxe2_flow_count_resource {
 	uint32_t count_type;
 	uint32_t global_index;
-	struct sxe2_fnav_cid_mgr_list_t fnav_cid_mgr_list;
+	struct sxe2_flow_cid_mgr_list_t flow_cid_mgr_list;
 };
 
 struct sxe2_flow_context {
 	struct rte_flow_list_t rte_flow_list;
 	rte_spinlock_t flow_list_lock;
-	struct sxe2_fnav_count_resource hw_res;
+	struct sxe2_flow_count_resource hw_res;
 	uint16_t tunnel_port_list[SXE2_FLOW_UDP_TUNNEL_MAX];
 	uint32_t fnav_inited;
 };
-- 
2.52.0

