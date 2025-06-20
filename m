Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FAC71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC3242EEA;
	Fri, 20 Jun 2025 14:06:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5E66D402F2
 for <dev@dpdk.org>; Fri, 20 Jun 2025 14:06:02 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3ThpB015646;
 Fri, 20 Jun 2025 05:06:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=caFXewKMb/GYZMn5L
 9EqChc9Kf09mIvl1Hw7ucjQ5Mir8vshsH+BUK3OM8gGdSKvvn7nshOQKRcOKoWKE
 wwsXMfwepPp2oXMQlFJaAr8c+SnNAPRDEgv+ZBUjtAqxmEYxAnH/vSTAe9rvO+r8
 hBeIzb7kPiYPsV0jQlw4rW/d0nT2botuuqnkBcq1+1r4Y+0Y2pHvkuKG6Bp18Ner
 QAkIlHt3Q3aA0CPdD2aHOMuU/9i/mzrdlU0xmGqfDOqGHic49bPM5ivEJ0IAvOLG
 EHx4GeoUUGD9wodM76ZSEM3SskW3TwEvhEaXzYs7GjLJ/9A8EB1eCJnLldJtm2Ix
 utjHQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgv7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 05:06:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 05:06:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 05:06:00 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 167AA5B692D;
 Fri, 20 Jun 2025 05:05:57 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 1/7] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Fri, 20 Jun 2025 14:05:45 +0200
Message-ID: <20250620120551.613148-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620120551.613148-1-tduszynski@marvell.com>
References: <20250618065618.4045910-1-tduszynski@marvell.com>
 <20250620120551.613148-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=68554ea9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NiBTYWx0ZWRfX1ZwfRRYPXLfY
 TNfF1JfIouCTThpY4Rn1QzmmtSVpYExd0XV7I2PX4JVRiZsC4GKMlI2+LUG3eB42vtpvwjll1ib
 VXryMkkk5VhDfemL2TswftBvUIDx01PV/krUdGaPUpXLGr7ddkApFMCVy90J0klrhuEC9eXGeBx
 Jatg/3c1bdQ3BXlljJpiPX9nV3oREPYX7CNR84B0kzHdCrHh3wCEAoLtH4EQZkXtGEzze5hJBB9
 YqQrj8RNmNPj9m88ZBMfNyLJrEMfwQgvlAtjmmhbkSCHVaEDnpA+VqRC8TaCO+u5TPg89jJGXZQ
 dpgdm0FFqVpSMi37ekfvuMhB7f8FaO8L6hnFz/wtEckuCmObsGoyRsVm0YJBo6sxXUiqSmZPaYq
 DjRLGfoTTCVvsUn3Ra97AOYNFkBrZr4+kyNybIE0t2FJrzc2Itdi62MYccs+JjJ3vuGZD3hM
X-Proofpoint-ORIG-GUID: KvNMOE6v8YQzYc6R1RRwBv21DO8XBx8g
X-Proofpoint-GUID: KvNMOE6v8YQzYc6R1RRwBv21DO8XBx8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-18_03,2025-03-28_01
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

