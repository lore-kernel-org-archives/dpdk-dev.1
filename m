Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F906CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3BCD40653;
	Thu, 23 Oct 2025 19:27:43 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA6540144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:42 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3hW9S029627
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 HgP1NRBUP0DYBxFpnzwg9DQn9VKoQRox+8yQ4EEl/8=; b=PdrzB0J0kN2aYJj0/
 SfcpxgncxAII0Lh8HASr8gMTQ6emFHB6tcTLE/UibbyBpzzvFpihjDKeTX5ElgxF
 yOziMJh4OCQe6R5vUY7lqYuiDxcZGKu7JStpb8WEdhGNdAIoF7+yoB2stLXK5z+7
 YgoK46xE8PCYk0/Waz08Ea8vIoMtHigLRmNmo9dANGBhbLdnNw2cym9mukc8Cq3i
 DC1sHqPMdLt/CJLimegvYE73uwluxwDT3TisTIbHwlVjT/PcCqfvfmAhYF9Gm4Ag
 ewpVRKPNJAM1QXM3Y6RFv5px82qtML8tkBQVnxH6swVGmWv4FE3ARAq6NfG0wk3r
 WnzNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycq49v5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:39 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id D9A2C3F7068;
 Thu, 23 Oct 2025 10:27:37 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 03/19] net/cnxk: disable CQ when SQ stopped
Date: Thu, 23 Oct 2025 22:57:11 +0530
Message-ID: <20251023172728.770661-3-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMSBTYWx0ZWRfX0IKiD+eq0VOG
 fm207DD9/8IDIXu7aacdrRyJGNyadHCHdYE8u+e8txQzrZO2mZSEoGd+6oaZ5FM70MZ3lCV5WRS
 gBKS5cRRDyqOSdeVCHjL2pJWQkAmAZxI4RGPhRHx+xe5eUUUnLIYcfdzqFq9Whbd6w/sR27Q5yt
 csgOEf2bJ0sJ56V3ZtIvfjg3ObPysJ2qFiYs2ArOCxQpKdBbrFqwKcS3/dSifZCchZ8p1mKEY+Z
 O09Lj+utw/hZhQQ5/NG7H2C2+PHgPsh198o7bfHcdU9NYQjXOFg27XCl5o7iJjx08AmOJkn+jG8
 IKB09PYD3bhGDa+gdj34JZnzF/wr1lEgXj15zeHh2JHA5KoBdy7FtnPb7AkXi/u+oaCVdUFOaq+
 d7awPrH54LASeaRqWuSzJZlefGB8TA==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68fa658d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=j0D0reGXZnfTH6MTHhMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2rMLD1NG_NmQWkfROs-vGnnYa95AeN-Q
X-Proofpoint-ORIG-GUID: 2rMLD1NG_NmQWkfROs-vGnnYa95AeN-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

Drain all CQ buffers and close CQ when SQ enabled completion is about to
stop.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cn10k_ethdev.c | 16 ++++++++--------
 drivers/net/cnxk/cn20k_ethdev.c | 11 ++++++-----
 drivers/net/cnxk/cnxk_ethdev.c  | 11 ++++++++++-
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index 9c1621dbfa..23a2341c8b 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -198,21 +198,21 @@ cn10k_nix_tx_compl_setup(struct cnxk_eth_dev *dev,
 static void
 cn10k_nix_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
 {
+	struct cn10k_eth_txq *txq = eth_dev->data->tx_queues[qid];
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
-	struct cn10k_eth_txq *txq;
 
-	cnxk_nix_tx_queue_release(eth_dev, qid);
-	txq = eth_dev->data->tx_queues[qid];
-
-	if (nix->tx_compl_ena)
+	if (nix->tx_compl_ena) {
+		/* First process all CQ entries */
+		handle_tx_completion_pkts(txq, 0);
 		plt_free(txq->tx_compl.ptr);
+	}
+	cnxk_nix_tx_queue_release(eth_dev, qid);
 }
 
 static int
-cn10k_nix_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
-			 uint16_t nb_desc, unsigned int socket,
-			 const struct rte_eth_txconf *tx_conf)
+cn10k_nix_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid, uint16_t nb_desc,
+			 unsigned int socket, const struct rte_eth_txconf *tx_conf)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 376e334588..a7ef1dd386 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -192,15 +192,16 @@ cn20k_nix_tx_compl_setup(struct cnxk_eth_dev *dev, struct cn20k_eth_txq *txq, st
 static void
 cn20k_nix_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
 {
+	struct cn20k_eth_txq *txq = eth_dev->data->tx_queues[qid];
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
-	struct cn20k_eth_txq *txq;
 
-	cnxk_nix_tx_queue_release(eth_dev, qid);
-	txq = eth_dev->data->tx_queues[qid];
-
-	if (nix->tx_compl_ena)
+	if (nix->tx_compl_ena) {
+		/* First process all CQ entries */
+		handle_tx_completion_pkts(txq, 0);
 		plt_free(txq->tx_compl.ptr);
+	}
+	cnxk_nix_tx_queue_release(eth_dev, qid);
 }
 
 static int
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index bfef06ae4a..4550fca3b5 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -570,6 +570,7 @@ cnxk_nix_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
 	struct cnxk_eth_txq_sp *txq_sp;
 	struct cnxk_eth_dev *dev;
 	struct roc_nix_sq *sq;
+	struct roc_nix_cq *cq;
 	int rc;
 
 	if (!txq)
@@ -578,11 +579,19 @@ cnxk_nix_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
 	txq_sp = cnxk_eth_txq_to_sp(txq);
 
 	dev = txq_sp->dev;
+	sq = &dev->sqs[qid];
 
 	plt_nix_dbg("Releasing txq %u", qid);
 
+	if (dev->nix.tx_compl_ena) {
+		/* Cleanup ROC CQ */
+		cq = &dev->cqs[sq->cqid];
+		rc = roc_nix_cq_fini(cq);
+		if (rc)
+			plt_err("Failed to cleanup cq, rc=%d", rc);
+	}
+
 	/* Cleanup ROC SQ */
-	sq = &dev->sqs[qid];
 	rc = roc_nix_sq_fini(sq);
 	if (rc)
 		plt_err("Failed to cleanup sq, rc=%d", rc);
-- 
2.34.1

