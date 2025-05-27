Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1FC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 271B94066A;
	Tue, 27 May 2025 15:01:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E5A3640664
 for <dev@dpdk.org>; Tue, 27 May 2025 15:01:43 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6sfah018502
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 /1VgeQFAEsPbIOEVDKv8dZEpT1PgxoSEfwEhnFvA2o=; b=fDuT+bwBPP/KeoCwB
 X2i9/mnHOlf0XW4GspFHwvI1BGSW0ay63YGWjoVOSdE60KavSQ3bxAfMggjyg3Pd
 QgudKOjERS1WrVLK5huvDOsTxtv8ZtMqZz8BaQSbJRn4k5gCYBro4RqoR3e4SH2/
 /0UE5wRHievXhwejxJULRnWnn8I05LgPhC2xcEsHsbja0X1Iwp0O1lQY/77PzMUL
 U//q8ucbK5AHBk31F3EEOnT0RdrV1y+AnbDCZRrYlGUn5QRMcje/Z+GPnuKTYu8y
 NNrps+uR6NMtZSAcVnZ/8r+1OIniovVhM4B03gquQq6bXaC18ZTnIXKkeT6/gAnI
 /pTvA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8hq8kw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:01:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:01:41 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 307673F705D;
 Tue, 27 May 2025 06:01:38 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 1/9] crypto/cnxk: include required headers
Date: Tue, 27 May 2025 18:31:27 +0530
Message-ID: <20250527130135.2301726-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfX9SnYdOX9PuBu
 JEYLzFCHexSeXjay3p8bENHzNaXfZNK3qH8aE5o2o6bLeKAWMMOM//rSbWI13bwLZcAnxsCGkZf
 BJ82ws8M09wRNf6iFayeYtslUXYeWBnGSdP7QOoZkPPpDfUJ/Y7blJgQXpatLCWzqHIdzYr4wDN
 tcKdS1ZgjI611Ui8T/kZgNjhVr76tBdTOKsiM8LvIPlGsBEjY40HE54BxqzLB47537sgGmZ2p8C
 bRB+7BrjWEq2ZZOc6kQZw9JM8hO97Gv7g9Na9BEYgtYsO2D3QiGNXZ/5nj4Rw1Dy55YttikzUy7
 uzeTPNlfJsptUWxmDaF7AOixQJ3wMcfj+vqVuSMYbkETizV2Rq/zGP4WFqs99rk7fA5We2mKlrL
 rx97juNNCLR6ms1n3WMolTAVh9xfhY3NkxN0hTl2yHWefPFD0VMv/dnPtsfgCOwUuzp0NYr+
X-Authority-Analysis: v=2.4 cv=D89HKuRj c=1 sm=1 tr=0 ts=6835b7b6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=olD1PbaJ0EHyQNdBE40A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: KkwA0YsIonUZ_avVBWES3Er8Nd4wAnBg
X-Proofpoint-ORIG-GUID: KkwA0YsIonUZ_avVBWES3Er8Nd4wAnBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

Including required headers.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
index 02278605a2..46861ab2cf 100644
--- a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
+++ b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
@@ -13,6 +13,9 @@
 
 #include <stdint.h>
 
+#include <rte_crypto.h>
+#include <rte_security.h>
+
 /* Forward declarations */
 
 /**
-- 
2.25.1

