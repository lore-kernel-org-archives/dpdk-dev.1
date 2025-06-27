Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A484C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:57:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1216C4066F;
	Fri, 27 Jun 2025 12:57:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1D1CA4066F
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:57:49 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R9xwUe018769;
 Fri, 27 Jun 2025 03:57:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=Nv38uozE4g4QW37Uv
 kxHGjUl5GhebLCE2NCB8Ib8y54E+XaE3AvVFnIbB22vvt1MUzy0hJyZS71qvBvcV
 ozTduKaJ1486ODGQ6Kk3indieHpYdSYX4p4IKd0BGFHw+PjTDL5kjfbIKrzhFFng
 ww2mll68nC/fqp9qo7lfKXFpKfOmfrc/ZWPJGLbW2+w4ZHwfLvhszRAuLpD0LD8a
 N8EXVSsh0fxTbbQ64JCJSZCiTF8wGgRsLOKmUYMahzWQh0Rr1P2fwRMuvA8fH3St
 LcVyaouMGBu8mhJVNc1RvjL2Pj40BZgXjwk0nr6/xs5h/2avP18a0ifsnGKkTWGW
 iW9wA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hs5c83mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:57:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:57:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:57:47 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 5EE0F5C68E3;
 Fri, 27 Jun 2025 03:57:45 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 1/8] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Fri, 27 Jun 2025 12:57:33 +0200
Message-ID: <20250627105740.3388237-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ARt4qFkHiL1Ua4rAayIxocDXQyOWiWzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX2Al/SRda9umw
 iuhWVW/ptB8QeJrWKzpXhTkuOFVG13VRIK94Wc6YXybWl3d5RcJLhukX1MyUM3EhFRWIDZUAhSI
 b2anE+JvgsJA38i3bWWOyvF079SkbqOAKAwKhPAZ1a2IvTDiiom1etiYk2TzHotk5oBS4I31DT/
 LL6Fj4E8Up17gtuwBZptmR4Wu7nIffNXjq8m4YCsQ+dA86RJJNKOpY/njdV/3su3J+AZgoTHDqS
 P++P1uZDWfcA05xUYMJhLHez8gjh4fUSnRb3ez+K8ovukXBy/Gzwp0SYkqtoluNyHfcJjXN5/OQ
 NmsYj+ZzVA1EapUlZ+aIT1zPSCaEUVAaSt4GFxq9zjNrulKaouxomQSvLCO8WoZLSyX5YIFj3MM
 2SOYSJhxBhAvvFlpBYR6w+wCsAHE5YBbpjwLqAUmVc9g146H2cuiA860x3K7iSzr3eJxanDp
X-Proofpoint-GUID: ARt4qFkHiL1Ua4rAayIxocDXQyOWiWzd
X-Authority-Analysis: v=2.4 cv=BNOzrEQG c=1 sm=1 tr=0 ts=685e792d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
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

