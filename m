Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC883D44C48
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA0D241153;
	Thu, 15 Jan 2026 15:01:58 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 4259C40E45;
 Thu, 15 Jan 2026 15:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768485717;
 bh=yHyiRhEnXeZ1npruFOtaPe22iXCMiiEj1teBUBeNK14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=G+3ygBFt0mc05aj+abWeoPhPp1EPoUv3qVGN4Hj2tKPuu84TeJ4rUQ5+/dDfux41h
 sc0hdUWQutI/nwmzd1KGeJtWd0hdLP6/A6xcjxGDVeXVAbVKRTLn8MnDgeFTTXKF4U
 nWrIKRe2DSxILg5otQuxPNXUNLTPj/j1T4tD3DGVcXEbCQe1hQdOS+guYK4Yx3g73b
 X4ieVPlIpqi2ZnxYTX295JUwwMDWjf3oflIpqhGdPOEBa86XZGU+19wWAF02zUmxSJ
 cepQZ874shpUSxSOqrfuZxv7Ii/FKdSwWPnulKiKzdMrheNAfdJDh7lBx3HHnH2h0h
 DV6Fs3k8TzHsA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 079611180078;
 Thu, 15 Jan 2026 15:01:57 +0100 (CET)
From: spinler@cesnet.cz
To: spinler@cesnet.cz
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: [PATCH 1/6] net/nfb: use constant values for max Rx/Tx queues count
Date: Thu, 15 Jan 2026 15:01:29 +0100
Message-ID: <20260115140134.235877-2-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115140134.235877-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

The nb_xx_queues values in the dev->data structure can be modified
dynamicaly by some apps. Use runtime-constant values from hardware
directly for max_rx_queues/max_tx_queues.

Fixes: 6435f9a0ac ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  3 +++
 drivers/net/nfb/nfb_ethdev.c | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index a8b24ff822..8f8577860a 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -48,6 +48,9 @@ struct pmd_internals {
 	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
 	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
 	struct nfb_device *nfb;
+
+	int max_rx_queues;
+	int max_tx_queues;
 };
 
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 98119d70fd..7a472a5f1e 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -237,11 +237,13 @@ static int
 nfb_eth_dev_info(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+
 	dev_info->max_mac_addrs = nfb_eth_get_max_mac_address_count(dev);
 
 	dev_info->max_rx_pktlen = (uint32_t)-1;
-	dev_info->max_rx_queues = dev->data->nb_rx_queues;
-	dev_info->max_tx_queues = dev->data->nb_tx_queues;
+	dev_info->max_rx_queues = internals->max_rx_queues;
+	dev_info->max_tx_queues = internals->max_tx_queues;
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_100G;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
@@ -538,8 +540,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
 		return -EINVAL;
 	}
-	data->nb_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
-	data->nb_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
+	internals->max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
+	internals->max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
 
 	NFB_LOG(INFO, "Available NDP queues RX: %u TX: %u",
 		data->nb_rx_queues, data->nb_tx_queues);
-- 
2.52.0

