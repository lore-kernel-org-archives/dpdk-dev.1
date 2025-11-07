Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA45CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD8A24067A;
	Fri,  7 Nov 2025 11:48:11 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4647F40668;
 Fri,  7 Nov 2025 11:48:10 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A75X6iM1492988; Fri, 7 Nov 2025 02:48:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
 fX1iw2u7w59FZwn4fWT+Vcdz4uthTxChNo3xpNoDUc=; b=IHSlERoIuknq6ZfiY
 OPIlSNv/Xu3FE6RluefYAUTgDRW4dNUf7Zji/4zVkrmaAzhaH7IhxM+KFZmtptqh
 2v7kCEXw2OucN+7hSXToaPpddlFZJPHykJpCddxoDEKosRkVfYeakoLJ90w5Fqy5
 I0E76JZxxoVANmXx170l5+pxWMUho0F2NKb4p1+15YJ2gfW/fDakPt844w0oHE50
 cigJSMYnrsuKbRSvN85v3gEVEgHHaLJClH5ktBXzwlfaoe2ovLceZDU9Ykk848Cb
 JWeyzRy5Mr20cxb5AlMwvpt9hGTJYRCaN8DM63q7ovmaf3srvl2f3/WtsccSKRnM
 XHW7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9aqkgvr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 02:48:09 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:08 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 5C5653F70C7;
 Fri,  7 Nov 2025 02:48:05 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Monendra Singh Kushwaha
 <kmonendra@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v4 05/23] common/cnxk: fix inline device API
Date: Fri, 7 Nov 2025 16:17:29 +0530
Message-ID: <20251107104747.1131008-5-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XvD3+FF9 c=1 sm=1 tr=0 ts=690dce69 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=a_7jAOaszgFUf3AtnaMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfXxBA1JWDvXM8n
 s1IYhQtTS+UO+/vd7KUdII/SyRd+RDOlKdpK+VKXYjEmfVpII/nG6GCQL2nDqOfFL4367bwSYri
 C4iLT+EhI/ALWa2RUxtK6cDDjfwbtwMAW1TrJzcye2ZV6SumkCW4ul5dtVVE6IP0HY8nJvrOBa7
 L32aXP6bysUC+MN30Oa2rk8pOKUwmArsa4RJKI6ARDN9B30g7Dx6y2OM2zg7TRz8zgMSBm6+ajs
 jDK1sGwRys8PEN2WLi9nuIMQT2J+Wf0wCTWaNknRdQJXyMdcHTcIzhZ59d50/yX4rU7E4Emz/67
 sbjYvWY4+DxlYJdjiQ5hxp9XTSmfg7HaEJHXmg2Qm5Bpq/80XKNLlx193/P/E18Ta2cguAOC0Au
 opqlCcl5b+w2VVVP4N7+AdhDQPDU6A==
X-Proofpoint-ORIG-GUID: 9T0OC5dj--_yfQuXrXnNMXAPb1YWq-rq
X-Proofpoint-GUID: 9T0OC5dj--_yfQuXrXnNMXAPb1YWq-rq
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

From: Monendra Singh Kushwaha <kmonendra@marvell.com>

This patch fixes the inline device functions to work
when roc_nix is NULL.

Fixes: f81ee7133b48 ("common/cnxk: support inline SA context invalidate")
Cc: stable@dpdk.org

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 70ab8001e1..6700f556a0 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2324,7 +2324,7 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 	if (outb_lf == NULL)
 		goto exit;
 
-	if (roc_model_is_cn10k() || roc_nix->use_write_sa) {
+	if (roc_model_is_cn10k() || (roc_nix && roc_nix->use_write_sa)) {
 		rbase = outb_lf->rbase;
 		flush.u = 0;
 
-- 
2.34.1

