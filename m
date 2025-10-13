Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CD5CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C46C40678;
	Mon, 13 Oct 2025 09:00:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0F8EC406BB;
 Mon, 13 Oct 2025 09:00:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CMlaqZ007000;
 Mon, 13 Oct 2025 00:00:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 nxMGWRp5RUNg0cJXcwtAnVQ8Z8g19VKQD/5zx7mx3s=; b=D0CGu1fPZB15Z7zGr
 HM2dpg7Q//YsStRsFtX2Asm8Eb3g2fGwxc49EY71lKEc7hvUGZDgvDjcoPNPXzLd
 rZffhWM8JrZQPqgX0S0F6NZBJhsgjADWCJpvWwo1HQglL6EZSg8Oygw0xG9m9+8c
 DkcHFU8rvKJJdL1v/C1QTh7hphV9Bj7VmQ5yCQ2zVFSb23rcjkH5y8vvf0hByn6I
 o6IBGjavEEKPmDxiVXGkuqE5LpCtcLSKGZbDNd/4SF/Xcjd9XYyspUCPH49VONtT
 3vHJmPE/hMKcPXkXR/tcWhCAJDHisZIKXmB+gBzYo8rQw85qpbi48swee2Z7X0vv
 RDpEQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49r8069ffh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 00:00:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:55 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id BD3293F70C0;
 Mon, 13 Oct 2025 00:00:40 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 16/19] common/cnxk: fix null SQ access
Date: Mon, 13 Oct 2025 12:29:46 +0530
Message-ID: <20251013065949.200414-16-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=68eca39c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=aJDCPxk_WUJAfcRIQEIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: ela-ZySYhauVjU5eiGZTFfAVngO4D3jc
X-Proofpoint-GUID: ela-ZySYhauVjU5eiGZTFfAVngO4D3jc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA0MCBTYWx0ZWRfX37VCB+bJem9G
 I2tmukojbAGqY1w4BvBt2tETyy7K5sGW5Zw7g/lyyazOW+pW7uVOmo/ub1LPfM0re97Ww14XE1U
 ylK3GN0IepoUWHLKxCsTKXIvv9AAgLjrcpNd0aVA6Y74Dj6CYMjrcClrVKoEW6+WbnIZxcYRarw
 HGj0lpS/3QBV6zNPFJ2dPM5QzOAJFumTLXXHiaas3x1kwO/rGrbytpS32NjpiRLNEuakMEXchcU
 ziKTViAIVgQtobMF/OrdcoNe+7vNkbgWRC8D3P2qH7WqqlxBk8Ruz2uccFGJaq9ZXBgxdA6MqVU
 RYDZdLQy7ITp/0XuC8+y8aQItNUm9/nbaqsZQA3oELWrPVKJF436smjBjZGsggh/fxfhezhq3tB
 M5ole/Of9jGgeaw39xMAEM1knEalxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

