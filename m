Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C4CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE8040691;
	Mon,  6 Jul 2026 12:47:39 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7715D409FA;
 Mon,  6 Jul 2026 12:47:34 +0200 (CEST)
X-QQ-mid: esmtpgz13t1783334850t7a8cfc64
X-QQ-Originating-IP: JMDPAx0fISY6ElcgdKpSLx6wJW8UwM2++I286rkWlXQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [125.121.223.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 06 Jul 2026 18:47:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8538816478869140329
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 1/2] net/txgbe: fix null pointer check order
Date: Mon,  6 Jul 2026 18:47:18 +0800
Message-Id: <20260706104723.25968-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
References: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MSPab3JKqisN7xZggOtKHQSouI3GbYuOgDuuA/8/cLeH0+wAkcwglZfg
 KxgHIzRlXWaClw0w+GFN+mAs8lEG5AshTftGXKGAu+xtraC09BzxQZ4w8TAP3SZO5Kf6Q0a
 +7F4GToZQ3sG4EsTXfQDAizFwPq0Xesv7464qnGUTa9L2hJ0oYxwyOpooMLwcvIrXRSBW65
 dksayQy6WW9EMqHrUsaaJCiiRM7qc5byJFLqyC5J9KXQU6w25TqHR5LQWYMGHTvDRmOjGgG
 O9ODGihzG62vYYiyfTAudP33V8UPCHmEoWcHWQxOrqsnHhOTDG4RcpkkHnsgTXSh89hBiMa
 4i9LsLu/JrHBnx+1gKD0q1++oeVn4/BUUjLuWv9631MUZLv9cBEBUo+RMbnboCjUf6OQp3j
 aQ6be7l8u7tqKM6eK4MdW5MDls7WX1pT72e0ZwkcVQAigo/6Du/JprtVBUag4x6N4f8jE3O
 OR8SH3yJnAdONUkxvkpfk4IbeJKubeBMbzIOxxFiPRkL+HzAss2SUuHmTWZ2K/SqwfMWNJC
 ZEGFwoPj+uAEeb/Snbica9GoG480jU2CVStwtOWriroqxUtNOAf5PhP1qdDk/Txfpc1O6VS
 wsisqi6LR1RjULxUbqpKUDo7Zgg8SWCneGbZrNZfg3fvl4TtPd26gTZeCQ9BOKn/MpGW5pw
 ElHh0rEHnaeU466vadxdvm0XjTXq3ig+OLT4/5KJpaqv/jpq9gYJaiRj2hg/6mFpYGuFXCX
 eTjaMz2kho0u51gI4Hp4zrxcjVF21cBSSi1y5IfofDdtHomlSRgTagPl+fSUwHvsKuLppZp
 hyDjVMUI/9O4FPuAanhTHBqgC7Oi8XWOWzE4EyI7hGNVlwTQPJkK/uMgfT5W7hG3cGa8K3O
 PmwkckO8PvPjXvz0lpleo14AHIxGqcXwDc8RTw/jSDyg+ukjG9NG/TE5jtar6cT/ibSR4Ko
 oLHedLhrZfN7t6Eg6rUxic3R0Wwk6yQZJtR2PSV/lVUdsFZizCmMrMmLtcNwQz1R1ApCDkK
 DYQqFCY2sQoYKJllJNede/gByzjrwT4e+5I1XaWtFB/1/qYLg6tbTKgq5VELjDCCKxXcXoF
 4VLVPpJTYkj+del5ukMrDsgVA4w590OUw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Move the null pointer check for 'hw' to the beginning of
txgbe_dev_setup_link_alarm_handler_aml() before any dereference
operation.

Currently, 'hw' is dereferenced via hw->dev_back before the
if (!hw) check. This is a reverse NULL check (REVERSE_INULL)
that renders the null pointer validation ineffective and
introduces undefined behavior.

This check serves as a defensive measure against two scenarios:
1. The function is called with a NULL parameter.
2. During application exit, rte_eth_dev_release_port() frees
   the port private data (dev_private) while an alarm callback
   is still pending or being executed. In such cases, checking
   'hw' early helps prevent access to already freed memory.

Coverity issue: 504601
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9a1cb448ad..4d2746371b 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3264,15 +3264,16 @@ void
 txgbe_dev_setup_link_alarm_handler_aml(void *param)
 {
 	struct txgbe_hw *hw = (struct txgbe_hw *)param;
+
+	if (!hw)
+		return;
+
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)hw->dev_back;
 	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
 	u32 speed;
 	bool autoneg = false;
 	u32 gssr = hw->phy.phy_semaphore_mask;
 
-	if (!hw)
-		return;
-
 	speed = hw->phy.autoneg_advertised;
 	if (!speed)
 		hw->mac.get_link_capabilities(hw, &speed, &autoneg);
-- 
2.21.0.windows.1

