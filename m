Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91848C0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 00:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A03C1402BB;
	Wed, 12 Feb 2025 01:59:31 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 5980540269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 01:59:29 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yt0H20Nz6z2Fd3F;
 Wed, 12 Feb 2025 08:55:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 645F0180069;
 Wed, 12 Feb 2025 08:59:27 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 08:59:26 +0800
Message-ID: <461ea7be-e1c8-4951-9c98-5b341cc5f243@huawei.com>
Date: Wed, 12 Feb 2025 08:59:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] eal: add workaround for __builtin_constant_p
To: Andre Muezerie <andremue@linux.microsoft.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
CC: <dev@dpdk.org>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-2-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <1739311325-14425-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2025/2/12 6:01, Andre Muezerie wrote:
> There's no MSVC equivalent for compiler extension __builtin_constant_p.
> EAL already had __rte_constant which was used as a first attempt to
> workaround __builtin_constant_p when using MSVC. However, there are
> pieces of code that would benefit from being able to provide a default
> value to be used instead of it being always 0 like how it was done by
> __rte_constant.
> 
> A new macro is added here allowing such default to be provided by the
> caller.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

