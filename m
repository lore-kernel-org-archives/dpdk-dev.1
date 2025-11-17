Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51065CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 01:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30F28402B9;
	Mon, 17 Nov 2025 02:43:20 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0F248402AA
 for <dev@dpdk.org>; Mon, 17 Nov 2025 02:43:17 +0100 (CET)
Received: from [192.168.50.193] (unknown [42.177.188.84])
 by APP-01 (Coremail) with SMTP id qwCowABH3s2zfRpp09n_AA--.33145S3;
 Mon, 17 Nov 2025 09:43:15 +0800 (CST)
Message-ID: <92be97a5-f2da-44ed-8008-8c0a5aa68b9a@iscas.ac.cn>
Date: Mon, 17 Nov 2025 09:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] node: lookup with RISC-V vector extension
To: dev@dpdk.org
Cc: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
References: <20251116155001.2809998-1-sunyuechi@iscas.ac.cn>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20251116155001.2809998-1-sunyuechi@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowABH3s2zfRpp09n_AA--.33145S3
X-Coremail-Antispam: 1UD129KBjvdXoW5KF4kWF13WryDZw18GFW5Awb_yoWxWFXEqF
 1xur93Z34UWF1kuFZ8Cws0vrWrC3yrCw13J3WFqr1vqa1DK3yDXwsrtr13AFsxXrZrKF15
 t3W8ZryftFnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2kYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8mXdUUUUUU==
X-Originating-IP: [42.177.188.84]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCQ4JAmkZ6BblEQAAs2
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

> Implement ip4_lookup_node_process_vec function for RISC-V architecture
> using RISC-V Vector Extension instruction set
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> ---
>   lib/eal/riscv/include/rte_vect.h |   2 +-
>   lib/node/ip4_lookup.c            |   5 +-
>   lib/node/ip4_lookup_rvv.h        | 167 +++++++++++++++++++++++++++++++
>   3 files changed, 172 insertions(+), 2 deletions(-)
>   create mode 100644 lib/node/ip4_lookup_rvv.h
>
Testing on sg2044 with dpdk-l3fwd-graph shows approximately 30% throughput
improvement and roughly 50%-60% reduction in ip4_lookup

