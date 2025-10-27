Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F0CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B76E40611;
	Mon, 27 Oct 2025 04:16:03 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 3FFF4402E0;
 Mon, 27 Oct 2025 04:15:59 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534957t8d2d4199
X-QQ-Originating-IP: v/NrmfgCRo79tMVw4RHdgSb46A1gph3pjufen0WgmYU=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:15:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15473540554250636557
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 04/19] net/ngbe: reduce memory size of ring descriptors
Date: Mon, 27 Oct 2025 11:15:27 +0800
Message-Id: <20251027031542.10512-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHg/5UkJGNUJ8O5WNZ3PK+E7iK8Rh+1HQPUekfht/XAl5x8EwjspJdeZ
 hPpydpjosgr+rxaznPR9/ZTBfAYQGonm5IcYmMihU+6wqOZGZ6LbII+kFug73C9OW7mmo2J
 2pc3YnQKRkFT689t7Dposi8d5yCxLaCZegBohhP5c3Ziil7RR7PMDPaoGVp1pq/XYxz/yPX
 nb9EUkboHR36/AhCA11WdQeV69NlJHLR1HmZWs9rKyqx7ueCMkafnmICmcHzZWPW4QKpnD+
 k47G/rd5ACX/8meUAKFV032UcOw6rAiHnKKYXuQUVm/9uBxXEJLysCIoizfuPx5TTrwoN2m
 EJDwAC1SuRaZKTr4HBuC6+jI0CP6cOFvvqlEW8UVneRSJZsfRKDLrfE2RKguF5vr6yht5q8
 cXSN9rE919nxt68irRKYBwIBPH1Jq+e6kQwertUdCgY+zIq1b8bu0G6bQNxiwromztgZE/5
 M2fQr+JcR1QHE/murhaYnJCq6+Prl8etBFZaeF+OxLdG6BlYVGZvkvMuLYqH9DBz+k/2EzJ
 RliQNT/X6aUgAaXn0dmve0XwEqgT1jGSxg0GBHb3BYDZwMRDiFyJqlHMVyLyAL/vpZ8ztlu
 eBRWy/NbYPeWgngxazJpgouO3EIFjrjzdgOLbX7Zz2PMNYljjJxQogtvbUogHCI3RsOZRba
 lgin4KTQOARahKHN3Zlu9toizRHy81g7P5W3E+d62tBxGk0uMHF43yZPfNrtqznovHdNFV/
 QGWpB+lWsjb8Y3667sGn/wcKMDNsxu5dZ1iJVTfOya0+wxIITtqSe14KN737LNCO0pjVoXj
 s29hV3eXJu4oFfreKk0JvRrKvRR9FZvDo43ZMQ02FdzWljK8vp7Bc2FY85Vd3h3g1SqFYT9
 jtSMj5aHYJfRgIQ/tXMHRhlE49OdJc4g/6Q7QuIKBERQOJHuWwwOghFwSpgPZxJSluz8aXX
 x5eW14X43CQQRYskPeXq8DsN/sJcLnxqGMh0wi1+jQmtC0zh9Lha5KvtJuRY3Ls4xvCu9b9
 j/CDcd9IOwSONmtMjyRb7OF2pxV5W4ooLFPd2IW5f4DgMoQ75v
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

The memory of ring descriptors was allocated in size of the maximum ring
size. It seems not friendly to our hardware on some domestic platforms.
Change it to allocate in size of the real ring size.

Fixes: 43b7e5ea60ac ("net/ngbe: support Rx queue setup/release")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/ngbe_rxtx.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index a60421293b..03ada844bf 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -2058,13 +2058,9 @@ ngbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	if (txq == NULL)
 		return -ENOMEM;
 
-	/*
-	 * Allocate Tx ring hardware descriptors. A memzone large enough to
-	 * handle the maximum ring size is allocated in order to allow for
-	 * resizing in later calls to the queue setup function.
-	 */
+	/* Allocate Tx ring hardware descriptors. */
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx,
-			sizeof(struct ngbe_tx_desc) * NGBE_RING_DESC_MAX,
+			sizeof(struct ngbe_tx_desc) * nb_desc,
 			NGBE_ALIGN, socket_id);
 	if (tz == NULL) {
 		ngbe_tx_queue_release(txq);
@@ -2324,6 +2320,7 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t len;
 	struct ngbe_adapter *adapter = ngbe_dev_adapter(dev);
 	uint64_t offloads;
+	uint32_t size;
 
 	PMD_INIT_FUNC_TRACE();
 	hw = ngbe_dev_hw(dev);
@@ -2357,13 +2354,10 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	rxq->offloads = offloads;
 
-	/*
-	 * Allocate Rx ring hardware descriptors. A memzone large enough to
-	 * handle the maximum ring size is allocated in order to allow for
-	 * resizing in later calls to the queue setup function.
-	 */
+	/* Allocate Rx ring hardware descriptors. */
+	size = (nb_desc + RTE_PMD_NGBE_RX_MAX_BURST) * sizeof(struct ngbe_rx_desc);
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
-				      RX_RING_SZ, NGBE_ALIGN, socket_id);
+				      size, NGBE_ALIGN, socket_id);
 	if (rz == NULL) {
 		ngbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2373,7 +2367,7 @@ ngbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Zero init all the descriptors in the ring.
 	 */
-	memset(rz->addr, 0, RX_RING_SZ);
+	memset(rz->addr, 0, size);
 
 	rxq->rdt_reg_addr = NGBE_REG_ADDR(hw, NGBE_RXWP(rxq->reg_idx));
 	rxq->rdh_reg_addr = NGBE_REG_ADDR(hw, NGBE_RXRP(rxq->reg_idx));
-- 
2.48.1

