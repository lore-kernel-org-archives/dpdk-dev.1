Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4AFCD4F25
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 00:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8692F40281;
	Fri, 15 May 2026 02:06:23 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id D4BA840151
 for <dev@dpdk.org>; Fri, 15 May 2026 02:06:21 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=pfqNl3qRToouMbBHm6eTdbXfC24KDtIHz0aU6P4AVaA=;
 b=j81sN1Ph1OhQ1OKwSPDpezkHW/0L0gjO3k3I8l/KCEivMwfHC2fjlA+A/QdX2Gw4xNNGuXpyL
 ag6ZsamQcQ6iBl9wgd5j5NBYDCfWq7pnCTmZNe9uRPk/wgVGyv5ocjEPu9g7RwGzN6yP2EOB2u6
 C4F22dTs9zlHXAAknYr1kgg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gGnNz0MjPzpTHf;
 Fri, 15 May 2026 07:59:15 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 587AF40561;
 Fri, 15 May 2026 08:06:19 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 08:06:18 +0800
Message-ID: <3c80e9fb-c285-4928-ade2-15a2bc1da914@huawei.com>
Date: Fri, 15 May 2026 08:06:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update for compress/uadk and crypto/uadk
 driver
To: ZongYu Wu <wuzongyu1@huawei.com>, <dev@dpdk.org>
CC: <fanghao11@huawei.com>, <liulongfang@huawei.com>, <thomas@monjalon.net>
References: <20260514124049.3133884-1-wuzongyu1@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260514124049.3133884-1-wuzongyu1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Please
1\ For commitlog, each line contain a maximum of 72 characters.
2\ Add you name in .mailmap

On 5/14/2026 8:40 PM, ZongYu Wu wrote:
> From: Zongyu Wu <wuzongyu1@huawei.com>
> 
> Zongyu Wu replaces Zhangfei Gao as the maintainer of compress/uadk and crypto/uadk.
> 
> Signed-off-by: Zongyu Wu <wuzongyu1@huawei.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f5539f851..84133b00ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1201,7 +1201,7 @@ F: drivers/crypto/scheduler/
>  F: doc/guides/cryptodevs/scheduler.rst
>  
>  HiSilicon UADK crypto
> -M: Zhangfei Gao <zhangfei.gao@linaro.org>
> +M: Zongyu Wu <wuzongyu1@huawei.com>
>  F: drivers/crypto/uadk/
>  F: doc/guides/cryptodevs/uadk.rst
>  F: doc/guides/cryptodevs/features/uadk.ini
> @@ -1318,7 +1318,7 @@ F: doc/guides/compressdevs/octeontx.rst
>  F: doc/guides/compressdevs/features/octeontx.ini
>  
>  HiSilicon UADK compress
> -M: Zhangfei Gao <zhangfei.gao@linaro.org>
> +M: Zongyu Wu <wuzongyu1@huawei.com>
>  F: drivers/compress/uadk/
>  F: doc/guides/compressdevs/uadk.rst
>  F: doc/guides/compressdevs/features/uadk.ini

