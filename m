Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15900CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 602E840292;
	Thu, 21 Aug 2025 06:53:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 67B454026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:53:08 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0q2Gn030611
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ssi99UUED7rjH64ZHtsfro4
 ECksE+moorbzFOV7VaEo=; b=OEa/cVmUKa+W1dzPVfebkb2w7gBjYpPD/WFvppx
 IHZjZ8ny8Mqo7ZO0ciDvjjEp1XmB6j65Prv9j840ivjXYrEdWo0d0rwdCnEDwBkn
 UFNqFYfrVaw/XqKuFh4k9H8PBRbG+/DpRvti6+M3FLtFcrMG6Ow5aWqn4MrBYQBo
 hScJazH24Z8UrwLKQ5EifNj2niJhtvgcmzLiZX40+CSkp+eTpE8t/H610sghLLc/
 a68Yw/s/CY4k3nB+JA5bKGoM6Zl+JSS4ZvZpKBvk2rC5HH4c1j4haJMoPkqbuRso
 8yGYyf/hWhOg34l5p5fkxTmg+nUzv3utMpFNQPjQUb/W1/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr2m8hkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:11 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 8796D3F708F;
 Wed, 20 Aug 2025 21:53:02 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 0/8] fixes and improvements to cnxk crypto PMD
Date: Thu, 21 Aug 2025 10:22:52 +0530
Message-ID: <20250821045300.3787899-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfX1x+gTqMfF8Vm
 /A4phnGtCnnlT3DcOE3FdZj0Kq02oAfe4fimTT1GTHbjpiXqAP6YXoGBKYHRxU7VpaHsEyVhnWS
 fk0ySEvbbv8av+hVM9ob+Ty2/74+D5KJc1eKwlrkqikZqMe5BDwK6QtjZbAut1KmngNG4RvBp0T
 er72LA6f3yzqHFanX4wBzYNuDCehe3fTgIRLAn7ZUCM8OhJMrcWdRkyETFdBfqdvcdw1o5MZ0r8
 a+YcLfrGVPEvL2NcslWegk6zWw9JZjEe6aPjIq6YtTzwXOqzQ+Y6F56mTsuydR6cPwovLOl8XJH
 BvKnNtBEHvOrrCEAFdcAy4bVg0wMhgAp2km0/lPamuIQhSA9+PRl0s+5VCZ38v7qWrK/9v4zIGU
 wTcaEhPYzfDGjE+fvL4880J6QUzTNzT0UKxQfIMPA3TTTg/MNe1I4esZF6OwQm/bVjTGgJJs
X-Proofpoint-GUID: AVCJP7AUmoX5G5eb-GZp2IQHyOKUD7wW
X-Proofpoint-ORIG-GUID: AVCJP7AUmoX5G5eb-GZp2IQHyOKUD7wW
X-Authority-Analysis: v=2.4 cv=LOc/gJW9 c=1 sm=1 tr=0 ts=68a6a633 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=TG_Foirp3Qm55mN1lE0A:9
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

Adding fixes and improvements to cnxk crypto PMD.

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
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h    |  94 +++++
 drivers/net/cnxk/cn10k_ethdev_sec.c          |  14 +-
 drivers/net/cnxk/cn20k_ethdev_sec.c          |   8 +-
 23 files changed, 723 insertions(+), 244 deletions(-)

-- 
2.25.1

