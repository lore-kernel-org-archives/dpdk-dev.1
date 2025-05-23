Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB9C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:51:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CEE4060F;
	Fri, 23 May 2025 15:51:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 44E8D400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 15:51:40 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8Rl006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=og/VX1fPwOtrc5mkUFZkPmQ
 MeJFndKzgIK42wJ+PUTc=; b=MiMbwcx1DAJn326ZDcF+ysMXoQ+Qy5yp13ujm6W
 zUeoxVIYQmi5fub/DHfGwkE2gRAWowhEX7oSKYaj/J3SU9PUDlrsMCstqPy0F1gD
 wTddZb6mZ+IfgxVrM1FV02tgpTCSQ/Fx2PRAmShriUUy8T5Cd/2hA0bhRYhRpJp3
 ANYMO+RIMvtNUV/7VJo6m0o36x1zxkgNCwO6g62R7B1cPWPDhGmV75uiLSqLBH9n
 96LXIbIuaQXyOGf2SRP0U9B7/s3LSZ6QG1Z6JMNR6Gm/XwMV0B/N+EB4KchIyETn
 ntRVJtNt1H+STIIaomAiCaJ7uI6zlibk+OirdKxzlDhcVmQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:15 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id B441D3F704F;
 Fri, 23 May 2025 06:51:12 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 00/40] fixes and new features to cnxk crypto PMD
Date: Fri, 23 May 2025 19:20:31 +0530
Message-ID: <20250523135111.2178408-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX0B4hQinsCbxZ
 hvyKb7Pmb5mUtxjDfRre10JP6dfUMnyYF9X3PH6TgDHV0mCmp3PlBjFIYAVlWdFVeW9L2lXP6SB
 7BzPeRUDEv7wgsqC+rEpoZRX6J1+iAklRxjQQlo1DmvHCJh6IBIpHId9LVdTxH4ziX45wUq5KKf
 07hNMaFuZnEDW6z+ChA+C/18MvNmewVxezl7rrXowGUh+fpbPn0Y+zqEbJVyc/ocx/Er6CLvHWx
 e4I2knwYVmvsyCAQp7sr1H9toNUiv2MN8Z4UpK39kvK6h73w+MVwelIlpAjOpsCJycH8cQAGQNi
 vkTNBs/DCwXf+ctNBylTigo1coOjSAhNQQoNSrO0fRj17vNDIIpscVDDZjEUah7pyuK9Lm4T3V/
 kjFSmICz77yC+svwJG9+sd3x9UKK5BP67Z5D9j66azfO3yOnvg8LASGpu0oYva/RkAKeRuVG
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d63 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=yt7XvdBj0OKymuKhKxoA:9
X-Proofpoint-GUID: Y8WV9MuYNI71fkzoydT8RtZBmtN84-7l
X-Proofpoint-ORIG-GUID: Y8WV9MuYNI71fkzoydT8RtZBmtN84-7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

Adding CN20K PMD support and improvements to cnxk crypto PMD.

Aakash Sasidharan (1):
  crypto/cnxk: fail Rx inject configure if not supported

Nithinsen Kaithakadan (4):
  common/cnxk: fix salt handling with aes-ctr
  common/cnxk: set correct salt value for ctr algos
  common/cnxk: update qsize in CPT iq enable
  crypto/cnxk: copy 8B iv into sess in aes ctr

Rupesh Chiluka (2):
  crypto/cnxk: extend check for max supported gather entries
  crypto/cnxk: add asym sessionless handling

Tejasree Kondoj (8):
  crypto/cnxk: add lookaside IPsec CPT LF stats
  crypto/cnxk: fix qp stats PMD API
  crypto/cnxk: enable IV from application support
  crypto/cnxk: move debug dumps to common
  crypto/cnxk: add Rx inject in security lookaside
  crypto/cnxk: include required headers
  crypto/cnxk: add struct variable for custom metadata
  doc: update CN20K CPT documentation

Vidya Sagar Velumuri (25):
  crypto/cnxk: update the sg list population
  crypto/cnxk: add check for max supported gather entries
  crypto/cnxk: add probe for cn20k crypto device
  crypto/cnxk: add ops skeleton for cn20k
  crypto/cnxk: add dev info get
  crypto/cnxk: add skeletion for enq deq functions
  crypto/cnxk: add lmtst routines for cn20k
  crypto/cnxk: add enqueue function support
  crypto/cnxk: add cryptodev dequeue support for cn20k
  crypto/cnxk: add rte security skeletion for cn20k
  crypto/cnxk: add security session creation
  crypto/cnxk: add security session destroy
  crypto/cnxk: move code to common
  crypto/cnxk: add rte sec session update
  crypto/cnxk: add rte security datapath handling
  crypto/cnxk: add skeleton for tls
  crypto/cnxk: add tls write session creation
  crypto/cnxk: add tls read session creation
  crypto/cnxk: add tls session destroy
  crypto/cnxk: add enq and dequeue support for TLS
  crypto/cnxk: tls post process
  crypto/cnxk: add tls session update
  crypto/cnxk: support raw API for cn20k
  crypto/cnxk: add model check for cn20k
  crypto/cnxk: add support for sessionless asym

 doc/guides/cryptodevs/cnxk.rst                |   26 +-
 doc/guides/cryptodevs/features/cn20k.ini      |  113 ++
 drivers/common/cnxk/cnxk_security.c           |    8 +
 drivers/common/cnxk/roc_cpt.c                 |    5 +
 drivers/common/cnxk/roc_cpt.h                 |    7 +-
 drivers/common/cnxk/roc_cpt_sg.h              |    2 +
 drivers/common/cnxk/roc_ie_ow_tls.h           |  233 +++
 drivers/crypto/cnxk/cn10k_cryptodev.c         |   12 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  222 ++-
 drivers/crypto/cnxk/cn10k_cryptodev_sec.h     |   14 -
 drivers/crypto/cnxk/cn10k_ipsec.c             |    8 +-
 drivers/crypto/cnxk/cn10k_ipsec_la_ops.h      |   27 +-
 drivers/crypto/cnxk/cn10k_tls.c               |    4 +-
 drivers/crypto/cnxk/cn10k_tls_ops.h           |   28 +-
 drivers/crypto/cnxk/cn20k_cryptodev.c         |  158 ++
 drivers/crypto/cnxk/cn20k_cryptodev.h         |   13 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 1272 +++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   85 ++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c     |  137 ++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.h     |   64 +
 drivers/crypto/cnxk/cn20k_ipsec.c             |  378 +++++
 drivers/crypto/cnxk/cn20k_ipsec.h             |   41 +
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h      |  210 +++
 drivers/crypto/cnxk/cn20k_tls.c               |  917 ++++++++++++
 drivers/crypto/cnxk/cn20k_tls.h               |   40 +
 drivers/crypto/cnxk/cn20k_tls_ops.h           |  260 ++++
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c      |   77 +-
 drivers/crypto/cnxk/cn9k_ipsec.c              |   19 +-
 drivers/crypto/cnxk/cn9k_ipsec_la_ops.h       |   15 +-
 drivers/crypto/cnxk/cnxk_cryptodev.c          |   17 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   16 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  127 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h      |   38 +-
 drivers/crypto/cnxk/cnxk_ipsec.h              |    2 +
 drivers/crypto/cnxk/meson.build               |    5 +
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h     |    3 +
 36 files changed, 4393 insertions(+), 210 deletions(-)
 create mode 100644 doc/guides/cryptodevs/features/cn20k.ini
 create mode 100644 drivers/common/cnxk/roc_ie_ow_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.c
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls_ops.h

-- 
2.25.1

