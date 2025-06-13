Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B47C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:43:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C15A642F0F;
	Fri, 13 Jun 2025 10:42:39 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id D140E42EEA
 for <dev@dpdk.org>; Fri, 13 Jun 2025 10:42:35 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804151te40472d1
X-QQ-Originating-IP: kMsiAfkS4u/tVI3Xadpmw8nWjMS12svOV/KjNZYAMIo=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8675857764569834167
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 09/17] net/txgbe: support RSS offload for SCTP port
Date: Fri, 13 Jun 2025 16:41:51 +0800
Message-Id: <20250613084159.22184-10-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NjuDfT6zrIZcnuxbUIId68JoVN9ko1XIWyvWqtrGCr184E/UzKODVnY0
 uYpNoZ3cLk6GsguNK31qglyE33L8I1xHKQ6kCvO8DgHZc8zcP/VUx1DcxnpkBsXu4HZs6a5
 Ra+dS5uPhJHH+fxlTzdSYyF7dzRQWQErfKkOpxOQx8d2nHNw7Ne4oaWjRfgEJoqowSpgf7w
 z6KQvqkcdDit1QeVBYklHozr+qrdlYQ4PXKH6w9+qlUGpFfEyJcYep9XjXLTwWYGpSATyLb
 O3EcERjQQrz8EPZPouG5vxk4Q92fdjdWBzeLm/v2n5jxUZDF3fMCuxBqwL6N3O8rtfg5cWw
 XMV0flJOvbjWMHsmiJ3n+m/0QrhNBlj5LaUe8mzpLJ+4rkNc//Jdh989zDVO5kx6WiNFQOv
 +j/aWFCd0+SODEWjyWcu3fz7f+ZbRZ/Sy76TX94aqsUjIFNUzLI/mCj2vF73az91CtfhPfn
 wQUNVapS9OkYJSLMOteun8CzGzLmaZw1Q0JJNK8YgWg7iMsmvwNZQA/OTKX35D2m5Hp6ALV
 pql/AGwglspD10VXBjpHemaiv3tEo0Z7nP0cVvR3LABfbyhbzt/JgSCMCCtJngf5v7De6cK
 iJxy7WYYzysSuhutWE4vFtHwptDcDfX7/dKaMwomCxUR9hNqLYVYElMxYHO62uxgEHWSt2P
 onkCXimIWzeBklkhQjFLnefEiphiqtImoy8OwexjXpTwdRBUf7A6/uzqMLGevRcOTy2m9r/
 ES2HI0qoHEVKqZsMaFUz1YRLzoSTXo92sTah2HHux9MTKCIDM/2IKbU+kk+rMJvXoNXdquu
 hO6BxbxaCFkQTPaPDLNJT3osalq9htrnwLkDpkpMFLRmSO/a1I7830k5AKKKpguEQ5lepel
 ExEtJ8AqVU/zUT2LCfWuWPFk78lif9fk+4qYi/z6Ll10uGJsi0s7nDIWdcg52GnYvKpyh91
 5/L+nDVKsBI2gDsaWBfjqIgrkbWF5a7tfhSHA2CKox52yHfOAxlg+twxh1kF6F/7y2Yw2c/
 t356K2g3utP/NXNH5yUNyXQsD168U=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

