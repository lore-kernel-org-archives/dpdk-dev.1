Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3692CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0C454066C;
	Mon, 15 Jun 2026 18:26:20 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C871440663
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:18 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbMIo279834 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 xH+TyEyyGfIsyjmT0T9YGBBQml6YAe3tZzk9sMNGNY=; b=Xt4JJZ5Zosy0/w3v4
 li929Rx9zzbKAOPhuljQ/JSs+qKHVbaTfn8PFgvs+CMsKDcr+YVHJU1Z98D0UEEn
 qsd4JFzyUSAWQS5VxGCh5BvqZmK62R5S34vX8i6AvWyM+LYBu74mI+t3vYtT4EzW
 k0GAVGhXnMU9cyTT1qaXgqjZ35PoAIjlm9BojCFmWSAdkwP490w4u0RZnY9ZgPMw
 VJrP0c/RIv185+XX/uFno8H+hwQXA7TCxAQT7aJEyFp8jk92RG/OFBr20JnmaDy8
 X+HV5vi3Jot2ljr7v8oUD0qZ4//CQpPqR83WM53GbZ8YPOSrseJxUO6BCEAG+4h6
 NDD3w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8vphh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:17 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 8F00E3F7063;
 Mon, 15 Jun 2026 09:26:14 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 05/20] common/cnxk: configure LSO mask for single segments
Date: Mon, 15 Jun 2026 21:54:31 +0530
Message-ID: <20260615162446.578336-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX783AxH8G797Z
 O/8Tm/GHMbqkZOyK55s+YJrkZimWz5AithT9qpBCPHdH5htNKup3jB4LvZiCU0RrB+EYZNb0AO2
 cAo62yCDi2rDsVQ6xm4uRuWKB8Kk0t8gNWJn/Nfkdcu+TSDFk+MPq6XFxLNt04Jk6z82/I3TiML
 cRtWWpMzR3DkMVTowhruDoh4JHm2DsMpqjUgpYGcQLfnNJYg2v4P72vsptJGTuYCRjGXjiJi0tF
 20av94LGVfapEsCUYD/isRwab4+GQoEWDqOZkxMn95FsBsX3XCvXqdPfUPVDhDSJN5TQ6volGyV
 W+sr3HVB8pZ/Ocr6EuCwW/7vl0nl4gPGG+hgQGrq0k0jg1vhKOsek6EWFfC/Hv9zIPTShk4sWm+
 NB0M5pNFvaEvAFz+XOFBPOBjN+E5JHm2HMYL1RKOD8hLtpVptbX8vocXVnkaTjMDINEu4/4NE3f
 CIJgoEggW9uwAldKQow==
X-Proofpoint-ORIG-GUID: zpHCu5uybG1haiK8pn03QEjfUcs9cz_r
X-Proofpoint-GUID: zpHCu5uybG1haiK8pn03QEjfUcs9cz_r
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a3027a9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=HkXQYvCU1nhRFysMGnkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX6VTL5JkCQRVZ
 RE1zXhozUYBuAyEpTvS9u0tZv/++9mFTjOHQ+TtnhNFwQsoT6aHH3EQMOiGQLKkNGC56/Bwo7Im
 FAL+BIKUOMMQYWATRrAU+4b3ttja2bk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

Configures LSO flag mask for single packets.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/common/cnxk/roc_nix_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 12a12c6e35..4653bb2049 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -239,6 +239,8 @@ nix_lso_ipv4(struct roc_nix *roc_nix)

 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
+	alt_flags.s.alt_ssf_set = 0;
+	alt_flags.s.alt_ssf_mask = 0xFFFF;
 	alt_flags.s.alt_fsf_set = 0x2000;
 	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
--
2.34.1

