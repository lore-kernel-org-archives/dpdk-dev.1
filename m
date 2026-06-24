Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709DCCDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B2C40DD0;
	Wed, 24 Jun 2026 13:53:32 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 324774067B;
 Wed, 24 Jun 2026 13:53:29 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782302001tbdf130fd
X-QQ-Originating-IP: HdavMuBD8M3S1JQQth3g5TOxAE7JjurkUQJBUyZvvx4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10054640437661575899
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v10 10/21] net/txgbe: fix a mass of unknown interrupts
Date: Wed, 24 Jun 2026 19:52:42 +0800
Message-Id: <20260624115254.20348-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NAl3ryHMp563mMzqltkn8mM4kbieYVmoED1PDfm0FLcpO8+LMlWVQMjj
 J/RAz7nDX4hvypgmbF1OD0fRjzARbXYLrYyBwpIc9KviFopKuwNo+0syj02ykhMiXS18YfP
 lZ0hIJZJxfkDDlstp6EO5MQhWQCjvQtQWwLZd+fWAU0eHBpxJGZC+qyVGeM0cBd5uPxcPV7
 Yk7p69u+sX5R6uS9qDMkVX7tsfJ8wyEk2VL9FiW7k6KkWLIiujck481pnCmuf/L/g7DADwE
 LqeS0YIXTU7BOJARoE/5lVbbyybU/5Xy9oe+TFL8rrVZuzks5PShl/ZPb0kFkbXaG4jMRRz
 wrYtkFYdSQ3Dz2iXA0lO6NLQ2o/IfqFeg7Ex4dW97Chdg6tDuOtzhm8651gll55KLPQmdIb
 WVNjsjXA4dVa8hemXlPbHflTat1/h5L0GMBPYTvRo6M1LSHyMX7GxAJ8Zbsqi/yvWvWbK1I
 WlCXzpi77k0P9nxmC9ZURYEzNH0aTSUXst1WeTaZomHj9tI/71njhsqy8ee/go25iYBbX9H
 iggshV9jgdmLvd+vZGkobZ9SQjwSHxaovY2azCpPiVX4aD/1EsJN1CXz5kV4HS6f0fwjQ9v
 aCw6Ze0FzGWDJteq8Xrushqa8qRlNsiVIi8RU/nPMGEv27HE0N7xh7EhlaMMmfeJPAuphNj
 FoicbRNW93Dfmbym8rl0UIbxBtuumyfRMI/IL7sHPV4M6Q1lnkjVFES0ahKYsqcJ2JOXcK7
 a0bEsMMXWnOkz16+Fbs3C5Rl+idp5Negl1SJLO6+F1XzkAYEt10v47L/+cI6q/8sg17JmLC
 iWXNdPtwflYuDSPPPHGC4GHWv02KkRX9uVoV3BET2xlCfOoyIRo60z7ZO5py9xM+W4Z59Zt
 46mWp6uLt4de1OSC9hH/SbCe9jcsIjl7LJ01hD33xdFDeD5ZM9Y7ZidmyFOCEpRagVMAZnu
 baLBUFQlOuRrwfchf4UNeNw/5hLmL/vjKIsDRAA+feo+8l9d5jYw2Cx+qb0nWF9gpq6Pi9e
 XGzQAt0tVRC5DXLyUi57QLS1A3ABYO1+uY7XMOZ2aCv0+M562hoS1tbQTau3urnBr4E0S+p
 xkvBJW12mvkwQVli7H3Z9MTkK2i876C1ufe7yOe7uax4+/IotIelco=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
index d5dcec3a2c..906ff16b67 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4347,6 +4347,8 @@ static int
 txgbe_set_rsc(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_dev_info dev_info = { 0 };
 	bool rsc_capable = false;
@@ -4397,8 +4399,6 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 			rd32(hw, TXGBE_RXCFG(rxq->reg_idx));
 		uint32_t psrtype =
 			rd32(hw, TXGBE_POOLRSS(rxq->reg_idx));
-		uint32_t eitr =
-			rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
 		/*
 		 * txgbe PMD doesn't support header-split at the moment.
@@ -4417,6 +4417,9 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		srrctl |= txgbe_get_rscctl_maxdesc(rxq->mb_pool);
 		psrtype |= TXGBE_POOLRSS_L4HDR;
 
+		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
+		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
+
 		/*
 		 * RSC: Set ITR interval corresponding to 2K ints/s.
 		 *
@@ -4430,19 +4433,20 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
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

