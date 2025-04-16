Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B2C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 10:09:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE21B406B8;
	Wed, 16 Apr 2025 12:09:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9C8D4406B4
 for <dev@dpdk.org>; Wed, 16 Apr 2025 12:09:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G97glj019618;
 Wed, 16 Apr 2025 03:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=qmApOL/sWnnlaq0Puon8OdF
 PnkTBQdC1mW5nbypus6k=; b=QXP/mM7Y23mN0vSEEqbI0OI/orAXci0faz+NuRA
 RWi9PEYI4PVaLnWY0LBNsWnxUnPfjpygQjZStIC94T86vwGKmP7QlkWXPc7+PHdK
 D0zJv6410eboHPOBYpR+Uxrib6T4XuDpoZPTsqiv1zA7J0ieCWI0wZ2KTtbluzla
 1qJUpUF45BfCyLSnhyXVzgQUEMZrFsfYS9RC2v2FQOXFW+4Ykf+iHo3hI49ZnJtJ
 qdLx6XPFy5NdTpct3ENVK8S5iE5ydx+VDaQliTdxo4MBuxOctJ6F1fMfg7SVvgzE
 wEVvioSHUbdrSfxARDKoeUPWhROt1gDAd/9ImxKuwDVNWpA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjh0pt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Apr 2025 03:09:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Apr 2025 03:09:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Apr 2025 03:09:41 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id C2B2F5B6943;
 Wed, 16 Apr 2025 03:09:36 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <vattunuru@marvell.com>, <g.singh@nxp.com>, <sachin.saxena@nxp.com>,
 <hemant.agrawal@nxp.com>, <fengchengwen@huawei.com>,
 <bruce.richardson@intel.com>, <kevin.laatz@intel.com>,
 <conor.walsh@intel.com>, <gmuthukrishn@marvell.com>,
 <vvelumuri@marvell.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [25.11 PATCH 0/3] Introduce DMA enqueue/dequeue operations
Date: Wed, 16 Apr 2025 15:39:28 +0530
Message-ID: <20250416100931.6544-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 75prE6imf_KARYjRYCeIQfxqU_TMOjI8
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=67ff81e6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=HJEslC__7xcM3DilELQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 75prE6imf_KARYjRYCeIQfxqU_TMOjI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Introduce DMA enqueue/dequeue operations to the DMA device library.

Add configuration flags to rte_dma_config instead of boolean for
individual features.

The enqueue/dequeue operations allow applications to communicate with the
DMA device using the rte_dma_op structure, providing a more flexible and
efficient way to manage DMA operations.

The programming model for the enqueue/dequeue operations is as follows:

* Query DMA devices capability for RTE_DMA_CAPA_OPS_ENQ_DEQ through
  rte_dma_info::dev_capa.
* Enable enqueue/dequeue operations on DMA device by enabling the
  flag RTE_DMA_CFG_FLAG_ENQ_DEQ in rte_dma_config::flags
  during device configuration.
* Allocate a mempool for rte_dma_ops with object size of
  rte_dma_op + (sizeof(struct rte_dma_sge) * rte_dma_info::max_sges * 2).
* Configure vchans and start the dma device.
* Get an rte_dma_op from the mempool, fill it with the necessary
  information and use rte_dma_enqueue() to enqueue the operation.
* Call rte_dma_dequeue() operation to get the array of finished operations.
* Free the rte_dma_op back to the mempool.

The enqueue dequeue operations are not compatible with rte_dma_copy,
rte_dma_copy_sg, rte_dma_fill, rte_dma_submit, rte_dma_completed and
rte_dma_completed_status range of APIs.

Pavan Nikhilesh (3):
  dmadev: add enqueue dequeue operations
  dma/cnxk: implement enqueue dequeue ops
  eventdev: refactor DMA adapter ops

 app/test-eventdev/test_perf_common.c          |   6 +-
 app/test-eventdev/test_perf_common.h          |   4 +-
 app/test/test_dmadev.c                        | 160 ++++++++++++++++++
 app/test/test_dmadev_api.c                    |  78 ++++++++-
 app/test/test_event_dma_adapter.c             |   6 +-
 doc/guides/prog_guide/dmadev.rst              |  34 ++++
 .../prog_guide/eventdev/event_dma_adapter.rst |   6 +-
 drivers/dma/cnxk/cnxk_dmadev.c                |  60 +++++--
 drivers/dma/cnxk/cnxk_dmadev.h                |   7 +
 drivers/dma/cnxk/cnxk_dmadev_fp.c             | 152 ++++++++++++++++-
 drivers/dma/dpaa/dpaa_qdma.c                  |   2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   2 +-
 lib/dmadev/rte_dmadev.c                       |  30 +++-
 lib/dmadev/rte_dmadev.h                       | 155 ++++++++++++++++-
 lib/dmadev/rte_dmadev_core.h                  |  10 ++
 lib/dmadev/rte_dmadev_trace.h                 |   2 +-
 lib/dmadev/rte_dmadev_trace_fp.h              |  20 +++
 lib/dmadev/rte_dmadev_trace_points.c          |   6 +
 lib/eventdev/rte_event_dma_adapter.c          |  18 +-
 lib/eventdev/rte_event_dma_adapter.h          |  57 -------
 20 files changed, 695 insertions(+), 120 deletions(-)

--
2.43.0

