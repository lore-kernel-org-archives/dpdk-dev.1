Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E3CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BA9F40264;
	Fri,  7 Nov 2025 11:48:26 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6216D40A6C
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:25 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A7AKn112930256 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 ePmewATE3KyCGC2COblLqwAla198RKKbB7q7zIzWNA=; b=FwTAa+//EGLHaVbez
 x70LZHlHZACyeU3SCyqC0AVQMQbOF+gRtf07ubESvGT2mFjCOW0OEZnKmTW1WY2I
 a9C1qe/fJUEFqbGBSGzSvf9V06bz8Wfbtj70M+yUYl4veQ9720ucz5XMPiKmCMjC
 ra+7CVScA0CcIySGDYiAAaHYUzqTYkaLY5TtqhRstjhguxQ3I8uqTjCqrT5asB9B
 3Tvly7gMMrzucAWuUtn8YI96aI0iJuC6pcqYc8LWy354xnuUyT3NiABK5Ir8GqO8
 SfKzm6rS4A2iK5nmh5zb2/dIO+KvJQQPHRm/p/c53or9bJO1LpgNwhzPaCaKlGHm
 oIVqA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9excg2by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:24 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:23 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 8956C3F70C7;
 Fri,  7 Nov 2025 02:48:20 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v4 10/23] common/cnxk: feature fn to check 16B alignment
Date: Fri, 7 Nov 2025 16:17:34 +0530
Message-ID: <20251107104747.1131008-10-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX2Viyp65p67s5
 z4rmKHXYw5iSa6a+MZjBQRIXXvmlOcxIIIhFCrB/OH6/uwY0WZVDBHrEhAmBNvbExAC8/uI4tNz
 LVYDKlBNxIwfjRLIJASWq7MYFORAxjuo9o5TQXOFHOR/puG/X6LF3EZDB5Xv4P06JGDQy4zE+2Y
 qaa4Y2cHoiHdGYbsyRToiR7TbU0Utr/XinPDSDCAZdQbWWUcjFwEVzGnq+NvwuSspHOBTKaWZMd
 My3qwkGcEjvlMiIXuBAGOqgaZ+K0B7rqSIZ+TvrjlB3MI9/3/FXbTzSBrEVTSpdANy7RmTj9S+d
 RQY9+m5aWUROzDPQapjIE4RpdhbVCz+t2MCD4335eikbddEMvM7MkwJG050+5j/+N5XfTPRVMlF
 TQn950gZO6Iq6k0a7uIPlwS66bXy6A==
X-Proofpoint-ORIG-GUID: WX_FSQ1-_cFJiJ2IchnrjL0CMPOkgUmM
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=690dce78 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=-bsIhdJEouxmazOkw5YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: WX_FSQ1-_cFJiJ2IchnrjL0CMPOkgUmM
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Added function to check whether board supports
16B alignment

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index c7d2a73d99..9c6adfe058 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -132,4 +132,9 @@ roc_feature_nix_has_sq_cnt_update(void)
 	return roc_model_is_cn20k();
 }
 
+static inline bool
+roc_feature_nix_has_16b_align(void)
+{
+	return roc_model_is_cn20k();
+}
 #endif
-- 
2.34.1

