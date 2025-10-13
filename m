Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7CCCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:01:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ECC240673;
	Mon, 13 Oct 2025 09:00:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6A5A24066E
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:00:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNh45L015038
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 3B8hgBbsrAqtsb6cBpjMwAmAVkcTEN6V+SvInejIIQ=; b=ZY8V790nj4qy5gex8
 twyOMxt8TG+qRe/wLNUPyxtGCFkXS0gE3VLWSSKjnF64h3fGJZBRGIsqP8x/atRU
 CDmIWyOZJqXQqGH1a4ZevPNQHHhNHt+yCjQGHJ0Zw/+wZGH4TsDQbswKZPuVsx6b
 QxuJLmItw2uk7upgDjufoojmGtAaYiDixjRH4f0+0stUPKi0iQ6hlu00dk30PRH/
 oc8YL9WYx5dxjd4ZevzUEQuhgtnOhH5oNdaGV/52OVG/4GDoaCj0CGkl3D+2vs64
 Ya0XfCm2IapqkzG5T2TMMm5CJhgYAX7A8ig2G1wvZTqCSCEQNtKZkqMNC/2UKDZl
 aYGlQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1s8mdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:35 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 66BB43F70CD;
 Mon, 13 Oct 2025 00:00:22 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 10/19] common/cnxk: feature fn to check 16B alignment
Date: Mon, 13 Oct 2025 12:29:40 +0530
Message-ID: <20251013065949.200414-10-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -M-YZGnwTKxDoIUl6ILfA2OoIXHEfMFz
X-Authority-Analysis: v=2.4 cv=ENQLElZC c=1 sm=1 tr=0 ts=68eca389 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=-bsIhdJEouxmazOkw5YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfX4tz4oWoWtJrc
 Q6byshC67Mz1nWuwVq6b980rMSRDZgJkRF9CEeEUpsdZ+rDwA/uuL2DvVhHt9mo617U1Xofd9kY
 Ske1ZEPKMdz/oy/9IGUxyYaU3sKuprETyzeRHUJI8igK5xsvmdOrihYgBIhDOgAeaKMj09lWapV
 4mYfUvQLQyhXotF2wWz5thpF8oh7SxThKJ+8BAr/4pgyr+inRwCi8wWArx0YunPoVHjQjox/adG
 e4VAGk1OVaVNqHkk3ajYQsY1PwaHV0EJaO3tqGkk6X4y6NewnGJyImAzpd5Pc/8clWOkkVmffZ8
 gLytYeyksySXyuazXQWTdGHbz54wR07C/0wEi6xXF79jIHwiBMQ5sPaoSpdBoVonK/P2U4y35Ci
 vcV6tGu2jpJb3JldcH49L4LMO9CEbw==
X-Proofpoint-GUID: -M-YZGnwTKxDoIUl6ILfA2OoIXHEfMFz
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

