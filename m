Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB08CD98CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4AA42EE4;
	Thu, 11 Jun 2026 09:33:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 446AA42EE4
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:33:56 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0R2Cw1253872 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
 BOdndqhSr4mJXQJqC3BKzD7ia1QSPPMeePRHEQv2XA=; b=aaMWF1aLt3lhaRLr5
 qO7YRT1y8ZOHc/hKAbz5HzSg+1f8eu2md7VSVz+l0hXN6SehY726LNQRP15sXu8C
 0PD17ako6MBUUki0Zvep23Q8dyH/g2I8OAXNff/x8dCLHg6fFF65hyxzomDWHiLh
 qiqq147Paa1N739gpLfShP4457e3bXQLP7lTydrRHIcoS8cfGO9g1j9MEZjcJUlk
 NnvGD5yuEeFQs5ERqtYpUVhmbmgkK2RrMY3nUd0LvKX9w0Nxav5Mymh/gN25sCEL
 Pn0RBAEXXGHW58A3Mq4mu1VYgx3MqdJCarakBY5O6rb8nQhkMLrwgWze57eyN1i9
 B+Z6Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vswr5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:33:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:33:52 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 2DE235B6973;
 Thu, 11 Jun 2026 00:33:49 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH 06/17] net/cnxk: reserve memory for lookup mem at probe
Date: Thu, 11 Jun 2026 13:03:00 +0530
Message-ID: <20260611073311.3129711-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXy8YD2WgzrlTO
 vwv4s24X/Iur4YQ39T18lHGTvElixJV7IbYuQZQYg3e/HeooNxotY09VMC+BLo6rhrLj/ShNZyY
 3uBzCu9kbiVeFqN92cI0sJtWWp2/bis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX/WQV83IqfYHQ
 9n75XXptk/NQotk67+EbaCvdJaKK8acGjOj2FRl609hFA2bl7Wdlu6fMQE5pXJkhdQQBefk90Mj
 M84MNkUyU6SAgPp49JyPOtA6JrOrQRcb/Q9DO4QTJowBgDjlsCxhJ+ishd2+zPUJQkydboR3LwS
 CCl4iSF9zjqiY++HrL7HXJ42er8xvkLD/VPP3tRSU+on4YpcKFCCCEnw8qjkpvCVX69oVWWKRF1
 ElpxhE0H+eZDslZ/GJRDMakRcY+bmu1IBoywvHjvM4Kmfl1R2za6pgA3cAxS+O2zp84sdQeS4TC
 BURqp7uy/mPq869y2PyRuwirR28Ah2LavSiAuOWEi1PF8ADwIQ23mliU1jHuMeFqbIxFMRYBROA
 QIjaelzQU2hZ4Y4h+hScliGqHfk1qt3KKpc5vlUyi9qoRqr6fNK11QOmmFnpFq+43fwWH9lefaH
 0/NjRvFFc2AwLqAf38A==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2a64e3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=ycIEUdTOxP0xdqTo3GYA:9
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: KrPtJZlQ0PaDDdWqS5u5IbSFKcPswM7s
X-Proofpoint-GUID: KrPtJZlQ0PaDDdWqS5u5IbSFKcPswM7s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Reserve memory for lookup mem at probe that is global for
all cnxk ethdev devices to avoid race at later stage.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 06d1c9b362..c782dc51a8 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2220,6 +2220,12 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 	/* Register callback for inline meta pool create 1:N pool:aura */
 	roc_nix_inl_custom_meta_pool_cb_register(cnxk_nix_inl_custom_meta_pool_cb);
 
+	/* Reserve memory for lookup_memory */
+	if (!cnxk_nix_fastpath_lookup_mem_get()) {
+		plt_err("Failed to reserve lookup memory rc=%d", rc);
+		goto dev_fini;
+	}
+
 	dev->eth_dev = eth_dev;
 	dev->configured = 0;
 	dev->ptype_disable = 0;
-- 
2.34.1

