Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11D1E8FDB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 05:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 289C7402A0;
	Mon, 29 Dec 2025 06:48:45 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 37C4A40267
 for <dev@dpdk.org>; Mon, 29 Dec 2025 06:48:43 +0100 (CET)
Received: from [192.168.50.151] (unknown [42.52.23.210])
 by APP-03 (Coremail) with SMTP id rQCowABHZt05FlJpmslqAg--.53668S3;
 Mon, 29 Dec 2025 13:48:41 +0800 (CST)
Message-ID: <e12c9054-a5a3-4b40-931c-b21c668e996f@iscas.ac.cn>
Date: Mon, 29 Dec 2025 13:48:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acl: add RISC-V vector extension implementation
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Cc: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <20251130200810.879556-1-sunyuechi@iscas.ac.cn>
 <fb1b6b08a8b54d998f37f098727a8581@huawei.com>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <fb1b6b08a8b54d998f37f098727a8581@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowABHZt05FlJpmslqAg--.53668S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYO7k0a2IF6F4UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
 6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
 0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
 80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI
 7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU8olk3UUUUU==
X-Originating-IP: [42.52.23.210]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRELAmlSD5YWHAABs4
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

> You probably need to update examples/l3fwd/l3fwd_acl.c too.
>
> Let's keep SCALAR as the last one, as default.
>   
Got it, fixed.
> +#include "acl_run_rvv.h"
> +
> +int
> +rte_acl_classify_rvv(const struct rte_acl_ctx *ctx, const uint8_t **data,
> +		      uint32_t *results, uint32_t num, uint32_t categories)
> +{
> +	if (likely(num >= 8))
> Why not use 'MAX_SEARCHES_RVV?' defined above?
I adapted this file from the NEON version but forgot to use it. Updated 
in v2.

