Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF35CCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C35ED40E1D;
	Thu, 13 Nov 2025 05:38:33 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 452A140E1D
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:38:32 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMsOKR1058934 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 sFjx1lQzLXn6/szIHXp8r/DBkBzdZEGsttF9qE62Mc=; b=ClLrKJTDy+F6kCwdU
 vJd61WuQcvRgi75ipnUOrW/qxU4YIa1tBjDYBMkYgcU7omrgWRw0lJ7BiBWfS9K4
 CRC4XM5tTyOdA4UGC2uVv24hHrUtAnymIcz6Um0aQqCCIvy24Km2DY3fXsIhCS4G
 s0L1QDreDHwbbQvxrSruIuV4J5bYi9efI9oePlFgxCabwrY+E5dqSLGdAy79wCSJ
 gEYHHnT+vbczyRzx4EBSy73irLLPr59DSW5Ua/nafd/1nXNugfdIOA8kCVOBd32G
 OVe68d3kvH4HxSiRPqrIcwmmruW5zE4WXL+BxShR2W/Jjt4PScOZRGCMk9vieiVA
 lyiSg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aa32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:31 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:38:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:38:30 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 7A8113F7076;
 Wed, 12 Nov 2025 20:38:23 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v5 03/23] net/cnxk: disable CQ when SQ stopped
Date: Thu, 13 Nov 2025 10:07:48 +0530
Message-ID: <20251113043808.1180851-3-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=691560c7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=j0D0reGXZnfTH6MTHhMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Vl7A6x0JPX2GXdTK4jzY_eV3owQrh7oj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX9p4nPq67H8M0
 eHumCUcB8qjyKjARzY1x4S0z+XX0DQhMPUI4I3wXGXiSLOgdSsMvP4vPYuaHKQH4tgtJdQ2/4NW
 hXg4JFCNmvBwSaCdZ53NC1tVf5laWt9eQTpS4QRIwmaxF8fsFFPYDF51mXj5zqlIVvAS95UuTfH
 1GjwEI5lbZSpS2JYDyhR774EltuSplWR8eGWsBxmnA7nH/fgc4S0tLqZ8QWaaJnOYx64eJfNNLO
 +lp+Hgio3saA/4JHuSMsajjpV/qgUgPmDuLVNq143c2cB/12J7uTsZ2daLk4JyqusYZ2SZAKWSD
 gKF4pTsImZ24lO3mrssa5yOjKDAgQ5/jSQsyu+UGWubEYh6VBRSWXcnQxEqvGyBXEOoWSBb5azu
 ZyUPUKzcf/1zt1DUmll5IhytKvPAYQ==
X-Proofpoint-ORIG-GUID: Vl7A6x0JPX2GXdTK4jzY_eV3owQrh7oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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
index 69830a1280..ff78622b58 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -658,6 +658,7 @@ cnxk_nix_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
 	struct cnxk_eth_txq_sp *txq_sp;
 	struct cnxk_eth_dev *dev;
 	struct roc_nix_sq *sq;
+	struct roc_nix_cq *cq;
 	int rc;
 
 	if (!txq)
@@ -666,11 +667,19 @@ cnxk_nix_tx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
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

