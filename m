Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A50C83F25
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C2D6406BC;
	Wed, 23 Jul 2025 06:41:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BF2CD406FF
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N2fCM8019625;
 Tue, 22 Jul 2025 21:41:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=fKGomB1zbOcFB5LkZ
 Qw3v9QYmvokc7zGPyCiL7qJssKvRz3ECcVCrB84jz8KTgXOiR+kKs5m2mfHp0oRI
 l4qX/v7kXf1DtN1VAve/kxg22J73DFVAILUKuX8S9GUnhPDBGyeSfeRgP6cs9gcK
 uAHJRkSbCp6xCy5rDpWaFbZida7DroUvMG75wWNtL7OrzEtJ0xm01JEE2aa277ZM
 v9bg1Prg2vK0bztWoLLdMPRWAflYkU004seiXDBrD3gKQIa7K/OuWjFTKQtyHpWC
 vVoMYwH7RlwREaZI5qNJJ77FoCduhTBZzFT1NZp06ZDqMvzjhsFvwOdC6CjACKqO
 VOnXw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 482q61064e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:42 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id BEF163F707E;
 Tue, 22 Jul 2025 21:41:38 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 5/8] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Wed, 23 Jul 2025 06:41:15 +0200
Message-ID: <20250723044118.2962318-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uEMeewfoGy89b38shviXjHpN4SkK6T32
X-Proofpoint-ORIG-GUID: uEMeewfoGy89b38shviXjHpN4SkK6T32
X-Authority-Analysis: v=2.4 cv=X9NSKHTe c=1 sm=1 tr=0 ts=68806808 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfXzcIf+elBjAF6
 rxzQg9b0AJfTBgziyalcOvDqy0oX6BBTHJ6HPoeffg9f9P8DSMfpjFdVFUwI6lxwAGTeAfL1qXy
 8vlKuxkDwl6BV2jPEW+dQvakbLKGKx5oond47T0dHDOUG5Sg9HGi3e9YJQMrEgNMHk6/v7uM4Al
 +4kNwhE2OC7UThl3FqheIoXrj2t1xKT+tgeYSKfQAV7hCLYPlMTyNZO9sGqxe2uD6PLLBzvSVZz
 ++hD5L0GusHHZp4+cqU7AuwoQ2DVA/gWc34GPGMmar9U8aUR23/2QrR/j0enF/uvnlOMkX0nz/C
 YbgZJmExDOAOLXYzv840dzn5ssUlpxfSsS29KJ4G9iOR44+iPPefrADi7sPVIjHj//VFwSMMyJD
 tCJozfnsHvFAUds4IVVrQr0jqbKPB/oMjYZW/n2Wxmef+6szY49gAThFZoT8wL5NFfSHcJJg
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

