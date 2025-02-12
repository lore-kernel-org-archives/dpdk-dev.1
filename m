Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA33C0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D53CC40ED8;
	Wed, 12 Feb 2025 02:04:53 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id C9F5E402BB
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:04:51 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yt0PT6V2tzkXNG;
 Wed, 12 Feb 2025 09:01:17 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 10D4C140257;
 Wed, 12 Feb 2025 09:04:50 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 09:04:49 +0800
Message-ID: <27950e1c-aa11-4e8d-91cc-1b69b6834f94@huawei.com>
Date: Wed, 12 Feb 2025 09:04:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] test-pmd: avoid non-constant initializer
To: Andre Muezerie <andremue@linux.microsoft.com>, Ori Kam <orika@nvidia.com>, 
 Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-7-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <1739311325-14425-7-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> Compiling with MSVC results in errors like the one below:
> 
> app/test-pmd/cmdline_flow.c(8819): error C2099: initializer
>     is not a constant
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

