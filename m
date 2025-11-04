Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05023CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:15:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A55F40609;
	Tue,  4 Nov 2025 14:15:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ABD3F40609
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6eaTchBfs/eD0jEq5ecbgvOK4alnGi7Vaole0yWHxo=;
 b=i8YAW9tVz2KPMzvVzoUUo8m2s4ic7VARvZ317n7Z2YLFgBE5Mslvuuf0SsJhOJiGJSjexr
 xK+d86o9YUx5V5pJk8gwgP17WauWQoNP4BGwu5nCQuiE8kFG8mV29pQEqQV3UkVQHLPFDy
 uStT+WpHfN/V/LRcwoz46k1aHDeD1cM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-fiHkMbodPuSNLKzaC7AGGg-1; Tue, 04 Nov 2025 08:15:37 -0500
X-MC-Unique: fiHkMbodPuSNLKzaC7AGGg-1
X-Mimecast-MFC-AGG-ID: fiHkMbodPuSNLKzaC7AGGg_1762262135
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-594259bf71aso1831400e87.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 05:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762262135; x=1762866935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6eaTchBfs/eD0jEq5ecbgvOK4alnGi7Vaole0yWHxo=;
 b=xEAtMq5QO9NYAkYaEu6wnFgC7ZfIYlxSpP9eKKitivCW9nOSDPdN1wCmunJ5t6ma//
 qxnT6xfRAX5rXkBIErP4z/v0ucqBf2lUXfsHPZl9D12/bSqRai1fU9MdOpXU7RWPmvN+
 LpLAtgobEDH8NwNtk5Hqfj7hiQjOhtUlk2TeKbp3KoTvoTa57Xdy+vS47/s7Z4bycvQ5
 NwttbzdzgDT8Q50vyNZaF/MmUqKDw6Iy31IwcCYIJyW8Sy7oP6Q45GQySd+q9EnmB6mq
 9VHzKBx4UUrGTncL7XTEOE9SfvHNRN3kHWNRlr7KTu1a94dZQDTfdkVBt0rSzDHOlFCs
 TGEA==
X-Gm-Message-State: AOJu0YxlqCLbUqAzvriUsXEQa83mWECS9Xl/JLswLWSjj0KFidkASozt
 oa8C6cvusJHTtyXlwjmDJ+dZbvuwK+s3YNyy/gyDzL4OPXhfMtnqEZ5eimHr5fM3V+TCPb//svr
 yKH7+A3gX24w1V2acM4njkVf4WsKdq+oImUfUzVY6MHtuIbcu8n5XxvMTvrdTjllqrwc9am44zp
 MFP7MijRP6oLOPjLSL8HY=
X-Gm-Gg: ASbGncvFGsFK+C7glv8x9+Pd1zRsE4/PTNLrkoLmJIlH9jeUHx4ZBBklCso724DOohg
 U+XUBrXFNrhK4fNz+PZ+e2F263hvXqjqtFERfEybVR0Jn+sXtK7UnUjY/9kMoUhwPW7q4vKd2+W
 uwJ9GLEo8pTlZOEHyl8Gv0JABYDVr6kypiXfk53oE5IkmoUy1hD+aqB3mQsQ==
X-Received: by 2002:a05:6512:3993:b0:592:fce6:9054 with SMTP id
 2adb3069b0e04-5941d556275mr5379139e87.52.1762262135249; 
 Tue, 04 Nov 2025 05:15:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKkS/I8ILVlvRZprQ3918J+qYJSxC24rCx8atxzdJXPa0WFMFDJp0R/a9l2YwUSWIqOnvhnC5HF+64rW2cE9I=
X-Received: by 2002:a05:6512:3993:b0:592:fce6:9054 with SMTP id
 2adb3069b0e04-5941d556275mr5379132e87.52.1762262134800; Tue, 04 Nov 2025
 05:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20251028143952.4160487-1-david.marchand@redhat.com>
In-Reply-To: <20251028143952.4160487-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 14:15:23 +0100
X-Gm-Features: AWmQ_blLi5chROMqTuVp6AcbO1V3Q2tlolwHWaUJJk2Eep0pJhHFJj86HlFwJ5M
Message-ID: <CAJFAV8x3awicFYCt_KFFDsVY0EFafvrMky4oRa8KJfhZwEeUTg@mail.gmail.com>
Subject: Re: [PATCH] trace: fix build with clang 21
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, jerinj@marvell.com, stable@dpdk.org, 
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eln_4IOPPBnddbphU133rDOerfS-pPrTs6Wl85Id0fI_1762262135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 28 Oct 2025 at 15:40, David Marchand <david.marchand@redhat.com> wrote:
>
> This was caught with recent clang.
> The RTE_TRACE_POINT_ARGS() macro expects at least one parameter.
> As a (void) function does not require any special tweaking with
> __rte_unused, we can simply replace with a direct (void) token.
>
> Build dir: /export/dpdk-next-net-mrvl/build-clang-static
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
> note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0
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
Fixes: 856aef55de95 ("trace: fix undefined behavior in register")
> Cc: stable@dpdk.org
>
> Reported-by: Jerin Jacob <jerinj@marvell.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

