Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EBBC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 12:00:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 317CF4069F;
	Tue,  3 Jun 2025 14:00:36 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id CFFFF40697
 for <dev@dpdk.org>; Tue,  3 Jun 2025 14:00:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bBTnv5dZrz27hhk;
 Tue,  3 Jun 2025 20:01:23 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id AB7F01401E9;
 Tue,  3 Jun 2025 20:00:32 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 20:00:32 +0800
Message-ID: <c958d41c-871f-4225-9943-ef0c52d74284@huawei.com>
Date: Tue, 3 Jun 2025 20:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] net: fix GTP packet parsing
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>
References: <20250411084303.770040-1-huangdengdui@huawei.com>
 <20250523025557.905502-1-huangdengdui@huawei.com>
 <20250526135305.653c12ac@hermes.local>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250526135305.653c12ac@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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


On 2025/5/27 4:53, Stephen Hemminger wrote:
> On Fri, 23 May 2025 10:55:55 +0800
> Dengdui Huang <huangdengdui@huawei.com> wrote:
> 
>> After parsing the GTP packet header, the next protocol type should
>> be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
>> Otherwise, the next protocol cannot be parsed.
>>
>> Bugzilla ID: 1672
>> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
>> Acked-by: Jie Hai <haijie1@huawei.com>
> 
> Looks good but there are failures in CI test of hardware L4 checksum.
> Please fix (or rerun the test).
> 
OK, thank you for your review.
I should not push these three patches together because they address different issues.
I will push this patch separately, and the other two patches will be pushed as a new patchset.


