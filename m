Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF10CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 00:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83820402CA;
	Thu,  6 Nov 2025 01:34:35 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 9D5E24013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 01:34:33 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ymUUQPIo60kaDZi/OWu032qF7koDvlcAWSi5v/82czA=;
 b=So3i3rO34SvYWeq3dUxKLGyvLV9BmqUbVtDpARZVzpXYdFnRlh5o78kew4xtweiM3yBk2iGAs
 io5/mlgI2GWiEVvm19LSwN9wQmXijT499/wtKaXiHqDXdLILwP/k0vV/VyokHyJ+DwKGlDadVM8
 jUqETnn8zT7dHblNRzk4UiQ=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d237X45B9zRhSr;
 Thu,  6 Nov 2025 08:32:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id ADFFF140258;
 Thu,  6 Nov 2025 08:34:31 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 08:34:31 +0800
Message-ID: <14afcee7-c302-4f6a-a614-c7cad1e84363@huawei.com>
Date: Thu, 6 Nov 2025 08:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] testpmd support pause/resume specify lcore's fwd
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251105094748.3269-1-fengchengwen@huawei.com>
 <20251105105946.73a06834@phoenix>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251105105946.73a06834@phoenix>
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

On 11/6/2025 2:59 AM, Stephen Hemminger wrote:
> On Wed, 5 Nov 2025 17:47:45 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> This patch support pause/resume specify lcore's forwarding for testpmd,
>> and also include two bugfix which found when test DCB function.
>>
>> Chengwen Feng (3):
>>   app/testpmd: fix invalid txp when setup DCB forward
>>   app/testpmd: fix wrong Rx queues when setup DCB forward
>>   app/testpmd: support pause/resume specify lcore
>>
>>  app/test-pmd/cmdline.c                      | 126 ++++++++++++++++++++
>>  app/test-pmd/config.c                       |   9 +-
>>  app/test-pmd/testpmd.c                      |   5 +
>>  app/test-pmd/testpmd.h                      |   2 +-
>>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  14 +++
>>  5 files changed, 149 insertions(+), 7 deletions(-)
>>
> 
> Please split bug fix from enhancements.

done

> 
> The whole scheme looks like an optimization for power usage in testpmd.
> Since testpmd is solely focused on performance, I don't think you have
> provided enough justification to add the new feature.

I know your worry, especial in this cycles.

> 
> With DCB if there are TC's that could receive packets, it is better
> not to never poll those queues. 
> 
> That said, longer term it would make sense to bring of the power
> saving logic that is in examples into testpmd.

I will try to another way to meet the usage of specify TC.

Thanks

