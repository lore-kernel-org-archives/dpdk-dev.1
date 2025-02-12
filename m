Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8135CC021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 00:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B55402BB;
	Wed, 12 Feb 2025 01:47:19 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 29A5D40269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 01:47:18 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yt01C0530zkXLJ;
 Wed, 12 Feb 2025 08:43:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2672A180087;
 Wed, 12 Feb 2025 08:47:15 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 08:47:14 +0800
Message-ID: <1d0ad51a-324f-4d4a-958b-2ce23a255d23@huawei.com>
Date: Wed, 12 Feb 2025 08:47:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Defer lcore variables allocation
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <frode.nordahl@canonical.com>,
 <mattias.ronnblom@ericsson.com>, <anatoly.burakov@intel.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/2/11 5:31, David Marchand wrote:
> As I had reported in 24.11-rc2, the lcore variables allocation have a
> noticeable impact on applications consuming DPDK, even when such
> applications does not use DPDK, or use features associated to
> some lcore variables.
> 
> While the amount has been reduced in a rush before rc2,
> there are still cases when the increased memory footprint is noticed
> like in scaling tests.
> See https://bugs.launchpad.net/ubuntu/+source/dpdk/+bug/2090931
> 
> 
> lcore variable allocations in constructor is a bad idea, as the
> application consuming DPDK has no control over such allocation:
> linking some code does not mean that all of it will be used at runtime.
> 
> The general question on whether lcore variables in constructor should
> be forbidden, is left to a later discussion.
> 
> For now, this series only focus on fixing subsystems using lcore
> variables so that those allocations are deferred either in rte_eal_init()
> or in the path that does require such lcore variables.
> 
> 

