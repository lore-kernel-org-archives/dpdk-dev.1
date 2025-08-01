Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E2C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 456704067C;
	Fri,  1 Aug 2025 12:21:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 551A94066F
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719ipSf009636;
 Fri, 1 Aug 2025 03:21:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=P0NUhEFCXmC5H5Wvt
 yrnVybrU5n69eEizFwuzDpsotHxwf4YGFNQFE+vRyaUDo9uEaAdP2LhMgpWSkEKa
 CBqE6YT7lGGuEeTxqZsNhciL3wgFdJadga8q2nPAuJMMJbmzDdE2G5ev1wqTPfln
 ipc63O0I/UHkQsmWBAKPEfTYfcPM1YuQWcdN/XY3JO8Ke1ZWmp0cl4bXlkldxv//
 knXE2XRvOPD63dNmCxs4AwN0haS5JGMcd/v+InG4hNR0DQ5txUxxdGJS3TAuNDHP
 KDVCoYm2APHj/MKwnpg0g3t3Prs/KClHOaK2mOMOczgPfgoIiNrjs/gv/Qzkg36l
 Iz0Uw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 488gsuh87q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:27 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id E304F3F7079;
 Fri,  1 Aug 2025 03:21:22 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation warning
 in chkincs
Date: Fri, 1 Aug 2025 12:21:02 +0200
Message-ID: <20250801102109.3544901-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nE7Z-GN90c78mpQstGHhFLd0HImonZuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfX+b2FxabmzaWk
 VVCUjZdPvN31iOvW853acJSuA4dfJRRnkcqyR2UtM7h7hd8uNvErGawlFs5kDzxr9+2R4fBXZbj
 owDQAlQf8z3kmW+SjpEbrSRIgAs5kV81pAaCj6youN3sLIlysnF216cG4vUdnrlQtV/u2AZHont
 qQZKcHrX/HTsfvJs6CQJFOwg1GHAR+SUJvSEeTTvJbpY78465ytrQ8eLmLdpU0bJUT9DtbLs95L
 uPcnkB6tQiiMUozfXSglB0SAip/fZg3kDYJXUKc7SGJvqajFy2QSAJiwfx7osaJmPTy9f+wL5fk
 Z2gyCGnnXBAsCGs82CqR0p/f+nGrv5oRPZFCOld9VZitW/W4xLgoklus3pXU8Jjfg5ASvD+bNQl
 yHS+8Y2HjEyfmZ8qYste5NFQdvvWtRN4B8lNWf3gNrHukFHTM6r76Zc5cczlIG7ZvH9aahGl
X-Authority-Analysis: v=2.4 cv=EbHIQOmC c=1 sm=1 tr=0 ts=688c9526 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: nE7Z-GN90c78mpQstGHhFLd0HImonZuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
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

