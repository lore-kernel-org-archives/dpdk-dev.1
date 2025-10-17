Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E1CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C67740BA2;
	Fri, 17 Oct 2025 15:11:07 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 2BFEC40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:11:04 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6+dgvVTL3rnpWSxmYIJ158NTcZUWna/WzbkL+9I7gGo=;
 b=hBJsmts9r367k2MyRqf3WdDvuBTrJKASVif/2QdG1rVjTXxDSPTpiP/WIrPYgG0i4tkSSVW5k
 u17OnsuFEbyrlWsVku+NpA+Du+Wt/lipAZpVCGxaQj/DXq6aMOyES24mmcEQgp8CKV4E4S+ZZP+
 cA1lsegHBCgELvQlDpdd8rE=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cp4v52VwLzmV66;
 Fri, 17 Oct 2025 21:10:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D650D1402E1;
 Fri, 17 Oct 2025 21:11:02 +0800 (CST)
Received: from [10.82.68.243] (10.82.68.243) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 21:11:01 +0800
Content-Type: multipart/alternative;
 boundary="------------YKiJNWjyoN8SL48ePz4zfrDB"
Message-ID: <a87c4189-6fcf-3b14-9b86-0b9a9f1eb380@huawei.com>
Date: Fri, 17 Oct 2025 21:10:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 1/1] lib/dma: add control-plane APIs for inter-domain
 DMA transfers
Content-Language: en-US
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>, <jerinj@marvell.com>
References: <20251013181049.2396041-1-vattunuru@marvell.com>
 <20251017122610.3126992-1-vattunuru@marvell.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251017122610.3126992-1-vattunuru@marvell.com>
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

--------------YKiJNWjyoN8SL48ePz4zfrDB
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

A minor comment below, but it seems could fix later.

Acked-by: Chengwen Feng <fengchengwen@huawei.com>


On 2025/10/17 20:26, Vamsi Krishna wrote:
> From: Vamsi Attunuru<vattunuru@marvell.com>
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
> Use rte_dma_access_pair_group_handler_get() to obtain handler information
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
> Signed-off-by: Vamsi Attunuru<vattunuru@marvell.com>
> ---
> V3 Changes:
> * Add documentation to dmadev doc.
> * Add common callback for group creator and joiner.
> * Fix V2 review comments
>
>   doc/guides/prog_guide/dmadev.rst |  49 +++++++++++
>   lib/dmadev/rte_dmadev.c          | 138 +++++++++++++++++++++++++++++++
>   lib/dmadev/rte_dmadev.h          | 137 ++++++++++++++++++++++++++++++
>   lib/dmadev/rte_dmadev_pmd.h      |  29 +++++++
>   lib/dmadev/rte_dmadev_trace.h    |  42 ++++++++++
>   5 files changed, 395 insertions(+)
>
> diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
> index 9b497ce7bd..c2a1e34c35 100644
> --- a/doc/guides/prog_guide/dmadev.rst
> +++ b/doc/guides/prog_guide/dmadev.rst
> @@ -174,3 +174,52 @@ are shown below.
>   
>   For more information on how to use the Telemetry interface, see
>   the :doc:`../howto/telemetry`.
> +
> +Inter-domain DMA Capabilities
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The inter-domain DMA feature enables DMA devices to perform data transfers
> +across different processes and OS domains. This is achieved by configuring
> +virtual channels (vchans) using `src_handler` and `dst_handler` fields, which
> +represent the source and destination endpoints for inter-domain DMA operations.
> +Handler information is exchanged between devices based on their DMA class type.
> +These handler details will be exchanged based on the type of DMA devices.
> +
> +DMA devices used for inter-process data transfer can be categorized as follows:

inter-process -> inter-domain

> +
> +Class A: Both endpoints require a DMA device for data transfer (e.g., Marvell DMA devices).
> +Class B: Only one endpoint requires a DMA device; the other does not.
> +Class C: Other device types not currently classified.
> +
> +Currently the necessary APIs for Class A DMA devices are avilable for exchanging the handler
> +details. Devices can create or join access groups using token-based authentication, ensuring
> +that only authorized devices within the same group can perform DMA transfers across processes
> +or OS domains.
> +
> +API usage flow for setting up the access pair group for DMA between process#1 & process#2.
> +
> +Process#1 (Group Creator):
> +--------------------------
> +Calls ``rte_dma_access_pair_group_create`` to establish a new access pair group,
> +then shares the ``group_id``, ``token`` and ``domain_id`` with Process#2 via IPC.
> +
> +Process#2 (Group Joiner):
> +-------------------------
> +Receives the ``group_id`` and ``token`` from Process#1 and calls ``rte_dma_access_pair_group_join``
> +to join the group.
> +
> +Both Processes:
> +---------------
> +Use ``rte_dma_access_pair_group_handler_get`` to obtain ``handler`` information for domains
> +in the group.
> +
> +--Perform inter-domain DMA transfers as required.
> +
> +Process#2 (when finished):
> +--------------------------
> +Calls ``rte_dma_access_pair_group_leave`` to exit the group.
> +
> +Process#1 (final cleanup):
> +--------------------------
> +Calls ``rte_dma_access_pair_group_destroy`` to destroy the group.
> +
> diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
> index 30c3db3a98..cf50d7433c 100644
> --- a/lib/dmadev/rte_dmadev.c
> +++ b/lib/dmadev/rte_dmadev.c
> @@ -816,6 +816,144 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
>   	return dev->dev_ops->vchan_status(dev, vchan, status);
>   }
>   
> +int
> +rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +				 int16_t *group_id, rte_dma_access_pair_group_event_cb_t cb)
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
> +
> +	if (*dev->dev_ops->access_pair_group_create == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_create)(dev, domain_id, token, group_id, cb);
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
> +			       rte_dma_access_pair_group_event_cb_t cb)
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
> +	return (*dev->dev_ops->access_pair_group_join)(dev, group_id, token, cb);
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
> +rte_dma_access_pair_group_handler_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
> +				      uint16_t *handler)
> +{
> +	struct rte_dma_info dev_info;
> +	struct rte_dma_dev *dev;
> +
> +	if (!rte_dma_is_valid(dev_id) || handler == NULL)
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
> +	if (*dev->dev_ops->access_pair_group_handler_get == NULL)
> +		return -ENOTSUP;
> +	return (*dev->dev_ops->access_pair_group_handler_get)(dev, group_id, domain_id, handler);
> +}
> +
>   static const char *
>   dma_capability_name(uint64_t capability)
>   {
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 1708311c5b..77c19b2008 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -148,6 +148,7 @@
>   
>   #include <rte_bitops.h>
>   #include <rte_common.h>
> +#include <rte_uuid.h>
>   
>   #ifdef __cplusplus
>   extern "C" {
> @@ -797,6 +798,142 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
>    */
>   int rte_dma_dump(int16_t dev_id, FILE *f);
>   
> +/**
> + * Event types for DMA access pair group notifications.
> + *
> + * When the event type is RTE_DMA_GROUP_EVENT_MEMBER_LEFT, the handler associated
> + * with the departing member's domain is no longer valid. Inter-domain DMA operations
> + * targeting that domain should be avoided.
> + *
> + * When the event type is RTE_DMA_GROUP_EVENT_GROUP_DESTROYED, all handlers associated
> + * with the group become invalid. No further inter-domain DMA operations should be
> + * initiated using those handlers.
> + */
> +enum rte_dma_access_pair_group_event_type {
> +	/** A member left the group (notifies creator and joiners) */
> +	RTE_DMA_GROUP_EVENT_MEMBER_LEFT,
> +	/** Group was destroyed (notifies joiners) */
> +	RTE_DMA_GROUP_EVENT_GROUP_DESTROYED
> +};
> +
> +/**
> + * This callback is used to notify interested parties (either the group creator
> + * or group joiners) about significant events related to the lifecycle of a DMA
> + * access pair group.
> + *
> + * It can be registered by:
> + * - **Group creators or Group joiners** to be notified when a member leaves the group.
> + * - **Group joiners** to be notified when the group is destroyed.
> + *
> + * @param dev_id
> + *   Identifier of the DMA device.
> + * @param group_id
> + *   Identifier of the access pair group where the event occurred.
> + * @param domain_id
> + *   UUID of the domain_id associated with the event. For member leave events,
> + *   this is the domain_id of the member that left. For group destruction events,
> + *   this may refer to the domain_id of the respective member.
> + * @param event
> + *   Type of event that occurred.
> + *   @see rte_dma_access_pair_group_event_type
> + */
> +typedef void (*rte_dma_access_pair_group_event_cb_t)(int16_t dma_id, int16_t group_id,
> +						     rte_uuid_t domain_id,
> +						     enum
> +						     rte_dma_access_pair_group_event_type event);
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
> + * @param cb
> + *   Callback function to be invoked when a member leaves the group.
> + *
> + * @return
> + *   0 on success,
> + *   negative error code on failure.
> + */
> +int rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
> +				     int16_t *group_id, rte_dma_access_pair_group_event_cb_t cb);
> +
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
> +
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
> + * @param cb
> + *   Callback function to be invoked when the device leaves the group or when the group
> + *   is destroyed due to some exception or failure.
> + *
> + * @return
> + *   0 on success,
> + *   negative value on failure indicating the error code.
> + */
> +int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
> +				   rte_dma_access_pair_group_event_cb_t cb);
> +
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
> +
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
> + * @param[out] handler
> + *   Pointer to store the retrieved handler value.
> + * @return
> + *   0 on success,
> + *   negative value on failure indicating the error code.
> + */
> +int rte_dma_access_pair_group_handler_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
> +					  uint16_t *handler);
> +
>   /**
>    * DMA transfer result status code defines.
>    *
> diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
> index 58729088ff..16fd625c2d 100644
> --- a/lib/dmadev/rte_dmadev_pmd.h
> +++ b/lib/dmadev/rte_dmadev_pmd.h
> @@ -64,6 +64,29 @@ typedef int (*rte_dma_vchan_status_t)(const struct rte_dma_dev *dev, uint16_t vc
>   /** @internal Used to dump internal information. */
>   typedef int (*rte_dma_dump_t)(const struct rte_dma_dev *dev, FILE *f);
>   
> +/** @internal Used to create an access pair group for inter-process or inter-OS DMA transfers. */
> +typedef int (*rte_dma_access_pair_group_create_t)(const struct rte_dma_dev *dev,
> +						  rte_uuid_t domain_id, rte_uuid_t token,
> +						  int16_t *group_id,
> +						  rte_dma_access_pair_group_event_cb_t cb);
> +
> +/** @internal Used to destroy an access pair group when all other devices have exited. */
> +typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev,
> +						   int16_t group_id);
> +
> +/** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
> +typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
> +						rte_uuid_t token,
> +						rte_dma_access_pair_group_event_cb_t cb);
> +
> +/** @internal Used to leave an access pair group, removing the device from the group. */
> +typedef int (*rte_dma_access_pair_group_leave_t)(const struct rte_dma_dev *dev, int16_t group_id);
> +
> +/** @internal Used to retrieve handler information of the domain_id present in the group. */
> +typedef int (*rte_dma_access_pair_group_handler_get_t)(const struct rte_dma_dev *dev,
> +						       int16_t group_id, rte_uuid_t domain_id,
> +						       uint16_t *handler);
> +
>   /**
>    * DMA device operations function pointer table.
>    *
> @@ -83,6 +106,12 @@ struct rte_dma_dev_ops {
>   
>   	rte_dma_vchan_status_t     vchan_status;
>   	rte_dma_dump_t             dev_dump;
> +
> +	rte_dma_access_pair_group_create_t	access_pair_group_create;
> +	rte_dma_access_pair_group_destroy_t	access_pair_group_destroy;
> +	rte_dma_access_pair_group_join_t	access_pair_group_join;
> +	rte_dma_access_pair_group_leave_t	access_pair_group_leave;
> +	rte_dma_access_pair_group_handler_get_t	access_pair_group_handler_get;
>   };
>   
>   /**
> diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
> index f1a178eeb5..da80a8cb50 100644
> --- a/lib/dmadev/rte_dmadev_trace.h
> +++ b/lib/dmadev/rte_dmadev_trace.h
> @@ -101,6 +101,48 @@ RTE_TRACE_POINT(
>   	rte_trace_point_emit_int(ret);
>   )
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
> +	rte_dma_trace_access_pair_group_handler_get,
> +	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
> +			     uint16_t *handler),
> +	rte_trace_point_emit_i16(dev_id);
> +	rte_trace_point_emit_i16(group_id);
> +	rte_trace_point_emit_u8_ptr(&domain_id[0]);
> +	rte_trace_point_emit_ptr(handler);
> +)
> +
>   #ifdef __cplusplus
>   }
>   #endif
--------------YKiJNWjyoN8SL48ePz4zfrDB
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span style="font-family:SimSun">A minor comment below, but it
        seems could fix later. <br>
      </span></p>
    <p><span style="font-family:SimSun">Acked-by: </span><span
        style="font-family:Calibri">Chengwen Feng <a
          class="moz-txt-link-rfc2396E"
          href="mailto:fengchengwen@huawei.com">&lt;fengchengwen@huawei.com&gt;</a></span></p>
    <p></p>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 2025/10/17 20:26, Vamsi Krishna
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251017122610.3126992-1-vattunuru@marvell.com">
      <pre class="moz-quote-pre" wrap="">From: Vamsi Attunuru <a class="moz-txt-link-rfc2396E" href="mailto:vattunuru@marvell.com">&lt;vattunuru@marvell.com&gt;</a>

Secure and controlled inter-domain DMA transfers require dedicated
control-plane APIs to create and manage access groups.

DMA devices used for inter-process data transfer can be categorized as
follows:

Class A: Both endpoints require a DMA device for data transfer (e.g.,
Marvell DMA devices).
Class B: Only one endpoint requires a DMA device; the other does not.
Class C: Other device types not currently classified.

Providing a unified API for all these categories is complex, as Linux
and other operating systems do not offer native control-plane APIs for
this purpose. Therefore, DPDK can implement its own control-plane
mechanisms to support Class A, B, and C devices.

This commit introduces the necessary APIs for Class A DMA devices.
Devices can create or join access groups using token-based
authentication, ensuring that only authorized devices within the same
group can perform DMA transfers across processes or OS domains.

API Usage Flow:

Process 1 (Group Creator):
Invokes rte_dma_access_pair_group_create() to establish a new access
pair group, then shares the group_id and token with Process 2 via IPC.

Process 2 (Group Joiner):
Receives the group_id and token from Process 1 and calls
rte_dma_access_pair_group_join() to join the group.

Both Processes:
Use rte_dma_access_pair_group_handler_get() to obtain handler information
for domains in the group.
Perform DMA transfers as required.

Process 2 (when finished):
Calls rte_dma_access_pair_group_leave() to exit the group.

Process 1:
Monitors for group updates and confirms group membership as needed.

Depends-on: patch-36335 (lib/dma: introduce inter-process and inter-OS DMA)

Signed-off-by: Vamsi Attunuru <a class="moz-txt-link-rfc2396E" href="mailto:vattunuru@marvell.com">&lt;vattunuru@marvell.com&gt;</a>
---
V3 Changes:
* Add documentation to dmadev doc.
* Add common callback for group creator and joiner.
* Fix V2 review comments

 doc/guides/prog_guide/dmadev.rst |  49 +++++++++++
 lib/dmadev/rte_dmadev.c          | 138 +++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev.h          | 137 ++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev_pmd.h      |  29 +++++++
 lib/dmadev/rte_dmadev_trace.h    |  42 ++++++++++
 5 files changed, 395 insertions(+)

diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 9b497ce7bd..c2a1e34c35 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -174,3 +174,52 @@ are shown below.
 
 For more information on how to use the Telemetry interface, see
 the :doc:`../howto/telemetry`.
+
+Inter-domain DMA Capabilities
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The inter-domain DMA feature enables DMA devices to perform data transfers
+across different processes and OS domains. This is achieved by configuring
+virtual channels (vchans) using `src_handler` and `dst_handler` fields, which
+represent the source and destination endpoints for inter-domain DMA operations.
+Handler information is exchanged between devices based on their DMA class type.
+These handler details will be exchanged based on the type of DMA devices.
+
+DMA devices used for inter-process data transfer can be categorized as follows:</pre>
    </blockquote>
    <p>inter-process -&gt; inter-domain<br>
    </p>
    <blockquote type="cite"
      cite="mid:20251017122610.3126992-1-vattunuru@marvell.com">
      <pre class="moz-quote-pre" wrap="">
+
+Class A: Both endpoints require a DMA device for data transfer (e.g., Marvell DMA devices).
+Class B: Only one endpoint requires a DMA device; the other does not.
+Class C: Other device types not currently classified.
+
+Currently the necessary APIs for Class A DMA devices are avilable for exchanging the handler
+details. Devices can create or join access groups using token-based authentication, ensuring
+that only authorized devices within the same group can perform DMA transfers across processes
+or OS domains.
+
+API usage flow for setting up the access pair group for DMA between process#1 &amp; process#2.
+
+Process#1 (Group Creator):
+--------------------------
+Calls ``rte_dma_access_pair_group_create`` to establish a new access pair group,
+then shares the ``group_id``, ``token`` and ``domain_id`` with Process#2 via IPC.</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:20251017122610.3126992-1-vattunuru@marvell.com">
      <pre class="moz-quote-pre" wrap="">
+
+Process#2 (Group Joiner):
+-------------------------
+Receives the ``group_id`` and ``token`` from Process#1 and calls ``rte_dma_access_pair_group_join``
+to join the group.
+
+Both Processes:
+---------------
+Use ``rte_dma_access_pair_group_handler_get`` to obtain ``handler`` information for domains
+in the group.
+
+--Perform inter-domain DMA transfers as required.
+
+Process#2 (when finished):
+--------------------------
+Calls ``rte_dma_access_pair_group_leave`` to exit the group.
+
+Process#1 (final cleanup):
+--------------------------
+Calls ``rte_dma_access_pair_group_destroy`` to destroy the group.
+
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 30c3db3a98..cf50d7433c 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -816,6 +816,144 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
 	return dev-&gt;dev_ops-&gt;vchan_status(dev, vchan, status);
 }
 
+int
+rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+				 int16_t *group_id, rte_dma_access_pair_group_event_cb_t cb)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id) || group_id == NULL)
+		return -EINVAL;
+	dev = &amp;rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &amp;dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev-&gt;dev_ops-&gt;access_pair_group_create == NULL)
+		return -ENOTSUP;
+	return (*dev-&gt;dev_ops-&gt;access_pair_group_create)(dev, domain_id, token, group_id, cb);
+}
+
+int
+rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id))
+		return -EINVAL;
+	dev = &amp;rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &amp;dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev-&gt;dev_ops-&gt;access_pair_group_destroy == NULL)
+		return -ENOTSUP;
+	return (*dev-&gt;dev_ops-&gt;access_pair_group_destroy)(dev, group_id);
+}
+
+int
+rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
+			       rte_dma_access_pair_group_event_cb_t cb)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id))
+		return -EINVAL;
+	dev = &amp;rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &amp;dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev-&gt;dev_ops-&gt;access_pair_group_join == NULL)
+		return -ENOTSUP;
+	return (*dev-&gt;dev_ops-&gt;access_pair_group_join)(dev, group_id, token, cb);
+}
+
+int
+rte_dma_access_pair_group_leave(int16_t dev_id, int16_t group_id)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id))
+		return -EINVAL;
+	dev = &amp;rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &amp;dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev-&gt;dev_ops-&gt;access_pair_group_leave == NULL)
+		return -ENOTSUP;
+	return (*dev-&gt;dev_ops-&gt;access_pair_group_leave)(dev, group_id);
+}
+
+int
+rte_dma_access_pair_group_handler_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
+				      uint16_t *handler)
+{
+	struct rte_dma_info dev_info;
+	struct rte_dma_dev *dev;
+
+	if (!rte_dma_is_valid(dev_id) || handler == NULL)
+		return -EINVAL;
+	dev = &amp;rte_dma_devices[dev_id];
+
+	if (rte_dma_info_get(dev_id, &amp;dev_info)) {
+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
+		return -EINVAL;
+	}
+
+	if (!((dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
+	    (dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process or inter-os domain",
+			    dev_id);
+		return -EINVAL;
+	}
+
+	if (*dev-&gt;dev_ops-&gt;access_pair_group_handler_get == NULL)
+		return -ENOTSUP;
+	return (*dev-&gt;dev_ops-&gt;access_pair_group_handler_get)(dev, group_id, domain_id, handler);
+}
+
 static const char *
 dma_capability_name(uint64_t capability)
 {
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 1708311c5b..77c19b2008 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -148,6 +148,7 @@
 
 #include &lt;rte_bitops.h&gt;
 #include &lt;rte_common.h&gt;
+#include &lt;rte_uuid.h&gt;
 
 #ifdef __cplusplus
 extern "C" {
@@ -797,6 +798,142 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
  */
 int rte_dma_dump(int16_t dev_id, FILE *f);
 
+/**
+ * Event types for DMA access pair group notifications.
+ *
+ * When the event type is RTE_DMA_GROUP_EVENT_MEMBER_LEFT, the handler associated
+ * with the departing member's domain is no longer valid. Inter-domain DMA operations
+ * targeting that domain should be avoided.
+ *
+ * When the event type is RTE_DMA_GROUP_EVENT_GROUP_DESTROYED, all handlers associated
+ * with the group become invalid. No further inter-domain DMA operations should be
+ * initiated using those handlers.
+ */
+enum rte_dma_access_pair_group_event_type {
+	/** A member left the group (notifies creator and joiners) */
+	RTE_DMA_GROUP_EVENT_MEMBER_LEFT,
+	/** Group was destroyed (notifies joiners) */
+	RTE_DMA_GROUP_EVENT_GROUP_DESTROYED
+};
+
+/**
+ * This callback is used to notify interested parties (either the group creator
+ * or group joiners) about significant events related to the lifecycle of a DMA
+ * access pair group.
+ *
+ * It can be registered by:
+ * - **Group creators or Group joiners** to be notified when a member leaves the group.
+ * - **Group joiners** to be notified when the group is destroyed.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device.
+ * @param group_id
+ *   Identifier of the access pair group where the event occurred.
+ * @param domain_id
+ *   UUID of the domain_id associated with the event. For member leave events,
+ *   this is the domain_id of the member that left. For group destruction events,
+ *   this may refer to the domain_id of the respective member.
+ * @param event
+ *   Type of event that occurred.
+ *   @see rte_dma_access_pair_group_event_type
+ */
+typedef void (*rte_dma_access_pair_group_event_cb_t)(int16_t dma_id, int16_t group_id,
+						     rte_uuid_t domain_id,
+						     enum
+						     rte_dma_access_pair_group_event_type event);
+
+/**
+ * Create an access pair group to enable secure DMA transfers between devices across different
+ * processes or operating system domains.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device initiating the group.
+ * @param domain_id
+ *   Unique identifier representing the process or OS domain.
+ * @param token
+ *   Authentication token used to establish the access group.
+ * @param[out] group_id
+ *   Pointer to store the ID of the newly created access group.
+ * @param cb
+ *   Callback function to be invoked when a member leaves the group.
+ *
+ * @return
+ *   0 on success,
+ *   negative error code on failure.
+ */
+int rte_dma_access_pair_group_create(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+				     int16_t *group_id, rte_dma_access_pair_group_event_cb_t cb);
+
+/**
+ * Destroy an access pair group if all participating devices have exited. This operation is only
+ * permitted by the device that originally created the group; attempts by other devices will result
+ * in failure.
+ *
+ * @param dev_id
+ *   Identifier of the device requesting group destruction.
+ * @param group_id
+ *   ID of the access group to be destroyed.
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
+
+/**
+ * Join an existing access group to enable secure DMA transfers between devices across different
+ * processes or OS domains.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device attempting to join the group.
+ * @param group_id
+ *   ID of the access group to join.
+ * @param token
+ *   Authentication token used to validate group membership.
+ * @param cb
+ *   Callback function to be invoked when the device leaves the group or when the group
+ *   is destroyed due to some exception or failure.
+ *
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
+				   rte_dma_access_pair_group_event_cb_t cb);
+
+/**
+ * Leave an access group, removing the device's entry from the group table and disabling
+ * inter-domain DMA transfers to and from this device. This operation is not permitted for the
+ * device that originally created the group.
+ *
+ * @param dev_id
+ *   Identifier of the device requesting to leave the group.
+ * @param group_id
+ *   ID of the access group to leave.
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_leave(int16_t dev_id, int16_t group_id);
+
+/**
+ * Retrieve the handler associated with a specific domain ID, which is used by the application to
+ * query source or destinationin handler to initiate inter-process or inter-OS DMA transfers.
+ *
+ * @param dev_id
+ *   Identifier of the DMA device requesting the handler.
+ * @param group_id
+ *   ID of the access group to query.
+ * @param group_tbl
+ *   Unique identifier of the target process or OS domain.
+ * @param[out] handler
+ *   Pointer to store the retrieved handler value.
+ * @return
+ *   0 on success,
+ *   negative value on failure indicating the error code.
+ */
+int rte_dma_access_pair_group_handler_get(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
+					  uint16_t *handler);
+
 /**
  * DMA transfer result status code defines.
  *
diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
index 58729088ff..16fd625c2d 100644
--- a/lib/dmadev/rte_dmadev_pmd.h
+++ b/lib/dmadev/rte_dmadev_pmd.h
@@ -64,6 +64,29 @@ typedef int (*rte_dma_vchan_status_t)(const struct rte_dma_dev *dev, uint16_t vc
 /** @internal Used to dump internal information. */
 typedef int (*rte_dma_dump_t)(const struct rte_dma_dev *dev, FILE *f);
 
+/** @internal Used to create an access pair group for inter-process or inter-OS DMA transfers. */
+typedef int (*rte_dma_access_pair_group_create_t)(const struct rte_dma_dev *dev,
+						  rte_uuid_t domain_id, rte_uuid_t token,
+						  int16_t *group_id,
+						  rte_dma_access_pair_group_event_cb_t cb);
+
+/** @internal Used to destroy an access pair group when all other devices have exited. */
+typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev,
+						   int16_t group_id);
+
+/** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
+typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
+						rte_uuid_t token,
+						rte_dma_access_pair_group_event_cb_t cb);
+
+/** @internal Used to leave an access pair group, removing the device from the group. */
+typedef int (*rte_dma_access_pair_group_leave_t)(const struct rte_dma_dev *dev, int16_t group_id);
+
+/** @internal Used to retrieve handler information of the domain_id present in the group. */
+typedef int (*rte_dma_access_pair_group_handler_get_t)(const struct rte_dma_dev *dev,
+						       int16_t group_id, rte_uuid_t domain_id,
+						       uint16_t *handler);
+
 /**
  * DMA device operations function pointer table.
  *
@@ -83,6 +106,12 @@ struct rte_dma_dev_ops {
 
 	rte_dma_vchan_status_t     vchan_status;
 	rte_dma_dump_t             dev_dump;
+
+	rte_dma_access_pair_group_create_t	access_pair_group_create;
+	rte_dma_access_pair_group_destroy_t	access_pair_group_destroy;
+	rte_dma_access_pair_group_join_t	access_pair_group_join;
+	rte_dma_access_pair_group_leave_t	access_pair_group_leave;
+	rte_dma_access_pair_group_handler_get_t	access_pair_group_handler_get;
 };
 
 /**
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index f1a178eeb5..da80a8cb50 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -101,6 +101,48 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_create,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+			     int16_t *group_id),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_u8_ptr(&amp;domain_id[0]);
+	rte_trace_point_emit_u8_ptr(&amp;token[0]);
+	rte_trace_point_emit_ptr(group_id);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_destroy,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_join,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t token),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+	rte_trace_point_emit_u8_ptr(&amp;token[0]);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_leave,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+)
+
+RTE_TRACE_POINT(
+	rte_dma_trace_access_pair_group_handler_get,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t domain_id,
+			     uint16_t *handler),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_i16(group_id);
+	rte_trace_point_emit_u8_ptr(&amp;domain_id[0]);
+	rte_trace_point_emit_ptr(handler);
+)
+
 #ifdef __cplusplus
 }
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------YKiJNWjyoN8SL48ePz4zfrDB--
