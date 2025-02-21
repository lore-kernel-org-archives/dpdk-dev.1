Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8735CC021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:30:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D699440EE3;
	Fri, 21 Feb 2025 18:30:32 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C9C7C402CC
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:30:30 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCq8Ak005095;
 Fri, 21 Feb 2025 09:30:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 Qe8SZ3rliUkPpiOrzl9o+OOdM+/v7KQ2Aq8xpnk5k8=; b=ba+SDKdmWxoKE9BVj
 qBK8jpXkRuK2fnuyfLYWvEsMzsqvF/E4JFf9L1VzI1j39NaNDjvAH0XAsd8t8mlh
 4Osz+u8mtu58Pkl4BhRIikBxToLXOSOTuMDj/RarLemAVbQsXBC4Dq/7icw2yNq7
 AW94M5qtwV66bdFQWvHihpIoU1hTWiIwC0KsrX5OhxdthOy0t/cdPWJrRs4De1dY
 1HA9hdsBBVlfDW8an3x50bFYY+/GjDs3WtBu27ajs4i2DbyrYMUdRNTU2u2AoQR7
 CkIdF3FPk+bJB+ShAJIsE88gMsyWRVAlkHZX7Q9oUP6dmekVk5MCm5MJo0Kj39uJ
 Gx+pg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgh4wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:30:30 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:30:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:30:29 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id D0DFC3F707A;
 Fri, 21 Feb 2025 09:30:26 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v3 0/5] vhost: add RSA support
Date: Fri, 21 Feb 2025 23:00:08 +0530
Message-ID: <cover.1740156665.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1736270125.git.gmuthukrishn@marvell.com>
References: <cover.1736270125.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QhUi5zd6JB25fnHuEJ5PPAe1UpZMhvgc
X-Proofpoint-ORIG-GUID: QhUi5zd6JB25fnHuEJ5PPAe1UpZMhvgc
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

This patch series supports asymmetric RSA in vhost crypto library.
It also includes changes to improve vhost crypto library:
 * support newer QEMU versions.
 * fix broken vhost_crypto example application.
 * stabilize crypto fastpath operations.

v3:
 - spin off new patches from one single patch in v2.
 - stabilized vhost crypto lib and example app.

Gowrishankar Muthukrishnan (5):
  vhost: skip crypto op fetch before vring init
  vhost: update vhost_user crypto session parameters
  examples/vhost_crypto: fix user callbacks
  vhost: support asymmetric RSA crypto ops
  examples/vhost_crypto: support asymmetric crypto

 examples/vhost_crypto/main.c |  54 +++-
 lib/vhost/vhost_crypto.c     | 514 ++++++++++++++++++++++++++++++++---
 lib/vhost/vhost_user.h       |  33 ++-
 lib/vhost/virtio_crypto.h    |  67 +++++
 4 files changed, 609 insertions(+), 59 deletions(-)

-- 
2.25.1

