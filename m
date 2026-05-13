Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F51CD343F
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 02:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D81402D0;
	Wed, 13 May 2026 04:30:06 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id C703F402B6
 for <dev@dpdk.org>; Wed, 13 May 2026 04:30:04 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vWaWCCfNapNFzSiagebr/pejrZnomWZxzniFhVxG7Ho=;
 b=GFwndsYiSt49fs6nQ7iJGfQuluoyZR9847Cvcc1FK9RvTzwwP94H3wZpqYf88L9GpDJQA9NVW
 p9+2vhm2OrqD0QQfwUbni4uj9gDOAwBpDep4iRo/TMDnNFzNOhjBxU3ajx6xAvP1JFN0QTqjnDq
 vyCCMk0jN1BsHJaYtVZltNk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gFcgl64nBznTVW;
 Wed, 13 May 2026 10:22:59 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C1ACF4055B;
 Wed, 13 May 2026 10:30:02 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 10:30:02 +0800
Message-ID: <ef49146b-429f-484a-83b9-0ab3de0a28f1@huawei.com>
Date: Wed, 13 May 2026 10:30:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/5] vhost_user: header defines for add/rem mem region
To: <pravin.bathija@dell.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <thomas@monjalon.net>
References: <20260506033733.972952-1-pravin.bathija@dell.com>
 <20260506033733.972952-3-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260506033733.972952-3-pravin.bathija@dell.com>
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

On 5/6/2026 11:37 AM, pravin.bathija@dell.com wrote:
> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> The changes in this file cover the enum message requests for
> supporting add/remove memory regions. The front-end vhost-user
> client sends messages like get max memory slots, add memory region
> and remove memory region which are covered in these changes which
> are on the vhost-user back-end. The changes also include data structure
> definition of memory region to be added/removed. The data structure
> VhostUserMsg has been changed to include the memory region.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index ef486545ba..f8d921f7f1 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -67,6 +67,9 @@ typedef enum VhostUserRequest {
>  	VHOST_USER_POSTCOPY_END = 30,
>  	VHOST_USER_GET_INFLIGHT_FD = 31,
>  	VHOST_USER_SET_INFLIGHT_FD = 32,
> +	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
> +	VHOST_USER_ADD_MEM_REG = 37,
> +	VHOST_USER_REM_MEM_REG = 38,
>  	VHOST_USER_SET_STATUS = 39,
>  	VHOST_USER_GET_STATUS = 40,
>  } VhostUserRequest;
> @@ -91,6 +94,11 @@ typedef struct VhostUserMemory {
>  	VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>  } VhostUserMemory;
>  
> +typedef struct VhostUserSingleMemReg {
> +	uint64_t padding;
> +	VhostUserMemoryRegion region;
> +} VhostUserSingleMemReg;

How about the same as qemu vhost define: VhostUserMemRegMsg

> +
>  typedef struct VhostUserLog {
>  	uint64_t mmap_size;
>  	uint64_t mmap_offset;
> @@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
>  		struct vhost_vring_state state;
>  		struct vhost_vring_addr addr;
>  		VhostUserMemory memory;
> +		VhostUserSingleMemReg memory_single;

Suggest the same as qemu define: VhostUserMemRegMsg memreg;

>  		VhostUserLog    log;
>  		struct vhost_iotlb_msg iotlb;
>  		VhostUserCryptoSessionParam crypto_session;

With above fix
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

