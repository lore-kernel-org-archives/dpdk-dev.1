Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6D60A3812
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=NrwfcMIe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E90D840ED1;
	Mon,  2 Nov 2026 13:22:42 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 37A2C4003C;
 Mon,  2 Nov 2026 13:22:41 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29DALo666194; Mon, 2 Nov 2026 04:22:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 xt5FDwTjUndv2KbKSbJuGXT3WbtoclPrhabEtld/FM=; b=NrwfcMIeuiq7pk4GW
 yZbIg5XCe8oCyeGWAqElbYnZC714lp18CGT/EthI/eokRW3/ENS8jUqMW5S1wbA1
 RFUQsA/wiRWO+ce6VC6lWMI3obRSif3jo+/DBxlHtRw26K8rEtz4bYVpHPCd/KkG
 6sP12N0GR448mIChf2LUSQXxkUCsLO0p566h4wWIJsFl6ctILUb3+/cKz9UcCQhB
 73Z9XZPpwEeDfiiSKrXdZYm/6ws9Frz5D5bNA0cXupNro8KNaqf3Ad8LOJciI3IN
 u/3DAd2tiUs1SsnIXHoPQkl677Kf84T5d6UkQmY9yNBlYXajKX2IxLva8WBzwe3r
 CmceQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hpqmrghda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 04:22:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 04:22:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 04:22:38 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 5A2F83F7078;
 Mon,  2 Nov 2026 04:22:35 -0800 (PST)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <rbhansali@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 4/5] common/cnxk: fix OOB access in RQ FC config
Date: Mon, 2 Nov 2026 17:51:52 +0530
Message-ID: <20261102122154.2611710-4-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102122154.2611710-1-ajp@marvell.com>
References: <20261102122154.2611710-1-ajp@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UYTE26SN c=1 sm=1 tr=0 ts=6ae8808f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=Iy4wGqz2l_ymsR4IiYMA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXzp2Mg3Ne7eO5
 YO+zFLuDAunBwx8DnI//PFqn4oF4mgpd8stwvI02HYiAuqN/o7B7zRxQ7RkEo90i+zA+9nvQtMN
 Ebdz7PIeVfPr9Stdx2mkiGeCgEr1R1KtddvhUGxAi/dbsEFtQFUXNh6Ch2W4+8dQf+OIw8o7D6z
 mZ9NoFJuHF9sdNPOFioo34yQBFqEJJxeOef7idj46Geaq/v+XxLO/evcQTmE8I3BOZaRxVhvQz8
 QDAwqD8OMHeM/Gb6V8H7BzX+9BM+IhFRoNpPC7tf26o8UTIWTJKkQCMDgbwAAWAVywaZTJiSxws
 TXEkYSJ0d/odkJUasbYprWCDqdvBSWFyuDznYDkzJQqePFClb73xBiNIK3WvwNyzLqbwUTF4zcJ
 iVBGe+hpRQyUu14RuwChvoYj2TPx9nIbWV1V5KlgJ7Lh+vi6N9n3Sis0BDwcdMk/BL43rw9YpQZ
 HY4g6c6hQr5p6hongtA==
X-Proofpoint-ORIG-GUID: A60vHb22XF6CM5K3PyhImipz7RAjfopO
X-Proofpoint-GUID: A60vHb22XF6CM5K3PyhImipz7RAjfopO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX7an3Zkb444Vd
 bmocyoGKY8QgkgP+N1d+ZFKyWQ9PpwlAD4mqGRruzP/heqwZo3xiwojl8CBaCqkjMaBKze8xXjn
 j42tlS6XRhqzJt1kYwuXbAKGEw95NvM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nix_fc_rq_config_set() indexes nix->rqs[] with the caller-supplied
fc_cfg->rq_cfg.rq without any bound or NULL check, unlike
roc_nix_rq_init(). An out-of-range rq reads a pointer past the
nb_rx_queues-sized array and then dereferences and writes through it
(rq->tc), and an in-range but uninitialised rq is a NULL deref.

Reject rq >= nb_rx_queues with NIX_ERR_QUEUE_INVALID_RANGE and a NULL
rq with NIX_ERR_PARAM before use, matching the sibling ROC helpers.

Fixes: 78fb5efed869 ("common/cnxk: remove flow control config at queue setup")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_fc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_fc.c b/drivers/common/cnxk/roc_nix_fc.c
index abf923b722..8164a2ba0e 100644
--- a/drivers/common/cnxk/roc_nix_fc.c
+++ b/drivers/common/cnxk/roc_nix_fc.c
@@ -358,7 +358,12 @@ nix_fc_rq_config_set(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 	struct roc_nix_rq *rq;
 	int rc;
 
+	if (fc_cfg->rq_cfg.rq >= nix->nb_rx_queues)
+		return NIX_ERR_QUEUE_INVALID_RANGE;
+
 	rq = nix->rqs[fc_cfg->rq_cfg.rq];
+	if (rq == NULL)
+		return NIX_ERR_PARAM;
 
 	if (rq->sso_ena) {
 		pool_drop_pct = fc_cfg->rq_cfg.pool_drop_pct;
-- 
2.43.0

