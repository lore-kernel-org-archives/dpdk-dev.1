Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A042C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 00:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 406724021E;
	Mon, 29 Jun 2026 02:42:49 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id E2336400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 02:42:47 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=hbKz5FpkGO2UrErpzVmGfrP6n3aT5/CTo29XHST27WE=;
 b=G/W0ZFZibsS7WFVzDXTq+IX2nQ/tr5cuJoR/YlJKJYs4h+Do4XScCLNCDL+36HhLnBAfLpZ4W
 1rxLQD2xEjRShQOo51qWpoegGxYv4+J5HpJOOK8/haNrIZ/HoltmVpzyTDdVMuQI7E6wnkUkm4c
 d/3QYjiad+MNoMAmGPcZJW8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gpS1p6vGczKm4l;
 Mon, 29 Jun 2026 08:33:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id AABD940574;
 Mon, 29 Jun 2026 08:42:45 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 29 Jun 2026 08:42:45 +0800
Message-ID: <94368ef9-ab61-44b1-b56a-6a1d263230b8@huawei.com>
Date: Mon, 29 Jun 2026 08:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dev: skip multi-process in hotplug
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <longli@microsoft.com>
References: <20260625072254.4190227-1-david.marchand@redhat.com>
 <20260628140557.1718861-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260628140557.1718861-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Minor suggestion: how about replace "bool do_mp = internal_conf->no_shconf == 0;" to "bool do_mp = !!internal_conf->no_shconf;" or bool do_mp = internal_conf->no_shconf;"

the no_shconf's prototype is "volatile unsigned", most of invokation is some like "if (internal_conf->no_shconf)"


On 6/28/2026 10:05 PM, David Marchand wrote:
> If multi-process is disabled (--no-shconf/--in-memory),
> there is no need to build a multi-process message.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/eal/common/eal_common_dev.c | 46 ++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
> index 762ed09e21..47fc45aa3e 100644
> --- a/lib/eal/common/eal_common_dev.c
> +++ b/lib/eal/common/eal_common_dev.c
> @@ -267,10 +267,16 @@ RTE_EXPORT_SYMBOL(rte_dev_probe)
>  int
>  rte_dev_probe(const char *devargs)
>  {
> +	const struct internal_config *internal_conf =
> +		eal_get_internal_configuration();
> +	bool do_mp = internal_conf->no_shconf == 0;
>  	struct eal_dev_mp_req req;
>  	struct rte_device *dev;
>  	int ret;
>  
> +	if (!do_mp)
> +		goto skip_mp_req;
> +
>  	memset(&req, 0, sizeof(req));
>  	req.t = EAL_DEV_REQ_TYPE_ATTACH;
>  	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
> @@ -294,6 +300,7 @@ rte_dev_probe(const char *devargs)
>  
>  	/* attach a shared device from primary start from here: */
>  
> +skip_mp_req:
>  	/* primary attach the new device itself. */
>  	ret = local_dev_probe(devargs, &dev);
>  
> @@ -311,6 +318,9 @@ rte_dev_probe(const char *devargs)
>  			return ret;
>  	}
>  
> +	if (!do_mp)
> +		goto skip_mp_notify;
> +
>  	/* primary send attach sync request to secondary. */
>  	ret = eal_dev_hotplug_request_to_secondary(&req);
>  
> @@ -337,16 +347,19 @@ rte_dev_probe(const char *devargs)
>  		goto rollback;
>  	}
>  
> +skip_mp_notify:
>  	return 0;
>  
>  rollback:
> -	req.t = EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK;
> +	if (do_mp) {
> +		req.t = EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK;
>  
> -	/* primary send rollback request to secondary. */
> -	if (eal_dev_hotplug_request_to_secondary(&req) != 0)
> -		EAL_LOG(WARNING,
> -			"Failed to rollback device attach on secondary."
> -			"Devices in secondary may not sync with primary");
> +		/* primary send rollback request to secondary. */
> +		if (eal_dev_hotplug_request_to_secondary(&req) != 0)
> +			EAL_LOG(WARNING,
> +				"Failed to rollback device attach on secondary."
> +				"Devices in secondary may not sync with primary");
> +	}
>  
>  	/* primary rollback itself. */
>  	if (local_dev_remove(dev) != 0)
> @@ -407,6 +420,9 @@ RTE_EXPORT_SYMBOL(rte_dev_remove)
>  int
>  rte_dev_remove(struct rte_device *dev)
>  {
> +	const struct internal_config *internal_conf =
> +		eal_get_internal_configuration();
> +	bool do_mp = internal_conf->no_shconf == 0;
>  	struct eal_dev_mp_req req;
>  	char *devargs;
>  	int ret;
> @@ -416,6 +432,9 @@ rte_dev_remove(struct rte_device *dev)
>  		return -ENOENT;
>  	}
>  
> +	if (!do_mp)
> +		goto skip_mp_req;
> +
>  	ret = build_devargs(dev->bus->name, dev->name, "", &devargs);
>  	if (ret != 0)
>  		return ret;
> @@ -474,6 +493,7 @@ rte_dev_remove(struct rte_device *dev)
>  			goto rollback;
>  	}
>  
> +skip_mp_req:
>  	/* primary detach the device itself. */
>  	ret = local_dev_remove(dev);
>  
> @@ -490,13 +510,15 @@ rte_dev_remove(struct rte_device *dev)
>  	return 0;
>  
>  rollback:
> -	req.t = EAL_DEV_REQ_TYPE_DETACH_ROLLBACK;
> +	if (do_mp) {
> +		req.t = EAL_DEV_REQ_TYPE_DETACH_ROLLBACK;
>  
> -	/* primary send rollback request to secondary. */
> -	if (eal_dev_hotplug_request_to_secondary(&req) != 0)
> -		EAL_LOG(WARNING,
> -			"Failed to rollback device detach on secondary."
> -			"Devices in secondary may not sync with primary");
> +		/* primary send rollback request to secondary. */
> +		if (eal_dev_hotplug_request_to_secondary(&req) != 0)
> +			EAL_LOG(WARNING,
> +				"Failed to rollback device detach on secondary."
> +				"Devices in secondary may not sync with primary");
> +	}
>  
>  	return ret;
>  }

