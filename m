Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D3BC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C90E4111B;
	Wed, 18 Jun 2025 14:54:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C0DCD40E1C;
 Wed, 18 Jun 2025 14:54:16 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ICPJxf008946;
 Wed, 18 Jun 2025 05:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=J2x/n6ybqbbpupEyld85hct
 1xv8WSV6MiWfNcCTODsM=; b=YCjEIVhaPtQNOFakEWR5zIRrWf6Ne8FpSzit760
 RkWIRpJes22CABLm26d1wiwPALzyKsN6gcGwdUDaK7bLRoaYS95qB3d+MlAWhQHF
 YiAnlOwDiBJZRmLahPthcQq2SyrdgUS1ycBb4Oi7QC7znn6DV8o43GxqWzC0o5ew
 9PgMJ0WaeBhYbpP1Grs0CoK+Tf55gK7YG0DarHhV2syUKbrBN0abLL77ZMM4FZBR
 zHZGxFjoSUK/ip7c5XpAPzpQAMaWHuYCwnyiufAfwO+Cup2UOA2eyZTUGr2KBYKz
 t9hWaqpuLdbPzFrZYAJV4hNTLtQBF99QyB2ufQbQmvTqxMQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bwdg01yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 05:54:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 05:54:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 05:54:14 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id C38113F7043;
 Wed, 18 Jun 2025 05:54:11 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>, <stable@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>, <fanzhang.oss@gmail.com>
Subject: [PATCH 0/3] fixes and addition of aes ctr test vectors
Date: Wed, 18 Jun 2025 12:54:06 +0000
Message-ID: <20250618125410.767919-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ga0XnRXL c=1 sm=1 tr=0 ts=6852b6f7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=zU64uIDumI1-wLEfXIIA:9
X-Proofpoint-GUID: C6L313QeO6PK3K_qWkNv7Q6w9-XnnoYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwOSBTYWx0ZWRfX95x0C6fKmQ5C
 Vm6UC2iD20SeFxz1Sb/ZIJWbSVGrtEJ+3/uNaLYfgyKrNC7CnI63F9j5skTdvRaSvMtFJ8x2W9l
 jiZqkoojVry7fXa+KnJSPf1pzRz+547BwvX0tV9zoa18lRRZY+m8oWBkVFy183aop2LOftsyUx6
 6/ux9yp63GoJzwCxmgwsyiYgilo9DSCOlKvS0kTyGpP0uOOr479zROIRZc09S8SN5aFiY3GXwXE
 qsabVircN6G+f8wrBriXoun+Yx1yDSUeD0Sp79e9nRkpT8jkXnT2OCwByn0+f7R32CGRWk21Xdr
 LotZLKpRdpuLtzySoaAotj5HDmcLgscRBzO15B/ewAwB5fENlcvVZh+D6Zd4ZV18+3fTpWnC8m6
 Zj6QjEgtQp3A/Q1UTMIVTjBtzgWoqqdgv5aiTMjvt+CIJ0RDS4A3QLy/K7DAMLlDDGCEaS1E
X-Proofpoint-ORIG-GUID: C6L313QeO6PK3K_qWkNv7Q6w9-XnnoYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
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

Include AES CTR test cases and resolve test failures

Nithinsen Kaithakadan (3):
  test/crypto: add ctr test cases and vectors
  test/crypto: set iv len to 32B for auth and cipher
  test/crypto: set ptr to null post crypto op free

 app/test/test_cryptodev.c                     |  36 +-
 app/test/test_cryptodev.h                     |   6 +-
 ...st_cryptodev_security_ipsec_test_vectors.h | 316 ++++++++++++++++++
 3 files changed, 356 insertions(+), 2 deletions(-)

-- 
2.48.1

