Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F2CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D84D40653;
	Thu, 23 Oct 2025 19:28:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0608B40653
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:28:02 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3clvg021888
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 3B8hgBbsrAqtsb6cBpjMwAmAVkcTEN6V+SvInejIIQ=; b=I1mI+gTQyABgATYRD
 0IIlbqq60knYjtRYwb7X4VNUcWZO9wSoLJtpnyVI+jJDhveDkfpdDyhkCR9qGneh
 g6cC6NkoEe8tn0u6bNIn+HpeuNHQQr2pKWkzTqssx/OCJjSlVe5EazfJBGdZn39b
 TTJgocV3c+70IrPzy+zqn+BkbDVmeKe1lMC/8UYWfgOe8UBU2b6rg8WugenP/xYU
 h9vcka6EfIYncj3hQIXMhyVXAjuuwkqEUb/HDa/Euczv2EDPdYXf4jEX855uXIgU
 NTlS+0jGeBd19zHj/yNw9NGAhV4T5U9FUAaUrpkWeS2TJ8stgIcvDc3bMsR1vecb
 2cxOw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:10 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id EC46C3F7068;
 Thu, 23 Oct 2025 10:27:58 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 10/19] common/cnxk: feature fn to check 16B alignment
Date: Thu, 23 Oct 2025 22:57:18 +0530
Message-ID: <20251023172728.770661-10-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3LUconeHBTgZzut285_XO0FUjrTEy4xD
X-Proofpoint-GUID: 3LUconeHBTgZzut285_XO0FUjrTEy4xD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX/K+vOI2WVJLl
 SfTEnhPrRMEHDi0MtBj/krBZvHX8rVr5UeJqLQHIFZfGK7QrQmNUwfo7dIOl5/9U4VgvRP3Ex2N
 Djm7Zm2dSwNCS3I09AJnunDPpf3syEHDT8vC3XtutFSeG6gE+0HR1VeWGl15Elnm6e9R9HpbVQY
 YqA+9x73bhGWJNue/8an0Q8QYkiqeDF+AhEygf4MWLxuqZ9Yv17HBLq6vz96Nve9UjoMcsENKyB
 7KT1565WlruPH0qhnMCqmZOu/7U7mXs/S3FqwPd/ebLOsaYx4k9lMlu2YxTaTELPAN2aM53w1SC
 NR6MTSuL17Bp83d5IGpl6ZLPTy6O9+vBqY4Qi9xvCVNgE+yYfuFx5Gi1cDvVTDdXrFsKNMEarJ3
 h8mZQM3AeBiwOH9+7OMoiUf93iKjOA==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa65a2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=-bsIhdJEouxmazOkw5YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

