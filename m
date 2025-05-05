Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A5C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 05:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F241E4025D;
	Mon,  5 May 2025 07:33:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 06B7140156
 for <dev@dpdk.org>; Mon,  5 May 2025 07:33:15 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5450Npwo026274
 for <dev@dpdk.org>; Sun, 4 May 2025 22:33:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 PzZHRpxSkNkMVS/FDga7xEFfX6jiZexCePpzGM5eZw=; b=EVLLIBdQQc1gX8aP3
 RoCGGcLqCNrqaWETWrewad1ejQVGZUxAIrtjQ5nhONoZ/+5Cccm0ARCg/6ztljZO
 wlMuL6h00sSuciyr0zh1rFT2FkPlZSlyMBLTbdB/WB36EcR9X+sym+eYdelqLwBy
 0E5vlTte7MPMX87+Lz+YHSyCLXtQfGzWJZv5XPQ1A+esvyr5wgl8z7FPgURv1+OC
 t6gQwxDEsF2WDLAI5Z6UOLgcut4w6QJQidi1fhCVVLsZNHzLgx2oy77T2W1qZmsM
 BwOUrSPEQt0QbDN92EjjOU0fFr6O9QXWwrlyQ0EOc4s90I4A8rkXlLN1QpnNdMWb
 qZmkw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ehyygdaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 04 May 2025 22:33:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 22:33:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 22:33:14 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id CDF723F708A;
 Sun,  4 May 2025 22:33:11 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v5 2/2] drivers: add support for IB_BTH header for RSS in cnxk
 device
Date: Mon, 5 May 2025 11:03:04 +0530
Message-ID: <20250505053304.3288290-2-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250505053304.3288290-1-kirankumark@marvell.com>
References: <20250430102011.991865-1-kirankumark@marvell.com>
 <20250505053304.3288290-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YKOfyQGx c=1 sm=1 tr=0 ts=68184d9a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=sF3me3CDcygQo1B6QsgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4Tg1GxMN1X2jeIVA-_I3gkqm7xfv1Viz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA0OSBTYWx0ZWRfXzgApmrmU9Cry
 KpR7P3k3MqpuzdD1G2KKnl2Jf0cXEEHckATDKrLo0y31fOLxrKgfjgBm1PRBM9MX16dhNJIfDtn
 gFdZxnldZYhVZFahUjAXNkf5IF4CFG36IXo16+DcLue+KH0tA6+jCSCVhS2YLj2QbBIzIA/744o
 VMLEBPyBoSm3WOJb7jB3RgRyU4FLu/0mpU3tzEc29Hj/dtwb4bzq10M9LsJnVMhT0CS5afXi1wR
 EBK2Y7VN9PPtbFcYZFpUFnbdzYc/8nVoNnt3EVwAmQuyqhTPwh8T7LY2PnZV/FaLJMAunWUazuw
 Rz7etX9vYgDznuRSI4xR0322CXOdrjMclGwpEUA0Osh9F/GN7eJzKBOKtqTjk3nucUoFZG01b7s
 YTe+G9UlQyigioxEYfQJQwMOTJNcZTUx2pmq9GPudp7YEWP+/anMDOLiZa1uByCsUpIeJtcZ
X-Proofpoint-GUID: 4Tg1GxMN1X2jeIVA-_I3gkqm7xfv1Viz
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
 drivers/common/cnxk/roc_mbox.h | 1 +
 drivers/net/cnxk/cnxk_ethdev.c | 3 +++
 drivers/net/cnxk/cnxk_ethdev.h | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..325fee626c 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1777,6 +1777,7 @@ struct nix_rss_flowkey_cfg {
 #define FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
 #define FLOW_KEY_TYPE_CUSTOM0	    BIT(19)
 #define FLOW_KEY_TYPE_VLAN	    BIT(20)
+#define FLOW_KEY_TYPE_ROCEV2 	    BIT(24)
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

