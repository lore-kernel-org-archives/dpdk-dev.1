Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59787CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C89240673;
	Wed, 24 Jun 2026 13:53:15 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 639E440665;
 Wed, 24 Jun 2026 13:53:06 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301983tdcb64719
X-QQ-Originating-IP: OMHDLcP+uT8I7U2Y+3n6GC0gxnJfaKpH28o6CFh07OQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17102530705709423069
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 02/21] net/ngbe: remove duplicate xstats counters
Date: Wed, 24 Jun 2026 19:52:34 +0800
Message-Id: <20260624115254.20348-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3uuf5hGXrR0snY51U89VY9BbxGJaabn8mGHdI11DS/+2Ix5VvakD15i
 DB4+QkV7XzZHFnhPR4g6YdNtdXbaeDxLQCdC7am9s/JoJZzQnhZ0PzPnVWpRdxw/MTw32n3
 oVTWlDsbB2Ed8r+5fCt2x0xPivYZDiSHZFLl/ZvuLGgCupghz5scyODqoxyv4PDkeNB+QPu
 UIegLLrf5pQTEM4fWFJpPRfkj0favXo8Qgle1fD8ZP5kduU/HE1gPmGX4cY3SsT9drC6Jgk
 rE57phbK5Gq+BjsO0GLsMpg3HqTHba0stcDtm0lg5Q8n6dagvcGiLKl2V7hNkdadMR1QPIs
 7U9+1m7vJZfR4Dp6CPOB6Tx41+TMF114sTFDJqnkcDMl982sJ4FkIY8F0Ivh6OpN4VmRXNz
 kk8+qs/x7cUfgkmCFVN1VmFGdbH+/vOt+2rUFK2c/RS16ZGXESNoScVgxLTfDyYx4OI2Vvk
 u1LCSTo3vb/dFTXj2zHWc4V9ymqkmOFFz3GR/ItJ3zTvbcs0ieTCcNwmLMX4tkuGu8O9BYC
 2U2WXAltpbbkTsKe9MnVvigDGp+69Y+y8SCeqzaJcwu/rLqZomE9VVw3Q3khnI4bn5sXnKJ
 IK+v/7t6R/UzuumlonD/QNUQXvk8rGDJIagpflvSYxl6MJSL1RCR9P15CRRl2ZIIKOa5IVa
 tpfgqkezK2HRpMqX5tU6WsiFd1e3U/M8AEbossqq5BhSf6k+6Iz90rV1z8g5RyBXit5sBbg
 NWU49pEGhDQRKH/lE3RqvjrlogyF9ES+5eztBeSNriXoZCklrl4Xedfn1Ot+/DKA9j+zu0a
 wuSIkWv0rpKc5GU+FpojmFk66Hd2wi7rFOlkRB3PAebWGvRn2Ni5BLjKNTXFL1xJ/sRXwdt
 ykYyImHTnwaPFIjX5tnDlgVp/pQRRjVsBF0I4D7hEdQpJRVUWWEW4XnWnG/ZNf3LK+BK+5F
 ieV3ccUB1Q4twLU/KN93FCIazQx/lx5mDdCefs6UKsTZGCJMJ0bHSz/C2TVGWvQ2wG+Ci3N
 NQ5wiTXSgy2ycO/wmdauX2XrmolsaM3RIZcs7z+i2Jt1B6sqMIRx1IubCzanRw1WkJ94Akr
 38r+cXJYJkmEiQSELK8CpbkZX2t9rOV2YrnOoP+ANs/nW1DzeqVe8EdnGBbUSxO4A==
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

Remove four redundant counters (tx_xon_packets, rx_xon_packets,
tx_xoff_packets and rx_xoff_packets) from xstats, as they were duplicates
of tx_flow_control_xon_packets and others. Both sets were reading the same
registers but being output twice under different names. After removing
these entries, the flow control counters in DPDK now align with those in
our Linux kernel driver.

Fixes: 8b433d04adc9 ("net/ngbe: support device xstats")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index f7b4a8b159..09bcd791ed 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -227,11 +227,6 @@ static const struct rte_ngbe_xstats_name_off rte_ngbe_stats_strings[] = {
 	HW_XSTAT(tx_size_1024_to_max_packets),
 
 	/* Flow Control */
-	HW_XSTAT(tx_xon_packets),
-	HW_XSTAT(rx_xon_packets),
-	HW_XSTAT(tx_xoff_packets),
-	HW_XSTAT(rx_xoff_packets),
-
 	HW_XSTAT_NAME(tx_xon_packets, "tx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(rx_xon_packets, "rx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(tx_xoff_packets, "tx_flow_control_xoff_packets"),
-- 
2.21.0.windows.1

