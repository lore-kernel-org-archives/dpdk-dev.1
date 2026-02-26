Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952C1FCE077
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E349A40669;
	Thu, 26 Feb 2026 14:18:36 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A34EB40669
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:18:35 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QDBdvG096637 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 h/mUqKpJJsuu4BhwRFZQmiFbveocGsPsGTrxS0tPwE=; b=DFFID4XWzFyoBt8rq
 2W3PjO5B4Y8FObLlIXd5F5ctm9aj8TLmPicrpsrxZwqT1AUi967uiCjmYV9kXGY2
 n9SCAwnyFMGc0jTBm8BjhNpNtlWv6YVDEC24jRKg42Fh9JnT4yzrQZBNcAEYR7+G
 1WbEaGXdTv0dgMTS5QZ041r7rr6LU1WUTyficbHAK5zsAGu6cEOCTRCZSznUaJQl
 T6CC/LhIAVnrsZ3JykSxa2D7le4WTXPo6ktMLSHa51vl8G6c0he4Uu4Ch1Jmfi+w
 S1MTv7cm3p9OZFsy4sLKSGfRlzWbUSHBKKzpNMIvwvLix3vR2SctRbdj+c99YrvC
 3Vjbg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cjpuhg0pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:18:34 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 05:18:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 05:18:34 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 8B6153F70D8;
 Thu, 26 Feb 2026 05:18:31 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 5/8] net/cnxk: config RQ PB and WQE caching
Date: Thu, 26 Feb 2026 18:47:12 +0530
Message-ID: <20260226131715.2851091-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226131715.2851091-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260226131715.2851091-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OXo_ydGcHRcn4hhTzbwhlcgjqaodnO10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExOSBTYWx0ZWRfXykjZywWGL///
 dyn5X3km3b4pDeqKOBjY80CLkLPfVXBR4qH1we17tRKirS8oQ939jwI4rZ9ROeN34Fgae0OKWzR
 VprflfNpSuhsjsQJQpFC+m7WxHHlSCV6ZTYwwH57ILURvXYzKm0R2TSkkSGKVLf36PBlmNFuQgL
 BDRGmeuM4GYJ2c3YpKl4yzR/01uo9nbvbhs3TwYeLbTt75GWXmzbzej4sktirSUcvoxplx5ZtqE
 pgpIW8U1NDICDiey5h6rO05INCBk8YIQOWJn9UuLmSZLbhb2+m+bnwIyFvNtVo5VNzIVL19Nyta
 F//phXsujZi6veo9K5ZtHncTy0KNTxbDYXEPCcuMSKK85pCzoH0tDETWzpbzQqzr/Opzf8mVFiD
 UYl2WuCrxHiZidsWT+CCN0rp2eD7RW340ipER20noYMKOA5eKDtJv6LbCWeXTaL2Dj4kRNI0qMZ
 0tzxoBe7fNwhHAC89pA==
X-Proofpoint-GUID: OXo_ydGcHRcn4hhTzbwhlcgjqaodnO10
X-Authority-Analysis: v=2.4 cv=f7JFxeyM c=1 sm=1 tr=0 ts=69a0482a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=fK6J1xwn4MavhwGraL0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
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

