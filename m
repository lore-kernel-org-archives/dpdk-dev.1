Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB2FD9E34
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 04:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18D7340657;
	Fri, 27 Feb 2026 05:38:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7B7EA40656
 for <dev@dpdk.org>; Fri, 27 Feb 2026 05:37:59 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QNLMab2261528 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 jebxVh6IDKlfsptMt/2BCYTEq9VYQuXS/LTvgRlYvc=; b=R3lDPn4jsrgWlhTpL
 i4KEGpi6Xlgw9zMTJ+fuFAcu11DXpT92EnzfW45/vt/ZLNYbSZDvOrShyYKY+nAy
 KDI48MyeljpHidfYX/oP9JnZwOkr0YJlHNOXUwODxiDf2hdqk5jyxvDW++cnmI6e
 Q+7+0bhl3eJhu7lzjieNB73aYBKXpzqBvIKg5b5M8yS4FcMb58L2OzA4yTydvBEG
 KjC0xDFAczQsFexrja1x6s/L9sf6lIM1vWXsaiPIX3jFHu79WCL42jK7GVnxfdPp
 xl7ToJyI6of3tfswUjKrWNCvjhkWCoCszyNbpqK5ygAUMPlNkS1eCR8dCdMMaX/Q
 xesZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjyrx0hc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 20:37:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 20:37:57 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 553FA3F70CE;
 Thu, 26 Feb 2026 20:37:55 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 5/8] net/cnxk: config RQ PB and WQE caching
Date: Fri, 27 Feb 2026 10:07:20 +0530
Message-ID: <20260227043723.1986183-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227043723.1986183-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260227043723.1986183-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y6H1cxeN c=1 sm=1 tr=0 ts=69a11fa6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=fK6J1xwn4MavhwGraL0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 62g248ApWMpDz1wEjEK9WKVeuRIr7u35
X-Proofpoint-GUID: 62g248ApWMpDz1wEjEK9WKVeuRIr7u35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAzMSBTYWx0ZWRfX37O7xNVPnKTO
 m06sDcLZed/0SeqfPWlT+BOPkPYIGVoQ7cqJJ4sH43h4FMCiNKminnUG+ooNiiXkjTaFKMSTEwB
 5YvZFChQmSLu6Y895KBUTGYSc1A5WJHY6YwgYGdpmWHiLFPS/Pk3PwZko6gALFGTIu1DxRYhWyo
 uOgWcrMAz2ROEbBAMtaet0GOB1XYGDWemi+jqe1TvScTtcBvKaWBS2UnbH52+GRV3chbVDM5uq4
 a1aNGvGGzzhTDW6E3WMPEJ5AH96okL3OOWuFr5gdK0g0bZMF2ysw6qcoHkjQ/EEkyYOx0Ld11ap
 2y0y/ry3adW7CLHkeV3/WYGWZVwe3BWVkNLL6XHpaHVCxQK0TVRAvjd5Yu3oexshZMDsCnpxpkM
 gRj8BM3ku35hGx1HxowYLKrUjInfovWue5pfXtuv+ddThAxrMD/adfDqM+MkCChPiziTkj2lsw8
 ACLtRykjvuyBu/EPAQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
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
Changes in v2: No changes.
Changes in v3: No changes.

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
index ba8ac52b46..06d1c9b362 100644
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

