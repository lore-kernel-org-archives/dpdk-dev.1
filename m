Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C5C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 01:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9E22402D5;
	Fri,  7 Feb 2025 02:43:37 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 87761402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 02:43:36 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f9bd7c480eso2834424a91.1
 for <dev@dpdk.org>; Thu, 06 Feb 2025 17:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738892615;
 x=1739497415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AI5R+VwbbpuaCFq4M2bkuBeTS0Sx8GVaGCurjv0n418=;
 b=fP9duFLo15lyZfwOCaoQTLcRUYCX24F3pejXVsD6HjL2+cqxzxtLGS5Q3xz3X2v3Rz
 iIbFLN2/OMi+O53Y6oxAAM7kf2YCVhMXTaNYP1qN4XjDGSIzlXJbPd+9AehMBhuDa2Sk
 yyRpssytw4EXGRC56v+IBkIBZwALIxbbmvb/KDF2Y0K9Qf+yKEBExD3ZPLqMc1G5OxlG
 +tLzbbkf8VMuuvnp9PesQKMRD7yv11o6KLqMDKyCO9mOt9oAtJQng8isT792lI4RsGv5
 jMpp3HBHApJbIQxVcO+AF6Zf4OeeGQoK2m2FkCgxf461bL6FiSu8HDkS4zLzBRK15Y5g
 FOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738892615; x=1739497415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AI5R+VwbbpuaCFq4M2bkuBeTS0Sx8GVaGCurjv0n418=;
 b=CtoYPABq/kbICYFhFrnjS531V9Ji0Ovz0pAEPoeGcsFFa8r6+efsn4ecmfyD9fyx5+
 qd4UMSGl0GV/BcJT2x/O64kOcSTp/ZGhljdXuNh+yDL0BDlBxitV4+RVi6VfmdBDvCI5
 ZVSIVfQhSiJKpCnrHO81IKg/4VdVufc6YEVExtyxsna+X9+UEfTS4rfmaQXYnJlBODOI
 JJYvaKRDLMGFKePO0vRdEcsUT//p7CI7BHOrgEI+j+9vo8bpYzT/3JunBuaVqLIR1cT+
 j6wQF+as0t7vlJ4y6Am88n4Zjr3pgrIscjlUfqYsX/sYIGFb1Ccm3XBojfMFcH8/6ego
 2sOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrrWA56SjDx9HeAka4+iVoIcI3QOyyAiXtxRV3s+fuUvIROP1QqtQKWNidsLL2kyjTz6o=@dpdk.org
X-Gm-Message-State: AOJu0Yz9YexVyDjx3nzXhhYGG3j29wITq0aG10kLelnXy05RFR+VBN2s
 W0j6tsZHxYbi1FtozHXzBnoSajkmbqJsXsJAwEvmzkjcaA+fytC3ukxW17hLt+k=
X-Gm-Gg: ASbGncsP6Ug5ZBnbc5rnrVhF4lW2vOu2uKNAur/MB5igbtVo+xGGzrn9Q3VIzkzVoWA
 b8W8NI0NjZwqPyfTVcSrvVuRPJbgUsz7+SoPJfGN/yST9pNWhp38/DWzIgXMMsyKEi9iHYjDtLP
 DuUwNG5zRXI2UbIYs1aQqtvaVh9uHdudXdMsMi/z7BxRdAbqJNFp4uUgl1m2paXt6+7p1ynpyT1
 VrQO3oeD7hPkq5L/hCMTMRb2SIsRug61n7kAh5YINR+6tPZlJTGlBjBc5ZgDAx9HERnRabEwCHM
 DcCB4+xDCd9KOLyHlWHDb0XcNUY/PPMny6lZp0ACzzF7msS27CIV3MdEut3ULqKXTb8e
X-Google-Smtp-Source: AGHT+IEl1eCUPXJovPprHOBL+X+mfVbuctc2ckuMALJKrYmhVx9Ccalz2StN/CqBY0OA/kgWR32Zvw==
X-Received: by 2002:a17:90b:38c3:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2fa24271b9dmr2530302a91.16.1738892615573; 
 Thu, 06 Feb 2025 17:43:35 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683dc35sm19167375ad.126.2025.02.06.17.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:43:35 -0800 (PST)
Date: Thu, 6 Feb 2025 17:43:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Srikanth Kaka <srikanth.k@oneconvergence.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Long Li
 <longli@microsoft.com>, dev@dpdk.org, Vag Singh
 <vag.singh@oneconvergence.com>, Anand Thulasiram <avelu@juniper.net>, Long
 Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH v5 00/14] add FreeBSD support to VMBUS & NetVSC PMDs
Message-ID: <20250206174333.1652a18e@hermes.local>
In-Reply-To: <20220423042849.7718-1-srikanth.k@oneconvergence.com>
References: <20220418042915.5765-1-srikanth.k@oneconvergence.com>
 <20220423042849.7718-1-srikanth.k@oneconvergence.com>
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

On Sat, 23 Apr 2022 09:58:35 +0530
Srikanth Kaka <srikanth.k@oneconvergence.com> wrote:

> This patchset requires FreeBSD VMBus kernel changes and
> HV_UIO driver. Both are currently under review at
> https://reviews.freebsd.org/D32184
> 
> Changelog:
> v5: - renamed dir osi to unix
>     - marked a newly added API as experimental
>     - removed camel case variables
> v4: - moved OS independent code out of Linux
> v3: - split the patches into further logical parts
>     - updated docs
> v2: - replaced strncpy with memcpy
>     - replaced malloc.h with stdlib.h
>     - added comment in linux/vmbus_uio.c
> v1: Intial release
> 
> Srikanth Kaka (14):
>   bus/vmbus: move independent code from Linux
>   bus/vmbus: move independent bus functions
>   bus/vmbus: move OS independent UIO functions
>   bus/vmbus: scan and get the network device on FreeBSD
>   bus/vmbus: handle mapping of device resources
>   bus/vmbus: get device resource values using sysctl
>   net/netvsc: make event monitor OS dependent
>   bus/vmbus: add sub-channel mapping support
>   bus/vmbus: open subchannels
>   net/netvsc: make IOCTL call to open subchannels
>   bus/vmbus: get subchannel info
>   net/netvsc: moving hotplug retry to OS dir
>   bus/vmbus: add meson support for FreeBSD
>   bus/vmbus: update MAINTAINERS and docs
> 
>  MAINTAINERS                             |   2 +
>  doc/guides/nics/netvsc.rst              |  11 ++
>  drivers/bus/vmbus/freebsd/vmbus_bus.c   | 286 ++++++++++++++++++++++++++++
>  drivers/bus/vmbus/freebsd/vmbus_uio.c   | 256 +++++++++++++++++++++++++
>  drivers/bus/vmbus/linux/vmbus_bus.c     |  28 +--
>  drivers/bus/vmbus/linux/vmbus_uio.c     | 320 ++++----------------------------
>  drivers/bus/vmbus/meson.build           |  12 +-
>  drivers/bus/vmbus/private.h             |   1 +
>  drivers/bus/vmbus/rte_bus_vmbus.h       |  11 ++
>  drivers/bus/vmbus/unix/vmbus_unix.h     |  27 +++
>  drivers/bus/vmbus/unix/vmbus_unix_bus.c |  37 ++++
>  drivers/bus/vmbus/unix/vmbus_unix_uio.c | 310 +++++++++++++++++++++++++++++++
>  drivers/bus/vmbus/version.map           |   6 +
>  drivers/bus/vmbus/vmbus_channel.c       |   5 +
>  drivers/net/netvsc/freebsd/hn_os.c      |  21 +++
>  drivers/net/netvsc/freebsd/meson.build  |   6 +
>  drivers/net/netvsc/hn_ethdev.c          |  95 +---------
>  drivers/net/netvsc/hn_os.h              |   8 +
>  drivers/net/netvsc/linux/hn_os.c        | 111 +++++++++++
>  drivers/net/netvsc/linux/meson.build    |   6 +
>  drivers/net/netvsc/meson.build          |   3 +
>  21 files changed, 1164 insertions(+), 398 deletions(-)
>  create mode 100644 drivers/bus/vmbus/freebsd/vmbus_bus.c
>  create mode 100644 drivers/bus/vmbus/freebsd/vmbus_uio.c
>  create mode 100644 drivers/bus/vmbus/unix/vmbus_unix.h
>  create mode 100644 drivers/bus/vmbus/unix/vmbus_unix_bus.c
>  create mode 100644 drivers/bus/vmbus/unix/vmbus_unix_uio.c
>  create mode 100644 drivers/net/netvsc/freebsd/hn_os.c
>  create mode 100644 drivers/net/netvsc/freebsd/meson.build
>  create mode 100644 drivers/net/netvsc/hn_os.h
>  create mode 100644 drivers/net/netvsc/linux/hn_os.c
>  create mode 100644 drivers/net/netvsc/linux/meson.build
> 

Is this patch still of interest to anyone?
It is over 3 years old, and would lots of work to rebase on current main branch.
Also, would need ack from existing vmbus maintainers.

Going to close off this version in patchwork as "Changes requested" since it
will need work.
