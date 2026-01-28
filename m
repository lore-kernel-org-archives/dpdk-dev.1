Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BB3D3567B
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A4F400D7;
	Wed, 28 Jan 2026 07:03:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 472EB400D6
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:03:37 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S1NAkx3583568 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=jCnDAkReCMKTlAiVnm+hYPk
 euik42/oORY9ispJG6ZQ=; b=kUrCcpjMIR733myhAzjzg8rnsY+JB9oHr6Pyg1U
 ORkryRaD0norBHazzqPfQp048PCbTGczM1kHZ1d93z7wDqAnm11s0yZ8qsiuhhae
 WidJw0HJ8R/WacTghiWFhgp0BAt8wRNr+WJmghA0WIhUr4XWE7i5yq/166J93OpU
 CxV2esHatApby6iJo8twmpIf7ZmuFB1plLUrI4sOhyXun4dOcns3Hj6KGafxNnSm
 G9yKs8BWVT5tLuAzedCJCGa5QM3nz64hrH88iEdYUNEsXMvXwr4hqtN2V3+z/eKk
 OcnnZA8qy+DcO4gBvIzY8bjBW0qHJJrC0XuSSmfxVfzVLww==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68exu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:03:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:03:35 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id F358A3F7072;
 Tue, 27 Jan 2026 22:03:32 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 01/18] common/cnxk: fix engine capabilities fetch logic
Date: Wed, 28 Jan 2026 11:32:59 +0530
Message-ID: <20260128060316.3967610-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979a6b8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=4AIo4pG-FwSD10GPDhcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfXzGYHYXgHD+1t
 UMYrlAekvbOEhBaGkdFLNPRaKD6Jm+9B2HnNKKAZiJbvpbFfRv4NofqfHd3XXepL5XHOZU/SY3r
 9HJAIMWZASOfE/9aL2eJHSkushJ42z6ns/rzUrv5ykzvZ/e5a7yq+TvaMvPxcsE/2Sf29sWfDHl
 ldWH4loMhw7LiatH+Xtd4XjSIzRuSUHgCJVFr2KMCUXjlNkuC+3Xau/OfOfSBNEsLnycNl03S2X
 v18SypBtOirSuYR1GDp9wQzPXWxs4V1AYJxt5HBk2wRCwejDJUNoewZUGpjvJQ7PtaWWiJD31tm
 ky2y4aQrRKbXEQ2en56GKS1rBFYeNlUkwQ2swBmzuEo+zUQPYqVwQHqsI8TVxcybsMKt7+RRbrb
 AGi0hnxRu2mjiTXOE+QHZp3qn1XyH7kggKa7M3O9bjGceOOuz0uZf3RvoSHuE3DimLNZWZphXnh
 NnmeyaAZEvv0pOtprEw==
X-Proofpoint-GUID: 34Z1M0KxPPTp5C42t_z3E7x6HGx11aOJ
X-Proofpoint-ORIG-GUID: 34Z1M0KxPPTp5C42t_z3E7x6HGx11aOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

While retrieving engine capabilities for CN9K we are
checking wrong for status LOADFVC instruction resulting
in loop.This patch fixes the same.

Fixes: 7c67c489d466 ("common/cnxk: fetch engine capabilities")

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 4 ++--
 drivers/common/cnxk/roc_nix_inl.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 600098ae1c..14d29e605a 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -1397,7 +1397,7 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 			plt_err("Expiry tracking with both packets & bytes is not supported");
 			return -EINVAL;
 		}
-		w2->s.life_unit = ROC_IE_OT_SA_LIFE_UNIT_PKTS;
+		w2->s.life_unit = ROC_IE_OW_SA_LIFE_UNIT_PKTS;
 	}
 
 	if (ipsec_xfrm->life.bytes_soft_limit != 0 || ipsec_xfrm->life.bytes_hard_limit != 0) {
@@ -1406,7 +1406,7 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 			plt_err("Expiry tracking with both packets & bytes is not supported");
 			return -EINVAL;
 		}
-		w2->s.life_unit = ROC_IE_OT_SA_LIFE_UNIT_OCTETS;
+		w2->s.life_unit = ROC_IE_OW_SA_LIFE_UNIT_OCTETS;
 	}
 
 	return 0;
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index f8be98efd5..683a9cc7ce 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1228,7 +1228,7 @@ nix_inl_eng_caps_get(struct nix *nix)
 		do {
 			roc_lmt_mov_seg((void *)lmt_base, &inst, 4);
 			lmt_status = roc_lmt_submit_ldeor(lf->io_addr);
-		} while (lmt_status != 0);
+		} while (lmt_status == 0);
 
 		/* Wait until CPT instruction completes */
 		do {
-- 
2.34.1

