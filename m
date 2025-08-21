Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA0CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 12:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9CFE402BD;
	Thu, 21 Aug 2025 14:20:42 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 7F83A402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 14:20:41 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c72SV1R4YztT3V;
 Thu, 21 Aug 2025 20:19:38 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id E467E140279;
 Thu, 21 Aug 2025 20:20:36 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 20:20:36 +0800
Message-ID: <bc5135ca-e415-4339-8c67-6eea8800efd5@huawei.com>
Date: Thu, 21 Aug 2025 20:20:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-2-huangdengdui@huawei.com>
 <20250813140646.48a2ff16@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250813140646.48a2ff16@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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



On 2025/8/14 5:06, Stephen Hemminger wrote:
> On Wed, 13 Aug 2025 15:33:15 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> The hns3 driver supports configuring RSS through both ops API and
>> rte_flow API. The ops API uses spink lock, while the rte_flow API uses
>> pthread mutex lock. When concurrent calls occur, issues may arise.
>> This patch replaces the lock in the flow API with spink lock.
>>
>> Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
> 
> With that mutex removed, you can also go farther and remove all references to pthread.


I made a mistake, and I will remove these references in the next version.

> 
> $ git diff
> diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
> index a63ab99edc..f6bb1b5d43 100644
> --- a/drivers/net/hns3/hns3_ethdev.h
> +++ b/drivers/net/hns3/hns3_ethdev.h
> @@ -5,7 +5,6 @@
>  #ifndef HNS3_ETHDEV_H
>  #define HNS3_ETHDEV_H
>  
> -#include <pthread.h>
>  #include <ethdev_driver.h>
>  #include <rte_byteorder.h>
>  #include <rte_io.h>
> diff --git a/drivers/net/hns3/hns3_flow.c b/drivers/net/hns3/hns3_flow.c
> index 458d4ffbf1..f2d1e4ec3a 100644
> --- a/drivers/net/hns3/hns3_flow.c
> +++ b/drivers/net/hns3/hns3_flow.c
> @@ -2853,13 +2853,10 @@ void
>  hns3_flow_init(struct rte_eth_dev *dev)
>  {
>         struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> -       pthread_mutexattr_t attr;
>  
>         if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>                 return;
>  
> -       pthread_mutexattr_init(&attr);
> -       pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
>         dev->data->dev_flags |= RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE;
>  
>         TAILQ_INIT(&hw->flow_fdir_list);


