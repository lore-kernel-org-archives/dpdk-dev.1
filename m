Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BB606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=iTRRhGp5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48CED4279F;
	Mon,  9 Nov 2026 17:21:21 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id 48B6F40E4B
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+VBQCG9Do0pl4+xKlsfD5T5prfVlzEUc5aI5EzO4+TI=;
 b=iTRRhGp5J8T3WMGsfTYZXMNMCzpsU+L5DugNsq/aQIYX1Ql9M0D9vlxtnh0LuT
 OwJLcxkObe8S40HC9At62hel/PiFzq1/wCnHiYmlHGRB93+2mEsxy+PHibIXF+Dx
 wPwLv8wJM1gUwaqzP3JH3HOJEj5PAuwHGJ9XysMnR4FY4=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 27/28] net/hinic3: add Tx burst mode get
Date: Tue, 10 Nov 2026 00:20:31 +0800
Message-ID: <20261109162033.1144-28-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S29
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyUtr48AF1xGFW5ur1UGFg_yoWrWrW5pF
 45Gay5Ar1DKrWUZ3Z5Gws7uF1Yqw48G3yUK3W3Ga4a9F98Xr17Aa4UtFWxZr1avw17Za4I
 vF1UG34q9F1jgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8b18UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwwPGWrx8uwIogAA3G
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
sends packets. The string is derived from the Tx burst function actually
installed on the device, so it reports the compact CQE path only when
that path is really in use, and also lists the enabled offloads.
Advertise the new capability in the feature matrix.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/features/hinic3.ini |  1 +
 drivers/net/hinic3/hinic3_ethdev.c  |  2 ++
 drivers/net/hinic3/hinic3_tx.c      | 31 +++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_tx.h      |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index 81c3e85410..ba30a850e9 100644
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
index a80b4e8b5e..793e0f84ad 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3835,6 +3835,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 	.fec_get_capability            = hinic3_fec_capability_get,
 	.fec_get                       = hinic3_fec_get,
 	.fec_set                       = hinic3_fec_set,
@@ -3889,6 +3890,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 };
 
 /**
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index a9dcb99095..ff5e5a4922 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -1507,6 +1507,37 @@ hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)
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
+		 "%s%s%s%s%s",
+		 dev->tx_pkt_burst == hinic3_xmit_pkts_compact_cqe ?
+			"compact CQE" : "scalar",
+		 (tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) ? " + MULTI" : "",
+		 (tx_offloads & (RTE_ETH_TX_OFFLOAD_TCP_TSO |
+				 RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO)) ? " + TSO" : "",
+		 (tx_offloads & (RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+				 RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM)) ? " + CKSUM" : "",
+		 (tx_offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT) ? " + VLAN" : "");
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

