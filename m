Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215ECCFA0D
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 00:37:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41BAC40BA5;
	Thu,  6 Nov 2025 01:37:28 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 83D1B4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 01:37:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=UlA3yLTQ50S3H4tBL+9xQ3ZEDHBEZjh/1EWUkoflqzU=;
 b=cQ1FmPFe+YxCgXTbj7cc9Zx5zHQZQM3wAc22hUxcW2eNVv30XamlhNRdM3FgJ8AS/THe7R2xu
 sFvU/1NFXpNNk43DqqAXiQyelj2NI6DrUpS/WvCRJm6/eYjUiELVOq34KhYb5f/TUdFQO6OdUeY
 mg5HfbNyzHQ8+2QKYtn56sI=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d23Bs5rW4z12LKN;
 Thu,  6 Nov 2025 08:35:49 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id EFAA2180B66;
 Thu,  6 Nov 2025 08:37:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 08:37:24 +0800
Message-ID: <60afaf2b-8871-4689-ae15-835fe6039a2f@huawei.com>
Date: Thu, 6 Nov 2025 08:37:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/vdpa: support show protocol features
From: fengchengwen <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>, <mcoqueli@redhat.com>
CC: <dev@dpdk.org>
References: <20251030065715.47304-1-fengchengwen@huawei.com>
Content-Language: en-US
In-Reply-To: <20251030065715.47304-1-fengchengwen@huawei.com>
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

ping for review / upstream

On 10/30/2025 2:57 PM, Chengwen Feng wrote:
> This commit adds show device's protocol features in list command.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  doc/guides/sample_app_ug/vdpa.rst |  8 ++++----
>  examples/vdpa/main.c              | 13 ++++++++++---
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
> index cd3ec99054..873efbf7c7 100644
> --- a/doc/guides/sample_app_ug/vdpa.rst
> +++ b/doc/guides/sample_app_ug/vdpa.rst
> @@ -70,10 +70,10 @@ Then we can create 2 vdpa ports in interactive cmdline.
>  .. code-block:: console
>  
>          vdpa> list
> -        device id       device address  queue num       supported features
> -        0               0000:06:00.3    1               0x14c238020
> -        1               0000:06:00.4    1               0x14c238020
> -        2               0000:06:00.5    1               0x14c238020
> +        device id       device address  queue num       supported features      supported protocol features
> +        0               0000:06:00.3    1               0x14c238020             0x10c33
> +        1               0000:06:00.4    1               0x14c238020             0x10c33
> +        2               0000:06:00.5    1               0x14c238020             0x10c33
>  
>          vdpa> create /tmp/vdpa-socket0 0000:06:00.3
>          vdpa> create /tmp/vdpa-socket1 0000:06:00.4
> diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
> index 289db26498..505e563a57 100644
> --- a/examples/vdpa/main.c
> +++ b/examples/vdpa/main.c
> @@ -324,11 +324,12 @@ void cmd_list_parsed(
>  {
>  	uint32_t queue_num;
>  	uint64_t features;
> +	uint64_t protocol_features;
>  	struct rte_vdpa_device *vdev;
>  	struct rte_device *dev;
>  	struct rte_dev_iterator dev_iter;
>  
> -	cmdline_printf(cl, "device name\tqueue num\tsupported features\n");
> +	cmdline_printf(cl, "device name\tqueue num\tsupported features\tsupported protocol features\n");
>  	RTE_DEV_FOREACH(dev, "class=vdpa", &dev_iter) {
>  		vdev = rte_vdpa_find_device_by_name(rte_dev_name(dev));
>  		if (!vdev)
> @@ -345,8 +346,14 @@ void cmd_list_parsed(
>  				"for device %s.\n", rte_dev_name(dev));
>  			continue;
>  		}
> -		cmdline_printf(cl, "%s\t\t%" PRIu32 "\t\t0x%" PRIx64 "\n",
> -			rte_dev_name(dev), queue_num, features);
> +		if (rte_vdpa_get_protocol_features(vdev, &protocol_features) < 0) {
> +			RTE_LOG(ERR, VDPA,
> +				"failed to get vdpa protocol features "
> +				"for device %s.\n", rte_dev_name(dev));
> +			continue;
> +		}
> +		cmdline_printf(cl, "%s\t\t%" PRIu32 "\t\t0x%" PRIx64 "\t\t0x%" PRIx64 "\n",
> +			rte_dev_name(dev), queue_num, features, protocol_features);
>  	}
>  }
>  

