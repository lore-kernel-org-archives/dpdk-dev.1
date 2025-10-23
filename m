Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A2CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:27:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C869E4065A;
	Thu, 23 Oct 2025 19:27:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A7BC9402F1;
 Thu, 23 Oct 2025 19:27:52 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3d0HA022499;
 Thu, 23 Oct 2025 10:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 I4Ox9OPjGLqq3QjLNxBHAN+zVij0kUv+UoF7xBpZE0=; b=X22ceq6m71TD7PoGe
 rVw+eFGvVeENHcBfv/9zQzG7PUkjDzPJcA6hGLDBIx7JDiS0xK0hASX/oLUplTT7
 GRRg4dNFE63sKrlBqM3YvYtHFR3WunCBCHjWtsmjrFkg/qdb/9E1OC8xToFhC/X+
 csWMR/9mUkQ2TvVfBQE2+jVJ9QYX1DWIhWg8jw9CJpGjcDQ13Nmti/ZYYWmvrzZn
 BCWc6QuOVdAgXlG5M0e3Ai100LgHShy+mPCQfaUlE96n93fQDxrr4TNj8bNfNDpm
 +UluHiqpWV3kH5bvIYAj+eOra86rR+w+e1ZW52s9bdaZFrSyZhZpNnLqcvDBCAc2
 1sYIw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w5f-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 10:27:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:46 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B6C0F3F7068;
 Thu, 23 Oct 2025 10:27:43 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Monendra Singh Kushwaha
 <kmonendra@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 05/19] common/cnxk: fix inline device API
Date: Thu, 23 Oct 2025 22:57:13 +0530
Message-ID: <20251023172728.770661-5-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xm-mPPvnDZc27OgEN-apzy-asRBQ-1U_
X-Proofpoint-GUID: xm-mPPvnDZc27OgEN-apzy-asRBQ-1U_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfXzwHWu7u0lnjD
 vxzAFlWmuc+rNCPFTzC84EBZihAE5jneBUI+CW8lc5oAKFSF/HUHYAmVyOq3dNzcJXeYWPUMZ0w
 L1e7ia++C52n7nTbdX/b/Hcp7GKCU5suVxuuZdIJHJWKgbhxA4RvNZJBg9wagO4mxIHeqpQgKDt
 wXBRfuEP0D6DKt1E7rWCSc5JytZobSFieho4RsTLGkUwysQUyZlnihCj+cuS1VJqG3pDIWRv58u
 CTs4iDbaDLs4WB07Lov+E9Thv77ujQ0PIPXHZmyCm7GeB0YyIQuB4OIW1fI1kV2lesMsgBdLy8a
 uOfxOsmRFyj12cV0l6YxdWXEWcxvxkDdfjLq8hyY2Q3Bog0oN3E/GCNcq/Cuv6p7tqjhB8JqDIW
 xQgs97HHcFN7UKSX18OCn7C/D24MJQ==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa6597 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=a_7jAOaszgFUf3AtnaMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
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
index c7637ddbdc..a5fc33b5c9 100644
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

