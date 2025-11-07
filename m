Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073C3CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F47D40676;
	Fri,  7 Nov 2025 11:48:48 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1147640B99
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:45 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A7AKtZj2930303 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 YeBJappRmySXrNvCGRQDeXdxB2IH7LZS3PhqiXIJGo=; b=OHSCuoqAKXytO22nV
 MJVwRP34Iy8aYF+A7R5jmqwazS7orhAdjCyT5hK+MBp6w3oQ7zBYP0N0j/LZhzYW
 4FwU+DhGHeBKef2UQixz2Z/1iUPtT+Jrq3DyRivg0JOxS5orOfr36gKFk5g/FM7S
 MmltPx6F6sgbkNmt1pZ46wfoGyPY3ru3hIp88UNZa8Hddd74EENm5VfPatE5plS/
 b7yJFW3GoxSDtb04zzYnebiTGJwwcoGiOs44B7EmTFUhKbo8ghgnyBMrXyfy3QbG
 GWuK4c2ANW8MkYvwsRHB9eGaNBOpuyYrLIo9HWYRTYuPokDPlFJtmlvKYgwCwOOR
 rw8yw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9excg2cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:45 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:55 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 1F28E3F70C7;
 Fri,  7 Nov 2025 02:48:41 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rahul Bhansali
 <rbhansali@marvell.com>
Subject: [PATCH v4 17/23] common/cnxk: change in aura field width
Date: Fri, 7 Nov 2025 16:17:41 +0530
Message-ID: <20251107104747.1131008-17-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfXxyfKnpNbHAti
 zaz88PBDu9JOd2P6WeKPiEPTbNrvwzs8ebRxt9MjczK7f+DCoqNhA9Z8F//pHx7v9jO5hCtxhOm
 lqixLdf6q4sVo6cjsaTrsPCyCU9rZoUA8LzXgDZd2lRxm22m/yuBVddBjoKLNnNDIRtKKeKkGj6
 TvzOU+EKcEa4treSkpGNGtwuGMOvGBG8IL8Ukvh+rhDgaJzkGqWdi7PX+0StqCj1B2eK7LCuE3M
 LyUWfVbGZ8BdN2lGhmEH2K8AVF/1jOYlTuLar0ZIqTEb+Ttyp61e1+EsS85aqDG73IPK18FXFTe
 yoXYVHok0UMzqDAEKRZVPOeMafdIzYfJIRFDcetujl+5C8+O4ol6Csw98CRVnL1uAcyfFnpMmqT
 Kiqa7LgM7JZSsH7qsr6ZK2Orn/UIOQ==
X-Proofpoint-ORIG-GUID: ad0Ib35vGPlDElHP7szAcm-YvQSqnfCX
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=690dce8d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=cGn8V5ORv-INC5DiuiAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ad0Ib35vGPlDElHP7szAcm-YvQSqnfCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Aura field width has changed from 20 bits to 17 bits for
cn20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_npa_type.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa_type.c b/drivers/common/cnxk/roc_npa_type.c
index ed90138944..4c794972c0 100644
--- a/drivers/common/cnxk/roc_npa_type.c
+++ b/drivers/common/cnxk/roc_npa_type.c
@@ -60,7 +60,7 @@ roc_npa_buf_type_mask(uint64_t aura_handle)
 uint64_t
 roc_npa_buf_type_limit_get(uint64_t type_mask)
 {
-	uint64_t wdata, reg;
+	uint64_t wdata, reg, shift;
 	uint64_t limit = 0;
 	struct npa_lf *lf;
 	uint64_t aura_id;
@@ -72,6 +72,7 @@ roc_npa_buf_type_limit_get(uint64_t type_mask)
 	if (lf == NULL)
 		return NPA_ERR_PARAM;
 
+	shift = roc_model_is_cn20k() ? 47 : 44;
 	for (aura_id = 0; aura_id < lf->nr_pools; aura_id++) {
 		if (plt_bitmap_get(lf->npa_bmp, aura_id))
 			continue;
@@ -87,7 +88,7 @@ roc_npa_buf_type_limit_get(uint64_t type_mask)
 				continue;
 		}
 
-		wdata = aura_id << 44;
+		wdata = aura_id << shift;
 		addr = (int64_t *)(lf->base + NPA_LF_AURA_OP_LIMIT);
 		reg = roc_atomic64_add_nosync(wdata, addr);
 
-- 
2.34.1

