Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA54CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3230540684;
	Fri, 19 Sep 2025 11:02:46 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id A010F402C1
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:02:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cSmcZ0VQ0z2Cgdj;
 Fri, 19 Sep 2025 16:58:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 513B31A0190;
 Fri, 19 Sep 2025 17:02:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Sep 2025 17:02:41 +0800
Message-ID: <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
Date: Fri, 19 Sep 2025 17:02:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] lib/dma: introduce inter-process and inter-OS DMA
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <vladimir.medvedkin@intel.com>, <anatoly.burakov@intel.com>,
 <kevin.laatz@intel.com>, <jerinj@marvell.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250901123341.2665186-1-vattunuru@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

This commit change is more than discussed, it add control API which for group management.

1. Control API: I check this commit and Intel commit [1], it seem has a quite difference.
   I hope Intel guys can express views. I prefer not add this part if no response.

2. Data API: this commit provide two way (vchan and flags) to use this feature, I'd rather
   stick to one, that way, so the app won't go haywire.

   The vchan scheme seems inflexible. If you want to update communication objects frequently
   during operation, the vchan needs to be recreated.

   I prefer reserved 16bit from flags (not 32bit because it seem has no such requirement).

[1] https://mails.dpdk.org/archives/dev/2023-August/274590.html

Thanks

On 9/1/2025 8:33 PM, Vamsi Krishna wrote:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Modern DMA hardware supports data transfers between multiple DMA
> devices, facilitating data communication across isolated domains,
> containers, or operating systems. These DMA transfers function as
> standard memory-to-memory operations, but with source or destination
> addresses residing in different process or OS address space. The
> exchange of these addresses between processes is handled through
> private driver mechanism, which are beyond the scope of this
> specification change.
> 
> This commit introduces new capability flags to advertise driver support
> for inter-process or inter-OS DMA transfers. It provides two mechanisms
> for specifying source and destination handlers: either through the vchan
> configuration or via the flags parameter in DMA enqueue APIs. This commit
> also adds a controller ID field to specify the device hierarchy details
> when applicable.
> 
> To ensure secure and controlled DMA transfers, this commit adds a set
> of APIs for creating and managing access groups. Devices can create or
> join an access group using token-based authentication, and only devices
> within the same group are permitted to perform DMA transfers across
> processes or OS domains. This approach enhances security and flexibility
> for advanced DMA use cases in multi-tenant or virtualized environments.
> 
> The following flow demonstrates how two processes (a group creator and a
> group joiner) use the DMA access group APIs to securely set up and
> manage inter-process DMA transfers:
> 
> 1) Process 1 (Group Creator):
>    Calls rte_dma_access_group_create(group_token, &group_id) to create a
>    new access group.
>    Shares group_id and group_token with Process 2 via IPC.
> 2) Process 2 (Group Joiner):
>    Receives group_id and group_token from Process 1.
>    Calls rte_dma_access_group_join(group_id, group_token) to join the
>    group.
> 3) Both Processes:
>    Use rte_dma_access_group_size_get() to check the number of devices in
>    the group.
>    Use rte_dma_access_group_get() to retrieve the group table and
>    handler information.
> 
>    Perform DMA transfers as needed.
> 
> 4) Process 2 (when done):
>    Calls rte_dma_access_group_leave(group_id) to leave the group.
> 5) Process 1:
>    Receives RTE_DMA_EVENT_ACCESS_TABLE_UPDATE to be notified of group
>    changes.
>    Uses rte_dma_access_group_size_get() to confirm the group size.
> 
> This flow ensures only authenticated and authorized devices can
> participate in inter-process or inter-OS DMA transfers, enhancing
> security and isolation.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  lib/dmadev/rte_dmadev.c       | 320 ++++++++++++++++++++++++++++++++++
>  lib/dmadev/rte_dmadev.h       | 255 +++++++++++++++++++++++++++
>  lib/dmadev/rte_dmadev_pmd.h   |  48 +++++
>  lib/dmadev/rte_dmadev_trace.h |  51 ++++++
>  4 files changed, 674 insertions(+)
> 

...

