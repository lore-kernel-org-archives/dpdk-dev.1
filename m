Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC425CA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2767440274;
	Sat, 10 Oct 2026 11:31:32 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id ADEB84026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:31:30 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=STYTCfMzQMrlfvjzPGp5luLLhDd1H4lz+skpDU+IuY4=;
 b=z2UT6Cu49TndFDqogdjUUz2UowhvhWSpJEmcV9XfWkd9k4o+B3byYneB3Y3oUj7+vTHk3EW77
 F2L8QPH1iXBUvDvBQFtdQgie2FZYaguD16YHOPI/uxYwSfNHffXu/Q5WiWQ+zErhJYusjRTItsz
 +su4DxklvWRmBWm8/DTW860=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j1ypl3ZvMz1prN4;
 Sat, 10 Oct 2026 17:19:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id C93A72011D;
 Sat, 10 Oct 2026 17:31:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 17:31:28 +0800
Message-ID: <bed911b9-df95-42c0-9b76-51c805e7694f@huawei.com>
Date: Sat, 10 Oct 2026 17:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Gagandeep Singh <g.singh@nxp.com>, <hemant.agrawal@nxp.com>
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
 <CAJFAV8z0pe6-B8Mmab2fkfji76rgboMbWD5BcFLQLGz96xtcFg@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8z0pe6-B8Mmab2fkfji76rgboMbWD5BcFLQLGz96xtcFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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



On 10/9/2026 1:27 AM, David Marchand wrote:
> Hello Chengwen,
> 
> On Wed, 12 Aug 2026 at 11:29, Gagandeep Singh <g.singh@nxp.com> wrote:
>>
>> V4-changes:
>>   - Removed the redundant local buffer "want"
>>   - Updated the comment for RTE_PMD_REGISTER_ALIAS
>>   - Removed stray extra blank line.
>>
>> V3-changes:
>>  - Fixed below AI comments:
>>    - Dead quote-stripping removed (`of_device_is_compatible`)
>>    - Redundant `goto out` removed
>>    - New Features entry added for bus platform changes.
>>    - Scatter-gather doc corrected in both sections
>>    - Unused CH_MATTR macros removed
>>    - Fixed SG sub-transfer length cap (`imx_edma5_copy_sg`)
>>    - Updated Per-job timeout logic.
>>    - Updated `rte_mem_iova2virt` per-op in IOVA=VA mode logic
>>    - Updated comments and documentation as per the AI comments.
>>
>> V2-changes:
>>  - Added dependent patch: bus/platform: match device by devicetree compatible string
>>  - Fixed multiple AI reported issues includes:
>>    - removed the alias from the driver, no need of it
>>    - removed imx_edma5_write32 from data-path, reported as coherency
>>      concern.
>>    - fix submit for previously enqueued jobs.
>>    - Added dsb in data path
>>    - Added a commnet for rte_mem_iova2virt() NULL behaviour.
>>    - Fixed: TCD NBYTES bits 31:30 are SMLOE/DMLOE — full 32-bit length corrupts them
>>    - Data path is fully synchronous: Acknowledged but intentionally deferred —
>>      the synchronous design is a deliberate simplification for the initial upstream submission.
>>      Noted in docs.
>>    - In-memory TCD64 pool is more complex than needed:
>>      Noted/deferred — the pool structure was retained for forward compatibility
>>      with hardware SG chaining.
>>    - Extended `imx_edma5_dump()` to read and print `CH_CSR` and `CH_ES` registers
>>      for every configured vchan.
>>    - Double and stary lines removed.
>>
>> V1:
>> This patch series adds a new dmadev Poll-Mode Driver (PMD) for the NXP
>> i.MX95 eDMA5 (Enhanced DMA Type 5) controller.
>>
>> Key features supported by this driver:
>>   - Memory-to-memory copy (RTE_DMA_OP_TYPE_MEMCPY)
>>   - Scatter-gather memory copy (RTE_DMA_OP_TYPE_SG)
>>   - 64-bit TCD (Transfer Control Descriptor) format
>>   - Non-coherent DMA with explicit cache clean/invalidate
>>   - Per-channel statistics and register dump for debug
>>
>> Patch breakdown:
>>   [1/5] bus/platform: add dependent patch to detect device using
>>         compatible string.
>>   [2/5] Skeleton: bus probe/remove, dmadev registration, MAINTAINERS,
>>         doc index, and release notes for 26.11.
>>   [3/5] Device configuration: vchan setup, TCD ring allocation,
>>         start/stop, and capability reporting.
>>   [4/5] Data path: enqueue (copy and sg), doorbell, completion poll.
>>   [5/5] Statistics and dump: per-channel counters and register dump.
>>
>> Tested on NXP i.MX95 EVK with vfio-platform.
>>
>>
>> Gagandeep Singh (5):
>>   bus/platform: match device by devicetree compatible string
>>   dma/imx_edma5: introduce eDMA5 dmadev skeleton
>>   dma/imx_edma5: add device configuration
>>   dma/imx_edma5: add data path
>>   dma/imx_edma5: add statistics and dump
>>
>>  MAINTAINERS                                |    5 +
>>  doc/guides/dmadevs/imx_edma5.rst           |   69 ++
>>  doc/guides/dmadevs/index.rst               |    1 +
>>  doc/guides/rel_notes/release_26_11.rst     |   15 +
>>  drivers/bus/platform/bus_platform_driver.h |   11 +-
>>  drivers/bus/platform/platform.c            |   49 +-
>>  drivers/dma/imx_edma5/imx_edma5_dmadev.c   | 1190 ++++++++++++++++++++
>>  drivers/dma/imx_edma5/imx_edma5_dmadev.h   |  234 ++++
>>  drivers/dma/imx_edma5/imx_edma5_hw.h       |  143 +++
>>  drivers/dma/imx_edma5/imx_edma5_logs.h     |   16 +
>>  drivers/dma/imx_edma5/meson.build          |   10 +
>>  drivers/dma/meson.build                    |    1 +
>>  12 files changed, 1741 insertions(+), 3 deletions(-)
>>  create mode 100644 doc/guides/dmadevs/imx_edma5.rst
>>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
>>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
>>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
>>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
>>  create mode 100644 drivers/dma/imx_edma5/meson.build
> 
> Please, could you have a look at this new DMA driver?

Thanks for the reminder. The review has been completed.

> 
> 

