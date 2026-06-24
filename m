Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3D0CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 06:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1517340299;
	Wed, 24 Jun 2026 08:05:53 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id D425740150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 08:05:51 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=M5Mck89YZkYPTxTP1OBevScAcUjDVFKmNo1r+eYEyhw=;
 b=PejR3d2vqpy6uHIlawFlxwXhRPht0JgLlLoBrhktvtRVMKPc6LvpMVeKkO/LLhWgNNrntbYEt
 UXnzgJZBFEm+Jx7xF29DtEhvMNi21gjnNy3vxS8B8FQ8snXb6vWtGxlUbaYS1dg6Sqm0dsoA9Or
 G5R3/XbppFpwMRV9URUiJ3k=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4glWQz5HJ6zLlZK;
 Wed, 24 Jun 2026 13:56:43 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id F2FC840563;
 Wed, 24 Jun 2026 14:05:48 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 14:05:48 +0800
Message-ID: <0f5232d3-206b-4cd9-bf87-d9e9be99b206@huawei.com>
Date: Wed, 24 Jun 2026 14:05:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <dev@dpdk.org>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <20260624032357.2153-1-fengchengwen@huawei.com>
 <20260623212621.1027df00@phoenix.local>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260623212621.1027df00@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 6/24/2026 12:26 PM, Stephen Hemminger wrote:
> On Wed, 24 Jun 2026 11:23:57 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> -extern struct lcore_conf lcore_conf[RTE_MAX_LCORE];
>> +extern struct lcore_conf *lcore_conf[RTE_MAX_LCORE];
>>  
> 
> Since almost no systems have that many cores. Why not allocate it dynamically
> based on rte_lcore_count at runtime?

I understand that the original implementation did this for
simplicity (e.g., it can quickly index to the conf based on
lcore-id).

In my patch, I still keep the array, but the elements are
changed to pointers, and only elements corresponding to
actually valid lcores are allocated.

