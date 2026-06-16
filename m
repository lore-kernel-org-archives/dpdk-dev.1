Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385ACD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 208AB40289;
	Tue, 16 Jun 2026 14:16:31 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 0398F4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:16:29 +0200 (CEST)
X-QQ-mid: Yeas6t1781612182t637t38093
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [183.157.22.210])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 6065441854880048883
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260527130222.24348-1-zaiyuwang@trustnetic.com>
 <20260527082228.68e25473@phoenix.local>
In-Reply-To: <20260527082228.68e25473@phoenix.local>
Subject: RE: [PATCH v5 00/21] Wangxun Fixes
Date: Tue, 16 Jun 2026 20:16:21 +0800
Message-ID: <004d01dcfd89$f161af10$d4250d30$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwJVTsfNAiuGKVG1cNeiMA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mv+tyGIfil93EIl0Ygo81vMK5YPLfX99x7yJVVISN5BiXfAM8pcTBgTc
 P5EZ10NQ9nq4B+luoXYz7ZUO1cx/S0GmMIJU/6l2tU2Fl3vLPWKjcIgdsqNKLgM2Z2O536P
 0V2JGO4ZYmRAI4AAiotq0bcRnc2bEz8b3T+Kt801SYttnBF+7NYPUTJKh3R50NivlKFL7PH
 qFjp5KQqECRwoeHudhdUUB5Z82KXzo8p7JLxiUD1Ib2o3wgLGaAYuC7ox8cB6RIz47yZNvf
 THXx9JUncZqkSoGnVUXdpZTdiLc2UZpMnXGFi0lYL0mgxTOM6WZeIT5b8S7+cvFWYrewqNl
 7tDVxQ3p1Oyj3kAUHlrlZnM3pLgP+KH3Ed8GyQ644ntaW5kXxFzVS5LUBUDSxLq5a5cCgKj
 4TjwfmdMaYfgdHJmEnlI3TsFG5ZgiS0SZjabDwulzYLIuNre57em10K8EyOTrWllmkA+0SB
 iJ5fbw7gvU4pwVYYXNmWCcq2mkUyX+get6ofxCRguKpcrL+JUJ4HZjxwkTTkarJljAzx5zL
 QScIPZru39cggnLy1mhDvRrJmFP77e05oeThAC8zqYqrl6KWF85lIxUODpCeTOg7YqQxIyl
 hfjBJRE9GASeNUOpoG/YymbJcG1690yQWcsDkhjb6EbW+w0TK0ro/ZvufLKjk+OMWU9bBpi
 eY09nmQJQBiiTBAR0BA4hGV+OEScroUR7eN4wnhmZkrKh+rLX5U+0vjoranAGONW1sRXlPo
 UB9mZaRB1RqMG964eo7egov4H7GJAZ54XNBWfBGzXAgylBDP/MBmWtJmPPO6UQqgl8xZ2+e
 B8ptiwJxXebNWQexoDHah5pd/6ZbMcsyQDsq+xPnYmV8nQPJKOKE7iyOcF87jpmz4rOQFx9
 wU5h1nHNNyV85V0c8NwyLOtEK76xymItHbO/86E0Q5L154hwtDqQM6pXG97AT52gXw7AJW/
 eQCaNLI4wro8savYpgaPM3S7eBy4KcURfXbyRnaKvyMBoo+FtV6j9Je/UVXCgTRn28jcNYo
 B0VZevii9Wm+roz8TBuQ6vnh93GNLkbLe0G0hi9A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, May 27, 2026 11:22 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang =
<zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v5 00/21] Wangxun Fixes
>=20
> On Wed, 27 May 2026 21:02:00 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
>=20
> > This series fixes several issues found on Wangxun Emerald, Sapphire
> > and Amber-lite NICs, with a focus on link-related problems.
> > ---
> > v5:
> > - Fixed issues identified by AI review
> > ---
> > v4:
> > - Fixed issues identified by devtools scripts
> > ---
> > v3:
> > - Addressed Stephen's comments
> > ---
> > v2:
> > - Fixed compilation error and code style issues
> > ---
> >
> > Zaiyu Wang (21):
> >   net/txgbe: remove duplicate xstats counters
> >   net/ngbe: remove duplicate xstats counters
> >   net/ngbe: add missing CDR config for YT PHY
> >   net/ngbe: fix VF promiscuous and allmulticast
> >   net/txgbe: fix inaccuracy in Tx rate limiting
> >   net/txgbe: fix link status check condition
> >   net/txgbe: fix Tx desc free logic
> >   net/txgbe: fix link flow control registers for Amber-Lite
> >   net/txgbe: fix link flow control config for Sapphire
> >   net/txgbe: fix a mass of unknown interrupts
> >   net/txgbe: fix traffic class priority configuration
> >   net/txgbe: fix link stability for 25G NIC
> >   net/txgbe: fix link stability for 40G NIC
> >   net/txgbe: fix link stability for Amber-Lite backplane mode
> >   net/txgbe: fix FEC mode configuration on 25G NIC
> >   net/txgbe: fix SFP module identification
> >   net/txgbe: fix get module info operation
> >   net/txgbe: fix get EEPROM operation
> >   net/txgbe: fix to reset Tx write-back pointer
> >   net/txgbe: fix to enable Tx desc check
> >   net/txgbe: fix temperature track for AML NIC
> >
> >  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
> >  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
> >  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
> >  drivers/net/txgbe/base/meson.build        |    2 +
> >  drivers/net/txgbe/base/txgbe.h            |    2 +
> >  drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
> >  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
> >  drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
> >  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
> >  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
> >  drivers/net/txgbe/base/txgbe_e56.c        | 3773 =
+++++++++++++++++++++
> >  drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
> >  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
> >  drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
> >  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
> >  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
> >  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
> >  drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
> >  drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
> >  drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
> >  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
> >  drivers/net/txgbe/txgbe_ethdev.c          |  458 ++-
> >  drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
> >  drivers/net/txgbe/txgbe_rxtx.c            |  107 +-
> >  drivers/net/txgbe/txgbe_rxtx.h            |   36 +
> >  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   16 +-
> >  26 files changed, 9445 insertions(+), 445 deletions(-)  create mode
> > 100644 drivers/net/txgbe/base/txgbe_e56.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> >
>=20
> More AI review feedback summary:
>=20
>=20
> 18/21 =E2=80=94 get EEPROM (Error): page is declared once before the =
for loop and never reset, so after
> crossing the 256-byte boundary every subsequent iteration walks one =
page further into the
> module than it should. Plus two related issues: data[0x2] reads the =
output buffer not the module
> byte, and the skip branch leaves stale databyte carrying over from the =
previous iteration.
>=20
> 20/21 =E2=80=94 Tx desc check (Error): #ifdef RTE_LIBRTE_SECURITY uses =
the
> pre-2020 macro name; the modern name is RTE_LIB_SECURITY (and the =
surrounding code in the
> same file uses it correctly). The IPsec guard is therefore always =
compiled out and the wr32m runs
> for every queue, including IPsec ones.
>=20
> 16/21 & 17/21 =E2=80=94 whitespace: \t if (tab-then-space) on two =
lines. Checkpatch will catch it, but
> worth a pass.
>=20
> 17/21 =E2=80=94 TXGBE_SFF_DDM_IMPLEMENTED: value 0x40 is correct as a =
bit-6 mask of byte 0x5C, but
> it is defined next to register-offset macros which makes it read as an =
offset.
>=20
> 14/21 =E2=80=94 kr_read_poll macro: uses usleep() directly; everything =
else in the txgbe base layer uses
> usec_delay().
>=20
> 7/21 =E2=80=94 type pun: the atomic load casts a volatile uint32_t * =
to volatile uint16_t *. Works on all
> DPDK platforms but is strict-aliasing-iffy; a u32 load with a u16 cast =
at the use site would be
> cleaner.
>=20
> Longer full review:
>=20
> Review of [PATCH v5 00/21] net/{txgbe,ngbe} fixes from Zaiyu Wang
>=20
> This revision addresses the substantive issues raised on v4:
>=20
>   - 07/21: Tx desc free now uses a documented helper
>     txgbe_tx_headwb_desc_done() that correctly handles the =
head=3D=3Dnext
>     boundary, and switches the headwb_mem read from a plain volatile
>     access to rte_atomic_load_explicit(... acquire).
>   - 08/21: AML xon/xoff stats no longer use plain assignment.  The
>     counter now goes through the new =
TXGBE_UPDATE_COUNTER_32BIT_GENERIC
>     macro with offset tracking, and txgbe_clear_hw_cntrs() =
write-clears
>     the AML registers and zeroes hw->last_stats on reset.
>   - 11/21: traffic class priority is consistent across all three
>     callers.  TXGBE_RPUP2TC_UP_SHIFT is bumped to 4, =
TXGBE_DCBUP2TC_MAP
>     is updated to match, txgbe_vmdq_dcb_configure() uses the macros
>     instead of a hardcoded *3 shift, and the unused TXGBE_DCBUP2TC_DEC
>     is removed.  The bonus fix of redirecting
>     txgbe_dcb_config_tx_data_arbiter_raptor() to TXGBE_PBTXUP2TC =
instead
>     of TXGBE_PBRXUP2TC is welcome.
>   - 12/21: txgbe_setup_phy_link_aml() now sets link_up =3D false =
before
>     'goto out' on TXGBE_ERR_TIMEOUT, so the out: block correctly =
routes
>     to *need_reset =3D true.  The generic 'compare' qsort helper has =
been
>     renamed to txgbe_e56_int_cmp().
>=20
> Remaining findings on v5 below.
>=20
> ----------------------------------------------------------------
>=20
> Patch 18/21 (net/txgbe: fix get EEPROM operation)
>=20
> Error: page accumulation across loop iterations in
> txgbe_get_module_eeprom() will return wrong bytes for any QSFP read =
that crosses the 256-byte
> page boundary.
>=20
>   +	uint8_t page =3D 0;
>   ...
>   +	for (i =3D info->offset; i < info->offset + info->length; i++) {
>   +		if (is_sfp) {
>   ...
>   +		} else {
>   +			offset =3D i;
>   +			while (offset >=3D RTE_ETH_MODULE_SFF_8436_LEN) {
>   +				offset -=3D RTE_ETH_MODULE_SFF_8436_LEN / 2;
>   +				page++;
>   +			}
>   +			if (page =3D=3D 0 || !(data[0x2] & 0x4)) {
>   +				status =3D hw->phy.read_i2c_sff8636(hw, page, offset,
>   +					       &databyte);
>=20
> 'page' is declared once before the for loop and never reset, but the =
while loop only increments it.
> For i =3D 256 the math is correct
> (page=3D0 entering, page=3D1 leaving, offset=3D128).  For i =3D 257 =
the loop enters with page=3D1 already
> set from the previous iteration and ends with page=3D2, offset=3D129 - =
it should still be page=3D1.
> Every subsequent iteration adds one more page, so the function reads =
bytes from ever-higher
> pages instead of staying on page 1, 2, 3, ...
>=20
> Reset page (and rebuild offset) at each iteration:
>=20
> 	uint16_t addr;
> 	uint8_t  page;
>=20
> 	for (i =3D info->offset; i < info->offset + info->length; i++) {
> 		...
> 		} else {
> 			page =3D 0;
> 			addr =3D i;
> 			while (addr >=3D RTE_ETH_MODULE_SFF_8436_LEN) {
> 				addr -=3D RTE_ETH_MODULE_SFF_8436_LEN / 2;
> 				page++;
> 			}
> 			...
> 		}
> 	}
>=20
> Two related concerns in the same block:
>=20
>   - The flat-memory check '!(data[0x2] & 0x4)' inspects byte 2 of the
>     caller's output buffer rather than module byte 2.  If info->offset
>     > 2 the byte was never read, so the test reads the value left by
>     memset (zero) and always evaluates to true.  Read module byte 2
>     explicitly before the loop and stash it in a local.
>=20
>   - When the skip branch is taken (paged read on flat memory), the
>     loop still does 'data[i - info->offset] =3D databyte', so the byte
>     written is whatever databyte held from the previous iteration.
>     Set databyte to 0 (or 0xff) before each iteration, or set the
>     output byte directly inside the skip branch.
>=20
> Patch 20/21 (net/txgbe: fix to enable Tx desc check)
>=20
> Error: the new IPsec guard uses the wrong macro name and is always =
compiled out.
>=20
>   +#ifdef RTE_LIBRTE_SECURITY
>   +		if (!txq->using_ipsec)
>   +#endif
>   +			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
>   +			      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % =
32));
>=20
> The DPDK build macro is RTE_LIB_SECURITY; RTE_LIBRTE_SECURITY is the
> pre-2020 name and is no longer defined anywhere in the tree (the rest =
of this same driver uses
> RTE_LIB_SECURITY in the surrounding code, including the deleted block =
this patch replaces).
> Result: the 'if (!txq->using_ipsec)' line is never preprocessed in, =
the wr32m runs for every queue
> unconditionally, and IPsec-enabled queues get the desc-check bit set =
even though the existing
> intent was to skip them.
>=20
> Replace with RTE_LIB_SECURITY.  Matches the existing pattern elsewhere =
in txgbe_rxtx.c
> (txgbe_rxtx.c:64, :444, :882, ...).
>=20
> Patch 16/21 (net/txgbe: fix SFP module identification)
>=20
> Warning: stray space in indentation of txgbe_read_i2c_sff8636() body.
>=20
>   +	s32 err =3D hw->phy.write_i2c_byte(hw, TXGBE_SFF_QSFP_PAGE_SELECT,
>   +					TXGBE_I2C_EEPROM_DEV_ADDR,
>   +					page);
>   +	 if (err !=3D 0)
>   +		return err;
>=20
> The 'if' line is indented with tab+space instead of a single tab.
> checkpatch will flag this.
>=20
> Info: this patch refactors away phy.read_i2c_byte_unlocked and =
phy.write_i2c_byte_unlocked and
> merges them into the existing phy.read_i2c_byte / phy.write_i2c_byte =
slots, which now no longer
> acquire the swfw semaphore.  Patches 17 and 18 add explicit =
acquire/release around their own
> callers, which is correct, but it is worth double-checking that no =
other in-tree caller of
> phy.read_i2c_eeprom / phy.read_i2c_sff8472 / phy.read_i2c_byte runs =
without holding
> TXGBE_MNGSEM_SWPHY after this patch.  The lock change and the callsite =
updates would
> arguably read better squashed together or at least kept adjacent in =
the series.
>=20
> Patch 17/21 (net/txgbe: fix get module info operation)
>=20
> Warning: stray space in indentation - same checkpatch issue as above.
>=20
>   +	if (hw->mac.type =3D=3D txgbe_mac_aml) {
>   +		value =3D rd32(hw, TXGBE_GPIOEXT);
>   +		 if (value & TXGBE_SFP1_MOD_ABS_LS) {
>=20
> 'if' is tab+space indented; should be two tabs.
>=20
> Info: TXGBE_SFF_DDM_IMPLEMENTED is added next to the SFP register =
offset definitions, but is
> then used as a bit mask of byte 0x5C:
>=20
>   #define TXGBE_SFF_DDM_IMPLEMENTED    0x40
>   #define TXGBE_SFF_SFF_8472_SWAP      0x5C
>   ...
>   if (sff8472_rev =3D=3D TXGBE_SFF_SFF_8472_UNSUP || page_swap ||
>       !(addr_mode & TXGBE_SFF_DDM_IMPLEMENTED)) {
>=20
> The value 0x40 is correct as bit 6 of the diagnostic-monitoring-type =
byte at offset 0x5C, but placing
> it alongside register offsets makes the macro look like an offset.  =
Consider moving it into a
> bit-mask group or renaming the offset/mask pair to make the intent =
obvious (e.g. _ADDR vs
> _MASK suffix).
>=20
> Patch 14/21 (net/txgbe: fix link stability for Amber-Lite)
>=20
> Warning: the new kr_read_poll() macro in txgbe_phy.h uses usleep() =
directly, while the rest of the
> txgbe base layer uses the
> usec_delay() abstraction (which expands to rte_delay_us_block() on =
DPDK).  Mixing the two is
> inconsistent and pulls in a POSIX dependency in a base/ file:
>=20
>   +#define kr_read_poll(op, val, cond, sleep_us, \
>   +		     times, args...) \
>   +({ \
>   ...
>   +		usleep(__sleep_us);\
>   ...
>   +})
>=20
> Switch to usec_delay() to match txgbe_eeprom.c, txgbe_hw.c, and the =
rest of the same file.
>=20
> Patch 7/21 (net/txgbe: fix Tx desc free logic)
>=20
> Info: txq->headwb_mem is declared 'volatile uint32_t *', but the new =
atomic read reads it as
> 'volatile uint16_t *':
>=20
>   +	const uint16_t head =3D rte_atomic_load_explicit((volatile =
uint16_t *)txq->headwb_mem,
>   +						       rte_memory_order_acquire);
>=20
> This works on every architecture DPDK supports (lower 16 bits of an =
aligned 32-bit object are
> accessible as a 16-bit atomic and head fits in 16 bits), but it is a =
type pun on a hardware-written
> object and a strict-aliasing violation in pure C.  A 32-bit atomic =
load with an explicit cast at use site
> would be cleaner:
>=20
> 	uint32_t h =3D rte_atomic_load_explicit(txq->headwb_mem,
> 					      rte_memory_order_acquire);
> 	const uint16_t head =3D (uint16_t)h;
>=20
> Stephen Hemminger <stephen@networkplumber.org>
>=20
>=20
Thanks.
All the comments above have been addressed in v6.

