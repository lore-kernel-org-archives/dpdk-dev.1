Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53697C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:41:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6364F40667;
	Fri, 27 Jun 2025 17:41:19 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9B23A4065C
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:17 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55REiXQO017682;
 Fri, 27 Jun 2025 08:41:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=RXbwtlJDlkjKMTCZs
 c0AGmJ/B+Ng3xXvY3nHm6tmBoOyT2BbtruQUQdeEAdJn1cisXcyzsJYJPVxGdE15
 V7itBWTMRPsilIBIK8D88/0IV4ulR7+E5YnC+HB9eg2KnvLpnINABu0uE2pTcQuq
 s9G56u4bT5YsrKCLv+ICx4Mr/PIew4N7/iMwAQqiC4TsWOnCCcd29n3vgJVrfpjh
 kpaUGq4FTNwWYfxgX5nrEQ1VL5qDGmMyogehE0My9qZki7yUEFEPYIesw7b+b8bP
 FacInGFHN5v4ZTlo4CQrqB9kkCEWjDEMi80RcAQsWE4uBMTE7lUZILjUTzbctlJ9
 N65bw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hfxphyja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 08:41:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 08:41:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 08:41:15 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 961743F705D;
 Fri, 27 Jun 2025 08:41:13 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v7 1/8] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Fri, 27 Jun 2025 17:41:00 +0200
Message-ID: <20250627154107.3405768-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627154107.3405768-1-tduszynski@marvell.com>
References: <20250627105740.3388237-1-tduszynski@marvell.com>
 <20250627154107.3405768-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNyBTYWx0ZWRfX0LgZTaoyGsaf
 nwqRMGKuMOvoXGdtP4Iyx/Me6frHx7+lGzwh2v0wrxiF5N6GL7+9r84QgKb+Q1x1AxOhTVnG9dS
 GNBWIrj3Dchy0Vn3ecg5ijoPehOTOIzHDyEQfh7hKoGcUCreRGugK/jpYEkYWr/xnjrSGCot4Lm
 iCIHSv419EwAjLr3Wvvo3tjQdKEzut1TsPyqEe/iJq0wAf27Ez3FFqHyRcXTIVzTRtbR326Qr3b
 5rN1knioM/zl0LxgCt9FArrd3HXO4lCSWTgGbaQSoMJuW2W2WI/3+Y48JBfPLYAQxwaODB5isTF
 N7U3MxwyaYgD9v2qjn4ccPdJy0Iiejv2mzfFwb/yBYnA0qOc4t+/nxPBvV8rVfW47lVBccbr99x
 49Ni8iNBMG3GAJbeOtLdEKIfLwAbK0/kBImqEalrB1xneR2nmnNGhf+CNIliOmMkn0ke3ZRq
X-Proofpoint-GUID: bPgTl2PwZs7gmKlGdS7ipTw7CASlgjQX
X-Proofpoint-ORIG-GUID: bPgTl2PwZs7gmKlGdS7ipTw7CASlgjQX
X-Authority-Analysis: v=2.4 cv=D/BHKuRj c=1 sm=1 tr=0 ts=685ebb9c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

