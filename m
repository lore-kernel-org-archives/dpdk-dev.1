Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA4AC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2507342F2F;
	Fri, 13 Jun 2025 10:42:45 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id B105642F2F;
 Fri, 13 Jun 2025 10:42:42 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804159t687531b3
X-QQ-Originating-IP: BSCE25S/a6USCNt3iq2mGoY3Nx6ZtnZS8F2Vcjin7xM=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15494878261525180617
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 13/17] net/txgbe: fix incorrect device statistics
Date: Fri, 13 Jun 2025 16:41:55 +0800
Message-Id: <20250613084159.22184-14-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MgjXJBbvxLhts+LpCuxrEsdLhVGMwqagCq0yNMDdAK8xQRIqM6wq74OF
 HDp8/INULuO5JiwiwVd5KyLdanEVZKxPvShtO/FfmWgLOLDKsDEtXlBeBYEF6JL3qZrvuVX
 pj1M/2NL/ahEpSlXojg8G5FPsbMEa273fsTgrlC5L+OdGmXwk8xvY1B8f2TkUCWbbqN72Tx
 vZcUObmljZ0MOPBE1/JZwnQ7KcORx3JMS2sYqTt7yADxzjskKIsqfpGpNnpmat58wYSi9f+
 Vp8vky74RP9xoQ2mIbX46+MieM7mME/iji96yLfVjyshS8w0g3d76+67D1L5YMub+H1HDcY
 /636K0H7f3L6lkkuMlglNtfDRZ6tz9K4poWu0rWXf+hzTJxmBCMbHfm4/baLVkvRP3M96Y0
 20YyesESan7p4iPr9ymWvaN+yJ/sg3A6My9G+ooKvO/nqULb6Vea4+lj0z1r12DyVxMvhcM
 xuB3HIi/c1LkMMf0NkFEX84KcPguJCZKH0GcHnkI9NGyMwJ+AFs5TSnO4p53T5A3xWD7Nxn
 qykFdDgVTsyx0urF8QXKyIU5DKjq0MEAMkcvpAI7o5bkdoTiyNnuSyY+MtMda4C0ODz1gI6
 RcnLr/rDwGU3gDVhOkoviADJ0Frnu+Hr1SChfsE9jnXFDouMK+ct42b80fL+wd46QNHYZdu
 I5VM1B86w24puMit/YC7KL+kPXwWk+UFcnHalQ0oFLq28Jg/qvuxdSXlst2NlF6G3LzbK5a
 qRo/yLufpncHFjd5yqem26bf4O2dqjf1D35FyeGblWtnAJPWnaiT8XkKRwb+V9T+xGtqye/
 1QVnTg0d8a0YEhhJ/IjJa2LnV1eGbpMvst612kIh6QVW3kZEEzjnRsvnd9cSD22sVSHgh9i
 EdJA7cIem1tmlXZEjw5bMJIvbrVrJB1sm96sWJSWeOyzbYUIkztVXr4ZKiN5b6wz1ZS4XQd
 7xKsarrLwUKNegdgZj4kBVPrTriyFZxmzR+4GxEIl0EXI9zW5YF28W9pdMAU6R6tLKQyAFl
 LeKol91C/sKmKZajqmJ4RLUQ27aLqOUm1N3IsC+RX0vtLKLCWJyB55i0mVYQQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

The extend statistic "rx_undersize_errors" is incorrectly read as the
counter of frames received with a length error, which names
"rx_length_error". And "rx_undersize_errors" is the counter of
shorter-than-64B frames received without any errors.

In addition, "tx_broadcast_packets" should use rd64() to get the full
count on the low and high registers.

Fixes: c9bb590d4295 ("net/txgbe: support device statistics")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index b68a0557be..580579094b 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2250,7 +2250,7 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 	hw_stats->rx_total_bytes += rd64(hw, TXGBE_MACRXGBOCTL);
 
 	hw_stats->rx_broadcast_packets += rd64(hw, TXGBE_MACRXOCTL);
-	hw_stats->tx_broadcast_packets += rd32(hw, TXGBE_MACTXOCTL);
+	hw_stats->tx_broadcast_packets += rd64(hw, TXGBE_MACTXOCTL);
 
 	hw_stats->rx_size_64_packets += rd64(hw, TXGBE_MACRX1TO64L);
 	hw_stats->rx_size_65_to_127_packets += rd64(hw, TXGBE_MACRX65TO127L);
@@ -2269,7 +2269,8 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 	hw_stats->tx_size_1024_to_max_packets +=
 			rd64(hw, TXGBE_MACTX1024TOMAXL);
 
-	hw_stats->rx_undersize_errors += rd64(hw, TXGBE_MACRXERRLENL);
+	hw_stats->rx_length_errors += rd64(hw, TXGBE_MACRXERRLENL);
+	hw_stats->rx_undersize_errors += rd32(hw, TXGBE_MACRXUNDERSIZE);
 	hw_stats->rx_oversize_cnt += rd32(hw, TXGBE_MACRXOVERSIZE);
 	hw_stats->rx_jabber_errors += rd32(hw, TXGBE_MACRXJABBER);
 
-- 
2.48.1

