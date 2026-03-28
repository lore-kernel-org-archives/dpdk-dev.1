Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C810F3DE2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 13:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 615154021F;
	Sat, 28 Mar 2026 14:43:37 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id B6745400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 14:43:35 +0100 (CET)
Received: from [192.168.50.151] (unknown [42.177.178.249])
 by APP-05 (Coremail) with SMTP id zQCowACnOg4D28dpMgLCCw--.32608S3;
 Sat, 28 Mar 2026 21:43:31 +0800 (CST)
Message-ID: <9bf3b19e-fcda-4930-991e-0e4e76da39ef@iscas.ac.cn>
Date: Sat, 28 Mar 2026 21:43:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal/riscv: add RISC-V specific I/O device memory
 operations
To: dangshiwei <1138222970gg@gmail.com>, dev@dpdk.org
Cc: stanislaw.kardach@gmail.com, thomas@monjalon.net
References: <20260313140836.3847-1-1138222970gg@gmail.com>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260313140836.3847-1-1138222970gg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnOg4D28dpMgLCCw--.32608S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45tr1UuF43tw1rKF1fCrg_yoWDXrb_Ar
 1kAFW5Zw45J3yDXrs8XF4rWFZ5Aw4jkr4UX3yIq3WI9a1SvrZxWFs8trZavFW5tw43Crsr
 C3Z3X3yj93Z5WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbrxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
 80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
 zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
 8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCa
 FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
 Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
 6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
 cSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAYAAmnHko6oCAAAsa
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

 > #ifdef RTE_ARCH_64
 >     /* lwu is RV64-only: zero-extends to avoid sign-bit pollution */
 >     asm volatile("lwu %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
 > #else
 >     /* on RV32, lw is full-width, no extension needed */
 >     asm volatile("lw %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
 > #endif

DPDK RISC-V does not support 32-bit.  config/riscv/meson.build:

if not dpdk_conf.get('RTE_ARCH_64')
   error('Only 64-bit compiles are supported for this platform type')

We can remove all the #ifdef RTE_ARCH_64.

 > ARM64 which is a strong-ordered architecture

I'm not familiar with ARM. it seems to be weakly-ordered?

"Armv8-A implements a weakly-ordered memory architecture." 
(https://developer.arm.com/documentation/102336/0100/Memory-ordering)

 > /* relaxed read */
 > /* relaxed write */
 > ..

Other architectures don't use this kind of annotation, so maybe RISC-V 
can drop it too.

And DPDK requires a real name in the Signed-off-by line.

