Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63EBC8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 09:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D294940269;
	Tue,  1 Jul 2025 11:05:58 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id B7AC3400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 11:05:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bWcT35XpNz2Cfm8;
 Tue,  1 Jul 2025 17:01:11 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 0029E1A0188;
 Tue,  1 Jul 2025 17:05:12 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 17:05:11 +0800
Message-ID: <72d2d4b5-ccc6-4afc-9031-06e2671f6393@huawei.com>
Date: Tue, 1 Jul 2025 17:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] net/hns3: VF support multi-TCs configure
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
 <20250611081900.3658421-7-huangdengdui@huawei.com>
 <20250629104055.0b38c168@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250629104055.0b38c168@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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


On 2025/6/30 1:40, Stephen Hemminger wrote:
> On Wed, 11 Jun 2025 16:19:00 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> +#pragma pack(1)
>> +#define HNS3_MBX_PRIO_SHIFT	4
>> +#define HNS3_MBX_PRIO_MASK	0xFu
>> +struct hns3_mbx_tc_config {
>> +	/*
>> +	 * Each four bits correspond to one priority's TC.
>> +	 * Bit0-3 correspond to priority-0's TC, bit4-7 correspond to
>> +	 * priority-1's TC, and so on.
>> +	 */
>> +	uint32_t prio_tc_map;
>> +	uint8_t tc_dwrr[HNS3_MAX_TC_NUM];
>> +	uint8_t num_tc;
>> +	/*
>> +	 * Each bit correspond to one TC's scheduling mode, 0 means SP
>> +	 * scheduling mode, 1 means DWRR scheduling mode.
>> +	 * Bit0 corresponds to TC0, bit1 corresponds to TC1, and so on.
>> +	 */
>> +	uint8_t tc_sch_mode;
>>  };
>> +#pragma pack()
>>  
> 
> DPDK has portable macros for packing __rte_packed_begin and __rte_packed_end.
> Please change to using those macros.
> Then rebase, retest and resubmit this patcheset

Okay, I have modified and pushed the new version.
