Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE1CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:44:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913964028C;
	Mon, 29 Sep 2025 11:44:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CCCF94028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 11:43:59 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T6iYou029607
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:43:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vSOOzODJRL/k31h4rr0Nyb3
 f2fgsIcr1tELlkV/iVhs=; b=jPGMSdQsGrfztHiH18dlMz8JuwaXbaDQBrJIvjG
 Tzg+sCa/FIRqZEAu6QqLKi2AdPPj+/4GJaYNnwiWABtTWDAU7+3HhFMxPOGbtlCn
 57Ot8fMkakBPFxMlJLNc1l9Xd4xBaOx2oSvKDmiwJE0pBfsrlqwMQwd7zgGM4ea2
 MGue7Do0DMN4RRCrRWKFlpCRLN6mGneaBe/zyb6+bhlI27UFhkXnM+O2iugkglyF
 0aTmIQaJhPlfoaLgSjrwEgSBT+rycWt4mziITB6gi0EVwfaaQt6CVKcVHO88pfJ+
 ySWvIlRJQ3AU4zPYXDLqT2UhFUCUlx6iTqls3A6hR9RBFfA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefba77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 29 Sep 2025 02:43:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:43:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:43:58 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 183FB3F7059;
 Mon, 29 Sep 2025 02:43:54 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 00/10] fixes and improvements to cnxk crypto PMD
Date: Mon, 29 Sep 2025 15:13:43 +0530
Message-ID: <20250929094353.1027744-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zx96rpBvJKzMmB14s36Kl91yO_YJNfji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfXxnW0TLlF8Yk/
 7oPK66kKpdgPSzcuVQ7/YL2sxKaxvBskEa7PajsUAsG/oO92SvGhEvxuVXRx4kC4wf32ms8daa7
 clKthhZ5nOR6pQNnnPVHIh/3IU3jWz8AQDY+OS1iooYDByTsthnEuIQx89xerp0VGvDMeX8fK88
 0d3MFRbN0GVnhUp7l3ELtFcCzFc0F+FhTaVn2h6NDLZ9covw/RCq8a+8iAoGEgYI9Fy1ippeOMu
 msnnoFw8pq7MFeIWXdokrkq2Kqu3K74t8tm0eHxA0Lisq/zTm/iEei+dXfDnUdiZc/I/qlqp4P3
 bngJDuyeQLmXGXZT4BZcB9r1xOGB+ZPZLC+xCqG8RT4O9J6Qp01/YICJR2E4VbgGW4PKvWgrmMv
 9g6g1EecAdnv6mOsyqWLnOY8OBWvmw==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68da54de cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=wQpQ-QugGdBdeMo4P64A:9
X-Proofpoint-ORIG-GUID: zx96rpBvJKzMmB14s36Kl91yO_YJNfji
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

Adding fixes and improvements to cnxk crypto PMD.

v3:
- Removed redundant code
- Added two patches for fixes.

Nithinsen Kaithakadan (4):
  common/cnxk: get context ilen as devarg
  crypto/cnxk: fix compilation error and warnings
  crypto/cnxk: align cptr to 256B in cn20k
  crypto/cnxk: fix tls mbuf sanity failures

Sucharitha Sarananaga (3):
  crypto/cnxk: add new API to get fpm tbl address
  crypto/cnxk: add new API to get EC grp tbl address
  crypto/cnxk: refactor rsa verification

Tejasree Kondoj (3):
  crypto/cnxk: align PDCP API with latest firmware
  crypto/cnxk: support custom metadata with CN20K
  common/cnxk: optimize ROC layer

 doc/guides/cryptodevs/cnxk.rst               |  11 +
 drivers/common/cnxk/cnxk_security.c          |  20 +-
 drivers/common/cnxk/cnxk_security.h          |  25 +-
 drivers/common/cnxk/hw/cpt.h                 |  14 +-
 drivers/common/cnxk/roc_cpt.c                |   7 +-
 drivers/common/cnxk/roc_cpt.h                |   5 +
 drivers/common/cnxk/roc_cpt_sg.h             |   1 +
 drivers/common/cnxk/roc_se.c                 |  10 +-
 drivers/common/cnxk/roc_se.h                 |  37 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c    |  56 ++-
 drivers/crypto/cnxk/cn10k_ipsec.c            |   4 +-
 drivers/crypto/cnxk/cn10k_tls.c              |  16 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c    |  59 ++--
 drivers/crypto/cnxk/cn20k_ipsec.c            |  80 +++--
 drivers/crypto/cnxk/cn20k_ipsec.h            |  15 +-
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h     |  41 ++-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c     |   4 +-
 drivers/crypto/cnxk/cnxk_ae.h                |  15 +-
 drivers/crypto/cnxk/cnxk_cryptodev.h         |   1 +
 drivers/crypto/cnxk/cnxk_cryptodev_devargs.c |  49 +++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c     | 130 ++++++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h     |  26 ++
 drivers/crypto/cnxk/cnxk_se.h                | 340 +++++++++++++------
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h    |  96 ++++++
 drivers/net/cnxk/cn10k_ethdev_sec.c          |  14 +-
 drivers/net/cnxk/cn20k_ethdev_sec.c          |   8 +-
 26 files changed, 784 insertions(+), 300 deletions(-)

-- 
2.25.1

