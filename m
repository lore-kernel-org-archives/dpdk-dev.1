Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9820CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:32:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D89D40676;
	Mon,  1 Sep 2025 09:31:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CD79B40664
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:31:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815MNbX007703
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:31:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 3B8hgBbsrAqtsb6cBpjMwAmAVkcTEN6V+SvInejIIQ=; b=SIldvbin1EVFho3Em
 GB8uAUVS67FJYUR4d3YErvG0Mv8vbhua5Re03RcdQnEhYRGLzUUZ0t5loO3ZVWzD
 4dewgLxD7yWYqWh5Kq64Sh9TirINOap+J0UPlaDUh6MgL9TJcJyYpNFiYo8/ip7r
 BiIVvtZ5fdHLnuO95bH/hM1h0iYjEtcNbHfIVMnqYguzFk0AdBTU85GRZtuGEWdW
 J9GxWrqnpxIjNzdr2xME6njTlQgKRCIRmIPXL8cpa419ojMKO/foq+Fi96nR/arz
 UGco3Ti1tvcn++ghsHZ8eTaTgyZ/Ed/tcgn1Ehh8NB7jDtLh0+vaBi7Nx6THiVvw
 9e5KQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48vj28hdar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:31:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:31:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:31:53 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 8AD453F70AC;
 Mon,  1 Sep 2025 00:31:50 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH 10/19] common/cnxk: feature fn to check 16B alignment
Date: Mon, 1 Sep 2025 13:00:26 +0530
Message-ID: <20250901073036.1381560-10-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hOvGjEKHx-fzQQNjvfWd381a6U7NNG44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMxMDA3NyBTYWx0ZWRfX/pqruWToileZ
 263/Et+nKiWfY1D8LkU84SlvwXV+hm3sXRgCoGeyCH2jqQo69KAMI8W7crt/5G9s8dfU6R42sJx
 qtvKW6msjHRqlZDkHcOkVEIRVpjDSqbydgpHnSIEhAuo0e3bREN0n6JUlv/Tqk8Hr0HAIWy3R3x
 7K8G9R17dEQRySYI/r3WB8m2xiDmLe7Z9FlAPCieSHsP9yccoKUnAM/La7V98lmuS8UBXujYqnK
 b9xwJWf3+ekNQ8jO4cnZtNsjVTu27Dincst28UCpPra4SQEcowrPqUkCJ2+MFSxh4tV88hcT2FI
 bbyLL35SuN3VADUmRwk/ZDawR7ncwadyq2U3r7greP8eS2ihGjXm2xbVQSyWDgI8VMOgyruJkBq
 qsBY8COq
X-Authority-Analysis: v=2.4 cv=OZGYDgTY c=1 sm=1 tr=0 ts=68b54bea cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=-bsIhdJEouxmazOkw5YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: hOvGjEKHx-fzQQNjvfWd381a6U7NNG44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Added function to check whether board supports
16B alignment

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 62a1b9e0b2..0663aef4b0 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -126,4 +126,9 @@ roc_feature_nix_has_sq_cnt_update(void)
 	return roc_model_is_cn20k();
 }
 
+static inline bool
+roc_feature_nix_has_16b_align(void)
+{
+	return roc_model_is_cn20k();
+}
 #endif
-- 
2.34.1

