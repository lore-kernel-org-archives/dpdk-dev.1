Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EBE6816F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 139C340615;
	Tue, 17 Feb 2026 12:03:33 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id E372F402A2
 for <dev@dpdk.org>; Tue, 17 Feb 2026 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771326206;
 bh=nTufxS6JUGsI2KxA9dlLx6pzy0y9uzckS3xifj+a5vY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=esOXyciay8BxVgjfa1T8Qym2lKWx/iw4eHbM7ax8jU7QmYXl2roagKe+zcxdMafgF
 3vO60qwu4gkxnPpVtiKb0ir6XBUZSlmCrD7PEo0CoolIdK1I5EwXKKKjvhs0uaN+sR
 bh1BZa9o8Yeth+64rfZ02UTV4Y82yZTvA/KB6EfqMjb7bKd3BlYahoMVH410BKA/Xa
 noy+MsIOGdRUvxrcpA4FGm6mc4+eMDRkR2u17mW0I6zil4ZH7yqHEBD4A3qLwjs+Bg
 Jd9qkc1YnIxfaHBL2Ksk4/xW3mW3gPromlN37eXoD7gKpRQpKDVQPQ+mW4a49PZ0Q+
 RabSs7pgrlkiw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id C59211180142;
 Tue, 17 Feb 2026 12:03:26 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 5/6] net/nfb: support setting Rx MTU
Date: Tue, 17 Feb 2026 12:03:23 +0100
Message-ID: <20260217110324.3344310-6-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217110324.3344310-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260217110324.3344310-1-spinler@cesnet.cz>
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
The max MTU value is also reported in dev_info.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 doc/guides/rel_notes/release_26_03.rst |  4 +--
 drivers/net/nfb/nfb.h                  |  1 +
 drivers/net/nfb/nfb_ethdev.c           | 45 +++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index ac76ac5b67..7ce852e349 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -64,10 +64,10 @@ New Features
   * The timestamp value has been updated to make it usable.
   * The DPDK port now represents just one Ethernet port instead of all Ethernet ports on the NIC.
   * All ports are used by default, but a subset can be selected using the ``port`` argument.
-  * Report firmware version and correct Ethernet link speed.
+  * Report firmware version, correct Ethernet link speed and maximum capable MTU value.
   * Common CESNET-NDK-based adapters have been added,
     including the FB2CGHH (Silicom Denmark) and XpressSX AGI-FH400G (Reflex CES).
-  * Added support for configuration of the RS-FEC mode, Link Up / Link Down state.
+  * Added support for configuration of the RS-FEC mode, Link Up / Link Down state, and the Rx MTU.
 
 
 Removed Items
diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index 3b905bbb3b..7d192946bc 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -84,6 +84,7 @@ struct pmd_priv {
 	int             *queue_map_rx;
 	/** Mapping from DPDK TX queue index to firmware queue ID */
 	int             *queue_map_tx;
+	uint16_t        frame_len_max_cap;      /**< Maximum length obtained from Rx MAC */
 	bool ready;     /**< This structure is initialized for usage in secondary process */
 };
 
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index a556ceca67..1093c6edf4 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -51,6 +51,7 @@ static struct nfb_pmd_internals_head nfb_eth_dev_list =
 	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
 
 static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
+static int nfb_eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 
 static int
 nfb_mdio_read(void *priv, int prtad, int devad, uint16_t addr)
@@ -271,6 +272,10 @@ nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 	int ret;
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
+	ret = nfb_eth_mtu_set(dev, dev_conf->rxmode.mtu);
+	if (ret)
+		goto err_mtu_set;
+
 	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		ret = rte_mbuf_dyn_rx_timestamp_register
 				(&nfb_timestamp_dynfield_offset,
@@ -285,6 +290,7 @@ nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 	return 0;
 
 err_ts_register:
+err_mtu_set:
 	nfb_eth_dev_uninit(dev);
 	return ret;
 }
@@ -330,7 +336,8 @@ nfb_eth_dev_info(struct rte_eth_dev *dev,
 
 	dev_info->max_mac_addrs = nfb_eth_get_max_mac_address_count(dev);
 
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = priv->frame_len_max_cap;
+	dev_info->max_mtu = dev_info->max_rx_pktlen - (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN);
 	dev_info->max_rx_queues = priv->max_rx_queues;
 	dev_info->max_tx_queues = priv->max_tx_queues;
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_FIXED;
@@ -575,6 +582,39 @@ nfb_eth_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		nc_rxmac_set_mac(internals->rxmac[i], index, 0, 0);
 }
 
+static uint16_t
+nfb_mac_read_frame_len_max_cap(struct pmd_internals *intl)
+{
+	unsigned int i;
+	uint16_t ret = UINT16_MAX;
+	struct nc_rxmac_status status;
+
+	for (i = 0; i < intl->max_rxmac; ++i) {
+		status.frame_length_max_capable = 0;
+		nc_rxmac_read_status(intl->rxmac[i], &status);
+		if (status.frame_length_max_capable && ret > status.frame_length_max_capable)
+			ret = status.frame_length_max_capable;
+	}
+	return ret;
+}
+
+static int
+nfb_eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	unsigned int i;
+	struct pmd_internals *intl = dev->process_private;
+	struct pmd_priv *priv = dev->data->dev_private;
+
+	mtu += RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
+	if (mtu > priv->frame_len_max_cap || mtu < RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
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
@@ -690,6 +730,7 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_set = nfb_eth_mac_addr_set,
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
+	.mtu_set = nfb_eth_mtu_set,
 	.fw_version_get = nfb_eth_fw_version_get,
 	.fec_get = nfb_eth_fec_get,
 	.fec_set = nfb_eth_fec_set,
@@ -793,6 +834,8 @@ nfb_eth_dev_init(struct rte_eth_dev *dev, void *init_data)
 			}
 		}
 
+		priv->frame_len_max_cap = nfb_mac_read_frame_len_max_cap(internals);
+
 		/* Allocate space for MAC addresses */
 		mac_count = nfb_eth_get_max_mac_address_count(dev);
 		data->mac_addrs = rte_zmalloc(data->name,
-- 
2.53.0

