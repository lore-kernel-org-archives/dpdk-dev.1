Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C569C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 08:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D418427DB;
	Sat, 22 Feb 2025 09:38:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CF4D6410E8
 for <dev@dpdk.org>; Sat, 22 Feb 2025 09:38:21 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M8UKLl022152;
 Sat, 22 Feb 2025 00:38:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 hNl8kD+5/+gKd5jIHa4JFNnPRK7EFjs48n5T0vDO4Y=; b=fc0BC1FwtI7dyWwRi
 RkSvOySrBIGzYsM0bBJLDoqB50bPzEZOK4k9Q4THzpBYMhEXg4HMVPl1z0+B52gB
 ISfUPZs9qcBUC1YhewH/bEf6ZXg5Ijx7TBEeCIWpWKUpUTGRO/haeQQvaQpMXELR
 mcHYd5IbXOnEhFykfdDCd/+jfYXkCHsULBXt2o7VWOQAV3Z+KD5GugZpQytdgIWE
 F6EcRLltFKgVNS6q6JZEcjSs4VFH4/AJZCsw679YntqLpp9ddCA/kUZUyuiBOu/B
 iBdx4vPBqiMyowNsIywviIV6gEbqvlX76X32EGveUEWHkLicPAHdiqL2Q9OxZYtK
 LLJbQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xxew95b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 00:38:20 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 00:38:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 00:38:19 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 186725B693B;
 Sat, 22 Feb 2025 00:38:15 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v4 0/5] vhost: add RSA support
Date: Sat, 22 Feb 2025 14:08:05 +0530
Message-ID: <cover.1740212213.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156665.git.gmuthukrishn@marvell.com>
References: <cover.1740156665.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SovibPmJWRVOyMFxaI_ariHky-kABFZp
X-Proofpoint-GUID: SovibPmJWRVOyMFxaI_ariHky-kABFZp
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

This patch series supports asymmetric RSA in vhost crypto library.
It also includes changes to improve vhost crypto library:
 * support newer QEMU versions.
 * fix broken vhost_crypto example application.
 * stabilize crypto fastpath operations.

v4:
 - fixed CI issues.

Gowrishankar Muthukrishnan (5):
  vhost: skip crypto op fetch before vring init
  vhost: update vhost_user crypto session parameters
  examples/vhost_crypto: fix user callbacks
  vhost: support asymmetric RSA crypto ops
  examples/vhost_crypto: support asymmetric crypto

 examples/vhost_crypto/main.c |  54 +++-
 lib/vhost/vhost_crypto.c     | 508 ++++++++++++++++++++++++++++++++---
 lib/vhost/vhost_user.h       |  33 ++-
 lib/vhost/virtio_crypto.h    |  67 +++++
 4 files changed, 603 insertions(+), 59 deletions(-)

-- 
2.25.1

