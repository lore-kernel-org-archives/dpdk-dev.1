Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C3C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 09:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89ED341143;
	Sat, 22 Feb 2025 10:17:06 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0C6D840649
 for <dev@dpdk.org>; Sat, 22 Feb 2025 10:17:04 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M91Wij031271
 for <dev@dpdk.org>; Sat, 22 Feb 2025 01:17:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 jnkP4eP5v8zbwnzWEfntWqRuvxfu6C3L1VLibh7rt4=; b=QHFh/p+1ddoxb8n7e
 ok1f55QJQMPmVzDVOd1ZRues8pvOZ7ZYDH1sur0woI8A0FV7XgPUj4BxV0M89SxK
 U594dN5byFs/7X8wLc3CQQKvVnbgMeA2QRU1Ctd8/brsiCQnd2PTk+1twbBEmAZ3
 uNwhhu7xNVddiTA5AN7ktFtIrbJeEOJnEh46rubVR84+QsaYYI3rxm0H/ed8fx2M
 sDYBDEzsKPiRaCsQdk8AQsF1EOKBbwS2YmMLtW7TvIhTCDWJXvdIrMSQWFnLmppI
 ZOPtOMC+3kIHCKXvKmBz7CpWtx+RTglEPYbrhFoCLe2vQp70/iyJxu6fNiUnY+ds
 /3F7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxuaagu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sat, 22 Feb 2025 01:17:03 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 01:17:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 01:17:02 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 3BDAA3F706A;
 Sat, 22 Feb 2025 01:16:59 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v4 0/6] crypto/virtio: enhancements for RSA and vDPA
Date: Sat, 22 Feb 2025 14:46:49 +0530
Message-ID: <cover.1740212415.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156584.git.gmuthukrishn@marvell.com>
References: <cover.1740156584.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TFxCv8U8TLu1TQ9fJv1hk3YZwR9mbxo0
X-Proofpoint-ORIG-GUID: TFxCv8U8TLu1TQ9fJv1hk3YZwR9mbxo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
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

v4:
 - CI issue fixed.

Depends-on: series-34682 ("vhost: add RSA support")

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
 drivers/crypto/virtio/virtio_rxtx.c           |  721 ++++++++++-
 drivers/crypto/virtio/virtio_rxtx.h           |   13 +
 drivers/crypto/virtio/virtio_user/vhost.h     |   90 ++
 .../crypto/virtio/virtio_user/vhost_vdpa.c    |  710 +++++++++++
 .../virtio/virtio_user/virtio_user_dev.c      |  749 ++++++++++++
 .../virtio/virtio_user/virtio_user_dev.h      |   85 ++
 drivers/crypto/virtio/virtio_user_cryptodev.c |  575 +++++++++
 drivers/crypto/virtio/virtqueue.c             |  229 +++-
 drivers/crypto/virtio/virtqueue.h             |  221 +++-
 lib/cryptodev/cryptodev_pmd.h                 |    6 +
 23 files changed, 4435 insertions(+), 492 deletions(-)
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

