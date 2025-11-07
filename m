Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F2CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A07374066D;
	Fri,  7 Nov 2025 11:48:09 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6E5AB4066A
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:08 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A73TxNX1335487 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 HgP1NRBUP0DYBxFpnzwg9DQn9VKoQRox+8yQ4EEl/8=; b=TzuVwzPCEOj7vAjsn
 byABeWdraFlRQzDMXTjSLTpMzaEkA0wmqBCH31ejnKWYU0c3IFC6CsuCNBIMGLGt
 r25isePjjOJi3oFzCqpV7ax4lWx6AJ+Ca1RQL8dBDc4+YrDlwWfVs/GE5DeGoKoE
 /4OYLySK+KdOj1MS9KntO6GMvVutQmTVAnth6eJf8zqNbzkdaIvJY4207JMZ7JTx
 4gzQKEMMJF+cviieE8lDSF/S6gmPf1ofRfbE4u6C6E1Kb4iBB3s4ASsQa4PBJwUT
 dAjH5x0HJtdLdiy8/co1HUq8gdjzH0nalZQaU9UF7tHSxtcx5QypSYlXe9i/kDnv
 toVcg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a98wkh9fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:07 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:18 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 818EA3F70C9;
 Fri,  7 Nov 2025 02:47:59 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 03/23] net/cnxk: disable CQ when SQ stopped
Date: Fri, 7 Nov 2025 16:17:27 +0530
Message-ID: <20251107104747.1131008-3-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CLwZJvKCKFsv0lQVyJc07X-2aDGfYp6o
X-Proofpoint-GUID: CLwZJvKCKFsv0lQVyJc07X-2aDGfYp6o
X-Authority-Analysis: v=2.4 cv=WY8BqkhX c=1 sm=1 tr=0 ts=690dce67 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=j0D0reGXZnfTH6MTHhMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX5WB9tjx5xqEV
 NDJqpQpqqTDXaU2dW3c+vCMDiMHVgR3suQcAw4o143TtUQxPrGedWT9dOkaIrMRsNFJlh6+Surv
 buJt/c9Z2tMhWx2W7nNyGDiVI4k8l0YVNAILH5r62jGNdp2MljT84FBasMpMEhezlQTQuOfSVpy
 TBBeIpcki+iQ72qtt9GJuhucCUCAXgdFR52/YDBGCmF3BTePzE+MI4MhQ9m9w2GRZsrTWKkU0Wz
 USd3PVBNDilDlCAb1SvzaKXeevZJv+SdONMuzaC0HyFg4zuB0K8kqDHAA5vnlpMjgpo8lB4Kvxy
 jr9Gy3APvNjIFy1Y3A8AFpJsX/Ka3j5ETkNlzHYIWXjfQiBDooAnyqschVX3icGV/YY+iFAoEBQ
 Q5+ZTftEQUKxsLucoWw6Bcum/t8v4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

