Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16560CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC6F40E13;
	Tue, 16 Jun 2026 14:21:15 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 307904026A;
 Tue, 16 Jun 2026 14:21:13 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612471ta5d05eb8
X-QQ-Originating-IP: lEZzQEdmXxX4pAjczseEUMPvtl/0a/E2BSKzjQq62W8=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7942984482180487741
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 07/21] net/txgbe: fix Tx desc free logic
Date: Tue, 16 Jun 2026 20:20:15 +0800
Message-Id: <20260616122030.9688-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M30plJS+/sfzxTsbolnwEt5W1oG8PUs7n1aUmalyrwuvhXBU2rYy6Ctq
 adK9Z2kQrIQss5/dwi/Y+b1J1BmB/7brRnXwcyboetSiAK5QVUZo7ZMlzfhxyeEoMcA7jn7
 kJ/XaopE0Aash+4WNmqfQQlp+PFxitSjSQwPynaeVCVcVmqwFspR5euuOYEzCJ1wxWkyaih
 68X3aTByvu2/pkHTqwGawNRCKGRgK2eM0dcSUVtWF8CROoL1T5vUzSOfIa4spNaAxumZzZh
 V6Na51mSihhsKI8vACAHWU1alQv1UGgHmJo/cfZRmcA/o2ZtNMWKyg3wvRqp8l6wJAGGd+Q
 eBlABfE4fOP/kdskkAWVYVBFTMXIVAeUwtDJYehIqb3vMk7kZOpRt+RBqzshIRhoJiNrNuA
 UVxX/ZzY3mSyZ4eJdF0g6WDC7etmGKjhCp5iXeBZ+ipdLl7ASHH3mwiCAQ+75dmvVAy6Ccm
 /J1k3SgRRgDTDeT7ffXiX8DgBGtynAu/pXWaN3Setys6XKB9i7Ur9+BJLW1JBsEuNrJdUs+
 z4rR949j9vadU8IcdClxCNo3pJJyFjb66YBI8WWwtYw1MowmgplceXBVFA/SzrrdLGv1TG4
 hixD1Ds3dN63yeBYgRPBeZlaYU5bsdnlvO/WH6U0YJxCMq92t4KgI46aZLaOkVMtbLt27Jb
 rKmqmV3WWI/fIhuxYPByMRDDD1D6buakIT4I6ntXs6RnQNOoAWwyv/AlNJ2kGllhWIpEVJk
 rWwHisErJY5sVnhNe5O3/RpTigAyGnYeOeC9md6NFFLRtr2HugTaikHpYQTr/he4ZBbuMRy
 s8NsJRAXir8nBYkPpZPCSRQQpCcCTGIFDBXHzNM7X15TwkFtddq81W2717r2hzKVJ+bn0to
 1WvXgMwvpSBXeQQ6XEep4v7yYV+gXaOZGBrnNoVnWPYzvTFGtW7L5CDdVoWByR1dS/cEr3G
 4Gj3VHJk3KhGHS/MVGYzMe7T2k9KShzX/OolAfKcIS0InF3yx9HN55NyrEpTYA4OrqCMEqi
 1JPkURdvMPHnjILpqMQxw1MgNzxE6TlE3JcjQkdLmJMwkshzqsl6dDkx+gQ2U5bqfnm4gf9
 qLL91LBLt8q
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
 drivers/net/txgbe/txgbe_rxtx.c            | 16 +++++------
 drivers/net/txgbe/txgbe_rxtx.h            | 35 +++++++++++++++++++++++
 drivers/net/txgbe/txgbe_rxtx_vec_common.h | 10 +++----
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e2cd9b8841..d6efb3b8cc 100644
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
diff --git a/drivers/net/txgbe/txgbe_rxtx.h b/drivers/net/txgbe/txgbe_rxtx.h
index 02e2617cce..43c818cfbf 100644
--- a/drivers/net/txgbe/txgbe_rxtx.h
+++ b/drivers/net/txgbe/txgbe_rxtx.h
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

