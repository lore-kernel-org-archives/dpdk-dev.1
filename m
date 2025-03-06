Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D587FC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 12:59:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E18704065F;
	Thu,  6 Mar 2025 13:59:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39B9D40430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 13:59:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741265989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17naMvb5OZT6nzEq3pORTYNCpR0AzfKHFtKuaPszbVY=;
 b=FoJnhgCGcJ7ZX4JAFDZz9j9Jj2PlHNeRv7saD2il6lZNVZJZdM3aPPXa0g46pqOftsOvMs
 LMQ7glLSVgh/PEPLcO5Opii02LajIXDwTjZFAv6P0qDBtEeCGR27LvT+VTvfqkYxuasG7w
 Y6TA/6HsqqfXBfsNqKn9GUCyjZnEqWU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-JYQ2gbI2Pzup5SZsGLucqw-1; Thu, 06 Mar 2025 07:59:48 -0500
X-MC-Unique: JYQ2gbI2Pzup5SZsGLucqw-1
X-Mimecast-MFC-AGG-ID: JYQ2gbI2Pzup5SZsGLucqw_1741265987
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-54958ff5ce5so427281e87.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 04:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741265987; x=1741870787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17naMvb5OZT6nzEq3pORTYNCpR0AzfKHFtKuaPszbVY=;
 b=YxlcK3WWF/Uc/HsXINWIGz0BYrNzlWaxSbsz0GdsV9cZJLSOE+5HP3lxLglVlbODra
 ICU/ounCXayBhl3iiKaYxp1xo19HxSkBM+LLN24sTnzypARauxIbknY4UoNVHINw9b8l
 p8hjS9Vt4MMkTsHqejM9HclVX+/lNg1ER5dVVJAgPfObWi0yS+49cqAyLW+QkvifXzSQ
 QYT9H2DfTJ0bogPb24CifI4nDeRRaAIh2xb6wmZ1a38FQLbiDnq35YXb5vPBDooMMj4X
 PwZsTzhjUUj0l7VYxTAExhM7ixumltBlzO2JnL/MZnDBYTsEnFE9U/iuP2gHzy1y0dKQ
 fabg==
X-Gm-Message-State: AOJu0YyfagHOeh1SzomkHMbQWgSCnw4IvxkcQ6089bbDgqvCn9TcxBW8
 ddlDZv2hjRBvpKG20+3plfu+MCHf4nUCa5naByWOF0sATYhJUSQWIgn8TuP58Fg3nCK7GrIc/2T
 CTvptzrI4noFolSbpUcr7XHygd68WIuf1EbvJlwYpEBnSzkKCflFPqjeCq39TeXUlrHtyJn3MIQ
 qUGxAwNUsu5SqD+jVGqCU3zPLwGw==
X-Gm-Gg: ASbGncsPt+1Im5zKlrKhVhnql79W6o7sIggr+uA88aptOQQhRGauMfWTZacOpntO9g4
 yzbLKg5iGnhMrr9CfkKujxXjZQdZHtCmXOUWcxM2sPvcdoOEwLsXjjmBE8/jD7bYglEiRLD26ne
 I=
X-Received: by 2002:a05:6512:2251:b0:549:57ae:ab38 with SMTP id
 2adb3069b0e04-5497d3830f2mr2733982e87.45.1741265986785; 
 Thu, 06 Mar 2025 04:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOc7G5dpRQztLb2mFRwbpkBXT80nl0OuCSvyBq4uLYwHx1KThlkO3ju4XI59zwZf64f5ckMK7stLdjTPBRP/o=
X-Received: by 2002:a05:6512:2251:b0:549:57ae:ab38 with SMTP id
 2adb3069b0e04-5497d3830f2mr2733964e87.45.1741265986321; Thu, 06 Mar 2025
 04:59:46 -0800 (PST)
MIME-Version: 1.0
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-4-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1739929198-28432-4-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 13:59:34 +0100
X-Gm-Features: AQ5f1JqmelwyAJuIWRPZat4N6lCTXBrmS_4is6EbqzVzdCviTVtYKp8fB10WGac
Message-ID: <CAJFAV8xtTE9nfCXLNm_4htFDSohs3=feCsNotDRxQU589rfxEA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] eal: update versioning macros
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SiwmNjtIzSvVq1-nEX0ilo-2Cqanr3A9FHKv4BZVoVg_1741265987
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

On Wed, Feb 19, 2025 at 2:40=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling with MSVC the error below shows up due to function
> versioning:
>
> ../lib/net/rte_net_crc.c(418): error C2061: syntax error:
>     identifier '__attribute__'
>
> MSVC allows alias function names to be exported, but the mechanism is
> different than the one used by gcc. It was considered to enhance the logi=
c
> in the existing version.map files but that file is also passed to other
> tools on Linux, making this challenging. A simpler approach is to have an
> optional version.map file to be used only when Microsoft's linker is to b=
e
> used. This optional map file is only necessary for libraries that have
> versioned code.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/eal/include/rte_function_versioning.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/include/=
rte_function_versioning.h
> index eb6dd2bc17..aa3165a659 100644
> --- a/lib/eal/include/rte_function_versioning.h
> +++ b/lib/eal/include/rte_function_versioning.h
> @@ -82,6 +82,13 @@
>   */
>  #define MAP_STATIC_SYMBOL(f, p)
>
> +/*
> + * MAP_STATIC_BASE_SYMBOL
> + * Has the same purpose as MAP_STATIC_SYMBOL, but takes a base function =
name
> + * instead of the whole function prototype. It is used to support MSVC.
> + */
> +#define MAP_STATIC_BASE_SYMBOL(b, p)
> +
>  #else
>  /*
>   * No symbol versioning in use
> @@ -90,7 +97,19 @@
>  #define VERSION_SYMBOL_EXPERIMENTAL(b, e)
>  #define __vsym
>  #define BIND_DEFAULT_SYMBOL(b, e, n)
> +
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define MAP_STATIC_SYMBOL(f, p)

I would prefer we trigger an explicit error when some code calling
MAP_STATIC_SYMBOL() is built with MSVC.


> +#define MAP_STATIC_BASE_SYMBOL(b, p) __pragma(comment(linker, "/alternat=
ename:" #b "=3D" #p))
> +/*
> + * version.map file should also be updated with "b=3Dp;", like
> + *     rte_net_crc_set_alg=3Drte_net_crc_set_alg_v26;
> + */
> +#else
>  #define MAP_STATIC_SYMBOL(f, p) f __attribute__((alias(RTE_STR(p))))
> +#define MAP_STATIC_BASE_SYMBOL(b, p)
> +#endif
> +

But in any case, I don't like as we end up with one macro for each linker.

I have been thinking about this topic, and I sent a RFC series, please
have a look.
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34798

I hope this type of approach will also make it possible to stop
converting from GNU linker type version.map commited in DPDK to
Windows linker format.


--=20
David Marchand

