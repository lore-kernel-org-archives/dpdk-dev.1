Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A857C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54ED940B8C;
	Wed, 25 Jun 2025 06:47:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5A00E406B6
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:40 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OLLFIg032236;
 Tue, 24 Jun 2025 21:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=F/Tp0ihI4f64Q37W1
 HontGlHO7QZszzuWvyeJMSI5QZbYO8+BCupOGhCM+q6E7E4zZcAUi2bM9hsQ63kw
 BhyO6PKeOVArqvSGxu79IeMuWteHZn5y1OBbeBBhoWlBfuBDKW3uqJ8kWUeZWWDl
 h+Q7Ltp3ML0M9Iuy6Nh7E+Wu1SFEnPgj1nl4pDLKzJ+7Inp11pu92HiGCys9czoE
 p+++V6FEHJ3bQhRMlQ5VzGnQBPXUkCW55A76Y/s8ldyLCVAkfO0A8N1vYsA4X8xc
 7/rRyK4lKomjsm8BDjaXFlqp+poly8Y5padwIqB6nJlVqTOKo/fZU1QjPqpgcIVq
 Cd2iA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47g3ungrga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:38 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 9BB5B3F705C;
 Tue, 24 Jun 2025 21:47:35 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 1/8] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Wed, 25 Jun 2025 06:47:23 +0200
Message-ID: <20250625044730.2435526-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=efU9f6EH c=1 sm=1 tr=0 ts=685b7f6b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 25qNXe4a6nY8RL_odzTFWK1A0K2nt440
X-Proofpoint-GUID: 25qNXe4a6nY8RL_odzTFWK1A0K2nt440
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfX/gtkdKVXsKvF
 5hKQybG6PSBWgVHvYmBLR+gl/53+1pXXYNp1Z/DHgs3LlaD0LdI52+hB311TsEP6XP8umKtJFiA
 FVecwkfzIXitecD9MYg0JOmKW+xKQkSSM1HN1t/L3clS52MHiOkzXQuvtRSP8nctAsAGalFM+rH
 9quK58RjwvLkNpdfcUX7BBoI3CIMgX45j09slAcn3iW0riFB7AaOX2nm3dw1HWQO0nKq/57cPuf
 JgIRGTiBmC2wAeOQgs9kz7gDPUSLX1FV3AamKHUcLCRnWHUj0gYwWT2H/uXYLJ+UrTRzgq6ezwz
 FEfjsyCsqHdmWBkuqExa5v/KPLD0BIqCuzFYoF6e8zpgRjo1KSpb1joz1/oktk6qZMSspodWHP6
 GL4M7efRmpgVpnHNOQuNAMM58cmzsuiarqssz/0OFkcjtCMnbeFXEZvrHFGVJCwKVuE10W7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
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

