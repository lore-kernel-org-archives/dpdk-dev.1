Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3849FCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:33:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2870406B4;
	Mon,  1 Sep 2025 09:32:19 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6AD1A4069F
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:32:18 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5817VJJE013700
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:32:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 YeBJappRmySXrNvCGRQDeXdxB2IH7LZS3PhqiXIJGo=; b=ZTGyDmi9YacRNShW4
 R/2Hmqec3fNdjSxfcbAVDnAgGvNqhWVmgt4LKcouJCuja9BbeJT9VU0E2gI5iMYC
 eCo8b9H5xIP9hF4t0w7096ls2xr1hi50/qgvh9x8tuRwKqJKdc8gc3ikCY90kY7e
 pASPPihy3FUBeOy+b0+b+9u15i/6MrODa8bO3rhUNKen3YoiL/nz1s5cU3ikOsoo
 2C+VRp9DShXpBKmOF3LFbzgJfXs27v6LzbMEwwGAQxj/+DQZ5W+kX6V2BoICBrHu
 nb+zlB/t7Ehsrzd0AyelQuAg+Ojy5DnDBUBbhDSHabS85Kpa/EecJu1E85WtOjyN
 FK+ew==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48w75y8073-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:32:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:32:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:32:16 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0428B3F70AC;
 Mon,  1 Sep 2025 00:32:13 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rahul Bhansali
 <rbhansali@marvell.com>
Subject: [PATCH 17/19] common/cnxk: change in aura field width
Date: Mon, 1 Sep 2025 13:00:33 +0530
Message-ID: <20250901073036.1381560-17-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDA3OSBTYWx0ZWRfXz+FzfDZBRr2W
 mErnSAiIo9ZhkZYPDDVFOD6+3sEAI/Q0AJKtCAV8H6z66pR65ckVdQWNksyDWPQjfmNndFN38aB
 MbGwJJY/b58gaLvpJ2q/jFOo9fOFJvZdOL58lObR66LPUqoNEdsDZxGRYExcBu2ZrHUUARbmOQP
 D9TI+NtGr4T2xLPft90cbDZRmClOfpfQ0GtgAd1dG//Ny4eYjgDBCGcERLnEtQVO+cBpTtcYwgw
 YaW0mF970E5/fls6eenJtDkPbKKtr/5NxEn+pm+FJevEJXgtG/64SrKQXNTlWzozzsiP+gHVkPm
 vuZYeIKiqqEKUxHyJgxkMKs+PfkN6s9hmiqlb91y004DidFivoo05ezk3p9z61mK9W7hfk8g41U
 vEaHir/r
X-Proofpoint-GUID: j3vRIc8VZQd9dtPThbO3SfZQaw_2aoaG
X-Authority-Analysis: v=2.4 cv=D9BHKuRj c=1 sm=1 tr=0 ts=68b54c01 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=cGn8V5ORv-INC5DiuiAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: j3vRIc8VZQd9dtPThbO3SfZQaw_2aoaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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

