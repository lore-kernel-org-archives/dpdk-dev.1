Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5779CC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1E94066C;
	Fri,  1 Aug 2025 12:21:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F151A40667
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:24 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5716VP0K004156;
 Fri, 1 Aug 2025 03:21:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 v6s0Sk83VymjqtOEHDotYL3FO+Z/g/fe2Qbar5L+Mg=; b=f94xJeIdu9d94fFif
 HmKy762uxajonLpeIrBhSS+1u/heU/jl3reM4/2nXomdK3vjl1EHuSoVBZFwguaO
 vmLCRB/d+C6iblqc699JvbuLQobjDi+ao6ruzudMq3vZNshkS5vXO9bgoqg4J9PU
 i3BE+7hUVeZP8PT7KGdg0gZimo6eyDv4vb6/GuyqGFMTjGQEq3hYbVfXoMwKETiu
 5HaO4wgsiDQSqjA0woaMz+xMvWeoVUtaYBLXXM8E7RbtfPl4o+AM+BFxiv17vIhl
 HNofV/oexsmbxIV7MRho5VHuOdlDuwAavPhngyz8xbNxGSM2kyZLPStDXN350UKl
 jRX8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 488rcngcjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:24 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id C596F3F7079;
 Fri,  1 Aug 2025 03:21:19 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 02/10] lib/pmu: fix build error if ALLOW_EXPERIMENAL_API
 is undefined
Date: Fri, 1 Aug 2025 12:21:01 +0200
Message-ID: <20250801102109.3544901-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L2Dgr7yvEqsk6_Pc0dGlVokyo4JjNwdR
X-Proofpoint-ORIG-GUID: L2Dgr7yvEqsk6_Pc0dGlVokyo4JjNwdR
X-Authority-Analysis: v=2.4 cv=WosrMcfv c=1 sm=1 tr=0 ts=688c9523 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=32mFfTR9fnK7rSb5dfEA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfX2zsRIZP949sh
 SkhuEZTT1V4rg8biMkG5x8+F20RkpA+iURRXGTy3CxFpto81O5Z4GBWcPATlmrtSff/ou4XhpVG
 tqa73ZsdkMgNUGsZML74KtLCSjFqDKodiuimM5sBh6y71kXfCGDUQ0xbQD9Ul+4INxQ32xYamHW
 hrZalWsv5MgO0SRkMiOENlEQt4R/dsJ1SAmA+j9mdyNGa9eZh1ML8bCe5v73FgLyHgIOtManVv8
 IKwICrvXqrG6eqD4vJd6pJ3y2iFriri5bQceaG0V943u2mlhb6hEw7clgWzkdDra6BRxhXypOTv
 aaMK4Zcuy6akwFVhZqGDiaoh8CCwlSVF9tk6iGTmMZGAI2MpMhWmekAQof6D7Qnq+14P4yJwDAb
 qSTzRkc2YXILrJl+o+4Ky/fSMHoa8Cxf0+anweNXlNkTVmpzxWVK4c2DRyioA5v3aY1k8cP4
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

Workaround that quiesces chincs check should be "turned-ff" not to cause
build failures in scenarios where experimental apis are disallowed.

Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 4c7271522a..d9bc775bf9 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -291,6 +291,10 @@ cleanup_events(struct rte_pmu_event_group *group)
 	group->enabled = false;
 }
 
+/* stop propagating chkincs quiescing to prevent unintended effects */
+#ifdef __rte_pmu_enable_group
+#undef __rte_pmu_enable_group
+#endif
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_pmu_enable_group, 25.07)
 int
 __rte_pmu_enable_group(struct rte_pmu_event_group *group)
-- 
2.34.1

