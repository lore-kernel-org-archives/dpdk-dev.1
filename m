Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D449CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D585340695;
	Sat,  9 May 2026 13:29:11 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 6FAE040678;
 Sat,  9 May 2026 13:29:08 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326145t1e40471a
X-QQ-Originating-IP: JHTGKRZmEAqP5lox47B/M77WGuZ2RYL368MnUO8WwAU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6988144633491017905
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 07/20] net/txgbe: fix Tx desc free logic
Date: Sat,  9 May 2026 19:28:09 +0800
Message-Id: <20260509112823.7728-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NL1XkljEko2CeDmcpi3vJOD9YLKsocxdBy3Qs0hSY/IjLkAsteJwlREY
 KFpEVa3EanTmxN87u7/1NpMX5+whDIw3j+yQ/dJpq7O0i9crWQJfYgMAI220r4QICqDdSD7
 BF6FwnIS2sh2yJboC34fRjA9SAwIiZt2hHVQgCEgRs6GEsj2pJsHnyM637jQtiCC4aMyUuE
 jSytcdLvBym6mS6DyjUkXjsaezRZl4jDjVJ9pPTQxYiV8a/a4IcEE1RoJpIeboPunxbyFH0
 /hwiLCKiCwnBG03y/WPizLpDtx8QaJdZf/5zrQS+j5Vm92+qULFqgP5P8ScvSX+JYwsW59o
 Ip9ECI1isPxqDZAhUjGjJRrb2VxjVTXq0z2yFRvmp0QOQX3T1M7M5BfLpLHh595WAFzTKf8
 v/Aq8LBYPjNo2fYFUACVPCPwz3jY08JexECEKsBCDGH521nIGm+fGwOt0vh3lcGtTqxBhTw
 AOk1Oy+/Q8LB4az47t9Q6sG/PggN0s3Wha2VEZUO7n+hoj8Swie+q6nTHQH9frCp7RNJf1y
 2A/qer1eiR5qW0roxk+G3Da2dKHdFjZBrs2bUEkHqUGCwCsNxnxqZUGBwYjVnhfgga+HXOY
 TGYHdcgf01jk+ZslJ0JEayI3EXqYOzwUtI6ZeLPK9d5KKbY3VD4k1wxCwzA3HFriGohX59m
 0kZnzSV1q+OPtqVOVt2lq9LxKUy011B819/B0pEaJ9igDVfHZ7E/SJXec0bigKdtk60Qs8c
 1qcHOIIfdtal4+NWjMKW6DSoPBb1Z7xrWOS9gmtaZvQ3dvAW97d0mfGHj7j3UT/hae1xLE4
 zamItp+fPZON2R0NB6OiPfkZBKGdy7a7CVpwgEENd3VhP/Bwtb4OXqduoGnTJ8kCV5DlO82
 3X8ht46/mAwg1H1Qjo29Mnz1qbNWlSJlrBxu8xKb7I9VLB1Xmb3RufWthD3WiY+TAo8/Vxe
 6nGWeSQqRjWfX8/S5vLcvAtTU6ekvdBjmWbxvu3wIVYEEANTDzps0knEHOBWU6pksBiYGoc
 2vW5T5/9pp9rNSyg2/nHI9NpUw3/XfsBYnju58saA6hMLPs7j6GPTfmE1hVKMtwKf/Jk1ae
 bis4Ey27XVU7SRokO1ZN5YYh/KhvBVu6lHAzORJL9xF
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

