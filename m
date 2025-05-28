Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6B2740E0A;
	Wed, 28 May 2025 13:51:55 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0D93D40E09
 for <dev@dpdk.org>; Wed, 28 May 2025 13:51:53 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5rdXB021837
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 Me85BZFLMNfiZ43o0SPULZjRSNrRvlIePVbJ3cIMng=; b=JkU/QZR07hBuNP1SF
 WJr6sps3UK8WVEYi18M4QvvDYEEXScosqpLPJ8d9sFpei1+Qk26EQoJ9MqIxJTaZ
 6EhED+x4nc/CxAvp+we6KDf4/7QBkmZLyKYxn8EbT0EkgI1R5snaQ1znN29dV01k
 mF3wtaxSnljDkQArOy93TQz63CgcNsHy7yvXEvRb/m8SkPXFL0Az0if1fsPTVNBq
 zeBI+PLmtzjH84bS6H/EYkx+HwD/OsSWFCpoHah0oFfNYfzWauTFCbokTHFlC9vy
 reDtVW1N4oAPOHe4EMU1jSh1lstttNu3AFvcFT726j9a5ShJkL2BnbiMirAlIfYX
 cN3Nw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq8217cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:51:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:51:52 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 8FD453F7060;
 Wed, 28 May 2025 04:51:48 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 4/7] net/cnxk: fix descriptor count update on reconfig
Date: Wed, 28 May 2025 17:21:19 +0530
Message-ID: <20250528115122.24052-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528115122.24052-1-rbhansali@marvell.com>
References: <20250528115122.24052-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5VEHb1G7_iDKS2mIvAn1xWD05VBkuSNx
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6836f8d9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=K8W4_W6bT_eAdeSgTYwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX0KXeDaXyqf21
 oD8WgKhh5U8JymLwr+r1zmUN+pOosh+9IysWveP6WjvU8nSyXi3RH0evFFp902SOm1vPHuEFFbJ
 938rRk72Y4S52oWBLeNfy07HpevZ2yOWgyp/lsEhRiLlaQfpt0Z2ssrteBoREJOt9VgyEGdoFQs
 QEwi0S0kOO2zVTH56J2IK1g3PPRt1r1gdbwZcG5hk230fjz4wVombtxdlLmN3N2Vtp34OTRpP2r
 vr/3m/smVzH+KneCyjhHNwjdzO8sRtVB+6yl/06pAnvoExf35SMxwudALh6g+6ZMIy541lMzdVH
 +/gDFVqjRxWG3COAHCLIShKcYE7HemPwz9wBDkyd33Q3jXkVYXSQJ9wfYQjdSn1d7BYuS/Np73T
 yLW3RzWxnc98p2A2MKLaty55ZBnC13AH1pJonUKbOVckRAi1WvMUsQZ4jhb2AAfUsPozxuBi
X-Proofpoint-GUID: 5VEHb1G7_iDKS2mIvAn1xWD05VBkuSNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

In Rx queue setup, input descriptors count is updated as per
requirement, and stored. But during port reconfig , this
descriptor count will change again in rx queue setup.
Hence, will need to store the initial input descriptor count.

Fixes: a86144cd9ded ("net/cnxk: add Rx queue setup and release")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 1ba09c068b..14e4e95419 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -653,6 +653,7 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 	struct roc_nix *nix = &dev->nix;
 	struct cnxk_eth_rxq_sp *rxq_sp;
 	struct rte_mempool_ops *ops;
+	uint32_t desc_cnt = nb_desc;
 	const char *platform_ops;
 	struct roc_nix_rq *rq;
 	struct roc_nix_cq *cq;
@@ -778,7 +779,7 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 	rxq_sp->qconf.conf.rx = *rx_conf;
 	/* Queue config should reflect global offloads */
 	rxq_sp->qconf.conf.rx.offloads = dev->rx_offloads;
-	rxq_sp->qconf.nb_desc = nb_desc;
+	rxq_sp->qconf.nb_desc = desc_cnt;
 	rxq_sp->qconf.mp = lpb_pool;
 	rxq_sp->tc = 0;
 	rxq_sp->tx_pause = (dev->fc_cfg.mode == RTE_ETH_FC_FULL ||
-- 
2.25.1

