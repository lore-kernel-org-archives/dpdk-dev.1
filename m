Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23CC02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 07:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 996BF427A7;
	Fri,  7 Feb 2025 08:45:02 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 9BF7B402C9;
 Fri,  7 Feb 2025 08:45:00 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yq5VX5F5dz11PW4;
 Fri,  7 Feb 2025 15:40:36 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 66C2C140257;
 Fri,  7 Feb 2025 15:44:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 15:44:56 +0800
Message-ID: <3ab6643a-6bcf-49b8-9ae1-88bc6dd89170@huawei.com>
Date: Fri, 7 Feb 2025 15:44:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test: improve resiliency of malloc autotest
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
References: <20250117125912.985475-1-bruce.richardson@intel.com>
 <20250117144112.2544963-1-bruce.richardson@intel.com>
 <0e91d822-ed10-4dae-8f0a-7169e7819517@huawei.com>
 <Z6SflKJyTbxMRD9g@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <Z6SflKJyTbxMRD9g@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2025/2/6 19:40, Bruce Richardson wrote:
> On Fri, Jan 24, 2025 at 03:18:11PM +0800, fengchengwen wrote:
>> The new impl don't support re-test, how about add a wrap:
>> 1. rename test_multi_alloc_statistics with do_test_multi_alloc_statistics, and make it take socket as parameter
>> 2. create a new function test_multi_alloc_statistics {
>>     // prepare a new malloc heap
>>     ret = do_test_multi_alloc_statistics(socket);
>>     // free the heap
>>     return ret;
>> }
>>
> 
> Can you clarify the issues being seen on re-test? I have just run
> malloc_autotest multiple times within the same dpdk-test instance and not
> seen any issues.

If the middle logic fail, for example:

	if ((post_stats.heap_totalsz_bytes != pre_stats.heap_totalsz_bytes) ||
			(post_stats.heap_freesz_bytes != pre_stats.heap_freesz_bytes) ||
			(post_stats.heap_allocsz_bytes != pre_stats.heap_allocsz_bytes) ||
			(post_stats.alloc_count != pre_stats.alloc_count) ||
			(post_stats.free_count != pre_stats.free_count)) {
		printf("Malloc statistics are incorrect - freed alloc\n");
		return -1;
	}

If the above if branch taken, then retest, the rte_malloc_heap_create(__func__) will
failed because already exist the heap.

> 
> /Bruce
> 

