Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE460AA0D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=fDjtpak7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EC4340E2C;
	Mon, 19 Oct 2026 17:20:20 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 182524067A
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9WbZHaVaYFzgbqL6MOYtgqb+tvViTqfhGLz2P5DCrds=;
 b=fDjtpak7bIobH3DtwOWM/EdZ/e1rirIqLJNcCD8WoHisaCB6ZtbMweMWeY1zVk
 d3CdZNuRO+5JzKVFqkRpLI01Y49f+flmcQA6TzlR2tBpDH8BtMm5ni5AYFrrUbTp
 afjgawG53qXbZF7f/OIZTo9GGI9hLPCKWS7L3n4nX0LUs=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 23/27] net/hinic3: ensure queue depth and state consistency
Date: Mon, 19 Oct 2026 23:19:25 +0800
Message-ID: <20261019151930.1572-24-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S25
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF4rZFW7uFyrur1kAFb_yoWrCrWfpF
 WDKa9xta47JrsF9wn8Ka13ua43XanayryUGFySq3WYvr45XF4jva45JF4SqrWkt395CF42
 vr1kAw4vgw1jq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8b18UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNgGlr2rWNSHUrwAA3u
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hardware tracks a single queue depth across all queues, so an rx or
tx queue configured with a different depth is rejected with -EINVAL
rather than silently coerced to the first queue's depth. Reset the rx/tx
queue states in dev_stop and the cached depths in dev_configure so the
queue state reflects the stopped device before the next start.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 42 ++++++++++++++++++++----------
 drivers/net/hinic3/hinic3_ethdev.h |  5 ++++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 78c0a14b99..32218fa0f6 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -316,8 +316,6 @@ hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)
 	}
 }
 
-#define HINIC3_MAX_QUEUE_DEPTH 16384
-#define HINIC3_MIN_QUEUE_DEPTH 128
 #define HINIC3_TXD_ALIGN       1
 #define HINIC3_RXD_ALIGN       1
 
@@ -752,6 +750,8 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 
 	nic_dev->num_sqs = dev->data->nb_tx_queues;
 	nic_dev->num_rqs = dev->data->nb_rx_queues;
+	nic_dev->rxq_depth = 0;
+	nic_dev->txq_depth = 0;
 
 	nic_dev->mtu_size =
 		(uint16_t)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode));
@@ -1096,16 +1096,17 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 
-	/* Queue depth must be equal to queue 0 */
-	if (qid != 0 && nb_desc != nic_dev->rxqs[0]->q_depth) {
-		PMD_DRV_LOG(WARNING, "rxq%u depth:%u is not equal to queue0 depth:%u.",
-			    qid, nb_desc, nic_dev->rxqs[0]->q_depth);
-		nb_desc = nic_dev->rxqs[0]->q_depth;
-	}
-
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
-	rq_depth = (nb_desc & (nb_desc - 1))
-			? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
+	rq_depth = (uint16_t)rte_align32pow2(nb_desc);
+
+	/* Queue depth must be equal to first queue */
+	if (nic_dev->rxq_depth == 0) {
+		nic_dev->rxq_depth = rq_depth;
+	} else if (rq_depth != nic_dev->rxq_depth) {
+		PMD_DRV_LOG(ERR, "rxq%u depth:%u is not equal to first queue depth:%u.",
+			    qid, rq_depth, nic_dev->rxq_depth);
+		return -EINVAL;
+	}
 
 	/*
 	 * Validate number of receive descriptors.
@@ -1329,10 +1330,17 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	hwdev = nic_dev->hwdev;
-
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
-	sq_depth = (nb_desc & (nb_desc - 1))
-				? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
+	sq_depth = (uint16_t)rte_align32pow2(nb_desc);
+
+	/* Queue depth must be equal to first queue */
+	if (nic_dev->txq_depth == 0) {
+		nic_dev->txq_depth = sq_depth;
+	} else if (sq_depth != nic_dev->txq_depth) {
+		PMD_DRV_LOG(ERR, "txq%u depth:%u is not equal to first queue depth:%u.",
+			qid, sq_depth, nic_dev->txq_depth);
+		return -EINVAL;
+	}
 
 	/*
 	 * Validate number of transmit descriptors.
@@ -2237,6 +2245,12 @@ hinic3_dev_stop(struct rte_eth_dev *dev)
 
 	/* Free mempool. */
 	hinic3_copy_mempool_uninit(nic_dev);
+
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++)
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++)
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 1a5eac7c23..21abea0668 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -15,6 +15,9 @@
 
 #define HINIC3_PMD_DRV_VERSION "B106"
 
+#define HINIC3_MAX_QUEUE_DEPTH         16384
+#define HINIC3_MIN_QUEUE_DEPTH         128
+
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
 
 #define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD
@@ -145,6 +148,8 @@ struct hinic3_nic_dev {
 	uint16_t max_sqs;
 	uint16_t max_rqs;
 
+	uint16_t rxq_depth;
+	uint16_t txq_depth;
 	uint16_t rx_buff_len;
 	uint16_t mtu_size;
 
-- 
2.33.0

