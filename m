Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5D110854CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 03:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE440402A0;
	Wed, 18 Mar 2026 04:04:46 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 091874026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 04:04:45 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35ba2ae4df3so1871013a91.2
 for <dev@dpdk.org>; Tue, 17 Mar 2026 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773803085;
 x=1774407885; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z40bj+avoTH+ZF08DDqvqvZmVDr0Wm9/n54o22IQQTU=;
 b=Cj/dPG6gBdUaE2UgQvBK4KGdmqb89BHbjQz//wTwOMGXLYKyYzWUoy6kmeK5EQUjEN
 XIG1ZUOL+dRyIfANKWeuI+d2r8jhWvLJNB2Cbyawqda09KHgORdNV97SO9QFCzU3SB+a
 5fqyS1OMpaxoXsZ1OfynYVUKhplXVkdMHP4l9DmkWisIDfqdJHRb9MibqJO/7bcvL/hN
 XYfXVK8GJTzKIIshOKliVgE5E4IUaf0LI0Bq+zVy+GFAm5SQu5TtfwUJcY/TlOUa8fAS
 BmXGxzCXTDhHC/qfPN3yH128X1dMUYw+GmHSmPMrC8bZa4LmS1rYAIeCPbVbMggamrPd
 pgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773803085; x=1774407885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z40bj+avoTH+ZF08DDqvqvZmVDr0Wm9/n54o22IQQTU=;
 b=W1rDulpVAQ7mOgZI+n1HBhiSIURfXy9Kb+AL3qXSNXHH147jRrkTlDDS6O5dW175DM
 Ah2xph5ooeDFFHtQiWDJvj1dgBhWSIaekAsZP7RJYL7j3C+TxN/phYeCbJoWb8cgFx7U
 sDUFBtmo6MGnGu/TR8ZlZv544X4p9ISotN0rnZFsYCFUqASWnZ2hsZukMJb42uPtZe3k
 PVRhEdhRXIGYBHndRG3l8072QCqACJoQefcOtQdgLT0Ap4ah5iBLElDQypIzEJetBo3M
 RPSKOD2tp5FujrDhVNmvhd+sssBko7OP7vXWePF41iqIe/A4BA7sCaaYtumA67GB8SfE
 NGyA==
X-Gm-Message-State: AOJu0YwTcYx79PcJClLa1m/3yA26NI5eelobLIog7SOikVv1Lmvxx+/9
 j5l531sbh4c6K6bWrGcaMe7iaF7YfCptZLXb6WgNOXGXKJ737fk4F9fTq/LHaokeUTZK0YYDhRl
 h1RL+
X-Gm-Gg: ATEYQzzX1WNuulIRJUccbeaT8UqJZXy/rjE+CJmg2d0bN5q37AmXMZlTKNhk4sYl2Uo
 7kq3Oi401vneGZpEH/VuPnTuKUsT6BzIYe7mjv1ueOTdtERW9k9VPx5qkYgOjBYOadcw2GPLziN
 XqyvmO5O2+86UKVHWiXzuRfymnuRL7/FgbWJgFcllglKl/yLSYsVU4VByg7s1ramgXtBcNc5ZxD
 4EGBO1kG1vsBVaBjqk4ySZUoSU8C1DArWRvlKdI3rr+zvAByYBNXao+5oO3TSO7FRiRHn5v3n/z
 Z5yJSpNhy6B/LiiTWeKujXwpQfra11KY7wrmm59k+DmVaM6FSd9LOkfBiSWWypzhEEVgxGbSFkA
 1axWkGLYZRQCIJ9QVcKioEh3aEQKiiWRdF0LepQ2LhpTt1PMeCjqkX++dMVQ0mqnlamGNcNQvO/
 NTItiC4X+UU0LLdfP1AFHP08b867Lk7l6ZhSX93h77s0B5YV+BU8Pce0swi1lq326BFhd8+paqO
 RedleQLc7957uc5hycyBg==
X-Received: by 2002:a17:903:390d:b0:2ae:7ed6:46e3 with SMTP id
 d9443c01a7336-2b06e3bd8d2mr22528105ad.27.1773803084574; 
 Tue, 17 Mar 2026 20:04:44 -0700 (PDT)
Received: from stephen-xps.local
 (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5ef519sm9501775ad.49.2026.03.17.20.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 20:04:44 -0700 (PDT)
Date: Tue, 17 Mar 2026 20:04:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v19 00/13] net/sxe: added Linkdata sxe ethernet driver
Message-ID: <20260317200441.1e2f3a83@stephen-xps.local>
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

This driver is large and requires more detail human review so it won't
make 25.03 release.

Some more automated review feedback (some of this is false positives like c=
omplaining
about u8, etc).

Review of [PATCH v19 01/13] through [PATCH v19 13/13] net/sxe driver series
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

Patch 02/13: net/sxe: add ethdev probe and remove
--------------------------------------------------

Error: Blocking calls (mdelay) under spinlock in HDC command path.

In sxe_pmd_hdc.c, sxe_hdc_cmd_process() acquires g_hdc_lock (an
rte_spinlock_t) then calls sxe_hdc_packet_trans(), which calls
sxe_poll_fw_ack() containing mdelay(10) in a loop up to 1000
iterations (SXE_HDC_WAIT_TIME). That is up to 10 seconds of
blocking while holding a spinlock. Spinlocks are busy-wait locks;
blocking under them wastes CPU on any other thread trying to
acquire the lock and causes massive latency spikes.

Replace g_hdc_lock with a pthread_mutex_t, which is a sleeping
lock and appropriate for operations that block for milliseconds.

Error: Global HDC state re-initialized on every probe.

sxe_hdc_channel_init() is called from sxe_probe() and
re-initializes the global g_hdc_lock spinlock and resets the
global sxe_trace_id counter. If two SXE PCI devices are probed,
the second probe reinitializes the lock while the first device
may be using it. This is a race condition.

Move the HDC channel initialization to a one-time constructor
(RTE_INIT) or use rte_thread_once / an initialization flag.

Error: Non-atomic store to atomic variable.

In sxe_common.c, sxe_trace_id_gen() writes sxe_trace_id with a
plain assignment (sxe_trace_id =3D 0) despite sxe_trace_id being
declared RTE_ATOMIC(uint64_t) and read elsewhere via
rte_atomic_fetch_add_explicit(). This is a data race. Use
rte_atomic_store_explicit(&sxe_trace_id, 0,
rte_memory_order_relaxed).

Warning: sxe_compat_version.h defines SXE_GET_FRAME_SIZE using
dev->data->mtu + SXE_ETH_OVERHEAD, where SXE_ETH_OVERHEAD is
RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN (18 bytes). The feature
set claims VLAN and QinQ support. The scatter decision in
sxe_rx_queue_attr_configure (patch 03) correctly adds
2*SXE_VLAN_TAG_SIZE separately, but the SXE_GET_FRAME_SIZE macro
does not include VLAN overhead. This inconsistency means callers
of SXE_GET_FRAME_SIZE that don't add VLAN overhead themselves
will underestimate frame size. Consider making the overhead
device-specific or using SXE_ETH_DEAD_LOAD consistently.


Patch 03/13: net/sxe: add tx rx setup and data path
----------------------------------------------------

Error: mtu_set does not re-select the Rx burst function.

In sxe_mtu_set() (sxe_ethdev.c), when the device is started and
scatter is not enabled, the function rejects the MTU change with
-EINVAL and tells the user to "stop port first." However, even
if the port is stopped and restarted, the mtu_set callback itself
stores the new MTU in adapter->mtu but never updates
dev->data->scattered_rx or re-selects the Rx burst function.
The Rx function selection only happens in sxe_rx_configure()
during dev_start, but it reads dev->data->mtu, not adapter->mtu.
If adapter->mtu and dev->data->mtu diverge, the scatter decision
at restart will use the wrong value.

The adapter->mtu field appears to shadow dev->data->mtu without
a clear purpose. The ethdev layer already writes dev->data->mtu
before calling the mtu_set callback. Either remove adapter->mtu
and use dev->data->mtu everywhere, or ensure they stay in sync.

Warning: dev_infos_get reports max_mtu using SXE_ETH_OVERHEAD
(18 bytes) but the device supports VLAN/QinQ, so the true maximum
frame overhead is larger. This means max_mtu is slightly
overestimated =E2=80=94 the ethdev layer would allow an MTU that, with
VLAN tags, exceeds max_rx_pktlen. This is a minor inconsistency
with the scatter Rx decision which does account for VLAN tags.


Patch 04/13: net/sxe: add link and mac layer operations
--------------------------------------------------------

No correctness issues found.


Patch 12/13: net/sxe: add virtual function
-------------------------------------------

Error: Missing NULL check after malloc.

In sxe_vf_rss_hash_conf_get(), rss_conf.rss_key is allocated
with malloc(SXE_RSS_KEY_SIZE) but the return value is never
checked for NULL. If malloc fails, the subsequent
sxe_rss_hash_conf_get() and memcpy() will dereference a NULL
pointer.

  rss_conf.rss_key =3D malloc(SXE_RSS_KEY_SIZE);
  +if (rss_conf.rss_key =3D=3D NULL)
  +    return -ENOMEM;
  sxe_rss_hash_conf_get(dev, &rss_conf);


Series-wide observations
------------------------

Warning: The driver defines its own integer typedefs (u8, u16,
u32, u64, s32 etc.) in sxe_types.h. DPDK convention is to use
standard C types (uint8_t, uint16_t, uint32_t, uint64_t, int32_t)
throughout. While this is a style issue and the base/ directory
has some latitude for cross-platform shared code, the pf/ and
vf/ code that is purely DPDK should prefer standard types.

Warning: Many functions use the goto-label pattern with labels
like l_end, l_out, l_ret, l_up, l_error, l_free, etc. Some
functions have goto targets that simply return 0 unconditionally
(e.g., sxe_hw_uc_addr_pool_disable), making the goto pattern
add complexity without benefit.

Warning: sxe_ethdev.c defines local constants SXE_ETH_HLEN (14),
SXE_ETH_FRAME_LEN (1514), SXE_ETH_FCS_LEN (4) that duplicate
standard RTE_ETHER_HDR_LEN, RTE_ETHER_MAX_LEN, and
RTE_ETHER_CRC_LEN. Use the rte_ constants directly.


