Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEAACCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 06:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ECE4402DA;
	Wed, 15 Oct 2025 08:59:13 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id AC1DF402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 08:59:11 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=J3HBSUJJiUbC6ZU0ReG6jnmhgpchlCQDzFbbeYJNk0M=;
 b=XZCMBlt8FbAjX4VcdQkCOIULVKbEwXd5JFHNRnjKPuCMEalNJgLdCOlQ7zjh9s2DcE3Dr/Iif
 aI6qFEzB5kqNJx11RO9eitf8ZUMv+VjYXvuJbQGUpb2aMw/rao69ljs/FMsKNT5WvMS8SRK88lW
 B8jU0EN+IZpqjKBSiyO19Ec=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cmhkR65PXz1T4JT;
 Wed, 15 Oct 2025 14:58:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3983614027A;
 Wed, 15 Oct 2025 14:59:08 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 14:59:07 +0800
Message-ID: <c8041ddd-0ad9-4fa9-93f9-9cd26cb9ce4c@huawei.com>
Date: Wed, 15 Oct 2025 14:59:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] lib/dma: add control-plane APIs for inter-domain
 DMA transfers
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>, <jerinj@marvell.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <20251013181049.2396041-1-vattunuru@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251013181049.2396041-1-vattunuru@marvell.com>
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

On 10/14/2025 2:10 AM, Vamsi Krishna wrote:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Secure and controlled inter-domain DMA transfers require dedicated
> control-plane APIs to create and manage access groups.
> 
> DMA devices used for inter-process data transfer can be categorized as
> follows:
> 
> Class A: Both endpoints require a DMA device for data transfer (e.g.,
> Marvell DMA devices).
> Class B: Only one endpoint requires a DMA device; the other does not.
> Class C: Other device types not currently classified.
> 
> Providing a unified API for all these categories is complex, as Linux
> and other operating systems do not offer native control-plane APIs for
> this purpose. Therefore, DPDK can implement its own control-plane
> mechanisms to support Class A, B, and C devices.
> 
> This commit introduces the necessary APIs for Class A DMA devices.
> Devices can create or join access groups using token-based
> authentication, ensuring that only authorized devices within the same
> group can perform DMA transfers across processes or OS domains.
> 
> API Usage Flow:
> 
> Process 1 (Group Creator):
> Invokes rte_dma_access_pair_group_create() to establish a new access
> pair group, then shares the group_id and token with Process 2 via IPC.
> 
> Process 2 (Group Joiner):
> Receives the group_id and token from Process 1 and calls
> rte_dma_access_pair_group_join() to join the group.
> 
> Both Processes:
> Use rte_dma_access_pair_group_handle_get() to obtain handler information
> for domains in the group.
> Perform DMA transfers as required.
> 
> Process 2 (when finished):
> Calls rte_dma_access_pair_group_leave() to exit the group.
> 
> Process 1:
> Monitors for group updates and confirms group membership as needed.
> 
> Depends-on: patch-36335 (lib/dma: introduce inter-process and inter-OS DMA)
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  lib/dmadev/rte_dmadev.c       | 137 ++++++++++++++++++++++++++++++++++
>  lib/dmadev/rte_dmadev.h       | 100 +++++++++++++++++++++++++
>  lib/dmadev/rte_dmadev_pmd.h   |  28 +++++++
>  lib/dmadev/rte_dmadev_trace.h |  42 +++++++++++
>  4 files changed, 307 insertions(+)
> 
> diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
> index d6792449bf..521b372b86 100644
> --- a/lib/dmadev/rte_dmadev.c
> +++ b/lib/dmadev/rte_dmadev.c
> @@ -804,6 +804,143 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
>  	return dev->dev_ops->vchan_status(dev, vchan, status);
>  }
>  
> +int
> +rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +				 int16_t *group_id)
> +{
> +	struct rte_dma_info dev_info;
> +	struct rte_dma_dev *dev;
> +
> +	if (!rte_dma_is_valid(dev_id) || group_id == NULL)
> +		return -EINVAL;
> +	dev = &rte_dma_devices[dev_id];
> +
> +	if (rte_dma_info_get(dev_id, &dev_info)) {
> +		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
> +	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
> +		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
> +			    dev_id);
> +		return -EINVAL;
> +	}

please add one blank line here

> +	if (*dev->dev_ops->access_pair_group_create == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_create)(dev, domain_id, token, group_id);
> +}
> +
> +int
> +rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id)
> +{
> +	struct rte_dma_info dev_info;
> +	struct rte_dma_dev *dev;
> +
> +	if (!rte_dma_is_valid(dev_id))
> +		return -EINVAL;
> +	dev = &rte_dma_devices[dev_id];
> +
> +	if (rte_dma_info_get(dev_id, &dev_info)) {
> +		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
> +	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
> +		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
> +			    dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (*dev->dev_ops->access_pair_group_destroy == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_destroy)(dev, group_id);
> +}
> +
> +int
> +rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
> +			       rte_dma_access_pair_leave_cb_t leave_cb)
> +{
> +	struct rte_dma_info dev_info;
> +	struct rte_dma_dev *dev;
> +
> +	if (!rte_dma_is_valid(dev_id))
> +		return -EINVAL;
> +	dev = &rte_dma_devices[dev_id];
> +
> +	if (rte_dma_info_get(dev_id, &dev_info)) {
> +		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
> +	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
> +		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
> +			    dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (*dev->dev_ops->access_pair_group_join == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_join)(dev, group_id, token, leave_cb);
> +}
> +
> +int
> +rte_dma_access_pair_group_leave(int16_t dev_id, int16_t group_id)
> +{
> +	struct rte_dma_info dev_info;
> +	struct rte_dma_dev *dev;
> +
> +	if (!rte_dma_is_valid(dev_id))
> +		return -EINVAL;
> +	dev = &rte_dma_devices[dev_id];
> +
> +	if (rte_dma_info_get(dev_id, &dev_info)) {
> +		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
> +	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
> +		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
> +			    dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (*dev->dev_ops->access_pair_group_leave == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_leave)(dev, group_id);
> +}
> +
> +int
> +rte_dma_access_pair_group_handle_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
> +				     uint16_t *handle)
> +{
> +	struct rte_dma_info dev_info;
> +	struct rte_dma_dev *dev;
> +
> +	if (!rte_dma_is_valid(dev_id) || handle == NULL)
> +		return -EINVAL;
> +	dev = &rte_dma_devices[dev_id];
> +
> +	if (rte_dma_info_get(dev_id, &dev_info)) {
> +		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (!((dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
> +	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
> +		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
> +			    dev_id);
> +		return -EINVAL;
> +	}
> +
> +	if (*dev->dev_ops->access_pair_group_handle_get == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_handle_get)(dev, group_id, domain_id, handle);
> +}
> +
>  static const char *
>  dma_capability_name(uint64_t capability)
>  {
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 4f735bb0c9..a6e73337eb 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -148,6 +148,7 @@
>  
>  #include <rte_bitops.h>
>  #include <rte_common.h>
> +#include <rte_uuid.h>
>  
>  #ifdef __cplusplus
>  extern "C" {
> @@ -779,6 +780,105 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
>   */
>  int rte_dma_dump(int16_t dev_id, FILE *f);
>  
> +/**
> + * Callback function invoked when a DMA device leaves an access group or when the group is
> + * destroyed due to some exception or failure.
> + *
> + * @param dma_id
> + *   Identifier of the DMA device that is leaving the group.
> + * @param group_id
> + *   ID of the access group being exited.
> + * @param user_data
> + *   User-defined data passed to the callback for context.

What's the user_data define? vendor specific?

> + */
> +typedef void (*rte_dma_access_pair_leave_cb_t)(int16_t dma_id, int16_t group_id, void *user_data);
> +
> +/**
> + * Create an access pair group to enable secure DMA transfers between devices across different
> + * processes or operating system domains.
> + *
> + * @param dev_id
> + *   Identifier of the DMA device initiating the group.
> + * @param domain_id
> + *   Unique identifier representing the process or OS domain.
> + * @param token
> + *   Authentication token used to establish the access group.
> + * @param[out] group_id
> + *   Pointer to store the ID of the newly created access group.
> + *
> + * @return
> + *   0 on success,
> + *   negative error code on failure.
> + */
> +int rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +				     int16_t *group_id);

add blank line here

> +/**
> + * Destroy an access pair group if all participating devices have exited. This operation is only
> + * permitted by the device that originally created the group; attempts by other devices will result
> + * in failure.
> + *
> + * @param dev_id
> + *   Identifier of the device requesting group destruction.
> + * @param group_id
> + *   ID of the access group to be destroyed.
> + * @return
> + *   0 on success,
> + *   negative value on failure indicating the error code.
> + */
> +int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);

add blank line here

> +/**
> + * Join an existing access group to enable secure DMA transfers between devices across different
> + * processes or OS domains.
> + *
> + * @param dev_id
> + *   Identifier of the DMA device attempting to join the group.
> + * @param group_id
> + *   ID of the access group to join.
> + * @param token
> + *   Authentication token used to validate group membership.
> + * @param leave_cb
> + *   Callback function to be invoked when the device leaves the group or when the group
> + *   is destroyed due to some exception or failure.
> + *
> + * @return
> + *   0 on success,
> + *   negative value on failure indicating the error code.
> + */
> +int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
> +				   rte_dma_access_pair_leave_cb_t leave_cb);

add blank line here

> +/**
> + * Leave an access group, removing the device's entry from the group table and disabling
> + * inter-domain DMA transfers to and from this device. This operation is not permitted for the
> + * device that originally created the group.
> + *
> + * @param dev_id
> + *   Identifier of the device requesting to leave the group.
> + * @param group_id
> + *   ID of the access group to leave.
> + * @return
> + *   0 on success,
> + *   negative value on failure indicating the error code.
> + */
> +int rte_dma_access_pair_group_leave(int16_t dev_id, int16_t group_id);

add blank line here

> +/**
> + * Retrieve the handler associated with a specific domain ID, which is used by the application to
> + * query source or destinationin handler to initiate inter-process or inter-OS DMA transfers.
> + *
> + * @param dev_id
> + *   Identifier of the DMA device requesting the handler.
> + * @param group_id
> + *   ID of the access group to query.
> + * @param group_tbl
> + *   Unique identifier of the target process or OS domain.
> + * @param[out] handle
> + *   Pointer to store the retrieved handler value.
> + * @return
> + *   0 on success,
> + *   negative value on failure indicating the error code.
> + */
> +int rte_dma_access_pair_group_handle_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
> +					 uint16_t *handle);

handle should be handler which keep consistency with depend commit.
if there are three OS join the same domain, then how this API get specific handler?

What I think is:
1. every domain has its own unique domain_id
2. Process 1 create one group, and share group_id and token with Process 2/3 via IPC.
3. Process 2 join the group (pass its domain_id)
4. Process 3 also join the group (pass its domain_id)
5. When Process 1 want to transfer between diffent domain:
   it first invoke rte_dma_access_pair_group_handle_get() to get target handler
   do vchan setup. there have three type: local to remote, remote to local, remote to remote. but how to describe the type I have see in depend commit.
   do transfer.
6. If one process leave the group, then other process will be invoke by a callback.
   this has a problem, the Process 1 hasn't register a callback for such event.

> +
>  /**
>   * DMA transfer result status code defines.
>   *
> diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
> index 58729088ff..8be4485593 100644
> --- a/lib/dmadev/rte_dmadev_pmd.h
> +++ b/lib/dmadev/rte_dmadev_pmd.h
> @@ -64,6 +64,28 @@ typedef int (*rte_dma_vchan_status_t)(const struct rte_dma_dev *dev, uint16_t vc
>  /** @internal Used to dump internal information. */
>  typedef int (*rte_dma_dump_t)(const struct rte_dma_dev *dev, FILE *f);
>  
> +/** @internal Used to create an access pair group for inter-process or inter-OS DMA transfers. */
> +typedef int (*rte_dma_access_pair_group_create_t)(const struct rte_dma_dev *dev,
> +						  rte_uuid_t domain_id, rte_uuid_t token,
> +						  int16_t *group_id);
> +
> +/** @internal Used to destroy an access pair group when all other devices have exited. */
> +typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev,
> +						   int16_t group_id);
> +
> +/** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
> +typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
> +						rte_uuid_t token,
> +						rte_dma_access_pair_leave_cb_t leave_cb);
> +
> +/** @internal Used to leave an access pair group, removing the device from the group. */
> +typedef int (*rte_dma_access_pair_group_leave_t)(const struct rte_dma_dev *dev, int16_t group_id);
> +
> +/** @internal Used to retrieve handler information of the domain_id present in the group. */
> +typedef int (*rte_dma_access_pair_group_handle_get_t)(const struct rte_dma_dev *dev,
> +						      int16_t group_id, rte_uuid_t domain_id,
> +						      uint16_t *handle);
> +
>  /**
>   * DMA device operations function pointer table.
>   *
> @@ -83,6 +105,12 @@ struct rte_dma_dev_ops {
>  
>  	rte_dma_vchan_status_t     vchan_status;
>  	rte_dma_dump_t             dev_dump;
> +
> +	rte_dma_access_pair_group_create_t	access_pair_group_create;
> +	rte_dma_access_pair_group_destroy_t	access_pair_group_destroy;
> +	rte_dma_access_pair_group_join_t	access_pair_group_join;
> +	rte_dma_access_pair_group_leave_t	access_pair_group_leave;
> +	rte_dma_access_pair_group_handle_get_t	access_pair_group_handle_get;
>  };
>  
>  /**
> diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
> index fa619c4090..c25cf8d60a 100644
> --- a/lib/dmadev/rte_dmadev_trace.h
> +++ b/lib/dmadev/rte_dmadev_trace.h
> @@ -101,6 +101,48 @@ RTE_TRACE_POINT(
>  	rte_trace_point_emit_int(ret);
>  )
>  
> +RTE_TRACE_POINT(
> +	rte_dma_trace_access_pair_group_create,
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +			     int16_t *group_id),
> +	rte_trace_point_emit_i16(dev_id);
> +	rte_trace_point_emit_u8_ptr(&domain_id[0]);
> +	rte_trace_point_emit_u8_ptr(&token[0]);
> +	rte_trace_point_emit_ptr(group_id);
> +)
> +
> +RTE_TRACE_POINT(
> +	rte_dma_trace_access_pair_group_destroy,
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id),
> +	rte_trace_point_emit_i16(dev_id);
> +	rte_trace_point_emit_i16(group_id);
> +)
> +
> +RTE_TRACE_POINT(
> +	rte_dma_trace_access_pair_group_join,
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t token),
> +	rte_trace_point_emit_i16(dev_id);
> +	rte_trace_point_emit_i16(group_id);
> +	rte_trace_point_emit_u8_ptr(&token[0]);
> +)
> +
> +RTE_TRACE_POINT(
> +	rte_dma_trace_access_pair_group_leave,
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id),
> +	rte_trace_point_emit_i16(dev_id);
> +	rte_trace_point_emit_i16(group_id);
> +)
> +
> +RTE_TRACE_POINT(
> +	rte_dma_trace_access_pair_group_handle_get,
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
> +			     uint16_t *handle),
> +	rte_trace_point_emit_i16(dev_id);
> +	rte_trace_point_emit_i16(group_id);
> +	rte_trace_point_emit_u8_ptr(&domain_id[0]);
> +	rte_trace_point_emit_ptr(handle);
> +)
> +
>  #ifdef __cplusplus
>  }
>  #endif

please add descript in DMAdev's doc.


