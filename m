Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE42CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 15:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E984C402AC;
	Mon, 11 Aug 2025 17:36:19 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id D68FA400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 17:36:18 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3b78315ff04so3874157f8f.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754926578;
 x=1755531378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Dilm457MZb55SV4obLI0f3SaHBRhraDWPnisqbqGwKI=;
 b=c1mriimZOTCjFD3Da/B63j6e+mpPAss9QJ5DzrFflsfMo2ISjT15ztaZ3ewdJajPay
 eTD9Is4UO/HXtZy+PSJvPC3rAAGEq58DUWDBBxRhD454UKsDrnf2gErjlR+9EbXNdNj8
 uossLFYTZ9q5SHizgM2w+XJng6zYTFRkfxowWT5EqApiMekFPWE7FfSKOnH3RTsFRgsx
 SQxs8BQ4h2IYNcnwxdRd4RLpJEKiVXjPBgobDKN6SfWFIWhI+N+FGwNoPbzMDbrYuRlV
 LwZvVvd/QzZnNN0roT644jl2MP0L5yt0fkMlxY8Yxvixxl+wh+un3zs6YDLohXfKQAc3
 UAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754926578; x=1755531378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dilm457MZb55SV4obLI0f3SaHBRhraDWPnisqbqGwKI=;
 b=N5cSN2NYyuIEXnYdyt3NMxungQBj4JgBuL3BO2dcoyh3vgV+WAKNrmT++xpO8HvRaW
 MnqdqVXILqE5L6tmYpyO1ReGiYshEfEHHWCvjY9kMhFGlSRA/L3CRwXLzAawpj0/vm8l
 M67mqOsrx3NMvmf0cIR1kpXB0QZOVwElq2Gmb5MXHhoF17LZQ3d1veGyhh5xnpvoPgQo
 RD/qBaoYnWsaKgWA/SqyyuNVeuXBdATja9SRWjJiFhapMZXjlTmI3icWp+sJqIh4p4e+
 BJaObwvcKzBpgQn3dkCqwwtr68yOqdWU+xsZ8FVruI1sTxbH0G4gLfq+WabP9OdTL+bF
 0ovA==
X-Gm-Message-State: AOJu0YzbEoM5XtPDeWSgRL0i0dUSX/iZ+KGyFlAC9pU1Pw6qAU1rk1Mo
 kwisAmFGxD2VCR9WsG2Y4dIVymUySIpQgI7/ntmF4lofzC3qV7UNLjO0XeZ8p9eF5+PrqaDUIH3
 QAV/R
X-Gm-Gg: ASbGncudAi3tydXlOdF497x85IoROK9lszd0V1SVCyusNgtIeqn9ksIQUY6rJGk4q79
 wAjPq/op2gKRPBn68AVqogPLNnmavxF5UPxkJY3+bsyz9mdMZ1ioyTlQZdgbBx5CGSaVhWM+CiE
 ahWzp65O2HGKGhtli8qeI6NJYCFMVHYAGbcosrrTMACmNN/Tm9/4rBymMeJblv0BlJ9hCsV0X76
 FRAjyG5dw2fnqfy/qwhczW/QwrPNohp5f1c22IzCw8doUhT267VG6r+zlk5P8OWptER0fI/yS7G
 xwMONnKGMkLZgErk0usGvcMsYNGE8vOKcTV/IIIjiW2Z2H0IbadB9Im5Xg4/AMYLmzb3ozmJAcm
 +DrPMdlMD26VQMF+fwCVYhvI+Is9Fd5BEj7aOh/9wV1quh9lm8Wb0fQSnzrp8GwnFfQ4ASUsljA
 M=
X-Google-Smtp-Source: AGHT+IEmtvWHbwFhU6fjeHEe55SV/8HfJXXaGlnUinWGK49PyTG8jM87ZPF+W+9m8mxQ+7l9tk6A/w==
X-Received: by 2002:a05:6000:4313:b0:3b4:9dbd:eee9 with SMTP id
 ffacd0b85a97d-3b9110046e7mr129569f8f.36.1754926578243; 
 Mon, 11 Aug 2025 08:36:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e075805csm315929065e9.4.2025.08.11.08.36.17
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:36:18 -0700 (PDT)
Date: Mon, 11 Aug 2025 08:36:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v11 00/14] Port mirroring for packet capture
Message-ID: <20250811083613.41f2f91c@hermes.local>
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

On Fri,  8 Aug 2025 09:55:38 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This is a rework of how packet capture is done in DPDK.
> The existing mechanism using callbacks has a number of problems:
>   - can't work when packets are sent and received in secondary process
>     because callbacks only function in the primary process
>   - requires "opt-in" from application
> 
> The new mechanism builds on the concept of port mirroring used
> in Linux/FreeBSD and also router vendors (SPAN ports).
> See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.
> 
> The implementation uses two new ethdev API's:
> one to add a port mirror, and one to remove it.
> 
> The internals of dumpcap are redone but the program command syntax is
> unchanged (no doc change needed). Using the new mirror mechanism, the
> dumpcap program creates a port using ring PMD and then directs a port
> mirror to that new ring PMD instance.  Then the packets are extracted
> from the ring.  If capturing on multiple devices, they all get
> mirrored to the same ring PMD.
> 
> The dumpcap program needs to be able to start the ring PMD it created
> but the existing ethdev API is broken when used from secondary process.
> One of the patches fixes that, it was also reported previously in Bugzilla.
> 
> The mirror API is optimized to use lockless transmit if possible.
> Fix the ring and null PMD to allow lockless transmit for use by capture.
> 
> Added tests for the mirror features.
> The performance has not been measured but the overhead of checking for
> mirror port is no more that the overhead of looking at the callback list.
> 
> v11 - fix build if BPF is disabled
>     - allow mirroring to device that is not lockfree
> 
> Stephen Hemminger (14):
>   ethdev: allow start/stop from secondary process
>   ethdev: make sure all necessary headers included
>   ethdev: reorder bpf and ethdev dependency
>   bpf: add ability to load bpf into a buffer
>   test: add test for hotplug and secondary process operations
>   net/ring: allow lockfree transmit if ring supports it
>   net/ring: add new devarg to create vdev from existing ring
>   mbuf: add dynamic flag for use by port mirroring
>   ethdev: add port mirroring feature
>   app/testpmd: support for port mirroring
>   pcapng: split packet copy from header insertion
>   pcapng: make queue optional
>   app/dumpcap: use port mirror instead of pdump
>   doc: add documentation for port mirroring
> 
>  app/dumpcap/main.c                           | 392 +++++++++++---
>  app/dumpcap/meson.build                      |   3 +-
>  app/test-pmd/cmdline.c                       |  13 +
>  app/test-pmd/cmdline_mirror.c                | 194 +++++++
>  app/test-pmd/cmdline_mirror.h                |  13 +
>  app/test-pmd/meson.build                     |   1 +
>  app/test/meson.build                         |   9 +-
>  app/test/test_bpf.c                          |  28 +
>  app/test/test_ethdev_mirror.c                | 325 ++++++++++++
>  app/test/test_mp_secondary.c                 |  50 +-
>  config/rte_config.h                          |   1 +
>  doc/guides/prog_guide/bpf_lib.rst            |   2 +
>  doc/guides/prog_guide/ethdev/index.rst       |   1 +
>  doc/guides/prog_guide/ethdev/port_mirror.rst |  68 +++
>  doc/guides/rel_notes/deprecation.rst         |   5 +
>  doc/guides/rel_notes/release_25_11.rst       |   5 +
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst  |  15 +
>  drivers/net/ring/rte_eth_ring.c              |  49 ++
>  lib/bpf/bpf_load.c                           | 111 +++-
>  lib/bpf/meson.build                          |   9 +-
>  lib/bpf/rte_bpf.h                            |  38 ++
>  lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c}   |  35 +-
>  lib/ethdev/ethdev_driver.c                   |  12 +-
>  lib/ethdev/ethdev_driver.h                   |   6 +
>  lib/ethdev/ethdev_private.c                  | 141 +++++
>  lib/ethdev/ethdev_private.h                  |  29 ++
>  lib/ethdev/ethdev_trace.h                    |  17 +
>  lib/ethdev/ethdev_trace_points.c             |   6 +
>  lib/ethdev/meson.build                       |   8 +
>  lib/{bpf => ethdev}/rte_bpf_ethdev.h         |   0
>  lib/ethdev/rte_ethdev.c                      |  99 ++--
>  lib/ethdev/rte_ethdev.h                      |  23 +-
>  lib/ethdev/rte_ethdev_core.h                 |  12 +-
>  lib/ethdev/rte_mirror.c                      | 508 +++++++++++++++++++
>  lib/ethdev/rte_mirror.h                      | 147 ++++++
>  lib/mbuf/rte_mbuf_dyn.h                      |   9 +
>  lib/meson.build                              |   4 +-
>  lib/pcapng/rte_pcapng.c                      | 179 ++++---
>  lib/pcapng/rte_pcapng.h                      |  27 +-
>  39 files changed, 2342 insertions(+), 252 deletions(-)
>  create mode 100644 app/test-pmd/cmdline_mirror.c
>  create mode 100644 app/test-pmd/cmdline_mirror.h
>  create mode 100644 app/test/test_ethdev_mirror.c
>  create mode 100644 doc/guides/prog_guide/ethdev/port_mirror.rst
>  rename lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} (95%)
>  rename lib/{bpf => ethdev}/rte_bpf_ethdev.h (100%)
>  create mode 100644 lib/ethdev/rte_mirror.c
>  create mode 100644 lib/ethdev/rte_mirror.h
> 

FYI - this set still has a couple of issues.
   - the secondary process doing packet transfer still is not captured
   - the introduction of another field in fast path causes cache misses

Looking into whether pdump can just broadcast to secondaries instead
like hotplug does. This is less impactful change.

Then if pdump can work unchanged, can make a port mirror demo application
using existing infrastructure and callbacks.
