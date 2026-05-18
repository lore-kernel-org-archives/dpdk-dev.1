Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C46CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 17:25:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952C3402D9;
	Mon, 18 May 2026 19:25:18 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 441AA40041
 for <dev@dpdk.org>; Mon, 18 May 2026 19:25:16 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso2650857eec.0
 for <dev@dpdk.org>; Mon, 18 May 2026 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779125115;
 x=1779729915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACD1lEsl/af9BQGt7jV3C+9yxyqIlcX+nBK3IPtQBxo=;
 b=uwpGE4H5jkaiMoP3vQizrT0R3kC8QM/1hOphoqJlEuN/p6ZH3jkwbDaZvAc96u/eWK
 knrAABSj/4cO2dVq4GyW6Kn3wNAFbMx0umRB/pXvYmga52DBP6rIJVvef6bMEoMYZYS9
 TQpI3DWfPSp0WxLtNLNE0XzyyCRkZ+KVjQHfaMKn3XpOUYEY+lgZrOgRn3iHXFFO1sxo
 //ET1zW9l+f53ggN9XhxHQ2/L7NmQ0Q3UAwIW43fc+N3BfZ7TitiFp/Tz+5hxQwEHxMO
 Y1r0Uy0S4zoNL4MbLatTRW5jgi4XHEVrMb2d64GQuf62wFWQEcyuYhisQJSGG3KvkYam
 5Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779125115; x=1779729915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACD1lEsl/af9BQGt7jV3C+9yxyqIlcX+nBK3IPtQBxo=;
 b=QZ3jCfG3IyYPrl9V4hj051StR9XvjYVeBSB4j9QAjC+C9cDZGQ2aZiFtWIu27KcRDI
 GZoeca+REJpxwz91wktRuIXUL5JaFXrWYh4TrstmyWGevQWt7UZSMMltVSGmhQjdbSUZ
 byaChwsjQVAGAjpGq1G9ReE3P4Pky+lZbxhEfd/w8YXTOern4wZFCWSrEytWZr01yQif
 Jm+YbhqYohMtnRCDolo5IBKSg0ewBtvWolpHOADOdUcm+9MrU7erPMD/NLx4GBVC6sNZ
 TNAQM4ucOz/JdVtdSuEaEKxMVb5Ub1fRYP8b42Ni9Fj3Dh50vh+B2dbldLchKB21iGdc
 /RFg==
X-Gm-Message-State: AOJu0Yx+U1krGgXnlmy3A/z+hVDWdB4PXFTDsbv6IbCr2YUHjrJO2odl
 pxK2EytTq5J/bktW1hTQeaY+UdsHMjG3Bnk2WpphDZQHC8+KJLB+HesvnZVOVP8yKhE/YHyda5z
 7Xc5g
X-Gm-Gg: Acq92OElvcy++Pk+oueDcG0GtbUjcacwnmgwzqAzBsOPPS4P+l/+WQuTjTSoFgW7gPd
 GiEueWZQsSY+yrY1cyI40hwizAvtEgAWJA3kRHQywp37g3LUiCFVGc/QforiLxPhZys0Ok+LIrG
 5Fi98W9/+hkR1qf5kD2wt1xI8e+y4zTVxTXL5Ky1zf7vt+lBwnaR/s4ND+ZBzGx5EIhWQReB2c+
 j5MWdb9c2yGNMTxEhU9MYLJsOQjx1uX7cqlYgbpGc4sB5EcM2I0nkNMkY4wWcyW1Dsdle3Ry67a
 3r3rtSX1uG2yfBOmFZln668H8zeIyZqaqaphWMjQAMIWwTWVJQDppRKbStrw++OvLEER9uIdy63
 FE40dVn/zBVGxCLu9bYn3I/aexGWpCVetEEHJT49ZI37iSnd2w/DfnqSPoOyfab65YxIH/HI340
 wmG9NEPl+HGv9KhShw8eGS2mGVUdk5Acq4AT8=
X-Received: by 2002:a05:7300:b2a5:b0:303:a1af:5042 with SMTP id
 5a478bee46e88-303a1af60eamr4402079eec.0.1779125114945; 
 Mon, 18 May 2026 10:25:14 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2ea78sm14091253eec.6.2026.05.18.10.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:25:14 -0700 (PDT)
Date: Mon, 18 May 2026 10:25:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v16 00/11] net/sxe2: fix logic errors and address feedback
Message-ID: <20260518102511.3888a02c@phoenix.local>
In-Reply-To: <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
References: <20260516074618.2343883-12-liujie5@linkdatatechnology.com>
 <20260518091405.3295896-1-liujie5@linkdatatechnology.com>
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

On Mon, 18 May 2026 17:13:54 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set addresses the feedback received on the v10 submission
> for the sxe2 PMD. The primary focus is on fixing vector path selection,
> ensuring memory safety during mbuf initialization, and cleaning up
> redundant logic in the configuration functions.
>=20
> v16 Changes:
> - Fixed vector Rx burst function being overwritten by scalar selection.
> - Refactored Rx/Tx mode set functions to seed flags from caps first,
>   eliminating tautological checks.
> - Added memset for mbuf_def in vector init to avoid uninitialized reads.
> - Converted pci_map_addr_info to designated initializers.
> - Removed dead Windows-only code in meson.build.
> - Added NULL checks for mbuf free for driver-wide consistency.
> - Updated burst_mode_get to accurately report AVX paths.
> - Adjusted SXE2_ETH_OVERHEAD to match actual VLAN capabilities.
>=20
> Jie Liu (11):
>   mailmap: add Jie Liu
>   doc: add sxe2 guide and release notes
>   common/sxe2: add sxe2 basic structures
>   drivers: add base driver skeleton
>   drivers: add base driver probe skeleton
>   drivers: support PCI BAR mapping
>   common/sxe2: add ioctl interface for DMA map and unmap
>   net/sxe2: support queue setup and control
>   drivers: add data path for Rx and Tx
>   net/sxe2: add vectorized Rx and Tx
>   net/sxe2: implement Tx done cleanup
>=20
>  .mailmap                                   |    1 +
>  doc/guides/nics/features/sxe2.ini          |   29 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/nics/sxe2.rst                   |   34 +
>  doc/guides/rel_notes/release_26_07.rst     |    4 +
>  drivers/common/sxe2/meson.build            |   15 +
>  drivers/common/sxe2/sxe2_common.c          |  683 +++++++++++++
>  drivers/common/sxe2/sxe2_common.h          |   85 ++
>  drivers/common/sxe2/sxe2_common_log.h      |   81 ++
>  drivers/common/sxe2/sxe2_host_regs.h       |  707 +++++++++++++
>  drivers/common/sxe2/sxe2_internal_ver.h    |   33 +
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  325 ++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.h      |  130 +++
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   62 ++
>  drivers/common/sxe2/sxe2_osal.h            |  153 +++
>  drivers/meson.build                        |    1 +
>  drivers/net/meson.build                    |    1 +
>  drivers/net/sxe2/meson.build               |   32 +
>  drivers/net/sxe2/sxe2_cmd_chnl.c           |  323 ++++++
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |   37 +
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  388 ++++++++
>  drivers/net/sxe2/sxe2_ethdev.c             |  968 ++++++++++++++++++
>  drivers/net/sxe2/sxe2_ethdev.h             |  318 ++++++
>  drivers/net/sxe2/sxe2_irq.h                |   48 +
>  drivers/net/sxe2/sxe2_queue.c              |   66 ++
>  drivers/net/sxe2/sxe2_queue.h              |  195 ++++
>  drivers/net/sxe2/sxe2_rx.c                 |  559 +++++++++++
>  drivers/net/sxe2/sxe2_rx.h                 |   34 +
>  drivers/net/sxe2/sxe2_tx.c                 |  420 ++++++++
>  drivers/net/sxe2/sxe2_tx.h                 |   32 +
>  drivers/net/sxe2/sxe2_txrx.c               |  362 +++++++
>  drivers/net/sxe2/sxe2_txrx.h               |   23 +
>  drivers/net/sxe2/sxe2_txrx_common.h        |  540 ++++++++++
>  drivers/net/sxe2/sxe2_txrx_poll.c          | 1044 ++++++++++++++++++++
>  drivers/net/sxe2/sxe2_txrx_poll.h          |   20 +
>  drivers/net/sxe2/sxe2_txrx_vec.c           |  201 ++++
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   73 ++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |  235 +++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  549 ++++++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  214 ++++
>  drivers/net/sxe2/sxe2_vsi.h                |  204 ++++
>  41 files changed, 9230 insertions(+)
>  create mode 100644 doc/guides/nics/features/sxe2.ini
>  create mode 100644 doc/guides/nics/sxe2.rst
>  create mode 100644 drivers/common/sxe2/meson.build
>  create mode 100644 drivers/common/sxe2/sxe2_common.c
>  create mode 100644 drivers/common/sxe2/sxe2_common.h
>  create mode 100644 drivers/common/sxe2/sxe2_common_log.h
>  create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
>  create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h
>  create mode 100644 drivers/common/sxe2/sxe2_osal.h
>  create mode 100644 drivers/net/sxe2/meson.build
>  create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.c
>  create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.h
>  create mode 100644 drivers/net/sxe2/sxe2_drv_cmd.h
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev.c
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev.h
>  create mode 100644 drivers/net/sxe2/sxe2_irq.h
>  create mode 100644 drivers/net/sxe2/sxe2_queue.c
>  create mode 100644 drivers/net/sxe2/sxe2_queue.h
>  create mode 100644 drivers/net/sxe2/sxe2_rx.c
>  create mode 100644 drivers/net/sxe2/sxe2_rx.h
>  create mode 100644 drivers/net/sxe2/sxe2_tx.c
>  create mode 100644 drivers/net/sxe2/sxe2_tx.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_common.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_common.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_sse.c
>  create mode 100644 drivers/net/sxe2/sxe2_vsi.c
>  create mode 100644 drivers/net/sxe2/sxe2_vsi.h
>=20

Getting much closer to merge, still time for 26.07.

Review of [PATCH v16 00/11] sxe2 PMD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Overall comments
----------------

All Error/Warning-level issues from the v15 review are addressed
in v16:

  - sxe2_tx_done_cleanup(): tx_queue NULL check now runs before
    dereferencing txq->vsi->adapter.
  - Vector mode probe is still primary-only, but secondaries now
    inherit the decision via adapter->q_ctxt.{rx,tx}_mode_flags
    rather than silently falling back to scalar.
  - BITS_TO_uint32_t macro renamed to BITS_TO_U32.
  - Dead "goto l_end; l_end:" pattern in sxe2_rx_mode_func_set
    removed in favour of "return;".
  - sxe2_drv_dev_handshake function name correctly spelled in
    the patch that introduces it.

Two new concerns and one carryover:


Patch 09/11: drivers: add data path for Rx and Tx
-------------------------------------------------

Warning: asymmetric secondary-process fallback in
sxe2_tx_mode_func_set() versus sxe2_rx_mode_func_set().

Rx (correct):

  if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
          ...
          adapter->q_ctxt.rx_mode_flags =3D rx_mode_flags;
  } else {
          rx_mode_flags =3D adapter->q_ctxt.rx_mode_flags;
  }

Tx (overrides primary's decision):

  if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
          ...
          adapter->q_ctxt.tx_mode_flags =3D tx_mode_flags;
  } else {
          tx_mode_flags =3D adapter->q_ctxt.tx_mode_flags;
          if (tx_mode_flags =3D=3D 0)
                  tx_mode_flags =3D SXE2_TX_MODE_SIMPLE_BATCH;
  }

If the primary genuinely settled on tx_mode_flags =3D 0 (no
vector, no simple-batch =E2=80=94 i.e. the full sxe2_tx_pkts /
sxe2_tx_pkts_prepare path), the secondary will pick
sxe2_tx_pkts_simple instead.  Primary and secondary then run
different burst functions against the same queue, with different
offload-handling semantics.  This breaks the multi-process
contract.

If the fallback is meant to handle "secondary attached before
primary configured anything", that case should be detected
explicitly (e.g. a separate "configured" flag).  Otherwise just
mirror the Rx side: trust whatever the primary put in shared
memory.

Warning: SXE2_{RX,TX}_MODE_VEC_SSE bit is never set.

sxe2_{rx,tx}_vec_support_check() always seeds *vec_flags with
either SXE2_*_MODE_VEC_SIMPLE or SXE2_*_MODE_VEC_OFFLOAD, both
of which are in SXE2_*_MODE_VEC_SET_MASK.  In the mode-set
function:

          tx_mode_flags =3D vec_flags;
  #ifdef RTE_ARCH_X86
          if ((tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) =3D=3D 0)
                  tx_mode_flags |=3D SXE2_TX_MODE_VEC_SSE;
  #endif

the condition is already false because vec_flags set at least
the SIMPLE bit, so VEC_SSE is never OR'd in.  The Rx side has
the identical pattern, with the additional dead duplicate
"rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_128" check
that the surrounding if already verified.  Either the
*_vec_support_check() helpers should seed only the OFFLOAD bit
and let the mode-set function pick SSE/AVX2/AVX512 from CPU
features, or the dead conditional should be removed.

As-is, the bursts dev->tx_pkt_burst =3D sxe2_tx_pkts_vec_sse and
dev->rx_pkt_burst =3D sxe2_rx_pkts_scattered_vec_sse_offload get
selected purely on the SET_MASK presence =E2=80=94 the SSE-specific bit
never participates.  This works on x86 (it's gated by
#ifdef RTE_ARCH_X86), but the VEC_SSE / VEC_AVX2 / VEC_AVX512 /
VEC_NEON bit definitions are then misleading: no code path
actually distinguishes them.


Series hygiene
--------------

Info: log strings "Open fd=3D%d to handshark with kernel" and
"Failed to handshark, ..." are introduced in patch 03 with the
typo, and corrected to "handshake" in patch 05.  The function
itself is correctly named sxe2_drv_dev_handshake throughout,
but the messages inside it disagree with the function name in
patches 03 and 04.  Two options: fold the typo fix into patch
03, or just write the log strings correctly the first time.

Info: dead "if (ret !=3D 0) PMD_LOG_ERR(...)" check after two
void-returning sxe2_{rx,tx}_mode_func_set() calls was added in
patch 08 and removed in patch 09 of v15; in v16 the same pattern
appears in patch 08 (added) and patch 09 (removed).  Same
within-series churn as before =E2=80=94 please collapse.
