Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB5CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6A5B40613;
	Mon,  1 Sep 2025 09:32:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7D28B40697
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:32:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5817VNHw013825
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:32:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 eOBbHBa0afY7z9J4miKIHvYdLfU0uoBAZEF2lyBZeU=; b=Nhk14pZUqv6IeDl0A
 lyOmskVp18+pRm6vVKX7auwHAUSlf42PJrVbSlFJmBw7XrlSaIdLK9lGjiMelus6
 oV83K9PpgrnYcM7p4Mf4IoO/jcbtr3DTNyhC5w+fWReW1MgO/DsGXjlLu09veYCg
 Ng5ntV/1OrS5RIZjSa2hrM06w+GmnoNOMSufieZHhgZYoxbeypcDKXzzFyPE5HrK
 qClG7qZeQyYW/AfRsk6NHrbN68/yNx1oN77VaDoyhp4H8PyNT5p8ub8rOXxBTCzj
 p90u/ZSDvliH3/co09mp82QhCcWbiV/WH4Rmy7/iG6KVrUFqjb2nWbX4rfZspaCp
 56Wsw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48w75y806w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:32:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:32:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:32:13 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B15043F70AC;
 Mon,  1 Sep 2025 00:32:10 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 16/19] common/cnxk: avoid null SQ access
Date: Mon, 1 Sep 2025 13:00:32 +0530
Message-ID: <20250901073036.1381560-16-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDA3OSBTYWx0ZWRfX3wAtu2I2McFM
 8dl2lyDLt7wR3N8ZliPGx/vd87xSptFzpFk5nb7KDbuDg2CGavHa8jW7YYk8XmC/p8PfQyeKad/
 bX4uU7+l61PAhHEc82S63uNDiZusly7GrOtC4aZSO6AnBzctcS3cH0Po8qRNLqn4VpwH8mojKvX
 3ulK6e1+YPwn78udB3bVlSRXgDxPK/xjB7FuIR7ot3eND3XSZFi8WYERx/R8x6aUeAYIjPar3q9
 oUomuXtkfEA1RT8JCw4ZZ5kIaob+NobXBoya9DSL6DNrT4a6QdgVpBO3OoqfLxLnxbZLpWC2bvn
 5WidQRdWuKFeTjVLjU/nRfPJKIEBGeUkCugrey+ZKlni+oeHVpiO380QUkt6XXBNGz5+YUylV/r
 OrW7KqbH
X-Proofpoint-GUID: SiARNiklmamqK6Zom4biqq7gMNip5lTI
X-Authority-Analysis: v=2.4 cv=D9BHKuRj c=1 sm=1 tr=0 ts=68b54bfe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=EJG3gQsRTrVFihcy3uAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SiARNiklmamqK6Zom4biqq7gMNip5lTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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

From: Satha Rao <skoteshwar@marvell.com>

Condition to check SQ is non NULL before access. Also pktio locks
are simplied while doing threshold_profile config.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_tm_ops.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_tm_ops.c b/drivers/common/cnxk/roc_nix_tm_ops.c
index 09d014a276..230e9b72f6 100644
--- a/drivers/common/cnxk/roc_nix_tm_ops.c
+++ b/drivers/common/cnxk/roc_nix_tm_ops.c
@@ -624,6 +624,13 @@ roc_nix_tm_hierarchy_xmit_enable(struct roc_nix *roc_nix, enum roc_nix_tm_tree t
 		sq_id = node->id;
 		sq = nix->sqs[sq_id];
 
+		if (!sq) {
+			plt_err("nb_rxq %d nb_txq %d sq_id %d lvl %d", nix->nb_rx_queues,
+				nix->nb_tx_queues, sq_id, node->lvl);
+			roc_nix_tm_dump(roc_nix, NULL);
+			roc_nix_dump(roc_nix, NULL);
+			return NIX_ERR_TM_INVALID_NODE;
+		}
 		rc = roc_nix_sq_ena_dis(sq, true);
 		if (rc) {
 			plt_err("TM sw xon failed on SQ %u, rc=%d", node->id,
-- 
2.34.1

