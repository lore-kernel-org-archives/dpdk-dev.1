Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19532C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37839402ED;
	Fri, 21 Feb 2025 18:41:29 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0535140270
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:41:26 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L94Jci006117
 for <dev@dpdk.org>; Fri, 21 Feb 2025 09:41:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 VzNLYoKNik6BeDGmONYNaEXP+UxgJqMuRKUmEmbE7U=; b=X56SERmRXhu5bkO83
 l1HSXW2tRbY097hQR0M/iZOub7p06o1UpwMFNzJ6ttlopJb5sWmV2nu3vBz3zJKG
 v3F0t8lB4UsjNDXWbiYdZPkACxY0O+Pmnf7hiAE322iExZh+xfJUT/HOTAce50gZ
 G3S7yVwU0i7cliabUOgdndH5cpXdTvZq/bvusS5PrQGvYY8wEgFp31/HpxPs71Py
 gTCivBaO6WME4Vggz5e51nv3+dzJKJQxJEi0w1X1IqMvAUNQWHJ6wZ3FJw1iKGEi
 NShtHvajSsLgZZLoEQjORows7w2s7c3aDwwVB8kEJcwI6FECPCAYa5SedyE/ro5C
 PZ16g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xphggyf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 21 Feb 2025 09:41:26 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:41:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:41:24 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id 76B465B6930;
 Fri, 21 Feb 2025 09:41:22 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v3 0/6] crypto/virtio: enhancements for RSA and vDPA
Date: Fri, 21 Feb 2025 23:11:10 +0530
Message-ID: <cover.1740156584.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1736270070.git.gmuthukrishn@marvell.com>
References: <cover.1736270070.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3Rw7cREwBJfPFROEBGUMmDe9eI8IZFEI
X-Proofpoint-ORIG-GUID: 3Rw7cREwBJfPFROEBGUMmDe9eI8IZFEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

v3:
 - vDPA backend code majorly sourced from virtio net.

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
 .../virtio/virtio_user/virtio_user_dev.c      |  767 ++++++++++++
 .../virtio/virtio_user/virtio_user_dev.h      |   85 ++
 drivers/crypto/virtio/virtio_user_cryptodev.c |  575 +++++++++
 drivers/crypto/virtio/virtqueue.c             |  229 +++-
 drivers/crypto/virtio/virtqueue.h             |  221 +++-
 lib/cryptodev/cryptodev_pmd.h                 |    6 +
 23 files changed, 4453 insertions(+), 492 deletions(-)
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

