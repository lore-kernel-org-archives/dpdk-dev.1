Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE54C36014
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 08:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03A05402B5;
	Wed,  2 Apr 2025 10:13:26 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id E157E4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 10:13:24 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZSHZp1q43zvWqD;
 Wed,  2 Apr 2025 16:09:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FF4A1800E5;
 Wed,  2 Apr 2025 16:13:22 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 16:13:21 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Apr
 2025 16:13:21 +0800
Message-ID: <946a6e12-6271-42f5-b402-99806b54486a@huawei.com>
Date: Wed, 2 Apr 2025 16:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update for hns3
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <stephen@networkplumber.org>
CC: <fengcengwen@huawei.com>, <huangdengdui@huawei.com>, Jie Hai
 <haijie1@huawei.com>
References: <20250402032943.3544535-1-haijie1@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250402032943.3544535-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

+Stephen

在 2025/4/2 11:29, Jie Hai 写道:
> Update maintainer for the hns3 driver.
>
> Signed-off-by: Jie Hai <haijie1@huawei.com>

Thanks for your contributions to hns3.

Acked-by: Huisong Li <lihuisong@huawei.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b01103f8e83..bcc9fdaf0c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -765,7 +765,7 @@ F: doc/guides/nics/gve.rst
>   F: doc/guides/nics/features/gve.ini
>   
>   Hisilicon hns3
> -M: Jie Hai <haijie1@huawei.com>
> +M: Dengdui Huang <huangdengdui@huawei.com>
>   F: drivers/net/hns3/
>   F: doc/guides/nics/hns3.rst
>   F: doc/guides/nics/features/hns3.ini
