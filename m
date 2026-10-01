Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E0CA5FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 13:29:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5958B40289;
	Thu,  1 Oct 2026 15:29:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 263C9400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 15:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDbqyQhDz0l6/g1OZGEmMSH966k8X/kPwI99YVJmNAo=;
 b=bQUBt5h9yfHijz8Dz5zrkK0kjBrh82efeou6JiFyG1Dg/joXnyhDCWF5w/trjIgdr4H2Ow
 SPUeLOGGm8rTJGmzh0BIDU/R1VI+l5jWa8ZITrQd/ME2fG+FwjGWZur7BEHAr9LEZHsJnY
 jnIxDyomd3F3Lr6lz1i4sqrI2UaImBY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-EPXQF_L4NNazZAZk7BQ-1A-1; Thu, 01 Oct 2026 09:29:49 -0400
X-MC-Unique: EPXQF_L4NNazZAZk7BQ-1A-1
X-Mimecast-MFC-AGG-ID: EPXQF_L4NNazZAZk7BQ-1A_1790861388
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a64e917254so40428091fa.2
 for <dev@dpdk.org>; Thu, 01 Oct 2026 06:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790861388; x=1791466188;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YDbqyQhDz0l6/g1OZGEmMSH966k8X/kPwI99YVJmNAo=;
 b=IFLqQQHg+rm8n3B94nLaD4404TPlQijoEvvu38azrmHXvglqF8wX5nUZHjTkaOypDF
 OvhOJkF1uN1fzTDmINIcvQXbejjxs5NNZd4MsnMNVu++WaOKnic6e5m7kNTfn1AdBpXa
 5yFJxPLCp5RaP/hlyP+bh3oe8QwJ24qW7lQD9wAOQo2vidddMRVRfapoJEuN2+c7kH8z
 MlXFLyA8PIAfot4IxxkQoWoKmU0LgGg9LbYKmCneSb7XQNMUppxh6LJcwi/yX5+FWmGv
 Iv3hUa/OhNXUGsbYpnE4c2FpT1aBnLl1nlhc+h8h92tnCFY0pKT9m3OY89c0WUvyvIJ5
 S8Bg==
X-Gm-Message-State: AFq9FYLqMUv+3/yLpfk4rm+fdqm4jZhtyEvueiesv93m/XzpTBapgfiD
 81vpwBoPoDDHNGkF1UxF6zm7AUQAnVh1/W8fwxZ0tfogNC9Sx0mBOJgux70tsKN1mA43XkuFj4Q
 +2IillZcYvHVvB2i8SR7WBinfNkGp3VkninVoTrOjk8YosUkpjLcP4sVw1HU2UvGVCsKTNLBLvn
 kmeHiWRq6IsG/sbjexZCs=
X-Gm-Gg: AYBFou3f4W7x49boeLBV0cq5rybm8FLmSG/g2t6nPkJQYNwD/andmdiwKU3YEEXDaA+
 Hc/mgsIbNA9JT1wQnzGT2r01kJg51esmXzrTocmpBxUzJP9JGFmMo71nf8WXpjUOfeOwtjFmPtn
 UrBBQX21Pj4goWaQCQYyzApDVg8uEL8/EYFFd5MzfL3lK5wRZY3s90fzhxTmynmG88AwdcI07Wa
 EDkKLO+MO2eiUZFiyPug05fRYE4kbHUwhn4zrFi0EJilL0g
X-Received: by 2002:a2e:be10:0:b0:3a6:48ce:2b05 with SMTP id
 38308e7fff4ca-3a779200300mr17182411fa.24.1790861387398; 
 Thu, 01 Oct 2026 06:29:47 -0700 (PDT)
X-Received: by 2002:a2e:be10:0:b0:3a6:48ce:2b05 with SMTP id
 38308e7fff4ca-3a779200300mr17182241fa.24.1790861386822; Thu, 01 Oct 2026
 06:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 1 Oct 2026 15:29:35 +0200
X-Gm-Features: AclHuK9XA95JId1Nw8dsC1rWxSLs0AZRyia8D-Ufe-2FSiMvotZrx60VBiFJSd8
Message-ID: <CAJFAV8zvRUx78Ccug5pnLEG+_iPqJVCiCMu1+1N_B+0hVZHaEg@mail.gmail.com>
Subject: Re: [PATCH v9 00/25] remove legacy atomic functions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Thomas Monjalon <thomas@monjalon.net>, dpdk-techboard <techboard@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t88QXBtJy7cWSE0AsnliD8Rp-p2Xp7nVfK2I_t3jeeU_1790861388
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

On Tue, 29 Sept 2026 at 16:04, Stephen Hemminger
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
> The eal/ring/smp_mb changes that were part of the earlier RFC and
> v1-v5 postings are not in this series; they are being handled
> separately since the ring memory model discussion is independent
> of removing the legacy API.
>
> Series-acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>
> v9 - rebase to main
>      - enic: remove extra memset
>      - failsafe: zmalloc of txq and rxq consistency
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
>  drivers/net/enic/enic_main.c                  |  21 +-
>  drivers/net/enic/enic_rxtx.c                  |  14 +-
>  drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
>  drivers/net/failsafe/failsafe_ops.c           |  16 +-
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
>  68 files changed, 415 insertions(+), 2568 deletions(-)
>  delete mode 100644 lib/eal/x86/include/rte_atomic_32.h

Series applied, thanks for this huge cleanup.


--=20
David Marchand

