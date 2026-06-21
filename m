Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F12CB40269;
	Sun, 21 Jun 2026 18:42:06 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 5C4B74021F
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:42:05 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30bcf74e617so7685948eec.1
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782060124;
 x=1782664924; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0xk6I3+84SqyT2pLxxyMLR9S9AVwJiARtJOQMon8Mk=;
 b=f2NN14belIk4GbaO6cBccaso5SC14vU8URnjp3DNBjPbJP9nNDKtVmqQOBGVxpA7zx
 e/nFa+MtE27GquqKsKs5Kg1b1jbiCAdyqPedp9/aYHI1ghP2bIWmoTBXTsV9eQahPq0r
 0CXRfOTIZO2L81G06awKEgzsSRTsUcw10BsUZj76paeh5notOzDtVAW8rCVpO6TnjVbJ
 xUVDcUZxVyo8skx65C0toAi437CZ2Ba0VuYySxG/1ScZyitYEEdl8gQgDPOgVMLHxiKP
 mdq9ki1KnADZst4R1qGDjK0VP9Q82/+f2me0iOHFaIrZJRosfxJ+CfGs+Gt1/yC8jNbJ
 miuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782060124; x=1782664924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0xk6I3+84SqyT2pLxxyMLR9S9AVwJiARtJOQMon8Mk=;
 b=MVg9ogwCr3sLB2gZ7LBeBD1hR3abWVaS5vhjwqRd0BGcJTuJjTw3oqkrmoJismrx4b
 omo6TNKvohKWAWhAcppB+qNkLJZUjs8TTFnWxFUZ2xNRjF5ihnh+sBdMXLuuzaOTerpv
 +ON1h6fHMbf2CDFTTNTmN4m2Cn93UU5TrEyZhsO+6KC54DsyWgqKZTKmYwTMUPs4ioMI
 KiqB7iLb/QD5qqpyWrqbQlBNTrdFJELCnSPUVlJ4UE6caV2J786dx18YGGCT77qMuao3
 cwuvpVixSkeFkCwteBoROInghfIBaJ430fLy2tADEKbny6ISk25BObQZDrUOyaypWxSN
 ieAg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkTCbIEFxxIBUfICWy7IUJ8yGkem//6NXVP3ACEEW6o0rM+Ca6aTyStyDPooH354Gu8cw=@dpdk.org
X-Gm-Message-State: AOJu0YxKz5YGQF1BJfz6aK5KK28xHwkDh++qNT2nvlgSsrAshguWRBBu
 lzMrKqNA9qdZpEr0a4h4iIUEy3Y/A32AP5+q41QVtVJvaTNbFIvL3MC3IPCZgfKhqso=
X-Gm-Gg: AfdE7cmxc46DM1/yEPHIZFOYfum31TezILu1dgeZzs8Ap4IDAj2jicOp92SwpTyAnkr
 4Z8xBQfHx3LOVreL6+hf21PycliHxwZWrLbvyBE4FvjUV/rgZ/YsAKDWN/K//wGNpjVukDbD2Oy
 xauq9sRmUKZwdyLaAGZUAffWR9d2+P/OlW4wSRW1TEfuQAmKZK7wnNkjFhgmGWHlYUQcryywwEv
 5pChP3JI0VTXe8m5I66nEEJe39KIu11kGQwX75gE6AD3v1cnzwZDO0qZGRIYij0lts/PSC8LMWV
 8L9a5+Fna+DhKPrN5aodjzSIvkPJkGUdqDdwkbAJkkfR+Pb8do4oijkQBhR8E0OPSahUyo7/HqP
 w2A0crGRl9PwYlJmMNMrNMY0H4qv87ZDm7FfE0ho6U+RZX+iBzW0eXkaQYKgkNDWBl+lgjWL6B2
 Y5cSp+P8GKRzjCJn8iQgqZ7PRKfPa7seFFPIUhOIAvzzCJl4E8IsbImzG64gfHwmmN
X-Received: by 2002:a05:7300:ac8a:b0:30b:f5c1:4484 with SMTP id
 5a478bee46e88-30c1dcc6923mr4901050eec.35.1782060123933; 
 Sun, 21 Jun 2026 09:42:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1f14fsm6964199eec.5.2026.06.21.09.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:42:03 -0700 (PDT)
Date: Sun, 21 Jun 2026 09:42:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v3 00/19] dpaa: bus, net, dma and mempool improvements
Message-ID: <20260621094200.33865648@phoenix.local>
In-Reply-To: <20260621152228.2777171-1-hemant.agrawal@nxp.com>
References: <20260621101651.1081425-1-hemant.agrawal@nxp.com>
 <20260621152228.2777171-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 21 Jun 2026 20:52:09 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects correctness fixes, cleanups and feature additions
> across the NXP DPAA bus, net, mempool and DMA drivers.
>=20
> 1. Bus/fman infrastructure cleanups (patches 01, 02, 13)
>    - Refine fman symbol naming and fix unintended global scope.
>    - Scan the maximum BPID count from the device tree rather than
>      using a compile-time constant.
>    - Improve the DPAA bus log macro and fix bus-detection logic.
>=20
> 2. BMI Tx statistics (patch 03)
>    - Extend fman_hw to read Tx BMI registers and expose the counters
>      through the xstats interface.
>=20
> 3. Process-type guards (patch 04)
>    - Add secondary-process checks in the net, DMA and crypto drivers
>      to prevent segfaults when operations valid only in the primary
>      process are called from a secondary.
>=20
> 4. FQ shutdown hardening (patches 05-11)
>    - Introduce helpers for qman channel and work-queue lookup so that
>      FQ teardown is driven by the FQ descriptor instead of ad-hoc
>      parameters.
>    - Add channel validation and CGR cleanup to the shutdown path.
>    - Clean up the Tx-confirmation FQ on device stop and remove a
>      redundant shutdown call from Rx queue setup.
>=20
> 5. net/dpaa improvements (patches 12, 14, 15)
>    - Optimise FM de-configuration to avoid redundant portal drains.
>    - Streamline FMC MAC-type parsing.
>    - Report an error when deferred-start mode is requested (not
>      supported by the driver).
>=20
> 6. mempool/dpaa (patches 16-17)
>    - Optimise multi-entry buffer-pool acquire/release operations.
>    - Release the BPID in the driver destructor to avoid resource leaks
>      across repeated bind/unbind cycles.
>=20
> 7. dma/dpaa (patch 18)
>    - Add SG-list data validation and a workaround for erratum
>      ERR050757.
>=20
> 8. net/dpaa ONIC support (patch 19)
>    - Add port-type checks for ONIC (Open Network Interface Card)
>      shared-Ethernet ports.
>=20
> Changes in v3:
> - Fix out-of-bounds rte_memcpy in bman_release_fast (squashed into
>   patch 16): when num =3D=3D 1 the source pointer bm_bufs[1] is one past
>   the array end; guard the copy with "if (num > 1)".
>=20
> Gagandeep Singh (2):
>   bus/dpaa: enhance DPAA FQ shutdown
>   dma/dpaa: add SG data validation and ERR050757 fix
>=20
> Hemant Agrawal (5):
>   net/dpaa: clean Tx confirmation FQ on device stop
>   net/dpaa: remove redundant FQ shutdown from Rx queue setup
>   net/dpaa: optimize FM deconfig
>   bus/dpaa: improve log macro and fix bus detection
>   net/dpaa: report error on using deferred start
>=20
> Jun Yang (10):
>   bus/dpaa: refine fman naming and fix global scope
>   bus/dpaa: scan max BPID from DTS
>   drivers: add BMI Tx statistics
>   bus/dpaa: define helpers for qman channel and wq
>   drivers: shutdown DPAA FQ by fq descriptor
>   bus/dpaa: improve FQ shutdown with channel validation
>   drivers: add DPAA cgrid cleanup support
>   net/dpaa: optimize FMC MAC type parsing
>   drivers: optimize DPAA multi-entry buffer pool operations
>   drivers: release DPAA bpid on driver destructor
>=20
> Prashant Gupta (1):
>   drivers: add process-type guards for secondary process
>=20
> Vanshika Shukla (1):
>   net/dpaa: add ONIC port checks
>=20
>  drivers/bus/dpaa/base/fman/fman.c         |  23 ++--
>  drivers/bus/dpaa/base/fman/fman_hw.c      | 108 ++++++++---------
>  drivers/bus/dpaa/base/qbman/bman.c        |  59 ++++------
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  48 +++++---
>  drivers/bus/dpaa/base/qbman/qman.c        | 115 ++++++++++--------
>  drivers/bus/dpaa/base/qbman/qman.h        |  23 +++-
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  29 ++++-
>  drivers/bus/dpaa/dpaa_bus.c               |  35 ++++--
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
>  drivers/bus/dpaa/include/fman.h           |  30 ++++-
>  drivers/bus/dpaa/include/fsl_bman.h       |  49 ++++++--
>  drivers/bus/dpaa/include/fsl_qman.h       |  22 +++-
>  drivers/crypto/dpaa_sec/dpaa_sec.c        |   3 -
>  drivers/dma/dpaa/dpaa_qdma.c              | 103 ++++++++++++----
>  drivers/mempool/dpaa/dpaa_mempool.c       |  75 ++++++++++--
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 132 ++++++++++++++++-----
>  drivers/net/dpaa/dpaa_ethdev.h            |  22 +++-
>  drivers/net/dpaa/dpaa_flow.c              | 137 +++++++++++++---------
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  73 +++++++-----
>  21 files changed, 748 insertions(+), 352 deletions(-)
>=20

Clang build fails:
 ccache clang -Idrivers/libtmp_rte_net_dpaa.a.p -Idrivers -I../drivers -Idr=
ivers/net/dpaa -I../drivers/net/dpaa -Ilib/ethdev -I../lib/ethdev -Ilib/eal=
/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include=
 -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -I=
lib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I=
../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metric=
s -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../l=
ib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -=
I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrive=
rs/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../l=
ib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Idrivers/mempool/dpaa -I..=
/drivers/mempool/dpaa -Idrivers/bus/dpaa -I../drivers/bus/dpaa -I../drivers=
/bus/dpaa/base -I../drivers/bus/dpaa/include -I../drivers/bus/dpaa/base/qbm=
an -Idrivers/common/dpaax -I../drivers/common/dpaax -I../drivers/common/dpa=
ax/caamflib -Ilib/eventdev -I../lib/eventdev -Ilib/hash -I../lib/hash -Ilib=
/rcu -I../lib/rcu -Ilib/timer -I../lib/timer -Ilib/cryptodev -I../lib/crypt=
odev -Ilib/dmadev -I../lib/dmadev -Xclang -fcolor-diagnostics -pipe -D_FILE=
_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -in=
clude rte_config.h -Wvla -Wcast-qual -Wcomma -Wdeprecated -Wformat -Wformat=
-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -=
Wnested-externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-comp=
are -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initiali=
zers -D_GNU_SOURCE -fPIC -march=3Dcorei7 -mrtm -DALLOW_EXPERIMENTAL_API -DA=
LLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -Wno=
-vla -Wno-shadow -Wno-pointer-arith -DRTE_COMPONENT_CLASS=3Dpmd_net -DRTE_C=
OMPONENT_NAME=3Ddpaa -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.dpaa -DRTE_ANNOTAT=
E_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dp=
aa_flow.c.o -MF drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dpaa_flow.c.o.d -o=
 drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dpaa_flow.c.o -c ../drivers/net/d=
paa/dpaa_flow.c
../drivers/net/dpaa/dpaa_flow.c:673:19: error: unused function 'get_tx_port=
_type' [-Werror,-Wunused-function]
  673 | static inline int get_tx_port_type(struct fman_if *fif)
      |                   ^~~~~~~~~~~~~~~~


Also did more detailed AI review:


Reviewed the v3 DPAA series (19 patches) against current main; applied
cleanly with git am and traced the affected paths. Issues by patch:

Patch 12 + 19: net/dpaa FM deconfig
Error: dpaa_eth_dev_close() can call dpaa_fm_deconfig() on a NULL
port_handle. Patch 12 added a second deconfig call (guarded only by
!(default_q || fmc_q)) plus an unconditional one at the end, and made
dpaa_fm_deconfig() idempotent with an early "if (!port_handle) return
0". Patch 19 removes that early return and only re-guards the
dpaa_fm_config() caller. Final close path:

if (!(default_q||fmc_q)) if (port_handle) deconfig  /* nulls handle */
...
if (!(default_q||fmc_q))            deconfig         /* handle NULL */
                                    deconfig         /* unconditional */

First call closes the port and sets port_handle =3D NULL; the next calls
hit fm_port_disable(NULL) (and delete_pcd/scheme/netenv on stale
handles). In default_q/fmc_q mode the last call also runs with a
possibly-NULL handle. Restore the !port_handle guard in
dpaa_fm_deconfig(), or guard every call site and drop the duplicates;
there is no reason to deconfig three times. dpaa_port_vsp_cleanup() is
fine, it is idempotent.

Patch 13: bus/dpaa improve log macro and fix bus detection
Error: dpaa_bus_dev_compare() no longer returns a comparison result.
It is installed as bus->dev_compare and rte_bus_find_devargs() uses it
as "cmp(name, devargs_name) !=3D 0 -> continue". The new body returns 0
on any DPAA platform (and short-circuits to 0 once dpaa_bus.detected is
set), so every device name compares "equal" to the first devargs in the
list, and per-device devargs get misapplied. A comparator must return
the name comparison (old strncmp(devname1, devname2, ...)). Bus
detection and pthread_key_create() side effects do not belong in a
compare callback.

Patch 03: drivers add BMI Tx statistics
Warning: the Tx BMI counters are added to dpaa_xstats_strings but
nothing reads them. fman_if_bmi_stats_get_all() and
fman_if_bmi_stats_reset() still only touch the Rx registers via
rx_bmi_map, and FMAN_IF_BMI_TX_STAT_OFFSET_START/END are defined but
unused. In dpaa_dev_xstats_get()/dpaa_xstats_get_by_id() the
regular-vs-BMI split is computed from sizeof(struct
dpaa_if_rx_bmi_stats) only, so adding 4 Tx entries shifts the boundary
and the Tx counters report stale/Rx data. Either wire get_all/reset to
read the tx_bmi_map range and fix the bmi_count split, or drop the Tx
entries from this patch.

Patch 04: drivers add process-type guards for secondary process
Error: dpaa_qdma_init() adds "char *penv;" but does not use it here;
penv is only consumed in patch 18. This commit fails to build
standalone with -Werror (-Wunused-variable), breaking bisect. Move the
declaration to patch 18.
Info: the subject says "add process-type guards" but the dpaa_sec hunk
removes the RTE_PROC_PRIMARY early-return in cryptodev_dpaa_sec_probe().
That is actually correct (secondary still attaches the cryptodev, and
dpaa_sec_dev_init() has its own primary-only guard), but the commit
message should say so.

Patch 18: dma/dpaa add SG data validation and ERR050757 fix
Warning: five new getenv() tunables (DPAA_QDMA_DATA_VALIDATION,
DPAA_QDMA_HW_ERR_CHECK, DPAA_QDMA_SG_ENABLE, DPAA_QDMA_SG_MAX_ENTRY_SIZE,
DPAA_QDMA_PCI_READ). The driver already uses devargs
(DPAA_DMA_ERROR_CHECK); these should be devargs too. checkpatch will
also flag the getenv additions.
Info: s_hw_err_check changes from bool to int; keep bool for a
true/false flag.

Patch 08: bus/dpaa enhance DPAA FQ shutdown
Info: qman_find_fq_by_cgrid() ends with "do {...} while (1);" followed
by an unreachable "return -ENODEV;" - drop the dead return. The linear
FQID probe from 1 with a hardware query per iteration relies on
qman_query_fq_np() returning -ERANGE to terminate; worth a comment.
This patch also leaves a new blank line at EOF (checkpatch).

Patch 17: drivers release DPAA bpid on driver destructor
Info: "#define RTE_PRIORITY_104 104" is unused; RTE_FINI_PRIO is called
with the literal 104. Use the macro or drop it.
