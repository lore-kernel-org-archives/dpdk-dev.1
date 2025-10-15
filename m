Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9BCCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF114064C;
	Wed, 15 Oct 2025 09:09:29 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 87D044064C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:09:26 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=X0X4o0JWMIFl5yfLkGAmR4xnp7K7rR8l/V1pQGxqnHQ=;
 b=HWNxqpkXYaumsTwb29zSOBBoXF4sFDENxlcDM0Ktgbc9ri3QXkAELcAKvwyKBeJPfkeuR41oB
 RD1pJ6pQWKYTbOtsq2pMXES4aAfiYaQHAcQ86LwwcIUjFq7nKoIGDJ4H7gWi6JlE98pr7qZDG1q
 UGqCmsORoqQzIbzyVTfF/IY=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cmhym1hCzz1prQ1;
 Wed, 15 Oct 2025 15:09:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C579F1400E3;
 Wed, 15 Oct 2025 15:09:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:09:24 +0800
Message-ID: <1ad2235d-147f-4de3-81b0-12f58887ae59@huawei.com>
Date: Wed, 15 Oct 2025 15:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/1] lib/dma: introduce inter-process
 and inter-OS DMA
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>, 
 Jerin Jacob <jerinj@marvell.com>
References: <--in-reply-to=20251010144631.713063-1-vattunuru@marvell.com>
 <20251013042136.1727540-1-vattunuru@marvell.com>
 <8e1d0411-5d9c-4af1-840e-ece661c08e2f@huawei.com>
 <SJ4PPFEA6F74CA2BD14F608EAB09B9E4029A6EAA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <SJ4PPFEA6F74CA2BD14F608EAB09B9E4029A6EAA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
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

On 10/14/2025 2:31 AM, Vamsi Krishna Attunuru wrote:
>>
>> ZjQcmQRYFpfptBannerEnd
>> with below comment fixed:
>> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>>
>> On 10/13/2025 12:21 PM, Vamsi Krishna wrote:
>>> From: Vamsi Attunuru <vattunuru@marvell.com>
>>>
>>> Modern DMA hardware supports data transfers between multiple DMA
>>> devices, facilitating data communication across isolated domains,
>>> containers, or operating systems. These DMA transfers function as
>>> standard memory-to-memory operations, but with source or destination
>>> addresses residing in different process or OS address space. The
>>> exchange of these addresses between processes is handled through
>>> private driver mechanism, which are beyond the scope of this
>>> specification change.
>>>
>>> This commit introduces new capability flags to advertise driver
>>> support for inter-process and inter-OS domain DMA transfers. It adds a
>>> mechanism to specify source and destination handlers via the vchan
>> configuration.
>>> Until standardized control-plane APIs are defined for various
>>> categories of DMA devices, these handler details can be exchanged
>>> through private driver mechanisms.
>>>
>>> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>>> ---
>>> V3 changes:
>>> * Fix v2 review comments
>>> V2 changes:
>>> * Seperate out the control-plane APIs
>>> * Address v0 review comments
>>> * Add validation checks
>>> * Rename the enums
>>>
>>>  lib/dmadev/rte_dmadev.c       | 19 +++++++++++
>>>  lib/dmadev/rte_dmadev.h       | 59
>> +++++++++++++++++++++++++++++++++++
>>>  lib/dmadev/rte_dmadev_trace.h |  3 ++
>>>  3 files changed, 81 insertions(+)
>>>
>>> diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c index
>>> 17ee0808a9..d6792449bf 100644
>>> --- a/lib/dmadev/rte_dmadev.c
>>> +++ b/lib/dmadev/rte_dmadev.c
>>> @@ -659,6 +659,21 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t
>> vchan,
>>>  		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
>>>  		return -EINVAL;
>>>  	}
>>> +	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
>>> +	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
>>> +		RTE_DMA_LOG(ERR, "Device %d inter domain only support
>> mem-to-mem transfer", dev_id);
>>> +		return -EINVAL;
>>> +	}
>>> +	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
>>> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
>>> +		RTE_DMA_LOG(ERR, "Device %d does not support inter os
>> domain", dev_id);
>>> +		return -EINVAL;
>>> +	}
>>> +	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
>>> +	    !(dev_info.dev_capa &
>> RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
>>> +		RTE_DMA_LOG(ERR, "Device %d does not support inter
>> process domain", dev_id);
>>> +		return -EINVAL;
>>> +	}
>>>  	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
>>>  	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
>>>  	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM && @@ -805,6
>> +820,8 @@
>>> dma_capability_name(uint64_t capability)
>>>  		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
>>>  		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
>>>  		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
>>> +		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN,
>> "inter_process_domain" },
>>> +		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
>>>  		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
>>>  		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
>>>  		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
>>> @@ -1014,6 +1031,8 @@ dmadev_handle_dev_info(const char *cmd
>> __rte_unused,
>>>  	ADD_CAPA(dma_caps, dev_capa,
>> RTE_DMA_CAPA_HANDLES_ERRORS);
>>>  	ADD_CAPA(dma_caps, dev_capa,
>> RTE_DMA_CAPA_M2D_AUTO_FREE);
>>>  	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
>>> +	ADD_CAPA(dma_caps, dev_capa,
>> RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
>>> +	ADD_CAPA(dma_caps, dev_capa,
>> RTE_DMA_CAPA_INTER_OS_DOMAIN);
>>>  	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
>>>  	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
>>>  	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL); diff --
>> git
>>> a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h index
>>> 550dbfbf75..4f735bb0c9 100644
>>> --- a/lib/dmadev/rte_dmadev.h
>>> +++ b/lib/dmadev/rte_dmadev.h
>>> @@ -265,6 +265,18 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
>>>   * known from 'nb_priorities' field in struct rte_dma_info.
>>>   */
>>>  #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
>>> +/** Support inter-process DMA transfers.
>>> + *
>>> + * When this bit is set, the DMA device can perform memory transfers
>>> +between
>>> + * different process memory spaces.
>>> + */
>>> +#define RTE_DMA_CAPA_INTER_PROCESS_DOMAIN	RTE_BIT64(9)
>>> +/** Support inter-OS domain DMA transfers.
>>> + *
>>> + * The DMA device can perform memory transfers across different
>>> +operating
>>> + * system domains.
>>> + */
>>> +#define RTE_DMA_CAPA_INTER_OS_DOMAIN		RTE_BIT64(10)
>>>
>>>  /** Support copy operation.
>>>   * This capability start with index of 32, so that it could leave gap
>>> between @@ -418,8 +430,13 @@ int rte_dma_close(int16_t dev_id);
>>>   */
>>>  enum rte_dma_direction {
>>>  	/** DMA transfer direction - from memory to memory.
>>> +	 * When the device supports inter-process or inter-OS domain
>> transfers,
>>> +	 * the field `type` in `struct rte_dma_vchan_conf::domain` specifies
>> the
>>> +	 * type of domain. For memory-to-memory transfers within the same
>> domain
>>> +	 * or process, `type` should be set to
>> `RTE_DMA_INTER_DOMAIN_NONE`.
>>>  	 *
>>>  	 * @see struct rte_dma_vchan_conf::direction
>>> +	 * @see struct rte_dma_inter_domain_param::type
>>>  	 */
>>>  	RTE_DMA_DIR_MEM_TO_MEM,
>>>  	/** DMA transfer direction - from memory to device.
>>> @@ -564,6 +581,39 @@ struct rte_dma_auto_free_param {
>>>  	uint64_t reserved[2];
>>>  };
>>>
>>> +/**
>>> + * Inter-DMA transfer domain type.
>>> + *
>>> + * This enum defines the types of transfer domains applicable to DMA
>> operations.
>>> + * It helps categorize whether a DMA transfer is occurring within the
>>> +same domain,
>>> + * across different processes, or between distinct operating system
>> domains.
>>> + *
>>> + * @see struct rte_dma_inter_domain_param:type  */ enum
>>> +rte_dma_inter_domain_type {
>>> +	/**< No inter-domain transfer; standard DMA within same domaini.
>> */
>>> +	RTE_DMA_INTER_DOMAIN_NONE,
>>> +	/**< Transfer occurs between different user-space processes. */
>>> +	RTE_DMA_INTER_PROCESS_DOMAIN,
>>> +	/**< Transfer spans across different operating system domains. */
>>> +	RTE_DMA_INTER_OS_DOMAIN,
>>
>> If comment located before define, it should prefix with ** not **<
> 
> Ack, will fix it.
>>
>>
>>> +};
>>> +
>>> +/**
>>> + * Parameters for inter-process or inter-OS DMA transfers.
>>> + *
>>> + * This structure defines the parameters required to perform DMA
>>> +transfers
>>> + * across different domains, such as between processes or operating
>> systems.
>>> + * It includes the domain type and handler identifiers for both the
>>> +source
>>> + * and destination domains.
>>
>> I think we could add more comment about how to config use the src/dst
>> handler.
>> as I comment in before mail:
> 
> Sure, will add more comments. I believe a handler value of zero is still valid
> for both source and destination. It typically represents the local process when
> the transfer direction is mem-to-mem and the inter-domain type if NONE.

If the inter-domain type is None, the src/dst handler should be ignore.

As I said in comment of "control-api commit", if the group has multiple (>2) process,
and the device could perform three type mem-to-mem copy:
1\ local to remote
2\ remote to local
3\ remote-A to remote-B or event remote-A to remote-A

the remote handler could get by rte_dma_access_pair_group_handle_get()
does the local handler also get by rte_dma_access_pair_group_handle_get() ?


> Handler values --whether zero or non-zero -- can be used to represent transfers
>  From local process to another OS domain, or vice versa. 
> 
> Do you have any thoughts on this.?, Specifically, do you foresee any issues with
> using handler value of zero.
> 
> Thanks
>>
>> It's mean local process if the src/dst_handler is zero?
>> for example, I setup a inter-os domain param, if the src_handle is none zero
>> and dst_handle is zero, then all DMA copy will from another OS to local
>> process.
>>     all DMA fill will write to local process.
>>
>> If the src_handle is zero and dst_handle is non-zero, then all DMA copy will
>>from local process to another OS domain
>>     all DMA fill will write to another OS domain.
>>
>> If both src_handle and dst_handle is non-zero, then all DMA copy will from
>> another OS to another OS domain
>>     all DMA fill will write to another OS domain.
>>
>>> + */
>>> +struct rte_dma_inter_domain_param {
>>> +	enum rte_dma_inter_domain_type type; /**< Type of inter-domain.
>> */
>>> +	uint16_t src_handler; /**< Source domain handler identifier. */
>>> +	uint16_t dst_handler; /**< Destination domain handler identifier. */
>>> +	uint64_t reserved[2]; /**< Reserved for future fields. */
>>
>> Please move above comment before define to keep the whole header-file
>> consistency.
>>
>>> +};
>>> +
>>>  /**
>>>   * A structure used to configure a virtual DMA channel.
>>>   *
>>> @@ -601,6 +651,15 @@ struct rte_dma_vchan_conf {
>>>  	 * @see struct rte_dma_auto_free_param
>>>  	 */
>>>  	struct rte_dma_auto_free_param auto_free;
>>> +	/** Parameters for inter-process or inter-OS domain DMA transfers.
>> This field
>>> +	 * specifies the source and destination domain handlers required for
>> DMA
>>> +	 * operations that span across different processes or operating system
>> domains.
>>> +	 *
>>> +	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
>>> +	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
>>> +	 * @see struct rte_dma_inter_domain_param
>>> +	 */
>>> +	struct rte_dma_inter_domain_param domain;

BTW: I remember the originl rfc only support inter-os domain, because Intel has
inter-process rfc, so we add it. now Intel has not follow this feature, I think
we could drop inter-process support (such as RTE_DMA_CAPA_INTER_PROCESS_XXX )
but keep the extend ability.

>>>  };
>>>
>>>  /**
>>> diff --git a/lib/dmadev/rte_dmadev_trace.h
>>> b/lib/dmadev/rte_dmadev_trace.h index 1de92655f2..fa619c4090 100644
>>> --- a/lib/dmadev/rte_dmadev_trace.h
>>> +++ b/lib/dmadev/rte_dmadev_trace.h
>>> @@ -79,6 +79,9 @@ RTE_TRACE_POINT(
>>>  	rte_trace_point_emit_int(conf->dst_port.port_type);
>>>  	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
>>>  	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
>>> +	rte_trace_point_emit_int(conf->domain.type);
>>> +	rte_trace_point_emit_u16(conf->domain.src_handler);
>>> +	rte_trace_point_emit_u16(conf->domain.dst_handler);
>>>  	rte_trace_point_emit_int(ret);
>>>  )
>>>
>>
>> BTW: please add the UT (test_dmadev_api.c) for above vchan_setup modify,
>> this could be another commit I think.
>>
> Yes, will add it.
> 

