Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B9CCF9E6
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B30D34042F;
	Thu, 23 Oct 2025 19:27:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C2222402F1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:38 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3cppR021903
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 bclCcxYad4T/Irwi8e2xb93JNizHtZORI6YgmvCTAw=; b=Mv2HzVZ7uoXEaL/Lq
 SHLgShAlD6ynWdMpHLSdMY6jZTuHTIjcSMcvDZSQ4DYthr4q56OGydidjXA0H470
 KagByFfauPe5VS90su25eJuoVD45wLa3N+8jAFh4t34IONrkGr1VEfmQ89KWd7/e
 DeQRIPn9ZIws4o8r7+ZSEkDzKQOvnee5f+BbIut4D5FQQd26By8AZsx/6zVqdNKK
 FPcmPuDQH3ODlhVzdqIi+dFP6ht8cVOgd9WDE0iT5VxB1pWaVaGiEcQi5dB/BeYI
 V/H+mCYRf+h1mE2wSZde/pZKejQYOQIxA4BUeF6TmtYATTBXbEuv06zrql8SNkiW
 bx6Yg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:46 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id E29413F7068;
 Thu, 23 Oct 2025 10:27:34 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 02/19] net/cnxk: new tree for SDP interface
Date: Thu, 23 Oct 2025 22:57:10 +0530
Message-ID: <20251023172728.770661-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VNyTg4s4ioirfJu4ppSs5QFMIEPy3DRO
X-Proofpoint-GUID: VNyTg4s4ioirfJu4ppSs5QFMIEPy3DRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfXyaGBH47tFnUZ
 X2+Aj7gdtiRy4mxNmPi7SbglMuHeSaewmNOX/xJjZt69Gb/ff7JY7HsG/flQzR2kCqx9C7bj67S
 fRyzY/xTEwBk644U7bLOkBH6NI9l0ts6F3AZOAiTUBWvuYyI+qMd2et2DXj7jSxU41Am9o/2TIZ
 UCG8K0zByLSWIO/N2vUEkLTGoHDySX+ZOHn0ZNE8/ZzavRr1c1zQMlL1ikGJ/o4QbknuX9oqUG0
 I7/irnanY7EVQBF+/AUAuwvVKFoYCz9BVHoXWAmp1JwyQXAltLBsZ2DB1e23sDBUf84T4mRS1PL
 UH3zYmFDc4JbekSRE5618N4BlgUhPj0BTGAHOgOfSsYtdJi/j7AlUE82yJkzC6DElBPIEHP0tUa
 S852ZECrVfeRPflxZL8AJ6+oZdP+Pg==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa6589 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=pDSVT7ON_-t1wQNCaMkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

From: Satha Rao <skoteshwar@marvell.com>

Create a new default tree for the SDP interface if more than one TX
queue is requested. This helps to backpressure each queue independently
when they are created with separate channels.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 6c723c9cec..bfef06ae4a 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1451,7 +1451,10 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		goto free_nix_lf;
 	}
 
-	rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
+	if (roc_nix_is_sdp(&dev->nix) && nb_txq > 1)
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_SDP, false);
+	else
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
 	if (rc) {
 		plt_err("Failed to enable default tm hierarchy, rc=%d", rc);
 		goto tm_fini;
-- 
2.34.1

