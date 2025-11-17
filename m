Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0CCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 04:11:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11B6402C3;
	Mon, 17 Nov 2025 05:11:57 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 92F06402AA
 for <dev@dpdk.org>; Mon, 17 Nov 2025 05:11:55 +0100 (CET)
Received: from [192.168.50.193] (unknown [42.177.188.84])
 by APP-01 (Coremail) with SMTP id qwCowAB3C8uKoBpp0FMCAQ--.29393S3;
 Mon, 17 Nov 2025 12:11:54 +0800 (CST)
Message-ID: <8cf595fe-ab7a-4c76-aeb9-2f6e676fc2c7@iscas.ac.cn>
Date: Mon, 17 Nov 2025 12:11:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] eal/riscv: optimize rte_memcpy with vector and
 zicbop extensions
To: Stephen Hemminger <stephen@networkplumber.org>,
 Qiguo Chen <chen.qiguo@zte.com.cn>
Cc: stanislaw.kardach@gmail.com, dev@dpdk.org, bruce.richardson@intel.com
References: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
 <20251024054128.1569133-1-chen.qiguo@zte.com.cn>
 <20251024054128.1569133-2-chen.qiguo@zte.com.cn>
 <20251024092722.6c623afd@phoenix>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20251024092722.6c623afd@phoenix>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowAB3C8uKoBpp0FMCAQ--.29393S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYO7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAa
 Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
 A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY
 0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU8pnQUUUUUU==
X-Originating-IP: [42.177.188.84]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAcJAmkagzp0PQAAsD
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


>> This patch uses RISC-V vector instructions and zicbop prefetching to
>> optimize memory copies for 129~1600 byte ranges.
>>
>> Signed-off-by: Qiguo Chen <chen.qiguo@zte.com.cn>
>> ---
> Is there any possibility of build environment being newer than
> the run time? The Intel builds already have to deal with that problem.

Yes, it's best to use hwprobe for runtime detection, but the hwprobe 
detection for the zicbop extension hasn't been merged into the kernel yet.
I'd like to refer to how other projects handle RISC-V integration; 
disabling it by default at compile time should also be acceptable.

