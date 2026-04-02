Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F5CC6B01
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 04:00:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C10304028B;
	Thu,  2 Apr 2026 06:00:57 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1D8FB40275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 06:00:55 +0200 (CEST)
Received: from [192.168.50.151] (unknown [42.177.178.249])
 by APP-01 (Coremail) with SMTP id qwCowAA3o2726c1pMOTvCw--.56087S3;
 Thu, 02 Apr 2026 12:00:54 +0800 (CST)
Message-ID: <97f5d14c-9136-45e3-9451-bda8253c3cae@iscas.ac.cn>
Date: Thu, 2 Apr 2026 12:00:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/6] devtools: add multi-provider AI patch review
 script
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260401154218.160500-1-stephen@networkplumber.org>
 <20260401154218.160500-3-stephen@networkplumber.org>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260401154218.160500-3-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowAA3o2726c1pMOTvCw--.56087S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5X7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
 6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F
 4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
 Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4
 A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY
 0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
 CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tmh5UUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAcFAmnNveOtzQABsX
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

> +        sections = []
> +        for label, review in reviews:
> +            sections.append(f"<h2>{label}</h2>\n{review}")
> +        return "\n<hr>\n".join(sections)
> +    elif output_format == "markdown":
> +        sections = []
> +        for label, review in reviews:
> +            sections.append(f"## {label}\n\n{review}")
> +        return "\n\n---\n\n".join(sections)
> +    else:  # text
> +        sections = []
> +        for label, review in reviews:
> +            sections.append(f"=== {label} ===\n\n{review}")
> +        return "\n\n" + "=" * 60 + "\n\n".join(sections)
> +

return ("\n\n" + "=" * 60 + "\n\n").join(sections)

