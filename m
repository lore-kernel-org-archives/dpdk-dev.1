Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD61C9832A
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 17:02:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89777402A4;
	Sat, 26 Sep 2026 19:02:55 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id BDA874028B
 for <dev@dpdk.org>; Sat, 26 Sep 2026 19:02:53 +0200 (CEST)
Received: from ar (unknown [42.86.133.105])
 by APP-05 (Coremail) with SMTP id zQCowADXRD+7+rdqeeBhCQ--.19575S2;
 Sun, 27 Sep 2026 01:02:51 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dangshiwei <1138222970gg@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/3] eal/riscv: add RISC-V specific I/O device memory
 operations
Date: Sat, 26 Sep 2026 10:02:51 -0700
Message-ID: <20260926170251.1260026-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260328185457.960-1-1138222970gg@gmail.com>
References: <20260328185457.960-1-1138222970gg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXRD+7+rdqeeBhCQ--.19575S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5C7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAa
 Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
 A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8pnQUUUUUU==
X-Originating-IP: [42.86.133.105]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAMCAmq30-I1ZQAAsj
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

Hi Shiwei,

Ordering is guaranteed by the fence either way, asm or C makes no difference.

For the generated code, the compiler cannot see through inline asm, so
the 8/16/32-bit reads end up with an extra extension instruction
(tested with gcc 16 and clang 22).

> lbu/lhu/lwu/ld for reads (zero-extending to avoid sign-bit pollution)

The compiler picks the right one from the context, there is no pollution.

Overall I don't see a real benefit here and would rather keep the
generic implementation. What do you think?

