Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D995606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=k8GjbXcl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EF8D40A73;
	Fri, 23 Oct 2026 17:59:18 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 3026B406B7
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=IZSXN02p++tcRBewIIbjvjTfLf7Z2Su/PuPvd+vZNYg=;
 b=k8GjbXcljMKYkSDqcp9tAABuiSbhHX1EOlOsoRTKm3XUr4MOjvmFNFofIX4MgN
 nh0lT+eAemCaRBJ1Kzl/iedSUB2CK65Sark7qwyOns7slPeVm5RsymuPi4+xRYGI
 OhaFmrqXaJ41Cgo9A1pPLZ5m83vYhmjJF0oq57Y8Mkqgw=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 26/27] net/hinic3: add Tx burst mode get
Date: Fri, 23 Oct 2026 23:58:07 +0800
Message-ID: <20261023155809.855-27-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S28
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UKry7GF43XrykXF4xZwb_yoWrXFWfpF
 W5Gay3Ar4DKrWUZ3Z3Gws7uF15Xw4kG3yUK3W3Ja4a9F98Xr1UAa4UtFWxZr1avw17Za4I
 vF1UG34q9F1UKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8b18UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMx65w2rbhB7c4wAA3D
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the active Tx burst mode and its offloads via the
tx_burst_mode_get callback so applications can query how each queue
sends packets. The string encodes whether the compact CQE path is in
use and which offloads are enabled.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/features/hinic3.ini |  1 +
 drivers/net/hinic3/hinic3_ethdev.c  |  2 ++
 drivers/net/hinic3/hinic3_tx.c      | 32 +++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_tx.h      |  2 ++
 4 files changed, 37 insertions(+)

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index e47907aa22..fcbc0d5c3d 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -9,6 +9,7 @@ Link speed configuration = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
 Runtime queue setup  = Y
+Burst mode info      = Y
 MTU update           = Y
 Scattered Rx         = Y
 TSO                  = Y
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index c09dad9efa..aec2dc42e9 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3743,6 +3743,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 	.fec_get_capability            = hinic3_fec_capability_get,
 	.fec_get                       = hinic3_fec_get,
 	.fec_set                       = hinic3_fec_set,
@@ -3797,6 +3798,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 };
 
 /**
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index d3568db9a8..14353c32f4 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -1479,6 +1479,38 @@ hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)
 	}
 }
 
+int
+hinic3_tx_burst_mode_get(struct rte_eth_dev *dev,
+			 uint16_t tx_queue_id,
+			 struct rte_eth_burst_mode *mode)
+{
+	uint64_t tx_offloads = dev->data->dev_conf.txmode.offloads;
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_txq *txq = NULL;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	txq = nic_dev->txqs[tx_queue_id];
+	if (!txq)
+		return -EINVAL;
+
+	snprintf(mode->info, sizeof(mode->info),
+		 "%s%s%s%s%s%s",
+		 (nic_dev->config.rx_cqe_compact_en == HINIC3_RX_CQE_COMPACT_EN) ?
+			"compact CQE" : "scalar",
+		 (tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) ? " + MULTI" : "",
+		 (tx_offloads & (RTE_ETH_TX_OFFLOAD_TCP_TSO |
+				 RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO)) ? " + TSO" : "",
+		 (tx_offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM)) ? " + CKSUM" : "",
+		 (tx_offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT) ? " + VLAN" : "",
+		 (tx_offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) ? " + QINQ" : "");
+
+	return 0;
+}
+
 /**
  * It is responsible for sending data packets.
  *
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index e0a2606428..6bdf71f59d 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -396,4 +396,6 @@ uint16_t hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
+int hinic3_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+			     struct rte_eth_burst_mode *mode);
 #endif /**< _HINIC3_TX_H_ */
-- 
2.33.0

