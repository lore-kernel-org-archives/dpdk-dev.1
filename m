Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3345CCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC124064C;
	Wed, 14 Oct 2026 14:45:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C10A64021E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 14:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791981953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jGo7og5xHolc+JT4Hks1hcWz90I7GE8/Sz5PVn5v01Y=;
 b=HK9bSugeRmehsnryKd29z7sbBQ188qv8svgTa+A6lIJ78Fyxyn2XXLQs9BC/54md9uXV2p
 48RBEFJxu69RBSUOKkilNZ1sbkDSVr+tL4r5091CzT7KjdtqTiWYvc5AzIPb2qb1wvUWfQ
 CYk0QWwFCxHL5XzgIfvwY/bzv9aK0F4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ql_Kb2grNKqCzqbe8fFNEw-1; Wed, 14 Oct 2026 12:45:51 +0000
X-MC-Unique: ql_Kb2grNKqCzqbe8fFNEw-1
X-Mimecast-MFC-AGG-ID: ql_Kb2grNKqCzqbe8fFNEw_1791981950
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a1fa5bb969so4820231fa.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 05:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791981950; x=1792586750;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jGo7og5xHolc+JT4Hks1hcWz90I7GE8/Sz5PVn5v01Y=;
 b=UKE6Rj5hazm+K3XObYtXgKnBQ8HvrQKy1ApFm3JiZJkBl1j1arkjdcdDmGaeFJUIn3
 w9ami8IWDZrYJfFwErma9aUKOyrGe9yp22d8fAiXlexFbuz1DDMnezKEDyN6kcptpaSu
 Qpa0hsQbUsqE24m3SYXYsV+58mnlUNznYpxV2v/I4QW6jhnLpjRKHI0kJjujYIbWyBhP
 GcdhRpq2qSnxhst+VzwJRQ1DXAWoVzjW1wUJ09m4N+LX+6oIw792CTa1nnmKuJXhnIlx
 q/fS9Mto77pQ+YoR+MAfIKhLrM5TXZdAAgtae7gUZklcrm0MF2YLDqAYcQgvBRkiwQ/x
 AFYA==
X-Gm-Message-State: AFq9FYLPt+cCHLEVLCTliUnr2dAVIsEN7gxg6+hn6WXuz66pfXoPdowp
 Ag+2fHuKNOG30tapLNsucmE2sbaQURv7Z9KNrV9WhYna+K3ojC0stWyj8jF7N5HKE60f17lKaTY
 7OimOnF13ytiU9lo8AWluQDaYk1O4bhOaiPZdTH6PKJNY/ceNu1X2nX0vP60d/NxffN4hwirLVV
 BfHc2wiqqrklx/+wqenSE=
X-Gm-Gg: AYBFou2IBwKB7JasdOzmNnlRq/xdSiw5Ufbs2lidEJZM43/jYR7d/UA0Mfb6h1XFG8k
 fGNZKZmC/HV3N/jRE2VS8wn4ozk34o/5UFmAgDeiT0E7affGfbRAJp3gF7xKePo5GzchQ7ImfTj
 4oiu/VyJXgUclcxmExC8LlJTZa5gdloSdPorQeMQ+TUGBf6GFGdPYQ05Jv35Q2QUqpFOO4CGRS5
 8Na/q9PyWg0kw+QlA7Z2QPSCFeuAi/jzjh187CYy26+zdOj
X-Received: by 2002:a2e:bc23:0:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3a9c5384f54mr32804651fa.16.1791981950137; 
 Wed, 14 Oct 2026 05:45:50 -0700 (PDT)
X-Received: by 2002:a2e:bc23:0:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3a9c5384f54mr32804591fa.16.1791981949456; Wed, 14 Oct 2026
 05:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 14 Oct 2026 14:45:37 +0200
X-Gm-Features: AclHuK9mpbRWEqb-IgMv7NgarT7S3BwwLV66BU3QKAClcvXtIvy_eBVF_rgKmGE
Message-ID: <CAJFAV8y+jB2XSuJXd4sppedQuqrQbp7Kw2g3pqdr-nNhOSFiyg@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] remove rte_smp_XX barriers
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QKYkMHoYSZo9Mx7vDATUl5j0Jv9G5Fg9Y1LdmAGwDU0_1791981950
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

On Wed, 14 Oct 2026 at 00:35, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This patch series completes the removal of rte_smp_XX barrier
> functions that was announced over five years ago (20.05).
>
> In the process several race conditions were found and fixed. See
> patches 3, 4 and 17, marked with Fixes: and Cc: stable. Patch 2 is
> also marked for stable because 3 and 4 do not build with clang
> without it.
>
> Most of this is mechanical with AI assistance, so strongly encourage
> maintainers to take a good look.
>
> Barriers ordering memory writes against a device doorbell now use
> rte_io_wmb() rather than an SMP barrier; on arm64 that is dmb oshst
> instead of dmb ishst. In some cases the C11 form gives marginal
> performance gains.
>
> The lock-free stack patch measured faster than the generic version it
> replaces, up to 63% on a 32-core x86 box; the numbers are in that
> patch's commit message.
>
> Patch 19 keeps the Peterson lock test, converted to C11 atomics, with
> the seq_cst fence and rte_mb() as its two cases. It comes before
> patch 20, which holds the last rte_smp_mb() caller, so x86 builds
> with tests enabled stay bisectable. Tested on x86, arm and riscv;
> still untested on ppc and loongarch.
>
> Patch 18 has no ack. Bruce, yours landed on 17; 18 changed since.
>
> Left for follow-up: device read barriers in patches 6, 8 and 14 are
> acquire fences where rte_io_rmb() would match the write side (same
> generated code today, so no regression). And the net/thunderx mailbox
> flags in patch 10 are plain bitfields that need to be atomic, which
> is pre-existing.
>
> v4 - rebase on main, which obsoleted the netvsc patch; address review
>      comments from Konstantin, Marat, David and Wei Hu; collect tags
>
> Stephen Hemminger (29):
>   bpf: replace deprecated SMP barriers with C11 fences
>   bus/vmbus: remove packed attribute from ring buffer
>   bus/vmbus: fix ring buffer ordering on weakly ordered CPUs
>   bus/vmbus: fix missing acquire on receive ring index
>   bus/vmbus: replace SMP barriers with C11 memory fences
>   drivers/baseband: convert rte_smp_rmb to fence
>   net/hinic: replace rte_smp_rmb
>   net/intel: replace rte_smp_rmb
>   net/virtio: replace rte_smp_rmb
>   net/thunderx: replace deprecated SMP barriers
>   stack: always use C11 memory model implementation
>   ring: replace SMP read barrier with C11 acquire fence
>   crypto/virtio: update comment reference to rte_smp_rmb
>   crypto/caam_jr: replace rte_smp_rmb
>   crypto/caam_jr: use IO barrier before job ring doorbell
>   crypto/octeontx: use IO barrier before doorbell
>   event/sw: fix unlinks in progress counter races
>   event/sw: replace SMP barriers with C11 atomics
>   test/barrier: convert to C11 atomics
>   eal/x86: move optimized fence out of SMP barrier
>   common/octeontx: remove redundant barrier in mbox
>   mempool/octeontx: use IO barrier in pool destroy
>   event/octeontx: replace deprecated SMP barriers
>   event/dpaa2: replace deprecated barrier in selftest
>   event/dsw: replace SMP barriers with release fences
>   event/opdl: replace SMP barriers with C11 atomics
>   net/virtio: replace deprecated barrier in avail index update
>   eal: remove stale SMP barrier in rte_service
>   eal: remove rte_smp_XX
>
>  app/test/test_barrier.c                       |  71 ++++----
>  devtools/checkpatches.sh                      |   8 -
>  doc/guides/rel_notes/deprecation.rst          |   8 -
>  doc/guides/rel_notes/release_26_11.rst        |  11 ++
>  .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |   8 +-
>  drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  12 +-
>  drivers/bus/vmbus/private.h                   |  12 +-
>  drivers/bus/vmbus/rte_vmbus_reg.h             |   4 +-
>  drivers/bus/vmbus/vmbus_bufring.c             |  22 +--
>  drivers/bus/vmbus/vmbus_channel.c             |  13 +-
>  drivers/common/octeontx/octeontx_mbox.c       |   6 +-
>  drivers/crypto/caam_jr/caam_jr.c              |   5 +-
>  .../crypto/octeontx/otx_cryptodev_hw_access.h |   4 +-
>  drivers/crypto/virtio/virtqueue.h             |   8 +-
>  drivers/event/dpaa2/dpaa2_eventdev_selftest.c |   4 +-
>  drivers/event/dsw/dsw_event.c                 |   8 +-
>  drivers/event/octeontx/ssovf_evdev_selftest.c |   6 +-
>  drivers/event/octeontx/ssovf_worker.c         |   8 +-
>  drivers/event/opdl/opdl_evdev.c               |   8 +-
>  drivers/event/sw/sw_evdev.c                   |  37 +++--
>  drivers/event/sw/sw_evdev.h                   |  11 +-
>  drivers/event/sw/sw_evdev_scheduler.c         |  24 ++-
>  drivers/mempool/octeontx/octeontx_fpavf.c     |   4 +-
>  drivers/net/hinic/base/hinic_pmd_cmdq.c       |   3 +-
>  drivers/net/hinic/base/hinic_pmd_mgmt.c       |   2 +-
>  drivers/net/intel/ice/ice_rxtx.c              |   2 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +-
>  drivers/net/thunderx/base/nicvf_hw.c          |   3 +-
>  drivers/net/thunderx/base/nicvf_plat.h        |   5 +-
>  drivers/net/virtio/virtqueue.h                |  22 +--
>  lib/bpf/bpf_pkt.c                             |  26 +--
>  lib/eal/arm/include/rte_atomic_32.h           |   6 -
>  lib/eal/arm/include/rte_atomic_64.h           |   6 -
>  lib/eal/common/rte_service.c                  |   1 -
>  lib/eal/include/generic/rte_atomic.h          |  61 -------
>  lib/eal/loongarch/include/rte_atomic.h        |   6 -
>  lib/eal/ppc/include/rte_atomic.h              |   6 -
>  lib/eal/riscv/include/rte_atomic.h            |   6 -
>  lib/eal/x86/include/rte_atomic.h              |  41 ++---
>  lib/ring/rte_ring_gcc_pvt.h                   |   6 +-
>  lib/stack/meson.build                         |   1 -
>  lib/stack/rte_stack_lf.h                      |   4 -
>  lib/stack/rte_stack_lf_generic.h              | 153 ------------------
>  43 files changed, 226 insertions(+), 438 deletions(-)
>  delete mode 100644 lib/stack/rte_stack_lf_generic.h

Thank you for this big cleanup.
Series applied.


-- 
David Marchand

