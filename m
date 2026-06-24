Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C80CD4F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 00:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF9F940299;
	Wed, 24 Jun 2026 02:58:01 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 8679940150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 02:58:00 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=UxtJiZmtss+Jxa54x6l8a4KKTOV4EdMvsn4YQjPiAcI=;
 b=MSxguX5zuPwDpRW1ISVVBCnSwwp2vVK5p3VAfxW6FqUfFrijTNMYV4MIiIzCV2GXjClbvAKpI
 NMcN3H8VGOkFrKOMuQ+4APAV0P1IMBVGx45M1u9fqWK8q1V7fVu6xHpXifLNppzD1KtoV53QdnS
 SKlQsSwg6MLZrLbbCj59MBE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4glNbm3FNPzLlZG;
 Wed, 24 Jun 2026 08:48:52 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 893B540573;
 Wed, 24 Jun 2026 08:57:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 08:57:56 +0800
Message-ID: <2b53ac05-892d-4c1e-8c8e-56d13ec402ad@huawei.com>
Date: Wed, 24 Jun 2026 08:57:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] app/dma_perf: skip case if worker maps to main lcore
To: Bruce Richardson <bruce.richardson@intel.com>, Rupesh Chiluka
 <rchiluka@marvell.com>
CC: Cheng Jiang <honest.jiang@foxmail.com>, <dev@dpdk.org>,
 <gakhil@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>
References: <20260623045841.2602104-1-rchiluka@marvell.com>
 <ajo-ra8UUPRXKoWF@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <ajo-ra8UUPRXKoWF@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 6/23/2026 4:07 PM, Bruce Richardson wrote:
> On Tue, Jun 23, 2026 at 10:28:41AM +0530, Rupesh Chiluka wrote:
>> Refuse to run DMA/CPU mem-copy cases when any worker is bound to the
>> EAL main lcore.
>>
> 
> Can you explain a bit more why?

+1
I understand this bugfix, as the following config, the test will stuck
because the master lcore is the same with worker lcore.

[GLOBAL]
eal_args=--in-memory --file-prefix=test -l 10-12

[case4]
type=CPU_MEM_COPY
mem_size=10
buf_size=64,8192,2,MUL
src_numa_node=0
dst_numa_node=1
lcore = 10, 11

So please add more explain as Bruce suggest, and also add Fixes/CC tag

> 
>> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
>> ---
>>  app/test-dma-perf/main.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
>> index 4249dcfd3d..b6aa5b8401 100644
>> --- a/app/test-dma-perf/main.c
>> +++ b/app/test-dma-perf/main.c
>> @@ -109,6 +109,7 @@ run_test_case(struct test_configure *case_cfg)
>>  static void
>>  run_test(uint32_t case_id, struct test_configure *case_cfg)
>>  {
>> +	uint32_t main_lcore = rte_get_main_lcore();
>>  	uint32_t nb_lcores = rte_lcore_count();
>>  	struct test_configure_entry *mem_size = &case_cfg->mem_size;
>>  	struct test_configure_entry *buf_size = &case_cfg->buf_size;
>> @@ -122,6 +123,14 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
>>  		return;
>>  	}
>>  
>> +	for (uint32_t i = 0; i < case_cfg->num_worker; i++) {

Please define the variables in front of function impl.

Thanks

>> +		if (case_cfg->dma_config[i].lcore_dma_map.lcore == main_lcore) {
>> +			printf("Case %u: worker %u cannot run on the EAL main lcore (%u).\n",
>> +			       case_id, i, main_lcore);
>> +			return;
>> +		}
>> +	}
>> +
>>  	printf("Number of used lcores: %u.\n", nb_lcores);
>>  
>>  	if (mem_size->incr != 0)
>> -- 
>> 2.48.1
>>
> 

