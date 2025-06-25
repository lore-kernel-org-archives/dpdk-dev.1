Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C040C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 696EA40E0F;
	Wed, 25 Jun 2025 06:47:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CFA7040E0F
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:50 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OLKwID031367;
 Tue, 24 Jun 2025 21:47:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=YJR4z+pj/EYkDBZmN
 KT2PQ445rm2EgNMKv94id1gam2rUsSCjc3ePVstdmbc1rKoKsinVTBKHYmwyFrv9
 WHKkU4uufJ8O+PijGr0/UlhGF0rtxW3d/mK62bmf0bb9hA8KZmnhLnEwzzIP9OqH
 CN7sZjWiTgsCObB7Y9rqbgEGp4sGG+kz8yCx0qlX1V/nirkDOpJeCY88HL3zr9qm
 RjGK4XtDGs8DpNDMZ98deZDNPH7wyU/koqu9NtSlrbv1N3HOQXnX8hFOeAabOC/q
 IlIAjz1UIDW9lvq27a+3LSFUmSgg5g2hiJhsHXcwVKxpySfiEXNkUcookKtMumDR
 mZrig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47g3ungrgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:49 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id CB4003F705C;
 Tue, 24 Jun 2025 21:47:46 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 5/8] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Wed, 25 Jun 2025 06:47:27 +0200
Message-ID: <20250625044730.2435526-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=efU9f6EH c=1 sm=1 tr=0 ts=685b7f75 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 3YcUnaHasZpCsFg2iYgltSmyKJb_ZyF6
X-Proofpoint-GUID: 3YcUnaHasZpCsFg2iYgltSmyKJb_ZyF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfXww3VJio6EmHc
 x1KxnO/5ZP8Dvfp30aA1Igb3Oj4yUEUu6MpjwZG6L0zFB2VaC/LymXmhJIcUnjOYCYnEcgtvwzY
 8v0Au5xN2AHRL3+lOupKmib0UHfwVwE98OxR4u5OEEFaJBGwZd7y9Al90rsySgWPLHDGFjow0Eu
 vFosfdB5wwPA78aFtWMeAS9Ani1vIy7B836x1wv+cePn819bohNwAFDv3eZ69RaXePUu/h2R82C
 pWdRAJg7mEcC9dOs8+lBQrVPUKY0jzAy+k8Zg8eup/m7qYsOx+ymxbR/X1zQPOGMY2z4ktXN0u+
 w15jYW4+SuoePvtUWLdfcExsJXklqlS6rcemWMaPoQkBMPVwAJnp4O63KLkrXquK3B0dP14wVR0
 vx9UJ1lj0xArJlYUlOXDGN7EgBN8jbioHuzQSxUiVFQK9vtDFsCSEJxNl3pSXE6LnhhtowAx
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

RTE_LIB_PMU is defined by build system automatically if DPDK is build
for Linux. Otherwise it's missing.

That said all cases where conditional compilation is required
can be handled without introducing other macros.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/rte_pmu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 84a5d522d1..e997f62334 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -33,13 +33,10 @@
 #include <rte_compat.h>
 #include <rte_lcore.h>
 
-#define RTE_PMU_SUPPORTED
 #if defined(RTE_ARCH_ARM64)
 #include "rte_pmu_pmc_arm64.h"
 #elif defined(RTE_ARCH_X86_64)
 #include "rte_pmu_pmc_x86_64.h"
-#else
-#undef RTE_PMU_SUPPORTED
 #endif
 
 #ifdef __cplusplus
-- 
2.34.1

