Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3975C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF1940A7A;
	Mon,  9 Jun 2025 09:05:25 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id C72BB40B91
 for <dev@dpdk.org>; Mon,  9 Jun 2025 09:05:22 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452716te95f881c
X-QQ-Originating-IP: FLYyy8hWzn2+F9wT6IDuI3h1+DRrhfUodDjydcaXPME=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10053156601016066695
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 04/12] net/txgbe: support RSS offload for SCTP port
Date: Mon,  9 Jun 2025 15:04:46 +0800
Message-ID: <76197192193F911C+20250609070454.223387-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nzc98Th+6mOzokPGNmeOlTEGx1Gc+o0lE5OdWSB+A7ktL0q5YqUOCXCZ
 eVxuqK/ZqyNI4BRgEmz6S+GVAAkZ0Gvkv3YLrrvnA6qYZogYNJmyRylcqUw0/BGH+uRSgyD
 +v5T0Xgp4okzf1oqd/56Fp1T1PmsDF/r+2jLIu8zqluVNQqchMsKrxwvuh0FDnRFy0E1ChY
 FduZKJxX8eYbrYbSVVYKjqGmsZ+DSiOd/3cf4LXiSBu5ZHsfce+D4tiMiMOcqSHVYpskYu6
 OxuL05lcSPa7FaKUrI+vuoCBC2nf7j4pntLt9jdZ+ziQ4kzlr9f8TYGZmX38WIEK6PbymfX
 iXyRhLKLyvhgnAiOynK9QWQp1zqyjjFVD5PsqL5n5Qyaet5LilLPGuMepDZyR9W7J027XwT
 OWwZHRixHnLVkcLAkd3phvKmf1/9T64/03JeDxZu+odtSuLsRwMe+e0A8Py1Q+ifsE2fsMX
 XFBR12/s5pxspPaTJ76tonJr/qap8jsX5NHKYbbPBnIBAJdmG96RXK33iNV5pIpvebkECnl
 dXei0jk4+WOks6AHgBOdyfEk5ES5MBLFKU6urEhB6EYj8jj3usrEaPrMCnR+f3XN9dZJQWA
 JO6bJ9elqFYeVsmYhzZ01XcB2LeZeBTFqe58+DqQibmrx3bJblrJ1V7ZSn6ugpAYqkUkHBd
 ngYcx1Q3+vKkwT4n5fzZXz58wfPor5T3OeFPXQYouXF2PxwJWC2EQwhuxUqTdCPLR8Mu1ts
 vlswQkYUnJH6ASuC9PFaZV9iVkQtA4lRm2dwNslIRLrRjAa3AYssOGx0ufB46vkqphpOy2E
 zbuQkGSR65tKUYO6G6l4dVEWs4XULLOAqIGq0BR6HDBvV6S6cH39GLy1hKZz2Xr7Ki2cWKK
 /aE71OtiQnEIIPhkVH/vVqhHKWm4bfrfcks5dLP8f1/vfmBSANrtiVJRswVsHQjSk6O8Hu/
 6JARXG5POxLQkO6nlf4jCVniidz3YQgxQYdPFJZHtvOW713zlrZIRpCG9LHCOdy6b4WbJD5
 4ra3mjJsv3Tmm/QDcRM/DSy6OfYueQfTWCGQlHeO/63Pm3ik6D4Pe4RPcOx+c=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
 drivers/net/txgbe/base/txgbe_regs.h |  4 ++++
 drivers/net/txgbe/txgbe_ethdev.h    |  2 ++
 drivers/net/txgbe/txgbe_rxtx.c      | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 7a9ba6976f..346c23b5da 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -580,6 +580,8 @@
 #define   TXGBE_RACTL_RSSMASK           MS(16, 0xFFFF)
 #define   TXGBE_RACTL_RSSIPV4TCP        MS(16, 0x1)
 #define   TXGBE_RACTL_RSSIPV4           MS(17, 0x1)
+#define   TXGBE_RACTL_RSSIPV4SCTP       MS(18, 0x1)
+#define   TXGBE_RACTL_RSSIPV6SCTP       MS(19, 0x1)
 #define   TXGBE_RACTL_RSSIPV6           MS(20, 0x1)
 #define   TXGBE_RACTL_RSSIPV6TCP        MS(21, 0x1)
 #define   TXGBE_RACTL_RSSIPV4UDP        MS(22, 0x1)
@@ -1287,6 +1289,8 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_VFPLCFG_RSSMASK         MS(16, 0xFF)
 #define   TXGBE_VFPLCFG_RSSIPV4TCP      MS(16, 0x1)
 #define   TXGBE_VFPLCFG_RSSIPV4         MS(17, 0x1)
+#define   TXGBE_VFPLCFG_RSSIPV4SCTP     MS(18, 0x1)
+#define   TXGBE_VFPLCFG_RSSIPV6SCTP     MS(19, 0x1)
 #define   TXGBE_VFPLCFG_RSSIPV6         MS(20, 0x1)
 #define   TXGBE_VFPLCFG_RSSIPV6TCP      MS(21, 0x1)
 #define   TXGBE_VFPLCFG_RSSIPV4UDP      MS(22, 0x1)
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index c2d0950d2c..9295d8fbd0 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -65,9 +65,11 @@
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
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 4e4b78fb43..a85d417ff6 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3090,6 +3090,10 @@ txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 		if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP ||
 		    rss_hf & RTE_ETH_RSS_IPV6_UDP_EX)
 			mrqc |= TXGBE_VFPLCFG_RSSIPV6UDP;
+		if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+			mrqc |= TXGBE_VFPLCFG_RSSIPV4SCTP;
+		if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+			mrqc |= TXGBE_VFPLCFG_RSSIPV6SCTP;
 
 		if (rss_hf)
 			mrqc |= TXGBE_VFPLCFG_RSSENA;
@@ -3120,6 +3124,10 @@ txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 		if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP ||
 		    rss_hf & RTE_ETH_RSS_IPV6_UDP_EX)
 			mrqc |= TXGBE_RACTL_RSSIPV6UDP;
+		if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_SCTP)
+			mrqc |= TXGBE_RACTL_RSSIPV4SCTP;
+		if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+			mrqc |= TXGBE_RACTL_RSSIPV6SCTP;
 
 		if (rss_hf)
 			mrqc |= TXGBE_RACTL_RSSENA;
@@ -3173,6 +3181,10 @@ txgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 		if (mrqc & TXGBE_VFPLCFG_RSSIPV6UDP)
 			rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP |
 				  RTE_ETH_RSS_IPV6_UDP_EX;
+		if (mrqc & TXGBE_VFPLCFG_RSSIPV4SCTP)
+			rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+		if (mrqc & TXGBE_VFPLCFG_RSSIPV6SCTP)
+			rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
 		if (!(mrqc & TXGBE_VFPLCFG_RSSENA))
 			rss_hf = 0;
 	} else {
@@ -3192,6 +3204,10 @@ txgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 		if (mrqc & TXGBE_RACTL_RSSIPV6UDP)
 			rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP |
 				  RTE_ETH_RSS_IPV6_UDP_EX;
+		if (mrqc & TXGBE_RACTL_RSSIPV4SCTP)
+			rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+		if (mrqc & TXGBE_RACTL_RSSIPV6SCTP)
+			rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
 		if (!(mrqc & TXGBE_RACTL_RSSENA))
 			rss_hf = 0;
 	}
-- 
2.48.1

