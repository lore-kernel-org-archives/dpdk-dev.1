Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB7C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 01:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4AF740156;
	Mon, 14 Apr 2025 03:17:55 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id C991D400D7
 for <dev@dpdk.org>; Mon, 14 Apr 2025 03:17:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZbTrD51G7z1R7ZH;
 Mon, 14 Apr 2025 09:15:56 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 462F81402C4;
 Mon, 14 Apr 2025 09:17:52 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 09:17:51 +0800
Message-ID: <8138f608-e9a2-4c9c-b046-a42d85cfbbb9@huawei.com>
Date: Mon, 14 Apr 2025 09:17:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update for hns3
To: Jie Hai <haijie1@huawei.com>, <dev@dpdk.org>, <thomas@monjalon.net>,
 <ferruh.yigit@amd.com>
CC: <lihuisong@huawei.com>, <fengcengwen@huawei.com>
References: <20250402084744.334095-1-haijie1@huawei.com>
Content-Language: en-US
From: huangdengdui <huangdengdui@huawei.com>
In-Reply-To: <20250402084744.334095-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

Acked-by: Dengdui Huang <huangdengdui@huawei.com>

On 2025/4/2 16:47, Jie Hai wrote:
> I am moving on to other things and dengdui is going to
> take over the role of hns3 maintainer. Update the
> MAINTAINERS accordingly.
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b01103f8e83..bcc9fdaf0c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -765,7 +765,7 @@ F: doc/guides/nics/gve.rst
>  F: doc/guides/nics/features/gve.ini
>  
>  Hisilicon hns3
> -M: Jie Hai <haijie1@huawei.com>
> +M: Dengdui Huang <huangdengdui@huawei.com>
>  F: drivers/net/hns3/
>  F: doc/guides/nics/hns3.rst
>  F: doc/guides/nics/features/hns3.ini
