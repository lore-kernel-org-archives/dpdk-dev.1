Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD0C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F20440674;
	Fri,  6 Jun 2025 10:02:00 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 9A0604066F
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:01:58 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196913td67dd90c
X-QQ-Originating-IP: KNn+7fYW3gff66AnTsgIPTuC0TwdJAyimy4PES2k0Lw=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16478930435086702399
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 05/12] net/ngbe: support RSS offload for SCTP port
Date: Fri,  6 Jun 2025 16:01:10 +0800
Message-ID: <40D036CA37F79251+20250606080117.183198-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MW//binZVb2sqK3dKVMpEFR0xnxFVGAJiPdAHt90+nIscQqwfumzmUg/
 8B0k42ZYarYIAsMdjXKnxJmpFvG8xvbuhTHqI7Wbx2u9WrllI0uRLgrPj7ZKcpzIbVhzDAz
 YvoIlVNGpKXaeW2nObrpA+wmSrKu53qMxnHjcsYMV4ReMcRQ0TTku2OjuCNXbYLu+lMLvZN
 oSlWVawIvs6+XJR6RAAdWexhzlvXJ0XvVIZbt5zROrO1SxhYbdr2E8z1oTeLc/0B6tUC6lz
 kD8yX1AoLYk3CULRO82EGwNuJRMtsuy09Aj6QxmhUlQgo7v9DikMhCorbdr2JfcdEvARoFJ
 9tPA8lC6lNOxIfXtm0cHQ9RV/loPkE3/W16vvYKD20lt/bMICBWNSHC2uFGjG5ekwXGhheZ
 gWiFr+nVnp5IwbPJuzKrSkLY2EcL7EWSXa/Vsm6/B/YHKCZIkGwkWac4KlWcuGkgkKwsjaH
 XEm1LlpFc0AALtAB0TZgDbxvm60uwYpjWjCJhEHa9X2NURGrHeKbDxXjchKFtgc0w6pog8V
 1BTrrvWW85CXuLPNqWaGJ4JJIgtET3/4V7eevRSz+svhEGE735nxnudNWBtBOHCTOtTECIY
 duYv9SotsZYLtqFr7BPmZLVmDhwLZUSLi1Z5R0T1zkPAnzc/iq862oG6nQryvb0r0mZLb9K
 5SdWXXvvE9BKPqOw655bEB0KoRuqiaed6aLMtdNT6RUosM88Df13FiWtX+8RqJVUg1gHBCp
 DizAwkIQjIQsK85SnvI1Kt8c/bqGhg2+I5cC8kcG1V6F8NPYAphG9n6TsntRKZVGf0ZnGQH
 B5DwyWhIrURDG8nMezd/5KfnhxoxCEvWfAeromn1O6qblnyt4ss4/HJTqhiu/j2h7jet8X1
 1ZgIqjVSlyPh0G40x3ba60g2I7mntCC+4CyccLz6wCL3Tb4xg22b836T8N93UQZbksgMJET
 7yFF+rd+ayVFA1guA+O7MIT8HaIXxsT1KToKPMKbaQQ2njaouTk6qqNV6/9PqZEoRhzsW5K
 Zlg/nfP4uoVfuh1X6sPTD/UflzMgYu1oqODaW60UdbKWjDxGnM
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

