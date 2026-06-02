Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B4BCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 05:28:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0B1A402D7;
	Tue,  2 Jun 2026 07:28:33 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id F3BEB40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 07:28:31 +0200 (CEST)
Received: from [192.168.50.151] (unknown [119.114.152.168])
 by APP-05 (Coremail) with SMTP id zQCowAC3Etb3aR5qk_8eEg--.12396S3;
 Tue, 02 Jun 2026 13:28:24 +0800 (CST)
Message-ID: <99a0008b-c1e2-4646-857c-9eb8fadefde9@iscas.ac.cn>
Date: Tue, 2 Jun 2026 13:28:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal/riscv: add Z sub-extension detection via hwprobe
 syscall
To: Thomas Monjalon <thomas@monjalon.net>, dangshiwei <1138222970gg@gmail.com>
Cc: dev@dpdk.org, stanislaw.kardach@gmail.com
References: <20260318144021.3308-1-1138222970gg@gmail.com>
 <20260323041714.4386-1-1138222970gg@gmail.com>
 <sNysWPxOScOg-GwsJvuWUQ@monjalon.net>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <sNysWPxOScOg-GwsJvuWUQ@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowAC3Etb3aR5qk_8eEg--.12396S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4xWw15Jr4kKw4rJrW3trb_yoWxAFb_ur
 WkA3y7Aw40yFZ5uF48tr43A3Z293ykZ34akF48Wr9xuF95A34DWrZ3GryfWF13AFW8AFyI
 y343XrWftwnIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbrxYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
 cSsGvfC2KfnxnUUI43ZEXa7IU8Tmh5UUUUU==
X-Originating-IP: [119.114.152.168]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAYGAmoeW-sl8AAAsP
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

On 6/2/26 4:24 AM, Thomas Monjalon wrote:

> Hello,
>
> We are waiting for a review of this patch.
> The maintainer is Sun Yuechi.

This patch conflicts with 
https://inbox.dpdk.org/dev/20240618174133.33457-1-daniel.gregory@bytedance.com/

dangshiwei replied to the conflicting patch, but neither side has 
expressed any further opinion for over two months. I'm not sure whether 
the author is still paying attention to this patch.

A few days ago I pinged a small patch from the author, hoping to see 
whether the author will respond further in the near future:
https://inbox.dpdk.org/dev/88299ee4-723d-4bbf-86ce-3f0023fbf82e@iscas.ac.cn/

