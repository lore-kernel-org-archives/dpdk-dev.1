Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E168CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Oct 2025 01:49:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F6C4026F;
	Sun, 12 Oct 2025 03:49:39 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 928EF4021F
 for <dev@dpdk.org>; Sun, 12 Oct 2025 03:49:38 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=QNIrWzoS33Sd15VCkOpNTFs2KU8+u/npMWQatOvlqsM=;
 b=T15iVijD11qgk8TO7NJk1vf00cmFARbX7D0qWoTedC7tHouf2piLIyewGt4K0Lw4BfWLXE3xJ
 lL7mNfh2RX7tbTItFQNwy6Q8nVrtft+6+DYCthyBQxh8o6v1w7kjo742OWvYeUqM6c75Hz0SReG
 B2q29e1gLBdOMb0gYwV592g=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4ckk0X1XcXzcb0X;
 Sun, 12 Oct 2025 09:48:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 7DDEF140278;
 Sun, 12 Oct 2025 09:49:36 +0800 (CST)
Received: from [10.82.125.119] (10.82.125.119) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 12 Oct 2025 09:49:35 +0800
Message-ID: <85e63937-4c1e-48f4-8052-214af37987e9@huawei.com>
Date: Sun, 12 Oct 2025 09:49:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/1] lib/dma: introduce inter-process and inter-OS DMA
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>, <jerinj@marvell.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <20251010144631.713063-1-vattunuru@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251010144631.713063-1-vattunuru@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.82.125.119]
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

On 2025/10/10 22:46, Vamsi Krishna wrote:
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
> for inter-process and inter-OS domain DMA transfers. It adds a mechanism
> to specify source and destination handlers via the vchan configuration.
> Until standardized control-plane APIs are defined for various categories
> of DMA devices, these handler details can be exchanged through private
> driver mechanisms.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> V2 changes:
> * Seperate out the control-plane APIs
> * Address v0 review comments
> * Add validation checks
> * Rename the enums
>
>   lib/dmadev/rte_dmadev.c       | 19 ++++++++++++
>   lib/dmadev/rte_dmadev.h       | 56 +++++++++++++++++++++++++++++++++++
>   lib/dmadev/rte_dmadev_trace.h |  3 ++
>   3 files changed, 78 insertions(+)
>
> diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
> index 17ee0808a9..23864dcb00 100644
> --- a/lib/dmadev/rte_dmadev.c
> +++ b/lib/dmadev/rte_dmadev.c
> @@ -659,6 +659,21 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
>   		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
>   		return -EINVAL;
>   	}
> +	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
> +	    conf->domain.domain_type != RTE_DMA_INTER_DOMAIN_NONE) {
> +		RTE_DMA_LOG(ERR, "Device %d direction and inter domain are invalid!", dev_id);

how about "Device %d inter domain only support memory-to-memory transfer" ?

so could be:

if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&

     conf->direction != RTE_DMA_DIR_MEM_TO_MEM)


> +		return -EINVAL;
> +	}
> +	if (conf->domain.domain_type == RTE_DMA_INTER_OS_DOMAIN &&
> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
> +		return -EINVAL;
> +	}
> +	if (conf->domain.domain_type == RTE_DMA_INTER_PROCESS_DOMAIN &&
> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
> +		return -EINVAL;
> +	}
>   	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
>   	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
>   	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
> @@ -805,6 +820,8 @@ dma_capability_name(uint64_t capability)
>   		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
>   		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
>   		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
> +		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN, "inter_process_domain" },
> +		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
>   		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
>   		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
>   		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
> @@ -1014,6 +1031,8 @@ dmadev_handle_dev_info(const char *cmd __rte_unused,
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_HANDLES_ERRORS);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_M2D_AUTO_FREE);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
> +	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
> +	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_OS_DOMAIN);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL);
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 550dbfbf75..12c249ec00 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -265,6 +265,18 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
>    * known from 'nb_priorities' field in struct rte_dma_info.
>    */
>   #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
> +/** Support inter-process DMA transfers.
> + *
> + * When this bit is set, the DMA device can perform memory transfers between
> + * different process memory spaces.
> + */
> +#define RTE_DMA_CAPA_INTER_PROCESS_DOMAIN	RTE_BIT64(9)
> +/** Support inter-OS domain DMA transfers.
> + *
> + * The DMA device can perform memory transfers across different operating
> + * system domains.
> + */
> +#define RTE_DMA_CAPA_INTER_OS_DOMAIN		RTE_BIT64(10)
>   
>   /** Support copy operation.
>    * This capability start with index of 32, so that it could leave gap between
> @@ -418,8 +430,13 @@ int rte_dma_close(int16_t dev_id);
>    */
>   enum rte_dma_direction {
>   	/** DMA transfer direction - from memory to memory.
> +	 * When the device supports inter-process or inter-OS domain transfers,
> +	 * the field `domain_type` in `struct rte_dma_vchan_conf::domain` specifies
> +	 * the type of domain. For memory-to-memory transfers within the same domain
> +	 * or process, `domain_type` should be set to `RTE_DMA_INTER_DOMAIN_NONE`.
>   	 *
>   	 * @see struct rte_dma_vchan_conf::direction
> +	 * @see struct rte_dma_inter_domain_param::domain_type
>   	 */
>   	RTE_DMA_DIR_MEM_TO_MEM,
>   	/** DMA transfer direction - from memory to device.
> @@ -564,6 +581,36 @@ struct rte_dma_auto_free_param {
>   	uint64_t reserved[2];
>   };
>   
> +/**
> + * Inter-DMA transfer domain type.
> + *
> + * This enum defines the types of transfer domains applicable to DMA operations.
> + * It helps categorize whether a DMA transfer is occurring within the same domain,
> + * across different processes, or between distinct operating system domains.
> + *
> + * @see struct rte_dma_inter_domain_param:domain_type
> + */
> +enum rte_dma_inter_domain_type {
> +	RTE_DMA_INTER_DOMAIN_NONE, /**< No inter-domain transfer; standard DMA within same domain */
> +	RTE_DMA_INTER_PROCESS_DOMAIN, /**< Transfer occurs between different user-space processes */
> +	RTE_DMA_INTER_OS_DOMAIN, /**< Transfer spans across different operating system domains. */

please place the comment before the definition.

> +};
> +
> +/**
> + * Parameters for inter-process or inter-OS DMA transfers.
> + *
> + * This structure defines the parameters required to perform DMA transfers
> + * across different domains, such as between processes or operating systems.
> + * It includes the domain type and handler identifiers for both the source
> + * and destination domains.
> + */
> +struct rte_dma_inter_domain_param {
> +	enum rte_dma_inter_domain_type domain_type; /**< Type of inter-domain. */

please rename domian_type to type because we are in domain context.

> +	uint16_t src_handler; /**< Source domain handler identifier. */
> +	uint16_t dst_handler; /**< Destination domain handler identifier. */
> +	uint64_t reserved[2]; /**< Reserved for future fields. */
> +};
> +
>   /**
>    * A structure used to configure a virtual DMA channel.
>    *
> @@ -601,6 +648,15 @@ struct rte_dma_vchan_conf {
>   	 * @see struct rte_dma_auto_free_param
>   	 */
>   	struct rte_dma_auto_free_param auto_free;
> +	/** Parameters for inter-process or inter-OS domain DMA transfers. This field
> +	 * specifies the source and destination domain handlers required  for DMA

two spaces before 'for DMA'

> +	 * operations that span across different processes or operating system domains.
> +	 *
> +	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
> +	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
> +	 * @see struct rte_dma_inter_domain_param
> +	 */
> +	struct rte_dma_inter_domain_param domain;
>   };
>   
>   /**
> diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
> index 1de92655f2..12ea9d53f6 100644
> --- a/lib/dmadev/rte_dmadev_trace.h
> +++ b/lib/dmadev/rte_dmadev_trace.h
> @@ -79,6 +79,9 @@ RTE_TRACE_POINT(
>   	rte_trace_point_emit_int(conf->dst_port.port_type);
>   	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
>   	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
> +	rte_trace_point_emit_int(conf->domain.domain_type);
> +	rte_trace_point_emit_u16(conf->domain.src_handler);
> +	rte_trace_point_emit_u16(conf->domain.dst_handler);
>   	rte_trace_point_emit_int(ret);
>   )
>   
