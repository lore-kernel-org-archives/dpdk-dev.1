Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5024CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8194C40651;
	Mon, 22 Jun 2026 13:13:06 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 466634064A;
 Mon, 22 Jun 2026 13:13:05 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126781t57f68939
X-QQ-Originating-IP: FuCI0xolCdf3+KsnpIRnoPiUpr3nEduD376uouD0PtA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:12:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14889442145986611367
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 20/21] net/txgbe: fix to enable Tx desc check
Date: Mon, 22 Jun 2026 19:11:08 +0800
Message-Id: <20260622111111.21024-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRYSeI3Ux+UP9K3VYLqtByBVYA6XcPDWhskfnPMuCKFJrB8sOhvEVu25
 +9sO0IOKrTqB/yNHHp6LgRUx8xgX7w1nra9VAeV8NczEkj3lJl0U/TM+44jXpzNQhVGtjza
 KkAqx4viQJOh/K31Skvd1j58NhFAgOhrpmFqifXJ04EMcIsyr9aSgoSdNnXDrPz7CONnW+U
 PyZdQJ2Prcn8Igy6W5i4+xAW4RKwkcYUIfwT8EJgyDZgthwDxSpLhycl6Tqvf66lF9ZLOvd
 BFU2vNafDaY73StKkjBIZHxh0VmPKbZV9e6fIi+KKwDaUmACKb+4a5sIBzoHwCUQti8/mIl
 uaWq/uFGqo9hIO9Hc2EL7jN4pa3J5xsnhdCoGo5+hp3JC83BYU5spYJtc6zSa36xuyWx+Yd
 yeJWQZ3nG8uNyVhgw7QHIX7u4sFb+jYVcSvsETMWCR5/LKYhde4zMYdNzJUr04BDY3A4/Rz
 h7YLW8NQZr9FDa5zCEHDLe3kiYxM69LAuzp/+/Km1kP4iNLYpxfr8L6UBX4/tMMDLJ4O+1W
 xeIBVjLWUtD3nvbVeDRsyo84x6dMoZSDEpySHZl0CKS3tTCnf4ZtbYvoaf8CVBmbul4uIoC
 ovYyvPWZ/m1wxQrfpcCLI6c6Z9fAcvHW3ThiEK37LXvkxPozd1mg4XMkXeaRG1cDSv1zmD+
 K3vCZTjtOWNZ1RKCTEcT0Sr9dPLYTDU3pXWIC8bYiVo5E4d3AEhEq6EP3SygiuwFHWKrJjb
 aylwkwyhSEH2D17vMXn2i7Z8r2wgrJ70q5MronTEI4MiBrNh7NmJizZar1b8qCWZoFf/RA9
 HzvzQyPGFQHoqF64XLLHdxqp2FsivWHedDVof8wwrctkPMzvw5ESknMW6i7kQKL2OtAFwCi
 QWk0gE7ITY9P+1J7ZxE/W/fhieAYpfPsRIiYSFRnRUni4v06ZCxpxJkLN48pEnw5LRaOja4
 GLnvAyd4udnQ6lU7M1wsMW87wF3ely8wLca+yeVHbllXpEscloM8LHvVn7T4zTzDpftKnyY
 gwh0iLlG7M1j3oTADYrZi7/vkGfs56ekGHanjpaLHOxU3QytutYbd5Agsk/toHDiXaBgoHU
 YcQRqv+S8TdksePXtvvgA7Ort7seQXHYg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Now lib security is enabled by default, and cannot be disabled if the
driver is intended to be used. So Tdm_desc_chk is always unable to enable.
Remove this restriction, and just enable the corresponding queue check.

Fixes: 0eabdfcd4af4 ("net/txgbe: enable Tx descriptor error interrupt")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 0a9fc3ddfd..f51c6193a9 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4761,6 +4761,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
+#ifdef RTE_LIB_SECURITY
+		if (!txq->using_ipsec)
+#endif
+			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
+			      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % 32));
+
 		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
@@ -4778,11 +4784,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		}
 	}
 
-#ifndef RTE_LIB_SECURITY
-	for (i = 0; i < 4; i++)
-		wr32(hw, TXGBE_TDM_DESC_CHK(i), 0xFFFFFFFF);
-#endif
-
 	/* Device configured with multiple TX queues. */
 	txgbe_dev_mq_tx_configure(dev);
 }
-- 
2.21.0.windows.1

