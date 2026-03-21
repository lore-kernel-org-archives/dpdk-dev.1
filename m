Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259691094489
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 17:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B42402DB;
	Sat, 21 Mar 2026 18:22:13 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id AD263402C9
 for <dev@dpdk.org>; Sat, 21 Mar 2026 18:22:11 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c1092cc08cso4098538eec.1
 for <dev@dpdk.org>; Sat, 21 Mar 2026 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774113731;
 x=1774718531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PznOrH0Dbph9nx87DSG/19aHlrpcUp1qWAeQ03w/oYo=;
 b=vN0BvvSO/Q30edZRJJOsOOAKLw9/sQspMj6RP3hngobNE0R4MeKKV2yGTcUvNXeFRK
 9WRWZ4XgJXExXuwyYaU/BNjAgcm6AVrb3YeU1HqaCzYSoScNczVIXlXRxufrVXgYqoy5
 Vm7ocTmfQQtoa6fZWTKvX5RuR2G7eb29cTUkt8az74UPLjnz/kYc/vwXdwNwiE/A5QlS
 VkR9dRmsT22nrpyVYqqxjDhU8UcWhTTuWH/prAX1l97uESXtl0u4uaY7mcUGcu2rAppB
 kViIkimGS39IM2GdgQ2/SVQku+p0uV94zdWQkQo+u82G7pFGlErmdBlPhiQ5+OIe0NI4
 9tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774113731; x=1774718531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PznOrH0Dbph9nx87DSG/19aHlrpcUp1qWAeQ03w/oYo=;
 b=PlOITcASrKmQT6UIpEGyGXndJ/2o26AwD7e1qdaLi4DPSBtIfjYhPblhaUYfNxJlG4
 hT66A7lhw6Br+BFOzsargTBlYPfNmYBHt5EHbDz3pJuSuo1MQ9rgEQ5I9BkwAibADRi/
 HUc07zgayCm0zHAIZZbn8VFZP+gPA/LRtFMLdAa3kNu6PQ6t9clNHTX4m98Zr5bUTgYx
 z15ViWxnG6NXuh/4p7KL9MkbEPbCSA5jhbFdkmM7e95nOz8to5Ndj1aMh0gm6wmkIIgO
 m3gsZhoznJg7M6QyXUsO5xAmKvHNoxHnMBIq8p0cF2JpN1XsrrA/s1ObqxSaLdN0i8Hy
 cuew==
X-Gm-Message-State: AOJu0Yy93UH2Trwz9zIg2N5BqxLTNGEjDJVXny/J5AL54txir3UYJ60p
 3D4/ci4UCgB6dEoY4a1adNCnKpCIGnJDqJyyQDuE0gSJjf0lYxDB0L5pM5Vm6g8FBFk=
X-Gm-Gg: ATEYQzyFMQ+R+aQi2f8MfegMyyJrhBuBTebRSX4/qSrN9bSkMMvUstDAwTsGimVhAJJ
 qCme8KFXVUy071D5GbMKN19zi12df/Xte3DUSQYYZ4ZKH90TW9PLyG91/JEs8rN2La/cmLZAOso
 ExwlSWf0A115ZNJPJtZvCRGV7bVm6aKYwNzcctggzil4h8/weTT2fLBiyvpeY8Usub1G4ldbW1S
 WsKXlFNGpT/FEXpwFaiIbf7S2wng2h5KfmEfi+ou0C9/cjJ7i0B+NNsC7H/dEN4JXsCSxguxH0R
 s/MUJUQmuRPOjOr87n8I8mosiCESMN68BZAFfz8z9mnVLV+9BBIKrypwBWUvqXbLq6LheSnsQkV
 51eI6zWAmaztvc/bOMp3r+lTDwtnMty7vZFUtdaiGT3H+hvFACCrFdMMrQOSZmkHyt1ZxejjAg5
 7C8CNxUMrXaD0DumlWosF7/KAWaZwmvlKCCU8=
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id
 5a478bee46e88-2c109752f8dmr3263964eec.21.1774113730415; 
 Sat, 21 Mar 2026 10:22:10 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10aefd778sm10137282eec.0.2026.03.21.10.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:22:10 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:22:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v19 00/13] net/sxe: added Linkdata sxe ethernet driver
Message-ID: <20260321102207.0ef768ea@phoenix.local>
In-Reply-To: <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
References: <20260303091057.2952214-14-liujie5@linkdatatechnology.com>
 <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 14 Mar 2026 16:51:52 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set implements core functionality for the SXE PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS, DCB, PTP etc.).
>=20
> V19:
>  - Addressed AI comments
>=20
> v18:
>  - Addressed AI comments
>=20
> Jie Liu (13):
>   net/sxe: add base driver directory and doc
>   net/sxe: add ethdev probe and remove
>   net/sxe: add tx rx setup and data path
>   net/sxe: add link and mac layer operations
>   net/sxe: support vlan filter
>   net/sxe: add filter function
>   net/sxe: support rss offload
>   net/sxe: add dcb function
>   net/sxe: support ptp
>   net/sxe: add xstats function
>   net/sxe: add custom cmd led ctrl
>   net/sxe: add simd function
>   net/sxe: add virtual function
>=20
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/sxe.ini           |   51 +
>  doc/guides/nics/features/sxe_vf.ini        |   37 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/nics/sxe.rst                    |   71 +
>  doc/guides/rel_notes/release_26_03.rst     |    6 +
>  drivers/net/meson.build                    |    1 +
>  drivers/net/sxe/base/sxe_common.c          |   45 +
>  drivers/net/sxe/base/sxe_common.h          |   13 +
>  drivers/net/sxe/base/sxe_compat_platform.h |   73 +
>  drivers/net/sxe/base/sxe_compat_version.h  |   34 +
>  drivers/net/sxe/base/sxe_errno.h           |   61 +
>  drivers/net/sxe/base/sxe_hw.c              | 3271 ++++++++++++++++++++
>  drivers/net/sxe/base/sxe_hw.h              | 1010 ++++++
>  drivers/net/sxe/base/sxe_logs.h            |  105 +
>  drivers/net/sxe/base/sxe_offload_common.c  |   54 +
>  drivers/net/sxe/base/sxe_offload_common.h  |   14 +
>  drivers/net/sxe/base/sxe_queue_common.c    |  450 +++
>  drivers/net/sxe/base/sxe_queue_common.h    |  240 ++
>  drivers/net/sxe/base/sxe_rx_common.c       |  358 +++
>  drivers/net/sxe/base/sxe_rx_common.h       |   17 +
>  drivers/net/sxe/base/sxe_tx_common.c       |   40 +
>  drivers/net/sxe/base/sxe_tx_common.h       |   12 +
>  drivers/net/sxe/base/sxe_types.h           |   40 +
>  drivers/net/sxe/base/sxevf_hw.c            |  819 +++++
>  drivers/net/sxe/base/sxevf_hw.h            |  318 ++
>  drivers/net/sxe/base/sxevf_regs.h          |  119 +
>  drivers/net/sxe/include/drv_msg.h          |   18 +
>  drivers/net/sxe/include/sxe/sxe_cli.h      |  218 ++
>  drivers/net/sxe/include/sxe/sxe_hdc.h      |   43 +
>  drivers/net/sxe/include/sxe/sxe_ioctl.h    |   21 +
>  drivers/net/sxe/include/sxe/sxe_msg.h      |  135 +
>  drivers/net/sxe/include/sxe/sxe_regs.h     | 1270 ++++++++
>  drivers/net/sxe/include/sxe_type.h         |  795 +++++
>  drivers/net/sxe/include/sxe_version.h      |   29 +
>  drivers/net/sxe/meson.build                |   65 +
>  drivers/net/sxe/pf/rte_pmd_sxe.h           |   19 +
>  drivers/net/sxe/pf/sxe.h                   |   93 +
>  drivers/net/sxe/pf/sxe_dcb.c               |  945 ++++++
>  drivers/net/sxe/pf/sxe_dcb.h               |   99 +
>  drivers/net/sxe/pf/sxe_ethdev.c            |  928 ++++++
>  drivers/net/sxe/pf/sxe_ethdev.h            |   28 +
>  drivers/net/sxe/pf/sxe_filter.c            |  923 ++++++
>  drivers/net/sxe/pf/sxe_filter.h            |  109 +
>  drivers/net/sxe/pf/sxe_flow_ctrl.c         |   98 +
>  drivers/net/sxe/pf/sxe_flow_ctrl.h         |   16 +
>  drivers/net/sxe/pf/sxe_irq.c               |  516 +++
>  drivers/net/sxe/pf/sxe_irq.h               |   48 +
>  drivers/net/sxe/pf/sxe_main.c              |  196 ++
>  drivers/net/sxe/pf/sxe_offload.c           |  336 ++
>  drivers/net/sxe/pf/sxe_offload.h           |   51 +
>  drivers/net/sxe/pf/sxe_phy.c               |  953 ++++++
>  drivers/net/sxe/pf/sxe_phy.h               |  117 +
>  drivers/net/sxe/pf/sxe_pmd_hdc.c           |  661 ++++
>  drivers/net/sxe/pf/sxe_pmd_hdc.h           |   42 +
>  drivers/net/sxe/pf/sxe_ptp.c               |  209 ++
>  drivers/net/sxe/pf/sxe_ptp.h               |   26 +
>  drivers/net/sxe/pf/sxe_queue.c             |  774 +++++
>  drivers/net/sxe/pf/sxe_queue.h             |  132 +
>  drivers/net/sxe/pf/sxe_rx.c                | 1459 +++++++++
>  drivers/net/sxe/pf/sxe_rx.h                |  188 ++
>  drivers/net/sxe/pf/sxe_stats.c             |  586 ++++
>  drivers/net/sxe/pf/sxe_stats.h             |   69 +
>  drivers/net/sxe/pf/sxe_tx.c                | 1051 +++++++
>  drivers/net/sxe/pf/sxe_tx.h                |   50 +
>  drivers/net/sxe/pf/sxe_vec_common.h        |  321 ++
>  drivers/net/sxe/pf/sxe_vec_neon.c          |  600 ++++
>  drivers/net/sxe/pf/sxe_vec_sse.c           |  622 ++++
>  drivers/net/sxe/pf/sxe_vf.c                | 1199 +++++++
>  drivers/net/sxe/pf/sxe_vf.h                |  200 ++
>  drivers/net/sxe/sxe_drv_type.h             |   15 +
>  drivers/net/sxe/sxe_testpmd.c              |  196 ++
>  drivers/net/sxe/vf/sxevf.h                 |   42 +
>  drivers/net/sxe/vf/sxevf_ethdev.c          |  752 +++++
>  drivers/net/sxe/vf/sxevf_ethdev.h          |   16 +
>  drivers/net/sxe/vf/sxevf_filter.c          |  493 +++
>  drivers/net/sxe/vf/sxevf_filter.h          |   70 +
>  drivers/net/sxe/vf/sxevf_irq.c             |  432 +++
>  drivers/net/sxe/vf/sxevf_irq.h             |   34 +
>  drivers/net/sxe/vf/sxevf_main.c            |   82 +
>  drivers/net/sxe/vf/sxevf_msg.c             |  624 ++++
>  drivers/net/sxe/vf/sxevf_msg.h             |  201 ++
>  drivers/net/sxe/vf/sxevf_offload.c         |   30 +
>  drivers/net/sxe/vf/sxevf_offload.h         |   16 +
>  drivers/net/sxe/vf/sxevf_queue.c           |  208 ++
>  drivers/net/sxe/vf/sxevf_queue.h           |   69 +
>  drivers/net/sxe/vf/sxevf_rx.c              |  162 +
>  drivers/net/sxe/vf/sxevf_rx.h              |   18 +
>  drivers/net/sxe/vf/sxevf_stats.c           |  162 +
>  drivers/net/sxe/vf/sxevf_stats.h           |   31 +
>  drivers/net/sxe/vf/sxevf_tx.c              |   46 +
>  drivers/net/sxe/vf/sxevf_tx.h              |   14 +
>  92 files changed, 27237 insertions(+)
>  create mode 100644 doc/guides/nics/features/sxe.ini
>  create mode 100644 doc/guides/nics/features/sxe_vf.ini
>  create mode 100644 doc/guides/nics/sxe.rst
>  create mode 100644 drivers/net/sxe/base/sxe_common.c
>  create mode 100644 drivers/net/sxe/base/sxe_common.h
>  create mode 100644 drivers/net/sxe/base/sxe_compat_platform.h
>  create mode 100644 drivers/net/sxe/base/sxe_compat_version.h
>  create mode 100644 drivers/net/sxe/base/sxe_errno.h
>  create mode 100644 drivers/net/sxe/base/sxe_hw.c
>  create mode 100644 drivers/net/sxe/base/sxe_hw.h
>  create mode 100644 drivers/net/sxe/base/sxe_logs.h
>  create mode 100644 drivers/net/sxe/base/sxe_offload_common.c
>  create mode 100644 drivers/net/sxe/base/sxe_offload_common.h
>  create mode 100644 drivers/net/sxe/base/sxe_queue_common.c
>  create mode 100644 drivers/net/sxe/base/sxe_queue_common.h
>  create mode 100644 drivers/net/sxe/base/sxe_rx_common.c
>  create mode 100644 drivers/net/sxe/base/sxe_rx_common.h
>  create mode 100644 drivers/net/sxe/base/sxe_tx_common.c
>  create mode 100644 drivers/net/sxe/base/sxe_tx_common.h
>  create mode 100644 drivers/net/sxe/base/sxe_types.h
>  create mode 100644 drivers/net/sxe/base/sxevf_hw.c
>  create mode 100644 drivers/net/sxe/base/sxevf_hw.h
>  create mode 100644 drivers/net/sxe/base/sxevf_regs.h
>  create mode 100644 drivers/net/sxe/include/drv_msg.h
>  create mode 100644 drivers/net/sxe/include/sxe/sxe_cli.h
>  create mode 100644 drivers/net/sxe/include/sxe/sxe_hdc.h
>  create mode 100644 drivers/net/sxe/include/sxe/sxe_ioctl.h
>  create mode 100644 drivers/net/sxe/include/sxe/sxe_msg.h
>  create mode 100644 drivers/net/sxe/include/sxe/sxe_regs.h
>  create mode 100644 drivers/net/sxe/include/sxe_type.h
>  create mode 100644 drivers/net/sxe/include/sxe_version.h
>  create mode 100644 drivers/net/sxe/meson.build
>  create mode 100644 drivers/net/sxe/pf/rte_pmd_sxe.h
>  create mode 100644 drivers/net/sxe/pf/sxe.h
>  create mode 100644 drivers/net/sxe/pf/sxe_dcb.c
>  create mode 100644 drivers/net/sxe/pf/sxe_dcb.h
>  create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
>  create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h
>  create mode 100644 drivers/net/sxe/pf/sxe_filter.c
>  create mode 100644 drivers/net/sxe/pf/sxe_filter.h
>  create mode 100644 drivers/net/sxe/pf/sxe_flow_ctrl.c
>  create mode 100644 drivers/net/sxe/pf/sxe_flow_ctrl.h
>  create mode 100644 drivers/net/sxe/pf/sxe_irq.c
>  create mode 100644 drivers/net/sxe/pf/sxe_irq.h
>  create mode 100644 drivers/net/sxe/pf/sxe_main.c
>  create mode 100644 drivers/net/sxe/pf/sxe_offload.c
>  create mode 100644 drivers/net/sxe/pf/sxe_offload.h
>  create mode 100644 drivers/net/sxe/pf/sxe_phy.c
>  create mode 100644 drivers/net/sxe/pf/sxe_phy.h
>  create mode 100644 drivers/net/sxe/pf/sxe_pmd_hdc.c
>  create mode 100644 drivers/net/sxe/pf/sxe_pmd_hdc.h
>  create mode 100644 drivers/net/sxe/pf/sxe_ptp.c
>  create mode 100644 drivers/net/sxe/pf/sxe_ptp.h
>  create mode 100644 drivers/net/sxe/pf/sxe_queue.c
>  create mode 100644 drivers/net/sxe/pf/sxe_queue.h
>  create mode 100644 drivers/net/sxe/pf/sxe_rx.c
>  create mode 100644 drivers/net/sxe/pf/sxe_rx.h
>  create mode 100644 drivers/net/sxe/pf/sxe_stats.c
>  create mode 100644 drivers/net/sxe/pf/sxe_stats.h
>  create mode 100644 drivers/net/sxe/pf/sxe_tx.c
>  create mode 100644 drivers/net/sxe/pf/sxe_tx.h
>  create mode 100644 drivers/net/sxe/pf/sxe_vec_common.h
>  create mode 100644 drivers/net/sxe/pf/sxe_vec_neon.c
>  create mode 100644 drivers/net/sxe/pf/sxe_vec_sse.c
>  create mode 100644 drivers/net/sxe/pf/sxe_vf.c
>  create mode 100644 drivers/net/sxe/pf/sxe_vf.h
>  create mode 100644 drivers/net/sxe/sxe_drv_type.h
>  create mode 100644 drivers/net/sxe/sxe_testpmd.c
>  create mode 100644 drivers/net/sxe/vf/sxevf.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_ethdev.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_filter.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_filter.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_irq.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_irq.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_main.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_msg.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_msg.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_offload.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_offload.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_queue.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_queue.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_rx.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_rx.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_stats.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_stats.h
>  create mode 100644 drivers/net/sxe/vf/sxevf_tx.c
>  create mode 100644 drivers/net/sxe/vf/sxevf_tx.h
>=20

More observations with wordy AI information:

The base layer has several problematic patterns where it pulls in raw
POSIX/libc syscalls instead of using DPDK's own abstractions. This
matters because DPDK abstractions exist specifically to handle
portability (Windows support), to integrate with the EAL runtime model,
and to avoid surprising behavior in a userspace poll-mode environment.

Here's what I found:

clock_gettime(CLOCK_MONOTONIC) in sxe_common.c =E2=80=94 Used by
sxe_time_get_real_ms() to get a millisecond timestamp that's sent to
firmware via the HDC time sync command. DPDK provides
rte_get_timer_cycles() and rte_get_timer_hz() for exactly this purpose.
If wall-clock time is specifically needed for the firmware protocol (as
opposed to monotonic elapsed time), that's a slightly different
situation, but the function name says "real ms" and it uses
CLOCK_MONOTONIC, so rte_get_timer_cycles() / (rte_get_timer_hz() /
1000) is a direct replacement.

clock_gettime(CLOCK_REALTIME) in the PTP code (patch 09) =E2=80=94 This one=
 is
for PTP initialization, where wall-clock time is arguably needed. But
DPDK's rte_timespec_get() (or even just using the PTP hardware clock
directly) would be more appropriate than a raw syscall.

pthread_sigmask() / sigaddset() / sigemptyset() in sxe_pmd_hdc.c =E2=80=94 =
The
HDC command path blocks SIGINT/SIGTERM during firmware transactions to
avoid being interrupted mid-protocol. This is a Linux-specific pattern
and won't work on other platforms. More fundamentally, DPDK drivers
shouldn't need to manipulate signal masks =E2=80=94 the EAL owns signal
handling. If the concern is that a firmware transaction must complete
atomically, the proper approach is to not use signals for cancellation
in the first place. In DPDK's model, control operations run on the main
thread which is not expected to receive asynchronous signals during
normal operation.

gettimeofday() / localtime() / strftime() in the TIME() macro in
sxe_logs.h =E2=80=94 This macro is defined but appears unused, which is good
because gettimeofday is a syscall and localtime is not thread-safe. It
should just be removed. The RTE_LOG infrastructure already handles
timestamps.

#include <pthread.h> in sxe_common.c and sxe_logs.h =E2=80=94 These includes
appear to be unnecessary leftovers. sxe_common.c doesn't use any
pthread functions (the trace_id uses rte_atomic). sxe_logs.h includes
pthread.h but doesn't use it either =E2=80=94 presumably it was for a
pthread_self() call in a logging macro that was removed.

pthread_t and pthread_barrier_t in VF adapter struct (patch 12) =E2=80=94 T=
hese
are declared in the struct but never used in the patch. If they're
intended for a link-check thread, the DPDK equivalent is
rte_thread_create_internal_control() with rte_thread_t.

The usleep_range() / mdelay() / msleep() macros in
sxe_compat_platform.h =E2=80=94 These are defined as wrappers around
rte_delay_us / rte_delay_ms, which is the right approach. But the macro
names are Linux kernel conventions (usleep_range, mdelay, msleep),
which suggests this base code was ported from a kernel driver. While
the macros themselves map to DPDK functions, the kernel-style naming
throughout the base layer is a signal that the port wasn't fully
adapted to DPDK conventions.

The overall pattern is that this base/ directory looks like a kernel
driver compat layer that was mechanically ported =E2=80=94 the Linux-isms
(__iomem, __force, usleep_range, mdelay, BIT(), ARRAY_SIZE(),
kernel-style type names) are papered over with macros, but some raw
POSIX calls leaked through. The driver would be cleaner if the base
layer used DPDK APIs directly rather than maintaining a Linux kernel
compatibility shim.
