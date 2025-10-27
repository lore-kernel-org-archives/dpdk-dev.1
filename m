Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29897CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 680504042E;
	Mon, 27 Oct 2025 04:16:02 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id E5C13402DD;
 Mon, 27 Oct 2025 04:15:58 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534955t4f0d43a7
X-QQ-Originating-IP: sqpI+kWpkLzcsfh1gnnBvEicbB3o158gzMAAaUcNQ7E=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:15:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1477620559860670365
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 03/19] net/txgbe: reduce memory size of ring descriptors
Date: Mon, 27 Oct 2025 11:15:26 +0800
Message-Id: <20251027031542.10512-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OMnP0zidhno0D01r28AyabTs3haEF3qF1IuKc3aSb/J+ZTgl2DINhMHX
 zFDY6gPAIC/hp46f0I/UwW4/kYT/0mkU94NHVCy8SowgBNa0QsoQHdj5uGa+oYzoUm6Ce7h
 yWEX3C9ThaLj+DPpluB82ifrragmLVFdQnmU+caouYxyPkyFONSWWHCY8mfQudhNsiM5BYL
 vpm4zBm+UjamZdV/ISnvFtrBVc8mrkn8hRUjSWD4Sl+hnYekvwR0u2mCs3HU1FHpV8LCcHf
 zchItXKXW75CPoLUW1w9GpJ3aG9f2S1A+jWZ8NA2zRUlnh4joaYzpXr3wNigA2NuLMBZVjw
 d9RLvFP+pPJQUYPEYXdOs61zGehJleQSaPr4c+nMynJnMPcAloSGrL7iM6qjf1bdpAZzjUa
 8jB4LX4cqTrrFw/Dw1sfHr65yOnwGmYjgfsKRm2EN6f2pVT136BwRV/7zkMPviLfy+WYjaC
 OkVMIJ2n7qRQEKT8DTVZIeCtA79Mr8B9cvEQejEZKlWy0OK/DinY8N2uuSQeW8eptZLjReY
 BzxtrkqwGxAkeE3wQk3qChmznUtwMq5rUe27JHQbhEf3OlvKJTHwFAHlGwHQsSrboQ1MU+5
 Eut/UJ1HbV+boe8wedvOA5YCKcsCQ2K0MST7ENOhBtJPovKQ4VIOtNjLC8NhVECt2Zcsnvo
 eKcSuFFhBXrjzm8bFXw39x3ercbrWd4tLxVtDx72jISTrnAnBbFc7xr60cUfEqlntBVFHAC
 w/6CHkH2Dt7Quw66miZn2FmDKodklF8EYSd6Xo95Nbs+U5fAkcePyUs6E/AkbxtmntT8Vwq
 xcIIWladHzIelpfnvZsTJMAOursb6KdBi999XE1hgwK/E+3RxckzScAf6n3OM2PXsXJhWlI
 TNgykeJHGxWFy/5Yy3gzKmFf7apBVizKJ5iU9oUv3SRP/XfVkKvn5xE6E1YZk/EPIWSNhci
 TKywAyd3prLtnUNTBCYQPYTCxpsS93e03jw27B9sKJ/IlBX0exKmKyenFarl0dg8ZLo+nbX
 4XVYdVtd+YAlDjgsMp2/jMng7FSaP2ex5Bn02nNA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Fixes: 226bf98eda87 ("net/txgbe: add Rx and Tx queues setup and release")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index c606180741..d77db1efa2 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2521,13 +2521,9 @@ txgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	if (txq == NULL)
 		return -ENOMEM;
 
-	/*
-	 * Allocate TX ring hardware descriptors. A memzone large enough to
-	 * handle the maximum ring size is allocated in order to allow for
-	 * resizing in later calls to the queue setup function.
-	 */
+	/* Allocate TX ring hardware descriptors. */
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx,
-			sizeof(struct txgbe_tx_desc) * TXGBE_RING_DESC_MAX,
+			sizeof(struct txgbe_tx_desc) * nb_desc,
 			TXGBE_ALIGN, socket_id);
 	if (tz == NULL) {
 		txgbe_tx_queue_release(txq);
@@ -2781,6 +2777,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	uint16_t len;
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	uint64_t offloads;
+	uint32_t size;
 
 	PMD_INIT_FUNC_TRACE();
 	hw = TXGBE_DEV_HW(dev);
@@ -2831,13 +2828,10 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	rxq->pkt_type_mask = TXGBE_PTID_MASK;
 
-	/*
-	 * Allocate RX ring hardware descriptors. A memzone large enough to
-	 * handle the maximum ring size is allocated in order to allow for
-	 * resizing in later calls to the queue setup function.
-	 */
+	/* Allocate RX ring hardware descriptors. */
+	size = (nb_desc + RTE_PMD_TXGBE_RX_MAX_BURST) * sizeof(struct txgbe_rx_desc);
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
-				      RX_RING_SZ, TXGBE_ALIGN, socket_id);
+				      size, TXGBE_ALIGN, socket_id);
 	if (rz == NULL) {
 		txgbe_rx_queue_release(rxq);
 		return -ENOMEM;
@@ -2847,7 +2841,7 @@ txgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Zero init all the descriptors in the ring.
 	 */
-	memset(rz->addr, 0, RX_RING_SZ);
+	memset(rz->addr, 0, size);
 
 	/*
 	 * Modified to setup VFRDT for Virtual Function
-- 
2.48.1

