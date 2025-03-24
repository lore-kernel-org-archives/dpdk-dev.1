Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA91C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 11:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2585B40655;
	Mon, 24 Mar 2025 12:10:42 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7A4E2402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 12:10:40 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9oY20008305
 for <dev@dpdk.org>; Mon, 24 Mar 2025 04:10:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rt7c8ImmBU4nNJttdtE+lLT
 r7feiwfHM/oho4fwRGvc=; b=kZWDGyE/MAYaACshG1s1p4+2R6TtgZ0fQdhal0b
 uGQpAou7zv2FDfExwvllD8YxaIJrIAfWS7hBkob8dbJi0VZSfXYy7BGI93XhSvki
 B8LL+Hk9NNPDYjRRtoDKjVXShWMY6XgpKGJvHIN/BVk4t7gb8NdaEELl+/K8psYL
 Nw6q0SUTXCmHpm3HGxQLkjt6jB+2CZUL2e0/ZXyJia5/XH1QDbGGDONCtYV1P0c+
 s7FRe3QivOZ4gIrdCC5BTXAdh8hnX4x0CvPQUHaZdnrRUgxPDvrcl9XWdCCcVY7f
 c5hOa+YcKo+M04iWF7F0v3lgQiuxNl45pdxMGAOAL+2OldA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45k548r3p5-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Mar 2025 04:10:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Mar 2025 04:10:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Mar 2025 04:10:37 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 740B765E6B1;
 Mon, 24 Mar 2025 04:10:35 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vattunuru@marvell.com>, <vvelumuri@marvell.com>
Subject: [PATCH v0 1/1] net/octeon_ep: fix buffer refill failure
Date: Mon, 24 Mar 2025 16:38:50 +0530
Message-ID: <20250324110850.92072-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=av6yCTZV c=1 sm=1 tr=0 ts=67e13daf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=tRCzY3Og-PgeT2zr7AQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Yx4nIt4sIScl8zJyWXq08FVO6RGrx0d8
X-Proofpoint-ORIG-GUID: Yx4nIt4sIScl8zJyWXq08FVO6RGrx0d8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Fix the buffer refill for SDP output queue
Fixes: ab09499e809c ("net/octeon_ep: add SSE Rx")

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Acked-by: Vamsi Krishna Attunuru <vattunuru@marvell.com>
---
 drivers/net/octeon_ep/cnxk_ep_rx.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.h b/drivers/net/octeon_ep/cnxk_ep_rx.h
index 83677e1c6f..5db32c4448 100644
--- a/drivers/net/octeon_ep/cnxk_ep_rx.h
+++ b/drivers/net/octeon_ep/cnxk_ep_rx.h
@@ -72,11 +72,10 @@ cnxk_ep_rx_refill(struct otx_ep_droq *droq)
 		desc_refilled = count;
 		count = droq->read_idx;
 		rc = cnxk_ep_rx_refill_mbuf(droq, count);
-		if (unlikely(rc)) {
+		if (unlikely(rc))
 			droq->stats.rx_alloc_failure++;
-			return;
-		}
-		desc_refilled += count;
+		else
+			desc_refilled += count;
 	}
 
 	/* Flush the droq descriptor data to memory to be sure
-- 
2.34.1

