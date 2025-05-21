Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC94C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 08:50:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 794AD40E28;
	Wed, 21 May 2025 10:50:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9593940151
 for <dev@dpdk.org>; Wed, 21 May 2025 10:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747817401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRzyt9WYUL6VnLcYOon1cZg/Lo42YdqWwFDOJoupWx0=;
 b=UFqlE4A072tYZjFbZGOa4Dk0RV6FQDeXSrGU2qy3jBJpdFXc7O+PU4h1eLYLX/BtvHWsL3
 ZsjM7YH3vUokFUr0tcV+0B0UsZ9kLUGcJHQxYKJyN9HTHbYlWswMdLtrMyVHzFlLpwJKB7
 wWvz71KgmZsTzK1r7Qkl1db3PxDarAw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-IM-s8nPBN-q2S5tJH1Iu-A-1; Wed, 21 May 2025 04:49:59 -0400
X-MC-Unique: IM-s8nPBN-q2S5tJH1Iu-A-1
X-Mimecast-MFC-AGG-ID: IM-s8nPBN-q2S5tJH1Iu-A_1747817398
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30d6a0309f6so37694881fa.2
 for <dev@dpdk.org>; Wed, 21 May 2025 01:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747817398; x=1748422198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRzyt9WYUL6VnLcYOon1cZg/Lo42YdqWwFDOJoupWx0=;
 b=KCvinDvCWa0IG125YAf8i0A1eABB+WJ2pmz0q+zG9OO6CxxdMFY8ZpSX4PITa5jH3N
 CpuCUiE/bR4HuCsyLlCxwnPurCkNWhreOaIdBC5ASTTQHZf6s1EJjf/h9hJVdWem7KmL
 kapoKCY+sxVA1hJX+qDT5Pt7Fk3lTA/TUf9EAa7eKbovLOLT6P1D2xthyRMbNRTv1nO1
 1jZqqYmsassjrM9IHbkAgasZgXMd/TEaDrLhfz0GsMdNFmnmqzI9nLULL6e1ZJ6+hFlJ
 Qsm53mxGOM+tluxThHxDhUMQTMaomEDB9gt212QRRJnyXNxOsvIcwgxNgvma1DvPNSs7
 iPSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHfAScSPNilF8mMhAnPi2saj9zKCYur70BUB69mLu86LsNHVNZ6jLK7hJvtBIBYetjOzs=@dpdk.org
X-Gm-Message-State: AOJu0Yz07rFBEy2xcO2ytwpopqmJ63M7NTAIWFdKghV3WziCry2STrUQ
 8QZcYq9t2Cgp+j8qR27j9lsQqU5PUcgRXpYBs4e2lm0loxlpPqWdBW7Y94z367R3oa2IyE7bvr3
 nYNIdB9D8FJRUofpxE+X0PvL4shrB5pkAyZ66nEe8iFHwxh8edV7bjFcUHAP7vz0YF1Oqihq0xI
 /iY4BeDrmwr6DcE64LKJk=
X-Gm-Gg: ASbGnctNFthUg8A9S1Kn9q2M2PZOZ4gwQrkoyIT0MUy+jPSORAY2HynNsAKKYMfIqKp
 ptSW9PoWTQ1RETyn06EoSdanybIdRP4Tiw40JE80YIUgutJ1mwwT3WVWwbuU6kkLWyQbqI6U=
X-Received: by 2002:a2e:bcc1:0:b0:31f:8659:dc23 with SMTP id
 38308e7fff4ca-32809780216mr88783691fa.33.1747817398043; 
 Wed, 21 May 2025 01:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4Im9KUZxbT59+NbHFNHQF1Jq/6RtDtQVAQ6ppV/OW9apjnHFisl3hOp5nz0Ut/jGQnM4SRWUPGWtjbQDPvZ8=
X-Received: by 2002:a2e:bcc1:0:b0:31f:8659:dc23 with SMTP id
 38308e7fff4ca-32809780216mr88783041fa.33.1747817394880; Wed, 21 May 2025
 01:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
In-Reply-To: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 May 2025 10:49:43 +0200
X-Gm-Features: AX0GCFvZFuzuju5lTsSak-GNcr8rNdnyIbeY1ANud0mEK2qni-9VN-LlRBBi6VI
Message-ID: <CAJFAV8zTePNoQh+5MM3cO1nd6ZuBud=NCL1ik0GVS1oTDDOV2A@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: unregister alarm callback before free ptr
To: Rui Ferreira <rui.ferreira1@h-partners.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c28o1KmMNSMYhGcL-MXyG82TNZOm71IWo9pBmACTcBE_1747817398
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, May 20, 2025 at 5:08=E2=80=AFPM Rui Ferreira
<rui.ferreira1@h-partners.com> wrote:
>
> This was flagged by Address sanitizer as a use after free. The
> intr_handle ptr is shared between the main thread and the interrupt
> thread, and the interrupt thread can dereference the ptr after free
> is called when the main thread cleans up (from the alarm callback).
>
> The interrupt thread never terminates (eal_intr_thread_main) so
> use rte_intr_callback_unregister_sync during cleanup to
> ensure the callback is removed before freeing the ptr.
>
> To be more defensive clear out the pointer and registration
> variable if we can unregister.
>
> Bugzilla ID: 1683
>
> Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>

I remember mentioning that other OS may be affected by the bug.
Please consider fixing this issue for Windows and FreeBSD too.


> ---
>  .mailmap                  | 1 +
>  lib/eal/linux/eal_alarm.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index d8439b79ce..907c5ea967 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1332,6 +1332,7 @@ Rosen Xu <rosen.xu@altera.com> <rosen.xu@intel.com>
>  Roy Franz <roy.franz@cavium.com>
>  Roy Pledge <roy.pledge@nxp.com>
>  Roy Shterman <roy.shterman@vastdata.com>
> +Rui Ferreira <rui.ferreira1@h-partners.com>
>  Ruifeng Wang <ruifeng.wang@arm.com>
>  Rushil Gupta <rushilg@google.com>
>  Ryan E Hall <ryan.e.hall@intel.com>
> diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
> index b216a007a3..eb6a21d4f0 100644
> --- a/lib/eal/linux/eal_alarm.c
> +++ b/lib/eal/linux/eal_alarm.c
> @@ -57,7 +57,14 @@ static void eal_alarm_callback(void *arg);
>  void
>  rte_eal_alarm_cleanup(void)
>  {
> -       rte_intr_instance_free(intr_handle);
> +       /* unregister callback using intr_handle in interrupt thread */
> +       int ret =3D rte_intr_callback_unregister_sync(intr_handle,
> +                                               eal_alarm_callback, (void=
 *)-1);
> +       if (ret >=3D 0) {
> +               rte_intr_instance_free(intr_handle);
> +               intr_handle =3D NULL;
> +               handler_registered =3D 0;
> +       }
>  }
>
>  int

In rte_eal_cleanup, the trace framework is uninitialised prior to
rte_eal_alarm_cleanup().

And the CI caught this issue (see ovsrobot report in patchwork).

ERROR: AddressSanitizer: heap-use-after-free on address 0x7f872ca90f80
at pc 0x7f873db9fb1e bp 0x7fffc98a3720 sp 0x7fffc98a3718
READ of size 4 at 0x7f872ca90f80 thread T0
    #0 0x7f873db9fb1d in __rte_trace_mem_get
/home/runner/work/dpdk/dpdk/build/../lib/eal/include/rte_trace_point.h:331:=
27
    #1 0x7f873db9fb1d in rte_eal_trace_intr_callback_unregister
/home/runner/work/dpdk/dpdk/build/../lib/eal/include/eal_trace_internal.h:5=
8:1
    #2 0x7f873db9fb1d in rte_intr_callback_unregister
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:685:2
    #3 0x7f873db9fe44 in rte_intr_callback_unregister_sync
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_interrupts.c:697:16
    #4 0x7f873db996ad in rte_eal_alarm_cleanup
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal_alarm.c:61:12
    #5 0x7f873db98b4f in rte_eal_cleanup
/home/runner/work/dpdk/dpdk/build/../lib/eal/linux/eal.c:1334:2
    #6 0x561c211092db in main
/home/runner/work/dpdk/dpdk/build/../app/test/test.c:263:2
    #7 0x7f873c429d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #8 0x7f873c429e3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #9 0x561c2104a534 in _start
(/home/runner/work/dpdk/dpdk/build/app/dpdk-test+0x1fc534) (BuildId:
37b8659fbf174b3d78222edbdcd9f2f6a3027aff)

Address 0x7f872ca90f80 is a wild pointer inside of access range of
size 0x000000000004.
SUMMARY: AddressSanitizer: heap-use-after-free
/home/runner/work/dpdk/dpdk/build/../lib/eal/include/rte_trace_point.h:331:=
27
in __rte_trace_mem_get
Shadow bytes around the buggy address:
  0x0ff16594a1a0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a1b0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a1c0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a1d0: fd fd fd fd fd fd fd fd 00 00 00 00 00 00 00 00
  0x0ff16594a1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x0ff16594a1f0:[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a200: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a210: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a220: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a230: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0ff16594a240: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D55106=3D=3DABORTING


--=20
David Marchand

