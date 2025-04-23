Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A9EC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9D4C40E48;
	Wed, 23 Apr 2025 18:00:54 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B3AC040DDD
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 14065E0329;
 Wed, 23 Apr 2025 20:00:42 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 14065E0329
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424042;
 bh=7UzjxaKq3KxgYGBcbN1IGbXPBjMYqLYLvaPrazP0jWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g7CdWBn7kOkLuipEX1EgZwqBTXjXvpRmcLuU7mpV9AQyfSubYDqIvtF7pqL51cRCz
 8xZxlnLatfOAX7iDvdOkGOlWE2050a6YfEDZyMWwLjRMDCsH5Il+ee/mY4DFL4/PKx
 KIIuvtksNj+N21azCjM9192d61XjUr3J5we2kw4J5OG2VUjuME8ny07GfpTnEQBtOl
 WzMHma9P5dRjpkoR8f/KgaZ/9BBE6eQlGQDzkwAeXCk/ZxjBYofbD2pkD1SuLmJIAC
 Qjg3otFGdkCj6H7SxzQhVVzL0hvg7r+JYlmnvIIBSqmwXxjEl1AFb/F8PewUbHEeUV
 xd0WFU1zSUehg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 37/45] net/sfc: make use of generic EFX MAC PDU calculation
 helpers
Date: Wed, 23 Apr 2025 19:59:54 +0400
Message-Id: <20250423160002.35706-38-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

To make sure that MAC PDU values do not come with legacy bug
workaround baked in when running on newer Medford4 NICs, use
generic replacement APIs from EFX in place of MAC PDU macros.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/sfc/sfc_dp_tx.h   |  3 +++
 drivers/net/sfc/sfc_ef10_tx.c | 13 ++++++++-----
 drivers/net/sfc/sfc_ethdev.c  | 17 ++++++++++-------
 drivers/net/sfc/sfc_port.c    |  2 +-
 drivers/net/sfc/sfc_repr.c    |  7 ++++++-
 drivers/net/sfc/sfc_repr.h    |  1 +
 drivers/net/sfc/sfc_tx.c      |  2 ++
 7 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/sfc/sfc_dp_tx.h b/drivers/net/sfc/sfc_dp_tx.h
index aad3b06595..0baf8c7dd6 100644
--- a/drivers/net/sfc/sfc_dp_tx.h
+++ b/drivers/net/sfc/sfc_dp_tx.h
@@ -84,6 +84,9 @@ struct sfc_dp_tx_qcreate_info {
 
 	/** NIC's DMA mapping information */
 	const struct sfc_nic_dma_info	*nic_dma_info;
+
+	/** Maximum MAC PDU (frame size) */
+	unsigned int		max_pdu;
 };
 
 /**
diff --git a/drivers/net/sfc/sfc_ef10_tx.c b/drivers/net/sfc/sfc_ef10_tx.c
index 116229382b..5543dc495f 100644
--- a/drivers/net/sfc/sfc_ef10_tx.c
+++ b/drivers/net/sfc/sfc_ef10_tx.c
@@ -65,6 +65,7 @@ struct sfc_ef10_txq {
 	unsigned int			max_fill_level;
 	unsigned int			free_thresh;
 	unsigned int			evq_read_ptr;
+	unsigned int			max_pdu;
 	struct sfc_ef10_tx_sw_desc	*sw_ring;
 	efx_qword_t			*txq_hw_ring;
 	volatile void			*doorbell;
@@ -252,7 +253,7 @@ sfc_ef10_tx_qpush(struct sfc_ef10_txq *txq, unsigned int added,
 }
 
 static unsigned int
-sfc_ef10_tx_pkt_descs_max(const struct rte_mbuf *m)
+sfc_ef10_tx_pkt_descs_max(const struct rte_mbuf *m, unsigned int max_pdu)
 {
 	unsigned int extra_descs_per_seg;
 	unsigned int extra_descs_per_pkt;
@@ -290,8 +291,7 @@ sfc_ef10_tx_pkt_descs_max(const struct rte_mbuf *m)
 	 * maximum PDU size.
 	 */
 	extra_descs_per_pkt =
-		(RTE_MIN((unsigned int)EFX_MAC_PDU_MAX,
-			 SFC_MBUF_PKT_LEN_MAX) - 1) /
+		(RTE_MIN(max_pdu, SFC_MBUF_PKT_LEN_MAX) - 1) /
 		SFC_EF10_TX_DMA_DESC_LEN_MAX;
 
 	return m->nb_segs + RTE_MIN(m->nb_segs * extra_descs_per_seg,
@@ -672,7 +672,8 @@ sfc_ef10_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			goto dma_desc_space_update;
 		}
 
-		if (sfc_ef10_tx_pkt_descs_max(m_seg) > dma_desc_space) {
+		if (sfc_ef10_tx_pkt_descs_max(m_seg, txq->max_pdu) >
+		    dma_desc_space) {
 			if (reap_done)
 				break;
 
@@ -686,7 +687,8 @@ sfc_ef10_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			reap_done = true;
 			dma_desc_space = txq->max_fill_level -
 				(added - txq->completed);
-			if (sfc_ef10_tx_pkt_descs_max(m_seg) > dma_desc_space)
+			if (sfc_ef10_tx_pkt_descs_max(m_seg, txq->max_pdu) >
+			    dma_desc_space)
 				break;
 		}
 
@@ -986,6 +988,7 @@ sfc_ef10_tx_qcreate(uint16_t port_id, uint16_t queue_id,
 			(info->hw_index << info->vi_window_shift);
 	txq->evq_hw_ring = info->evq_hw_ring;
 	txq->tso_tcp_header_offset_limit = info->tso_tcp_header_offset_limit;
+	txq->max_pdu = info->max_pdu;
 
 	sfc_ef10_tx_info(&txq->dp.dpq, "TxQ doorbell is %p", txq->doorbell);
 
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 05194918f9..bd0061f557 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -90,6 +90,7 @@ sfc_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	const struct sfc_adapter_priv *sap = sfc_adapter_priv_by_eth_dev(dev);
 	struct sfc_adapter_shared *sas = sfc_adapter_shared_by_eth_dev(dev);
 	struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
+	const efx_nic_cfg_t *encp = efx_nic_cfg_get(sa->nic);
 	struct sfc_rss *rss = &sas->rss;
 	struct sfc_mae *mae = &sa->mae;
 
@@ -98,7 +99,7 @@ sfc_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 	dev_info->max_mtu = EFX_MAC_SDU_MAX;
 
-	dev_info->max_rx_pktlen = EFX_MAC_PDU_MAX;
+	dev_info->max_rx_pktlen = encp->enc_mac_pdu_max;
 
 	dev_info->max_vfs = sa->sriov.num_vfs;
 
@@ -1112,23 +1113,24 @@ static int
 sfc_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 {
 	struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
-	size_t pdu = EFX_MAC_PDU(mtu);
+	const efx_nic_cfg_t *encp = efx_nic_cfg_get(sa->nic);
+	size_t pdu = efx_mac_pdu_from_sdu(sa->nic, mtu);
 	size_t old_pdu;
 	int rc;
 
 	sfc_log_init(sa, "mtu=%u", mtu);
 
 	rc = EINVAL;
-	if (pdu < EFX_MAC_PDU_MIN) {
+	if (pdu < encp->enc_mac_pdu_min) {
 		sfc_err(sa, "too small MTU %u (PDU size %u less than min %u)",
 			(unsigned int)mtu, (unsigned int)pdu,
-			EFX_MAC_PDU_MIN);
+			encp->enc_mac_pdu_min);
 		goto fail_inval;
 	}
-	if (pdu > EFX_MAC_PDU_MAX) {
+	if (pdu > encp->enc_mac_pdu_max) {
 		sfc_err(sa, "too big MTU %u (PDU size %u greater than max %u)",
 			(unsigned int)mtu, (unsigned int)pdu,
-			(unsigned int)EFX_MAC_PDU_MAX);
+			encp->enc_mac_pdu_max);
 		goto fail_inval;
 	}
 
@@ -3378,6 +3380,7 @@ sfc_eth_dev_create_repr(struct sfc_adapter *sa,
 			uint16_t repr_port,
 			enum rte_eth_representor_type type)
 {
+	const efx_nic_cfg_t *encp = efx_nic_cfg_get(sa->nic);
 	struct sfc_repr_entity_info entity;
 	efx_mport_sel_t mport_sel;
 	int rc;
@@ -3414,7 +3417,7 @@ sfc_eth_dev_create_repr(struct sfc_adapter *sa,
 	entity.vf = repr_port;
 
 	rc = sfc_repr_create(sa->eth_dev, &entity, sa->mae.switch_domain_id,
-			     &mport_sel);
+			     encp->enc_mac_pdu_max, &mport_sel);
 	if (rc != 0) {
 		sfc_err(sa,
 			"failed to create representor for controller %u port %u repr_port %u: %s",
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index e5bb6d8620..5e80003ca1 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -391,7 +391,7 @@ sfc_port_configure(struct sfc_adapter *sa)
 
 	sfc_log_init(sa, "entry");
 
-	port->pdu = EFX_MAC_PDU(dev_data->mtu);
+	port->pdu = efx_mac_pdu_from_sdu(sa->nic, dev_data->mtu);
 
 	if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
 		port->include_fcs = true;
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 2c1421b959..18e76fa7da 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -32,6 +32,7 @@ struct sfc_repr_shared {
 	uint16_t		repr_id;
 	uint16_t		switch_domain_id;
 	uint16_t		switch_port_id;
+	unsigned int		max_pdu;
 };
 
 struct sfc_repr_queue_stats {
@@ -514,7 +515,7 @@ sfc_repr_dev_infos_get(struct rte_eth_dev *dev,
 
 	dev_info->device = dev->device;
 
-	dev_info->max_rx_pktlen = EFX_MAC_PDU_MAX;
+	dev_info->max_rx_pktlen = srs->max_pdu;
 	dev_info->max_rx_queues = SFC_REPR_RXQ_MAX;
 	dev_info->max_tx_queues = SFC_REPR_TXQ_MAX;
 	dev_info->default_rxconf.rx_drop_en = 1;
@@ -920,6 +921,7 @@ struct sfc_repr_init_data {
 	efx_pcie_interface_t	intf;
 	uint16_t		pf;
 	uint16_t		vf;
+	unsigned int		max_pdu;
 };
 
 static int
@@ -1012,6 +1014,7 @@ sfc_repr_eth_dev_init(struct rte_eth_dev *dev, void *init_params)
 	srs->pf_port_id = repr_data->pf_port_id;
 	srs->repr_id = srs->switch_port_id;
 	srs->switch_domain_id = repr_data->switch_domain_id;
+	srs->max_pdu = repr_data->max_pdu;
 
 	dev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
 	dev->data->representor_id = srs->repr_id;
@@ -1062,6 +1065,7 @@ int
 sfc_repr_create(struct rte_eth_dev *parent,
 		struct sfc_repr_entity_info *entity,
 		uint16_t switch_domain_id,
+		unsigned int max_pdu,
 		const efx_mport_sel_t *mport_sel)
 {
 	struct sfc_repr_init_data repr_data;
@@ -1108,6 +1112,7 @@ sfc_repr_create(struct rte_eth_dev *parent,
 		repr_data.intf = entity->intf;
 		repr_data.pf = entity->pf;
 		repr_data.vf = entity->vf;
+		repr_data.max_pdu = max_pdu;
 
 		ret = rte_eth_dev_create(parent->device, name,
 					 sizeof(struct sfc_repr_shared),
diff --git a/drivers/net/sfc/sfc_repr.h b/drivers/net/sfc/sfc_repr.h
index 2093973761..01f5947a84 100644
--- a/drivers/net/sfc/sfc_repr.h
+++ b/drivers/net/sfc/sfc_repr.h
@@ -36,6 +36,7 @@ struct sfc_repr_entity_info {
 int sfc_repr_create(struct rte_eth_dev *parent,
 		    struct sfc_repr_entity_info *entity,
 		    uint16_t switch_domain_id,
+		    unsigned int max_pdu,
 		    const efx_mport_sel_t *mport_sel);
 
 #ifdef __cplusplus
diff --git a/drivers/net/sfc/sfc_tx.c b/drivers/net/sfc/sfc_tx.c
index f376f24f7b..ebc0a8235b 100644
--- a/drivers/net/sfc/sfc_tx.c
+++ b/drivers/net/sfc/sfc_tx.c
@@ -228,6 +228,8 @@ sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 
 	info.nic_dma_info = &sas->nic_dma_info;
 
+	info.max_pdu = encp->enc_mac_pdu_max;
+
 	rc = sa->priv.dp_tx->qcreate(sa->eth_dev->data->port_id, sw_index,
 				     &RTE_ETH_DEV_TO_PCI(sa->eth_dev)->addr,
 				     socket_id, &info, &txq_info->dp);
-- 
2.39.5

