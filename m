Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7283BCD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 12:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9AAA4060A;
	Wed,  6 May 2026 14:36:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4E5C2402D1
 for <dev@dpdk.org>; Wed,  6 May 2026 14:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778070981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tj0EZIObPYqkZhFKiRoe0cv83O0mTj+Wv4hL6GRui5o=;
 b=MhwrEoyWaMXpfw+OEifDONRW9RgiQbV6OeaUp8sd0zvByMz5UKlZ1Ucp95Odd4eHi/cU++
 N2GJiYnPE+XxWw3fk+X+kMQCaJdwRz9nFhw3lQs82lGNETpQq+i4SRSBoUYmt9/MY3Piyt
 hX5OfXKZoneM1+Wie9pJOvt+Tfl+LHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-0Kt7Hn0fOZCqbvUbNelNxQ-1; Wed,
 06 May 2026 08:36:18 -0400
X-MC-Unique: 0Kt7Hn0fOZCqbvUbNelNxQ-1
X-Mimecast-MFC-AGG-ID: 0Kt7Hn0fOZCqbvUbNelNxQ_1778070976
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADB221800451; Wed,  6 May 2026 12:36:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DA813002D2F; Wed,  6 May 2026 12:36:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 2/5] ethdev: announce VMDq capability
Date: Wed,  6 May 2026 14:35:50 +0200
Message-ID: <20260506123554.2524136-3-david.marchand@redhat.com>
In-Reply-To: <20260506123554.2524136-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260506123554.2524136-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pFtHArWGTZZFDgK6FaInO_Ip0uKg9V3lwKyNhjrsiiA_1778070976
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Let's mark VMDq feature availability as a per device capability.
We can then enforce API calls related to this feature are done on device
with such capability.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,

---
 drivers/net/bnxt/bnxt_ethdev.c         |  3 ++-
 drivers/net/intel/e1000/igb_ethdev.c   |  1 +
 drivers/net/intel/fm10k/fm10k_ethdev.c |  1 +
 drivers/net/intel/i40e/i40e_ethdev.c   |  3 ++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 ++
 drivers/net/txgbe/txgbe_ethdev.c       |  1 +
 drivers/net/txgbe/txgbe_ethdev_vf.c    |  1 +
 lib/ethdev/rte_ethdev.c                | 17 +++++++++++++++++
 lib/ethdev/rte_ethdev.h                |  2 ++
 9 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..0f783b9e98 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1214,7 +1214,8 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 
 	dev_info->speed_capa = bnxt_get_speed_capabilities(bp);
 	dev_info->dev_capa = RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
-			     RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
+			     RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
+			     RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->default_rxconf = (struct rte_eth_rxconf) {
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index ef1599ac38..fe68c18417 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -2324,6 +2324,7 @@ eth_igb_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->tx_queue_offload_capa = igb_get_tx_queue_offloads_capa(dev);
 	dev_info->tx_offload_capa = igb_get_tx_port_offloads_capa(dev) |
 				    dev_info->tx_queue_offload_capa;
+	dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	switch (hw->mac.type) {
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 97f61afec2..037d2206fd 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1444,6 +1444,7 @@ fm10k_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
 			RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
 			RTE_ETH_LINK_SPEED_40G | RTE_ETH_LINK_SPEED_100G;
+	dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
 
 	return 0;
 }
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 100a751225..64c29c6e85 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -3878,7 +3878,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 
 	dev_info->dev_capa =
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
-		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
+		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
+		RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->hash_key_size = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..5d886b3e28 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3997,6 +3997,7 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_mtu =  dev_info->max_rx_pktlen - IXGBE_ETH_OVERHEAD;
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 	dev_info->vmdq_queue_num = dev_info->max_rx_queues;
+	dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->rx_queue_offload_capa = ixgbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (ixgbe_get_rx_port_offloads(dev) |
 				     dev_info->rx_queue_offload_capa);
@@ -4115,6 +4116,7 @@ ixgbevf_dev_info_get(struct rte_eth_dev *dev,
 		dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
 	else
 		dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
+	dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->rx_queue_offload_capa = ixgbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (ixgbe_get_rx_port_offloads(dev) |
 				     dev_info->rx_queue_offload_capa);
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 5d360f8305..bd818e8269 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2836,6 +2836,7 @@ txgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_vfs = pci_dev->max_vfs;
 	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
 	dev_info->vmdq_queue_num = dev_info->max_rx_queues;
+	dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 	dev_info->rx_queue_offload_capa = txgbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (txgbe_get_rx_port_offloads(dev) |
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 39a5fff65c..934763574c 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -572,6 +572,7 @@ txgbevf_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_hash_mac_addrs = TXGBE_VMDQ_NUM_UC_MAC;
 	dev_info->max_vfs = pci_dev->max_vfs;
 	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
+	dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 	dev_info->rx_queue_offload_capa = txgbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (txgbe_get_rx_port_offloads(dev) |
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9577b7d848..7ba539e796 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -158,6 +158,7 @@ static const struct {
 	{RTE_ETH_DEV_CAPA_RXQ_SHARE, "RXQ_SHARE"},
 	{RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP, "FLOW_RULE_KEEP"},
 	{RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP, "FLOW_SHARED_OBJECT_KEEP"},
+	{RTE_ETH_DEV_CAPA_VMDQ, "VMDQ"},
 };
 
 enum {
@@ -1581,6 +1582,22 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+	if (!(dev_info.dev_capa & RTE_ETH_DEV_CAPA_VMDQ)) {
+		if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support VMDq rx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+		if (dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
+				dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support VMDq tx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+	}
+
 	/*
 	 * Setup new number of Rx/Tx queues and reconfigure device.
 	 */
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..62c72de0e5 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1696,6 +1696,8 @@ struct rte_eth_conf {
 #define RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP         RTE_BIT64(3)
 /** Device supports keeping shared flow objects across restart. */
 #define RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP RTE_BIT64(4)
+/** Device supports VMDq. */
+#define RTE_ETH_DEV_CAPA_VMDQ RTE_BIT64(5)
 /**@}*/
 
 /*
-- 
2.53.0

