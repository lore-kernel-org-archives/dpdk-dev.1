Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94751EE20B6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD774065E;
	Fri,  6 Feb 2026 18:04:45 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 9545840156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397479;
 bh=I+eek92qVagVdXqLzYBqEVASZtNDqj6amBbC/LKyV84=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZH0KXpTWQ6Zfx2P8G55sclA6g/et3pq1idH/oV6uM1BKagtU4yATKqFRMBOQrARlD
 GAwYILNRL4sIfRvggXsmanZu5uSAziUSaQAGhC+16f5/K8kdJhJTOjVES9pRkSrVe0
 emM4qS1CXwQbpOGHILmW+TqbQ+leHW+0+FUTxiMf12JqoAfTngSr+6epZfT+dUl66p
 EZIXhdH9YiVtNYxlF/Gj0JM16y+PAhiyI3fiTf8Kd8ZhNpkl8FYjOE/BxdYSDevRJZ
 rWTOwz4OyP/kGxZdPBIzPHrY2YtDEzxEeyJJkG19uE/SLT8ZmjHQH5l9qiewhYvOk3
 Qb1z1I8fW6Abg==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 788C71180078;
 Fri,  6 Feb 2026 18:04:39 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 5/7] net/nfb: support setting Rx MTU
Date: Fri,  6 Feb 2026 18:04:33 +0100
Message-ID: <20260206170435.302184-6-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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

Enable configuration of the MTU on the Rx MAC assigned to the port.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index b927d006e7..b4bd98e08c 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -49,6 +49,7 @@ static struct nfb_pmd_internals_head nfb_eth_dev_list =
 	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
 
 static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
+static int nfb_eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 
 static int
 nfb_mdio_read(void *priv, int prtad, int devad, uint16_t addr)
@@ -255,6 +256,10 @@ nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 	int ret;
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
+	ret = nfb_eth_mtu_set(dev, dev_conf->rxmode.mtu);
+	if (ret)
+		goto err_mtu_set;
+
 	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		ret = rte_mbuf_dyn_rx_timestamp_register
 				(&nfb_timestamp_dynfield_offset,
@@ -269,6 +274,7 @@ nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 	return 0;
 
 err_ts_register:
+err_mtu_set:
 	nfb_eth_dev_uninit(dev);
 	return ret;
 }
@@ -549,6 +555,38 @@ nfb_eth_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		nc_rxmac_set_mac(internals->rxmac[i], index, 0, 0);
 }
 
+static int
+nfb_eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	unsigned int i;
+	struct nc_rxmac_status status;
+	struct pmd_internals *intl = dev->process_private;
+	uint16_t frame_length_max_capable;
+
+	mtu += RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
+
+	if (!intl->max_rxmac)
+		return 0;
+
+	status.frame_length_max_capable = 0;
+	nc_rxmac_read_status(intl->rxmac[0], &status);
+	frame_length_max_capable = status.frame_length_max_capable;
+
+	for (i = 1; i < intl->max_rxmac; ++i) {
+		nc_rxmac_read_status(intl->rxmac[i], &status);
+		if (frame_length_max_capable > status.frame_length_max_capable)
+			frame_length_max_capable = status.frame_length_max_capable;
+	}
+
+	if (frame_length_max_capable < mtu && frame_length_max_capable != 0)
+		return -EINVAL;
+
+	for (i = 0; i < intl->max_rxmac; ++i)
+		nc_rxmac_set_frame_length(intl->rxmac[i], mtu, RXMAC_FRAME_LENGTH_MAX);
+
+	return 0;
+}
+
 static int
 nfb_eth_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 		size_t fw_size)
@@ -661,6 +699,7 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_set = nfb_eth_mac_addr_set,
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
+	.mtu_set = nfb_eth_mtu_set,
 	.fw_version_get = nfb_eth_fw_version_get,
 	.fec_get = nfb_eth_fec_get,
 	.fec_set = nfb_eth_fec_set,
-- 
2.53.0

