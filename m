Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DEDCC6B00
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 04:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D7A4028B;
	Thu,  2 Apr 2026 06:08:20 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 799F140275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 06:08:18 +0200 (CEST)
Received: from [192.168.50.151] (unknown [42.177.178.249])
 by APP-01 (Coremail) with SMTP id qwCowACXPGiv681pkwnwCw--.10489S3;
 Thu, 02 Apr 2026 12:08:16 +0800 (CST)
Message-ID: <7c10b2b5-71e9-4ef7-be7e-02da5bda7aaf@iscas.ac.cn>
Date: Thu, 2 Apr 2026 12:08:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update RISC-V maintainer
To: Stanislaw Kardach <stanislaw.kardach@gmail.com>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20260401192401.6243-1-stanislaw.kardach@gmail.com>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260401192401.6243-1-stanislaw.kardach@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXPGiv681pkwnwCw--.10489S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF45Ar4xWr15GF1fCw47XFb_yoWfWFX_Ga
 1kWF92ga9ruFs8Jwn0qF9ayr4Yqr4fGr1ftan2qrZxAa4DGrna9r1ktw18C3W3ArZ7KF10
 yrn3uayakwnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbrxYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
 cSsGvfC2KfnxnUUI43ZEXa7IU8mhF7UUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRAFAmnNvduy0QABs+
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

On 4/2/26 3:24 AM, Stanislaw Kardach wrote:

> Change the RISC-V maintainer to Sun Yuechi and remove myself as
> I'm unable to properly perform maintainer duties due to time
> constraints.
>
> Signed-off-by: Stanislaw Kardach <stanislaw.kardach@gmail.com>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f5539f851..eeb55951b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -334,11 +334,10 @@ F: examples/*/*_altivec.*
>   F: examples/common/altivec/
>   
>   RISC-V
> -M: Stanisław Kardach <stanislaw.kardach@gmail.com>
> +M: Sun Yuechi <sunyuechi@iscas.ac.cn>
>   F: config/riscv/
>   F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
>   F: lib/eal/riscv/
> -M: Sun Yuechi <sunyuechi@iscas.ac.cn>
>   F: lib/**/*rvv*
>   
>   Intel x86
Acked-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

