Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706BC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 11:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E00140144;
	Fri, 16 May 2025 13:29:26 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mails.dpdk.org (Postfix) with ESMTP id 7F1F6400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 13:29:23 +0200 (CEST)
Received: from loongson.cn (unknown [10.20.42.143])
 by gateway (Coremail) with SMTP id _____8Bx12mQISdonWTsAA--.55647S3;
 Fri, 16 May 2025 19:29:20 +0800 (CST)
Received: from [10.20.42.143] (unknown [10.20.42.143])
 by front1 (Coremail) with SMTP id qMiowMAxzxuJISdo8hXZAA--.43372S3;
 Fri, 16 May 2025 19:29:15 +0800 (CST)
Subject: Re: [PATCH v3] build: automatically report minimum meson version
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Patrick Robb <probb@iol.unh.edu>
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250515134647.932537-1-bruce.richardson@intel.com>
 <CAJFAV8ycKdFJgLBXr2RXcmUkHxftKywbrpOCvLtutRh6CMPujA@mail.gmail.com>
From: zhoumin <zhoumin@loongson.cn>
Message-ID: <a8bdadd1-57ac-b24f-8862-1d0166cab3be@loongson.cn>
Date: Fri, 16 May 2025 19:28:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJFAV8ycKdFJgLBXr2RXcmUkHxftKywbrpOCvLtutRh6CMPujA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxuJISdo8hXZAA--.43372S3
X-CM-SenderInfo: 52kr3ztlq6z05rqj20fqof0/1tbiAgEEAWgmdWgODQACsU
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFW5Zw47tr1DuFW8Kw18tFc_yoW8GF4Upa
 y5C3Z8tF4vqay8JFZruF18XF9YvasxW34Yqw15JrWDKr9xtF4UJrWSkayYgFWq9FyrXFsY
 9r45C3s5G3WDu3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUU
 U
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

Hello David Marchand,

On Fri, May 16, 2025 at 3:33 PM, David Marchand wrote:

> Hello Min Zhou,
>
> On Thu, May 15, 2025 at 3:47 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
>> Add a script to buildtools to report the minimum meson version given in
>> our meson.build file. Then use this script in two ways:
>>
>> 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
>>     version to set up the CI, rather than hard-coding it.
>> 2. in meson.build call the script to report the version. This serves as
>>     a sanity check to ensure that any changes to meson.build file do not
>>     break the script.
>>
>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
>>
>> ---
>> v3: update minimum meson to 0.57.2 (from 0.57.0) to fix CI errors
>> v2: rebase to latest main
> The LoongArch CI reported an error on this patch, but I can't find out
> the reason:
> https://mails.dpdk.org/archives/test-report/2025-May/877981.html
>
> This is probably related to the meson version in the build env, since
> this patch increases the minimum version to 0.57.2.
>
> Can you have a look please?
Sure. The reason for this error is related to the meson version in the 
build environment. I will update the version of meson and retest this 
patch.
>

