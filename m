Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C50CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:39:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D35840E2E;
	Thu, 13 Nov 2025 05:39:06 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9096A40E27
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:39:04 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD0Zsv01254507 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 g3t6i888jM1znbMAvXnyh2tOcerRydyiEO40Y9+r0Y=; b=U0O9iKiPaTDyAItiU
 xHvqcF2C6awt0wReJgDeg+bDHJlWh5RIJbVIHpaEKbVTArEV9y0UZzrguG3duPSp
 tMqmt/rdoL2sHjmYiSWCFDuuvEHZaN73WJ/epibTCgxuV4rqfhb/+m6HtStLyadN
 BHEtu+Uybomq4JDKTyrKEMSeXyYklKELi4YhRmPqfW+X+EykyYpkEW4H0QyTlv2p
 JiAPwPqSNVNxCylKrlFS8fukDTu+LBUemFw3NmmuwvlSL0HcOfkgQmLawTB1Me1L
 QKUA737WFHWJyXfb+8ZucWMuhCRtaN2hDqHgx+ju9fqIKmDqFOFmux3hpS+jfjkE
 W2WcQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad4x7rf4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:03 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:14 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 170C33F7076;
 Wed, 12 Nov 2025 20:38:58 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v5 08/23] common/cnxk: update DF flag in IPv4 fragments
Date: Thu, 13 Nov 2025 10:07:53 +0530
Message-ID: <20251113043808.1180851-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX+0VGK6ieQc/S
 hHKU6kx6Tqrb+cTFtPfwOxZ3clrcBK0DaHgxzTi4SBjXxXv0o59qLrjQBaSx/tYjXRBGiQl2DXE
 FVutHtPTjGWyWZEAw4s0kIjOLG9pL+8uWt8g3P2oIi8cVlH/r/r72Ja8lgKC2KITRHX9b3qm1/A
 XjM2lFH29xQa9qHjiBItYK+nOuOcV61VUxH8z4tR4NNwH4qB5nlfySzQ0VnaONdAa7hvWslWy5N
 pJGdF6WAeJFyuE/6GlYdQJYXLVhLF5C/JMXFsWV1TsjbPGA31/yvS+xA8/9gHQ+dGlShsvX8Zib
 0MpW/k74Yt2U39ZwIrN1U/ssxBQCbMEC2H05V11UmlC2LpNvc2dGC8tK9h7+iQRWS14IPNxSG+U
 iQdTBoE1E2yDBa+lX80fOjsayd0NDw==
X-Authority-Analysis: v=2.4 cv=EfnFgfmC c=1 sm=1 tr=0 ts=691560e7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=shHwveO5flH-z4HOgfUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: icENTntYKn3SUGvtqyHs2bfSv2ABwxAv
X-Proofpoint-ORIG-GUID: icENTntYKn3SUGvtqyHs2bfSv2ABwxAv
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

