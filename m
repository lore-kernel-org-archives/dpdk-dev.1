Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A5FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 07:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A46740270;
	Mon,  4 May 2026 09:05:08 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 3DD874026C
 for <dev@dpdk.org>; Mon,  4 May 2026 09:05:06 +0200 (CEST)
Received: from [192.168.50.151] (unknown [119.114.153.107])
 by APP-03 (Coremail) with SMTP id rQCowADX3cQfRfhposMGEA--.42490S3;
 Mon, 04 May 2026 15:05:04 +0800 (CST)
Message-ID: <94160881-2297-4cdd-b829-9666f03dc7f2@iscas.ac.cn>
Date: Mon, 4 May 2026 15:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] RISC-V vector extension support
To: dev@dpdk.org
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
 <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowADX3cQfRfhposMGEA--.42490S3
X-Coremail-Antispam: 1UD129KBjvdXoWrWFy3Kw4kAF45Jr4xtryrWFg_yoWxGrX_uw
 4xurZ7Z3yUXaykZFZ0kr45ArW3CFW7Gwn5Z3WFqrySvFs5GryUGF4ktr10yFsa9FW3KF1S
 yr1fJrySyFnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbrkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
 WUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
 Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
 WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
 YxBIdaVFxhVjvjDU0xZFpf9x07jY6wZUUUUU=
X-Originating-IP: [119.114.153.107]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgwRAmn4KagwngAAsn
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

On 3/31/26 11:10 AM, Sun Yuechi wrote:

> v4:
> - Removed duplicate macro definitions of RTE_LPM_LOOKUP_SUCCESS and
>    RTE_LPM_VALID_EXT_ENTRY_BITMASK
> - Split SIMD bitwidth change into separate patch
>
> Sun Yuechi (2):
>    eal/riscv: set default SIMD bitwidth to 128
>    node: lookup with RISC-V vector extension
>
>   doc/guides/rel_notes/release_26_03.rst |   4 +
>   lib/eal/riscv/include/rte_vect.h       |   2 +-
>   lib/node/ip4_lookup.c                  |   5 +-
>   lib/node/ip4_lookup_rvv.h              | 164 +++++++++++++++++++++++++
>   4 files changed, 173 insertions(+), 2 deletions(-)
>   create mode 100644 lib/node/ip4_lookup_rvv.h
ping

