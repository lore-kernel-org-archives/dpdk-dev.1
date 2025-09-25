Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CBCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 02:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8923E40276;
	Thu, 25 Sep 2025 04:06:23 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 8212A40151
 for <dev@dpdk.org>; Thu, 25 Sep 2025 04:06:21 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cXH6L42Vrz2RWH9;
 Thu, 25 Sep 2025 10:02:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5CEF61A0188;
 Thu, 25 Sep 2025 10:06:09 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 10:06:08 +0800
Message-ID: <3ee3f047-e1d9-4d71-b1a9-fff271f6a345@huawei.com>
Date: Thu, 25 Sep 2025 10:06:08 +0800
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

...

>  
> +/**
> + * Inter-DMA transfer type.
> + *
> + * Specifies the type of DMA transfer, indicating whether the operation
> + * is within the same domain, between different processes, or across different
> + * operating system domains.
> + *
> + * @see struct rte_dma_inter_transfer_param:transfer_type
> + */
> +enum rte_dma_inter_transfer_type {
> +	RTE_DMA_INTER_TRANSFER_NONE, /**< No inter-domain transfer. */
> +	RTE_DMA_INTER_PROCESS_TRANSFER, /**< Transfer is between different processes. */
> +	RTE_DMA_INTER_OS_TRANSFER, /**< Transfer is between different OS domains. */

how about rte_dma_inter_domain_type {
	RTE_DMA_INTER_DOMAIN_NONE,
	RTE_DMA_INTER_PRTOCESS_DOMAIN,
	RTE_DMA_INTER_OS_DOMAIN,
}

> +};
> +
> +/**
> + * Parameters for inter-process or inter-OS DMA transfers.
> + *
> + * This structure holds the necessary information to perform DMA transfers
> + * between different processes or operating system domains, including the
> + * transfer type and handler identifiers for the source and destination.
> + */
> +struct rte_dma_inter_transfer_param {
> +	enum rte_dma_inter_transfer_type transfer_type; /**< Type of inter-domain transfer. */
> +	uint16_t src_handler; /**< Source handler identifier. */
> +	uint16_t dst_handler; /**< Destination handler identifier. */
> +	uint64_t reserved[2]; /**< Reserved for future fields. */

how about: struct rte_dma_inter_domain_param {
	enum rte_dma_inter_domain_type domain_type; /**< Type of inter-domain. */
	uint16_t src_handler; /**< Source domain handler identifier. */
	uint16_t dst_handler; /**< Destination domain handler identifier. */
	uint64_t reserved[2]; /**< Reserved for future fields. */
}

It's mean local process if the src/dst_handler is zero?
for example, I setup a inter-os domain param, if the src_handle is none zero and dst_handle is zero,
then all DMA copy will from another OS to local process.
     all DMA fill will write to local process.

If the src_handle is zero and dst_handle is non-zero,
then all DMA copy will from local process to another OS domain
     all DMA fill will write to another OS domain.

If both src_handle and dst_handle is none,
then all DMA copy will from another OS to another OS domain
     all DMA fill will write to another OS domain.

Please add such comments.

And also It's necessary to verify these parameters during vchan-setup.

> +};
> +
>  /**
>   * A structure used to configure a virtual DMA channel.
>   *
> @@ -601,6 +650,14 @@ struct rte_dma_vchan_conf {
>  	 * @see struct rte_dma_auto_free_param
>  	 */
>  	struct rte_dma_auto_free_param auto_free;
> +	/** Parameters for inter-process or inter-OS DMA transfers to specify
> +	 * the source and destination handlers.
> +	 *
> +	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
> +	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
> +	 * @see struct rte_dma_inter_transfer_param
> +	 */
> +	struct rte_dma_inter_transfer_param inter_transfer;
>  };
>  

...
