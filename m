Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7CCAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 10:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1EEE40669;
	Mon, 29 Sep 2025 12:28:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2683C4028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 12:27:59 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TAH9mq010903
 for <dev@dpdk.org>; Mon, 29 Sep 2025 03:27:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=GGnXHEvQh9W6fuKiYzb21nI
 rWU5OmB/rZ+I2OWj/3ow=; b=i5sN29OmZxMvRptjm48QuhRzCRH49wXHzizQ9Ao
 qsMpPGWezfBn7ivYzAIVJOGKp3x7Bu60NlBVz+lB2KSig+NRxZLMN7QDqIiU94vg
 ySAPgTlgpH3wjDFSUyt8sU9coRgCn6wN/fLGxSHQ5bKJlcAH1uMmo6S4GUSHqPC6
 Egs9z1B5vudOzlgZMt2gRbUsgqMyKTK0GX6KFofKeXPPxYs6gxPDQG8WmRdz8aBs
 bzRQlgKZh+e47JnD/lsD4DTYt1y3X5ARRVmmq5EPfng8ANWiXPVRAIMd7CFIH0EG
 2fpJmLQA+B8HSh+Y3QFG+eXKwKbylyJqvnbNJYcVbnwJjQw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ed9hknvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 29 Sep 2025 03:27:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 03:27:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 03:27:56 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id AD0643F707B;
 Mon, 29 Sep 2025 03:27:54 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH] event/cnxk: increase inflight buffer count
Date: Mon, 29 Sep 2025 15:57:53 +0530
Message-ID: <20250929102753.1036004-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b7W/I9Gx c=1 sm=1 tr=0 ts=68da5f2e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=AjdBvmSu3e-_IAx3gTAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: kogsWR8AxAYOYa9UxjQowihwp4DcFOe3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4OSBTYWx0ZWRfX4tf6FLoehl4X
 quUOw7aUlSZxlAJCmqS+0BmD//NBElV9QUSZ5T8dGQNsyeuQPf4XyDOYwjt+6RigGsPwYQSsQsL
 5JL1ri/ZLzoasAVDBB0tYw5GbRs8+TnxFc1RAxH23QOQ5bvH4iKt82uVXx+2CEL6xbLg3OVWWza
 BFddeJRLKC32k3q+F512XYD1HtLv6ptDqZYdE2cRLltsneN39eJDEfNjsgrUNYbhWTE0Zagaivw
 1ntquZKLpGZ8YKmX5mIdpcpS8ZSeD3sB/ZPYGE5D6WEbVIPP2H7M+N5jgxyMu0JHII2ngMjVJ6N
 KnjYM3ZJ/NQb+nXEDBIHHvy4tUwSdIxG8j2UiiqzocncfyHNayVWPgyt+lra+Qwp7Dm8kL1Wc8y
 Rhv1BlMPOC8Pfc9fMndoVG0umLtIDA==
X-Proofpoint-ORIG-GUID: kogsWR8AxAYOYa9UxjQowihwp4DcFOe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
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

Increasing crypto adapter inflight buffer count as
performance is dropped to zero when high traffic is
sent on 16 or 24 cores in event vector mode.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/event/cnxk/cnxk_eventdev_adptr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c b/drivers/event/cnxk/cnxk_eventdev_adptr.c
index 80f770ee8d..3380712095 100644
--- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
+++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
@@ -667,7 +667,7 @@ crypto_adapter_qp_setup(const struct rte_cryptodev *cdev, struct cnxk_cpt_qp *qp
 	snprintf(name, RTE_MEMPOOL_NAMESIZE, "cnxk_ca_req_%u:%u", cdev->data->dev_id, qp->lf.lf_id);
 	req_size = sizeof(struct cpt_inflight_req);
 	cache_size = RTE_MIN(RTE_MEMPOOL_CACHE_MAX_SIZE, qp->lf.nb_desc / 1.5);
-	nb_req = RTE_MAX(qp->lf.nb_desc, cache_size * rte_lcore_count());
+	nb_req = qp->lf.nb_desc + (cache_size * rte_lcore_count());
 	qp->ca.req_mp = rte_mempool_create(name, nb_req, req_size, cache_size, 0, NULL, NULL, NULL,
 					   NULL, rte_socket_id(), 0);
 	if (qp->ca.req_mp == NULL)
-- 
2.25.1

