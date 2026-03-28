Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3408810F3DC9
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 03:33:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA083402E7;
	Sat, 28 Mar 2026 04:33:27 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 15705402D9
 for <dev@dpdk.org>; Sat, 28 Mar 2026 04:33:24 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=MQptyVlggaNLNxEUVzCcfiSKS2fX+IxWVp+P9hk8aXM=;
 b=KeRX+VV2TJvtQWKleRzbNEHs+uqxcIZt68YTAFhg8OL2Oy4a54VoqxpOMUY6PCF3E2azMdu3M
 HBs5bsVPQP6S2SnQVM/ftjs4Ad2gWIu6EetZS+lIoxwZ7WAIUQ67TVf2oY+vdYOqdV1B0P9sm9e
 LrxrOgPmAt8KtF0oFOV6UlM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fjNH72mZ7zRhT6;
 Sat, 28 Mar 2026 11:27:15 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9978840538;
 Sat, 28 Mar 2026 11:33:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 11:33:21 +0800
Message-ID: <7d6d9c0e-722b-408d-878f-bac6c699ee46@huawei.com>
Date: Sat, 28 Mar 2026 11:33:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] bus: factorize devargs lookup
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, Parav Pandit
 <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski
 <tduszynski@marvell.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-6-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260326102424.2361945-6-david.marchand@redhat.com>
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

On 3/26/2026 6:24 PM, David Marchand wrote:
> Each bus reimplements some similar devargs lookup code.
> 
> The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> device names. We can't use the .parse existing handler from outside the
> bus code itself, as the size of the bus specific device location address
> is unknown.
> Introduce a bus specific helper to compare two device names and
> hide this ugly detail.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> ---

...

> diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
> index 06a3643290..e6963dc18a 100644
> --- a/drivers/bus/uacce/uacce.c
> +++ b/drivers/bus/uacce/uacce.c
> @@ -70,25 +70,10 @@ extern int uacce_bus_logtype;
>  #define UACCE_BUS_DEBUG(fmt, ...) UACCE_BUS_LOG(DEBUG, fmt, ##__VA_ARGS__)
>  
>  
> -static struct rte_devargs *
> -uacce_devargs_lookup(const char *dev_name)
> -{
> -	char name[RTE_UACCE_DEV_PATH_SIZE] = {0};
> -	struct rte_devargs *devargs;
> -
> -	snprintf(name, sizeof(name), "%s%s", UACCE_DEV_PREFIX, dev_name);

For uacce, application should pass device with prefix uacce, e.g:
  dpdk-testpmd -a uacce:hisi_zip-0,queues=2 --file-prefix=feng -- -i

And the scan device is hisi_zip-0, so in match we should combined which is
above snprintf does.

> -	RTE_EAL_DEVARGS_FOREACH(uacce_bus.bus.name, devargs) {
> -		if (strcmp(devargs->name, name) == 0)
> -			return devargs;
> -	}
> -
> -	return NULL;
> -}
> -
>  static bool
>  uacce_ignore_device(const char *dev_name)
>  {
> -	struct rte_devargs *devargs = uacce_devargs_lookup(dev_name);
> +	struct rte_devargs *devargs = rte_bus_find_devargs(&uacce_bus.bus, dev_name);
>  

...

>  
>  	return retval;
> diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_find_devargs)
> +struct rte_devargs *
> +rte_bus_find_devargs(const struct rte_bus *bus, const char *name)
> +{
> +	rte_bus_devname_compare_t cmp = bus->devname_compare;
> +	struct rte_devargs *devargs;
> +
> +	if (cmp == NULL)
> +		cmp = strcmp;
> +
> +	RTE_EAL_DEVARGS_FOREACH(rte_bus_name(bus), devargs) {
> +		if (cmp(name, devargs->name) != 0)
> +			continue;
> +		return devargs;
> +	}
> +
> +	return NULL;
> +}
> +

...


