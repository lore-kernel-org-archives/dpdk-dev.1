Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E357FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CBDE40A6E;
	Wed, 29 Apr 2026 12:26:30 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8F8C0406A2;
 Wed, 29 Apr 2026 12:26:27 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458383t68f8f7b1
X-QQ-Originating-IP: MlvG5KXNyEOJGdaD9Gg7bGYshb8GAKUT5Po0ywQZ2e4=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13716076639812210846
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 07/20] net/txgbe: fix Tx desc free logic
Date: Wed, 29 Apr 2026 18:25:01 +0800
Message-Id: <20260429102515.58880-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MCiK9DnWZEXsgUdRCXfUufjCtFepzjzUSRnxmMeBnFjVHdMePe8MXZ6c
 cz2uIky/PiplGwJdH+1mRAdcxwoVJ32jS+8B44Y4H29ZZHN2F3ag7/fZz61fUbAGKtoJSNg
 N8hS05xjKnQltsuzX269Wb1wrpYtOWK0HoWS6I1xqidu3reTM3F/YLnszZFsMYd1zW8AXV6
 xDu9gKGJGo4vvy3yCp4eBF7ztzAfNRaKYjuaAzx4uutUJbsor5Xh02r8snXnClXdot2eM6o
 qdpM8LijYk76CCaPamB3OV3XmC7OQO/SA2A2b47wjXtQdkumXGmXnJpYlqVnoEzxaJM2F8o
 ca88ONVKlJ39MsvXhARTuBcf0j7yCFpHviWyT5aq1c9Uh35hqri9aCoRus7OQgfUVhAnP2j
 LWTpTkf65UOnFAGFjtBcCwiGYaNdW8mW10jMx5NNoRvJQBTm7ZYG2kHm6j5Jgl3fFEq4CkF
 LOcNglym6QfjT5DRNY/KlLvMSHUXgkTFoOLqrdico9Jdzi/orn2v8rL8oh99QrgGV01ob68
 3iBunyu0gJAjUWfNJYE6vKp6CgvwI8178Mhkr5WY2bY7v/TLdZh+eLf3ysPr5TrxMLLbhTc
 rUfkv8QXq/X7RM5j4T8jZF/WIiPFSncRtwU+TCZA93WTaD2aL4+bUUIASTPMBOsInj7QzS9
 UtntoscZlU7oF4CSpS/qOLAqvNVnsyZkYiWsXiH0WJdsnBze4zRIzn4a0gzKnL2QLkPVIjD
 I5x52nNlCnEh6piVkVwq0zoS4s+5HlXLt6A8igYVUvGeTC8TGoZnPx0SnR0VT6Ei38BMd2n
 N6Z8KivUQ2IweNlmv0XaPzHgKlWhNH0p2ddEIo+HI1fKc8pvxPSMCXbVuGtn/x00bih10VU
 E+Mez9Y8rfK5cZZquEKu2+HM7FWLKyTKc4KxrF1n/hXgA7UF644PSFXXwmpS/IBYKTXt8DZ
 FUbtcB2JwQsxFe3Go7SsaJ42U1vQlw9korvxk5kwnk2M56fM+lrEH0ymB6B785yiTOV/FsK
 l4cUwUueKgGqszc2I65Iotlrk13dBU8bQvoLvHrh7TNsxtcMIV
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

