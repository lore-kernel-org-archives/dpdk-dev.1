Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE43C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CCA14065D;
	Fri,  6 Jun 2025 10:01:58 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 90CD240616
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:01:56 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196911t695fe91b
X-QQ-Originating-IP: 5zSIj/2hUKdgrp8p3lUmvBAhpG1eCIdaB392oACrBa4=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5525924386531058644
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 04/12] net/txgbe: support RSS offload for SCTP port
Date: Fri,  6 Jun 2025 16:01:09 +0800
Message-ID: <89727E92A22E4976+20250606080117.183198-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NPS3ZrBWpSdgek99ljsgpivhUONzAoaveUq2vUKEKNTTwDBNSui63lkf
 GnfZTcQs1z+SI7B5Q09X4yOohF5X5M5M+QSgSZJaavgxB9G+Df9swQXzULamgkkyl1NtKC9
 mY20wQqqTdWPddRzmccaF95XI5blZ0XyxYns1W5+u3DmfQnOW5ELWYmi3TsUWv4hIte6w6L
 G5Syr5XMCUYMZTbXBy0KQnJrHjch8A0St3fW4X/HR00Q2zshy5S4z1C8eb717j1LoTjrDg9
 2yeiUGlQeEwFSLhrAMs9JBEmmRSt3/AAm/E/TOQZJxoXebIkGwJndiXwVlc8GUzdAzy8Vhn
 q58CzjZsu2qLjb9a7sZor/KHa905n+oqqiMf8lpfxJw0WJGy+Afpo4EOmtLMzCSysyMZUsV
 HcRMkSsu/SmCrQ7W8JTm0mPxme77WcjhDA14MZW11/GTygV8J8qwl4I9RMGg2wcP1iK3pcL
 9JVJ87iwEqqkG2uyG7yGunvCEB+78owxcaaUnuwq2wxFCVGYbS1AUUQm+p3KD83t1ODKB6m
 RJ8N4H+uz64zBFr6NvRDOSfFHYmH8CCsVm0zXISUqwitWq/QJ92RLyCnmcP9f6yKmmtUKit
 pDwbCp3IT6S2WIJfD1N7/pkFLQ7gZSlV/UXZh94iP/SY2wqb0TwwwdM0hP2QtCTfYzmIp2U
 Fqrd/+d6BosMKGj7W/5KPVetnwo4uqvevAaKlpP2A+6ZSg9vQGQXNh371k1V5IHkOswJbn6
 nloTv5QpNEhtU7r7ptNTfXc9pqM1a9zZBS1VSND0dRXukP85mAtTe/1d6hGmrKEPbf+ShYJ
 R2lJicVFx+NoN+GpfEyvwk1NPSPlaJ3p5NN+JztmSoTKkVO4XOMVcj2zcnFJA02DzQK0wrq
 O2saU34DjtapAj8mZLGFAkeDHdGveru7BfOyNvqryI6FnNZmf7PD8+TzOzFCNlXbE0TAB1v
 2sk+Acpf2iWc/nWrsGTR9eVxoxWgBhPVscAJI/dpSJoA5PZ9aNoMPsLdnp2n0ZIkj6+GaGr
 +KsZfeI+xW9OGrFkRKooYX3NQAR6E=
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

