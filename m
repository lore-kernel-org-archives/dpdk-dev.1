Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C96CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 04:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45DD241143;
	Mon, 17 Nov 2025 05:19:53 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6103D402AA
 for <dev@dpdk.org>; Mon, 17 Nov 2025 05:19:51 +0100 (CET)
Received: from [192.168.50.193] (unknown [42.177.188.84])
 by APP-01 (Coremail) with SMTP id qwCowAA3z85mohpptXgCAQ--.28720S3;
 Mon, 17 Nov 2025 12:19:50 +0800 (CST)
Message-ID: <4615b675-6847-4f3b-925f-75df52be5bcc@iscas.ac.cn>
Date: Mon, 17 Nov 2025 12:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] eal/riscv: optimize rte_memcpy with vector and
 zicbop extensions
To: Qiguo Chen <chen.qiguo@zte.com.cn>, stanislaw.kardach@gmail.com,
 stephen@networkplumber.org
Cc: dev@dpdk.org, bruce.richardson@intel.com
References: <20251024054128.1569133-2-chen.qiguo@zte.com.cn>
 <20251024072734.1573077-1-chen.qiguo@zte.com.cn>
 <20251024072734.1573077-2-chen.qiguo@zte.com.cn>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20251024072734.1573077-2-chen.qiguo@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA3z85mohpptXgCAQ--.28720S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxtFy5WrW3CryxurW7Arb_yoW8uw1Upr
 ykKrWvvrW5Jrn3J3y8Jr1UCay5Wr1vqw4UGr92gFyUJanrJr1Sqr42qr4v9F4UJr4rA3s8
 Gr1jq3sxuF47XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8sID7UUUUU==
X-Originating-IP: [42.177.188.84]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAUJAmkagzp0WAADsn
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

 > > # detect extensions
 > > # Requires intrinsics available in GCC 14.1.0+ and Clang 18.1.0+
 > > if (riscv_extension_macros and
 > >     (cc.get_define('__riscv_zicbop', args: machine_args) != ''))
 > >   if ((cc.get_id() == 'gcc' and 
cc.version().version_compare('>=14.1.0'))
 > >       or (cc.get_id() == 'clang' and 
cc.version().version_compare('>=18.1.0')))
 > >       message('Compiling with the zicbop extension')
 > >       machine_args += ['-DRTE_RISCV_FEATURE_PREFETCH']
 > >   else
 > >     warning('Detected zicbop extension but cannot use because 
intrinsics are not available (present in GCC 14.1.0+ and Clang 18.1.0+)')
 > >   endif
 > > endif
 >
 > The implementation does not involve intrinsics

It looks like nothing has been changed here yet.

 > #if defined(RTE_RISCV_FEATURE_V) && 
!(defined(RTE_RISCV_FEATURE_PREFETCH))
 > #undef RTE_RISCV_FEATURE_V
 > #endif
 >
 > static __rte_always_inline void
 > _rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
 > {
 >     asm volatile (
 >         "prefetch.r 64(%1)\n"
 >         "prefetch.w 64(%0)\n"
 >         "prefetch.r 128(%1)\n"
 >         "prefetch.w 128(%0)\n"
 >         "prefetch.r 192(%1)\n"
 >         "prefetch.w 192(%0)\n"
 >         "prefetch.r 256(%1)\n"
 >         "prefetch.w 256(%0)\n"
 >         "prefetch.r 320(%1)\n"
 >         "prefetch.w 320(%0)\n"
 >         "prefetch.r 384(%1)\n"
 >         "prefetch.w 384(%0)\n"
 >         "prefetch.r 448(%1)\n"
 >         "prefetch.w 448(%0)\n"
 >         "prefetch.r 512(%1)\n"
 >         "li t6, 512\n"
 >         "3:\n"
 >         "li t5, 128;"
 >         "vsetvli zero, t5, e8, m8, ta, ma\n"

With the current compilation conditions, if zicbop isn’t supported, the 
v-optimization also won’t be compiled.
Have you tested the performance difference if you remove these 
prefetches and only use v?
Can we use a condition like this to support only v?

#if defined(RTE_RISCV_FEATURE_V)
    #if (defined(RTE_RISCV_FEATURE_PREFETCH))
         ...
    #endif
     ...
#endif

