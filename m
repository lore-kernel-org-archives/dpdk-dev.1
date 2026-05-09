Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731A7CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50E9540674;
	Sat,  9 May 2026 13:29:08 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id BA83F40655;
 Sat,  9 May 2026 13:29:05 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326143t128a439c
X-QQ-Originating-IP: LZPV67hN8W0X3kfUF1U7lEiINBogrTw6PpG5vmsMbb8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2045400647185219102
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 06/20] net/txgbe: fix link status check condition
Date: Sat,  9 May 2026 19:28:08 +0800
Message-Id: <20260509112823.7728-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKKHiI6c9SH3xDGZ8iAfY6E6MNvXkVavYUY3c+xjaETjc7ip5bg2gm7k
 cFmFpOh7PSlbxg1eEdCuGW7jNn/6ht+q8lMzfkqgNtdbVLiRza83KVToPe+5E59hFS60K5a
 bggmAPbuiRTqGfrAPN2KeVNVbNfLa5pq4ielokLK348PKNVTABIGZugzBhWPUh0mG1Kqe+S
 EHnUaZuEv5ESCYtmqTV2CuxczUU5lfKXgd1nEt+dVBbb+Xu3vcr/Mn8dRs9gab9H+PHeq7i
 Oy5m1yVyMnEntaYOZHCUtNy2B3guXDvkagT4hOdI1p4Zu0jtlzB1nA2quQANnQW5O/O9n8h
 V/O+APtZb4W1H++WIm7VcAsI7cOJ1ahV/ifJFcHvxwGJoCC4Fr3hjaaWi8kjy9NzdhRHte/
 c7qMHVEMhhdJ41xUAxZb+mqJl95lMiiR9saghIpUbLR2etq6kGbIiwIWjBi5u66WxIpiJVZ
 eMbU3NtksKO8xFmZsGUDe/b8+BVul7nHTZD4LLKzRDD3lfXG8UQdpXBX+0njr3mnQeupxcG
 Y5bsN16E65ue4YpF3OQUKEubzb3CkTPV1UYudbSaGbV5pE8ojZidbgMgRpYuOEEGTImxbfz
 T0+3oTaGM0tlC18zRYD9yB6sD1+70Ms/mJJjzEHY6hbtGf3c3f+VLhy7209zcHW9GbOgcy2
 TUyuCdRITZ7XzJaHLtSoow+Ye4ozo4Tx1Fx5vIT1+T8xPtYARVEwQzMnFgXdTIFNoa1ItaL
 lnp/fDtJemuzmYYrOU63+ma+P7Xr/8luPlJn8yMwlftw8uiQRC6q4O47Hfeaxk1EuIr5geI
 BT2L3zgMrP0Jsqcfwpo68sGzsExkO5LTjszYgHIwFsL2akKRJArC+0P6GcG2cd9uZ2KcH5+
 /SHxDM5fSrbBFCOoCe65b/euWjPqcNf+ZBAX1QZf71oEAPajgA+L+B3xr70lA8oL8vREuWF
 5eeC+MObaCilz7ycRJ2+VRb0fUkUZGFY2TNdJ/YsubP7t6eTQpueIpJrmzZZA0O7tOe6qFN
 tXH2ofkBwUaU0H1eu/Z9gGwI8O6f3QBuc66tRxm3+Jx/iwE7scJOxa0ldbdKt3FUqo3hYSJ
 oPNx/D1Enyb
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

