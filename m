Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BBC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7985842F27;
	Fri, 13 Jun 2025 10:42:42 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 400B342F07
 for <dev@dpdk.org>; Fri, 13 Jun 2025 10:42:37 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804153tf5ba6aff
X-QQ-Originating-IP: OKZQh2SLCerw7XoYZdOWzfmZmYACNRnIJm0utoLZj50=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7342313512202435104
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 10/17] net/ngbe: support RSS offload for SCTP port
Date: Fri, 13 Jun 2025 16:41:52 +0800
Message-Id: <20250613084159.22184-11-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NImvdRhE6fHp7z1zVxE+NTmvWkemkzZsLLQ/MtXbeDgRr7F7PNpp77er
 s4QYl4XqOXxBpbhc5UbOhwyrGaDvksLybfPdLFydL0obiPEIL9mb9PsFvRWY7kyAhtnQHk2
 sb46BW/HUhweWl3BxWJrptKohNzf0Jhw8UWl3LkAHZ+F+3mKc3enGcRj8OmxwV7OD/Zy0gD
 XGBsDgEz0dyMGj3VAQ9woRcWu22C0MeoJQwqQVz+MIfWbLD7e5RQfE2GAuPtwR5LJeraLGT
 f9iJucFf6rNYIzzSEIei9sxHidJOA7fiL9leerL84Axh4Ybx0NoBnrSjOKxeL8+w4RL+tuw
 YW+nhynCZXBsjfU22sKgg4mtDlAJh0xC6pIkl68JZFl81q6B1aOrcx0qIGPtSAIs6NafeAX
 hGflkEffinh5R66TewiQ3abDOZAZd1uJuimTtYFG8rU7Ltm/5dV3Ir6+6jyaimzqKppP02m
 pHH4nU6q47xYFxbEgXPY1at9G5jSEmSz2MNxhBgnZxwQr/RPCgmfw1hGQw4qSkHTdIDilQ7
 sUfZF5M5yksunwdMS/qqhe7vLs2oZ5d1cvYvAHmnzr+bzGiC9lQ8qnWfaHH/i+7acW7klHi
 q1GJjjqD3OXGUJpc0rE48IYXfdsEW327Exx+OVTEJTbUsqjQXHf3rA2De2WPWSUEYZ46Luz
 paVOLG6N+JpSkqNhol1Pbe9KNnxjT+EYikKnxJPwLsmQdZd1uPEkJ3KAltFdckOk4vLl9Q+
 xrtvmHLgoKYD+9wp9m4VPx9p6Uvs0WwGOw3eDhhLumIuzqDgNj2JBDVW6Vfp/apMk7qquZr
 20PNJE0VhJ/WbHlhGZA5WbR9Qu6U5LgjevWd54V6iLdrSnEY8ZgOMo3ojaI2r0KH60b5JIq
 lV4YYzLVdQ4TUJQLr92b7hmVrqs3wxq5aqJvhUwf37q5scuvkBFS682BEz0+CYmaKzkjYwm
 4Z2fADUxBau7guDdyOl3WxhqUAq0l5T4S6lzRYwUB+8pPIyI4se204SyQzUc83jQIgHNK/7
 b+cLPVpxX7m8bq/F9S4bOQ59KSSLo=
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

Add support for IPv4/IPv6 SCTP RSS offload.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_regs.h | 2 ++
 drivers/net/ngbe/ngbe_ethdev.h    | 2 ++
 drivers/net/ngbe/ngbe_rxtx.c      | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_regs.h b/drivers/net/ngbe/base/ngbe_regs.h
index b1295280a7..3c123049b7 100644
--- a/drivers/net/ngbe/base/ngbe_regs.h
+++ b/drivers/net/ngbe/base/ngbe_regs.h
@@ -452,6 +452,8 @@
 #define   NGBE_RACTL_RSSMASK		MS(16, 0xFFFF)
 #define   NGBE_RACTL_RSSIPV4TCP		MS(16, 0x1)
 #define   NGBE_RACTL_RSSIPV4		MS(17, 0x1)
+#define   NGBE_RACTL_RSSIPV4SCTP	MS(18, 0x1)
+#define   NGBE_RACTL_RSSIPV6SCTP	MS(19, 0x1)
 #define   NGBE_RACTL_RSSIPV6		MS(20, 0x1)
 #define   NGBE_RACTL_RSSIPV6TCP		MS(21, 0x1)
 #define   NGBE_RACTL_RSSIPV4UDP		MS(22, 0x1)
diff --git a/drivers/net/ngbe/ngbe_ethdev.h b/drivers/net/ngbe/ngbe_ethdev.h
index 37c6459f51..faff57ef34 100644
--- a/drivers/net/ngbe/ngbe_ethdev.h
+++ b/drivers/net/ngbe/ngbe_ethdev.h
@@ -40,9 +40,11 @@
 	RTE_ETH_RSS_IPV4 | \
 	RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
 	RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_SCTP | \
 	RTE_ETH_RSS_IPV6 | \
 	RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
 	RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_SCTP | \
 	RTE_ETH_RSS_IPV6_EX | \
 	RTE_ETH_RSS_IPV6_TCP_EX | \
 	RTE_ETH_RSS_IPV6_UDP_EX)
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index a372bf2963..3dd268e5bc 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -2652,6 +2652,10 @@ ngbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP ||
 	    rss_hf & RTE_ETH_RSS_IPV6_UDP_EX)
 		mrqc |= NGBE_RACTL_RSSIPV6UDP;
+	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+		mrqc |= NGBE_RACTL_RSSIPV4SCTP;
+	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+		mrqc |= NGBE_RACTL_RSSIPV6SCTP;
 
 	if (rss_hf)
 		mrqc |= NGBE_RACTL_RSSENA;
@@ -2704,6 +2708,10 @@ ngbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	if (mrqc & NGBE_RACTL_RSSIPV6UDP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP |
 			  RTE_ETH_RSS_IPV6_UDP_EX;
+	if (mrqc & NGBE_RACTL_RSSIPV4SCTP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+	if (mrqc & NGBE_RACTL_RSSIPV6SCTP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
 	if (!(mrqc & NGBE_RACTL_RSSENA))
 		rss_hf = 0;
 
-- 
2.48.1

