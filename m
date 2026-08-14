Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74929C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:22:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 328E54069D;
	Fri, 14 Aug 2026 14:22:23 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4691C40288
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S10;
 Fri, 14 Aug 2026 20:22:13 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 08/13] net/sxe2: enhance repre event handling and  MP code
Date: Fri, 14 Aug 2026 20:21:59 +0800
Message-ID: <20260814122204.2666045-9-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S10
X-Coremail-Antispam: 1UD129KBjvJXoW3ZFWUuw4xXw1UKw4ktFy7Wrg_yoWDWw4rpF
 4FgF15XF18XF1IvwnxJay8ZFnIgrWrJr1UKFZIy34fW3WUtF1rAF45tryYy3WYk3s8Ar1S
 ya17tFyDGa17uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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

This patch improves representor link state event handling and refactors
multi-process message processing:

- Add representor link state event propagation:
  * Propagate LSC events to all VF representors when PF link changes
  * Get link status and trigger callbacks for each representor
  * Only process in primary process for representor callbacks
  * Change OICR log format to hexadecimal for better readability

- Refactor primary process message handling:
  * Extract work logic to sxe2_mp_do_primary_work helper function
  * Use parameter copy to avoid side effects on original message
  * Simplify reply construction in primary handler

- Simplify statistics interface:
  * Remove qstats parameter from sxe2_mp_req_get_stats
  * Remove qstats copy from shared memory
  * Update function signature in header and implementation

- Improve error handling and cleanup:
  * Change error return from EINVAL to ENODATA when no response
  * Simplify sxe2_link_update_init error path
  * Remove unnecessary goto statements and cleanup labels
  * Remove extra whitespace

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_irq.c   | 27 ++++++++++++---
 drivers/net/sxe2/sxe2_mac.c   | 10 ++----
 drivers/net/sxe2/sxe2_mp.c    | 65 +++++++++++++++++++----------------
 drivers/net/sxe2/sxe2_mp.h    |  3 +-
 drivers/net/sxe2/sxe2_stats.c | 10 +++---
 5 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index 3306504761..7fe500b229 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -77,14 +77,32 @@ static int32_t sxe2_fc_state_callback(struct rte_eth_dev *dev)
 static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t oicr)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[adapter->dev_info.dev_data->port_id];
+	struct rte_eth_dev *repr_eth_dev;
+	struct sxe2_adapter *repr_adapter;
+	uint8_t vf_id;
 
 	if (oicr & RTE_BIT32(SXE2_COM_EC_LINK_CHG)) {
-		PMD_DEV_LOG_INFO(adapter, DRV, "OICR=%" PRIu64, oicr);
+		PMD_DEV_LOG_INFO(adapter, DRV, "OICR=0x%" PRIx64, oicr);
 		(void)sxe2_drv_mac_link_status_get(adapter);
-		if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			rte_eth_dev_callback_process(dev,
 						     RTE_ETH_EVENT_INTR_LSC,
 						     NULL);
+		}
+		if (adapter->switchdev_info.is_switchdev) {
+			for (vf_id = 0; vf_id < adapter->repr_ctxt.nb_repr_vf; vf_id++) {
+				repr_eth_dev = adapter->repr_ctxt.vf_rep_eth_dev[vf_id];
+				if (!repr_eth_dev)
+					continue;
+				repr_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(repr_eth_dev);
+				(void)sxe2_drv_mac_link_status_get(repr_adapter);
+				if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+					rte_eth_dev_callback_process(repr_eth_dev,
+								     RTE_ETH_EVENT_INTR_LSC,
+								     NULL);
+				}
+			}
+		}
 	}
 	if (oicr & RTE_BIT32(SXE2_COM_SW_MODE_SWITCHDEV)) {
 		PMD_DEV_LOG_INFO(adapter, DRV, "event notify switchdev");
@@ -863,12 +881,11 @@ static void sxe2_rxq_intr_unregister(struct rte_eth_dev *dev)
 			(void)sxe2_drv_dev_rxq_irq_set(adapter->cdev, i, &efd, 1);
 			sxe2_rxq_intr_efd_free(irq_ctxt->rxq_event_fd[i]);
 		}
+		rte_free(irq_ctxt->rxq_event_fd);
+		irq_ctxt->rxq_event_fd = NULL;
 	}
-	rte_free(irq_ctxt->rxq_event_fd);
-	irq_ctxt->rxq_event_fd = NULL;
 
 	rte_intr_vec_list_free(intr_handle);
-
 	rte_intr_nb_efd_set(intr_handle, 0);
 	rte_intr_max_intr_set(intr_handle, 0);
 }
diff --git a/drivers/net/sxe2/sxe2_mac.c b/drivers/net/sxe2/sxe2_mac.c
index 729c804ac3..e65c578262 100644
--- a/drivers/net/sxe2/sxe2_mac.c
+++ b/drivers/net/sxe2/sxe2_mac.c
@@ -448,20 +448,14 @@ int32_t sxe2_link_update_init(struct rte_eth_dev *dev)
 	int32_t ret;
 
 	PMD_INIT_FUNC_TRACE();
-
 	rte_spinlock_init(&adapter->link_ctxt.link_lock);
-
 	ret = sxe2_drv_mac_link_status_get(adapter);
-	if (ret) {
+	if (ret)
 		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get link status, ret=%d", ret);
-		goto l_end;
-	}
-
-	(void)sxe2_link_update(dev, 0);
 
-l_end:
 	return ret;
 }
+
 int32_t sxe2_link_update(struct rte_eth_dev *dev, __rte_unused int32_t wait_to_complete)
 {
 	struct rte_eth_link new_link;
diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
index a4a5c76495..78986dbf14 100644
--- a/drivers/net/sxe2/sxe2_mp.c
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -29,16 +29,11 @@ static int32_t sxe2_mp_secondary_handle(const struct rte_mp_msg *mp_msg,
 					 const void *peer);
 
 static int32_t
-sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+sxe2_mp_do_primary_work(struct sxe2_mp_param *param)
 {
-	struct rte_mp_msg reply;
-	const struct sxe2_mp_param *param =
-			(const struct sxe2_mp_param *)mp_msg->param;
-	struct sxe2_mp_param *reply_param = (struct sxe2_mp_param *)reply.param;
 	struct rte_eth_dev *dev;
-	int32_t ret = 0;
 	struct sxe2_mp_shared_data *mz_data;
-	int32_t send_reply = 0;
+	int32_t ret = 0;
 	int32_t cnt = 0;
 
 	if (!rte_eth_dev_is_valid_port(param->port_id)) {
@@ -49,24 +44,21 @@ sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	}
 
 	dev = &rte_eth_devices[param->port_id];
-	sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+
 	if (sxe2_mp_mz == NULL) {
-		PMD_LOG_ERR(DRV, "Failed to lookup memzone %s", SXE2_MP_MZ_NAME);
-		ret = -ENOENT;
-		goto out;
+		sxe2_mp_mz = rte_memzone_lookup(SXE2_MP_MZ_NAME);
+		if (sxe2_mp_mz == NULL) {
+			PMD_LOG_ERR(DRV, "Failed to lookup memzone %s",
+					SXE2_MP_MZ_NAME);
+			ret = -ENOENT;
+			goto out;
+		}
 	}
 
 	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
-	send_reply = 1;
-
-	memset(&reply, 0, sizeof(reply));
-	(void)strlcpy(reply.name, SXE2_MP_NAME, sizeof(reply.name));
-	reply.len_param = sizeof(*reply_param);
-
 	switch (param->type) {
 	case SXE2_MP_REQ_GET_STATS:
-		ret = sxe2_stats_info_get(dev,
-					  &mz_data->payload.stats_blk.stats,
+		ret = sxe2_stats_info_get(dev, &mz_data->payload.stats_blk.stats,
 					  &mz_data->payload.stats_blk.qstats);
 		break;
 	case SXE2_MP_REQ_GET_XSTATS:
@@ -88,15 +80,32 @@ sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	default:
 		PMD_LOG_ERR(DRV, "primary process: unrecognized msg type: %d",
 				param->type);
-		send_reply = false;
 		ret = -EINVAL;
-		goto out;
+		break;
 	}
+
 out:
-	if (!send_reply)
-		return ret;
+	param->result = ret;
+	return ret;
+}
 
-	reply_param->result = ret;
+static int32_t
+sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct rte_mp_msg reply;
+	struct sxe2_mp_param *reply_param = (struct sxe2_mp_param *)reply.param;
+	const struct sxe2_mp_param *param =
+			(const struct sxe2_mp_param *)mp_msg->param;
+	struct sxe2_mp_param param_copy;
+
+	memset(&reply, 0, sizeof(reply));
+	(void)strlcpy(reply.name, SXE2_MP_NAME, sizeof(reply.name));
+	reply.len_param = sizeof(*reply_param);
+
+	param_copy = *param;
+	(void)sxe2_mp_do_primary_work(&param_copy);
+
+	reply_param->result = param_copy.result;
 	reply_param->type = param->type;
 	reply_param->port_id = param->port_id;
 
@@ -275,7 +284,7 @@ int32_t sxe2_mp_request_simple(struct rte_eth_dev *dev,
 	if (reply.nb_received == 0) {
 		PMD_LOG_ERR(DRV, "No response received from primary for type=%d, port %u",
 			type, dev->data->port_id);
-		ret = -EINVAL;
+		ret = -ENODATA;
 		goto out;
 	}
 
@@ -289,8 +298,7 @@ int32_t sxe2_mp_request_simple(struct rte_eth_dev *dev,
 }
 
 int32_t sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
-		      struct rte_eth_stats *stats,
-		      struct eth_queue_stats *qstats)
+		      struct rte_eth_stats *stats)
 {
 	struct sxe2_mp_shared_data *mz_data;
 	int32_t mp_ret;
@@ -303,7 +311,7 @@ int32_t sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		PMD_LOG_WARN(DRV, "Primary process direct execution for port %u",
 			     dev->data->port_id);
-		return sxe2_stats_info_get(dev, stats, qstats);
+		return sxe2_stats_info_get(dev, stats, NULL);
 	}
 
 	int32_t token_ret = sxe2_mp_acquire_token();
@@ -325,7 +333,6 @@ int32_t sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
 
 	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
 	memcpy(stats, &mz_data->payload.stats_blk.stats, sizeof(*stats));
-	memcpy(qstats, &mz_data->payload.stats_blk.qstats, sizeof(*qstats));
 	PMD_LOG_DEBUG(DRV, "sxe2_mp: stats received via IPC for port %u",
 			  dev->data->port_id);
 	ret = 0;
diff --git a/drivers/net/sxe2/sxe2_mp.h b/drivers/net/sxe2/sxe2_mp.h
index da9cc91d8d..1f779a1332 100644
--- a/drivers/net/sxe2/sxe2_mp.h
+++ b/drivers/net/sxe2/sxe2_mp.h
@@ -56,8 +56,7 @@ int sxe2_mp_request_simple(struct rte_eth_dev *dev,
 			   int *result_out);
 
 int sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
-			  struct rte_eth_stats *stats,
-			  struct eth_queue_stats *qstats);
+			  struct rte_eth_stats *stats);
 
 int sxe2_mp_req_get_xstats(struct rte_eth_dev *dev,
 			   struct rte_eth_xstat *xstats, uint32_t usr_cnt);
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
index 3ad8fe2fe9..b91d8d1555 100644
--- a/drivers/net/sxe2/sxe2_stats.c
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -318,7 +318,7 @@ int32_t sxe2_stats_info_get(struct rte_eth_dev *dev,
 	struct sxe2_stats   *stats_out = &vsi->vsi_stats.stats;
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-		return sxe2_mp_req_get_stats(dev, stats, qstats);
+		return sxe2_mp_req_get_stats(dev, stats);
 
 	ret = sxe2_vsi_hw_stats_get_update(adapter);
 	if (ret)
@@ -328,9 +328,11 @@ int32_t sxe2_stats_info_get(struct rte_eth_dev *dev,
 	if (ret)
 		goto end;
 
-	ret = sxe2_drv_queue_info_get_update(adapter, qstats);
-	if (ret)
-		goto end;
+	if (qstats) {
+		ret = sxe2_drv_queue_info_get_update(adapter, qstats);
+		if (ret)
+			goto end;
+	}
 
 	sxe2_stats_update(adapter);
 
-- 
2.52.0

