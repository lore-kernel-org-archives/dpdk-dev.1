Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA0CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 05:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B5840292;
	Thu, 21 Aug 2025 07:24:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CAEF84026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 07:24:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0oETf028554;
 Wed, 20 Aug 2025 22:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=fmF/kj00Gus+AZPpNSMOcjr
 pUQvvQDMp2YMz00bL42M=; b=AcpfUJ05l7xvXYPo2N7Q8Tmh+jlw/saxlroFadI
 7ufn7gg5J7TlyMf/NdjoOVQOuHvnx8twyuRCSFhQN3yd0uqLOQ4FXG4lxqEDWS35
 r/d8wcVPaAjdbHez2G3Ki/+rDcz4dlvF7iwwjL5dGPTm0UHdwbXjAibWGr8JfFqy
 eoha8MW/ljdLv/awT4eTxFyFvuISjCfkTUPSuPFZB38YnxaAAMVi+FFjeZBVb0lq
 y3GATH2VHNiGtC9zRdKAyYXVeQ7e78HEtQwf4j8sK18M00g1J95XKd0edR/PbyGv
 NCUM9Y1w4/PpbOcDsUgjYAmkISCwd14kZBzbXryagJNksjg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr2m8kjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 22:24:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 22:24:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 22:24:52 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 4573B3F70D1;
 Wed, 20 Aug 2025 22:24:45 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <kai.ji@intel.com>,
 "Sucharitha Sarananaga" <ssarananaga@marvell.com>
Subject: [PATCH 0/2] app/test-crypto-perf: RSA modlen validation and asym ops
 fix
Date: Thu, 21 Aug 2025 05:24:38 +0000
Message-ID: <20250821052440.3213146-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0MCBTYWx0ZWRfXwlyO2r0FPGwD
 LtD3LH9T0Gxnqf/+4kktlc1haHqAEHmbuUmdzCrikkeoqUFdQXUCVmKI9ybsbG4funJQZkxRi3d
 L6cuogP0N7ExGm9GWLylLQeLjwyStuyEUfgRzjesSk4SdiGcOG+A2wPdISxLO4691ZkooJearCt
 XuQ65Nrimc7WEh/YIbExQi5nUaBAv+GgoQS7bS8n70rJ1PNuyFqnybvnPiXB5wRa2Ae1aHVy6q8
 Poj2SJZO0GHYahWV+ZqJL7bOjEcKYnSRWRiKGvSdpkYjkDvKFW5cCdKebN8Po+KHp2BkreCdh+X
 oH3OoYNiPH2ilJlYcith06sQL39ozductBvjsXFA6tyeWjpQl78OdtR9tdnoHgDzs6ycGrh/J3p
 ++RUfZxQRlz1ntJhhxKUawtAu5LCEjuG9SeF5gOajkTrHZIhzwuUBzd36Q+jSpsduRjIagRT
X-Proofpoint-GUID: lOp8DI2pft-0gGVV7bFO3cVFFeHR196P
X-Proofpoint-ORIG-GUID: lOp8DI2pft-0gGVV7bFO3cVFFeHR196P
X-Authority-Analysis: v=2.4 cv=LOc/gJW9 c=1 sm=1 tr=0 ts=68a6ada7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=t5NRGmGhVjxxedjfy1MA:9
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

This patch series improves the robustness of the RSA performance tests in the crypto-perf application.

Patch 1 introduces validation for RSA modulus length to ensure only supported sizes are used during testing. This helps prevent invalid test cases and improves test reliability.

Patch 2 builds on the validation logic and fixes the execution flow for other asymmetric operations, ensuring they are correctly handled when RSA modlen validation fails.

Note: Patch 1 has been submitted upstream but is not yet merged. It is included here again to provide full context and allow reviewers to test both patches together.

Please review and provide feedback.

Thanks,  
Sucharitha Sarananaga

-- 
2.49.0

