Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4DEC021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 08:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98FE540652;
	Mon, 24 Feb 2025 09:42:46 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B3A6E40299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 09:42:44 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O515AI009513;
 Mon, 24 Feb 2025 00:42:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 jkJ/hvRBoyYXGxq8MxvY474VZzEP/hBx18L3xOCBl0=; b=B1NY/fGo5Sk0QZ6dl
 dJNdRlfXrViVuBBYi0DSGjfmXLEmBVcICIsT01w0kJIUxUrFUjiHdMV+Na670pUm
 xSzoN3lxdnld4e3W4J2PcYfMJnP+02s0zBrjwclCg/52kZu6Bgvsvf8B8glUzFcS
 xx4SD+ua9G+oLaUrUf9ixrqIQ9S06XaZHH3X5noBVjpR91E9rFVrndW5ypzFy780
 F1fZc+P5CM5veriO9+TWb20obI4EqYIfO7viTzqhvD2yKC7WNi0L9DLpOH6MBf7W
 6WvRwLaV3jhAKbl/rRtVrFfyKSoQFub5/Xdz6N0BvHgg2ahZQc+/q42Oa6rD4bYC
 /iWFw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbsk5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 00:42:43 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 00:42:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 00:42:42 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id C08FA3F705D;
 Mon, 24 Feb 2025 00:42:40 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <s.v.naga.harish.k@intel.com>, <jerinj@marvell.com>
CC: Shijith Thotton <sthotton@marvell.com>, <dev@dpdk.org>,
 <pbhagavatula@marvell.com>
Subject: [PATCH v3 0/3] Rx adapter API to add Rx queues in burst
Date: Mon, 24 Feb 2025 14:12:22 +0530
Message-ID: <cover.1740383918.git.sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218091543.282270-1-sthotton@marvell.com>
References: <20250218091543.282270-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -yNp5yXTu9SAQAZ7lZiEfTP2ULMjyqxO
X-Proofpoint-ORIG-GUID: -yNp5yXTu9SAQAZ7lZiEfTP2ULMjyqxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
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

v2:
 - Updated documentation to explain the new API.

v3:
 - Improved MULTI_EVENTQ check.

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
 lib/eventdev/rte_event_eth_rx_adapter.c       | 160 ++++++++++++++
 lib/eventdev/rte_event_eth_rx_adapter.h       |  33 +++
 lib/eventdev/version.map                      |   3 +
 13 files changed, 691 insertions(+), 127 deletions(-)

-- 
2.25.1

