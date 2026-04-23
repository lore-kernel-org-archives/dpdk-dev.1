Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE6FAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4CBB4068E;
	Thu, 23 Apr 2026 05:41:11 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 95CB540669;
 Thu, 23 Apr 2026 05:41:09 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915666td1749a32
X-QQ-Originating-IP: YBwaXWXVx/unrZoHWgJemiYrnl+BSZ2/Z5es6v3apIY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15418852069478850439
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 07/18] net/txgbe: fix Tx desc free logic
Date: Thu, 23 Apr 2026 11:40:12 +0800
Message-Id: <20260423034024.14404-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OLp6I6DgxWaIAfHi7bXCMR6FGdVxNbpqsN6K8jTYj87McWh/MHl3PTYT
 5Prn7y/eaNzpdPqc0DQtSzUWy7z3B2YN7SaeIkhXNt5fBdviUc2k8vk/0ftsfm3M01f8oeO
 SnC9RIyf3NXp294AScMS49riW995t87UgLb8KzWTWidAXyygK+akPk0tCmBbpfloz1rZqzW
 hJQcOIGwPU+Y6m9cJB5k95px4GU27JpCYAtPDK+YJ0Tr9DhoPcgMmKW5pgtvZ4v01c40OxA
 y6oCiHolEg9X8MsezO664f+PrFcK51HQBzPazN4kSo7lA3MTkLAWG3curri4XUMFE41wKp/
 B18cGUQg2aKWkqrB9w4Qxr4DASXurl5tmjocCNRo9RyfympFIh/CcyzFrT0f2yZEAcTvaXf
 Klo2alBHGiuJXdk8p5nMV7z702QLaoYRkIqZuF1IQgTehJswrpeKTjsQ4H9/wTq19J2jf6X
 RpoYI15cablryC8zt7BgdQtV++XDEHf6QeC5kIOoNJlwb1QrvEn4WD4FmR/mZDSEAUHIkIp
 ImSp+b1KZdYbysdyzNPnpyP98E4nE2+yAjyMCXhch6gP0wjDgqOQU7e3z1x8LzqRqdycQlg
 NaaepFr6u/XKFbpepIGVUL9CH5jthagtFhLL8JX6scSr65KDJUO6e7zD2l7T6mL4utlVjRK
 I9d3eTDPQqkxhdvbNg0RMn+5EMu7mQIFWwNi0dKMS8hwbVPtzN3uhpTV18hN6Gb1VtJHCGj
 PV+SdobOKuxF3brnDhSmibz0yN6yfajNDxENZP6Z+XE1JNO8yS6HYnOxlQ4+5O1BzDJcYVR
 hJsvbJ6grE83Wk6Biepg3bNo4sWW+/+1uhS6Cge904i1TPQD7dbi2JZMo+YIfKUndmT7SlX
 FeeFI5De3UVFqb2ZngHacAQ4i6Y8X5hrvcnWa6biqpeJ/QbfjvOSmns2UXonPBAGS05Wqqe
 7YDZnNLLZanLSonBOb7CpPPgGhwEXWPKlBV9AOQ8aCtsJN/An1cmawffoK+Fa87d5v7TOCl
 yFWtcsIvMOqr00DZhwWqXhwE3UaxR+hehtW2McGFeIv94DvDt/
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

