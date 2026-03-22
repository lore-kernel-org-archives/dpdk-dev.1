Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD4FC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 16:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 207D7402EE;
	Sun, 22 Mar 2026 17:38:04 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id D9D07402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 17:38:02 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-82a73593410so1237067b3a.1
 for <dev@dpdk.org>; Sun, 22 Mar 2026 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774197482;
 x=1774802282; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DdPVZ55y6Oj0lCKog4s2CgPomUNAOL/br/fMXPRqQg=;
 b=2OdTm2aathG9N7ll7Ui0UzHJvcwUK3lEG4UO3DmMJNEQo1XeYcngoHK3SwChRsnfUx
 gp8MK/q0TXeZcgbAkX73A2v//PgT1KGSWpKhNmnPXmp+WwgGaUvp1uHBXp9fRQ6rHZRJ
 cLI8kL6kmXeRuf+6Apf11Y0ruRy4IRH7jfB6EajV1gyPMLJkwSrkT29yHk4lYQ3n2z5e
 QnSLxs/YUOeBF8NYUQbsW5DYxZ8QE2wPvQjJS6NhLdYr+BI5+RfaG+RpfjUKJ8cwQjG+
 d6eq47cYG/CG293mY7pu2uccpeIDijaJDqk2FAPV3Mx/ztTmQVcH6qtADAnghaVh5vGc
 1jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774197482; x=1774802282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0DdPVZ55y6Oj0lCKog4s2CgPomUNAOL/br/fMXPRqQg=;
 b=ClbuU0yBfiobjUIikFSbBD7HsHx1mxdWipcTrF4ykREZLavAoueyzoRdpwMTJ6RjEK
 p/KkVSG26o1x7wfGT2Dea49Qti8gM18sA8xdAy1xG3azOdfOnf2MndSea/DznJhwuM6h
 A+JoX7xl+mupNWpYbY68jE6fxV4tloz/LVD6WK4l6jDA7OyeJsqHWFfFYNSN9pJ3gr55
 eTjZd63nwx7V7ehczXlpM0VjYdCLYSMspHHBjxMEiI2eXqd7spAMxYIeIpxsT/lUgmV8
 diWRokZumxoREJgthnvt73fOjbC5HBydzx0ZcRJoDVv2B3jApbNYmfm/PuZa9WaMs0dw
 6m7Q==
X-Gm-Message-State: AOJu0Yz1i+I1dZZ1iGWa0ViYdEnj5JOb0Hqnw+2+jcdM2f+eV19CWJ92
 +FGXVidnThJ6vih/0eDy2iY0ASbiOKDelFLmqmuYQhGUNX5p2/+0j4ZSyBrDWSGrQwg=
X-Gm-Gg: ATEYQzyRSfAhfc6rAcskk5FhlWZUqr3VWL54HcdaVWKd1Dm/i7WMriUo/UXlQT8fv4j
 2tsD6L7MNb7EQGm3JTJKUR5BaneHemX+di8iLMJGFF7tOcWkmmHRHdNfUGT2zSyF4CXHV8vLxa7
 I6zRKdlykBuUvuPAYHFR5y+F8ojoQ9WZfMiMrAA67K4vGSPe1+sUMp+tF27jQ/tIv1mOU4PBBhk
 X2KQ1uGowLcOy9+b8kIt4wAXQZVE0exL8RzVdanjS0YuK+KBNZSWVGTvuKu+yxnmR2Ka2EaGpHL
 ZTUDRfn3Rh6MNBLb0a/pM0ckNYcuxtcWNMF7zXfrF+6M4UecsIw6GRUSyPiEqNHwOXlZC3jRauU
 e5r4ImLNFXNgHVKdx/sMAKsv3TSaiit3Tp0uv8/TUZ/ttDQgT2Br/eaz6NH43AFmApGLFYnZzQl
 0tj20XhOFkfHsp8B0EeOGQzIJZAlmtByLQyi4=
X-Received: by 2002:a05:6a00:2394:b0:829:6e26:7d7a with SMTP id
 d2e1a72fcca58-82a8c35cfebmr8595872b3a.38.1774197481815; 
 Sun, 22 Mar 2026 09:38:01 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409c681sm8251642b3a.37.2026.03.22.09.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 09:38:01 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:37:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v19 00/13] net/sxe: added Linkdata sxe ethernet driver
Message-ID: <20260322093753.29f4b2a0@phoenix.local>
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

Since this is a new driver. added an AI review of documentation
(features matrix) vs code

Implemented (ops wired up):
Feature	Status	Evidence
Speed capabilities	=E2=9C=85	dev_infos_get reports speed_capa
Link speed configuration	=E2=9C=85	dev_set_link_up / dev_set_link_down
Link status	=E2=9C=85	link_update
Link status event	=E2=9C=85	LSC interrupt handler + SXE_IRQ_LINK_UPDATE
Rx interrupt	=E2=9C=85	rx_queue_intr_enable / rx_queue_intr_disable
Queue start/stop	=E2=9C=85	rx_queue_start/stop, tx_queue_start/stop
MTU update	=E2=9C=85	mtu_set
Scattered Rx	=E2=9C=85	scattered_rx logic in queue configure
LRO	=E2=9C=85	LRO Rx burst functions
TSO	=E2=9C=85	TSO offload in tx_offload_capa
Promiscuous mode	=E2=9C=85	promiscuous_enable / promiscuous_disable
Allmulticast mode	=E2=9C=85	allmulticast_enable / allmulticast_disable
Unicast MAC filter	=E2=9C=85	mac_addr_add / mac_addr_remove / mac_addr_set
Multicast MAC filter	=E2=9C=85	set_mc_addr_list
RSS hash	=E2=9C=85	rss_hash_update / rss_hash_conf_get
RSS key update	=E2=9C=85	via rss_hash_update
RSS reta update	=E2=9C=85	reta_update / reta_query
VMDq	=E2=9C=85	VMDQ configure code present
SR-IOV	=E2=9C=85	VF driver in patch 13, sxe_vt_configure
DCB	=E2=9C=85	get_dcb_info, DCB configure functions
VLAN filter	=E2=9C=85	vlan_filter_set
Flow control	=E2=9C=85	flow_ctrl_get / flow_ctrl_set / priority_flow_ctrl_s=
et
CRC offload	=E2=9C=85	RTE_ETH_RX_OFFLOAD_KEEP_CRC handling
VLAN offload	=E2=9C=85	vlan_offload_set / vlan_strip_queue_set / vlan_tpid_=
set
L3/L4 checksum offload	=E2=9C=85	In offload capabilities
Packet type parsing	=E2=9C=85	dev_supported_ptypes_get, ptype tables
Timesync	=E2=9C=85	Full set of timesync ops
Rx descriptor status	=E2=9C=85	Assigned to eth_dev->rx_descriptor_status
Tx descriptor status	=E2=9C=85	Assigned to eth_dev->tx_descriptor_status
Basic stats	=E2=9C=85	stats_get / stats_reset
Extended stats	=E2=9C=85	xstats_get / xstats_reset / xstats_get_names
Stats per queue	=E2=9C=85	queue_stats_mapping_set
FW version	=E2=9C=85	fw_version_get
Registers dump	=E2=9C=85	get_reg
Module EEPROM dump	=E2=9C=85	get_module_info / get_module_eeprom
Linux	=E2=9C=85	Platform code present
x86-64	=E2=9C=85	SIMD code in patch 12

Claimed but NOT implemented (no ops wired):
Feature	Status	Notes
EEPROM dump	=E2=9D=8C	No get_eeprom_length or get_eeprom ops wired. sxe.ini=
 claims EEPROM dump =3D Y but there's no get_eeprom callback in sxe_eth_dev=
_ops. Module EEPROM (get_module_eeprom) is present but that's a different f=
eature.
Power mgmt address monitor	=E2=9D=93	No get_monitor_addr op visible in the =
ops struct. This feature requires the PMD to implement get_monitor_addr to =
support rte_power_monitor().
QinQ offload	=E2=9D=93	Claimed as P (partial). vlan_tpid_set is present, bu=
t I didn't see explicit QinQ double-tag handling in the offload path. The o=
verhead calculations reference 2 * SXE_VLAN_TAG_SIZE suggesting awareness, =
but the actual hardware offload for QinQ insertion/stripping needs verifica=
tion.
Inner L3/L4 checksum	=E2=9D=93	Claimed as P. The ptype tables cover NVGRE/V=
XLAN tunnel types, but whether inner checksum offload is actually wired in =
the Tx path needs verification against the offload capabilities returned.
ARMv8	=E2=9D=93	Claimed as Y but the SIMD code in patch 12 appears to be x8=
6-specific (SSE/AVX). No NEON intrinsics visible.

