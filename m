Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3ABCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE37940658;
	Fri,  7 Nov 2025 11:48:07 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7B2C240656
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:06 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A785J7U3944138 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 QQ3CtvWB+ZwurKL7A8IEGCdLV3VLoPb+Sct/qmZd+A=; b=ALziGMmtlDw4kNvAU
 sXPqN1geVS8ju/8gCVFPg/Of0OlI7WohOAgLnMMuD6ZHm6P9IlVwzDI2wEcVA9mn
 GKdr6n7mnHomVxZPKmzVhSy7+g4ih8U2vGYUbonwE1xTnHdJQFnoe4/QR39vv0KL
 J4KxuSSf3XQtx6JkLcPeXqeeFM61FjVKrEmRSwJx7v8RheXQM/Bx9GuLQcha1Td3
 YhAKr6NPpmRaTcic+LdSZONchqifgEY6+9lcN1tSz1MLxJ1FAs4YLqrhsOnrzIVT
 31b8poZOb8m8IAnhHBdgSqwDuRQJe55DgASrBJLn75xTARuFcLMhwtwkCQetFl0U
 hnJbg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk65sma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:05 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:04 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 6975F3F70C7;
 Fri,  7 Nov 2025 02:48:02 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 04/23] net/cnxk: update scatter check as warning for SDP
Date: Fri, 7 Nov 2025 16:17:28 +0530
Message-ID: <20251107104747.1131008-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690dce65 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=GRh1LX0TW_9BVTnexCsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IagkIq7UZeOX-Qqh_IdoBDQaGwf1VmJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX0m/e+fuhpLxQ
 /aPr0ksAGaolroi8Uk+bwjYn7rM/Cn7rwwbtYrRHNv/Kk13r3IGv47Hh7EORvudlj+ZNx9CUBeB
 74C8XBzAwlcwuZGCAAmudqLUgIewnYpbqKQ7LHPCeEVA3KOqKiFlDjmSeTqguOimPU5QCZ/sgA2
 ueCXvLJyAIRLImOx7+aGoJAwLF7aGQmqXqdspg3Bh7gGs7yehs7AcWubThfCJ/KHR6MTUhFYJUF
 zHveTtb4btjTjRGnR8vR92yPuQJAoiXE4GWRWt2vbN1liBeCidKmeB9V77yFV9KteVlFMyDPmqZ
 KmhKjkIx6NommwREzYwdpSKV2rTBr56KIKJ5Jkx/2wqLRpSYC86n4qq3AbBzaPcMxTpTCcEO7uA
 X9URf8N3UpieM+GEmEI/QfpQtvJLtQ==
X-Proofpoint-ORIG-GUID: IagkIq7UZeOX-Qqh_IdoBDQaGwf1VmJB
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

Update scatter check as warning for SDP interfaces instead of error
to support cases where host application is already aware for the max
buf size.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 7a8ddb4c9b..49e77e49a6 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -613,8 +613,11 @@ cnxk_nix_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
 	 */
 	if (data->dev_started && frame_size > buffsz &&
 	    !(dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER)) {
-		plt_err("Scatter offload is not enabled for mtu");
-		goto exit;
+		if (!roc_nix_is_sdp(nix)) {
+			plt_err("Scatter offload is not enabled for mtu");
+			goto exit;
+		}
+		plt_warn("Scatter offload is not enabled for mtu on SDP interface");
 	}
 
 	/* Check <seg size> * <max_seg>  >= max_frame */
-- 
2.34.1

