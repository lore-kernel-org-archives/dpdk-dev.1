Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CE0E9A04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3709A40661;
	Thu, 19 Feb 2026 10:09:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3798440654
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:09:19 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61J288GY553489 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:09:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 O3T3ByaqmWs4bxx8oULo4PsXf48sQ1dDvttRCwuTx0=; b=Mf1P0hsP2mg+AMhTW
 KerbOwSeOhdHsYRssavEQh+72Iv7YllZo6A3PIW7NE428j/cjODcN/o9dDKAPvnS
 jFkcJ6KyIp850nXeTuI0xXSig4kbZVnBHOc2szOmmaO+mZW4fZ+ANql4ZklodZiZ
 af/MkSMJi+gig2/gvkGFkVhn1W/BFijImoIRpQJNjaIdTvFZxP0t592kVOVm0eA4
 L0N6vpbSLiEaGK3eRelag9jk/MNht5v1f1xdcyCRkG9SBZo9IaQmuir1TE5++FA6
 YLJ1SjEjvy18yFSy1Hg1ECxaiPBW9pdsukba97cz2fl3fK8GEQKpHFAvo26Hrdra
 V9H6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cdsfagmeg-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:09:18 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Feb 2026 01:09:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 19 Feb 2026 01:09:27 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id A06CA3F70C2;
 Thu, 19 Feb 2026 01:09:08 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 5/8] net/cnxk: config RQ PB and WQE caching
Date: Thu, 19 Feb 2026 14:38:44 +0530
Message-ID: <20260219090847.3257753-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219090847.3257753-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=T/GBjvKQ c=1 sm=1 tr=0 ts=6996d33e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=fK6J1xwn4MavhwGraL0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4MyBTYWx0ZWRfX49dzDLopg4Ql
 85qj+GRm/YlUEMiXEN4uH2Q3GW2l9PQ07toxqV0f4IfeXj5W6OA8X8JFprSRyxWFdelEXoaWhvB
 p4eXb6Vb/s+8kl0JClp8zloKdolbvOKtgbHWMaHU1ZKFsJ9YItSigIhAoSg8NgG9Hmlxf7nevgv
 cfNVWorNy0GRu5AtrBzaOCCTBGCcc7NUdlpuj6XSV7qqBW58udH3NA/RiuhbJD4TikK/f62kdKP
 H62id1jHMfkCC8wy5KJbEKH2BSJ8EBwu+wFqJvDiutq8UhUQem2wKAJvfy50C6Y04G8GYRIPMS0
 ulGUiMPX+rfn75P1gfHiOzE0t8nyxvdnM8gWFUI+bGa3BxJkRDGwVKWKowJEpp7mjNpVjWsHART
 ummX81LdhNesiJFdN+iZhYyzzzSBYnVISi+BF1vfCN6fxy/SZIUQ5r/7k+Bf//1dU3BDm1w/mru
 pDohkTdy2aKUkNfIOqw==
X-Proofpoint-ORIG-GUID: bfTSt-x1ClKMZPbdk9nNflR7r0mX9Tyb
X-Proofpoint-GUID: bfTSt-x1ClKMZPbdk9nNflR7r0mX9Tyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
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

Config RQ's PB (packet buffer) and WQE caching to default
values.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cnxk_eswitch.c | 2 ++
 drivers/net/cnxk/cnxk_ethdev.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index 6b1bfdd476..e45c7dfd07 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -389,6 +389,8 @@ cnxk_eswitch_rxq_setup(struct cnxk_eswitch_dev *eswitch_dev, uint16_t qid, uint1
 	rq->aura_handle = lpb_pool->pool_id;
 	rq->flow_tag_width = 32;
 	rq->sso_ena = false;
+	rq->pb_caching = ROC_NIX_RQ_DEFAULT_PB_CACHING;
+	rq->wqe_caching = ROC_NIX_RQ_DEFAULT_WQE_CACHING;
 
 	/* Calculate first mbuf skip */
 	first_skip = (sizeof(struct rte_mbuf));
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index c979454f37..c5daf0ca10 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -959,6 +959,8 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 	rq->aura_handle = lpb_pool->pool_id;
 	rq->flow_tag_width = 32;
 	rq->sso_ena = false;
+	rq->pb_caching = ROC_NIX_RQ_DEFAULT_PB_CACHING;
+	rq->wqe_caching = ROC_NIX_RQ_DEFAULT_WQE_CACHING;
 
 	/* Calculate first mbuf skip */
 	first_skip = (sizeof(struct rte_mbuf));
-- 
2.34.1

