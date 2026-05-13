Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD7ACD343F
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 02:22:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4EA0402D0;
	Wed, 13 May 2026 04:22:18 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 3F4FE402B6
 for <dev@dpdk.org>; Wed, 13 May 2026 04:22:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=0yCgOWV37VabGs4En2sFtz3ifcKYoqsqRTCk5dalcf4=;
 b=Wj6GIJcPortcWW2ZbzG4nxwSXjgX7ghgooQhumZevo4zVp1BSpOp0eCAoPExkcfLpcs3QxVr9
 FMORUvM4htHX2muqU3KPxtDB8etReFoUvpqLFra5Ug3s+nx922dPdAam9jaNZqgyJC+duVv1z7N
 x0fmw/3IXWbyhhtZAQA+9EQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gFcVh1PTZz12LDY;
 Wed, 13 May 2026 10:15:08 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C5824056A;
 Wed, 13 May 2026 10:22:13 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 10:22:13 +0800
Message-ID: <dd00f786-04ad-45d4-9fcf-807fde2d2abb@huawei.com>
Date: Wed, 13 May 2026 10:22:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/5] vhost: add user to mailmap and define to vhost hdr
To: <pravin.bathija@dell.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <thomas@monjalon.net>
References: <20260506033733.972952-1-pravin.bathija@dell.com>
 <20260506033733.972952-2-pravin.bathija@dell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260506033733.972952-2-pravin.bathija@dell.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 5/6/2026 11:37 AM, pravin.bathija@dell.com wrote:
> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> - add user to mailmap file.
> - define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>   that depicts if the feature/capability to add/remove memory regions
>   is supported. This is a part of the overall support for add/remove
>   memory region feature in this patchset.
> 
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  .mailmap              | 1 +
>  lib/vhost/rte_vhost.h | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 0e0d83e1c6..cc44e27036 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1295,6 +1295,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
>  Prathisna Padmasanan <prathisna.padmasanan@intel.com>
>  Praveen Kaligineedi <pkaligineedi@google.com>
>  Praveen Shetty <praveen.shetty@intel.com>
> +Pravin M Bathija <pravin.bathija@dell.com>
>  Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
>  Prince Takkar <ptakkar@marvell.com>
>  Priyalee Kushwaha <priyalee.kushwaha@intel.com>
> diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
> index 2f7c4c0080..a7f9700538 100644
> --- a/lib/vhost/rte_vhost.h
> +++ b/lib/vhost/rte_vhost.h
> @@ -109,6 +109,10 @@ extern "C" {
>  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
>  #endif
>  
> +#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> +#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
> +#endif
> +
>  #ifndef VHOST_USER_PROTOCOL_F_STATUS
>  #define VHOST_USER_PROTOCOL_F_STATUS 16
>  #endif

