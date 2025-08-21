Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9CFCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 01:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A60E40292;
	Thu, 21 Aug 2025 03:25:30 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 075664026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 03:25:28 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c6lrb2g4Dzdcfb;
 Thu, 21 Aug 2025 09:21:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id A56681402DF;
 Thu, 21 Aug 2025 09:25:26 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 09:25:26 +0800
Message-ID: <191ae21c-a901-408b-989c-73f355c13eec@huawei.com>
Date: Thu, 21 Aug 2025 09:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V5 01/18] doc: add some basic files to describe the hinic3
 driver.
To: Feifei Wang <wff_light@vip.163.com>, <dev@dpdk.org>
CC: Yi Chen <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>, Xin
 Wang <wangxin679@h-partners.com>, Stephen Hemminger
 <stephen@networkplumber.org>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
 <20250702020953.599-2-wff_light@vip.163.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250702020953.599-2-wff_light@vip.163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

On 7/2/2025 10:09 AM, Feifei Wang wrote:
> From: Yi Chen <chenyi221@huawei.com>
> 
> 
> This patch adds some basic files to describe the hinic3 driver.

The subject suggest: doc: add hinic3 driver

Commit log: This patch adds document for hinic3 driver.

> 
> 
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> 
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> 
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>
> 
> ---

...

> 
> 
> +Huawei hinic3
> 
> +M: Feifei Wang <wangfeifei40@huawei.com>
> 
> +F: drivers/net/hinic3/

There are no drivers/hinic3/ files included in this commit.

> 
> +F: doc/guides/nics/hinic3.rst
> 
> +F: doc/guides/nics/features/hinic3.ini

The hinic3.ini was also not included in this commit.

> 
> +
> 
>  Intel Network Common Code
> 
>  M: Bruce Richardson <bruce.richardson@intel.com>
> 
>  T: git://dpdk.org/next/dpdk-next-net-intel
> 
> diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
> 
> new file mode 100644
> 
> index 0000000000..c9e49a2be2
> 
> --- /dev/null
> 
> +++ b/doc/guides/nics/hinic3.rst
> 
> @@ -0,0 +1,51 @@
> 
> +..  SPDX-License-Identifier: BSD-3-Clause
> 
> +    Copyright(c) 2025 Huawei Technologies Co., Ltd
> 
> +
> 
> +HINIC Poll Mode Driver

HINIC -> HINIC3


