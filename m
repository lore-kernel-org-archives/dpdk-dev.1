Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CDC61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2930640B98;
	Mon,  9 Jun 2025 09:05:26 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id E6AE740B94
 for <dev@dpdk.org>; Mon,  9 Jun 2025 09:05:23 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452719t1c18da3c
X-QQ-Originating-IP: OXAKT/sxG5JnQEiZa8K4CL2EXgG7soTdjbteQ/ZmD5Q=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1657494531615998031
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 05/12] net/ngbe: support RSS offload for SCTP port
Date: Mon,  9 Jun 2025 15:04:47 +0800
Message-ID: <8B79DE012B805E6A+20250609070454.223387-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MnvGtZwO7LbyepA791NaHhkOZ3BDu2ctZBSH5JcSpD6eTFRckSXnfosn
 ZUk1xd5Cv6QOkXwinBwFeQIBVOR3CWeLD4VA+M6TyQuv2AEA1scfocKl5t4vCJTYjYdGsdY
 gunHS5+HVrsTmy9Hyw7O5ZC+r3UrbzElZj9XccN+751/DZHt8VCVex6JlvFaRyAyrWYeWiN
 iZZszvgLbWw3Tjy2RN8cPZIrj2hjLgNozyzdrPLw5+/oHC25msUrcS8bB1cQlq1oqooJbNR
 kr/nOiJ0+IX3kO8lEKLcrtNgU/jSCs40KQkBnJtUuG7E8gYs7bJub2WvXy2BS8ckmkiFOhv
 diPtEpCQ0ebFoAw95w4jlx/bCt9YfwoEKQNNrgWTof8UXcE3jcUEKf1ME7MfR8yXzRSvEZ4
 WySfKnwx3m97CLmAYn/oSPkRYSExvWnifZrsgxboa9VB5RY8qn+PrMEVSSn8jKmETKyr/nm
 0IBRv+x1LYAmT6/OWVuliCYxHSc7COa/IdN7KeCvSeD4CwP9BA7f7f1pp1y4ZGORQM7KNo6
 IZJTDwt5Yj5ec9/hof1YFkgAqhjcwobkVh9dDquj00aKk5OlKHJ+QSuWn8EVDl+gXg7qHlO
 /3WlT70Ocbr/Zyc23aSWQCLrCUNLE1ThWPgoU52vCqMvSxzaOKQuyRSScsv5BwmYrA1La/P
 B91r0oNK528WKW9BP5mNuSRSCk6Hpk8N1w2U/CTm65ltmgVg6t9umNHUiELs3OgbNQvibxq
 LFDyDjtUGr3OVjDvaiOzHjpx3vM7crr5gqM+uoYW4MjxF2ENrS+BAMtbVchkie/QropuQs3
 YHnAQi6iqfczQGfczJGW/V94+bttu5spu8rWllu5RV5f318e8HL9DiboDxVy/+VsyGtTNow
 Aua6WUBuPUE9fGhW3MhZnRCPIQDK0V6ASNL0cOKJE1W50QDZO1Ucr60ANVjUzk6KnsctfgH
 Epd4MZggV8tql4gqkbsBi5MK/ZjdSS39L0TUTarlXIJwLVKup9EWfaqb4ST9Y4C3T+8rG/5
 8UYV5jxGCChfBtna2h1ftqU3pcjgg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

