Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB92ACCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 16:21:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C54A34028D;
	Tue, 28 Oct 2025 17:21:34 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id D5B8C4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:21:32 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4e896e91368so68736681cf.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761668492; x=1762273292; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTBk4asxGOd4cPI591G7MEBA5Mg1Wu2Mg6mXF9TsG2A=;
 b=EEhbrpJyaNeAPfPsFuaPWQedo2LsJv6Lw8m1lIz4ObnCB12oA+nuCGdfKE6rgjJAeD
 aML2Sur6bDyi7pYkA8rx642uaneFLxVsIMflZ6CcSCCS9RND77GteaAPksqR1w0abln+
 bXM4BQwGP6FAhOJQfPR3+wBO2UlJij8ai/ziz0wdvwTj0iD2t5ZfM08ToPvugLOYV6fa
 2Z/bCF45bWVGEkbgavjhz8QkE+yk7ZRjW8XVM7GysBDSrfEebqfN0odMKcWTg/KE8lRq
 S1f9iVXmH4EXnDtBJiXjkbWfsvYxEdrI4OVOaOVe/AZ/Dia4py3Y9g1DrqMPOxNFuFRB
 c0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761668492; x=1762273292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTBk4asxGOd4cPI591G7MEBA5Mg1Wu2Mg6mXF9TsG2A=;
 b=VptOStxH48x76cpe6rzibS6y6BCQ7i7e/pBaxKdVI4kHSqiuJN3aAp68cnnoXKZXWN
 Eph23Pf1LksjZenm+MxM+ShzT0VZmQlhZOV3JYe/pGhYo2eZGxJudYdbDijiA/aia0TY
 2kG1mKiYVIScY2iUy8C8mRlkUQwc2+m5bbBtFHft31QAQUCNZj8jzIz7PbMtRaXaRaYX
 MHXM0w7qqXjXgtSFl/GGj3F8oL6V1UHv+5kkYrLH4nw5wD1OrxGnY0oA8CTxw6AZJ1cD
 CMk4UxPO1dV2zZhgDEargIMTGMxIVTWvxSU3LCFg2eQthWtWhPO0YSrQHPWTP427mVxo
 8YIw==
X-Gm-Message-State: AOJu0YzCct7UVYWfA+QWZ8JO/r2tK325VKm3xq5aCjqGVyckdhRYqJvt
 b9KEu6UaDBxV7b1lFGJlHP16x6e6OHvKDqy1Nf5Edd9R0wyAUfRe+6zSep6RDb8eX+isBRyIOLW
 6iSXyvnwYh272ckUo6JJE5SJl+tBOA8I=
X-Gm-Gg: ASbGncsrUn2lMnCKNGvo+W65ElVC0jYrBrWKlCAfDAUfjTBgAF9FXRoR5YJvTbMYekm
 hPDQXosaF8FMDqU4RecqALsQ0kZMMjN/lesG1mrOSSayFYsApwJWr9uGXCkn45BUYHSdoJostez
 LNirOb1N71+X6Zz2kllaGcreYI9gzGPFOY+5n2gu3sNU350cbhJKoM3ig9ujCgZLXJbSkpSQJI+
 XavCMrsTHjJiy/ljKfWiUb0EJzmVIGLJvAB0Z6mK+IWRKPhyi0WYBq4cL0=
X-Google-Smtp-Source: AGHT+IHeDOPsHEVn0mMFNVNXVfxnrkCFi3BBF2nSdPg4le6aW/HWjDc/JmbIHR30LDJk1RjHRrgeE3BXYxUZvXlm5A4=
X-Received: by 2002:a05:622a:d02:b0:4ed:d32:fd46 with SMTP id
 d75a77b69052e-4ed0d32ff7bmr29237561cf.39.1761668492079; Tue, 28 Oct 2025
 09:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251028143952.4160487-1-david.marchand@redhat.com>
In-Reply-To: <20251028143952.4160487-1-david.marchand@redhat.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 28 Oct 2025 21:51:16 +0530
X-Gm-Features: AWmQ_bmGSJM697LNYHU4izIZlqAG38d1dZzLtDcIqxnOqwXGQ6JZujHS78CueJo
Message-ID: <CALBAE1NCaP7G5BzGpZWbNt-ZgZMRPor5+0dERNNWVyWnFsUW8w@mail.gmail.com>
Subject: Re: [PATCH] trace: fix build with clang 21
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, jerinj@marvell.com, stable@dpdk.org, 
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
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

On Tue, Oct 28, 2025 at 8:26=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> This was caught with recent clang.
> The RTE_TRACE_POINT_ARGS() macro expects at least one parameter.
> As a (void) function does not require any special tweaking with
> __rte_unused, we can simply replace with a direct (void) token.
>
> Build dir: /export/dpdk-next-net-mrvl/build-clang-static

This can be removed.

Add Fixes: if possible.
Acked-by: Jerin Jacob <jerinj@marvell.com>




> Project version: 25.11.0-rc1
> C compiler for the host machine: ccache clang (clang 21.1.4
>         "clang version 21.1.4")
>
> In file included from ../lib/eal/common/eal_common_trace_points.c:7:
> ../lib/eal/include/rte_eal_trace.h:23:2: error: attribute 'unused'
>         cannot be applied to a 'void' parameter
>         [-Werror,-Wignored-attributes]
>    23 |         RTE_TRACE_POINT_ARGS(void),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ../lib/eal/include/rte_trace_point_register.h:46:3: note: expanded
>         from macro 'RTE_TRACE_POINT_ARGS'
>    46 |         (RTE_TRACE_POINT_ARGS_(RTE_TRACE_POINT_ARGS_COUNT(0,
>         __VA_ARGS__), __VA_ARGS__))
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../lib/eal/include/rte_trace_point_register.h:44:30: note: expanded
>         from macro 'RTE_TRACE_POINT_ARGS_'
>    44 |         RTE_TRACE_POINT_ARGS_EXPAND(RTE_TRACE_POINT_ARGS_FUNC
>         (N))(__VA_ARGS__)
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
>         ~~~~~~~~~~~~~~~~~
> ../lib/eal/include/rte_trace_point_register.h:41:38: note: expanded
>         from macro 'RTE_TRACE_POINT_ARGS_FUNC'
>    41 | #define RTE_TRACE_POINT_ARGS_FUNC(a) RTE_TRACE_POINT_ARGS_ ## a
>       |                                      ^
> note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=3D=
0
>         to see all)
> ../lib/eal/include/rte_trace_point_register.h:42:42: note: expanded
>         from macro 'RTE_TRACE_POINT_ARGS_EXPAND'
>    42 | #define RTE_TRACE_POINT_ARGS_EXPAND(...) __VA_ARGS__
>       |                                          ^
> ../lib/eal/include/rte_trace_point_register.h:26:35: note: expanded
>         from macro 'RTE_TRACE_POINT_ARGS_1'
>    26 | #define RTE_TRACE_POINT_ARGS_1(a) __rte_unused a
>       |                                   ^~~~~~~~~~~~
> ../lib/eal/include/rte_common.h:248:37: note: expanded
>         from macro '__rte_unused'
>   248 | #define __rte_unused __attribute__((__unused__))
>       |                                     ^~~~~~~~~~
> 1 error generated.
>
> Cc: stable@dpdk.org
>
> Reported-by: Jerin Jacob <jerinj@marvell.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/test_trace.h           | 2 +-
>  lib/eal/include/rte_eal_trace.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/app/test/test_trace.h b/app/test/test_trace.h
> index 4ad44e2bea..123ec8290a 100644
> --- a/app/test/test_trace.h
> +++ b/app/test/test_trace.h
> @@ -13,5 +13,5 @@ RTE_TRACE_POINT(
>
>  RTE_TRACE_POINT_FP(
>         app_dpdk_test_fp,
> -       RTE_TRACE_POINT_ARGS(void),
> +       (void),
>  )
> diff --git a/lib/eal/include/rte_eal_trace.h b/lib/eal/include/rte_eal_tr=
ace.h
> index 9ad2112801..152474bf84 100644
> --- a/lib/eal/include/rte_eal_trace.h
> +++ b/lib/eal/include/rte_eal_trace.h
> @@ -20,7 +20,7 @@ extern "C" {
>  /* Generic */
>  RTE_TRACE_POINT(
>         rte_eal_trace_generic_void,
> -       RTE_TRACE_POINT_ARGS(void),
> +       (void),
>  )
>
>  RTE_TRACE_POINT(
> --
> 2.51.0
>
