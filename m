Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93048C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 19:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 652714021F;
	Wed, 26 Mar 2025 20:36:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 962BA40156
 for <dev@dpdk.org>; Wed, 26 Mar 2025 20:36:50 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QIeNCY007938
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:36:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 8oJsyd5zz9TDVuURgJvzdsbtk2MFyCwgIYLgl1dI/E=; b=f3vRK0dFCUU3WchSN
 34cwSdtRn7hBNKYCiEBuw2OLfP41WjfmF9unSd/y9UX10XAr9L07Wq7obcMdz6Bt
 kgc3VNjjJyAz2qpYoL4O1H4DL0OAmo6vTfgMnkH/1DKFdqctUDbP25pQzG7WqSK+
 0LlRe5LFlOv7W97KAl2hlczzsFvBRFVTwAedc5bIgnqZi5hNnPFA5IwZCipijus+
 IMCS0YDRJji4NAWKeO8j1n+G/cff+TelWEbK267vT3bglVrKuS10e/Q0wtOBRnZD
 8r3UKU7PsRu59u/GmrZigZMIRn8c2KoGQGtkr+dwTPC0qWsalYfv0VRTSIRBLOvm
 q/PbQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45meyk1d7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Mar 2025 12:36:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 12:36:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 12:36:48 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id C437A5C68F3;
 Wed, 26 Mar 2025 12:36:46 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC v2 0/3] Introduce DMA enqueue/dequeue operations
Date: Thu, 27 Mar 2025 01:06:33 +0530
Message-ID: <20250326193637.12557-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129143649.3887989-1-kshankar@marvell.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=G+wcE8k5 c=1 sm=1 tr=0 ts=67e45751 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=92pHrIvrNbpdVixIpVQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ktmN67Bsto33LRs-ThO3FaeWREO2LOvK
X-Proofpoint-GUID: ktmN67Bsto33LRs-ThO3FaeWREO2LOvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
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

The enqueue/dequeue operations allow applications to communicate with the
DMA device using the rte_dma_op structure, providing a more flexible and
efficient way to manage DMA operations.

The programming model for the enqueue/dequeue operations is as follows:

* Query DMA devices capability for RTE_DMA_CAPA_OPS_ENQ_DEQ through
  rte_dma_info::dev_capa.
* Enable enqueue/dequeue operations on DMA device by enabling
  rte_dma_conf::enable_enq_deq during device configuration.
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
 app/test/test_event_dma_adapter.c             |   6 +-
 .../prog_guide/eventdev/event_dma_adapter.rst |   6 +-
 drivers/dma/cnxk/cnxk_dmadev.c                |  27 +++-
 drivers/dma/cnxk/cnxk_dmadev.h                |   7 +
 drivers/dma/cnxk/cnxk_dmadev_fp.c             | 152 +++++++++++++++++-
 lib/dmadev/rte_dmadev.c                       |  18 +++
 lib/dmadev/rte_dmadev.h                       | 145 +++++++++++++++++
 lib/dmadev/rte_dmadev_core.h                  |  10 ++
 lib/dmadev/rte_dmadev_trace_fp.h              |  20 +++
 lib/dmadev/rte_dmadev_trace_points.c          |   6 +
 lib/eventdev/rte_event_dma_adapter.c          |  18 +--
 lib/eventdev/rte_event_dma_adapter.h          |  57 -------
 14 files changed, 397 insertions(+), 85 deletions(-)

--
2.43.0

