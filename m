Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F1C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 08:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F9EA427AC;
	Wed, 18 Jun 2025 10:36:58 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id ABA2B40EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 10:36:56 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNSimr016784
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:36:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=kVh0xOp/Ed04nXnIdM+3c0m
 +DkU0sT8BSMfs61W4fIk=; b=BOSai0+rsfwi0id79yIdpl7856Qqr3Is6rKc73k
 lye9vlgBHm1mTdoLH+MbTr9XZGyBU7vpC5R6mUaHNcEqeoX7esiGGCCdpocP6Ilz
 rcl7g7kKipR1tJhkuAbgEyFLzxSQLZ5dWSv+Bnv5uCvt/dTTE7eYynXontiQyZpK
 upDD+gVLj1s8HUUGWQy4H6GQwoV3WsI8pnjB/fUvTWpCpDwPsIRSMUnR+syD2ok9
 EuYzIsg+ovei/GFYAncqCCkm8O99TFreDKeoykhdgN+X1czKAeJ6V79WXeqeWAoK
 5Rfj6l/DDiFPhWpYXUko5BkY0wx+ptWO20EEkVBQ1NP0QKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bj2kgw5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:36:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 01:36:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 01:36:54 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 4A8C73F7063;
 Wed, 18 Jun 2025 01:36:52 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>, <pbhagavatula@marvell.com>
Subject: [PATCH v3 0/2] add crypto adapter support in cn20k
Date: Wed, 18 Jun 2025 08:36:48 +0000
Message-ID: <20250618083651.637234-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q9jS452a c=1 sm=1 tr=0 ts=68527aa7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=f922ecHyS2UEbBIbVm0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA3NCBTYWx0ZWRfX3OcxSEITH9jO
 L4iHeUwqu9QtShxobdUJw0E0jiYwzY2zueC1OcDBDilbvD43TJm2iWyr5k61neWeAJu/PKg3/x+
 a9Ca8cYl7U88iO055/Y1UkIQVZSgS2vc8JNEJ/MBv6Xxn2yc/8rtBEqruBzlYjt5pdUtp4XrtnG
 qJHi+qd0PYYdGcQdC6rJXMFp6wtIJzfZ3SYsqH/2olLt9BIsPKDlt9W9b9bs/m4M26jISXDIEFv
 22Lgkd5Z04yauY6AL5SM0mDos9wuexvwRLxdSR7I4blGRdifN5krGuHiDrlo2xFkZfEcyKAYEQ/
 RkeIZTRfTPmHPBKFNX46ydyt8sctwZuRSGpvkRe4VshrphB+yUZMoHmedkT83p7tXFGuHMLwROh
 IMcSh/W7VUmSIcjR7B/jgR9Rf4iAXuyPkUpLpQBZaZ29qC6u2P8hQZAybWSHMUs94k3Jg+5j
X-Proofpoint-GUID: ai7sjiILAx8msHiWhbTUWFONStJMOKvv
X-Proofpoint-ORIG-GUID: ai7sjiILAx8msHiWhbTUWFONStJMOKvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
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

This series introduces support for the crypto adapter in
CN20K and incorporates sessionless asymmetric changes.

v2:
- fix compilation failures

v3:
- add dependent patch

Nithinsen Kaithakadan (2):
  crypto/cnxk: add crypto adapter for cn20k
  crypto/cnxk: add sessionless asym cn20k support

 doc/guides/cryptodevs/features/cn20k.ini      |   1 +
 .../crypto/cnxk/cn20k_cryptodev_event_dp.h    |  14 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 675 +++++++++++++++++-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   4 +
 drivers/event/cnxk/cn20k_eventdev.c           |  69 ++
 drivers/event/cnxk/cn20k_worker.h             |   7 +-
 6 files changed, 754 insertions(+), 16 deletions(-)
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_event_dp.h

-- 
2.48.1

