Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C1C0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE210402BB;
	Wed, 12 Feb 2025 02:16:14 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 08E0A40269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:16:12 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yt0hr0g98zfbH0;
 Wed, 12 Feb 2025 09:14:36 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id F0B951802D0;
 Wed, 12 Feb 2025 09:16:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 09:16:10 +0800
Message-ID: <fa141b19-4988-4dff-8731-b8992927c1d9@huawei.com>
Date: Wed, 12 Feb 2025 09:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] test-pmd: declare lcore_count atomic when using C11
 memory model
To: Andre Muezerie <andremue@linux.microsoft.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
CC: <dev@dpdk.org>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-9-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <1739311325-14425-9-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

On 2025/2/12 6:02, Andre Muezerie wrote:
> Compiling with MSVC results in the error below:
> 
> app/test/test_ring_perf.c(197): error C7712: address argument to atomic
>     operation must be a pointer to an atomic integer,
>     'volatile unsigned int *' is not valid
> 
> The fix is to mark lcore_count as atomic when using C11 memory model.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

