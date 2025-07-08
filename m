Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7DDC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 18:41:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E7D140649;
	Tue,  8 Jul 2025 20:41:07 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 74FBA40292
 for <dev@dpdk.org>; Tue,  8 Jul 2025 20:41:06 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d5d0ea6c8dso355583085a.1
 for <dev@dpdk.org>; Tue, 08 Jul 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752000065;
 x=1752604865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sazIGiEay+n7zVeZr3YI4RMEd6GLyjy6yWL0KzQLSC0=;
 b=Y0xlR95g+nk37JtTrvoe4ww0woTG66T6pSsXm3i9ibikhwjb6SXltY2Nkac618Y3Cg
 rMtMSitvCgzq4wxpo3c2lfZkzeU3hv1DpWQbD3ZHeznPPr+aNzgBAocBW+i7HNtU3nz7
 k6Gdc4zTpTj42d6ioMrfHRusGPug4kNT9BjwZH/gG/eNWqqVOjV/WOX97eaQfFxbxkK8
 bM6ZLZ4kzYIlyR6bF9jfzj5tK5IxS952E1CkH5qva3lTrnaetZoFGMAKS5kigSKZMbey
 AEW5fCwIxhn2yDWafVG3hd07MhC3uTNV0qQ1eYb4SRXbNZxpq8wDhDOjrOE8H3bMMYAP
 pyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752000065; x=1752604865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sazIGiEay+n7zVeZr3YI4RMEd6GLyjy6yWL0KzQLSC0=;
 b=tzLbhieJ/DCfU4g5p6MtwIACMBLv1h6TtkWWW9XjDNZUHTLNHfUHOqP4pCHQU2PchU
 QNd1NhsJsUJyiDsECE7+wC4uv/17fIaPfkYEPHkJFLzraTvzgRFSu7fW/GezNeu4mdyW
 Unbc45syFwRCskmzSlRkomuN5LwQ7Es596/81q2qO8y33WtkVGNI2QuuKuJd01J+bGCE
 ZA0nYWD9HOvbAwaVcIqnzFQxO13bYqVoo4oASBM7zbsEv0UMeUkQK0mS/k+smt28Lh6e
 KPcsFxlHXxQHwZSKDvPJVWzokU56s3pdnGWptA9kY3piAp9SwqnefERqGkm146PHUCmE
 lq0g==
X-Gm-Message-State: AOJu0Ywl5wNUqXKXcfyOwPpt0xfjKhcK7r2QlYkClwLdbQtMyA4x1DhX
 7QO+HPAIP0kiW0G5JXGPKNLsS+02eJEz2nd/LpO8eB+wGdGg5L89UM+0GHA8rLp7GlE=
X-Gm-Gg: ASbGncutbF/jJAI3U1FZCep+O8IpBMsbDs/Er0U3ceumLgnHx4GhzIvabQbdXkIvvxk
 JmStt0HzWEZGF1P+K1Gyt0elCCQarR1kO7doUxmd1zmliclyzwQhUXidQ0SiqWZpNUzaBWwoJQN
 jK7zu8S7+yHX9EH6t8gShLLwRk+tkZQu5BMxDiJ5uciRcRtx58LmE5FlbwfTRgd89ER2CYPR4mV
 SvjoYRaQ6wYcb1AQ4o74/xA2Sx+06syICjIRRSPr8Y3MI0YY9Ph23Vt6ftomPDCi+TI/kypTNGx
 Pffm5AZ/+46chUPjX56fh9tBW6xpnWLmyiaWD0B9WKZ6LeifGseXFCxNMLoZLNk5iTgfrQ/DgkU
 /k9KQ6HIuRtO/EvGJLzw09du4xLpMU4RWNf8BIPQ=
X-Google-Smtp-Source: AGHT+IFXde07V9kvE/tVNlWu5jIQl/4pmsOd49QekTje8OKsb+yDflpqSG2+FHc5LBM7BAG+Dal0Zw==
X-Received: by 2002:a05:620a:84c8:b0:7c5:9c12:fc8 with SMTP id
 af79cd13be357-7d5df17e3fdmr1973436885a.38.1752000065474; 
 Tue, 08 Jul 2025 11:41:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbdbd276sm811498585a.45.2025.07.08.11.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 11:41:05 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:41:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v2 0/5] rework EAL argument parsing in DPDK
Message-ID: <20250708114101.22db6a9b@hermes.local>
In-Reply-To: <20250708172039.183989-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue,  8 Jul 2025 17:20:34 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> This RFC is a second, more complete, prototype of one approach we may
> want to take to help improve management of EAL cmdline arguments.
> 
> BACKGROUND:
> - The first problem that led to this work was that of providing a
>   way for users to easily provide a set of CPU cores to DPDK where the
>   CPU ids are >= RTE_MAX_LCORE
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
>   will be later a --proc-type=secondary flag. We have all sorts of
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
> 2. keep them in the list of arguments, and ignore them (with warning) when
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
> 

Could DPDK use a better 3rd party library for arparse like:
  https://github.com/cofyc/argparse
that one is MIT license so free to reuse, etc.

The project does have a bad habit of reinventing existing more complete
existing libraries (for example RCU).
