Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D3C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 09:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A070402BB;
	Tue, 18 Feb 2025 10:16:14 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7C471402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 10:16:12 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HNEisx012512;
 Tue, 18 Feb 2025 01:16:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 ViUUsvKlgcj9JR4oaYUopCqEq7p92Sp3TPeFbVXDNw=; b=ZDzgxDdwxjf2z/GAn
 vjcWWIo3b4+0EGuxrr6gM30OklQ0DYH2/b1ddLkNYyMpBVUsJIFjN1g8B9aqrirn
 SjjfVKNke6DvAI/ql+fyhrHyMvLSzv9IlASzCYmGTheNAFJSMhepEuBQOpYVErjJ
 4/NEAmSh8GhJaskK2CF1C/Fi263iyFNrgyK8KXqd0Rt/5TFYSAkgzBtO2FiFszw7
 Cm+Ez50dRB5pigh021eBkEs61AGKjlHi0M0fQDTI5pVkeDulhl+k2XPo3LBD4/s3
 z6b1RpIySLw6sOQtYhHnnBBQQZkPMo8IHNsuzrQQjn3wc6QJkU5F7hroaF/SIJAq
 LewCA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44u5rdm8v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 01:16:10 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Feb 2025 01:16:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Feb 2025 01:16:09 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 7E88A3F7074;
 Tue, 18 Feb 2025 01:16:07 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <s.v.naga.harish.k@intel.com>, <jerinj@marvell.com>
CC: Shijith Thotton <sthotton@marvell.com>, <dev@dpdk.org>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v2 0/3] Rx adapter API to add Rx queues in burst
Date: Tue, 18 Feb 2025 14:45:39 +0530
Message-ID: <20250218091543.282270-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207140910.721374-1-sthotton@marvell.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QIcjrjCxON94bFqEC6pRLwd8qre__hKR
X-Proofpoint-GUID: QIcjrjCxON94bFqEC6pRLwd8qre__hKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
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

RFC:
 - https://patches.dpdk.org/project/dpdk/patch/20241219073405.1724200-1-sthotton@marvell.com/

v1:
 - Updated documentation to explain the new API.

Shijith Thotton (3):
  eventdev/eth_rx: add API to burst add queues to Rx adapter
  event/cnxk: enable PMD op to burst add queues to Rx adapter
  test/event: unit test to burst add Rx queues to adapter

 app/test/test_event_eth_rx_adapter.c          |  86 ++++++++
 .../eventdev/event_ethernet_rx_adapter.rst    |  60 +++++-
 drivers/event/cnxk/cn10k_eventdev.c           |  82 ++++++--
 drivers/event/cnxk/cn20k_eventdev.c           | 195 +++++++++++++-----
 drivers/event/cnxk/cn9k_eventdev.c            |  38 +++-
 drivers/event/cnxk/cnxk_eventdev.h            |   8 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c      | 102 +++++----
 lib/eventdev/eventdev_pmd.h                   |  34 +++
 lib/eventdev/eventdev_trace.h                 |  14 ++
 lib/eventdev/eventdev_trace_points.c          |   3 +
 lib/eventdev/rte_event_eth_rx_adapter.c       | 155 ++++++++++++++
 lib/eventdev/rte_event_eth_rx_adapter.h       |  33 +++
 lib/eventdev/version.map                      |   3 +
 13 files changed, 686 insertions(+), 127 deletions(-)

-- 
2.25.1

