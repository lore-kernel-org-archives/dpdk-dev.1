Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1CC61CE8
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 01:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC7E141109;
	Tue, 10 Jun 2025 03:19:29 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id A7C6140276
 for <dev@dpdk.org>; Tue, 10 Jun 2025 03:19:28 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bGW6l28Wsz10WqM;
 Tue, 10 Jun 2025 09:14:55 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id B53F4180450;
 Tue, 10 Jun 2025 09:19:25 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 09:19:25 +0800
Message-ID: <6107161a-119f-4e13-8839-63a82b2c86e9@huawei.com>
Date: Tue, 10 Jun 2025 09:19:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net/hns3: fix can't use vector for Rx when set VLAN
 filter
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250609130651.2752977-1-huangdengdui@huawei.com>
 <20250609130651.2752977-4-huangdengdui@huawei.com>
 <20250609101233.73a05aef@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250609101233.73a05aef@hermes.local>
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


On 2025/6/10 1:12, Stephen Hemminger wrote:
> On Mon, 9 Jun 2025 21:06:51 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> Currently, When RTE_ETH_RX_OFFLOAD_VLAN_FILTER offload is set,
>> driver wouldn't select Rx vector algorithm. Actually, this
>> algorithm support it, so open it.
>>
>> Fixes: a3d4f4d291d7 ("net/hns3: support NEON Rx")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> 
> Mind if I reword commit message slightly.
> Use past tense for case before the patch was applied (old)
> and present for case when patch is applied.
> 
> When the RTE_ETH_RX_OFFLOAD_VLAN_FILTER offload flag was set,
> the driver would not select the Rx vector algorithm.
> But this flag is OK when using vector algorithm so remove
> it from the mask.
> 
> 

Okay, I don't mind. This new description is easier to understand.
