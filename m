Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E0CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D185A40A6B;
	Mon, 11 May 2026 12:37:03 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id B42BE4060C;
 Mon, 11 May 2026 12:36:58 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495810tb7884834
X-QQ-Originating-IP: Gyi8ouNsbagou8uAyG6UqtDQuVJp8WOjq74XqMjOAdE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6599888055775018967
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 10/20] net/txgbe: fix a mass of unknown interrupts
Date: Mon, 11 May 2026 18:35:52 +0800
Message-Id: <20260511103604.19724-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mm/8i8/T4yneU5jX/ZfI5I+VDlhyc1xgTr8mCt1WzKecWvYJ/ukvbw/E
 z+KIeTyAqW4WEdzrIOZ/qNmGK3BBOS52bD2EKEbZGpOfW0E5tCAZ9EpE4hD6V7vdllo01mx
 VRvmtj6VOeJUArbHHEBpuLEDv5LP9ySohv187+u6UHmZjpvlqhVDAMurH7CMM0m7l828jic
 FurylmPhg9k1abqflrR4CwQhia4kWUGzpHtVgmHaJUK9VpD68bIX6xwSv8uochJ5Zei2zrO
 8Lo6TMqRJmtcbcSsDs4Y3hysMTEl67YlUdIaUEGlWjgy1KjKaqamGM1J9ntxZbQLrxjS8gS
 qC1NbILKX6Vb4UIgpOmoADduVLVvjmBJ/U9TVJydRuXnz9jj1EtKsq7a2bDNAfteMP6M2mh
 7vROmazQiF9vhetQl5Lf+/kOFWTkCJy3LIp/VKb6n14SoCV0AU7pHb4V6LBqIzQs30ZjC8X
 FaGFfZzJL5sYLFokNyXCYfTZC+fpW82IC/pAQVC+ynXHZaJtAKLU55aM8yqVkdjDiT9F2nu
 grmn3GoSG1ZcuyzcKlksBa1ZdKUh+HDdbPjypbjTkHPXvIIdhihumUnLv5x1C5NXyoxdCk7
 8tIma5sNQh44micsmjvtZ0NRi5YCSDPZaCJ1Wl6WKEviJvcXX16+2yh+SgeaL+NhpBYb8Q6
 zgc+/1NRKVuM1nkfBUqWmAwn4EIMCLorii+fIFnO5sJAMeHhWqa8eQm4FMfK1jFUvjQhYB1
 +IBs7K81IdfOGn09je2JexcyfSWK91HfihDZabYgtQUb8cg5/OINp0PBG4R9oDSAOkbBWvE
 Sm5Zxhph6N+hGLyLOEYF7NSmnjwlsyvxAzymGKuhqR/S4NxR5OXl7Lx0X6sZp9WKkLkXvE/
 2/ylMCIwDZkFbGdW9uJmU1ekhGGUqN3Ml1jMcGdHIUu9PTzVdm2nmikJPwepa8XAWDj9U3x
 sMAXK7+g7CKKmBqKJwCgUhD7OBrb+8DzZKovd1J9oaVjm3C2gaCTcK7fnr8OVbXaW8FWFeY
 5AX9yF/vz4DmpMc3HZfdYla93P9Zj54ruGPiFe97d9iGtsxaxW0XjhrXBnoEbCzYzuHAcHk
 2XVGPSIkVizwj22X3p3WzY=
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

Fixes: be797cbf4582 ("net/txgbe: add Rx and Tx init")
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

