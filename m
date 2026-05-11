Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E2CCD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4BCB406B4;
	Mon, 11 May 2026 12:36:46 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 5F06440673;
 Mon, 11 May 2026 12:36:44 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495801tb6430911
X-QQ-Originating-IP: WFsx4mlF/Oktkgql0gW5U+0c2rFM/qBfvT6234trddY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4824376215983365300
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 07/20] net/txgbe: fix Tx desc free logic
Date: Mon, 11 May 2026 18:35:49 +0800
Message-Id: <20260511103604.19724-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NafziRg7Bx69C6cE4Ml9sinPkSkUz+KltB//ZVDSnH3C/cDxdiobOIZB
 Fnhde7iVCVWZQdwFmyvmx8ZwIEXcrDzIiSqjqDHzGrQgV53mPqf5CfLddpsf6JJx1FGmioO
 Y9r9DV9X8exU4402Q4nX6DmsIqlvs/3qKiXIweCprD7F0iGERGMdZm06r9UBQ+5rt1FWx1o
 RjEVUWVoCDq9V2fqrk1l8BE28ulqU4NNt9HHSl4LlCZ4dPUJnxAI1H7AFadfqP0zEomT7DY
 bfk53hYcYXiFRbs4ONu3xU3hbg9WwnsOWbKnJs9DQMxdI6o2PqlbIxDIuVw03K4rN9R10+W
 NoOv+vVtnRxAIxT20dlHmQbRZKubIKtqYfyVxE43Ym3RGs61Obsc7TpdM1DLcWDXFwAMpv0
 6hIWsAD1Q7ve1btL6FXrURvh7RVuEH7Gf2nv716JCzlb5jUnhLXbCFmBiTp4MO1XNbxhdqm
 Cc/aHQHsLsNZcZ+AQxPa+vptZajW1NzYoGzYlmuHYBEbNR+MQ6AWjuX5qDulnFu2GCXMpAc
 R5O/2f08LV6HDOSvnxOdZF4ICTYIvFeRzGIhtyMqJVLHN0TPJartxiq3RJyG5r61dWCCP6M
 MgR3Vrai7ox/IN7BG8kEcd50ZDe0Tg3gi7w4BUZVHMJTNcMmITVblpshKuVgVdJrom/uxuH
 uyTXP/NkXiY1CGUcm5luh3WvxwvMHzrGmrNsubpONXgAWrzr7y39WJIyeoT9RsfCHNTj2Ck
 0iwGqiIR3HfkDXa/KOzi3x2RAS2iWFvjaOFiY7GrM/reWG4wJfPl4DWfB7erQFi0PME+SmV
 p3zj2ZTFJUQ5Qb0w9v2kzlRAJSfCk4SpDmJvqOwetpNP8qEyVy7WVkb0GJIOO1xIma6eYbR
 3dqxodF66uDXFsuvWH6pVSq2dva/JgpKo6FcDv09Xdto4dCCM3eOpT82XmmvBmrduf1PTuS
 64NjopvLy9egAE4SSmDYVoeWxTmGFEVURfhADzxgjRvocaA3l/h7VNlKSXFAFtTU3e+YnfX
 KTllPK3FIHlwJFYS3yOXhLCyF3QbFq+gENMxNkAHUzmuofXI0Z5kTfaXBtnys0A6spTwGEW
 OoZ6ZWjjthuOcLkG6YR6rs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
 drivers/net/txgbe/txgbe_rxtx.c            | 9 ++++++++-
 drivers/net/txgbe/txgbe_rxtx_vec_common.h | 7 +++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index e2cd9b8841..72a4965693 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -100,7 +100,9 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 
 		volatile uint16_t head = (uint16_t)*txq->headwb_mem;
 
-		if (txq->tx_next_dd > head && head > tx_last_dd)
+		if (txq->tx_next_dd == head)
+			return 0;
+		else if (txq->tx_next_dd > head && head > tx_last_dd)
 			return 0;
 		else if (tx_last_dd > txq->tx_next_dd &&
 				(head > tx_last_dd || head < txq->tx_next_dd))
@@ -652,6 +654,11 @@ txgbe_xmit_cleanup(struct txgbe_tx_queue *txq)
 		/* we have caught up to head, no work left to do */
 		if (desc_to_clean_to == head)
 			return -(1);
+		else if (desc_to_clean_to > head && head > last_desc_cleaned)
+			return -(1);
+		else if (last_desc_cleaned > desc_to_clean_to &&
+			 (head > last_desc_cleaned || head < desc_to_clean_to))
+			return -(1);
 	} else {
 		if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
 			PMD_TX_FREE_LOG(DEBUG,
diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_common.h b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
index 00847d087b..edf3586b77 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
@@ -94,8 +94,11 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
 				      txq->tx_next_dd - txq->tx_free_thresh;
 		if (tx_last_dd >= txq->nb_tx_desc)
 			tx_last_dd -= txq->nb_tx_desc;
-				volatile uint16_t head = (uint16_t)*txq->headwb_mem;
-		if (txq->tx_next_dd > head && head > tx_last_dd)
+
+		volatile uint16_t head = (uint16_t)*txq->headwb_mem;
+		if (txq->tx_next_dd == head)
+			return 0;
+		else if (txq->tx_next_dd > head && head > tx_last_dd)
 			return 0;
 		else if (tx_last_dd > txq->tx_next_dd &&
 				(head > tx_last_dd || head < txq->tx_next_dd))
-- 
2.21.0.windows.1

