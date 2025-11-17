Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ACCEBF96
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 04:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1F0A402AA;
	Mon, 17 Nov 2025 05:47:38 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7C459402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 05:47:36 +0100 (CET)
Received: from [192.168.50.193] (unknown [42.177.188.84])
 by APP-01 (Coremail) with SMTP id qwCowAC3UNDmqBppfe0CAQ--.15757S3;
 Mon, 17 Nov 2025 12:47:35 +0800 (CST)
Message-ID: <ecdd30ff-99b9-4591-9fe5-d75933d039f0@iscas.ac.cn>
Date: Mon, 17 Nov 2025 12:47:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] riscv: implement accelerated crc using zbc
To: Stanislaw Kardach <stanislaw.kardach@gmail.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>, Liang Ma
 <liangma@liangbit.com>, Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>
References: <20240712154645.80622-1-daniel.gregory@bytedance.com>
 <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <20240917142600.GA474015@ste-uk-lab-gw>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20240917142600.GA474015@ste-uk-lab-gw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3UNDmqBppfe0CAQ--.15757S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYO7k0a2IF6w1UM7kC6x804xWl14x267AK
 xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
 0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
 80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI
 7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU8489tUUUUU==
X-Originating-IP: [42.177.188.84]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAUJAmkagzqHswAAs8
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

On 9/17/24 10:26 PM, Daniel Gregory wrote:

> Would it be possible to get a review on this patchset? I would be happy
> to hear any feedback on the approach to RISC-V extension detection or
> how I have implemented the hardware-optimised CRCs.
>
Hi，

Just wanted to follow up on this patch. Are you still interested in moving
it forward?

If so, could you please address the remaining comments([Patch 1/5] ...) 
and resolve the merge conflicts?

