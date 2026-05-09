Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B3CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425E540A73;
	Sat,  9 May 2026 13:29:45 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id BE3CB40662;
 Sat,  9 May 2026 13:29:42 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326179t7ec151b5
X-QQ-Originating-IP: tJF1DcYOpT3D39iObPBCzYmFRZIDCqZe5N952YGKlxE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15721888936788250486
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 20/20] net/txgbe: fix to enable Tx desc check
Date: Sat,  9 May 2026 19:28:22 +0800
Message-Id: <20260509112823.7728-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NSahpW5IwUZOkEGJIOCbcqI2pZ2HDjcSw5O+cMFIqK7ZUVYGMxU75YI2
 L/J5JnkMaTpO4l474tf0SIjppG7Shmt+6Xjv8WxCO5AaAPkAsB+b5I+BSi62hCo1ZNnhPif
 sEuPdqCR0+oSZBz8NNADot0/2mMDf6hvm2yON6GC/jgqYnUJtd0ZYPGscatXwi0cQV5GodW
 Roi6e+E95fy4r+6CkP4Q5WvUG82AuuICC5OqoegESIrJKSRjRgiUeRHnvuLHkcUXRZWf+ov
 8Ybyr+RZ3ol/lZKxkdAl2TEaEGoPw7Bl2vWpCv3y8/VTmntp7XmGTlll5Oopds2PY5auAPC
 wqeOIQUduCPOYV3HpqOae83EL6PV6667qXFNq9fCZGjHsA91ZiRWqJWnrEBR8hHfLHKocAp
 Hzedg/YMmiPB0+bKm8lWMcF+CPBxiiV5FJSimA5pnutJHtc56SLJmp2ZdMabWOEt7J/IBL1
 6Hk1K4NZJzK3gAy4kPGqbmrEuwtFkmPEJ69cthk5GsAE7W3Hdq5mWr8awr/SW5RQqUq7opg
 hKo7fSYcz4LwaAiN1avFeOb8064yehOHKlQo/zrD5E4fAEt4MHHFg+MrN6gtpWdum8agg7o
 NQ3ZrrMZGXTokhPwwvE/WVT3e+Vt42eCMqF/azz0KEgme8J3KrH0iczGGDNUBoKDeUnVj+g
 afX7mgkihrl/483+bu3Y9anUdh3vEFgJggUQB/J56cmjuijuVxeTy9FIK74j4ur22LZj4Sv
 9WH1JK9qHi99jY6eZwuIR46GpsYzq7pIaw+9xNaVxLalfO2D/i5IRb5/ppDJFKlR3zKHIsd
 1yyQXDRS12VTRUJTluGKbhSIHdv5wDW88uQIyaySyqiXIddT3MEXzXM0UX1Bzu4n2h2ht+M
 KGXFS3oSgbqJ5zPAW6GU6zDRtA4tGdNlts2SOkVOZGugj9TjWC0ZpJDLq+xDAXPJZ42R0pX
 NXqQuOTpdCCXUxFC7GtbG2UBetdIxUMPbsRlF1nbEgAOICFrcfBu1wnj/0pryyTJBYjqVGA
 qH5TG4ycJ+ov9r644aPIA/rUaYhd3xl4PgXkUWUf+3DxRF8Qhh0SrO1UBVKpEG5oBljMomJ
 wzD1zR3G08E
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
index ef53a868a6..8b3d5eec14 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4768,6 +4768,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
+#ifdef RTE_LIBRTE_SECURITY
+		if (!(txq->using_ipsec))
+#endif
+			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
+			      BIT(txq->reg_idx % 32), BIT(txq->reg_idx % 32));
+
 		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
@@ -4785,11 +4791,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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

