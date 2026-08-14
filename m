Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C616C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3E7A40689;
	Fri, 14 Aug 2026 22:20:31 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id CF67040697
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:30 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso1121394a91.1
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738830;
 x=1787343630; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNmwRcF+zZpW/Cn7NuFqEltIIrNIa5faa9nPdgmi7LI=;
 b=THtw5EHz+ldA+NQEMSMcQ9LEIP3AhIu6Hj16PS+F0QwVR/OlSRjeW8c2Neq1URYqc6
 HcMmwl/hjk/uwMd51e+FCynx7vhEkQUTIR4nETxWDtGMK0zev66VoQpyqTRLWD4pcP4A
 +2/eUsyirnQHsYlMh4q2TCFR5SJmHjr97NhX5N0Iea98nv5DYwCOHCnCS0osN1OL8uoV
 kU/tsQ2SWvZIv7RHOJDpiFs7T4/5Mwmb/PAJzCyhafBPtKzDH+PEhl2OhRU7XINqM0wP
 oY0ivjfqJ3LcKWQ7mMHgOjrBSl1u7yBxuhnHf7yTQXszWzMFH2jBtmwFgMIFz+k+M5v5
 /VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738830; x=1787343630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNmwRcF+zZpW/Cn7NuFqEltIIrNIa5faa9nPdgmi7LI=;
 b=q95L8LrmmBOv9/24SJF0TB/XJAAAC4WyAz4hJQ5NgX5U9/brGk1jTD02u4mAWyLKuy
 BNrKP+K/gOBOZkLByEcv5oM0W9RIDk7SafN0ITZT5j3kAG/94E9Fii5+TtxgwSzHZY6o
 oLIWgVyYd2qTjkKB9DFZqUcD2fmjZS7wC138dFys2TewPPwJOOiwJZblFd9UAT2uKovB
 jOdZtae4O6rE9V05huVwI5aTfcC0NlfBYlJNjvduGc3BR7R+6IS9jZ2OBC1S+8A6utg9
 7XtAkc7bGYUSxaANYmHMYUmZU1RB2o8SBaKM+zt3tMbUldUoZGOMbGHoyvvzlXfplRrX
 0WMw==
X-Gm-Message-State: AOJu0YwSro+esGf5pi/7DSk4ZAi5DKGepinYgAgykeYGmm2vyyb10G/L
 dMHPGVA+2RQcZPrTwZgXzn9l0+lSwS/zoDhL6rUpT8kUTLEFkctuB8yWenoAX4FNfMKCjBTUxYH
 itLly
X-Gm-Gg: AR+sD136wrDJjb4cY8OR96EntFWSLpAg6cC334sCpRm//euxS2H3DKS9UjUM3JSMGzx
 R1D66/v/hRKpnc9VQrzG6yfFCYT1t5GB21u8Cb3nE64hBfQonuvsEj1edPkzXnapHiIeap4yx9Z
 8ihA1ZmsIrpX3o5gV+dtOYr837xsygO8zlt18nL4ANaQaacOafKZsF0LbQH1qHi2lKpwnveXm6A
 nUVeT4fwdVi6T40ePAktp9Cyw8pjAQVqv6VGNNLvSfOJDa+HldnE+Hn5q653JniXBsEn3jVFHRM
 EMJn0MQBYn1mCREUg/9ZxsmFsbSDdMqN+C04kte/bIwE0RFKENrRi9WJn0nS4z17JBP4nv7G2VR
 xuPxn8NJD/gI39dh1VwszXSVB3WTj3WkX2WQNjKAvpvGr+ZoISEZMFPmNRTTk5SmG23E5RC0ZK0
 RUMU+sqWtYO9ptCS5EpOZbanXQebLlLaMnrBTYI/ufD7CWDDYVs47Ceqp8X3ApF6In52PHKY4nZ
 ykACVIr6Z9dAlKtgqMPko9yz20=
X-Received: by 2002:a17:90b:1850:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-3933b751fecmr9612712a91.5.1786738829920; 
 Fri, 14 Aug 2026 13:20:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v4 10/16] net/sxe2: remove queue stats mapping
Date: Fri, 14 Aug 2026 12:46:06 -0700
Message-ID: <20260814194757.329424-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The queue stats mapping API is removed in 26.11. Drop the
.queue_stats_mapping_set op and the SXE2_DEV_CAPS_OFFLOAD_Q_MAP
handling, along with the now-unused mapping init/reset helpers.

Per-queue stats are now reported one entry per configured queue
rather than one entry per stat mapping pool, so convert the
multi-process path as well. The qstats member of the shared payload
becomes an array large enough for every queue the primary can
report, and the secondary copies back the queue count in use
instead of a single entry.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 99 --------------------------------
 drivers/net/sxe2/sxe2_cmd_chnl.h | 10 ----
 drivers/net/sxe2/sxe2_ethdev.c   |  5 --
 drivers/net/sxe2/sxe2_mp.c       | 18 +++++-
 drivers/net/sxe2/sxe2_mp.h       |  7 ++-
 drivers/net/sxe2/sxe2_stats.c    | 76 +-----------------------
 drivers/net/sxe2/sxe2_stats.h    |  5 --
 7 files changed, 24 insertions(+), 196 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b09989fe50..050488301c 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -1609,105 +1609,6 @@ int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_
 	return ret;
 }
 
-int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx)
-{
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
-	int32_t ret = 0;
-	struct sxe2_common_device *cdev = adapter->cdev;
-	struct sxe2_drv_cmd_params param = {0};
-	struct sxe2_drv_rx_map_req req = {0};
-	struct sxe2_rx_queue *rxq = NULL;
-
-	rxq = eth_dev->data->rx_queues[queue_id];
-	if (rxq == NULL) {
-		PMD_LOG_ERR(DRV, "Rx queue %u is not available or setup",
-				queue_id);
-		ret = -EINVAL;
-		goto l_end;
-	}
-
-	req.queue_id = rxq->queue_id;
-	req.pool_idx = pool_idx;
-
-	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RX_MAP_SET,
-				 &req, sizeof(req),
-				 NULL, 0);
-
-	ret = sxe2_drv_cmd_exec(cdev, &param);
-	if (ret)
-		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
-
-l_end:
-	return ret;
-}
-
-int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx)
-{
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
-	int32_t ret = 0;
-	struct sxe2_common_device *cdev = adapter->cdev;
-	struct sxe2_drv_cmd_params param = {0};
-	struct sxe2_drv_tx_map_req req = {0};
-	struct sxe2_tx_queue *txq = NULL;
-
-	txq = eth_dev->data->tx_queues[queue_id];
-	if (txq == NULL) {
-		PMD_LOG_ERR(DRV, "Rx queue %u is not available or setup", queue_id);
-		ret = -EINVAL;
-		goto l_end;
-	}
-
-	req.queue_id = txq->queue_id;
-	req.pool_idx = pool_idx;
-
-	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_MAP_SET,
-				 &req, sizeof(req),
-				 NULL, 0);
-
-	ret = sxe2_drv_cmd_exec(cdev, &param);
-	if (ret)
-		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
-
-l_end:
-	return ret;
-}
-
-int32_t sxe2_drv_mapping_reset(struct rte_eth_dev *eth_dev)
-{
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
-	struct sxe2_drv_cmd_params param = {0};
-	struct sxe2_common_device *cdev = adapter->cdev;
-	int32_t ret;
-
-	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_RX_MAP_RESET,
-				 NULL, 0,
-				 NULL, 0);
-
-	ret = sxe2_drv_cmd_exec(cdev, &param);
-	if (ret)
-		PMD_LOG_ERR(DRV, "Reset queue mapping failed, ret=%d", ret);
-
-	return ret;
-}
-
-int32_t sxe2_drv_mapping_stats_info_clear(struct rte_eth_dev *eth_dev)
-{
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
-	struct sxe2_drv_cmd_params param = {0};
-	struct sxe2_common_device *cdev = adapter->cdev;
-	int32_t ret;
-
-	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_RX_MAP_INFO_CLEAR,
-				 NULL, 0,
-				 NULL, 0);
-
-	ret = sxe2_drv_cmd_exec(cdev, &param);
-	if (ret)
-		PMD_LOG_ERR(DRV, "Clear map stats info failed, ret=%d", ret);
-
-	return ret;
-}
-
 int32_t sxe2_drv_flow_filter_add(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
 {
 	struct sxe2_drv_flow_filter_req req = { 0 };
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index d63caad526..f43dcc8e7a 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -102,16 +102,6 @@ int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter,
 int32_t sxe2_drv_fc_state_get(struct sxe2_adapter *adapter,
 			      struct sxe2_drv_vsi_fc_get_resp *dev_fc_state_resp);
 
-int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
-
-int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
-
-int32_t sxe2_drv_mapping_reset(struct rte_eth_dev *eth_dev);
-
-int32_t sxe2_drv_mapping_stats_info_clear(struct rte_eth_dev *eth_dev);
-
-int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id, uint8_t pool_idx);
-
 int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
 
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 8bbfdc3a15..440411a65a 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -194,8 +194,6 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.xstats_get_names           = sxe2_xstats_names_get,
 	.xstats_reset               = sxe2_stats_info_reset,
 
-	.queue_stats_mapping_set    = sxe2_queue_stats_mapping_set,
-
 	.fw_version_get             = sxe2_fw_version_string_get,
 
 	.get_monitor_addr           = sxe2_get_monitor_addr,
@@ -1309,9 +1307,6 @@ static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
 		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_PTP;
 
-	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)
-		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_Q_MAP;
-
 	if (dev_caps->cap_flags & SXE2_DEV_CAPS_OFFLOAD_FC_STATE)
 		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_FC_STATE;
 }
diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
index a9598b6dd6..298a95ac7a 100644
--- a/drivers/net/sxe2/sxe2_mp.c
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -15,6 +15,11 @@
 #include "sxe2_stats.h"
 #include "sxe2_common_log.h"
 
+/* The shared qstats array must hold every queue the primary may write. */
+static_assert(SXE2_RXQ_STATS_MAP_MAX_NUM <= SXE2_MP_MAX_QSTATS &&
+	      SXE2_TXQ_STATS_MAP_MAX_NUM <= SXE2_MP_MAX_QSTATS,
+	      "shared qstats array too small for per-queue stats");
+
 static RTE_ATOMIC(uint16_t)primary_ethdev_cnt;
 static RTE_ATOMIC(uint16_t)secondary_ethdev_cnt;
 static const struct rte_memzone *sxe2_mp_mz;
@@ -65,9 +70,11 @@ sxe2_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 
 	switch (param->type) {
 	case SXE2_MP_REQ_GET_STATS:
+		memset(mz_data->payload.stats_blk.qstats, 0,
+		       sizeof(mz_data->payload.stats_blk.qstats));
 		ret = sxe2_stats_info_get(dev,
 					  &mz_data->payload.stats_blk.stats,
-					  &mz_data->payload.stats_blk.qstats);
+					  mz_data->payload.stats_blk.qstats);
 		break;
 	case SXE2_MP_REQ_GET_XSTATS:
 		cnt = sxe2_xstats_info_get(dev,
@@ -325,8 +332,13 @@ int32_t sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
 
 	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
 	memcpy(stats, &mz_data->payload.stats_blk.stats, sizeof(*stats));
-	if (qstats != NULL)
-		memcpy(qstats, &mz_data->payload.stats_blk.qstats, sizeof(*qstats));
+	if (qstats != NULL) {
+		uint16_t nb_queues = RTE_MAX(dev->data->nb_rx_queues,
+					     dev->data->nb_tx_queues);
+
+		memcpy(qstats, mz_data->payload.stats_blk.qstats,
+		       RTE_MIN(nb_queues, SXE2_MP_MAX_QSTATS) * sizeof(*qstats));
+	}
 	PMD_LOG_DEBUG(DRV, "sxe2_mp: stats received via IPC for port %u",
 			  dev->data->port_id);
 	ret = 0;
diff --git a/drivers/net/sxe2/sxe2_mp.h b/drivers/net/sxe2/sxe2_mp.h
index da9cc91d8d..aafe3cb1ba 100644
--- a/drivers/net/sxe2/sxe2_mp.h
+++ b/drivers/net/sxe2/sxe2_mp.h
@@ -10,6 +10,8 @@
 #include <rte_memzone.h>
 #include <rte_stdatomic.h>
 
+#include "sxe2_drv_cmd.h"
+
 #define SXE2_MP_NAME		"sxe2_mp_msg"
 #define SXE2_MP_MZ_NAME		"sxe2_stats_mz"
 
@@ -17,6 +19,9 @@
 
 #define SXE2_MP_MAX_XSTATS	128
 
+/* Must cover every queue the primary can report per-queue stats for. */
+#define SXE2_MP_MAX_QSTATS	SXE2_TXQ_STATS_MAP_MAX_NUM
+
 #define SXE2_MP_MAX_SPIN	100000
 
 enum sxe2_mp_req_type {
@@ -34,7 +39,7 @@ struct sxe2_mp_param {
 union sxe2_mp_shared_payload {
 	struct {
 		struct rte_eth_stats stats;
-		struct eth_queue_stats qstats;
+		struct eth_queue_stats qstats[SXE2_MP_MAX_QSTATS];
 	} stats_blk;
 	struct {
 		struct rte_eth_xstat xstats[SXE2_MP_MAX_XSTATS];
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
index 0e4857a906..74a2594099 100644
--- a/drivers/net/sxe2/sxe2_stats.c
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -499,90 +499,20 @@ int32_t sxe2_stats_hw_reset(struct rte_eth_dev *dev)
 
 int32_t sxe2_stats_info_reset(struct rte_eth_dev *dev)
 {
-	int32_t ret;
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
-
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		return sxe2_mp_req_reset_stats(dev);
 
-	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP) {
-		ret = sxe2_drv_mapping_stats_info_clear(dev);
-		if (ret)
-			goto l_end;
-	}
-
-	ret = sxe2_stats_hw_reset(dev);
-	if (ret)
-		goto l_end;
-
-l_end:
-	return ret;
+	return sxe2_stats_hw_reset(dev);
 }
 
 int32_t sxe2_stats_init(struct rte_eth_dev *dev)
 {
 	PMD_INIT_FUNC_TRACE();
-	int32_t ret;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	ret = sxe2_queue_stats_map_init(dev);
-	if (ret)
-		goto l_end;
-
-	ret = sxe2_stats_hw_reset(dev);
-	if (ret)
-		goto l_end;
-
-l_end:
-	return ret;
-}
-
-int32_t sxe2_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-				  uint16_t queue_id, uint8_t pool_idx, uint8_t is_rx)
-{
-	int32_t ret = -1;
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(eth_dev);
-
-	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)) {
-		PMD_LOG_ERR(DRV, "VF does not support queue mapping! ");
-		goto l_end;
-	}
-
-	if (is_rx)
-		ret = sxe2_drv_rxq_mapping_set(eth_dev, queue_id, pool_idx);
-	else
-		ret = sxe2_drv_txq_mapping_set(eth_dev, queue_id, pool_idx);
-
-	if (ret) {
-		PMD_LOG_ERR(DRV, "Queue stats mapping failed ! "
-			"queue_id:%u pool_idx:%u", queue_id, pool_idx);
-		goto l_end;
-	}
-
-	PMD_LOG_DEBUG(DRV, "port %u %s queue_id %d stat map to pool[%u] ",
-		     (uint16_t)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, pool_idx);
-l_end:
-	return ret;
-}
+	dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
-int32_t sxe2_queue_stats_map_init(struct rte_eth_dev *dev)
-{
-	int32_t ret = 0;
-	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
-
-	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP) {
-		dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
-
-		ret = sxe2_drv_mapping_reset(dev);
-		if (ret) {
-			PMD_LOG_ERR(DRV, "Queue stats mapping init failed !");
-			goto l_end;
-		}
-	}
-
-l_end:
-	return ret;
+	return sxe2_stats_hw_reset(dev);
 }
diff --git a/drivers/net/sxe2/sxe2_stats.h b/drivers/net/sxe2/sxe2_stats.h
index 64ac2bb11d..f9cb5a8225 100644
--- a/drivers/net/sxe2/sxe2_stats.h
+++ b/drivers/net/sxe2/sxe2_stats.h
@@ -31,9 +31,4 @@ int32_t sxe2_stats_info_reset(struct rte_eth_dev *dev);
 
 int32_t sxe2_stats_init(struct rte_eth_dev *dev);
 
-int32_t sxe2_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-				  uint16_t queue_id, uint8_t pool_idx, uint8_t is_rx);
-
-int32_t sxe2_queue_stats_map_init(struct rte_eth_dev *dev);
-
 #endif
-- 
2.53.0

