Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F9C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC37642DC1;
	Fri,  7 Feb 2025 15:10:00 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 30CF042DBE
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:09:59 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517CcrQe023928
 for <dev@dpdk.org>; Fri, 7 Feb 2025 06:09:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ZGtxW9a0OeUdwkozpJ8hpOm
 t0b46jMYvDLmKcump4cM=; b=fBJET0KoYvBQjdF019qdN4Ph5uMQ3toynAISldQ
 yQ4gVBx/AqL87NhrDaQmH/x/vBjBWYZUZeftBwxsLWjm6fXArGV2HrVuCJaLogHi
 3CejDD/0UWnzyFlgZSHuR+v4Sk7o10aCAYYohXXpQzsldE9V5QEdzwFaHwbwa4R7
 82pKN+fGMYeFMcGpz04uesteQv7oO/IevGoic8m6SmgPTpooQ/JkAh2ny7/0uSFO
 NtNFMbmJl6SbonY2UOhOdAF25bo2NhF+6kel8eSpXw+YxFeUufRngQD63JZbaowm
 /Vbtne+YFeAVpKdd7mwG0R12PjEt5Uu8PFYbWHTVkjiLqpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44njc1g5ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:09:58 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 7 Feb 2025 06:09:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Feb 2025 06:09:56 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 355A43F704A;
 Fri,  7 Feb 2025 06:09:54 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <jerinj@marvell.com>
CC: <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>,
 <dev@dpdk.org>
Subject: [PATCH 0/3] Rx adapter API to add Rx queues in burst
Date: Fri, 7 Feb 2025 19:39:07 +0530
Message-ID: <20250207140910.721374-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RK_8uqcfFMjyqIYcbt9EaD_wPBwkYahx
X-Proofpoint-ORIG-GUID: RK_8uqcfFMjyqIYcbt9EaD_wPBwkYahx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
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

This patch series introduces the rte_event_eth_rx_adapter_queues_add()
API, allowing multiple Rx queues to be added to an Rx adapter in a
single burst. This enhancement benefits applications that require bulk
addition of Rx queues.  

To support this API, a new internal eventdev PMD operation for adding Rx
queues has been implemented. The second patch in the series enables this
operation for the CNXK PMD. 

Additionally, a unit test has been added to validate the API's
functionality.

RFC: https://patches.dpdk.org/project/dpdk/patch/20241219073405.1724200-1-sthotton@marvell.com/

Shijith Thotton (3):
  eventdev/eth_rx: add API to burst add queues to Rx adapter
  event/cnxk: enable PMD op to burst add queues to Rx adapter
  test/event: unit test to burst add Rx queues to adapter

 app/test/test_event_eth_rx_adapter.c     |  86 ++++++++++
 drivers/event/cnxk/cn10k_eventdev.c      |  82 ++++++++--
 drivers/event/cnxk/cn20k_eventdev.c      | 195 ++++++++++++++++-------
 drivers/event/cnxk/cn9k_eventdev.c       |  38 ++++-
 drivers/event/cnxk/cnxk_eventdev.h       |   8 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c | 102 +++++++-----
 lib/eventdev/eventdev_pmd.h              |  34 ++++
 lib/eventdev/eventdev_trace.h            |  14 ++
 lib/eventdev/eventdev_trace_points.c     |   3 +
 lib/eventdev/rte_event_eth_rx_adapter.c  | 146 +++++++++++++++++
 lib/eventdev/rte_event_eth_rx_adapter.h  |  33 ++++
 lib/eventdev/version.map                 |   3 +
 12 files changed, 627 insertions(+), 117 deletions(-)

-- 
2.25.1

