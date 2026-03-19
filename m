Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECF31091912
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 20:18:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE508402B9;
	Thu, 19 Mar 2026 21:18:17 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 714F24013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 21:18:15 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-127380532eeso3586170c88.1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 13:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773951494; cv=none;
 d=google.com; s=arc-20240605;
 b=Ac32LtpITm1taIYzsNovVUm0ltV24NniaFsm0b7sXInDXsa4cZtjGgAmw52QMcowZO
 QAxK0+qcpkxQ+qgQqWj4Ke+ccwTZosfqc9LURoCzcIKLXX/N2pokKMF/2rR//5BvRhVl
 1qStXVihnUQFTbTB0ah50RUN6cSxKfhTdEDtpBMGYfFmowXS3Ip6cd74nf5Yg9I4D191
 ghvPRW3/uESZl96AcdhxjtJ6bHC1JL2xKF4TJ/t+U1UGRbN3MUK8gBPCZBv8sStV/ppI
 gFR8MbyK/34sxwb3brfmTX4BIL26DymIzg7aA1/kw2s1hT05O4Z6Ujf1rm3mSObFyKR5
 72gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Afx2R1i7iP8MH4b50smeliumL1Gut3KrWKoxecX4bDw=;
 fh=FrOm8Zxjtk8Vz9XPnZuRIL9rXk+dlmFQdkgQwGfBT9E=;
 b=ULwE8cFKYxnm0o0Wh5yacfqfuaWRpRgzsIS6wiqy4Qlk/2BsCC216vLP1dwPN9QHB/
 iOllUiFMNg5s1ObJ4qKM79/W4ySWm3Ypj71+dWh/SvxELWgnSqO6u4EZvgtGDjPpKNa7
 W1w2mEwZ5SS+mZjn/KNxSQ17Cx3bC7hZTc0N79NvcY/Ff4iuNYB9nmBYkIEZAsc26qm1
 v+N3Rq0nxtmksphQy+S0DuOeug/q1U0XLcU8PJOc35UPDN1+zXspwQpY+GcGxhAfhCPQ
 ZFqUxU8PiT8yg7Pg2U76gbSsU3haq41iRFPI3WQp/xbXaIelK8A2dHsUCAOad396QKtH
 Dl2Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773951494; x=1774556294; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Afx2R1i7iP8MH4b50smeliumL1Gut3KrWKoxecX4bDw=;
 b=jZiVc7ZkuFGXLgkHMMIdOHMF8ETUkrubRH+tDfu6DqnTD7xDHak6rOYxl2L4Hf0PRE
 y5F3rvUrIsIPHoY1OBedbFbUCygHF9YM01aUZjigIRtc/HkqyD0qLnfNBPAE8mze21E1
 PwlUTxGcdOOpNIV4uRyCEqXmoneKvGyd+FPe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773951494; x=1774556294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Afx2R1i7iP8MH4b50smeliumL1Gut3KrWKoxecX4bDw=;
 b=iAC70odFi/lO6t5OUP4Re1ZOb2Lzl96MRzRDetPpET86bnNy/qMI/yvFY92Y6O5vwv
 yfNut2WAcBUaAcRxsEs05/xbyXfDoYHYPwg00cPU6sRBcsJEUWyYEoWXOJ4t/fRYj0fp
 pKrluMzM0C2PYyIdMtgHDcD5m3YneHnG68MHMwk4YOxiU/CI7tXW24RuD5IJCol33Drs
 E2F74alqgNwhmnJ1MMWeGC0nKBPhbjdZcQzuDSJhNW9khFv6VJdZxVuMWMA95ROFanpI
 MU6Fp4iRsV5WPxw/nTlt9vNt9JPu4f1wsKwLxqu/tI7UQE4cWv3ahMVNpyhw0JjYfpZ1
 1cUg==
X-Gm-Message-State: AOJu0YwFe6fUrRlPzpw39/HhYXgX2+LgIeD9nu1knGD8UC+YknYFAWPj
 pjWtv6xdSca1P50uuZwAUnBLwkVVNY5uF72OmgVekxIiB+5meUBeVOoArPNeva2bU+xftgM58+Y
 XcxyGB2bhtJ1mnNOkhNCyYV2nD+708JVY599lvAOmuQ==
X-Gm-Gg: ATEYQzx2HJe4YgZ4GAew68NfdBQMs8N3nGOYzlqrKETqFi4a76DhDtDIH201r7QMf8F
 zSddYVy2SfXcDpMxvk/oLFZ5x041rbsa+kfSu9JnEexw1/HQyVU06DmMOhALkr5PKwDY3lFpYUG
 l48BpYirjISFvNYLIKuJnV1gNPsWmLMyUkVkvCc5T2FjUTBc5kPYBiQBXoDK5QhAPPEVDvs8nZ9
 y5rRJlTh86w3mkHG2XZViCj3PWpe+e3g64uOGvJf+NLu+fPdJXf7TfY7Vz50N/nJIqmCu3Uv/k7
 R8k9fIAZ0Ut7BtNCKtz3kQu2kKOJOvj6R749oOCURdeI0fdbdgf4OA==
X-Received: by 2002:a05:7022:61a7:b0:128:bc19:813d with SMTP id
 a92af1059eb24-12a726c14bamr236456c88.27.1773951494230; Thu, 19 Mar 2026
 13:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 19 Mar 2026 16:15:03 -0400
X-Gm-Features: AaiRm53EZupKgZKiP5jA1oivXvdOhVSuLKq6J9sG1T-6G9v5baa_CjMiPFQCkWc
Message-ID: <CAJvnSUCez8aFrFRaSuDxw20HaBB7+83zk6Uh+j7cU7AdpGn6GA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Get fast-test suite to run on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, david.marchand@redhat.com, 
 Matthew Labrecque <mlabrecque@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000a9add3064d664498"
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

--000000000000a9add3064d664498
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Bruce. We will apply the series and try a fast tests run on our
freebsd14 VM. And if all goes well provide a tested by tag and wait for
this to hit mainline so unit tests in CI can turn back on. :)

On Thu, Mar 19, 2026 at 1:13=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> Bugzilla ID: 761
>
> The standard "fast-tests" suite is used to sanity-check large parts
> of the DPDK codebase, but it failed to run successfully on FreeBSD,
> with large numbers of failures. This is a long-standing issue reported
> in Bugzilla back in 2021 (hence the 3-digit BZ ID)
>
> This set attempts to rectify this situation by allowing the suite
> to run without errors. Mostly it does this by disabling test suites
> that rely on features like multi-process which are unsupported on
> FreeBSD. It also fixes the test_debug suite which should run on
> BSD but was failing.
>
> After this set, a run on my FreeBSD system passes with zero failures
> and 22 tests reported as skipped.
>
> Bruce Richardson (7):
>   test/timer_secondary: skip test on FreeBSD
>   test/eal_flags: skip test on FreeBSD
>   test/pdump: skip test on FreeBSD
>   test/secondary_process: skip test on FreeBSD
>   test/external_memory: skip test on FreeBSD
>   test/interrupts: skip test on FreeBSD
>   test/debug: fix unit test on FreeBSD
>
>  app/test/process.h              | 11 ++++++++---
>  app/test/test_debug.c           |  6 +++---
>  app/test/test_eal_flags.c       | 26 +++++++++++++-------------
>  app/test/test_external_mem.c    |  4 ++--
>  app/test/test_interrupts.c      |  2 +-
>  app/test/test_mp_secondary.c    |  4 ++--
>  app/test/test_pdump.c           |  6 ++++++
>  app/test/test_timer_secondary.c |  4 ++--
>  8 files changed, 37 insertions(+), 26 deletions(-)
>
> --
> 2.51.0
>
>

--000000000000a9add3064d664498
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Bruce. We will apply the series=C2=A0and try a fast=
 tests run on our freebsd14 VM. And if all goes well provide a tested by ta=
g and wait for this to hit mainline so unit tests in CI can turn back on. :=
)</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Thu, Mar 19, 2026 at 1:13=E2=80=AFPM Bruce Richar=
dson &lt;<a href=3D"mailto:bruce.richardson@intel.com">bruce.richardson@int=
el.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Bugzilla ID: 761<br>
<br>
The standard &quot;fast-tests&quot; suite is used to sanity-check large par=
ts<br>
of the DPDK codebase, but it failed to run successfully on FreeBSD,<br>
with large numbers of failures. This is a long-standing issue reported<br>
in Bugzilla back in 2021 (hence the 3-digit BZ ID)<br>
<br>
This set attempts to rectify this situation by allowing the suite<br>
to run without errors. Mostly it does this by disabling test suites<br>
that rely on features like multi-process which are unsupported on<br>
FreeBSD. It also fixes the test_debug suite which should run on<br>
BSD but was failing.<br>
<br>
After this set, a run on my FreeBSD system passes with zero failures<br>
and 22 tests reported as skipped.<br>
<br>
Bruce Richardson (7):<br>
=C2=A0 test/timer_secondary: skip test on FreeBSD<br>
=C2=A0 test/eal_flags: skip test on FreeBSD<br>
=C2=A0 test/pdump: skip test on FreeBSD<br>
=C2=A0 test/secondary_process: skip test on FreeBSD<br>
=C2=A0 test/external_memory: skip test on FreeBSD<br>
=C2=A0 test/interrupts: skip test on FreeBSD<br>
=C2=A0 test/debug: fix unit test on FreeBSD<br>
<br>
=C2=A0app/test/process.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
11 ++++++++---<br>
=C2=A0app/test/test_debug.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 6 +++---<br>
=C2=A0app/test/test_eal_flags.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 26 ++++++++++++=
+-------------<br>
=C2=A0app/test/test_external_mem.c=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0app/test/test_interrupts.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0app/test/test_mp_secondary.c=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0app/test/test_pdump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 6 ++++++<br>
=C2=A0app/test/test_timer_secondary.c |=C2=A0 4 ++--<br>
=C2=A08 files changed, 37 insertions(+), 26 deletions(-)<br>
<br>
--<br>
2.51.0<br>
<br>
</blockquote></div>

--000000000000a9add3064d664498--
