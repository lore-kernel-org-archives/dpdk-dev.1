Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E5DC531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:30:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52AFD40BA0;
	Thu, 23 Jul 2026 22:29:52 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id B78A440B92
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:49 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso865096a91.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838589;
 x=1785443389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ELBDAilgaoqGPgJBq/h8aJC7grLC8r2bjc97BlHVLA=;
 b=zyAcKkIEpR5HjG6KHxueGKmfkDF8Ok95L7RhQq9jaEo1COxF6aO4Mvw95ATqdaVvPQ
 16JIeB4qjvN/f4EdIi0sQXFJ3LMqur6moIvHD2I8Tk59gb88juTXnOGsQsXHNSB1gxH/
 6ZgQem3uSVvVhViEzauRIQMk/sUBd5BzvJERPV+iP1mYZjo4PSdbwKW6sxj4AlTP8l2a
 mRAGbPCo2DR+DiWhU5e97qm2ZUpv773Wu8PRUm/cKR7ca8ZmqMTejRvYv9BXCz4QvASR
 bkq5BJiR1joUvoGFkz9LwDO1SQfteB2MjE60HRfRtvNWELEuY8THqsCsXDCklar6wdqM
 BycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838589; x=1785443389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0ELBDAilgaoqGPgJBq/h8aJC7grLC8r2bjc97BlHVLA=;
 b=H0kHiecjknGoOfA1hqnw9AOhG70p45xKuHBoS9EAl3Dv7L9qRdhzCuSqgRUr00/EcT
 uq1ZeADrSrvdbfBW42FZAM5y9UMmyVxsj0VUg5D0DxaD48GKLSDKjUXZ40UAIsC6ZtO5
 nd7mYWkflzCl7Od6xh7M4JwUTxA5GxuG1MBN+o1dUxeo5FOcp6zWVATLKchtQfQiY9Qs
 9VS/UbFSTev6K1KUu79VrnQjg0Se9AMxcsTwgDrEkkXqkEbIaDOANcWo/Tb1dfa5NFQQ
 HdgfcVsuutlQ/0kXGo5QPoP9BscI637ODCTNV6pqjodHhYRyXh2xs+LKbdbYhkB1hdeI
 SHWA==
X-Gm-Message-State: AOJu0Yz06r2JzqAVvAjf3X22yHBKAH1zdzCr+rz+m1hD0DFD14b0Yjme
 CYLSI928uSP2iY01FutvDoacKHx6LfAuS561Uucb6AQyaQWH+lE7MHwFZGXndEO4CR6+DKhfVfh
 8Ye+E
X-Gm-Gg: AR+sD11sFYk0FMNnH9/9DtdsiikFsY++9TFZz53cEEFWWmcECcrPRB+jvasYvYAnVlQ
 8xwvwdjIXlTLPvEBdxN3KVZY1Srn/lYXFQJt0XU9II6Zu0eTvtOYbBa5WIkdkHZw5knyuwdYSeA
 1qxf+1AsJsxPKW7zcZbubs5Fp8pWARYaKT1VYKLKkT9TcgvYIwo+jGJsAdLRRE7xsYm6/zoBout
 xfZ5W6jaddksvYODauMceWdx0S1bLxIZ7yvXUcVqrbGGloAh+um+ZJSz+j91cHLlhpG5G5FjEX9
 5MCv2EcBZMgcdRO6dpIa9diUB1QXYnB9Qava+Nc552onlbO2XDmRkou7vNa1QZcDHC/I3LpBWpA
 vnQ9teVdO0ffuiW7uQVfEZspfPtgmWiCWKpqYkiQyzb0RZsH3pWA1WKjbYsHHyUtmd6cpHwNV8r
 hlh0KuwnahNKXgSOmyCisZCLfcWhaOgWi78uIUlAcgRQsqGgJPiAU=
X-Received: by 2002:a17:90b:3944:b0:38e:7268:220d with SMTP id
 98e67ed59e1d1-38ec65f99bcmr4546983a91.20.1784838588783; 
 Thu, 23 Jul 2026 13:29:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 8/9] net/sxe2: remove queue stats mapping
Date: Thu, 23 Jul 2026 13:28:13 -0700
Message-ID: <20260723202936.378793-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 99 --------------------------------
 drivers/net/sxe2/sxe2_cmd_chnl.h | 10 ----
 drivers/net/sxe2/sxe2_ethdev.c   |  5 --
 drivers/net/sxe2/sxe2_stats.c    | 76 +-----------------------
 drivers/net/sxe2/sxe2_stats.h    |  5 --
 5 files changed, 3 insertions(+), 192 deletions(-)

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
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
index 3ad8fe2fe9..27cd019c1a 100644
--- a/drivers/net/sxe2/sxe2_stats.c
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -497,90 +497,20 @@ int32_t sxe2_stats_hw_reset(struct rte_eth_dev *dev)
 
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
+	dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
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
-
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

