Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7472CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C0BF40B9A;
	Wed, 24 Jun 2026 13:53:24 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id E732B40698;
 Wed, 24 Jun 2026 13:53:17 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301994t00af9240
X-QQ-Originating-IP: TLaMRxLGjChfXHmuWcqi9NZkuDUmfmzZ2v07LmEPH+Y=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15060493355625403367
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 07/21] net/txgbe: fix Tx desc free logic
Date: Wed, 24 Jun 2026 19:52:39 +0800
Message-Id: <20260624115254.20348-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NpEfzX/VBPFI7BgMO6s2ZFqlLZY7XJKMOm40H1pigyZ7BYKIh0T/673h
 1HHKNg+rwDyTpaGnmbTXFHhD0scKfas/wsHLgx70BgujUqY3WpaJFddSn22Da/S3DNUVvq7
 EOE8xmBP8NfvP87wW48JcBkZbFcVEPDCffvIKGCL/smL4SKb37d+mMFcIAkRM1T7x+YgxcG
 E7aHVevgR1wIT1XlX4SoL5yXLRPkwz8Z+3xuv25XWeW6wcFLVq/ELnHsSc6wygSmLdatUsX
 VmG3TZVli0PeLDsag4JQyIwZT2KhMbIglTndBd3+pN9VcRXCyBmpzcpJsgQMa7CXy6pdM1I
 AWH0ZAoxYvTUmXbU7++RdN3lWij/bChMIe/0AVEs1o9XzW0Q/IaEh9WwHIdEy5ahzAJ8Y2Y
 0ikQzHoMyaW9i+v6me2BVRJKpIar19BV+jNOSaVmWRkwR0bFyfnQEPP8jiwhprk8QMMtnrf
 TQXIz6D8B0rSBwLABxsup7TU9E0FxH4bleOC43pr9j1HYZ0Enqn59aCx5K3CqSrRd2phNqA
 5cqoQqx71Lu4BhwkpX66xPSmI1M0hX/9COlp7KQmB/1i/J+N9nPCr/Yib+deYg80YRXKfEu
 d+/6YAPo6HLWeYSryyhdopTGagbi8n0MotsPD0oMWhPrLSqjc9/HY/VxWMJw0R4RjCX5mOy
 H+QAuuWon0JtsCxIVYn7iVIj2dKSFkV9Nlh3Ob7FoyIyxV68CktqpidaVWz+bmpyRrOMcnD
 jV/Lu5X/5mzIlZda3ygMNio+9jy4Of/5f0GMevKA7jpF9g1/vZN1NDM7JNAJ3jYMnkE62Y8
 H868iXvAYVog7vWFYHXB6QYyeAl+KdLaKIPhFtIadN9NJMz63YwVBuI23nJ1JKIP2RlFOr6
 JfAGd1P5KVGPBm3Rm3a+1RRf2xvYokSbi/eEgsr/2X278v0bXaqtkVSXV51RZ+61h/DlwgP
 q/jDSm5pwvu2692Q5w/iQ95HS7+Gv0ZZx5JrAUjd7nC4lkHyjIv8UggAgohPSAxh3OaIBgz
 on5Y9u7DwI5jeKo+pwGZFJQE8BF17QdLbCEwj9Q66yra6nWHcXxij/jZ+bqMOiSfEZj3RAv
 LnvjDf+Or5v
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

On some server environments, this driver caused TDM non-fatal errors
or PCIe request errors during Tx operation

In Amber-Lite NIC's Tx head write-back mode, the hardware periodically
writes back a head index pointing to the next descriptor it is adout
to process in Tx ring. All descriptors before the head are considered
processed by hardware and can be safely freed by the driver.

The root cause is that the driver can safely free a batch of descriptors
only when the hardware's write-back head pointer has advanced beyond all
descriptors in that batch, meaning they have all been processed by the
hardware. If the driver frees a descriptor before the hardware has
finished processing it, invalid memory access may occur, leading to the
observed bug.

To fix the issue, correct the boundary check in all three Tx cleanup
functions, each of which was missing the proper condition to prevent
freeing unprocessed descriptors.

Fixes: 8ada71d0bb7f ("net/txgbe: add Tx head write-back mode for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c            | 18 +++++------
 drivers/net/txgbe/txgbe_rxtx.h            | 37 ++++++++++++++++++++++-
 drivers/net/txgbe/txgbe_rxtx_vec_common.h | 10 +++---
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e2cd9b8841..d5dcec3a2c 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -98,12 +98,11 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 		if (tx_last_dd >= txq->nb_tx_desc)
 			tx_last_dd -= txq->nb_tx_desc;
 
-		volatile uint16_t head = (uint16_t)*txq->headwb_mem;
+		uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
+						      rte_memory_order_acquire);
+		const uint16_t head = (uint16_t)h;
 
-		if (txq->tx_next_dd > head && head > tx_last_dd)
-			return 0;
-		else if (tx_last_dd > txq->tx_next_dd &&
-				(head > tx_last_dd || head < txq->tx_next_dd))
+		if (!txgbe_tx_headwb_desc_done(head, tx_last_dd, txq->tx_next_dd))
 			return 0;
 	} else {
 		/* check DD bit on threshold descriptor */
@@ -645,12 +644,13 @@ txgbe_xmit_cleanup(struct txgbe_tx_queue *txq)
 	status = txr[desc_to_clean_to].dw3;
 
 	if (txq->headwb_mem) {
-		u32 head = *txq->headwb_mem;
+		uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
+						      rte_memory_order_acquire);
+		const uint16_t head = (uint16_t)h;
 
 		PMD_TX_FREE_LOG(DEBUG, "queue[%02d]: headwb_mem = %03d, desc_to_clean_to = %03d",
 				txq->reg_idx, head, desc_to_clean_to);
-		/* we have caught up to head, no work left to do */
-		if (desc_to_clean_to == head)
+		if (!txgbe_tx_headwb_desc_done(head, last_desc_cleaned, desc_to_clean_to))
 			return -(1);
 	} else {
 		if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
@@ -2440,7 +2440,7 @@ txgbe_setup_headwb_resources(struct rte_eth_dev *dev,
 
 	txq->headwb = headwb;
 	txq->headwb_dma = TMZ_PADDR(headwb);
-	txq->headwb_mem = (uint32_t *)TMZ_VADDR(headwb);
+	txq->headwb_mem = (RTE_ATOMIC(uint32_t) *)TMZ_VADDR(headwb);
 
 	/* Zero out headwb_mem memory */
 	for (i = 0; i < headwb_size; i++)
diff --git a/drivers/net/txgbe/txgbe_rxtx.h b/drivers/net/txgbe/txgbe_rxtx.h
index 02e2617cce..9b0fffae8e 100644
--- a/drivers/net/txgbe/txgbe_rxtx.h
+++ b/drivers/net/txgbe/txgbe_rxtx.h
@@ -417,7 +417,7 @@ struct txgbe_tx_queue {
 	bool		    resetting;
 	const struct rte_memzone *headwb;
 	uint64_t             headwb_dma;
-	volatile uint32_t    *headwb_mem;
+	RTE_ATOMIC(uint32_t) *headwb_mem;
 };
 
 struct txgbe_txq_ops {
@@ -426,6 +426,41 @@ struct txgbe_txq_ops {
 	void (*reset)(struct txgbe_tx_queue *txq);
 };
 
+/**
+ * Check whether Tx descriptors in the range (last, next]  are done
+ * in Tx head write-back mode.
+ *
+ * In head write-back mode, the hardware periodically updates *headwb_mem
+ * with the index of the next descriptor it will process.
+ * All descriptors before the head are considered processed by hardware and can
+ * be safely freed. The descriptor pointed to by head itself is not yet processed.
+ *
+ * @param head
+ *   Current hardware head index read from headwb_mem.
+ * @param last
+ *   The highest-index descriptor cleaned in the previous round
+ *   (exclusive: descriptors at or before this index are already freed).
+ * @param next
+ *   The highest-index descriptor to be cleaned in this round
+ *   (inclusive: this descriptor is the target of the current cleanup).
+ * @return
+ *   true if all descriptors in the range (last, next] have been completed
+ *   by hardware and can be freed, false otherwise.
+ */
+static inline bool
+txgbe_tx_headwb_desc_done(uint16_t head, uint16_t last, uint16_t next)
+{
+	if (next == head)
+		return false;
+	else if (next > head && head > last)
+		return false;
+	/* wrap case */
+	else if (last > next && (head > last || head < next))
+		return false;
+
+	return true;
+}
+
 /* Takes an ethdev and a queue and sets up the tx function to be used based on
  * the queue parameters. Used in tx_queue_setup by primary process and then
  * in dev_init by secondary process when attaching to an existing ethdev.
diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_common.h b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
index 00847d087b..77d7ff785b 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -94,11 +94,11 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 				      txq->tx_next_dd - txq->tx_free_thresh;
 		if (tx_last_dd >= txq->nb_tx_desc)
 			tx_last_dd -= txq->nb_tx_desc;
-				volatile uint16_t head = (uint16_t)*txq->headwb_mem;
-		if (txq->tx_next_dd > head && head > tx_last_dd)
-			return 0;
-		else if (tx_last_dd > txq->tx_next_dd &&
-				(head > tx_last_dd || head < txq->tx_next_dd))
+		uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
+						      rte_memory_order_acquire);
+		const uint16_t head = (uint16_t)h;
+
+		if (!txgbe_tx_headwb_desc_done(head, tx_last_dd, txq->tx_next_dd))
 			return 0;
 	} else {
 		/* check DD bit on threshold descriptor */
-- 
2.21.0.windows.1

