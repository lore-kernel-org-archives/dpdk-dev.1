Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F2CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 08:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FF04402B6;
	Tue,  4 Nov 2025 09:12:25 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id B24604028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 09:12:23 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YqqA2yl3D+qYe9n9byMEbmI5ubNezILYDBL+wFW6cmg=;
 b=0rxVtGqOjiIyTDGHBilzKtv0GJwAVXApdjWPtIAO61QIk69chmYzMjqievfoR9MS0J4BuBUYP
 noMhVJ5zhW12DnZ2+oRKwJfVMBwptK4oQeacUy7h2rz5zF6EKEan5EBOXfNAr3+mc10oXQZDsOP
 tSddmknW6C5QBCRidzQCTCA=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d11Nk5LwfzRhRp;
 Tue,  4 Nov 2025 16:10:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CE242147BBC;
 Tue,  4 Nov 2025 16:12:20 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 16:12:20 +0800
Message-ID: <d7af7a2d-939a-45b3-9353-2787ef1dd513@huawei.com>
Date: Tue, 4 Nov 2025 16:12:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] vhost_user: Increase number of memory regions
To: Pravin M Bathija <pravin.bathija@dell.com>, <dev@dpdk.org>
CC: <pravin.m.bathija.dev@gmail.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-6-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104042142.2787631-6-pravin.bathija@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
> In this patch the number of memory regions are increased from
> 8 to 128. When a vhost-user front-end such as qemu or libblkio
> queries the back-end such as dpdk with the message, get max number
> of memory slots, the back-end replies with this number 128 instead
> of the previously defined 8. The back-end also allocates that many
> slots in the memory table where regions are added/removed as
> requested by the vhost-user front-end. This also helps the vhost-
> user front-end to limit the number of memory regions when sending
> the set mem table message ar adding memory regions.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index 5a0e747b58..c6ad5b76d6 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -11,7 +11,7 @@
>  
>  /* refer to hw/virtio/vhost-user.c */
>  
> -#define VHOST_MEMORY_MAX_NREGIONS 8
> +#define VHOST_MEMORY_MAX_NREGIONS 128

The address translation may increase a lot if the real region is 128.
Maybe we should add another patch to optimize it.

>  
>  #define VHOST_USER_NET_SUPPORTED_FEATURES \
>  	(VIRTIO_NET_SUPPORTED_FEATURES | \

