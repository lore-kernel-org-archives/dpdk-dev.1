Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DE10F3DE2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 13:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15FC64021F;
	Sat, 28 Mar 2026 14:53:31 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id C3504400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 14:53:29 +0100 (CET)
Received: from [192.168.50.151] (unknown [42.177.178.249])
 by APP-05 (Coremail) with SMTP id zQCowAAHnA9X3cdpLB3CCw--.33217S3;
 Sat, 28 Mar 2026 21:53:27 +0800 (CST)
Message-ID: <2bd9229f-c57f-415f-9929-9e10864e312f@iscas.ac.cn>
Date: Sat, 28 Mar 2026 21:53:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] node: lookup with RISC-V vector extension
Content-Language: en-US
To: dev@dpdk.org
Cc: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowAAHnA9X3cdpLB3CCw--.33217S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYY7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gc
 CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
 r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87
 Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij
 64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
 IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
 6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
 IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
 67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
 uYvjxU2-VyUUUUU
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwsAAmnHk86pSwAAsf
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

On 2/6/26 4:16 PM, Sun Yuechi wrote:

> Implement ip4_lookup_node_process_vec function for RISC-V architecture
> using RISC-V Vector Extension instruction set
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> ---
>   doc/guides/rel_notes/release_26_03.rst |   4 +
>   lib/eal/riscv/include/rte_vect.h       |   2 +-
>   lib/node/ip4_lookup.c                  |   5 +-
>   lib/node/ip4_lookup_rvv.h              | 167 +++++++++++++++++++++++++
>   4 files changed, 176 insertions(+), 2 deletions(-)
>   create mode 100644 lib/node/ip4_lookup_rvv.h

ping

