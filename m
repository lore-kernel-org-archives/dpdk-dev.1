Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F037CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E4840693;
	Fri,  7 Nov 2025 11:48:21 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 288B140693
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:18 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A79CHFJ2746472 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 g3t6i888jM1znbMAvXnyh2tOcerRydyiEO40Y9+r0Y=; b=NXoYe8o+2GkgNwzOi
 YH/pE85H/YqTg6DnpjvQn0f3TKcH8kETC51gAw215K4E5YuH+8kFzU+EQzYJLF3t
 di/ciH/TX5q/R09iTG+22GdU99v4UNemVVJpTVsFMu4u0jFT7g037WqmYYf7dtJj
 imUVJc79DfP2AfE886ekBiZ90QCa7yefZ3Cu/KRnPMqmeO8Q3DKMshrtIOrI06UK
 iWBGG5fIhj5zUecp0l+au29XABNkh9Ov0DC7zXiHX1gqILM3S8KpY+NIjyxZ6AA/
 lBuc2u23sPk+KUMzbR2x/ZXAnJA1Gbxt4ymVTq3f0dUYSzmheZjQJJ7K8Wc4Pp5w
 q6jlg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk65snq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:17 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id A21CF3F70C7;
 Fri,  7 Nov 2025 02:48:14 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 08/23] common/cnxk: update DF flag in IPv4 fragments
Date: Fri, 7 Nov 2025 16:17:32 +0530
Message-ID: <20251107104747.1131008-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690dce71 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=shHwveO5flH-z4HOgfUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: WH2KNJpIFeQ21FxRgbTMI4n_mdQ__PB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX5scJAayIdZtC
 cyd0dhFaU9dlcRls5+P0bw0oIM3I1k2gUfmQhHk5E6TpnHzsGXu1ZfGK4WEtnDOTa5A5etYBLBM
 6geIasRXgtHYG/d4JV7CtKm+7mJwcAMQlTg6XhmLTfHOU2osyGyvtmOJQQRvPpPI1FTn0eY6w9B
 6/emG7koB06QRZbtPVx5pffhFzzZ7rDfYk/sJrKY/FOEge+x2KVW4+A2iJz3OM+DhBN5xAOSsfs
 HVoDCGRQ20j/n7gKwLFxgmSmGI2uMewjIAz5J31vbx6WCUaYObRH8134WbxpdxVP4aE2NoBhlnP
 dJ+BGG2BbBp9TFf2y8YBp0usytOpL/uvXGZqkgWYpCZBUCh0aW+Xyt4Tav9wqx1wWU+7tZ87vNQ
 Ph1MTiskgBZwQLOtNeOD+jBgvkSO1w==
X-Proofpoint-ORIG-GUID: WH2KNJpIFeQ21FxRgbTMI4n_mdQ__PB5
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

From: Satha Rao <skoteshwar@marvell.com>

While performing IPv4 fragmentation, consider the DF flag from the
original packet header instead of setting it to zero.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 138090317a..12a12c6e35 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -240,11 +240,11 @@ nix_lso_ipv4(struct roc_nix *roc_nix)
 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
 	alt_flags.s.alt_fsf_set = 0x2000;
-	alt_flags.s.alt_fsf_mask = 0x1FFF;
+	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
-	alt_flags.s.alt_msf_mask = 0x1FFF;
+	alt_flags.s.alt_msf_mask = 0x5FFF;
 	alt_flags.s.alt_lsf_set = 0x0000;
-	alt_flags.s.alt_lsf_mask = 0x1FFF;
+	alt_flags.s.alt_lsf_mask = 0x5FFF;
 	flag_idx = roc_nix_lso_alt_flags_profile_setup(roc_nix, &alt_flags);
 	if (flag_idx < 0)
 		return rc;
-- 
2.34.1

