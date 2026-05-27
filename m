Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CECD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB1114068A;
	Wed, 27 May 2026 15:03:35 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id CD13340697;
 Wed, 27 May 2026 15:03:31 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887009t6d8b95de
X-QQ-Originating-IP: +kFxsz/fsDpylSVUSGXhdUXKYAnk8i+H+mZ9GtKu0Jo=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16904278434224540441
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 07/21] net/txgbe: fix Tx desc free logic
Date: Wed, 27 May 2026 21:02:07 +0800
Message-Id: <20260527130222.24348-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MMkVjSP788VvXIrbLnnDtl6vcK9MHkMwbDYrvlo/FHUkL4Dz3+3/vCxK
 VxSQezkzITq1APx9DbIqPPPJfMpBDO0AsUur4OOj7Bcx80JftORUc326cz8H5lZf2WwTPhW
 sTvyG/trVCRTY29bZSDMobI8RMpTsdAOs13wnATINYy9xv87cdh09+jQCrsoxUcx1nIxhhv
 Y73H/UhmfdYqo6Po2MomyURz7HsB4Vz0380dhfy2ezrgTnO61NJDN+kM2EAEiAQBj2ou3n1
 93ItGcFA8WHdozsHKue7UgAf9yRxOoeY4hp54r0Y1s1SetYtzuPnf9ca8uWRa4i1kMUgwUV
 EoW1aBZmM6SY9XuvmJow9HhINU/1ZNpre/Q59lTInvtZvmwXIV9JhOn/Z8n1oyaXpfldKTq
 OhCEqci9eS8g4c+VK8bo6WKLKPaTWo0J7IHrxtLL1hg9yZIEr5Vb1L3/9NGLAiBbmt5msUE
 9Tg7HeNt49XG2LgZwxDr0uYVYnkdk4hvrinQlW7jX2jXXLH9YUVlLagKgfjyeEcmgT1VTmf
 kcYyzQzVSmc47HV/RTgEPYHcN0ivPUHjEt/tixXrs4aTcb0cgoRG4VYzBDYxoljQ5ven3QH
 8csF3q9NzXR5aOyVG9EaHNtJnyT1YnpKXh3rc/c8fM7+Oh2/tGklnbsEGjz0NtFrGmJR2u2
 WzZfoh1pGVvqIfOi8fNjy2dEHFH3oyauLojwJAlZIazuBQrMocywU3Q9S1dh20kK9Jo9M3V
 yhdI4VjMXfAAw1n/PUgU+VoAGuBMoUqSUgo4uiB8HctNP0KkkxQ+wFm0k0PU6TeXoVEGYYN
 v0uL9bXWfBRFahTTKgsxQ4nmStvUa2XBFiNGluTqjvDQAQvkdhRo6Oc0aJi+PQxnAQC9G1E
 ANse1oVLMVIlVPSi3XBWSHVfjaR6FYAkocVp1gIekVoUG+o/akqqsdCvMvrgLkESnb0eIp0
 N3w5563urPMDp0EFb6xXQLcxmaFUEKVjlCV0Zk2i6JKnue7/+13Iznmu/+FWejri875x59H
 BtOlV4cSrn8BKHBXdWoY+ELpepsuVLku59FMFXQfZJ24AmlFEqumM9p/N89/VnM+1kh4+ZD
 VE+Gs922ksgsykoNObIsuU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
 drivers/net/txgbe/txgbe_rxtx.c            | 14 ++++-----
 drivers/net/txgbe/txgbe_rxtx.h            | 35 +++++++++++++++++++++++
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |  9 +++---
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e2cd9b8841..2639712336 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -98,12 +98,10 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 		if (tx_last_dd >= txq->nb_tx_desc)
 			tx_last_dd -= txq->nb_tx_desc;
 
-		volatile uint16_t head = (uint16_t)*txq->headwb_mem;
+		const uint16_t head = rte_atomic_load_explicit((volatile uint16_t *)txq->headwb_mem,
+								rte_memory_order_acquire);
 
-		if (txq->tx_next_dd > head && head > tx_last_dd)
-			return 0;
-		else if (tx_last_dd > txq->tx_next_dd &&
-				(head > tx_last_dd || head < txq->tx_next_dd))
+		if (!txgbe_tx_headwb_desc_done(head, tx_last_dd, txq->tx_next_dd))
 			return 0;
 	} else {
 		/* check DD bit on threshold descriptor */
@@ -645,12 +643,12 @@ txgbe_xmit_cleanup(struct txgbe_tx_queue *txq)
 	status = txr[desc_to_clean_to].dw3;
 
 	if (txq->headwb_mem) {
-		u32 head = *txq->headwb_mem;
+		const uint16_t head = rte_atomic_load_explicit((volatile uint16_t *)txq->headwb_mem,
+								rte_memory_order_acquire);
 
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
index 00847d087b..3671326084 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -94,11 +94,10 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 				      txq->tx_next_dd - txq->tx_free_thresh;
 		if (tx_last_dd >= txq->nb_tx_desc)
 			tx_last_dd -= txq->nb_tx_desc;
-				volatile uint16_t head = (uint16_t)*txq->headwb_mem;
-		if (txq->tx_next_dd > head && head > tx_last_dd)
-			return 0;
-		else if (tx_last_dd > txq->tx_next_dd &&
-				(head > tx_last_dd || head < txq->tx_next_dd))
+		const uint16_t head = rte_atomic_load_explicit((volatile uint16_t *)txq->headwb_mem,
+								rte_memory_order_acquire);
+
+		if (!txgbe_tx_headwb_desc_done(head, tx_last_dd, txq->tx_next_dd))
 			return 0;
 	} else {
 		/* check DD bit on threshold descriptor */
-- 
2.21.0.windows.1

