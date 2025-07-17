Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EAC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 10:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E4AB4013F;
	Thu, 17 Jul 2025 12:42:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 87404400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 12:42:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752748924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPzMZr5ImusjUj9SZ5RXR8T2v0mPbCid5jPorS4M0VE=;
 b=egJW7rrdb798U8gjTmQjWOJofNpSo99JhnUZ28kxCqQ1cw3iopHGKRUDuV1mFFx9Nlcl9R
 xE9NSVc7Wdyy/rCdR0AwdNTyhHQzwjU8m8qgd1efguS8FyAXGm0XXO4M3nHOKMcjppSkW5
 RKIqNZNPUdKewcDinTjE3GGB89KYzZE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-mcK3Z0gaPeqVK7rCxXaoeQ-1; Thu, 17 Jul 2025 06:42:02 -0400
X-MC-Unique: mcK3Z0gaPeqVK7rCxXaoeQ-1
X-Mimecast-MFC-AGG-ID: mcK3Z0gaPeqVK7rCxXaoeQ_1752748921
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32b3ba8088fso3139901fa.1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 03:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748921; x=1753353721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPzMZr5ImusjUj9SZ5RXR8T2v0mPbCid5jPorS4M0VE=;
 b=Uzk+wNiMDGcsjgePafloMMZtbPTRrF2N1g2FOoDBj2Fvg9gMxiitlosyIR/M/Epc2p
 FMrysG6ldt79M5rnxDfehj65Aazm4jEeoQ9TlqGGF7e5ltbgk9Jz+rxcKjSa7oEHLy8G
 8GtpZl5cwU8Oi9kjY8o4eJwJ/iTl0Nj4xI6Pq5EdCV7jrvVyVbaPdwkU2OQZMLJMo79O
 vdAmFzpTmn75SNEod+ISaLHiG/FMzxBeWr/mwIUftw5rZnN2F9DbHT8JJ+nnDNfVkihE
 t2N9aXoLMI7DQwudA/yJYa/ok3sKVxwF2Xv0OhgApPYaBqOqiy6pHDB5qlXnZ2rNmxZ4
 lXVw==
X-Gm-Message-State: AOJu0YwQNcJ9KmwquxApZye0i8DgqgTWOqfurlouSvr9CfbMAHsDwauE
 6kikBtN4BLc1nicxm3oyolQbpPlhmowwJllPdwb1YQ81T3RZtPciNW4rc3iOsEY6PI8WO8hEsVD
 NRiCis7JW21Ntm5iy9QNGpr/oE0KumxyVNzx+CzhRF9HWoHYk3aVyQI1NlcWs7lNyS4PBo33134
 A8uFZiErZnegawUMuYO90=
X-Gm-Gg: ASbGnctFwwQ4l5WkwYkrIsRncfMK6CEX/ax7rTzaK6UIeTMLkwteClm9blwJCJRcRZ1
 fzehLjEG04gbKmB+d3jPqF1DR+Vrh2JTF+i5COnlUEeCxzNOSMl7CHugQK9jG6Np9VqnDURQjVT
 L5Gbijq/oVhccFAlkvrFap0/c=
X-Received: by 2002:a05:651c:40cc:b0:32b:784f:bca5 with SMTP id
 38308e7fff4ca-3308e56b445mr18421481fa.28.1752748921118; 
 Thu, 17 Jul 2025 03:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKoictJIjWYt/IpFX8H4yH5mqavKpd37NkBjG+pp7446RqYYkrbBE3E+DR6kDNnC48BkQHeFTCtfoyZNO7HRA=
X-Received: by 2002:a05:651c:40cc:b0:32b:784f:bca5 with SMTP id
 38308e7fff4ca-3308e56b445mr18421291fa.28.1752748920250; Thu, 17 Jul 2025
 03:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
In-Reply-To: <20250708172039.183989-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 17 Jul 2025 12:41:46 +0200
X-Gm-Features: Ac12FXwlRNTX5UtCGotkhtCGtiCpvAWIL3MxeHYfyLYmAF_Wh1BUNJloY9bCDJ0
Message-ID: <CAJFAV8yCJ85zN4cTtpnFngC96jzL49722mLawBh8ZjpUTWNsiw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rFQ5nlhu2clVe7Wy_BpCqZJ1VMOV5CQPogEyDEZBAFk_1752748921
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

On Tue, Jul 8, 2025 at 7:21=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> This RFC is a second, more complete, prototype of one approach we may
> want to take to help improve management of EAL cmdline arguments.
>
> BACKGROUND:
> - The first problem that led to this work was that of providing a
>   way for users to easily provide a set of CPU cores to DPDK where the
>   CPU ids are >=3D RTE_MAX_LCORE
> - There are a number of solutions which were discussed for this, most
>   of which involved automatically remapping CPU ids to lcore ids
>   starting at zero.
> - However, in discussion with David M. at the last DPDK Summit in
>   Prague, he pointed out the main difficulty with all these approaches
>   in that they don't work with multi-process, since we can't reuse lcore
>   id numbers in secondary process.
> - This in turn lead to a realisation that when processing cmdline
>   arguments in DPDK, we always do so with very little context. So, for
>   example, when processing the "-l" flag, we have no idea whether there
>   will be later a --proc-type=3Dsecondary flag. We have all sorts of
>   post-arg-processing checks in place to try and catch these scenarios.
>
> This patchset therefore tries to simplify the handling of argument
> processing, by explicitly doing an initial pass to collate all arguments
> into a structure. Thereafter, the actual arg parsing is done in a fixed
> order, meaning that e.g. when processing the --main-lcore flag, we have
> already processed the service core flags. We also can far quicker and
> easier check for conflicting options, since they can all be checked for
> NULL/non-NULL in the arg structure immediately after the struct has been
> populated.
>
> To do the initial argument gathering, this RFC uses the existing argparse
> library in DPDK. With recent changes, this now meets our needs for EAL
> argument parsing and allows us to not need to do direct getopt argument
> processing inside EAL at all.
>
> An additional benefit of this work, is that the argument parsing for EAL
> is much more centralised into common options. This reduces code a bit.
> However, what is missing here is proper handling for unsupported options
> across BSD and Windows. We can either take two approaches:
> 1. just ifdef them out so they don't appear in the argparse list on
>    unsupported platforms, giving errors when used.
> 2. keep them in the list of arguments, and ignore them (with warning) whe=
n
>    used on unsupported platforms.
> The advantage of #1 is that it is simple and correct, but the advantage
> of #2 is that is makes it easier to move scripts and commandline args
> between platforms - but at the cost of the arg list shown by help to be
> less accurate.

#2 makes sense if we intend to implement those Linux options in other
OS, but I don't see this coming (I would rather remove options in
general).
So I prefer something like #1.


About patch 1, please update doc/guides/linux_gsg/eal_args.include.rst
(this file needs some fixes as well, like the --log* options are not
documented, this is a separate topic).

About patch 2 where the options are declared, --socket-* options got
renamed as --numa-* recently.

In this same patch, I see little differences in option descriptions.
Those tweaks are easier to read, but some details are lost and not
covered in doc/guides/linux_gsg/eal_args.include.rst (resp.
linux_eal_parameters.rst for Linux only options).
For example, our doc does not describe --log-level=3Dhelp.

Patch 3 removed the rte_usage_hook_t stuff, this must be restored for
applications that rely on this.

I also see a difference in the cpu discovery logs that disappeared
after the series, I did not investigate why.
EAL: Detected CPU lcores: 16
EAL: Detected NUMA nodes: 1


The rest of the series looks like a good refactoring.
Thanks for the cleanup.


--=20
David Marchand

