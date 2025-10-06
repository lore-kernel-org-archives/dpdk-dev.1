Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A43FCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 10:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 421DE402DD;
	Mon,  6 Oct 2025 12:27:46 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id A02A9402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 12:27:44 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-71d60504788so48185187b3.2
 for <dev@dpdk.org>; Mon, 06 Oct 2025 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759746464; x=1760351264; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zfx1mG8/mEo30VFZ1B7gD37AR8xvwLPFU4ClBlq5PNs=;
 b=MZ2b8zu3rDRH9YLglXcp0q9jnFtOCJCfLALzpwpp6L4pkUboMVKRj18USujwX7nJhI
 kIn5Rrd5iqDFAuXhJsyozW8uAPPNjVHvwpPsQdApJS58+lwuqgRB/QUemjfK9xcNkXs/
 o6De9HSmew4lam2Lgx5WH4Ppo0ZCZqxztMMkB7qnLHEVPZZYa/lbieD/NHdqN/MrsbBk
 c1D3RURLMzmNIL7BcpLQq4NQkSWmNvXuP+PfSuQiYZYbHQoKFjwrfPw5DbWVOzv4vAPn
 CdwVg0nTZuZVxMtj8aSMX/+D82cfyy/kMo6OxZ2Otmr0OuMWCSK0dghctCEwHqHz2WTq
 hfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759746464; x=1760351264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zfx1mG8/mEo30VFZ1B7gD37AR8xvwLPFU4ClBlq5PNs=;
 b=SjgfX1t7bqWtHJ2SiJ69LnLjHsB1Enc2G5Dn6B9mLIxTinGZgDa0AbcPnOy2/VSf2l
 bTOQ+Dkh57gDeO0q74ubUR3wQKIsJSVEzY11Lz3koU44G88H88qGd/YOMUw9Hlzgxqbn
 a8Y0wqnpUTN39DGdAPJTVFLIMd/uab2FG47HBM/ala4zogcqyWG+tiAQyhJvemc/NRKt
 Qp9EJ3ZLEN8J+G6YXdM9PgjA+xhG3L7Qlkc6ETrVRfvyeqa8D7fQOcTZC0tDDgYWjYtP
 Z0U0C8vL2rTT0QFhhsaT5Qusp0SBz88EQ2SW2/9h13yj7YNC6Fauz8hK7V3N3OrCTzJL
 yYlQ==
X-Gm-Message-State: AOJu0Yzt5oDlRjva6DvltWq7x7UtmkFxQHhS8cUIDRQCkAExZ2sAohix
 rkS7Xqme8rp6u7ZZ5V5Fz/cKAhp0BJxkj4xiZ35mszknTkJTusDEcy6xbNv5yfjjSwYyaS6DRuh
 cZIc+dQi6OfbPQedr7cSokN2AnSqn1bA=
X-Gm-Gg: ASbGncvrIPRYLVUVZXPf8Un8wm/RpS39Yl5aw++fj9Oex3aTqr6mzlwlY7GHSWXaAOy
 xpf4leDuM+ypg8FB+MMScP/jBuld1YzNMldD+fW4i+UlMNF8RfOcK8/mMF+j5ncvhzJQ7gmOS91
 ksGcoYGIXDZ2dP8+n9y+4dBW2buaJCbSHqu1Vt5FTBEiugkPzXs5K3usj9DCo03UD/J9ZukcBbH
 GwLOyJu4Yy+JoEphTPV4RX4ixR6GfWt5pLbNgMDriLOOGPwnmIQsKrCcjreIqrtIA==
X-Google-Smtp-Source: AGHT+IGAsiIy9FwAZIRyReK9EzqtinGAHmFqA5qPgLQEY/wSLMVXYpai5WsvoL66+Dm4oLnbNdk0BovN6vMg8xu7vig=
X-Received: by 2002:a05:690c:691:b0:77f:937f:32be with SMTP id
 00721157ae682-77f94705f60mr245163527b3.41.1759746463723; Mon, 06 Oct 2025
 03:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8zLgkqEyifkG0t5f22pu+55PUXAKXdQXHHK7n2sxenTzg@mail.gmail.com>
In-Reply-To: <CAJFAV8zLgkqEyifkG0t5f22pu+55PUXAKXdQXHHK7n2sxenTzg@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 6 Oct 2025 11:27:31 +0100
X-Gm-Features: AS18NWCOWLhYdzuOnwEFqwxgPg4fR_Y1_v0Ev0zaeExodtRVG0Nz2Xu1w3vPpSU
Message-ID: <CAMw=ZnSVkkdF8_V54xWxDths7HyRcW_6Fu3kuiQ-tg2buScCeA@mail.gmail.com>
Subject: Re: Build failure in OBS with openSUSE 15.6
To: David Marchand <david.marchand@redhat.com>
Cc: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, 
 Kevin Traynor <ktraynor@redhat.com>, Aaron Conole <aconole@redhat.com>, 
 Patrick Robb <probb@iol.unh.edu>
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

On Mon, 6 Oct 2025 at 08:43, David Marchand <david.marchand@redhat.com> wrote:
>
> Hello Luca,
>
> We have a build failure in the openSUSE 15.6 job in OBS.
> https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/openSUSE_Leap_15.6/x86_64
>
> This failure is due to 4a04a346e7f3 ("vhost: simplify use of
> pragmas"), which followed dd7fdfff9bc1 ("build: remove support for GCC
> < 8 and clang < 7").
>
> The openSUSE 15.6 job still uses
> [   39s] C compiler for the host machine: cc (gcc 7.5.0 "cc (SUSE Linux) 7.5.0")
>
> Is it possible to update to a more recent gcc?
> Otherwise this test should be dropped.

Hi, that's what Leap 15 ships with, so I've disabled the job since
it's no longer supported.
BTW I believe you have an account? Thomas and Kevin are already listed
as maintainers so they can do these changes too, if you tell me your
username I can add you as well, it's just a click in the repositories
tab to enable/disable builds
