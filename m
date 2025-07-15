Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E0C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 00:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18B144021E;
	Tue, 15 Jul 2025 02:59:14 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 9A1094013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 02:59:12 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bh1585W5GztSQF;
 Tue, 15 Jul 2025 08:58:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 462FE1401F3;
 Tue, 15 Jul 2025 08:59:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 08:59:09 +0800
Message-ID: <01a66ad9-a763-457a-b0b2-c6aae1948f84@huawei.com>
Date: Tue, 15 Jul 2025 08:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>,
 <pbhagavatula@marvell.com>, <kevin.laatz@intel.com>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250710085101.1678775-1-vattunuru@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Hi Vamsi,

From the commit log, I guess this commit mainly want to meet following case:

     ---------------             ----------------
     |  Container  |             |  VirtMachine |
     |             |             |              |
     |  dmadev-1   |             |   dmadev2    |
     ---------------             ----------------
           |                            |
           ------------------------------

App run in the container could launch DMA transfer from local buffer to the VirtMachine by config
dmadev-1/2 (the dmadev-1/2 are passthrough to diffent OS domain).

Could you explain how to use it from application perspective (for example address translation) and
application & hardware restrictions?


BTW: In this case, there are two OS domain communication, and I remember there are also inter-process
DMA RFC, so maybe we could design more generic solution if you provide more info.

Thanks

On 2025/7/10 16:51, Vamsi Krishna wrote:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Modern DMA hardware supports data transfer between multiple
> DMA devices, enabling data communication across isolated domains or
> containers. To facilitate this, the ``dmadev`` library requires changes
> to allow devices to register with or unregisters from DMA groups for
> inter-device communication. This feature is planned for inclusion
> in DPDK 25.11.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index e2d4125308..46836244dd 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -152,3 +152,10 @@ Deprecation Notices
>  * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
>    ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
>    Those API functions are used internally by DPDK core and netvsc PMD.
> +
> +* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV`` will be added
> +  to advertise DMA device's inter-device DMA copy capability. To enable
> +  this functionality, a few dmadev APIs will be added to configure the DMA
> +  access groups, facilitating coordinated data communication between devices.
> +  A new ``dev_idx`` field will be added to the ``struct rte_dma_vchan_conf``
> +  structure to configure a vchan for data transfers between any two DMA devices.

