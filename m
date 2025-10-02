Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 13:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA98840BA2;
	Thu,  2 Oct 2025 15:21:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B31640A84
 for <dev@dpdk.org>; Thu,  2 Oct 2025 15:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759411298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dt7BbXejqhLUefwNYFYNhpuj5KWRX0ramejtzobo+44=;
 b=c/pcIWg1XTiwQOFPWYynk5syWGHNBnbyNd3dDK8gPU+BkRp1InzkNOajYOSH77SxNqaUn2
 7LUKWnIF/pmuIkkH3c4AdhnX/nLfKgGsBe+OkZp2W6bgXtx95byvFpMJbYSEfzLEubqisM
 /I08ABWP0SWGo/hmStMwD9cid0I8PLw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-I8QZs4SsOXC0V3UaXYKBBw-1; Thu, 02 Oct 2025 09:21:37 -0400
X-MC-Unique: I8QZs4SsOXC0V3UaXYKBBw-1
X-Mimecast-MFC-AGG-ID: I8QZs4SsOXC0V3UaXYKBBw_1759411296
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-36c0f8f10e6so5098281fa.2
 for <dev@dpdk.org>; Thu, 02 Oct 2025 06:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759411296; x=1760016096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dt7BbXejqhLUefwNYFYNhpuj5KWRX0ramejtzobo+44=;
 b=vhG7T8/CvUNBJy3rKc3Yt69t+fBZ60iaDrz0fHYo3k787NJXZt/78R3rswn3GJrret
 YjZP9CeLdQJ2n6Z14fMSTMjEFqHh68GnNmVLT6A/RBXG2TJJF9N2BRURYsHCJbz1hciw
 eJQsA0Jue4JV2gx1aPPcrn3vBa0iuqgXR6aVjqjD5hZMoFzQzFnlkb5YxAQYKoPEejsT
 Km1tOmNtMU8AjI7+ZLoQ6r9S8XuDbPCQP5bx59qdudUI84Fjao9siwLFvd3X/qksLtg5
 IIdGeDCyveLHNj7Kkpaf8DyHR9tuebmlfN9SMfGZf3zlXFJyMvUM3wrO0kZK/WrHCK/C
 HdYw==
X-Gm-Message-State: AOJu0YyvFWblvVyo7Q4p5eTcek7WbqGoQCXoI2GWv7B8iAUwsRc+fxw3
 mcPNoDJBhJvvKXbjdUiSwileTVt2RWfWxPUrLqTngVmPUrHMCYo/H7UBHFSS9tnoKy+tuDDwAju
 5ETO1N5nJ+vj8O+kCjurYJIKyFrFgnmYPsViYzZzRXbiw09rRYkoyCLkH0lIcmTqVupREiKKPlx
 hNRLExQGkex6jLXa/GeZ8=
X-Gm-Gg: ASbGnctM7u1RL8lKwVr1Cpj5x55NechCVOF9uf09Xs6jRNHLhmni/syCNS6s67osz4J
 iilDHcE4QqJd1F8DYm2P4t8uIAxJR5azdotjsILYysQfCsi8LNj8IawFOJn08X49n8uqtLpBc2+
 X9hOv9g3+OwMUlExV6N9Qxb2wBLtl3
X-Received: by 2002:a2e:a546:0:b0:361:8f0a:6fe4 with SMTP id
 38308e7fff4ca-373a71162c7mr19291291fa.6.1759411295948; 
 Thu, 02 Oct 2025 06:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEazP3lLQyaEWLyMxy7czfd74EZhBnmLTZVIi3hbluuaJZqe8Dhb7f9+5wjYzVlct6UzS4AfbtupYidgTjBWRs=
X-Received: by 2002:a2e:a546:0:b0:361:8f0a:6fe4 with SMTP id
 38308e7fff4ca-373a71162c7mr19291261fa.6.1759411295449; Thu, 02 Oct 2025
 06:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20251001064512.2539269-1-david.marchand@redhat.com>
In-Reply-To: <20251001064512.2539269-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 15:21:23 +0200
X-Gm-Features: AS18NWDbl-fZxpJc3ujWxBLjrq792VABXqQQF5HpXhDEWUjH8MCH-X2UG_-8B5Q
Message-ID: <CAJFAV8xF4uMJNzK==D5tjHiggxJRGDW1=X8FBvKBykM9Nc9GmA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Add a stricter headers check
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eT3vRxcyxjv5cDXO2UlN3P9NuicYpl-VWZAUt6ribkU_1759411296
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

On Wed, 1 Oct 2025 at 08:45, David Marchand <david.marchand@redhat.com> wrote:
>
> As explained in patch 8, the current headers check can not catch
> issues when a public header includes an internal header.
>
> Patch 1-5 fixes have not been marked as backport material as those bugs
> seems minor/easy to fix externally (by either including missing headers,
> or enabling enable_driver_sdk option).
>
>
> --
> David Marchand
>
> Changes since v6:
> - a rabbit told me I should fix driver headers include path:
>   https://github.com/david-marchand/dpdk/pull/2#discussion_r2390690589,
>
> Changes since v5:
> - added headers staging cleanup,
>
> Changes since v4:
> - reworked headers install,
> - fixed issue in ARM memcpy header,
> - further simplified the header check modifications,
>
> Changes since v3:
> - narrowed down the changes under a check on check_includes= option,
> - moved the staging directories under buildtools/chkincs,
>
> Changes since v2:
> - major rework, dropping the makefile approach, and instead copying
>   headers to a staging directory used by the check,
> - rebased,
> - dropped changes on raw cnxk drivers and disabled the associated
>   build warning in the headers check,
>
> David Marchand (9):
>   baseband/acc: fix exported header
>   drivers: drop export of driver headers
>   eventdev: do not include driver header in DMA adapter
>   gpudev: fix driver header for Windows
>   drivers: fix some exported headers
>   eal/arm: fix C++ build for 32-bit memcpy
>   build: factorize headers installation
>   buildtools/chkincs: use a staging directory for headers
>   power: separate public and driver headers
>
>  buildtools/chkincs/meson.build                | 68 +++++++++++++++----
>  .../chkincs/staging/drivers/meson.build       | 13 ++++
>  buildtools/chkincs/staging/meson.build        | 43 ++++++++++++
>  buildtools/chkincs/staging/stage-headers.py   | 50 ++++++++++++++
>  config/meson.build                            |  3 +-
>  devtools/checkpatches.sh                      |  8 +++
>  drivers/baseband/acc/meson.build              |  2 +-
>  drivers/bus/vmbus/rte_vmbus_reg.h             |  6 ++
>  drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h     |  2 +
>  drivers/meson.build                           |  7 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h               |  2 +
>  drivers/net/intel/iavf/rte_pmd_iavf.h         |  6 ++
>  drivers/net/mlx5/rte_pmd_mlx5.h               |  3 +
>  drivers/net/txgbe/meson.build                 |  2 +-
>  drivers/raw/dpaa2_cmdif/rte_pmd_dpaa2_cmdif.h |  2 +
>  drivers/raw/ntb/rte_pmd_ntb.h                 |  2 +
>  lib/bbdev/meson.build                         | 14 ++--
>  lib/eal/arm/include/meson.build               |  3 +-
>  lib/eal/arm/include/rte_memcpy_32.h           |  6 +-
>  lib/eal/include/meson.build                   |  3 +-
>  lib/eal/loongarch/include/meson.build         |  3 +-
>  lib/eal/ppc/include/meson.build               |  3 +-
>  lib/eal/riscv/include/meson.build             |  3 +-
>  lib/eal/x86/include/meson.build               |  6 +-
>  lib/ethdev/meson.build                        |  6 +-
>  lib/eventdev/rte_event_dma_adapter.h          |  2 +-
>  lib/gpudev/gpudev.c                           |  1 +
>  lib/gpudev/gpudev_driver.h                    |  4 +-
>  lib/meson.build                               | 10 +--
>  lib/mldev/meson.build                         |  5 +-
>  lib/power/meson.build                         |  7 +-
>  lib/power/power_cpufreq.h                     | 14 +---
>  lib/power/power_uncore_ops.h                  |  1 +
>  lib/power/rte_power_cpufreq.c                 |  2 +-
>  lib/power/rte_power_cpufreq.h                 | 15 +++-
>  lib/power/rte_power_uncore.c                  |  2 +-
>  lib/power/rte_power_uncore.h                  |  3 +-
>  lib/rawdev/meson.build                        |  3 +-
>  lib/regexdev/meson.build                      |  3 +-
>  lib/security/meson.build                      |  3 +-
>  meson.build                                   | 21 ++++--
>  41 files changed, 276 insertions(+), 86 deletions(-)
>  create mode 100644 buildtools/chkincs/staging/drivers/meson.build
>  create mode 100644 buildtools/chkincs/staging/meson.build
>  create mode 100755 buildtools/chkincs/staging/stage-headers.py

Series applied, thanks for the reviews.


-- 
David Marchand

