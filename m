Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7928D1D86F
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 06:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6849E4029D;
	Thu,  4 Dec 2025 07:52:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 25EEE4027D
 for <dev@dpdk.org>; Thu,  4 Dec 2025 07:52:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3NlM7T1016141 for <dev@dpdk.org>; Wed, 3 Dec 2025 22:52:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=yw5l0x2H4VQslRRCROhG0GD
 pPcKxQZukjEIJaeOZAXo=; b=Mvbcred7/e56YjOYriBbLk+pJNakB1jCdcNy6yR
 A9taVHAiz9OuOs24AX7tS3w1QUC2462DOmnkOFmjkmqcjS4DomF8cwd1LxdTp1mH
 69lUosssqAzWV9iN1MZq8igIsv2aBJC9p//djdvENeFygqaYo0+hDtAX+a55LWYM
 J9XLpoF2PhLJRjKUNEaEwMfcTM+UFst4JTB1ZZCEMTFNpMFCKE8KJ3YAnv5DG3Ye
 rx7UoDYHJcJPxJ73YvmhirxW0etm74fL2ctuFAuvAloFd0JLJh3IMLglF8dvVTks
 Quk8W7mzomqZ/HlRFZ06rk78BwfNAESqq06y4J/r1tHEjzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4atjuu2p85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 03 Dec 2025 22:52:15 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Dec 2025 22:52:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Dec 2025 22:52:27 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id AB1463F7044;
 Wed,  3 Dec 2025 22:52:12 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH 0/2] cnxk: Add HALO support for CN20K mempool
Date: Thu, 4 Dec 2025 12:21:31 +0530
Message-ID: <20251204065203.1866809-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA1NCBTYWx0ZWRfX2eKvhHAGm5LX
 EzaoviIjU9e3oSAB5E4is6RpzJavojiYn/goW8U63bGlnJ+NaOOw504fZ0CZPR1IP0k/VxU4rpS
 2Ux5i1jkdBQSdR7NgEel7zSh5RQ/RLtSb+38Kt9tjFXys8yA7KqI+xuwSRZLCN5Rl8UnSM8iUab
 E1hDKRBMIcRE06pqCJvI1G7jdBbMaMO8KjO/O2Ofgopl9cgXy8DHYe624GKr3zfphFwt55ygMJG
 VTJUGt1NRXrrrvTuP22m9Y78IJSJhuBZeFuHqhrjHkxFHswQ7R6Lh08DXQCrhnuEJF/graNnpu0
 mmKGshMfHtOZFGGnS/WtG6muYqCv74H1NDJxBn+9OOa2yb3Xs+vR8IwypJKfuemdjp9qJoRTkKE
 eGgv8t+yhdyaqWMIP4eXbRGLgbDz0g==
X-Proofpoint-ORIG-GUID: 98bvDnNtu6hjaZapphlp4LOBrMGAsM5P
X-Proofpoint-GUID: 98bvDnNtu6hjaZapphlp4LOBrMGAsM5P
X-Authority-Analysis: v=2.4 cv=E/nAZKdl c=1 sm=1 tr=0 ts=69312f9f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ie_s_1RjWHafuwhorpgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
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

This patch series introduces HALO support for the CN20K platform.
On earlier platforms (CN9K/CN10K), the NPA mempool required separate
aura and pool contexts even for a 1:1 aura-to-pool mapping. This led to
unnecessary context usage for the most common use case.

With CN20K, HALOs allow replacing this 1:1 aura/pool model with a single
combined context, reducing context consumption and simplifying mempool
management.

Patch 1 adds HALO creation support in the ROC common layer.
Patch 2 integrates HALO usage into the CN20K mempool driver and adds a
new "halo_ena" devarg to enable or disable this feature.

Nawal Kishor (2):
common/cnxk: add support for halos
mempool/cnxk: add halo support in mempool

 drivers/common/cnxk/hw/npa.h                  |  81 ++++++
 drivers/common/cnxk/roc_idev.c                |  25 ++
 drivers/common/cnxk/roc_idev.h                |   3 +
 drivers/common/cnxk/roc_idev_priv.h           |   1 +
 drivers/common/cnxk/roc_mbox.h                |   6 +
 drivers/common/cnxk/roc_nix.h                 |   1 +
 drivers/common/cnxk/roc_nix_queue.c           |  46 ++-
 drivers/common/cnxk/roc_npa.c                 | 268 ++++++++++++++++--
 drivers/common/cnxk/roc_npa.h                 |  20 +-
 drivers/common/cnxk/roc_npa_debug.c           | 201 ++++++++++++-
 drivers/common/cnxk/roc_npa_priv.h            |   3 +
 .../common/cnxk/roc_platform_base_symbols.c   |   2 +
 drivers/common/cnxk/roc_sso.c                 |  35 ++-
 drivers/common/cnxk/roc_sso.h                 |   1 +
 drivers/mempool/cnxk/cn10k_mempool_ops.c      |  19 +-
 drivers/mempool/cnxk/cn20k_mempool_ops.c      |  60 ++++
 drivers/mempool/cnxk/cn9k_mempool_ops.c       |   2 +-
 drivers/mempool/cnxk/cnxk_mempool.c           |  40 ++-
 drivers/mempool/cnxk/cnxk_mempool.h           |  16 +-
 drivers/mempool/cnxk/cnxk_mempool_ops.c       |  11 +-
 drivers/mempool/cnxk/meson.build              |   1 +
 21 files changed, 750 insertions(+), 92 deletions(-)
 create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c

-- 
2.48.1

