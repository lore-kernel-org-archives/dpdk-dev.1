Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E89CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AC2D41141;
	Tue, 16 Jun 2026 14:21:54 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 4309C410EE;
 Tue, 16 Jun 2026 14:21:50 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612507teb71d6be
X-QQ-Originating-IP: CaDGyKuKBR/L3aXmHJ4dMqEA7pZ7nHHPMho+De6WSKs=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13055263882040877462
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 20/21] net/txgbe: fix to enable Tx desc check
Date: Tue, 16 Jun 2026 20:20:28 +0800
Message-Id: <20260616122030.9688-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N9DIJtFs/avnfWZzC2Zk+y2PWTfH4ZYrvCTUYdF/kXwaPdQse3BIeq8K
 Xs8aUuuq99ksMrnQM9mQJE4wTpenYyRz7omvpe0htL+ARFn5EyBshaepmK8yIziht9lYhrP
 ZBpSesXChP4CSiwx+8x5JRl31hh/YT8+kzT3mq4oIfroan/+d5zjDWAbvkNuj6PAEp5oOfq
 I/J9iyQpNvfz/rZs6x2jgBB1xajn1mAfw9FxbgWKIS2xS4R/Z1fZ9hF7ZJX8L+HH6jRihkm
 BYxseR5F9TMgIVMriFGf/CnMeriiE+9fKnkEH+3hIAFouxQwjuVvoy3cAZETt5lGteOP2A1
 /tPTuT6RqOHRbEKEUVngueFCpzSHiuNYloHH9j824lThUHGnrb0/9WgTQVk2qYh+alXgSuD
 8MUvqNCQv3rQLyCaaFFe2xePQLPolodiC6Cc1ACiyIamU5PL7sOv2EQtwkLPKJYpLwZnqY8
 xTgVCLl29WUoyt68Sath353/7kMY/cZl68huWQC1LrcGQcrYrWulPRNDxvPYUGbE7pt+kGb
 ze8fTgLRYilrN8Ek0js46aFAzXHappYzh6L1a+WvjmY11fOHNk7ZLcO6wmhvKdCK0HNRN9x
 9owKdIoJPVDspHAO9Jl5ok3ihlpsNfjoYCEW/XtjOUFEdWVThKQo7oaMhSW6tIzvDsY+xLU
 FZVgq3d7ao4RjcJXumtg25BMo+I/1o46Vwpxe3vcxqtITQZLcwFj20j+wmsMNoKIkUJf3l5
 X7/kZyzoY8H5v1+GfzoLMq7VyX8Df4sE9kNO7XEGBXCx6p4F8XrVM4fn/d78cMZDaFAHIRr
 v27zLC8rPRJ5aDt4WNxVFFOqDvomFywOOli1epP28O3wUpDnuUq9H8gDJqsEqcCP+rDv00v
 T1UNGambcJMg0h5mGnY6tAru9/0p+JoUKV5TLhDGr0azCCFl5BDWQZO4duJMbaAHrufrEGl
 /BVcRc9YdPVUhqzavuJdiIjbdmRc0ZdLUpzpqwgDUnwQTAd9QEUAHdMFG/hmCJHQsGDWt4F
 QyAZDseSYEXoo8S5ZcpGV64lxdBw55l37BCg+TFeh4NIDUsiqNZIVmALtQcUx9IVG0Lp7vS
 /yVy39waj1X2frjDSPv4No=
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

