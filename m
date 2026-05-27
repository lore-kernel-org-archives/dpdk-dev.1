Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60453CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5053B40697;
	Wed, 27 May 2026 15:04:16 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 308734067C;
 Wed, 27 May 2026 15:04:10 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887048t47550aef
X-QQ-Originating-IP: 01cEPNcGNVP1wF1Lhf2vCvZDZ1pz/BItmLPChsGkQDI=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:04:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3458853357583196030
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 20/21] net/txgbe: fix to enable Tx desc check
Date: Wed, 27 May 2026 21:02:20 +0800
Message-Id: <20260527130222.24348-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MkbhhZQIFFmGs57IkQm0Wisn7btc91mLKHdBHpfAA2V0UfIr5xHvQybl
 R/Dhxh7eWncCu6p+Ixo9pWVeOVRWM5egVoN1lOgIDDAmpwg+CbVuPqZgnqD0U5Th184mbtq
 wjtplhhCrlEUL2W0yFJfi4R6Vd7caxxH1QAngp5rDY8TcfrfwW6aU8f9IbVewC+SetLMOgg
 tywMb5vcmoa2ssA3qWQRX+KXxxekP13a1q/PGXC9j7e56TQqDCKaiUD4pws76CRz2/ra+DF
 t1NN0EINCgWHhG3JCmUpCReVdnGDGbTCND4fgKLyxNTomL7Tr7e7JLBxUY2h4X7NZ8L1PGo
 ze/WbFzMFrd80L1Vjle76q2CgC85rVYpMtdRlp3yrCgwzstGBIefzFlRVbYMC9/Dg9Rcr7l
 juZY+235r7dVc2zAXUudhqVM6hk0li/wr/iebzUKDEPYj72sRtaDiAMxpXpuN2dMj9iby0w
 NR69BL7Ir476RRTX2dntzJpt7kHW9BlbEMcjrCPL/0VPWKSdNYFSrpcpXaeSeSIgY5Jy3z7
 1nf45zW1brCC1teCtVtpM6bmDEBfIr0JGfxIlCUAKQjad2VWml0jr7DqbqQu5Sw5UEOyvGK
 /Em4C+2MdJLRD6XmjWyJcA/Zwq0bPHEhNnN2X03jM2Ts68eNlWjRdAfFZJSRxIHZXSWThKn
 fAkLVMwyKA/R5HiQmjXMeAhIIk4lFNMZzsFkW6vMVNX4jIJZHPXl+20wJ7Q03Z6OdrdLXzs
 aGW4QzTbS1oRDr2j9WO+8uQEBvoxk59h7N5GAhctmHXwyAEc07Fml38yKvHvXpB9Ag7fWLH
 BJ0CW3w9Hugl8HVndckvse8uAHzr+CYU5CPvYnMxtlW7c32+L14pyFum/pzaJxnLDCiwp9B
 4yFaRXZgpqATmjy+vFwL4cKYJ4vVhKSHmjdyBPjWRGCmeqkHxeBSHdXQsb87DpeVHnhaQfN
 lxRQzSK8Uhvo7jijOYKX8vIMnzLJCo4hdnGl+W/r7c7QJ3KH4wWSMmZhCly7od4IVnnoCtM
 StMithur/PfX11/ORmaIVw85aPp7R26pVujYQY9H9JxjWuNZTlCNtIRFC7DfNUXH9h7/vSl
 uXLDl7hk5M0K8lnX7Ux1SQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index d27f2915f8..9c3b403ba5 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4759,6 +4759,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
+#ifdef RTE_LIBRTE_SECURITY
+		if (!txq->using_ipsec)
+#endif
+			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
+			      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % 32));
+
 		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
@@ -4776,11 +4782,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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

