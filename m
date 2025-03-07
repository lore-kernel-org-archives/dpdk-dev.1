Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6376FC19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 09:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B49F4029E;
	Fri,  7 Mar 2025 10:40:24 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 001DC40275;
 Fri,  7 Mar 2025 10:40:22 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z8Lnq6Wtnz1R6Dl;
 Fri,  7 Mar 2025 17:38:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CC0181402C4;
 Fri,  7 Mar 2025 17:40:18 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 17:40:18 +0800
Message-ID: <11224e6b-4101-415e-bab3-b526688bace2@huawei.com>
Date: Fri, 7 Mar 2025 17:40:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethdev: fix get_reg_info
To: Thierry Herbelot <thierry.herbelot@6wind.com>, <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, <stable@dpdk.org>
References: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2025/2/18 19:58, Thierry Herbelot wrote:
> 'width' and 'offset' are input parameters when dumping the register
> info of an Ethernet device. They should be copied in the new request
> before calling the device callback function.
> 
> Fixes: 083db2ed9e9 ('ethdev: add report of register names and filter')
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> ---
>  lib/ethdev/rte_ethdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index 6413c54e3b39..073a3bcf5c0b 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -6511,6 +6511,8 @@ rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
>  	}
>  
>  	reg_info.length = info->length;
> +	reg_info.width = info->width;
> +	reg_info.offset = info->offset;

I think there are ambiguities in the original API definition:
1) the width was used as an output parameter in current all PMD impl.
2) the offset was unused in current all PMD impl.

But maybe other non-opensource PMD will use these two field.
So I think it's OK to copy the two fields (maybe another field "version") before invoke _ext API.

>  	reg_info.data = info->data;
>  
>  	ret = rte_eth_dev_get_reg_info_ext(port_id, &reg_info);

