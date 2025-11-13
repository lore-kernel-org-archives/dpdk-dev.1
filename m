Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C5BCD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08BA40E68;
	Thu, 13 Nov 2025 05:39:53 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E391640E1B
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:39:52 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACNS4Qm4031439 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 YeBJappRmySXrNvCGRQDeXdxB2IH7LZS3PhqiXIJGo=; b=MVBRWP1Zapk2y3Kew
 neIoWHagVn7ceDk6gRTNo/4GOBgjJJzX0hWcN1kQiu/DL32rBcAtC0vTwffi7+OZ
 Xebw0FtVE9dQKMNI+358HnN8jh1O5Mo1O2Av6y+dTpWhX9gPJuaUlsPQ9z+ZzfFT
 9aemOhtcPA+bieywk3tLrVKPNwjpYTf/T/S+fpc1hTeNZBdj6tv+d0tKwzm1esMz
 5uYUNUhTX7F0V6xXpT+T9+ifEdJ9Ajn+i4rWQFwZN/BXBj62e4rMSoYS70GT18Xv
 tWj1J6qls/oA66KAnl+z2Pd1FfRk/e5/+1QoujkWk0IHuq6861ku1SvjN3oBZJ4S
 61XaA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad3xbgkhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:50 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id D71F73F7076;
 Wed, 12 Nov 2025 20:39:46 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rahul Bhansali
 <rbhansali@marvell.com>
Subject: [PATCH v5 17/23] common/cnxk: change in aura field width
Date: Thu, 13 Nov 2025 10:08:02 +0530
Message-ID: <20251113043808.1180851-17-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: M2rF5p8qG56-SRBR7aCcMSzkkhtW_8ga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX/OL3Tbir9h1s
 ptMwKf077rnSL/xBrhV56xsagWDpKOr9GMrldXclY3WZzE0WlqjxVdXEBHpuHcxdTPYiBdAlKu5
 eBzVHC0PbFrZrnbj9TmQTO5FgHlvA1gMWqbbvvnLL3xC/Py1wdprjV6NB2Wra80wl4L7yAv0Bwc
 I/d4GZX9Abvbwkl8TU5I70JheWUQJc88ntyE2xMlPKLkwx9gV8WVidL95C9FFx0wVieo/8vdbJK
 9vlA7+z+c6wTGjmvi9NDGwGMH3pjVbizwqIgZJ7ghP4F1po5bJz9Ly3hhee/Wiyz9yNEx5ntgZK
 ZbuqRcwEkmZufwHVpzc9CzO8yR85QXcRV3R/WE45S9b7H/b/f7O+KWP83NuxN7IMwwjGM4WZ7n2
 tmdemMeHI/lxg5LMdNxG6JMlp7sT8A==
X-Authority-Analysis: v=2.4 cv=Qq9THFyd c=1 sm=1 tr=0 ts=69156118 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=cGn8V5ORv-INC5DiuiAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: M2rF5p8qG56-SRBR7aCcMSzkkhtW_8ga
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

