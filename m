Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D7ECA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 09:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32EB240276;
	Tue, 29 Sep 2026 11:17:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DFE6C4013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 11:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790673454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpArPzJRzcApveMX8o84ssJYUVuuO9pxET9WXx5cm7g=;
 b=SqxEDq+nOI5jN9aGESwchIu6Zmdq0FIOWVwXHBn/rr5tCHSs4XQC5HtOxqMU50t3BHJZ5M
 0sJ+hHOIUsReX56DytcTG5mvnsdJWnPNymvbrNk5bU/QhAmClxXH9a/iIV0nMurrTvUydS
 FTCwET8MVNTTMpRRipzxVJIxyeirnus=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ZJjyn4o1PfCLt8BEP7vm1A-1; Tue, 29 Sep 2026 05:17:32 -0400
X-MC-Unique: ZJjyn4o1PfCLt8BEP7vm1A-1
X-Mimecast-MFC-AGG-ID: ZJjyn4o1PfCLt8BEP7vm1A_1790673451
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b8f173baa7so1772287e87.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790673451; x=1791278251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EpArPzJRzcApveMX8o84ssJYUVuuO9pxET9WXx5cm7g=;
 b=om7+roj1qGCiv7TAgcclFaQoRgcMUTv7Z3s6nXBqkDJSXdn+3hgjIcBc89G5it9DvX
 v6jK0Ao3cTJ45DtlathzqSrexmIpZaDdAK0wS1I1WJnb+Kam2w2qHbxDcleUui8YzidP
 i2IZiYGZMo0noi7PVGqhCmOwmEeEUNQ32MWmg+NVZB013mIuu2gF6e/lgpBrItlAjJTH
 x7Zy8X44VZE8+A9bnarWu6xS9c3sSOgQ0rEqLvQdtuuAFp3IZDOksQzmPeiDaKjoIK3S
 t0TeSfKdKCVntePU3gmRTPNZFnyu2zQSerFNwkpjzzRTtwi5fNTBI2qFildCdfVTPHIO
 369w==
X-Gm-Message-State: AFq9FYIn/oXN/SiLSCp/HQjgKgHJPeIc5hWDH5AH/jcP1m+EVKyKtNkk
 g33mDZjA9sFyiS+TV3r4V1tD3fmNk7K7LAFy9+2qu0za+3sorjg3gYCyhLfBa2HyQLqg4v0I1I5
 zS0QkTqO5NcfrBMJLH61R8W5XvAEGqRSbcP7TMplRazUDc1gNkdscj3Sb+i+1zhE3MbYITTyj42
 12WgObYUIZTax8ZGyn00c=
X-Gm-Gg: AYBFou3/Ni/ztmx18R2zT3PMPaOLVEk+tGH14jfzCGrPfS8S3KZISrGLaXnGKxyu6eT
 ulVSzAqPMNKOvIOXDsauhm58tykjtIBPz3gGhbQ01oXFln5slEGxPV+t1pqgGfV4mPjTC2GHC9h
 To3E7y/qQQtVidCP8cqD6zgikl5yddY4Ydr1gmZsu73mB8ApAaON+T/li+YZb/Wx6tuFZ3aZquf
 z0Om6pe/5g58HzUGyrpaYrszdwLw4IcjJixy9X7griVQ0Ok
X-Received: by 2002:a05:6512:2347:b0:5b8:f4ed:2055 with SMTP id
 2adb3069b0e04-5b8f4ed4a7bmr2392668e87.9.1790673451263; 
 Tue, 29 Sep 2026 02:17:31 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:b0:5b8:f4ed:2055 with SMTP id
 2adb3069b0e04-5b8f4ed4a7bmr2392663e87.9.1790673450682; Tue, 29 Sep 2026
 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 11:17:19 +0200
X-Gm-Features: AclHuK_CHcX2lcOxS7PatVyBvhaI2YIrvMF-yLeVUMh7AIrsDTUNwhbSd5ExPD4
Message-ID: <CAJFAV8wJPihurdTXW_A6gwF-ZnRxS+JJhVqpzODr-8FC1y62Qg@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] remove legacy atomic functions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mEd4QEZeb8Dmu-cll-GlKX-5pPIsgFriWdOpBXCzsmc_1790673451
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

On Thu, 17 Sept 2026 at 22:11, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The rte_atomicNN_* family was flagged for deprecation in 2021 by
> commit 3ec965b6de12 ("doc: update atomic operation deprecation")
> but removal had stalled and usage continued to grow.
>
> This series finishes converting every remaining in-tree caller to
> the C11-style rte_atomic_*_explicit() / RTE_ATOMIC() API, then
> removes the legacy functions. The deprecation has been out there
> long enough so not a big surprise to users.
>
> Series-acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>
> v8 - drop unused in_use flag in dpaa
>    - consolidate fslmc changes
>    - vmbus: use acquire ordering on the wait for the previous
>      producer so an earlier producer's data writes are carried by
>      this thread's release store (Long Li)
>    - collect review tags
>    - more AI review comments
>
> v7 - fix some review comments
>    - remove unused macros
>    - remove ret_atomicNN functions (rather than deprecating them).
>
> v6 - rebase for 26.11
>    - address some more AI review comments
>
> Stephen Hemminger (25):
>   bpf: use C11 atomics in BPF_ST_ATOMIC_REG
>   net/bonding: use stdatomic
>   net/nbl: remove unused rte_atomic16 field
>   net/ena: replace use of rte_atomicNN
>   net/failsafe: convert to stdatomic
>   net/enic: do not use deprecated rte_atomic64
>   net/pfe: use ethdev linkstatus helpers
>   net/sfc: replace rte_atomic with stdatomic
>   crypto/ccp: replace use of rte_atomic64 with stdatomic
>   bus/dpaa: remove unused in_use field
>   bus/dpaa: replace rte_atomic16 with stdatomic
>   bus/fslmc: replace rte_atomic with stdatomic
>   common/dpaax: remove unused atomic wrappers
>   net/netvsc: replace rte_atomic32 with stdatomic
>   event/sw: convert from rte_atomic32 to stdatomic
>   bus/vmbus: convert from rte_atomic to stdatomic
>   net/bnx2x: convert from rte_atomic32 to stdatomic
>   drivers/event: replace rte_atomic32 in selftests
>   net/hinic: replace rte_atomic32 with stdatomic
>   net/txgbe: replace rte_atomic32 with stdatomic
>   net/vhost: use stdatomic for state flags
>   net/vhost: use stdatomic instead of rte_atomic32
>   vdpa/ifc: replace rte_atomic32 with stdatomic
>   test/atomic: drop old rte_atomicNN tests
>   eal: remove rte_atomicNN functions
>
>  app/test/test_atomic.c                        | 523 +---------
>  devtools/checkpatches.sh                      |   8 -
>  .../prog_guide/writing_efficient_code.rst     |   9 +-
>  doc/guides/rel_notes/deprecation.rst          |   7 -
>  doc/guides/rel_notes/release_26_11.rst        |   7 +
>  drivers/bus/dpaa/base/qbman/bman.c            |   7 +-
>  drivers/bus/dpaa/base/qbman/qman.c            |   9 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  11 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  11 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |  11 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  14 +-
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   9 +-
>  drivers/bus/fslmc/qbman/include/compat.h      |  18 +-
>  drivers/bus/vmbus/private.h                   |   2 +-
>  drivers/bus/vmbus/vmbus_bufring.c             |  40 +-
>  drivers/common/dpaax/compat.h                 |  14 -
>  drivers/crypto/ccp/ccp_crypto.c               |  11 +-
>  drivers/crypto/ccp/ccp_crypto.h               |   2 +-
>  drivers/crypto/ccp/ccp_dev.c                  |  10 +-
>  drivers/crypto/ccp/ccp_dev.h                  |   4 +-
>  drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
>  drivers/event/octeontx/ssovf_evdev_selftest.c |  57 +-
>  drivers/event/sw/sw_evdev.c                   |   8 +-
>  drivers/event/sw/sw_evdev.h                   |   4 +-
>  drivers/event/sw/sw_evdev_worker.c            |  16 +-
>  drivers/net/bnx2x/bnx2x.c                     |   6 +-
>  drivers/net/bnx2x/bnx2x.h                     |   2 +-
>  drivers/net/bnx2x/ecore_sp.c                  |   6 +-
>  drivers/net/bonding/eth_bond_8023ad_private.h |   6 +-
>  drivers/net/bonding/rte_eth_bond_8023ad.c     |  35 +-
>  drivers/net/ena/base/ena_plat_dpdk.h          |  14 +-
>  drivers/net/ena/ena_ethdev.c                  |  21 +-
>  drivers/net/ena/ena_ethdev.h                  |   7 +-
>  drivers/net/enic/enic.h                       |   6 +-
>  drivers/net/enic/enic_compat.h                |   1 -
>  drivers/net/enic/enic_main.c                  |  17 +-
>  drivers/net/enic/enic_rxtx.c                  |  14 +-
>  drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
>  drivers/net/failsafe/failsafe_ops.c           |  12 +-
>  drivers/net/failsafe/failsafe_private.h       |  29 +-
>  drivers/net/failsafe/failsafe_rxtx.c          |   2 +-
>  drivers/net/hinic/base/hinic_compat.h         |   2 +-
>  drivers/net/hinic/base/hinic_pmd_hwdev.c      |  24 +-
>  drivers/net/hinic/base/hinic_pmd_hwdev.h      |   4 +-
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 -
>  drivers/net/netvsc/hn_rndis.c                 |  28 +-
>  drivers/net/netvsc/hn_rxtx.c                  |  12 +-
>  drivers/net/netvsc/hn_var.h                   |   6 +-
>  drivers/net/pfe/pfe_ethdev.c                  |  32 +-
>  drivers/net/sfc/sfc.c                         |   9 +-
>  drivers/net/sfc/sfc.h                         |   4 +-
>  drivers/net/sfc/sfc_port.c                    |   7 +-
>  drivers/net/sfc/sfc_stats.h                   |   2 +-
>  drivers/net/txgbe/base/txgbe_mng.c            |   4 +-
>  drivers/net/txgbe/base/txgbe_type.h           |   2 +-
>  drivers/net/vhost/rte_eth_vhost.c             |  92 +-
>  drivers/vdpa/ifc/ifcvf_vdpa.c                 |  37 +-
>  lib/bpf/bpf_exec.c                            |  13 +-
>  lib/eal/arm/include/rte_atomic_32.h           |   4 -
>  lib/eal/arm/include/rte_atomic_64.h           |   4 -
>  lib/eal/include/generic/rte_atomic.h          | 928 ------------------
>  lib/eal/loongarch/include/rte_atomic.h        |   4 -
>  lib/eal/ppc/include/rte_atomic.h              | 175 ----
>  lib/eal/riscv/include/rte_atomic.h            |   4 -
>  lib/eal/x86/include/meson.build               |   1 -
>  lib/eal/x86/include/rte_atomic.h              | 187 +---
>  lib/eal/x86/include/rte_atomic_32.h           | 212 ----
>  lib/eal/x86/include/rte_atomic_64.h           | 157 ---
>  68 files changed, 416 insertions(+), 2559 deletions(-)
>  delete mode 100644 lib/eal/x86/include/rte_atomic_32.h

AI review spots that concurrent non atomic increments is undefined
behavior (in at least net/ena).
There is also one nit in net/enic.

There may be some leftover, but I spotted nothing more for now.
The series lgtm on the principle.


--=20
David Marchand

