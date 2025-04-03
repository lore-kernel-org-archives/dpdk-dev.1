Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C4C36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 01:25:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 072CB4029A;
	Thu,  3 Apr 2025 03:25:14 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id E6DE24014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 03:25:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZSkSL30fmz2RTJS;
 Thu,  3 Apr 2025 09:20:18 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 8151B140259;
 Thu,  3 Apr 2025 09:25:07 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 09:25:06 +0800
Message-ID: <ec13baa6-ccbd-4e7d-897f-ae5cdc6834cd@huawei.com>
Date: Thu, 3 Apr 2025 09:25:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem: fix infinite loop
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <anatoly.burakov@intel.com>, <stephen@networkplumber.org>,
 <mb@smartsharesystems.com>
References: <20250402124258.2299435-1-huangdengdui@huawei.com>
 <a063308e-448d-4881-a661-17adb52888a4@gmail.com>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <a063308e-448d-4881-a661-17adb52888a4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


On 2025/4/3 5:16, Dmitry Kozlyuk wrote:
> On 02.04.2025 15:42, Dengdui Huang wrote:
>> When the process address space is insufficient,
>> mmap will fail, which will cause an infinite loop.
>> This pathc fix it.
>>
>> Fixes: c4b89ecb64ea ("eal: introduce memory management wrappers")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> 
> Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
> 
> Typo: "pathc fix" -> "patch fixes", or, better:
> "This patch stops attempting mmap if it fails and the requested size cannot be reduced."
> 
> The bug is actually older, but it doesn't matter since both c4b89ecb64ea and b7cc54187ea4 belong to all LTS:
> 
> Fixes: b7cc54187ea4 ("mem: move virtual area function in common directory")
> 

It would be better to write the commit log like this, and I'll modify it in v2.
