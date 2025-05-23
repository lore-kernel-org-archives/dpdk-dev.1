Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1CC54ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 15:55:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4376940DD6;
	Fri, 23 May 2025 17:54:53 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5848A40DDE
 for <dev@dpdk.org>; Fri, 23 May 2025 17:54:49 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9k4H030039
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 NhnuEunx4ONFcdH6/rC0vyzIKKx0UeHn69z6wLjCqc=; b=GPvfGkvjEpVbgTvyA
 MlLBCglku6chK+6hOpP/yO4/s5r6Db4MBeIeL/zx2/4csiE/jJJpaiY72SRTumzI
 5z/4S3t9Qe3DSRon2HARq4PK56hTxyJa5BjlwqEgt0VWDifjnlDgJironajcr2+A
 zwPGV5Am/lpomICsb/E8baZn5HZruA+9gc/+aC/1/W54cDjmEeJsIWxKUPapymb3
 HnjDaRFBk7aGoGk3oNjhd+TrpeKsiNzesPdFL9Ne7t7a1tFVgSj4SJgzNmSS9Ib2
 e08nFUZGhDhFs5fhUfPEF6EAhhHLUyqCwQqNcV8arxPmD+Q1JcVh2jKA/a2KgUpB
 l0O4A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw58hkw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 08:54:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 08:54:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 08:54:41 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 39B8B3F7078;
 Fri, 23 May 2025 08:54:37 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 5/6] net/cnxk: update frag offset calculation
Date: Fri, 23 May 2025 21:23:46 +0530
Message-ID: <20250523155347.1156891-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523155347.1156891-1-rbhansali@marvell.com>
References: <20250519125424.1435140-1-rbhansali@marvell.com>
 <20250523155347.1156891-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68309a48 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=v69dt79VaSGfBV6H58AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NCBTYWx0ZWRfX+Ri9VOY/FmV9
 txwu2ePPD6JfX0/RsqS70mFDfme8cgm/59HOOirsWT8GPJFrKPBFsfaz7i9lg5+X6vsBa0VkonX
 /QVOC22kfPsyYOP1PVoqJcIfuRZClKBqyM4d5wU+OoJoRJ0BTCk+JXP81rKYOYvZVEYIjH1eAZ4
 9D7kjztdfXcP0vSSl1Qxlxk0wL5MxJYF6xWThE+4dsT0K1u7TyuEgCDWm2WbHSyOmYyhcugLePm
 jg68e1ix16KIbHxA8Riaz7Dqr32ez7AHBobc2NO25HHMIl5pe1GOZtmTd4Fnp9E/2xRb1Db5t2b
 aafYDnbm5FIA1P3rPp/+RNXYtBs4nCXWeXFmKZIIH3lO8KjusTcP50oLykf8Ge4ff4W5LwDA1iw
 KArFqpPKkrcwFggkf58q7xmXBe05SmyFFS5Qw1WuCN5dL0K+4P/e3fhqFCghtBW3F4AxcRa4
X-Proofpoint-GUID: qtTSFsmod2sbekfgCJzHG_utgz_VkzJB
X-Proofpoint-ORIG-GUID: qtTSFsmod2sbekfgCJzHG_utgz_VkzJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
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
Changes in v2: No change.

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

