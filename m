Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E911CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 945C840430;
	Thu, 25 Jun 2026 15:59:59 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 79781402B0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:59:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gmL5L3t5RzHnGjV;
 Thu, 25 Jun 2026 21:59:18 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id E605140569;
 Thu, 25 Jun 2026 21:59:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 25 Jun 2026 15:59:52 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 25 Jun 2026 15:59:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v5 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Topic: [PATCH v5 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Index: AQHdBAMS8DBu9x4KNEKCz+aS9fVLkbZPPNmw
Date: Thu, 25 Jun 2026 13:59:52 +0000
Message-ID: <42ae97d2d2754ea69025a6f6cc6c057d@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
 <20260624175815.673064-8-stephen@networkplumber.org>
In-Reply-To: <20260624175815.673064-8-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Below is what gdb shows actually generated for instruction 15 of
test_ld_mbuf1_prog (with minimal changes and comments for readability). I
suggest adding this to the comments or (if we don't feel like keeping it
updated) the commit message, it helps analyzing the code a bit.

(Also, stack drawings in the file do not include the buffer we use here.)

     0: 0x92800069      mov     x9, #-4         // mov x9, <imm>
     1: 0x8b150129      add     x9, x9, x21     // add x9, src_reg
     2: 0xd280050a      mov     x10, #40        // mov x9, <&::data_len>
     3: 0x786a6a6a      ldrh    w10, [x19, x10]
     4: 0xcb09014a      sub     x10, x10, x9
     5: 0xd280008b      mov     x11, #4         // mov x11, <sz>
     6: 0xeb0b014f      subs    x15, x10, x11
     7: 0x5400010b      b.lt    +8              // b.lt slow
     8: 0xd280020a      mov     x10, #16        // mov x10, <&::data_off>
     9: 0x786a6a6a      ldrh    w10, [x19, x10]
    10: 0xd2800007      mov     x7, #0          // mov x7, <&::buf_addr>
    11: 0xf8676a67      ldr     x7, [x19, x7]
    12: 0x8b0a00e7      add     x7, x7, x10
    13: 0x8b0900e7      add     x7, x7, x9
    14: 0x1400000c      b       +12             // b load
                        slow:
    15: 0x91000121      add     x1, x9, #0      // mov x1, x9
    16: 0x91000260      add     x0, x19, #0     // mov x0, x19
    17: 0x52800082      mov     w2, #4          // mov w2, <sz>
    18: 0xd1002323      sub     x3, x25, #8     // sub x3, x25, <stack_ofs>
    19: 0xd2a04d49      mov     x9, #0x26a0000  // mov x9,
    20: 0xf29d3409      movk    x9, #0xe9a0     //   __rte_pktmbuf_read
    21: 0xd63f0120      blr     x9
    22: 0x91000007      add     x7, x0, #0      // mov x7, x0
    23: 0xb5000067      cbnz    x7, +3          // cbnz load
    24: 0xd2800007      mov     x7, #0x0
    25: 0x17ffff88      b       -120            // b epilogue
                        load:
    26: 0xb87f68e7      ldr     w7, [x7, xzr]
    27: 0xdac008e7      rev32   x7, x7

Opcode variations:
* Instruction 1 is omitted for BPF_ABS.
* Instruction 26 varies depending on sz.
* Instruction 27 varies or is omitted depending on sz.

Some benign nits:
* Instruction 6 should probably be `subs xzr, x10, x11`, a slight 1-bit err=
or in
  the existing code, though x15 is unused.
* Instructions 5 and 17 use different encoding for the same operation, woul=
d be
  nice to keep them consistent, though operand never exceeds INT32_MAX.
* Instruction 10 is redundant.

I see two problems:
* We never check that x9 is non-negative. We could either add one more chec=
k,
  or rearrange the code and use unsigned comparison at 7: (currently b.lt).
  (There was some discussion previously regarding the special meaning of
  negative BPF_ABS immediate, but I believe this is out of scope of this pa=
tch,
  here we should just fail on negative _effective_ offset regardless of opc=
ode.)
* Second argument of __rte_pktmbuf_read is `uint32_t off`, and we are tryin=
g to
  pass 64-bit offset in x1. We need a check that it does not exceed UINT32_=
MAX.

Otherwise looks good to me.

