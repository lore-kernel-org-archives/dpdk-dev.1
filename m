Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BAFC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 12:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0053C40654;
	Mon, 19 May 2025 14:55:05 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F0B8E40276
 for <dev@dpdk.org>; Mon, 19 May 2025 14:55:04 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J5cHJd022417
 for <dev@dpdk.org>; Mon, 19 May 2025 05:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 9zvc6a29ePXC8Aeq3o3IWIAhfWy9UsZ3JCzHBQd+5w=; b=OMcjk55iddfFac1s3
 LKwQQI58oeB1Pc11NBKOMrL5UJ1lhRKJx1y1wW0nRbyo2+0zT4L6UI06Jotpmbrp
 cHUsuZ4l0ZaqNW1IuxMmI1DNVlTBoTa6dcgwhGf53qUWgn+QYs7PmWuOlbILih5r
 wODxk1uCt8slFPybGwM3DPrM3krQ71QH3AEGZXcWwDnL60hfPHIh6JoPl4lU6kKO
 MZ+4AMSFYyhGceZ8IBfS4Rodebjso75g5mvMrqb9j0YjJfsFTvEDitSY3rb8iXDT
 GPmhUts/JK8UXmuNoYTY8uaTV6SbgiklYRbuZ/jYHXRPXydsIQYwN6t1jib1jeaY
 Emxsw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46qxnprsya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 May 2025 05:55:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 05:55:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 05:55:02 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 203753F7055;
 Mon, 19 May 2025 05:54:59 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 5/6] net/cnxk: update frag offset calculation
Date: Mon, 19 May 2025 18:24:23 +0530
Message-ID: <20250519125424.1435140-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519125424.1435140-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mrKpJ7eVAajC7yYIeBidYSv8etTVRC97
X-Proofpoint-GUID: mrKpJ7eVAajC7yYIeBidYSv8etTVRC97
X-Authority-Analysis: v=2.4 cv=Z7fsHGRA c=1 sm=1 tr=0 ts=682b2a27 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=XyxXChsBumu1WMGwIQ0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyMCBTYWx0ZWRfX9YUO/utKl3iK
 UNiezu7kYWrsG5qojbMKBPQJqtfdwF3W9md6xbQVaZRqFXR6vGt4rqxNYM7EMSuid3ILR1CCigC
 QcJEEm5RZKwG39g7X0lAosIvAtgPJL53k1e5VnOgO7PRT0UxpYitfXM6iqixJqs1dCT2EYkmJwO
 LhMCZ2qBBA9kRnsahLLnxgwYKyqD3nj3kWIuw9x8KLvT91aj9Xc6AmlFvED+th3E/6p5bk86zaz
 C6O1wuiqNgy0RNoIdvaI6pnh3sS3LdvAJ0tzCA1zma8Ylkxdqxd6ETeRt3H6L5k9+4vnYM80+GH
 w/1wDiH4gGXrYlQAa53GGomIO59NkzSOyhji0bgIFwH7c3kdZCy5sbxQ7wnrEHugE/s9UmRWNMW
 8MSGIQT/eno0ZIj0tBujbDHNmTL2ltvQAUsq36WEIyONJ3obaQ62cTfU3QakLWq1QToM80pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
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

Update frag offset calculation based on CSR change.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_rx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index 09042e384d..5682631815 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -337,7 +337,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		cq_w5 = *((const uint64_t *)rx + 4);
 		len = rlen + ((cq_w5 >> 16) & 0xFF) - (cq_w5 & 0xFF);
 		num_frags = hdr->w0.num_frags;
-		sg_base = cpth + (offset ? (offset << 3) : 256);
+		sg_base = cpth + (offset ? (offset << 5) : 256);
 		finfo = (const struct cpt_frag_info_s *)sg_base;
 		sg_base += num_frags ? (num_frags > 4 ? 32 : 16) : 0;
 		sg = *(uint64_t *)sg_base;
-- 
2.25.1

