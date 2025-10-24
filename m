Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C25CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6203B402EB;
	Fri, 24 Oct 2025 07:48:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 01BCA40608
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:48:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3rdXA007308;
 Thu, 23 Oct 2025 22:48:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=A1ZQXFR1cFW0l4wdt
 1Zk/rQLsBtHYB7w36mi4kw3fbiKT+CGHmPrXxDHpyyTo1SVtDcJKqEUUaBTBjmbq
 A8CEvcRe8dAPBdp+GztjfwviJ9mSfa8zB6hLTkVCX0uipSO//WzrHlHaQA0G19E7
 Q/BR8TiT3m7Xfm//enbgI+OhDxuHTtFhdsOveOl1QUQW5OlqKvmbC0fELr0D0uvC
 HteLxXIPS3k3kc1CLPD7WdwT4uasSuHoZnTjz1KEzQMx1zZFKj/cgc+34RbZic4B
 IPV5JLm1mrnjpJdVdb+iFZwAo6c91P0dNeyfhHzpMYY0mbYTIcJGxIxNwpqsvmx1
 fq95Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a01xn84u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:48:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:48:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:48:48 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id D5A023F7071;
 Thu, 23 Oct 2025 22:48:46 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>
Subject: [PATCH v11 3/9] lib/pmu: export only necessary arch headers
Date: Fri, 24 Oct 2025 07:48:24 +0200
Message-ID: <20251024054830.933910-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 44PKMIeSRfsZMMv9IGBNjIwEsQhzIAPU
X-Proofpoint-GUID: 44PKMIeSRfsZMMv9IGBNjIwEsQhzIAPU
X-Authority-Analysis: v=2.4 cv=JfmxbEKV c=1 sm=1 tr=0 ts=68fb1343 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDAzMSBTYWx0ZWRfX7Ax0ww4yCk9k
 zBWxgN7/vp71UsCCwo6UvJqCW8s4pJZ4XbJChnMbpE+os4tHvvT+hxiItPTqfcXAy1lpMP2+RKk
 r1Y7PmpYV9/KfVyldaBIgjdWO7H5GtA/fClrIobFShozHCzXlkQq9ZT61j4/Wjwk2IrJjgnj3Sa
 VNNgwCaGN9v/Vi8xTnNKPPY1rh6K2uWQWx25stNy+StyY1q69X2Y5IsCR5FBq9TK7IhfSWvR+/U
 PElNIswJNY0HnPyDetJvMjZ338ybaIyNlgGfrCpi0HB3mcLx+hbxdpnUoQuCqgCcp6CEGxdOjNy
 ggxA6S0WUzZwRetkul+eG54Y4GI8NBYLI6bp/HVQOzsxznyPDBZNsguKkyoPVm4QtB1d2+gi0l2
 CoJjxDFsleDQIYc0h5e4UtTddID3qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
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

