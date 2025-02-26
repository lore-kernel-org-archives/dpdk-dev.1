Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC8C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 18:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 043F24029F;
	Wed, 26 Feb 2025 19:58:34 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5240C4029A
 for <dev@dpdk.org>; Wed, 26 Feb 2025 19:58:32 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QG57xH022354
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:58:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 Xq0ZORcTZFLdhnEUAZ2mzGX27KCKsvB9VCS9M78E8E=; b=Qh2XqZcIVKgo8ss95
 GCyfEaRG4ykFsJzA9gnO6tHrmqkMClvsulnnDwNA8r59G4MIsWxKRWwIDcxl/9Qk
 5gb1LKz2r64fVHdg6A/5BWbtlPc0Vtdq3bO0ofhinTI4wb2wxOkZ2l3r0cF8wf3G
 gWi+wYrltDwMhAVBByepuId/c1JEm2u54sNsH+GeDw7fhcHPyHw6+9NnatWITwT+
 Mz+c112B7QP3JaFXnGRY1XWxel3Bvhn181t4Laypsas1urTUteGopxI70zRHoJvT
 w6fz+zvwYHRafJA6fEQ3pNiOshUVr5TkvSXkSahJ651B6Yz47sR1o8g+mCRpaaNF
 ffp5g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45265tgfgc-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:58:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Feb 2025 10:58:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Feb 2025 10:58:28 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.81])
 by maili.marvell.com (Postfix) with ESMTP id 1B71B3F7071;
 Wed, 26 Feb 2025 10:58:26 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v5 0/6] crypto/virtio: enhancements for RSA and vDPA
Date: Thu, 27 Feb 2025 00:28:12 +0530
Message-ID: <cover.1740595670.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212415.git.gmuthukrishn@marvell.com>
References: <cover.1740212415.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HaHuTjE8 c=1 sm=1 tr=0 ts=67bf6457 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=0okw920XIqAbwthZp6AA:9
X-Proofpoint-GUID: 20VX0586TSwqWGEdK9c8IbyZX9Nkl7hB
X-Proofpoint-ORIG-GUID: 20VX0586TSwqWGEdK9c8IbyZX9Nkl7hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
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

This patch series enhances virtio crypto PMD to:
 * support RSA
 * support packed virtio ring
 * support vDPA backend

Depends-on: patch-152109 ("vhost: support asymmetric RSA crypto ops")

Gowrishankar Muthukrishnan (6):
  crypto/virtio: add asymmetric RSA support
  crypto/virtio: refactor queue operations
  crypto/virtio: add packed ring support
  crypto/virtio: add vDPA backend
  test/crypto: add asymmetric tests for virtio PMD
  test/crypto: add tests for virtio user PMD

 app/test/test_cryptodev.c                     |    7 +
 app/test/test_cryptodev.h                     |    1 +
 app/test/test_cryptodev_asym.c                |   43 +
 doc/guides/cryptodevs/features/virtio.ini     |    4 +
 doc/guides/rel_notes/release_25_03.rst        |    4 +
 drivers/crypto/virtio/meson.build             |    8 +
 drivers/crypto/virtio/virtio_crypto_algs.h    |    2 +-
 .../virtio/virtio_crypto_capabilities.h       |   19 +
 drivers/crypto/virtio/virtio_cryptodev.c      | 1060 +++++++++++------
 drivers/crypto/virtio/virtio_cryptodev.h      |   18 +-
 drivers/crypto/virtio/virtio_cvq.c            |  228 ++++
 drivers/crypto/virtio/virtio_cvq.h            |   33 +
 drivers/crypto/virtio/virtio_logs.h           |    6 +-
 drivers/crypto/virtio/virtio_pci.h            |   38 +-
 drivers/crypto/virtio/virtio_ring.h           |   65 +-
 drivers/crypto/virtio/virtio_rxtx.c           |  725 ++++++++++-
 drivers/crypto/virtio/virtio_rxtx.h           |   13 +
 drivers/crypto/virtio/virtio_user/vhost.h     |   90 ++
 .../crypto/virtio/virtio_user/vhost_vdpa.c    |  710 +++++++++++
 .../virtio/virtio_user/virtio_user_dev.c      |  749 ++++++++++++
 .../virtio/virtio_user/virtio_user_dev.h      |   85 ++
 drivers/crypto/virtio/virtio_user_cryptodev.c |  575 +++++++++
 drivers/crypto/virtio/virtqueue.c             |  229 +++-
 drivers/crypto/virtio/virtqueue.h             |  221 +++-
 lib/cryptodev/cryptodev_pmd.h                 |    6 +
 25 files changed, 4447 insertions(+), 492 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_cvq.c
 create mode 100644 drivers/crypto/virtio/virtio_cvq.h
 create mode 100644 drivers/crypto/virtio/virtio_rxtx.h
 create mode 100644 drivers/crypto/virtio/virtio_user/vhost.h
 create mode 100644 drivers/crypto/virtio/virtio_user/vhost_vdpa.c
 create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.c
 create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.h
 create mode 100644 drivers/crypto/virtio/virtio_user_cryptodev.c

-- 
2.25.1

