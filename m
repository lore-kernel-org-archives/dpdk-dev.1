Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B2CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 06:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A0DC40677;
	Thu, 21 Aug 2025 08:13:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A2EF540674;
 Thu, 21 Aug 2025 08:13:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L5vmCM030362;
 Wed, 20 Aug 2025 23:13:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 LnaetlvxkZ/CIzDL8PPVpEvkQy1NlT+1NYbwt1QSWI=; b=GJvS15849ArhdKFRQ
 2EsCuvnWd4N2RbwYY6E2nmd6UpOZ+k8/7E3uWUHgLzc1phHV+lfPbpucpgECZITp
 Df7fLrBxYJBAcawNkCa5nooIXZeCWiY9nfS3ZMDeA/rQziqSYCi2gpJz4wMWnylO
 yjuTLnOCXei6n1P0BqiS0MKtl9p6flqlcI10bVed5odThA94+J+DNbwE0q9xD6hk
 AQymy7wRqZ4EaeXZa7EEeeUhje+wZLhWYmcgBoJr0OW6NIxT25KG+YT+cC0LAocM
 77zCVpzCtsqE/xz1oohpEy2y2J/cRqhVaQKewGbXc2OuX78txYP/U1nCDY7O+G+B
 vijFg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nws6817n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 23:13:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 23:13:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 23:13:58 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 584C13F7097;
 Wed, 20 Aug 2025 23:13:50 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH v2 2/8] crypto/cnxk: fix compilation error and warnings
Date: Thu, 21 Aug 2025 11:43:35 +0530
Message-ID: <20250821061341.3790775-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821061341.3790775-1-ktejasree@marvell.com>
References: <20250821061341.3790775-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fMYzyudvgIz8kzosbHSZk_IzhEt7bdUH
X-Proofpoint-ORIG-GUID: fMYzyudvgIz8kzosbHSZk_IzhEt7bdUH
X-Authority-Analysis: v=2.4 cv=A/k1/6WG c=1 sm=1 tr=0 ts=68a6b922 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=JO9r-knm2aUZGej8jHYA:9
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0NCBTYWx0ZWRfX2ZIjnlbVh0u8
 UyWQSHVERhlHqteSJouzz80PUAbuHO+SOfOafZ3zUPwBSJkSaUlmMd1+esxaOCsvqY9690J1FBo
 TwWVWTgV9b/cyWAXus6FPj7PQl53IrUsYLZ21g45POXz+WbO1IhD00FQbz5b52dPfUPcP1yWsBX
 Xr7cjgK9+2nxMQNgtLtBs7Dk15wh7QmL0AuiNBJMhR+tSEfsYvE2n9luYwMpHIv/hHr5NA7Pyzw
 L1+EhLcijy5680P+N2b6ueahpsI0n3Y+KPXTS4ByX6Quf9fTjzv6Q0Bxw6ksLlbmX2g3MaLwbVV
 tzXKHXdpZHF/9gKch89cCL/PqA31VTw+d2AfqqdafDArXSbzbngHrcT1FrgSDh6f9C9lY8Kh+MJ
 gN0mIqR+Z5wgp00wlfygLrlGHU/hbeG+RlhgdEIZWZBSVWejPX/iaOlTaE+XaymnK7aHeGLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
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

