Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABDAC0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:10:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54A9D402BB;
	Wed, 12 Feb 2025 02:10:08 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 6F66D40269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:10:06 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yt0Z04v4Xz1JJpW;
 Wed, 12 Feb 2025 09:08:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 587BA14011B;
 Wed, 12 Feb 2025 09:10:03 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Feb 2025 09:10:02 +0800
Message-ID: <08f8c0b2-053f-458a-93bf-c1a92fb9dac6@huawei.com>
Date: Wed, 12 Feb 2025 09:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] test-pmd: don't return value from void function
To: Andre Muezerie <andremue@linux.microsoft.com>, Ori Kam <orika@nvidia.com>, 
 Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-8-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <1739311325-14425-8-git-send-email-andremue@linux.microsoft.com>
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
> Compiling with MSVC results in the warning below:
> 
> app/test-pmd/cmdline_flow.c(13964): warning C4098: 'cmd_set_raw_parsed':
>     'void' function returning a value
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

