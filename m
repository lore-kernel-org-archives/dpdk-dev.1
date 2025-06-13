Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A29C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72B0A42EC5;
	Fri, 13 Jun 2025 10:42:31 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id C70BF42EC1;
 Fri, 13 Jun 2025 10:42:27 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804145t7c3c506a
X-QQ-Originating-IP: FijplzoiumGO+AqdCERBEtzuaLYLQNBdEjmoGine8hA=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16471880715651769317
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 06/17] net/txgbe: fix FDIR perfect mode for IPv6 packets
Date: Fri, 13 Jun 2025 16:41:48 +0800
Message-Id: <20250613084159.22184-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N/18iCB8Aki/+MIuyJCcStXoXkGbJCFUlN5Oih5qVQo3Rlx2/Ct4zNn3
 h9XDZgTgqnTHvWD4fGszM4hWRBAnaeOX5cilS0RzzvoUwvzSl6eWPkhRmt0bomPC5sTmITP
 EH6yB2otgrehDVW+cmbFN0+Ao/w4VP772o6avPtDATUL3ambzLjnXpaNCwqHOtSwP5qldl5
 yXJid6rKJ/q8D1gDY0e1tZCs4F03ztS4sv1J6mdMJN+Oj6uOmwHBx7TwmwZzB9G/Z2x0rBq
 4QyirHGCkDj0+RIWkjKHsys1xhjR46fbNLwm7MjFf+EXM7thx89lcAlB81WOebWwqtwbKZb
 A5wS07ngW1szt+HwePQG/X2/rsqVestgrhMKAIgjnGWq3VgoU+dB5woQkT3Myszgoz4ZIKt
 JgdT0eKmYgPLDtGlDbzDD5V5ndQSRNC74h1nvaksIFvTm9gbuh69w0kqj4+OH4GYIUbzF/e
 SrfMc1KUaMEJ6eIuKfjLPMxdCeiDSlO2V/Z1Du4y9ePTgd7hNgt/lhonZIIbEQQ+rF+qK/6
 /6hrXl46bhWIpd1MvgTbHrkgpcnj5XsFy9rAdhd4k66aZrLUJM7ScVbqNb8VyT4z3YLMV1j
 h9DjAdq+SeYVQvlFlOPvho27gx8xOFENRpsKvpBUNFLO43Ay3IysaAQWpFnplIzRICbNnZa
 65IVAUMNVuEPOFmBQBO6o60XUQOz4AWpZk4Lb5drQmTmam8TgC1q4FLomY3EUYwEi32tRZd
 luQnbYI9KadDKFsOvSw8hlIPoYWrqnN/rANQJI1d035xbgO45uqNdeimzFGFu2NnQRamtZm
 N+gwQ8qrzYrcTXHpFgk/vpM7V0yVt+kuZzLrh54FQVITZmialWrDollcgqgQg4OCvo/y/Ou
 f+ydZ7Y810/D+QmJbsnpPxtbR8u63ntwwJzTGANAhlfqL3G95zIAlr0x7ACUSqzd5rz6vjI
 753zFoU/j87qLFuxvR9p900wwyjBstxKiH8s5Q/3ixxtMu9kGILDJxn+IhM+ybqZHsXV/do
 y1Cyksgx8yxkPtGqq+ejfTWAHNioz+UE51wT+pAg2Anqmmml4V
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

Perfect mode of FDIR rules to filter IPv6 packets is supported by
hardware. Remove the restriction and fix the setting.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_fdir.c | 22 ++++++++--------------
 drivers/net/txgbe/txgbe_flow.c |  7 +------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 0d12fb9a11..0efd43b59a 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -210,15 +210,12 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
 	wr32(hw, TXGBE_FDIRSIP4MSK, ~info->mask.src_ipv4_mask);
 	wr32(hw, TXGBE_FDIRDIP4MSK, ~info->mask.dst_ipv4_mask);
 
-	if (mode == RTE_FDIR_MODE_SIGNATURE) {
-		/*
-		 * Store source and destination IPv6 masks (bit reversed)
-		 */
-		fdiripv6m = TXGBE_FDIRIP6MSK_DST(info->mask.dst_ipv6_mask) |
-			    TXGBE_FDIRIP6MSK_SRC(info->mask.src_ipv6_mask);
-
-		wr32(hw, TXGBE_FDIRIP6MSK, ~fdiripv6m);
-	}
+	/*
+	 * Store source and destination IPv6 masks (bit reversed)
+	 */
+	fdiripv6m = TXGBE_FDIRIP6MSK_DST(info->mask.dst_ipv6_mask) |
+		    TXGBE_FDIRIP6MSK_SRC(info->mask.src_ipv6_mask);
+	wr32(hw, TXGBE_FDIRIP6MSK, ~fdiripv6m);
 
 	return 0;
 }
@@ -642,6 +639,8 @@ fdir_write_perfect_filter(struct txgbe_hw *hw,
 	fdircmd |= TXGBE_FDIRPICMD_QP(queue);
 	fdircmd |= TXGBE_FDIRPICMD_POOL(input->vm_pool);
 
+	if (input->flow_type & TXGBE_ATR_L3TYPE_IPV6)
+		fdircmd |= TXGBE_FDIRPICMD_IP6;
 	wr32(hw, TXGBE_FDIRPICMD, fdircmd);
 
 	PMD_DRV_LOG(DEBUG, "Rx Queue=%x hash=%x", queue, fdirhash);
@@ -810,11 +809,6 @@ txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 		is_perfect = TRUE;
 
 	if (is_perfect) {
-		if (rule->input.flow_type & TXGBE_ATR_L3TYPE_IPV6) {
-			PMD_DRV_LOG(ERR, "IPv6 is not supported in"
-				    " perfect mode!");
-			return -ENOTSUP;
-		}
 		fdirhash = atr_compute_perfect_hash(&rule->input,
 				TXGBE_DEV_FDIR_CONF(dev)->pballoc);
 		fdirhash |= TXGBE_FDIRPIHASH_IDX(rule->soft_id);
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index c7cbf96a46..145ee8a452 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -1812,12 +1812,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		rule->input.flow_type = TXGBE_ATR_FLOW_TYPE_IPV6;
 		rule->mask.pkt_type_mask &= ~TXGBE_ATR_TYPE_MASK_L3P;
 
-		/**
-		 * 1. must signature match
-		 * 2. not support last
-		 */
-		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
-		    item->last) {
+		if (item->last) {
 			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-- 
2.48.1

