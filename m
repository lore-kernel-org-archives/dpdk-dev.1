Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9766FCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A4394065B;
	Thu, 21 Aug 2025 06:53:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 410D44026C;
 Thu, 21 Aug 2025 06:53:18 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0oXLB016891;
 Wed, 20 Aug 2025 21:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 LnaetlvxkZ/CIzDL8PPVpEvkQy1NlT+1NYbwt1QSWI=; b=gmfSpSKx07SJx3d7W
 ROwNFtHqKjJjT6RLPvb1QZ6N4lDw04UDjq2l7yW9x6TxysgPWYPLm2J7KuVMJMXr
 BEi15q+JeGLrX+LcxlbpOOkt/hSl/YVDtXlkk4YPfNJ0SAfd5Ime8NLqyd3t0OjG
 bkwYKvCVWSLgIZ+YgOLYeTMGvhpiDV41iXqV8FB891P9nLQUsPDxM2rzAWJP0eoz
 78fxOolHk9lubdeJ2QeEjSHjLOxMwEdN0dY6CvM/9yycP3d/NP2uWsZ6OFH15qTJ
 4NCXqqwUAjGyVtX0QdXW5G10dFTmko8r+sjKMDgaDjIbNgFWIBA22EfDBUAOZUlO
 SUCqg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr3g0j0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 21:53:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:21 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 1D5AA3F708F;
 Wed, 20 Aug 2025 21:53:11 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH 2/8] crypto/cnxk: fix compilation error and warnings
Date: Thu, 21 Aug 2025 10:22:54 +0530
Message-ID: <20250821045300.3787899-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=St/JKPO0 c=1 sm=1 tr=0 ts=68a6a63d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=JO9r-knm2aUZGej8jHYA:9
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: -5Weo6_3qoWlmGBatEqbfJFYyjf3D72b
X-Proofpoint-ORIG-GUID: -5Weo6_3qoWlmGBatEqbfJFYyjf3D72b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfXwOg7IEtc9X+o
 IiCfyMqfQfX6OPLiT8Hw+RvSNnH6IEPJU1yaZT/cAF9AE2wVvIT2TssHlQBLODqbyLIRFb9IhlD
 Gf2nYAx20zBWFShyziAyQafM4pECs9mO+0p+uiVNv4zHPumpds+XcP4UPI4na+NZVQABV7WyyS6
 JyZLEnpn45pwBgGgAAn5oo1scO5Z7h6QeYONlvz0zIh60oEIPj/Z1jkc9DqnZ33cllfpCdoRh/U
 c82SvL82qtd9dYMybZXll7uGqDk9zW5XLKdQKdmW55oshByWzk2gF5l68zapdqPCJgEhwbI9GZ4
 2FN3Jvr5v/3pszQcsdZjg9uN84jgs5qa2cXqg+qOx4EHZKw4g3Us2SaMU1wnPCzD5Khd+H9lPP6
 9IRQFqsPuPq5eVZCmViy/MfdKmK6GikZMVzlqyHr4QRSZdAOw68HAaY4g3PW+fHDOQJziswq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Remove multiple return statements.
Fix compilation error in debug mode.

Fixes: 8fc370ee0208 ("crypto/cnxk: add CN20K security skeleton")
Cc: stable@dpdk.org

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/crypto/cnxk/cn20k_ipsec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index 8f79033ccc..0bca863492 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -373,6 +373,4 @@ cn20k_ipsec_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 
 	return cn20k_ipsec_outb_sa_create(roc_cpt, &qp->lf, &conf->ipsec, conf->crypto_xform,
 					  (struct cn20k_sec_session *)sess);
-
-	return 0;
 }
-- 
2.25.1

