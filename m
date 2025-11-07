Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09317CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 359DA40A81;
	Fri,  7 Nov 2025 11:48:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E1B414067E;
 Fri,  7 Nov 2025 11:48:42 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A73TjPd1335071; Fri, 7 Nov 2025 02:48:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 nxMGWRp5RUNg0cJXcwtAnVQ8Z8g19VKQD/5zx7mx3s=; b=AJT7vtzCrfkGUubAN
 n+ouDb2Vf/p7ov0cQkcUdg60Rs6OdMgCRytKszP+3pUW+BwVpYslF6YAjpswmZms
 R0nRJmbD4pp1WeSyew18Ohkh7j3Q2OslixUDU+50UNQvQ5byCbFkQGbSGCsPdx5/
 2glDjfeICe3pazGuuYr+pJIsIZXj4yPuxrXFP8elkO5QCWmVq+stiAYcC6YDiI8p
 tyGOvk48+wZ2+tKv+Q3SPdy7IDs+YIfj2euYQoBfkOxiRxLgQm3+sAqFUoqZtVXj
 njLQ1r1576QbNCCeCihEz2JrVF8O25/PY3pw5S+fHubR7xeVKy5MshjNS0MzoDlL
 kCe6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a98wkh9sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 02:48:42 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:41 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id DA1C63F70C7;
 Fri,  7 Nov 2025 02:48:38 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v4 16/23] common/cnxk: fix null SQ access
Date: Fri, 7 Nov 2025 16:17:40 +0530
Message-ID: <20251107104747.1131008-16-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Kg6gWZhxR2Oa7VCio6cJU5TOsuqs5F_b
X-Proofpoint-GUID: Kg6gWZhxR2Oa7VCio6cJU5TOsuqs5F_b
X-Authority-Analysis: v=2.4 cv=WY8BqkhX c=1 sm=1 tr=0 ts=690dce8a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=aJDCPxk_WUJAfcRIQEIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX6Jbt8lV3iFj2
 58sbK1kZyQ+lVg6A+QFYy7voCbYBas4ySk3N5QyDKtd8AwEFq189g4YqcCAtR/XYmKXiv8Yi1m3
 KdWhvo0436GqAW/WaxMmoSOQtrEfLbgZLTZTnIg+O58bxpykSxgfGed1TZlfbqSY3nF7ZQR4/LR
 tKq9VxyqKUMlwuv79dciDTI6cA7PUCsxg+5fi1C4fYzvB4/obcW0saT8Zlah8ebj0UEcl/Pa0ub
 GQUg5Wpq5t9PqIFQYGrSZI3FCSZWPB8urpzK5CxVsHFBzrzAQPkAvyrKAW/fOrh24I0eBH/XXyX
 2cgVmfH8JcxCex0Y0LLEaqtoNWK3oqxgW61LW60MQO0VP2kkb7GjBV/qXrRwBx2ZfAKQII1kNdl
 E53zsMTVrzCZsgcfVQOLNf2WooLwJA==
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

Condition to check SQ is non NULL before access. Also pktio locks
are simplified while doing threshold_profile config.

Fixes: 90a903ffa6eb ("common/cnxk: split NIX TM hierarchy enable API")
Cc: stable@dpdk.org

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

