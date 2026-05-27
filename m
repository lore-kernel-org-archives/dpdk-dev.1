Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DCACD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817374067D;
	Wed, 27 May 2026 15:04:37 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 7B7F340653;
 Wed, 27 May 2026 15:04:35 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887020t02afda04
X-QQ-Originating-IP: HOwXG4n0Y2tcr4U9AQlArbcXXpvrCxvUkWsxZ8g2HtQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10981817445175204367
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 10/21] net/txgbe: fix a mass of unknown interrupts
Date: Wed, 27 May 2026 21:02:10 +0800
Message-Id: <20260527130222.24348-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NIM9fEB8IbgPvuPIy+5FXzigj69idPddMN40hyw3N0FHrByOAZ6Z0G64
 OVBh8+VTDS/DeQb4hLJf6XlGUhUG63VodzCku/+j5CF7dTx69DfgvTXJXsQpyenwXm9oJgY
 M3N3NO+EhVSEcAKQCKBTrUI3QzDIS/Ck96asTmy292kjOkYtD7UekamM6Awd8j3gHbvoReU
 aI0LRKEp6WrUza81rCejQ6byFiwXtYOP7JOiD9vkuw1WnB0TQ6oVTCxlN9v5up5H7ieDjtb
 juMYuqc2n5aeraNVS86yngcdqKZl0S0KcpSdzuXWC2KWIOTj4ottxB9qqJyGZ51u8l6nIIn
 GBWflTQmuXukwfnD9+fAhMCJGrreMbztx7mCjSPH+k0CDuVPXcKrlD+ZmGTtcPJ6rCWQsWW
 L+jQ5KdqdRxSnMPJ9sFMLsjvoRabv61UCxfqNmf8Y4heL0dFGEL6Xm4yDF5I6z826Y53bvr
 E+0sjiwCv7BvY8WxPqQpzPHCK0NlYOm9+rxpHLk2di3wDLJ1fzBEaDaPnfXpz7xZcotMCBI
 yev/YKvDpvsfXydAnQ7mV82LRvLXGsN7AQ4hUo5FvbdRM04pCcK52T8LC62ohDlbrNpTv0a
 ZTjiARImCPwMZ97xHRChjc81wLUUcVBsDUmawAe5DTSNhtTQOx2onrihyF6Rrn6yhcnZRAo
 JmUTk23AcmEVzKS85Cx0T0SthsBCix/1c1lv4Fhjjz2X640P6wXyF6TPLxYAGjFacGWvk9E
 vQppzAst4F1vkEGyTnL4zFUWfy/4jkcAH0kFUE4ivG5lkqhfNRhz6FC5EMTqVCz17SBAnLg
 R2MgzoktValjJnyhk6iyn8s4qB/xFxq68nYXEoQx/brJIXT0jThLDTmKl+fQVoaspb3dgES
 xnCS9I0PKZXFO2rwMm6g7Omas0nzaw/7D7Wf5fqD2sz1Il9m1M6dygvyIxAwl8JPoYDB8ev
 tkZnq5u86zvyPE8itKVDCRMCKox5yki25B77sqkIaxU9GJnKBBoIZptPWEsfUyceI3BRE5m
 4uRSGdpbhwXvNQrk+olORNdStpWO7AoXaOrLaOgh/R0z/QcKzRacDpqeu8cN3nHU9FAGtlR
 4sACoejGomLebcGin3VY2Q=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

When RSC is enabled, Rx ring IVAR is set to configure ITR. It causes Rx
ring interrupts report on the default msix_vector. Thus a mass of unknown
interrupts occupy CPU.

Fix the issue by setting ring IVAR only when the rxq interrupt is enabled.

Fixes: be797cbf4582 ("net/txgbe: add Rx and Tx init")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 2639712336..28b06f3b93 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4345,6 +4345,8 @@ static int
 txgbe_set_rsc(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_dev_info dev_info = { 0 };
 	bool rsc_capable = false;
@@ -4395,8 +4397,6 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 			rd32(hw, TXGBE_RXCFG(rxq->reg_idx));
 		uint32_t psrtype =
 			rd32(hw, TXGBE_POOLRSS(rxq->reg_idx));
-		uint32_t eitr =
-			rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
 		/*
 		 * txgbe PMD doesn't support header-split at the moment.
@@ -4415,6 +4415,9 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		srrctl |= txgbe_get_rscctl_maxdesc(rxq->mb_pool);
 		psrtype |= TXGBE_POOLRSS_L4HDR;
 
+		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
+		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
+
 		/*
 		 * RSC: Set ITR interval corresponding to 2K ints/s.
 		 *
@@ -4428,19 +4431,20 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		 * For a sparse streaming case this setting will yield
 		 * at most 500us latency for a single RSC aggregation.
 		 */
-		eitr &= ~TXGBE_ITR_IVAL_MASK;
-		eitr |= TXGBE_ITR_IVAL_10G(TXGBE_QUEUE_ITR_INTERVAL_DEFAULT);
-		eitr |= TXGBE_ITR_WRDSA;
+		if (rte_intr_dp_is_en(intr_handle)) {
+			uint32_t eitr = rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
-		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
-		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
-		wr32(hw, TXGBE_ITR(rxq->reg_idx), eitr);
+			eitr &= ~TXGBE_ITR_IVAL_MASK;
+			eitr |= TXGBE_ITR_IVAL_10G(TXGBE_QUEUE_ITR_INTERVAL_DEFAULT);
+			eitr |= TXGBE_ITR_WRDSA;
+			wr32(hw, TXGBE_ITR(rxq->reg_idx), eitr);
 
-		/*
-		 * RSC requires the mapping of the queue to the
-		 * interrupt vector.
-		 */
-		txgbe_set_ivar_map(hw, 0, rxq->reg_idx, i);
+			/*
+			 * RSC requires the mapping of the queue to the
+			 * interrupt vector.
+			 */
+			txgbe_set_ivar_map(hw, 0, rxq->reg_idx, i);
+		}
 	}
 
 	dev->data->lro = 1;
-- 
2.21.0.windows.1

