Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64ACCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 12:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22CB34021F;
	Thu,  6 Nov 2025 13:57:24 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id EF0F74013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 13:57:22 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=cYAIRo9EuMq7flxzmavApipDQRIJFCeBGWR6CVBL1WE=;
 b=HOkb3BLAVXCYEEPe1UMnrKG6Y2kYvYdufsRV7gIxcA9SR2NyzYeHkyD/MuWotqxLZaHoRBPIy
 HoLYSkuGVxa0xEQB8zit79ta0Kw8qbPBhuPpZFJ9EFNMOsBGPeZjhstqhJzgCRN3B0y+HnjBJpL
 teD9C0liAvdJzJe9jGIwL30=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d2Mcc6Gt7zLlw5;
 Thu,  6 Nov 2025 20:55:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 713D51A0188;
 Thu,  6 Nov 2025 20:57:20 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 20:57:20 +0800
Message-ID: <b2028576-c308-4791-b38a-44edb3be3a9c@huawei.com>
Date: Thu, 6 Nov 2025 20:57:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] bugfix and refactor of dma-perf
From: fengchengwen <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251020041105.1590-1-fengchengwen@huawei.com>
 <c3009bd2-19fb-4ff9-960c-14870d10c561@huawei.com>
Content-Language: en-US
In-Reply-To: <c3009bd2-19fb-4ff9-960c-14870d10c561@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Hi Thomas,

Gentle ping for merge.

Thanks.

On 10/29/2025 9:18 AM, fengchengwen wrote:
> ping for review / upstream
> 
> On 10/20/2025 12:10 PM, Chengwen Feng wrote:
>> This patchset contain one bugfix and refactor commits for
>> test-dma-perf application.
>>
>> Chengwen Feng (14):
>>   app/dma-perf: fix use-after-free
>>   app/dma-perf: add global section for config file
>>   app/dma-perf: use argparse lib to parse argument
>>   app/dma-perf: refactor output csv
>>   app/dma-perf: support list DMA devices
>>   app/dma-perf: add more global config
>>   app/dma-perf: remove invalid or redundant field
>>   app/dma-perf: refactor load config function
>>   app/dma-perf: refactor benchmark function
>>   app/dma-perf: support specific error info
>>   app/dma-perf: fix segment fault with large size
>>   app/dma-perf: fix on-flight DMA when verify data
>>   app/dma-perf: fix wrong stage to stop dmadev
>>   app/dma-perf: refactor benchmark function
>>
>> ---
>> v4: rebase to latest upstream.
>>     add one more refactor commit.
>> v3: add min/max desc when list DMA devices
>>     add three bugfix commit (11~13) that recently found
>> v2: fix global argv[0] not prog name.
>>     friendly remide if there are no dmadev when list-dma.
>>     add ack from Vamsi Attunuru.
>>
>>  app/test-dma-perf/benchmark.c | 479 ++++++++++++++++-----------
>>  app/test-dma-perf/config.ini  |  36 +--
>>  app/test-dma-perf/main.c      | 594 ++++++++++++++++++----------------
>>  app/test-dma-perf/main.h      |  28 +-
>>  app/test-dma-perf/meson.build |   2 +-
>>  doc/guides/tools/dmaperf.rst  |  57 ++--
>>  6 files changed, 671 insertions(+), 525 deletions(-)
>>
> 

