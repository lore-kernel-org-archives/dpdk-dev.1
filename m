Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE66C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14587427B5;
	Wed, 18 Jun 2025 08:56:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id ECAD7427B5
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:56:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I2oigs026847;
 Tue, 17 Jun 2025 23:56:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=b06Bk6x8ZI4ISC8Y9
 KOfY4W3y3JdTlwCRB9cO+tIRcFpsuwj2iNtEgiqlle+jfSVZQtEGD45mIIdpIlrZ
 8Ldx0xDYkL2zDRqESTbncxJ6C1Kfbe7BNa6dBMUfwcbtHr3df3U7lh8WvICyfYsH
 a1TqXDxsD7q+DpktFu8he08nDWeJkk+9AQm1nvknWBkmYV9zn0EWacYjbLUYP19P
 foPaNRk9B8CFol0w4Np2EPJfIVTqnsZSG7acKhny/IKQ1F+kG8qvT4t5sU77L+K/
 VMU+8e3dYL0+HpovCnYjXpRjTcqJ2ba7mDcqDNS+Yk+KTOZ21e/FYhjQdn31Fr96
 vLn7A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xrq64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 23:56:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:56:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:56:26 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 262803F7043;
 Tue, 17 Jun 2025 23:56:23 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 1/6] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Wed, 18 Jun 2025 08:56:13 +0200
Message-ID: <20250618065618.4045910-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618065618.4045910-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=6852631b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OCBTYWx0ZWRfX6IDadWpHcQSS
 HhNov+gJHPsDMgynH5gyQFVwDJJZOeTa1a1EI+RnJ6+TiZwBWX4luUTmO7B2m7A26MqcG/mSJo8
 V6cerWp3oIFNaimkJ/TOq6tODcq15q0BxRTEvzjKwERVeKnAWNTeqDAggPLPzr+jvkTK5XsUG9B
 7YAl428C6Mf94MHk34oCqK8j+D0z6oSng0FExMAkzEb7lB7gCFrrCwrSqRlAa7Ca/VgyGbr9AxP
 6/dewro1UOBL87IDuyX+aPdHtLAi5zfcxzz6xPmaSP2zR5GIN2G4QKPvFSaxgD/4XsqgbCIgrGV
 T2JSzX3MZ+UDBYtO+3yXrobEdFqeGplfZHFk0vXCaozJMgs+QakB/WgRTT2Hsh/uu9uArY4ELxv
 l6McpNBiDIUiH5eMmWANIdxOLNey6MOs0pPTi7THTIVZi4Kr9FxKpKwAnqu0i6fSKsvVGay/
X-Proofpoint-GUID: tDZwK2saffZ4AzlMfE9azIRaolrxiBh9
X-Proofpoint-ORIG-GUID: tDZwK2saffZ4AzlMfE9azIRaolrxiBh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
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

Add a dummy rte_pmu_read() definition for chkincs when
ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
use of experimental APIs in tracepoints.

Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/rte_pmu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 57b634ecd8..84a5d522d1 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
 
 	return __rte_pmu_read_userpage(group->mmap_pages[index]);
 }
+/* quiesce warnings produced by chkincs */
+#ifndef ALLOW_EXPERIMENTAL_API
+#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
+#endif
 
 #ifdef __cplusplus
 }
-- 
2.34.1

