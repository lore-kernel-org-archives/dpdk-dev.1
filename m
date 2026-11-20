Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41960A261F
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=h/SW/OkC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86E8D40E20;
	Fri, 20 Nov 2026 17:35:44 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTPS id 2751F4060C
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=wenZOKIGCskI2/jccdjjv3C+H9I6vRVDPHK7zYWb7w4=;
 b=h/SW/OkCk25XYGoCegihsO3hlAIuAA6K8Mo/658hKAbL5bAICbAqrtT3uxXIIs
 PBQCmpRRd/wST6iF78gC59CJfGRbEZ9npQm/CQ4jd/QwGsmeJzSBiG/FmSZTJFrl
 Q8Wvg55R1OzMvbps5vuF9eY5hf7Wd3czU+fbcM6O6nnLU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 27/28] net/hinic3: add Tx burst mode get
Date: Sat, 21 Nov 2026 00:34:52 +0800
Message-ID: <20261120163454.1159-28-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S29
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyUtr48AF1xGFW5ur1UGFg_yoWruw18pF
 Z8Gay5AryDtrWUZ3WkGws7uF15Xw4kJ3yUKw1fGa4avF98Xr17Z34UtFW7Zr1aqr17Za4I
 vF1jg3sFkF1jgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8b18UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwaps2sAdsYRXQAA38
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
 doc/guides/nics/features/hinic3.ini    |  1 +
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/hinic3/hinic3_ethdev.c     |  2 ++
 drivers/net/hinic3/hinic3_tx.c         | 31 ++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_tx.h         |  2 ++
 5 files changed, 37 insertions(+)

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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 89a182a17a..aba7601a04 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -179,6 +179,7 @@ New Features
   * Added a compact CQE receive data path.
   * Extended TCP segmentation offload (TSO) to 255 segments.
   * Added a compact task transmit data path.
+  * Added Tx burst mode reporting.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 0f38e6b2b6..4bbc1a1efb 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -3892,6 +3892,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 	.fec_get_capability            = hinic3_fec_capability_get,
 	.fec_get                       = hinic3_fec_get,
 	.fec_set                       = hinic3_fec_set,
@@ -3946,6 +3947,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
 	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
+	.tx_burst_mode_get             = hinic3_tx_burst_mode_get,
 };
 
 /**
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index 3f44814405..0bee8a8691 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -1500,6 +1500,37 @@ hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)
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
+		 dev->tx_pkt_burst == hinic3_xmit_pkts_compact_task ?
+			"compact task" : "scalar",
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
index 51024e4e99..3a6451f69b 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -404,4 +404,6 @@ uint16_t hinic3_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb
 int hinic3_stop_sq(struct hinic3_txq *txq);
 int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
 int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
+int hinic3_tx_burst_mode_get(struct rte_eth_dev *dev, uint16_t tx_queue_id,
+			     struct rte_eth_burst_mode *mode);
 #endif /**< _HINIC3_TX_H_ */
-- 
2.33.0

