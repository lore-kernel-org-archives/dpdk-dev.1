Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02DFCCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 949D340A87;
	Thu, 23 Oct 2025 19:28:29 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BCB1E40658;
 Thu, 23 Oct 2025 19:28:27 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3hdNY029708;
 Thu, 23 Oct 2025 10:28:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 L8e2MrXclTppenAambg9J3Fuq8PrCfyKrCqp90BlJI=; b=Zioryc8MxzfZR5yEW
 JnGjeJSSg6OFOXpgHRS3wKlfYSYw2Q1r+ndyt0+qSxwCDfmR6zavpVht833mbRBz
 UzuJWWUxOni6CD2AA1rbOgXm01b21TouWq+bC1D6LaMjRoMyP3zCX6emchuJa6la
 9aRgEOGXULKKQpJgpv1XAaRnNKo1bvSIVEESZ8QCddGMUojXGCPed3joYz+TNm10
 XJUPfqNbpFXGXtqrN+xt6I12/snuCzaWAX8qvD8lwyPQ3hmwMEMyfO+HtDhG+Bdw
 CMRQLk9tnWJ7OoV8qBNZGKPBskdSPju/It9I2y3HEN360jTqRHs/yhSQ8P5UeU0R
 +INVQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycq49vak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 10:28:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:35 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id AE1D95C68F1;
 Thu, 23 Oct 2025 10:28:23 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v3 18/19] common/cnxk: fix error handling on inline inbound
 setup
Date: Thu, 23 Oct 2025 22:57:26 +0530
Message-ID: <20251023172728.770661-18-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMSBTYWx0ZWRfXzUs/Z7O8VVAf
 lZOoOCoOixVdHDWYRDKXDaS0QR0Kg3tVG8DZdaKpXWJyZx6IbMP6oqYINDRitsY6CgzL/a0VCY2
 PeaohC8saDNYiexOM58VnO8F47i0V42g5ZWnFO2+JLuZjFns1TUPMUdGStR9me1TgrZAymQpvFq
 7UtLYsZkCTmIgJXYh4ZKatbmaMB0uO2qqiMMbtwlS9M/Sj5ZhwVs0t2iR0A7n8TrlCEC+FdtoUA
 p5G5lSmwO8xANZyHJReKBj9lVtxcRNRr/On3bY45nRo+P9ZQCisvXDiLJWUEPDVP05v8FWwL33K
 SyN1vyFlHn/x86kjcQykwNewEhKrqZpGyBcMAMjGO5s9YtfZNxWBOvbig5Rf5QybrUoDmvEaeD4
 vBQX++pGtUr/r+Z1JXqGdzRwOFRVqg==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68fa65ba cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=Np0JFEGaXBVNt86ZIjUA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: KLMTXGU5HWGgJRgkQkOioOJejGXNLvvT
X-Proofpoint-ORIG-GUID: KLMTXGU5HWGgJRgkQkOioOJejGXNLvvT
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

Fix issue reported by kloc work.
Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
Cc: stable@dpdk.org

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 75d03c1077..38ff96334e 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -244,7 +244,7 @@ nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 	if (!cpt_req) {
 		rc |= -ENOSPC;
 	} else {
-		nix_req->enable = false;
+		cpt_req->enable = 0;
 		rc |= mbox_process(mbox);
 	}
 cpt_cfg_fail:
-- 
2.34.1

