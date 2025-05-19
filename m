Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C5DC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 18:56:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17D3540651;
	Mon, 19 May 2025 20:56:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF3FA40612
 for <dev@dpdk.org>; Mon, 19 May 2025 20:56:17 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIXk73004682;
 Mon, 19 May 2025 11:56:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 w+On5gq8/rNz0+53RUUiOhRwvHu54AJuVJi2xGWQ0Y=; b=Iym5v2z/IqD+IpFoC
 ChJ+6jHZBe6h1ypBIDY6tCQAwL7ZiGpuQbN+jkioHJfAqTRU7Jqi5YbcgvhjUBYV
 8GsqqBI4TMOpkQpGOb4llfzCXc+Hl4qt9hm49wZztEi3V4pC/Bbl1z7lDEgKr8jU
 vFo4zzCMO8uckM8SkDXVRNk/gMLXA8Ff7QncO6t7bOQHSkmctzmviwJMOEtr9ZP5
 0tuBPFq3DKJ4ZNrfqBPzFMwrFpWEK+4IyQhpKj3hCEMdbZvZLymwJrHm7i9w620H
 36y/O3e8Qf4DkT65cwdxfyK6gjXts7WX9kGKRkhByL1AJ6X6SEAVoxfC1KU1F3dI
 +Cfcg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46q46fb6cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 11:56:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 11:56:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 11:56:15 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id E0EDA3F7080;
 Mon, 19 May 2025 11:56:10 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <vattunuru@marvell.com>, <g.singh@nxp.com>, <sachin.saxena@nxp.com>,
 <hemant.agrawal@nxp.com>, <fengchengwen@huawei.com>,
 <bruce.richardson@intel.com>, <kevin.laatz@intel.com>,
 <conor.walsh@intel.com>, <gmuthukrishn@marvell.com>,
 <vvelumuri@marvell.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [25.11 PATCH v2 0/5] Introduce DMA enqueue/dequeue operations
Date: Tue, 20 May 2025 00:25:59 +0530
Message-ID: <20250519185604.5584-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416100931.6544-1-pbhagavatula@marvell.com>
References: <20250416100931.6544-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b8uy4sGx c=1 sm=1 tr=0 ts=682b7ed0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=5UiQzHqjQ8NTYce_5-QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: G6jfdwMG1gVI6UZHEX83WeeOs3g3Msdw
X-Proofpoint-ORIG-GUID: G6jfdwMG1gVI6UZHEX83WeeOs3g3Msdw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE3NiBTYWx0ZWRfXzbomH8VPxLP7
 fryxPI4t3fiJ2bS02dFjFxWANm5XhLaPwMAz5/X3TU1jPs4M2Zpxl7dN8jK1HpVR1MCds0Y0JC/
 Y+kmHDBDj+aQqHWgmvNoe4qfeZpHKWbbZElb1S2aqKsn1j63saZf7aGan+/zivCZWnZLWG0a+GC
 LpTmkP0kaDv157nsDYdtybCir5AhhIGZ0QGyUMw1Jlr4OhqujuHDN7YfiQMkXKCUW72tF3TUm1A
 IlYzfKG3MeQZ1uw9sToolji/V8/+ukQGtABQpm9ZLV8GfOpqbCxUciAqLHPS5Jt04bmBkVasp2n
 HVKQBu+FZUfXo8Ki5eaFgAA4NJjEYZg+9cFWkvuVq5IVlYeKn6GF4Oeif/FnQcy470JbPV7ai0O
 33DinFIBKL0gLEkTfV5tJ+fRoDHmblJSaWbPgoazEr+r03Xt6B8V9SL4BTy06eoG7RosQgK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
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
* The enqueue operation behaves as a submit i.e., all the ops enqueued
  should be considered as submitted.
* Call rte_dma_dequeue() operation to get the array of finished operations.
* Free the rte_dma_op back to the mempool.

The ``rte_event_dma_adapter_op`` structure encapsulates all the
necessary fields required for DMA operations and does not introduce
any hard dependencies. Given its completeness and modular design,
it is a suitable candidate for reuse within the DMA library as
``rte_dma_op``.
This approach promotes consistency across subsystems, reduces code
duplication, and simplifies maintenance by leveraging an existing,
well-defined data structure.

Note: Not all fields inside ``rte_dma_ops`` are used by the DMA device
      as some of them are valid only in the context of event device
      programming model and can be repurposed by the application.
      These include ``op_mp``, ``impl_opaque``,
      ``user_meta``, ``event_meta``, ``dma_dev_id`` and ``vchan``.

When the DMA device is configured with RTE_DMA_CFG_FLAG_ENQ_DEQ
flag, the enqueue/dequeue operations should be used to perform
DMA operations.
All other operations i.e., rte_dma_copy, rte_dma_copy_sg,
rte_dma_fill, rte_dma_submit, rte_dma_completed,
rte_dma_completed_status are not supported.

Pavan Nikhilesh (5):
  dmadev: add enqueue dequeue operations
  test/dma: add enqueue dequeue operations
  app/dma-perf: add option to measure enq deq ops
  dma/cnxk: implement enqueue dequeue ops
  eventdev: refactor DMA adapter ops

 app/test-dma-perf/benchmark.c                 | 137 +++++++++++-
 app/test-dma-perf/config.ini                  |   3 +
 app/test-dma-perf/main.c                      |  13 +-
 app/test-dma-perf/main.h                      |   1 +
 app/test-eventdev/test_perf_common.c          |   6 +-
 app/test-eventdev/test_perf_common.h          |   4 +-
 app/test/test_dmadev.c                        | 160 ++++++++++++++
 app/test/test_dmadev_api.c                    |  78 ++++++-
 app/test/test_event_dma_adapter.c             |   6 +-
 doc/guides/prog_guide/dmadev.rst              |  34 +++
 .../prog_guide/eventdev/event_dma_adapter.rst |   6 +-
 doc/guides/tools/dmaperf.rst                  |   5 +
 drivers/dma/cnxk/cnxk_dmadev.c                |  80 +++++--
 drivers/dma/cnxk/cnxk_dmadev.h                |   7 +
 drivers/dma/cnxk/cnxk_dmadev_fp.c             | 201 +++++++++++++++---
 drivers/dma/dpaa/dpaa_qdma.c                  |   2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   2 +-
 lib/dmadev/rte_dmadev.c                       |  30 ++-
 lib/dmadev/rte_dmadev.h                       | 155 +++++++++++++-
 lib/dmadev/rte_dmadev_core.h                  |  10 +
 lib/dmadev/rte_dmadev_trace.h                 |   2 +-
 lib/dmadev/rte_dmadev_trace_fp.h              |  20 ++
 lib/dmadev/rte_dmadev_trace_points.c          |   6 +
 lib/eventdev/rte_event_dma_adapter.c          |  18 +-
 lib/eventdev/rte_event_dma_adapter.h          |  57 -----
 25 files changed, 884 insertions(+), 159 deletions(-)

--
2.43.0

