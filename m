Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9225DC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 06:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF49440156;
	Wed,  5 Mar 2025 07:16:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3B20A400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 07:16:24 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524DlOJP028774
 for <dev@dpdk.org>; Tue, 4 Mar 2025 22:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 0XRXsnrNLK1ig3L+x8ZkSyJvif3IFpuyFLH//WYT3s=; b=GKThCfNiqYywpDotH
 w64bTtJ/rrjdEohrIADqKPg4IciGiH++HMOm1p4XMc0MbzI0E8Z8aB9coM/b+Ugf
 3ppiDqDKHDG4xywvPJLB9jviUfb5TNqasMNodl2XiYeYBKA0tEOE+BumLFG7O3Jq
 ZRQw/tvl/MTqy8062P8JqUt0l/jhDGhgjSWh1T0uBmx8mxFkVE+ifgpg0L8hgo5T
 dJ7bpUPyyQWCKPo9nzSeT5OvINptIMc7PJuf8Z7ivwZ16p2YC8ONkalDj4Loo1ii
 LmIsKihTVS4AfZWB9SmZeeXQlAJ6yxJXgNJoRiAqW18XcdCsWS5M+88M/gASgrt9
 38xQg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4542mugan2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Mar 2025 22:16:23 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Mar 2025 22:16:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 4 Mar 2025 22:16:22 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.23.41])
 by maili.marvell.com (Postfix) with ESMTP id 1995F3F705F;
 Tue,  4 Mar 2025 22:16:20 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v6 0/6] crypto/virtio: enhancements for RSA and vDPA
Date: Wed, 5 Mar 2025 11:46:08 +0530
Message-ID: <cover.1741154953.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740595670.git.gmuthukrishn@marvell.com>
References: <cover.1740595670.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xcr6mboTk4GVeF55U1COkcbhaEu-2NK9
X-Authority-Analysis: v=2.4 cv=H6Ihw/Yi c=1 sm=1 tr=0 ts=67c7ec37 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=0okw920XIqAbwthZp6AA:9
X-Proofpoint-GUID: Xcr6mboTk4GVeF55U1COkcbhaEu-2NK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
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

v6:
 - patches rebased.

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

