Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8591DC54E71
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 May 2025 09:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B113402D3;
	Sat, 24 May 2025 11:13:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9C21E40298
 for <dev@dpdk.org>; Sat, 24 May 2025 11:13:34 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O8XZbJ021252;
 Sat, 24 May 2025 02:13:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 X6Y939jHVmQ3j9WSqiq+ip2o+rSzdq+GRwn+8/L78E=; b=TXJhIhPoQyGAg5B5s
 QsEEBwLmA500HSLpY/uH4P7/z5z27A3VT8NgzlvhU5m0Rmbeu9DdU705URclOvQX
 zkKI94jxh/X+vKlZWZsrKZzbFGm5NIcCeuQx5ZuyKquFEltbOtD0DrZwiXM+S/1K
 Seyg+zxhkhl70PArMdZwU3hBUZamVGAtBprt4gI9jdf8IbWF87JvVCgtraOti1a7
 npuivJCOz8tc44piOxbB3geF0MM23wu6cKEFHs6TvL//V4E3RS0bFeQLzUcwN/R2
 lD9Mdxx9lRArLiBfgWuhXFRBVQQD7VjdRTEqyyRXR2z2Irz1pBMWpqxYqdmQGB15
 vHVmg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46u5dk0bfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 May 2025 02:13:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 24 May 2025 02:13:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 24 May 2025 02:13:31 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 3B7A93F7079;
 Sat, 24 May 2025 02:13:26 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <vattunuru@marvell.com>, <g.singh@nxp.com>, <sachin.saxena@nxp.com>,
 <hemant.agrawal@nxp.com>, <fengchengwen@huawei.com>,
 <bruce.richardson@intel.com>, <kevin.laatz@intel.com>,
 <conor.walsh@intel.com>, <gmuthukrishn@marvell.com>,
 <vvelumuri@marvell.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Date: Sat, 24 May 2025 14:43:10 +0530
Message-ID: <20250524091316.10056-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519185604.5584-1-pbhagavatula@marvell.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDA4MyBTYWx0ZWRfX1/FOq2850NcP
 UKhiUPDqBDvZI7vfFUaSOYP9fmWZ9j95jVJbc+ubyMaWD6MyeeOP/wFh5TPgp07sVys+e0RmlSx
 Y4fFGVMrfUUcKVTRVX5A2XxX5IyO8iOs4WwOZPRR62VYSuEthP2B5ewvPZsm+VZKUGc/pZ2FNjl
 V4n9rA2dYYt1ZBkpqieY5u8u3U+c7Cv0cFY5bu9pUes0ZgAjVExXYyTdrbsKoyuSCFb1FOt3nIR
 +v31lW98jNZp7pmIlAIrCyimzwKDamtgto0hn/AENvDk5BdtspefLzIIad2BPiNd58b+jT4NSVA
 4FM5r/EyFjKlE3CG53UsEFZXyaZE5jpY7zR6i8gKPjt1lKLbZIkqBHxGWksx7ZHZTxs0FK79Vq8
 5/1vmXwJrTicUrt9qil3WFji995CVFrR374G7f22Q6tIIm0VJf/ofcGLKsANYjpB9vw1Uwap
X-Authority-Analysis: v=2.4 cv=HpV2G1TS c=1 sm=1 tr=0 ts=68318dbd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=5UiQzHqjQ8NTYce_5-QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WAtKzlnYBOpYL6_FuVr5pMqTfXPlxHi3
X-Proofpoint-GUID: WAtKzlnYBOpYL6_FuVr5pMqTfXPlxHi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_04,2025-05-22_01,2025-03-28_01
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

On OCTEON CNXK platform, we observed upto 20% latency reduction by using
enqueue and dequeue ops.

v2 Changes:
- Split app/test changes to new patch.
- update app/test-dma-perf by adding option to test enq/deq ops.

v3 Changes:
- Fix github build failure.

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
 lib/dmadev/rte_dmadev_trace_points.c          |   8 +
 lib/eventdev/rte_event_dma_adapter.c          |  18 +-
 lib/eventdev/rte_event_dma_adapter.h          |  57 -----
 25 files changed, 886 insertions(+), 159 deletions(-)

--
2.43.0

