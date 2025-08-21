Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E3CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 06:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C47A740292;
	Thu, 21 Aug 2025 08:13:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AD7D74026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 08:13:48 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0pTUB009804
 for <dev@dpdk.org>; Wed, 20 Aug 2025 23:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=KQy9qbf+Mc73+uBzGaZmqQB
 15LT5+hiGV7wuTG4rSl0=; b=HNPuvUa0iTgFrutp/FRDW+kYWgh84nVf5/rJHH4
 4fSQCo1Gl0JyKYo+wLis430H5n6V5pitzgHxRRphVKaLYOe/fQymc7+6K9M7ycmP
 yK7TIN8hwBUZMAozmDCaX8nXPW68vXsIF6k8x/zj0q2S3ThTbi4f4W7jccUp8Ymu
 jqCDKkZ6fgEYW0EwW5mAX9l4MizYL8Jt/My5jxCFATxPYoeZOF7ZjMrQzoZ/rFy1
 CMAVM+PnIIR20lEV8uIDdecXzVPMCvE62Pt1FhGtEU4B3zovDryTkJENw12mBbbU
 L5w0RVI5k1X4eCdieGgSff+ZLgIIyR1g5PGPmyrKaQhNJbw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nhhr9uft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 23:13:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 23:13:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 23:13:50 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 18E0A3F7097;
 Wed, 20 Aug 2025 23:13:42 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 0/8] fixes and improvements to cnxk crypto PMD
Date: Thu, 21 Aug 2025 11:43:33 +0530
Message-ID: <20250821061341.3790775-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0NSBTYWx0ZWRfXz6iIgzKjqggO
 aSFoZ9lFxuN+W7pMYXyoARCC/cxkCy/tXSEhUXS8XjcxKJ0xbzPQe6OC7BVPnACcF+oSGgZuIVm
 a6hHHMjXZBS/L6Y3HJGNen8gz3CLVA5vvP3Ipy0MkO3KY9zguynEnFQnl5JDnOLu+unR2wPgPyU
 4DhnAVDztWnIDIYF1myCM5pVOaSEtzS8FcqDchSjcwnNffEYRiHMVtmXYJ7VwI5n0+pS+ijuBY8
 I0N67lh+fCRM/ZHrG4eFlVDfPAB7tKx3L+ptYImcmY7lx+BNRf4D41Be7M5nJsYwXRcTm2Z1/EN
 CAGUijy7IhrZMPBLYLyrM4/QxjuU8ySwEDsaPz8wpK8FMfijud/GUpqAJpwQTC3e+Vusy10XxTH
 PxSAqiJ0xOHPrBJ/FMnLkKmOD8xbW8o/+eR4fCkFDkkDIj839OOm4q2XnjUa+37WxavNLRwb
X-Proofpoint-ORIG-GUID: rYdbqEf0dr6Okdvy_eeyfxNLfX4ECPoE
X-Authority-Analysis: v=2.4 cv=L/REg+T8 c=1 sm=1 tr=0 ts=68a6b91b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=TG_Foirp3Qm55mN1lE0A:9
X-Proofpoint-GUID: rYdbqEf0dr6Okdvy_eeyfxNLfX4ECPoE
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

Adding fixes and improvements to cnxk crypto PMD.

v2:
- Fixed coding style issues.

Nithinsen Kaithakadan (3):
  common/cnxk: get context ilen as devarg
  crypto/cnxk: fix compilation error and warnings
  crypto/cnxk: align cptr to 256B in cn20k

Sucharitha Sarananaga (3):
  crypto/cnxk: add new API to get fpm tbl address
  crypto/cnxk: add new API to get EC grp tbl address
  crypto/cnxk: refactor rsa verification

Tejasree Kondoj (2):
  crypto/cnxk: align PDCP API with latest firmware
  crypto/cnxk: support custom metadata with CN20K

 doc/guides/cryptodevs/cnxk.rst               |  11 +
 drivers/common/cnxk/cnxk_security.c          |  20 +-
 drivers/common/cnxk/cnxk_security.h          |  25 +-
 drivers/common/cnxk/hw/cpt.h                 |  14 +-
 drivers/common/cnxk/roc_cpt.c                |   8 +-
 drivers/common/cnxk/roc_cpt.h                |   5 +
 drivers/common/cnxk/roc_se.h                 |  37 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c    |  16 +-
 drivers/crypto/cnxk/cn10k_ipsec.c            |   4 +-
 drivers/crypto/cnxk/cn10k_tls.c              |  16 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c    |  20 +-
 drivers/crypto/cnxk/cn20k_ipsec.c            |  80 +++--
 drivers/crypto/cnxk/cn20k_ipsec.h            |  15 +-
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h     |  41 ++-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c     |   4 +-
 drivers/crypto/cnxk/cnxk_ae.h                |  15 +-
 drivers/crypto/cnxk/cnxk_cryptodev.h         |   1 +
 drivers/crypto/cnxk/cnxk_cryptodev_devargs.c |  49 +++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c     | 130 ++++++-
 drivers/crypto/cnxk/cnxk_se.h                | 340 +++++++++++++------
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h    |  96 ++++++
 drivers/net/cnxk/cn10k_ethdev_sec.c          |  14 +-
 drivers/net/cnxk/cn20k_ethdev_sec.c          |   8 +-
 23 files changed, 725 insertions(+), 244 deletions(-)

-- 
2.25.1

