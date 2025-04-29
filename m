Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EEC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 09:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1483D406BB;
	Tue, 29 Apr 2025 11:53:04 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 59F40406BB
 for <dev@dpdk.org>; Tue, 29 Apr 2025 11:53:02 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T6cECZ024861
 for <dev@dpdk.org>; Tue, 29 Apr 2025 02:53:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 mvDex0xgj+/9h9g8TilHhjsa4yeeO89sWJz2vP6SB0=; b=fMwkyROwS5QzEkrY5
 YXPYbeVkjrFSdHMrNdotm8hPkUE0iapTBglG0nkqa0oNoAfdURUli79KPbvMDyQd
 n7hrVyVxUoX9IawD9ZpMsBRlyyh4ueS1dE7PcL4BOGhrS3fgYLGcN8hq0wzboggE
 B67cnPP83Du2CZ6c3mN5Lt462jseRx9taahzWSZEbxwFvg9fUWznYS4UfP4CRmlx
 CtJ7xLTOREV0Op9shssiHQ9scFvUMBMaQAVJKcIp9mFH3XKE3cqBFLIk9D3onDqV
 11AWHviDKDXVS46almVMqxPShsVR3d9FKqkgHxsdzTufwexntoJ/McnhJDTfzj1g
 PaTzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 469krcc778-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 29 Apr 2025 02:53:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Apr 2025 02:53:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Apr 2025 02:53:00 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 15D173F7045;
 Tue, 29 Apr 2025 02:52:57 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 2/2] drivers: add support for IB_BTH header for RSS in cnxk
 device
Date: Tue, 29 Apr 2025 15:22:42 +0530
Message-ID: <20250429095242.1861885-2-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429095242.1861885-1-kirankumark@marvell.com>
References: <20250422051459.661395-1-kirankumark@marvell.com>
 <20250429095242.1861885-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HTwMO2tPLole_K018aOtTtaUTJ8IK4_a
X-Authority-Analysis: v=2.4 cv=f61IBPyM c=1 sm=1 tr=0 ts=6810a17d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=sF3me3CDcygQo1B6QsgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3MyBTYWx0ZWRfX0U9+1cCjqXo1
 RxkKSx/WUPCc+af4obKhAD28VueZ6kgTAd0oCSjXXqQz0fSCwyqCl5iJasZs7t649dX/wgi+4HG
 BZpOVK+lisSBC/djfU6izP0aXZs2U7HAbBb5oGRri41ahZBeIMpWuwDUpeceaNhxoYXjNLnow7s
 y7dnJG/42AkB0DrsfFEFyujFw8U2LIy45CSk9k4GBunHBjYVr1u/yg7GuD5ODVOi2qQMb4SRUuK
 Uj0QnVHMBYcNorEbE17/7D7UHFWwJZxB3257HDZSiv51dE2QgjPQkHzAfNkLXH3rjVX56vwnmhw
 weABnVgASgvE9pRTRRkOLGUqOBoidd+OKpuN3lkphDMUXSP1YnjPcKH7q1oputrlEurN3mWsDXM
 y4s9QBhO0EdDalwR1c6lGIpJl6buHwJmmPI33V/kyPFGae+rPRf7YEOb/fyWC8g+hcY0763J
X-Proofpoint-ORIG-GUID: HTwMO2tPLole_K018aOtTtaUTJ8IK4_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
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

