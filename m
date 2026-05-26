Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A98CD5BCF
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 03:31:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CA7B402AC;
	Tue, 26 May 2026 05:31:03 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id AE57940279
 for <dev@dpdk.org>; Tue, 26 May 2026 05:31:01 +0200 (CEST)
Received: from [192.168.50.151] (unknown [119.114.152.168])
 by APP-03 (Coremail) with SMTP id rQCowABHZ97yExVq2+9jEg--.900S3;
 Tue, 26 May 2026 11:30:59 +0800 (CST)
Message-ID: <88299ee4-723d-4bbf-86ce-3f0023fbf82e@iscas.ac.cn>
Date: Tue, 26 May 2026 11:30:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal/riscv: implement prefetch using __builtin_prefetch
To: shiwei dang <1138222970gg@gmail.com>
Cc: dev@dpdk.org, stanislaw.kardach@gmail.com, stephen@networkplumber.org,
 david.marchand@redhat.com
References: <20260310133524.28087-1-1138222970gg@gmail.com>
 <cac6e40a-6efd-4097-9b7a-90c559279879@iscas.ac.cn>
 <CAF-WEyHKBEwYW_E6UvjKwEL7LQO4pfFS7qtv-3gjz1B7c5cNYQ@mail.gmail.com>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <CAF-WEyHKBEwYW_E6UvjKwEL7LQO4pfFS7qtv-3gjz1B7c5cNYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHZ97yExVq2+9jEg--.900S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYY7k0a2IF6F4UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
 6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
 0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
 80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI
 7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
 uYvjxU2_HUDUUUU
X-Originating-IP: [119.114.152.168]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAUTAmoU456wiAAAsj
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

On 3/29/26 12:38 AM, shiwei dang wrote:

> Hi ,
>
> Thanks for the review. I'll address both points (real name in 
> Signed-off-by and test results) together in v2 once I have access to 
> physical RISC-V hardware.
>
> Best regards, Dang Shiwei
>
>

Hi,

Gentle ping — any update on v2?

