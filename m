Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5281B40E17;
	Mon, 26 May 2025 19:00:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 88D3C4065D
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:59 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QEx0kh007178
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 /1VgeQFAEsPbIOEVDKv8dZEpT1PgxoSEfwEhnFvA2o=; b=JN6g/oIETPj1pNAVo
 MYmkE9MLxErNfsBzSkvI1pT0o03HfjQEBarnBd9R5gqRzT7KXJX6B6R7JbwGPjcn
 2mXCSNaD816KT5AtKqkJ9iNYwKC2xMekAyM9NgciPoql5aPVdGsQ4YPfSmJWnTwg
 UlzYsdhfEcEYYwA93gy82ho2m87BzEjNGeS/xbOtZx7JgIQ1zIaOLUlb1n3JC+s3
 AIG24nn/ZB6ICeD5lr6W7THsbB6irx8F6bEu1oModHsZNlGtSrSwqzUrT3zNNGsq
 WeR3e5p1hAHLwekoGeRT1on+/0u8yFiP9HKKcxp0t9Uuo98jOYdW28end5cCl706
 ienRA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vthfr711-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:57 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 0EF443F7048;
 Mon, 26 May 2025 09:59:54 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 29/40] crypto/cnxk: include required headers
Date: Mon, 26 May 2025 22:28:08 +0530
Message-ID: <20250526165819.2197892-30-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX8gHmIJwNggow
 9hEZUBLarA4eatDQ1ESsS5UUHSkO73USo4ne3QPWnDS3gkorF1e7Gyz3+dfFhQuT5l6+JW54YTx
 rsmXja+zCkRaYPrAnX1eGRjI4zBRPz1p9KG9HhBCP9n8AAeD5aCyISe8cb4yHoVVS19IEHaI5YD
 Jp1SwhrR1g+toupUqqvL2Yw3qLD+tBZ6TOoT8KVLARLkbYzCPK3ZTj62mTofQDNeAexXy5C0blB
 slTjvnV02adwwtxL3MoH33K8eY+5VTcY8aJ82VCpQQSY04JoWAB9DfU+RmdOaCG74ogvAASzSp9
 wSxGVvRsWQoXHrQjMlI0pj4AWLnjast/Rc2FZuhgez6VOR9qyFsFeolddtM3hs+LlXppAA2n1xk
 w66Rb18nh7bMXNlg6XF4wUGNIpDLnE45pc/Wmhcnorjdh/rATR+R+LnpHS4sK+tWP+rqkN20
X-Proofpoint-ORIG-GUID: RHBV0yRAG4PSw4n_UDJjWBcE9_fwAcgO
X-Proofpoint-GUID: RHBV0yRAG4PSw4n_UDJjWBcE9_fwAcgO
X-Authority-Analysis: v=2.4 cv=FfA3xI+6 c=1 sm=1 tr=0 ts=68349e0e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=olD1PbaJ0EHyQNdBE40A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

