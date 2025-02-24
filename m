Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ADCC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F7CE406BA;
	Mon, 24 Feb 2025 11:35:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 955794042E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 11:35:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51Den001318;
 Mon, 24 Feb 2025 02:35:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 eFbxhiS8NPpsz01dS6lFDowFmOi4JzDGcai8VEQ3K8=; b=X+f+Q//qZ+HkkJ3gL
 D5i5bSZ8CZ1AhI+ySrx360fcJ31eHUonjWw6MQyTbkMHIYiWofpKH+f9yQ6e1YsQ
 zW6Y+TQONCBZOYO4GBiJ7C2Pdtpm6MJvtp9JCzPruI4ahj+SiSIenXgVWzMBnXTy
 sX5sOVH+8Ski78V+NT5YXq8MnaNKGpSxI+Vk8tHfEjXduP7O68i3sNZW+DFzizp7
 90tiu+D59X1LPB8A7LlFQ2S2Kg32w+rG5Buep0PB30t0HlLJ6BAYMUhV7jVDNBkT
 5XZUjRRP9aRuTS/8t736ntCqSNubU6f5fd6OtHnfFh/72pcygl/V2/tslXQ2BUpy
 sJqPg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jkhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 02:35:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 02:35:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 02:35:15 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.21.204])
 by maili.marvell.com (Postfix) with ESMTP id D8BC43F705D;
 Mon, 24 Feb 2025 02:35:12 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v5 0/5] vhost: add RSA support
Date: Mon, 24 Feb 2025 16:05:02 +0530
Message-ID: <cover.1740390893.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212213.git.gmuthukrishn@marvell.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: r4F0pCweY_xC5Cur91OXDUtfLke6HTP7
X-Proofpoint-ORIG-GUID: r4F0pCweY_xC5Cur91OXDUtfLke6HTP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

v5:
 - added docs.

Gowrishankar Muthukrishnan (5):
  vhost: skip crypto op fetch before vring init
  vhost: update vhost_user crypto session parameters
  examples/vhost_crypto: fix user callbacks
  vhost: support asymmetric RSA crypto ops
  examples/vhost_crypto: support asymmetric crypto

 doc/guides/rel_notes/release_25_03.rst    |   3 +
 doc/guides/sample_app_ug/vhost_crypto.rst |   5 +
 examples/vhost_crypto/main.c              |  54 ++-
 lib/vhost/vhost_crypto.c                  | 508 ++++++++++++++++++++--
 lib/vhost/vhost_user.h                    |  33 +-
 lib/vhost/virtio_crypto.h                 |  67 +++
 6 files changed, 611 insertions(+), 59 deletions(-)

-- 
2.25.1

