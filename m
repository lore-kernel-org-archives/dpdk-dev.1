Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D7FAD3F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D31406BB;
	Thu, 23 Apr 2026 05:41:20 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 3404740648;
 Thu, 23 Apr 2026 05:41:16 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915674t2692f7bc
X-QQ-Originating-IP: J5o8AskCo9LaAAnMA/a0CZ+Cj/FguLMCxFDsa9zKzgg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8688943966282058344
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 10/18] net/txgbe: fix a mass of unknown interrupts
Date: Thu, 23 Apr 2026 11:40:15 +0800
Message-Id: <20260423034024.14404-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Na1lnm+VQEKDS/h0NqnbjOzOtrzSgk6tlU4o5AQwK2jaNPtrSfwo2y5X
 /1FcJk8d8pkFXMwdEq6fQJnhysL3jc7+IVor9Wb0uctDDsUFGoRHUxEgqlfkRWemN267cpF
 b/pwvJlg88tpJyVPHL1D55qjAgF3TyLDU6sVcfQYHIzSh8O3IQbWySK4uPGqRX9TyULNcMq
 5tXmH4nwaoR1g+OvW2E4BWKfip/BusUvXMxxpwFxSGRV3NoAg+M7P1ZwyldCeS5q4rKAiKH
 F/PgMq9vfxywxpz/owIq/WMRRNmrDCfnBou7c7sOVcFMXBtvAkqu3eMksOPsSsUx1V3n9TC
 MfJSvxwmqhB1GKxuNaKSaYZpGppZC2PLFaFlFw4n1Gmk8y/E93R9j5nAPc5iCwG+H/kDg6O
 L0SDjo2Onls5v5MdghER4Cq/6FV9pzHZC5oDuqjH4jIgl7zqIJlC4g4yERpNdma8V9qLs+n
 OxrntF+qJ0ODTgmaQzhHDQS24SmS+rCSkb8InRWFKXb68f7MXNRtrAwTHa7/qk8F8Y55VCj
 /0xOZMmcZ5eEMg3Eiz6s3uedH/h/zbQyQ4QdsW6oAM1FGaY9V1N279O893gVHIpqtC8/V1x
 G1p2QZxOFxgRRm5a4vX5drSaZq+GZYUhC+bP0VAurBavZi1lL831782wo/uhb2uVKwvDq7G
 oH8KXjWGgQX/odOHkWJSuOptTxYwS6xQp50qitlPBfTHDeuuoGd0MAzipXynL+klzptJuxg
 8l1+9psZspNcrAj84k5l/N9LHvtXQN2rjC/1UggD0BxUcbylhF+UPRn++4+BLoplK6S3inH
 f63xHefmVmSXmYpNDoN8gT4AKlAZCUajp1vMAgzc0r1Eh85lQFzzJvsSW7M1CbcIZFDuIJ+
 oC2U/GArvMFC4DHUWGEi9c8tEiiFkDVkKjvA5PFTeWbXABaszImoXerPea5+jbuN0lBbekR
 VzsQ2M41OR1o/i4Zd8bNHMHujgDY4f8lVHWAwXLz3Adx7rkh/nbdQlUi568mVs4Jceh73M9
 6T2EwyxyRNCbC4WNDmP1SQ5vXhfGvFC9lUZJfe+DQ240EtBQwSc40sFt5ecxXGtQ7EnQ+Fx
 JWsHfRQ9WAiofC67yP9vMk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 72a4965693..be279dc4ec 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4354,6 +4354,8 @@ static int
 txgbe_set_rsc(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_dev_info dev_info = { 0 };
 	bool rsc_capable = false;
@@ -4404,8 +4406,6 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 			rd32(hw, TXGBE_RXCFG(rxq->reg_idx));
 		uint32_t psrtype =
 			rd32(hw, TXGBE_POOLRSS(rxq->reg_idx));
-		uint32_t eitr =
-			rd32(hw, TXGBE_ITR(rxq->reg_idx));
 
 		/*
 		 * txgbe PMD doesn't support header-split at the moment.
@@ -4424,6 +4424,9 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
 		srrctl |= txgbe_get_rscctl_maxdesc(rxq->mb_pool);
 		psrtype |= TXGBE_POOLRSS_L4HDR;
 
+		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
+		wr32(hw, TXGBE_POOLRSS(rxq->reg_idx), psrtype);
+
 		/*
 		 * RSC: Set ITR interval corresponding to 2K ints/s.
 		 *
@@ -4437,19 +4440,20 @@ txgbe_set_rsc(struct rte_eth_dev *dev)
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

