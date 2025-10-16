Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC2CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 12:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41C2C411F3;
	Thu, 16 Oct 2025 14:43:19 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mails.dpdk.org (Postfix) with ESMTP id 84E0B40269;
 Thu, 16 Oct 2025 14:43:16 +0200 (CEST)
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxG9Jg6PBoPuQWAA--.47914S3;
 Thu, 16 Oct 2025 20:43:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxE+Re6PBonjHqAA--.59310S3;
 Thu, 16 Oct 2025 20:43:12 +0800 (CST)
Subject: Re: [PATCH v1] maintainers: update for LoongArch
To: zhoumin <zhoumin@loongson.cn>, Patrick Robb <probb@iol.unh.edu>
Cc: thomas@monjalon.net, dev@dpdk.org, ci@dpdk.org
References: <20251016090948.836029-1-zhoumin@loongson.cn>
 <CAJvnSUCqYoRQg29ovs+r7CQH=wnJQMMLusi_oJthvXA6oa4aEQ@mail.gmail.com>
 <fec69d04-4ba6-2378-61c9-15be790bb8e5@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c7f0e0cc-bd06-4474-2e7e-410c302b222e@loongson.cn>
Date: Thu, 16 Oct 2025 20:40:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fec69d04-4ba6-2378-61c9-15be790bb8e5@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+Re6PBonjHqAA--.59310S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur13uryDurWUKr1kKrWxGrX_yoW8XryUpF
 9xA3WqkryUKrsrArsFk34FgrnFyrZ3Crn7JFsIvr90kr98Jwn0q3W0vr4v93WUZa1rGF40
 vrn5J34jqF45ZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
 Ja73UjIFyTuYvjxU70PfDUUUU
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



On 2025/10/16 下午8:30, zhoumin wrote:
> Hi Patrick Robb,
> 
> Yes, Bibo will also be responsible for maintaining the LoongArch CI 
> testing going forward.
I will be responsible for maintaining the LoongArch CI also,
and best wishes and thanks for contribution for Min Zhou.

Regards
Bibo Mao
> 
> On Thu, Oct 16, 2025 at 7:32 PM, Patrick Robb wrote:
>> Hi Min Zhou,
>>
>> Will Bibi be responsible for maintaining the Loongarch CI testing 
>> going forward, or are you retaining that responsibility? Thanks.
>>
>> On Thu, Oct 16, 2025 at 5:46 AM Min Zhou <zhoumin@loongson.cn 
>> <mailto:zhoumin@loongson.cn>> wrote:
>>
>>     Update maintainers for LoongArch architecture.
>>
>>     Signed-off-by: Min Zhou <zhoumin@loongson.cn
>>     <mailto:zhoumin@loongson.cn>>
>>     Signed-off-by: Bibo Mao <maobibo@loongson.cn
>>     <mailto:maobibo@loongson.cn>>
>>     ---
>>      MAINTAINERS | 2 +-
>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>     diff --git a/MAINTAINERS b/MAINTAINERS
>>     index 1a2729be66..7abe482e7d 100644
>>     --- a/MAINTAINERS
>>     +++ b/MAINTAINERS
>>     @@ -320,7 +320,7 @@ F: examples/*/*_neon.*
>>      F: examples/common/neon/
>>
>>      LoongArch
>>     -M: Min Zhou <zhoumin@loongson.cn <mailto:zhoumin@loongson.cn>>
>>     +M: Bibo Mao <maobibo@loongson.cn <mailto:maobibo@loongson.cn>>
>>      F: config/loongarch/
>>      F: doc/guides/linux_gsg/cross_build_dpdk_for_loongarch.rst
>>      F: lib/eal/loongarch/
>>     -- 
>>     2.27.0
>>

