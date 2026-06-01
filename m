Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391CDCD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 22:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D8B402C4;
	Tue,  2 Jun 2026 00:23:24 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 911A440150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 00:23:23 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-137dd4cc208so1141534c88.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780352602;
 x=1780957402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9Nnakl1eS7MLw2zw1Mv4qyTB9a7mQJmfXm232GywvA=;
 b=XZPSeQJe8SIvAbIuKdOwdtPAI3lCu5RWu4rJKpUszjtdMUh0JcvBigxCoe4947xapL
 T0AYaYB8Xv3OJRyRMWCxEDOmkZu4kvhLZAnuNIFV7GYvlMxwoPiQ22h+XPkvTsxaODkn
 xwJKTG+ZHccSCL2EUTgMZ7W5G7/q1r0hiqIVR8ovOe1Gn0GujrDjSq3sO6Eg3R1j/vZ5
 8HDoXJ5LRd6wwHOZsKKh+mg6CCc9DCKoqFSpTn86ovZi1LyKX/Ul6Tu/AUG2yH2wj5yT
 7hl3lTZwE9D5nNowa6ddL+KdUJJ8Rxxc8tbfYhpYA0x4lOV7HtIZymmfvrTVkXqTVKop
 2NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780352602; x=1780957402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g9Nnakl1eS7MLw2zw1Mv4qyTB9a7mQJmfXm232GywvA=;
 b=CN2GbVCxs97NNi5qDBHXXXTpqnq0pIzbEM8Pu+tgxIcAlfF6NCPiLtu1Gv8L9jdAWF
 kFgALG3dgegHgtWffTaEo4CBVLP3Tj2CeLz6AtgH4n0jMyem0HPdYdBFKw8iDzITrqBg
 AjsoNUkxCiiPl4ahJ7/AWQemvO1mIoBEqzCMW2tkcya0H5yZgYC7uDw8ujKGRH+YwYhP
 9HD17AdoE7v7utD8+etDi6VpMwXp6irwsvvWocYc6ORPi8G8joYDkLIGVHqQzQQjiNNv
 F6dOcHlfTgg/BsVnyMFQEYZ5Xk4xxRJLOt/W39WZVm5LOOC7YNEqJR9Mayifywdd/C93
 R/Hg==
X-Gm-Message-State: AOJu0YwbK0IzfK1bnkw3++EMVvgFONY2p+owxbJPo4YI1CL5mDewROkl
 6TQBdu0yuiZ4yU+tRsxyUVhL1If9Zv80HpxVmE/iCVvdWXpo5eIgzKc+78is6b9npjo=
X-Gm-Gg: Acq92OFz9DVc8RUK/teOXtCAuJPWXjx6110aGufgfQZXLpP2eLoA32fHnllegR6x3yJ
 Vk3JWn936riZglrH9qPrIWRpYsk6GYrjEKlasGX1ph3839QcsNGNWfjiCXn8WOPVW68T5fIkAhJ
 +3KfgXTlIlo/sFo+f6nm7hWyfg37BiuKhgo/5Pdlmmfjh5JXSNtKeoB0lbOg019gEGQ93cnFykk
 rlSjeVk6gFWXgcXgMFkSGsMkUhoo9LmQpsUq945lQEzKtCN3sx8wr6aQ2snWUjasApZ0pOVatBy
 210QQarJ15UukqIfLGUo0Vf7LbKD9CLlnH/Cm6MHdE7MUAOuxlpMzTP4/7ojRJX1apFQBEEKYpA
 s0yJIl7e9DqJoqSFvy9CJwT2E0J3AgNVAgdZ2BspmzmvY1W7614ulDOmaQDO+BDJClSXgGJuNxT
 x6PisdlGi+TGydnwGFeCNpbwBQUj6jmt05YofRzty7fZdb8rge7hlZI4RJ2Bwu+/37ZOxb2t0Bp
 I4HBFDy/yRQMg==
X-Received: by 2002:a05:7022:393:b0:130:5606:94d with SMTP id
 a92af1059eb24-137edff950fmr510034c88.0.1780352602245; 
 Mon, 01 Jun 2026 15:23:22 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm8246135c88.11.2026.06.01.15.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 15:23:22 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:23:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] ring: avoid extra store at move head
Message-ID: <20260601152313.1946d438@phoenix.local>
In-Reply-To: <20260601181509.71007-1-konstantin.ananyev@huawei.com>
References: <20260601181509.71007-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 1 Jun 2026 19:15:09 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> C11 __rte_ring_headtail_move_head_mt() uses output
> parameter: 'uint32_t *old_head' directly within CAS operation.
> In x86_64 that cause gcc to generate extra instructions to
> store return value of CAS (eax) within 'old_head' memory location,
> even when CAS was not successful and another attempt should be
> performed. In some cases, even extra branch can be observed.
> To be more specific the code like that is generated:
> // start of 'do { } while();' loop
> .L2
>         ...
>         lock cmpxchgl   %r8d, (%rdi)
>         jne     .L17  //
> .L1: // <---- successful completion of CAS, finish
>         movl    %edx, %eax
>         ret
> .L17: // <---- unsuccessful completion of CAS, repeat
>         movl    %eax, (%r9)
>         jmp     .L2
>=20
> In constrast, x86 specific version that uses
> __sync_bool_compare_and_swap() doesn't exibit such problem,
> as __sync_bool_compare_and_swap() doesn't update the 'old_head'
> with new value, and we have to re-read it explicitly on each iteration.
>=20
> Overcome that problem by using local variable 'head' inside the loop,
> and updaing '*old_head' value only at exit.
> With such change gcc manages to avoid extra store(/branch).
>=20
> Depends-on: series-38225 ("deprecate rte_atomicNN family")
>=20
> Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---

I used the standard ring perf tests and ran 10 times via:
! /bin/bash
if [ -z "$1" ]; then
	echo "Usage $0 version"
	exit 1
fi

VERSION=3D$1
for i in $(seq 1 10); do
     sudo DPDK_TEST=3Dring_perf_autotest \
        ./build/app/dpdk-test -l 2-5 -n 4 --no-pci --file-prefix=3Drun$i \
        > ~/DPDK/ring_perf_results/${VERSION}_run${i}.log 2>&1
    echo "${VERSION} run $i done"
done


Then had Claude compare results:

Key metric (two physical cores legacy MP/MC bulk n=3D128):
  main:        5.380 cycles/elem
  sync-bool:   5.377 cycles/elem  (-0.07%)
  avoid-store: 5.892 cycles/elem  (+9.52%)  =E2=86=90 regresses


Looking at the dissassembly of ring_enqueue_bulk:

The inner loop of main and sync-bool versions is:
mov    0x80(%rdi),%r11d            ; load d->head via displacement
mov    0x104(%rdi),%ebx             ; load s->tail
add    %ecx,%ebx
sub    %r11d,%ebx
cmp    %ebx,%r12d
jae    [exit]
lea    (%r8,%r11,1),%r13d           ; new_head =3D old_head + n
mov    %r11d,%eax                   ; expected =E2=86=92 eax
lock cmpxchg %r13d,0x80(%rdi)       ; =E2=86=90 displacement addressing
jne    [retry]                      ; =E2=86=90 direct jne, eax preserved

Using atomic_compare_exchange and your patch:
mov    0x38(%rdi),%r10d
mov    0x80(%rdi),%eax              ; load d->head directly into %eax
lea    0x80(%rdi),%rcx               ; =E2=86=90 MATERIALIZE &d->head into =
%rcx
lea    -0x1(%r8),%r12d
mov    0x104(%rdi),%r11d
add    %r10d,%r11d
sub    %eax,%r11d
cmp    %r11d,%r12d
jae    [exit]
lea    (%r8,%rax,1),%r13d           ; new_head
lock cmpxchg %r13d,(%rcx)           ; =E2=86=90 INDIRECT addressing via %rcx
mov    %eax,%ebx                    ; =E2=86=90 EXTRA: save post-CAS %eax t=
o %ebx
jne    [retry]

Bottom line: good idea but still fighting with Gcc optimizer here.

