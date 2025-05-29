Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 15:44:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FF4A427A6;
	Thu, 29 May 2025 17:43:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E6F9B427A9
 for <dev@dpdk.org>; Thu, 29 May 2025 17:43:56 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDqVXu003767
 for <dev@dpdk.org>; Thu, 29 May 2025 08:43:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 mvDex0xgj+/9h9g8TilHhjsa4yeeO89sWJz2vP6SB0=; b=gQ0BWE/ckf6b/F9Ss
 F8d3YlkB7IkpPEdC1BjsiQ+012lzDb1llAEWhbVReMHHX+j4xECtiHubTsRxtOLV
 L1PLqMx5etSgKyEXMqJ8Y5CVHa5dbFtnlQ8MGMJMKg1QBFeIv4EeM3MS5STj3cpR
 i5G491E65MOcGq0UwcO2+L0h+dE3AXOksaOKdb/GDlENnpJathgInqiWBpPmfT4s
 VeA2S5/pD10TMWrWRd/lOjNT1gDddXnLHwZaP/1ZuxzkZEH9cB7swepNSDVRYlqH
 I0zB60HnXbqYR2MK4R2eVrw3NlTNVZ7Z2LJ2vWibZX80uzK1VldNaORdRgWfeqSu
 l6Jzw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46xc7h9rw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 29 May 2025 08:43:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 May 2025 08:43:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 May 2025 08:43:55 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id E1C5F3F70AB;
 Thu, 29 May 2025 08:43:52 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v9 2/2] drivers: add support for IB_BTH header for RSS in cnxk
 device
Date: Thu, 29 May 2025 21:13:43 +0530
Message-ID: <20250529154343.1589903-2-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250529154343.1589903-1-kirankumark@marvell.com>
References: <20250529153908.1571050-1-kirankumark@marvell.com>
 <20250529154343.1589903-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NCCY78nJxKC_0F3pbksd8H011XGw-pCR
X-Proofpoint-ORIG-GUID: NCCY78nJxKC_0F3pbksd8H011XGw-pCR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1MiBTYWx0ZWRfX549a4YBICQD7
 Xkg2krNs/DOjIaswamnQ78pJvOI0qP72zjnGix2Pwe5Pi1oYczgTfMPf85GlPdPZtk45w4pZeKl
 5CErwMzntxvTnZK1pQ+Dsd3sFpuBzI8I0q7AJTQLWqYoBmn/GhLVU5XBTBmQyXtUWdqBtPHiJRz
 DIKhdPLXuC2gycnz4DPDER/9Wn6V4lR6hC2FzJEsIiez1UyTHj0Wpv2COkia/iyEpYCuhgFh4fa
 6DJ4f4vdwTXxccDpiVA/b3nQ2fq84nbudLuvS/XfJUCHfTyUHtFUVSrL7jV/Q/HyWQRUBKcsQ0q
 Ht1GovhoKeiX9cR6J/K99e8LvHcCzylkKyVK9CebPA44tjY7Y8S+coeeXiKJerL1JjKz2mV/VRi
 iDaHjahPqeLTTL2NVFaQ1CPlUNbh+Nu9bJ3FWOHiuG2wCpgvNMoSYKciMuhbTU8CneQSALtv
X-Authority-Analysis: v=2.4 cv=QcBmvtbv c=1 sm=1 tr=0 ts=683880bc cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=sF3me3CDcygQo1B6QsgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
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

From: Kiran Kumar K <kirankumark@marvell.com>

Adding support for IB_BTH header for RSS in cnxk device.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h | 1 +
 drivers/net/cnxk/cnxk_ethdev.c | 3 +++
 drivers/net/cnxk/cnxk_ethdev.h | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..030556c8dc 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1777,6 +1777,7 @@ struct nix_rss_flowkey_cfg {
 #define FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
 #define FLOW_KEY_TYPE_CUSTOM0	    BIT(19)
 #define FLOW_KEY_TYPE_VLAN	    BIT(20)
+#define FLOW_KEY_TYPE_ROCEV2 BIT(24)
 #define FLOW_KEY_TYPE_L4_DST	    BIT(28)
 #define FLOW_KEY_TYPE_L4_SRC	    BIT(29)
 #define FLOW_KEY_TYPE_L3_DST	    BIT(30)
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 026c61f2c7..9500e92172 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -939,6 +939,9 @@ cnxk_rss_ethdev_to_nix(struct cnxk_eth_dev *dev, uint64_t ethdev_rss,
 	if (ethdev_rss & RTE_ETH_RSS_GTPU)
 		flowkey_cfg |= FLOW_KEY_TYPE_GTPU;
 
+	if (ethdev_rss & RTE_ETH_RSS_IB_BTH)
+		flowkey_cfg |= FLOW_KEY_TYPE_ROCEV2;
+
 	return flowkey_cfg;
 }
 
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index daf80be51b..4f9802c5fa 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -59,7 +59,7 @@
 	(RTE_ETH_RSS_PORT | RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP |                 \
 	 RTE_ETH_RSS_TCP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_TUNNEL |             \
 	 RTE_ETH_RSS_L2_PAYLOAD | CNXK_NIX_RSS_L3_L4_SRC_DST |                 \
-	 RTE_ETH_RSS_LEVEL_MASK | RTE_ETH_RSS_C_VLAN)
+	 RTE_ETH_RSS_LEVEL_MASK | RTE_ETH_RSS_C_VLAN | RTE_ETH_RSS_IB_BTH)
 
 #define CNXK_NIX_TX_OFFLOAD_CAPA                                               \
 	(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |          \
-- 
2.48.1

