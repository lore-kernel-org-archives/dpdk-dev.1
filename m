Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E30CCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E69240E35;
	Thu, 13 Nov 2025 05:39:32 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7EF9540E2F;
 Thu, 13 Nov 2025 05:39:30 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMqaTu1056312; Wed, 12 Nov 2025 20:39:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 ZpHL1hosEFch7o35pa0G5cAWh39txsUfWExcoW8c0M=; b=HT7UMrtxRxhxMwCay
 RDZc22cE+YJBakWIfPINv2dScVjwfL1HcFNneuMy2ivpVXeUJP5O2exrUM1UtdQW
 ENH1DZG5G+sOWyxt8TnWSRbh8Sr4EvtyvRO8lFMqyltBLrmi2hBSBEIWN0Z48Bug
 BlMF03sHj9QcoOWZ1ZlsL02btsYKjDVjZRlxL+qEQoqfMqLLhDKj2TeWyQ6FeDBl
 oQDeoEapE+DoT5f2924LUgPeMJ4AIuV09GyJ31jNGFdBEeSg16LIShQMl9FH457y
 idK9u9JPfWWSxpX1Al+pWXWTq+gbcWL79cTPRD7TPiiaYzcM2U/1QPmVLTZ313e7
 CUd3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aa73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 20:39:29 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:29 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B6CAB3F7076;
 Wed, 12 Nov 2025 20:39:23 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v5 12/23] common/cnxk: fix max number of SQB bufs in clean up
Date: Thu, 13 Nov 2025 10:07:57 +0530
Message-ID: <20251113043808.1180851-12-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=69156101 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=3m7XhV8NHwqQqn6gr2kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 9uGjRFnc3JEQCxQYLd0IDfOvu5jKMw0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX7FBO8vdZLcWU
 vN2H1XCAGsXxMhYIhGNzkdIvtU+Ch/peRLbPr1xhqy18KEmJM00nJnQC42NdaCcHA+Uca2mX/cQ
 MUooeRZS5NGrXL1QOWRhw6hsx5663zoruII2tNapwhWCcyke9syjfDoW80iG/yq8T3IxaiLpq1K
 p6jNpEfQLD5IlKCgfRVGdrnKnXE1TXAes1X8aYCowbjKXSPkO9o9lbFfPKfMxrVp2PneDqiw9UJ
 Yx9n4Qm0ggxRpJPjTzJNcyDcRMkw2xjlIifj+kKcx7/Z59dfL3ZOUL6K6Ud6Hxr8vqPtW+guOcC
 Vdsr0zFBXQWgjjwMjVtg7ZZpfUXZIGIeKT96vm/dxz9I6Ma+zWrdxjTLU1ul6WxCpE662DuF3oM
 +zx5uPFCvvA2z8W9DBv2LoUnxQq/0g==
X-Proofpoint-ORIG-GUID: 9uGjRFnc3JEQCxQYLd0IDfOvu5jKMw0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

