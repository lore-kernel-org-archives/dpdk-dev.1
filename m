Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC50CC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E66FF40613;
	Mon, 16 Jun 2025 08:54:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 68CF340609
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:54:00 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNVcku028273;
 Sun, 15 Jun 2025 23:53:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=Or0B4VVYYY95F/dCz
 EVRAWe5v7IfmHE+s7ODlcoGZDdWICi1zRXcGhaoyEDR8iRkgmV/8BTCPlQFgAp6W
 3aGXJDKef5XqiXrr+IhoSnOCabqHvD+jydXUzoE6gfV09xJSj6hwgFEHPVhL6Xu4
 9ZK0blPFfdAYmF447xPE92xNtXLkt8AHDwEoA8DkqwxwSGGeXrrBPFPl75+klcjs
 TaUba9aV/xOzfByQ27wkoP6Me2/Lo9SlRsSe2xGD9kmrYjKYuJ7ZPCPyuYBWy5pB
 Cr23TkIaxITm0k2wjQFS1VRSx5eYySbQ693pL4CZnDroavSBY0fsUtyTxaolJ1n/
 7m+eg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70m9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:53:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:53:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:53:58 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 1AAC35E6875;
 Sun, 15 Jun 2025 23:53:56 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Tomasz Duszynski <tduszynski@marvell.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>
Subject: [PATCH 1/6] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Mon, 16 Jun 2025 08:53:36 +0200
Message-ID: <20250616065341.3233106-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616065341.3233106-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fbf87 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfX0Xh9O/E/qV4A
 gvNO2dtuPhAF3FCeyR+8LpNfkRt34B//xv3rekVsI32f06G/caRVSf2QlDItDGN1KTp6szLCMF+
 IvlC/3fYyfL7wT3UVxl2egW/15Q4SNulMUtLPEDB/EP1fA2+ViZPoiyTdSILWS7JgZh9mqCwPz+
 I+E5Y79sragfIcP9LEXDT5RuMjMNjBUSb5Abtzu0xamIjx3Vzo/lwcVXQH+K+8DPEYpWOXmwoZE
 ibmJuT87JASZDg1TNoKlazpDmhl8CCB/cktnd7u8Z600zDR+g8gRWWzEABzuaMz6Kprp3HfKO+X
 52e8bnEez55LkSlosf6CXds5vg79KJSzoTjqrVmFNK8wkjILM1nzSU8VCnzmDImEnX42D1OdmXb
 kb2kM+ZFvNqWFFH+Opcs4be24Ohey7YIBufEZtbQDMrpAlmyWC7zG8fUj6sCaiUrwRdt4/fU
X-Proofpoint-ORIG-GUID: SaMrBlzX0WpFOe95J0FFftJoE5AmEGCa
X-Proofpoint-GUID: SaMrBlzX0WpFOe95J0FFftJoE5AmEGCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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

