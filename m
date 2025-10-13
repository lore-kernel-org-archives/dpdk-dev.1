Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12274CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:02:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A9B3406B4;
	Mon, 13 Oct 2025 09:00:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2CBF340653
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:00:48 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D0SQg4024868
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 YeBJappRmySXrNvCGRQDeXdxB2IH7LZS3PhqiXIJGo=; b=XmhXFIa1NZnvnLFQG
 xtZmwT6EzCqjofYc/o2Np7Gz6lMW4UAEMHs7ku91QppQB326WIUsZyQRMQAOp8ea
 x7aX7k/JAkX+4HxaAmVeIA7Z9TUpH7om8/yGwpG3yytBrx9yRFur5JFji/666HE/
 7GDd7m4Nx4dsvwpcDWNCfLJeUbxTV5EOsohNeWEaK9ELlp2FGtfgXJC9TEnsZ160
 fbXp78n8B9qYm7H/AEwbkjngA4NfjRDVF+x4CYHospwafMsXQglDbxp/v8RwYSTv
 nyMcBizrveyswPjKgo6o1qxV4Ppj/AD4P9djqf+Z+nhfT3I4mxPlSErHB8B7QksX
 TYl/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1s8mg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:56 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id E90823F70C0;
 Mon, 13 Oct 2025 00:00:43 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rahul Bhansali
 <rbhansali@marvell.com>
Subject: [PATCH v2 17/19] common/cnxk: change in aura field width
Date: Mon, 13 Oct 2025 12:29:47 +0530
Message-ID: <20251013065949.200414-17-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TokzYmcLaMOpOnHVSK4nZArfWuzNuZVb
X-Authority-Analysis: v=2.4 cv=ENQLElZC c=1 sm=1 tr=0 ts=68eca39f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=cGn8V5ORv-INC5DiuiAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfXzgcsMOwf9U8o
 2jNK/8ahZLP9h8siyH+DF0RwG420gmPb+Q3bfPpGRjh2JKIVB656nYcaA6xhc2ByZI2qYlqP5ap
 Q/dqGFTRcsdr9VbGhHKxoifybzYzXMoak6CB5+q3xYQ6rNRA582kp4QOK9jwTUtqdalCADRLWQb
 Rs9N6J40IPsGRD2xtVX0QTTSzrXXeWSyOoQrzB5jl4EmkbizVdS9XlD3oTetKFgOBDeBmUne+3u
 jwBQtsU3LVmfgqsLxo+w2zLP4lpSuPjs3fx9FRxlSMP+uxSrFOaxkxvSsljvMfPrnrsbq1f0J5Q
 PaTn2Qzwm7wV2qbc2xpgX5Nk85Qr3ifJCUEzjELt/4XV29LazWVH9s9twS0KQSjb6V4tZ+hrPdv
 zQEVIk91aehqO6mCtMeVpcWq74Qt6A==
X-Proofpoint-GUID: TokzYmcLaMOpOnHVSK4nZArfWuzNuZVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

