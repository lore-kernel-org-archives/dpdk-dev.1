Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A65FFAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBE8240684;
	Thu, 23 Apr 2026 05:41:08 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0518B402E0;
 Thu, 23 Apr 2026 05:41:05 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915663t319c4a77
X-QQ-Originating-IP: c3wiXj6lIko4/P6oBYL00g0+XlNbgMzoVwxwk+bi0UU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15902235284246121214
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 06/18] net/txgbe: fix link status check condition
Date: Thu, 23 Apr 2026 11:40:11 +0800
Message-Id: <20260423034024.14404-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NY3HYYTs4gYS35NXC4s82o5awrQ6e3Fq2aQnXAPWR900dx0Kr6hFdQXB
 1zkt7Gzb3fr1FnjFg9mcCISvsD3MsovoR0BPmn8ukE++UGOR56iHR3UV9KqeZoctXJ1pHy7
 6jlOf6+IgGV3c8bcNo5IUD4O/I2Agi6iUPu3KblRVmU5fO8k5yexMH0MGMzzS+KKB14OJpR
 +IlADU84BaVrYrrO2vfvIqsQDvVUGuYHslbqpW4BrbbF2AiXBsEWz7Gf5m0rrUMErmHcyQ+
 YvlRlHzPi4Pra5ZO40qZveQsVR3ZAR75jeY2ZUMxHTXQzp+WFtpui+YbjJAwaf2L9i9jcld
 2IUWQmrb1x56o5zpRk1GzlIhMA7OYSJNeSzg9Z2wg3eL29+KRrnIgSCT5meRCSr6iNemfxB
 4hiA05OCM87QQlF7vnAkpkS3tJlTfAgEzEGKICnD3GGnXpoqKtzyoCJnzneF2BnbyU6b3E6
 8GhNwNSAut4brZbfbAg/f9gNCpFfsIAXOz2PumhqLnNrHt8WzUdqk+Q4V0tV0wBzLRDJqVj
 p9dmKdiCtgK8zeRSjq/63Ge5xoSXHEOIoUWAaXYsaxEQSE0Zx8lUWxNzPalKJbFfwaUalCI
 ylMT89veqHZTJK7WWMUFFvF8NwOgPjlCFvaKDGtH2dBI7ga6RxzVGCV6L/rSHBHfigHqp68
 9DW/bUgygIsqFX5F7Loiott2uH4Itl+1dqgCV4Cel7rl1lN/gFWVAzahRsPJixUBl4qauFK
 RDYmOuv1F20CkdFze674Xl2sjiFgiQN8BrYGm2WdZb7L2Gq6g+VQnBmjIC6Q9FKm+lqXVGl
 Qo2o7kB6/HPDEZ5kV+nlxMBvxf3vRoXb4hVMUd9Ce79KVHU6GtxFTHCqitWMh3LDRZ1k7Mt
 Qb9+IUnt6tnqpT4NH6YprF0LiOwz+N02BMKW3LqwtlQGvdRjK3rthKgPunsQc1Qpt0lcx+k
 niVHpN/PKT/iRWkovTvlJwc+kvsIIBz3DIy9XxP+9zUVcFxLUXx2PCYTQHT/uVrieGTQquz
 xGt0v5S9w7D0oYdhC8lfW8gPPn//7b5rJYpWOpwTcdi2/W8xI4PXZQhylAZb5goUQnycBB9
 g==
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

The original code incorrectly used 'if (link_up)' instead of
'if (*link_up)', causing the condition to always evaluate to true
because the pointer itself is non-NULL. This led to incorrect speed
assignment.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 2 +-
 drivers/net/txgbe/base/txgbe_aml40.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index b376eca5b5..de9a1b1c93 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -67,7 +67,7 @@ s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
-	if (link_up) {
+	if (*link_up) {
 		switch (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_MASK) {
 		case TXGBE_CFG_PORT_ST_AML_LINK_25G:
 			*speed = TXGBE_LINK_SPEED_25GB_FULL;
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 733bbac13a..eefd7119fd 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -68,7 +68,7 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
-	if (link_up) {
+	if (*link_up) {
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
-- 
2.21.0.windows.1

