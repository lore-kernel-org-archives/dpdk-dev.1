Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E75C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:41:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CCAD4066F;
	Wed, 23 Jul 2025 06:41:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2F67C4026D
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:31 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNXc6P026838;
 Tue, 22 Jul 2025 21:41:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=SBjXmjpsaj0WBUR1t
 a/hKHuUJz3MqPDP0x5SNYxWxwXmMXxqwTzMxOCpmezMLCRgy8uBM6t1BKU69Oswf
 2jlVi2TRe0uAheXh8T2eaJ3EChraIi2xhV+j3rP8w5cDc7AnR0nIZD5R3BdfswlN
 iWKyv6Q+tHzV/WjB9WRjsqhYhFpF/B+wOlzXlXgf5iDyUky3xE1dzbfMt/b9UZMt
 cCvXYNAcHulFgn+kyJwxEnfFuYDiA74EaJs8mIa0hVJZcdLhUR/H3mPiG4N2HJk8
 w06gcAax8gu9XJsbveMKqkTQm2DekPLcImVBtHwvVGWRs42VUKMSJofsVXzVSwEC
 Aox0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 482jy50pju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:30 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 27B623F707E;
 Tue, 22 Jul 2025 21:41:26 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 1/8] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Wed, 23 Jul 2025 06:41:11 +0200
Message-ID: <20250723044118.2962318-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: H8BQmpvtVKiMEORtm07OkXiBfGs64mLc
X-Authority-Analysis: v=2.4 cv=OdqYDgTY c=1 sm=1 tr=0 ts=688067fa cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: H8BQmpvtVKiMEORtm07OkXiBfGs64mLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfX/XkhcGH4aYuo
 Z9WQPH05QJ/0fqQ0jvgV21HvrynBqEeDX6kzEf5k2rhiLYocCrU4WNjWcyGnJQjbTLhwN1cTqG4
 94PLAbBukVZ0sskzmFuLZlNLK5kusCAg5PHHxB6VztN89kYSGk5El0IJjJRzjlMXssh2xAIHlg4
 hjM4puqQDd2R9MoE6X126JUG0kVZ/7eAonMXBpsE505HkQnQWmY7QsX41Fx5FNnU+cl2Jd5gqjS
 Pa/q0hRzOb1hE6FViiu7G4lpxWgT8sF6VuhJh+QSx4z9MOcbWR8uNOIIQ/2TJlZIlNHXfdGkQZQ
 B/P5KS/tXTN4eV6gw6xwf/zDMGhad/UzvtdgTd9LI34OXQKFagBJNst/uJaGjKf4QnwCvzJ+rdl
 1ZWHX49CpGIA6heBIRs7K7gdQGq7Nc462OwrvghClHFGGCC9rs89EvvIhlvADAQw7s6uvfcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
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

