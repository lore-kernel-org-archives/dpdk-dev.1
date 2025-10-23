Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B9ECCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C36840676;
	Thu, 23 Oct 2025 19:28:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F1F0440650;
 Thu, 23 Oct 2025 19:28:09 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3cppf021903;
 Thu, 23 Oct 2025 10:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 ZpHL1hosEFch7o35pa0G5cAWh39txsUfWExcoW8c0M=; b=OQUxfIggIuomCnAJA
 C4qDcxyq2BPVDYmEDHzQDSEe8d6MdknflMXeHyRejgFSwbSUG8H0PojXGrq98e3J
 ZUaFCXBaNV8f+toj3W12cTpBaRVUUhvcdTwO56JJX3hkiXcHcAGlYBGZ4sJj2HQS
 NXnEvk91oSvFU2IyjPg0W1piajCxZYkIyeta1mWYsxh+tOMwHdIoncfFcljszlHL
 Fwt7lNm+mzzY+RkihDSV8UHcqsoaS+FUj4jtLSUg6NsBccawvpz8se1TnDXC/LT2
 iOwzWfRg/zn+xxnGlxjkh54xFiC68ccboozbflWao50tKi7RVyJ6paInK4sbv+wc
 FHykg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 10:28:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:07 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 1CA0E3F7068;
 Thu, 23 Oct 2025 10:28:04 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v3 12/19] common/cnxk: fix max number of SQB bufs in clean up
Date: Thu, 23 Oct 2025 22:57:20 +0530
Message-ID: <20251023172728.770661-12-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fFlMQ-hajiBSnULb_mZOyAPtuZiBQcxb
X-Proofpoint-GUID: fFlMQ-hajiBSnULb_mZOyAPtuZiBQcxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfXyko/2W6b/nNJ
 sEg6bQ1vreKnHG6TC3ORaRot1djhs5BImTXGErb4bLOL2dXAQ6x881gMfGDdImSU9wqVU0XWAH6
 0IDBICgqgC5Dx6x1bD+LjmfZYFaG/4soX7iPOLYbDndOF2o4EQwT9EW5H0SBcoHiI2/UvoMy02X
 GYodcoVFxc7YJ4bsTBYP6VSwhIP2VZN/Bo0HTtg6i3hlf0KUof5NyGQSpeN6yaNztgaODWRHTny
 3LTiZwJ1LsNxROnQNWswvPlKaj39hI33rO32Z5ENv7ofHkAvr9ZwUAShppIRi+zAzVNC6DDeVl/
 UKle0/Ihx4c5T8gXDq1c4yxrNrM9HCC7GsBdQ80cSl2GBwFYoP7vgq+blw6O7mvLSjAaLlxoAf3
 kWUOLl7hyDoUB2zMHqjrSuyryZHSZg==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa65a9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=3m7XhV8NHwqQqn6gr2kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
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

From: Sunil Kumar Kori <skori@marvell.com>

By default, SQB pool is created with max (512 buffers) +
extra threshold buffers and aura limit is set to 512 + thr.

But while clean up, aura limit is reset to MAX (512 buffers)
only before destroying the pool.

Hence while destroying the pool, only 512 buffers are cleaned
from aura and extra threshold buffers are left as it is.

At later stage if same SQB pool is created then H/W
throws error for extra threshold buffers that it is already
in pool.

Fixes: 780f90e951a5 ("common/cnxk: restore NIX SQB pool limit before destroy")
Cc: stable@dpdk.org

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/common/cnxk/roc_nix_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index e59cd77538..1de6e51c5e 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -2057,7 +2057,7 @@ roc_nix_sq_fini(struct roc_nix_sq *sq)
 	/* Restore limit to max SQB count that the pool was created
 	 * for aura drain to succeed.
 	 */
-	roc_npa_aura_limit_modify(sq->aura_handle, NIX_MAX_SQB);
+	roc_npa_aura_limit_modify(sq->aura_handle, sq->aura_sqb_bufs);
 	rc |= roc_npa_pool_destroy(sq->aura_handle);
 	plt_free(sq->fc);
 	plt_free(sq->sqe_mem);
-- 
2.34.1

