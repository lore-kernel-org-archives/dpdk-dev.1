Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D6CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B17504042C;
	Mon, 13 Oct 2025 09:00:04 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D4576402C5
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:00:02 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNSNg6000545
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 bclCcxYad4T/Irwi8e2xb93JNizHtZORI6YgmvCTAw=; b=eoapi81XipMGKIuiT
 jUzpenRxblZGdJarbmTyZl0yiv3IncexBF6/o1jopRQPIXJwODMRen90gevAlFvF
 n1LA+9JWXWLIPeCf2WEHBq3fQEBxQcPjZwiuqc1vV7pQKBHd73HEU+JP+XdRJ5gP
 flNv0/WcPYiWU1hDhJe/v9r2KDln8fv5WKXWjpwMCAIwwGa0i2fSNnDXFgLNlyV6
 0NZWsWDadg7ws1Pcyo+gnKGqbuWAJYyq94qqzc4wn8EfUZY6DpxqW+pxYHrJOF/S
 2G3YgjVYpK/qJGn0Vzudy+8UWK8w66LB6va+lD4gFlN2s518Sve0Ln52fb4j5UyI
 j5ShA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1jrmd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:12 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0A5A03F7072;
 Sun, 12 Oct 2025 23:59:57 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 02/19] net/cnxk: new tree for SDP interface
Date: Mon, 13 Oct 2025 12:29:32 +0530
Message-ID: <20251013065949.200414-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7jOqV-fHi00zUTCOTWem2HtHTtVlkZkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfX3/LluVXEbpO4
 km6jWjtmwwjE6N1IfobndaHiAmAVsw4HXqdeyuCG2AUzEYVUJw1LmkYdv0cAvn2NoUGJYR5zMmA
 CYgfKEL70OMqX0/ZF95ovqWCFpP4J0F5gf4sk9SjGNNx5O3x7/AMo9SCktOx2i8NdfvQI/Dfg1c
 gaeQOvvpwp1RWRfRNhLaNr689VcrusweRGZUJ1jCVMHuYSOixNtdHBVnSBcEwWDPTszqjxOfPvj
 SO/MdXbNYAxu56WgmA4SFke5j57hPLNX5dCHgT4yEpWH/XjBT23rBWygBMEdYM8IdLwNpU7bEAK
 SmdqlAtFl2RiAoKiN6s4kB7qh3RDDD68miFWjadSytnkk3txfSTgsClmfeOd98q/PJ8RUopdXB5
 WnHSFYAsbEcRQCezrUNk++StXXA6pQ==
X-Authority-Analysis: v=2.4 cv=Utdu9uwB c=1 sm=1 tr=0 ts=68eca372 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=pDSVT7ON_-t1wQNCaMkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 7jOqV-fHi00zUTCOTWem2HtHTtVlkZkU
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

Create a new default tree for the SDP interface if more than one TX
queue is requested. This helps to backpressure each queue independently
when they are created with separate channels.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 6c723c9cec..bfef06ae4a 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1451,7 +1451,10 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		goto free_nix_lf;
 	}
 
-	rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
+	if (roc_nix_is_sdp(&dev->nix) && nb_txq > 1)
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_SDP, false);
+	else
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
 	if (rc) {
 		plt_err("Failed to enable default tm hierarchy, rc=%d", rc);
 		goto tm_fini;
-- 
2.34.1

