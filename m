Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B2CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A303F40EE7;
	Wed, 17 Jun 2026 05:35:16 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 6AC8B40F35;
 Wed, 17 Jun 2026 05:35:12 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667310t3476c7a9
X-QQ-Originating-IP: ztmnULVUVIA8Q0t7pUKMwd5aHYFqjI/UGU86wnNFcvM=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:35:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9643629817313180330
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 20/21] net/txgbe: fix to enable Tx desc check
Date: Wed, 17 Jun 2026 11:33:58 +0800
Message-Id: <20260617033400.376-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N9raz/IvcDljnfQ4YfLcAifHfNMVB/RtOX8G2HGzxWyR4OCbpNy5rpcZ
 yqUz+dqUwCI+gZajyRZ6Bmo/sbBomFOB9Xkmtve9Ki+HdaodFahbzgh6WgofPSymy5obJZR
 +psHx7M/JQ2bSFnwKTFpt3OnffXVvBEBw24bVi+dRgVHIvx79eiyzauyPiLYabmqd3CEKgA
 guYGr2x08Zra2CHTuYVow/742FUpnfR+znnnKZ3s5iTSZ8zsPpljSy8q82zMHNh1ywIeX+u
 lgvsXq+B2AWmtfX5WGKPxY7omAs3zVbL2JDg7x2Y0Mq32BeXgTrzQ685g22f3PASOm3LF7R
 ubN0sAIQAnfA6eE0p7SC7mLhWWDfgv8l0wZWzGUB4lfjyV/1BdKQw62StSiUZJwwh3qOLrE
 387W0e8+1P10wZS8lxKibKck73RidTWV9ghGj0B59SIx9bX9bj17Eq7snXBv5DCQ58JQA/Q
 MPp5qdzMdqCUfV06BkqODI55woObga/OfYVtr3v9N+OKNAthEuwzjz3Xt5SuPka8VtjvGi9
 se5vMj1J7QpQUl7XsCM2yv6xRTDT78Q+Z5JdrT4IJCNuV6Qqf+eiQbE6vttJE5EpbVVIXaW
 ZK9SIXIVstN0G5OP0I/TDd6vLeuYZ4SfbfBkRQvFzOg7uPB15TFEgm6c/yKhbAaQ4x1ejij
 5mXKmVbvwywFwaF3mAA2kocIsucaAXY64OfFLW/aAybtj2/2l9cKkAhwe1IYV3VV3AoHuVM
 GNdsllIHdmpHYPjs9pjKWbynWlPceP4TffQjC0xF+Azs/0blsC2qclyEQpCTZ9k94JNjYYl
 IVeZbcoW5ilPPPD0U4nNFDHd5sW7wmBaq3enQYyT6pwtHmOHt5iX27IFLroYXKX7krR8jeS
 JmCbDrsITwP+vXBdWMghC+0TionTNGx4oaTqZaQd5JMQOBRDTCoRHvWGG4T1aLtjMRFPT/m
 SCHiM7/KwdaXoX/2IzhImYTj05iEGmlhucLWRRwILUPI+s52Rz+D9t/s7o860kVkpYwHRv7
 PzKiH6ekp7eiB4qR4csvGLVgkGWUCgdAsZ8NZSR2EI7hLZ++etdcrbboOcsewNTdp6vwjSz
 bXBG2XzfYet8aHY4Utua4s=
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
index ed34b3a38c..8b277d3062 100644
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

