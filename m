Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786FCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 419A8402ED;
	Mon, 27 Oct 2025 04:16:07 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 07C57402ED;
 Mon, 27 Oct 2025 04:16:01 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534959t5d9b5fb9
X-QQ-Originating-IP: dNQOjvKIHYdWx8Lm1X/B0cGDnzAyyekaQnLevj/Avlw=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:15:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2674874813143135722
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 05/19] net/txgbe: fix VF Rx buffer size in config register
Date: Mon, 27 Oct 2025 11:15:28 +0800
Message-Id: <20251027031542.10512-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MZQHZNohqAr1FwDDf9IzJnpOczmnH0cARaS+fuj0fiFKjvbkGdSVsYvL
 sronsY+1OlYQveJbjL1TzNwQjc7ydNWNwTSDFvy/acOwHS9m2pIBgHzUHoKqjjj2QdVc1lx
 ZmILFIpFGw32GOyWqZQtG2MD78Rn3A9UeDefS7hBTIrxcG+CHChHm13peQ0yK+DPhfazc2G
 shRtZGrnr3U1N+jFtC5cNpX7a+k1NrcuSXL7SMPj0XsJYDvYRl7EY6X/jknmhNAr98Qzb0l
 e5kdw653fMvwlVf7UvpLs47AzlhbKVa1Jahbdoi4B1mqlpyZwaEwcfcR5XRE3ywclPvGNxA
 dpyG3Q2ptjBA6lQqE7aXtdcBZLxOcCsdUTsjmo9ehJPfbtZIcGCXXRhpUYiiYYYsx1d03yB
 dXBYlPBr+Ce5n21InFngrqqwPxhzNPMrbsy0HuVyMgE7uFBeekxUWkxs8XfENfVdKpo9WsE
 8rzV6tEs4YndluD2aDiEKIkrhI/LBmGfuqscqBGDcU2PriV8+NftKzcR9V3X+z7w4ulpRF7
 tJTFGh02otYRIYa6xidEvofVi7wmbUpCmIRWYUoYcC9uXBiNgBxS2DthNVBbkHeC+3muOmM
 xMDPpQEZ9GX1DqLH+3uPf4XI6L9dgSgNGkGlgtOZeuj83kmz7OA3hElBKoIZCCpL4TmIp0q
 pnOLJKE6O1nQE7Hjkd7tW0FlpabsikH7Re+lJp/8kdWRQsvfrvWQiv8dWN6XE1SsKMqJOsZ
 FikJkS4YI7cTXKS0fVdr0UudCi3VnPd3M3H9pzyC9t2PHPDctToqLf8o7rvEcc9vzF3ZqEL
 LpebN+V6agRYb5eiRPksJSAxt9ZrhpSr35qhIMRWnGZ/LQc54CTDASlgzdMq4kHtRPBpeEA
 qLXaS7JuZ40FTCDsHAQ+Ap3E9HEqgK/QALtPVHF7tx35qgh+XSGCAvKYIBUCNw9iBIEqP4W
 5t0DjUz4omFhiXsh8FteZGBK4DVz8kCoFqFal/kEwjFQYS/FJbyKCFm/VgMapMg8cASKlVt
 wS41C/FV+sNR/5W9GzlEcmadbA7ng=
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

Refer to commit 8a3ef4b89e6d ("net/txgbe: fix Rx buffer size in
config register").

When round up buffer size to 1K, to configure the register, hardware
will receive packets exceeding the buffer size in LRO mode. It will
cause a segment fault in the receive function.

Fixes: 92144bb36c6f ("net/txgbe: support VF Rx/Tx")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index d77db1efa2..a3472bcf34 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -5256,7 +5256,7 @@ txgbevf_dev_rx_init(struct rte_eth_dev *dev)
 		 */
 		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
 			RTE_PKTMBUF_HEADROOM);
-		buf_size = ROUND_UP(buf_size, 1 << 10);
+		buf_size = ROUND_DOWN(buf_size, 1 << 10);
 		srrctl |= TXGBE_RXCFG_PKTLEN(buf_size);
 
 		/*
-- 
2.48.1

