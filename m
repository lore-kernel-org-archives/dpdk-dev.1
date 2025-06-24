Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD098C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 12:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7C0240A82;
	Tue, 24 Jun 2025 14:29:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7370740669
 for <dev@dpdk.org>; Tue, 24 Jun 2025 14:29:51 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OANlpa024244;
 Tue, 24 Jun 2025 05:29:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=GX6V6ZAkDDTWVsx/G
 VfOR2F44t/ek7OGshp9PbD/PtxUmk8twWd+BnjgCrpdJZssEPPfMEQGObNQcvrak
 tiheRir2lP7HLxR9udRO9PfU5k9QqfeTjGk2wYrYZ6a7D4gIbe5oUw/OBYlNAC0F
 bFuay0uov9jw9eUxCGBfgwTuEqiF32pKESlIcxZiz5b25aneFjQ/8Pfw2eG0O0Ds
 j2k94ISdEUfvGuUkG6dOSqwbrViuOffWjX/HQs/FnXIuJKGhI7ZfptG6vdc9eMc/
 C6m6QdtgAnfNDcKNwdzEJFD9rapeKQ1BJJyvUEZ8u/UFW4dg5GZBdJzz7jP4Kv4n
 gkT7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ft7h06k3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 05:29:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 05:29:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 05:29:48 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 90E773F7061;
 Tue, 24 Jun 2025 05:29:46 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v4 4/7] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Tue, 24 Jun 2025 14:29:27 +0200
Message-ID: <20250624122930.1783177-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624122930.1783177-1-tduszynski@marvell.com>
References: <20250620120551.613148-1-tduszynski@marvell.com>
 <20250624122930.1783177-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8UiFJfKCeAnvvPGfK0EgsFDZBhu3rmyi
X-Proofpoint-ORIG-GUID: 8UiFJfKCeAnvvPGfK0EgsFDZBhu3rmyi
X-Authority-Analysis: v=2.4 cv=Nr7Rc9dJ c=1 sm=1 tr=0 ts=685a9a3d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwNSBTYWx0ZWRfX3NNmlWCsSNwP
 DWuwfxiACNT+Pj4bpKS3gbvvy/xfoAe56ZlUwFDOJ4S8QmkJ+loQN9LF9c01VU+gWi6pjt1npre
 HP7fqrabJYPoD7lfi1dDXNuLDSkG2ueT+K0BGxZFgFfQLFM4+3LFGUgjJNKAg4HFB7Cu2SHvf4h
 +M9+Rl5VwArLf2OSsczkNPpkzdP0UkoGaxBbzJ+mJiOFHixYq9ZHiyUn/4XBEPgwqUGUF5Wx/e2
 o7ye7bq/H1cSqtclaPNWTEIGO6UIXuQ/0jEGQ75zmLfQGMH2pueI7+hh5RHZMyfoKbJwfdgbSOO
 6ETGRzsDTHhq0E25QMxJCOIao83zVI2kJCtyxHrYw1k46xIRDfjjwPmXzAqIgKvXJ2p8cGFdaG7
 lV7cIpn9BoztK4kNTBfAZjmUYoSSqeVxnu6i/M42V5++wUoT/FFwm29OBdNsYUe83whdwA/D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
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

