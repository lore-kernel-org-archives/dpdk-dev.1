Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099CCCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:44:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CC2940691;
	Mon, 29 Sep 2025 11:44:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4ED11406B6;
 Mon, 29 Sep 2025 11:44:07 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T9cRKk018721;
 Mon, 29 Sep 2025 02:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 LnaetlvxkZ/CIzDL8PPVpEvkQy1NlT+1NYbwt1QSWI=; b=OuJqV1ZrL5Nr3h4cJ
 /4H/TCC6cCiWt7KBEuSoeuPo0FLhbWq4S4Jeeh+VGGkhTqk+BZQrYzjfaaanwNEF
 CDC+pZdEVJegtmkfHijUAZu6Hpp543V8Yyj2OFjERtcTfM9T91rbm6WBO63Buizu
 cCgtuo323WD8SA35mIWwhjGP04lZPPA1BVI7/JkIh6xbBU6U782bbG9RWfPjQU1R
 NsoZEGKB1xtWDxVxCHUqZFImxrkaIo/TY8AAur8zOhsQd+Kyfv+neZOJcXAh0b6c
 AEmvi+fIVBrdOTCKvl5cU3KRPQnNFlqad1lXqtmFJ6xakJRsXWwg1212SFjQ2y5j
 lDFQg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefba7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 02:44:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:44:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:44:13 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 253C03F7059;
 Mon, 29 Sep 2025 02:44:01 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH v3 02/10] crypto/cnxk: fix compilation error and warnings
Date: Mon, 29 Sep 2025 15:13:45 +0530
Message-ID: <20250929094353.1027744-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: x5YSht-qR7m6GCybFU2CxoscGkhtyRMM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfX33eB+V0b3G39
 5woOVz/3yyfsMA+59wDD0PkSN7hhBpglZAP37HQPPjx6swC9YtpfsC5Mj4WLr8cgjnHNkYcylB1
 h3DeXaDEjWtx/L3bc9RmAfcSqok8/YeLUM/gyjo1Tezqhg39yJ+EO9mm6WSqCyY2S4eS84Nrs8J
 BzaAs9Dn4Yd0VLIYRikphDECCbf9MJwzL3SGP/7uOztfHKEtQ4kGEOKoUd1b4258Y9hgPwrf8cf
 rwz1B9B/BrasZPeu/mrBFdnUvjemAuD4XRfQPIvAfvgtvDDS1RQfFQ9PHibhrCT+Uwl4c4nzFMi
 28hQ3QpPJ+bEtoLlfn9/anaUjqdULqC6B1BCJvvueJ5aLGa0akoiedmrRV8Ggvbug3t8KPlbOc5
 7dUVIm3XyIKg0HNG6sFamw5pWkZzNw==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68da54e6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=JO9r-knm2aUZGej8jHYA:9
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: x5YSht-qR7m6GCybFU2CxoscGkhtyRMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
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

