Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B57606A333
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=cdT1z75w
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9D644067C;
	Fri, 20 Nov 2026 17:35:33 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTPS id F23E64060C
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=YumZX1WCmRoySXBNQyD57aK/N05j+yNPje4n1kSzQns=;
 b=cdT1z75wjIrytc/ii/LHBuDFKffnpkZ8X1ygLxFrA9bieO9C0iMR+oUGU0BrXo
 g24rGu8Jl83fzhKEAO2ioFULAT+VYChFJQRWCHxSH13ZA+VWq+KVFVFLgMr0og+j
 AVzhaOQOrKYKVNXXfPTOQc/IqDcKCyOVqRFivCh9+kEqY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 23/28] net/hinic3: ensure queue depth and state consistency
Date: Sat, 21 Nov 2026 00:34:48 +0800
Message-ID: <20261120163454.1159-24-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S25
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw1fJw1fZF4DAw4rXw47Jwb_yoWxKw43pF
 WDKayDta47JrsF9ws0ka1fuF13XFsay34UGFySq3WYyw15XF4UAa43tF4Fvrs7J395AF47
 Zr1kAa1vgw1jgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URMKZUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwWps2sAdsULOAAA3H
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

The hardware tracks a single queue depth, which the root context takes
from queue 0. A queue configured with a different depth used to be
silently coerced to the first queue's depth; reject it with -EINVAL
instead, since the application sized its mempool for the requested
depth.

Keep the expected depth in the per-port state, reset it in
dev_configure() and dev_stop(), and validate in dev_start() that every
configured queue is present and shares queue 0's depth.

Reset the rx/tx queue states in dev_stop, including the tx queue status
used by the Tx path, so the queue state reflects the stopped device
before the next start.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 88 +++++++++++++++++++++++++-----
 drivers/net/hinic3/hinic3_ethdev.h |  5 ++
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index ebd7988436..7ba33a0c02 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -318,8 +318,6 @@ hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)
 	}
 }
 
-#define HINIC3_MAX_QUEUE_DEPTH 16384
-#define HINIC3_MIN_QUEUE_DEPTH 128
 #define HINIC3_TXD_ALIGN       1
 #define HINIC3_RXD_ALIGN       1
 
@@ -739,6 +737,8 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 
 	nic_dev->num_sqs = dev->data->nb_tx_queues;
 	nic_dev->num_rqs = dev->data->nb_rx_queues;
+	nic_dev->rxq_depth = 0;
+	nic_dev->txq_depth = 0;
 
 	nic_dev->mtu_size =
 		(uint16_t)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode));
@@ -1118,16 +1118,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
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
 
 	/*
 	 * Validate number of receive descriptors.
@@ -1144,6 +1136,19 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		return -EINVAL;
 	}
 
+	/*
+	 * The hardware tracks a single queue depth. Keep the value chosen by
+	 * the first queue of this configuration and compare against it, so a
+	 * runtime reconfiguration with a different depth is not rejected by
+	 * queues that still hold the previous depth.
+	 */
+	if (nic_dev->rxq_depth != 0 && nic_dev->rxq_depth != rq_depth) {
+		PMD_DRV_LOG(ERR,
+			    "rxq%u depth:%u is not equal to the port depth:%u.",
+			    qid, rq_depth, nic_dev->rxq_depth);
+		return -EINVAL;
+	}
+
 	/*
 	 * The RX descriptor ring will be cleaned after rxq->rx_free_thresh
 	 * descriptors are used or if the number of descriptors required
@@ -1297,6 +1302,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		}
 	}
 	dev->data->rx_queues[qid] = rxq;
+	nic_dev->rxq_depth = rq_depth;
 
 	return 0;
 
@@ -1353,8 +1359,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	hwdev = nic_dev->hwdev;
 
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
-	sq_depth = (nb_desc & (nb_desc - 1))
-				? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
+	sq_depth = (uint16_t)rte_align32pow2(nb_desc);
 
 	/*
 	 * Validate number of transmit descriptors.
@@ -1371,6 +1376,19 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		return -EINVAL;
 	}
 
+	/*
+	 * The hardware tracks a single queue depth. Keep the value chosen by
+	 * the first queue of this configuration and compare against it, so a
+	 * runtime reconfiguration with a different depth is not rejected by
+	 * queues that still hold the previous depth.
+	 */
+	if (nic_dev->txq_depth != 0 && nic_dev->txq_depth != sq_depth) {
+		PMD_DRV_LOG(ERR,
+			    "txq%u depth:%u is not equal to the port depth:%u.",
+			    qid, sq_depth, nic_dev->txq_depth);
+		return -EINVAL;
+	}
+
 	/*
 	 * The TX descriptor ring will be cleaned after txq->tx_free_thresh
 	 * descriptors are used or if the number of descriptors required
@@ -1468,6 +1486,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	}
 
 	dev->data->tx_queues[qid] = txq;
+	nic_dev->txq_depth = sq_depth;
 
 	return 0;
 
@@ -2113,6 +2132,33 @@ hinic3_dev_start(struct rte_eth_dev *eth_dev)
 	int err;
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+
+	/*
+	 * The root context carries a single depth per direction, taken from
+	 * queue 0, and a queue setup cannot change the other queues. A partial
+	 * reconfiguration would therefore leave the rings sized differently
+	 * from the root context, so refuse to start unless every configured
+	 * queue is present and shares the depth of queue 0.
+	 */
+	for (i = 0; i < nic_dev->num_rqs; i++) {
+		if (nic_dev->rxqs[i] == NULL ||
+		    nic_dev->rxqs[i]->q_depth != nic_dev->rxqs[0]->q_depth) {
+			PMD_DRV_LOG(ERR,
+				    "rxq%u is missing or has a different depth than rxq0.",
+				    i);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < nic_dev->num_sqs; i++) {
+		if (nic_dev->txqs[i] == NULL ||
+		    nic_dev->txqs[i]->q_depth != nic_dev->txqs[0]->q_depth) {
+			PMD_DRV_LOG(ERR,
+				    "txq%u is missing or has a different depth than txq0.",
+				    i);
+			return -EINVAL;
+		}
+	}
+
 	err = hinic3_copy_mempool_init(nic_dev);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Create copy mempool failed, dev_name: %s",
@@ -2263,6 +2309,7 @@ hinic3_dev_stop(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev;
 	struct rte_eth_link link;
+	uint16_t i;
 	int err;
 
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
@@ -2314,6 +2361,21 @@ hinic3_dev_stop(struct rte_eth_dev *dev)
 
 	/* Free mempool. */
 	hinic3_copy_mempool_uninit(nic_dev);
+
+	/* A stopped device starts a new queue configuration. */
+	nic_dev->rxq_depth = 0;
+	nic_dev->txq_depth = 0;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++)
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct hinic3_txq *txq = dev->data->tx_queues[i];
+
+		if (txq != NULL)
+			HINIC3_SET_TXQ_STOPPED(txq);
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 0763665885..eff0bca29e 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -15,6 +15,9 @@
 
 #define HINIC3_PMD_DRV_VERSION "B106"
 
+#define HINIC3_MAX_QUEUE_DEPTH         16384
+#define HINIC3_MIN_QUEUE_DEPTH         128
+
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
 
 #define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD
@@ -144,6 +147,8 @@ struct hinic3_nic_dev {
 
 	uint16_t num_sqs;
 	uint16_t num_rqs;
+	uint16_t rxq_depth;
+	uint16_t txq_depth;
 	uint16_t max_sqs;
 	uint16_t max_rqs;
 
-- 
2.33.0

