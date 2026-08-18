Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE24DC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC7A34069D;
	Tue, 18 Aug 2026 04:15:36 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 748BB4028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:15:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADHNUA8wINq+acKBg--.60494S10;
 Tue, 18 Aug 2026 10:15:27 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 08/13] net/sxe2: enhance repr event handling and  MP code
Date: Tue, 18 Aug 2026 10:15:13 +0800
Message-ID: <20260818021518.2922515-9-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHNUA8wINq+acKBg--.60494S10
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWrJr43WFyxWw13KryrCrg_yoW3XrW5pF
 WFgF1rXF18XF1Ivw13Aa18ZFnI9rWrJryUKFZIk34ft3WUtFy0yFW5tr90y3WFk3s8Zw1S
 ya17KF9rG3W7CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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
 drivers/net/sxe2/sxe2_irq.c | 27 +++++++++++++----
 drivers/net/sxe2/sxe2_mac.c | 10 ++-----
 drivers/net/sxe2/sxe2_mp.c  | 59 +++++++++++++++++++++----------------
 3 files changed, 58 insertions(+), 38 deletions(-)

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
index a4a5c76495..93a11150a9 100644
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
+		ret = -ENOENT;
 		goto out;
 	}
 
-- 
2.52.0

