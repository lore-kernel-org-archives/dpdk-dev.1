Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63005C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 20:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE1AA40DF8;
	Tue, 20 May 2025 22:17:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0423340DF5;
 Tue, 20 May 2025 22:17:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGeoi7026264;
 Tue, 20 May 2025 13:17:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vvRXtJ1h9hzZTUUq5l4t5Uh
 Z6zE1w+HbrMmuE+MLcKU=; b=lNYwT9VIHCzhFLvJXtyoyazuaiHuCa9aCn2HPvu
 j03LRehOp5hzA0V7oEeaqfPfMkzfpsJyjYQTnaGzFgFZOWvPxclm0nqfS04kgaJQ
 fLBC7TovkAzVhZWNMVvXhug5ClePFvlY76Ee6lt4Ae8oPXIIoSNVlIVJU1/5PXBp
 d+T1h1+GtmI0I9iYG1oKEaaH1yXEHqD8s8tfcKwEbXbUI8YrC9uMezZ6noD8FzeN
 NnjSiXnNszfr/TS8/13tozDNzJDO0sA+vvXpK4kwZ3HiTdpCaAqMXdD0y+SJWzRY
 zYSW1ZCXZNN0WIK0kdVTiBH2WvXm1w8RNIaFQqgsa7JPBuQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46rwfggd3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 13:17:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 13:17:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 13:17:40 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id ADFC73F705B;
 Tue, 20 May 2025 13:17:37 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <anatoly.burakov@intel.com>, <erik.g.carrillo@intel.com>,
 <mb@smartsharesystems.com>, <jerinj@marvell.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH] eal: fix return value of lcore role
Date: Wed, 21 May 2025 01:47:26 +0530
Message-ID: <20250520201726.7420-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE2MyBTYWx0ZWRfX3xsduUyFAvl4
 vDnecRzTPH3xUmry+9qNiE1qTcmVqhX/E4rQbzDfhTChvBLDajiS5xn45zI8OO1l2ztpNgeP9dv
 I2seHBTcPz5XD4Hk8PrWLAK2kxkbuNEyVPkT/a1qZEPrQ0FlbrY70GZaccUZLNnB65LXSDLhPQ4
 qZnZBhGIM8/ThWI/cGhe4ylFdRnc8/V9cDtsQ6yypKJyNoTkjPX1LNHCtfDqmBr/vNxtyT9w4p3
 WXR7lbx4RQEZB771ejz1Zgsw8WLcAletvRTzCJi6MglfMHevbeYb6ZGN97MCEugDD9iLCyRXKIE
 Z8fdWUbPPkrLUioG0/EzBwuI+koTFBdYxMqGLcwG0/RJJv20nWUOLhosJG99BftKXaLFAN99s8J
 dxDJMt7Lo8kz/yfGi7wZMSaO+HiNhPDqrMXw2lzWknuwSHXB4rGhWAKQCpdAEUOVl/ugkLvN
X-Proofpoint-GUID: ZbLk28jI0dK99u5TfQCbQzk6fGtgs0fz
X-Authority-Analysis: v=2.4 cv=T6OMT+KQ c=1 sm=1 tr=0 ts=682ce366 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=n02bokGJAAAA:8 a=HRtwC6vWtb1WTaXEcz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=rszdq1ld3peujIA30KyE:22
X-Proofpoint-ORIG-GUID: ZbLk28jI0dK99u5TfQCbQzk6fGtgs0fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Update rte_lcore_has_role() to return false instead of a
negative value for invalid lcore IDs, removing the need
for callers to pre-validate the ID.

Fixes: b0a1502a277c ("eal: make semantics of lcore role function more intuitive")
Cc: stable@dpdk.org

Suggested-by: Morten Brørup <mb@smartsharesystems.com>
Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 lib/eal/common/eal_common_lcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 294267177d..9dd6c72055 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -87,7 +87,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 	struct rte_config *cfg = rte_eal_get_configuration();
 
 	if (lcore_id >= RTE_MAX_LCORE)
-		return -EINVAL;
+		return 0;
 
 	return cfg->lcore_role[lcore_id] == role;
 }
-- 
2.43.0

