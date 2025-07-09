Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB652C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 12:31:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A38DD402A9;
	Wed,  9 Jul 2025 14:31:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2BD794021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 14:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752064258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+00FWSXI23BIyeYjNqPzhZXHwYWDky9fmlDm5qHVOSM=;
 b=YpzCAg7QeaDxgZ+lX7eb2guZj+Ydp0IBTDw0QmlchWHNlkZEINJmw1OO2JSi16UGAoR9xq
 4aPECcAxat7fbYIpzSilaMwJz25aNfaWLt84gXfy6H/LaxMsfKYFg+XRyT1nogwH2xl4NH
 a0De35QRsdNb39ulhrVJ4bQJDRr4x3A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-mXGjsoC2Ng2zqP3bnKYt9w-1; Wed, 09 Jul 2025 08:30:57 -0400
X-MC-Unique: mXGjsoC2Ng2zqP3bnKYt9w-1
X-Mimecast-MFC-AGG-ID: mXGjsoC2Ng2zqP3bnKYt9w_1752064256
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-553addbf0beso4246567e87.2
 for <dev@dpdk.org>; Wed, 09 Jul 2025 05:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752064256; x=1752669056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+00FWSXI23BIyeYjNqPzhZXHwYWDky9fmlDm5qHVOSM=;
 b=OvrUDSuiU86Ejjb1DaEKolb21MPKyNbTjmDiCU2QJvcQZ/gOnk2Nvi4nYd5yMFebGG
 d4sXuvoZdxvhEfjUcxA1IiQh/Up0neORopoVqQQMqYBDT2oh26+R0QrE90gm/jGF1Xjq
 vJLAOGaqMn06PwTEGcXGhV5rKehLTN7Vxk4Z6+dt+QM9YtV/4A1BMurxL9ztJXYHhWZx
 ZPYh7vvOS6QzGuXAGTbe18Dzv0f5wBFw9Q7GSHQlBV1v0HZLTK3kRTgCOpz0P7t6kPCY
 Vl6e4QeN199OadHQQ7AeP2eKNAiNTyTLEPCt7cIP//LLGAfH0kyImR5aoruzpC5mUjLv
 Qjlg==
X-Gm-Message-State: AOJu0YzgK0TUvYfShxzmDVQwxLyo7L6pixuJQQG9FUmvofRZp5RfZ9CD
 E773hRy7oCywGOb2rd6k6a67pvx6Xg3F5yqKQSAX/1gMHqrTDPB4YRREFu7mavAOD6XY7+OY1dC
 N1wk7xwlSi78KCvkyQH98GGeQ1zg28/sGnFz6nZXzMLQnvssFhezu+GKQWfoWlxjOkKWMAw2/U2
 BDUam40eb2WYFM2Jp9jlQ=
X-Gm-Gg: ASbGnct7QW0vE9CIOE+QMfWOONaeBBHSMwdq6AwILnpxmTexd/7MKHegioL5MNGJGgJ
 6jQtuu7EjsASNmYh9BL8T98KZrEVZq5McdnND+87vtLNXkzx/SX7KJ3lNjdcLjfa8QgVMh5OONf
 Z8tM3uoQ==
X-Received: by 2002:a05:6512:a83:b0:553:3314:adcf with SMTP id
 2adb3069b0e04-558fa87d4dfmr798489e87.5.1752064254372; 
 Wed, 09 Jul 2025 05:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuytiBRxHby1XL0XiNHlIj0njno7p3KPNUlPYdRy74EF1m1MH4crB+yE504rQq290JT6vcR+baPjmm9VTMCcc=
X-Received: by 2002:a05:6512:a83:b0:553:3314:adcf with SMTP id
 2adb3069b0e04-558fa87d4dfmr798477e87.5.1752064253832; Wed, 09 Jul 2025
 05:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
In-Reply-To: <20250708172039.183989-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 9 Jul 2025 14:30:42 +0200
X-Gm-Features: Ac12FXwpOFl4Fcec6of8USF7KE0CXWnptSWuQFM1XjyAVPwZ6uD6i8bDnh2FhEs
Message-ID: <CAJFAV8wD3BRGYvNdZmnaNauw8qwOpqKn5GmMNEVcb4pema-vEg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: srd62YoFWKxHb1r-_jFTyB4aUkdmuh9umCDfHvQOUBk_1752064256
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

Hi Bruce,

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
>
> Bruce Richardson (5):
>   eal: add long options for each short option
>   eal: define the EAL parameters in argparse format
>   eal: gather EAL args before processing
>   eal: combine parameter validation checks
>   eal: simplify handling of conflicting cmdline options
>
>  lib/eal/common/eal_common_memory.c  |    3 +-
>  lib/eal/common/eal_common_options.c | 1236 ++++++++++++++-------------
>  lib/eal/common/eal_options.h        |  101 +--
>  lib/eal/common/eal_private.h        |   11 +
>  lib/eal/freebsd/eal.c               |  164 +---
>  lib/eal/linux/eal.c                 |  384 +--------
>  lib/eal/linux/eal_memory.c          |    2 +-
>  lib/eal/meson.build                 |    2 +-
>  lib/eal/windows/eal.c               |  113 +--
>  lib/meson.build                     |    1 +
>  10 files changed, 726 insertions(+), 1291 deletions(-)

Thanks for working on this topic.
I will review it soon, after v25.07.

ASan complains about this series, as some memory gets leaked, could
you have a look?


--=20
David Marchand

