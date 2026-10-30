Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF05606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=S535mCjw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7328410F1;
	Fri, 30 Oct 2026 15:48:23 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTPS id 9016340285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=NnMqkLvNVkqtlAhX+RBchNYsuGkGsTIiI8jYg3Ge1sU=;
 b=S535mCjw18KQffREACw7IzAuE3RuwayBUKllAgrnkACtxWlODAf0GaX3eQ0lTL
 rrsSAZ6NHeZlDfXPjxnERBqq9ZVL9DNdielDig9XJcvqNUi3BEjhrw2z92wVvtzu
 dSw0EEwZW1V9Zph8ue5j/Cy18fvgYbO4pogwIdIckWXzE=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 23/28] net/hinic3: ensure queue depth and state consistency
Date: Fri, 30 Oct 2026 22:47:27 +0800
Message-ID: <20261030144733.2120-24-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S25
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF4rZFW7uFyrur1kAFb_yoWrKry5pF
 WDKa9rta47JrsrWwnYka1fu3W3XanayryUGFySqw1Y9r45XF40va43JFWSqrWvq395AF4j
 9r1kAwsFgw1jq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8b18UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNR6GkGrkrh5gjwAA3s
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

The hardware tracks a single queue depth across all queues, so an rx or
tx queue configured with a different depth is rejected with -EINVAL
rather than silently coerced to the first queue's depth. Reset the rx/tx
queue states in dev_stop and the cached depths in dev_configure so the
queue state reflects the stopped device before the next start.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 41 ++++++++++++++++++++----------
 drivers/net/hinic3/hinic3_ethdev.h |  5 ++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index c0be692008..5ef966838f 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -316,8 +316,6 @@ hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)
 	}
 }
 
-#define HINIC3_MAX_QUEUE_DEPTH 16384
-#define HINIC3_MIN_QUEUE_DEPTH 128
 #define HINIC3_TXD_ALIGN       1
 #define HINIC3_RXD_ALIGN       1
 
@@ -737,6 +735,8 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 
 	nic_dev->num_sqs = dev->data->nb_tx_queues;
 	nic_dev->num_rqs = dev->data->nb_rx_queues;
+	nic_dev->rxq_depth = 0;
+	nic_dev->txq_depth = 0;
 
 	nic_dev->mtu_size =
 		(uint16_t)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode));
@@ -1092,16 +1092,8 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 
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
@@ -1118,6 +1110,15 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		return -EINVAL;
 	}
 
+	/* Queue depth must be equal to first queue */
+	if (nic_dev->rxq_depth == 0) {
+		nic_dev->rxq_depth = rq_depth;
+	} else if (rq_depth != nic_dev->rxq_depth) {
+		PMD_DRV_LOG(ERR, "rxq%u depth:%u is not equal to first queue depth:%u.",
+			    qid, rq_depth, nic_dev->rxq_depth);
+		return -EINVAL;
+	}
+
 	/*
 	 * The RX descriptor ring will be cleaned after rxq->rx_free_thresh
 	 * descriptors are used or if the number of descriptors required
@@ -1327,8 +1328,7 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	hwdev = nic_dev->hwdev;
 
 	/* Queue depth must be power of 2, otherwise will be aligned up. */
-	sq_depth = (nb_desc & (nb_desc - 1))
-				? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
+	sq_depth = (uint16_t)rte_align32pow2(nb_desc);
 
 	/*
 	 * Validate number of transmit descriptors.
@@ -1345,6 +1345,15 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		return -EINVAL;
 	}
 
+	/* Queue depth must be equal to first queue */
+	if (nic_dev->txq_depth == 0) {
+		nic_dev->txq_depth = sq_depth;
+	} else if (sq_depth != nic_dev->txq_depth) {
+		PMD_DRV_LOG(ERR, "txq%u depth:%u is not equal to first queue depth:%u.",
+			qid, sq_depth, nic_dev->txq_depth);
+		return -EINVAL;
+	}
+
 	/*
 	 * The TX descriptor ring will be cleaned after txq->tx_free_thresh
 	 * descriptors are used or if the number of descriptors required
@@ -2253,6 +2262,12 @@ hinic3_dev_stop(struct rte_eth_dev *dev)
 
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
index 930161c858..4597d9d133 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -15,6 +15,9 @@
 
 #define HINIC3_PMD_DRV_VERSION "B106"
 
+#define HINIC3_MAX_QUEUE_DEPTH         16384
+#define HINIC3_MIN_QUEUE_DEPTH         128
+
 #define PCI_DEV_TO_INTR_HANDLE(pci_dev) ((pci_dev)->intr_handle)
 
 #define HINIC3_PKT_RX_L4_CKSUM_BAD	RTE_MBUF_F_RX_L4_CKSUM_BAD
@@ -148,6 +151,8 @@ struct hinic3_nic_dev {
 	uint16_t max_sqs;
 	uint16_t max_rqs;
 
+	uint16_t rxq_depth;
+	uint16_t txq_depth;
 	uint16_t rx_buff_len;
 	uint16_t mtu_size;
 
-- 
2.33.0

