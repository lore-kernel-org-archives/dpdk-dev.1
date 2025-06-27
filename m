Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C62C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1856040678;
	Fri, 27 Jun 2025 12:57:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 406DA4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:57:54 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RA0GiM019553;
 Fri, 27 Jun 2025 03:57:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=LGLVpKffc2HycFW/Q
 jCoof87H7VVR8oXFABZFz/jkxJ3zx3rasCLtMy7VFxpfG+QKwu1VVy3WyHBLVFjr
 J+T3dAqvqmXZkgH7FaYc3McEO8H/QEs8wKhDuY+rBmcSSUe7T55zJt5G1UlMH+aO
 gHUV6bnboGXCPwhVy9EzZ9OImvvQ724adEY6cvzjV1X+rCM/OrkHlyKxwBZm73fK
 ioS4X/AGVqUtgBoV0napDqgc65mU+Sx+PyVhRQxdXxA5xFRBmDILq8sXwjKRx2Kn
 MKkQYxIHtyg9vFd/u8a1KVOx7/y1MzakSLlSrOXHyzpDiIHmChwNFl4lS2c5/lzi
 hC6XQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hs5c83mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:57:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:57:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:57:50 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 344405C68E3;
 Fri, 27 Jun 2025 03:57:47 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 2/8] lib/pmu: export only necessary arch headers
Date: Fri, 27 Jun 2025 12:57:34 +0200
Message-ID: <20250627105740.3388237-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dVCgMRBW19-0RlMgh4kaauFMnnO4-WNk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX0bjLPB3e9n8z
 w/NRnbXWTgNBHo6UfEK3LMlPbDiKcVCyCePyaWto1aL8lvBnV4GGuIV61ldmdDjZqs7wpD6Wm2n
 XotOE8q4RWFH9H7NyewD3lxoLpWosElVhu8vX40lN5gtQFy5BohdeWR2lzM/oFkV4AIviWxK4RB
 KrDSIZaAL5iOK6a1W9KiW0Hiv2JOJhUyZeCKSSTcQBlHRFYvkLMmJoMvjDWRlruEOFtVRDwIvd3
 8UumPcefXNIunSJZ18+tRC/FXd12oGShGCdX7m7LNDC8ZsoTa5h6wTWVFeEjLz0ChfjsHVBruPZ
 6Vhlffc62zsquD8A1Snn8C0porjX7k7Xe9VoMUgd70syZ79tXPcZ9u7Ek5/lDk0ZscY0F4QNEo0
 lvg7v+uqaazZPKa/IDrD+8UHNkgTi7EGLPgJcAI0f5bJGbs4ux42iO8OdiQZUyK3DHw6So4j
X-Proofpoint-GUID: dVCgMRBW19-0RlMgh4kaauFMnnO4-WNk
X-Authority-Analysis: v=2.4 cv=BNOzrEQG c=1 sm=1 tr=0 ts=685e7931 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
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

Install only architecture specific headers to avoid header pollution.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/pmu/meson.build b/lib/pmu/meson.build
index bcb6d10f1a..53013d0ed6 100644
--- a/lib/pmu/meson.build
+++ b/lib/pmu/meson.build
@@ -10,13 +10,13 @@ endif
 headers = files('rte_pmu.h')
 sources = files('pmu.c')
 
-indirect_headers += files(
-        'rte_pmu_pmc_arm64.h',
-        'rte_pmu_pmc_x86_64.h',
-)
-
 if dpdk_conf.has('RTE_ARCH_ARM64')
+    indirect_headers += files('rte_pmu_pmc_arm64.h')
     sources += files('pmu_arm64.c')
 endif
 
+if dpdk_conf.has('RTE_ARCH_X86_64')
+    indirect_headers += files('rte_pmu_pmc_x86_64.h')
+endif
+
 deps += ['log']
-- 
2.34.1

