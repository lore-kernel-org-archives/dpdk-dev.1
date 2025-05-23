Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ECEC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 250E740ED0;
	Fri, 23 May 2025 15:52:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CB72440E1C
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NDibN3008886
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 /1VgeQFAEsPbIOEVDKv8dZEpT1PgxoSEfwEhnFvA2o=; b=L1oGUyCUUhRAiwkGa
 LgurWLlpk+bMnElDyNP6n8hnbv05/erpS7dinr76LtZhzngCMZ+gW8AVwrdAkvyE
 Q5MuC+NIA7OXnhVMJ2GBFNiuMBZy4o6asPUj3gaNleNbRh7Jxv05NRU15/Iz2KqM
 YKlN8f2c3ounKoRhP1SHfu5yAKfnUSH0d6qs7P89HQvy32rVJbJn2IBKupZdwjOi
 rbSr1CG2RmELeG2yHwKebSvDzaSZhnDTrDyq72mDnTwcF2qJPV8Vow0UbFynwF+J
 jt6MfAoVL0H6jKnajbkAJm7wldfAS+Ssd1oKvlwlPgJJpfw7E9SvzNHdNZgHaOdF
 w0NpQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tt5w00gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:49 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 088483F704F;
 Fri, 23 May 2025 06:52:46 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 29/40] crypto/cnxk: include required headers
Date: Fri, 23 May 2025 19:21:00 +0530
Message-ID: <20250523135111.2178408-30-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bYBrUPPB c=1 sm=1 tr=0 ts=68307db3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=olD1PbaJ0EHyQNdBE40A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4pmAhUx2Av_MpfyPZcp7thbTS5dw9U7R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX62Ne1rGjJTA6
 eowyGsqXkFTUOLdb3JGFq7kRAD783gqIhyQH20j9U9ZOMsaMuie7QGtkNIVRXsn/fC3ekCACdAj
 8cgf8yesMVC/xkoUPRPXvyq1WANRqEO5AuXbQilM3W3ysHgjTIa480ae3I6DWEGj4dzKfkI5KkG
 TB7Q5HZljv+QCnGfL11CnA7KnXel3EuWXpQy3AFpIl/M5CiR+FhzdCCqoOvg+u2lp0JyJmD2mSA
 /cJ3htbgZWEkVvL2R0Ejz8Zx2rgpaRJWdWPF6ceRYU9dcf7Anve8x5SByBLXaVYtyRxAOrkR8SZ
 kvTKkci1sswT1RQjPz/532EpQjsekWOpZqnjusmWoQ2jJpVkBSmn7CMjXQ+fYRQIjxXlqeSHP9j
 P8y7aXGSDgNEoHsZtygu6HxPnBwKlATA9xgS3HJRVFIygBL/xARo38HVcNqAvEt9d6/mHwwU
X-Proofpoint-GUID: 4pmAhUx2Av_MpfyPZcp7thbTS5dw9U7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

