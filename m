Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE2BC19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 13:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE7640E32;
	Fri, 28 Feb 2025 14:47:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EAFBE40609
 for <dev@dpdk.org>; Fri, 28 Feb 2025 14:47:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SB10qI021859;
 Fri, 28 Feb 2025 05:47:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 3UquHsSuTXl7BM9pf9JZPwmQcIMySMPDf8JGlKfS/w=; b=UJpbP+Yt/SjjygVH7
 BTlQTwHNflXGwBQuw2NuOlPXnnaDC7HcTMfXUEpoVGGnDQpTkcFi6SQpjJAj6cWJ
 EWpgxna95zQR3kdSD3Ve1aU9r7EIxRadodRjVEL04NwLt0WZi69YxFZm2dIjsNIU
 EsH/MRzWqQNZdlvdIygbxtjgPuXuyu8AJMJyAw+Dex/nJdAiKdmavX5G5lHwNGpZ
 CYso5IQUS6UFH3h4Xds/B2jG2V04aB5aIy6I7d+S1C7QjGBY7KyCSGlEMfAnijAY
 9yKQ8RV0vXnZWdnyiDgdIMQ+L+owvro3PUxoIeW8fJJNFW5sN9jxmpf3MPY4arNJ
 /yHYg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 453bgw884s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 05:47:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Feb 2025 05:47:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Feb 2025 05:47:24 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 285C45B692E;
 Fri, 28 Feb 2025 05:47:21 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: [v9 0/6] vhost: add RSA support
Date: Fri, 28 Feb 2025 19:17:07 +0530
Message-ID: <cover.1740749809.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740679955.git.gmuthukrishn@marvell.com>
References: <cover.1740679955.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZMQtmW7b c=1 sm=1 tr=0 ts=67c1be6d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=SSEcSf4z2q0PDGKyEI4A:9 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: 3FMxPbXGXRa2Gh2p0aFBYtwS3BIffsbI
X-Proofpoint-GUID: 3FMxPbXGXRa2Gh2p0aFBYtwS3BIffsbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
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

v9:
 - new patch 1/6

Gowrishankar Muthukrishnan (6):
  vhost: fix thread safety checks for vhost crypto data req
  vhost: skip crypto op fetch before vring init
  vhost: update vhost_user crypto session parameters
  examples/vhost_crypto: fix user callbacks
  vhost: support asymmetric RSA crypto ops
  examples/vhost_crypto: support asymmetric crypto

 doc/guides/rel_notes/release_25_03.rst    |   3 +
 doc/guides/sample_app_ug/vhost_crypto.rst |   5 +
 examples/vhost_crypto/main.c              |  54 +-
 lib/vhost/vhost_crypto.c                  | 597 +++++++++++++++++++---
 lib/vhost/vhost_user.h                    |  33 +-
 lib/vhost/virtio_crypto.h                 |  67 +++
 6 files changed, 664 insertions(+), 95 deletions(-)

-- 
2.25.1

