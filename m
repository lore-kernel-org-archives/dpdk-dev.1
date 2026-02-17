Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB3E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:40:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F74F402A2;
	Tue, 17 Feb 2026 06:40:03 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5E6324029D;
 Tue, 17 Feb 2026 06:40:02 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GKJ4AC3055578; Mon, 16 Feb 2026 21:40:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=1wa/JgJvz/o/6jhz87EZsdb
 FNzSDFlF3NOlzy7aofvs=; b=WSCErQJHchlApoIAN/IeX7HaoEF6GKK5/DkicQM
 GSAzq+kil68CsogpZJ4hxaZOixdl9BpW9VG/q4wcYzgv4f+XIx4q5XIWle61wdOT
 lnbUP8wabkUzmoQNECrYAoP7ngcXCIU12T5LBUDqdysG8HymiOq4Fb06OF+U2DES
 XTM4VDQp4JuIHBq5Y9KXPgV1VEyqFtFuNBTbq6ZdR2hIvGKMwGkVBW5Nh5RW0rAQ
 sVF7J8vO7YYDKIa5kiUjs3UalLgKEIatNC01J5p64gb2v8mpqc0wXJUj5MPaN3go
 +wH1JhzolfEjxzAk+Y+T1DLuQMuA/YqTDP3e0QNLwTGHNaQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck17v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 21:40:01 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:40:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:40:17 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 497E43F707A;
 Mon, 16 Feb 2026 21:39:57 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 01/18] common/cnxk: fix engine capabilities fetch logic
Date: Tue, 17 Feb 2026 11:09:26 +0530
Message-ID: <20260217053943.2748100-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=6993ff31 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=PnxCTWz9nqBHbpKa4poA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: 1DruHrjkxlTVOVRopPd1hVu3_UnMBNHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX0plu9oOCoDJF
 qVqX/5XzHMa4j+3SjW30TCGD8KqjFYxQXeqWD/h7lmVBy+Y8XSxn+mnBIFt0GOwpBu4QJHLWMPa
 Ab4/bMuVkxcMTAHQVSWb5XpREZB7HIyBMC1oqihMO01CqQr7JiKMwhZYoFlBkixWoMKOE6ZTASj
 2F6xmdO+U4KJ/0836//5xLBpCk/2G94+MHgjSQ1mQb6NE3fijHAlb3UWrRP+riCg2wSakARGLiz
 H4djVqRMd77NKPnTUm+dDRQO2z0I8YC/hOEy6HSs681FhNqU2aKleEBByXJlXQysv9Ysyv8xUBz
 Wmaj3i+4lCcbubLWNfxMG1xWttDMlmd6hlZ05DWaQy6AjShO08ZdcjzrAn0rUZiTkE+j+zENMkc
 NYSyBTq8wgtwkVY7awnOnHkzOBheaidAjHcftDu7lMwPc55RVmjjXDxi5EQAI4H3dL9R61s6E16
 xvjbWdUWws1RY4WVzBw==
X-Proofpoint-GUID: 1DruHrjkxlTVOVRopPd1hVu3_UnMBNHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

For CN9k platform, incorrect status is checked from LOAD
FVC instruction while retrieving engine capabilities.

The loop is updated for a valid return status check on
LOADFVC instruction.

Fixes: 7c67c489d466 ("common/cnxk: fetch engine capabilities")
Cc: stable@dpdk.org

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
Changes in v2: Updated commit message. Removed not related macro change.

 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index f8be98efd5..683a9cc7ce 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1228,7 +1228,7 @@ nix_inl_eng_caps_get(struct nix *nix)
 		do {
 			roc_lmt_mov_seg((void *)lmt_base, &inst, 4);
 			lmt_status = roc_lmt_submit_ldeor(lf->io_addr);
-		} while (lmt_status != 0);
+		} while (lmt_status == 0);

 		/* Wait until CPT instruction completes */
 		do {
--
2.34.1

