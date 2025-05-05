Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C3C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 05:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7867040657;
	Mon,  5 May 2025 07:57:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B55A24065C
 for <dev@dpdk.org>; Mon,  5 May 2025 07:57:28 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5452uwn2021860
 for <dev@dpdk.org>; Sun, 4 May 2025 22:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 bk7a1lnJc3ahEQ6K9lME/cSNtmAbK4YL4QN4BDJ0f0=; b=gerfaMq2Qofj2Xly0
 0VgnQUz82xRJsTu6rzA9lBLG/5XVx9kJ5aQ3vSch9GFIqIGHC4QdAik+QKywLIZ3
 soVwYqF1xID86489xktzNELk5G4C9if4v7TMx3RmYMAv2ImKY2/1RjoQvC9gzHjP
 z9cyPvfrnHUurOwhFM7QW4dmkbCJFtH1jwL5yHp4rjmj09pa19P+n2AqyaGAW9T3
 tQ9/YBaRHhyNNZ86Voima9E0gbFCEQAg8bbHJxb+sxo8toAXBzQiB1aguEK2YbGl
 YJJezD2I9QJvlt0++U9soUi/QJVeC5zxPJUVFJP7C/VauHj84LYcIGYZYq/kV9QY
 v6qIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ehyyge9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 04 May 2025 22:57:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 22:57:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 22:57:26 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id EB3AF3F7073;
 Sun,  4 May 2025 22:57:23 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v6 2/2] drivers: add support for IB_BTH header for RSS in cnxk
 device
Date: Mon, 5 May 2025 11:27:16 +0530
Message-ID: <20250505055717.3697335-2-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250505055717.3697335-1-kirankumark@marvell.com>
References: <20250505053304.3288290-1-kirankumark@marvell.com>
 <20250505055717.3697335-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YKOfyQGx c=1 sm=1 tr=0 ts=68185347 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=sF3me3CDcygQo1B6QsgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: XrCVZYRlTXuFBJSl-04UTLe1UC-LFcQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1MyBTYWx0ZWRfXxdygBID1kc6d
 j4HJCOuoI9MrbWjqEFjU5Q/ghGHJFKQvNEZKJqkATcVCniwsB5YyYqTR5E++2bgcKqA74QEJhKL
 EdVB3q0NvlXqzMkn45mhgBntIM2s1DDv0t0MMx6fHriCfdXAC6PFMPSYORsZDQ0QyRrHuWkqssX
 MxIdVidX1mo50aB3iTvBt2RY4Q+bm3qDhFDAcFiMOgwrM5EEZw6KR3JgPjkBdJH7RqGxv5yr9IZ
 KC5y6OmEPztriAjm4X21FdjFcwqLldHZE7KpsXTtfFx05gHqi45fBnAwNTo3fsjg/sEu4t1rKhz
 oCxX3dZsfgL6EWiP3r+lZIOXx0Gpo0SkKIfYXXw93t9eAsYDyoC0SJiuvDzWul1bxdc0aM4Jxzf
 lf8/CXnFm9QMg26Q8v+T+qaO4Q/tqYFpRWWETcTefHyMtWc2Duo5bXrFHDtw2xIXrG8/Tb8/
X-Proofpoint-GUID: XrCVZYRlTXuFBJSl-04UTLe1UC-LFcQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
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
* v6 Chaanges:
 - Formatting changes.

 drivers/common/cnxk/roc_mbox.h | 1 +
 drivers/net/cnxk/cnxk_ethdev.c | 3 +++
 drivers/net/cnxk/cnxk_ethdev.h | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..251e48adab 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1777,6 +1777,7 @@ struct nix_rss_flowkey_cfg {
 #define FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
 #define FLOW_KEY_TYPE_CUSTOM0	    BIT(19)
 #define FLOW_KEY_TYPE_VLAN	    BIT(20)
+#define FLOW_KEY_TYPE_ROCEV2	    BIT(24)
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

