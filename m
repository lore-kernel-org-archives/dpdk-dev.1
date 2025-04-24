Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC484C369D1
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 07:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBFF240156;
	Thu, 24 Apr 2025 09:01:31 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 2A2B1400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 09:01:29 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZjmxT6bq8zvWvw;
 Thu, 24 Apr 2025 14:57:17 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 79C781402CD;
 Thu, 24 Apr 2025 15:01:27 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 15:01:26 +0800
Message-ID: <b296e45a-131e-4956-a9dd-260d7a120996@huawei.com>
Date: Thu, 24 Apr 2025 15:01:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [25.11 PATCH 1/3] dmadev: add enqueue dequeue operations
To: <pbhagavatula@marvell.com>, <jerinj@marvell.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
CC: <vattunuru@marvell.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <20250416100931.6544-1-pbhagavatula@marvell.com>
 <20250416100931.6544-2-pbhagavatula@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250416100931.6544-2-pbhagavatula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Hi Pavan,

On 2025/4/16 18:09, pbhagavatula@marvell.com wrote:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Add enqueue/dequeue operations that use struct rte_dma_op
> to communicate with the dma device.
> These operations need to be enabled at dma device configuration
> time by setting the flag rte_dma_conf::enable_enq_deq if the
> device supports RTE_DMA_CAPA_OPS_ENQ_DEQ capability.
> The enqueue dequeue operations are not compatible with
> rte_dma_copy, rte_dma_copy_sg, rte_dma_fill, rte_dma_submit,
> rte_dma_completed, rte_dma_completed_status range of APIs.
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
>  app/test/test_dmadev.c               | 160 +++++++++++++++++++++++++++
>  app/test/test_dmadev_api.c           |  78 +++++++++++--
>  doc/guides/prog_guide/dmadev.rst     |  34 ++++++
>  drivers/dma/dpaa/dpaa_qdma.c         |   2 +-
>  drivers/dma/dpaa2/dpaa2_qdma.c       |   2 +-
>  lib/dmadev/rte_dmadev.c              |  30 ++++-
>  lib/dmadev/rte_dmadev.h              | 155 ++++++++++++++++++++++++--
>  lib/dmadev/rte_dmadev_core.h         |  10 ++
>  lib/dmadev/rte_dmadev_trace.h        |   2 +-
>  lib/dmadev/rte_dmadev_trace_fp.h     |  20 ++++
>  lib/dmadev/rte_dmadev_trace_points.c |   6 +
>  11 files changed, 477 insertions(+), 22 deletions(-)

It seemed this API couldn't use at the same time with original API. Could you describe this explicitly?
I'm inferring that this feature is added mainly for performance. and we traded it off when design the API.
So could you share the performance gain when use this API compared with original API?

You have show the programming model for the enqueue/dequeue operations at cover letter, that's nice,
but I want to know the higher level: how the library API interact with Application. so that I can
understand why the rte_dma_op contain so such fields.

And also, please split this commit to at least two: one for library, one for UT.

Thanks

