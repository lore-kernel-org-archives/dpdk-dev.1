Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B11CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 15:22:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC9414027D;
	Wed, 27 May 2026 17:22:33 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id F01844026C
 for <dev@dpdk.org>; Wed, 27 May 2026 17:22:32 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304c5f56072so217447eec.0
 for <dev@dpdk.org>; Wed, 27 May 2026 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779895352;
 x=1780500152; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dmg4Cblt2Sff4HjFw4KTaW4DXeyMJ5RKwOWdUizQ9Y=;
 b=tIyj8LeO/BR0TFNQ7b6KsLU135o/Wcj/hU9t9++WJuvJxWlcFMnsMiUcNw2IBCEGDF
 z8CHnDa1i4ZF8ljVGs6E3PWzjch51uNqJM6Wq485PY+xVTptaOvg4jizoOYzTeN0ExBR
 dE8hMaBFNE18FRYRz8loYqjKTV3EADnp/y0VaUD4Hy63zqlvUZCYOwv6auDkndwokthm
 i3spHlrmfCMlJCQ939FM6be5+Hr2jAmYf2f6depQuXBFGmbbPl6EGBDs4e9RNCJi9Huw
 6a2Rnh0u54LG1DY+7XeLNgBKuAxxyiKjB+giyNNfCMmADIISXksbum+CEO7Y7BbgyYUe
 wsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779895352; x=1780500152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8dmg4Cblt2Sff4HjFw4KTaW4DXeyMJ5RKwOWdUizQ9Y=;
 b=lTdPvQTG+IiEICWbdOcFVMx3REDBdjaKHV/8zszk/zb3arCiY8OMZBN4OkWALjtCzJ
 TjntOI8K940YzO4tsxFteDGPrspa+gvKqadgMkQ36IQLKr4E/2+GvrWuDDD7zQrNKDaD
 9WgnpwiqnPKme2MDLkUITu7oyMMSvleIvykJDzNOTHPV10oEUnGlVUj2dq64DQJmYLgG
 XCqjHO9OSfWojfG2UJD7ICqM1UMuN1Ca3wBHe0OF7k9d2IBedM3sf24ckUC5iGTm84bv
 e9x3B/AXL3rfwcTqFfNKw9SIKjDXNIasepGxCUpHTa4I13YoJZs0WZ7SuGmkrGNOTSX0
 Ov+Q==
X-Gm-Message-State: AOJu0YwEdYshj7q7hUYvOR0LfWVl/FmSyLKOnl2ljjC+dKdHkGqgDPY9
 uv+t1wqhsNbMB55gUT+2cGaaiB3HTQBqmgTf8gUkL22kKq8N3UFd6paUrD6fBv0nCr5065zD48g
 JHlQw
X-Gm-Gg: Acq92OHoZfTv91pn95uekHre9kbCyuhwre9r86lhgN8as4d3ifm11hDpDCn1vsFePWL
 t2ckKTc7vTxGv7bEYMlFGAB1IXejS3mzFjvPBzjigN9PTY2cDfmt/QU3fK81r8k/CofK0Q90+Gz
 WRGVhAKE2yMftDcKR0JdHyytNqe36DSBqsOEM6qTrr74T5j4Y0c7vM8Knw4ou+bEI5LXoYtbDBd
 /qiCY49aNlgDeRg2Y5S7vNa/i4VbmmBJKNAcuJHB0TTHmWDEAG4BypbWJScvEsA6AkmkWcMaYJg
 7ododKLZCAaHQC6Tl+DhQgFJFLVkoS30w+oQuzehaqfCqOwuxqtMiKgTEwgDb78rPPnz8dpP9nF
 GG1/e6J8+E21eZG/ClMQI+VLLyQQrbghCQO1jhsUIbUDohBQkJyN1cgngmcBKiJq242ELvz4Hfp
 Ocm1thSWI4ifNC56eH6Am9YQMcQo2Oi04AGzKMdSmz8DUuXsEYxzzi7+WcdJ1qks3BrNrPKHsCo
 /aIbhpI/2aOuw==
X-Received: by 2002:a05:7301:2e89:b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-30449fbb314mr9190606eec.0.1779895351765; 
 Wed, 27 May 2026 08:22:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304cc3451dasm584231eec.16.2026.05.27.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:22:31 -0700 (PDT)
Date: Wed, 27 May 2026 08:22:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 00/21] Wangxun Fixes
Message-ID: <20260527082228.68e25473@phoenix.local>
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
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

On Wed, 27 May 2026 21:02:00 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
> ---
> v5:
> - Fixed issues identified by AI review
> ---
> v4:
> - Fixed issues identified by devtools scripts
> ---
> v3:
> - Addressed Stephen's comments
> ---
> v2:
> - Fixed compilation error and code style issues
> ---
>=20
> Zaiyu Wang (21):
>   net/txgbe: remove duplicate xstats counters
>   net/ngbe: remove duplicate xstats counters
>   net/ngbe: add missing CDR config for YT PHY
>   net/ngbe: fix VF promiscuous and allmulticast
>   net/txgbe: fix inaccuracy in Tx rate limiting
>   net/txgbe: fix link status check condition
>   net/txgbe: fix Tx desc free logic
>   net/txgbe: fix link flow control registers for Amber-Lite
>   net/txgbe: fix link flow control config for Sapphire
>   net/txgbe: fix a mass of unknown interrupts
>   net/txgbe: fix traffic class priority configuration
>   net/txgbe: fix link stability for 25G NIC
>   net/txgbe: fix link stability for 40G NIC
>   net/txgbe: fix link stability for Amber-Lite backplane mode
>   net/txgbe: fix FEC mode configuration on 25G NIC
>   net/txgbe: fix SFP module identification
>   net/txgbe: fix get module info operation
>   net/txgbe: fix get EEPROM operation
>   net/txgbe: fix to reset Tx write-back pointer
>   net/txgbe: fix to enable Tx desc check
>   net/txgbe: fix temperature track for AML NIC
>=20
>  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
>  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
>  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
>  drivers/net/txgbe/base/meson.build        |    2 +
>  drivers/net/txgbe/base/txgbe.h            |    2 +
>  drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
>  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
>  drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
>  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
>  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
>  drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
>  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
>  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
>  drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
>  drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
>  drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
>  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
>  drivers/net/txgbe/txgbe_ethdev.c          |  458 ++-
>  drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
>  drivers/net/txgbe/txgbe_rxtx.c            |  107 +-
>  drivers/net/txgbe/txgbe_rxtx.h            |   36 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   16 +-
>  26 files changed, 9445 insertions(+), 445 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
>

More AI review feedback summary:


18/21 =E2=80=94 get EEPROM (Error): page is declared once before the for lo=
op
and never reset, so after crossing the 256-byte boundary every
subsequent iteration walks one page further into the module than it
should. Plus two related issues: data[0x2] reads the output buffer not
the module byte, and the skip branch leaves stale databyte carrying
over from the previous iteration.

20/21 =E2=80=94 Tx desc check (Error): #ifdef RTE_LIBRTE_SECURITY uses the
pre-2020 macro name; the modern name is RTE_LIB_SECURITY (and the
surrounding code in the same file uses it correctly). The IPsec guard
is therefore always compiled out and the wr32m runs for every queue,
including IPsec ones.

16/21 & 17/21 =E2=80=94 whitespace: \t if (tab-then-space) on two lines. Ch=
eckpatch will catch it, but worth a pass.

17/21 =E2=80=94 TXGBE_SFF_DDM_IMPLEMENTED: value 0x40 is correct as a bit-6
mask of byte 0x5C, but it is defined next to register-offset macros
which makes it read as an offset.

14/21 =E2=80=94 kr_read_poll macro: uses usleep() directly; everything else=
 in the txgbe base layer uses usec_delay().

7/21 =E2=80=94 type pun: the atomic load casts a volatile uint32_t * to
volatile uint16_t *. Works on all DPDK platforms but is
strict-aliasing-iffy; a u32 load with a u16 cast at the use site would
be cleaner.

Longer full review:

Review of [PATCH v5 00/21] net/{txgbe,ngbe} fixes from Zaiyu Wang

This revision addresses the substantive issues raised on v4:

  - 07/21: Tx desc free now uses a documented helper
    txgbe_tx_headwb_desc_done() that correctly handles the head=3D=3Dnext
    boundary, and switches the headwb_mem read from a plain volatile
    access to rte_atomic_load_explicit(... acquire).
  - 08/21: AML xon/xoff stats no longer use plain assignment.  The
    counter now goes through the new TXGBE_UPDATE_COUNTER_32BIT_GENERIC
    macro with offset tracking, and txgbe_clear_hw_cntrs() write-clears
    the AML registers and zeroes hw->last_stats on reset.
  - 11/21: traffic class priority is consistent across all three
    callers.  TXGBE_RPUP2TC_UP_SHIFT is bumped to 4, TXGBE_DCBUP2TC_MAP
    is updated to match, txgbe_vmdq_dcb_configure() uses the macros
    instead of a hardcoded *3 shift, and the unused TXGBE_DCBUP2TC_DEC
    is removed.  The bonus fix of redirecting
    txgbe_dcb_config_tx_data_arbiter_raptor() to TXGBE_PBTXUP2TC instead
    of TXGBE_PBRXUP2TC is welcome.
  - 12/21: txgbe_setup_phy_link_aml() now sets link_up =3D false before
    'goto out' on TXGBE_ERR_TIMEOUT, so the out: block correctly routes
    to *need_reset =3D true.  The generic 'compare' qsort helper has been
    renamed to txgbe_e56_int_cmp().

Remaining findings on v5 below.

----------------------------------------------------------------

Patch 18/21 (net/txgbe: fix get EEPROM operation)

Error: page accumulation across loop iterations in
txgbe_get_module_eeprom() will return wrong bytes for any QSFP read
that crosses the 256-byte page boundary.

  +	uint8_t page =3D 0;
  ...
  +	for (i =3D info->offset; i < info->offset + info->length; i++) {
  +		if (is_sfp) {
  ...
  +		} else {
  +			offset =3D i;
  +			while (offset >=3D RTE_ETH_MODULE_SFF_8436_LEN) {
  +				offset -=3D RTE_ETH_MODULE_SFF_8436_LEN / 2;
  +				page++;
  +			}
  +			if (page =3D=3D 0 || !(data[0x2] & 0x4)) {
  +				status =3D hw->phy.read_i2c_sff8636(hw, page, offset,
  +					       &databyte);

'page' is declared once before the for loop and never reset, but the
while loop only increments it.  For i =3D 256 the math is correct
(page=3D0 entering, page=3D1 leaving, offset=3D128).  For i =3D 257 the loop
enters with page=3D1 already set from the previous iteration and ends
with page=3D2, offset=3D129 - it should still be page=3D1.  Every subsequent
iteration adds one more page, so the function reads bytes from
ever-higher pages instead of staying on page 1, 2, 3, ...

Reset page (and rebuild offset) at each iteration:

	uint16_t addr;
	uint8_t  page;

	for (i =3D info->offset; i < info->offset + info->length; i++) {
		...
		} else {
			page =3D 0;
			addr =3D i;
			while (addr >=3D RTE_ETH_MODULE_SFF_8436_LEN) {
				addr -=3D RTE_ETH_MODULE_SFF_8436_LEN / 2;
				page++;
			}
			...
		}
	}

Two related concerns in the same block:

  - The flat-memory check '!(data[0x2] & 0x4)' inspects byte 2 of the
    caller's output buffer rather than module byte 2.  If info->offset
    > 2 the byte was never read, so the test reads the value left by
    memset (zero) and always evaluates to true.  Read module byte 2
    explicitly before the loop and stash it in a local.

  - When the skip branch is taken (paged read on flat memory), the
    loop still does 'data[i - info->offset] =3D databyte', so the byte
    written is whatever databyte held from the previous iteration.
    Set databyte to 0 (or 0xff) before each iteration, or set the
    output byte directly inside the skip branch.

Patch 20/21 (net/txgbe: fix to enable Tx desc check)

Error: the new IPsec guard uses the wrong macro name and is always
compiled out.

  +#ifdef RTE_LIBRTE_SECURITY
  +		if (!txq->using_ipsec)
  +#endif
  +			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
  +			      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % 32));

The DPDK build macro is RTE_LIB_SECURITY; RTE_LIBRTE_SECURITY is the
pre-2020 name and is no longer defined anywhere in the tree (the rest
of this same driver uses RTE_LIB_SECURITY in the surrounding code,
including the deleted block this patch replaces).  Result: the
'if (!txq->using_ipsec)' line is never preprocessed in, the wr32m
runs for every queue unconditionally, and IPsec-enabled queues get
the desc-check bit set even though the existing intent was to skip
them.

Replace with RTE_LIB_SECURITY.  Matches the existing pattern
elsewhere in txgbe_rxtx.c (txgbe_rxtx.c:64, :444, :882, ...).

Patch 16/21 (net/txgbe: fix SFP module identification)

Warning: stray space in indentation of txgbe_read_i2c_sff8636() body.

  +	s32 err =3D hw->phy.write_i2c_byte(hw, TXGBE_SFF_QSFP_PAGE_SELECT,
  +					TXGBE_I2C_EEPROM_DEV_ADDR,
  +					page);
  +	 if (err !=3D 0)
  +		return err;

The 'if' line is indented with tab+space instead of a single tab.
checkpatch will flag this.

Info: this patch refactors away phy.read_i2c_byte_unlocked and
phy.write_i2c_byte_unlocked and merges them into the existing
phy.read_i2c_byte / phy.write_i2c_byte slots, which now no longer
acquire the swfw semaphore.  Patches 17 and 18 add explicit
acquire/release around their own callers, which is correct, but it is
worth double-checking that no other in-tree caller of
phy.read_i2c_eeprom / phy.read_i2c_sff8472 / phy.read_i2c_byte runs
without holding TXGBE_MNGSEM_SWPHY after this patch.  The lock change
and the callsite updates would arguably read better squashed together
or at least kept adjacent in the series.

Patch 17/21 (net/txgbe: fix get module info operation)

Warning: stray space in indentation - same checkpatch issue as above.

  +	if (hw->mac.type =3D=3D txgbe_mac_aml) {
  +		value =3D rd32(hw, TXGBE_GPIOEXT);
  +		 if (value & TXGBE_SFP1_MOD_ABS_LS) {

'if' is tab+space indented; should be two tabs.

Info: TXGBE_SFF_DDM_IMPLEMENTED is added next to the SFP register
offset definitions, but is then used as a bit mask of byte 0x5C:

  #define TXGBE_SFF_DDM_IMPLEMENTED    0x40
  #define TXGBE_SFF_SFF_8472_SWAP      0x5C
  ...
  if (sff8472_rev =3D=3D TXGBE_SFF_SFF_8472_UNSUP || page_swap ||
      !(addr_mode & TXGBE_SFF_DDM_IMPLEMENTED)) {

The value 0x40 is correct as bit 6 of the diagnostic-monitoring-type
byte at offset 0x5C, but placing it alongside register offsets makes
the macro look like an offset.  Consider moving it into a bit-mask
group or renaming the offset/mask pair to make the intent obvious
(e.g. _ADDR vs _MASK suffix).

Patch 14/21 (net/txgbe: fix link stability for Amber-Lite)

Warning: the new kr_read_poll() macro in txgbe_phy.h uses usleep()
directly, while the rest of the txgbe base layer uses the
usec_delay() abstraction (which expands to rte_delay_us_block() on
DPDK).  Mixing the two is inconsistent and pulls in a POSIX dependency
in a base/ file:

  +#define kr_read_poll(op, val, cond, sleep_us, \
  +		     times, args...) \
  +({ \
  ...
  +		usleep(__sleep_us);\
  ...
  +})

Switch to usec_delay() to match txgbe_eeprom.c, txgbe_hw.c, and the
rest of the same file.

Patch 7/21 (net/txgbe: fix Tx desc free logic)

Info: txq->headwb_mem is declared 'volatile uint32_t *', but the new
atomic read reads it as 'volatile uint16_t *':

  +	const uint16_t head =3D rte_atomic_load_explicit((volatile uint16_t *)t=
xq->headwb_mem,
  +						       rte_memory_order_acquire);

This works on every architecture DPDK supports (lower 16 bits of an
aligned 32-bit object are accessible as a 16-bit atomic and head fits
in 16 bits), but it is a type pun on a hardware-written object and a
strict-aliasing violation in pure C.  A 32-bit atomic load with an
explicit cast at use site would be cleaner:

	uint32_t h =3D rte_atomic_load_explicit(txq->headwb_mem,
					      rte_memory_order_acquire);
	const uint16_t head =3D (uint16_t)h;

Stephen Hemminger <stephen@networkplumber.org>

