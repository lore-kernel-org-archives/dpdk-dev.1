Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F42C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:44:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62B90406B8;
	Tue, 11 Aug 2026 17:44:25 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id BA4144027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:44:23 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso562015ad.2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786463063;
 x=1787067863; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8qK7lahLr36kDtF6XWYXp95LOGRmhIbNSX043oaQmzM=;
 b=L/c5fSwvF4sdVsRlONeBPdknajOz9EC8JPSdpN5/mZwl6mQi009cJhttTbCA9i4Xt0
 2l8tA3B8CUmpTtMeWmzT8CKKFCnoMrTzU9hFhg1G6UarVIA7P2wwJ/QJ6jjftEOrz0sK
 FdYzywEspVaT20+I/xnaGjSfoS8lb9UHM+hcNW9YGbL1zJbLNx4k+0fUfwefpSKnLAUI
 cuT0aEni9N9ZcgSWzAZyBfZa1133L9ZGy3eVXB9JLvBLhboipvhBRq0LDbJvwIsuBieM
 IkSkGXFcKxpPbOk5s36WtAy82glTS5kQcP2qLjpWKwiklT868zC8YXhESnsCncNpHiyC
 uJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463063; x=1787067863;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8qK7lahLr36kDtF6XWYXp95LOGRmhIbNSX043oaQmzM=;
 b=QT1ud8s/PTCEAwCUwwNlj6DyHAgj23ZfKFVaUYb+V0vO1njvfIGIB79krUeufCHgnH
 Ovckx7b532HlbW9v/gnjJXEz8/a/MBRXdRTvkasETW+NGz4sw+/DcWXcLXmPBDkBkF8h
 BsVG+kycyoWzNokyDB6ZSGcK8Cc6dcd3xVUW8877EGsQJVNzJao8lhA+sclz0yOVz9I9
 M11B1vbClhsvxZ3tD/lLp2RNH/8xUGKe1Q4kuS1cz/CckYPXfmNp0TCquDC+AGUlW32i
 16bGn7M0Myv05ihvq5ihMsMdHrzXw41gc29GhwRGPDS4MQ/2kSzK+742IbkPc8w5V6eW
 WOcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF0exa/0ddcpU/I7E5UPMYcTahQuG33AVaIa8sXKVxwPl1Lm9mfx8Cl++fzRAdHMmQe7w=@dpdk.org
X-Gm-Message-State: AOJu0YykC52RK2BTc9KEl9kN2Hlj4Mtm1dwQme1kxkVKZkr0T6VAuZKZ
 k3CtHrf+QTsDkLA7VOEJ+ZfdtULjvZo6kQ+A8VRb2S5zBFlpma15ZokvouDxIXtDRJ4=
X-Gm-Gg: AR+sD13HlEMleYs04uJ9FQqBm2Rcg+3WF+uflH0UuZHi5YhEc8JXFzErqfhgHRj5xQx
 NGXxshrItFw0yJbl5RNyOifbdp3HI9baBz/SxfVuaPuBYC3UTeUm/YADiLoXKAdZ4yC3yrwDZmZ
 VYi9naA+oPA+q3WU525tizdi+NmDxiPfBBvmpDxR57acnypiICAGWwLORhW81oXRaKHmGWYQq7i
 YPevE7pRMJBZF7IdQHGAlCZkvp44eaGnaf431RcQ239Nl6XIJu+wdNzVAEXICsmVhOTlST7fk8V
 dduQV9bEVxEoByIEWRDhtMFEYqCPZwn1Tet7zcQAhLU24NudbVfhOBvODyzQd5tS3fuDcI4g2J3
 cAvu3PrRRdS1/ANbaBU5XFacg/5SHOKPwpBhC2do//dcrPTW21hvChu1zlAsfyVKEClvmRDd3dt
 q+SowDaU5NfOa9h5QMalFz3hV5x1u9wEDGW9rbsKNV29HlukyyRQmds4/GyS3y9Z65PI7p9hQc1
 1DIQ/KmpR/bA7QUtIWw3vGc7ajxsw==
X-Received: by 2002:a17:90b:2547:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-392f46be6acmr1139949a91.4.1786463062400; 
 Tue, 11 Aug 2026 08:44:22 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412458a390sm592605c88.14.2026.08.11.08.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:44:22 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:44:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v8 00/26] DPAA driver fixes and improvements
Message-ID: <20260811084419.0ba93487@phoenix.local>
In-Reply-To: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
References: <20260703124950.1895871-1-hemant.agrawal@nxp.com>
 <20260811115731.3421032-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 11 Aug 2026 17:27:05 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of correctness fixes, cleanups and feature
> additions across the NXP DPAA bus, net, mempool and DMA drivers.
> 
> 1. Bus/fman infrastructure cleanups (patches 01, 02, 12)
>    - bus/dpaa: refine fman naming and fix global scope
>    - bus/dpaa: scan max BPID from DTS
>    - bus/dpaa: improve log macro and fix bus detection
> 
> 2. Process-type guards (patch 03)
>    - drivers: add process-type guards to prevent segfaults in secondary
> 
> 3. FQ shutdown hardening (patches 04-08)
>    - bus/dpaa: define helpers for qman channel and wq
>    - bus/dpaa: shutdown DPAA FQ by fq descriptor
>    - bus/dpaa: improve FQ shutdown with channel validation
>    - bus/dpaa: enhance DPAA FQ shutdown
>    - bus/dpaa: add DPAA cgrid cleanup support
> 
> 4. net/dpaa improvements (patches 09, 11, 13)
>    - net/dpaa: add ONIC port checks
>    - net/dpaa: optimize FM deconfig
>    - net/dpaa: optimize FMC MAC type parsing
> 
> 5. Statistics (patch 10)
>    - drivers: add BMI Tx statistics
> 
> 6. mempool/dpaa (patches 14-15)
>    - drivers: optimize DPAA multi-entry buffer pool operations
>    - drivers: release DPAA bpid on driver destructor
> 
> 7. dma/dpaa (patch 16)
>    - dma/dpaa: add SG data validation and ERR050757 fix
> 
> 
> Gagandeep Singh (4):
>   net/dpaa: fix device remove
>   bus/dpaa: enhance DPAA FQ shutdown
>   dma/dpaa: add SG data validation and ERR050757
>   drivers: add offline (O/H) port device support
> 
> Hemant Agrawal (5):
>   net/dpaa: optimize FM deconfig
>   net/dpaa: support Rx/Tx taildrop threshold devarg
>   net/dpaa: add Tx rate limiting API
>   net/dpaa: support non fmX-macY type of shared Ethernet name
>   bus/dpaa: improve log macro and fix bus detection
> 
> Jun Yang (15):
>   drivers: improve  crypto fq resource handling
>   bus/dpaa: refine fman naming and fix global scope
>   bus/dpaa: scan max BPID from DTS
>   bus/dpaa: define helpers for qman channel and wq
>   drivers: shutdown DPAA FQ by fq descriptor
>   bus/dpaa: improve FQ shutdown with channel validation
>   bus/dpaa: add DPAA cgrid cleanup support
>   drivers: add BMI Tx statistics
>   net/dpaa: optimize FMC MAC type parsing
>   drivers: release DPAA bpid on driver destructor
>   bus/dpaa: orp queue create and burst enqueue
>   net/dpaa: support fmcless rxq number as devargs
>   drivers: optimize DPAA multi-entry buffer pool operations
>   drivers: improve shutdown fq with channel
>   drivers: memory free in destructor
> 
> Prashant Gupta (1):
>   drivers: add process-type guards for secondary process
> 
> Vanshika Shukla (1):
>   net/dpaa: enhance VSP port support
> 
>  doc/guides/nics/dpaa.rst                  |  38 +-
>  drivers/bus/dpaa/base/fman/fman.c         |  23 +-
>  drivers/bus/dpaa/base/fman/fman_hw.c      | 104 ++--
>  drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  49 +-
>  drivers/bus/dpaa/base/qbman/qman.c        | 196 ++++--
>  drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 164 +++--
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
>  drivers/bus/dpaa/include/fman.h           |  13 +-
>  drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |  51 +-
>  drivers/common/dpaax/compat.h             |  22 +-
>  drivers/common/dpaax/dpaax_iova_table.c   |  25 +-
>  drivers/crypto/dpaa_sec/dpaa_sec.c        | 106 +++-
>  drivers/dma/dpaa/dpaa_qdma.c              |  80 ++-
>  drivers/mempool/dpaa/dpaa_mempool.c       |  77 ++-
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 281 +++++++--
>  drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
>  drivers/net/dpaa/dpaa_flow.c              | 211 +++++--
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  73 ++-
>  drivers/net/dpaa/dpaa_oldev.c             | 701 ++++++++++++++++++++++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
>  drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
>  drivers/net/dpaa/meson.build              |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h           |  21 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h     |  92 +++
>  31 files changed, 2136 insertions(+), 448 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
> 

Lots of issues in this patch series. I saw a few but AI sees lots more:

NAK for this revision.

I reviewed patches 1-20 against an applied tree (base c1a46b9) rather than
reading the diffs, and stopped there. There are enough structural problems
that a v9 is a better use of everyone's time than another round of
patch-by-patch comments. Patches 21-25 are not reviewed.

Series-level problems
---------------------

The series is not bisectable. Patch 2 calls qman_shutdown_fq() with a
struct qman_fq * at four sites in dpaa_sec.c, but the signature is int
qman_shutdown_fq(u32 fqid) until patch 7 changes it. Building at patch 2
with -Dwerror=true:

  ../drivers/crypto/dpaa_sec/dpaa_sec.c:3625:40: error: passing argument 1
  of 'qman_shutdown_fq' makes integer from pointer without a cast
  [-Werror=int-conversion]

and the same at lines 3636, 3813 and 3826. Reorder or squash.

Patch 9 reverts most of patch 8: the else-if restructure, the conditional
SDQCR restore, the declaration placement and the log wording all go back to
what they were. Patch 8's commit message advertises "only restore SDQCR
when it was actually changed" and patch 9 removes it. Squash them.

No release notes anywhere. git diff over the series touches only
doc/guides/nics/dpaa.rst. New PMD API, four new devargs, offline port
support, and removal of the DPAA_TX_TAILDROP_THRESHOLD environment variable
all need doc/guides/rel_notes/ entries for 26.11.

Several commit messages describe changes that are not in the patch. Noted
per-patch below. Please make the messages match the diffs.

Dead code that survives all 26 patches: force_ooo (added to struct qman_fq,
read twice, never written), qman_enqueue_multi_orp() (no caller), the
ORP_RWS_WIN_*/ORP_AUTO_ADVANCE_*/ORP_LATE_ARRIVE_* enums,
DPAA_INVALID_BPID, and the six BMI offset macros from patch 11. In
dma/dpaa, s_sg_enable, s_data_validation and s_pci_read are file-scope
statics with no way to set them, so the !s_sg_enable path patch 15 adds is
unreachable.

Patch 2
-------

Error: both failure logs after the RX qman_alloc_fqid_range() print ret
instead of num. ret is 0 there from the last dpaa_sec_init_tx(), so the
message reads "Failed(0)".

Warning: dpaa_sec_uninit() guards the TX release with if (fqid) but
releases the RX range unconditionally.

Info: ret = -ENODEV before goto init_error is dead; that label returns
-EFAULT.

Patch 3
-------

Warning: the message says "Make fman_ccsr_map_fd static as it is only used
within fman.c". It is still non-static at fman.c:19 with extern at
fman.h:485, and cannot be static while fman_hw.c asserts on it. Drop the
claim and the "fix global scope" half of the subject.

Patch 4
-------

Error: of_get_property(dt_node, "fsl,bpid-range", NULL) discards the length
and then reads range[0] and range[1]. Patch 8 of this same series adds
exactly the right check for the sibling property in qman_driver.c (lenp !=
sizeof(rte_be32_t) * 2). Do the same here.

Warning: the per-revision bman_pool_max = 8 for BMAN_REV20 is dropped and
the no-DTS fallback is a flat 64 for every revision. bman_pool_max gates
the bounds checks in bman.c and bman_driver.c. Also start + count is
uint32_t assigned to a u16.

Patch 5
-------

Warning: the secondary-process early return in rte_dpaa_remove() skips
rte_eth_dev_release_port(), leaking the port slot in the secondary. See
virtio_user_ethdev.c for the usual pattern.

Info: message says "for dma/dpaa drivers" but net/dpaa is also modified.

Patch 6
-------

Warning: this is a bug fix, not a refactor. The old code was channel =
dest_wq & 0x7; wq = dest_wq >> 3. Per the qm_fqd dest union in fsl_qman.h
(channel:13, wq:3) the new helpers are correct and the old code had the two
swapped. Needs a Fixes: tag, Cc: stable@dpdk.org, and a message that says
what is being corrected.

Patch 8
-------

Error: the pool-channel branch of qman_shutdown_fq() can never succeed. It
requires p->config->channel == channel, but config->channel is the portal's
dedicated channel id (see qman_priv.h) and dedicated channels start at
QM_CHANNEL_SWPORTAL0 == 0 while pool channels start at 0x21/0x401. Every
pool-channel FQ shutdown now returns -EINVAL. The old
QM_SDQCR_CHANNELS_POOL_CONV(channel) drain was removed with nothing in its
place. This is still broken at the end of the series.

Patch 9
-------

Warning: mostly a revert of patch 8, see above.

Warning: the message claims "better handling of ORL presence"; the diff
does not touch ORL handling.

Patch 10
--------

Warning: the message names qman_find_fq_by_cgid(); the code adds
qman_find_fq_by_cgrid().

Warning: the do { } while (1) has no bound. Termination depends entirely on
the hardware returning ERR_FQID. Bound it by QM_FQID_MASK. Scanning a
24-bit FQID space with two MC commands per iteration is also slow for a
teardown path.

Patch 11
--------

Error: the message says "Extend fman_hw to read Tx BMI registers", but
fman_hw.c is never touched. fman_if_bmi_stats_get_all() still reads only
the eight Rx registers, at the end of the series. The four new tx_* xstats
are therefore filled from Rx counters.

Error: removing fmbm_rstc from struct dpaa_if_rx_bmi_stats breaks
dpaa_dev_xstats_get(). The bound num - (bmi_count - 1) worked only because
bmi_count - 1 equalled the BMI entry count. bmi_count is now 8 with 12 BMI
entries, so the bound is 18 instead of 13 and five xstats read the wrong
array.

Error: FMAN_IF_BMI_TX_STAT_OFFSET_START/END reference fmbm_tfrc and
fmbm_tbdc, which do not exist in struct tx_bmi_regs (fman.h:295). All six
new macros are unused, so this only breaks when someone uses them.

Patch 14
--------

Error: the per-lcore cache loop reads out of bounds. rte_mempool.c:944 sets
local_cache past the header using RTE_MEMPOOL_HEADER_SIZE(mp, 0); when
cache_size == 0 the array is never allocated. The loop reads
cache->flushthresh for all RTE_MAX_LCORE entries regardless, and writes
when the garbage read is non-zero.

Error: the tuning is a no-op. rte_mempool.h:92 documents flushthresh as
"Obsolete; for API/ABI compatibility purposes only" and nothing reads it.

Warning: the s_dpaa_bpid_allocated_flag[] shadow table duplicates state
already in rte_dpaa_bpid_info[] and exists only because the destructor
cannot reach EAL memory. Fix the teardown ordering instead.

Info: struct dpaa_bpid_flag.used should be bool. RTE_PRIORITY_104 works
only by double macro expansion; bus/dpaa and net/dpaa pass the bare number.

Patch 16
--------

Warning: removing the DPAA_TX_TAILDROP_THRESHOLD environment variable is
user-visible and needs a release note.

Error: doc, e.g. ``dpaa:fm1-mac3,recv_err_pkts=1` has unbalanced inline
literal backticks.

Patch 17
--------

Error: handle leak. On the !port_handle path, a failing
fm_port_set_rate_limit() returns without the fm_port_close(handle) that
only runs on the success path.

Warning: rte_pmd_dpaa_port_set_rate_limit() is new public API in an
installed header with no RTE_EXPORT_*_SYMBOL macro, so it will not appear
in the generated map. It is also not marked __rte_experimental and has no
testpmd hook or test. Compare rte_pmd_dpaa_ol_* in dpaa_oldev.c, which does
this correctly.

Warning: fm_open(0) return is not checked before fm_port_open().

Warning: the failure log prints fm_info.fman_handle rather than the handle
that failed to open.

Warning: uint32_t ret returned as -ret.

Info: the IOW -> _IOW change is a real fix to a previously unused macro,
but should be called out in the message.

Patch 18
--------

Error: eq->orp = orp->fqid is missing the byte swap. The single-frame
qman_enqueue_orp() a few hundred lines below does eq->orp =
cpu_to_be32(orp->fqid), and every other field in the new function is
swapped.

Error: ~(flags[i] & (QMAN_ENQUEUE_FLAG_HOLE | QMAN_ENQUEUE_FLAG_NESN)) is
bitwise complement and is non-zero for every input, so
QM_EQCR_VERB_CMD_ENQUEUE is always set and holes are enqueued as real
frames. Should be logical !.

Warning: force_ooo has no writer anywhere, so both new bypass paths are
dead. Should also be bool.

Info: QM_EQCR_VERB_COLOUR_MASK and QM_EQCR_VERB_INTERRUPT are propagated
from flags in the single-frame version but dropped here.

Patch 20
--------

Error: doc, no blank line before the drv_sh_if_name bullet, which breaks
the list.

Warning: the doc comment on dpaa_get_devargs_str() describes returning a
pointer valid until the kvargs list is freed; the function copies into a
caller-supplied buffer.
