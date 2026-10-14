Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB09CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B870440E37;
	Wed, 14 Oct 2026 17:10:13 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id DE79D40B91
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=SzrpL2SNTYnqQuILkkZageglrsP5Zh4tCAzEr/FO3j8=;
 b=UPS325Y/WOcwB1Apjy1usPKwket2HwQo9j7DDi7LYLCPG02n4tTqV3Xm1UY5ka
 BXr214cKfuclGoRL/x0XI25lZCW2Zey6IGVwfW2947PX5MyWOoh1eNBJfVw/iRtq
 MfmS/+wOr9o2vnZk8s8ldDQhm1ehrd0ymP39tEXgZwm7o=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 23/26] net/hinic3: add Tx burst mode get
Date: Wed, 14 Oct 2026 23:09:19 +0800
Message-ID: <20261014150923.838-24-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S25
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4UKry7GF43XrykXF4xZwb_yoWrXFWfpF
 45GayfAr4DKrWUZ3Z5Gws7uF15Xw4kG3yUK3W3Ja4a9F98Zr17Aa4UtFWxZr1avw17ua4I
 vF1UW34q9F1UKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8b18UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB2EjmrPmz0cpQAA3Z
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
index 14f152a604..7fa7921fd3 100644
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
index ea2a5c55ca..3095b5a571 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3692,6 +3692,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 	.fec_get_capability            = hinic3_fec_capability_get,
 	.fec_get                       = hinic3_fec_get,
 	.fec_set                       = hinic3_fec_set,
@@ -3746,6 +3747,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 };
 
 /**
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index b52be4c180..7ffa680123 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -1313,6 +1313,38 @@ hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)
 	}
 }
 
+int
+hinic3_tx_burst_mode_get(struct rte_eth_dev *dev,
+				uint16_t tx_queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	uint16_t tx_offloads = dev->data->dev_conf.txmode.offloads;
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_txq *txq = NULL;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	txq = nic_dev->txqs[tx_queue_id];
+	if (!txq)
+		return -EINVAL;
+
+	snprintf(mode->info, sizeof(mode->info),
+		"%s%s%s%s%s%s",
+		(nic_dev->config.rx_cqe_compact_en == HINIC3_RX_CQE_COMPACT_EN) ?
+			"compact CQE" : "scalar",
+		(tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) ? " + MULTI" : "",
+		(tx_offloads & (RTE_ETH_TX_OFFLOAD_TCP_TSO |
+				RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO)) ? " + TSO" : "",
+		(tx_offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+				RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+				RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+				RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+				RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM)) ? " + CKSUM" : "",
+		(tx_offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT) ? " + VLAN" : "",
+		(tx_offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) ? " + QINQ" : "");
+
+	return 0;
+}
+
 /**
  * It is responsible for sending data packets.
  *
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index b216a39ecd..af702b7ec5 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -396,4 +396,6 @@ uint16_t hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
+int hinic3_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+			     struct rte_eth_burst_mode *mode);
 #endif /**< _HINIC3_TX_H_ */
-- 
2.33.0

