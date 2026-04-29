Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7CFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11AF040E17;
	Wed, 29 Apr 2026 12:27:09 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 54EBC40BA3;
 Wed, 29 Apr 2026 12:27:04 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458421tc07612b0
X-QQ-Originating-IP: VR5eBDO/KkX3DEjBLnoSlZGmhHN2mKojOjcQIvKwNBE=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3355685452230363621
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 20/20] net/txgbe: fix to enable Tx desc check
Date: Wed, 29 Apr 2026 18:25:14 +0800
Message-Id: <20260429102515.58880-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NwU6Bou9okj/icFFaS8mLcMfWmD0JY8DsMSRg7+UV1dSN8WDBnw7118A
 ycIoUKULVcVouYCdPFyKYwjtBuOp4Z8LrgpcfzIlk39AMhAH+23eCkiP7lmvQkbqa30SRp6
 qqRzgMU7cwvcIYJyTKJtE88QtpDAdQn6QtKN6rV9qsZTi01AWPhJZs7MyAmK0b3RerI229F
 Zxv3haTjoWsFolVJyWB6AcgEZfmkd7yqUcpWchGrZk4eq9jXDy2HsS/Dyfi9Y27bxEKyfqK
 Ht8IQf1CvFHW7VYc58MrHjfk2sxzF911N95WJYQom9Bnwt9iPDzFP6o1L6VByLvCWatJ7lb
 6mdpznlYrrhirEXbgS7o1H74dwZ0Ijrm8/fLVnTnSUlpL3fun6/QxiIDiQRdJpTuELm5206
 f/RErK3Jq0WzxvuwGW2O6HI/uz9H0WAFjZkrA2sRO9LzTmSVEg0CodJCneDUxPpLD5+tplj
 9lUyGyIb5XDiQ+VsZCstS3wixCcXz7bXb8tfeEJ5OE7FvOjBh7ClkFkZ0eqqyF9P7uafwWh
 ch/qq1USeSzCELABX7XhACbFt1RTJmInwsllwSjagIC7pdvAC+QPAUiN297Hx1/tTMKPD5b
 4huIaMQgPuFnXDnyzn+mwXIC6yUUGlojTRmGp6uu+QrDpVf82Oj6mLUu4RaEeltUoC21byX
 vJLpjvbbhH58Y4xeedlhF/iERD6LuBi6z+V+xhnLUa9amAO+VnHgCX6NXHUKWSkguYSXn+I
 hE6c3rI6IaKQPI0+r9+jw3fpUINOK0IkUmspESg1HWfj1rlSdP52qKUIRX+Fmx00f1Ch5aB
 yCsBEac/uNiQozBtisGYFzCV73Lwh2wzwzFoLHZsBgMVa05EWTeTUOFsi3BF9DQaW8Dr1UN
 Gb6Bg7TEWmLAMwyBvSYD4/BqkgdlJYBWjPf86EoNGMFiuP1k07y2NaToEAn7QEgX93zq8Rx
 amDJVQnHASBvPNOH5bbDTP1rCfg4o/9GG1fb5ywCRZJze9KcNbWahcGvIwiB8+OlCJhIsbG
 Wa5lHvfYxnb4XlNONQTizty4uMN0E7XpWxO6Nbds7cMxXTUOlue35SWOSzsU71CVha7YiIr
 9Ixc6TMIbHu
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index 956d1cbad8..2403aff920 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4771,6 +4771,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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
 
@@ -4788,11 +4794,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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

