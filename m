Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D2C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD3542DB0;
	Wed, 21 Jan 2026 18:02:00 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 29872427C5;
 Wed, 21 Jan 2026 18:01:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769014917;
 bh=0Q+iNvpyos1p5BHLGOKlxkXojU0xFF7d/c2ZvCvjWhw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C9n5wxzD7zLC5OlDhiFPxvP5rvRd6T+S+EupJP33MzFtwWUHskuiWs4if6ulDMe8P
 aQdqZs8p/w2ByvTpoQcRgDztvl7KQfla7X9ywi2X88/Su8/n0V+dkXuzIEXu2BPv3i
 lJ7+gsssHRBX1Sz4F+4pV7kxPYWjXAgGUR/EYstKeCplK0V6zo5T87+60kcUWCPYgY
 dNpZmuUtSpngCchopiLoBQnDBGNBZmOaIQld2dqaWA5iASsFhLuOqvBgS6jy+rsFHn
 U8fsQ5DvzGpRN6ml7fK8jEuRR6XFuF6X0r52NyQO0WVLXZQpOwVcZ7kwr2fKtqd2iO
 ByJxhUgzRDTnQ==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id E30F21180078;
 Wed, 21 Jan 2026 18:01:57 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>,
	stable@dpdk.org
Subject: [PATCH v4 1/6] net/nfb: use constant values for max Rx/Tx queues count
Date: Wed, 21 Jan 2026 18:01:15 +0100
Message-ID: <20260121170120.268553-2-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121170120.268553-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
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
dynamically by some apps. Use runtime-constant values from hardware
directly for max_rx_queues/max_tx_queues.

Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        |  3 +++
 drivers/net/nfb/nfb_ethdev.c | 12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index a8b24ff822..917b830283 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -48,6 +48,9 @@ struct pmd_internals {
 	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
 	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
 	struct nfb_device *nfb;
+
+	uint16_t max_rx_queues;
+	uint16_t max_tx_queues;
 };
 
 #endif /* _NFB_H_ */
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 5f1b11a961..feba06a291 100644
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
@@ -538,11 +540,11 @@ nfb_eth_dev_init(struct rte_eth_dev *dev)
 		NFB_LOG(ERR, "nfb_open(): failed to open %s", nfb_dev);
 		return -EINVAL;
 	}
-	data->nb_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
-	data->nb_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
+	internals->max_rx_queues = ndp_get_rx_queue_available_count(internals->nfb);
+	internals->max_tx_queues = ndp_get_tx_queue_available_count(internals->nfb);
 
 	NFB_LOG(INFO, "Available NDP queues RX: %u TX: %u",
-		data->nb_rx_queues, data->nb_tx_queues);
+		internals->max_rx_queues, internals->max_tx_queues);
 
 	nfb_nc_rxmac_init(internals->nfb,
 		internals->rxmac,
-- 
2.52.0

