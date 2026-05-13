Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06962CD4F24
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 14:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0837402B6;
	Wed, 13 May 2026 16:45:48 +0200 (CEST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43]) by mails.dpdk.org (Postfix) with ESMTP id 8E68E40041
 for <dev@dpdk.org>; Wed, 13 May 2026 16:45:47 +0200 (CEST)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a8704dc3a8so7001026e87.3
 for <dev@dpdk.org>; Wed, 13 May 2026 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778683547;
 x=1779288347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjEp12VecJ1p5vw0y/ep+E8PAl2TBf3m8l65ai72nck=;
 b=YDLyc7sNb4XPZkGrXV2fNduQlVXIXeKkXpM1CBgjwm8lqpu0Cxgw33oCndgCM7cbJk
 50VmwrVN93HHYliVc4UgNZn/rNPYnRiwNpPDbaFD3vMMFnXDW85cMFyRFNiWapGxTWa6
 JDwfQUUkmd0tZVHYCZ/KxMVzIJKH60xxf5sL2gvwa+PhOrff/ktSsdiDeVmdISYlClxU
 mmiXYsKz+6XOLsaWGGeXwuZd/w/ezRWcC4omOeF8VRBUrk51L6MPe19417GPAujH73Hr
 6efnhdFOouK/Pi/oG8iSoHk7AG6M8s5jODUI+cZwYwkqLe6jOL5heqtQ5Q+y94q+TTPP
 fwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683547; x=1779288347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yjEp12VecJ1p5vw0y/ep+E8PAl2TBf3m8l65ai72nck=;
 b=Peetq2VytGCw4Q00gjcQAwwPKJ0R4CcIVFATziQvFcvFOBPXJ1yi8a6tJUr+oJF3Uc
 zHU0n0L2S6bu+VM+SxyJP8YGr0dADTMdEZKzzrECsWP2DiZFS9MQLGNpQItnvqeP+0VB
 A1t8TiFWqmluT1dt+WBjy2+7Q4T+C4fKfPTAWMf8qj5DfCQpb4j8rlUTqSzk8rPrNH6i
 DViML9Kx+W4K5B9Gf7c7af3OOPlSb85KAKvSjHgsWd5RhAydUITvNHcsc/C5BjRq5v3a
 RQx6meMDgt3wlt24lTWvkRBFGWePssL1HNgg2YRiUuRAG8sgQt5bH5cwp6DLaMTF8phQ
 oHCQ==
X-Gm-Message-State: AOJu0YwMVpATRKVEuc3AipU+qUcRCeT6PgpkFtQaKKqy9EjlshoQoLS+
 4E0FdTgNcIV57iuH+6BBf8BjVUENeDQNiO9041gVHbvCmGx2xMh37e/rikFQkzy1ohN85093rXC
 84zlQ6+49Ug==
X-Gm-Gg: Acq92OFzjgy0nd43ER6ZPgj6WLDSnK2ir8A05caRRzufaekgei8b1miplJjNOfCFzps
 ggprNDR0/9uSaSSiCx5Raq/wCZqYoms2vtfXt+TWwDaqQ77vot89rETWHJiEoZxdNGSqiTtChnP
 shOSMSlKQbkv8tK72AUZeiY+XhsrSf+x16pqKLrdzdQAqH11sKfJ/bH1fALa7aeNW9/ody0RCC4
 aoAMEnQMqoidfgg0OzCe87MczhPkpO4/vp/rAQhh0vWf8aga6HR5IydDPhiI41fODt5QBSwJ+P9
 KpjAwBVmlxsAsTI6/WGtCSIycif1fYIpV60ttNAYjiG1KpVL8SHc0OR8EvJjOmYGgZq3VjcByaE
 LC/6SSNg76eLDKKwYVnNzL/rtrka+Ma2UaiN7GTv+zUAXK2Ns0fglzKk7X8jE0tWgU0onGP2TGq
 Hd/3DQcohcmvMCJ3fKPWpVTn0i/NZTPks2V1/bPoZh
X-Received: by 2002:a05:6512:483:b0:5a8:f03b:a406 with SMTP id
 2adb3069b0e04-5a8f03ba414mr922265e87.16.1778683546658; 
 Wed, 13 May 2026 07:45:46 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a95661aasm4074389e87.68.2026.05.13.07.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:45:46 -0700 (PDT)
Date: Wed, 13 May 2026 16:45:42 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 00/10] net/sxe2: fix logic errors and address feedback
Message-ID: <20260513164542.5d6a6ff6@stephen-xps.local>
In-Reply-To: <20260512113700.837744-1-liujie5@linkdatatechnology.com>
References: <20260512080616.454171-11-liujie5@linkdatatechnology.com>
 <20260512113700.837744-1-liujie5@linkdatatechnology.com>
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

On Tue, 12 May 2026 19:36:49 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set addresses the feedback received on the v10 submission
> for the sxe2 PMD. The primary focus is on fixing vector path selection,
> ensuring memory safety during mbuf initialization, and cleaning up
> redundant logic in the configuration functions.
>=20
> v13 Changes:
> - Fixed vector Rx burst function being overwritten by scalar selection.
> - Refactored Rx/Tx mode set functions to seed flags from caps first,elimi=
nating tautological checks.
> - Added memset for mbuf_def in vector init to avoid uninitialized reads.
> - Converted pci_map_addr_info to designated initializers.
> - Removed dead Windows-only code in meson.build.
> - Added NULL checks for mbuf free for driver-wide consistency.
> - Updated burst_mode_get to accurately report AVX paths.
> - Adjusted SXE2_ETH_OVERHEAD to match actual VLAN capabilities.
>=20
> Jie Liu (10):
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
>=20
>  .mailmap                                   |   1 +
>  doc/guides/nics/features/sxe2.ini          |  30 +
>  doc/guides/nics/index.rst                  |   1 +
>  doc/guides/nics/sxe2.rst                   |  34 +
>  doc/guides/rel_notes/release_26_07.rst     |   4 +
>  drivers/common/sxe2/meson.build            |  15 +
>  drivers/common/sxe2/sxe2_common.c          | 685 +++++++++++++++
>  drivers/common/sxe2/sxe2_common.h          |  86 ++
>  drivers/common/sxe2/sxe2_common_log.h      |  83 ++
>  drivers/common/sxe2/sxe2_errno.h           | 110 +++
>  drivers/common/sxe2/sxe2_host_regs.h       | 707 +++++++++++++++
>  drivers/common/sxe2/sxe2_internal_ver.h    |  33 +
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      | 326 +++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.h      | 141 +++
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |  63 ++
>  drivers/common/sxe2/sxe2_osal.h            | 584 +++++++++++++
>  drivers/common/sxe2/sxe2_type.h            |  60 ++
>  drivers/meson.build                        |   1 +
>  drivers/net/meson.build                    |   1 +
>  drivers/net/sxe2/meson.build               |  32 +
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 319 +++++++
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  33 +
>  drivers/net/sxe2/sxe2_drv_cmd.h            | 389 +++++++++
>  drivers/net/sxe2/sxe2_ethdev.c             | 941 ++++++++++++++++++++
>  drivers/net/sxe2/sxe2_ethdev.h             | 315 +++++++
>  drivers/net/sxe2/sxe2_irq.h                |  49 ++
>  drivers/net/sxe2/sxe2_queue.c              |  67 ++
>  drivers/net/sxe2/sxe2_queue.h              | 194 +++++
>  drivers/net/sxe2/sxe2_rx.c                 | 579 +++++++++++++
>  drivers/net/sxe2/sxe2_rx.h                 |  34 +
>  drivers/net/sxe2/sxe2_tx.c                 | 447 ++++++++++
>  drivers/net/sxe2/sxe2_tx.h                 |  32 +
>  drivers/net/sxe2/sxe2_txrx.c               | 372 ++++++++
>  drivers/net/sxe2/sxe2_txrx.h               |  22 +
>  drivers/net/sxe2/sxe2_txrx_common.h        | 541 ++++++++++++
>  drivers/net/sxe2/sxe2_txrx_poll.c          | 945 +++++++++++++++++++++
>  drivers/net/sxe2/sxe2_txrx_poll.h          |  17 +
>  drivers/net/sxe2/sxe2_txrx_vec.c           | 197 +++++
>  drivers/net/sxe2/sxe2_txrx_vec.h           |  72 ++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    | 235 +++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       | 545 ++++++++++++
>  drivers/net/sxe2/sxe2_vsi.c                | 212 +++++
>  drivers/net/sxe2/sxe2_vsi.h                | 205 +++++
>  43 files changed, 9759 insertions(+)
>  create mode 100644 doc/guides/nics/features/sxe2.ini
>  create mode 100644 doc/guides/nics/sxe2.rst
>  create mode 100644 drivers/common/sxe2/meson.build
>  create mode 100644 drivers/common/sxe2/sxe2_common.c
>  create mode 100644 drivers/common/sxe2/sxe2_common.h
>  create mode 100644 drivers/common/sxe2/sxe2_common_log.h
>  create mode 100644 drivers/common/sxe2/sxe2_errno.h
>  create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
>  create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h
>  create mode 100644 drivers/common/sxe2/sxe2_osal.h
>  create mode 100644 drivers/common/sxe2/sxe2_type.h
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

Still lots of AI review feedback:

Summary of v13 sxe2 PMD review

Most of the mechanical issues from v10 (carried into v11/v12) have
been addressed in v13: duplicate tx_queue_offload_capa is gone,
RTE_LOG_REGISTER_SUFFIX no longer registers Tx as "rx", the
fopen("/var/log/...") path, SXE2_DPDK_DEBUG, FPGA_VER_ASIC and the
debug flags in meson are gone, rx_queue_release / tx_queue_release
are in dev_ops, and mmap() is correctly checked against MAP_FAILED.

What still needs to be fixed:

Errors
------

Patch 06/10 - Inverted error checks in sxe2_dev_pci_map_init().
sxe2_dev_pci_res_seg_map() returns 0 on success, negative on
failure (the definition is in this same patch). Five consecutive
call sites use "if (!ret)" which is true on success, then log
"Failed to map..." and goto cleanup, unmapping the BAR segment
just mapped and returning ret=3D0 so the caller thinks probe
succeeded. On a real failure, the check is false and the code
proceeds as if the mapping had succeeded. Same bug flagged in
v10, unchanged in v11/v12/v13.

Patch 04/10 - rte_ticketlock_t (busy-wait FIFO lock) held
across blocking ioctl() to the kernel driver in
sxe2_drv_cmd_exec(), sxe2_drv_dev_handshark(), and the DMA
map/unmap entry points added in patch 07. Other lcores trying
to acquire the lock burn CPU spinning until the kernel returns.
Use pthread_mutex_t; the lock is in process-private memory so
PTHREAD_PROCESS_SHARED is not needed.

Patch 06/10 - Non-ASCII characters in source comments. In
sxe2_net_map_addr_info_pf[]: "/* SXE2_PCI_MAP_RES_IRQ_ITR(=E9=BB=98=E8=AE=
=A4=E4=BD=BF=E7=94=A8ITR0) */".
DPDK source should be ASCII English.

Warnings
--------

Patch 02/10 - Feature matrix overclaims. sxe2.ini lists
"MTU update =3D Y" but no .mtu_set is registered, and
"Free Tx mbuf on demand =3D Y" but no .tx_done_cleanup is
registered. Either implement the callbacks or fix the matrix.

Patch 09/10 - Dead "if (ret !=3D SXE2_SUCCESS)" check in the
secondary-process branch of sxe2_dev_init() after two calls to
void-returning functions (sxe2_rx_mode_func_set,
sxe2_tx_mode_func_set). ret cannot change, so the error log
never fires.

Patch 03/10 - Driver-private kernel-style aliases in
sxe2_type.h: u8/s8/u16/.../s64 typedefs, "#define STATIC static",
"#define __le16 u16", "#define __be16 u16". DPDK convention is
to use the standard names directly. The __le*/__be* defines
also erase the endianness annotation rather than preserving
it.

Patch 03/10 - sxe2_osal.h reinvents infrastructure that already
exists in DPDK: BIT/BIT_ULL/GENMASK/set_bit/test_bit/bitmap_weight
(use rte_bitops.h / rte_bitmap.h), LIST_FOR_EACH_ENTRY and
friends (use sys/queue.h TAILQ_* or rte_tailq), COMPILER_BARRIER
(use rte_compiler_barrier), sxe2_*_lock wrappers around
rte_spinlock_*, and udelay/mdelay/msleep aliases for
rte_delay_us. The kernel idioms __iomem and IS_ERR/IS_ERR_VALUE
do not belong in a userspace PMD.

Patch 03/10 - sxe2_errno.h defines a parallel SXE2_ERR_* namespace
that aliases every POSIX errno. The rest of the driver mixes
both spellings (-EFAULT and SXE2_ERR_PERM appear in the same
file). Pick one and use it everywhere.

Patch 08/10 - Redundant "queue_idx >=3D nb_*_queues" guards at
the top of sxe2_rx_queue_setup / sxe2_tx_queue_setup / queue_start
/ queue_stop. The ethdev layer validates queue_idx before
calling the PMD.

Patches 04 and 06 - Typos in identifiers and log strings:
sxe2_commoin_inited (commoin -> common), sxe2_drv_dev_handshark
(handshark -> handshake; the ioctl SXE2_COM_CMD_HANDSHAKE is
correct, only the wrapper is mistyped), "kernel reseted, need
restart app." (reseted -> was reset).

Info
----

Patch 09/10 - sxe2_rx_mode_func_set always picks a scattered Rx
burst (split or non-split) regardless of dev->data->scattered_rx.
There is no plain single-segment fast path.

Patch 10/10 - The vector capability probe in
sxe2_rx_mode_func_set is gated on RTE_PROC_PRIMARY, but a
secondary process calls the same function and lands on the
scalar path. Since rx_pkt_burst is per-rte_eth_dev and
re-assigned by whichever process calls last, the resulting
mode depends on attach ordering.

Patch 09/10 - Dead "goto l_end_of_tx;" immediately before the
"l_end_of_tx:" label in sxe2_tx_pkts().

Patch 10/10 - The "AVX512/AVX2 is not supported in build env"
log lines fire based on CPU capability, not on any build-time
absence, so the message is misleading.

The v10-flagged PCI map inverted-check bug is still present
after three respins.=20

Longer report available if needed.
