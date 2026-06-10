Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70100CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:10:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70621402C6;
	Wed, 10 Jun 2026 03:10:40 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id D75DE400D5
 for <dev@dpdk.org>; Wed, 10 Jun 2026 03:10:38 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/EiZryFsuagzHKbLZn2ZdZ6r97ITqOLSGxZNI2dCWsE=;
 b=EdytMBUDAkJ6iW8ZqjQiE0NJ0KfQEySjQG6mpoY28ghul3FCnXtDExzciYEJrKmE9U0wGnIYc
 uLVXCEANXaxHRsgDb4dZAiuaGU06VJCOoi1yvRGhIf05zcEe+6Hu9gPCH6s+YEuGVLy03RXda12
 0q6hA0N6QyaKCj/fbI5j/eM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gZnZ80Rmyz1prLy;
 Wed, 10 Jun 2026 09:02:40 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 99A97203B1;
 Wed, 10 Jun 2026 09:10:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:10:36 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 10 Jun
 2026 09:10:35 +0800
Message-ID: <9a739c2b-7b32-4393-820b-845797fdb43b@huawei.com>
Date: Wed, 10 Jun 2026 09:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: fix duplicated typedef for setting uncore freq
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
References: <20260507112754.3418377-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260507112754.3418377-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

Kindly ping for review.

On 5/7/2026 7:27 PM, Huisong Li wrote:
> Remove a duplicated rte_power_set_uncore_freq_t definition.
> And this ops is intended to set any available uncore frequency instead
> of minimum and maximum one.
>
> Fixes: ebe99d351a3f ("power: refactor uncore power management")
> Cc: stable@dpdk.org
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   lib/power/power_uncore_ops.h | 24 +-----------------------
>   1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/lib/power/power_uncore_ops.h b/lib/power/power_uncore_ops.h
> index 783860ee5b..025a55cb97 100644
> --- a/lib/power/power_uncore_ops.h
> +++ b/lib/power/power_uncore_ops.h
> @@ -76,8 +76,7 @@ typedef int (*rte_power_uncore_exit_t)(unsigned int pkg, unsigned int die);
>   typedef uint32_t (*rte_power_get_uncore_freq_t)(unsigned int pkg, unsigned int die);
>   
>   /**
> - * Set minimum and maximum uncore frequency for specified die on a package
> - * to specified index value.
> + * Set uncore frequency for specified die on a package to specified index value.
>    * It should be protected outside of this function for threadsafe.
>    *
>    * This function should NOT be called in the fast path.
> @@ -98,27 +97,6 @@ typedef uint32_t (*rte_power_get_uncore_freq_t)(unsigned int pkg, unsigned int d
>    */
>   typedef int (*rte_power_set_uncore_freq_t)(unsigned int pkg, unsigned int die, uint32_t index);
>   
> -/**
> - * Return the list length of available frequencies in the index array.
> - *
> - * This function should NOT be called in the fast path.
> - *
> - * @param pkg
> - *  Package number.
> - *  Each physical CPU in a system is referred to as a package.
> - * @param die
> - *  Die number.
> - *  Each package can have several dies connected together via the uncore mesh.
> - * @param index
> - *  The index of available frequencies.
> - *
> - * @return
> - *  - 1 on success with frequency changed.
> - *  - 0 on success without frequency changed.
> - *  - Negative on error.
> - */
> -typedef int (*rte_power_set_uncore_freq_t)(unsigned int pkg, unsigned int die, uint32_t index);
> -
>   /**
>    * Return the list length of available frequencies in the index array.
>    *
