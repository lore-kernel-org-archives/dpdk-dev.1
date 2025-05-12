Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E42EC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 03:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0E8A4026C;
	Mon, 12 May 2025 05:36:51 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 12AD74026A
 for <dev@dpdk.org>; Mon, 12 May 2025 05:36:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zwlc93vwpz13KbK;
 Mon, 12 May 2025 11:35:21 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id D04E2180477;
 Mon, 12 May 2025 11:36:44 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 May 2025 11:36:44 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 May
 2025 11:36:43 +0800
Message-ID: <db77a90a-7a91-4b40-9837-254483230311@huawei.com>
Date: Mon, 12 May 2025 11:36:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem: fix infinite loop
To: Dengdui Huang <huangdengdui@huawei.com>, <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>, 
 <roretzla@linux.microsoft.com>, <anatoly.burakov@intel.com>,
 <stephen@networkplumber.org>, <mb@smartsharesystems.com>
References: <20250402124258.2299435-1-huangdengdui@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250402124258.2299435-1-huangdengdui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

LGTM,

Acked-by: Huisong Li <lihuisong@huawei.com>

在 2025/4/2 20:42, Dengdui Huang 写道:
> When the process address space is insufficient,
> mmap will fail, which will cause an infinite loop.
> This pathc fix it.
>
> Fixes: c4b89ecb64ea ("eal: introduce memory management wrappers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
<...>
