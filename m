Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FDAC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 08:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DA4C4060C;
	Thu,  3 Apr 2025 10:12:22 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5F14060A
 for <dev@dpdk.org>; Thu,  3 Apr 2025 10:12:19 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZSvW428QTzvWrV;
 Thu,  3 Apr 2025 16:08:16 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 8DA1E140383;
 Thu,  3 Apr 2025 16:12:16 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 16:12:15 +0800
Message-ID: <ce050b67-1480-4b62-a6d1-a6b2e7e6b28f@huawei.com>
Date: Thu, 3 Apr 2025 16:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] eal: fix unckeck pipe
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <dmitry.kozliuk@gmail.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, Harry van Haaren <harry.van.haaren@intel.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250402122454.2148612-1-huangdengdui@huawei.com>
 <20250402122454.2148612-3-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB8D@smartserver.smartshare.dk>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB8D@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2025/4/2 22:45, Morten Brørup wrote:
>> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
>> Sent: Wednesday, 2 April 2025 14.25
>>
>> The communication pipe may be unavailable, for example,
>> when the lcore role is ROLE_OFF or ROLE_NON_EAL.
>> So check whether the pipe is available before using it.
>>
>> Fixes: a95d70547c57 ("eal: factorize lcore main loop")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> ---
>>  lib/eal/unix/eal_unix_thread.c | 3 +++
>>  lib/eal/windows/eal_thread.c   | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/lib/eal/unix/eal_unix_thread.c
>> b/lib/eal/unix/eal_unix_thread.c
>> index ef6cbff0ee..103571cabf 100644
>> --- a/lib/eal/unix/eal_unix_thread.c
>> +++ b/lib/eal/unix/eal_unix_thread.c
>> @@ -17,6 +17,9 @@ eal_thread_wake_worker(unsigned int worker_id)
>>  	char c = 0;
>>  	int n;
>>
>> +	if (m2w == 0 || w2m == 0)
>> +		return -EINVAL;
>> +
>>  	do {
>>  		n = write(m2w, &c, 1);
>>  	} while (n == 0 || (n < 0 && errno == EINTR));
>> diff --git a/lib/eal/windows/eal_thread.c
>> b/lib/eal/windows/eal_thread.c
>> index 9e3df200b9..82bb974868 100644
>> --- a/lib/eal/windows/eal_thread.c
>> +++ b/lib/eal/windows/eal_thread.c
>> @@ -24,6 +24,9 @@ eal_thread_wake_worker(unsigned int worker_id)
>>  	char c = 0;
>>  	int n;
>>
>> +	if (m2w == 0 || w2m == 0)
>> +		return -EINVAL;
>> +
>>  	do {
>>  		n = _write(m2w, &c, 1);
>>  	} while (n == 0 || (n < 0 && errno == EINTR));
>> --
>> 2.33.0
> 
> This internal function eal_thread_wake_worker() is only called from rte_eal_remote_launch().
> It would be better to check the lcore role there.
> 

Is it better to check lcore roles in rte_eal_remote_launch() instead?
Only Role_RTE and Role_SERVICE lcore can be woken up through rte_eal_remote_launch().

> References:
> https://elixir.bootlin.com/dpdk/v25.03-rc2/A/ident/eal_thread_wake_worker
> https://elixir.bootlin.com/dpdk/v25.03-rc2/source/lib/eal/common/eal_common_launch.c#L52
> 
> Furthermore, in theory, file descriptor 0 is a valid file descriptor; if "stdin" has been closed, a newly opened file (or pipe) may be assigned file descriptor 0.
> 
>
